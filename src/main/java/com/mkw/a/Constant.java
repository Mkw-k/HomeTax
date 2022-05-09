package com.mkw.a;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

public class Constant {

	@Getter
	@RequiredArgsConstructor
	public enum adminInfo{
		adminInfo(1, "phone", "01026074128");
		
		private final int code;
	    private final String koName;
	    private final String enName;
	 
	    public static adminInfo fromKoName(String text){
	        for (adminInfo code :values()){
	            if (code.getKoName().equals(text)) {
	                return code;
	            }
	        }
	        throw new IllegalArgumentException();
	    }

	}
}
