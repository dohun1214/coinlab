package com.coinlab.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.coinlab.dao.UserDAO;

@WebServlet("/checkEmailDuplicate.do")
public class CheckEmailDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");

		UserDAO userDAO = new UserDAO();
		boolean isDuplicate = userDAO.checkEmailDuplicate(email);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"isDuplicate\":" + isDuplicate + "}");
	}

}
