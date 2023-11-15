package com.springProeject01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springProeject01.dto.Member;

@Controller
public class MainController {

	@RequestMapping(value = "/")
	public ModelAndView mainPage(Model model) {
		System.out.println("controller - / 요청");
		ModelAndView mav = new ModelAndView();
		//1. 데이터 - SERVICE
		mav.addObject("maindate", "TESTDATE");
//		ArrayList<Board> bList = svc.getBoardList();
//		mav.addObject("이름", 데이터);
		//2. 포워딩 - 페이지 지정
		mav.setViewName("MemberJoin"); // ("페이지 이름") /WEB_INF/views/main.jsp
		return mav;
	}
	
	@RequestMapping(value = "/testPage")
	public ModelAndView testPage(int testnum, 
			@RequestParam(value="teststr") String tstr, String testva,  @RequestParam(value="testval", defaultValue = "TEST") String testval) {
		System.out.println("/testPage 요청");
		System.out.println("testnum : " + testnum);
		System.out.println("tstr : " + tstr);
		System.out.println("testval : " + testval);
		return null;
	}
	
	@RequestMapping(value = "/testJoin")
	public ModelAndView testJoin(Member member) {
		System.out.println("/testJoin 요청");
		ModelAndView mav = new ModelAndView();
//		1. 회원가입 회원정보 파라메터 확인
		System.out.println(member);
//		2. SERVICE 회원가입 기능 호출
//		int joinResult = msvc.memberJoin(member)
//		회원가입 성공 >>  메인페이지로 이동
		mav.setViewName("redirect:/"); // / 요청
		
		return mav;
	}
	
	
	
	
	
}
