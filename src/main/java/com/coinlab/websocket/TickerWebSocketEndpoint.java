package com.coinlab.websocket;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/ticker")
public class TickerWebSocketEndpoint {

	private static UpbitWebSocketClient upbitClient;

	private Session session;

	static {
		upbitClient = UpbitWebSocketClient.getInstance();
	}

	@OnOpen
	public void onOpen(Session session) {
		this.session = session;
		System.out.println("프론트엔드 연결: " + session.getId());

		// Upbit 클라이언트에 세션 등록
		upbitClient.addSession(session);
	}

	@OnClose
	public void onClose(Session session) {
		System.out.println(session.getId() + " 연결 종료");

		// Upbit 클라이언트에서 세션 제거
		upbitClient.removeSession(session);
	}

	@OnError
	public void onError(Session session, Throwable throwable) {
		System.err.println("에러 발생");
		System.err.println("세션 Id : " + session.getId());
		System.err.println("에러 메세지 : " + throwable.getMessage());
		throwable.printStackTrace();
	}
}