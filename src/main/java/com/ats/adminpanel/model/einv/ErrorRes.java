package com.ats.adminpanel.model.einv;

import java.util.List;

public class ErrorRes {
	private String Status;
	private Object Data;
	private List<ErrorDetail> ErrorDetails = null;
	private Object InfoDtls;
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	public Object getData() {
		return Data;
	}
	public void setData(Object data) {
		Data = data;
	}
	public List<ErrorDetail> getErrorDetails() {
		return ErrorDetails;
	}
	public void setErrorDetails(List<ErrorDetail> errorDetails) {
		ErrorDetails = errorDetails;
	}
	public Object getInfoDtls() {
		return InfoDtls;
	}
	public void setInfoDtls(Object infoDtls) {
		InfoDtls = infoDtls;
	}
	@Override
	public String toString() {
		return "ErrorRes [Status=" + Status + ", Data=" + Data + ", InfoDtls=" + InfoDtls + "]";
	}
	
	
	
	
	
}
