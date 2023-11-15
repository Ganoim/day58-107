package com.MovieProject.Dto;

import lombok.Data;

@Data
public class Schedule {
	
	private String mvcode;		// 영화코드
	private String thcode;		// 극장코드
	private String schall;		// 상영관
	private String scdate;		// 날짜 및 시간

}
