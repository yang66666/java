package com.bjpowernode.crm.util;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionUtil {
	private static SqlSessionFactory sqlSessionFactory;
	private static ThreadLocal<SqlSession> t = new ThreadLocal<SqlSession>();
	static{
		String resource = "mybatis.xml";
		InputStream inputStream = null;
		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
	}
	
	public static SqlSession getSession(){
		
		SqlSession session = t.get();
		if(session==null){
			session = sqlSessionFactory.openSession();
			t.set(session);
		}
		return session;
		
	}
	
	public static void myClose(SqlSession session){
		if(session!=null){
			session.close();
		}
		session = null;
		t.remove();
	}
	
}


















