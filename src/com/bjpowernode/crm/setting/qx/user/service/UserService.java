package com.bjpowernode.crm.setting.qx.user.service;

import java.util.Map;

import com.bjpowernode.crm.setting.qx.user.domain.User;


public interface UserService {
	public void save(User u);
	public void delete(String[] ids);
	public void update(User u);
	public User getById(String id);
	
	public Map getAll(String pageNo,Map<String,String> pmap);
	
	//更改状态
	public void changeLs(String param);
	public User login(String act, String pwd, String ip);
}
