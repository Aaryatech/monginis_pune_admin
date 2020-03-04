package com.ats.adminpanel.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Array;
import java.net.URLConnection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.junit.experimental.theories.PotentialAssignment.CouldNotGenerateValueException;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.AccessControll;
import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.GetMenuShow;
import com.ats.adminpanel.model.GetProdVariation;
import com.ats.adminpanel.model.Info;
import com.ats.adminpanel.model.accessright.ModuleJson;
import com.ats.adminpanel.model.franchisee.AllMenuResponse;
import com.ats.adminpanel.model.franchisee.Menu;
import com.ats.adminpanel.model.franchisee.SubCategory;
import com.ats.adminpanel.model.item.AllItemsListResponse;
import com.ats.adminpanel.model.item.Item;
import com.ats.adminpanel.model.production.GetProdDetailBySubCat;
import com.ats.adminpanel.model.production.GetProdDetailBySubCatList;
import com.ats.adminpanel.model.production.GetProdPlanDetail;
import com.ats.adminpanel.model.production.PostProdPlanHeader;
import com.ats.adminpanel.model.production.PostProductionPlanDetail;
import com.ats.adminpanel.model.productionplan.MixingDetailed;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Controller
public class NewProdController {

	@RequestMapping(value = "/showProdVariation", method = RequestMethod.GET)
	public ModelAndView showProdVariation(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		HttpSession session = request.getSession();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("showProdVariation", "showProdVariation", "0", "1", "0", "0",
				newModuleList);

		if (view.getError() == true) {

			model = new ModelAndView("accessDenied");

		} else {
			model = new ModelAndView("prod_new/show_variation");
			Constants.mainAct = 4;
			Constants.subAct = 36;

			RestTemplate restTemplate = new RestTemplate();

			AllMenuResponse allMenuResponse = restTemplate.getForObject(Constants.url + "getAllMenu",
					AllMenuResponse.class);

			List<Menu> menuList = allMenuResponse.getMenuConfigurationPage();

			model.addObject("menuList", menuList);

		}
		return model;
	}

	// getProdForVariationProcess

	@RequestMapping(value = "/getProdForVariationProcess", method = RequestMethod.GET)
	public @ResponseBody DataListObejct getProdForVariationProcess(HttpServletRequest request,
			HttpServletResponse response) {

		System.err.println("In getProdForVariationProcess");
		HttpSession session = request.getSession();
		DataListObejct dataObject = new DataListObejct();

		RestTemplate restTemplate = new RestTemplate();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		String menuId = request.getParameter("menuId");
		String date = request.getParameter("from_datepicker");
		String	menuName= request.getParameter("menuName");
		
		String selectedMenu = request.getParameter("menu_id_list");

		selectedMenu = selectedMenu.substring(1, selectedMenu.length() - 1);
		selectedMenu = selectedMenu.replaceAll("\"", "");
		List<String> menuList = new ArrayList<>();
		menuList = Arrays.asList(selectedMenu);
		// getCountOfProdPlanForCatId
		map.add("catId", 2);
		map.add("status", 4);
		map.add("date", date);
		map.add("isPlanned", 0);

		session.setAttribute("date", date);
		session.setAttribute("menuName", menuName);
		
		session.setAttribute("selectedMenu", selectedMenu);
		
		session.setAttribute("menuId", menuId);

		Integer prodCount = restTemplate.postForObject(Constants.url + "getCountOfProdPlanForCatId", map,
				Integer.class);
		System.err.println("prodCount " + prodCount);
		map = new LinkedMultiValueMap<String, Object>();
		if (prodCount.equals(0)) {
			map.add("menuId", menuId);
			map.add("date", date);
			
			map.add("selectedMenu", selectedMenu);
			GetProdVariation[] getProdVarArr = restTemplate.postForObject(Constants.url + "getProdVariation", map,
					GetProdVariation[].class);

			List<GetProdVariation> prodList = new ArrayList<GetProdVariation>();

			prodList = new ArrayList<GetProdVariation>(Arrays.asList(getProdVarArr));
			dataObject.setProdVarList(prodList);
			session.setAttribute("prodListCurrStock", getProdVarArr);

			dataObject.setStatus(1);
		} else {
			dataObject.setStatus(0);
		}

		return dataObject;

	}

	@RequestMapping(value = "/insertProdForVaria", method = RequestMethod.POST)
	public String insertProdForVaria(HttpServletRequest request, HttpServletResponse response) {
		System.err.println("insertProdForVaria");
		RestTemplate restTemplate = new RestTemplate();
		HttpSession session = request.getSession();

		List<PostProductionPlanDetail> planDetailList = new ArrayList<PostProductionPlanDetail>();
		PostProductionPlanDetail planDetailObj = new PostProductionPlanDetail();
		PostProdPlanHeader planHeader = new PostProdPlanHeader();
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		String pDate = formatter.format(date);
		System.out.println(pDate);

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		String menuId = (String) session.getAttribute("menuId");// request.getParameter("menuId");
		String date2 = (String) session.getAttribute("date");// request.getParameter("from_datepicker");
		String selectedMenu = (String) session.getAttribute("selectedMenu");
		// session.setAttribute("menuId", menuId);

		map.add("menuId", menuId);
		map.add("date", date2);
		map.add("selectedMenu", selectedMenu);
		
		GetProdVariation[] getProdVarArr = restTemplate.postForObject(Constants.url + "getProdVariation", map,
				GetProdVariation[].class);

		List<GetProdVariation> prodList = new ArrayList<GetProdVariation>();

		prodList = new ArrayList<GetProdVariation>(Arrays.asList(getProdVarArr));

		try {
			planHeader.setProductionStatus(3);
			planHeader.setItemGrp1(2);
			planHeader.setProductionDate(pDate);
			planHeader.setTimeSlot(1);
			planHeader.setProductionBatch("");

			for (int i = 0; i < prodList.size(); i++) {

				float curStockQty = (prodList.get(i).getOpTotal() + prodList.get(i).getProductionQty()
						- prodList.get(i).getRejectedQty()) - prodList.get(i).getOtherMenuOrderQty();

				float variationQty = curStockQty - prodList.get(i).getSelMenuOrderQty();

				if (variationQty < 0) {
					variationQty = variationQty * -1;
				} else {
					variationQty = 0;
				}

				planDetailObj = new PostProductionPlanDetail();

				planDetailObj.setItemId(prodList.get(i).getId());
				planDetailObj.setOpeningQty((int)curStockQty);
				planDetailObj.setOrderQty((int) variationQty);
				planDetailObj.setProductionQty(0);
				planDetailObj.setRejectedQty(0);
				planDetailObj.setPlanQty(0);
				planDetailObj.setInt4(0);

				planDetailObj.setProductionDate(pDate);
				planDetailObj.setProductionBatch("");

				planDetailObj.setCurClosingQty(0);
				planDetailObj.setCurOpeQty(0);
				planDetailList.add(planDetailObj);

			}

			System.out.println("in if insert new plan");
			planHeader.setPostProductionPlanDetail(planDetailList);
			Info insertNewinPlan = restTemplate.postForObject(Constants.url + "postProductionPlan", planHeader,
					Info.class);
			System.out.println("insertNewinPlan Response " + insertNewinPlan);

		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			session.removeAttribute("menuId");
			session.removeAttribute("date");
		} catch (Exception e) {

		}

		return "redirect:/showProdVariation";
	}
	
	@RequestMapping(value = "/currentStockPdf", method = RequestMethod.GET)
	public void  currentStockPdf(HttpServletRequest request, HttpServletResponse response) throws FileNotFoundException {
		  BufferedOutputStream outStream = null;
		System.out.println("Inside currentStockPdf ");
		HttpSession session = request.getSession();
		Document doc=new Document();
		List<GetProdVariation> prodList = new ArrayList<GetProdVariation>();
		GetProdVariation[] getProdVarArr=(GetProdVariation[]) session.getAttribute("prodListCurrStock");
		prodList = new ArrayList<GetProdVariation>(Arrays.asList(getProdVarArr));

		Document document = new Document(PageSize.A4);
		//  ByteArrayOutputStream out = new ByteArrayOutputStream();
		 
		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss a");
		Calendar cal = Calendar.getInstance();

		System.out.println("time in currentStockPdf ==" + dateFormat.format(cal.getTime()));
		String timeStamp=dateFormat.format(cal.getTime());
		String FILE_PATH=Constants.REPORT_SAVE;
		File file=new File(FILE_PATH);
		
		PdfWriter writer = null;
		
		
		 FileOutputStream out=new FileOutputStream(FILE_PATH);
		   try {
			    writer=PdfWriter.getInstance(document,out);
		} catch (DocumentException e) {
			
			e.printStackTrace();
		}
		
		 PdfPTable table = new PdfPTable(4);
		 try {
		 System.out.println("Inside prodList");
		 table.setWidthPercentage(100);
	     table.setWidths(new float[]{0.9f, 1.8f,1.4f,1.4f});
	     
	     	Font headFont = new Font(FontFamily.TIMES_ROMAN, 10, Font.NORMAL, BaseColor.BLACK);
			Font headFont1 = new Font(FontFamily.HELVETICA, 11, Font.BOLD, BaseColor.BLACK);
			Font f = new Font(FontFamily.TIMES_ROMAN, 11.0f, Font.UNDERLINE, BaseColor.BLUE);
			Font f1 = new Font(FontFamily.TIMES_ROMAN, 11.0f, Font.UNDERLINE, BaseColor.DARK_GRAY);

	     
	     PdfPCell hcell;
	     hcell = new PdfPCell(new Phrase("Sr.No.", headFont1));
	     hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	     table.addCell(hcell);

	     hcell = new PdfPCell(new Phrase("Item Name", headFont1));
	     hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	     table.addCell(hcell);
	    
	     
	     hcell = new PdfPCell(new Phrase("Current Stock Quantity", headFont1));
	     hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	     table.addCell(hcell);
	     
	     
	    
	     
	     hcell = new PdfPCell(new Phrase("Comment", headFont1));
	     hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	     table.addCell(hcell);
	     
	     table.setHeaderRows(1);
	     
	     int index=0;
	     for (int i=0;i<prodList.size();i++) {
	    	 
	    	 
	    	 float curStockQty = (prodList.get(i).getOpTotal() + prodList.get(i).getProductionQty()
						- prodList.get(i).getRejectedQty()) - prodList.get(i).getOtherMenuOrderQty();

				float variationQty = curStockQty - prodList.get(i).getSelMenuOrderQty();

				if (variationQty < 0) {
					variationQty = variationQty * -1;
				} else {
					variationQty = 0;
				}
				int curStock=(int) (curStockQty);
				if(curStock>0) {
	       index++;
	         PdfPCell cell;

	        cell = new PdfPCell(new Phrase(String.valueOf(index),headFont));
	         cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	         cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	         table.addCell(cell);

	        
	         cell = new PdfPCell(new Phrase(prodList.get(i).getItemName(),headFont));
	         cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	         cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	         cell.setPaddingRight(2);
	         cell.setPadding(4);

	         table.addCell(cell);
	         
	         
	         cell = new PdfPCell(new Phrase(String.valueOf(curStockQty),headFont));
	         cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	         cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	         cell.setPaddingRight(2);
	         cell.setPadding(4);
	         table.addCell(cell);
	         
	         
	         
	         cell = new PdfPCell(new Phrase("",headFont));
	         cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	         cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	         cell.setPaddingRight(2);
	         cell.setPadding(4);
	         table.addCell(cell);
				}	         
	     }

	     document.open();
	     Paragraph company = new Paragraph(Constants.FACTORYNAME+"\n"+Constants.FACTORYADDRESS, f);
	     company.setAlignment(Element.ALIGN_CENTER);
	     document.add(company);
	     document.add(new Paragraph(" "));

	     Paragraph heading = new Paragraph("Report-Current Stock - "+dateFormat.format(cal.getTime()));
	     heading.setAlignment(Element.ALIGN_CENTER);
	     document.add(heading);
			String reportDate = (String) session.getAttribute("date");
			
			document.add(new Paragraph("Tab Name - " +session.getAttribute("menuName")+"- \t Selected Date - "+ reportDate));
			document.add(new Paragraph("\n"));
	     document.add(table);
	 	 int totalPages=writer.getPageNumber();
	 	/*com.ats.adminpanel.model.itextpdf.Header event; // = new com.ats.adminpanel.model.itextpdf.Header();
	 	for(int i=1;i<totalPages;i++) {
	 	 event = new com.ats.adminpanel.model.itextpdf.Header();
	 	event.setHeader(new Phrase(String.format("page %s", i)));
	 	
	 	writer.setPageEvent(event);
	 	}
	 	 FooterTable footerEvent = new FooterTable(table);
	 	 */
	 	 
	 //	 document.add(new Paragraph(""+document.setPageCount(document.getPageNumber()));
	     
	 	 System.out.println("Page no "+totalPages);
	     
	    // document.addHeader("Page" ,String.valueOf(totalPages));
	    // writer.setPageEvent((PdfPageEvent) new Phrase());
	    
	     document.close();
	     
	     
	   //Atul Sir code to open a Pdf File 
			if (file != null) {

				String mimeType = URLConnection.guessContentTypeFromName(file.getName());

				if (mimeType == null) {

					mimeType = "application/pdf";

				}

				response.setContentType(mimeType);

				response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

				// response.setHeader("Content-Disposition", String.format("attachment;
				// filename=\"%s\"", file.getName()));

				response.setContentLength((int) file.length());

				InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

				try {
					FileCopyUtils.copy(inputStream, response.getOutputStream());
				} catch (IOException e) {
					System.out.println("Excep in Opening a Pdf File for Mixing");
					e.printStackTrace();
				}
			}
	     
	    /* Desktop d=Desktop.getDesktop();
	     
	     if(file.exists()) {
	    	 try {
				d.open(file);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	     }*/
	     
	 } catch (DocumentException ex) {
	 
		 System.out.println("Pdf Generation Error: Prod From Orders"+ex.getMessage());
		 
		 ex.printStackTrace();
	   
	 }

		ModelAndView model = new ModelAndView("production/pdf/productionPdf");
		//model.addObject("prodFromOrderReport",updateStockDetailList);

	
	}
	
	
	

}
