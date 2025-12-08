package com.coinlab.controller;

import java.io.IOException;
import java.util.List;

import com.coinlab.dao.HoldingsDAO;
import com.coinlab.dao.TransactionsDAO;
import com.coinlab.dto.Holdings;
import com.coinlab.dto.Transactions;
import com.coinlab.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/mypage.do")
public class MyPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final TransactionsDAO transactionsDAO = new TransactionsDAO();
	private final HoldingsDAO holdingsDAO = new HoldingsDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loginUser") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		User loginUser = (User) session.getAttribute("loginUser");
		List<Transactions> transactions = transactionsDAO.getTransactionsByUserId(loginUser.getUserId());
		List<Holdings> holdings = holdingsDAO.getHoldingsByUserId(loginUser.getUserId());

		request.setAttribute("transactions", transactions);
		request.setAttribute("holdings", holdings);
		request.getRequestDispatcher("/mypage.jsp").forward(request, response);
	}
}
