package com.coinlab.controller;

import java.io.IOException;

import com.coinlab.dao.AssetsDAO;
import com.coinlab.dao.UserDAO;
import com.coinlab.dto.Assets;
import com.coinlab.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username =  request.getParameter("username");
		String password = request.getParameter("password");

		UserDAO userDAO = new UserDAO();
		User user = userDAO.login(username, password);
		
		if(user !=null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", user);
			session.setAttribute("username", user.getUsername());
			
			userDAO.updateLastLogin(user.getUsername());
			
			AssetsDAO assetsDAO = new AssetsDAO();
			Assets assets = assetsDAO.getAssetsByUserId(user.getUserId());
			session.setAttribute("userAssets", assets);
			session.setMaxInactiveInterval(3600);
			
			
			response.sendRedirect("index.jsp");
			
		}else {
			request.setAttribute("errorMsg", "아이디 또는 비밀번호가 틀립니다.");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

}
