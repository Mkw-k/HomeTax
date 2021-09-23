package com.mkw.a.service;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.domain.MemberVo;

public interface DiscountInterface {

	/**
	 * 월세 관련 DTO를 받아서 해당 회원에 맞는 월세를 책정하여 
	 * 해당 값들을 셋팅한 DTO를 리턴해주는 함수 
	 * @author K
	 * @param HomeTaxVo 
	 * @return HomeTaxVo
	 */
	public HomeTaxVo setMemberHomeTax(MemberVo member, HomeTaxVo tax, int nomalLen, int discountLen);
}
