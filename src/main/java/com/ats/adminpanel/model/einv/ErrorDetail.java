package com.ats.adminpanel.model.einv;

public class ErrorDetail {

private String ErrorCode;
private String ErrorMessage;
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
	return "ErrorDetail [ErrorCode=" + ErrorCode + ", ErrorMessage=" + ErrorMessage + "]";
}



}
