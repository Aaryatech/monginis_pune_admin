package com.ats.adminpanel.model;

//Sachin 27-02-2020
public class GetProdVariation {

	private Integer id; 		//primary key of m_item table
	private String itemId;		//primary code of m_item table by Monginis
	private String itemName;
	
	private float opTotal; 		//finished good stock table opTotal 
	private float productionQty;//prod  table prodQty 
	private float rejectedQty;	//prod  table rejectedQty 
	private float remainingQty;	//prod  table remainingQty 
	
	private float selMenuOrderQty; //t_order currently selected menu order qty 
	private float otherMenuOrderQty;//t_order other than currently selected menu order qty 
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public float getOpTotal() {
		return opTotal;
	}
	public void setOpTotal(float opTotal) {
		this.opTotal = opTotal;
	}
	public float getProductionQty() {
		return productionQty;
	}
	public void setProductionQty(float productionQty) {
		this.productionQty = productionQty;
	}
	public float getRejectedQty() {
		return rejectedQty;
	}
	public void setRejectedQty(float rejectedQty) {
		this.rejectedQty = rejectedQty;
	}
	public float getRemainingQty() {
		return remainingQty;
	}
	public void setRemainingQty(float remainingQty) {
		this.remainingQty = remainingQty;
	}
	public float getSelMenuOrderQty() {
		return selMenuOrderQty;
	}
	public void setSelMenuOrderQty(float selMenuOrderQty) {
		this.selMenuOrderQty = selMenuOrderQty;
	}
	public float getOtherMenuOrderQty() {
		return otherMenuOrderQty;
	}
	public void setOtherMenuOrderQty(float otherMenuOrderQty) {
		this.otherMenuOrderQty = otherMenuOrderQty;
	}
	
	@Override
	public String toString() {
		return "GetProdVariation [id=" + id + ", itemId=" + itemId + ", itemName=" + itemName + ", opTotal=" + opTotal
				+ ", productionQty=" + productionQty + ", rejectedQty=" + rejectedQty + ", remainingQty=" + remainingQty
				+ ", selMenuOrderQty=" + selMenuOrderQty + ", otherMenuOrderQty=" + otherMenuOrderQty + "]";
	}
	
}
