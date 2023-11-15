package com.springProeject01.dto;

import lombok.Data;

@Data
public class Board {
	private int bno;
	private String bwriter;
	private String btitle;
	private String bcontents;
	private int bhits;
	private String bstate;

}
