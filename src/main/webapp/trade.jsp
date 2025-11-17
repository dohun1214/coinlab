<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CoinLab - 거래</title>
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
	<select id="coin-select">
		<option value="KRW-BTC" selected>비트코인</option>
		<option value="KRW-ETH">이더리움</option>
		<option value="KRW-SOL">솔라나</option>
		<option value="KRW-XRP">리플</option>
		<option value="KRW-ADA">에이다</option>
		<option value="KRW-AVAX">아발란체</option>
		<option value="KRW-DOT">폴카닷</option>
		<option value="KRW-ARB">아비트럼</option>
		<option value="KRW-ATOM">코스모스</option>
		<option value="KRW-APT">앱토스</option>
		<option value="KRW-UNI">유니스왑</option>
		<option value="KRW-AAVE">에이브</option>
		<option value="KRW-LINK">체인링크</option>
		<option value="KRW-SAND">샌드박스</option>
		<option value="KRW-DOGE">도지코인</option>
		<option value="KRW-SHIB">시바이누</option>
		<option value="KRW-PEPE">페페</option>
		<option value="KRW-USDT">테더</option>
		<option value="KRW-USDC">유에스디코인</option>
	</select>

	<select id="type">
		<option value="seconds" selected>초</option>
		<option value="minutes/1">1분</option>
		<option value="minutes/5">5분</option>
		<option value="minutes/10">10분</option>
		<option value="minutes/30">30분</option>
		<option value="minutes/60">1시간</option>
		<option value="minutes/240">4시간</option>
	</select>
	<div id="chart"></div>

	<script type="text/javascript" src="js/trade.js"></script>
</body>
</html>