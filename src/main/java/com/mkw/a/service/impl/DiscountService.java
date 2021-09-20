package com.mkw.a.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.domain.MemberVo;
import com.mkw.a.service.DiscountInterface;

@Component
public class DiscountService {

	private final Map<String, DiscountInterface> policyMap;
	
	@Autowired
	public DiscountService(Map<String, DiscountInterface> policyMap) {
	
		this.policyMap = policyMap;
		System.out.println("policyMap = " + policyMap);
		
	}
	
	public HomeTaxVo discount(MemberVo member, String discountCode, HomeTaxVo tax, int nomalLen, int discountLen) {
		DiscountInterface discountPolicy = policyMap.get(discountCode);
		
		System.out.println("discountCode = " + discountCode);
		System.out.println("discountPolicy = " + discountPolicy);
		
		return discountPolicy.setMemberHomeTax(member, tax, nomalLen, discountLen);
				
	}

	public Map<String, DiscountInterface> getPolicyMap() {
		return policyMap;
	}
	
	
}
