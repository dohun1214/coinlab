package com.coinlab.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.coinlab.dto.User;
import com.coinlab.util.DBUtil;

@WebServlet("/deleteAccount.do")
public class DeleteAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("loginUser") == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		User user = (User) session.getAttribute("loginUser");
		int userId = user.getUserId();

		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);

			// 1. 게시글 댓글 삭제
			String deleteCommentsSql = "DELETE FROM comments WHERE user_id = ?";
			try (PreparedStatement pstmt = conn.prepareStatement(deleteCommentsSql)) {
				pstmt.setInt(1, userId);
				pstmt.executeUpdate();
			}

			// 2. 게시글 좋아요 삭제
			String deleteBoardLikesSql = "DELETE FROM board_likes WHERE user_id = ?";
			try (PreparedStatement pstmt = conn.prepareStatement(deleteBoardLikesSql)) {
				pstmt.setInt(1, userId);
				pstmt.executeUpdate();
			}

			// 3. 게시글 삭제
			String deleteBoardSql = "DELETE FROM board WHERE user_id = ?";
			try (PreparedStatement pstmt = conn.prepareStatement(deleteBoardSql)) {
				pstmt.setInt(1, userId);
				pstmt.executeUpdate();
			}

			// 4. 거래 내역 삭제
			String deleteTransactionsSql = "DELETE FROM transactions WHERE user_id = ?";
			try (PreparedStatement pstmt = conn.prepareStatement(deleteTransactionsSql)) {
				pstmt.setInt(1, userId);
				pstmt.executeUpdate();
			}

			// 5. 보유 코인 삭제
			String deleteHoldingsSql = "DELETE FROM holdings WHERE user_id = ?";
			try (PreparedStatement pstmt = conn.prepareStatement(deleteHoldingsSql)) {
				pstmt.setInt(1, userId);
				pstmt.executeUpdate();
			}

			// 6. 자산 정보 삭제
			String deleteAssetsSql = "DELETE FROM assets WHERE user_id = ?";
			try (PreparedStatement pstmt = conn.prepareStatement(deleteAssetsSql)) {
				pstmt.setInt(1, userId);
				pstmt.executeUpdate();
			}

			// 7. 사용자 삭제
			String deleteUserSql = "DELETE FROM users WHERE user_id = ?";
			try (PreparedStatement pstmt = conn.prepareStatement(deleteUserSql)) {
				pstmt.setInt(1, userId);
				pstmt.executeUpdate();
			}

			conn.commit();

			// 세션 무효화
			session.invalidate();

			// 로그인 페이지로 리다이렉트
			response.sendRedirect(request.getContextPath() + "/login.jsp?msg=accountDeleted");
			return;

		} catch (SQLException e) {
			e.printStackTrace();
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			session.setAttribute("errorMsg", "회원 탈퇴 중 오류가 발생했습니다.");
			response.sendRedirect(request.getContextPath() + "/mypage.do");
		} finally {
			if (conn != null) {
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
