package com.ats.adminpanel.controller;

import java.math.BigDecimal;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.ExportToExcel;
import com.ats.adminpanel.model.franchisee.SubCategory;
import com.ats.adminpanel.model.item.AllItemsListResponse;
import com.ats.adminpanel.model.item.CategoryListResponse;
import com.ats.adminpanel.model.item.GetItemByCatId;
import com.ats.adminpanel.model.item.GetItemByCatIdList;
import com.ats.adminpanel.model.item.Item;
import com.ats.adminpanel.model.item.MCategoryList;
import com.ats.adminpanel.model.salesvaluereport.SalesReturnItemDaoList;
import com.ats.adminpanel.model.salesvaluereport.SalesReturnValueDaoList;

@Controller
@Scope("session")
public class SaleItemReportController {

	GetItemByCatIdList allItemsListResponse;

	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	@RequestMapping(value = "/showMonthlySalesValueWiseItemReport", method = RequestMethod.GET)
	public ModelAndView showMonthlySalesValueWiseItemReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;

		model = new ModelAndView("reports/sales/monthwisesalesitemvalue");
		RestTemplate restTemplate = new RestTemplate();

		try {

			CategoryListResponse categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory",
					CategoryListResponse.class);
			List<MCategoryList> categoryList;
			categoryList = categoryListResponse.getmCategoryList();

			model.addObject("catList", categoryList);
			String year = request.getParameter("year");
			String catId = request.getParameter("selectCat");

			System.out.println("catIdcatId" + catId);

			if (year != "") {
				String[] yrs = year.split("-"); // returns an array with the 2 parts

				MultiValueMap<String, String> map = new LinkedMultiValueMap<String, String>();

				map.add("fromYear", yrs[0]);
				map.add("toYear", yrs[1]);
				map.add("catId", catId);

				SalesReturnItemDaoList[] salesReturnValueReportListRes = restTemplate.postForObject(
						Constants.url + "getSalesReturnValueItemReport", map, SalesReturnItemDaoList[].class);

				List<SalesReturnItemDaoList> salesReturnValueReportList = new ArrayList<SalesReturnItemDaoList>(
						Arrays.asList(salesReturnValueReportListRes));

				map = new LinkedMultiValueMap<String, String>();

				map.add("catId", catId);

				allItemsListResponse = restTemplate.postForObject(Constants.url + "getItemByCategoryId", map,
						GetItemByCatIdList.class);

				List<GetItemByCatId> itemsList = new ArrayList<GetItemByCatId>();
				itemsList = allItemsListResponse.getGetItemByCatId();

				LinkedHashMap<Integer, SalesReturnItemDaoList> salesReturnValueReport = new LinkedHashMap<>();

				for (int i = 0; i < salesReturnValueReportList.size(); i++) {
					salesReturnValueReport.put(i, salesReturnValueReportList.get(i));
					float totBillAmt = 0;
					float totGrnValue = 0;
					float totGvnValue = 0;
					for (int k = 0; k < salesReturnValueReportList.get(i).getSalesReturnValueItemDao().size(); k++) {
						totBillAmt = totBillAmt
								+ salesReturnValueReportList.get(i).getSalesReturnValueItemDao().get(k).getGrandTotal();
						totGrnValue = totGrnValue
								+ salesReturnValueReportList.get(i).getSalesReturnValueItemDao().get(k).getGrnQty();
						totGvnValue = totGvnValue
								+ salesReturnValueReportList.get(i).getSalesReturnValueItemDao().get(k).getGvnQty();
					}
					salesReturnValueReportList.get(i).setTotBillAmt(totBillAmt);
					salesReturnValueReportList.get(i).setTotGrnQty(totGrnValue);
					salesReturnValueReportList.get(i).setTotGvnQty(totGvnValue);
				}

				model.addObject("salesReturnValueReport", salesReturnValueReport);
				model.addObject("itemsList", itemsList);

				// exportToExcel
				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();
				rowData.add("Sr.");
				rowData.add("Group Name");
				for (int i = 0; i < salesReturnValueReport.size(); i++) {
					rowData.add(salesReturnValueReport.get(i).getMonth() + " Gross Sale");
					rowData.add(salesReturnValueReport.get(i).getMonth() + " GVN Value");
					rowData.add(salesReturnValueReport.get(i).getMonth() + " GRN Value");
					rowData.add(salesReturnValueReport.get(i).getMonth() + " Total");
				}
				rowData.add("Total Gross Sale");
				rowData.add("Total GRN Value");
				rowData.add("Total GVN Value");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				float totBillAmt = 0.0f;
				float totGrnAmt = 0.0f;
				float totGvnAmt = 0.0f;
				for (int k = 0; k < itemsList.size(); k++) {

					float grandTotal = 0.0f;
					float grnQty = 0.0f;
					float gvnQty = 0.0f;

					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					rowData.add("" + (k + 1));
					rowData.add("" + itemsList.get(k).getItemName());
					for (int i = 0; i < salesReturnValueReport.size(); i++) {
						for (int j = 0; j < salesReturnValueReport.get(i).getSalesReturnValueItemDao().size(); j++) {

							if (salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j)
									.getItemId() == itemsList.get(k).getId()) {
								rowData.add("" + roundUp(salesReturnValueReport.get(i).getSalesReturnValueItemDao()
										.get(j).getGrandTotal()));
								rowData.add("" + roundUp(
										salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j).getGvnQty()));
								rowData.add("" + roundUp(
										salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j).getGrnQty()));
								rowData.add("" + roundUp(salesReturnValueReport.get(i).getSalesReturnValueItemDao()
										.get(j).getGrandTotal()
										- (salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j).getGvnQty()
												+ salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j)
														.getGrnQty())));
								grandTotal = grandTotal + salesReturnValueReport.get(i).getSalesReturnValueItemDao()
										.get(j).getGrandTotal();
								grnQty = grnQty
										+ salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j).getGrnQty();
								gvnQty = gvnQty
										+ salesReturnValueReport.get(i).getSalesReturnValueItemDao().get(j).getGvnQty();
							}

						}
					}
					rowData.add("" + roundUp(grandTotal));
					rowData.add("" + roundUp(grnQty));
					rowData.add("" + roundUp(gvnQty));

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);
					totBillAmt = totBillAmt + grandTotal;
					totGrnAmt = totGrnAmt + grnQty;
					totGvnAmt = totGvnAmt + gvnQty;

				}

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("");
				rowData.add("Total");
				for (int i = 0; i < salesReturnValueReport.size(); i++) {
					rowData.add("" + roundUp(salesReturnValueReport.get(i).getTotBillAmt()));
					rowData.add("" + roundUp(salesReturnValueReport.get(i).getTotGvnQty()));
					rowData.add("" + roundUp(salesReturnValueReport.get(i).getTotGrnQty()));
					rowData.add(roundUp((salesReturnValueReport.get(i).getTotBillAmt()
							- (salesReturnValueReport.get(i).getTotGvnQty()
									+ salesReturnValueReport.get(i).getTotGrnQty())))
							+ "");
				}
				rowData.add("" + totBillAmt);
				rowData.add("" + totGrnAmt);
				rowData.add("" + totGvnAmt);
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				System.err.println("exportToExcelList" + exportToExcelList.toString());
				HttpSession session = request.getSession();
				session.setAttribute("exportExcelList", exportToExcelList);
				session.setAttribute("excelName", "MonthlySalesReturnValueReport");

			}

		} catch (Exception e) {

		}
		// }
		return model;

	}

}
