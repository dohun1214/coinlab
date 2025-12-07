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

	private void refreshLoginUserIfSame(HttpSession session, String username) {
		if (session == null || username == null) {
			return;
		}
		User current = (User) session.getAttribute("loginUser");
		if (current != null && username.equals(current.getUsername())) {
			try {
				User refreshed = userDAO.getUserByUsername(username);
				session.setAttribute("loginUser", refreshed);
			} catch (Exception ignored) {
			}
		}
	}

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

		if ("create".equals(action)) {
			String newUsername = request.getParameter("newUsername");
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			String nickname = request.getParameter("nickname");
			String balanceStr = request.getParameter("initialBalance");
			if (newUsername != null && password != null && email != null && nickname != null) {
				try {
					double balance = (balanceStr != null && !balanceStr.isBlank())
							? Double.parseDouble(balanceStr.replace(",", ""))
							: 10000000.0;
					User newUser = new User();
					newUser.setUsername(newUsername.trim());
					newUser.setPassword(password.trim());
					newUser.setEmail(email.trim());
					newUser.setNickname(nickname.trim());
					newUser.setProfileImage("/images/default-profile.png");
					userDAO.insertUserWithBalance(newUser, balance);
				} catch (NumberFormatException ignored) {
					// 실패 시 무시하고 목록으로 리다이렉트
				}
			}
		} else if ("delete".equals(action) && username != null) {
			userDAO.deleteUser(username);
			if (loginUser != null && username.equals(loginUser.getUsername())) {
				session.invalidate();
				response.sendRedirect(request.getContextPath() + "/login.jsp");
				return;
			}
		} else if ("nickname".equals(action) && username != null) {
			String nickname = request.getParameter("nickname");
			if (nickname != null && !nickname.isBlank()) {
				userDAO.updateNickname(username, nickname.trim());
				refreshLoginUserIfSame(session, username);
			}
		} else if ("balance".equals(action) && username != null) {
			String balanceStr = request.getParameter("initialBalance");
			if (balanceStr != null && !balanceStr.isBlank()) {
				try {
					double balance = Double.parseDouble(balanceStr.replace(",", ""));
					userDAO.updateInitialBalance(username, balance);
					refreshLoginUserIfSame(session, username);
				} catch (NumberFormatException ignored) {
				}
			}
		} else if ("role".equals(action) && username != null) {
			String role = request.getParameter("role");
			if ("ADMIN".equals(role) || "USER".equals(role)) {
				userDAO.updateUserRole(username, role);
				refreshLoginUserIfSame(session, username);
			}
		}

		response.sendRedirect(request.getContextPath() + "/admin/users.do");
	}
}
