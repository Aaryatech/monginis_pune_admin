package com.ats.adminpanel.model;

public class CalCulateTray {

	private int orderId;

	private int frId;

	private int frRouteId;

	private int subCatId;

	private String frName;

	private String subCatName;

	private float orderQty;

	private float trayQty;

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
	}

	public int getSubCatId() {
		return subCatId;
	}

	public void setSubCatId(int subCatId) {
		this.subCatId = subCatId;
	}

	public String getFrName() {
		return frName;
	}

	public void setFrName(String frName) {
		this.frName = frName;
	}

	public String getSubCatName() {
		return subCatName;
	}

	public void setSubCatName(String subCatName) {
		this.subCatName = subCatName;
	}

	public float getOrderQty() {
		return orderQty;
	}

	public void setOrderQty(float orderQty) {
		this.orderQty = orderQty;
	}

	public float getTrayQty() {
		return trayQty;
	}

	public void setTrayQty(float trayQty) {
		this.trayQty = trayQty;
	}

	public int getFrRouteId() {
		return frRouteId;
	}

	public void setFrRouteId(int frRouteId) {
		this.frRouteId = frRouteId;
	}

	@Override
	public String toString() {
		return "CalCulateTray [orderId=" + orderId + ", frId=" + frId + ", frRouteId=" + frRouteId + ", subCatId="
				+ subCatId + ", frName=" + frName + ", subCatName=" + subCatName + ", orderQty=" + orderQty
				+ ", trayQty=" + trayQty + "]";
	}

}
