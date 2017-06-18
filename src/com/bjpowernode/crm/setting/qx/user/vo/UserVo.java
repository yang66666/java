package com.bjpowernode.crm.setting.qx.user.vo;

import com.bjpowernode.crm.setting.dept.dao.DeptDao;
import com.bjpowernode.crm.setting.dept.domain.Dept;
import com.bjpowernode.crm.util.SqlSessionUtil;

public class UserVo {
	
	private String id;
	private String loginAct;
	private String loginPwd;
	private String name;
	private String deptNo;
	private String expireTime;
	private String lockStatus;
	private String allowIps;
	private String email;
	private String createBy;
	private String createTime;
	private String editBy;
	private String editTime;
	
	private String deptName;	//显示部门名称
	private String lockStatusText;	//显示锁定状态文本
	
	private DeptDao dd = null;//
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLoginAct() {
		return loginAct;
	}
	public void setLoginAct(String loginAct) {
		this.loginAct = loginAct;
	}
	public String getLoginPwd() {
		return loginPwd;
	}
	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}
	public String getExpireTime() {
		return expireTime;
	}
	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}
	public String getLockStatus() {
		return lockStatus;
	}
	public void setLockStatus(String lockStatus) {
		this.lockStatus = lockStatus;
	}
	public String getAllowIps() {
		return allowIps;
	}
	public void setAllowIps(String allowIps) {
		this.allowIps = allowIps;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getEditBy() {
		return editBy;
	}
	public void setEditBy(String editBy) {
		this.editBy = editBy;
	}
	public String getEditTime() {
		return editTime;
	}
	public void setEditTime(String editTime) {
		this.editTime = editTime;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptNo) {
		dd = SqlSessionUtil.getSession().getMapper(DeptDao.class);
		String name = dd.getNameByNo(deptNo);
		this.deptName = name;
	}
	public String getLockStatusText() {
		return lockStatusText;
	}
	public void setLockStatusText(String lockStatus) {
		//this.lockStatusText = lockStatusText;
		
		if("0".equals(lockStatus)){
			this.lockStatusText = "锁定";
		}else{
			this.lockStatusText = "启用";
		
		}
	}
	
	
	
	
}






