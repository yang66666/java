package com.bjpowernode.crm.util;

public class PageUtil {
	
	private int pageNo;	//��ǰҳ(��ǰ�ǵڼ�ҳ)
	private int pageCount = 5;	//ÿҳ��ʾ��������¼
	private int pageSize;	//��ҳ��
	private int total;	//�ܼ�¼��
	
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	
	
}
