package com.ats.adminpanel.model;


public class LineMaster {
	private int lineId;
	
	private String lineName;
	
	private String updtDttime;
	
	private String exVar1;
	private String exVar2;
	
	private int exInt1;
	private int exInt2;
	
	private int delStatus;

	public int getLineId() {
		return lineId;
	}

	public void setLineId(int lineId) {
		this.lineId = lineId;
	}

	public String getLineName() {
		return lineName;
	}

	public void setLineName(String lineName) {
		this.lineName = lineName;
	}

	public String getUpdtDttime() {
		return updtDttime;
	}

	public void setUpdtDttime(String updtDttime) {
		this.updtDttime = updtDttime;
	}

	public String getExVar1() {
		return exVar1;
	}

	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}

	public String getExVar2() {
		return exVar2;
	}

	public void setExVar2(String exVar2) {
		this.exVar2 = exVar2;
	}

	public int getExInt1() {
		return exInt1;
	}

	public void setExInt1(int exInt1) {
		this.exInt1 = exInt1;
	}

	public int getExInt2() {
		return exInt2;
	}

	public void setExInt2(int exInt2) {
		this.exInt2 = exInt2;
	}

	public int getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}

	@Override
	public String toString() {
		return "LineMaster [lineId=" + lineId + ", lineName=" + lineName + ", updtDttime=" + updtDttime + ", exVar1="
				+ exVar1 + ", exVar2=" + exVar2 + ", exInt1=" + exInt1 + ", exInt2=" + exInt2 + ", delStatus="
				+ delStatus + "]";
	}
	
}
