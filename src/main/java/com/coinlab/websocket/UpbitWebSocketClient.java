package com.coinlab.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.websocket.Session;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.WebSocket;
import okhttp3.WebSocketListener;
import okio.ByteString;

public class UpbitWebSocketClient extends WebSocketListener {

	private static UpbitWebSocketClient instance;

	private WebSocket webSocket;

	private OkHttpClient client;

	private Gson gson;

	private Set<Session> frontendSessions = new CopyOnWriteArraySet<Session>();

	JsonObject processed = new JsonObject();

	private UpbitWebSocketClient() {
		this.client = new OkHttpClient();
		this.gson = new Gson();
		System.out.println("UpbitWebSocketClient 생성자 실행");
	}

	public static UpbitWebSocketClient getInstance() {
		if (instance == null) {
			instance = new UpbitWebSocketClient();
		}
		return instance;
	}

	public void connect() {
		System.out.println("Upbit 연결 시작");

		String url = "wss://api.upbit.com/websocket/v1";

		Request request = new Request.Builder().url(url).build();

		webSocket = client.newWebSocket(request, this);
		System.out.println("Websocket 연결 시도 중...");
	}

	@Override
	public void onOpen(WebSocket webSocket, Response response) {
		System.out.println("Upbit Websocket 연결 성공");

		String subscribeMessage = "[{\"ticket\": \"test\"},{\"type\": \"ticker\",\"codes\": [\"KRW-BTC\",\"KRW-ETH\",\"KRW-SOL\",\"KRW-XRP\",\"KRW-ADA\",\"KRW-AVAX\",\"KRW-DOT\",\"KRW-ARB\",\"KRW-ATOM\",\"KRW-APT\",\"KRW-UNI\",\"KRW-AAVE\",\"KRW-LINK\",\"KRW-SAND\",\"KRW-DOGE\",\"KRW-SHIB\",\"KRW-PEPE\",\"KRW-USDT\",\"KRW-USDC\"]}]";
		webSocket.send(subscribeMessage);

	}

	@Override
	public void onMessage(WebSocket webSocket, ByteString bytes) {
		String text = bytes.utf8();

		processAndStore(text);
		broadcastToFrontend();
	}

	private void processAndStore(String text) {
		JsonObject upbitData = gson.fromJson(text, JsonObject.class);

		String type = upbitData.get("type").getAsString();
		String code = upbitData.get("code").getAsString();
		double highPrice = upbitData.get("high_price").getAsDouble();
		double lowPrice = upbitData.get("low_price").getAsDouble();
		double trade_price = upbitData.get("trade_price").getAsDouble();
		String change = upbitData.get("change").getAsString();
		double signedChangePrice = upbitData.get("signed_change_price").getAsDouble();
		double signedChangeRate = upbitData.get("signed_change_rate").getAsDouble();
		double accTradePrice24h = upbitData.get("acc_trade_price_24h").getAsDouble();
		double accTradeVolume24h = upbitData.get("acc_trade_volume_24h").getAsDouble();
		
		processed.addProperty("type", type);
		processed.addProperty("code", code);
		processed.addProperty("koreanName", getKoreanName(code));
		processed.addProperty("highPrice", highPrice);
		processed.addProperty("lowPrice", lowPrice);
		processed.addProperty("tradePrice", trade_price);
		processed.addProperty("change", change);
		processed.addProperty("signedChangePrice", signedChangePrice);
		processed.addProperty("signedChangeRate", signedChangeRate);
		processed.addProperty("accTradePrice24h", accTradePrice24h);
		processed.addProperty("accTradeVolume24h", accTradeVolume24h);

	}

	private String getKoreanName(String code) {
		Map<String, String> names = new HashMap<String, String>();
		names.put("KRW-BTC", "비트코인");
		names.put("KRW-ETH", "이더리움");
		names.put("KRW-SOL", "솔라나");
		names.put("KRW-XRP", "리플");
		names.put("KRW-ADA", "에이다");
		names.put("KRW-AVAX", "아발란체");
		names.put("KRW-DOT", "폴카닷");
		names.put("KRW-ARB", "아비트럼");
		names.put("KRW-ATOM", "코스모스");
		names.put("KRW-APT", "앱토스");
		names.put("KRW-UNI", "유니스왑");
		names.put("KRW-AAVE", "에이브");
		names.put("KRW-LINK", "체인링크");
		names.put("KRW-SAND", "샌드박스");
		names.put("KRW-DOGE", "도지코인");
		names.put("KRW-SHIB", "시바이누");
		names.put("KRW-PEPE", "페페");
		names.put("KRW-USDT", "테더");
		names.put("KRW-USDC", "유에스디코인");
		return names.get(code);

	}

	public String getAllData() {
		String json = gson.toJson(processed);
		return json;
	}

	public void addSession(Session session) {
		if(frontendSessions.isEmpty()) {
			connect();
		}
		frontendSessions.add(session);
	}

	public void removeSession(Session session) {
		frontendSessions.remove(session);
		
		if(frontendSessions.isEmpty()) {
			disconnect();
		}
	}

	public void broadcastToFrontend() {
		String data = getAllData();
		for (Session session : frontendSessions) {
			if (session != null && session.isOpen()) {
				try {
					session.getBasicRemote().sendText(data);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void onFailure(WebSocket webSocket, Throwable t, Response response) {
		System.err.println("Upbit 연결 실패");
		System.err.println("에러 메세지 : " + t.getMessage());

		new Thread(() -> {
			try {
				Thread.sleep(2000);
				connect();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}).start();
	}

	@Override
	public void onClosed(WebSocket webSocket, int code, String reason) {
		System.out.println("Upbit 연결 종료");
		System.out.println("종료 코드 : " + code);
		System.out.println("종료 이유 : " + reason);
	}

	public void disconnect() {
		if (webSocket != null) {
			webSocket.close(1000, "정상 종료");
			webSocket = null;
		}
	}

}
