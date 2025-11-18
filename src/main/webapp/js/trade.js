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

	// 초기 데이터 로드

	// WebSocket 연결
	const ws = new WebSocket('ws://localhost:8080/CoinLab/candle');

	ws.onopen = () => {
		console.log('WebSocket 연결됨');

	};

	let code = document.getElementById('coin-select').value;
	let type = document.getElementById('type').value;
	loadInitialData(code, type)
	document.getElementById('coin-select').addEventListener('change', function() {
		code = this.value;
		loadInitialData(code, type)
	})
	document.getElementById('type').addEventListener('change', function() {
		type = this.value;
		loadInitialData(code, type)
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

	function getTime(type,timestamp) {
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
		/** @type {{type : string, code: string, koreanName: string, openingPrice: number, highPrice : number, lowPrice : number, tradePrice : number, timestamp : number}} */
		let data = JSON.parse(event.data)

		if (data.code == code && data.type == getType(type)) {
			// 캔들 데이터 업데이트
			const candleData = {
				time: getTime(type,data.timestamp),
				open: data.openingPrice,
				high: data.highPrice,
				low: data.lowPrice,
				close: data.tradePrice
			};

			candlestickSeries.update(candleData);
		}



	};

	ws.onerror = (error) => {
		console.error('WebSocket 오류:', error);
	};

	ws.onclose = () => {
		console.log('WebSocket 연결 종료');
	};
})