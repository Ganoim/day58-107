package com.MovieProject.Dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.MovieProject.Dto.Member;

public interface MemberDao {

	Member selectMemberInfo(String id);

	int insertMember_kakao(Member member);

	int insertJoin(Member mem);

	Member selectLogin(@Param("mid")String mid, @Param("mpw")String mpw);

	String selectMemberIdCheck(String inputId);

	Member ViewMyInfoDao(String currentId);

	ArrayList<HashMap<String, String>> selectReserveList(String loginId);

	int deleteCancelReserve(String recode);

}
