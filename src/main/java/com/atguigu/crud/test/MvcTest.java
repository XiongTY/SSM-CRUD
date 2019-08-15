package com.atguigu.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.atguigu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

/**
 * 使用spring测试模块提供的测试请求功能,测试crud正确性
 * @author Administrator
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
	//传入springmvc的IOC
	@Autowired
	WebApplicationContext context;
	//虚拟mvc请求,获取处理结果
	MockMvc mockMvc;
	@Before
	public void initMockMvc() {
	mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();
		
		//请求成功,请求域会有pageinfo
		
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("PageInfo");
		System.out.println("当前"+pi.getPageNum());
		System.out.println("总"+pi.getPages());
		System.out.println("总记录"+pi.getTotal());
		System.out.println("连续显示页码");
		int[] nums = pi.getNavigatepageNums();
		for (int i : nums) {
			System.out.println("  "+i);
		}
		
		//获取员工数据
		List<Employee> list = pi.getList();
		for (Employee employee : list) {
			System.out.println("ID"+employee.getEmpId()+"==name"+employee.getEmpName());
		}
	}
	
}
