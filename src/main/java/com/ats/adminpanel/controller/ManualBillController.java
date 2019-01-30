package com.ats.adminpanel.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.ats.adminpanel.model.SearchSpCakeResponse;
import com.ats.adminpanel.model.SpCakeResponse;
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
			System.out.println("SpCake Controller SpCakeList Response 0000000" + spCakeResponse.toString());

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
				currentWt = currentWt + specialCake.getSpRate2();//spr rate 2 means weight increment by 
				weightList.add(currentWt);
			} 

			System.out.println("Weight List for SP Cake: " + weightList.toString());

			if (frDetails.getFrRateCat() == 1) {
				sprRate = specialCake.getMrpRate1();
				spBackendRate = specialCake.getSpRate1();

			}/* else if (frDetails.getFrRateCat() == 2) {
				sprRate = specialCake.getMrpRate2();
				spBackendRate = specialCake.getSpRate2(); //No frRateCate 2 is present in franchisee
			}*/else {
				sprRate = specialCake.getMrpRate3();
				spBackendRate = specialCake.getSpRate3();

			}

			model.addObject("sprRate", sprRate);
			model.addObject("spBackendRate", spBackendRate);
			
			model.addObject("weightList", weightList);


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

		flavourList = restTemplate.getForObject(Constants.url + "/showFlavourList", FlavourList.class);
		flavoursList = flavourList.getFlavour();

		try {

			flavoursList = flavourList.getFlavour();

			System.out.println("FLAVOURS:" + flavoursList.toString());

			System.out.println("DB Sptype" + flavoursList.get(0).getSpType());

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
					System.err.println(flavour.getSpfId());
					System.err.println(flavoursListWithAddonRate.toString());
				} else {
					flavour.setSpfAdonRate(0.0);
					flavoursListWithAddonRate.add(flavour);
				}
			}
			System.out.println("Filter Item List " + flavoursListWithAddonRate.toString());
		} catch (Exception e) {
			System.out.println("Exception in getFlavourBySpfId() AJAX CALL");

		}

		// return flavoursListWithAddonRate;

		// return flavoursListWithAddonRate;

		return flavoursList;

	}
}
