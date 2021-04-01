package com.ats.adminpanel.model.einv;

public class ValDetails {
	/// <summary>
    ///Required Parameter - "Total Assessable value of all items"
    /// </summary>
    public double AssVal ;
    /// <summary>
    /// "Total CGST value of all items"
    /// </summary>
    public double CgstVal ;
    /// <summary>
    /// "Total SGST value of all items"
    /// </summary>
    public double SgstVal ;
    /// <summary>
    /// "Total IGST value of all items"
    /// </summary>
    public double IgstVal ;
    /// <summary>
    /// "Total CESS value of all items"
    /// </summary>
    public double CesVal ;
    //public double CesNonAdVal ;
    /// <summary>
    /// "Total State CESS value of all items"
    /// </summary>
    public double StCesVal ;
    /// <summary>
    /// "Rounded off amount"
    /// </summary>
    public double RndOffAmt ;
    /// <summary>
    ///Required Parameter - "Final Invoice value "
    /// </summary>
    public double TotInvVal ;
    /// <summary>
    /// "Final Invoice value in Additional Currency"
    /// </summary>
    public double TotInvValFc ;
	public double getAssVal() {
		return AssVal;
	}
	public void setAssVal(double assVal) {
		AssVal = assVal;
	}
	public double getCgstVal() {
		return CgstVal;
	}
	public void setCgstVal(double cgstVal) {
		CgstVal = cgstVal;
	}
	public double getSgstVal() {
		return SgstVal;
	}
	public void setSgstVal(double sgstVal) {
		SgstVal = sgstVal;
	}
	public double getIgstVal() {
		return IgstVal;
	}
	public void setIgstVal(double igstVal) {
		IgstVal = igstVal;
	}
	public double getCesVal() {
		return CesVal;
	}
	public void setCesVal(double cesVal) {
		CesVal = cesVal;
	}
	public double getStCesVal() {
		return StCesVal;
	}
	public void setStCesVal(double stCesVal) {
		StCesVal = stCesVal;
	}
	public double getRndOffAmt() {
		return RndOffAmt;
	}
	public void setRndOffAmt(double rndOffAmt) {
		RndOffAmt = rndOffAmt;
	}
	public double getTotInvVal() {
		return TotInvVal;
	}
	public void setTotInvVal(double totInvVal) {
		TotInvVal = totInvVal;
	}
	public double getTotInvValFc() {
		return TotInvValFc;
	}
	public void setTotInvValFc(double totInvValFc) {
		TotInvValFc = totInvValFc;
	}
	@Override
	public String toString() {
		return "ValDetails [AssVal=" + AssVal + ", CgstVal=" + CgstVal + ", SgstVal=" + SgstVal + ", IgstVal=" + IgstVal
				+ ", CesVal=" + CesVal + ", StCesVal=" + StCesVal + ", RndOffAmt=" + RndOffAmt + ", TotInvVal="
				+ TotInvVal + ", TotInvValFc=" + TotInvValFc + "]";
	}
    
    
}
