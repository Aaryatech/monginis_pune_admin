package com.ats.adminpanel.model.einv;

public class DocSetails {

	/// <summary>
    /// Required Parameter - "description": "Document Type: INVOICE, CREDIT NOTE, DEBIT NOTE"
    /// </summary>
    public String Typ ;
    /// <summary>
    ///Required Parameter - "Document Number"
    /// </summary>
    public String No ;
    /// <summary>
    ///Required Parameter - "Document Date"
    /// </summary>
    public String Dt ; //
    //public String OrgInvNo ;
	public String getTyp() {
		return Typ;
	}
	public void setTyp(String typ) {
		Typ = typ;
	}
	public String getNo() {
		return No;
	}
	public void setNo(String no) {
		No = no;
	}
	public String getDt() {
		return Dt;
	}
	public void setDt(String dt) {
		Dt = dt;
	}
	@Override
	public String toString() {
		return "DocSetails [Typ=" + Typ + ", No=" + No + ", Dt=" + Dt + "]";
	}
    
    
	
}
