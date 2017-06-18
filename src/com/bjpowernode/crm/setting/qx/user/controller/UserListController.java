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
import com.bjpowernode.crm.util.PageUtil;
import com.bjpowernode.crm.util.ServiceFactory;

public class UserListController extends HttpServlet{
	private UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//获取高级查询的各个条件
		String name1 = request.getParameter("name1");
		String dept1 = request.getParameter("dept1");
		String lock1 = request.getParameter("lock1");
		String time1 = request.getParameter("time1");
		String time2 = request.getParameter("time2");
		
		Map<String,String> pmap = new HashMap<String,String>();
		
		if(name1!=null&&!"".equals(name1.trim())){
			pmap.put("name1","%"+name1+"%");
		}
		
		pmap.put("dept1",dept1);
		pmap.put("lock1",lock1);
		pmap.put("time1",time1);
		pmap.put("time2",time2);
		
		
		
		response.setContentType("text/html;charset=utf-8");
		
		System.out.println("------------------------------");
		
		String pageNo = request.getParameter("pageNo");
		Map map = us.getAll(pageNo,pmap);
		List<User> uList = (List<User>)map.get("uList");
		PageUtil pu = (PageUtil)map.get("pu");
		
		request.setAttribute("pu",pu);
		request.setAttribute("uList",uList);
		
//{"pu":{"pageNo":1,"pageCount":1,"pageSize":1,"total":1},"dList":[{"id":"?","no":"?","name":"?","manager":"?","phone":"?","description":"?"},{},{},{}]}                                                                               
		
		StringBuffer buf = new StringBuffer();
		buf.append("{\"pu\":{\"pageNo\":"+pu.getPageNo()+",\"pageCount\":"+pu.getPageCount()+",\"pageSize\":"+pu.getPageSize()+",\"total\":"+pu.getTotal()+"},\"uList\":[");
		
		for(int i=0;i<uList.size();i++){
			
			User d = uList.get(i);
			
			UserVo v = new UserVo();
			v.setDeptName(d.getDeptNo());
			v.setLockStatusText(d.getLockStatus());
			
			//{"id":"?","loginAct":"?","loginPwd":"?","name":"?","deptNo":"?","expireTime":"?","lockStatus":"?","allowIps":"?","email":"?","createBy":"?","createTime":"?","editBy":"?","editTime":"?"}
			
			buf.append("{\"id\":\""+d.getId()+"\",\"loginAct\":\""+d.getLoginAct()+"\",\"loginPwd\":\""+d.getLoginPwd()+"\",\"name\":\""+d.getName()+"\",\"deptNo\":\""+d.getDeptNo()+"\",\"expireTime\":\""+d.getExpireTime()+"\",\"lockStatus\":\""+d.getLockStatus()+"\",\"allowIps\":\""+d.getAllowIps()+"\",\"email\":\""+d.getEmail()+"\",\"createBy\":\""+d.getCreateBy()+"\",\"createTime\":\""+d.getCreateTime()+"\",\"editBy\":\""+d.getEditBy()+"\",\"editTime\":\""+d.getEditTime()+"\",\"deptName\":\""+v.getDeptName()+"\",\"lockStatusText\":\""+v.getLockStatusText()+"\"}");                                                                  
			
			if(i<uList.size()-1){
				buf.append(",");
			}
			
		}
		
		buf.append("]}");
		
		PrintWriter pw = response.getWriter();
		pw.print(buf.toString());
		pw.close();
		
		//request.getRequestDispatcher("/settings/User/index.jsp").forward(request, response);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
}
















