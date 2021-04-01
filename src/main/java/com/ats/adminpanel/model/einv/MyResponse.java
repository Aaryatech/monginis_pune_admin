package com.ats.adminpanel.model.einv;

public class MyResponse {

	public String Status;
	private MyData Data;
	
	
	private String ErrorDetails;

	private String InfoDtls;

	private String status_cd;
	private String error_cd;
	private String error_message;
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	public MyData getData() {
		return Data;
	}
	public void setData(MyData data) {
		Data = data;
	}
	
	
	public String getErrorDetails() {
		return ErrorDetails;
	}
	public void setErrorDetails(String errorDetails) {
		ErrorDetails = errorDetails;
	}
	public String getInfoDtls() {
		return InfoDtls;
	}
	public void setInfoDtls(String infoDtls) {
		InfoDtls = infoDtls;
	}
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
	@Override
	public String toString() {
		return "MyResponse [Status=" + Status + ", Data=" + Data + ", ErrorDetails=" + ErrorDetails + ", InfoDtls="
				+ InfoDtls + ", status_cd=" + status_cd + ", error_cd=" + error_cd + ", error_message=" + error_message
				+ "]";
	}
	
	
	
}
