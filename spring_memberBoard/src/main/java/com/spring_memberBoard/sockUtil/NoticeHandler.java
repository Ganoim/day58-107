package com.spring_memberBoard.sockUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class NoticeHandler extends TextWebSocketHandler {
	
	//접속된 클라이언트 목록
	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 클라이언트가 웹소켓에 접속을 했을 때 실행 - (NoticeSock 에 접속)
		clientList.add(session); // 클라이언트 목록에 추가
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 클라이언트가 웹소켓에 메세지를 전송 했을 때 실행 - (NoticeSock 에 메세지 전송)
		System.out.println(message.getPayload()); // => {"noticeType":"reply","bno":10,"bwriter":"작성자테스트"}
		JsonObject noticeObj = JsonParser.parseString(message.getPayload()).getAsJsonObject();
		
		String noticeType = noticeObj.get("noticeType").getAsString();
		
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", noticeType);
		
		
		// 공지종류 : 새 글 등록 알림(전체), 댓글 등록 알림(개별)
		switch (noticeType) {
		case "reply": // 개별 전송 - bwriter에게 전송 (bwriter == 회원아이디)
			String bno = noticeObj.get("noticeMsg").getAsString();    // noticeType을 String 타입으로 받는다(getAsString)
			String bwriter = noticeObj.get("receiveId").getAsString();
			msgInfo.put("msgcomm", bno);
			
			for(WebSocketSession client : clientList) {
				Map<String, Object> clienAttrs = client.getAttributes();  // session
				String clientMemberId = (String)clienAttrs.get("loginMemberId");
				if( clientMemberId.equals(bwriter) ) {
					client.sendMessage(new TextMessage(new Gson().toJson(msgInfo) ) );
				}
				
			}
			break;
		case "board": // 전체 전송
			// 서버가 접속중인 클라이언트들에게 메세지 전송
			msgInfo.put("msgcomm", "새 글이 등록되었습니다.");
			for (WebSocketSession client: clientList) {
				client.sendMessage(new TextMessage ( new Gson().toJson(msgInfo) ) ); // message.getPayload()
			}
			break;	
		}
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 클라이언트가 웹소켓에서 접속을 해제 했을 때 실행 - (NoticeSock 에 접속해제)
		clientList.remove(session); // 클라이언트 목록에서 제거
	}
	
	

}
