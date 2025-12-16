package com.coinlab.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.coinlab.dao.BoardDAO;
import com.coinlab.dao.UserDAO;
import com.coinlab.dto.Board;
import com.coinlab.dto.Ranking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/index.do")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final UserDAO userDAO = new UserDAO();
	private final BoardDAO boardDAO = new BoardDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 랭킹 상위 3명 조회
		ArrayList<Ranking> topRankings = userDAO.getRankingByProfitRate(3);

		// 최신 공지사항 4개 조회
		List<Board> allPosts = boardDAO.getPosts(null);
		List<Board> recentPosts = allPosts.size() > 4 ? allPosts.subList(0, 4) : allPosts;

		request.setAttribute("topRankings", topRankings);
		request.setAttribute("recentPosts", recentPosts);
		request.getRequestDispatcher("/home.jsp").forward(request, response);
	}
}
