package com.ats.adminpanel.model.einv;

public class ShippedDetails {

	
	 /// <summary>
    ///"GSTIN of entity to whom goods are shipped"
    /// </summary>
    public String Gstin ;
    /// <summary>
    ///Required Parameter - "Legal Name"
    /// </summary>
    public String LglNm ;
    /// <summary>
    /// "Tradename"
    /// </summary>
    public String TrdNm ;
    /// <summary>
    ///Required Parameter - "Building/Flat no, Road/Street"
    /// </summary>
    public String Addr1 ;
    /// <summary>
    /// "Address 2 of the supplier (Floor no., Name of the premises/building)"
    /// </summary>
    public String Addr2 ;
    //public String Bno ;
    //public String Bnm ;
    //public String Flno ;
    /// <summary>
    ///Required Parameter - "Location"
    /// </summary>
    public String Loc ;
    //public String Dst ;
    /// <summary>
    ///Required Parameter - "Pincode"
    /// </summary>
    public int Pin ;
    /// <summary>
    ///Required Parameter - "State Code to which supplies are shipped to."
    /// </summary>
    public String Stcd ;
	public String getGstin() {
		return Gstin;
	}
	public void setGstin(String gstin) {
		Gstin = gstin;
	}
	public String getLglNm() {
		return LglNm;
	}
	public void setLglNm(String lglNm) {
		LglNm = lglNm;
	}
	public String getTrdNm() {
		return TrdNm;
	}
	public void setTrdNm(String trdNm) {
		TrdNm = trdNm;
	}
	public String getAddr1() {
		return Addr1;
	}
	public void setAddr1(String addr1) {
		Addr1 = addr1;
	}
	public String getAddr2() {
		return Addr2;
	}
	public void setAddr2(String addr2) {
		Addr2 = addr2;
	}
	public String getLoc() {
		return Loc;
	}
	public void setLoc(String loc) {
		Loc = loc;
	}
	public int getPin() {
		return Pin;
	}
	public void setPin(int pin) {
		Pin = pin;
	}
	public String getStcd() {
		return Stcd;
	}
	public void setStcd(String stcd) {
		Stcd = stcd;
	}
	@Override
	public String toString() {
		return "ShippedDetails [Gstin=" + Gstin + ", LglNm=" + LglNm + ", TrdNm=" + TrdNm + ", Addr1=" + Addr1
				+ ", Addr2=" + Addr2 + ", Loc=" + Loc + ", Pin=" + Pin + ", Stcd=" + Stcd + "]";
	}
    
	
}
