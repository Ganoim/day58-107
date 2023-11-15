package com.spring_memberBoard.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring_memberBoard.dto.Member;
import com.spring_memberBoard.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService msvc;
	
	@RequestMapping(value="/memberJoinForm")
	public ModelAndView MemberJoinForm() {
		
		System.out.println("memberJoinForm - 호출");
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("member/MemberJoinForm");
		
		return mav;
	}
	
	@RequestMapping(value="/memberIdCheck")
	public @ResponseBody String memIdCheck(String inputId) {
		
		System.out.println("memberIdCheck - 호출");
		
		System.out.println("inputId : " + inputId);
		

		
		String checkResult = msvc.midCheck(inputId);
		

		
		return checkResult;
	}
	
	@RequestMapping(value="/memberJoin")
	public ModelAndView memberJoin(Member mem, String memailId, String memailDomain,
			RedirectAttributes ra) {
		
		System.out.println("MemberController - /memberJoin 호출");
		
		ModelAndView mav = new ModelAndView();
		
		String memail = memailId + "@" + memailDomain;
		

		mem.setMemail(memail);
		mem.setMstate("1");

		int joinResult = msvc.memJoin(mem);
		
		if(joinResult > 0) {
			/* views/Success.jsp
			 * <script>
			 * alert('${msg}');
			 * location.href="${url}";
			 * </script>
			 */
			mav.addObject("msg","회원가입에 성공 했습니다.");
			
//			mav.setViewName("MainPage");
//			mav.addObject("msg","가입 성공");
//			mav.addObject("url","mainpage");
			
			System.out.println("가입 성공");
			
			mav.setViewName("redirect:/");
			ra.addFlashAttribute("msg","회원가입 되었습니다.");//redirect일 떄만 동작한다. "이름", "이름에 집어 넣어줄 데이터"
		}
		
		else {
			System.out.println("가입 실패");
			mav.setViewName("redirect:/memberJoinForm");
			ra.addFlashAttribute("msg", "회원가입에 실패하였습니다.");

		}
		
		return mav;
	}
	
	/* 1. 로그인 페이지 이동 요청에 대한 처리 /memberLoginForm */
	@RequestMapping(value = "/memberLoginForm")
	public ModelAndView memberLoginForm() {
		
		System.out.println("로그인 페이지 이동 요청");
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("member/MemberLoginForm");
		
		return mav;
	}
	
	/* 2. 로그인 요청에 대한 처리 /memberLogin */
	
	@RequestMapping(value = "/memberLogin")
	public ModelAndView memberLogin(@Param("mid")String mid, @Param("mpw") String mpw, HttpSession session, RedirectAttributes ra) {
		
		System.out.println("로그인 처리 요청 - /memberLogin");
		ModelAndView mav = new ModelAndView();
		
		// 1. 로그인할 아이디, 비밀번호 파라메터 확인
//		System.out.println("입력한 아이디 : " + mid);
//		System.out.println("입력한 비밀번호 : " + mpw);
		
		// 2. SERVICE - 로그인 회원정보 조회 호출
		Member loginMember = msvc.getLoginMemberInfo(mid, mpw);
		
		if(loginMember == null) {
			System.out.println("로그인 실패");
			// '아이디 또는 비밀번호가 일치하지 않습니다.' 출력
			ra.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			// 로그인 페이지로 이동 요청
			mav.setViewName("redirect:/memberLoginForm");
		}
		else {
			System.out.println("로그인 성공");
			session.setAttribute("loginMemberId", loginMember.getMid());
			// '로그인 성공' 출력
			ra.addFlashAttribute("msg", "로그인 성공");
			// 메인 페이지로 이동 요청
			mav.setViewName("redirect:/");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/memberLogout")
	public ModelAndView memberLogout(RedirectAttributes ra, HttpSession session) {
		
		System.out.println("로그아웃 요청");
		
		// session.invalidate(); // 세션 정보를 초기화
		session.removeAttribute("loginMemberId");
		
		ModelAndView mav = new ModelAndView();
		
		ra.addFlashAttribute("msg", "로그아웃 되었습니다.");
		mav.setViewName("redirect:/"); // 메인 페이지 이동 요청
		
		return mav;
	}
	
	
	
	//1. Member 회원정보 select
	//2. member/MyInfo.jsp로 응답
	@RequestMapping(value = "/MyInfo")
	public ModelAndView MyInfo(HttpSession session) {
		System.out.println("회원정보 페이지 요청 - /MyInfo");
		ModelAndView mav = new ModelAndView();
		//1. SERVICE - 회원정보 조회
		// 회원정보를 조회할 아이디 = 세션 loginMemberId
		// SELECT * FROM MEMGER WHEWE MID = ;
		String loginId = (String)session.getAttribute("loginMemberId"); // session으로 현재 로그인되어있는 id가져오기
		System.out.println("회원정보를 조회 할 아이디 : " + loginId);
		Member member = msvc.getMemberInfo(loginId);
		mav.addObject("mInfo", member);
		
		//2. SERVICE 작성한 글(BOARDS) 수 조회
		int bo = msvc.getMemberBoard(loginId);
		mav.addObject("bInfo", bo);
		//3. SERVICE 작성한 글(REPLYS) 수 조회
		int re = msvc.getMemberReply(loginId);
		mav.addObject("rInfo", re);
		
		//4. member/MyInfo.jsp 응답
		mav.setViewName("/member/MyInfo");
		return mav;
	}
		
		
	//1. 내정보 출려
	//2. 정보수정 버튼 클릭 >> 내정보 수정페이지 이동요청(/memberMidufyForm)
	
	@RequestMapping(value = "/memberModifyForm")
	public ModelAndView memberModifyForm(HttpSession session) {
		System.out.println("내정보 수정 페이지 요청 - /memberModifyForm");
		ModelAndView mav = new ModelAndView();
		
		String loginId = (String)session.getAttribute("loginMemberId");
		System.out.println("회원정보를 조회 할 아이디 : " + loginId);
		
		Member member = msvc.getMemberInfo(loginId);
		mav.addObject("mInfo", member);

		mav.setViewName("member/MemberModifyForm");
		return mav;
	}
	
	
	@RequestMapping(value = "/memberModify")
	public ModelAndView memberModify(Member member, RedirectAttributes ra) {
		System.out.println("회원정보 수정 요청 - /memberModify");
		ModelAndView mav = new ModelAndView();
		System.out.println(member);
		/* 
		 * UPDATE MEMBERC
		 * SET MPW = ?, MNAME = ?, MBIRTH = ?, MEMAIL = ?
		 * WHERE MID = ? */
		int updateResult = msvc.modifyMemberInfo(member);
		if(updateResult > 0) {
			System.out.println("회원정보 수정 성공");
			ra.addFlashAttribute("msg", "회원정보가 수정되었습니다");
		} else {
			System.out.println("회원정보 수정 실패");
			ra.addFlashAttribute("msg", "회원정보가 수정을 실패하였습니다");
		}
		mav.setViewName("redirect:/myInfo");
		
		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
