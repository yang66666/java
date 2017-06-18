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

public class DeptListController extends HttpServlet{
	private DeptService ds = (DeptService) ServiceFactory.getService(new DeptServiceImpl());
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pageNo = request.getParameter("pageNo");
		Map map = ds.getAll(pageNo);
		List<Dept> dList = (List<Dept>)map.get("dList");
		PageUtil pu = (PageUtil)map.get("pu");
		
		request.setAttribute("pu",pu);
		request.setAttribute("dList",dList);
		
//{"pu":{"pageNo":1,"pageCount":1,"pageSize":1,"total":1},"dList":[{"id":"?","no":"?","name":"?","manager":"?","phone":"?","description":"?"},{},{},{}]}                                                                               
		
		StringBuffer buf = new StringBuffer();
		buf.append("{\"pu\":{\"pageNo\":"+pu.getPageNo()+",\"pageCount\":"+pu.getPageCount()+",\"pageSize\":"+pu.getPageSize()+",\"total\":"+pu.getTotal()+"},\"dList\":[");
		
		for(int i=0;i<dList.size();i++){
			
			Dept d = dList.get(i);
			
			buf.append("{\"id\":\""+d.getId()+"\",\"no\":\""+d.getNo()+"\",\"name\":\""+d.getName()+"\",\"manager\":\""+d.getManager()+"\",\"phone\":\""+d.getPhone()+"\",\"description\":\""+d.getDescription()+"\"}");
			
			if(i<dList.size()-1){
				buf.append(",");
			}
			
		}
		
		buf.append("]}");
		
		PrintWriter pw = response.getWriter();
		pw.print(buf.toString());
		pw.close();
		
		//request.getRequestDispatcher("/settings/dept/index.jsp").forward(request, response);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
}
















