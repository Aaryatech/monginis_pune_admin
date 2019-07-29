package com.ats.adminpanel.controller;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.commons.DateConvertor;
import com.ats.adminpanel.model.AllFrIdName;
import com.ats.adminpanel.model.AllFrIdNameList;
import com.ats.adminpanel.model.ExportToExcel;
import com.ats.adminpanel.model.billing.Company;
import com.ats.adminpanel.model.franchisee.SubCategory;
import com.ats.adminpanel.model.item.CategoryListResponse;
import com.ats.adminpanel.model.item.MCategoryList;
import com.ats.adminpanel.model.salesreport3.TempFrWiseSubCat;
import com.ats.adminpanel.model.salesreport3.TempSubCatWiseBillData;
import com.ats.adminpanel.model.salesreport3.YearlySaleData;

@Controller
@Scope("session")
public class SalesReportController3 {

	String todaysDate;
	ArrayList<SubCategory> subCatAList;

	AllFrIdNameList allFrIdNameList = new AllFrIdNameList();
	List<MCategoryList> mCategoryList;
	
	
	
	// -----------------YEARLY
		// REPORT--------------------------------------------------

		@RequestMapping(value = "/showYearlyFrSubCatSaleReport", method = RequestMethod.GET)
		public ModelAndView showYearlyFrSubCatSaleReport(HttpServletRequest request, HttpServletResponse response) {

			ModelAndView model = null;
			HttpSession session = request.getSession();

			model = new ModelAndView("reports/sales/yearlyFrSubCatSale");
			
			String yearStartDate="";

			try {
				ZoneId z = ZoneId.of("Asia/Calcutta");

				LocalDate date = LocalDate.now(z);
				DateTimeFormatter formatters = DateTimeFormatter.ofPattern("d-MM-uuuu");
				todaysDate = date.format(formatters);
				yearStartDate= date.format(formatters);;
				
				RestTemplate restTemplate = new RestTemplate();

				allFrIdNameList = new AllFrIdNameList();
				try {

					allFrIdNameList = restTemplate.getForObject(Constants.url + "getAllFrIdName", AllFrIdNameList.class);

				} catch (Exception e) {
					System.out.println("Exception in getAllFrIdName" + e.getMessage());
					e.printStackTrace();

				}
				
				
				try {
					Company company= restTemplate.getForObject(Constants.url+"/getCompany",Company.class);
					yearStartDate=DateConvertor.convertToDMY(company.getFromDate());
				}catch (Exception e) {
					e.printStackTrace();
				}
				
				
				model.addObject("yearStartDate", yearStartDate);
				model.addObject("todaysDate", todaysDate);
				model.addObject("unSelectedFrList", allFrIdNameList.getFrIdNamesList());

				CategoryListResponse categoryListResponse;

				categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory",
						CategoryListResponse.class);

				mCategoryList = categoryListResponse.getmCategoryList();

				model.addObject("mCategoryList", mCategoryList);

				SubCategory[] subCatList = restTemplate.getForObject(Constants.url + "getAllSubCatList",
						SubCategory[].class);

				subCatAList = new ArrayList<SubCategory>(Arrays.asList(subCatList));

			} catch (Exception e) {

				System.out.println("Exc in showYearlyFrSubCatSaleReport--  " + e.getMessage());
				e.printStackTrace();

			}
			return model;

		}

		// ----AJAX----GET SUB CATEGORY LIST BY CAT ID-------------------

		@RequestMapping(value = "/getSubCatListByCatId", method = RequestMethod.GET)
		public @ResponseBody List<SubCategory> getSubCatByCatIdForReport(HttpServletRequest request,
				HttpServletResponse response) {

			List<SubCategory> subCatList = new ArrayList<SubCategory>();
			try {
				RestTemplate restTemplate = new RestTemplate();
				String selectedCat = request.getParameter("catId");
				boolean isAllCatSelected = false;

				System.out.println(
						"System.out.println(selectedCat);System.out.println(selectedCat);System.out.println(selectedCat);"
								+ selectedCat);

				if (selectedCat.contains("-1")) {
					isAllCatSelected = true;
				} else {
					selectedCat = selectedCat.substring(1, selectedCat.length() - 1);
					selectedCat = selectedCat.replaceAll("\"", "");
				}

				System.out.println(selectedCat);
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("catId", selectedCat);
				map.add("isAllCatSelected", isAllCatSelected);

				subCatList = restTemplate.postForObject(Constants.url + "getSubCatListByCatIdInForDisp", map, List.class);
				System.out.println(subCatList.toString());

			} catch (Exception e) {

			}

			return subCatList;
		}

		// -------AJAX---------FR LIST-------------

		@RequestMapping(value = "/getAllFrList", method = RequestMethod.GET)
		@ResponseBody
		public List<AllFrIdName> getFrListofAllFrForFrSummery(HttpServletRequest request, HttpServletResponse response) {

			return allFrIdNameList.getFrIdNamesList();

		}

		// ----AJAX-------------SEARCH YEARLY REPORT-------------

		@RequestMapping(value = "/getYearlyFrSubCatSaleReport", method = RequestMethod.GET)
		public @ResponseBody List<YearlySaleData> getYearlyFrSubCatSaleReport(HttpServletRequest request,
				HttpServletResponse response) {

			List<YearlySaleData> reportList = new ArrayList<>();

			String fromDate = "";
			String toDate = "";
			try {
				System.out.println("Inside get Sale Bill Wise");
				String selectedFr = request.getParameter("fr_id_list");
				String selectedSubCatIdList = request.getParameter("subCat_id_list");
				fromDate = request.getParameter("fromDate");
				toDate = request.getParameter("toDate");

				System.out.println("selectedFrBefore------------------" + selectedFr);

				selectedFr = selectedFr.substring(1, selectedFr.length() - 1);
				selectedFr = selectedFr.replaceAll("\"", "");

				selectedSubCatIdList = selectedSubCatIdList.substring(1, selectedSubCatIdList.length() - 1);
				selectedSubCatIdList = selectedSubCatIdList.replaceAll("\"", "");

				System.out.println("selectedFrAfter------------------" + selectedFr);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				RestTemplate restTemplate = new RestTemplate();

				System.out.println("Inside If all fr Selected ");

				String frDt = "", toDt = "";
				try {
					frDt = DateConvertor.convertToYMD(fromDate);
					toDt = DateConvertor.convertToYMD(toDate);
				} catch (Exception e) {
				}

				map.add("fromDate", frDt);
				map.add("toDate", toDt);
				map.add("frIdList", selectedFr);
				map.add("subCatIdList", selectedSubCatIdList);

				ParameterizedTypeReference<List<YearlySaleData>> typeRef = new ParameterizedTypeReference<List<YearlySaleData>>() {
				};
				ResponseEntity<List<YearlySaleData>> responseEntity = restTemplate.exchange(
						Constants.url + "getYearlyFrSubCatSaleReport", HttpMethod.POST, new HttpEntity<>(map), typeRef);

				reportList = responseEntity.getBody();

				System.err.println("REPORT ------------------- " + reportList);

			} catch (Exception e) {
				System.out.println("get Yearly sale Report  " + e.getMessage());
				e.printStackTrace();

			}

			
			return reportList;
		}

		@RequestMapping(value = "/displayYearlyReport", method = RequestMethod.GET)
		public ModelAndView displayYearlyReport(HttpServletRequest request, HttpServletResponse response) {

			ModelAndView model = null;

			model = new ModelAndView("reports/sales/displayFrSubCatYearlyReport");

			List<YearlySaleData> reportList = new ArrayList<>();

			String fromDate = "";
			String toDate = "";
			String selectedType = "";

			try {

				String selectedFrArray[] = request.getParameterValues("selectFr");
				String selectedSubCatIdArray[] = request.getParameterValues("item_grp2");
				fromDate = request.getParameter("fromDate");
				toDate = request.getParameter("toDate");
				selectedType = request.getParameter("typeId");

				String selectedFr = "";
				StringBuilder sb = new StringBuilder();

				if (selectedFrArray.length > 0) {
					for (int i = 0; i < selectedFrArray.length; i++) {
						System.out.println("fr Ids List " + selectedFrArray[i]);

						sb = sb.append(selectedFrArray[i] + ",");
					}

					selectedFr = sb.toString();
					selectedFr = selectedFr.substring(0, selectedFr.length() - 1);
				}

				System.err.println("FR IDS -------------- " + selectedFr);

				String selectedSubCatIdList = "";
				StringBuilder sb1 = new StringBuilder();

				List<String> scIds = new ArrayList<>();
				scIds = Arrays.asList(selectedSubCatIdArray);

				if (scIds.contains("-1")) {
					// subCatIdList.clear();
					List<String> tempScIdList = new ArrayList();

					if (subCatAList != null) {

						for (int i = 0; i < subCatAList.size(); i++) {
							tempScIdList.add(String.valueOf(subCatAList.get(i).getSubCatId()));
						}
					}
					System.err.println("SUB CAT ID ARRAY --------- " + tempScIdList);
					selectedSubCatIdList = tempScIdList.toString().substring(1, tempScIdList.toString().length() - 1);
					selectedSubCatIdList = selectedSubCatIdList.replaceAll("\"", "");

				} else {

					if (selectedSubCatIdArray.length > 0) {
						for (int i = 0; i < selectedSubCatIdArray.length; i++) {
							System.out.println("sc Ids List " + selectedSubCatIdArray[i]);

							sb1 = sb1.append(selectedSubCatIdArray[i] + ",");
						}

						selectedSubCatIdList = sb1.toString();
						selectedSubCatIdList = selectedSubCatIdList.substring(0, selectedSubCatIdList.length() - 1);
					}
				}

				System.out.println("selectedFrAfter------------------" + selectedSubCatIdList);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				RestTemplate restTemplate = new RestTemplate();

				System.out.println("Inside If all fr Selected ");

				String frDt = "", toDt = "";
				try {
					frDt = DateConvertor.convertToYMD(fromDate);
					toDt = DateConvertor.convertToYMD(toDate);
				} catch (Exception e) {
				}

				map.add("fromDate", frDt);
				map.add("toDate", toDt);
				map.add("frIdList", selectedFr);
				map.add("subCatIdList", selectedSubCatIdList);

				ParameterizedTypeReference<List<YearlySaleData>> typeRef = new ParameterizedTypeReference<List<YearlySaleData>>() {
				};
				ResponseEntity<List<YearlySaleData>> responseEntity = restTemplate.exchange(
						Constants.url + "getYearlyFrSubCatSaleReport", HttpMethod.POST, new HttpEntity<>(map), typeRef);

				reportList = new ArrayList<>();
				reportList = responseEntity.getBody();

				DecimalFormat df = new DecimalFormat("0.00");

				System.err.println("REPORT ------------------- " + reportList);

				if (reportList != null) {

					for (int i = 0; i < reportList.size(); i++) {

						float monthTotalSoldQty = 0;
						float monthTotalSoldAmt = 0;
						float monthTotalVarQty = 0;
						float monthTotalVarAmt = 0;
						float monthTotalRetQty = 0;
						float monthTotalRetAmt = 0;
						float monthTotalNetQty = 0;
						float monthTotalNetAmt = 0;
						//float monthTotalRetAmtPer = 0;

						float monthTotalSoldTaxableAmt = 0;
						float monthTotalVarTaxableAmt = 0;
						float monthTotalRetTaxableAmt = 0;
						float monthTotalNetTaxableAmt = 0;
						//float monthTotalRetTaxableAmtPer = 0;

						for (int j = 0; j < reportList.get(i).getDataList().size(); j++) {

							float frTotalSoldQty = 0;
							float frTotalSoldAmt = 0;
							float frTotalVarQty = 0;
							float frTotalVarAmt = 0;
							float frTotalRetQty = 0;
							float frTotalRetAmt = 0;
							float frTotalNetQty = 0;
							float frTotalNetAmt = 0;
							//float frTotalRetAmtPer = 0;
							float frTotalSoldTaxableAmt = 0;
							float frTotalVarTaxableAmt = 0;
							float frTotalRetTaxableAmt = 0;
							float frTotalNetTaxableAmt = 0;
							//float frTotalRetTaxableAmtPer = 0;

							TempFrWiseSubCat frData = reportList.get(i).getDataList().get(j);

							for (int k = 0; k < frData.getSubCatList().size(); k++) {

								TempSubCatWiseBillData data = frData.getSubCatList().get(k);

								frTotalSoldQty = frTotalSoldQty + data.getSoldQty();
								frTotalSoldAmt = frTotalSoldAmt + data.getSoldAmt();
								frTotalVarQty = frTotalVarQty + data.getVarQty();
								frTotalVarAmt = frTotalVarAmt + data.getVarAmt();
								frTotalRetQty = frTotalRetQty + data.getRetQty();
								frTotalRetAmt = frTotalRetAmt + data.getRetAmt();
								frTotalNetQty = frTotalNetQty + (data.getSoldQty() - (data.getVarQty() + data.getRetQty()));
								frTotalNetAmt = frTotalNetAmt + (data.getSoldAmt() - (data.getVarAmt() + data.getRetAmt()));

								

								frTotalSoldTaxableAmt = frTotalSoldTaxableAmt + data.getTaxableAmt();
								frTotalVarTaxableAmt = frTotalVarTaxableAmt + data.getVarTaxableAmt();
								frTotalRetTaxableAmt = frTotalRetTaxableAmt + data.getRetTaxableAmt();
								frTotalNetTaxableAmt = frTotalNetTaxableAmt
										+ (data.getTaxableAmt() - (data.getVarTaxableAmt() + data.getRetTaxableAmt()));

							

							}

							frData.setFrTotalSoldQty(frTotalSoldQty);
							frData.setFrTotalSoldAmt(frTotalSoldAmt);

							frData.setFrTotalVarQty(frTotalVarQty);
							frData.setFrTotalVarAmt(frTotalVarAmt);

							frData.setFrTotalRetQty(frTotalRetQty);
							
							frData.setFrTotalRetAmt(frTotalRetAmt);

							frData.setFrTotalNetQty(frTotalNetQty);
							frData.setFrTotalNetAmt(frTotalNetAmt);
							
							float frTotalRetAmtPer=0;
							if (frTotalSoldAmt == 0) {
								frTotalRetAmtPer =  0;

							} else {
								frTotalRetAmtPer = (((frTotalVarAmt + frTotalRetAmt) * 100) / frTotalSoldAmt);
							}
							

							frData.setFrTotalRetAmtPer(Float.parseFloat(df.format(frTotalRetAmtPer)));

							frData.setFrTotalSoldTaxableAmt(frTotalSoldTaxableAmt);

							frData.setFrTotalVarTaxableAmt(frTotalVarTaxableAmt);

							frData.setFrTotalRetTaxableAmt(frTotalRetTaxableAmt);

							frData.setFrTotalNetTaxableAmt(frTotalNetTaxableAmt);
							
							float frTotalRetTaxableAmtPer=0;
							if (frTotalSoldTaxableAmt == 0) {
								frTotalRetTaxableAmtPer =  0;
							} else {
								frTotalRetTaxableAmtPer = (((frTotalVarTaxableAmt + frTotalRetTaxableAmt) * 100)
												/ frTotalSoldTaxableAmt);
							}

							frData.setFrTotalRetTaxableAmtPer(Float.parseFloat(df.format(frTotalRetTaxableAmtPer)));

							// -----------MONTHLY SUM--------------------------
							monthTotalSoldQty = monthTotalSoldQty + frTotalSoldQty;
							monthTotalSoldAmt = monthTotalSoldAmt + frTotalSoldAmt;
							monthTotalVarQty = monthTotalVarQty + frTotalVarQty;
							monthTotalVarAmt = monthTotalVarAmt + frTotalVarAmt;
							monthTotalRetQty = monthTotalRetQty + frTotalRetQty;
							monthTotalRetAmt = monthTotalRetAmt + frTotalRetAmt;
							monthTotalNetQty = monthTotalNetQty + frTotalNetQty;
							monthTotalNetAmt = monthTotalNetAmt + frTotalNetAmt;
							//monthTotalRetAmtPer = monthTotalRetAmtPer + frTotalRetAmtPer;

							monthTotalSoldTaxableAmt = monthTotalSoldTaxableAmt + frTotalSoldTaxableAmt;
							monthTotalVarTaxableAmt = monthTotalVarTaxableAmt + frTotalVarTaxableAmt;
							monthTotalRetTaxableAmt = monthTotalRetTaxableAmt + frTotalRetTaxableAmt;
							monthTotalNetTaxableAmt = monthTotalNetTaxableAmt + frTotalNetTaxableAmt;
							//monthTotalRetTaxableAmtPer = monthTotalRetTaxableAmtPer + frTotalRetTaxableAmtPer;

						}

						reportList.get(i).setMonthTotalSoldQty(monthTotalSoldQty);
						reportList.get(i).setMonthTotalSoldAmt(monthTotalSoldAmt);

						reportList.get(i).setMonthTotalVarQty(monthTotalVarQty);
						reportList.get(i).setMonthTotalVarAmt(monthTotalVarAmt);

						reportList.get(i).setMonthTotalRetQty(monthTotalRetQty);
						reportList.get(i).setMonthTotalRetAmt(monthTotalRetAmt);

						reportList.get(i).setMonthTotalNetQty(monthTotalNetQty);
						reportList.get(i).setMonthTotalNetAmt(monthTotalNetAmt);
						
						float monthTotalRetAmtPer=0;
						if(monthTotalSoldAmt==0) {
							monthTotalRetAmtPer=0;
						}else {
							monthTotalRetAmtPer=(((monthTotalVarAmt+monthTotalRetAmt)*100)/monthTotalSoldAmt);
						}

						reportList.get(i).setMonthTotalRetAmtPer(Float.parseFloat(df.format(monthTotalRetAmtPer)));

						reportList.get(i).setMonthTotalSoldTaxableAmt(monthTotalSoldTaxableAmt);

						reportList.get(i).setMonthTotalVarTaxableAmt(monthTotalVarTaxableAmt);

						reportList.get(i).setMonthTotalRetTaxableAmt(monthTotalRetTaxableAmt);

						reportList.get(i).setMonthTotalNetTaxableAmt(monthTotalNetTaxableAmt);
						
						float monthTotalRetTaxableAmtPer=0;
						if(monthTotalSoldTaxableAmt==0) {
							monthTotalRetTaxableAmtPer=0;
						}else {
							monthTotalRetTaxableAmtPer=(((monthTotalVarTaxableAmt+monthTotalRetTaxableAmt)*100)/monthTotalSoldTaxableAmt);
						}
						
						

						reportList.get(i).setMonthTotalRetTaxableAmtPer(Float.parseFloat(df.format(monthTotalRetTaxableAmtPer)));

					}
				}

				System.err.println("-------------- REPORT---------------- " + reportList);

				model.addObject("reportList", reportList);
				model.addObject("reportType", selectedType);

			} catch (Exception e) {

				System.out.println("Exc in display yearly report--  " + e.getMessage());
				e.printStackTrace();

			}

			try {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add(" ");
				for (int i = 0; i < reportList.size(); i++) {
					rowData.add(" ");
					rowData.add(" ");
					rowData.add(" ");
					rowData.add(" ");
					rowData.add(reportList.get(i).getDateStr());
					rowData.add(" ");
					rowData.add(" ");
					rowData.add(" ");
					rowData.add(" ");

				}
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();

				rowData.add(" ");

				for (int i = 0; i < reportList.size(); i++) {

					rowData.add("Sold Qty");
					rowData.add("Sold Amt");
					rowData.add("Var Qty");
					rowData.add("Var Amt");
					rowData.add("Ret Qty");
					rowData.add("Ret Amt");
					rowData.add("Net Qty");
					rowData.add("Net Amt");
					rowData.add("Ret Amt %");

				}
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				if (reportList != null) {

					YearlySaleData monthData = reportList.get(0);

					for (int f = 0; f < monthData.getDataList().size(); f++) {

						TempFrWiseSubCat frData = monthData.getDataList().get(f);

						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();

						rowData.add("" + frData.getFrName());

						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);

						for (int s = 0; s < frData.getSubCatList().size(); s++) {

							TempSubCatWiseBillData scData = frData.getSubCatList().get(s);

							expoExcel = new ExportToExcel();
							rowData = new ArrayList<String>();

							rowData.add("" + scData.getSubCatName());

							for (int m = 0; m < reportList.size(); m++) {

								for (int f1 = 0; f1 < reportList.get(m).getDataList().size(); f1++) {

									if (reportList.get(m).getDataList().get(f1).getFrId() == frData.getFrId()) {
										for (int sc1 = 0; sc1 < reportList.get(m).getDataList().get(f1).getSubCatList()
												.size(); sc1++) {
											if (reportList.get(m).getDataList().get(f1).getSubCatList().get(sc1)
													.getSubCatId() == scData.getSubCatId()) {

												TempSubCatWiseBillData scData1 = reportList.get(m).getDataList().get(f1)
														.getSubCatList().get(sc1);

												// rowData.add("" + scData1.getSubCatName());

												if (selectedType.equalsIgnoreCase("1")) {

													rowData.add("" + scData1.getSoldQty());
													rowData.add("" + scData1.getSoldAmt());

													rowData.add("" + scData1.getVarQty());
													rowData.add("" + scData1.getVarAmt());

													rowData.add("" + scData1.getRetQty());
													rowData.add("" + scData1.getRetAmt());

													rowData.add("" + (scData1.getSoldQty()
															- (scData1.getVarQty() + scData1.getRetQty())));
													rowData.add("" + (scData1.getSoldAmt()
															- (scData1.getVarAmt() + scData1.getRetAmt())));

													if (scData1.getSoldAmt() == 0) {
														rowData.add("0.00%");
													} else {
														rowData.add(
																"" + String.format("%.02f", (((scData1.getVarAmt() + scData1.getRetAmt()) * 100)
																		/ scData1.getSoldAmt())) + "%");
													}

												} else if (selectedType.equalsIgnoreCase("2")) {

													rowData.add("" + scData1.getSoldQty());
													rowData.add("");

													rowData.add("" + scData1.getVarQty());
													rowData.add("");

													rowData.add("" + scData1.getRetQty());
													rowData.add("");

													rowData.add("" + (scData1.getSoldQty()
															- (scData1.getVarQty() + scData1.getRetQty())));
													rowData.add("");

													rowData.add("");

												} else if (selectedType.equalsIgnoreCase("3")) {

													rowData.add("");
													rowData.add("" + scData1.getSoldAmt());

													rowData.add("");
													rowData.add("" + scData1.getVarAmt());

													rowData.add("");
													rowData.add("" + scData1.getRetAmt());

													rowData.add("");
													rowData.add("" + (scData1.getSoldAmt()
															- (scData1.getVarAmt() + scData1.getRetAmt())));

													if (scData1.getSoldAmt() == 0) {
														rowData.add("0.00%");
													} else {
														rowData.add(
																"" + String.format("%.02f", (((scData1.getVarAmt() + scData1.getRetAmt()) * 100)
																		/ scData1.getSoldAmt())) + "%");
													}

												} else if (selectedType.equalsIgnoreCase("4")) {

													rowData.add("" + (int)scData1.getSoldQty());
													rowData.add("" + scData1.getTaxableAmt());

													rowData.add("" + (int)scData1.getVarQty());
													rowData.add("" + scData1.getVarTaxableAmt());

													rowData.add("" + (int)scData1.getRetQty());
													rowData.add("" + scData1.getRetTaxableAmt());

													rowData.add("" + (int)(scData1.getSoldQty()
															- (scData1.getVarQty() + scData1.getRetQty())));
													rowData.add("" + (scData1.getTaxableAmt()
															- (scData1.getVarTaxableAmt() + scData1.getRetTaxableAmt())));

													if (scData1.getTaxableAmt() == 0) {
														rowData.add("0.00%");
													} else {
														rowData.add("" + String.format("%.02f", (((scData1.getVarTaxableAmt()
																+ scData1.getRetTaxableAmt()) * 100)
																/ scData1.getTaxableAmt())) + "%");
													}

												}

												break;
											}
										}

										break;
									}
								}
							}
							expoExcel.setRowData(rowData);
							exportToExcelList.add(expoExcel);

						}

						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();

						rowData.add("Total");

						for (int k = 0; k < reportList.size(); k++) {
							for (int n = 0; n < reportList.get(k).getDataList().size(); n++) {

								TempFrWiseSubCat fr = reportList.get(k).getDataList().get(n);

								if (frData.getFrId() == fr.getFrId()) {

									if (selectedType.equalsIgnoreCase("1")) {

										rowData.add("" + (int)fr.getFrTotalSoldQty());
										rowData.add("" + fr.getFrTotalSoldAmt());

										rowData.add("" + (int)fr.getFrTotalVarQty());
										rowData.add("" + fr.getFrTotalVarAmt());

										rowData.add("" + (int)fr.getFrTotalRetQty());
										rowData.add("" + fr.getFrTotalRetAmt());

										rowData.add("" + (int)fr.getFrTotalNetQty());
										rowData.add("" + fr.getFrTotalNetAmt());

										rowData.add("" + fr.getFrTotalRetAmtPer() + "%");

									} else if (selectedType.equalsIgnoreCase("2")) {

										rowData.add("" + (int)fr.getFrTotalSoldQty());
										rowData.add("");

										rowData.add("" + (int)fr.getFrTotalVarQty());
										rowData.add("");

										rowData.add("" + (int)fr.getFrTotalRetQty());
										rowData.add("");

										rowData.add("" + (int)fr.getFrTotalNetQty());
										rowData.add("");

										rowData.add("");

									} else if (selectedType.equalsIgnoreCase("3")) {

										rowData.add("");
										rowData.add("" + fr.getFrTotalSoldAmt());

										rowData.add("");
										rowData.add("" + fr.getFrTotalVarAmt());

										rowData.add("");
										rowData.add("" + fr.getFrTotalRetAmt());

										rowData.add("");
										rowData.add("" + fr.getFrTotalNetAmt());

										rowData.add("" + fr.getFrTotalRetAmtPer() + "%");

									} else if (selectedType.equalsIgnoreCase("4")) {

										rowData.add("" + (int)fr.getFrTotalSoldQty());
										rowData.add("" + fr.getFrTotalSoldTaxableAmt());

										rowData.add("" + (int)fr.getFrTotalVarQty());
										rowData.add("" + fr.getFrTotalVarTaxableAmt());

										rowData.add("" + (int)fr.getFrTotalRetQty());
										rowData.add("" + fr.getFrTotalRetTaxableAmt());

										rowData.add("" + (int)fr.getFrTotalNetQty());
										rowData.add("" + fr.getFrTotalNetTaxableAmt());

										rowData.add("" + fr.getFrTotalRetTaxableAmtPer() + "%");

									}

								}

							}
						}

						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);

					}

				} // if

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();

				rowData.add("TOTAL");

				for (int i = 0; i < reportList.size(); i++) {

					YearlySaleData data = reportList.get(i);

					if (selectedType.equalsIgnoreCase("1")) {

						rowData.add("" + (int)data.getMonthTotalSoldQty());
						rowData.add("" + data.getMonthTotalSoldAmt());

						rowData.add("" + (int)data.getMonthTotalVarQty());
						rowData.add("" + data.getMonthTotalVarAmt());

						rowData.add("" + (int)data.getMonthTotalRetQty());
						rowData.add("" + data.getMonthTotalRetAmt());

						rowData.add("" + (int)data.getMonthTotalNetQty());
						rowData.add("" + data.getMonthTotalNetAmt());

						rowData.add("" + data.getMonthTotalRetAmtPer()+"%");

					} else if (selectedType.equalsIgnoreCase("2")) {

						rowData.add("" +(int) data.getMonthTotalSoldQty());
						rowData.add("");

						rowData.add("" + (int)data.getMonthTotalVarQty());
						rowData.add("");

						rowData.add("" + (int)data.getMonthTotalRetQty());
						rowData.add("");

						rowData.add("" + (int)data.getMonthTotalNetQty());
						rowData.add("");

						rowData.add("");

					} else if (selectedType.equalsIgnoreCase("3")) {

						rowData.add("");
						rowData.add("" + data.getMonthTotalSoldAmt());

						rowData.add("");
						rowData.add("" + data.getMonthTotalVarAmt());

						rowData.add("");
						rowData.add("" + data.getMonthTotalRetAmt());

						rowData.add("");
						rowData.add("" + data.getMonthTotalNetAmt());

						rowData.add("" + data.getMonthTotalRetAmtPer() + "%");

					} else if (selectedType.equalsIgnoreCase("4")) {

						rowData.add("" + (int)data.getMonthTotalSoldQty());
						rowData.add("" + data.getMonthTotalSoldTaxableAmt());

						rowData.add("" + (int)data.getMonthTotalVarQty());
						rowData.add("" + data.getMonthTotalVarTaxableAmt());

						rowData.add("" + (int)data.getMonthTotalRetQty());
						rowData.add("" + data.getMonthTotalRetTaxableAmt());

						rowData.add("" + (int)data.getMonthTotalNetQty());
						rowData.add("" + data.getMonthTotalNetTaxableAmt());

						rowData.add("" + data.getMonthTotalRetTaxableAmtPer() + "%");

					}

				}

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				// rowData.add("" + roundUp(drTotalAmt - crTotalAmt));

				HttpSession session = request.getSession();
				session.setAttribute("exportExcelListNew", exportToExcelList);
				session.setAttribute("excelNameNew", "YearlyShopWiseItemGroupReport");
				session.setAttribute("reportNameNew", "Shop + Item Group wise Summary -> Yearly Report");
				session.setAttribute("searchByNew", "From : " + reportList.get(0).getDateStr() + "  To : " + reportList.get((reportList.size()-1)).getDateStr() + " ");
				session.setAttribute("mergeUpto1", "$A$1:$J$1");
				session.setAttribute("mergeUpto2", "$A$2:$J$2");

			} catch (Exception e) {
				System.err.println("--------------EXC - ");
				e.printStackTrace();
			}

			return model;

		}

	
}
