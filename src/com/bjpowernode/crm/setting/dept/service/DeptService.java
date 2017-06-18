package com.bjpowernode.crm.setting.dept.service;

import java.util.List;
import java.util.Map;

import com.bjpowernode.crm.setting.dept.domain.Dept;

public interface DeptService {
	
	public void save(Dept d);
	public void delete(String[] ids);
	public void update(Dept d);
	public Dept getById(String id);
	
	public Map getAll(String pageNo);
	
}
