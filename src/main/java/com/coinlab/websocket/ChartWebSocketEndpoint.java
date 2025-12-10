package com.coinlab.websocket;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;

/**
 * 차트 데이터를 위한 WebSocket 엔드포인트
 * 클라이언트가 연결하고 구독 정보를 보내면 Upbit API로부터 실시간 캔들 데이터를 전달
 */
@ServerEndpoint("/chart")
public class ChartWebSocketEndpoint {

	private ChartWebSocketClient chartClient;

	@OnOpen
	public void onOpen(Session session) {
		System.out.println("차트 클라이언트 연결: " + session.getId());
		chartClient = ChartWebSocketClient.getOrCreate(session);
	}

	@OnMessage
	public void onMessage(String message, Session session) {
		System.out.println("차트 구독 요청: " + message);

		// 메시지 형식: {"code": "KRW-BTC", "type": "candle.1m"}
		try {
			com.google.gson.JsonObject json = new com.google.gson.Gson().fromJson(message, com.google.gson.JsonObject.class);
			String code = json.get("code").getAsString();
			String type = json.get("type").getAsString();

			chartClient.connect(code, type);
		} catch (Exception e) {
			System.err.println("구독 요청 파싱 실패: " + e.getMessage());
			e.printStackTrace();
		}
	}

	@OnClose
	public void onClose(Session session) {
		System.out.println("차트 클라이언트 연결 종료: " + session.getId());
		ChartWebSocketClient.remove(session);
	}

	@OnError
	public void onError(Session session, Throwable throwable) {
		System.err.println("차트 WebSocket 에러");
		System.err.println("세션 ID: " + session.getId());
		System.err.println("에러 메시지: " + throwable.getMessage());
		throwable.printStackTrace();
	}
}
