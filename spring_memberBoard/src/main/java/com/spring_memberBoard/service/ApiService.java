package com.spring_memberBoard.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.spring_memberBoard.dto.Bus;

@Service
public class ApiService {
	

	public ArrayList getBusArrive() throws Exception  {
		System.out.println("SERVICE - getBusArrive() 호출");
		 StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/ArvlInfoInqireService/getSttnAcctoArvlPrearngeInfoList"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=fnyC%2Fb4wNr6W9EaP84Tyac4BVyrteRBwti2mUVVQ5hLu%2F9a2YrkUHdCJVQjexkbJed8YUswpg2ZchXc0SB08Hw%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
	        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode("23", "UTF-8")); /*도시코드 [상세기능3 도시코드 목록 조회]에서 조회 가능*/
	        urlBuilder.append("&" + URLEncoder.encode("nodeId","UTF-8") + "=" + URLEncoder.encode("ICB163000063", "UTF-8")); /*정류소ID [국토교통부(TAGO)_버스정류소정보]에서 조회가능*/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
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
	        
	        // 변환
	        JsonObject busInfo_Json = (JsonObject) JsonParser.parseString(sb.toString());
	        
	        JsonArray infoList = busInfo_Json.get("response").getAsJsonObject()
	        					  			 .get("body").getAsJsonObject()
	        					  			 .get("items").getAsJsonObject()
	        					  			 .get("item").getAsJsonArray(); 
	        
	        System.out.println(infoList);
	        System.out.println(infoList.size());
	        
	        ArrayList<Bus> busList = new ArrayList<Bus>();
	        for(int i = 0; i < infoList.size(); i++) {
	        	Bus bus = new Bus();
	        	
	        	String nodenm = infoList.get(i).getAsJsonObject().get("nodenm").getAsString();
	        	bus.setNodenm(nodenm);
	        	
	        	String routeno = infoList.get(i).getAsJsonObject().get("routeno").getAsString();
	        	bus.setRouteno(routeno);
	        	
	        	String arrprevstationcnt = infoList.get(i).getAsJsonObject().get("arrprevstationcnt").getAsString();
	        	bus.setArrprevstationcnt(arrprevstationcnt);
	        	
	        	String arrtime = infoList.get(i).getAsJsonObject().get("arrtime").getAsString();
	        	bus.setArrtime(arrtime);
	        	busList.add(bus);
	        }
	        System.out.println(busList);
	        
//	        JsonArray busInfo_body = busInfo_Json.get("response").getAsJsonObject().get("body").getAsJsonObject();
//	        JsonObject busInfo_Items = busInfo_body.get("items").getAsJsonObject();
//	        System.out.println(busInfo_Items);
//	        JsonObject itemList = busInfo_Items.get("item").getAsJsonArray();
	        
		
		return busList;
	}

	public String getBusArrInfoList(String nodeId, String routeno) throws IOException  {
		System.out.println("SERVICE 버스도착정보_API 호출");
		/* 공공데이터 포털 예제코드 */
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/ArvlInfoInqireService/getSttnAcctoArvlPrearngeInfoList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=fnyC%2Fb4wNr6W9EaP84Tyac4BVyrteRBwti2mUVVQ5hLu%2F9a2YrkUHdCJVQjexkbJed8YUswpg2ZchXc0SB08Hw%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode("23", "UTF-8")); /*도시코드 [상세기능3 도시코드 목록 조회]에서 조회 가능*/
        urlBuilder.append("&" + URLEncoder.encode("nodeId","UTF-8") + "=" + URLEncoder.encode(nodeId, "UTF-8")); /*정류소ID [국토교통부(TAGO)_버스정류소정보]에서 조회가능*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
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
//        System.out.println(sb.toString());
        
        JsonObject arrInfoJson = JsonParser.parseString(sb.toString()).getAsJsonObject();
        
        JsonArray busInfoList = arrInfoJson.get("response").getAsJsonObject()
        								   .get("body").getAsJsonObject()
        								   .get("items").getAsJsonObject()
        								   .get("item").getAsJsonArray();
        
        System.out.println(busInfoList);
        System.out.println(busInfoList.size());
        Gson gson = new Gson();
		String result = gson.toJson(busInfoList);
//		return new Gson().toJson(busInfoList);
		return result;
	}
	
	
	public String getBusSttnLost(String lati, String longti) throws IOException {
		System.out.println("SERVICE 정류소정보_API 호출");
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/BusSttnInfoInqireService/getCrdntPrxmtSttnList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=fnyC%2Fb4wNr6W9EaP84Tyac4BVyrteRBwti2mUVVQ5hLu%2F9a2YrkUHdCJVQjexkbJed8YUswpg2ZchXc0SB08Hw%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
        urlBuilder.append("&" + URLEncoder.encode("gpsLati","UTF-8") + "=" + URLEncoder.encode(lati, "UTF-8")); /*WGS84 위도 좌표*/
        urlBuilder.append("&" + URLEncoder.encode("gpsLong","UTF-8") + "=" + URLEncoder.encode(longti, "UTF-8")); /*WGS84 경도 좌표*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
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
        String result = "";
        Gson gson = new Gson();
		
        JsonObject arrInfoJson = JsonParser.parseString(sb.toString()).getAsJsonObject();
        
        JsonElement busInfoList = arrInfoJson.get("response").getAsJsonObject()
        								   .get("body").getAsJsonObject()
        								   .get("items").getAsJsonObject()
        								   .get("item").getAsJsonArray();
        
        if(busInfoList.isJsonArray()) {
        	result = gson.toJson(busInfoList.getAsJsonArray());
        }else {
        	result = gson.toJson(busInfoList.getAsJsonObject());
        }
        
		return result;
	}
	
	

	public String getBusRouteId(String routeid) throws IOException {
		System.out.println("SERVICE 노선별버스위치_API 호출");
		 StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/BusLcInfoInqireService/getRouteAcctoBusLcList"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=fnyC%2Fb4wNr6W9EaP84Tyac4BVyrteRBwti2mUVVQ5hLu%2F9a2YrkUHdCJVQjexkbJed8YUswpg2ZchXc0SB08Hw%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
	        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode("23", "UTF-8")); /*도시코드 [상세기능3 도시코드 목록 조회]에서 조회 가능*/
	        urlBuilder.append("&" + URLEncoder.encode("routeId","UTF-8") + "=" + URLEncoder.encode(routeid, "UTF-8")); /*노선ID [국토교통부(TAGO)_버스노선정보]에서 조회가능*/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
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
	        
	        Gson gson = new Gson();
			
	        JsonObject nodeJson = JsonParser.parseString(sb.toString()).getAsJsonObject();
	        
	        JsonElement busNodeList = nodeJson.get("response").getAsJsonObject()
	        								    .get("body").getAsJsonObject()
	        								   .get("items").getAsJsonObject()
	        								   .get("item").getAsJsonArray();
	        
	        String result = gson.toJson(busNodeList);
	        
	        System.out.println("result"+result);
	        
	        
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
