package com.spring_memberBoard.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.spring_memberBoard.dto.Member;

public interface MemberDao {
	
	// unnotation으로 쿼리문 수행 방법

	@Select("SELECT MID, MPW, MNAME, TO_CHAR(MBIRTH, 'YYYY-MM-DD')AS MBIRTH, MEMAIL, MSTATE FROM MEMBERC WHERE MID = #{inputId }")
	Member selectMemberInfo(String inputId);

	// 파라메터를 2개 이상 사용할 경우 unnotation으로 @param을 붙여 주어야함
	// 파라메터명과 SQL문에 사용할 이름은 같아야 함
	
	// 로그인을 하는 경우
//	@Select("SELECT * FROM MEMBERS WHERE MID = #{MID } AND MPW = #{MPW }")
//	Member selectMemberLogin(@Param("MID") String inputId, @Param("MPW") String inputPw);
	
	
	
	// mapping으로 쿼리문 수행 방법
	Member selectMemberInfo_mapper(@Param("inputId")String inputId);


	// 회원가입_unnotation
//	@Insert("INSERT INTO MEMBERS(MID, MPW, MNAME, MBIRTH, MEMAIL, MSTATE) VALUES(#{mem.mid }, #{mem.mpw }, #{mem.mname }, #{mem.mbirth }, #{mem.memail }, #{mem.mstate })")
//	int joinInsertInfo(Member mem);
	
	
	// 회원가입_mapper
	int joinInsertInfo_mapper(@Param("mem")Member mem);

	// 로그인 기능
	Member selectLogin(@Param("mid")String mid, @Param("mpw")String mpw);
	
	@Update("UPDATE MEMBERC SET MPW = #{mpw}, MNAME = #{mname}, MBIRTH = #{mbirth}, MEMAIL = #{memail} WHERE MID = #{mid} ")
	int updateMemberInfo(Member member);

	@Select("SELECT COUNT(*) FROM BOARDS WHERE BWRITER = #{inputId }")
	int selectMemeberBoard(@Param("inputId") String loginId);

	@Select("SELECT COUNT(*) FROM REPLYS WHERE REMID = #{inputId }")
	int selectMemberReply(@Param("inputId") String loginId);

	
	
	
	
	
	
	
	

}
