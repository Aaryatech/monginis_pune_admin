package com.ats.adminpanel.model.einv;

import java.util.List;

public class RespPlCancelIRN {
	private String Status;
	 public List<RespErrDetailsPl> ErrorDetails ;
	    public List<RespInfoDtlsPl> InfoDtls;
	    
	 Object Data;
	 
	 
	public Object getData() {
		return Data;
	}
	public void setData(Object data) {
		Data = data;
	}

	private String Irn;
	private String CancelDate;
	
	public String getIrn() {
		return Irn;
	}
	public void setIrn(String irn) {
		Irn = irn;
	}
	public String getCancelDate() {
		return CancelDate;
	}
	public void setCancelDate(String cancelDate) {
		CancelDate = cancelDate;
	}
	
	
	
	
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	public List<RespErrDetailsPl> getErrorDetails() {
		return ErrorDetails;
	}
	public void setErrorDetails(List<RespErrDetailsPl> errorDetails) {
		ErrorDetails = errorDetails;
	}
	public List<RespInfoDtlsPl> getInfoDtls() {
		return InfoDtls;
	}
	public void setInfoDtls(List<RespInfoDtlsPl> infoDtls) {
		InfoDtls = infoDtls;
	}
	
	@Override
	public String toString() {
		return "RespPlCancelIRN [Status=" + Status + ", ErrorDetails=" + ErrorDetails + ", InfoDtls=" + InfoDtls
				+ ", Irn=" + Irn + ", CancelDate=" + CancelDate + "]";
	}
	
	
	
}
