package com.mkw.a.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.mkw.a.domain.HomeTaxVo;

public interface HomeTaxService {

	void createTax(HomeTaxVo tax, HttpServletResponse response) throws Exception;

	List<HomeTaxVo> getAllTaxList(String day);

	ArrayList<HomeTaxVo> detailTax(HomeTaxVo home);

	HashMap<String, Object> inputTax(HomeTaxVo home);

	HomeTaxVo getTotalData(String day);

	List<HomeTaxVo> chkTax(HomeTaxVo home);

	boolean insertTableInput(HomeTaxVo home);

}
