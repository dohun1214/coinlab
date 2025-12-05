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

		if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
			request.setAttribute("errorMsg", "제목과 내용을 입력해주세요.");
			request.getRequestDispatcher("/board-write.jsp").forward(request, response);
			return;
		}

		try {
			boardDAO.createPost(loginUser.getUserId(), title.trim(), content.trim());
			response.sendRedirect(request.getContextPath() + "/board.do");
		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errorMsg", "게시글 저장 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/board-write.jsp").forward(request, response);
		}
	}
}
