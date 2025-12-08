package com.coinlab.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.coinlab.dao.BoardDAO;
import com.coinlab.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/board/comment/update.do")
public class BoardCommentUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final BoardDAO boardDAO = new BoardDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loginUser") == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		User loginUser = (User) session.getAttribute("loginUser");
		String commentIdStr = request.getParameter("commentId");
		String postIdStr = request.getParameter("postId");
		String content = request.getParameter("content");

		if (commentIdStr == null || postIdStr == null || content == null || content.trim().isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/board.do");
			return;
		}

		try {
			int commentId = Integer.parseInt(commentIdStr);
			boolean isAdmin = "ADMIN".equals(loginUser.getRole());
			boolean success = boardDAO.updateComment(commentId, loginUser.getUserId(), content.trim(), isAdmin);

			if (!success) {
				System.err.println("댓글 수정 실패: 권한 없음 또는 댓글이 존재하지 않음");
			}

			response.sendRedirect(request.getContextPath() + "/board.do#post-" + postIdStr);
		} catch (NumberFormatException | SQLException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/board.do");
		}
	}
}
