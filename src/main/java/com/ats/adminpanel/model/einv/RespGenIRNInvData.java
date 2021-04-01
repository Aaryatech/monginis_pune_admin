package com.ats.adminpanel.model.einv;

import java.io.Serializable;
import java.util.List;

public class RespGenIRNInvData implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public String AckNo ;
    public String AckDt ;
    public String Version ;
    public String Irn ;
    public TranDetails TranDtls ;
    public DocSetails DocDtls ;
    public SellerDetails SellerDtls ;

    public BuyerDetails BuyerDtls ;
    public DispatchedDetails DispDtls ;
    public ShippedDetails ShipDtls ;
    public ValDetails ValDtls ;
    public PayDetails PayDtls ;
    public ExpDetails ExpDtls ;
    public RefDetails RefDtls ;
    public List<ItmList> ItemList ;
    
    
    public String SignedInvoice ;
    public String SignedQRCode ;
    public String EwbNo;
    public String EwbDt;
    public String EwbValidTill;
    public RespGenIRNInvData ExtractedSignedInvoiceData;
    public RespGenIRNQrCodeData ExtractedSignedQrCode;
    public String QrCodeImage;
    public String JwtIssuer;
    
public String Status;
	
   // public AuthSuccessRespPl Data;  
   // public List<RespErrDetailsPl> ErrorDetails ;
   // public List<RespInfoDtlsPl> InfoDtls;
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	/*
	 * public AuthSuccessRespPl getData() { return Data; } public void
	 * setData(AuthSuccessRespPl data) { Data = data; } public
	 * List<RespErrDetailsPl> getErrorDetails() { return ErrorDetails; } public void
	 * setErrorDetails(List<RespErrDetailsPl> errorDetails) { ErrorDetails =
	 * errorDetails; } public List<RespInfoDtlsPl> getInfoDtls() { return InfoDtls;
	 * } public void setInfoDtls(List<RespInfoDtlsPl> infoDtls) { InfoDtls =
	 * infoDtls; }
	 */
    
	
	public String getAckDt() {
		return AckDt;
	}
	
	
	
	
	public String getAckNo() {
		return AckNo;
	}
	public void setAckNo(String ackNo) {
		AckNo = ackNo;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public void setAckDt(String ackDt) {
		AckDt = ackDt;
	}
	public String getVersion() {
		return Version;
	}
	public void setVersion(String version) {
		Version = version;
	}
	public String getIrn() {
		return Irn;
	}
	public void setIrn(String irn) {
		Irn = irn;
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
	public ExpDetails getExpDtls() {
		return ExpDtls;
	}
	public void setExpDtls(ExpDetails expDtls) {
		ExpDtls = expDtls;
	}
	public RefDetails getRefDtls() {
		return RefDtls;
	}
	public void setRefDtls(RefDetails refDtls) {
		RefDtls = refDtls;
	}
	public List<ItmList> getItemList() {
		return ItemList;
	}
	public void setItemList(List<ItmList> itemList) {
		ItemList = itemList;
	}
	
	
	
	
	public String getSignedInvoice() {
		return SignedInvoice;
	}
	public void setSignedInvoice(String signedInvoice) {
		SignedInvoice = signedInvoice;
	}
	public String getSignedQRCode() {
		return SignedQRCode;
	}
	public void setSignedQRCode(String signedQRCode) {
		SignedQRCode = signedQRCode;
	}
	public String getEwbNo() {
		return EwbNo;
	}
	public void setEwbNo(String ewbNo) {
		EwbNo = ewbNo;
	}
	public String getEwbDt() {
		return EwbDt;
	}
	public void setEwbDt(String ewbDt) {
		EwbDt = ewbDt;
	}
	public String getEwbValidTill() {
		return EwbValidTill;
	}
	public void setEwbValidTill(String ewbValidTill) {
		EwbValidTill = ewbValidTill;
	}
	public RespGenIRNInvData getExtractedSignedInvoiceData() {
		return ExtractedSignedInvoiceData;
	}
	public void setExtractedSignedInvoiceData(RespGenIRNInvData extractedSignedInvoiceData) {
		ExtractedSignedInvoiceData = extractedSignedInvoiceData;
	}
	public RespGenIRNQrCodeData getExtractedSignedQrCode() {
		return ExtractedSignedQrCode;
	}
	public void setExtractedSignedQrCode(RespGenIRNQrCodeData extractedSignedQrCode) {
		ExtractedSignedQrCode = extractedSignedQrCode;
	}
	public String getQrCodeImage() {
		return QrCodeImage;
	}
	public void setQrCodeImage(String qrCodeImage) {
		QrCodeImage = qrCodeImage;
	}
	public String getJwtIssuer() {
		return JwtIssuer;
	}
	public void setJwtIssuer(String jwtIssuer) {
		JwtIssuer = jwtIssuer;
	}
	@Override
	public String toString() {
		return "RespGenIRNInvData [AckNo=" + AckNo + ", AckDt=" + AckDt + ", Version=" + Version + ", Irn=" + Irn
				+ ", TranDtls=" + TranDtls + ", DocDtls=" + DocDtls + ", SellerDtls=" + SellerDtls + ", BuyerDtls="
				+ BuyerDtls + ", DispDtls=" + DispDtls + ", ShipDtls=" + ShipDtls + ", ValDtls=" + ValDtls
				+ ", PayDtls=" + PayDtls + ", ExpDtls=" + ExpDtls + ", RefDtls=" + RefDtls + ", ItemList=" + ItemList
				+ ", SignedInvoice=" + SignedInvoice + ", SignedQRCode=" + SignedQRCode + ", EwbNo=" + EwbNo
				+ ", EwbDt=" + EwbDt + ", EwbValidTill=" + EwbValidTill + ", ExtractedSignedInvoiceData="
				+ ExtractedSignedInvoiceData + ", ExtractedSignedQrCode=" + ExtractedSignedQrCode + ", QrCodeImage="
				+ QrCodeImage + ", JwtIssuer=" + JwtIssuer + ", Status=" + Status + "]";
	}
    
}
