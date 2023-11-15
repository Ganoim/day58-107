package com.MovieProject.Controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.MovieProject.Dto.Movie;
import com.MovieProject.Dto.Reserve;
import com.MovieProject.Dto.Review;
import com.MovieProject.Dto.Schedule;
import com.MovieProject.Dto.Theater;
import com.MovieProject.Service.MovieService;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private MovieService mvsvc;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home() {
		System.out.println("메인 페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		//1. 영화 랭킹 목록 조회
		// SELECT * FROM MOVIES ORDER BY MVOPEN DESC;
		ArrayList<Movie> rankMovList = mvsvc.getMovieRank();
		mav.addObject("rankMovList", rankMovList);
		//2. 이동할 페이지 설정
		mav.setViewName("home");
		
		return mav;
	}
	
	
	
	@RequestMapping(value = "/detailMovie")
	public ModelAndView detailMovie(String mvcode) {
		System.out.println("detailMovie - 영화 상세페이지");
		ModelAndView mav = new ModelAndView();
		//1. 서비스 - 영화정보조회 메소드 호출
		Movie movie = mvsvc.getDetaiMovie(mvcode);
		mav.addObject("movie",movie);
		
		//2. SERVICE - 관람평 목록 조회
		// 관람평 작성자(아이딩 - mid, 프로필 - mprofile)
		// 관람평 내용 - rvcomment, 관람평 작성일 - redate
		ArrayList<HashMap <String, String> > rvList = mvsvc.getMovieReviewList(mvcode);
		System.out.println(rvList);
		
		mav.addObject("rvList", rvList);
		mav.setViewName("movie/detailMovie");
		
		return mav;
	}
	
	@RequestMapping(value="/movieList")
	public ModelAndView movieList() {
		System.out.println("movieList - 영화 목록페이지");
		ModelAndView mav = new ModelAndView();
		
		ArrayList<Movie> movieList = mvsvc.getMovieList("ALL");
		System.out.println(movieList);
		mav.addObject("movieList",movieList);
		mav.setViewName("movie/movieList");
		
		return mav;
	}
	
	@RequestMapping(value="/reserveMovie")
	public ModelAndView reserveMovie() {
		System.out.println("reserveMovie - 영화 예매 페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		// 예매 가능한 영화 목록
		ArrayList<Movie> movList = mvsvc.getMovieList("ALL");
		mav.addObject("movList",movList);
		// 예매 가능한 극장 목록
		ArrayList<Theater> thList = mvsvc.getTheaterList("ALL");
		mav.addObject("thList", thList);
		
		mav.setViewName("movie/ReservePage");
		return mav;
	}
	
//	@RequestMapping(value="/getMovieList_json")
//	public @ResponseBody String getMovieList_json(String selThCode) {
//		System.out.println("예매페이지_영화목록 조회 요청");
//		
//		ArrayList<Movie> movList = mvsvc.getMovieList(selThCode);
//		
//		return new Gson().toJson(movList);
//	}
	

	@RequestMapping(value="/getTheaterList_json")
	public @ResponseBody String getTheaterList_json(String selMvCode) {
		System.out.println("예매페이지_극장목록 조회 요청");
		System.out.println("선택한 영화 코드 : " + selMvCode); // ALL OR "MV00000"
		ArrayList<Theater> thList = mvsvc.getTheaterList(selMvCode);
		//System.out.println(thList);
		//System.out.println(thList.size());
		
		return new Gson().toJson(thList);
	}
	
	@RequestMapping(value="/getMovieList_json")
	public @ResponseBody String getMovieList_json(String selThCode) {
		System.out.println("예매가능한 영화목록 조회 요청");
		System.out.println("선택한 극장 코드 : " + selThCode);
		ArrayList<Movie> mvList = mvsvc.getMovieList_json(selThCode);
		
		return new Gson().toJson(mvList);
	}
	
	@RequestMapping(value="/getSchduleDateList_json")
	public @ResponseBody String getSchduleDateList_json(String mvcode, String thcode) {
		System.out.println("예매가능한 날짜목록 조회 요청");
		System.out.println("선택한 영화코드, 극장코드 :" + mvcode+", "+thcode);
		ArrayList<Schedule> scList = mvsvc.getSchduleDateList_json(mvcode, thcode);
		
		return new Gson().toJson(scList);
	}
	
	@RequestMapping(value="/getTimeList_json")
	public @ResponseBody String getTimeList_json(Schedule sc) { //(String mvcode, String thcode, String scdate)
		System.out.println("예매가능한 상영관 목록 조회 요청");
		System.out.println("선택한 영화코드 : " + sc.getMvcode());
		System.out.println("선택한 영화코드 : " + sc.getThcode());
		System.out.println("선택한 영화코드 : " + sc.getScdate());
		
		ArrayList<Schedule> scTimeList = mvsvc.getScTimeList_json(sc);
		
		return new Gson().toJson(scTimeList);
	}
	
	@RequestMapping(value="/regustReserveInfo")
	public @ResponseBody String regustReserveInfo(Reserve reinfo, HttpSession session) {
		System.out.println("예매 처리 요청");
		System.out.println(reinfo);
		
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) {
			
			return "login";
		} else {
			reinfo.setMid(loginId);
			String registResult = mvsvc.registReserveInfo(reinfo);
			return registResult;			
		}
		
	}
	
	@RequestMapping(value="/reviewWriteForm")
	public ModelAndView reviewWriteForm(String recode) {
		System.out.println("관람평 작성 페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		// 관람한 영화 정보 조회
		
		
		mav.setViewName("/movie/ReviewWriteForm");
		return mav;
	}
	
	@RequestMapping(value="/registReview")
	public ModelAndView registReview(String recode, String rvcomment, HttpSession session, RedirectAttributes re) {
		System.out.println("관람평 등록 요청");
		ModelAndView mav = new ModelAndView();
		
		System.out.println("예매코드 : " + recode);
		System.out.println("관람평 : " + rvcomment);
		
		String mid = (String)session.getAttribute("loginId");
		
		Review rv = new Review();
		
		rv.setMid(mid);
		rv.setRecode(recode);
		rv.setRvcomment(rvcomment);
		int result = mvsvc.registReview(rv);
		
		if(result > 0) {
			System.out.println("관람평 등록 성공");
			re.addFlashAttribute("msg", "관람평이 등록 되었습니다");
			mav.setViewName("redirect:/");
		} else {
			System.out.println("관람평 등록 실패");
			re.addFlashAttribute("msg", "관람평이 등록에 실패하였습니다");
			mav.setViewName("redirect:/reserveList");
		}
		
		
		return mav;
	}
	
	@RequestMapping(value="/getDetaiMovie")
	public ModelAndView getDetaiMovie(String mvcode) {
		System.out.println("영화 상세페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		
		Movie movie = mvsvc.getDetaiMovie(mvcode);
		System.out.println();
		mav.addObject("movie", movie);
		
		//2. SERVICE - 관람평 목록 조회
		// 관람평 작성자(아이딩 - mid, 프로필 - mprofile)
		// 관람평 내용 - rvcomment, 관람평 작성일 - redate
		
		mav.addObject("reviewList", "reviewList");
		
		mav.setViewName("movie/DetailMovie");
		return mav;
	}
	
	
	
	
	
	
	
}
