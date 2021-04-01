package com.ats.adminpanel.model.einv;

import java.io.Serializable;
import java.util.List;

//Response class for Einv Gen Response

public class RespPlGenIRN implements Serializable {
	
	
	  /**
	 * 
	 */
	
	private static final long serialVersionUID = 1L;
	public String AckNo ; public String AckDt ; public String Irn; public String
	SignedInvoice;
	public String SignedQRCode;
	public String Status; public
	  String EwbNo; public String EwbDt; public String EwbValidTill; public
	  RespGenIRNInvData ExtractedSignedInvoiceData;
	 
	
    private RespGenIRNInvData Data; //Main Response..
    public List<RespErrDetailsPl> ErrorDetails ;
    public List<RespInfoDtlsPl> InfoDtls;
    public List<RespErrDetailsPl> getErrorDetails() {
		return ErrorDetails;
	}
	public void setErrorDetails(List<RespErrDetailsPl> errorDetails) {
		ErrorDetails = errorDetails;
	}

	
	public String status_cd,error_cd,error_message;
	 
	
	
	public String getStatus_cd() {
		return status_cd;
	}
	public void setStatus_cd(String status_cd) {
		this.status_cd = status_cd;
	}
	public String getError_cd() {
		return error_cd;
	}
	public void setError_cd(String error_cd) {
		this.error_cd = error_cd;
	}
	public String getError_message() {
		return error_message;
	}
	public void setError_message(String error_message) {
		this.error_message = error_message;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public List<RespInfoDtlsPl> getInfoDtls() {
		return InfoDtls;
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	public void setInfoDtls(List<RespInfoDtlsPl> infoDtls) {
		InfoDtls = infoDtls;
	}
	public RespGenIRNInvData getData() {
		return Data;
	}
	public void setData(RespGenIRNInvData data) {
		Data = data;
	}
	
	
	
	
	public String getAckNo() {
		return AckNo;
	}
	public void setAckNo(String ackNo) {
		AckNo = ackNo;
	}
	public String getAckDt() {
		return AckDt;
	}
	public void setAckDt(String ackDt) {
		AckDt = ackDt;
	}
	public String getIrn() {
		return Irn;
	}
	public void setIrn(String irn) {
		Irn = irn;
	}
	public String getSignedInvoice() {
		return SignedInvoice;
	}
	public void setSignedInvoice(String signedInvoice) {
		SignedInvoice = signedInvoice;
	}
	public String getSignedQRCode() {
		return SignedQRCode;
	}
	public void setSignedQRCode(String signedQRCode) {
		SignedQRCode = signedQRCode;
	}
	public String getEwbNo() {
		return EwbNo;
	}
	public void setEwbNo(String ewbNo) {
		EwbNo = ewbNo;
	}
	public String getEwbDt() {
		return EwbDt;
	}
	public void setEwbDt(String ewbDt) {
		EwbDt = ewbDt;
	}
	public String getEwbValidTill() {
		return EwbValidTill;
	}
	public void setEwbValidTill(String ewbValidTill) {
		EwbValidTill = ewbValidTill;
	}
	public RespGenIRNInvData getExtractedSignedInvoiceData() {
		return ExtractedSignedInvoiceData;
	}
	public void setExtractedSignedInvoiceData(RespGenIRNInvData extractedSignedInvoiceData) {
		ExtractedSignedInvoiceData = extractedSignedInvoiceData;
	}
	@Override
	public String toString() {
		return "RespPlGenIRN [AckNo=" + AckNo + ", AckDt=" + AckDt + ", Irn=" + Irn + ", SignedInvoice=" + SignedInvoice
				+ ", SignedQRCode=" + SignedQRCode + ", Status=" + Status + ", EwbNo=" + EwbNo + ", EwbDt=" + EwbDt
				+ ", EwbValidTill=" + EwbValidTill + ", ExtractedSignedInvoiceData=" + ExtractedSignedInvoiceData
				+ ", Data=" + Data + ", ErrorDetails=" + ErrorDetails + ", InfoDtls=" + InfoDtls + ", status_cd="
				+ status_cd + ", error_cd=" + error_cd + ", error_message=" + error_message + "]";
	}
	
	/*
	 * public RespPlGenIRN(String ackNo, String ackDt, String irn, String
	 * signedInvoice, String signedQRCode, String status, String ewbNo, String
	 * ewbDt, String ewbValidTill, RespGenIRNInvData extractedSignedInvoiceData,
	 * RespGenIRNInvData data, List<RespErrDetailsPl> errorDetails,
	 * List<RespInfoDtlsPl> infoDtls, String status_cd, String error_cd, String
	 * error_message) { super(); AckNo = ackNo; AckDt = ackDt; Irn = irn;
	 * SignedInvoice = signedInvoice; SignedQRCode = signedQRCode; Status = status;
	 * EwbNo = ewbNo; EwbDt = ewbDt; EwbValidTill = ewbValidTill;
	 * ExtractedSignedInvoiceData = extractedSignedInvoiceData; Data = data;
	 * ErrorDetails = errorDetails; InfoDtls = infoDtls; this.status_cd = status_cd;
	 * this.error_cd = error_cd; this.error_message = error_message; }
	 */
  
    
	
	
}
