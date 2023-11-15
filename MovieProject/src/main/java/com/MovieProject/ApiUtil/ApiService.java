package com.MovieProject.ApiUtil;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.MovieProject.Dto.Reserve;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class ApiService {

	public String kakaoPay_ready(Reserve reInfo, HttpSession session) {
		System.out.println("service kakaoPay_ready()");
		String requestUrl = "https://kapi.kakao.com/v1/payment/ready";
		/*
		partner_order_id	가맹점 주문번호, "RE00000" - 임의의 값
		partner_user_id		가맹점 회원 id, "TESTID"
		item_name			상품명, "영화 예매 결제" 
		quantity			상품 수량	1
		total_amount		상품 총액	12000
		tax_free_amount		상품 비과세 금액 O
		approval_url		결제 성공 시 redirect url, "http://localhost:8080/kakaoPay_appoval"
		cancel_url			결제 취소 시 redirect url, "http://localhost:8080/kakaoPay_cancel"
		fail_url			결제 실패 시 redirect url, "http://localhost:8080/kakaoPay_fail"
		*/
		HashMap<String, String> requestParams = new HashMap<String, String>();
		//requestParams.put("partner_order_id", reInfo.getRecode());
		requestParams.put("partner_order_id", "RE00000"); // RE00000 - reInfo.getRecode()
		requestParams.put("partner_user_id", "TESTID");
		//requestParams.put("partner_user_id", (String)session.getAttribute("loginId"));
		requestParams.put("item_name", "영화예매결제");
		requestParams.put("quantity", "1");
		requestParams.put("total_amount", "12000");
		requestParams.put("tax_free_amount", "0");
		requestParams.put("approval_url", "http://localhost:8080/kakaoPay_approval");
		requestParams.put("cancel_url", "http://localhost:8080/kakaoPay_cancel");
		requestParams.put("fail_url", "http://localhost:8080/kakaoPay_fail");
		
		String result = null;
		try {
			String Response = kakaoResponse_json(requestUrl, requestParams);
			/* tid, next_redirect_pc_url */
			JsonObject re = (JsonObject)JsonParser.parseString(Response);
			String tid = re.get("tid").getAsString();
			String nextUrl = re.get("next_redirect_pc_url").getAsString();
			System.out.println("tid : " + tid);
			session.setAttribute("tid", tid);
//			session.setAttribute("recode", reInfo.getRecode());
			System.out.println("next_redirect_pc_url : " + nextUrl);
			
			result = nextUrl;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public String kakaoPay_approval(String tid, String pg_token) {
		System.out.println("service kakaoPay_approval()");
		String requestUrl = "https://kapi.kakao.com/v1/payment/approve";
		HashMap<String, String> requestParams = new HashMap<String, String>();
		requestParams.put("tid", tid);
		requestParams.put("partner_order_id", "RE00000"); // recode
		requestParams.put("partner_user_id", "TESTID"); // loginId
		requestParams.put("pg_token", pg_token);
		
		String result = null;
		try {
			String response = kakaoResponse_json(requestUrl, requestParams);
			result = response;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	

	private String kakaoResponse_json(String requestUrl, HashMap<String, String> requestParams) throws IOException {
		System.out.println("SERVICE - kakaoResponse_json() 호출");
		StringBuilder urlBuilder = new StringBuilder(requestUrl); /*URL*/
	    urlBuilder.append("?" + URLEncoder.encode("cid","UTF-8") + "=TC0ONETIME"); /* 가맹점 코드 */
	    
	    for(String key : requestParams.keySet()) { // keySet - requestParams.put("키", "값")에서 키만가져오는것
	    	urlBuilder.append("&" + URLEncoder.encode(key,"UTF-8") + "=" + URLEncoder.encode(requestParams.get(key), "UTF-8")); /*요청할 파라메터*/
	    	
	    }
	    
	    URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Authorization", "KakaoAK f8018b6a1f50c0dff824c2a0bb97c3db");
		conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		System.out.println("Response code: " + conn.getResponseCode());
		
		if(conn.getResponseCode() != 200) {
			return null;
		}
		
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		System.out.println(sb.toString());
		
		

		return sb.toString();
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
