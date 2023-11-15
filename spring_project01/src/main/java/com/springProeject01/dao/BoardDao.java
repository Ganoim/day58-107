package com.springProeject01.dao;

import org.springframework.beans.factory.annotation.Autowired;

import com.springProeject01.dto.Board;

public interface BoardDao {

	int insertBoard(Board board);
	
	

}
