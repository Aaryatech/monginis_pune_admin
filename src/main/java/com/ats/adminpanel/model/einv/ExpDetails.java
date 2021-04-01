package com.ats.adminpanel.model.einv;

public class ExpDetails {

	 /// <summary>
    /// "Shipping Bill No."
    /// </summary>
    public String ShipBNo ;
    /// <summary>
    ///  "Shipping Bill Date"
    /// </summary>
    public String ShipBDt ;
    /// <summary>
    /// "Country Code"
    /// </summary>
    public String CntCode ;
    /// <summary>
    /// "Additional Currency Code"
    /// </summary>
    public String ForCur ;
    public double InvForCur ;
    /// <summary>
    /// "Port Code"
    /// </summary>
    public String Port ;
    /// <summary>
    ///  "Options for supplier for refund. Y/N"
    /// </summary>
    public String RefClm ;
	public String getShipBNo() {
		return ShipBNo;
	}
	public void setShipBNo(String shipBNo) {
		ShipBNo = shipBNo;
	}
	public String getShipBDt() {
		return ShipBDt;
	}
	public void setShipBDt(String shipBDt) {
		ShipBDt = shipBDt;
	}
	public String getCntCode() {
		return CntCode;
	}
	public void setCntCode(String cntCode) {
		CntCode = cntCode;
	}
	public String getForCur() {
		return ForCur;
	}
	public void setForCur(String forCur) {
		ForCur = forCur;
	}
	public double getInvForCur() {
		return InvForCur;
	}
	public void setInvForCur(double invForCur) {
		InvForCur = invForCur;
	}
	public String getPort() {
		return Port;
	}
	public void setPort(String port) {
		Port = port;
	}
	public String getRefClm() {
		return RefClm;
	}
	public void setRefClm(String refClm) {
		RefClm = refClm;
	}
	@Override
	public String toString() {
		return "ExpDetails [ShipBNo=" + ShipBNo + ", ShipBDt=" + ShipBDt + ", CntCode=" + CntCode + ", ForCur=" + ForCur
				+ ", InvForCur=" + InvForCur + ", Port=" + Port + ", RefClm=" + RefClm + "]";
	}
    
    
}
