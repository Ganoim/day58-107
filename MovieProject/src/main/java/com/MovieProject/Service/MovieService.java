package com.MovieProject.Service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MovieProject.Dao.MovieDao;
import com.MovieProject.Dto.Movie;
import com.MovieProject.Dto.Reserve;
import com.MovieProject.Dto.Review;
import com.MovieProject.Dto.Schedule;
import com.MovieProject.Dto.Theater;

@Service
public class MovieService {
	
	@Autowired
	private MovieDao mvdao;

	public ArrayList<Movie> getMovieRank() {
		System.out.println("MovieService - 영화 랭킹목록 조회");
		
		ArrayList<Movie> rankMovList = mvdao.selectMovieRank();
		System.out.println("rankMovList : " + rankMovList);
		
		int totalCount = 0;
		for(Movie mov : rankMovList) {
			totalCount +=  Integer.parseInt(mov.getRecount()); // totalCount = totalCount + mov.getRecount
			
			String mvGrade = mov.getMvinfo().split(",")[0];
			if(mvGrade.equals("전체관람가")) {
				mvGrade = "All";
			} else if(mvGrade.equals("청소년관람불가")){
				mvGrade = "18";
			} else if(mvGrade.equals("15세이상관람가")){
				mvGrade = "15";
			} else {
				mvGrade = "12";
			}
			
			//System.out.println("mvGrade : " + mvGrade);
			mov.setMvstate(mvGrade);
		}
		
		for(Movie mv : rankMovList) {
			int recount = Integer.parseInt(mv.getRecount());
			double reRate = ((double)recount / totalCount) * 100;
//			System.out.println( Math.round(reRate * 100) / 100.0 );
			
			String recount_str = reRate + "";
			if(recount_str.length() > 5) {
				mv.setRecount( recount_str.substring(0, 4) );				
			} else {
				mv.setRecount(recount_str);	
			}
		}
		
		
		return rankMovList;
	}

	public Movie getDetaiMovie(String mvcode) {
		System.out.println("getMovieView - 영화 상세목록 조회");
		
		Movie movie = mvdao.selectDetaiMovie(mvcode);
		System.out.println("movie : " + movie);
		
		return movie;
//		return mvdao.selectDetaiMovie(mvcode);
	}

	public ArrayList<Movie> getMovieList(String selMvcode) { //String selMvcode
		System.out.println("getMovieList - 영화 전체목록 조회");
		ArrayList<Movie> movieList = mvdao.selectMovieList(selMvcode);
		
		for(Movie mov : movieList) {
			String movGrade = mov.getMvinfo().split(",")[0];
			// split - 0[15세이상관람가] 1[130분] 2[한국]
			movGrade = movGrade.substring(0, 2);
			if(movGrade.equals("전체")) { // subString 안쓰면 - 전체관람가, 청소년관람불가, 15세이상관람가
				movGrade = "All";
			} else if(movGrade.equals("청소")){
				movGrade = "18";
			} else if(movGrade.equals("15")){
				movGrade = "15";
			} else {
				movGrade = "12";
			}
			
			//System.out.println("movGrade : " + movGrade);
			mov.setMvstate(movGrade); // split로 분류한 정보를 state에 넣어줌
			
		}
		
		
		return movieList;
	}

//	public ArrayList<Movie> getMovList() {
//		System.out.println("getMovieList - 영화 전체목록 조회");
//		ArrayList<Movie> movieList = mvdao.selectMovieList();
//		
//		return movieList;
//	} 

	public ArrayList<Theater> getTheaterList(String selMvcode) {
		System.out.println("SERVICE - getTheaterList()");
		
		return mvdao.selectTheaterList(selMvcode);
	}

	public ArrayList<Movie> getMovieList_json(String selThCode) {
		System.out.println("SERVICE - getMovieList_json()");
		
		return mvdao.selectMovieList_json(selThCode);
	}

	public ArrayList<Schedule> getSchduleDateList_json(String mvcode, String thcode) {
		System.out.println("SERVICE - getSchduleDateList_json()");
		
		return mvdao.selectSchduleDateList_json(mvcode, thcode);
	}

//	public ArrayList<Schedule> getScTimeList_json(String mvcode, String thcode, String scdate) {
//		System.out.println("SERVICE - getSchduleDateList_json()");
//		
//		return mvdao.selectScTimeList_json(mvcode, thcode, scdate);
//	}

	public ArrayList<Schedule> getScTimeList_json(Schedule sc) {
		System.out.println("SERVICE - getSchduleDateList_json()");
		
		return mvdao.selectScTimeList_json(sc);
	}
	
	@Autowired
	private AdminService adminsvc;
	
	public String registReserveInfo(Reserve reinfo) {
		
		//1. 예매코드 생성('RE00001')
		String maxReCode = mvdao.selectMaxReCode();
		System.out.println("maxReCode : " + maxReCode);

		String recode = adminsvc.genCode(maxReCode);			
		
		reinfo.setRecode(recode);
		System.out.println(reinfo);
		
		//2. DAO - INSERT
		
		int insertResult = mvdao.insertRecode(reinfo);
		
		if(insertResult > 0) {
			return recode;
		} else {
			return null;
		}
		
	}

	public int registReview(Review review) {
		System.out.println("SERVICE - registReview()");
		//1. 리뷰코드 생성
		String maxRvcode = mvdao.selectMaxRvcode();
		System.out.println("maxRvcode : " + maxRvcode);
		
		String rvcode = adminsvc.genCode(maxRvcode);
		System.out.println("rvcode : " + rvcode);
		review.setRvcode(rvcode);
		
		int insertResult = 0;
		try {
			insertResult = mvdao.insertReview(review);
		} catch(Exception e) {
			e.printStackTrace();
		}
				
		return insertResult;
	}

	public ArrayList<HashMap<String, String>> getMovieReviewList(String mvcode) {
		System.out.println("SERVICE - getMovieReviewList()");
		
		
		
		return mvdao.selectMovieReviewList(mvcode);
	}
	
	

	



	
	
	
	
	
	
	
	
	
	
	
}
