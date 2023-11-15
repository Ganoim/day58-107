package com.springProeject01.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springProeject01.dto.Board;
import com.springProeject01.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService bsvc;
	
	@RequestMapping(value = "/boardWriteForm")
	public ModelAndView boardWriteForm() {
		System.out.println("/boardWriteForm 요청 - 글작성 페이지");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/boardWriteForm"); //  /WEB-INF/views/boardWriteForm - 포워딩 해줄 페이지 설정
		
		return mav;
	}
	
	@RequestMapping(value = "/boardWrite")
	public ModelAndView boardWrite(Board board) { /* 글등록을 눌렀을때 가져올데이터  */
		System.out.println("/boardWrite 요청");
		System.out.println("글 등록 요청");
		//1. 파라메터 확인
		System.out.println(board);
		//2. SERVICE 호출 - 글 등록 메소드 호출
		int writeResult = bsvc.boardWrite_svc(board);
		System.out.println("writeResult : " + writeResult);
		
		
		return null;
	}
	
	
	

}
