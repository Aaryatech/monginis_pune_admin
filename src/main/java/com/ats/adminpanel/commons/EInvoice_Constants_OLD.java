package com.ats.adminpanel.commons;


public class EInvoice_Constants_OLD {

//	public static  final String  ASP_ID="1629701119";//madhvi
//	public static  final String  ASP_PWD="pdMulani@123";
	
	public static  final String  ASP_ID="1657201921";//pune
	public static  final String  ASP_PWD="lutffoods123@";
	
	
//	public static  final String  GSTIN="34AACCC1596Q002";
	public static  final String  GSTIN="27AAACL1073F1ZU"; //pune GSTIN
	
	
//	public static  final String  USER_NAME="TaxProEnvPON";
//	public static  final String  EINV_PWD="abc34*";
	
	
	public static  final String  USER_NAME="API_LUTF";
	public static  final String  EINV_PWD="Lutffoods@2021";
	
	
	public static String AUTH_TOKEN=null;
	public static int QR_CD_SIZE=250;
	
	public static String Production_Url_TOKEN="https://einvapi.charteredinfo.com/eivital/dec/v1.03/auth";
	public static  String SandBox_Url_TOKEN="https://gstsandbox.charteredinfo.com/eivital/dec/v1.03/auth";
		
	//1]
	public static String E_INV_AUTH_TOKEN_URL = Production_Url_TOKEN+"?aspid="+ASP_ID+"&password="+ASP_PWD+"&Gstin="+GSTIN+"&user_name="+USER_NAME+"&eInvPwd="+EINV_PWD;				
	
	
	public static String Production_Url_GEN_EINV="https://einvapi.charteredinfo.com/eicore/dec/v1.03/Invoice";
	public static String Sandbox_Url_GEN_EINV="https://einvapi.charteredinfo.com/eicore/dec/v1.03/Invoice";
	 
	//2]
	public static String GEN_IRN_URL = Production_Url_GEN_EINV+"?"
			+ "aspid="+ASP_ID+"&password="+ASP_PWD+"&Gstin="+GSTIN+"&user_name="+USER_NAME+
			"&QrCodeSize="+QR_CD_SIZE+"&AuthToken=";
		
	
	
	
	
	
	public static String E_INV_AUTH_TOKEN_URL_OLD = "https://gstsandbox.charteredinfo.com/eivital/dec/v"
			+"1.03/auth?aspid="+ASP_ID+"&password="+ASP_PWD+"&Gstin="+GSTIN+"&user_name="+USER_NAME+"&eInvPwd="+EINV_PWD;				
		
		
		public static String GEN_IRN_URL_OLD = "https://gstsandbox.charteredinfo.com/eicore/dec/v1.03/Invoice?"
				+ "aspid="+ASP_ID+"&password="+ASP_PWD+"&Gstin="+GSTIN+"&user_name="+USER_NAME+
				"&QrCodeSize="+QR_CD_SIZE+"&AuthToken=";
			

	
}
