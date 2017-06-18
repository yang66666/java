package com.bjpowernode.crm.setting.qx.user.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bjpowernode.crm.exception.ApplicationException;
import com.bjpowernode.crm.setting.qx.user.dao.UserDao;
import com.bjpowernode.crm.setting.qx.user.domain.User;
import com.bjpowernode.crm.setting.qx.user.service.UserService;
import com.bjpowernode.crm.util.DateUtil;
import com.bjpowernode.crm.util.PageUtil;
import com.bjpowernode.crm.util.SqlSessionUtil;

public class UserServiceImpl implements UserService{
	
	private UserDao userDao;
	
	@Override
	public void save(User u) {
		userDao = SqlSessionUtil.getSession().getMapper(UserDao.class);
		userDao.save(u);
	}

	@Override
	public void delete(String[] ids) {
		userDao = SqlSessionUtil.getSession().getMapper(UserDao.class);
		for(String id:ids){
			userDao.delete(id);
		}
	}

	@Override
	public void update(User u) {
		userDao = SqlSessionUtil.getSession().getMapper(UserDao.class);
		userDao.update(u);
	}

	@Override
	public User getById(String id) {
		userDao = SqlSessionUtil.getSession().getMapper(UserDao.class);
		return userDao.getById(id);
	}

	@Override
	public Map getAll(String pageNoStr,Map<String,String> pmap) {
		userDao = SqlSessionUtil.getSession().getMapper(UserDao.class);
		//得到当前页
		int pageNo = 1;
		if(pageNoStr!=null&&!"".equals(pageNoStr.trim())){
			pageNo = Integer.valueOf(pageNoStr);
		}
		
		//获得每页显示多少条记录
		int pageCount = 5;
		
		//获得总记录数
		int total = userDao.getTotal(pmap);
		
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
		
		
		
		//使用map1装 用来分页的map以及条件查询的map
		Map map1 = new HashMap();
		map1.put("pumap", map);
		map1.put("pmap", pmap);
		
		
		//获得需要返回的第二个元素  当前页的显示列表
		List<User> uList = userDao.getAll(map1);
		
		//最后将两个元素打包成map,进行返回
		Map rmap = new HashMap();
		rmap.put("pu",pu);
		rmap.put("uList", uList);
		
		return rmap;
	}

	@Override
	public void changeLs(String param) {
		userDao = SqlSessionUtil.getSession().getMapper(UserDao.class);
		//javascript:void(aaaaaaaaaaaaaaaaaaaaaaaaaa)
		
		String[] paramarr = param.split("\\(");
		
		String id = paramarr[1].substring(0,32);
		
		//通过id获取user
		User user = userDao.getById(id);
		
		//查看到当前的user是什么状态
		//除了0为锁定,其他的任何值都是启用
		String lockStatus = user.getLockStatus();
		
		if("0".equals(lockStatus)){
			lockStatus = "1";
		}else{
			lockStatus = "0";
		}
		
		user.setLockStatus(lockStatus);
		
		userDao.updateLockStatus(user);
		
		
	}
	
	@Override
	public User login(String act, String pwd, String ip) {
		userDao = SqlSessionUtil.getSession().getMapper(UserDao.class);
		User user = userDao.getByActAndPwd(act,pwd);
		
		String info = "";
		
		if(user==null){
			//没有用户名和密码,登录失败
			throw new ApplicationException("用户名或密码不正确");
		}
		
		//判断ip地址
		String allowIps = user.getAllowIps();
		if(!allowIps.contains(ip)){
			//ip地址受限,登录失败
			//return user;
			throw new ApplicationException("ip地址受限,请联系管理员");
		}
		
		//判断是否锁定
		String lockstatus = user.getLockStatus();
		if("0".equals(lockstatus)){
			//用户锁定,登录失败
			throw new ApplicationException("用户锁定,请联系管理员");
		}
		
		String expireTime = user.getExpireTime();
		String currentTime = DateUtil.getCurrentTime();
		
		if(expireTime.compareTo(currentTime)<=0){
			//失效时间已过,登录失败
			throw new ApplicationException("用户失效,请联系管理员");
		}
		
		
		return user;
	}

}

























