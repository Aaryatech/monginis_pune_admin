package com.ats.adminpanel.model.einv;

import java.util.List;

public class RespAuthPl {

	public int Status;
	
    public AuthSuccessRespPl Data;  
    public List<RespErrDetailsPl> ErrorDetails ;
    public List<RespInfoDtlsPl> InfoDtls;
	public int getStatus() {
		return Status;
	}
	public void setStatus(int status) {
		Status = status;
	}
	public AuthSuccessRespPl getData() {
		return Data;
	}
	public void setData(AuthSuccessRespPl data) {
		Data = data;
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
		return "RespAuthPl [Status=" + Status + ", Data=" + Data + ", ErrorDetails=" + ErrorDetails + ", InfoDtls="
				+ InfoDtls + "]";
	}
	
}
