package com.ats.adminpanel.model;

import java.util.List;
 

public class ServHeaderForPdf {
	
	private int servId;  
	private String servDate; 
	private int typeId; 
	private int dealerId;   
	private int servType; 
	private int servType2; 
	private String billNo; 
	private String billDate; 
	private int vehId;  
	private String vehNo; 
	private String servAdviseRem; 
	private String servDoneRem; 
	private float sprTot; 
	private float labChrge; 
	private float totalDisc; 
	private float totalExtra; 
	private float discOnBill; 
	private float extraOnBill; 
	private float taxAmt; 
	private float taxableAmt; 
	private float roundOff; 
	private float total; 
	private int servDoneKm; 
	private int nextDueKm; 
	private int isApproved; 
	private int delStatus; 
	private String billFile;
	private String varchar1; 
	private String varchar2; 
	private String typeName; 
	private String dealerName;
	private String vehName;
	private String city; 
	private String gstnNo;
	List<ServDetailForPdf> list;
	public int getServId() {
		return servId;
	}
	public void setServId(int servId) {
		this.servId = servId;
	}
	public String getServDate() {
		return servDate;
	}
	public void setServDate(String servDate) {
		this.servDate = servDate;
	}
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public int getDealerId() {
		return dealerId;
	}
	public void setDealerId(int dealerId) {
		this.dealerId = dealerId;
	}
	public int getServType() {
		return servType;
	}
	public void setServType(int servType) {
		this.servType = servType;
	}
	public int getServType2() {
		return servType2;
	}
	public void setServType2(int servType2) {
		this.servType2 = servType2;
	}
	public String getBillNo() {
		return billNo;
	}
	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}
	public String getBillDate() {
		return billDate;
	}
	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}
	public int getVehId() {
		return vehId;
	}
	public void setVehId(int vehId) {
		this.vehId = vehId;
	}
	public String getVehNo() {
		return vehNo;
	}
	public void setVehNo(String vehNo) {
		this.vehNo = vehNo;
	}
	public String getServAdviseRem() {
		return servAdviseRem;
	}
	public void setServAdviseRem(String servAdviseRem) {
		this.servAdviseRem = servAdviseRem;
	}
	public String getServDoneRem() {
		return servDoneRem;
	}
	public void setServDoneRem(String servDoneRem) {
		this.servDoneRem = servDoneRem;
	}
	public float getSprTot() {
		return sprTot;
	}
	public void setSprTot(float sprTot) {
		this.sprTot = sprTot;
	}
	public float getLabChrge() {
		return labChrge;
	}
	public void setLabChrge(float labChrge) {
		this.labChrge = labChrge;
	}
	public float getTotalDisc() {
		return totalDisc;
	}
	public void setTotalDisc(float totalDisc) {
		this.totalDisc = totalDisc;
	}
	public float getTotalExtra() {
		return totalExtra;
	}
	public void setTotalExtra(float totalExtra) {
		this.totalExtra = totalExtra;
	}
	public float getDiscOnBill() {
		return discOnBill;
	}
	public void setDiscOnBill(float discOnBill) {
		this.discOnBill = discOnBill;
	}
	public float getExtraOnBill() {
		return extraOnBill;
	}
	public void setExtraOnBill(float extraOnBill) {
		this.extraOnBill = extraOnBill;
	}
	public float getTaxAmt() {
		return taxAmt;
	}
	public void setTaxAmt(float taxAmt) {
		this.taxAmt = taxAmt;
	}
	public float getTaxableAmt() {
		return taxableAmt;
	}
	public void setTaxableAmt(float taxableAmt) {
		this.taxableAmt = taxableAmt;
	}
	public float getRoundOff() {
		return roundOff;
	}
	public void setRoundOff(float roundOff) {
		this.roundOff = roundOff;
	}
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	public int getServDoneKm() {
		return servDoneKm;
	}
	public void setServDoneKm(int servDoneKm) {
		this.servDoneKm = servDoneKm;
	}
	public int getNextDueKm() {
		return nextDueKm;
	}
	public void setNextDueKm(int nextDueKm) {
		this.nextDueKm = nextDueKm;
	}
	public int getIsApproved() {
		return isApproved;
	}
	public void setIsApproved(int isApproved) {
		this.isApproved = isApproved;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public String getBillFile() {
		return billFile;
	}
	public void setBillFile(String billFile) {
		this.billFile = billFile;
	}
	public String getVarchar1() {
		return varchar1;
	}
	public void setVarchar1(String varchar1) {
		this.varchar1 = varchar1;
	}
	public String getVarchar2() {
		return varchar2;
	}
	public void setVarchar2(String varchar2) {
		this.varchar2 = varchar2;
	}
	public List<ServDetailForPdf> getList() {
		return list;
	}
	public void setList(List<ServDetailForPdf> list) {
		this.list = list;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getGstnNo() {
		return gstnNo;
	}
	public void setGstnNo(String gstnNo) {
		this.gstnNo = gstnNo;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getDealerName() {
		return dealerName;
	}
	public void setDealerName(String dealerName) {
		this.dealerName = dealerName;
	}
	public String getVehName() {
		return vehName;
	}
	public void setVehName(String vehName) {
		this.vehName = vehName;
	}
	@Override
	public String toString() {
		return "ServHeaderForPdf [servId=" + servId + ", servDate=" + servDate + ", typeId=" + typeId + ", dealerId="
				+ dealerId + ", servType=" + servType + ", servType2=" + servType2 + ", billNo=" + billNo
				+ ", billDate=" + billDate + ", vehId=" + vehId + ", vehNo=" + vehNo + ", servAdviseRem="
				+ servAdviseRem + ", servDoneRem=" + servDoneRem + ", sprTot=" + sprTot + ", labChrge=" + labChrge
				+ ", totalDisc=" + totalDisc + ", totalExtra=" + totalExtra + ", discOnBill=" + discOnBill
				+ ", extraOnBill=" + extraOnBill + ", taxAmt=" + taxAmt + ", taxableAmt=" + taxableAmt + ", roundOff="
				+ roundOff + ", total=" + total + ", servDoneKm=" + servDoneKm + ", nextDueKm=" + nextDueKm
				+ ", isApproved=" + isApproved + ", delStatus=" + delStatus + ", billFile=" + billFile + ", varchar1="
				+ varchar1 + ", varchar2=" + varchar2 + ", typeName=" + typeName + ", dealerName=" + dealerName
				+ ", vehName=" + vehName + ", city=" + city + ", gstnNo=" + gstnNo + ", list=" + list + "]";
	}
	
	

}
