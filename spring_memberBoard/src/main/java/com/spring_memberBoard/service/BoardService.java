package com.spring_memberBoard.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring_memberBoard.dao.BoardDao;
import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.dto.Reply;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao bdao;

	// 글 등록 기능
	public int registBoard(Board board, HttpSession session) throws IllegalStateException, IOException {
		
		System.out.println("SERVICE - registBoard() 호출");
		
		// 업로드된 파일 저장 - 저장경로 설정, 파일명 처리
		MultipartFile bfile = board.getBfile(); // 첨부 파일
		String bfilename = ""; // 파일명 저장할 변수
		String savePath = session.getServletContext().getRealPath("/resources/boardUpload"); // 파일을 저장할 경로
		
		if(!bfile.isEmpty()) { // 첨부파일 확인
			//  첨부파일이 있는 경우
			// !bfile.isEmpty() 파일이 있는 경우 true
			System.out.println("첨부파일 있음");
			
			// 임의의 코드 + img3.jpg
			UUID uuid = UUID.randomUUID();
			String code = uuid.toString();
			System.out.println("code : " + code);
			bfilename = code + "_" + bfile.getOriginalFilename();
			
			// 저장할 경로 resources/boardUpload 폴더에 파일 저장
			System.out.println("savePath" + savePath);
			File newFile = new File(savePath, bfilename);
			bfile.transferTo(newFile);
			
		}
		
		System.out.println("파일이름 : " + bfilename);
		board.setBfilename(bfilename);
		// 제목, 내용, 작성자, 첨부파일명
		System.out.println(board);
		
		// 글번호 생성 (최대값 + 1) - SELECT MAX(BNO) FROM BOARDS
		int bno = bdao.getMaxBno() + 1;
		board.setBno(bno);
		
		// DAO - INSERT INTO BOARDS...
		int insertResult = 0;
		try {
			insertResult = bdao.insertBoard(board);			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		// INSERT 결과 반환
		return insertResult;
	}

	public Board getBoardView(int bno) {
		System.out.println("SERVICE - getBoardView 호출");
		Board board = null;
		
		try {
			// 1. 조회수 증가
			bdao.updatebhits(bno);
			// 2. 글 정보 조회
			board = bdao.selectBoard(bno);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		// 3. 글내용 줄바꿈 문자 >> 태그로 치환
		String bcontents = board.getBcontents();
		bcontents = bcontents.replace("\r\n", "<br>").replace(" ", "&nbsp;");
		board.setBcontents(bcontents);
		
		return board;
	}

	public ArrayList<Board> getBoardList() {
		System.out.println("SERVICE - getBoardList 호출");
		
		/* 글번호가 1번인 글의 댓글 수
		 * SELECT COUNT(*) FROM REPLYS WHERE REBNO = 
		 *  */
		ArrayList<Board> bList = bdao.selectBoardList();
		System.out.println(bList);
		for(Board bo : bList) { // int i = 0; i < bList.size(); i++
//			System.out.println(bo.getBno());
//			System.out.println(bList.get(i).getBno()); 위와 같은거
			int recount = bdao.selectBoardRecound(bo.getBno());
			bo.setRecount(recount);
		}
		System.out.println("recount 추가 이후 bList 출력");
		System.out.println(bList);
		System.out.println();
		
		
//		ArrayList<Board> bList = bdao.selectBoardList();
		return bList;
		
//		return bdao.selectBoardList; 바로 리턴받아도 가능
	}
	
	// 댓글 등록기능
	public int registReply(Reply re) {
		System.out.println("SERVICE - regisReply() 호출");
		//1. 댓글 번호 생성
		int renum = bdao.selectMaxRenum() + 1;
		re.setRenum(renum); // renum 필드에 댓글번호저장
		System.out.println(renum);

		//2. DAO - INSERT문 호출
		int insertResult = 0;
		try {
			insertResult = bdao.insertReply(re);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return insertResult;
	}
	
	//댓글 목록 조회 기능
	public ArrayList<Reply> getReplyList(int rebno) {
		System.out.println("SERVICE - getReplyList() 호출");
//		ArrayList<Reply> rList = bdao.selectReplyList();
		
		/* SELECT * FROM REPLYS WHERE REBNO = #{rebno} */
		return bdao.selectReplyList(rebno);
	}

	public int deleteReply(int renum) {
		System.out.println("SERVICE - deleteReply() 호출");
		
		return bdao.deleteReply(renum);
	}

	public ArrayList<HashMap<String, String>> getBoardList_map() {
		System.out.println("SERVICE - getBoardList_map() 호출");
		
		
		return bdao.selectBoardList_map();
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
