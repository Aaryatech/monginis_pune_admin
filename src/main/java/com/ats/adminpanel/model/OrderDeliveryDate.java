package com.ats.adminpanel.model;

public class OrderDeliveryDate {
	
	private int frId;
	private double ttlAmt;
	private String frName;
	public int getFrId() {
		return frId;
	}
	public void setFrId(int frId) {
		this.frId = frId;
	}
	public double getTtlAmt() {
		return ttlAmt;
	}
	public void setTtlAmt(double ttlAmt) {
		this.ttlAmt = ttlAmt;
	}
	public String getFrName() {
		return frName;
	}
	public void setFrName(String frName) {
		this.frName = frName;
	}
	@Override
	public String toString() {
		return "OrderDeliveryDate [frId=" + frId + ", ttlAmt=" + ttlAmt + ", frName=" + frName + "]";
	}
	
	
	
}
