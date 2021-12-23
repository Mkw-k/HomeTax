package com.mkw.a.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.mkw.a.controller.HomeTaxController;

@Deprecated
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	private static final Logger logger = LoggerFactory.getLogger(HomeTaxController.class);
	
	//작동안되는 거로 보임 현재 sevlet-context.xml에 등록해놨음 빈이랑 패턴
	//부트만 되는 방식인지?
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
    	logger.debug("여기가 인터셉터 추가부분");
        LoginIntercepter loginIntercepter = new LoginIntercepter();
        registry.addInterceptor(loginIntercepter)
                .addPathPatterns("**/detailTax")
                .addPathPatterns("**/chkTax")
                .excludePathPatterns(loginIntercepter.loginInessential)
                .order(0);
    }
}