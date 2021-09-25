package com.mkw.a.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mkw.a.domain.MemberVo;
import com.mkw.a.service.BoardService;
import com.mkw.a.service.MemberService;
import com.mkw.a.util.PdsUtil;

/*
 * 비즈니스 로직들 다 서비스로 이주시켜야함 
 */
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
		
		String patter2 = "yyyyMMddHHmmss";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(patter2);
		String yymmddhhmmss = simpleDateFormat.format(new Date());
		logger.debug("현재시간 >>> " + yymmddhhmmss);
		
		String dirStr = "D:/Temp/MemberLog";
		
		File loggerfile = new File(dirStr+ "/" + yymmddhhmmss +".txt");
	    logger.debug("경로 및 파일명 확인 >>> "+ dirStr+ "/" + yymmddhhmmss +".txt");
	    
		FileWriter fw = new FileWriter(loggerfile, true);
		
		
	    fw.write("입력시간 >>> " + yymmddhhmmss + "\r\n");
		
		
		String filename = userPic.getOriginalFilename();
		mem.setFilename(filename);
		
		String fupload = req.getServletContext().getRealPath("/upload");
		
		String newfilename = PdsUtil.getNewFileName(mem.getFilename());
		mem.setNewfilename(newfilename);
		
		File file = new File(fupload + "/" +newfilename);
		fw.write(">>> 업로드 경로 및 파일네임 : " + fupload + "/" +newfilename);
		
		try {
			FileUtils.writeByteArrayToFile(file, userPic.getBytes());
			
			boolean b = memberService.regiAf(mem);
			
			response.setContentType("text/html; charset=euc-kr");
		
			if(b) {
				logger.debug("가입성공");
				login(mem, req, response);
				
			}else {
				logger.debug("가입실패");
				
				PrintWriter pw = response.getWriter();
				pw.println("<script>alert('가입에 실패하였습니다'); "
						+ "location.href='home';</script>");
				pw.flush();
				throw new IOException();
			}
			
		} catch (IOException e) {
			logger.debug("IO익셉션 발생 : 가입에 실패하였거나 다른 익셉션이 발생하였을수 있습니다");
			logger.debug(e.toString());
			
		}catch (Exception e) {
			logger.debug(e.toString());
		}
		finally {
			fw.close();
		}
		
	}
	
	
	
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		logger.debug("::::로그인 페이지로 이동");
		return "member/login";
	}
	
	@RequestMapping(value = "/loginAf", method = RequestMethod.POST)
	public void login(MemberVo mem, HttpServletRequest req
						, HttpServletResponse resp)throws Exception {
		
		resp.setCharacterEncoding("UTF-8"); 
		resp.setContentType("text/html; charset=UTF-8");
		MemberVo login = memberService.login(mem);
		
		
		if(login != null) {
			req.getSession().setAttribute("login", login);
			System.out.println(login.toString());
			
			PrintWriter pw = resp.getWriter();
			

			pw.println("<script>alert('로그인성공'); " +
					"location.href='home';</script>");
			pw.flush();
			
		}else {
			
			System.out.println("로그인실패");
			PrintWriter pw = resp.getWriter();
			pw.println("<script>alert('로그인실패'); " +
					"location.href='home';</script>");
			pw.flush();
			
		}
		
		
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
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public String memberUpdate(HttpSession session, Model model, HttpServletRequest req) {
		
		MemberVo login = (MemberVo)req.getSession().getAttribute("login");
		
		model.addAttribute("isUpdate", "YES");
		model.addAttribute("login", login);
		
		return "member/regi";
	}
	
	@RequestMapping(value = "/updateAf", method = RequestMethod.POST)
	public void updateAf(Model model, MemberVo mem, 
		@RequestParam(value = "userPic", required = false)MultipartFile userPic, 
		HttpServletRequest req, HttpServletResponse response) throws IOException {
		/*
		String pattern = "yyyyMMdd";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		String yymmdd = simpleDateFormat.format(new Date());
		logger.debug("폴더명 >>> " + yymmdd);
		*/
		
		String patter2 = "yyyyMMddHHmmss";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(patter2);
		String yymmddhhmmss = simpleDateFormat.format(new Date());
		logger.debug("현재시간 >>> " + yymmddhhmmss);
		
		String dirStr = "D:/Temp/MemberLog";
		
		File loggerfile = new File(dirStr+ "/" + yymmddhhmmss +".txt");
		logger.debug("경로 및 파일명 확인 >>> "+ dirStr+ "/" + yymmddhhmmss +".txt");
		
		FileWriter fw = new FileWriter(loggerfile, true);
		
		/*
		//경로를 문자열로 받을 수도 있다
		File newFile = new File(dirStr);
		
		if(newFile.mkdir()){   //만드려는 디렉토리가 하나일 경우
		logger.debug(" <<<< 디렉토리를 생성했습니다. >>>> ");
		}else{
		logger.debug(" <<<< 디렉토리를 생성하지 못했습니다. >>>> ");
		}
		*/
		
		fw.write("입력시간 >>> " + yymmddhhmmss + "\r\n");
		
		
		String filename = userPic.getOriginalFilename();
		mem.setFilename(filename);
		
		String fupload = req.getServletContext().getRealPath("/upload");
		
		String newfilename = PdsUtil.getNewFileName(mem.getFilename());
		mem.setNewfilename(newfilename);
		
		File file = new File(fupload + "/" +newfilename);
		fw.write(">>> 업로드 경로 및 파일네임 : " + fupload + "/" +newfilename);
		
		try {
			FileUtils.writeByteArrayToFile(file, userPic.getBytes());
			
			boolean b = memberService.updateMember(mem);
			
			response.setContentType("text/html; charset=euc-kr");
			
			if(b) {
				logger.debug("수정성공");
				PrintWriter pw = response.getWriter();
				pw.println("<script>alert('수정에 성공하였습니다'); "
						+ "location.href='home';</script>");
				pw.flush();
				
			}else {
				logger.debug("가입실패");
				PrintWriter pw = response.getWriter();
				pw.println("<script>alert('수정에 실패하였습니다'); "
						+ "location.href='home';</script>");
				pw.flush();
				throw new IOException();
			}
			
		} catch (IOException e) {
		logger.debug("IO익셉션 발생 : 가입에 실패하였거나 다른 익셉션이 발생하였을수 있습니다");
		logger.debug(e.toString());
		
		}catch (Exception e) {
		logger.debug(e.toString());
		}
		finally {
		fw.close();
		}
		

		
	}
	
	
	@ResponseBody
	@RequestMapping(value="/skTest",method=RequestMethod.POST)  
	public void skTest(@RequestBody ArrayList<HashMap<String, Object>> param, HttpServletResponse response) throws IOException{  
		
		ArrayList<String> resultList = new ArrayList<String>();
		
		System.out.println(param.toString());
		
		//resultList = boardService.skTest(param);
		String var1 =  boardService.skTestReturn(param);
		
		System.out.println("리턴값 확인 : " + var1 + "**************************");
		
		PrintWriter pw = response.getWriter();
		
		pw.println("<script>alert(확인); " +
				"location.href='home';</script>");
		pw.flush();
		
	}
	
	
}
