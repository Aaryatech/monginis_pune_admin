package com.ats.adminpanel.controller;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.AllFrIdNameList;
import com.ats.adminpanel.model.ErrorMessage;
import com.ats.adminpanel.model.FlavourList;
import com.ats.adminpanel.model.GenerateBill;
import com.ats.adminpanel.model.GenerateBillList;
import com.ats.adminpanel.model.Info;
import com.ats.adminpanel.model.SearchSpCakeResponse;
import com.ats.adminpanel.model.SpCakeResponse;
import com.ats.adminpanel.model.billing.PostBillDataCommon;
import com.ats.adminpanel.model.billing.PostBillDetail;
import com.ats.adminpanel.model.billing.PostBillHeader;
import com.ats.adminpanel.model.flavours.Flavour;
import com.ats.adminpanel.model.franchisee.FranchiseeList;
import com.ats.adminpanel.model.manspbill.SpecialCake;

@Controller
@Scope("session")
public class ManualBillController {
	FlavourList flavourList;

	public AllFrIdNameList allFrIdNameList = new AllFrIdNameList();
	SpecialCake specialCake = new SpecialCake();

	@RequestMapping(value = "/showManualBill", method = RequestMethod.GET)
	public ModelAndView showManualBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		try {
			model = new ModelAndView("manualBill/add_man_bill");
			RestTemplate restTemplate = new RestTemplate();
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			allFrIdNameList = new AllFrIdNameList();
			try {

				allFrIdNameList = restTemplate.getForObject(Constants.url + "getAllFrIdName", AllFrIdNameList.class);

			} catch (Exception e) {
				System.out.println("Exception in getAllFrIdName" + e.getMessage());
				e.printStackTrace();

			}

			SpCakeResponse spCakeResponse = restTemplate.getForObject(Constants.url + "showSpecialCakeList",
					SpCakeResponse.class);
			System.out.println("SpCake Controller SpCakeList Response " + spCakeResponse.toString());
			List<com.ats.adminpanel.model.SpecialCake> specialCakeList = new ArrayList<com.ats.adminpanel.model.SpecialCake>();

			specialCakeList = spCakeResponse.getSpecialCake();

			model.addObject("specialCakeList", specialCakeList);// 1 object to be used in jsp 2 actual object
			model.addObject("specialCake", specialCake);// 1 object to be used in jsp 2 actual object
			model.addObject("frId", 0);// 1 object to be used in jsp 2 actual object

			flavourList = restTemplate.getForObject(Constants.url + "/showFlavourList", FlavourList.class);

			model.addObject("unSelectedFrList", allFrIdNameList.getFrIdNamesList());
			model.addObject("billBy", 0);

		} catch (Exception e) {

			System.err.println("Exce in showManualBill" + e.getMessage());
			e.printStackTrace();

		}

		return model;
	}

	// getSpCakeForManBill

	@RequestMapping(value = "/getSpCakeForManBill", method = RequestMethod.POST)
	public ModelAndView getSpCakeForManBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		try {
			model = new ModelAndView("manualBill/add_man_bill");
			RestTemplate restTemplate = new RestTemplate();

			String spCode = request.getParameter("sp_cake_id");
			List<Float> weightList = new ArrayList<>();

			int frId = Integer.parseInt(request.getParameter("fr_id"));
			int billBy = Integer.parseInt(request.getParameter("sel_rate"));
			System.err.println("Bill By " + billBy);

			model.addObject("frId", frId);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("spCode", spCode);
			try {
				SearchSpCakeResponse searchSpCakeResponse = restTemplate
						.postForObject(Constants.url + "/searchSpecialCake", map, SearchSpCakeResponse.class);
				ErrorMessage errorMessage = searchSpCakeResponse.getErrorMessage();
				System.err.println("Selected Special Cake 111111111111" + searchSpCakeResponse.toString());

				specialCake = searchSpCakeResponse.getSpecialCake();

				model.addObject("specialCake", specialCake);

			} catch (Exception e) {
				e.printStackTrace();
			}
			model.addObject("unSelectedFrList", allFrIdNameList.getFrIdNamesList());

			SpCakeResponse spCakeResponse = restTemplate.getForObject(Constants.url + "showSpecialCakeList",
					SpCakeResponse.class);
			// System.out.println("SpCake Controller SpCakeList Response 0000000" +
			// spCakeResponse.toString());

			List<com.ats.adminpanel.model.SpecialCake> specialCakeList = new ArrayList<com.ats.adminpanel.model.SpecialCake>();

			specialCakeList = spCakeResponse.getSpecialCake();

			model.addObject("specialCakeList", specialCakeList);

			FranchiseeList frDetails = restTemplate.getForObject(Constants.url + "getFranchisee?frId={frId}",
					FranchiseeList.class, frId);

			float sprRate;
			float spBackendRate;

			float minWt = Float.valueOf(specialCake.getSpMinwt());

			float maxWt = Float.valueOf(specialCake.getSpMaxwt());

			weightList.add(minWt);
			float currentWt = minWt;
			while (currentWt < maxWt) {
				currentWt = currentWt + specialCake.getSpRate2();// spr rate 2 means weight increment by
				weightList.add(currentWt);
			}

			System.out.println("Weight List for SP Cake: " + weightList.toString());

			if (frDetails.getFrRateCat() == 1) {
				System.err.println("Rate cat 1");
				
				if (billBy == 0) { // means calc by mrp
					sprRate = specialCake.getMrpRate1();
					spBackendRate = specialCake.getSpRate1();
				} else {// means calc by rate

					sprRate = specialCake.getSpRate1();
					spBackendRate = specialCake.getMrpRate1();
				}

			} else {
				System.err.println("Rate cat no");

				if (billBy == 0) {

					sprRate = specialCake.getMrpRate3();
					spBackendRate = specialCake.getSpRate3();
				} else {
					
					sprRate = specialCake.getSpRate3();
					spBackendRate = specialCake.getMrpRate3();
				}

			}
			
			System.err.println("sprRate " + sprRate);
			model.addObject("sprRate", sprRate);
			model.addObject("spBackendRate", spBackendRate);

			model.addObject("weightList", weightList);
			model.addObject("billBy", billBy);

		} catch (Exception e) {
			System.err.println("Exce in getSpCakeForManBill" + e.getMessage());
			e.printStackTrace();
		}
		return model;

	}

	@RequestMapping(value = "/getFlavourBySpfId", method = RequestMethod.GET)
	public @ResponseBody List<Flavour> flavourById(@RequestParam(value = "spType", required = true) int spType) {

		List<Flavour> flavoursListWithAddonRate = new ArrayList<Flavour>();

		System.out.println("SpType:: " + spType);

		List<Flavour> flavoursList = new ArrayList<Flavour>();
		List<Flavour> filterFlavoursList = new ArrayList<Flavour>();

		RestTemplate restTemplate = new RestTemplate();

		//flavourList = restTemplate.getForObject(Constants.url + "/showFlavourList", FlavourList.class);
		//flavoursList = flavourList.getFlavour();

		try {

			flavoursList = flavourList.getFlavour();

			//System.out.println("FLAVOURS:" + flavoursList.toString());

			//System.out.println("DB Sptype" + flavoursList.get(0).getSpType());

			for (int i = 0; i < flavoursList.size(); i++) {

				if (flavoursList.get(i).getSpType() == spType) {
					filterFlavoursList.add(flavoursList.get(i));

				}
			}
			for (Flavour flavour : filterFlavoursList) {
				if (specialCake.getIsAddonRateAppli() == 1) {
					List<String> list = Arrays.asList(specialCake.getErpLinkcode().split(","));
					if (list.contains("" + flavour.getSpfId())) {
						flavour.setSpfAdonRate(0.0);
					}
					flavoursListWithAddonRate.add(flavour);
					//System.err.println(flavour.getSpfId());
					//System.err.println(flavoursListWithAddonRate.toString());
				} else {
					flavour.setSpfAdonRate(0.0);
					flavoursListWithAddonRate.add(flavour);
				}
			}
			System.out.println("Filter flavour List " + flavoursListWithAddonRate.toString());
		} catch (Exception e) {
			System.out.println("Exception in getFlavourBySpfId() AJAX CALL");

		}

		// return flavoursListWithAddonRate;

		// return flavoursListWithAddonRate;

		return flavoursList;

	}

	private static final Logger logger = LoggerFactory.getLogger(ManualBillController.class);

	// ------------------------Get Addon Rate AJAX
	// method(spcakeorder)-----------------------------------
	@RequestMapping(value = "/getAddOnRate", method = RequestMethod.GET)
	public @ResponseBody Flavour getAddOnRate(@RequestParam(value = "spfId", required = true) double spfId) {
		List<Flavour> flavoursList = new ArrayList<Flavour>();
		Flavour filteredFlavour = new Flavour();
		flavoursList = flavourList.getFlavour();

		for (Flavour flavour : flavoursList) {

			if (flavour.getSpfId() == spfId) {

				filteredFlavour = flavour;
			}
		}
		return filteredFlavour;
	}

	// insertManualSpBill
	@RequestMapping(value = "/insertManualSpBill", method = RequestMethod.POST)
	public String insertManualSpBill(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		try {
			model = new ModelAndView("manualBill/add_man_bill");
			RestTemplate restTemplate = new RestTemplate();

			String frName = request.getParameter("fr_name");
			String gstNo = request.getParameter("gst_no");

			int frId = Integer.parseInt(request.getParameter("fr_id"));
			int billBy = Integer.parseInt(request.getParameter("sel_rate"));

			FranchiseeList frDetails = restTemplate.getForObject(Constants.url + "getFranchisee?frId={frId}",
					FranchiseeList.class, frId);

			PostBillDataCommon postBillDataCommon = new PostBillDataCommon();

			List<PostBillHeader> postBillHeaderList = new ArrayList<PostBillHeader>();

			List<PostBillDetail> postBillDetailsList = new ArrayList();

			PostBillHeader header = new PostBillHeader();

			header.setBillDate(new Date());
			header.setFrCode(frDetails.getFrCode());

			header.setDelStatus(0);
			header.setFrId(frDetails.getFrId());

			int spId = Integer.parseInt(request.getParameter("sp_id"));

			String spGrand = request.getParameter("sp_grand");

			float tax1 = Float.parseFloat(request.getParameter("tax1"));

			float tax2 = Float.parseFloat(request.getParameter("tax2"));

			float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;
			float sumDiscAmt = 0;

			PostBillDetail billDetail = new PostBillDetail();

			String billQty = "1";
			Float orderRate = Float.parseFloat(spGrand);
			Float baseRate = (orderRate * 100) / (100 + (tax1 + tax2));
			baseRate = roundUp(baseRate);
			Float taxableAmt = (float) (baseRate * 1);
			taxableAmt = roundUp(taxableAmt);

			float sgstRs = (taxableAmt * tax1) / 100;
			float cgstRs = (taxableAmt * tax2) / 100;
			float igstRs = (taxableAmt * (tax1 + tax2)) / 100;
			Float totalTax = sgstRs + cgstRs;
			float discAmt = 0;
			if (billQty == null || billQty == "") {// new code to handle hidden records
				billQty = "1";
			}

			Float discPer = 0.0f;
			if (frDetails.getIsSameState() == 1) {
				baseRate = (orderRate * 100) / (100 + (tax1 + tax2));
				taxableAmt = (float) (baseRate * Integer.parseInt(billQty));
				// ----------------------------------------------------------
				discAmt = ((taxableAmt * discPer) / 100); // new row added
				System.out.println("discAmt: " + discAmt);// new row added
				sumDiscAmt = sumDiscAmt + discAmt;

				taxableAmt = taxableAmt - discAmt; // new row added
				// ----------------------------------------------------------
				sgstRs = (taxableAmt * tax1) / 100;
				cgstRs = (taxableAmt * tax2) / 100;
				igstRs = 0;
				totalTax = sgstRs + cgstRs;

			}

			else {
				baseRate = (orderRate * 100) / (100 + (tax1 + tax2));
				taxableAmt = (float) (baseRate * Integer.parseInt(billQty));
				// ----------------------------------------------------------
				discAmt = ((taxableAmt * discPer) / 100); // new row added
				System.out.println("discAmt: " + discAmt);// new row added
				sumDiscAmt = sumDiscAmt + discAmt;

				taxableAmt = taxableAmt - discAmt; // new row added
				// ----------------------------------------------------------
				sgstRs = 0;
				cgstRs = 0;
				igstRs = (taxableAmt * (tax1 + tax2)) / 100;
				totalTax = igstRs;
			}

			sgstRs = roundUp(sgstRs);
			cgstRs = roundUp(cgstRs);
			igstRs = roundUp(igstRs);

			totalTax = roundUp(totalTax);

			Float grandTotal = totalTax + taxableAmt;
			grandTotal = roundUp(grandTotal);

			sumTaxableAmt = sumTaxableAmt + taxableAmt;
			sumTaxableAmt = roundUp(sumTaxableAmt);

			sumTotalTax = sumTotalTax + totalTax;
			sumTotalTax = roundUp(sumTotalTax);

			sumGrandTotal = sumGrandTotal + grandTotal;
			sumGrandTotal = roundUp(sumGrandTotal);

			billDetail.setOrderId(0);
			billDetail.setMenuId(40);//
			billDetail.setCatId(5);
			billDetail.setItemId(spId);
			billDetail.setOrderQty(1);
			billDetail.setBillQty(1);

			if (frDetails.getFrRateCat() == 1) {
				billDetail.setMrp(specialCake.getMrpRate1());//
			} else {
				billDetail.setMrp(specialCake.getMrpRate3());//

			}
			billDetail.setRateType(frDetails.getFrRateCat());
			billDetail.setRate(Float.parseFloat(spGrand));
			billDetail.setBaseRate(baseRate);
			billDetail.setTaxableAmt(taxableAmt);
			billDetail.setDiscPer(discPer);// new
			billDetail.setRemark("" + discAmt);// new
			billDetail.setSgstPer(tax1);
			billDetail.setSgstRs(sgstRs);
			billDetail.setCgstPer(tax2);
			billDetail.setCgstRs(cgstRs);
			billDetail.setIgstPer((tax1 + tax2));
			billDetail.setIgstRs(igstRs);
			billDetail.setTotalTax(totalTax);
			billDetail.setGrandTotal(grandTotal);
			billDetail.setDelStatus(0);
			billDetail.setIsGrngvnApplied(0);

			billDetail.setGrnType(3);// newly added

			header.setSgstSum(billDetail.getSgstRs());
			header.setCgstSum(billDetail.getCgstRs());
			header.setIgstSum(billDetail.getIgstRs());

			int itemShelfLife = 1;

			/*
			 * // inc exp date if these menuId if (gBill.getMenuId() == 44 ||
			 * gBill.getMenuId() == 45 || gBill.getMenuId() == 46) {
			 * 
			 * calculatedDate = incrementDate(calculatedDate, 1);
			 * 
			 * }
			 */

			DateFormat Df = new SimpleDateFormat("dd-MM-yyyy");
			String deliveryDate = Df.format(header.getBillDate());
			String calculatedDate = incrementDate(deliveryDate, itemShelfLife);

			Date expiryDate = null;
			try {
				expiryDate = Df.parse(calculatedDate);
			} catch (ParseException e) {

				e.printStackTrace();
			}
			billDetail.setExpiryDate(expiryDate);
			postBillDetailsList.add(billDetail);

			header.setTaxableAmt(sumTaxableAmt);
			header.setGrandTotal(Math.round(sumGrandTotal));
			header.setDiscAmt(sumDiscAmt);// new

			System.err.println("sumof grand total beofre " + sumGrandTotal);

			System.err.println("Math round up Sum " + header.getGrandTotal());
			header.setTotalTax(sumTotalTax);

			header.setStatus(1);
			header.setPostBillDetailsList(postBillDetailsList);

			ZoneId zoneId = ZoneId.of("Asia/Calcutta");
			ZonedDateTime zdt = ZonedDateTime.now(zoneId);
			// System.out.println("time ==" + zdt.format(null));

			SimpleDateFormat sdf = new SimpleDateFormat("kk:mm:ss ");
			TimeZone istTimeZone = TimeZone.getTimeZone("Asia/Kolkata");
			Date d = new Date();
			sdf.setTimeZone(istTimeZone);
			String strtime = sdf.format(d);

			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal = Calendar.getInstance();

			header.setRemark(dateFormat.format(cal.getTime()));
			header.setTime(strtime);
			postBillHeaderList.add(header);

			postBillDataCommon.setPostBillHeadersList(postBillHeaderList);

			Info info = restTemplate.postForObject(Constants.url + "insertBillData", postBillDataCommon, Info.class);

			System.out.println("Info Data insertBillData response " + info.toString());

		} catch (Exception e) {
			System.err.println("Exx in insertManualSpBill " + e.getMessage());
			e.printStackTrace();
		}

		// return "redirect:/pdf/showBillPdf/-/-/1,9";

		return "redirect:/showBillListForPrint";

	}

	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	public String incrementDate(String date, int day) {

		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		Calendar c = Calendar.getInstance();
		try {
			c.setTime(sdf.parse(date));

		} catch (ParseException e) {
			System.out.println("Exception while incrementing date " + e.getMessage());
			e.printStackTrace();
		}
		c.add(Calendar.DATE, day); // number of days to add
		date = sdf.format(c.getTime());

		return date;

	}
}
