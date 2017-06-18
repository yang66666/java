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

public class DeptEditController extends HttpServlet{
	private DeptService ds = (DeptService) ServiceFactory.getService(new DeptServiceImpl());
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		
		Dept d  =ds.getById(id);
		
		StringBuffer buf = new StringBuffer();
		
		buf.append("{\"id\":\""+d.getId()+"\",\"no\":\""+d.getNo()+"\",\"name\":\""+d.getName()+"\",\"manager\":\""+d.getManager()+"\",\"phone\":\""+d.getPhone()+"\",\"description\":\""+d.getDescription()+"\"}");
		
		PrintWriter pw = response.getWriter();
		pw.print(buf.toString());
		pw.close();
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
}
















