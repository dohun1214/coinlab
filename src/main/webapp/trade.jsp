<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CoinLab - 거래</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
body {
	margin: 0;
	padding: 20px;
	background-color: #1e1e1e;
}

#chart {
	width: 100%;
	height: 600px;
}
</style>
<script
	src="https://unpkg.com/lightweight-charts@5.0.9/dist/lightweight-charts.standalone.production.js"></script>
</head>
<body>
	<div
		class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-3 mb-6">
		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-blue-500 rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-BTC">
			<div class="text-white font-semibold">비트코인</div>
			<div class="text-gray-400 text-xs mt-1">BTC</div>
			<div class="price" data-code="KRW-BTC"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-ETH">
			<div class="text-white font-semibold">이더리움</div>
			<div class="text-gray-400 text-xs mt-1">ETH</div>
			<div class="price" data-code="KRW-ETH"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-SOL">
			<div class="text-white font-semibold">솔라나</div>
			<div class="text-gray-400 text-xs mt-1">SOL</div>
			<div class="price" data-code="KRW-SOL"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-XRP">
			<div class="text-white font-semibold">리플</div>
			<div class="text-gray-400 text-xs mt-1">XRP</div>
			<div class="price" data-code="KRW-XRP"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-ADA">
			<div class="text-white font-semibold">에이다</div>
			<div class="text-gray-400 text-xs mt-1">ADA</div>
			<div class="price" data-code="KRW-ADA"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-AVAX">
			<div class="text-white font-semibold">아발란체</div>
			<div class="text-gray-400 text-xs mt-1">AVAX</div>
			<div class="price" data-code="KRW-AVAX"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-DOT">
			<div class="text-white font-semibold">폴카닷</div>
			<div class="text-gray-400 text-xs mt-1">DOT</div>
			<div class="price" data-code="KRW-DOT"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-ARB">
			<div class="text-white font-semibold">아비트럼</div>
			<div class="text-gray-400 text-xs mt-1">ARB</div>
			<div class="price" data-code="KRW-ARB"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-ATOM">
			<div class="text-white font-semibold">코스모스</div>
			<div class="text-gray-400 text-xs mt-1">ATOM</div>
			<div class="price" data-code="KRW-ATOM"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-APT">
			<div class="text-white font-semibold">앱토스</div>
			<div class="text-gray-400 text-xs mt-1">APT</div>
			<div class="price" data-code="KRW-APT"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-UNI">
			<div class="text-white font-semibold">유니스왑</div>
			<div class="text-gray-400 text-xs mt-1">UNI</div>
			<div class="price" data-code="KRW-UNI"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-AAVE">
			<div class="text-white font-semibold">에이브</div>
			<div class="text-gray-400 text-xs mt-1">AAVE</div>
			<div class="price" data-code="KRW-AAVE"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-LINK">
			<div class="text-white font-semibold">체인링크</div>
			<div class="text-gray-400 text-xs mt-1">LINK</div>
			<div class="price" data-code="KRW-LINK"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-SAND">
			<div class="text-white font-semibold">샌드박스</div>
			<div class="text-gray-400 text-xs mt-1">SAND</div>
			<div class="price" data-code="KRW-SAND"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-DOGE">
			<div class="text-white font-semibold">도지코인</div>
			<div class="text-gray-400 text-xs mt-1">DOGE</div>
			<div class="price" data-code="KRW-DOGE"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-SHIB">
			<div class="text-white font-semibold">시바이누</div>
			<div class="text-gray-400 text-xs mt-1">SHIB</div>
			<div class="price" data-code="KRW-SHIB"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-PEPE">
			<div class="text-white font-semibold">페페</div>
			<div class="text-gray-400 text-xs mt-1">PEPE</div>
			<div class="price" data-code="KRW-PEPE"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-USDT">
			<div class="text-white font-semibold">테더</div>
			<div class="text-gray-400 text-xs mt-1">USDT</div>
			<div class="price" data-code="KRW-USDT"></div>
		</div>

		<div
			class="coin-box bg-gray-700 hover:bg-gray-600 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
			data-code="KRW-USDC">
			<div class="text-white font-semibold">유에스디코인</div>
			<div class="text-gray-400 text-xs mt-1">USDC</div>
			<div class="price" data-code="KRW-USDC"></div>
		</div>
	</div>

	<select id="type">
		<option value="seconds" selected>초</option>
		<option value="minutes/1">1분</option>
		<option value="minutes/5">5분</option>
		<option value="minutes/10">10분</option>
		<option value="minutes/30">30분</option>
		<option value="minutes/60">1시간</option>
		<option value="minutes/240">4시간</option>
	</select>

	<span id="high_price" style="color: red"></span>
	<span id="low_price" style="color: red"></span>
	<span id="trade_price" style="color: red"></span>
	<span id="change" style="color: red"></span>
	<span id="signed_change_rate" style="color: red"></span>
	<span id="signed_change_price" style="color: red"></span>
	<span id="acc_trade_volume_24h" style="color: red"></span>
	<span id="acc_trade_price_24h" style="color: red"></span>

	<div id="chart"></div>

	<!-- 거래 패널 -->
	<div style="color: white;">
		<h2>거래</h2>

		<!-- 보유 자산 -->
		<div>
			<p>
				보유 KRW: <span id="user_krw_balance"><fmt:formatNumber
						value="${ sessionScope.userAssets.krwBalance}" pattern="#,###" /></span>
				원
			</p>
			<p>
				보유 수량: <span id="user_coin_quantity">0</span>
			</p>
		</div>

		<hr>

		<!-- 매수 -->
		<h3>매수</h3>
		<form action="trade/buy.do" method="post">
			<input type="hidden" name="coinSymbol" id="buy_coinSymbol"
				value="KRW-BTC"> <input type="hidden" name="price"
				id="buy_price" value="0">
			<p>
				현재가: <span id="current_price_buy">0</span> 원
			</p>
			<p>
				수량: <input type="number" id="buy_quantity" step="0.00000001"
					value="0" name="quantity">
			</p>
			<p>
				총 금액: <span id="buy_total">0</span> 원
			</p>
			<input type="submit" value="매수">
		</form>
		
		<%-- 성공/에러 메시지 표시 --%>
		<c:if test="${not empty sessionScope.successMsg}">
			<div class="alert alert-success">${sessionScope.successMsg}</div>
			<c:remove var="successMsg" scope="session" />
		</c:if>

		<c:if test="${not empty sessionScope.errorMsg}">
			<div class="alert alert-error">${sessionScope.errorMsg}</div>
			<c:remove var="errorMsg" scope="session" />
		</c:if>

		<hr>

		<!-- 매도 -->
		<h3>매도</h3>
		<form action="trade/sell.do" method="post">
			<input type="hidden" name="coinSymbol" id="sell_coinSymbol"
				value="KRW-BTC"> <input type="hidden" name="price"
				id="sell_price" value="0">
			<p>
				현재가: <span id="current_price_sell">0</span> 원
			</p>
			<p>
				수량: <input type="number" id="sell_quantity" step="0.00000001"
					value="0" name="quantity">
			</p>
			<p>
				총 금액: <span id="sell_total">0</span> 원
			</p>
			<input type="submit" value="매도">
		</form>
	</div>


	<script type="text/javascript" src="js/trade.js"></script>
</body>
</html>