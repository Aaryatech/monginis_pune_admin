package com.ats.adminpanel.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList; 
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

 
import com.ats.adminpanel.model.ExportToExcel;

 

@Controller
public class ExportExcelController {

/*	<dependency>
    <groupId>org.apache.poi</groupId>
    <artifactId>poi-ooxml</artifactId>
    <version>3.13</version>
</dependency>*/

	
	List<ExportToExcel> exportToExcelList=new ArrayList<ExportToExcel>();
	List<ExportToExcel> exportToExcelListDummy=new ArrayList<ExportToExcel>();
	  @RequestMapping(value = "/exportToExcel", method = RequestMethod.GET)
	    @ResponseBody
	    public void downloadSpreadsheet(HttpServletResponse response, HttpServletRequest request) throws Exception {
	        XSSFWorkbook wb = null;
	        HttpSession session = request.getSession();
	        try {
	        	
	        	
	        	  exportToExcelList=(List)session.getAttribute("exportExcelList"); 
	        	System.out.println("Excel List :"+exportToExcelList.toString());
	         
	        	String excelName=(String)session.getAttribute("excelName"); 
	            wb=createWorkbook();
	            autoSizeColumns(wb);
	            response.setContentType("application/vnd.ms-excel");
	            String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	            response.setHeader("Content-disposition", "attachment; filename="+excelName+"-"+date+".xlsx");
	            wb.write(response.getOutputStream());
	        	
	        } catch (IOException ioe) {
	            throw new RuntimeException("Error writing spreadsheet to output stream");
	        } finally {
	            if (wb != null) {
	                wb.close();
	            }
	        }
	        session.removeAttribute( "exportExcelList" );
	        System.out.println("Session List"+session.getAttribute("exportExcelList")); 
	    }
	  @RequestMapping(value = "/exportToExcelDummy", method = RequestMethod.GET)
	    @ResponseBody
	    public void exportToExcelDummy(HttpServletResponse response, HttpServletRequest request) throws Exception {
	        XSSFWorkbook wb = null;
	        HttpSession session = request.getSession();
	        try {
	        	
	        	
	        	exportToExcelListDummy=(List)session.getAttribute("exportExcelListDummy"); 
	        	System.out.println("Excel List :"+exportToExcelList.toString());
	         
	        	String excelName=(String)session.getAttribute("excelName"); 
	            wb=createWorkbook1();
	            autoSizeColumns(wb);
	            response.setContentType("application/vnd.ms-excel");
	            String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	            response.setHeader("Content-disposition", "attachment; filename="+excelName+"-"+date+".xlsx");
	            wb.write(response.getOutputStream());
	        	
	        } catch (IOException ioe) {
	            throw new RuntimeException("Error writing spreadsheet to output stream");
	        } finally {
	            if (wb != null) {
	                wb.close();
	            }
	        }
	        session.removeAttribute( "exportToExcelListDummy" );
	        System.out.println("Session List"+session.getAttribute("exportToExcelListDummy")); 
	    }
	    private XSSFWorkbook createWorkbook() throws IOException {
	        XSSFWorkbook wb = new XSSFWorkbook();
	        XSSFSheet sheet = wb.createSheet("LIST");
	        sheet.createFreezePane(0, 1);
	       /* writeHeaders(wb, sheet);
	        writeHeaders(wb, sheet);
	        writeHeaders(wb, sheet);
	 */
	        
	        	 for (int rowIndex = 0; rowIndex < exportToExcelList.size(); rowIndex++) {
	        	 XSSFRow row = sheet.createRow(rowIndex);
	        	 row.setHeight((short)700);
	        	 for (int j = 0; j < exportToExcelList.get(rowIndex).getRowData().size(); j++) {
	           
	            XSSFCell cell = row.createCell(j);
	            
	           
	            cell.setCellValue(exportToExcelList.get(rowIndex).getRowData().get(j));
	           
	             
	      
	        }
	        	 if(rowIndex==0)
	        	 row.setRowStyle(createHeaderStyle(wb));
	        }
	        return wb;
	    }
	    private XSSFWorkbook createWorkbook1() throws IOException {
	        XSSFWorkbook wb = new XSSFWorkbook();
	        XSSFSheet sheet = wb.createSheet("LIST");
	        sheet.createFreezePane(0, 1);
	       /* writeHeaders(wb, sheet);
	        writeHeaders(wb, sheet);
	        writeHeaders(wb, sheet);
	 */
	        
	        	 for (int rowIndex = 0; rowIndex < exportToExcelListDummy.size(); rowIndex++) {
	        	 XSSFRow row = sheet.createRow(rowIndex);
	        	 row.setHeight((short)700);
	        	 for (int j = 0; j < exportToExcelListDummy.get(rowIndex).getRowData().size(); j++) {
	           
	            XSSFCell cell = row.createCell(j);
	            
	           
	            cell.setCellValue(exportToExcelListDummy.get(rowIndex).getRowData().get(j));
	           
	             
	      
	        }
	        	 if(rowIndex==0)
	        	 row.setRowStyle(createHeaderStyle(wb));
	        }
	        return wb;
	    }
	/*    private void writeHeaders(XSSFWorkbook workbook, XSSFSheet sheet) {
	        XSSFRow header = sheet.createRow(0);
	        XSSFCell headerCell = header.createCell(0);
	        headerCell.setCellValue("Cities to visit");
	        headerCell.setCellStyle(createHeaderStyle(workbook));
	         
	    }*/
	    public void autoSizeColumns(Workbook workbook) {
	        int numberOfSheets = workbook.getNumberOfSheets();
	        for (int i = 0; i < numberOfSheets; i++) {
	            Sheet sheet = workbook.getSheetAt(i);
	            if (sheet.getPhysicalNumberOfRows() > 0) {
	                Row row = sheet.getRow(0);
	                row.setHeight((short)700);

	                Iterator<Cell> cellIterator = row.cellIterator();
	                while (cellIterator.hasNext()) {
	                    Cell cell = cellIterator.next();
	                    int columnIndex = cell.getColumnIndex();
	                    sheet.autoSizeColumn(columnIndex);
	                }
	            }
	        }
	    }
	    private XSSFCellStyle createHeaderStyle(XSSFWorkbook workbook) {
	        XSSFCellStyle style = workbook.createCellStyle();
	        style.setWrapText(true);
	        style.setFillForegroundColor(new XSSFColor(new java.awt.Color(247, 161, 103)));

	        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	        style.setAlignment(CellStyle.ALIGN_CENTER);
	        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

	        style.setBorderRight(CellStyle.BORDER_THIN);
	        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
	        style.setBorderBottom(CellStyle.BORDER_THIN);
	        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	        style.setBorderLeft(CellStyle.BORDER_THIN);
	        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	        style.setBorderTop(CellStyle.BORDER_THIN);
	        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
	        style.setDataFormat(1);
	       
	        Font font =workbook.createFont();
	        font.setFontName("Arial");
	        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	        font.setBold(true);
	        font.setColor(HSSFColor.WHITE.index);
	        style.setFont(font);
	 
	        return style;
	    }
}
