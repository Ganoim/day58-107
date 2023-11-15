package com.spring_memberBoard.sockUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class ChatHandler extends TextWebSocketHandler {
	
	// 채팅 페에지에 접속한 클라이언트 목록
	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("채팅 페이지 접속");
		
		Map<String, Object> sessionAttrs = session.getAttributes();  // session
		String loginMemberId = (String)sessionAttrs.get("loginMemberId");
		
		Gson gson = new Gson();
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "c");
		msgInfo.put("msgid", loginMemberId);
		msgInfo.put("msgcomm", "접속 했습니다.");
		
		
		for(WebSocketSession client : clientList) {
			client.sendMessage( new TextMessage( gson.toJson (msgInfo) ) );
			
		}
		clientList.add(session);
		
		for(WebSocketSession client : clientList) { // A,B,C,D,E 5번 반복
			Map<String, Object> clientAttrs = client.getAttributes();  // session
			String clientMemberId = (String)clientAttrs.get("loginMemberId");
			
			HashMap<String, String> clientInfo = new HashMap<String, String>();
			clientInfo.put("msgtype", "c");
			clientInfo.put("msgid", clientMemberId);
			clientInfo.put("msgcomm", "접속 했습니다.");
			
			session.sendMessage( new TextMessage( gson.toJson(clientInfo) ) ); // 
		}
		
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("채팅 메세지 전송");
		
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginMemberId = (String)sessionAttrs.get("loginMemberId");
		System.out.println("보내는 아이디 : " + loginMemberId);
		
		Gson gson = new Gson();
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "m");
		msgInfo.put("msgid", loginMemberId);
		msgInfo.put("msgcomm", message.getPayload());
		
		
		for(WebSocketSession client : clientList) {
			if(!client.getId().equals(session.getId()) ){
				client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
			}
			
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("채팅 페이지 접속해제");
		clientList.remove(session);
		
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginMemberId = (String)sessionAttrs.get("loginMemberId");
		
		Gson gson = new Gson();
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "d");
		msgInfo.put("msgid", loginMemberId);
		msgInfo.put("msgcomm", "접속을 해제 했습니다.");
		for(WebSocketSession client : clientList) {
			client.sendMessage( new TextMessage( gson.toJson (msgInfo) ) );
			
		}
		
		
		
	}
	
	
	
	
}
