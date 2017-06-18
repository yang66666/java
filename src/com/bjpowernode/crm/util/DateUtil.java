package com.bjpowernode.crm.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	
	private DateUtil(){}
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public static String getCurrentTime() {
		Date d = new Date();
		String dateStr = sdf.format(d);
		return dateStr;
	}

}
