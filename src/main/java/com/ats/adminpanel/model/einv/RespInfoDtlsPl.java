package com.ats.adminpanel.model.einv;


public class RespInfoDtlsPl {
	public String InfCd;
    public Object Desc;
	public String getInfCd() {
		return InfCd;
	}
	public void setInfCd(String infCd) {
		InfCd = infCd;
	}
	public Object getDesc() {
		return Desc;
	}
	public void setDesc(Object desc) {
		Desc = desc;
	}
	@Override
	public String toString() {
		return "RespInfoDtlsPl [InfCd=" + InfCd + ", Desc=" + Desc + "]";
	}
    
    
}


