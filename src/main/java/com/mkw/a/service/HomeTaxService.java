package com.mkw.a.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mkw.a.domain.HomeTaxVo;

public interface HomeTaxService {

	boolean createTax(HomeTaxVo tax);

	List<HomeTaxVo> getAllTaxList(String day);

	HomeTaxVo detailTax(HomeTaxVo home);

	HashMap<String, Object> inputTax(HomeTaxVo home);

	HomeTaxVo getTotalData(String day);

	List<HomeTaxVo> chkTax(HomeTaxVo home);

	boolean insertTableInput(HomeTaxVo home);

}
