package com.bjpowernode.crm.workbench.activity.dao;

import com.bjpowernode.crm.workbench.activity.domain.MarketActivity;

/**
 * dao接口层也就是持久层,业务处理层
 * @author Administrator
 *
 */
public interface MarketActivityDao {
	/**
	 * 保存新创建的市场活动
	 * @param activity
	 * @return
	 */
	public int saveCreateMarketActivity(MarketActivity activity);
	
}
