package com.ats.adminpanel.controller;

import java.math.BigDecimal;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.AccessControll;
import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.commons.DateConvertor;
import com.ats.adminpanel.model.AllFrIdName;
import com.ats.adminpanel.model.AllFrIdNameList;
import com.ats.adminpanel.model.AllRoutesListResponse;
import com.ats.adminpanel.model.ExportToExcel;
import com.ats.adminpanel.model.Info;
import com.ats.adminpanel.model.Route;
import com.ats.adminpanel.model.RouteMgmt;
import com.ats.adminpanel.model.accessright.ModuleJson;
import com.ats.adminpanel.model.billing.PostBillHeader;
import com.ats.adminpanel.model.franchisee.FrNameIdByRouteId;
import com.ats.adminpanel.model.franchisee.FrNameIdByRouteIdResponse;
import com.ats.adminpanel.model.franchisee.Menu;
import com.ats.adminpanel.model.reportv2.CreditNoteBillReport;
import com.ats.adminpanel.model.salesreport.SalesReportBillwise;

@Controller
@Scope("session")
public class SalesReportController2 {

	AllFrIdNameList allFrIdNameList = new AllFrIdNameList();
	String todaysDate;

	@RequestMapping(value = "/showBillwiseCreditNoteReport", method = RequestMethod.GET)
	public ModelAndView showBillwiseCreditNoteReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		HttpSession session = request.getSession();

		model = new ModelAndView("reports/sales/billwiseCreditNote");

		try {
			ZoneId z = ZoneId.of("Asia/Calcutta");

			LocalDate date = LocalDate.now(z);
			DateTimeFormatter formatters = DateTimeFormatter.ofPattern("d-MM-uuuu");
			todaysDate = date.format(formatters);

			RestTemplate restTemplate = new RestTemplate();

			allFrIdNameList = new AllFrIdNameList();
			try {

				allFrIdNameList = restTemplate.getForObject(Constants.url + "getAllFrIdName", AllFrIdNameList.class);

			} catch (Exception e) {
				System.out.println("Exception in getAllFrIdName" + e.getMessage());
				e.printStackTrace();

			}

			model.addObject("todaysDate", todaysDate);
			model.addObject("unSelectedFrList", allFrIdNameList.getFrIdNamesList());

		} catch (Exception e) {

			System.out.println("Exc in show sales report bill wise  " + e.getMessage());
			e.printStackTrace();
		}

		return model;

	}

	@RequestMapping(value = "/getBillNoAndDateByFrId", method = RequestMethod.GET)
	@ResponseBody
	public List<PostBillHeader> getBillNoAndDateByFrId(HttpServletRequest request, HttpServletResponse response) {

		List<PostBillHeader> billList = new ArrayList<>();

		try {
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			String selectedFr = request.getParameter("selectedFr");

			System.out.println(selectedFr);

			selectedFr = selectedFr.substring(1, selectedFr.length() - 1);
			selectedFr = selectedFr.replaceAll("\"", "");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("frId", selectedFr);
			RestTemplate restTemplate = new RestTemplate();

			billList = restTemplate.postForObject(Constants.url + "/getBillNoDateByFrId", map, List.class);

			System.out.println("billListbillListbillList" + billList.toString());

		} catch (Exception e) {

			e.printStackTrace();
		}

		return billList;

	}

	@RequestMapping(value = "/getCreditNoteDetailReport", method = RequestMethod.GET)
	@ResponseBody
	public List<CreditNoteBillReport> getCreditNoteDetailReport(HttpServletRequest request,
			HttpServletResponse response) {

		List<CreditNoteBillReport> billList = new ArrayList<>();

		try {

			String selectBillNo = request.getParameter("selectBillNo");

			System.out.println(selectBillNo);

			selectBillNo = selectBillNo.substring(1, selectBillNo.length() - 1);
			selectBillNo = selectBillNo.replaceAll("\"", "");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			map.add("billNoList", selectBillNo);
			RestTemplate restTemplate = new RestTemplate();

			CreditNoteBillReport[] billListArray = restTemplate
					.postForObject(Constants.url + "/getCreditNoteDetailReport", map, CreditNoteBillReport[].class);

			billList = new ArrayList<>(Arrays.asList(billListArray));

			System.out.println("billListbillListbillList" + billList.toString());

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			rowData.add("Sr.No.");
			rowData.add("Bill No");
			rowData.add("Bill Date");
			rowData.add("CRN No");
			rowData.add("CRN date");
			rowData.add("Item Name");
			rowData.add("Qty");
			rowData.add("Grand Total");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			float totalQty = 0.0f;
			float totalAMt = 0.0f;

			for (int i = 0; i < billList.size(); i++) {

				totalQty = totalQty + billList.get(i).getGrnGvnQty();
				totalAMt = totalAMt + billList.get(i).getGrnGvnAmt();

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add((i + 1) + "");
				rowData.add("" + billList.get(i).getBillNo());
				rowData.add("" + billList.get(i).getBillDate());
				rowData.add("" + billList.get(i).getCrnNo());
				rowData.add("" + billList.get(i).getCrnDate());

				rowData.add("" + billList.get(i).getItemName());
				rowData.add("" + billList.get(i).getGrnGvnQty());
				rowData.add("" + billList.get(i).getGrnGvnAmt());

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add("Total");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("" + roundUp(totalQty));
			rowData.add("" + roundUp(totalAMt));

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			HttpSession session = request.getSession();

			session.setAttribute("exportExcelListNew", exportToExcelList);
			session.setAttribute("excelNameNew", "CreditNoteBillReport");
			session.setAttribute("reportNameNew", "CreditNoteBillReport");

			session.setAttribute("mergeUpto1", "$A$1:$H$1");
			session.setAttribute("mergeUpto2", "$A$2:$H$2");

		} catch (Exception e) {

			e.printStackTrace();
		}

		return billList;

	}

	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	@RequestMapping(value = "pdf/showBillwiseCreditNoteReportPdf/ {fromDate}/{toDate}/{selectBillNo}", method = RequestMethod.GET)
	public ModelAndView showBillwiseCreditNoteReportPdf(@PathVariable String fromDate, @PathVariable String toDate,
			@PathVariable String selectBillNo, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("reports/sales/pdf/billwiseCreditNotePdf");
		List<CreditNoteBillReport> saleList = new ArrayList<>();
		boolean isAllFrSelected = false;

		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			map.add("billNoList", selectBillNo);
			RestTemplate restTemplate = new RestTemplate();

			ParameterizedTypeReference<List<CreditNoteBillReport>> typeRef = new ParameterizedTypeReference<List<CreditNoteBillReport>>() {
			};
			ResponseEntity<List<CreditNoteBillReport>> responseEntity = restTemplate.exchange(
					Constants.url + "getCreditNoteDetailReport", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			saleList = responseEntity.getBody();

			System.out.println("sales List Bill Wise " + saleList.toString());

		} catch (

		Exception e) {
			System.out.println("Exce in show Sale Bill wise by fr PDF " + e.getMessage());
			e.printStackTrace();
		}
		model.addObject("fromDate", fromDate);
		model.addObject("FACTORYNAME", Constants.FACTORYNAME);
		model.addObject("FACTORYADDRESS", Constants.FACTORYADDRESS);
		model.addObject("toDate", toDate);

		model.addObject("report", saleList);
		return model;
	}
}
