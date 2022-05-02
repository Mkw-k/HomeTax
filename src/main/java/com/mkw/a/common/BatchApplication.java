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
 * @author K
 *
 */
@EnableScheduling
@Component
@RequiredArgsConstructor
public class BatchApplication {
	
	//api 
	private final TestCoolsms testcoolsms;
	
	//service
	private final HomeTaxService homeTaxService; 
	
	/**
	  *
	  * @Method Name : scheduledTest
	  *<pre>
	  *</pre>
	  * @작성일 : 2022. 5. 3. 오전 12:35:42
	  * @작성자 : K
	  * @변경이력 : 
	  * @Method 설명 : 매월 23일 0시 48분 0초에 월세를 전송함
	  * @throws Exception
	  *
	  */
	@Scheduled(cron = "0 48 0 23 * ?")
	public void scheduledTest(String day, HttpServletRequest request) throws Exception{
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		MemberVo login = (MemberVo)request.getSession().getAttribute("login");
		
		System.out.println("스케쥴러 작동!!");
		System.out.println("스케쥴러 작동 시간 :: " + sdf.format(calendar.getTime()));
		
		//1. sms 기본정보 셋팅 
		String phoneNum = "01026074128";	//송신자 번호 
		String cerNum = login.getPhone();	//수신자 번호
		
		//2. 납부 월세 기본정보 
		List<HomeTaxVo> collect = homeTaxService.getAllTaxList(day)
				.stream()
				.filter(x->x.getMyid().equals(login.getMyid()))
				.collect(Collectors.toList());
		
		//3. 검증작업 잘못된 리턴 데이터 경우 
		if(collect.isEmpty()) {
			throw new Exception("로그인한 유저의 해당 월의 납부월세기본 데이터가 없습니다");
		}else if(collect.size() > 1) {
			throw new Exception("로그인한 유저의 해당 월의 납부월세기본 데이터가 2개 이상입니다. 데이터에 문제가 있으니 관리자에게 문의하세요");
		}
		
		//TODO sms 전문 생성하기 
		//testcoolsms > certifiedPhoneNumber 구현되어있음 
		
		//sms 보내기 
		testcoolsms.certifiedPhoneNumber(phoneNum, cerNum, sdf.format(calendar.getTime()));
	}
	
}
