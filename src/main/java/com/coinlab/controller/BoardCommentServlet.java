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

@WebServlet("/board/comment.do")
public class BoardCommentServlet extends HttpServlet {
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
		String postIdParam = request.getParameter("postId");
		String content = request.getParameter("content");

		if (postIdParam == null) {
			response.sendRedirect(request.getContextPath() + "/board.do");
			return;
		}

		int postId = Integer.parseInt(postIdParam);
		if (content == null || content.trim().isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/board.do#post-" + postId);
			return;
		}

		try {
			boardDAO.createComment(postId, loginUser.getUserId(), content.trim());
			response.sendRedirect(request.getContextPath() + "/board.do#post-" + postId);
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/board.do#post-" + postId);
		}
	}
}
