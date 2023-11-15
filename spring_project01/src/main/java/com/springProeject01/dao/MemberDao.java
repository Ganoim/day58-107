package com.springProeject01.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.springProeject01.dto.Board;
import com.springProeject01.dto.Member;

public interface MemberDao {
	
	@Insert("INSERT INTO MEMBERSS(MID, MPW, MNAME, MBIRTH, MADDR)"
		  +" VALUES(#{mid}, #{mpw}, #{mname}, #{mbirth}, #{maddr} )")
	int insertMember(Member member);

	@Select("SELECT * FROM MEMBERSS")
	ArrayList<Member> selectMemberList();
	
}
