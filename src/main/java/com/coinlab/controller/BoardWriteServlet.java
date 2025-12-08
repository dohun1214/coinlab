package com.coinlab.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.coinlab.dao.BoardDAO;
import com.coinlab.dto.Board;
import com.coinlab.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/board/write.do")
public class BoardWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final BoardDAO boardDAO = new BoardDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loginUser") == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		User loginUser = (User) session.getAttribute("loginUser");
		String postIdStr = request.getParameter("postId");

		// 수정 모드인 경우
		if (postIdStr != null && !postIdStr.isEmpty()) {
			try {
				int postId = Integer.parseInt(postIdStr);
				Board post = boardDAO.getPostById(postId);

				if (post == null) {
					response.sendRedirect(request.getContextPath() + "/board.do");
					return;
				}

				// 작성자 본인이거나 관리자인 경우만 수정 가능
				boolean isAdmin = "ADMIN".equals(loginUser.getRole());
				if (post.getUserId() != loginUser.getUserId() && !isAdmin) {
					response.sendRedirect(request.getContextPath() + "/board.do");
					return;
				}

				request.setAttribute("post", post);
				request.setAttribute("isEditMode", true);
			} catch (NumberFormatException | SQLException e) {
				e.printStackTrace();
				response.sendRedirect(request.getContextPath() + "/board.do");
				return;
			}
		}

		request.getRequestDispatcher("/board-write.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loginUser") == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		User loginUser = (User) session.getAttribute("loginUser");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String postIdStr = request.getParameter("postId");

		if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
			request.setAttribute("errorMsg", "제목과 내용을 입력해주세요.");
			request.getRequestDispatcher("/board-write.jsp").forward(request, response);
			return;
		}

		try {
			// 수정 모드인 경우
			if (postIdStr != null && !postIdStr.isEmpty()) {
				int postId = Integer.parseInt(postIdStr);
				boolean isAdmin = "ADMIN".equals(loginUser.getRole());
				boolean success = boardDAO.updatePost(postId, loginUser.getUserId(), title.trim(), content.trim(), isAdmin);

				if (!success) {
					request.setAttribute("errorMsg", "게시글 수정 권한이 없거나 게시글이 존재하지 않습니다.");
					request.getRequestDispatcher("/board-write.jsp").forward(request, response);
					return;
				}
			} else {
				// 새 게시글 작성
				boardDAO.createPost(loginUser.getUserId(), title.trim(), content.trim());
			}

			response.sendRedirect(request.getContextPath() + "/board.do");
		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errorMsg", "게시글 저장 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/board-write.jsp").forward(request, response);
		}
	}
}
