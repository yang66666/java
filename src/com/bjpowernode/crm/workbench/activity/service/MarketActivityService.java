package com.bjpowernode.crm.workbench.activity.service;

import com.bjpowernode.crm.workbench.activity.domain.MarketActivity;
/**
 * 保存新建市场活动接口
 * @author Administrator
 *
 */
public interface MarketActivityService {
	/**
	 * 保存新创建的市场活动
	 * @param activity
	 * @return
	 */
	public int saveCreateMarketActivity(MarketActivity activity);
}
