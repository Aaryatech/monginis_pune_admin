package com.ats.adminpanel.controller.temp;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.commons.EInvoice_Constants_CN;
import com.ats.adminpanel.model.ErrorMessage;
import com.ats.adminpanel.model.billing.Company;
import com.ats.adminpanel.model.einv.BuyerDetails;
import com.ats.adminpanel.model.einv.CustomErrEwayBill;
import com.ats.adminpanel.model.einv.DocSetails;
import com.ats.adminpanel.model.einv.ItmList;
import com.ats.adminpanel.model.einv.ReqPlCancelIRN;
import com.ats.adminpanel.model.einv.ReqPlGenIRN;
import com.ats.adminpanel.model.einv.RespAuthPl;
import com.ats.adminpanel.model.einv.RespGenIRNInvData;
import com.ats.adminpanel.model.einv.RespPlCancelIRN;
import com.ats.adminpanel.model.einv.RespPlGenIRN;
import com.ats.adminpanel.model.einv.SellerDetails;
import com.ats.adminpanel.model.einv.ShippedDetails;
import com.ats.adminpanel.model.einv.TranDetails;
import com.ats.adminpanel.model.einv.ValDetails;
import com.ats.adminpanel.model.franchisee.FranchiseSup;
import com.ats.adminpanel.model.franchisee.FranchiseeList;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
@Scope("session")
public class EInvForCredNoteCont {
	String cleanUpJsonBOM(String res1) {
		return res1.trim().replaceFirst("\ufeff", "");
	}

	@RequestMapping(value = "/genEInvBill1", method = RequestMethod.POST)
	public @ResponseBody List<CustomErrEwayBill> genEInvBill(HttpServletRequest request, HttpServletResponse response) {
		List<CustomErrEwayBill> errorBillList = new ArrayList<CustomErrEwayBill>();
		RestTemplate restTemplate = new RestTemplate();
		List<RespPlGenIRN> einvSuccessList = new ArrayList<RespPlGenIRN>();

		try {
			ObjectMapper mapperObj = new ObjectMapper();
			String billList = new String();
			ResponseEntity<List<EInvBillHeader>> bRes = null;
			
			  String[] selectedBills = request.getParameterValues("select_to_agree");
			  String vehNo = request.getParameter("vehNo"); 
			
			  for (int i = 0; i < selectedBills.length; i++) { billList = selectedBills[i]
			  + "," + billList; }
			 
			// String selectedBills2= request.getParameter("select_to_agree");
			  billList = billList.substring(0, billList.length() - 1);
			  System.err.println("selectedBills2 " + billList.toString());
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("crnIdList", billList);

			ParameterizedTypeReference<List<EInvBillHeader>> typeRef1 = new ParameterizedTypeReference<List<EInvBillHeader>>() {
			};
			try {
				bRes = restTemplate.exchange(Constants.url + "getCredNoteListForEInvoice", HttpMethod.POST,
						new HttpEntity<>(map), typeRef1);
			} catch (HttpClientErrorException e) {
				System.err.println("/getBillListForEInvoice Http Excep \n " + e.getResponseBodyAsString());
			}
			List<EInvBillHeader> billHeaderList = bRes.getBody();

			// System.err.println("billHeaderList " + billHeaderList.toString());

			RespAuthPl tokenRes = null; // = restTemplate.getForObject(EwayConstants.getToken, GetAuthToken.class);
			ResponseEntity<String> tokRes = null;

			ParameterizedTypeReference<String> typeRef2 = new ParameterizedTypeReference<String>() {
			};
			try {
				tokRes = restTemplate.exchange(EInvoice_Constants_CN.E_INV_AUTH_TOKEN_URL, HttpMethod.GET,
						new HttpEntity<>(null), typeRef2);
				try {
					System.err.println("Token Res SAA " + tokRes.toString());
					tokenRes = mapperObj.readValue(tokRes.getBody(), RespAuthPl.class);

				} catch (HttpClientErrorException e) {
					System.err.println("Inner HTTP TOKEN EX getToken" + e.getResponseBodyAsString());
				} catch (Exception e) {
					e.printStackTrace();
					System.err.println("Inner try for getToken" + e.getMessage());
				}
			}catch (HttpServerErrorException e) {
				System.err.println("Inner HttpServerErrorException" + e.getResponseBodyAsString());
			} catch (HttpClientErrorException e) {
				System.err.println("/getToken Http Excep \n " + e.getResponseBodyAsString());
			}
			EInvoice_Constants_CN.AUTH_TOKEN = tokenRes.getData().getAuthToken();
			RespPlGenIRN einvSuccess = null;
			ResponseCode ewayErrRes = null;
			ParameterizedTypeReference<String> typeRef = new ParameterizedTypeReference<String>() {
			};
			ResponseEntity<String> responseEntity = null;

			Company company = restTemplate.getForObject(Constants.url + "/getCompany", Company.class);
			// System.err.println("company " + company.toString());
			int isStaticData = 0;
			String GSTIN = "34AACCC1596Q002";
			String BuyerGSTIN = "34AAGCM8851L1ZZ";
			// String GSTIN="27ABOFM3012D1ZK";
			for (int i = 0; i < billHeaderList.size(); i++) {
				einvSuccess = new RespPlGenIRN();
				EInvBillHeader bill = billHeaderList.get(i);
				map = new LinkedMultiValueMap<String, Object>();
				map.add("frId", bill.getFrId());

				FranchiseSup frSup = restTemplate.postForObject(Constants.url + "/getfrSupByFrID", map,
						FranchiseSup.class);

				FranchiseeList frData = restTemplate.getForObject(Constants.url + "getFranchisee?frId={frId}",
						FranchiseeList.class, bill.getFrId());

				ReqPlGenIRN billReq = new ReqPlGenIRN();

				BuyerDetails buyerDtls = new BuyerDetails();

				buyerDtls.setAddr1(frData.getFrAddress().trim());
				// buyerDtls.setGstin("29AWGPV7107B1Z1");
				try {
				if (bill.getPartyGstin().trim().length() < 15) {
					buyerDtls.setGstin("URP");
				} else {
					buyerDtls.setGstin(bill.getPartyGstin().trim());
				}
				}catch (Exception e) {
					//buyerDtls.setGstin("URP");
					buyerDtls.setGstin(frData.getFrGstNo().trim());
				}

				if (isStaticData == 1) {
					buyerDtls.setGstin(BuyerGSTIN);
				}

				buyerDtls.setEm(null);
				buyerDtls.setLglNm(frData.getFrName());
				buyerDtls.setLoc(frData.getFrCity().trim());
				buyerDtls.setPh("9850198518");
				buyerDtls.setPin(frData.getFrTarget());

				if (isStaticData == 1) {
					buyerDtls.setPin(605001);
				}
				// to get from supplemnt state - split to get

				String[] stateNameCode = frSup.getFrState().split("-");
				buyerDtls.setPos("" + stateNameCode[1]);
				buyerDtls.setState("" + stateNameCode[1]);
				buyerDtls.setStcd("" + stateNameCode[1]);

				if (isStaticData == 1) {
					buyerDtls.setPos("34");
					buyerDtls.setState("34");
					buyerDtls.setStcd("34");
				}

				buyerDtls.setTrdNm(frData.getFrName());

				// buyerDtls.setEm("");

				billReq.setBuyerDtls(buyerDtls);
				ShippedDetails shipDtls = new ShippedDetails();
				shipDtls.setAddr1(buyerDtls.getAddr1());
				shipDtls.setAddr2(buyerDtls.getAddr2());
				shipDtls.setGstin(buyerDtls.getGstin());
				shipDtls.setLglNm(buyerDtls.getLglNm());
				shipDtls.setLoc(buyerDtls.getLoc());
				shipDtls.setPin(buyerDtls.getPin());
				shipDtls.setStcd(buyerDtls.getStcd());
				shipDtls.setTrdNm(buyerDtls.getTrdNm());

				DocSetails docDtls = new DocSetails();

				docDtls.setDt(bill.getBillDate());
				docDtls.setNo(bill.getInvoiceNo());
				docDtls.setTyp("CRN");

				billReq.setDocDtls(docDtls);

				List<ItmList> itemList = new ArrayList<ItmList>();
double taxableSum = 0, cessSum=0,cgstSum=0,igstSum=0,sgstSum=0;
DecimalFormat df = new DecimalFormat("#.00");
				for (int k = 0; k < bill.geteInvBillDetail().size(); k++) {

					EInvBillDetail billDetail = bill.geteInvBillDetail().get(k);
					double retPer = 100;
					if (billDetail.getIsGrn() == 1) {
						if (billDetail.getGrnType() == 0) {
							retPer = 85;
						} else if (billDetail.getGrnType() == 1) {
							retPer = 90;
						} else {
							retPer = 100;
						}
					}
					System.err.println("Ret Per "+retPer +"Disc per  " +billDetail.getDiscPer());
					double baseRate = billDetail.getBaseRate() * (retPer-billDetail.getDiscPer()) / 100;
					System.err.println("billDetail.getBaseRate()" +billDetail.getBaseRate() +"calc base rate " +baseRate);
					System.err.println("billDetail.getDiscPer()" +billDetail.getDiscPer());
					billDetail.setBaseRate(baseRate);
					
					billDetail.setDiscPer(0);
					
					ItmList item = new ItmList();

					item.setHsnCd(billDetail.getHsnCode());
					item.setPrdDesc(billDetail.getItemName());
					item.setSlNo("" + (k + 1));
					item.setIsServc("N");

					if (billDetail.getIgstRs() > 0) {
						item.setGstRt(billDetail.getIgstPer());
					} else {
						item.setGstRt(billDetail.getCgstPer() + billDetail.getSgstPer());
					}

					
					item.setTotAmt(billDetail.getGrandTotal());
					item.setTotAmt(Double.parseDouble(df.format(billDetail.getBaseRate() * billDetail.getBillQty())));

					// item.setTotItemVal(billDetail.getTaxableAmt());
					// item.setUnitPrice(billDetail.getRate());
					item.setUnitPrice(Double.parseDouble(df.format(billDetail.getBaseRate())));

					item.setUnit(billDetail.getItemUom());
					item.setQty(billDetail.getBillQty());

					item.setCesAmt(billDetail.getCessRs());
					item.setCesNonAdvlAmt(0);
					item.setCesRt(billDetail.getCessPer());

					// item.setDiscount(q*rate*discPer/100);
					// double
					// disc=billDetail.getBillQty()*billDetail.getRate()*billDetail.getDiscPer()/100;
					double disc = billDetail.getBillQty() * billDetail.getBaseRate() * billDetail.getDiscPer() / 100;

					 System.err.println("DISc "+disc + "rup " +roundUp(disc));

					item.setDiscount(Double.parseDouble(df.format(disc)));
					item.setAssAmt(Double.parseDouble(df.format(item.getTotAmt() - item.getDiscount())));
					System.err.println("item.getAssAmt" +item.getAssAmt());
					item.setTotItemVal(Double.parseDouble(
							df.format(item.getAssAmt() + item.getAssAmt() * billDetail.getIgstPer() / 100)));
					System.err.println("item.item.setTotItemVal" +item.getTotItemVal());
					item.setFreeQty(0);
					item.setOthChrg(0);
					item.setPreTaxVal(billDetail.getTaxableAmt());
					
					taxableSum=taxableSum+item.getAssAmt();
					cessSum=cessSum+billDetail.getCessRs();
				
							
					if (frData.getIsSameState()!=1) {
						item.setIgstAmt(
								Double.parseDouble(df.format(item.getAssAmt() * billDetail.getIgstPer() / 100)));
						igstSum=igstSum+item.getIgstAmt();
					} else {
						item.setCgstAmt(
								Double.parseDouble(df.format(item.getAssAmt() * billDetail.getCgstPer() / 100)));
						item.setSgstAmt(
								Double.parseDouble(df.format(item.getAssAmt() * billDetail.getSgstPer() / 100)));
						cgstSum=cgstSum+item.getCgstAmt();
						sgstSum=sgstSum+item.getSgstAmt();
					}
					 System.err.println("cgst " +item.getCgstAmt());
					 System.err.println("sgst " +item.getSgstAmt());
					itemList.add(item);
					System.err.println("Item "+item);
				}

				billReq.setItemList(itemList);

				SellerDetails sellerDtls = new SellerDetails();

				sellerDtls.setAddr1(company.getFactAddress());
				sellerDtls.setAddr2(null);
				sellerDtls.setEm(company.getEmail());
				sellerDtls.setGstin(company.getGstin());
				if (isStaticData == 1) {
					sellerDtls.setGstin(GSTIN);
				}

				sellerDtls.setLglNm(company.getCompName());
				sellerDtls.setLoc(company.getExVar1());
				sellerDtls.setPh(company.getPhoneNo1());

				sellerDtls.setPin(Integer.parseInt(company.getPhoneNo2()));
				sellerDtls.setState("" + company.getStateCode());
				sellerDtls.setStcd("" + company.getStateCode());

				if (isStaticData == 1) {
					sellerDtls.setPin(605001);
					sellerDtls.setState("" + 34);
					sellerDtls.setStcd("" + 34);
				}

				sellerDtls.setTrdNm(company.getCompName());

				billReq.setSellerDtls(sellerDtls);

				TranDetails tranDtls = new TranDetails();
				tranDtls.setEcmGstin(null);
				tranDtls.setRegRev("N");
				tranDtls.setSupTyp("B2B");
				tranDtls.setTaxSch("GST");

				billReq.setTranDtls(tranDtls);

				ValDetails valDtls = new ValDetails();
				valDtls.setAssVal(bill.getTaxableAmt());
				//valDtls.setCesVal(bill.getCessSum());
				//valDtls.setCgstVal(bill.getCgstSum());
				if (bill.getIgstSum() > 0) {
					//valDtls.setIgstVal(bill.getIgstSum());
				}
				
				
				valDtls.setRndOffAmt(bill.getRoundOff());
				//valDtls.setSgstVal(bill.getSgstSum());
				valDtls.setStCesVal(0);
				valDtls.setTotInvVal(taxableSum+cgstSum+igstSum+cgstSum+cessSum);
				
				double diff=(int) roundUp((taxableSum+cgstSum+igstSum+cgstSum+cessSum));
				
				double roff=(taxableSum+cgstSum+igstSum+cgstSum+cessSum)-diff;
				System.err.println("Diff" +diff+ "roff  " +roff);
				valDtls.setRndOffAmt(Double.parseDouble(df.format(roff)));
				valDtls.setTotInvVal(diff);
				valDtls.setTotInvValFc(0);
				
				//Now new 
				valDtls.setCesVal(Double.parseDouble(df.format(cessSum)));
				
				if (frData.getIsSameState()!=1) {
					valDtls.setIgstVal(Double.parseDouble(df.format(igstSum)));
				}else {
					valDtls.setSgstVal(Double.parseDouble(df.format(sgstSum)));	
					valDtls.setCgstVal(Double.parseDouble(df.format(cgstSum)));
				}
				valDtls.setAssVal((Double.parseDouble(df.format(taxableSum))));
				//End of now
				System.err.println("valDtls "+valDtls);
				
				billReq.setValDtls(valDtls);

				billReq.setVersion("1.1");

				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_JSON);

				String jsonStr = mapperObj.writeValueAsString(billReq);
				 System.err.println("jsonStr " + jsonStr);
				try {
					responseEntity = restTemplate.exchange(
							EInvoice_Constants_CN.GEN_IRN_URL + tokenRes.getData().getAuthToken() + "", HttpMethod.POST,
							new HttpEntity<>(jsonStr), typeRef);
					// System.err.println("ewaySuccRes aaaa " + responseEntity.getBody());
					JsonObject objData = null;
					JsonArray errorData = null;
					JsonElement errorElement = null;
					String stat = null;
					try {
						String res = responseEntity.getBody();
						System.err.println("RES " + res);
						JsonElement jsonElement = new JsonParser().parse(res);
						JsonObject jsonObject = jsonElement.getAsJsonObject();
						System.err.println("jsonObject  " + jsonObject);

						System.err.println("jsonObject.get(\"Status\"). " + jsonObject.get("Status"));
						stat = jsonObject.get("Status").toString();
						stat = stat.substring(1, stat.length() - 1);
						stat = stat.replaceAll("\"", "");

						if (stat.equalsIgnoreCase("1")) {
							String dataString = jsonObject.get("Data").getAsString();

							JsonElement dataElement = new JsonParser().parse(dataString);
							objData = dataElement.getAsJsonObject();
							System.err.println("dataElement   " + dataElement);
							System.err.println(" objData" + objData);
							System.err.println(" objData dt " + objData.get("AckDt").toString());
							System.err.println("jsonObject Data  " + jsonObject.get("Data"));

						} else if (stat.equalsIgnoreCase("0")) {
							errorData = jsonObject.get("ErrorDetails").getAsJsonArray();
							// errorElement= new JsonParser().parse(errorDetailStr);
							// errorData=errorElement.getAsJsonArray();
							System.err.println("errorData " + errorData);
						}
						// System.err.println("errorData at 0 " +errorData.get(0));
						// einvSuccess = mapperObj.readValue(cleanUpJsonBOM(res), RespPlGenIRN.class);

						System.err.println("stat" + stat);
						if (stat.equalsIgnoreCase("0")) {
							CustomErrEwayBill errRes = new CustomErrEwayBill();
							// errRes.setBillNo(bill.getBillNo());
							// errRes.setInvoiceNo(bill.getInvoiceNo());
							JsonObject errorObj1 = (JsonObject) errorData.get(0);
							System.err.println("errorObj1" + errorObj1);
							errRes.setTimeStamp("" + bill.getInvoiceNo());
							errRes.setInvoiceNo(bill.getInvoiceNo());
							errRes.setErrorCode(errorObj1.get("ErrorCode").toString());
							errRes.setMessage(errorObj1.get("ErrorMessage").toString());
							errorBillList.add(errRes);
						} else {
							map = new LinkedMultiValueMap<String, Object>();
							try {
								String irn = objData.get("Irn").toString();
								irn = irn.substring(1, irn.length() - 1);
								irn = irn.replaceAll("\"", "");
								String ackNo = objData.get("AckNo").toString();
								ackNo = ackNo.substring(1, ackNo.length() - 1);
								ackNo = ackNo.replaceAll("\"", "");

								map.add("irnAndAckNo", irn + "~" + ackNo);
							} catch (Exception e) {
								System.err.println("Its  Null ");
							}
							map.add("billNo", bill.getBillNo());

							System.err.println("map  " + map);
							ErrorMessage updateEInvDataInBill = restTemplate
									.postForObject(Constants.url + "/updateIRNForEInvInBill1", map, ErrorMessage.class);
						}
						// einvSuccessList.add(einvSuccess);
						// System.err.println("ewaySuccRes HERE " + einvSuccess.toString());

					} catch (HttpClientErrorException e) {
						System.err.println("ewayErrRes body   " + e.getResponseBodyAsString());
						ewayErrRes = mapperObj.readValue(e.getResponseBodyAsString(), ResponseCode.class);
						System.err.println("ewayErrRes   " + ewayErrRes.toString());

						CustomErrEwayBill errRes = new CustomErrEwayBill();

						// errRes.setBillNo(bill.getBillNo());
						// errRes.setInvoiceNo(bill.getInvoiceNo());
						errRes.setTimeStamp("--");
						errRes.setErrorCode(ewayErrRes.getError().getError_cd());
						errRes.setMessage(ewayErrRes.getError().getMessage());

						errorBillList.add(errRes);
					} catch (Exception e) {
						e.printStackTrace();
						System.err.println("Inner Try e inv fail");
					}

				} catch (HttpClientErrorException e) {

					ewayErrRes = mapperObj.readValue(e.getResponseBodyAsString(), ResponseCode.class);
					System.err.println("ewayErrRes   " + ewayErrRes.toString());
					CustomErrEwayBill errRes = new CustomErrEwayBill();

					// errRes.setBillNo(bill.getBillNo());
					// errRes.setInvoiceNo(bill.getInvoiceNo());
					errRes.setTimeStamp("--");
					errRes.setErrorCode(ewayErrRes.getError().getError_cd());
					errRes.setMessage(ewayErrRes.getError().getMessage());

					errorBillList.add(errRes);
				}

			} // End of Bill Header For Loop

		} catch (Exception e) {
			e.printStackTrace();
		}
		System.err.println("errorBillList " + errorBillList.toString());
		return errorBillList;

	}

	public static float roundUp(double d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}
	/*
	 * SELECT
	 * t_bill_header.bill_no,t_bill_header.invoice_no,t_bill_header.bill_date,
	 * t_bill_header.fr_id,t_bill_header.tax_applicable,t_bill_header.taxable_amt,
	 * t_bill_header.total_tax,
	 * t_bill_header.grand_total,t_bill_header.disc_amt,t_bill_header.round_off,
	 * t_bill_header.sgst_sum,t_bill_header.cgst_sum,t_bill_header.igst_sum,
	 * t_bill_header.party_name,
	 * t_bill_header.party_gstin,t_bill_header.party_address,t_bill_header.veh_no,
	 * t_bill_header.ex_varchar2 as cess_sum
	 * 
	 * FROM t_bill_header WHERE t_bill_header.del_status=0 and t_bill_header.bill_no
	 * IN (1,45,78,96,102)
	 * 
	 * 
	 * SELECT t_bill_detail.bill_detail_no,t_bill_detail.bill_no,
	 * t_bill_detail.order_id,t_bill_detail.item_id,t_bill_detail.bill_qty,
	 * t_bill_detail.order_qty,
	 * t_bill_detail.mrp,t_bill_detail.rate,t_bill_detail.base_rate,t_bill_detail.
	 * taxable_amt,t_bill_detail.sgst_rs,
	 * t_bill_detail.cgst_rs,t_bill_detail.igst_rs,t_bill_detail.cess_rs,
	 * t_bill_detail.total_tax,t_bill_detail.grand_total,t_bill_detail.expiry_date,
	 * t_bill_detail.disc_per, CASE WHEN t_bill_detail.cat_id=5 THEN (SELECT
	 * m_sp_cake.sp_name FROM m_sp_cake WHERE m_sp_cake.sp_id=
	 * t_bill_detail.item_id) ELSE (SELECT m_item.item_name FROM m_item WHERE
	 * t_bill_detail.item_id=m_item.id)END AS item_name from t_bill_detail WHERE
	 * bill_no=1
	 * 
	 */

	@RequestMapping(value = "/cancelEInvBill1", method = RequestMethod.POST)
	public @ResponseBody List<CustomErrEwayBill> cancelEInvBill(HttpServletRequest request,
			HttpServletResponse response) {
		List<CustomErrEwayBill> errorBillList = new ArrayList<CustomErrEwayBill>();
		RestTemplate restTemplate = new RestTemplate();
		List<RespPlCancelIRN> einvCancelList = new ArrayList<RespPlCancelIRN>();

		try {
			ObjectMapper mapperObj = new ObjectMapper();
			String billList = new String();
			ResponseEntity<List<EInvBillHeader>> bRes = null;
			String[] selectedBills = request.getParameterValues("select_to_print");
			String vehNo = request.getParameter("vehNo");
			for (int i = 0; i < selectedBills.length; i++) {
				billList = selectedBills[i] + "," + billList;
			}

			billList = billList.substring(0, billList.length() - 1);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("billIdList", billList);

			ParameterizedTypeReference<List<EInvBillHeader>> typeRef1 = new ParameterizedTypeReference<List<EInvBillHeader>>() {
			};
			try {
				bRes = restTemplate.exchange(Constants.url + "getBillListForEInvoice", HttpMethod.POST,
						new HttpEntity<>(map), typeRef1);
			} catch (HttpClientErrorException e) {
				System.err.println("/getBillListForEInvoice Http Excep \n " + e.getResponseBodyAsString());
			}
			List<EInvBillHeader> billHeaderList = bRes.getBody();

			RespAuthPl tokenRes = null; // = restTemplate.getForObject(EwayConstants.getToken, GetAuthToken.class);
			ResponseEntity<String> tokRes = null;

			ParameterizedTypeReference<String> typeRef2 = new ParameterizedTypeReference<String>() {
			};
			try {
				tokRes = restTemplate.exchange(EInvoice_Constants_CN.E_INV_AUTH_TOKEN_URL, HttpMethod.GET,
						new HttpEntity<>(null), typeRef2);
				try {
					System.err.println("Token Res SAA " + tokRes.toString());
					tokenRes = mapperObj.readValue(tokRes.getBody(), RespAuthPl.class);

				} catch (HttpClientErrorException e) {
					System.err.println("Inner HTTP TOKEN EX getToken" + e.getResponseBodyAsString());
				} catch (Exception e) {
					e.printStackTrace();
					System.err.println("Inner try for getToken" + e.getMessage());
				}
			} catch (HttpClientErrorException e) {
				System.err.println("/getToken Http Excep \n " + e.getResponseBodyAsString());
			}

			EInvoice_Constants_CN.AUTH_TOKEN = tokenRes.getData().getAuthToken();
			ReqPlCancelIRN einCancel = null;
			ResponseCode ewayErrRes = null;
			ParameterizedTypeReference<String> typeRef = new ParameterizedTypeReference<String>() {
			};
			ResponseEntity<String> responseEntity = null;

			Company company = restTemplate.getForObject(Constants.url + "/getCompany", Company.class);
			// System.err.println("company " + company.toString());
			int isStaticData = 1;
			String GSTIN = "34AACCC1596Q002";
			String BuyerGSTIN = "34AAGCM8851L1ZZ";
			// String GSTIN="27ABOFM3012D1ZK";
			RespPlCancelIRN cancelRes;
			for (int i = 0; i < billHeaderList.size(); i++) {
				einCancel = new ReqPlCancelIRN();
				einCancel.setCnlRem("Wrong Entry");
				einCancel.setCnlRsn("1");
				einCancel.setIrn(billHeaderList.get(i).getIrnAckData().split("~")[0]);
				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_JSON);

				String jsonStr = mapperObj.writeValueAsString(einCancel);
				System.err.println("jsonStr " + jsonStr);
				try {
					responseEntity = restTemplate.exchange(
							EInvoice_Constants_CN.CANCEL_IRN_URL + tokenRes.getData().getAuthToken() + "", HttpMethod.POST,
							new HttpEntity<>(jsonStr), typeRef);
					System.err.println("ewayCancel token " + responseEntity.getBody());
					JsonObject objData = null;
					JsonArray errorData = null;
					JsonElement errorElement = null;
					String stat = null;

					try {
						String res = responseEntity.getBody();

						JsonElement jsonElement = new JsonParser().parse(res);
						JsonObject jsonObject = jsonElement.getAsJsonObject();
						System.err.println("jsonObject  " + jsonObject);

						System.err.println("jsonObject.get(\"Status\"). " + jsonObject.get("Status"));
						stat = jsonObject.get("Status").toString();
						stat = stat.substring(1, stat.length() - 1);
						stat = stat.replaceAll("\"", "");
						if (stat.equalsIgnoreCase("1")) {
							String dataString = jsonObject.get("Data").getAsString();

							JsonElement dataElement = new JsonParser().parse(dataString);
							objData = dataElement.getAsJsonObject();
							System.err.println("dataElement   " + dataElement);
							System.err.println(" objData" + objData);
							// System.err.println(" objData dt " + objData.get("AckDt").toString());
							// System.err.println("jsonObject Data " +jsonObject.get("Data"));

							map = new LinkedMultiValueMap<String, Object>();
							try {
								map.add("irnAckData", "NA");
							} catch (Exception e) {
								System.err.println("Its  Null ");
							}
							map.add("billNo", billHeaderList.get(i).getBillNo());

							ErrorMessage updateEinvForCancel = restTemplate
									.postForObject(Constants.url + "/updateEInvDataInBill", map, ErrorMessage.class);

						} else if (stat.equalsIgnoreCase("0")) {
							errorData = jsonObject.get("ErrorDetails").getAsJsonArray();
							// errorElement= new JsonParser().parse(errorDetailStr);
							// errorData=errorElement.getAsJsonArray();
							System.err.println("errorData " + errorData);
						}
						if (stat.equalsIgnoreCase("0")) {
							CustomErrEwayBill errRes = new CustomErrEwayBill();
							// errRes.setBillNo(bill.getBillNo());
							// errRes.setInvoiceNo(bill.getInvoiceNo());
							JsonObject errorObj1 = (JsonObject) errorData.get(0);
							System.err.println("errorObj1" + errorObj1);
							errRes.setTimeStamp("" + billHeaderList.get(i).getInvoiceNo());
							errRes.setInvoiceNo(billHeaderList.get(i).getInvoiceNo());
							errRes.setErrorCode(errorObj1.get("ErrorCode").toString());
							errRes.setMessage(errorObj1.get("ErrorMessage").toString());
							errorBillList.add(errRes);
						}

					} catch (HttpClientErrorException e) {
						System.err.println("ewayErrRes body   " + e.getResponseBodyAsString());
						ewayErrRes = mapperObj.readValue(e.getResponseBodyAsString(), ResponseCode.class);
						System.err.println("ewayErrRes   " + ewayErrRes.toString());
						CustomErrEwayBill errRes = new CustomErrEwayBill();

						// errRes.setBillNo(bill.getBillNo());
						// errRes.setInvoiceNo(bill.getInvoiceNo());
						errRes.setTimeStamp("--");
						errRes.setErrorCode(ewayErrRes.getError().getError_cd());
						errRes.setMessage(ewayErrRes.getError().getMessage());

						errorBillList.add(errRes);
					} catch (Exception e) {
						e.printStackTrace();
						System.err.println("Inner Try e inv fail");
					}

				} catch (HttpClientErrorException e) {

					ewayErrRes = mapperObj.readValue(e.getResponseBodyAsString(), ResponseCode.class);
					System.err.println("ewayErrRes   " + ewayErrRes.toString());
					CustomErrEwayBill errRes = new CustomErrEwayBill();

					// errRes.setBillNo(bill.getBillNo());
					// errRes.setInvoiceNo(bill.getInvoiceNo());
					errRes.setTimeStamp("--");
					errRes.setErrorCode(ewayErrRes.getError().getError_cd());
					errRes.setMessage(ewayErrRes.getError().getMessage());

					errorBillList.add(errRes);
				}
			} // End of Bill Header For Loop

		} catch (Exception e) {
			e.printStackTrace();
		}

		return errorBillList;

	}

}
