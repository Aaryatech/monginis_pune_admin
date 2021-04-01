package com.ats.adminpanel.model.einv;

import java.util.List;

public class ReqPlGenIRN {

	
	 /// <summary>
    ///Required Parameter - "Version of the schema"
    /// </summary>
    public String Version ;
    /// <summary>
    /// Required Parameter - Transaction Details
    /// </summary>
    public TranDetails TranDtls ;
    /// <summary>
    /// Required Parameter - Doccument Details
    /// </summary>
    public DocSetails DocDtls ;
    public ExpDetails ExpDtls ;
    /// <summary>
    /// Required Parameter - Seller Details
    /// </summary>
    public SellerDetails SellerDtls ;
    /// <summary>
    ///Required Parameter - Buyer Details
    /// </summary>
    public BuyerDetails BuyerDtls ;
    public DispatchedDetails DispDtls ;
    public ShippedDetails ShipDtls ;
    /// <summary>
    /// Required Parameter
    /// </summary>
    public ValDetails ValDtls ;
    public PayDetails PayDtls ;
    public RefDetails RefDtls ;
    public EwbDetails EwbDtls ;
    
    
    public List<ItmList> ItemList;


	public String getVersion() {
		return Version;
	}


	public void setVersion(String version) {
		Version = version;
	}


	public TranDetails getTranDtls() {
		return TranDtls;
	}


	public void setTranDtls(TranDetails tranDtls) {
		TranDtls = tranDtls;
	}


	public DocSetails getDocDtls() {
		return DocDtls;
	}


	public void setDocDtls(DocSetails docDtls) {
		DocDtls = docDtls;
	}


	public ExpDetails getExpDtls() {
		return ExpDtls;
	}


	public void setExpDtls(ExpDetails expDtls) {
		ExpDtls = expDtls;
	}


	public SellerDetails getSellerDtls() {
		return SellerDtls;
	}


	public void setSellerDtls(SellerDetails sellerDtls) {
		SellerDtls = sellerDtls;
	}


	public BuyerDetails getBuyerDtls() {
		return BuyerDtls;
	}


	public void setBuyerDtls(BuyerDetails buyerDtls) {
		BuyerDtls = buyerDtls;
	}


	public DispatchedDetails getDispDtls() {
		return DispDtls;
	}


	public void setDispDtls(DispatchedDetails dispDtls) {
		DispDtls = dispDtls;
	}


	public ShippedDetails getShipDtls() {
		return ShipDtls;
	}


	public void setShipDtls(ShippedDetails shipDtls) {
		ShipDtls = shipDtls;
	}


	public ValDetails getValDtls() {
		return ValDtls;
	}


	public void setValDtls(ValDetails valDtls) {
		ValDtls = valDtls;
	}


	public PayDetails getPayDtls() {
		return PayDtls;
	}


	public void setPayDtls(PayDetails payDtls) {
		PayDtls = payDtls;
	}


	public RefDetails getRefDtls() {
		return RefDtls;
	}


	public void setRefDtls(RefDetails refDtls) {
		RefDtls = refDtls;
	}


	public EwbDetails getEwbDtls() {
		return EwbDtls;
	}


	public void setEwbDtls(EwbDetails ewbDtls) {
		EwbDtls = ewbDtls;
	}


	public List<ItmList> getItemList() {
		return ItemList;
	}


	public void setItemList(List<ItmList> itemList) {
		ItemList = itemList;
	}


	@Override
	public String toString() {
		return "ReqPlGenIRN [Version=" + Version + ", TranDtls=" + TranDtls + ", DocDtls=" + DocDtls + ", ExpDtls="
				+ ExpDtls + ", SellerDtls=" + SellerDtls + ", BuyerDtls=" + BuyerDtls + ", DispDtls=" + DispDtls
				+ ", ShipDtls=" + ShipDtls + ", ValDtls=" + ValDtls + ", PayDtls=" + PayDtls + ", RefDtls=" + RefDtls
				+ ", EwbDtls=" + EwbDtls + ", ItemList=" + ItemList + "]";
	}
    
    
    
}
