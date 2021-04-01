package com.ats.adminpanel.model.einv;

//for Cancel IRN
public class ReqPlCancelIRN {

	private String CnlRem;
	private String CnlRsn;
	private String Irn;
	public String getCnlRem() {
		return CnlRem;
	}
	public void setCnlRem(String cnlRem) {
		CnlRem = cnlRem;
	}
	public String getCnlRsn() {
		return CnlRsn;
	}
	public void setCnlRsn(String cnlRsn) {
		CnlRsn = cnlRsn;
	}
	public String getIrn() {
		return Irn;
	}
	public void setIrn(String irn) {
		Irn = irn;
	}
	@Override
	public String toString() {
		return "ReqPlCancelIRN [CnlRem=" + CnlRem + ", CnlRsn=" + CnlRsn + ", Irn=" + Irn + ", getCnlRem()="
				+ getCnlRem() + ", getCnlRsn()=" + getCnlRsn() + ", getIrn()=" + getIrn() + "]";
	}
	
	
	
}
