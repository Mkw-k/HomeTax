package com.mkw.a.common;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mkw.a.service.HomeTaxService;
import com.mkw.a.service.impl.HomeTaxServiceImpl;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Component
public class TestCoolsms {
	
	@Autowired
	HomeTaxServiceImpl homeTaxService;
	
	public void certifiedPhoneNumber(String phoneNumber, String cerNum, String date) {
		
		String api_key = "NCSVQSHKTSHNACR9";
		String api_secret = "XKKT3D1RLWVJRIA4YPKUI818LKYCVFBE";
		Message coolsms = new Message(api_key, api_secret);
		
		String formatDate = date.substring(2,4) + date.substring(5,7);
		System.out.println("formatDate 확인 :: " + formatDate);
		
		//해당월의 월세 내역을 가지고 오고 그 내역을 통하여 회원들에게 문자메세지를 전송해주는 로직 만들어야함 
		//getTaxByYearMonth
		ArrayList<HashMap<String, Object>> MonthTaxList = new ArrayList<HashMap<String,Object>>();
		MonthTaxList = homeTaxService.getTaxByYearMonth(formatDate);
		MonthTaxList.forEach(System.out::println);
		
		for (HashMap<String, Object> hashMap : MonthTaxList) {
			
			// 4 params(to, from, type, text) are mandatory. must be filled 
			HashMap<String, String> params = new HashMap<String, String>();
			//params.put("to", hashMap.get("PHONE").toString());
			params.put("to", "01026074128");
			params.put("from", "01026074128");
			params.put("type", "SMS");
			
			String TaxText = "";
			TaxText += "이번달" + "(" + hashMap.get("DAY").toString() + ") ";
			TaxText +=  hashMap.get("NAME").toString() + "님의 납부하실 월세 총액은 " + hashMap.get("TOTALFEE").toString() + "원 입니다" + "\n";
			TaxText += "수도세 : " + hashMap.get("WATER").toString()+ "원, ";
			TaxText += "전기세 : " + hashMap.get("ELEC").toString()+ "원, ";
			TaxText += "가스비 : " + hashMap.get("GAS").toString()+ "원, ";
			TaxText += "관리비 : " + hashMap.get("MANAGERFEE").toString()+ "원, ";
			TaxText += "월세 : " + hashMap.get("MONTHFEE").toString()+ "원, ";
			TaxText += "인터넷비 : " + hashMap.get("INTER").toString()+ "원";
			
			System.out.println("문자 메세지 확인 >>>>>>> ");
			System.out.println(TaxText);
			params.put("text", TaxText );
			params.put("app_version", "test app 1.2"); //application name and version
			
			try {
				JSONObject obj = (JSONObject) coolsms.send(params);
				System.out.println(obj.toString());
			} catch (CoolsmsException e) {
				System.out.println(e.getMessage());
				System.out.println(e.getCode());
			}
		}
	
	}

}
