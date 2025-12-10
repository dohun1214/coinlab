package com.coinlab.websocket;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.google.gson.Gson;

import jakarta.websocket.Session;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.WebSocket;
import okhttp3.WebSocketListener;
import okio.ByteString;

/**
 * 각 클라이언트 세션마다 독립적인 Upbit 차트 WebSocket 연결을 관리
 */
public class ChartWebSocketClient extends WebSocketListener {

	private WebSocket upbitWebSocket;
	private Session frontendSession;
	private OkHttpClient client;
	private Gson gson;
	private String currentCode;
	private String currentType;

	// 모든 활성 클라이언트를 관리
	private static Map<String, ChartWebSocketClient> activeClients = new ConcurrentHashMap<>();

	public ChartWebSocketClient(Session frontendSession) {
		this.frontendSession = frontendSession;
		this.client = new OkHttpClient();
		this.gson = new Gson();
	}

	public static ChartWebSocketClient getOrCreate(Session session) {
		return activeClients.computeIfAbsent(session.getId(), k -> new ChartWebSocketClient(session));
	}

	public static void remove(Session session) {
		ChartWebSocketClient client = activeClients.remove(session.getId());
		if (client != null) {
			client.disconnect();
		}
	}

	public void connect(String code, String type) {
		this.currentCode = code;
		this.currentType = type;

		// 기존 연결이 있으면 종료
		if (upbitWebSocket != null) {
			upbitWebSocket.close(1000, "Switching subscription");
		}

		String url = "wss://api.upbit.com/websocket/v1";
		Request request = new Request.Builder().url(url).build();
		upbitWebSocket = client.newWebSocket(request, this);

		System.out.println("차트 WebSocket 연결 시도: " + code + " (" + type + ")");
	}

	@Override
	public void onOpen(WebSocket webSocket, Response response) {
		System.out.println("차트 WebSocket 연결 성공");

		// Upbit에 구독 메시지 전송
		String subscribeMessage = String.format(
				"[{\"ticket\": \"chart-%s\"},{\"type\": \"%s\",\"codes\": [\"%s\"]}]",
				frontendSession.getId(),
				currentType,
				currentCode
		);
		webSocket.send(subscribeMessage);
		System.out.println("구독 메시지 전송: " + subscribeMessage);
	}

	@Override
	public void onMessage(WebSocket webSocket, ByteString bytes) {
		String text = bytes.utf8();

		// 프론트엔드로 그대로 전달
		if (frontendSession != null && frontendSession.isOpen()) {
			try {
				frontendSession.getBasicRemote().sendText(text);
			} catch (IOException e) {
				System.err.println("프론트엔드 전송 실패: " + e.getMessage());
			}
		}
	}

	@Override
	public void onFailure(WebSocket webSocket, Throwable t, Response response) {
		System.err.println("차트 WebSocket 연결 실패: " + t.getMessage());

		// 재연결 시도
		new Thread(() -> {
			try {
				Thread.sleep(2000);
				if (frontendSession != null && frontendSession.isOpen()) {
					connect(currentCode, currentType);
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}).start();
	}

	@Override
	public void onClosed(WebSocket webSocket, int code, String reason) {
		System.out.println("차트 WebSocket 연결 종료: " + reason);
	}

	public void disconnect() {
		if (upbitWebSocket != null) {
			upbitWebSocket.close(1000, "Client disconnected");
			upbitWebSocket = null;
		}
	}
}
