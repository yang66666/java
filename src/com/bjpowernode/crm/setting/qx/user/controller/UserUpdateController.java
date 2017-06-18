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

public class UserUpdateController extends HttpServlet{
	private UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String loginAct = request.getParameter("loginAct");
		String name = request.getParameter("name");
		String loginPwd = request.getParameter("loginPwd");
		String email = request.getParameter("email");
		String expireTime = request.getParameter("expireTime");
		String lockStatus = request.getParameter("lockStatus");
		String deptNo = request.getParameter("deptNo");
		String allowIps = request.getParameter("allowIps");
		
		User u = new User();
		u.setId(id);
		u.setLoginAct(loginAct);
		u.setLoginPwd(loginPwd);
		u.setName(name);
		u.setEmail(email);
		u.setExpireTime(expireTime);
		u.setDeptNo(deptNo);
		u.setLockStatus(lockStatus);
		u.setAllowIps(allowIps);
		u.setEditBy("lisi");
		u.setEditTime(DateUtil.getCurrentTime());
		
		us.update(u);
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
}
















