package com.bjpowernode.crm.setting.dept.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bjpowernode.crm.setting.dept.domain.Dept;
import com.bjpowernode.crm.setting.dept.service.DeptService;
import com.bjpowernode.crm.setting.dept.service.impl.DeptServiceImpl;
import com.bjpowernode.crm.util.PageUtil;
import com.bjpowernode.crm.util.ServiceFactory;
import com.bjpowernode.crm.util.UUIDUtil;

public class DeptUpdateController extends HttpServlet{
	private DeptService ds = (DeptService) ServiceFactory.getService(new DeptServiceImpl());
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String no = request.getParameter("no");
		String name = request.getParameter("name");
		String manager = request.getParameter("manager");
		String phone = request.getParameter("phone");
		String description = request.getParameter("description");
		
		Dept d = new Dept();
		d.setId(id);
		d.setNo(no);
		d.setName(name);
		d.setManager(manager);
		d.setPhone(phone);
		d.setDescription(description);
		
		ds.update(d);
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
}
















