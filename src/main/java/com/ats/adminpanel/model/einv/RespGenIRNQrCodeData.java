package com.ats.adminpanel.model.einv;

public class RespGenIRNQrCodeData {
	  public String SellerGstin ;
      public String BuyerGstin ;
      public String DocNo ;
      public String DocTyp ;
      public String DocDt ;
      public double TotInvVal ;
      public String ItemCnt ;
      public String MainHsnCode ;
      public String Irn ;
	public String getSellerGstin() {
		return SellerGstin;
	}
	public void setSellerGstin(String sellerGstin) {
		SellerGstin = sellerGstin;
	}
	public String getBuyerGstin() {
		return BuyerGstin;
	}
	public void setBuyerGstin(String buyerGstin) {
		BuyerGstin = buyerGstin;
	}
	public String getDocNo() {
		return DocNo;
	}
	public void setDocNo(String docNo) {
		DocNo = docNo;
	}
	public String getDocTyp() {
		return DocTyp;
	}
	public void setDocTyp(String docTyp) {
		DocTyp = docTyp;
	}
	public String getDocDt() {
		return DocDt;
	}
	public void setDocDt(String docDt) {
		DocDt = docDt;
	}
	public double getTotInvVal() {
		return TotInvVal;
	}
	public void setTotInvVal(double totInvVal) {
		TotInvVal = totInvVal;
	}
	public String getItemCnt() {
		return ItemCnt;
	}
	public void setItemCnt(String itemCnt) {
		ItemCnt = itemCnt;
	}
	public String getMainHsnCode() {
		return MainHsnCode;
	}
	public void setMainHsnCode(String mainHsnCode) {
		MainHsnCode = mainHsnCode;
	}
	public String getIrn() {
		return Irn;
	}
	public void setIrn(String irn) {
		Irn = irn;
	}
	@Override
	public String toString() {
		return "RespGenIRNQrCodeData [SellerGstin=" + SellerGstin + ", BuyerGstin=" + BuyerGstin + ", DocNo=" + DocNo
				+ ", DocTyp=" + DocTyp + ", DocDt=" + DocDt + ", TotInvVal=" + TotInvVal + ", ItemCnt=" + ItemCnt
				+ ", MainHsnCode=" + MainHsnCode + ", Irn=" + Irn + "]";
	}
      
      
      
}
