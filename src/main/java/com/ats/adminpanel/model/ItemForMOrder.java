package com.ats.adminpanel.model;


public class ItemForMOrder{
	
	private int id;

	private String itemId;
	
	private String itemName;

	private int itemGrp1;
	
	private int itemGrp2;
	
	private int itemGrp3;
	
	private double itemRate1;
	
	private double itemRate2;
	
	private double itemMrp1;
	
	private double itemMrp2;
	
	private double itemMrp3;
	
	private String itemImage;
	
	private double itemTax1;
	
	private double itemTax2;
	
	private double itemTax3;
	
	private int itemIsUsed;
	
	private double itemSortId;
	
	private int grnTwo;
	
	private int delStatus;
		
	private double itemRate3;
	
	private int minQty;
	
	private int shelfLife;
	
    private float discPer;
    
    private int orderQty;
    
    

	public int getOrderQty() {
		return orderQty;
	}

	public void setOrderQty(int orderQty) {
		this.orderQty = orderQty;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
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

	public int getItemGrp1() {
		return itemGrp1;
	}

	public void setItemGrp1(int itemGrp1) {
		this.itemGrp1 = itemGrp1;
	}

	public int getItemGrp2() {
		return itemGrp2;
	}

	public void setItemGrp2(int itemGrp2) {
		this.itemGrp2 = itemGrp2;
	}

	public int getItemGrp3() {
		return itemGrp3;
	}

	public void setItemGrp3(int itemGrp3) {
		this.itemGrp3 = itemGrp3;
	}

	public double getItemRate1() {
		return itemRate1;
	}

	public void setItemRate1(double itemRate1) {
		this.itemRate1 = itemRate1;
	}

	public double getItemRate2() {
		return itemRate2;
	}

	public void setItemRate2(double itemRate2) {
		this.itemRate2 = itemRate2;
	}

	public double getItemMrp1() {
		return itemMrp1;
	}

	public void setItemMrp1(double itemMrp1) {
		this.itemMrp1 = itemMrp1;
	}

	public double getItemMrp2() {
		return itemMrp2;
	}

	public void setItemMrp2(double itemMrp2) {
		this.itemMrp2 = itemMrp2;
	}

	public double getItemMrp3() {
		return itemMrp3;
	}

	public void setItemMrp3(double itemMrp3) {
		this.itemMrp3 = itemMrp3;
	}

	public String getItemImage() {
		return itemImage;
	}

	public void setItemImage(String itemImage) {
		this.itemImage = itemImage;
	}

	public double getItemTax1() {
		return itemTax1;
	}

	public void setItemTax1(double itemTax1) {
		this.itemTax1 = itemTax1;
	}

	public double getItemTax2() {
		return itemTax2;
	}

	public void setItemTax2(double itemTax2) {
		this.itemTax2 = itemTax2;
	}

	public double getItemTax3() {
		return itemTax3;
	}

	public void setItemTax3(double itemTax3) {
		this.itemTax3 = itemTax3;
	}

	public int getItemIsUsed() {
		return itemIsUsed;
	}

	public void setItemIsUsed(int itemIsUsed) {
		this.itemIsUsed = itemIsUsed;
	}

	public double getItemSortId() {
		return itemSortId;
	}

	public void setItemSortId(double itemSortId) {
		this.itemSortId = itemSortId;
	}

	public int getGrnTwo() {
		return grnTwo;
	}

	public void setGrnTwo(int grnTwo) {
		this.grnTwo = grnTwo;
	}

	public int getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}

	public double getItemRate3() {
		return itemRate3;
	}

	public void setItemRate3(double itemRate3) {
		this.itemRate3 = itemRate3;
	}

	public int getMinQty() {
		return minQty;
	}

	public void setMinQty(int minQty) {
		this.minQty = minQty;
	}

	public int getShelfLife() {
		return shelfLife;
	}

	public void setShelfLife(int shelfLife) {
		this.shelfLife = shelfLife;
	}

	public float getDiscPer() {
		return discPer;
	}

	public void setDiscPer(float discPer) {
		this.discPer = discPer;
	}

	@Override
	public String toString() {
		return "ItemForMOrder [id=" + id + ", itemId=" + itemId + ", itemName=" + itemName + ", itemGrp1=" + itemGrp1
				+ ", itemGrp2=" + itemGrp2 + ", itemGrp3=" + itemGrp3 + ", itemRate1=" + itemRate1 + ", itemRate2="
				+ itemRate2 + ", itemMrp1=" + itemMrp1 + ", itemMrp2=" + itemMrp2 + ", itemMrp3=" + itemMrp3
				+ ", itemImage=" + itemImage + ", itemTax1=" + itemTax1 + ", itemTax2=" + itemTax2 + ", itemTax3="
				+ itemTax3 + ", itemIsUsed=" + itemIsUsed + ", itemSortId=" + itemSortId + ", grnTwo=" + grnTwo
				+ ", delStatus=" + delStatus + ", itemRate3=" + itemRate3 + ", minQty=" + minQty + ", shelfLife="
				+ shelfLife + ", discPer=" + discPer + ", orderQty=" + orderQty + "]";
	}
    
}
