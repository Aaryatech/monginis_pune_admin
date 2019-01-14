package com.ats.adminpanel.controller;

import java.awt.Dimension;
import java.awt.Insets;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;
import org.zefer.pd4ml.PD4PageMark;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.commons.DateConvertor;
import com.ats.adminpanel.model.AllFrIdNameList;
import com.ats.adminpanel.model.AllRoutesListResponse;
import com.ats.adminpanel.model.ItemListForDispatchReport;
import com.ats.adminpanel.model.ItemListStatioinWise;
import com.ats.adminpanel.model.PDispatchReport;
import com.ats.adminpanel.model.PDispatchReportList;
import com.ats.adminpanel.model.Route;
import com.ats.adminpanel.model.RouteMaster;
import com.ats.adminpanel.model.StaionListWithFranchiseeList;
import com.ats.adminpanel.model.TypeWiseItemTotal;
import com.ats.adminpanel.model.franchisee.FrNameIdByRouteId;
import com.ats.adminpanel.model.franchisee.FrNameIdByRouteIdResponse;
import com.ats.adminpanel.model.franchisee.Menu;
import com.ats.adminpanel.model.franchisee.SubCategory;
import com.ats.adminpanel.model.item.CategoryListResponse;
import com.ats.adminpanel.model.item.Item;
import com.ats.adminpanel.model.item.MCategoryList; 

@Controller
@Scope("session")
public class DispachReport {
	
	
	String todaysDate;
	AllFrIdNameList allFrIdNameList = new AllFrIdNameList();
	List<Integer> stationList = new ArrayList<>();
	List<RouteMaster> list = new ArrayList<>();
	List<Item> itemList = new ArrayList<Item>();
	List<StaionListWithFranchiseeList> staionListWithFranchiseeList = new ArrayList<StaionListWithFranchiseeList>();
	List<Menu> menuList = new ArrayList<Menu>(); 
	
	@RequestMapping(value = "/showPDispatchItemReportNew", method = RequestMethod.GET)
	public ModelAndView showPDispatchItemReportNew(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("reports/puneDispatchReport");
 

		try {
			ZoneId z = ZoneId.of("Asia/Calcutta");

			LocalDate date = LocalDate.now(z);
			DateTimeFormatter formatters = DateTimeFormatter.ofPattern("d-MM-uuuu");
			todaysDate = date.format(formatters);

			RestTemplate restTemplate = new RestTemplate();

			Integer[] array = restTemplate.getForObject(Constants.url + "/itemListGroupByStationNo",
					Integer[].class);
			 stationList = new ArrayList<Integer>(Arrays.asList(array)); 
			model.addObject("stationList", stationList);  
			
			Menu[] allMenus = restTemplate.getForObject(Constants.url + "/getAllMenuList",
					Menu[].class);
			  menuList = new ArrayList<Menu>(Arrays.asList(allMenus)); 
			 
			 model.addObject("menuList", menuList); 
			model.addObject("stationList", stationList);  
			model.addObject("todaysDate", todaysDate); 

		} catch (Exception e) {

			System.out.println("Exc in show sales report bill wise  " + e.getMessage());
			e.printStackTrace();
		}

		return model;

	}
	
	@RequestMapping(value = "/routListByAbcType", method = RequestMethod.GET)
	@ResponseBody
	public List<RouteMaster> routListByAbcType(HttpServletRequest request, HttpServletResponse response) {

		 list = new ArrayList<>();
 

		try {
			 
			int abcType = Integer.parseInt(request.getParameter("abcType"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("abcType", abcType);
			RestTemplate restTemplate = new RestTemplate();

			RouteMaster[] routeMaster = restTemplate.postForObject(Constants.url + "/showRouteListNewByabcType",map,
					RouteMaster[].class);
			 list = new ArrayList<RouteMaster>(Arrays.asList(routeMaster));
			 

		} catch (Exception e) {

		 
			e.printStackTrace();
		}

		return list;

	}
	
	@RequestMapping(value = "/searchPDispatchItemReportNew", method = RequestMethod.GET)
	public ModelAndView searchPDispatchItemReportNew(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("reports/searchPDispatchItemReportNew");
 

		try {
			
			String date = request.getParameter("billDate");
			int stationId = Integer.parseInt(request.getParameter("stanId"));
			int abcType = Integer.parseInt(request.getParameter("abcType"));
			int routId = Integer.parseInt(request.getParameter("selectRoute"));
			String[] menuId =  request.getParameterValues("menuId") ;
			
			
			
			String stationIds = new String();
			String abcTypes = new String();
			String menuIds = new String();
			
			for(int i=0; i < menuId.length ; i++) {
				menuIds=menuIds+","+menuId[i];
			}
			menuIds=menuIds.substring(1, menuIds.length());
			
			if(stationId==-1) {
				
				for(int i=0; i < stationList.size() ; i++) {
					
					stationIds = stationIds+","+stationList.get(i);
				}
				stationIds=stationIds.substring(1, stationIds.length());
				
			}else {
				stationIds=String.valueOf(stationId);
			}
			
			if(abcType==0) {
				 
				abcTypes="1,2,3";
				
			}else {
				abcTypes=String.valueOf(abcType);
			}
			
			if(menuIds.contains("0")) {
				 
				menuIds = new String();
				
				for(int i=0; i < menuList.size() ; i++) {
					menuIds=menuIds+","+menuList.get(i).getMenuId();
				}
				menuIds=menuIds.substring(1, menuIds.length());
			} 
			
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("date", DateConvertor.convertToYMD(date));
			map.add("abcType", abcTypes);
			map.add("stationNos", stationIds);
			map.add("routId", routId);
			map.add("menuIds", menuIds);
			
			System.out.println("map " + map); 

			RestTemplate restTemplate = new RestTemplate();

			StaionListWithFranchiseeList[] array = restTemplate.postForObject(Constants.url + "/getAbcDepatchReport",map,
					StaionListWithFranchiseeList[].class);
			
			 staionListWithFranchiseeList = new ArrayList<StaionListWithFranchiseeList>(Arrays.asList(array));
			 
			System.err.println(staionListWithFranchiseeList);
			
			List<ItemListStatioinWise> itemListStatioinWiseList = new ArrayList<>();
			
			Item[] item = restTemplate.getForObject(Constants.url + "/getItemListForDispatchReport", 
					Item[].class);

			 itemList = new ArrayList<Item>(Arrays.asList(item));
			 
			for(int i=0; i < staionListWithFranchiseeList.size() ; i++) {
				
				ItemListStatioinWise itemListStatioinWise = new ItemListStatioinWise();
				itemListStatioinWise.setStationNo(staionListWithFranchiseeList.get(i).getStationNo());
				List<TypeWiseItemTotal> typeWiseItemTotalList= new ArrayList<>();
				
				for(int j=0 ; j<itemList.size() ; j++) {
					
					if(itemList.get(j).getItemMrp2()==staionListWithFranchiseeList.get(i).getStationNo()) {
						
						TypeWiseItemTotal itemListForDispatchReport = new TypeWiseItemTotal();
						itemListForDispatchReport.setItemId(itemList.get(j).getId());
						itemListForDispatchReport.setItemName(itemList.get(j).getItemName());
						typeWiseItemTotalList.add(itemListForDispatchReport);
					}
					
				}
				itemListStatioinWise.setTypeWiseItemTotalList(typeWiseItemTotalList);
				itemListStatioinWiseList.add(itemListStatioinWise);
			}
			
			System.err.println();
			for(int i=0; i < staionListWithFranchiseeList.size() ; i++) {
				 
				for(int j=0 ; j<itemListStatioinWiseList.size() ; j++) {
					
					if(itemListStatioinWiseList.get(j).getStationNo()==staionListWithFranchiseeList.get(i).getStationNo()) {
						
						for(int k=0 ;k<staionListWithFranchiseeList.get(i).getList().size() ; k++)
						{
							 
								if(staionListWithFranchiseeList.get(i).getList().get(k).getAbcType()==1) {
									
									for(int m=0 ;m<staionListWithFranchiseeList.get(i).getList().get(k).getItemList().size() ; m++)
									{
										for(int l=0 ;l<itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().size() ; l++)
										{
											if(staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getItemId()
													==itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getItemId()) {
												itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).setaTotal(
														itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getaTotal()+
														staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getOrderQty()); 
												break;
											}
										} 
									}
									
								}else if(staionListWithFranchiseeList.get(i).getList().get(k).getAbcType()==2) {
									
									for(int m=0 ;m<staionListWithFranchiseeList.get(i).getList().get(k).getItemList().size() ; m++)
									{
										for(int l=0 ;l<itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().size() ; l++)
										{
											if(staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getItemId()
													==itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getItemId()) {
												itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).setbTotal(
														itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getbTotal()+
														staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getOrderQty()); 
												break;
											}
										}
										
									}
									
								}else if(staionListWithFranchiseeList.get(i).getList().get(k).getAbcType()==3) {
									
									for(int m=0 ;m<staionListWithFranchiseeList.get(i).getList().get(k).getItemList().size() ; m++)
									{
										for(int l=0 ;l<itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().size() ; l++)
										{
											if(staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getItemId()
													==itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getItemId()) {
												itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).setcTotal(
														itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getcTotal()+
														staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getOrderQty());
												break;
											}
										}
									}
									
								}
						 
						}
						 
					}
					
				}
				 
				
			}
			
			System.err.println("itemListStatioinWiseList" + itemListStatioinWiseList);
			 
			allFrIdNameList = restTemplate.getForObject(Constants.url + "/getAllFrIdName", AllFrIdNameList.class);
			model.addObject("staionListWithFranchiseeList", staionListWithFranchiseeList);
			model.addObject("itemList", itemList);
			model.addObject("allFrIdNameList", allFrIdNameList.getFrIdNamesList());
			model.addObject("itemListStatioinWiseList", itemListStatioinWiseList);
			model.addObject("date", date);
			model.addObject("stationId", stationId);
			model.addObject("abcType", abcType);
			model.addObject("routId", routId);
			model.addObject("menuIds", menuIds);
			
		} catch (Exception e) {
 
			e.printStackTrace();
		}

		return model;

	}
	
	 @RequestMapping(value = "/pdf/getPDispatchReportNewPdf/{date}/{stationId}/{abcType}/{routId}/{menuIds}", method = RequestMethod.GET)
	public ModelAndView getPDispatchReportNewPdf(@PathVariable String date,@PathVariable int stationId,@PathVariable int abcType,
			@PathVariable int routId,@PathVariable String menuIds,HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView model = new ModelAndView("reports/sales/dispatchPReportNewPdf");
		 
		try {
			 
			RestTemplate restTemplate = new RestTemplate();
			String stationIds = new String();
			String abcTypes = new String();
			
			if(stationId==-1) {
				
				Integer[] array = restTemplate.getForObject(Constants.url + "/itemListGroupByStationNo",
						Integer[].class);
				List<Integer> stationList = new ArrayList<Integer>(Arrays.asList(array)); 
				model.addObject("stationList", stationList);
				
				for(int i=0; i < stationList.size() ; i++) {
					
					stationIds = stationIds+","+stationList.get(i);
				}
				stationIds=stationIds.substring(1, stationIds.length());
				
			}else {
				stationIds=String.valueOf(stationId);
			}
			
			if(abcType==0) {
				 
				abcTypes="1,2,3";
				
			}else {
				abcTypes=String.valueOf(abcType);
			}
			
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("date", DateConvertor.convertToYMD(date));
			map.add("abcType", abcTypes);
			map.add("stationNos", stationIds);
			map.add("routId", routId);
			map.add("menuIds", menuIds);
			System.out.println("map " + map); 
 
			StaionListWithFranchiseeList[] array = restTemplate.postForObject(Constants.url + "/getAbcDepatchReport",map,
					StaionListWithFranchiseeList[].class);
			
			List<StaionListWithFranchiseeList> staionListWithFranchiseeList = new ArrayList<StaionListWithFranchiseeList>(Arrays.asList(array));
			 
			System.err.println(staionListWithFranchiseeList);
			
			Item[] item = restTemplate.getForObject(Constants.url + "/getItemListForDispatchReport", 
					Item[].class);

			List<Item> itemList = new ArrayList<Item>(Arrays.asList(item));
			
			 AllFrIdNameList allFrIdNameList = restTemplate.getForObject(Constants.url + "/getAllFrIdName", AllFrIdNameList.class);
			 
			 List<ItemListStatioinWise> itemListStatioinWiseList = new ArrayList<>();
			 
			 for(int i=0; i < staionListWithFranchiseeList.size() ; i++) {
					
					ItemListStatioinWise itemListStatioinWise = new ItemListStatioinWise();
					itemListStatioinWise.setStationNo(staionListWithFranchiseeList.get(i).getStationNo());
					List<TypeWiseItemTotal> typeWiseItemTotalList= new ArrayList<>();
					
					for(int j=0 ; j<itemList.size() ; j++) {
						
						if(itemList.get(j).getItemMrp2()==staionListWithFranchiseeList.get(i).getStationNo()) {
							
							TypeWiseItemTotal itemListForDispatchReport = new TypeWiseItemTotal();
							itemListForDispatchReport.setItemId(itemList.get(j).getId());
							itemListForDispatchReport.setItemName(itemList.get(j).getItemName());
							typeWiseItemTotalList.add(itemListForDispatchReport);
						}
						
					}
					itemListStatioinWise.setTypeWiseItemTotalList(typeWiseItemTotalList);
					itemListStatioinWiseList.add(itemListStatioinWise);
				}
			 
			 for(int i=0; i < staionListWithFranchiseeList.size() ; i++) {
				 
					for(int j=0 ; j<itemListStatioinWiseList.size() ; j++) {
						
						if(itemListStatioinWiseList.get(j).getStationNo()==staionListWithFranchiseeList.get(i).getStationNo()) {
							
							for(int k=0 ;k<staionListWithFranchiseeList.get(i).getList().size() ; k++)
							{
								 
									if(staionListWithFranchiseeList.get(i).getList().get(k).getAbcType()==1) {
										
										for(int m=0 ;m<staionListWithFranchiseeList.get(i).getList().get(k).getItemList().size() ; m++)
										{
											for(int l=0 ;l<itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().size() ; l++)
											{
												if(staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getItemId()
														==itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getItemId()) {
													itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).setaTotal(
															itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getaTotal()+
															staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getOrderQty()); 
													break;
												}
											} 
										}
										
									}else if(staionListWithFranchiseeList.get(i).getList().get(k).getAbcType()==2) {
										
										for(int m=0 ;m<staionListWithFranchiseeList.get(i).getList().get(k).getItemList().size() ; m++)
										{
											for(int l=0 ;l<itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().size() ; l++)
											{
												if(staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getItemId()
														==itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getItemId()) {
													itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).setbTotal(
															itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getbTotal()+
															staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getOrderQty()); 
													break;
												}
											}
											
										}
										
									}else if(staionListWithFranchiseeList.get(i).getList().get(k).getAbcType()==3) {
										
										for(int m=0 ;m<staionListWithFranchiseeList.get(i).getList().get(k).getItemList().size() ; m++)
										{
											for(int l=0 ;l<itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().size() ; l++)
											{
												if(staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getItemId()
														==itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getItemId()) {
													itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).setcTotal(
															itemListStatioinWiseList.get(j).getTypeWiseItemTotalList().get(l).getcTotal()+
															staionListWithFranchiseeList.get(i).getList().get(k).getItemList().get(m).getOrderQty());
													break;
												}
											}
										}
										
									}
							 
							}
							 
						}
						
					}
					 
					
				}
			 
			model.addObject("itemListStatioinWiseList", itemListStatioinWiseList);
			model.addObject("staionListWithFranchiseeList", staionListWithFranchiseeList);
			model.addObject("itemList", itemList);
			model.addObject("allFrIdNameList", allFrIdNameList.getFrIdNamesList());
			model.addObject("date", date);
			model.addObject("abcType", abcType);
		} catch (Exception e) {
			System.out.println("get Dispatch Report Exception: " + e.getMessage());
			e.printStackTrace();

		}
		return model;

	}
	
	private Dimension format = PD4Constants.A4;
	private boolean landscapeValue = false;
	private int topValue = 8;
	private int leftValue = 0;
	private int rightValue = 0;
	private int bottomValue = 8;
	private String unitsValue = "m";
	private String proxyHost = "";
	private int proxyPort = 0;

	private int userSpaceWidth = 750;
	private static int BUFFER_SIZE = 1024;

	@RequestMapping(value = "/pdfForDisReportNew", method = RequestMethod.GET)
	public void showPDF1(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Inside PDf For Report URL ");
		String url = request.getParameter("url");
		System.out.println("URL " + url);
		
		//File f = new File("/home/supertom/apache-tomcat-8.5.35/webapps/admin/report.pdf");
		//File f = new File("/opt/apache-tomcat-8.5.6/webapps/uploads/report.pdf");
		File f =new File("/home/lenovo/Documents/pdf/Report.pdf");

		try {
			runConverter1(Constants.ReportURL + url, f, request, response);
			// runConverter("www.google.com", f,request,response);

		} catch (IOException e) {

			System.out.println("Pdf conversion exception " + e.getMessage());
		}

		// get absolute path of the application
		ServletContext context = request.getSession().getServletContext();
		String appPath = context.getRealPath("");
		//String filePath = "/home/supertom/apache-tomcat-8.5.35/webapps/admin/report.pdf";

		String filePath ="/home/lenovo/Documents/pdf/Report.pdf";

		// construct the complete absolute path of the file
		String fullPath = appPath + filePath;
		File downloadFile = new File(filePath);
		FileInputStream inputStream = null;
		try {
			inputStream = new FileInputStream(downloadFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		try {
			// get MIME type of the file
			String mimeType = context.getMimeType(fullPath);
			if (mimeType == null) {
				// set to binary type if MIME mapping not found
				mimeType = "application/pdf";
			}
			System.out.println("MIME type: " + mimeType);

			String headerKey = "Content-Disposition";

			// response.addHeader("Content-Disposition", "attachment;filename=report.pdf");
			response.setContentType("application/pdf");

			OutputStream outStream;

			outStream = response.getOutputStream();

			byte[] buffer = new byte[BUFFER_SIZE];
			int bytesRead = -1;

			while ((bytesRead = inputStream.read(buffer)) != -1) {
				outStream.write(buffer, 0, bytesRead);
			}

			inputStream.close();
			outStream.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void runConverter1(String urlstring, File output, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		if (urlstring.length() > 0) {
			if (!urlstring.startsWith("http://") && !urlstring.startsWith("file:")) {
				urlstring = "http://" + urlstring;
			}
			System.out.println("PDF URL " + urlstring);
			java.io.FileOutputStream fos = new java.io.FileOutputStream(output);

			PD4ML pd4ml = new PD4ML();
			pd4ml.enableSmartTableBreaks(true);
			try {

				  try {                                                              
                      pd4ml.setPageSize( landscapeValue ? pd4ml.changePageOrientation( format ): format );
                   } catch (Exception e) {
                      e.printStackTrace();
                   }

				Dimension landscapeA4 = pd4ml.changePageOrientation(PD4Constants.A4);
				pd4ml.setPageSize(landscapeA4);
                     
				PD4PageMark footer = new PD4PageMark();

				footer.setPageNumberTemplate("Page $[page] of $[total]");
				footer.setPageNumberAlignment(PD4PageMark.RIGHT_ALIGN);
				footer.setFontSize(10);
				footer.setAreaHeight(20);

				pd4ml.setPageFooter(footer);

			} catch (Exception e) {
				System.out.println("Pdf conversion method excep " + e.getMessage());
			}

			if (unitsValue.equals("mm")) {
				pd4ml.setPageInsetsMM(new Insets(topValue, leftValue, bottomValue, rightValue));
			} else {
				pd4ml.setPageInsets(new Insets(topValue, leftValue, bottomValue, rightValue));
			}

			pd4ml.setHtmlWidth(userSpaceWidth);

			pd4ml.render(urlstring, fos);
		}
	} 

	 
     
}
