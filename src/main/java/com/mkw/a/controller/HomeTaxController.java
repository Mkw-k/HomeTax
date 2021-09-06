package com.mkw.a.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.mkw.a.domain.MemberVo;
import com.mkw.a.service.HomeTaxService;
import com.mkw.a.service.MemberService;

@Controller
public class HomeTaxController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeTaxController.class);

	@Autowired
	private HomeTaxService homeTaxService;
	
	@Autowired
	private MemberService memberservice;
	
	
	@RequestMapping(value = "toCreateTax", method = RequestMethod.GET)
	public String toCreateTax() {
		return "HomeTax/createtax";
	}
	
	@RequestMapping(value = "createTax", method = RequestMethod.POST)
	public String createTax(HomeTaxVo home) {
		
		boolean b = homeTaxService.createTax(home);
		
		return "redirect:/home";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "getTaxListData", method = RequestMethod.GET)
	public List<HomeTaxVo> toCreateTax(String day) {
		
		List<HomeTaxVo> list = homeTaxService.getAllTaxList(day);
		
		return list;
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
		
		HomeTaxVo vo = homeTaxService.detailTax(home);
		
		model.addAttribute("vo", vo);
		
		return "HomeTax/detailTax";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "detailData", method = RequestMethod.GET)
	public HomeTaxVo detailData(HomeTaxVo home, Model model) {
		
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
