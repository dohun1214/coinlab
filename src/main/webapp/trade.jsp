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
	padding: 0;
	background-color: #f8f9fa;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

.container {
	display: flex;
	flex: 1;
	padding: 0;
}

.sidebar {
	position: fixed; 
	left: 20px;
	top: 80px; 
	width: 280px;
	height: calc(100vh - 80px); 
	background-color: #ffffff;
	overflow-y: auto;
	padding: 16px;
	border-right: 1px solid #e9ecef;
}

.sidebar::-webkit-scrollbar {
	width: 8px;
}

.sidebar::-webkit-scrollbar-track {
	background: #f8f9fa;
}

.sidebar::-webkit-scrollbar-thumb {
	background: #dee2e6;
	border-radius: 4px;
}

.sidebar::-webkit-scrollbar-thumb:hover {
	background: #adb5bd;
}

.main-content {
	flex: 1;
	margin-left: 320px;  /* sidebar 너비 + 여백 */
	padding: 20px 20px 20px 40px;
	display: flex;
	flex-direction: column;
	gap: 20px;
}

.content-grid {
	display: flex;
	flex-direction: column;
	gap: 20px;
	flex: 1;
}

.chart-section {
	display: flex;
	flex-direction: column;
	gap: 20px;
	min-width: 1350px;
}

#chart {
	width: 100%;
	height: 420px;
}

.trade-panel {
	width: 100%;
	margin: 0 auto;
}

footer {
	margin-left: 320px;
	flex-shrink: 0;
}
</style>
<script
	src="https://unpkg.com/lightweight-charts@5.0.9/dist/lightweight-charts.standalone.production.js"></script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<div class="container">
		<!-- 사이드바 -->
		<div class="sidebar">
			<h2 class="text-gray-900 text-lg font-bold mb-4">코인 목록</h2>
			<div class="flex flex-col gap-2">
				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-blue-500 rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-BTC">
					<div class="text-gray-900 font-semibold">비트코인</div>
					<div class="text-gray-600 text-xs mt-1">BTC</div>
					<div class="price" data-code="KRW-BTC"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-ETH">
					<div class="text-gray-900 font-semibold">이더리움</div>
					<div class="text-gray-600 text-xs mt-1">ETH</div>
					<div class="price" data-code="KRW-ETH"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-SOL">
					<div class="text-gray-900 font-semibold">솔라나</div>
					<div class="text-gray-600 text-xs mt-1">SOL</div>
					<div class="price" data-code="KRW-SOL"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-XRP">
					<div class="text-gray-900 font-semibold">리플</div>
					<div class="text-gray-600 text-xs mt-1">XRP</div>
					<div class="price" data-code="KRW-XRP"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-ADA">
					<div class="text-gray-900 font-semibold">에이다</div>
					<div class="text-gray-600 text-xs mt-1">ADA</div>
					<div class="price" data-code="KRW-ADA"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-AVAX">
					<div class="text-gray-900 font-semibold">아발란체</div>
					<div class="text-gray-600 text-xs mt-1">AVAX</div>
					<div class="price" data-code="KRW-AVAX"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-DOT">
					<div class="text-gray-900 font-semibold">폴카닷</div>
					<div class="text-gray-600 text-xs mt-1">DOT</div>
					<div class="price" data-code="KRW-DOT"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-ARB">
					<div class="text-gray-900 font-semibold">아비트럼</div>
					<div class="text-gray-600 text-xs mt-1">ARB</div>
					<div class="price" data-code="KRW-ARB"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-ATOM">
					<div class="text-gray-900 font-semibold">코스모스</div>
					<div class="text-gray-600 text-xs mt-1">ATOM</div>
					<div class="price" data-code="KRW-ATOM"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-APT">
					<div class="text-gray-900 font-semibold">앱토스</div>
					<div class="text-gray-600 text-xs mt-1">APT</div>
					<div class="price" data-code="KRW-APT"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-UNI">
					<div class="text-gray-900 font-semibold">유니스왑</div>
					<div class="text-gray-600 text-xs mt-1">UNI</div>
					<div class="price" data-code="KRW-UNI"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-AAVE">
					<div class="text-gray-900 font-semibold">에이브</div>
					<div class="text-gray-600 text-xs mt-1">AAVE</div>
					<div class="price" data-code="KRW-AAVE"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-LINK">
					<div class="text-gray-900 font-semibold">체인링크</div>
					<div class="text-gray-600 text-xs mt-1">LINK</div>
					<div class="price" data-code="KRW-LINK"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-SAND">
					<div class="text-gray-900 font-semibold">샌드박스</div>
					<div class="text-gray-600 text-xs mt-1">SAND</div>
					<div class="price" data-code="KRW-SAND"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-DOGE">
					<div class="text-gray-900 font-semibold">도지코인</div>
					<div class="text-gray-600 text-xs mt-1">DOGE</div>
					<div class="price" data-code="KRW-DOGE"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-SHIB">
					<div class="text-gray-900 font-semibold">시바이누</div>
					<div class="text-gray-600 text-xs mt-1">SHIB</div>
					<div class="price" data-code="KRW-SHIB"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-PEPE">
					<div class="text-gray-900 font-semibold">페페</div>
					<div class="text-gray-600 text-xs mt-1">PEPE</div>
					<div class="price" data-code="KRW-PEPE"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-USDT">
					<div class="text-gray-900 font-semibold">테더</div>
					<div class="text-gray-600 text-xs mt-1">USDT</div>
					<div class="price" data-code="KRW-USDT"></div>
				</div>

				<div
					class="coin-box bg-gray-50 hover:bg-gray-100 border-2 border-transparent rounded-lg p-3 cursor-pointer transition-all text-center"
					data-code="KRW-USDC">
					<div class="text-gray-900 font-semibold">유에스디코인</div>
					<div class="text-gray-600 text-xs mt-1">USDC</div>
					<div class="price" data-code="KRW-USDC"></div>
				</div>
			</div>
		</div>

		<!-- 메인 컨텐츠 -->
		<div class="main-content">
			<!-- 코인 헤더 -->
			<div class="flex justify-between items-center">
				<div class="flex items-center gap-4">
					<h1 class="text-gray-900 text-2xl font-bold" id="coin_title">비트코인 (BTC)</h1>
					<span class="text-gray-900 text-xl font-semibold" id="header_price">100,000,000 원</span>
					<span id="change_badge" class="bg-red-500 text-white px-3 py-1 rounded text-sm font-semibold">+1.4%</span>
					<span id="signed_change_price" class="text-gray-900 font-medium"></span>
				</div>
				<div class="flex items-center gap-2">
					<span class="text-gray-600 text-sm">차트 간격:</span>
					<select id="type" class="bg-white text-gray-900 border border-gray-300 rounded px-3 py-1">
						<option value="seconds" selected>초</option>
						<option value="minutes/1">1분</option>
						<option value="minutes/5">5분</option>
						<option value="minutes/10">10분</option>
						<option value="minutes/30">30분</option>
						<option value="minutes/60">1시간</option>
						<option value="minutes/240">4시간</option>
					</select>
				</div>
			</div>

			<!-- 코인 통계 정보 카드 -->
			<div class="grid grid-cols-4 gap-4">
				<div class="bg-white rounded-lg p-4 border border-gray-200">
					<div class="text-gray-600 text-sm mb-1">고가</div>
					<div class="text-gray-900 font-semibold text-lg" id="high_price">-</div>
				</div>
				<div class="bg-white rounded-lg p-4 border border-gray-200">
					<div class="text-gray-600 text-sm mb-1">저가</div>
					<div class="text-gray-900 font-semibold text-lg" id="low_price">-</div>
				</div>
				<div class="bg-white rounded-lg p-4 border border-gray-200">
					<div class="text-gray-600 text-sm mb-1">거래대금 (24H)</div>
					<div class="text-gray-900 font-semibold text-lg" id="acc_trade_price24h">-</div>
				</div>
				<div class="bg-white rounded-lg p-4 border border-gray-200">
					<div class="text-gray-600 text-sm mb-1">거래량 (24H)</div>
					<div class="text-gray-900 font-semibold text-lg" id="acc_trade_volume24h">-</div>
				</div>
			</div>

			<!-- 콘텐츠 그리드 -->
			<div class="content-grid">
				<!-- 차트 섹션 -->
				<div class="chart-section">
					<!-- 실시간 가격 차트 -->
					<div class="bg-white rounded-lg p-4 border border-gray-200">
						<h3 class="text-gray-800 font-semibold mb-4">실시간 가격 차트</h3>
						<div id="chart"></div>
					</div>
				</div>

				<!-- 거래 패널 -->
				<div class="trade-panel bg-white rounded-lg overflow-hidden border border-gray-200">
				<!-- 탭 헤더 -->
				<div class="flex border-b border-gray-200">
					<button id="buy_tab" class="flex-1 px-6 py-4 font-semibold bg-red-50 text-red-600 border-b-2 border-red-600 transition-colors">매수</button>
					<button id="sell_tab" class="flex-1 px-6 py-4 font-semibold text-gray-600 hover:bg-gray-50 transition-colors">매도</button>
				</div>

				<!-- 매수 패널 -->
				<div id="buy_panel" class="p-6">
					<form action="trade/buy.do" method="post" id="buy_form">
						<input type="hidden" name="coinSymbol" id="buy_coinSymbol" value="KRW-BTC">
						<input type="hidden" name="price" id="buy_price" value="0">

						<div class="mb-4">
							<div class="flex justify-between text-sm mb-2">
								<span class="text-gray-600">주문 수량</span>
								<span class="text-gray-900"><span id="buy_quantity_display">0</span>개</span>
							</div>
							<div class="flex justify-between text-sm mb-4">
								<span class="text-gray-600">사용 가능 잔액</span>
								<span class="text-gray-900"><span id="user_krw_balance"><fmt:formatNumber value="${sessionScope.userAssets.krwBalance}" pattern="#,###" /></span> 원</span>
							</div>

							<input type="number" id="buy_quantity" step="0.00000001" min="0.00000001" value="0" name="quantity" class="w-full bg-gray-50 text-gray-900 border border-gray-300 rounded px-4 py-3 mb-4" required>

							<!-- 퍼센트 버튼 -->
							<div class="grid grid-cols-4 gap-2 mb-4">
								<button type="button" class="buy_percent_btn bg-gray-100 hover:bg-gray-200 text-gray-900 rounded py-2" data-percent="25">25%</button>
								<button type="button" class="buy_percent_btn bg-gray-100 hover:bg-gray-200 text-gray-900 rounded py-2" data-percent="50">50%</button>
								<button type="button" class="buy_percent_btn bg-gray-100 hover:bg-gray-200 text-gray-900 rounded py-2" data-percent="75">75%</button>
								<button type="button" class="buy_percent_btn bg-gray-100 hover:bg-gray-200 text-gray-900 rounded py-2" data-percent="100">100%</button>
							</div>

							<div class="flex justify-between text-sm mb-2">
								<span class="text-gray-600">현재가</span>
								<span class="text-gray-900" id="current_price_buy">0 원</span>
							</div>
							<div class="flex justify-between text-sm mb-2">
								<span class="text-gray-600">주문 금액</span>
								<span class="text-gray-900" id="buy_total">0 원</span>
							</div>
							<div class="flex justify-between text-sm mb-2">
								<span class="text-gray-600">수수료 (0.05%)</span>
								<span class="text-red-600 font-medium" id="buy_fee">0 원</span>
							</div>
							<div class="flex justify-between text-sm mb-4 pt-2 border-t border-gray-200">
								<span class="text-gray-900 font-semibold">총 결제 금액</span>
								<span class="text-gray-900 font-semibold" id="buy_total_with_fee">0 원</span>
							</div>
						</div>

						<button type="submit" class="w-full bg-red-600 hover:bg-red-700 text-white font-semibold py-4 rounded transition-colors">매수</button>
					</form>
				</div>

				<!-- 매도 패널 -->
				<div id="sell_panel" class="p-6 hidden">
					<form action="trade/sell.do" method="post" id="sell_form">
						<input type="hidden" name="coinSymbol" id="sell_coinSymbol" value="KRW-BTC">
						<input type="hidden" name="price" id="sell_price" value="0">

						<div class="mb-4">
							<div class="flex justify-between text-sm mb-2">
								<span class="text-gray-600">주문 수량</span>
								<span class="text-gray-900"><span id="sell_quantity_display">0</span>개</span>
							</div>
							<div class="flex justify-between text-sm mb-4">
								<span class="text-gray-600">보유 수량</span>
								<span class="text-gray-900" id="user_coin_quantity">0</span>
							</div>

							<input type="number" id="sell_quantity" step="0.00000001" min="0.00000001" value="0" name="quantity" class="w-full bg-gray-50 text-gray-900 border border-gray-300 rounded px-4 py-3 mb-4" required>

							<!-- 퍼센트 버튼 -->
							<div class="grid grid-cols-4 gap-2 mb-4">
								<button type="button" class="sell_percent_btn bg-gray-100 hover:bg-gray-200 text-gray-900 rounded py-2" data-percent="25">25%</button>
								<button type="button" class="sell_percent_btn bg-gray-100 hover:bg-gray-200 text-gray-900 rounded py-2" data-percent="50">50%</button>
								<button type="button" class="sell_percent_btn bg-gray-100 hover:bg-gray-200 text-gray-900 rounded py-2" data-percent="75">75%</button>
								<button type="button" class="sell_percent_btn bg-gray-100 hover:bg-gray-200 text-gray-900 rounded py-2" data-percent="100">100%</button>
							</div>

							<div class="flex justify-between text-sm mb-2">
								<span class="text-gray-600">현재가</span>
								<span class="text-gray-900" id="current_price_sell">0 원</span>
							</div>
							<div class="flex justify-between text-sm mb-2">
								<span class="text-gray-600">매도 금액</span>
								<span class="text-gray-900" id="sell_total">0 원</span>
							</div>
							<div class="flex justify-between text-sm mb-2">
								<span class="text-gray-600">수수료 (0.05%)</span>
								<span class="text-blue-600 font-medium" id="sell_fee">0 원</span>
							</div>
							<div class="flex justify-between text-sm mb-4 pt-2 border-t border-gray-200">
								<span class="text-gray-900 font-semibold">총 수령 금액</span>
								<span class="text-gray-900 font-semibold" id="sell_total_after_fee">0 원</span>
							</div>
						</div>

						<button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-4 rounded transition-colors">매도</button>
					</form>
				</div>

				<%-- 성공/에러 메시지 표시 --%>
				<c:if test="${not empty sessionScope.successMsg}">
					<div id="success_message" class="mx-6 mb-6 bg-green-600 text-white px-4 py-3 rounded transition-opacity duration-500">${sessionScope.successMsg}</div>
					<c:remove var="successMsg" scope="session" />
				</c:if>

				<c:if test="${not empty sessionScope.errorMsg}">
					<div id="error_message" class="mx-6 mb-6 bg-red-600 text-white px-4 py-3 rounded transition-opacity duration-500">${sessionScope.errorMsg}</div>
					<c:remove var="errorMsg" scope="session" />
				</c:if>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript" src="js/trade.js"></script>

<%@ include file="footer.jsp" %>

</body>
</html>
