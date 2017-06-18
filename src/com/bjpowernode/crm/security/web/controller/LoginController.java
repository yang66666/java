package com.bjpowernode.crm.security.web.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bjpowernode.crm.exception.ApplicationException;
import com.bjpowernode.crm.setting.qx.user.domain.User;
import com.bjpowernode.crm.setting.qx.user.service.UserService;
import com.bjpowernode.crm.setting.qx.user.service.impl.UserServiceImpl;
import com.bjpowernode.crm.util.ServiceFactory;

public class LoginController extends HttpServlet{
	//private UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
		
		//获得用户名和密码
		String act = request.getParameter("act");
		
		String pwd = request.getParameter("pwd");
		
		System.out.println(act +":" + pwd);
		
		//获取ip地址
		String ip = request.getRemoteAddr();
		System.out.println(ip);
		UserService us = new UserServiceImpl();
		
		String json = "";
		
		//登录成功返回的json{"success":true}
		
		//登录失败返回的json{"success":false,"msg":"?"}
		try{
			User user = us.login(act,pwd,ip);
			//下面的操作是安全的,因为如果上一行捕获到了异常,那么直接跳到catch块
			request.getSession().setAttribute("user",user);
			json = "{\"success\":true}";
		}catch(ApplicationException e){
			e.printStackTrace();
			String msg = e.getMessage();
			json = "{\"success\":false,\"msg\":\""+msg+"\"}";
		}
		System.out.println(json);
		PrintWriter pw = response.getWriter();
		pw.print(json);
		pw.close();
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
	
}

















