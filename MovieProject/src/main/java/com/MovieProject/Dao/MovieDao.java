package com.MovieProject.Dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.MovieProject.Dto.Movie;
import com.MovieProject.Dto.Reserve;
import com.MovieProject.Dto.Review;
import com.MovieProject.Dto.Schedule;
import com.MovieProject.Dto.Theater;

public interface MovieDao {
	// 영화 인기 순위 조회
	ArrayList<Movie> selectMovieRank();
	// 영화 상세정보 조회
	Movie selectDetaiMovie(String mvcode);

	ArrayList<Movie> selectMovieList(String selMvcode);
	
	// 영화 목록 조회
	ArrayList<Movie> selectMovieList_json(String selThCode);
//	ArrayList<Movie> selectMovieList_json(String selThCode);
	// 극장 목록 조회
	ArrayList<Theater> selectTheaterList(String selMvcode);
	// 날짜 목록 조회
	ArrayList<Schedule> selectSchduleDateList_json( @Param("mvcode")String mvcode, @Param("thcode")String thcode);
	// 상영관 목록조회
	//ArrayList<Schedule> selectScTimeList_json(@Param("mvcode")String mvcode, @Param("mvcode")String thcode, @Param("scdate")String scdate);
	ArrayList<Schedule> selectScTimeList_json(Schedule sc);
	
	String selectMaxReCode();
	
	
	int insertRecode(Reserve reinfo);
	
	//리뷰코드 최대값
	String selectMaxRvcode();
	//리뷰등록
	int insertReview(Review review);
	ArrayList<HashMap<String, String>> selectMovieReviewList(String mvcode);
	
	


	

	
	
	
	
}
