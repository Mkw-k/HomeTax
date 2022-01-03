package com.mkw.a;


import static org.springframework.test.web.client.match.MockRestRequestMatchers.content;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.mkw.a.controller.maincontroller;
import com.mkw.a.service.impl.BoardServiceImpl;
import com.mkw.a.service.impl.MemberServiceImpl;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml")
public class SampleTest {
	
	private MockMvc mockmvc;
	
	@Autowired
	private WebApplicationContext context;
	
	@Before
	public void setup() {
		this.mockmvc = MockMvcBuilders.webAppContextSetup(this.context).build();
	}
	
	@Test
	public void test2() throws Exception{
		this.mockmvc.perform(get("/getAllMemberData"))
					.andDo(print())
					.andExpect(status().isOk());
	}
	
}
