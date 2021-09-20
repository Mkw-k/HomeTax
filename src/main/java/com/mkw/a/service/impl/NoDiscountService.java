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
		
		tax.setMyid(member.getMyid());
		tax.setDay(getDay);
		tax.setWater(water);
		tax.setElec(elec);
		tax.setGas(gas);
		tax.setManagerfee(managerfee);
		
		int interfee = 0;
		int monthfee = 0;
		
		interfee = tax.getInter()/nomalLen;
		tax.setInter(interfee);
		monthfee = (tax.getMonthfee()/(nomalLen+discountLen))+10000;
		tax.setMonthfee(monthfee);
		
		int totalfee = water + elec + gas + managerfee + interfee + monthfee;
		tax.setTotalfee(totalfee);
		tax.setRestfee(totalfee);
		
		return tax;
	}

}
