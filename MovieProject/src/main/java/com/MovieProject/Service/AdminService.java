package com.MovieProject.Service;

import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MovieProject.Dao.AdminDao;
import com.MovieProject.Dto.Movie;
import com.MovieProject.Dto.Schedule;
import com.MovieProject.Dto.Theater;

@Service
public class AdminService {

	@Autowired
	private AdminDao adminDao;

	/* addCgvMovies() 시작 */
	public int addCgvMovies() throws IOException {
		System.out.println("AdminService - //addCgvMovies 호출");
		// cgv 영화 정보수집
		// jsoup
		// 무비차트 페이지 접속 >> 영화 상세 페이지 URL 수집
		String movieChartUrl = "http://www.cgv.co.kr/movies/?lt=1&ft=0";
		Document chartDoc = Jsoup.connect(movieChartUrl).get();

		Elements urlItems = chartDoc.select("div.sect-movie-chart>ol>li>div.box-image>a"); // a태그 19개

		ArrayList<Movie> movieList = new ArrayList<Movie>();
		for (Element urlItem : urlItems) {
			Movie movie = new Movie();
			// 영화 상세 페이지 접속 >> 영화 상세 정보 수집
			String detailUrl = "http://www.cgv.co.kr" + urlItem.attr("href");

			Document detailDoc = Jsoup.connect(detailUrl).get();

			String mvtitle = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.title > strong").text();
			System.out.println("제목 : " + mvtitle);
			movie.setMvtitle(mvtitle);

			String mvdirector = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd:nth-child(2)")
					.text();
			mvdirector = mvdirector.replace(", ", ",");
			System.out.println("감독 : " + mvdirector); // dl > dd:nth-child(2) -dl태그 자식 요소 dd태그안에 2번째 요소
			movie.setMvdirector(mvdirector);

			String mvactors = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(0)
					.text();
			mvactors = mvactors.replace(", ", ",");
			System.out.println("배우 : " + mvactors);
			movie.setMvactors(mvactors);

			String mvgenre = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(0)
					.nextElementSibling().text();
			mvgenre = mvgenre.replace("장르 : ", "");
			System.out.println("장르 : " + mvgenre);
			movie.setMvgenre(mvgenre);

			String mvinfo = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(1)
					.text();
			mvinfo = mvinfo.replace(", ", ",");
			System.out.println("정보 : " + mvinfo);
			movie.setMvinfo(mvinfo);

			String mvopen = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(2)
					.text();
			mvopen = mvopen.substring(0, 10);
			System.out.println("개봉 : " + mvopen);
			movie.setMvopen(mvopen);

			String mvposter = detailDoc.select("#select_main > div.sect-base-movie > div.box-image > a > span > img")
					.attr("src");
			System.out.println("포스터 : " + mvposter);
			movie.setMvposter(mvposter);

			System.out.println();

			movieList.add(movie);
		}

		// movieList >> 영화정보 19개 수집

		// DB - MOVIES 테이블 INSERT
		// MOVIES 테이블 MVCODE 촤대값 조회

		String maxMvcode = adminDao.selectMaxMvCode();
		System.out.println("maxMvcode : " + maxMvcode); // MV00000

		int insertCount = 0;
		for (Movie mov : movieList) {
			// 1. 영화코드 생성
			String mvcode = genCode(maxMvcode);
			System.out.println("mvcode : " + mvcode);
			mov.setMvcode(mvcode); // insert하기위해 저장
			System.out.println(mov);
			// 2. MOVIES 테이블 INSERT
			try {
				int insertResult = adminDao.insertMovie(mov);
				insertCount += insertResult; // insertCount = insertCount + insertResult
				maxMvcode = mvcode;
			} catch (Exception e) {
				continue; // 중복 영화 일 경우 다음 반복으로
			}
		}

		return insertCount;

	}
	/* addCgvMovies() 종료 */

	// 코드 생성 매소드
	public String genCode(String currentCode) {
		System.out.println("genCode() 호출 : " + currentCode);
		// currentCode = MV00000 :: 앞2자리 영문, 뒤 5자리 숫자
		String strCode = currentCode.substring(0, 2); // "MV"
		int numCode = Integer.parseInt(currentCode.substring(2));

		String newCode = strCode + String.format("%05d", numCode + 1); //

		return newCode;
	}

	public ArrayList<String> getTheaterUrls() {
		System.out.println("AdminService - getTheaterUrls() 호출 : ");
		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
		options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);
		String cgvTheaterUrl = "http://www.cgv.co.kr/theaters/";
		driver.get(cgvTheaterUrl);
		List<WebElement> theaterElements = driver.findElements(By.cssSelector("div.sect-city>ul>li>div.area>ul>li>a"));

		ArrayList<String> thUrls = new ArrayList<String>();
		for (WebElement theaterElement : theaterElements) {
			thUrls.add(theaterElement.getAttribute("href"));
		}
		driver.quit();
		return thUrls;
	}

	public int getCgvTheaters() {
		System.out.println("AdminService - getCgvTheaters() 호출");
		// 극장 페이지 URl 수집 기능 호출
		ArrayList<String> theaterUrls = getTheaterUrls();
		System.out.println(theaterUrls.size());

		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
		options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);

		ArrayList<Theater> thList = new ArrayList<Theater>();
		for (String url : theaterUrls) {
			driver.get(url);
			try {
				Theater th = new Theater();
				WebElement titleElement = driver
						.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > h4 > span"));
				String thname = titleElement.getText();
				th.setThname(thname);
				System.out.println("극장 : " + thname);

				WebElement addrElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > strong"));
				String thaddr = addrElement.getText();
				thaddr = thaddr.replace("위치/주차 안내 >", "");
				thaddr = thaddr.split("\n")[0];
				th.setThaddr(thaddr);
				/*
				 * 서울특별시 강남구 역삼동 814-6 스타플렉스\n서울특별시 강남구 강남대로 438 (역삼동) [0] \n [1]
				 */

				System.out.println("주소 : " + thaddr);

				WebElement telElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > span.txt-info > em:nth-child(1)"));
				String thtel = telElement.getText();
				th.setThtel(thtel);
				System.out.println("전화번호 : " + thtel);

				WebElement infoElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > span.txt-info > em:nth-child(2)"));
				String thinfo = infoElement.getText();
				th.setThinfo(thinfo);
				System.out.println("정보 : " + thinfo);

				WebElement imgElement = driver.findElement(By.cssSelector("#theater_img_container > img"));
				String thimg = imgElement.getAttribute("src");
				th.setThimg(thimg);
				System.out.println("이미지 : " + thimg);

				System.out.println();
				thList.add(th);

			} catch (Exception e) {
				continue;
			}

		}
		// CGV 극장정보 202개 수집
		System.out.println("thList.size() : " + thList.size());
		// DB - THEATERS 테이블 INSERT
		// THEATER 테이블 THCODE 최대값 조회 >> TH00000
		String maxThcode = adminDao.selectMaxThcode();
		System.out.println("maxThcode : " + maxThcode);

		int insertCount = 0;
		for (Theater theater : thList) {
			String thcode = genCode(maxThcode);
			System.out.println("thcode : " + thcode);
			theater.setThcode(thcode); // insert하기위해 저장
			System.out.println(thcode);

			try {
				int insertResult = adminDao.insertTheater(theater);
				insertCount += insertResult; // insertCount = insertCount + insertResult
				maxThcode = thcode;
			} catch (Exception e) {
				continue; // 중복 영화 일 경우 다음 반복으로
			}

		}
		driver.quit();
		return 0;
	}

	public int addCgvSchedule() {
		System.out.println("AdminService - addCgvSchedule() 호출");
		// 극장 페이지 URL 수집 기능 호출
		ArrayList<String> theaterUrls = getTheaterUrls();

		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
//		options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);
		
		ArrayList<Schedule> ScheduleList = new ArrayList<Schedule>();

		for (String thurl : theaterUrls) { /* 극장 페에지 접속 - for 시작 */
			driver.get(thurl); // SELENIUM - Chrome 극장 페이지로 접속

			try { /* 극장별 스케줄 수집 - try 시작 */
				String thname = driver.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > h4 > span")).getText();
//				System.out.println("극장 : " + thname);
				// SELENIUM - 극장 페이지 내부에 있는 스케줄 프레임으로 변경
				driver.switchTo().frame(driver.findElement(By.id("ifrm_movie_time_table"))); 

				// SELENIUM - 예약 가능 날짜 목록 수집
				List<WebElement> dayList = driver.findElements(By.cssSelector("#slider > div:nth-child(1) > ul > li"));
				for (int i = 1; i < dayList.size(); i++) { /* 날짜별 스케줄 수집 - for 시작 */
					if (i > 0) {
						driver.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on+li")).click();
					}

					/* showtimes : 상영 스케줄표 영화 목록 */
					String mm = driver.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on > div > a > span")).getText();
					mm = mm.replace("월", "");
					String dd = driver.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on > div > a > strong")).getText();
//					System.out.println(mm + dd);

					List<WebElement> showtimes = driver.findElements(By.cssSelector("body > div > div.sect-showtimes > ul > li"));
					for (WebElement showtime : showtimes) { /* 영화 스케줄 수집 - for 시작 */
						//예매 가능한 영화 제목
						String mvtitle = showtime.findElement(By.cssSelector("div > div.info-movie > a > strong")).getText();
						//예매 가능한 상영관 목록
						List<WebElement> type_Halls = showtime.findElements(By.cssSelector("div.col-times>div.type-hall"));
						for(WebElement hall : type_Halls) {
							//예매 가능한 상영관 이름 1관
							String hallName = hall.findElement(By.cssSelector("div.info-hall > ul > li:nth-child(2)")).getText();
//							System.out.println("상영관 : " + hallName);
							List<WebElement> timeList = hall.findElements(By.cssSelector("div.info-timetable > ul > li > a > em"));
							for(WebElement time : timeList) {
								//예매 가능하 시간
								String hallTime = time.getText();
								System.out.println(thname + " : " + mm+dd + " : " + mvtitle + " : " + hallName + " : " + hallTime);
								
								Schedule schedule = new Schedule();
								schedule.setMvcode(mvtitle);	// 오펜하이머
								schedule.setThcode(thname);		// CGV 강남
								schedule.setSchall(hallName);	// 
								schedule.setScdate("2023" + mm + dd + " " + hallTime); //20230824 18:30
								ScheduleList.add(schedule);
								
								
							}
							System.out.println();	
							
						}
						
						
					}/* 영화 스케줄 수집 - for 끝 */
					
				} /* 날짜별 스케줄 수집 - for 종료 */
				
				

			} catch (Exception e) {
				continue;
			} /* 극장별 스케줄 수집 - try 끝 */

		} /* 극장 페에지 접속 - for 종료 */
		
		System.out.println(ScheduleList.size());
		//insert
		int insertCount = 0;
		for(Schedule sc : ScheduleList) {
			try {
				int insertResult = adminDao.insertSchedule(sc);
				insertCount += insertResult;
			} catch (Exception e) {
//				e.printStackTrace();
				continue;
			}
		}
		
		
		driver.quit(); // SELENIUM - Chrome 종료
		return insertCount;
	}
	
	
	
	
	public void mapperTest_Movie(String thcode) {
		System.out.println("service");
		ArrayList<Movie> movList = adminDao.selectMapperTest(thcode);
		System.out.println("극장선택o : "+movList.size());
		
		ArrayList<Movie> movList2 = adminDao.selectMapperTest(null);
		System.out.println("극장선택x : " + movList2.size());
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
}
