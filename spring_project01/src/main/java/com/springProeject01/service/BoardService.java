package com.springProeject01.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springProeject01.dao.BoardDao;
import com.springProeject01.dto.Board;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao bdao;

	public int boardWrite_svc(Board board) {
		System.out.println("SERVICE - boardWrite_svc() 호출");
		//DAO - INSERT
		int insertResult = bdao.insertBoard(board);
		
		
		return insertResult;
	}
	
	

}
