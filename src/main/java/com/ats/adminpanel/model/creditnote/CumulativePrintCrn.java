package com.ats.adminpanel.model.creditnote;

import java.util.LinkedHashMap;
import java.util.List;

public class CumulativePrintCrn {

	List<CreditPrintBean> crnPrint;
	
	LinkedHashMap<String, CrnDetailsTaxSummary> totalSummaryList;



	public List<CreditPrintBean> getCrnPrint() {
		return crnPrint;
	}

	public void setCrnPrint(List<CreditPrintBean> crnPrint) {
		this.crnPrint = crnPrint;
	}

	public LinkedHashMap<String, CrnDetailsTaxSummary> getTotalSummaryList() {
		return totalSummaryList;
	}

	public void setTotalSummaryList(LinkedHashMap<String, CrnDetailsTaxSummary> totalSummaryList) {
		this.totalSummaryList = totalSummaryList;
	}

	@Override
	public String toString() {
		return "CumulativePrintCrn [crnPrint=" + crnPrint + ", totalSummaryList=" + totalSummaryList + "]";
	}
	
	
}
