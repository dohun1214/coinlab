document.addEventListener('DOMContentLoaded', () => {
	const chart = LightweightCharts.createChart(document.getElementById('chart'), {
		layout: {
			background: { type: 'solid', color: '#1e1e1e' },
			textColor: '#d1d4dc',
		},
		grid: {
			vertLines: { color: '#2b2b43' },
			horzLines: { color: '#2b2b43' },
		},

		timeScale: {
			timeVisible: true,
			secondsVisible: true,
		}
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

	let currentPriceSell = document.getElementById('current_price_sell')
	let sellQuantity = document.getElementById('sell_quantity')
	let sellTotal = document.getElementById('sell_total')

	let code = 'KRW-BTC'; // 기본값
	let type = document.getElementById('type').value;
	loadInitialData(code, type)

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


	ws.onmessage = (event) => {


		let data = JSON.parse(event.data)

		if (data.code == code) {

			document.getElementById('high_price').innerText = `고가 : ${data.highPrice}`
			document.getElementById('low_price').innerText = `저가 : ${data.lowPrice}`
			document.getElementById('trade_price').innerText = `종가 : ${data.tradePrice}`
			document.getElementById('change').innerText = `가격 변동 상태 : ${data.change}\n`
			document.getElementById('signed_change_rate').innerText = `전일 종가 대비 가격 변화율 : ${Math.floor(data.signedChangeRate * 100 * 100) / 100}%`
			document.getElementById('signed_change_price').innerText = `전일 종가 대비 가격 변화 : ${data.signedChangePrice}`
			document.getElementById('acc_trade_volume_24h').innerText = `거래량(24h) : ${Math.floor(data.accTradeVolume24h * 1000) / 1000} ${code.split("-")[1]} `
			document.getElementById('acc_trade_price_24h').innerText = `거래대금(24h) : ${Math.floor(data.accTradePrice24h)} KRW`

			document.getElementById('current_price_buy').innerText = data.tradePrice
			document.getElementById('buy_price').value = data.tradePrice
			buyTotal.innerText =Math.floor(parseInt(currentPriceBuy.innerText) * parseFloat(buyQuantity.value)*1000)/1000

			document.getElementById('current_price_sell').innerText = data.tradePrice
			document.getElementById('sell_price').value = data.tradePrice
			sellTotal.innerText = parseInt(currentPriceSell.innerText) * parseFloat(sellQuantity.value)



		}

		document.querySelectorAll('.price').forEach((d) => {
			if (d.dataset.code == data.code) {
				d.innerHTML = data.change == "RISE" ? `<span style="color:#DD3C44">${data.tradePrice}</span>` : data.change == "FALL" ? `<span style="color:#1375EC">${data.tradePrice}</span>` : `<span style="color:black">${data.tradePrice}</span>`
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
		buyTotal.innerText = Math.floor(parseInt(currentPriceBuy.innerText) * parseFloat(buyQuantity.value)*1000)/1000
	})

	document.getElementById('sell_quantity').addEventListener('input', () => {
		sellTotal.innerText = parseInt(currentPriceSell.innerText) * parseFloat(sellQuantity.value)
	})


})