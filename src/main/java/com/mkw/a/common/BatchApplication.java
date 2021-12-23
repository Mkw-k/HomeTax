package com.mkw.a.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/*
 * 추후 배치로 변경 예정 
 * 아직 까지는 간단한 스케쥴러 형식 
 * 
 * 월세 문자 전송 기능 
 * 추후 카카오 채널 톡 추가 예정 
 * 
 */
@EnableScheduling
@Component
public class BatchApplication {
	
	@Autowired
	TestCoolsms testcoolsms;
	
	@Scheduled(cron = "0 48 0 23 * ?")
	public void scheduledTest() throws Exception{
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println("스케쥴러 작동!!");
		System.out.println("스케쥴러 작동 시간 :: " + sdf.format(calendar.getTime()));
		
		String phoneNum = "01026074128";
		String cerNum = "0000";
		
		testcoolsms.certifiedPhoneNumber(phoneNum, cerNum, sdf.format(calendar.getTime()));
	}
	
}
