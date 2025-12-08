package com.coinlab.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.coinlab.dao.UserDAO;
import com.coinlab.dto.Ranking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ranking.do")
public class RankingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final UserDAO userDAO = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 상위 20명 조회
		ArrayList<Ranking> rankings = userDAO.getRankingByProfitRate(20);

		request.setAttribute("rankings", rankings);
		request.getRequestDispatcher("/ranking.jsp").forward(request, response);
	}
}
