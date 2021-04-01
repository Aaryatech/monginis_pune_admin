package com.ats.adminpanel.model.einv;


public class AuthSuccessRespPl {

	public String ClientId ;
    public String UserName ;
    public String AuthToken ;
    public String Sek ;
    public String TokenExpiry ;
	public String getClientId() {
		return ClientId;
	}
	public void setClientId(String clientId) {
		ClientId = clientId;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}
	public String getAuthToken() {
		return AuthToken;
	}
	public void setAuthToken(String authToken) {
		AuthToken = authToken;
	}
	public String getSek() {
		return Sek;
	}
	public void setSek(String sek) {
		Sek = sek;
	}
	public String getTokenExpiry() {
		return TokenExpiry;
	}
	public void setTokenExpiry(String tokenExpiry) {
		TokenExpiry = tokenExpiry;
	}
	@Override
	public String toString() {
		return "AuthSuccessRespPl [ClientId=" + ClientId + ", UserName=" + UserName + ", AuthToken=" + AuthToken
				+ ", Sek=" + Sek + ", TokenExpiry=" + TokenExpiry + "]";
	}
    
    
    
}
