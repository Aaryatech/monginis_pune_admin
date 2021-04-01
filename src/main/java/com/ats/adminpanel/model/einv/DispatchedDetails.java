package com.ats.adminpanel.model.einv;

public class DispatchedDetails {

	/// <summary>
    ///Required Parameter - "Name of the company from which the goods are dispatched"
    /// </summary>
    public String Nm ;
    /// <summary>
    ///Required Parameter - "Address 1 of the entity from which goods are dispatched.(Building/Flat no.Road/Street etc.)"
    /// </summary>
    public String Addr1 ;
    /// <summary>
    /// "Address 2 of the entity from which goods are dispatched. (Floor no., Name of the premises/building)"
    /// </summary>
    public String Addr2 ;
    /// <summary>
    ///Required Parameter - "Location"
    /// </summary>
    public String Loc ;
    /// <summary>
    ///Required Parameter - "Pincode"
    /// </summary>
    public String Pin ;
    /// <summary>
    ///Required Parameter - "State Code"
    /// </summary>
    public String Stcd ;
	public String getNm() {
		return Nm;
	}
	public void setNm(String nm) {
		Nm = nm;
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
	public String getPin() {
		return Pin;
	}
	public void setPin(String pin) {
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
		return "DispatchedDetails [Nm=" + Nm + ", Addr1=" + Addr1 + ", Addr2=" + Addr2 + ", Loc=" + Loc + ", Pin=" + Pin
				+ ", Stcd=" + Stcd + "]";
	}
    
    
}
