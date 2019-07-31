package com.ats.adminpanel.model;




public class ItemIdOnly {
	
	
	private int id;
	
	private String itemName;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	@Override
	public String toString() {
		return "ItemIdOnly [id=" + id + ", itemName=" + itemName + "]";
	}
	
	

}
