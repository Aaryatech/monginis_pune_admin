package com.ats.adminpanel.controller;

import java.awt.Dimension;
import java.awt.Insets;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;
import org.zefer.pd4ml.PD4PageMark;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.model.LogisSetting;
import com.ats.adminpanel.model.ServDetailForPdf;
import com.ats.adminpanel.model.ServHeaderForPdf;
import com.ats.adminpanel.model.billing.Company;
import com.ats.adminpanel.model.logistics.Dealer;
import com.ats.adminpanel.model.logistics.MechType;
import com.ats.adminpanel.model.logistics.ServHeader;
import com.ats.adminpanel.model.logistics.SparePart;

@Controller
@Scope("session")
public class LogisticsPoController {

	@RequestMapping(value = "pdf/logisPo/{id}", method = RequestMethod.GET)
	public ModelAndView poPdf(@PathVariable int[] id, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("logistics/reportPdf/po");
		try {
			System.out.println("PO List ids " + id);

			RestTemplate restTemplate = new RestTemplate();
 
			List<Integer> integersList = new ArrayList<Integer>();

			for (int i = 0; i < id.length; i++) {

				if (id[i] > 0) {

					integersList.add(id[i]);
				}
			}

			String listOfIds = integersList.stream().map(Object::toString).collect(Collectors.joining(","));  
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("servId", listOfIds);
			  
			ServHeaderForPdf servDetailForPdf = restTemplate.postForObject(Constants.url + "getServiceDetailByServIdForPdf", map,
					ServHeaderForPdf.class);
			List<ServHeaderForPdf> list = new ArrayList<>();
			list.add(servDetailForPdf);
			
			map = new LinkedMultiValueMap<String, Object>();
			String otherPartIdss = "logis_part_other";
			map.add("key", otherPartIdss);
			LogisSetting otherPartIds = restTemplate.postForObject(Constants.url + "getLogisOtherPartIds", map,
					LogisSetting.class);
			
			List<ServDetailForPdf> detailList = servDetailForPdf.getList();
			
			model.addObject("viewServicingDetail", list); 
			model.addObject("detailList", detailList); 
			
			String[] ids = otherPartIds.getKeyValue().split(",");
			
			for(int i=0;i<detailList.size() ; i++) {
				if (Integer.parseInt(ids[0]) == detailList.get(i).getSprId()
						|| Integer.parseInt(ids[1]) == detailList.get(i).getSprId()) {

					detailList.get(i).setSprName(detailList.get(i).getVarchar1());
					 
				}
			}

		} catch (Exception e) {
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

	private int userSpaceWidth = 850;
	private static int BUFFER_SIZE = 1024;

	@RequestMapping(value = "/poPdfReport", method = RequestMethod.GET)
	public void showPDF(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Inside PDf For Report URL ");
		String url = request.getParameter("url");
		// String url="/showEditViewIndentDetail/1";
		System.out.println("URL " + url);

		// File f = new File("/report.pdf");
		// File f = new File("C:/pdf/report.pdf");
		File f = new File(Constants.REPORT_SAVE);
		try {
			runConverter(Constants.ReportURL + url, f, request, response);
			// runConverter("www.google.com", f,request,response);

		} catch (IOException e) {

			System.out.println("Pdf conversion exception " + e.getMessage());
		}

		// get absolute path of the application
		ServletContext context = request.getSession().getServletContext();
		String appPath = context.getRealPath("");
		// String filePath = "/report.pdf";

		// String filePath ="C:/pdf/report.pdf";
		String filePath = Constants.REPORT_SAVE;
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

	private void runConverter(String urlstring, File output, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		if (urlstring.length() > 0) {
			if (!urlstring.startsWith("http://") && !urlstring.startsWith("file:")) {
				urlstring = "http://" + urlstring;
			}
			System.out.println("PDF URL " + urlstring);
			java.io.FileOutputStream fos = new java.io.FileOutputStream(output);

			PD4ML pd4ml = new PD4ML();

			try {

				PD4PageMark footer = new PD4PageMark();
				pd4ml.enableSmartTableBreaks(true);
				footer.setPageNumberTemplate("page $[page] of $[total]");
				footer.setTitleAlignment(PD4PageMark.LEFT_ALIGN);
				footer.setPageNumberAlignment(PD4PageMark.RIGHT_ALIGN);
				footer.setInitialPageNumber(1);
				footer.setFontSize(8);
				footer.setAreaHeight(15);

				pd4ml.setPageFooter(footer);

			} catch (Exception e) {
				System.out.println("Pdf conversion method excep " + e.getMessage());
			}
			try {
				pd4ml.setPageSize(landscapeValue ? pd4ml.changePageOrientation(format) : format);
				// pd4ml.setPageSize(new java.awt.Dimension(15*72, 11*72));
			} catch (Exception e) {
				System.out.println("Pdf conversion ethod excep " + e.getMessage());
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
