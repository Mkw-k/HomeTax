package com.mkw.a.mapper;

import java.util.List;
import java.util.Map;

import com.mkw.a.domain.HomeTaxVo;

public interface HomeTaxDao {

	boolean createTax(HomeTaxVo tax);

	List<HomeTaxVo> getAllTaxList(String day);

	HomeTaxVo detailTax(HomeTaxVo home);

	boolean inputTax(HomeTaxVo home);

	HomeTaxVo getTotalData(String day);

	List<HomeTaxVo> chkTax(HomeTaxVo home); 

}
