package com.mkw.a.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.domain.MemberVo;
import com.mkw.a.mapper.HomeTaxDao;
import com.mkw.a.service.DiscountInterface;

//할인 정책 코드 
@Component
public class FixDiscountService implements DiscountInterface{

	@Autowired
	private HomeTaxDao hometaxdao;
	
	@Override
	public HomeTaxVo setMemberHomeTax(MemberVo member, HomeTaxVo tax, int nomalLen, int discountLen) {
		
		String getDay = tax.getDay();
		int water = tax.getWater()/(nomalLen+discountLen);
		int elec = tax.getElec()/(nomalLen+discountLen);
		int gas = tax.getGas()/(nomalLen+discountLen);
		int managerfee = tax.getManagerfee()/(nomalLen+discountLen);
		String htCustome = tax.getHtcustome();
		
		//22-01-29 로직 수정 
		//박규하 인터넷비 무료이던것 -> 남준이 반값으로 변경 
		int interfee = tax.getInter()/(nomalLen+discountLen);
		
		HomeTaxVo newTax = new HomeTaxVo();
		
		newTax.setMyid(member.getMyid());
		newTax.setDay(getDay);
		newTax.setWater(water);
		newTax.setElec(elec);
		newTax.setGas(gas);
		newTax.setManagerfee(managerfee);
		newTax.setHtcustome(htCustome);
		newTax.setInter(interfee);
		
		//할인월세 계산을 위한 초기화 및 선언
		int monthfee = 0;
		
		//할인 정책 코드 라인 
		//현재 지정되어있는 할인 금액 불러오기 (인당 지정금액 할인 정책임) 
		int fixDiscountPrice = hometaxdao.getDiscountPolicyPrice();
		
		//할인월세 구현로직
		monthfee = (tax.getMonthfee()/(nomalLen+discountLen))-(fixDiscountPrice*nomalLen);
		System.out.println(tax.getMonthfee() + " + " + nomalLen + " + " + discountLen + " ) " +  "- (" +fixDiscountPrice +" * " + nomalLen + ") ");
		newTax.setMonthfee(monthfee);
		
		int totalfee = water + elec + gas + managerfee + interfee + monthfee;
		newTax.setTotalfee(totalfee);
		newTax.setRestfee(totalfee);
		
		return newTax;
	}

}
