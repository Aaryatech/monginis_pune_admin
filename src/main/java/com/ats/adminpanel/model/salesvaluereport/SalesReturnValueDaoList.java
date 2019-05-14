package com.ats.adminpanel.model.salesvaluereport;

import java.util.List;

public class SalesReturnValueDaoList {

	private String month;
	private float monthTotal;

	private List<SalesReturnValueDao> salesReturnQtyValueList;

	public float getMonthTotal() {
		return monthTotal;
	}

	public void setMonthTotal(float monthTotal) {
		this.monthTotal = monthTotal;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public List<SalesReturnValueDao> getSalesReturnQtyValueList() {
		return salesReturnQtyValueList;
	}

	public void setSalesReturnQtyValueList(List<SalesReturnValueDao> salesReturnQtyValueList) {
		this.salesReturnQtyValueList = salesReturnQtyValueList;
	}

	@Override
	public String toString() {
		return "SalesReturnValueDaoList [month=" + month + ", monthTotal=" + monthTotal + ", salesReturnQtyValueList="
				+ salesReturnQtyValueList + "]";
	}

}
