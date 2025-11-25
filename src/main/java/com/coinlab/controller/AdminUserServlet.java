package com.coinlab.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.coinlab.dao.UserDAO;
import com.coinlab.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/users.do")
public class AdminUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final UserDAO userDAO = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User loginUser = session != null ? (User) session.getAttribute("loginUser") : null;

		if (loginUser == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		if (!"ADMIN".equals(loginUser.getRole())) {
			request.setAttribute("accessDenied", true);
			request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
			return;
		}

		ArrayList<User> users = userDAO.getAllUsers();
		if (users == null) {
			users = new ArrayList<>();
		}

		request.setAttribute("users", users);
		request.setAttribute("userCount", users.size());
		request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User loginUser = session != null ? (User) session.getAttribute("loginUser") : null;

		if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN);
			return;
		}

		String action = request.getParameter("action");
		String username = request.getParameter("username");

		if ("delete".equals(action) && username != null) {
			userDAO.deleteUser(username);
		} else if ("role".equals(action) && username != null) {
			String role = request.getParameter("role");
			if ("ADMIN".equals(role) || "USER".equals(role)) {
				userDAO.updateUserRole(username, role);
			}
		}

		response.sendRedirect(request.getContextPath() + "/admin/users.do");
	}
}
