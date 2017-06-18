package com.bjpowernode.crm.setting.dept.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bjpowernode.crm.setting.dept.dao.DeptDao;
import com.bjpowernode.crm.setting.dept.domain.Dept;
import com.bjpowernode.crm.setting.dept.service.DeptService;
import com.bjpowernode.crm.util.PageUtil;
import com.bjpowernode.crm.util.SqlSessionUtil;

public class DeptServiceImpl implements DeptService{
	
	private DeptDao dd;
	
	@Override
	public void save(Dept d) {
		dd = SqlSessionUtil.getSession().getMapper(DeptDao.class);
		dd.save(d);
	}

	@Override
	public void delete(String[] ids) {
		dd = SqlSessionUtil.getSession().getMapper(DeptDao.class);
		for(String id:ids){
			dd.delete(id);
		}
	}

	@Override
	public void update(Dept d) {
		dd = SqlSessionUtil.getSession().getMapper(DeptDao.class);
		dd.update(d);
	}

	@Override
	public Dept getById(String id) {
		dd = SqlSessionUtil.getSession().getMapper(DeptDao.class);
		return dd.getById(id);
	}
	
	
	@Override
	public Map getAll(String pageNoStr) {
		dd = SqlSessionUtil.getSession().getMapper(DeptDao.class);
		//得到当前页
		int pageNo = 1;
		if(pageNoStr!=null&&!"".equals(pageNoStr.trim())){
			pageNo = Integer.valueOf(pageNoStr);
		}
		
		//获得每页显示多少条记录
		int pageCount = 5;
		
		//获得总记录数
		int total = dd.getTotal();
		
		//获得总页数
		int pageSize = total/pageCount;
		if(total%pageCount>0){
			pageSize++;
		}
		
		//获得需要返回的第一个元素 分页信息
		PageUtil pu = new PageUtil();
		pu.setPageCount(pageCount);
		pu.setPageNo(pageNo);
		pu.setPageSize(pageSize);
		pu.setTotal(total);
		
		
		
		
		int skipCount = (pageNo-1)*pageCount;
		
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("skipCount", skipCount);
		map.put("pageCount",pageCount);
		
		//获得需要返回的第二个元素  当前页的显示列表
		List<Dept> dList = dd.getAll(map);
		
		//最后将两个元素打包成map,进行返回
		Map rmap = new HashMap();
		rmap.put("pu",pu);
		rmap.put("dList", dList);
		
		return rmap;
	}

}

























