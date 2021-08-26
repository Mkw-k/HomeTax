package com.mkw.a.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		
		HomeTaxVo vo = homeTaxService.detailTax(home);
		
		return vo;
	}
	
	
	@RequestMapping(value = "inputTax", method = RequestMethod.GET)
	public String inputTax(HomeTaxVo home, Model model) {
		
		System.out.println("넘어온 데이터 : "+ home.toString());
		
		
		
	    boolean b = homeTaxService.inputTax(home);
		
		System.out.println("진행됐음");
		
		String msg = "";
		if (b) {
			System.out.println("납부성공!");
			msg = "납부성공!";
		} else {
			System.out.println("납부실패!");
			msg = "납부실패!";
		}
		
		String myid = home.getMyid();
		String day = home.getDay();
		
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", "detailTax?myid="+myid+"&day="+day);
		
		return "commons/alert";
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
