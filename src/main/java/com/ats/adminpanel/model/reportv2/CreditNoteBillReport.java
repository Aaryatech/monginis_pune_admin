package com.ats.adminpanel.model.reportv2;

public class CreditNoteBillReport {

	private int itemId;
	private String itemName;

	private float grnGvnQty;
	private float grnGvnAmt;

	private String crnDate;
	private String invoiceNo;
	private String billDate;
	private String billNo;

	private String crnNo;

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public float getGrnGvnQty() {
		return grnGvnQty;
	}

	public void setGrnGvnQty(float grnGvnQty) {
		this.grnGvnQty = grnGvnQty;
	}

	public float getGrnGvnAmt() {
		return grnGvnAmt;
	}

	public void setGrnGvnAmt(float grnGvnAmt) {
		this.grnGvnAmt = grnGvnAmt;
	}

	public String getInvoiceNo() {
		return invoiceNo;
	}

	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}

	public String getCrnDate() {
		return crnDate;
	}

	public void setCrnDate(String crnDate) {
		this.crnDate = crnDate;
	}

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public String getCrnNo() {
		return crnNo;
	}

	public void setCrnNo(String crnNo) {
		this.crnNo = crnNo;
	}

	@Override
	public String toString() {
		return "CreditNoteBillReport [itemId=" + itemId + ", itemName=" + itemName + ", grnGvnQty=" + grnGvnQty
				+ ", grnGvnAmt=" + grnGvnAmt + ", crnDate=" + crnDate + ", invoiceNo=" + invoiceNo + ", billDate="
				+ billDate + ", billNo=" + billNo + ", crnNo=" + crnNo + "]";
	}

}
