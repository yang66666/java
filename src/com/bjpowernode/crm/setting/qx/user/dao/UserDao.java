package com.bjpowernode.crm.setting.qx.user.dao;

import java.util.List;
import java.util.Map;

import com.bjpowernode.crm.setting.qx.user.domain.User;

public interface UserDao {
	
	public void save(User u);
	public void delete(String id);
	public void update(User d);
	
	public User getById(String id);
	public List<User> getAll(Map map);
	
	public int getTotal(Map<String,String> map);
	
	public void updateLockStatus(User user);
	
	public User getByActAndPwd(String act, String pwd);
	
}
