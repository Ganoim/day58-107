package com.MovieProject.Dao;

import java.util.ArrayList;

import com.MovieProject.Dto.Movie;
import com.MovieProject.Dto.Schedule;
import com.MovieProject.Dto.Theater;

public interface AdminDao {

	String selectMaxMvCode();

	int insertMovie(Movie mov);

	String selectMaxThcode();

	int insertTheater(Theater th);

	int insertSchedule(Schedule sc);

	ArrayList<Movie> selectMapperTest(String selthcode);

	

}
