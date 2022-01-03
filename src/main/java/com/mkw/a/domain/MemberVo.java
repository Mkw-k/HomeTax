package com.mkw.a.domain;

import java.io.Serializable;

import lombok.AccessLevel;
import lombok.Data;
import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
 * 211228 K
 * phone 변수 String으로 타입변경했음 
 * 정수 타입의 경우 맨 첫자 0이 사라지는 문제발생하여 타입교체
 *  010 -> 10 
 *  
 * */

@Setter
@Getter
@RequiredArgsConstructor
@ToString
/* @Data */
public class MemberVo implements Serializable{
	
	public MemberVo() {
		// TODO Auto-generated constructor stub
	}

	private String name; 
	
	private String classify; 
	
	private String email;
	
	private String phone;
	
	//@Setter(value = AccessLevel.NONE)	//해당 어노테이션을 붙여놓으면 롬복이 셋터를 생성하지 않음
	private String pwd;
	
	private String issale;
	
	@NonNull
	private String myid;
	
	private int auth;
	
	private String filename;
	
	private String newfilename;
	
	private String del;
}
