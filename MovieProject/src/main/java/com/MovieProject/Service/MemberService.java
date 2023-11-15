package com.MovieProject.Service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.MovieProject.Dao.MemberDao;
import com.MovieProject.Dao.MovieDao;
import com.MovieProject.Dto.Member;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao memdao;

	public Member getLoginMemberInfo_kakao(String id) {
		System.out.println("SERVICE - getLoginMemberInfo_kakao() 호출");
		
		return memdao.selectMemberInfo(id);
	}

	public int regisMember_kakao(Member member) {
		System.out.println("SERVICE - regisMember_kakao() 호출");
		
		return memdao.insertMember_kakao(member);
	}

	public int regisMember(Member mem, HttpSession session) throws IOException {
		System.out.println("SERVICE - regisMember() 호출");
		
		
		MultipartFile mfile = mem.getMfile(); // 첨부 파일
		String mprofile = ""; // 파일명 저장할 변수
		String savePath = session.getServletContext().getRealPath("/resources/users/mprofile"); // 파일을 저장할 경로
		
		if(!mfile.isEmpty()) { // 첨부파일 확인
			//  첨부파일이 있는 경우
			// !bfile.isEmpty() 파일이 있는 경우 true
			System.out.println("첨부파일 있음");
			
			// 임의의 코드 + img3.jpg
			UUID uuid = UUID.randomUUID();
			String code = uuid.toString();
			System.out.println("code : " + code);
			mprofile = code + "_" + mfile.getOriginalFilename();
			
			// 저장할 경로 resources/mprofile 폴더에 파일 저장
			System.out.println("savePath" + savePath);
			File newFile = new File(savePath, mprofile);
			mfile.transferTo(newFile);	
		}
		
		System.out.println("파일이름 : " + mprofile);
		mem.setMprofile(mprofile);
		System.out.println(mem);
		
		int resultJoin = memdao.insertJoin(mem);
		
		return resultJoin;
	}

	public Member regusLogin(String mid, String mpw) {
		System.out.println("SERVICE - regusLogin() 호출");
		
		Member member = new Member();
		
		member = memdao.selectLogin(mid, mpw);
		
		return member;
	}

	public String memberIdCheck(String inputId) {
		System.out.println("SERVICE - memberIdCheck() 호출");
//		String result = memdao.selectMemberIdCheck(inputId);
//		if(result == null) {
//			return "Y";
//		} else {
//			return "N";
//		}
//		
		return memdao.selectMemberIdCheck(inputId);
	}

	public Member ViewMyInfo(String currentId) {
		System.out.println("SERVICE - 내 정보 조회 서비스");
		Member ViewMyInfoDao = memdao.ViewMyInfoDao(currentId);
		return ViewMyInfoDao;
	}

	public ArrayList<HashMap<String, String>> getReserveList(String loginId) {

		
		return memdao.selectReserveList(loginId);
	}

	public int CancelReserve(String recode, String loginId) {
		System.out.println("SERVICE - 예매 취소 서비스");
		
		int result = memdao.deleteCancelReserve(recode);
		
		return result;
	}

	
	
	
	
	
}
