package com.mkw.a.service.impl;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.domain.MemberVo;
import com.mkw.a.service.DiscountInterface;


@Component
public class NoDiscountService implements DiscountInterface{

	@Override
	public HomeTaxVo setMemberHomeTax(MemberVo member, HomeTaxVo tax, int nomalLen, int discountLen) {
		String getDay = tax.getDay();
		int water = tax.getWater()/(nomalLen+discountLen);
		int elec = tax.getElec()/(nomalLen+discountLen);
		int gas = tax.getGas()/(nomalLen+discountLen);
		int managerfee = tax.getManagerfee()/(nomalLen+discountLen);
		String htCustome = tax.getHtcustome();
		
		HomeTaxVo newTax = new HomeTaxVo();
		
		newTax.setMyid(member.getMyid());
		newTax.setDay(getDay);
		newTax.setWater(water);
		newTax.setElec(elec);
		newTax.setGas(gas);
		newTax.setManagerfee(managerfee);
		newTax.setHtcustome(htCustome);
		
		int interfee = 0;
		int monthfee = 0;
		
		//22-01-29 박규하 이사로인하여 로직 수정 인터넷비는 할인회원도 적용됨 
		interfee = tax.getInter()/(nomalLen+discountLen);
		newTax.setInter(interfee);
		monthfee = (tax.getMonthfee()/(nomalLen+discountLen))+10000;
		newTax.setMonthfee(monthfee);
		
		int totalfee = water + elec + gas + managerfee + interfee + monthfee;
		newTax.setTotalfee(totalfee);
		newTax.setRestfee(totalfee);
		
		return newTax;
	}

}
