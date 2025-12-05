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

@WebServlet("/board/comment/delete.do")
public class BoardCommentDeleteServlet extends HttpServlet {
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
		String commentIdParam = request.getParameter("commentId");
		String postIdParam = request.getParameter("postId");

		if (commentIdParam == null || postIdParam == null) {
			response.sendRedirect(request.getContextPath() + "/board.do");
			return;
		}

		int commentId = Integer.parseInt(commentIdParam);
		int postId = Integer.parseInt(postIdParam);
		boolean isAdmin = "ADMIN".equalsIgnoreCase(loginUser.getRole());

		try {
			boardDAO.deleteComment(commentId, loginUser.getUserId(), isAdmin);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		response.sendRedirect(request.getContextPath() + "/board.do#post-" + postId);
	}
}
