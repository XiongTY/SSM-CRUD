package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.dao.EmployeeMapper;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
/**
 * 处理员工crud请求
 * @author Administrator
 *
 */

@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	
	
	
	
	
	@RequestMapping(value="emp/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpBy(@PathVariable("id")String ids) {
		if(ids.contains("-")) {
			String[] str_ids = ids.split("-");
			List<Integer> del_ids = new ArrayList<Integer>();
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else {
			Integer id = Integer.parseInt(ids);
		employeeService.deleteEmp(id);
		}
		return Msg.success(); 
	}
	
	@RequestMapping(value="emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	

	@RequestMapping(value="emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee=employeeService.getEmp(id);
		return Msg.success().add("emp",employee);
	}
	
	
	
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg SaveEmp(Employee employee) {
		employeeService.saveEmp(employee);
		return Msg.success();
	}
	
	@RequestMapping("emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue = "1")Integer pn,Model model) {
		PageHelper.startPage(pn, 5);
		//startpage后面紧跟的查询就是分页查询
		List<Employee> emps= employeeService.getAll();
		//使用pageinfo包装查询后的结果.只需要将pageinfo交给页面即可
		//封装了详细的分页信息,和查出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("PageInfo", page);
		
		return Msg.success().add("PageInfo",page);
	}
	
	/**
	 * 查询员工数据(分页查询)
	 * @return
	 */
	//@RequestMapping("/emps")
//	public String getEmp(@RequestParam(value="pn",defaultValue = "1")Integer pn,Model model) {
//		//这不是分页查询
//		//引入pagehelper
//		PageHelper.startPage(pn, 5);
//		//startpage后面紧跟的查询就是分页查询
//		List<Employee> emps= employeeService.getAll();
//		//使用pageinfo包装查询后的结果.只需要将pageinfo交给页面即可
//		//封装了详细的分页信息,和查出来的数据,传入连续显示的页数
//		PageInfo page = new PageInfo(emps,5);
//		model.addAttribute("PageInfo", page);
//		
//		return "list";
//	}
}
