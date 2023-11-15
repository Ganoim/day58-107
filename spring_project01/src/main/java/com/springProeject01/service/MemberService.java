package com.springProeject01.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springProeject01.dao.MemberDao;
import com.springProeject01.dto.Member;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao mdao;

	public int memberJoin_svc(Member member) {
		System.out.println("service - memberJoin_svc() 호출");
		//1. dao - INSERT INTO MEMBERS 
		int insertResult = mdao.insertMember(member);
		
		return insertResult;
	}
	//회원목록 조회 메소드
	public ArrayList<Member> getMemberList() {
		System.out.println("service - getMemberList() 호출");
		ArrayList<Member> mList = mdao.selectMemberList();
		
		return null;
	}
	
	
	
	
	
	
}
