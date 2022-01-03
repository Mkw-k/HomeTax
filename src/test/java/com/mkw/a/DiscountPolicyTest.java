package com.mkw.a;


import static org.junit.Assert.assertThat;

import java.util.Map;

import org.junit.Test;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.domain.MemberVo;
import com.mkw.a.service.DiscountInterface;
import com.mkw.a.service.impl.DiscountService;

class DiscountPolicyTest {

	private Map<String, DiscountInterface> policyMap;
	
	@Test
	void test() {
		AnnotationConfigApplicationContext ac = new AnnotationConfigApplicationContext(DiscountService.class);
		
		//DiscountService service = ac.getBean(DiscountService.class);
		//MemberVo member = new MemberVo();
		//HomeTaxVo tax = new HomeTaxVo();
		
		//service.discount(member, "FixDiscountService", tax, 2, 1);
		DiscountInterface discountPolicy = policyMap.get("FixDiscountService");
		assertThat(discountPolicy, null);
	}

}
