package com.mkw.a.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mkw.a.domain.HomeTaxVo;

public interface HomeTaxDao {

	boolean createTax(HomeTaxVo tax);

	List<HomeTaxVo> getAllTaxList(String day);

	ArrayList<HomeTaxVo> detailTax(HomeTaxVo home);

	boolean inputTax(HomeTaxVo home);

	HomeTaxVo getTotalData(String day);

	List<HomeTaxVo> chkTax(HomeTaxVo home);

	boolean insertTableInput(HomeTaxVo home);

	List<HashMap<String, Object>> getMonthInputListData(HashMap<String, Object> param);  

}
