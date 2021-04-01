package com.ats.adminpanel.model.einv;

public class PrecDocument {
	/// <summary>
    ///Required Parameter - "Reference of original invoice, if any."
    /// </summary>
    public String InvNo ;
    /// <summary>
    ///Required Parameter - "Date of preceding invoice"
    /// </summary>
    public String InvDt ;
    /// <summary>
    /// "Other Reference"
    /// </summary>
    public String OthRefNo ;
	public String getInvNo() {
		return InvNo;
	}
	public void setInvNo(String invNo) {
		InvNo = invNo;
	}
	public String getInvDt() {
		return InvDt;
	}
	public void setInvDt(String invDt) {
		InvDt = invDt;
	}
	public String getOthRefNo() {
		return OthRefNo;
	}
	public void setOthRefNo(String othRefNo) {
		OthRefNo = othRefNo;
	}
	@Override
	public String toString() {
		return "PrecDocument [InvNo=" + InvNo + ", InvDt=" + InvDt + ", OthRefNo=" + OthRefNo + "]";
	}
    
    
    
}
