package com.coinlab.websocket;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import okhttp3.*;
import okio.ByteString;

public class UpbitWebSocketClient extends WebSocketListener{
	
	private static UpbitWebSocketClient instance;
	
	private WebSocket webSocket;
	
	private OkHttpClient client;
	
	private Gson gson;
	
	private Map<String, JsonObject> processedData = new ConcurrentHashMap<String, JsonObject>();
	
	private UpbitWebSocketClient() {
		this.client = new OkHttpClient();
		this.gson = new Gson();
		System.out.println("UpbitWebSocketClient 생성자 실행");
	}
	
	
	public static UpbitWebSocketClient getInstance() {
		if(instance==null) {
			instance = new UpbitWebSocketClient();
		}
		return instance;
	}
	
	public void connect () {
		System.out.println("Upbit 연결 시작");
		
		String url = "wss://api.upbit.com/websocket/v1";
		
		Request request = new Request.Builder().url(url).build();
		
		webSocket = client.newWebSocket(request, this);
		System.out.println("Websocket 연결 시도 중...");
	}
	
	@Override
	public void onOpen(WebSocket webSocket, Response response) {
		System.out.println("Upbit Websocket 연결 성공");
		
		String subscribeMessage = "[{\"ticket\": \"test\"},{\"type\": \"ticker\",\"codes\": [\"KRW-BTC\",\"KRW-ETH\"]},{\"format\": \"DEFAULT\"}]";
		webSocket.send(subscribeMessage);
		
	}
	
	
	@Override
	public void onMessage(WebSocket webSocket, ByteString bytes) {
		String text = bytes.utf8();
		
		processAndStore(text);
	}


	private void processAndStore(String text) {
		JsonObject upbitData = gson.fromJson(text, JsonObject.class);
		
		String code = upbitData.get("code").getAsString();
		double price = upbitData.get("trade_price").getAsDouble();
		double changeRate = upbitData.get("signed_change_rate").getAsDouble();
		double changePrice = upbitData.get("signed_change_price").getAsDouble();
		double volume = upbitData.get("acc_trade_volume").getAsDouble();
		double highPrice = upbitData.get("high_price").getAsDouble();
		double lowPrice = upbitData.get("low_price").getAsDouble();
		double status = upbitData.get("change").getAsDouble();
		
		double changeRatePercent = Math.round(changeRate*10000)/100.0;
		
		JsonObject processed = new JsonObject();
		processed.addProperty("code", code);
		processed.addProperty("koreanName", getKoreanName(code));
		processed.addProperty("currentPrice", price);
		processed.addProperty("changeRate", changeRatePercent);
		processed.addProperty("changePrice", changePrice);
		processed.addProperty("volume24h", volume);
		processed.addProperty("highPrice", highPrice);
		processed.addProperty("lowPrice", lowPrice);
		processed.addProperty("timestamp", System.currentTimeMillis());
		processed.addProperty("status", status);
		
		
		processedData.put(code, processed);
	}


	private String getKoreanName(String code) {
		Map<String, String> names = new HashMap<String, String>();
		names.put("KRW-BTC", "비트코인");
		names.put("KRW-ETH", "이더리움");
		names.put("KRW-XRP", "리플");
		return names.get(code);
		
	}
	
	
	
	
}
