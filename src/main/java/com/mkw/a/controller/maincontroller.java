package com.mkw.a.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mkw.a.domain.MemberVo;
import com.mkw.a.service.BoardService;
import com.mkw.a.service.MemberService;

@Controller
public class maincontroller {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("test")
	public String test(Model model) {
		model.addAttribute("viewAll", boardService.viewAll());
		return "board/test";
	}
	
	@RequestMapping(value = "/regiMember", method = RequestMethod.GET)
	public String regiMember() {
		
		return "member/regi";
	}
	
	@RequestMapping(value = "/regiAf", method = RequestMethod.POST)
	public String regiAf(Model model, MemberVo mem) {
		
		boolean b = memberService.regiAf(mem);
		
		if(b) {
			System.out.println("가입성공");
		}else {
			System.out.println("가입실패");
		}
		
		return "redirect:/home";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		
		return "member/login";
	}
	
	@RequestMapping(value = "/loginAf", method = RequestMethod.POST)
	public String login(MemberVo mem, HttpServletRequest req
						, HttpServletResponse write)throws Exception {
		
		MemberVo login = memberService.login(mem);
		
		if(login != null) {
			req.getSession().setAttribute("login", login);
			/*
			 * write.setContentType("text/html; charset=UTF-8"); PrintWriter out_write =
			 * write.getWriter(); out_write.println("<script>alert('로그인성공');</script>");
			 * out_write.flush();
			 */
		}else {
			System.out.println("로그인실패");
			/*
			 * write.setContentType("text/html; charset=UTF-8"); PrintWriter out_write =
			 * write.getWriter(); out_write.println("<script>alert('로그인실패');</script>");
			 * out_write.flush();
			 */
		}
		
		return "redirect:/home";
	}
	
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		
		return "redirect:/home";
	}
	
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage(HttpSession session) {
		
		return "member/mypage";
	}

	
	
}
