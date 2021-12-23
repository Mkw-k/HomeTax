package com.mkw.a.common;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/*사용안함*/ 
@Deprecated
public class LoginUtils {
	
	protected static Log loginUtilLog = LogFactory.getLog(LoginUtils.class);

	public static String loginCheck(HttpServletRequest req) {
		
		String dest = (String)req.getSession().getAttribute("dest");
		 
		if(dest == null) {
			 loginUtilLog.debug("로그인중 request OK");
		 }else {
			 loginUtilLog.debug("로그인필요함 request BACK");
		 }
         String redirect = (dest != null) ? "/home" : req.getServletPath();
         
         return redirect;
	};
}
