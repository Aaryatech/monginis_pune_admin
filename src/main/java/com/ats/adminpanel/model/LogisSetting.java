package com.ats.adminpanel.model;
 

public class LogisSetting {
	
	 
	private int settingId; 
	private String key; 
	private String keyValue;
	public int getSettingId() {
		return settingId;
	}
	public void setSettingId(int settingId) {
		this.settingId = settingId;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getKeyValue() {
		return keyValue;
	}
	public void setKeyValue(String keyValue) {
		this.keyValue = keyValue;
	}
	@Override
	public String toString() {
		return "LogisSetting [settingId=" + settingId + ", key=" + key + ", keyValue=" + keyValue + "]";
	}
	
	
	

}
