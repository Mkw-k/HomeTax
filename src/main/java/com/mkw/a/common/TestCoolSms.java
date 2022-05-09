package com.mkw.a.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.service.HomeTaxService;
import com.mkw.a.service.impl.HomeTaxServiceImpl;

import lombok.RequiredArgsConstructor;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

/**
 * @class: TestCoolSms 
 * @author K
 * <pre>
 * SMS 기본 Biz 로직 클래스 
 * </pre>
 *	TODO 1. 문자메세지 전문은 DB 데이터에 ${date} 식으로 변경하거나 properties 식으로 변경할 예정임  
 */
@Component
@RequiredArgsConstructor
public class TestCoolSms {
	
	private final HomeTaxServiceImpl homeTaxService;
	
	/**
	  * @Method Name : sendHomeTaxSms
	  *<pre>
	  * 이전 메서드 이름 : certifiedPhoneNumber
	  *</pre>
	  * @작성일 : 2022. 5. 4. 오전 12:38:43
	  * @작성자 : K
	  * @변경이력 : 
	  * @Method 설명 : BatchApplication 스케쥴러가 sms문자를 전송할때 사용하는 메소드  
	  * @param phoneNumber
	  * @param cerNum(빈값임)
	  * @param date
	  *
	  */
	public void sendHomeTaxSms(String phoneNumber, String date) {
		//api 기본정보
		String api_key = "NCSVQSHKTSHNACR9";
		String api_secret = "XKKT3D1RLWVJRIA4YPKUI818LKYCVFBE";
		Message coolsms = new Message(api_key, api_secret);
		
		//날짜 셋팅
		String formatDate = date.substring(2,4) + date.substring(5,7);
		System.out.println("formatDate 확인 :: " + formatDate);
		
		//월세내역
		ArrayList<HashMap<String, Object>> monthTaxList = new ArrayList<HashMap<String,Object>>();
		monthTaxList = homeTaxService.getTaxByYearMonth(formatDate);
//		MonthTaxList.forEach(System.out::println);
		
		for (HashMap<String, Object> hashMap : monthTaxList) {
			
			// 4 params(to, from, type, text) are mandatory. must be filled
			
			//sms 송신정보 생성 (파라미터셋팅)
			HashMap<String, String> params = new HashMap<String, String>();
			//params.put("to", hashMap.get("PHONE").toString());
			params.put("to", "01026074128");
			params.put("from", hashMap.get("MYID").toString());
			params.put("type", "SMS");
			
			//sms전문생성
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
				//sms전송
				JSONObject obj = (JSONObject) coolsms.send(params);
				System.out.println(obj.toString());
				//운영자에게 확인문자 전송 
				sendChkSmsToAdmin(phoneNumber, date);
			} catch (CoolsmsException e) {
				System.out.println(e.getMessage());
				System.out.println(e.getCode());
			}
			
			
		}
	
	}
	
	/**
	  *
	  * @Method Name : sendChkSmsToAdmin
	  *<pre>
	  *</pre>
	  * @작성일 : 2022. 5. 10. 오전 12:04:50
	  * @작성자 : K
	  * @변경이력 : 
	  * @Method 설명 : 월세 알람 SMS 유저들에게 전달후 전달되었다는 문자 운영자에게 전달 
	  * @param phoneNumber
	  * @param date
	  *
	  */
	public void sendChkSmsToAdmin(String phoneNumber, String date) {
		//api 기본정보
		String api_key = "NCSVQSHKTSHNACR9";
		String api_secret = "XKKT3D1RLWVJRIA4YPKUI818LKYCVFBE";
		Message coolsms = new Message(api_key, api_secret);
		
		//날짜 셋팅 ex) 2104
		String formatDate = date.substring(2,4) + date.substring(5,7);
		System.out.println("formatDate 확인 :: " + formatDate);
		
		//sms 송신정보 생성 (파라미터셋팅)
		HashMap<String, String> params = new HashMap<String, String>();
		//params.put("to", hashMap.get("PHONE").toString());
		params.put("to", "01026074128");
		params.put("from", "01026074128");
		params.put("type", "SMS");
		
		//월세내역
		ArrayList<HashMap<String, Object>> monthTaxList = new ArrayList<HashMap<String,Object>>();
		monthTaxList = homeTaxService.getTaxByYearMonth(formatDate);
		
		//sms전문생성
		String TaxText = "";
		TaxText += "이번달" + "(" + formatDate  + ") ";
		TaxText += "월세메세지를 발송하였습니다";
		
		System.out.println("문자 메세지 확인 >>>>>>> ");
		System.out.println(TaxText);
		params.put("text", TaxText );
		params.put("app_version", "test app 1.2"); //application name and version
		
		try {
			//sms전송
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
	}

	/**
	  *
	  * @Method Name : sendSmsForAdmin
	  *<pre>
	  *</pre>
	  * @작성일 : 2022. 5. 10. 오전 12:03:22
	  * @작성자 : K
	  * @변경이력 : 
	  * @Method 설명 : 월세 입력 요청 SMS 전송 (운영자에게)
	  * @param phoneNumber
	  * @param date
	 * @return 
	  *
	  */
	public boolean sendSmsForAdmin(String phoneNumber, String date) {
		//api 기본정보
		String api_key = "NCSVQSHKTSHNACR9";
		String api_secret = "XKKT3D1RLWVJRIA4YPKUI818LKYCVFBE";
		Message coolsms = new Message(api_key, api_secret);
		
		//날짜 셋팅 ex) 2104
		String formatDate = date.substring(2,4) + date.substring(5,7);
		System.out.println("formatDate 확인 :: " + formatDate);
		
		List<HomeTaxVo> taxList = homeTaxService.getAllTaxList(formatDate);
		
		if(!taxList.isEmpty()) {
			System.out.println("월세가 이미 입력이 되어있습니다");
			return false;
		}
			
		//sms 송신정보 생성 (파라미터셋팅)
		HashMap<String, String> params = new HashMap<String, String>();
		//params.put("to", hashMap.get("PHONE").toString());
		params.put("to", "01026074128");
		params.put("from", "01026074128");
		params.put("type", "SMS");
		
		//월세내역
		ArrayList<HashMap<String, Object>> monthTaxList = new ArrayList<HashMap<String,Object>>();
		monthTaxList = homeTaxService.getTaxByYearMonth(formatDate);
		
		//sms전문생성
		String TaxText = "";
		if(monthTaxList.isEmpty()) {
			TaxText += "이번달" + "(" + formatDate  + ") ";
			TaxText += "월세를 입력해주세요";
		}else {
			System.out.println("이번달 월세가 이미 입력되어있습니다.");
			return false;
		}
		
		System.out.println("문자 메세지 확인 >>>>>>> ");
		System.out.println(TaxText);
		params.put("text", TaxText );
		params.put("app_version", "test app 1.2"); //application name and version
		
		try {
			//sms전송
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
			
			return obj != null ? true: false;
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		return false;
	}
}
