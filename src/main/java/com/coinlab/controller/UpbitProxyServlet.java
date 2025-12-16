package com.coinlab.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/trade/upbit-proxy.do")
public class UpbitProxyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UPBIT_API_BASE = "https://api.upbit.com/v1/candles/";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 파라미터 추출
		String type = request.getParameter("type"); // 예: minutes/1, seconds, etc.
		String market = request.getParameter("market"); // 예: KRW-BTC
		String count = request.getParameter("count"); // 예: 200

		// 파라미터 검증
		if (type == null || market == null) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("{\"error\": \"Missing required parameters\"}");
			return;
		}

		// 기본값 설정
		if (count == null) {
			count = "200";
		}

		try {
			// Upbit API URL 생성
			String urlString = UPBIT_API_BASE + type + "?market=" +
					URLEncoder.encode(market, StandardCharsets.UTF_8) +
					"&count=" + count;

			URL url = new URL(urlString);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");
			conn.setConnectTimeout(5000);
			conn.setReadTimeout(5000);

			int responseCode = conn.getResponseCode();

			// 응답 읽기
			BufferedReader in = new BufferedReader(
					new InputStreamReader(
							responseCode == 200 ? conn.getInputStream() : conn.getErrorStream(),
							StandardCharsets.UTF_8
					)
			);

			StringBuilder content = new StringBuilder();
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				content.append(inputLine);
			}
			in.close();
			conn.disconnect();

			// 응답 전달
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.setStatus(responseCode);
			

			// CORS 헤더 추가 (필요한 경우)
			response.setHeader("Access-Control-Allow-Origin", "*");
			response.setHeader("Access-Control-Allow-Methods", "GET");

			PrintWriter out = response.getWriter();
			out.print(content.toString());
			out.flush();

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
		}
	}
}
