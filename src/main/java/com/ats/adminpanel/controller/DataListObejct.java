package com.ats.adminpanel.controller;

import java.util.List;

import com.ats.adminpanel.model.GetProdVariation;


public class DataListObejct {

	List<GetProdVariation> prodVarList;
	
	int status;

	public List<GetProdVariation> getProdVarList() {
		return prodVarList;
	}

	public void setProdVarList(List<GetProdVariation> prodVarList) {
		this.prodVarList = prodVarList;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "DataListObejct [prodVarList=" + prodVarList + ", status=" + status + "]";
	}
	
	
	
	
}
