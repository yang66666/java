package com.bjpowernode.crm.exception;

/**
 * 自定义异常,用来做登录操作提示用
 * @author ymj
 *
 */
public class ApplicationException extends RuntimeException{
	
	public ApplicationException(){}
	
	public ApplicationException(String msg){
		super(msg);
	}
	
}
