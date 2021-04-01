package com.ats.adminpanel.model.einv;

public class BatchDetails {
	/// <summary>
    ///Required Parameter - "Batch name"
    /// </summary>
    public String Nm ;
    /// <summary>
    /// "Batch Expiry Date"
    /// </summary>
    public String ExpDt ;
    /// <summary>
    /// "Warranty Date"
    /// </summary>
    public String WrDt ;
	public String getNm() {
		return Nm;
	}
	public void setNm(String nm) {
		Nm = nm;
	}
	public String getExpDt() {
		return ExpDt;
	}
	public void setExpDt(String expDt) {
		ExpDt = expDt;
	}
	public String getWrDt() {
		return WrDt;
	}
	public void setWrDt(String wrDt) {
		WrDt = wrDt;
	}
	@Override
	public String toString() {
		return "BatchDetails [Nm=" + Nm + ", ExpDt=" + ExpDt + ", WrDt=" + WrDt + "]";
	}
    
    
}
