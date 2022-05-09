package com.mkw.a;

import static org.junit.Assert.assertThat;

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

import com.mkw.a.common.TestCoolSms;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml")
public class TestCoolSmsTest {

private MockMvc mockmvc;
	
	@Autowired
	private WebApplicationContext context;
	
	@Autowired
	private TestCoolSms testCoolSms;
	
	//각 테스트 이전 
	@Before
	public void setup() {
		this.mockmvc = MockMvcBuilders.webAppContextSetup(this.context).build();
	}
	
	@Test
	public void smsTest1() throws Exception{
//		assertThat(testCoolSms.sendSmsForAdmin("01026074128", "2205"));
	}

}
