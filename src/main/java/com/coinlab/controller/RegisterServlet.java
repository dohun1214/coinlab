package com.coinlab.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.coinlab.dao.UserDAO;
import com.coinlab.dto.User;

@WebServlet("/register.do")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String nickname = request.getParameter("nickname");
		String profileImage = null;
		
		User user = new User(username, password, email, nickname, profileImage);
		UserDAO userDAO = new UserDAO();
		userDAO.insertUser(user);
		
		response.sendRedirect("login.jsp");
	}

}
