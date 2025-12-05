package com.coinlab.controller;

import java.io.IOException;
import java.util.List;

import com.coinlab.dao.BoardDAO;
import com.coinlab.dto.BoardComment;
import com.coinlab.dto.BoardPost;
import com.coinlab.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/board.do")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final BoardDAO boardDAO = new BoardDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loginUser") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		User loginUser = (User) session.getAttribute("loginUser");
		List<BoardPost> posts = boardDAO.getPosts(loginUser.getUserId());

		for (BoardPost post : posts) {
			List<BoardComment> comments = boardDAO.getComments(post.getPostId());
			post.setComments(comments);
		}

		request.setAttribute("posts", posts);
		request.getRequestDispatcher("/board.jsp").forward(request, response);
	}
}
