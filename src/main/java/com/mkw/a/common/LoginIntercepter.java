package com.mkw.a.common;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.mkw.a.controller.HomeTaxController;
import com.mkw.a.domain.MemberVo;

@Component
public class LoginIntercepter implements HandlerInterceptor {

	private static final Logger logger = LoggerFactory.getLogger(HomeTaxController.class);
	
	//해당 리스트들도 사용하지 않는중 
    public List loginEssential
            = Arrays.asList("./detailTax", "/chkTax");

    public List loginInessential
            = Arrays.asList("/login/memberManager", "/login/mypage");
    
    /*
    public List loginEssential
    = Arrays.asList("HomeTax/detailTax","/post/**", "/comment/**",  "/category/**", "/member/manage/**", "/main/edit/**");

	public List loginInessential
    = Arrays.asList("/post/board/**", "/post/read/**", "/post/like/**" );
	*/

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	MemberVo login = (MemberVo)request.getSession().getAttribute("login");

    	//로그인 되어있을 경우
        if(login != null){
        	return true;
        }
      //로그인 안 되어있을 경우
        else{
            String destUri = request.getRequestURI();
            String destQuery = request.getQueryString();
            String dest = (destQuery == null) ? destUri : destUri+"?"+destQuery;
        
            request.getSession().setAttribute("dest", dest);
        
            response.sendRedirect("./login");
            return false;
        }
    }
}