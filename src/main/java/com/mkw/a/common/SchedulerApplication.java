package com.mkw.a.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.mkw.a.domain.HomeTaxVo;
import com.mkw.a.domain.MemberVo;
import com.mkw.a.service.HomeTaxService;

import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

/**
 * 추후 배치로 변경 예정 
 * 아직 까지는 간단한 스케쥴러 형식 
 * 
 * 월세 문자 전송 기능 
 * 추후 카카오 채널 톡 추가 예정 
 * 
 * Junit Test 추가 필요 
 * 
 * @author K
 *
 */
@EnableScheduling
@Component
@RequiredArgsConstructor
public class SchedulerApplication {
	
	//api 
	private final TestCoolSms testcoolsms;
	
	//service
	private final HomeTaxService homeTaxService; 
	
	/**
	  *
	  * @Method Name : smsTaxScheduler
	  *<pre>
	  *	참고사항 : 스케쥴러는 파라미터가 있으면 에러남 
	  *</pre>
	  * @작성일 : 2022. 5. 3. 오전 12:35:42
	  * @작성자 : K
	  * @변경이력 : 
	  * @Method 설명 : 매월 23일 0시 48분 0초에 월세를 전송함
	  * @throws Exception
	  *
	  */
	@Scheduled(cron = "0 48 0 23 * ?")
	public void smsTaxScheduler() throws Exception{
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		System.out.println("스케쥴러 작동!!");
		System.out.println("스케쥴러 작동 시간 :: " + sdf.format(calendar.getTime()));
		
		//1. sms 기본정보 셋팅 
		String phoneNum = "01026074128";	//송신자 번호 
		
		//sms 보내기 
		testcoolsms.sendHomeTaxSms(phoneNum, sdf.format(calendar.getTime()));
	}
	
	/**
	  *
	  * @Method Name : alertCreateTaxSmsScheduler
	  *<pre>
	  *</pre>
	  * @작성일 : 2022. 5. 10. 오전 12:08:42
	  * @작성자 : K
	  * @변경이력 : 
	  * @Method 설명 : 매달 15일 22시 까지 월세가 입력되있지 않으면 월세작성요청 문자 운영자에게 전송
	  * @throws Exception
	  *
	  */
	@Scheduled(cron = "0 0 22 15 * *")
	public void alertCreateTaxSmsScheduler() throws Exception{
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		System.out.println("스케쥴러 작동!!");
		System.out.println("스케쥴러 작동 시간 :: " + sdf.format(calendar.getTime()));
		
		//1. sms 기본정보 셋팅 
		String phoneNum = "01026074128";	//송신자 번호 
		
		//sms 보내기 
		testcoolsms.sendSmsForAdmin(phoneNum, sdf.format(calendar.getTime()));
	}
}
