package com.mkw.a.util;

import java.util.Date;

public class PdsUtil {

	public static String getNewFileName(String f) {
		String filename = "";
		String fpost = "";
		
		if(f.lastIndexOf('.') >= 0) {
			fpost = f.substring(f.lastIndexOf('.'));
			filename = new Date().getTime()+fpost;
		}else {
			filename = new Date().getTime()+".back";
		}
		
		return filename;
	}
}
