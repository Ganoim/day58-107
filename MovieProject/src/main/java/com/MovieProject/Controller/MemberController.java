package com.MovieProject.Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.MovieProject.Dao.MovieDao;
import com.MovieProject.Dto.Member;
import com.MovieProject.Service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memsvc;
	
	@RequestMapping(value="/memberLoginForm")
	public ModelAndView memberLoginForm() {
		System.out.println("로그인페이지 이동요청 - /memberLoginForm");
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("member/memberLoginForm");
		
		return mav;
	}
	
	@RequestMapping(value="/memberLogin_kakao")
	public @ResponseBody String memberLogin_kakao(String id, HttpSession session) {
		System.out.println("카카오 로그인 요청");
		System.out.println("카카오 id : " + id);
		// Member, MemberService, MemberDao
		Member loginMember = memsvc.getLoginMemberInfo_kakao(id);
		
		if(loginMember == null) {
			System.out.println("카카오 계정 정보 없음");
			return "N";
		} else {
			System.out.println("카카오 계정 정보 있음");
			System.out.println("로그인 처리");
			session.setAttribute("loginId", loginMember.getMid());
			session.setAttribute("loginName", loginMember.getMname());
			session.setAttribute("loginProfile", loginMember.getMprofile());
			session.setAttribute("loginState", loginMember.getMstate());
			return "Y";
		}
		
	}
	
	@RequestMapping(value = "/memberJoin_kakao")
	public @ResponseBody String memberJoin_kakao(Member member){
		System.out.println("카카오 계정 - 회원가입요청 - /memberJoin_kakao");
		System.out.println(member);
		
		int result = memsvc.regisMember_kakao(member);
		
		return result+"";
	}
	
	@RequestMapping(value="/memberJoinForm")
	public ModelAndView memberJoinForm() {
		System.out.println("회원가입 페이지 이동요청 - /memberJoinForm");
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("member/memberJoinForm");
		
		return mav;
	}
	
	@RequestMapping(value="/memberJoin")
	public ModelAndView memberJoin(Member mem, String memailId, String memailDomain, HttpSession session, RedirectAttributes ra) throws IOException {
		System.out.println("회원가입 요청 - /memberJoin");
		ModelAndView mav = new ModelAndView();
		
		String memail = memailId + "@" + memailDomain;
		mem.setMemail(memail);

		System.out.println("member : " + mem);	
		
		int joinResult = 0;
		try {
			joinResult = memsvc.regisMember(mem, session);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 
		if(joinResult > 0) {
			//mav.addObject("msg","회원가입에 성공 했습니다.");
			System.out.println("가입 성공");
			mav.setViewName("redirect:/");
			ra.addFlashAttribute("msg","회원가입 되었습니다.");//redirect일 떄만 동작한다. "이름", "이름에 집어 넣어줄 데이터"
		} else {
			System.out.println("가입 실패");
			mav.setViewName("redirect:/memberJoinForm");
			ra.addFlashAttribute("msg", "회원가입에 실패하였습니다.");
		}
		return mav;	
	}
	
	@RequestMapping(value="/memberLogin")
	public ModelAndView memberLogin(String mid, String mpw, HttpSession session, RedirectAttributes ra){
		System.out.println("로그인 요청 - /ModelAndView() ");
		ModelAndView mav = new ModelAndView();
		
		System.out.println("아이디/비밀번호 : "+mid+"/"+mpw);
		
		Member memLogin = memsvc.regusLogin(mid, mpw);
		
		if(memLogin == null) {
			System.out.println("로그인 실패");
			ra.addFlashAttribute("msg", "아이디/비밀번호다 일치하지않습니다.");
			mav.setViewName("redirect:/memberLoginForm");
		} else {
			String mstate = memLogin.getMstate().substring(0,1);
			System.out.println(mstate); // YK YC NK NC
			System.out.println(mstate.equals("Y"));
			System.out.println(mstate.equals("N"));
			
			//session.setAttribute("memLogin", memLogin);	
			session.setAttribute("loginId", memLogin.getMid());
			session.setAttribute("loginName", memLogin.getMname());
			session.setAttribute("loginProfile", memLogin.getMprofile());
			session.setAttribute("loginState", memLogin.getMstate());
			
			System.out.println(memLogin);
			
			System.out.println("로그인 성공");
			ra.addFlashAttribute("msg", "로그인 되었습니다.");
			mav.setViewName("redirect:/");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/memberLogout")
	public String memberLogout(HttpSession session, RedirectAttributes ra) {
		session.invalidate();
		ra.addFlashAttribute("msg", "로그아웃 되었습니다.");
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/memberIdCheck")
	public @ResponseBody String memberIdCheck(String inputId) {
		System.out.println("아아디 중복 화인 요청 - /memberIdCheck");
		System.out.println("중복확인할 아이디 : " + inputId);
		
		return memsvc.memberIdCheck(inputId);
	}
	
	@RequestMapping(value="/ReserveList")
	public ModelAndView ReserveList(HttpSession session, RedirectAttributes ra) {
		System.out.println("예매 내역 페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		
		//예매 목록 조회 (영화제목, 극장, 상영관, 상영시간)
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) {
			ra.addFlashAttribute("msg", "로그인 후 이용가능 합니다.");
			mav.setViewName("redirect:/");
			return mav;
		}
		
		ArrayList<HashMap<String,String> > reserveList = memsvc.getReserveList(loginId);
		System.out.println("예매 정보 조회 : "+reserveList);
		mav.addObject("reList",reserveList);
		
		mav.setViewName("member/ReserveList");
		
		return mav;
	}
	
	@RequestMapping(value="/cancelReserve")
	public ModelAndView cancelReserve(String recode, HttpSession session, RedirectAttributes ra) {
		System.out.println("예매 취소 요청 - /cancelReserve");
		System.out.println("취소할 예매코드 : " + recode);
		ModelAndView mav = new ModelAndView();
		
		String loginId = (String)session.getAttribute("loginId");
		
		int cancelResult = memsvc.CancelReserve(recode, loginId);
		if(cancelResult > 0) {
			System.out.println("예매 취소 완료");
			ra.addFlashAttribute("msg", "예매가 취소되었습니다.");
		} else {
			System.out.println("예매 취소 실패");
			ra.addFlashAttribute("msg", "예매 취소를 실패 하였습니다.");
		}
		mav.setViewName("redirect:/ReserveList");
		
		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
