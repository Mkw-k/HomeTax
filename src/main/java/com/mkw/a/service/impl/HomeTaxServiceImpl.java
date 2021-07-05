package com.mkw.a.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.mapper.HomeTaxMapper;
import com.mkw.a.service.HomeTaxService;

@Service
public class HomeTaxServiceImpl implements HomeTaxService{

	@Autowired
	private HomeTaxMapper mapper;

	//C 월세 등록
	@Override
	public boolean createTax(HomeTaxVo tax) {
		
		return mapper.createTax(tax);
		
	}
	
	//R 전체 월세 내역 불러오기
	@Override
	public List<HomeTaxVo> getAllTaxList(String day) {
		return mapper.getAllTaxList(day);
	}
	
	//R 개인 월세 내역 불러오기
	@Override
	public HomeTaxVo detailTax(HomeTaxVo home) {
		return mapper.detailTax(home);
	}

	//U 월세 납부 
	@Override
	public boolean inputTax(HomeTaxVo home) {
		System.out.println("여기까지오다니");
		return mapper.inputTax(home);
	}

	//R 전체 합산 데이터 가져오기 
	@Override
	public HomeTaxVo getTotalData(String day) {
		return mapper.getTotalData(day);
	}

	@Override
	public List<HomeTaxVo> chkTax(HomeTaxVo home) {
		return mapper.chkTax(home);
	}
	
	//CRUD
	

	
	
	
	
	
	
	
	
	//R 월세 납부내역 불러오기
	
	
}
