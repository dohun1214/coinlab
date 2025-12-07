document.addEventListener('DOMContentLoaded', () => {
	// 페이지 로드 시 스크롤 위치 복원
	const savedScrollPosition = sessionStorage.getItem('tradeScrollPosition');
	if (savedScrollPosition) {
		window.scrollTo(0, parseInt(savedScrollPosition));
		sessionStorage.removeItem('tradeScrollPosition');
	}

	// 성공/에러 메시지 5초 후 자동 사라지기
	const successMessage = document.getElementById('success_message');
	const errorMessage = document.getElementById('error_message');

	if (successMessage) {
		setTimeout(() => {
			successMessage.style.opacity = '0';
			setTimeout(() => successMessage.remove(), 500);
		}, 5000);
	}

	if (errorMessage) {
		setTimeout(() => {
			errorMessage.style.opacity = '0';
			setTimeout(() => errorMessage.remove(), 500);
		}, 5000);
	}

	const chart = LightweightCharts.createChart(document.getElementById('chart'), {
		layout: {
			background: { type: 'solid', color: '#ffffff' },
			textColor: '#333333',
		},
		grid: {
			vertLines: { color: '#f0f0f0' },
			horzLines: { color: '#f0f0f0' },
		},

		timeScale: {
			timeVisible: true,
			secondsVisible: true,
		},
		width: document.getElementById('chart').clientWidth,
		height: 400,
	});

	// 캔들스틱 시리즈 추가 (5.0 문법)
	const candlestickSeries = chart.addSeries(LightweightCharts.CandlestickSeries, {
		upColor: '#DD3C44',
		downColor: '#1375EC',
		borderVisible: false,
		wickUpColor: '#DD3C44',
		wickDownColor: '#1375EC',
	});

	// 초기 데이터 가져오기
	async function loadInitialData(code, type) {
		candlestickSeries.setData([]);
		try {
			// Upbit API에서 최근 200개의 데이터 가져오기
			const response = await fetch(`https://api.upbit.com/v1/candles/${type}?market=${code}&count=200`);
			const data = await response.json();

			// 데이터를 차트 형식으로 변환 (시간 순서대로 정렬)
			const chartData = data.reverse().map(candle => ({
				time: Math.floor((new Date(candle.candle_date_time_kst).getTime() + (9 * 60 * 60 * 1000)) / 1000),
				open: candle.opening_price,
				high: candle.high_price,
				low: candle.low_price,
				close: candle.trade_price
			}));

			// 차트에 초기 데이터 설정
			candlestickSeries.setData(chartData);
			console.log('초기 데이터 로드 완료:', chartData.length, '개');

		} catch (error) {
			console.error('초기 데이터 로드 실패:', error);
		}
	}


	// WebSocket 연결
	const ws = new WebSocket('ws://localhost:8080/CoinLab/ticker');

	ws.onopen = () => {
		console.log('WebSocket 연결됨');

	};


	let currentPriceBuy = document.getElementById('current_price_buy')
	let buyQuantity = document.getElementById('buy_quantity')
	let buyTotal = document.getElementById('buy_total')
	let buyFee = document.getElementById('buy_fee')
	let buyTotalWithFee = document.getElementById('buy_total_with_fee')

	let currentPriceSell = document.getElementById('current_price_sell')
	let sellQuantity = document.getElementById('sell_quantity')
	let sellTotal = document.getElementById('sell_total')
	let sellFee = document.getElementById('sell_fee')
	let sellTotalAfterFee = document.getElementById('sell_total_after_fee')

	const FEE_RATE = 0.0005; // 0.05% 수수료

	let code = 'KRW-BTC'; // 기본값
	let type = document.getElementById('type').value;
	loadInitialData(code, type)

	// 탭 전환 기능
	const buyTab = document.getElementById('buy_tab');
	const sellTab = document.getElementById('sell_tab');
	const buyPanel = document.getElementById('buy_panel');
	const sellPanel = document.getElementById('sell_panel');

	buyTab.addEventListener('click', () => {
		// 매수 탭 활성화
		buyTab.classList.add('bg-red-50', 'text-red-600', 'border-b-2', 'border-red-600');
		buyTab.classList.remove('text-gray-600', 'hover:bg-gray-50');

		// 매도 탭 비활성화
		sellTab.classList.remove('bg-blue-50', 'text-blue-600', 'border-b-2', 'border-blue-600');
		sellTab.classList.add('text-gray-600', 'hover:bg-gray-50');

		buyPanel.classList.remove('hidden');
		sellPanel.classList.add('hidden');
	});

	sellTab.addEventListener('click', () => {
		// 매도 탭 활성화
		sellTab.classList.add('bg-blue-50', 'text-blue-600', 'border-b-2', 'border-blue-600');
		sellTab.classList.remove('text-gray-600', 'hover:bg-gray-50');

		// 매수 탭 비활성화
		buyTab.classList.remove('bg-red-50', 'text-red-600', 'border-b-2', 'border-red-600');
		buyTab.classList.add('text-gray-600', 'hover:bg-gray-50');

		sellPanel.classList.remove('hidden');
		buyPanel.classList.add('hidden');
	});

	// 보유 코인 수량 가져오기
	async function updateCoinHolding(coinCode) {
		try {
			const response = await fetch(`trade/getHolding.do?coinSymbol=${coinCode}`);
			const data = await response.json();
			document.getElementById('user_coin_quantity').innerText = data.quantity.toFixed(8);
		} catch (error) {
			console.error('보유 수량 가져오기 실패:', error);
			document.getElementById('user_coin_quantity').innerText = '0';
		}
	}

	// 초기 로드 시 BTC 보유 수량 가져오기
	updateCoinHolding(code);

	// 코인 박스 클릭 이벤트
	const coinBoxes = document.querySelectorAll('.coin-box');
	coinBoxes.forEach(box => {
		box.addEventListener('click', function() {
			// 모든 박스의 선택 상태 제거
			coinBoxes.forEach(b => {
				b.classList.remove('border-blue-500');
				b.classList.add('border-transparent');
			});

			// 클릭한 박스 선택 상태로 변경
			this.classList.remove('border-transparent');
			this.classList.add('border-blue-500');

			code = this.getAttribute('data-code');

			// 헤더 정보 업데이트
			const coinSymbol = code.split("-")[1];
			document.getElementById('coin_title').innerText = `${getCoinName(code)} (${coinSymbol})`;

			// 보유 수량 업데이트
			updateCoinHolding(code);

			loadInitialData(code, type);
			document.getElementById('buy_coinSymbol').value = code
			document.getElementById('sell_coinSymbol').value = code
			ws2.close();
			ws2 = connectNewWebSocket(code);

		});
	});
	document.getElementById('type').addEventListener('change', function() {
		type = this.value;
		loadInitialData(code, type)
		ws2.close()
		ws2 = connectNewWebSocket(code)
	})

	function getType(type) {
		switch (type) {
			case "seconds":
				return "candle.1s";
			case "minutes/1":
				return "candle.1m";
			case "minutes/5":
				return "candle.5m";
			case "minutes/10":
				return "candle.10m";
			case "minutes/30":
				return "candle.30m";
			case "minutes/60":
				return "candle.60m";
			case "minutes/240":
				return "candle.240m";

		}
	}

	function getTime(type, timestamp) {
		switch (type) {
			case "seconds":
				return Math.floor((timestamp + (9 * 60 * 60 * 1000)) / 1000);
			case "minutes/1":
				return Math.floor((timestamp + 9 * 60 * 60 * 1000) / 1000 / 60) * 60;
			case "minutes/5":
				return Math.floor((timestamp + 9 * 60 * 60 * 1000) / 1000 / 300) * 300;
			case "minutes/10":
				return Math.floor((timestamp + 9 * 60 * 60 * 1000) / 1000 / 600) * 600;
			case "minutes/30":
				return Math.floor((timestamp + 9 * 60 * 60 * 1000) / 1000 / 1800) * 1800;
			case "minutes/60":
				return Math.floor((timestamp + 9 * 60 * 60 * 1000) / 1000 / 3600) * 3600;
			case "minutes/240":
				return Math.floor((timestamp + 9 * 60 * 60 * 1000) / 1000 / 14400) * 14400;
		}
	}

	let coin = {
		'KRW-BTC': {},
		'KRW-ETH': {}
	}

	ws.onmessage = (event) => {


		let data = JSON.parse(event.data)

		coin[data.code] = data


		for (const key of Object.keys(coin)) {
			if (code == key) {
				// 헤더 정보 업데이트
				const coinSymbol = code.split("-")[1];
				document.getElementById('coin_title').innerText = `${getCoinName(code)} (${coinSymbol})`;
				document.getElementById('header_price').innerText = `${coin[code].tradePrice.toLocaleString()} 원`;

				// 변동률 배지 업데이트
				const changeRate = (Math.floor(coin[code].signedChangeRate * 100 * 100) / 100).toFixed(2);
				const changeBadge = document.getElementById('change_badge');

				if (coin[code].change === 'RISE') {
					changeBadge.className = 'bg-red-500 text-white px-3 py-1 rounded text-sm font-semibold';
					changeBadge.innerText = `+${changeRate}%`;
				} else if (coin[code].change === 'FALL') {
					changeBadge.className = 'bg-blue-500 text-white px-3 py-1 rounded text-sm font-semibold';
					changeBadge.innerText = `${changeRate}%`;
				} else {
					changeBadge.className = 'bg-gray-500 text-white px-3 py-1 rounded text-sm font-semibold';
					changeBadge.innerText = '0.00%';
				}

				document.getElementById('current_price_buy').innerText = `${coin[code].tradePrice.toLocaleString()} 원`
				document.getElementById('buy_price').value = coin[code].tradePrice
				const buyTotalAmount = Math.floor(coin[code].tradePrice * parseFloat(buyQuantity.value));
				const buyFeeAmount = Math.floor(buyTotalAmount * FEE_RATE);
				buyTotal.innerText = buyTotalAmount.toLocaleString() + ' 원';
				if(buyFee) buyFee.innerText = buyFeeAmount.toLocaleString() + ' 원';
				if(buyTotalWithFee) buyTotalWithFee.innerText = (buyTotalAmount + buyFeeAmount).toLocaleString() + ' 원';

				document.getElementById('current_price_sell').innerText = `${coin[code].tradePrice.toLocaleString()} 원`
				document.getElementById('sell_price').value = coin[code].tradePrice
				const sellTotalAmount = Math.floor(coin[code].tradePrice * parseFloat(sellQuantity.value));
				const sellFeeAmount = Math.floor(sellTotalAmount * FEE_RATE);
				sellTotal.innerText = sellTotalAmount.toLocaleString() + ' 원';
				if(sellFee) sellFee.innerText = sellFeeAmount.toLocaleString() + ' 원';
				if(sellTotalAfterFee) sellTotalAfterFee.innerText = (sellTotalAmount - sellFeeAmount).toLocaleString() + ' 원';

				document.getElementById('high_price').innerHTML = `<span style="color: #DD3C44">${coin[code].highPrice.toLocaleString()} 원</span>`
				document.getElementById('low_price').innerHTML = `<span style="color: #1375EC">${coin[code].lowPrice.toLocaleString()} 원</span>`
				document.getElementById('acc_trade_price24h').innerText = `${Math.floor(coin[code].accTradePrice24h).toLocaleString()} 원`
				document.getElementById('acc_trade_volume24h').innerText = `${coin[code].accTradeVolume24h.toFixed(2)} ${coin[code].code.split("-")[1]}`

				// signed_change_price 업데이트
				const signedChangePriceElem = document.getElementById('signed_change_price');
				if (coin[code].change === 'RISE') {
					signedChangePriceElem.className = 'text-red-600 font-medium';
					signedChangePriceElem.innerText = `+${coin[code].signedChangePrice.toLocaleString()} 원`;
				} else if (coin[code].change === 'FALL') {
					signedChangePriceElem.className = 'text-blue-600 font-medium';
					signedChangePriceElem.innerText = `${coin[code].signedChangePrice.toLocaleString()} 원`;
				} else {
					signedChangePriceElem.className = 'text-gray-600 font-medium';
					signedChangePriceElem.innerText = '0 원';
				}

				break
			}
		}

		document.querySelectorAll('.price').forEach((d) => {
			if (d.dataset.code == data.code) {
				d.innerHTML = data.change == "RISE" ? `<span style="color:#DD3C44">${data.tradePrice.toLocaleString()}</span>` : data.change == "FALL" ? `<span style="color:#1375EC">${data.tradePrice.toLocaleString()}</span>` : `<span style="color:gray">${data.tradePrice.toLocaleString()}</span>`
			}
		})

	};

	ws.onerror = (error) => {
		console.error('WebSocket 오류:', error);
	};

	ws.onclose = () => {
		console.log('WebSocket 연결 종료');
	};


	let ws2 = connectNewWebSocket(code)
	function connectNewWebSocket(code) {
		let ws2 = new WebSocket('wss://api.upbit.com/websocket/v1')

		ws2.onopen = () => {
			console.log('ws2 연결 성공')
			ws2.send(JSON.stringify([
				{ "ticket": "test" },
				{ "type": `${getType(type)}`, "codes": [`${code}`] }
			]))
		}


		ws2.onmessage = async (event) => {
			let text = await event.data.text()
			/** @type {{type : string, code: string, opening_price: number, high_price : number, low_price : number, trade_price : number, timestamp : number}} */
			let data = JSON.parse(text)

			const candleData = {
				time: getTime(type, data.timestamp),
				open: data.opening_price,
				high: data.high_price,
				low: data.low_price,
				close: data.trade_price
			};

			candlestickSeries.update(candleData);




		}


		ws2.onerror = (error) => {
			console.error('ws2 에러' + error)
		}
		return ws2
	}

	document.getElementById('buy_quantity').addEventListener('input', () => {
		const currentPrice = parseFloat(currentPriceBuy.innerText.replace(/,/g, '').replace('원', '').trim());
		const total = Math.floor(currentPrice * parseFloat(buyQuantity.value));
		const fee = Math.floor(total * FEE_RATE);
		buyTotal.innerText = total.toLocaleString() + ' 원';
		if(buyFee) buyFee.innerText = fee.toLocaleString() + ' 원';
		if(buyTotalWithFee) buyTotalWithFee.innerText = (total + fee).toLocaleString() + ' 원';
		document.getElementById('buy_quantity_display').innerText = buyQuantity.value;
	})

	document.getElementById('sell_quantity').addEventListener('input', () => {
		const currentPrice = parseFloat(currentPriceSell.innerText.replace(/,/g, '').replace('원', '').trim());
		const total = Math.floor(currentPrice * parseFloat(sellQuantity.value));
		const fee = Math.floor(total * FEE_RATE);
		sellTotal.innerText = total.toLocaleString() + ' 원';
		if(sellFee) sellFee.innerText = fee.toLocaleString() + ' 원';
		if(sellTotalAfterFee) sellTotalAfterFee.innerText = (total - fee).toLocaleString() + ' 원';
		document.getElementById('sell_quantity_display').innerText = sellQuantity.value;
	})

	// 매수 퍼센트 버튼 기능
	const buyPercentBtns = document.querySelectorAll('.buy_percent_btn');
	buyPercentBtns.forEach(btn => {
		btn.addEventListener('click', () => {
			const percent = parseInt(btn.getAttribute('data-percent'));
			const krwBalance = parseFloat(document.getElementById('user_krw_balance').innerText.replace(/,/g, ''));
			const currentPrice = parseFloat(currentPriceBuy.innerText.replace(/,/g, '').replace('원', '').trim());

			if (currentPrice > 0) {
				const quantity = (krwBalance * percent / 100) / currentPrice;
				const total = Math.floor(currentPrice * quantity);
				const fee = Math.floor(total * FEE_RATE);
				buyQuantity.value = quantity.toFixed(8);
				buyTotal.innerText = total.toLocaleString() + ' 원';
				if(buyFee) buyFee.innerText = fee.toLocaleString() + ' 원';
				if(buyTotalWithFee) buyTotalWithFee.innerText = (total + fee).toLocaleString() + ' 원';
				document.getElementById('buy_quantity_display').innerText = quantity.toFixed(8);
			}
		});
	});

	// 매도 퍼센트 버튼 기능
	const sellPercentBtns = document.querySelectorAll('.sell_percent_btn');
	sellPercentBtns.forEach(btn => {
		btn.addEventListener('click', () => {
			const percent = parseInt(btn.getAttribute('data-percent'));
			const coinQuantity = parseFloat(document.getElementById('user_coin_quantity').innerText);
			const currentPrice = parseFloat(currentPriceSell.innerText.replace(/,/g, '').replace('원', '').trim());

			const quantity = coinQuantity * percent / 100;
			const total = Math.floor(currentPrice * quantity);
			const fee = Math.floor(total * FEE_RATE);
			sellQuantity.value = quantity.toFixed(8);
			sellTotal.innerText = total.toLocaleString() + ' 원';
			if(sellFee) sellFee.innerText = fee.toLocaleString() + ' 원';
			if(sellTotalAfterFee) sellTotalAfterFee.innerText = (total - fee).toLocaleString() + ' 원';
			document.getElementById('sell_quantity_display').innerText = quantity.toFixed(8);
		});
	});

	// 코인 이름 매핑
	function getCoinName(code) {
		const coinNames = {
			'KRW-BTC': '비트코인',
			'KRW-ETH': '이더리움',
			'KRW-SOL': '솔라나',
			'KRW-XRP': '리플',
			'KRW-ADA': '에이다',
			'KRW-AVAX': '아발란체',
			'KRW-DOT': '폴카닷',
			'KRW-ARB': '아비트럼',
			'KRW-ATOM': '코스모스',
			'KRW-APT': '앱토스',
			'KRW-UNI': '유니스왑',
			'KRW-AAVE': '에이브',
			'KRW-LINK': '체인링크',
			'KRW-SAND': '샌드박스',
			'KRW-DOGE': '도지코인',
			'KRW-SHIB': '시바이누',
			'KRW-PEPE': '페페',
			'KRW-USDT': '테더',
			'KRW-USDC': '유에스디코인'
		};
		return coinNames[code] || code;
	}

	// 매수 폼 제출 시 검증 및 스크롤 위치 저장
	document.getElementById('buy_form').addEventListener('submit', (e) => {
		const quantity = parseFloat(buyQuantity.value);
		if (quantity <= 0 || isNaN(quantity)) {
			e.preventDefault();
			alert('매수 수량은 0.00000001개 이상이어야 합니다.');
			return false;
		}
		sessionStorage.setItem('tradeScrollPosition', window.scrollY);
	});

	// 매도 폼 제출 시 검증 및 스크롤 위치 저장
	document.getElementById('sell_form').addEventListener('submit', (e) => {
		const quantity = parseFloat(sellQuantity.value);
		if (quantity <= 0 || isNaN(quantity)) {
			e.preventDefault();
			alert('매도 수량은 0.00000001개 이상이어야 합니다.');
			return false;
		}
		sessionStorage.setItem('tradeScrollPosition', window.scrollY);
	});

})