package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

/**测试DAO*/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
//		//1.创建Spring IOC容器
//		 ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2.从容器中获取mapper
//		 DepartmentMapper bean=ioc.getBean(DepartmentMapper.class);
		System.out.println(departmentMapper);
		
		//1.插入几个部门
	
//		departmentMapper.insertSelective(new Department(null,"开发部2"));
//		departmentMapper.insertSelective(new Department(null,"测试部2"));
		
		//2.生成员数据
		//employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "123@qq.com", 1));
		
		//3.批量插入多个员工(使用可以执行批量操作的sqlsession)
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null, uid, "M", uid+"at@qqq", 1));
			System.out.println("批量完成");
		}
	}
}
