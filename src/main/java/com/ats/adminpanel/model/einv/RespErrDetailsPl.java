package com.ats.adminpanel.model.einv;


public class RespErrDetailsPl {

	public String ErrorCode ;
    public String ErrorMessage ;
	public String getErrorCode() {
		return ErrorCode;
	}
	public void setErrorCode(String errorCode) {
		ErrorCode = errorCode;
	}
	public String getErrorMessage() {
		return ErrorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		ErrorMessage = errorMessage;
	}
	@Override
	public String toString() {
		return "RespErrDetailsPl [ErrorCode=" + ErrorCode + ", ErrorMessage=" + ErrorMessage + "]";
	}
    
    
    
	
    
    
}
