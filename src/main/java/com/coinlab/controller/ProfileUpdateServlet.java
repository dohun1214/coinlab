package com.coinlab.controller;

import java.io.IOException;

import com.coinlab.dao.UserDAO;
import com.coinlab.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

@WebServlet(urlPatterns = { "/profile/update", "/profile/update.do" })
public class ProfileUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User sessionUser = (session == null) ? null : (User) session.getAttribute("loginUser");
		if (sessionUser == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String username = sessionUser.getUsername();
		String currentPassword = request.getParameter("currentPassword");
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		String newPassword = request.getParameter("newPassword");
		String newPasswordConfirm = request.getParameter("newPasswordConfirm");

		if (currentPassword == null || !currentPassword.equals(sessionUser.getPassword())) {
			request.setAttribute("errorMsg", "현재 비밀번호가 올바르지 않습니다.");
			request.getRequestDispatcher("/mypage.jsp").forward(request, response);
			return;
		}

		if (newPassword != null && !newPassword.isEmpty()) {
			if (!newPassword.equals(newPasswordConfirm)) {
				request.setAttribute("errorMsg", "새 비밀번호와 확인이 일치하지 않습니다.");
				request.getRequestDispatcher("/mypage.jsp").forward(request, response);
				return;
			}
		}

		UserDAO userDAO = new UserDAO();
		if (nickname != null && !nickname.isBlank()) {
			userDAO.updateNickname(username, nickname.trim());
		}
		if (email != null && !email.isBlank()) {
			userDAO.updateEmail(username, email.trim());
		}
		if (newPassword != null && !newPassword.isBlank()) {
			userDAO.updatePassword(username, newPassword);
		}

		try {
			User refreshed = userDAO.getUserByUsername(username);
			session.setAttribute("loginUser", refreshed);
			request.setAttribute("successMsg", "내 정보가 저장되었습니다.");
		} catch (SQLException e) {
			request.setAttribute("errorMsg", "정보 갱신 중 오류가 발생했습니다.");
		}
		request.getRequestDispatcher("/mypage.jsp").forward(request, response);
	}
}
