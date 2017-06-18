package com.bjpowernode.crm.setting.dept.dao;

import java.util.List;
import java.util.Map;

import com.bjpowernode.crm.setting.dept.domain.Dept;

public interface DeptDao {
	
	public void save(Dept d);
	public void delete(String id);
	public void update(Dept d);
	
	public Dept getById(String id);
	public List<Dept> getAll(Map map);
	
	public int getTotal();
	
	public String getNameByNo(String no);
	
}













