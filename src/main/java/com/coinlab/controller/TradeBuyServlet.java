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

@WebServlet("/trade/buy.do")
public class TradeBuyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String coinSymbol = request.getParameter("coinSymbol").split("-")[1];
		int price =Integer.parseInt(request.getParameter("price"));
		double quantity = Double.parseDouble(request.getParameter("quantity"));
		double totalPrice = price * quantity;
		
		HttpSession session = request.getSession(false);
		
		if(session == null || session.getAttribute("loginUser") == null ) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}
		
		User user = (User)session.getAttribute("loginUser");
		
		AssetsDAO assetsDAO = new AssetsDAO();
		boolean success = assetsDAO.decreaseKrwBalance(user.getUserId(), totalPrice);
		
		if(success) {
			Assets updatedAssets = assetsDAO.getAssetsByUserId(user.getUserId());
			session.setAttribute("userAssets", updatedAssets);
			
			HoldingsDAO holdingsDAO = new HoldingsDAO();
			holdingsDAO.addCoinHolding(user.getUserId(), coinSymbol, quantity, price);
			
			TransactionsDAO transactionDAO = new TransactionsDAO();
			transactionDAO.insertTransaction(user.getUserId(), coinSymbol, "BUY", quantity, price, totalPrice);
			

			
			session.setAttribute("successMsg", "매수가 완료되었습니다");
			
			response.sendRedirect(request.getContextPath() + "/trade.jsp");
		}else {
			request.setAttribute("errorMsg", "잔액이 부족합니다.");
			response.sendRedirect(request.getContextPath() + "/trade.jsp");
		}
		
		
		
	}

}
