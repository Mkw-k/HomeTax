package com.mkw.a.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.service.MemberService;
import com.mkw.a.service.impl.HomeTaxServiceImpl;

@Controller
public class HomeTaxController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeTaxController.class);

	@Autowired
	private HomeTaxServiceImpl homeTaxService;
	
	@Autowired
	private MemberService memberservice;
	
	
	@RequestMapping(value = "toCreateTax", method = RequestMethod.GET)
	public String toCreateTax() {
		return "HomeTax/createtax";
	}
	
	@RequestMapping(value = "createTax", method = RequestMethod.POST)
	public String createTax(HomeTaxVo home) {
		
		boolean b = homeTaxService.createTax(home);
		
		if(b) {
			
		}else {
			
		}
		
		return "redirect:/home";
	}
	
	
	/**
	 * 메인 페이지에 모든 회원 월세 리스트와 토탈 월세 데이터를 월별로 뿌려주는 코드
	 * 
	 * @author K
	 * @param String day 
	 * @return List<HomeTaxVo> list
	 * @exception NullPointerException
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "getTaxListData", method = RequestMethod.GET)
	public List<HomeTaxVo> toCreateTax(String day) {
		
		//utils 클래스에 safe 관련 함수 만들어야함 
		logger.debug("day = " + day);
		
		return homeTaxService.getAllTaxList(day);
	}
	
	

	/**
	 * 요금상세 및 납부로 이동
	 * @author K
	 * @param myid 
	 * @return HomeTaxVo (해당 월의 월세 디테일 데이터) 
	 */
	@RequestMapping(value = "detailTax", method = RequestMethod.GET)
	public String detailTax(HomeTaxVo home, Model model) {
		System.out.println("이게 아이디:"+home.getMyid());
		System.out.println("이게 날짜:"+home.getDay());
		
		ArrayList<HomeTaxVo> voList = homeTaxService.detailTax(home);
		
		if(voList.isEmpty()) {
			// 현재 날짜 구하기 (시스템 시계, 시스템 타임존)
			LocalDate now = LocalDate.now();
			String year = now.getYear() + "";
			String month = now.getMonthValue() + "";
			
			if(month.length() == 1) {
				month = "0" + month;
			}
			ArrayList<HomeTaxVo> createVoList = new ArrayList<HomeTaxVo>();
			String day = year.substring(2, 4) + month;
			HomeTaxVo tax = new HomeTaxVo();
			tax.setDay(day);
			
			createVoList.add(tax);
			model.addAttribute("voList", createVoList);

		}else {
			model.addAttribute("voList", voList);
		}
		
		return "HomeTax/detailTax";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "detailData", method = RequestMethod.GET)
	public ArrayList<HomeTaxVo> detailData(HomeTaxVo home, Model model) {
		
		System.out.println(home.toString());
		
		return homeTaxService.detailTax(home);
	}
	
	
	//별로 안좋은 기술인거 같음 추후 flush로 수정 예정임 
	@RequestMapping(value = "inputTax", method = RequestMethod.GET)
	public void inputTax(HomeTaxVo home, HttpServletResponse response) throws IOException {
		
		//System.out.println("넘어온 데이터 : "+ home.toString());
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = homeTaxService.inputTax(home);
		
		System.out.println("진행됐음");
		
		String myid = home.getMyid();
		String day = home.getDay();
		String url = "detailTax?myid="+myid+"&day="+day;
		
		PrintWriter pw = response.getWriter();
		pw.println("<script>alert('"+resultMap.get("resultMsg").toString()+"'); "
				+ "location.href='"+url+"';</script>");
		pw.flush();
	}
	

	@RequestMapping(value = "chkTax", method = RequestMethod.GET)
	public String chkTax(HomeTaxVo home, Model model) {
		
		return "HomeTax/chkTax";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "chkTaxAf", method = RequestMethod.GET)
	public List<HomeTaxVo> chkTaxAf(HomeTaxVo home, Model model) {
		
		List<HomeTaxVo> list = homeTaxService.chkTax(home);
		
		return list;
	}
	
}
