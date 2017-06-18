package com.bjpowernode.crm.setting.qx.user.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bjpowernode.crm.setting.qx.user.domain.User;
import com.bjpowernode.crm.setting.qx.user.service.UserService;
import com.bjpowernode.crm.setting.qx.user.service.impl.UserServiceImpl;
import com.bjpowernode.crm.setting.qx.user.vo.UserVo;
import com.bjpowernode.crm.util.DateUtil;
import com.bjpowernode.crm.util.PageUtil;
import com.bjpowernode.crm.util.ServiceFactory;
import com.bjpowernode.crm.util.UUIDUtil;

public class UserDetailController extends HttpServlet{
	private UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
		
		String id = request.getParameter("id");
		
		User d = us.getById(id);
		
		UserVo v = new UserVo();
		v.setDeptName(d.getDeptNo());
		v.setLockStatusText(d.getLockStatus());
		
		StringBuffer buf = new StringBuffer();
		buf.append("{\"id\":\""+d.getId()+"\",\"loginAct\":\""+d.getLoginAct()+"\",\"loginPwd\":\""+d.getLoginPwd()+"\",\"name\":\""+d.getName()+"\",\"deptNo\":\""+d.getDeptNo()+"\",\"expireTime\":\""+d.getExpireTime()+"\",\"lockStatus\":\""+d.getLockStatus()+"\",\"allowIps\":\""+d.getAllowIps()+"\",\"email\":\""+d.getEmail()+"\",\"createBy\":\""+d.getCreateBy()+"\",\"createTime\":\""+d.getCreateTime()+"\",\"editBy\":\""+d.getEditBy()+"\",\"editTime\":\""+d.getEditTime()+"\",\"deptName\":\""+v.getDeptName()+"\",\"lockStatusText\":\""+v.getLockStatusText()+"\"}");
		
		PrintWriter pw = response.getWriter();
		pw.print(buf.toString());
		pw.close();
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
}
















