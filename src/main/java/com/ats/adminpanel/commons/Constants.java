package com.ats.adminpanel.commons;


public class Constants {
	
	public static final String SHOWBASEPATH ="http://107.180.93.120:8080/uploadspune/";
	public static final String UPLOADBASEPATH ="/opt/cpanel/ea-tomcat85/webapps/uploadspune/";
	
	//public static final String SHOWBASEPATH ="http://148.72.40.234:8080/uploadspune/";
	//public static final String UPLOADBASEPATH ="/opt/apache-tomcat-8.5.37/webapps/uploadspune/";
	
	public static final String url="http://localhost:8097/";
	//public static final String url="http://localhost:8080/";
	//public static final String url="http://107.180.93.120:8080/bakerywebapi/";
	public static final String SPCAKE_IMAGE_URL = SHOWBASEPATH+"MSPCAKE/";
	public static final String FR_IMAGE_URL = SHOWBASEPATH+"FR/";
	public static final String MESSAGE_IMAGE_URL = SHOWBASEPATH+"MSG/";
	public static final String ITEM_IMAGE_URL = SHOWBASEPATH+"ITEM/";
	public static final String RAW_MAT_IMG_URL =SHOWBASEPATH+"RAWMAT/";
	public static final String GATE_ENTRY_IMG_URL = SHOWBASEPATH+"GATEENTRY/";
	public static final String GVN_IMAGE_URL =SHOWBASEPATH+"GVN/";
	public static  String FACTORYNAME = "LUTF FOODS PVT. LTD.";
	public static  String FACTORYADDRESS = "Sr No 37, Near Angraj Hotel, Kondhwa, Pune, Maharashtra 411048";
	public static final String FACTORYGSTIN = "27AAACL1073F1ZU";
	public static final String CITY = "PUNE";
	public static final String STATE = "MAHARASHTRA";
	public static final String CODE = "LF";

	// navigation view
	
	public static int mainAct=0;
	public static int subAct=0;

	public static int FR_IMAGE_TYPE=1;
	public static int ITEM_IMAGE_TYPE=2;
	public static int MESSAGE_IMAGE_TYPE=3;
	
	public static int SPCAKE_IMAGE_TYPE=4;
	
	public static int CUST_CHIOICE_IMAGE_TYPE=5;
	
	
	public static int RAW_MAT_IMAGE_TYPE=6;

	public static int GATE_ENTRY_IMAGE_TYPE=7;

	
	//public static final String ReportURL ="http://192.168.1.25:8080/admin/";
	public static final String ReportURL ="http://107.180.93.120:8080/admin/";//change

	public static final String SETTING_KEY = "PB";

	public static final int DIS_BY_ACC = 7;

	public static final int AP_BY_ACC = 6;

	public static final int DIS_BY_STORE = 5;

	public static final int AP_BY_STORE = 4;

	public static final int AP_BY_GATE = 2;

	public static final int DIS_BY_GATE = 3;
	
//    public static final String REPORT_SAVE = "/home/supertom/apache-tomcat-8.5.35/webapps/admin/Report.pdf";
//	
//	public static final String BILL_REPORT_PATH="/home/supertom/apache-tomcat-8.5.35/webapps/admin/bill.pdf";
//    public static final String FINISHEDGOOD_REPORT_PATH="/home/supertom/apache-tomcat-8.5.35/webapps/admin/fsr.pdf";
//	public static final String CRN_REPORT_PATH="/home/supertom/apache-tomcat-8.5.35/webapps/admin/crn.pdf";
//	public static final String PO_PDF_PATH="/home/supertom/apache-tomcat-8.5.35/webapps/admin/po.pdf";
//    public static final String SALES_REPORT_PATH="/home/supertom/apache-tomcat-8.5.35/webapps/admin/report.pdf";
//    public static final String INWARD_PATH="/home/supertom/apache-tomcat-8.5.35/webapps/admin/Inward.pdf";
//    public static final String LOG_PDF_PATH="/home/supertom/apache-tomcat-8.5.35/webapps/admin/logdf.pdf";
//    public static final String DISPATCH_PATH="/home/supertom/apache-tomcat-8.5.35/webapps/admin/dispatch.pdf";

	
	public static final String REPORT_SAVE = UPLOADBASEPATH+"Report.pdf";
	
	public static final String BILL_REPORT_PATH=UPLOADBASEPATH+"bill.pdf";
    public static final String FINISHEDGOOD_REPORT_PATH=UPLOADBASEPATH+"fsr.pdf";
	public static final String CRN_REPORT_PATH=UPLOADBASEPATH+"crn.pdf";
	public static final String PO_PDF_PATH=UPLOADBASEPATH+"po.pdf";
    public static final String SALES_REPORT_PATH=UPLOADBASEPATH+"reportbill.pdf";
    public static final String INWARD_PATH=UPLOADBASEPATH+"Inward.pdf";
    public static final String LOG_PDF_PATH=UPLOADBASEPATH+"logdf.pdf";
    public static final String DISPATCH_PATH=UPLOADBASEPATH+"dispatch.pdf";
	
	
	public static final String SP_CAKE_FOLDER = SHOWBASEPATH+"SPCAKE/";

	public static final String CUST_CHOICE_PHOTO_CAKE_FOLDER = SHOWBASEPATH+"CUSTCHOICEPHOTOCAKE/";
	public static final int LOGIS_BILL_PDF_TYPE = 8;
	public static final String LOGIS_BILL_URL = SHOWBASEPATH+"MSPCAKE/";
	public static final int MENU_IMAGE_TYPE = 0;
	public static final String MENU_IMAGE_URL = null;
}
