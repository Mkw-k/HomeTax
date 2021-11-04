package com.mkw.a.service.impl;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.junit.platform.commons.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.domain.MemberVo;
import com.mkw.a.mapper.HomeTaxDao;
import com.mkw.a.service.HomeTaxService;
import com.mkw.a.service.MemberService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class HomeTaxServiceImpl implements HomeTaxService{
	
	private static final Logger logger = LoggerFactory.getLogger(HomeTaxServiceImpl.class);
	
	private final DiscountService discountService;
	@Autowired
	private HomeTaxDao hometaxdao;
	@Autowired
	private MemberService memberservice;
	
	public HomeTaxServiceImpl(DiscountService discountService) {
		this.discountService = discountService;
		
	}
	

	//C 월세 등록
	//한개라도 오류가 발생하면 전체 롤백으로 되도록 해야함 
	@Override 
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT, timeout = 10)
	public void createTax(HomeTaxVo homeTax, HttpServletResponse response) throws Exception {
		
		boolean b = false;
		response.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=UTF-8");
		
		//input 타입 month로 들어오는 데이터 가공 
		//2021-09 => 2109
		String day = homeTax.getDay();
		day = day.substring(2,4) + day.substring(5,7);
		homeTax.setDay(day);
		
		logger.debug("데이터확인");
		logger.debug(homeTax.toString());
		 
		//일반회원의 수 가져오기 
		int nomalLen = memberservice.getnomalLen();
		//할인회원의 수 가져오기
		int discountLen = memberservice.getdiscountLen(); 
		
		//모든 회원정보를 리스트로 가져오기
		List<MemberVo> MemberList = memberservice.getMemberList();
		
		try {
			
			boolean b1 = hometaxdao.create_hometax_payment_chk(day);
		
			for (MemberVo memberVo : MemberList) {
				
				if(memberVo.getAuth() != 3 && memberVo.getAuth() != 9) {
			
					HomeTaxVo resultTax = new HomeTaxVo();
							
					//맨앞자리가 소문자가 되는거 주의할것 원래 대문자여도 소문자로 변형됨 fixDiscountService noDiscountService
					if(memberVo.getAuth() == 1 && memberVo.getIssale().equals("1")) {
						resultTax = discountService.discount(memberVo, "fixDiscountService", homeTax, nomalLen, discountLen);
					}
					else if(memberVo.getAuth() == 1 && memberVo.getIssale().equals("0")) {
						resultTax = discountService.discount(memberVo, "noDiscountService", homeTax, nomalLen, discountLen);
					}
					
					//System.out.println(resultTax.toString());
					b = hometaxdao.createTax(resultTax);
					
					
					
					if(b && b1) {
						System.out.println(memberVo.getName()+"님의 월세정보 등록성공");
					}else {
						System.out.println(memberVo.getName()+"님의 월세정보 등록실패");
					}
				
				}
					
			}
			System.out.println("**********************");
			System.out.println("등록 성공 DB 커밋!");
			
			
			PrintWriter pw = response.getWriter();
			pw.println("<script>alert('월세 등록 성공'); "
					+ "location.href='home';</script>");
			pw.flush();
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("**********************");
			System.out.println("예외발생 롤백처리진행!");
			
			
			PrintWriter pw = response.getWriter();
			pw.println("<script>alert('월세 등록 실패'); "
					+ "location.href='home';</script>");
			pw.flush();
		}
		
	}
	
	//R 전체 월세 내역 불러오기
	@Override
	public List<HomeTaxVo> getAllTaxList(String day) {
		
		//개인 월세 데이터 
		List<HomeTaxVo> resultList = hometaxdao.getAllTaxList(day);
		//토탈 월세 데이터 
		HomeTaxVo vo = hometaxdao.getTotalData(day);
		resultList.add(vo);
		
		return resultList;
	}
	
	//R 개인 월세 내역 불러오기
	@Override
	public ArrayList<HomeTaxVo> detailTax(HomeTaxVo home) {
		return hometaxdao.detailTax(home);
	}

	//U 월세 납부 
	//로그 다 찍고 텍스트 파일 생성해야함 
	@Override
	public HashMap<String, Object> inputTax(HomeTaxVo home) {
		System.out.println("여기까지오다니");
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boolean b = false;
		
		boolean b1 = hometaxdao.inputTax(home);
		
		int seq = home.getSEQ();
		int overfee = home.getOVERFEE();
		
		System.out.println("데이터 확인 : " + seq + "//" + overfee);
		
		//납부내역 테이블에 납부 데이터 인서트 
		boolean b2 = insertTableInput(home);
		
		if(b1 && b2) {
			b = true;
		}
		
		if(b) {
			resultMap.put("resultMsg", "납부성공!");
		}else {
			resultMap.put("resultMsg", "납부실패!");
		}
		
		return resultMap;
	}

	//R 전체 합산 데이터 가져오기
	@Override
	public HomeTaxVo getTotalData(String day) {
		return hometaxdao.getTotalData(day);
	}

	@Override
	public List<HomeTaxVo> chkTax(HomeTaxVo home) {
		return hometaxdao.chkTax(home);
	}
	
	
	//납부가 완료 될경우 추가로 납부내역 테이블에 납부데이터 인서트 
	@Override
	public boolean insertTableInput(HomeTaxVo home) {
		return hometaxdao.insertTableInput(home);
	}

	//납부 상세내역에서 해당월을 클릭할 경우 해당월의 모든 납부내역을 레이어팝업창에서 확일할수 있는 기능 
	public List<HashMap<String, Object>> getMonthInputListData(HashMap<String, Object> param) {
		return hometaxdao.getMonthInputListData(param);
	}


	public HashMap<String, Object> inputTempTax(HomeTaxVo home) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boolean b = false;
		
		b = hometaxdao.inputTempTax(home);
		
		if(b) {
			logger.debug("데이터 확인 >>> seq: " + home.getSEQ() + "납부완료");
			resultMap.put("resultMsg", "납부성공!");
		}else {
			logger.debug("데이터 확인 >>> seq: " + home.getSEQ() + "납부실패");
			resultMap.put("resultMsg", "납부실패!");
		}
		
		return resultMap;
	}


	public List<HomeTaxVo> getNoConfirmData() {
		return hometaxdao.getNoConfirmData();
	}


	public HashMap<String, Object> confirmTaxAf(HashMap<String, Object> param) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boolean b  = hometaxdao.confirmTaxAf(param);
		
		boolean b1 = hometaxdao.inputTaxMaster(param);
		
		if(b && b1) {
			resultMap.put("resultMsg", "Y");
		}else {
			resultMap.put("resultMsg", "N");
		}
		
		return resultMap;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public HashMap<String, Object> recallTaxAf(HashMap<String, Object> param) {
		logger.debug("월세 반려 비즈니스 로직 start !!!!!!");
		logger.debug("*******recallTaxAfter 파라미터확인*******");
		logger.debug(param.toString());
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			
			//인서트 테이블에서 DEL = Y로 변경
			boolean b  = hometaxdao.recallTaxAf(param);	
			//홈택스 테이블(temp)에서 업데이트 되었던(인풋되었던) 금액 다시 원상복구
			boolean b2 = hometaxdao.recallTaxAf_step2_updateTempTax(param); 
			
			if(b&&b2) {
				resultMap.put("resultMsg", "Y");
				logger.debug("월세 반려 성공!!!!!");
			}else {
				resultMap.put("resultMsg", "N");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("월세 반려 실패 예외 발생!!!!!");
			resultMap.put("resultMsg", "N");
		}
		
		return resultMap;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT, timeout = 10)
	public HashMap<String, Object> inputDues(HashMap<String, Object> param) {
		logger.debug("HomeTaxServiceImpl >>> inputDues >>> param 확인 >>> " + param);
		
		HashMap<String, Object> dueParam = new HashMap<String, Object>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		String bValue =  StringUtils.nullSafeToString(param.get("bValue").toString());
		String isChecked = StringUtils.nullSafeToString(param.get("isChecked").toString());
		String bday = StringUtils.nullSafeToString(param.get("bday").toString()); 
		
		if(isChecked.equals("true") && isChecked != null && isChecked != "") {
			isChecked = "Y";
		}else {
			isChecked = "N";
		}
		
		logger.debug("bValue >>> " + bValue);
		logger.debug("isChecked >>> " + isChecked);
		logger.debug("bday >>> " + bday);
		
		dueParam.put(bValue, isChecked);
		dueParam.put("bday", bday);
		
		boolean b = hometaxdao.payment_chk_update(dueParam);
		
		if(b) {
			resultMap.put("resultMsg", "Y");
		}else {
			resultMap.put("resultMsg", "N");
		}
		
		return resultMap;
	}

	
	@Override
	public HashMap<String, Object> getDuesStatus(HashMap<String, Object> param) {

		logger.debug("HomeTaxServiceImpl >>> getDuesStatus");
		logger.debug("param >>> " + param);
		
		HashMap<String, Object> resultMap = hometaxdao.getDuesStatus(param);
		
		return resultMap;
	}


	public ArrayList<HashMap<String, Object>> getMonthTaxListData() {

		return hometaxdao.getMonthTaxListData();
	}
	
	
	
	
	
	//CRUD
	

	
	
	
	
	
	
	
	
	//R 월세 납부내역 불러오기
	
	
}
