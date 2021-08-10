package com.mkw.a.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mkw.a.domain.MemberVo;
import com.mkw.a.service.BoardService;
import com.mkw.a.service.MemberService;
import com.mkw.a.util.PdsUtil;

@Controller
public class maincontroller {
	
	private static final Logger logger = LoggerFactory.getLogger(maincontroller.class);

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
	
	/**
	 * 회원가입 페이지에서 받은 폼데이터를 DB에 넣어주고 성공 여부를 얼럿창으로 
	 * 클라이언트에게 던져주고 메인페이지로 넘어가는 코드 입니다. 
	 * 
	 * @author K
	 * @param MemberVo, userPic 
	 * @exception IOException
	 * 
	 */
	@RequestMapping(value = "/regiAf", method = RequestMethod.POST)
	public void regiAf(Model model, MemberVo mem, 
						@RequestParam(value = "userPic", required = false)MultipartFile userPic, 
						HttpServletRequest req, HttpServletResponse response) throws IOException {
		
		PrintWriter out = response.getWriter();
		String filename = userPic.getOriginalFilename();
		mem.setFilename(filename);
		
		String fupload = req.getServletContext().getRealPath("/upload");
		
		String newfilename = PdsUtil.getNewFileName(mem.getFilename());
		mem.setNewfilename(newfilename);
		
		File file = new File(fupload + "/" +newfilename);
		
		try {
			FileUtils.writeByteArrayToFile(file, userPic.getBytes());
			
			boolean b = memberService.regiAf(mem);
			
			response.setContentType("text/html; charset=euc-kr");
		
			if(b) {
				logger.debug("가입성공");
				
				out.println("<script>alert('가입에 성공하였습니다'); " +
						"location.href='home';</script>");

				out.println("<script>alert('가입에 성공하였습니다'); </script>");
				out.flush();

				
			}else {
				logger.debug("가입실패");
				out.println("<script>alert('가입에 실패하였습니다'); "
						+ "location.href='home';</script>");
				out.flush();
				throw new IOException();
			}
			
		} catch (IOException e) {
			logger.debug("IO익셉션 발생 : 가입에 실패하였거나 다른 익셉션이 발생하였을수 있습니다");
			logger.debug(e.toString());
			
		}catch (Exception e) {
			logger.debug(e.toString());
		}
		
	}
	
	
	
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		logger.debug("::::로그인 페이지로 이동");
		return "member/login";
	}
	
	@RequestMapping(value = "/loginAf", method = RequestMethod.POST)
	public String login(MemberVo mem, HttpServletRequest req
						, HttpServletResponse write)throws Exception {
		
		MemberVo login = memberService.login(mem);
		
		System.out.println(login.toString());
		
		if(login != null) {
			req.getSession().setAttribute("login", login);
			
		}else {
			
			System.out.println("로그인실패");
			
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
	
	@RequestMapping(value = "/imageTest", method = RequestMethod.GET)
	public String imageTest() {
		
		return "testpage/imageTest";
	}
	
	@RequestMapping(value = "/uploadTest", method = RequestMethod.GET)
	public String uploadTest() {
		
		return "testpage/uploadTest";
	}
	
	@RequestMapping(value="/savefile",method=RequestMethod.POST)  
	public ModelAndView upload(@RequestParam CommonsMultipartFile file,HttpSession session){  
	        String path=session.getServletContext().getRealPath("/");  
	        String filename=file.getOriginalFilename();  
	          
	        System.out.println(path+" "+filename);  
	        try{  
	        byte barr[]=file.getBytes();  
	          
	        BufferedOutputStream bout=new BufferedOutputStream(  
	                 new FileOutputStream(path+"/"+filename));  
	        bout.write(barr);  
	        bout.flush();  
	        bout.close();  
	          
	        }catch(Exception e){System.out.println(e);}  
	        return new ModelAndView("/testpage/upload-success","filename",path+"/"+filename);  
	    }  
	
	
}
