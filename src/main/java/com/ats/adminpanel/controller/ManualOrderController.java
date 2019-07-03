package com.ats.adminpanel.controller;

import java.io.IOException;
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
import javax.servlet.http.HttpSession;

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

import com.ats.adminpanel.commons.AccessControll;
import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.GenerateBill;
import com.ats.adminpanel.model.Info;
import com.ats.adminpanel.model.ItemForMOrder;
import com.ats.adminpanel.model.Orders;
import com.ats.adminpanel.model.accessright.ModuleJson;
import com.ats.adminpanel.model.billing.PostBillDataCommon;
import com.ats.adminpanel.model.billing.PostBillDetail;
import com.ats.adminpanel.model.billing.PostBillHeader;
import com.ats.adminpanel.model.franchisee.FranchiseeAndMenuList;
import com.ats.adminpanel.model.franchisee.FranchiseeList;
import com.ats.adminpanel.model.franchisee.Menu;
import com.ats.adminpanel.model.item.Item;

@Controller
@Scope("session")
public class ManualOrderController {
	List<Orders> orderList = new ArrayList<Orders>();
	int billNo = 0;
	FranchiseeAndMenuList franchiseeAndMenuList;

	@RequestMapping(value = "/showManualOrder", method = RequestMethod.GET)
	public ModelAndView showManualOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {

		ModelAndView model = null;
		HttpSession session = request.getSession();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("showManualOrder", "showManualOrder", "1", "0", "0", "0", newModuleList);

		if (view.getError() == true) {

			model = new ModelAndView("accessDenied");

		} else {
			model = new ModelAndView("orders/manualOrder");
			try {
				RestTemplate restTemplate = new RestTemplate();
				franchiseeAndMenuList = restTemplate.getForObject(Constants.url + "getFranchiseeAndMenu",
						FranchiseeAndMenuList.class);
				orderList = new ArrayList<Orders>();
				System.out.println("Franchisee Response " + franchiseeAndMenuList.getAllFranchisee());

				model.addObject("allFranchiseeAndMenuList", franchiseeAndMenuList);
				model.addObject("billNo", billNo);
				billNo = 0;
			} catch (Exception e) {
				System.out.println("Franchisee Controller Exception " + e.getMessage());
			}
		}
		return model;

	}

	// ----------------------------------( METHOD)-------------------------
	@RequestMapping(value = "/getMenuForOrder", method = RequestMethod.GET)
	public @ResponseBody List<Menu> findAllMenu(@RequestParam(value = "fr_id", required = true) int frId) {

		List<Menu> menuList = new ArrayList<Menu>();
		List<Menu> confMenuList = new ArrayList<Menu>();
		try {
			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);
			// Calling Service to get Configured Menus
			Integer[] configuredMenuId = restTemplate.postForObject(Constants.url + "getConfiguredMenuId", map,
					Integer[].class);

			ArrayList<Integer> configuredMenuList = new ArrayList<Integer>(Arrays.asList(configuredMenuId));

			menuList = franchiseeAndMenuList.getAllMenu();

			for (Menu menu : menuList) {
				if (menu.getMainCatId() != 5 && menu.getMenuId() != 42) {
					for (int i = 0; i < configuredMenuList.size(); i++) {
						if (menu.getMenuId() == configuredMenuList.get(i)) {
							confMenuList.add(menu);
						}

					}
				}
			}
			System.out.println("configuredMenuList:" + confMenuList.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return confMenuList;
	}

	// ----------------------------------------END--------------------------------------------
	@RequestMapping(value = "/getItemsOfMenuId", method = RequestMethod.GET)
	public @ResponseBody List<Orders> commonItemById(@RequestParam(value = "menuId", required = true) int menuId,
			@RequestParam(value = "frId", required = true) int frId,
			@RequestParam(value = "by", required = true) int by,
			@RequestParam(value = "ordertype", required = true) int ordertype) throws ParseException {

		try {
			// System.out.println("menuId " + menuId);
			orderList = new ArrayList<Orders>();
			RestTemplate restTemplate = new RestTemplate();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			Date today = new Date();
			Date tomorrow = new Date(today.getTime() + (1000 * 60 * 60 * 24));
			java.sql.Date sqlCurrDate = new java.sql.Date(today.getTime());
			java.sql.Date sqlTommDate = new java.sql.Date(tomorrow.getTime());

			List<Menu> menuList = franchiseeAndMenuList.getAllMenu();
			Menu frMenu = new Menu();
			for (Menu menu : menuList) {
				if (menu.getMenuId() == menuId) {
					frMenu = menu;
					break;
				}
			}
			int selectedCatId = frMenu.getMainCatId();

			System.out.println("Finding Item List for Selected CatId=" + selectedCatId);

			java.util.Date utilDate = new java.util.Date(sqlCurrDate.getTime());

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("itemGrp1", selectedCatId);
			map.add("menuId", menuId);
			map.add("frId", frId);
			map.add("prodDate", formatter.format(utilDate));
			map.add("ordertype", ordertype);
			ItemForMOrder[] itemRes = restTemplate.postForObject(Constants.url + "getItemListForMOrder", map,
					ItemForMOrder[].class);
			ArrayList<ItemForMOrder> itemList = new ArrayList<ItemForMOrder>(Arrays.asList(itemRes));
			System.out.println("Filter Item List " + itemList.toString());

			FranchiseeAndMenuList franchiseeListRes = restTemplate.getForObject(Constants.url + "getFranchiseeAndMenu",
					FranchiseeAndMenuList.class);
			System.out.println("franchiseeList" + franchiseeListRes.toString());
			FranchiseeList franchiseeList = null;

			for (int i = 0; i < franchiseeListRes.getAllFranchisee().size(); i++) {
				if (franchiseeListRes.getAllFranchisee().get(i).getFrId() == frId) {
					franchiseeList = franchiseeListRes.getAllFranchisee().get(i);
				}
			}

			for (ItemForMOrder item : itemList) {

				Orders order = new Orders();
				if (by == 0) {
					if (franchiseeList.getFrRateCat() == 1) {
						order.setOrderRate(item.getItemRate1());
						order.setOrderMrp(item.getItemMrp1());
					} else if (franchiseeList.getFrRateCat() == 2) {
						order.setOrderRate(item.getItemRate2());
						order.setOrderMrp(item.getItemMrp2());
					} else {
						order.setOrderRate(item.getItemRate3());
						order.setOrderMrp(item.getItemMrp3());
					}

				} else {

					if (franchiseeList.getFrRateCat() == 1) {
						order.setOrderRate(item.getItemMrp1());
						order.setOrderMrp(item.getItemMrp1());
					} else if (franchiseeList.getFrRateCat() == 2) {
						order.setOrderRate(item.getItemMrp2());
						order.setOrderMrp(item.getItemMrp2());
					} else {
						order.setOrderRate(item.getItemMrp3());
						order.setOrderMrp(item.getItemMrp3());
					}

				}
				if (ordertype == 0) {
					order.setRefId(0);
				} else {
					order.setRefId(1);
				}

				int frGrnTwo = franchiseeList.getGrnTwo();
				System.err.println("frGrnTwo" + frGrnTwo + "item.getGrnTwo()" + item.getGrnTwo());
				/*if (item.getGrnTwo() == 1) {*/
					if (frGrnTwo == 1) {

						order.setGrnType(1);

					} else {

						order.setGrnType(0);
					}
				/*} // end of if

				else {
					if (item.getGrnTwo() == 2) {
						order.setGrnType(2);

					} else {
						order.setGrnType(0);
					}
				}*/ // end of else
				if (menuId == 29 || menuId == 30 || menuId == 42 || menuId == 43 || menuId == 44 || menuId == 47) {

					order.setGrnType(3);

				}
				// for push grn
				if (menuId == 48) {

					order.setGrnType(4);
				}

				order.setOrderId(0);
				order.setItemId(String.valueOf(item.getId()));
				order.setItemName(item.getItemName() + "--[" + franchiseeList.getFrCode() + "]");
				order.setFrId(frId);
				if (menuId == 29 || menuId == 86 || menuId == 87 ) {
					order.setDeliveryDate(sqlCurrDate);
				} else {
					order.setDeliveryDate(sqlTommDate);
				}
				order.setMinQty(item.getMinQty());
				order.setIsEdit(0);
				order.setEditQty(0);/// set order qty on submit
				order.setIsPositive(item.getDiscPer());
				order.setMenuId(menuId);
				order.setOrderDate(sqlCurrDate);
				order.setOrderDatetime("" + sqlCurrDate);
				order.setUserId(0);
				order.setOrderQty(item.getOrderQty());
				order.setOrderStatus(0);
				order.setOrderType(item.getItemGrp1());
				order.setOrderSubType(item.getItemGrp2());
				order.setProductionDate(sqlCurrDate);
				// order.setRefId(item.getId());

				orderList.add(order);

			}
			System.out.println("------------------------" + orderList.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return orderList;
	}

	@RequestMapping(value = "/insertItem", method = RequestMethod.GET)
	public @ResponseBody List<Orders> insertItem(HttpServletRequest request, HttpServletResponse response) {

		try {

			int itemId = Integer.parseInt(request.getParameter("itemId"));
			// System.out.println("itemId"+itemId);

			int frId = Integer.parseInt(request.getParameter("frId"));
			// System.out.println("frId"+frId);

			int menuId = Integer.parseInt(request.getParameter("menuId"));
			// System.out.println("menuId"+menuId);

			int qty = Integer.parseInt(request.getParameter("qty"));
			// System.out.println("qty"+qty);

			RestTemplate restTemplate = new RestTemplate();
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("id", itemId);

			Item item = restTemplate.postForObject("" + Constants.url + "getItem", map, Item.class);
			// System.out.println("ItemResponse" + item);

			map = new LinkedMultiValueMap<String, Object>();
			map.add("id", itemId);
			map.add("frId", frId);
			float discPer = restTemplate.postForObject(Constants.url + "getDiscById", map, Float.class);

			map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);

			FranchiseeList franchiseeList = restTemplate.getForObject(Constants.url + "getFranchisee?frId={frId}",
					FranchiseeList.class, frId);
			// System.out.println("franchiseeList" + franchiseeList.toString());

			Orders order = new Orders();

			if (franchiseeList.getFrRateCat() == 1) {
				order.setOrderRate(item.getItemRate1());
				order.setOrderMrp(item.getItemMrp1());
			} else if (franchiseeList.getFrRateCat() == 2) {
				order.setOrderRate(item.getItemRate2());
				order.setOrderMrp(item.getItemMrp2());
			} else {
				order.setOrderRate(item.getItemRate3());
				order.setOrderMrp(item.getItemMrp3());
			}
			int frGrnTwo = franchiseeList.getGrnTwo();
			// System.err.println("frGrnTwo"+frGrnTwo+"item.getGrnTwo()"+item.getGrnTwo());
			if (item.getGrnTwo() == 1) {

				if (frGrnTwo == 1) {

					order.setGrnType(1);

				} else {

					order.setGrnType(0);
				}
			} // end of if

			else {
				if (item.getGrnTwo() == 2) {
					order.setGrnType(2);

				} else {
					order.setGrnType(0);
				}
			} // end of else
			if (menuId == 29 || menuId == 30 || menuId == 42 || menuId == 43 || menuId == 44 || menuId == 47) {

				order.setGrnType(3);

			}
			// for push grn
			if (menuId == 48) {

				order.setGrnType(4);
			}

			Date today = new Date();
			Date tomorrow = new Date(today.getTime() + (1000 * 60 * 60 * 24));
			java.sql.Date sqlCurrDate = new java.sql.Date(today.getTime());
			java.sql.Date sqlTommDate = new java.sql.Date(tomorrow.getTime());

			order.setOrderId(0);
			order.setItemId(String.valueOf(itemId));
			order.setItemName(item.getItemName() + "--[" + franchiseeList.getFrCode() + "]");
			order.setFrId(frId);
			if (menuId == 29 || menuId == 86 || menuId == 87) {
				order.setDeliveryDate(sqlCurrDate);
			} else {
				order.setDeliveryDate(sqlTommDate);
			}
			order.setIsEdit(0);
			order.setEditQty(qty);
			order.setIsPositive(discPer);
			order.setMenuId(menuId);
			order.setOrderDate(sqlCurrDate);
			order.setOrderDatetime("" + sqlCurrDate);
			order.setUserId(0);
			order.setOrderQty(qty);
			order.setOrderStatus(0);
			order.setOrderType(item.getItemGrp1());
			order.setOrderSubType(item.getItemGrp2());
			order.setProductionDate(sqlCurrDate);
			order.setRefId(itemId);

			orderList.add(order);

			// System.out.println("orderListinserted:"+orderList.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return orderList;
	}

	/*
	 * @RequestMapping(value = "/deleteItems", method = RequestMethod.GET)
	 * public @ResponseBody List<Orders> deleteItemDetail(HttpServletRequest
	 * request, HttpServletResponse response) { ResponseEntity<String>
	 * orderListResponse=null; try {
	 * 
	 * int index=Integer.parseInt(request.getParameter("key"));
	 * orderList.remove(index);
	 * 
	 * System.out.println("OrderList :"+orderList.toString()); } catch (Exception e)
	 * { e.printStackTrace();
	 * 
	 * } return orderList; }
	 */
	@RequestMapping(value = "/generateManualBill", method = RequestMethod.POST)
	public String generateManualBill(HttpServletRequest request, HttpServletResponse response) {

		GenerateBill[] orderListResponse = null;
		List<Orders> orderListSave = new ArrayList<>();
		String submitorder = request.getParameter("submitorder");
		String submitbill = request.getParameter("submitbill");
		int frId = Integer.parseInt(request.getParameter("fr_id"));
		try {
			RestTemplate restTemplate = new RestTemplate();
			if (orderList != null || !orderList.isEmpty()) {

				for (int i = 0; i < orderList.size(); i++) {
					int qty = Integer.parseInt(request.getParameter("qty" + orderList.get(i).getItemId()));
					if (submitorder == null) {
						System.err.println("submitorder");
						float discPer = Float
								.parseFloat(request.getParameter("discper" + orderList.get(i).getItemId()));// new on 15
																											// feb for
																											// dis on
																											// bill
						orderList.get(i).setIsPositive(discPer);// new on 15 feb for dis on bill
						System.err.println("discPer==" + discPer);
					}
					orderList.get(i).setEditQty(qty);
					orderList.get(i).setOrderQty(qty);
					if (qty > 0) {
						orderListSave.add(orderList.get(i));
					}
				}
				if (submitorder != null) {
					orderListResponse = restTemplate.postForObject(Constants.url + "placeManualOrder", orderListSave,
							GenerateBill[].class);
				} else {// placeManualOrderNew --- not updates prev avail item order -each time new
						// entry
					orderListResponse = restTemplate.postForObject(Constants.url + "placeManualOrderNew", orderListSave,
							GenerateBill[].class);

				}
				orderList = new ArrayList<Orders>();// LIST CLEARED
				List<GenerateBill> tempGenerateBillList = new ArrayList<GenerateBill>(Arrays.asList(orderListResponse));

				if (submitbill != null) {

					String partyName = request.getParameter("frName");
					String partyGstin = request.getParameter("gstin");
					String partyAddress = request.getParameter("address");
					// System.out.println("Place Order Response" + orderListResponse.toString());

					PostBillDataCommon postBillDataCommon = new PostBillDataCommon();
					List<PostBillHeader> postBillHeaderList = new ArrayList<PostBillHeader>();
					List<PostBillDetail> postBillDetailsList = new ArrayList<PostBillDetail>();

					PostBillHeader header = new PostBillHeader();
					header.setFrId(frId);

					float sumTaxableAmt = 0, sumTotalTax = 0, sumGrandTotal = 0;
					float sumDiscAmt = 0;

					for (int j = 0; j < tempGenerateBillList.size(); j++) {

						GenerateBill gBill = tempGenerateBillList.get(j);

						System.out.println("Inner For frId " + gBill.getFrId());

						System.out.println("If condn true " + gBill.getFrId());

						PostBillDetail billDetail = new PostBillDetail();

						String billQty = "" + tempGenerateBillList.get(j).getOrderQty();
						float discPer = tempGenerateBillList.get(j).getIsPositive();

						// billQty = String.valueOf(gBill.getOrderQty());
						Float orderRate = (float) gBill.getOrderRate();
						Float tax1 = (float) gBill.getItemTax1();
						Float tax2 = (float) gBill.getItemTax2();
						Float tax3 = (float) gBill.getItemTax3();

						Float baseRate = (orderRate * 100) / (100 + (tax1 + tax2));
						baseRate = roundUp(baseRate);

						Float taxableAmt = (float) (baseRate * Integer.parseInt(billQty));

						System.out.println("taxableAmt: " + taxableAmt);
						taxableAmt = roundUp(taxableAmt);

						float sgstRs = (taxableAmt * tax1) / 100;
						float cgstRs = (taxableAmt * tax2) / 100;
						float igstRs = (taxableAmt * tax3) / 100;
						Float totalTax = sgstRs + cgstRs;
						float discAmt = 0;
						if (billQty == null || billQty == "") {// new code to handle hidden records
							billQty = "0";
						}

						if (gBill.getIsSameState() == 1) {
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
							baseRate = (orderRate * 100) / (100 + (tax3));
							taxableAmt = (float) (baseRate * Integer.parseInt(billQty));
							// ----------------------------------------------------------
							discAmt = ((taxableAmt * discPer) / 100); // new row added
							System.out.println("discAmt: " + discAmt);// new row added
							sumDiscAmt = sumDiscAmt + discAmt;

							taxableAmt = taxableAmt - discAmt; // new row added
							// ----------------------------------------------------------
							sgstRs = 0;
							cgstRs = 0;
							igstRs = (taxableAmt * tax3) / 100;
							totalTax = igstRs;
						}

						sgstRs = roundUp(sgstRs);
						cgstRs = roundUp(cgstRs);
						igstRs = roundUp(igstRs);

						// header.setSgstSum(sumT1);
						// header.setCgstSum(sumT2);
						// header.setIgstSum(sumT3);

						totalTax = roundUp(totalTax);

						Float grandTotal = totalTax + taxableAmt;
						grandTotal = roundUp(grandTotal);

						sumTaxableAmt = sumTaxableAmt + taxableAmt;
						sumTaxableAmt = roundUp(sumTaxableAmt);

						sumTotalTax = sumTotalTax + totalTax;
						sumTotalTax = roundUp(sumTotalTax);

						sumGrandTotal = sumGrandTotal + grandTotal;
						sumGrandTotal = roundUp(sumGrandTotal);

						billDetail.setOrderId(tempGenerateBillList.get(j).getOrderId());
						billDetail.setMenuId(gBill.getMenuId());
						billDetail.setCatId(gBill.getCatId());
						billDetail.setItemId(gBill.getItemId());
						billDetail.setOrderQty(gBill.getOrderQty());
						billDetail.setBillQty(Integer.parseInt(billQty));
						billDetail.setMrp((float) gBill.getOrderMrp());
						billDetail.setRateType(gBill.getRateType());
						billDetail.setRate((float) gBill.getOrderRate());
						billDetail.setBaseRate(roundUp(baseRate));
						billDetail.setTaxableAmt(roundUp(taxableAmt));
						billDetail.setDiscPer(discPer);// new
						billDetail.setRemark("" + roundUp(discAmt));// new
						billDetail.setSgstPer(tax1);
						billDetail.setSgstRs(sgstRs);
						billDetail.setCgstPer(tax2);
						billDetail.setCgstRs(cgstRs);
						billDetail.setIgstPer(tax3);
						billDetail.setIgstRs(igstRs);
						billDetail.setTotalTax(totalTax);
						billDetail.setGrandTotal(grandTotal);
						billDetail.setDelStatus(0);
						billDetail.setIsGrngvnApplied(0);
						billDetail.setHsnCode(gBill.getHsnCode());// newly added
						billDetail.setGrnType(gBill.getGrnType());// newly added

						header.setSgstSum(header.getSgstSum() + billDetail.getSgstRs());
						header.setCgstSum(header.getCgstSum() + billDetail.getCgstRs());
						header.setIgstSum(header.getIgstSum() + billDetail.getIgstRs());

						int itemShelfLife = gBill.getItemShelfLife();

						String deliveryDate = gBill.getDeliveryDate();

						String calculatedDate = incrementDate(deliveryDate, itemShelfLife);

						// inc exp date if these menuId
						if (gBill.getMenuId() == 67 || gBill.getMenuId() == 86 || gBill.getMenuId() == 90) {

							calculatedDate = incrementDate(calculatedDate, 1);

						}

						DateFormat Df = new SimpleDateFormat("dd-MM-yyyy");

						Date expiryDate = null;
						try {
							expiryDate = Df.parse(calculatedDate);
						} catch (ParseException e) {

							e.printStackTrace();
						}

						billDetail.setExpiryDate(expiryDate);
						postBillDetailsList.add(billDetail);
						header.setFrCode(gBill.getFrCode());

						header.setRemark("");
						header.setTaxApplicable((int) (gBill.getItemTax1() + gBill.getItemTax2()));

					}
					header.setBillDate(new Date());// hardcoded curr Date
					header.setTaxableAmt(roundUp(sumTaxableAmt));
					header.setGrandTotal(roundUp(sumGrandTotal));
					header.setDiscAmt(roundUp(sumDiscAmt));// new

					System.err.println("sumof grand total beofre " + sumGrandTotal);

					System.err.println("Math round up Sum " + header.getGrandTotal());
					header.setTotalTax(sumTotalTax);

					header.setStatus(1);
					header.setPostBillDetailsList(postBillDetailsList);

					ZoneId zoneId = ZoneId.of("Asia/Calcutta");
					ZonedDateTime zdt = ZonedDateTime.now(zoneId);

					SimpleDateFormat sdf = new SimpleDateFormat("kk:mm:ss ");
					TimeZone istTimeZone = TimeZone.getTimeZone("Asia/Kolkata");
					Date d = new Date();
					sdf.setTimeZone(istTimeZone);
					String strtime = sdf.format(d);

					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Calendar cal = Calendar.getInstance();

					header.setRemark(dateFormat.format(cal.getTime()));
					header.setTime(strtime);
					header.setPartyName(partyName);
					header.setPartyGstin(partyGstin);
					header.setPartyAddress(partyAddress);
					
					header.setBillTime("-");
					header.setVehNo("-");
					header.setExVarchar1("-");
					header.setExVarchar2("-");
					postBillHeaderList.add(header);
					postBillDataCommon.setPostBillHeadersList(postBillHeaderList);

					System.out.println("Test data : " + postBillDataCommon.toString());

					PostBillHeader[] respList = restTemplate.postForObject(Constants.url + "insertBillData",
							postBillDataCommon, PostBillHeader[].class);

					List<PostBillHeader> billRespList = new ArrayList<PostBillHeader>(Arrays.asList(respList));

					billNo = billRespList.get(0).getBillNo();
					System.out.println("Save Res Data " + respList.toString());

				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/showManualOrder";
	}

	/*
	 * @RequestMapping(value = "/showManualOrder", method = RequestMethod.GET)
	 * public ModelAndView showManualOrder(HttpServletRequest request,
	 * HttpServletResponse response) {
	 * 
	 * ModelAndView model = new ModelAndView("orders/manualOrder"); try {
	 * RestTemplate restTemplate = new RestTemplate(); franchiseeAndMenuList =
	 * restTemplate.getForObject(Constants.url + "getFranchiseeAndMenu",
	 * FranchiseeAndMenuList.class); orderList=new ArrayList<Orders>();
	 * System.out.println("Franchisee Response " +
	 * franchiseeAndMenuList.getAllFranchisee());
	 * 
	 * model.addObject("allFranchiseeAndMenuList", franchiseeAndMenuList);
	 * 
	 * } catch (Exception e) { System.out.println("Franchisee Controller Exception "
	 * + e.getMessage()); } return model;
	 * 
	 * } // METHOD)-------------------------
	 * 
	 * @RequestMapping(value = "/getMenuForOrder", method = RequestMethod.GET)
	 * public @ResponseBody List<Menu> findAllMenu(@RequestParam(value = "fr_id",
	 * required = true) int frId) {
	 * 
	 * List<Menu> menuList = new ArrayList<Menu>(); List<Menu> confMenuList = new
	 * ArrayList<Menu>(); try { RestTemplate restTemplate = new RestTemplate();
	 * 
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>(); map.add("frId", frId); // Calling Service to get Configured Menus
	 * Integer[] configuredMenuId = restTemplate.postForObject(Constants.url +
	 * "getConfiguredMenuId", map, Integer[].class);
	 * 
	 * ArrayList<Integer> configuredMenuList = new
	 * ArrayList<Integer>(Arrays.asList(configuredMenuId));
	 * 
	 * menuList = franchiseeAndMenuList.getAllMenu();
	 * 
	 * for (Menu menu : menuList) { if(menu.getMainCatId()!=5 &&
	 * menu.getMenuId()!=42) { for (int i = 0; i < configuredMenuList.size(); i++) {
	 * if (menu.getMenuId() == configuredMenuList.get(i)) { confMenuList.add(menu);
	 * }
	 * 
	 * } } } System.out.println("configuredMenuList:"+confMenuList.toString()); }
	 * catch (Exception e) { e.printStackTrace(); } return confMenuList; } //
	 * ----------------------------------------END----------------------------------
	 * ----------
	 * 
	 * @RequestMapping(value = "/getItemsOfMenuId", method = RequestMethod.GET)
	 * public @ResponseBody List<CommonConf> commonItemById(@RequestParam(value =
	 * "menuId", required = true) int menuId) {
	 * 
	 * System.out.println("menuId " + menuId);
	 * 
	 * RestTemplate restTemplate = new RestTemplate();
	 * 
	 * List<Menu> menuList = franchiseeAndMenuList.getAllMenu(); Menu frMenu = new
	 * Menu(); for (Menu menu : menuList) { if (menu.getMenuId() == menuId) { frMenu
	 * = menu; break; } } int selectedCatId = frMenu.getMainCatId();
	 * 
	 * System.out.println("Finding Item List for Selected CatId=" + selectedCatId);
	 * 
	 * List<SpecialCake> specialCakeList = new ArrayList<SpecialCake>();
	 * 
	 * List<CommonConf> commonConfList = new ArrayList<CommonConf>();
	 * 
	 * if (selectedCatId == 5) { SpCakeResponse spCakeResponse =
	 * restTemplate.getForObject(Constants.url + "showSpecialCakeList",
	 * SpCakeResponse.class);
	 * System.out.println("SpCake Controller SpCakeList Response " +
	 * spCakeResponse.toString());
	 * 
	 * specialCakeList = spCakeResponse.getSpecialCake();
	 * 
	 * for (SpecialCake specialCake : specialCakeList) { CommonConf commonConf = new
	 * CommonConf(); commonConf.setId(specialCake.getSpId());
	 * commonConf.setName(specialCake.getSpCode() + "-" + specialCake.getSpName());
	 * commonConfList.add(commonConf); System.out.println("spCommonConf" +
	 * commonConf.toString()); }
	 * 
	 * System.out.println("------------------------"); } else {
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>(); map.add("itemGrp1", selectedCatId);
	 * 
	 * Item[] item = restTemplate.postForObject(Constants.url + "getItemsByCatId",
	 * map, Item[].class); ArrayList<Item> itemList = new
	 * ArrayList<Item>(Arrays.asList(item)); System.out.println("Filter Item List "
	 * + itemList.toString());
	 * 
	 * for (Item items : itemList) { CommonConf commonConf = new CommonConf();
	 * commonConf.setId(items.getId()); commonConf.setName(items.getItemName());
	 * commonConfList.add(commonConf); System.out.println("itemCommonConf" +
	 * commonConf.toString()); } System.out.println("------------------------"); }
	 * 
	 * return commonConfList; }
	 * 
	 * @RequestMapping(value = "/insertItem", method = RequestMethod.GET)
	 * public @ResponseBody List<Orders> insertItem(HttpServletRequest request,
	 * HttpServletResponse response) {
	 * 
	 * try {
	 * 
	 * int itemId=Integer.parseInt(request.getParameter("itemId"));
	 * System.out.println("itemId"+itemId);
	 * 
	 * int frId=Integer.parseInt(request.getParameter("frId"));
	 * System.out.println("frId"+frId);
	 * 
	 * int menuId=Integer.parseInt(request.getParameter("menuId"));
	 * System.out.println("menuId"+menuId);
	 * 
	 * int qty=Integer.parseInt(request.getParameter("qty"));
	 * System.out.println("qty"+qty);
	 * 
	 * RestTemplate restTemplate = new RestTemplate(); MultiValueMap<String, Object>
	 * map = new LinkedMultiValueMap<String, Object>(); map.add("id", itemId);
	 * 
	 * Item item = restTemplate.postForObject("" + Constants.url + "getItem",
	 * map,Item.class); System.out.println("ItemResponse" + item);
	 * 
	 * map = new LinkedMultiValueMap<String, Object>(); map.add("id", itemId);
	 * map.add("frId", frId); float discPer=restTemplate.postForObject(Constants.url
	 * + "getDiscById", map,Float.class);
	 * 
	 * map = new LinkedMultiValueMap<String, Object>();
	 * 
	 * map.add("frId", frId);
	 * 
	 * FranchiseeList franchiseeList = restTemplate.getForObject(Constants.url +
	 * "getFranchisee?frId={frId}", FranchiseeList.class, frId);
	 * System.out.println("franchiseeList" + franchiseeList.toString());
	 * 
	 * Orders order=new Orders();
	 * 
	 * if(franchiseeList.getFrRateCat()==1) {
	 * order.setOrderRate(item.getItemRate1());
	 * order.setOrderMrp(item.getItemMrp1()); } else
	 * if(franchiseeList.getFrRateCat()==2) {
	 * order.setOrderRate(item.getItemRate2());
	 * order.setOrderMrp(item.getItemMrp2()); } else {
	 * order.setOrderRate(item.getItemRate3());
	 * order.setOrderMrp(item.getItemMrp3()); } int
	 * frGrnTwo=franchiseeList.getGrnTwo();
	 * System.err.println("frGrnTwo"+frGrnTwo+"item.getGrnTwo()"+item.getGrnTwo());
	 * if(item.getGrnTwo()==1) {
	 * 
	 * if(frGrnTwo==1) {
	 * 
	 * order.setGrnType(1);
	 * 
	 * 
	 * }else {
	 * 
	 * order.setGrnType(0); } }//end of if
	 * 
	 * else { if(item.getGrnTwo()==2) { order.setGrnType(2);
	 * 
	 * } else { order.setGrnType(0); } }// end of else
	 * if(menuId==29||menuId==30||menuId==42||menuId==43|| menuId==44||menuId==47) {
	 * 
	 * order.setGrnType(3);
	 * 
	 * } //for push grn if(menuId==48) {
	 * 
	 * order.setGrnType(4); }
	 * 
	 * Date today = new Date(); Date tomorrow = new Date(today.getTime() + (1000 *
	 * 60 * 60 * 24)); java.sql.Date sqlCurrDate = new
	 * java.sql.Date(today.getTime()); java.sql.Date sqlTommDate = new
	 * java.sql.Date(tomorrow.getTime());
	 * 
	 * order.setOrderId(0); order.setItemId(String.valueOf(itemId));
	 * order.setItemName(item.getItemName()+"--["+franchiseeList.getFrCode()+"]");
	 * order.setFrId(frId); if(menuId==44||menuId==45) {
	 * order.setDeliveryDate(sqlCurrDate); }else {
	 * order.setDeliveryDate(sqlTommDate); } order.setIsEdit(0);
	 * order.setEditQty(qty); order.setIsPositive(discPer); order.setMenuId(menuId);
	 * order.setOrderDate(sqlCurrDate); order.setOrderDatetime(""+sqlCurrDate);
	 * order.setUserId(0); order.setOrderQty(qty); order.setOrderStatus(0);
	 * order.setOrderType(item.getItemGrp1());
	 * order.setOrderSubType(item.getItemGrp2());
	 * order.setProductionDate(sqlCurrDate); order.setRefId(itemId);
	 * 
	 * orderList.add(order);
	 * 
	 * System.out.println("orderListinserted:"+orderList.toString());
	 * 
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return orderList; }
	 * 
	 * @RequestMapping(value = "/deleteItems", method = RequestMethod.GET)
	 * public @ResponseBody List<Orders> deleteItemDetail(HttpServletRequest
	 * request, HttpServletResponse response) { ResponseEntity<String>
	 * orderListResponse=null; try {
	 * 
	 * int index=Integer.parseInt(request.getParameter("key"));
	 * orderList.remove(index);
	 * 
	 * System.out.println("OrderList :"+orderList.toString()); } catch (Exception e)
	 * { e.printStackTrace();
	 * 
	 * } return orderList; }
	 * 
	 * @RequestMapping(value = "/generateManualBill", method = RequestMethod.GET)
	 * public @ResponseBody List<Orders> generateManualBill(HttpServletRequest
	 * request, HttpServletResponse response) {
	 * 
	 * List<Orders> orderListResponse=new ArrayList<>(); try { RestTemplate
	 * restTemplate = new RestTemplate(); if(orderList!=null ||
	 * !orderList.isEmpty()) { orderListResponse =
	 * restTemplate.postForObject(Constants.url + "placeOrder",
	 * orderList,List.class); orderList=new ArrayList<Orders>();
	 * System.out.println("Place Order Response" + orderListResponse.toString()); }
	 * } catch (Exception e) { e.printStackTrace(); } return orderListResponse; }
	 */

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
