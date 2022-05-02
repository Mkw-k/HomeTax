package com.mkw.a.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mkw.a.common.LoginUtils;
import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.domain.MemberVo;
import com.mkw.a.service.MemberService;
import com.mkw.a.service.impl.HomeTaxServiceImpl;

import lombok.RequiredArgsConstructor;

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
	public void createTax(HomeTaxVo home, HttpServletResponse response) throws Exception {
		
		homeTaxService.createTax(home, response);
		
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
	  *
	  * @Method Name : detailTax
	  *<pre>
	  *요금상세 및 납부로 이동
	  *인터셉터 장착 211223 K
	  *</pre>
	  * @작성일 : 2021. 12. 23. 오후 10:46:57
	  * @작성자 : K
	  * @변경이력 : 
	  * @Method 설명 :
	  *
	  * @param home
	  * @param model
	  * @param req
	  * @return HomeTaxVo (해당 월의 월세 디테일 데이터)
	  *
	  */
	@GetMapping(value = "detailTax")
	public String detailTax(HomeTaxVo home, Model model, HttpServletRequest req) {
		System.out.println("이게 아이디:"+home.getMyid());
		System.out.println("이게 날짜:"+home.getDay());
		
		ArrayList<HomeTaxVo> taxVoList = homeTaxService.detailTax(home);
		
		if(taxVoList.isEmpty()) {
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
			model.addAttribute("voList", taxVoList);
		}
		 
//		String redirect = LoginUtils.loginCheck(req);
//		return "redirect:"+redirect;
		
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
	public void inputTax(HomeTaxVo home, HttpServletResponse response, HttpServletRequest req) throws IOException {
		
		logger.debug("tax parameter 확인 >>>>>>>>>>>>>>>");
		logger.debug(home.toString());
		
		response.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=UTF-8");
		//현재 로그인 되어있는 아이디로 반환하기 위한 조건 
		MemberVo login = (MemberVo)req.getSession().getAttribute("login");
		System.out.println(login.toString());
		
		//System.out.println("넘어온 데이터 : "+ home.toString());
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = homeTaxService.inputTax(home);
		
		System.out.println("진행됐음");
		
		//현재 로그인 되어있는(세션존재하는) 아이디로 설정 
		String myid = login.getMyid();
		String day = home.getDay();
		String url = "detailTax?myid="+myid+"&day="+day;
		
		PrintWriter pw = response.getWriter();
		pw.println("<script>alert('"+resultMap.get("resultMsg").toString()+"'); "
				+ "location.href='"+url+"';</script>");
		pw.flush();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "getNoConfirmData", method = RequestMethod.GET)
	public List<HomeTaxVo> getNoConfirmData(){
		
		return homeTaxService.getNoConfirmData();
	}
	
	@ResponseBody 
	@RequestMapping(value = "confirmTaxAf", method = RequestMethod.POST)
	public HashMap<String, Object> confirmTaxAf(@RequestBody HashMap<String, Object> param) throws IOException {
		System.out.println("*******confirmTaxAf 파라미터확인*******");
		System.out.println(param.toString());
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = homeTaxService.confirmTaxAf(param);
		
		return resultMap;
	}
	
	/* get 방식으로 쿼리스트링 받을때 requestparam을 쓰면 해시맵에 데이터를 넣을수 있음 
	@RequestMapping(value = "confirmTaxAf", method = RequestMethod.GET)
	public void confirmTaxAf(@RequestParam HashMap<String, Object> param) throws IOException {
		System.out.println("*******confirmTaxAf 파라미터확인*******");
		System.out.println(param.toString());
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = homeTaxService.confirmTaxAf(param);
	}
	*/
	
	//월세 반려
	@ResponseBody
	@RequestMapping(value = "recallTaxAfter", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public HashMap<String, Object> recallTaxAfter(@RequestBody HashMap<String, Object> param) throws IOException {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = homeTaxService.recallTaxAf(param);
		
		return resultMap;
	}
	

	@RequestMapping(value = "chkTax", method = RequestMethod.GET)
	public String chkTax(HomeTaxVo home, Model model) {
		
		return "HomeTax/chkTax";
	}
	
	@RequestMapping(value = "confirmTax", method = RequestMethod.GET)
	public String confirmTax(@RequestParam HashMap<String, Object> param, Model model) {
		
		logger.debug("아이디 체크 >>>> " + (String)param.get("myid"));
		
		return "HomeTax/confirmTax";
	}
	
	
	@GetMapping(value = "Graph")
	public String taxGraph(HomeTaxVo home, Model model) {
		
		logger.debug("HomeTaxController >>> taxGraph");
		
		/*
		 * ArrayList<HashMap<String, Object>> resultMap = new
		 * ArrayList<HashMap<String,Object>>(); resultMap =
		 * homeTaxService.getMonthTaxListData();
		 * 
		 * model.addAttribute("resultMap", resultMap);
		 */
		return "HomeTax/graphTax";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "chkTaxAf", method = RequestMethod.GET)
	public List<HomeTaxVo> chkTaxAf(HomeTaxVo home, Model model) {
		
		List<HomeTaxVo> list = homeTaxService.chkTax(home);
		
		return list;
	}
	
	@ResponseBody    
	@RequestMapping(value = "getMonthInputListData", method = RequestMethod.POST)
	public List<HashMap<String, Object>> getMonthInputListData(@RequestBody HashMap<String, Object> param) {
		
		System.out.println("*************파라미터 확인");
		System.out.println(param.toString());
		
		List<HashMap<String, Object>> list = homeTaxService.getMonthInputListData(param);
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "inputDues", method = RequestMethod.POST)
	public HashMap<String, Object> inputDues(@RequestBody HashMap<String, Object> param) {
		
		logger.debug("HomeTaxController >>>> inputDues >>>>  param 확인 >>>>" + param);
		
		HashMap<String, Object> result = homeTaxService.inputDues(param);
		
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "getDuesStatus", method = RequestMethod.POST)
	public HashMap<String, Object> getDuesStatus(@RequestBody HashMap<String, Object> param) {
			
		HashMap<String, Object> result = homeTaxService.getDuesStatus(param);
		
		return result;
	}
	
	
	//기존에 HomeTax/Graph로 타고 들어온 페이지에서 getMonthTaxListData로 가면 브라우저 주소는 HomeTax/getMonthTaxListData가 된다 
	@ResponseBody    
	@RequestMapping(value = "getMonthTaxListData", method = RequestMethod.GET)
	public List<HashMap<String, Object>> getMonthTaxListData() {
		
		logger.debug("HomeTaxController >>> getMonthTaxListData");
		
		List<HashMap<String, Object>> resultMapList = homeTaxService.getMonthTaxListData();
		
		return resultMapList;
	}
	
}
