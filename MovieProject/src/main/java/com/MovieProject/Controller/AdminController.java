package com.MovieProject.Controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.MovieProject.Service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adsvc;
	
	@RequestMapping(value="/getCgvMovieInfo")
	public ModelAndView getCgvMovieInfo() throws IOException {
		System.out.println("영화정보 수집요청 - /getCgvMovieInfo");
		// 추가된 영화 개수
		int addCount = adsvc.addCgvMovies();
		System.out.println("추가 : " + addCount);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}
	
	@RequestMapping(value="/getCgvTheaterInfo")
	public ModelAndView getCgvTheaterInfo() {
		System.out.println("CGV 극장 정보 수집 요청 - /getCgvTheaterInfo");
		
		int addConut = adsvc.getCgvTheaters();
		System.out.println("추가 : " + addConut);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}
	
	@RequestMapping(value="/getCgvScheduleInfo")
	public ModelAndView getCgvScheduleInfo() {
		System.out.println("CGV 상영 스케줄 수집 요청 - /getCgvScheduleInfo");
		
		int addConut = adsvc.addCgvSchedule();
		System.out.println("추가 : " + addConut);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		
		return mav;
	}
	
	@RequestMapping(value="/mapperTest")
	public String mapperTest(String thcode) {
		System.out.println("선택한 극장 : " + thcode);
		
		adsvc.mapperTest_Movie(thcode);
		
		
		return "redirect:/";
	}
	
	
	
	
	
	
}
