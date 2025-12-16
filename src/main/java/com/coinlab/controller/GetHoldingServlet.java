package com.coinlab.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import com.coinlab.dao.HoldingsDAO;
import com.coinlab.dto.User;

@WebServlet("/trade/getHolding.do")
public class GetHoldingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		try {
			HttpSession session = request.getSession(false);

			if (session == null || session.getAttribute("loginUser") == null) {
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				out.print("{\"quantity\": 0}");
				return;
			}

			User user = (User) session.getAttribute("loginUser");
			String coinSymbol = request.getParameter("coinSymbol");

			if (coinSymbol != null && coinSymbol.contains("-")) {
				coinSymbol = coinSymbol.split("-")[1];
			}

			HoldingsDAO holdingsDAO = new HoldingsDAO();
			double quantity = holdingsDAO.getCoinHolding(user.getUserId(), coinSymbol);

			out.print("{\"quantity\": " + quantity + "}");
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			out.print("{\"quantity\": 0, \"error\": \"" + e.getMessage() + "\"}");
		} finally {
			out.flush();
		}
	}
}
