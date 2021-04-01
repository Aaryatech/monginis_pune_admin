package com.ats.adminpanel.model.einv;

public class TranDetails {

	 /// <summary>
    /// Required Parameter - "GST- Goods and Services Tax Scheme"
    /// </summary>
    public String TaxSch ;
    /// <summary>
    /// Required Parameter - supply Type
    /// </summary>
    public String SupTyp ;
    //public String Catg ;
    /// <summary>
    /// "Y- whether the tax liability is payable under reverse charge"
    /// </summary>
    public String RegRev ;
    //public String Typ ;
    //public String EcmTrn ;
    /// <summary>
    /// "GSTIN of e-Commerce operator"
    /// </summary>
    public String EcmGstin ;
    //public bool EcmTrnSel ;
	public String getTaxSch() {
		return TaxSch;
	}
	public void setTaxSch(String taxSch) {
		TaxSch = taxSch;
	}
	public String getSupTyp() {
		return SupTyp;
	}
	public void setSupTyp(String supTyp) {
		SupTyp = supTyp;
	}
	public String getRegRev() {
		return RegRev;
	}
	public void setRegRev(String regRev) {
		RegRev = regRev;
	}
	public String getEcmGstin() {
		return EcmGstin;
	}
	public void setEcmGstin(String ecmGstin) {
		EcmGstin = ecmGstin;
	}
	@Override
	public String toString() {
		return "TranDetails [TaxSch=" + TaxSch + ", SupTyp=" + SupTyp + ", RegRev=" + RegRev + ", EcmGstin=" + EcmGstin
				+ "]";
	}
    
    
    
	
}
