package com.ats.adminpanel.model.einv;

public class RefDetails {

	// <summary>
    /// "Remarks/Note"
    /// </summary>
    public String InvRmk ;
    /// <summary>
    ///Required Parameter - "Invoice Period Start Date"
    /// </summary>
    public String InvStDt ;
    /// <summary>
    ///Required Parameter - "Invoice Period End Date"
    /// </summary>
    public String InvEndDt ;
    public PrecDocument PrecDocDtls ;
	public String getInvRmk() {
		return InvRmk;
	}
	public void setInvRmk(String invRmk) {
		InvRmk = invRmk;
	}
	public String getInvStDt() {
		return InvStDt;
	}
	public void setInvStDt(String invStDt) {
		InvStDt = invStDt;
	}
	public String getInvEndDt() {
		return InvEndDt;
	}
	public void setInvEndDt(String invEndDt) {
		InvEndDt = invEndDt;
	}
	public PrecDocument getPrecDocDtls() {
		return PrecDocDtls;
	}
	public void setPrecDocDtls(PrecDocument precDocDtls) {
		PrecDocDtls = precDocDtls;
	}
	@Override
	public String toString() {
		return "RefDetails [InvRmk=" + InvRmk + ", InvStDt=" + InvStDt + ", InvEndDt=" + InvEndDt + ", PrecDocDtls="
				+ PrecDocDtls + "]";
	}
	
}
