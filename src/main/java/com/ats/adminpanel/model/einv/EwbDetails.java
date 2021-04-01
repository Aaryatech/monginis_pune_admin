package com.ats.adminpanel.model.einv;

public class EwbDetails {
	/// <summary>
    /// "Transin/GSTIN"
    /// </summary>
    public String TransId ;
    /// <summary>
    /// "Name of the transporter"
    /// </summary>
    public String TransName ;
    /// <summary>
    ///Required Parameter - "Mode of transport (Road-1, Rail-2, Air-3, Ship-4)"
    /// </summary>
    public String TransMode ;
    /// <summary>
    ///Required Parameter - "Distance between source and destination PIN codes"
    /// </summary>
    public String Distance ;
    /// <summary>
    /// "Tranport Document Number"
    /// </summary>
    public String TransDocNo ;
    /// <summary>
    /// "Transport Document Date"
    /// </summary>
    public String TransDocDt ;
    /// <summary>
    /// "Vehicle Number"
    /// </summary>
    public String VehNo ;
    /// <summary>
    /// "Whether O-ODC or R-Regular "
    /// </summary>
    public String VehType ;
	public String getTransId() {
		return TransId;
	}
	public void setTransId(String transId) {
		TransId = transId;
	}
	public String getTransName() {
		return TransName;
	}
	public void setTransName(String transName) {
		TransName = transName;
	}
	public String getTransMode() {
		return TransMode;
	}
	public void setTransMode(String transMode) {
		TransMode = transMode;
	}
	public String getDistance() {
		return Distance;
	}
	public void setDistance(String distance) {
		Distance = distance;
	}
	public String getTransDocNo() {
		return TransDocNo;
	}
	public void setTransDocNo(String transDocNo) {
		TransDocNo = transDocNo;
	}
	public String getTransDocDt() {
		return TransDocDt;
	}
	public void setTransDocDt(String transDocDt) {
		TransDocDt = transDocDt;
	}
	public String getVehNo() {
		return VehNo;
	}
	public void setVehNo(String vehNo) {
		VehNo = vehNo;
	}
	public String getVehType() {
		return VehType;
	}
	public void setVehType(String vehType) {
		VehType = vehType;
	}
	@Override
	public String toString() {
		return "EwbDetails [TransId=" + TransId + ", TransName=" + TransName + ", TransMode=" + TransMode
				+ ", Distance=" + Distance + ", TransDocNo=" + TransDocNo + ", TransDocDt=" + TransDocDt + ", VehNo="
				+ VehNo + ", VehType=" + VehType + "]";
	}
    
    
}
