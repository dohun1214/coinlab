package com.coinlab.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.coinlab.dao.AssetsDAO;
import com.coinlab.dao.HoldingsDAO;
import com.coinlab.dao.TransactionsDAO;
import com.coinlab.dto.Assets;
import com.coinlab.dto.User;

@WebServlet("/trade/sell.do")
public class TradeSellServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final double FEE_RATE = 0.0005; // 0.05% 수수료

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String coinSymbol = request.getParameter("coinSymbol").split("-")[1];
		double price = Double.parseDouble(request.getParameter("price"));
		double quantity = Double.parseDouble(request.getParameter("quantity"));
		double totalPrice = price * quantity;
		double fee = totalPrice * FEE_RATE;

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("loginUser") == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		User user = (User) session.getAttribute("loginUser");

		HoldingsDAO holdingsDAO = new HoldingsDAO();
		double avgBuyPrice = holdingsDAO.getAvgBuyPrice(user.getUserId(), coinSymbol);
		boolean success = holdingsDAO.reduceCoinHolding(user.getUserId(), coinSymbol, quantity);

		if (success) {
			AssetsDAO assetsDAO = new AssetsDAO();
			double totalAfterFee = totalPrice - fee;
			assetsDAO.increaseKrwBalance(user.getUserId(), totalAfterFee);
			assetsDAO.addTotalFee(user.getUserId(), fee);

			TransactionsDAO transactionDAO = new TransactionsDAO();
			transactionDAO.insertTransaction(user.getUserId(), coinSymbol, "SELL", quantity, price, totalPrice, fee);

			double realizedProfit = (price - avgBuyPrice) * quantity - fee;
			assetsDAO.addRealizedProfit(user.getUserId(), realizedProfit);
			assetsDAO.updateProfitRate(user.getUserId());

			Assets updatedAssets = assetsDAO.getAssetsByUserId(user.getUserId());
			session.setAttribute("userAssets", updatedAssets);


			session.setAttribute("successMsg", "매도가 완료되었습니다");

			response.sendRedirect(request.getContextPath() + "/trade.jsp");
		} else {
			session.setAttribute("errorMsg", "보유 수량이 부족합니다.");
			response.sendRedirect(request.getContextPath() + "/trade.jsp");
		}

	}

}
