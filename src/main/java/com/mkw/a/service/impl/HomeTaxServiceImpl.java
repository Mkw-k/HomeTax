package com.mkw.a.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.domain.MemberVo;
import com.mkw.a.mapper.HomeTaxDao;
import com.mkw.a.service.HomeTaxService;
import com.mkw.a.service.MemberService;

@Service
public class HomeTaxServiceImpl implements HomeTaxService{

	@Autowired
	private HomeTaxDao hometaxdao;
	
	@Autowired
	private MemberService memberservice;

	//C 월세 등록
	@Override
	public boolean createTax(HomeTaxVo home) {
		
		boolean b = false;
		
		int nomalLen = memberservice.getnomalLen();
		int discountLen = memberservice.getdiscountLen(); 
		
		List<MemberVo> MemberList = memberservice.getMemberList();
		
		String getDay = home.getDay();
		int water = home.getWater()/(nomalLen+discountLen);
		int elec = home.getElec()/(nomalLen+discountLen);
		int gas = home.getGas()/(nomalLen+discountLen);
		int managerfee = home.getManagerfee()/(nomalLen+discountLen);
		
		
		
		for (MemberVo memberVo : MemberList) {
			
			if(memberVo.getAuth() != 3 && memberVo.getAuth() != 9) {
			
				HomeTaxVo tax = new HomeTaxVo();
				
				tax.setMyid(memberVo.getMyid());
				tax.setDay(getDay);
				tax.setWater(water);
				tax.setElec(elec);
				tax.setGas(gas);
				tax.setManagerfee(managerfee);
				
				int interfee = 0;
				int monthfee = 0;
				
				if(Integer.parseInt(memberVo.getIssale()) == 0) {
					interfee = home.getInter()/nomalLen;
					tax.setInter(interfee);
					monthfee = (home.getMonthfee()/(nomalLen+discountLen))+10000;
					tax.setMonthfee(monthfee);
				}else {
					tax.setInter(interfee);
					monthfee = (home.getMonthfee()/(nomalLen+discountLen))-(10000*nomalLen);
					tax.setMonthfee(monthfee);
				}
				
				int totalfee = water + elec + gas + managerfee + interfee + monthfee;
				tax.setTotalfee(totalfee);
				tax.setRestfee(totalfee);
				
				b = hometaxdao.createTax(tax);
				
				if(b) {
					System.out.println(memberVo.getName()+"님의 월세정보 등록성공");
				}else {
					System.out.println(memberVo.getName()+"님의 월세정보 등록실패");
				}
				
			}
		}
		
		return b;
		
	}
	
	//R 전체 월세 내역 불러오기
	@Override
	public List<HomeTaxVo> getAllTaxList(String day) {
		return hometaxdao.getAllTaxList(day);
	}
	
	//R 개인 월세 내역 불러오기
	@Override
	public HomeTaxVo detailTax(HomeTaxVo home) {
		return hometaxdao.detailTax(home);
	}

	//U 월세 납부 
	@Override
	public boolean inputTax(HomeTaxVo home) {
		System.out.println("여기까지오다니");
		
		boolean b = false;
		
		boolean b1 = hometaxdao.inputTax(home);
		
		int seq = home.getSEQ();
		int overfee = home.getOVERFEE();
		
		System.out.println("데이터 확인 : " + seq + "//" + overfee);
		
		boolean b2 = insertTableInput(home);
		
		if(b1 && b2) {
			b = true;
		}
		
		return b;
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
	
	
	@Override
	public boolean insertTableInput(HomeTaxVo home) {
		return hometaxdao.insertTableInput(home);
	}
	
	
	
	//CRUD
	

	
	
	
	
	
	
	
	
	//R 월세 납부내역 불러오기
	
	
}
