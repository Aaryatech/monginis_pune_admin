
package com.ats.adminpanel.model;

import java.util.Date;


public class SpCakeOrdersBean {
	
   /*  private int frId;// frId added
*/	private int spOrderNo;
    private String spCode;
    private String spName;
    private String spfName;
    private String spEvents;
    private String spDeliveryDate;
    private float spPrice;
    private float spTotalAddRate;
    private String frName;
    private String itemId;
	private float spSelectedWeight;
    private String spBookedForName;
	private int isAllocated;
	private int isBillGenerated;
	
	
	
/*
    public int getFrId() {
    	return frId;
    }

    public void setFrId(int frId) {
    	this.frId = frId;
    }
    */
	
    public int getIsBillGenerated() {
		return isBillGenerated;
	}

	public void setIsBillGenerated(int isBillGenerated) {
		this.isBillGenerated = isBillGenerated;
	}

	public String getSpBookedForName() {
		return spBookedForName;
	}

	public void setSpBookedForName(String spBookedForName) {
		this.spBookedForName = spBookedForName;
	}

	public int getIsAllocated() {
		return isAllocated;
	}

	public void setIsAllocated(int isAllocated) {
		this.isAllocated = isAllocated;
	}

	public String getSpCode() {
        return spCode;
    }

    public float getSpSelectedWeight() {
		return spSelectedWeight;
	}

	public void setSpSelectedWeight(float spSelectedWeight) {
		this.spSelectedWeight = spSelectedWeight;
	}

	public int getSpOrderNo() {
		return spOrderNo;
	}

	public void setSpOrderNo(int spOrderNo) {
		this.spOrderNo = spOrderNo;
	}

	public void setSpCode(String spCode) {
        this.spCode = spCode;
    }

    public String getSpName() {
        return spName;
    }

    public void setSpName(String spName) {
        this.spName = spName;
    }

    
    public String getSpfName() {
		return spfName;
	}

	public void setSpfName(String spfName) {
		this.spfName = spfName;
	}

	public String getSpEvents() {
        return spEvents;
    }

    public void setSpEvents(String spEvents) {
        this.spEvents = spEvents;
    }

   

	
	public String getSpDeliveryDate() {
		return spDeliveryDate;
	}

	public void setSpDeliveryDate(String spDeliveryDate) {
		this.spDeliveryDate = spDeliveryDate;
	}

	public float getSpPrice() {
		return spPrice;
	}

	public void setSpPrice(float spPrice) {
		this.spPrice = spPrice;
	}

	public float getSpTotalAddRate() {
		return spTotalAddRate;
	}

	public void setSpTotalAddRate(float spTotalAddRate) {
		this.spTotalAddRate = spTotalAddRate;
	}

	public String getFrName() {
        return frName;
    }

    public void setFrName(String frName) {
        this.frName = frName;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

	@Override
	public String toString() {
		return "SpCakeOrdersBean [spOrderNo=" + spOrderNo + ", spCode=" + spCode + ", spName=" + spName + ", spfName="
				+ spfName + ", spEvents=" + spEvents + ", spDeliveryDate=" + spDeliveryDate + ", spPrice=" + spPrice
				+ ", spTotalAddRate=" + spTotalAddRate + ", frName=" + frName + ", itemId=" + itemId
				+ ", spSelectedWeight=" + spSelectedWeight + ", spBookedForName=" + spBookedForName + ", isAllocated="
				+ isAllocated + ", isBillGenerated=" + isBillGenerated + "]";
	}

	
}
