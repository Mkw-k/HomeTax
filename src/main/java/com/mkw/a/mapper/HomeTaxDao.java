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

	boolean inputTempTax(HomeTaxVo home);

	List<HomeTaxVo> getNoConfirmData();

	boolean confirmTaxAf(HashMap<String, Object> param);

	boolean inputTaxMaster(HashMap<String, Object> param);

	boolean recallTaxAf(HashMap<String, Object> param);

	boolean create_hometax_payment_chk(String day);

	boolean payment_chk_update(HashMap<String, Object> dueParam);

	HashMap<String, Object> getDuesStatus(HashMap<String, Object> param);

	ArrayList<HashMap<String, Object>> getTaxGraphData();  

}
