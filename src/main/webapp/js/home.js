document.addEventListener('DOMContentLoaded', () => {
	// 숫자를 천단위 콤마로 포맷팅
	function formatPrice(price) {
		return Math.floor(price).toLocaleString('ko-KR');
	}

	// 전일대비를 퍼센트로 포맷팅
	function formatChangeRate(rate) {
		const percent = (rate * 100).toFixed(2);
		const sign = rate >= 0 ? '+' : '';
		return sign + percent + '%';
	}

	// 거래대금을 억/백만 단위로 포맷팅
	function formatVolume(volume) {
		if (volume >= 100000000) {
			return (volume / 100000000).toFixed(0) + '억';
		} else if (volume >= 1000000) {
			return (volume / 1000000).toFixed(0) + '백만';
		} else {
			return volume.toLocaleString('ko-KR');
		}
	}

	// 전일대비에 따라 색상 클래스 반환
	function getChangeRateColor(rate) {
		if (rate > 0) {
			return 'text-red-600'; // 상승
		} else if (rate < 0) {
			return 'text-blue-600'; // 하락
		} else {
			return 'text-slate-600'; // 보합
		}
	}

	const ws = new WebSocket('ws://localhost:8080/CoinLab/ticker')
	ws.onopen = () => {
		console.log('websocket 연결됨')
	}

	ws.onmessage = (event) => {
		let data = JSON.parse(event.data)

		switch (data.code) {
			case "KRW-BTC":
				document.getElementById('current-price-1').innerHTML = formatPrice(data.tradePrice);
				const changeRate1 = document.getElementById('change-rate-1');
				changeRate1.innerHTML = formatChangeRate(data.signedChangeRate);
				changeRate1.className = 'px-6 py-4 text-right font-bold ' + getChangeRateColor(data.signedChangeRate);
				document.getElementById('volume-1').innerHTML = formatVolume(data.accTradePrice24h);
				break;
			case "KRW-ETH":
				document.getElementById('current-price-2').innerHTML = formatPrice(data.tradePrice);
				const changeRate2 = document.getElementById('change-rate-2');
				changeRate2.innerHTML = formatChangeRate(data.signedChangeRate);
				changeRate2.className = 'px-6 py-4 text-right font-bold ' + getChangeRateColor(data.signedChangeRate);
				document.getElementById('volume-2').innerHTML = formatVolume(data.accTradePrice24h);
				break;
			case "KRW-USDT":
				document.getElementById('current-price-3').innerHTML = formatPrice(data.tradePrice);
				const changeRate3 = document.getElementById('change-rate-3');
				changeRate3.innerHTML = formatChangeRate(data.signedChangeRate);
				changeRate3.className = 'px-6 py-4 text-right font-bold ' + getChangeRateColor(data.signedChangeRate);
				document.getElementById('volume-3').innerHTML = formatVolume(data.accTradePrice24h);
				break;
			case "KRW-XRP":
				document.getElementById('current-price-4').innerHTML = formatPrice(data.tradePrice);
				const changeRate4 = document.getElementById('change-rate-4');
				changeRate4.innerHTML = formatChangeRate(data.signedChangeRate);
				changeRate4.className = 'px-6 py-4 text-right font-bold ' + getChangeRateColor(data.signedChangeRate);
				document.getElementById('volume-4').innerHTML = formatVolume(data.accTradePrice24h);
				break;
			case "KRW-SOL":
				document.getElementById('current-price-5').innerHTML = formatPrice(data.tradePrice);
				const changeRate5 = document.getElementById('change-rate-5');
				changeRate5.innerHTML = formatChangeRate(data.signedChangeRate);
				changeRate5.className = 'px-6 py-4 text-right font-bold ' + getChangeRateColor(data.signedChangeRate);
				document.getElementById('volume-5').innerHTML = formatVolume(data.accTradePrice24h);
		}
	}
})