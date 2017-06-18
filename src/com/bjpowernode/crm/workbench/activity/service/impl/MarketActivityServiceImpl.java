package com.bjpowernode.crm.workbench.activity.service.impl;

import com.bjpowernode.crm.util.SqlSessionUtil;
import com.bjpowernode.crm.workbench.activity.dao.MarketActivityDao;
import com.bjpowernode.crm.workbench.activity.domain.MarketActivity;
import com.bjpowernode.crm.workbench.activity.service.MarketActivityService;
/**
 * 市场业务处理类
 * @author Administrator
 *
 */
public class MarketActivityServiceImpl implements MarketActivityService{
	//service层处理类需要调到层,动态代理
	private MarketActivityDao marketActivityDao = SqlSessionUtil.getSession().getMapper(MarketActivityDao.class);
	
	@Override
	public int saveCreateMarketActivity(MarketActivity activity) {
		
		//返回一个dao层接口中的方法
		return marketActivityDao.saveCreateMarketActivity(activity);
	}

}
