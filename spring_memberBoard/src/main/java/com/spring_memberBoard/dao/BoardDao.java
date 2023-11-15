package com.spring_memberBoard.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.dto.Reply;

public interface BoardDao {

	int getMaxBno();

	int insertBoard(@Param("board") Board board);

	Board selectBoard(@Param("bno") int bno);

	void updatebhits(@Param("bno") int bno);

	@Select("SELECT * FROM BOARDS WHERE BSTATE = '1' ORDER BY BDATE DESC")
	ArrayList<Board> selectBoardList();
	
	@Select("SELECT NVL(MAX (RENUM), 0) FROM REPLYS")
	int selectMaxRenum();
	
	@Insert("INSERT INTO REPLYS(RENUM, REBNO, REMID, RECOMMENT, REDATE, RESTATE)"
			+ " VALUES( #{renum}, #{rebno}, #{remid}, #{recomment}, SYSDATE, '1')")
	int insertReply(Reply re);
	
	@Select("SELECT * FROM REPLYS WHERE REBNO = #{rebno} AND RESTATE = '1' ORDER BY REDATE")
	ArrayList<Reply> selectReplyList(@Param("rebno") int rebno);

	@Update("UPDATE REPLYS SET RESTATE = '0' WHERE RENUM = #{renum}")
	int deleteReply(@Param("renum") int renum);
	
	
	@Select("SELECT COUNT(*) FROM REPLYS WHERE REBNO = #{bno}")
	int selectBoardRecound(@Param("bno") int bno);
	
	
	ArrayList<HashMap<String, String>> selectBoardList_map();
	
	

}
