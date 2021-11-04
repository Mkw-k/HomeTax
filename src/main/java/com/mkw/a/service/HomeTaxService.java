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
	
	public List<HashMap<String, Object>> getMonthInputListData(HashMap<String, Object> param);

	HashMap<String, Object> inputDues(HashMap<String, Object> param);

	HashMap<String, Object> getDuesStatus(HashMap<String, Object> param);

	HashMap<String, Object> recallTaxAf(HashMap<String, Object> param);

}
