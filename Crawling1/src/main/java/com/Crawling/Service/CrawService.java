package com.Crawling.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.PageLoadStrategy;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Service;

@Service
public class CrawService {

	public ArrayList<HashMap<String, String>> getOliveRankItem() throws IOException {
		System.out.println("Service - 올리브영 랭킹 아이템 수집 기능 호출");
		// Jsoup
		//1. https://www.oliveyoung.co.kr/store/main/getBestList.do 접속
		String oliveRankUrl = "https://www.oliveyoung.co.kr/store/main/getBestList.do";
		//2. 랭킹 페이지 문서 리턴 <HTML> ~ <HTML>
		Document oliveRankDoc = Jsoup.connect(oliveRankUrl).get();
//		System.out.println(oliveRankDoc);
		
		//3. 필요한 정보가 있는 부분(태그,요소) 선택<CSS선택자>
		Elements itemsDiv = oliveRankDoc.select("div.TabsConts"); //div선택
		
		Elements items = itemsDiv.get(0).select("ul.cate_prd_list li");//0번 인덱스 지정후 ul태그 중 cate_prd_list 안에 li태그 선택
//		System.out.println(items.get(1));
//		System.out.println(items.size());
		
		
		/*리뷰 수 >> 상세페이지 이동 후 리뷰 조회*/
/*		System.out.println(items.get(1).select("div.prd_info>a").attr("href")); */
		
		
		//4. 데이터를 수집
		/*브랜드명, 상품이름, 상품가격, 상품이미지, 리뷰수 */
		ArrayList<HashMap<String,String>> prdList = new ArrayList<HashMap<String,String>>();
		for(int i=0; i<items.size(); i++) {
		HashMap<String,String> prd_map = new HashMap<String,String>();
		/*상품이미지*/
		String imgUrl = items.get(i).select("div.prd_info>a>img").attr("src");		
		prd_map.put("prdImg", imgUrl);
		System.out.println("상품 이미지 : "+imgUrl);
//		System.out.println(items.get(i).select("div.prd_info>a>img"));
		
		/*브랜드명*/
		String brandName = items.get(i).select("span.tx_brand").text();
		prd_map.put("prdBrand", brandName);
		System.out.println("브랜드명 : "+brandName);
		
		/*상품이름*/
		String prdName=items.get(i).select("p.tx_name").text();
		prd_map.put("prdName", prdName);
//		String[] prdName_split = prdName.split("]"); //이름 분리작업
//		System.out.println(prdName_split.length);
//		System.out.println(prdName_split[0]);
//		System.out.println(prdName_split[1]);
		System.out.println("상품이름 : "+prdName);
		
		/*상품가격*/
		String prdPrice=items.get(i).select("span.tx_cur>span.tx_num").text();
		prd_map.put("prdPrice", prdPrice);
		System.out.println("상품가격 : "+prdPrice);
		
		//상세페이지 URL
		String detailUrl = items.get(i).select("div.prd_info>a").attr("href");
		//상세페이지 Document
		Document detailDoc = Jsoup.connect(detailUrl).get();
		//#repReview > em
		String reviewCount = detailDoc.select("#repReview > em").text();
		reviewCount= reviewCount.replace("(", "").replace(")", "");
		prd_map.put("prdRev", reviewCount);
		System.out.println("리뷰 수 : "+reviewCount);
		prdList.add(prd_map);
		}
		
//		for(Element item : items) {
		
		
		
		//5. DB에 저장
		

		return prdList;
	}

	
	public ArrayList<HashMap<String, String>> getPrdList_11st(String searchText) throws IOException {
		System.out.println("SERVICE - getPrdList_11st");
		ChromeOptions chromeOptions = new ChromeOptions();
	    chromeOptions.setPageLoadStrategy(PageLoadStrategy.NORMAL);
	    chromeOptions.addArguments("headless");
	    
	    WebDriver driver = new ChromeDriver(chromeOptions);
	    String connectUrl = "https://search.11st.co.kr/Search.tmall?kwd="+searchText;
        driver.get(connectUrl);
        List<WebElement> items = driver.findElements(By.cssSelector("section.search_section>ul.c_listing>li>div.c_card"));
        System.out.println("items.size() : " + items.size());
        ArrayList<HashMap<String,String>> prdList_11st = new ArrayList<HashMap<String,String>>();
        
	        for(WebElement item : items) {
	        	HashMap<String, String> prdInfo = new HashMap<String, String>();
	        	prdInfo.put("prdSite", "11st");
	        try {
	        	String prdName = item.findElement(By.cssSelector("div.c_prd_name strong")).getText();
	        	prdInfo.put("prdName", prdName);
	        	
	        	String prdUrl = item.findElement(By.cssSelector("div.c_prd_name>a")).getAttribute("href");
	        	prdInfo.put("prdUrl", prdUrl);
	        	
	        	String prdPrice = item.findElement(By.cssSelector("div.c_prd_price span.value")).getText();
	//        	System.out.println("prdPrice : " + prdPrice);
	        	prdPrice = prdPrice.replace(",", "");
	        	prdInfo.put("prdPrice", prdPrice);
	        	prdList_11st.add(prdInfo);
	        	
	        } catch(Exception e) {
	        	continue;
	        }
        	
        }
		return prdList_11st;
	}


	public ArrayList<HashMap<String, String>> getPrdList_coopang(String searchText) throws IOException {
		System.out.println("SERVICE - getPrdList_coopang()");
		// 접속할 페이지 url
		// https://www.coupang.com/np/search?
		// component=&q=keyboard&channel=user
		
		String connectUrl = "https://www.coupang.com/np/search";
		HashMap<String, String> paramList = new HashMap<String, String>();
		paramList.put("component", "");
		paramList.put("q", searchText);
		paramList.put("channel", "user");
		
		Document targetPage = Jsoup.connect(connectUrl).data(paramList).cookie("auth", "token").get();
		
		Elements items = targetPage.select("li.search-product");
		
//		System.out.println(items);
		System.out.println(items.size());
		// 상품이름, 상품가격, 상세페이지URL 수집
		ArrayList<HashMap<String, String>> prdList_coopang = new ArrayList<HashMap<String, String>>();
		for(Element item : items) {
			HashMap<String, String> prdInfo = new HashMap<String, String>();
			
			String prdName = item.select("div.descriptions-inner>div.name").text();
			prdInfo.put("prdName", prdName);
//			System.out.println("상품이름 : " + prdName);
			
			String prdPrice = item.select("div.descriptions-inner>div.price-area strong.price-value").text();
			prdPrice = prdPrice.replace(",", ""); // 68,700 >> 68700 
			prdInfo.put("prdPrice", prdPrice);
//			System.out.println("상품가격 : " + prdPrice);
			
			String prdUrl = item.select("a").attr("href");
			prdUrl = "https://www.coupang.com" + prdUrl;
			prdInfo.put("prdUrl", prdUrl);
			prdInfo.put("prdSite", "coopang");
//			System.out.println("상세URL : " + prdUrl);
			
			/*
			  ArrayList :: [0]키보드 [1]모니터 [2]마우스 [3]스피커
			  ArrayList.add(2, "그래픽카드")
			  ArrayList :: [0]키보드 [1]모니터 [2]그래픽카드 [3]마우스 [4]스피커
			  
			  25000, 키보드
			  
			  [0]30000,키보드
		   -> [1]25000,키보드
			  [2]10000,키보드
			 */
			// 상품을 가격순 정령 ( 높은 가격 ~ 낮은 가격 ) 순으로 정령
			String sortOption= "PRICE_DESC";
			
			int idx = -1; // prdList_coopang에 추가할 인덱스 번호
			for(int i = 0; i < prdList_coopang.size(); i++) {
				int prdPrice_int = Integer.parseInt(prdPrice);
				int listPrice =  Integer.parseInt(prdList_coopang.get(i).get("prdPrice"));
				
				boolean sortType = false;
				switch(sortOption) {
				case "PRICE_DESC":
					sortType = prdPrice_int > listPrice;
					break;
				case "PRICE_ACS":
					sortType = prdPrice_int < listPrice;
					break;
				}
				if(sortType) {
					idx = i;
					break;
				}
				
				if(prdPrice_int > listPrice) {
					idx = i;
					break;
				}
				
			}
			
			if(idx >  -1) {
				prdList_coopang.add(idx, prdInfo);				
			} else {
				prdList_coopang.add(prdInfo);				
			}
			
			
		}
		
		
		return prdList_coopang;
	}


	public ArrayList<HashMap<String, String>> getPrdList_gmarket(String searchText) throws IOException {
		System.out.println("SERVICE - getPrdList_gmarket()");
		// https://browse.gmarket.co.kr/search?keyword=keyboard
		
		String connectUrl = "https://browse.gmarket.co.kr/search";
		HashMap<String, String> paramList = new HashMap<String, String>();
		paramList.put("keyword", searchText);
		
		Document targetPage = Jsoup.connect(connectUrl).data(paramList).get();
		
		Elements items = targetPage.select("div.box__component-itemcard");
		
//		System.out.println(items.get(0));
//		System.out.println(items.size());
		
		ArrayList<HashMap<String, String>> prdList_gmarket = new ArrayList<HashMap<String, String>>();
		for(Element item : items) {
			HashMap<String, String> prdInfo = new HashMap<String, String>();
			prdInfo.put("prdSite", "gmarket");
			
			String prdName = item.select("div.box__item-container div.box__item-title span.text__item").text();
			prdInfo.put("prdName", prdName);
//			System.out.println("prdName : " + prdName);
			
			String prdPrice = item.select("div.box__item-container div.box__item-price div.box__price-seller strong.text__value").text();
			prdPrice = prdPrice.replace(",", "");
			prdInfo.put("prdPrice", prdPrice);
//			System.out.println("prdPrice : " + prdPrice);
			
			String prdUrl = item.select("div.box__item-container div.box__item-title a.link__item").attr("href");
			prdInfo.put("prdUrl", prdUrl);
//			System.out.println("prdUrl : " + prdUrl);
			
			prdList_gmarket.add(prdInfo);
		}
		
		
		
		
		return prdList_gmarket;
	}

}
