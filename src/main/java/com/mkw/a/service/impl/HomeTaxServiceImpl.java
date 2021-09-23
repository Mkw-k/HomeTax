package com.mkw.a.service.impl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.domain.MemberVo;
import com.mkw.a.mapper.HomeTaxDao;
import com.mkw.a.service.HomeTaxService;
import com.mkw.a.service.MemberService;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class HomeTaxServiceImpl implements HomeTaxService{
	
	
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
		 
		//일반회원의 수 가져오기 
		int nomalLen = memberservice.getnomalLen();
		//할인회원의 수 가져오기
		int discountLen = memberservice.getdiscountLen(); 
		
		//모든 회원정보를 리스트로 가져오기
		List<MemberVo> MemberList = memberservice.getMemberList();
		
		try {
		
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
					
					b = hometaxdao.createTax(resultTax);
					
					if(b) {
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
			//e.printStackTrace();
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
	
	
	
	//CRUD
	

	
	
	
	
	
	
	
	
	//R 월세 납부내역 불러오기
	
	
}
