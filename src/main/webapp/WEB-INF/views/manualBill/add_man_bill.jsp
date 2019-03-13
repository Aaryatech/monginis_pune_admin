<%@page import="com.ats.adminpanel.model.franchisee.SubCategory"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page
	import="java.io.*, java.util.*, java.util.Enumeration, java.text.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Monginis Admin</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!--base css styles-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/data-tables/bootstrap3/dataTables.bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap-fileupload/bootstrap-fileupload.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/chosen-bootstrap/chosen.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap-timepicker/compiled/timepicker.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/clockface/css/clockface.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap-datepicker/css/datepicker.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/daterangepicker.css" />

<!--page specific css styles-->

<!--flaty css styles-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/flaty.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/flaty-responsive.css">

<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/img/favicon.png">

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/common.js"></script>

<!--basic scripts-->

<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<script>
	window.jQuery
			|| document
					.write('<script src="${pageContext.request.contextPath}/resources/assets/jquery/jquery-2.0.3.min.js"><\/script>')
</script>
<script
	src="${pageContext.request.contextPath}/resources/assets/bootstrap/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/jquery-cookie/jquery.cookie.js"></script>

<!--page specific plugin scripts-->
<script
	src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.resize.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.pie.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.stack.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.crosshair.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.tooltip.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/sparkline/jquery.sparkline.min.js"></script>

<!--flaty scripts-->
<script src="${pageContext.request.contextPath}/resources/js/flaty.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/flaty-demo-codes.js"></script>
<!--page specific plugin scripts-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/bootstrap-fileupload/bootstrap-fileupload.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/chosen-bootstrap/chosen.jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/clockface/js/clockface.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/date.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/daterangepicker.js"></script>
<!-- http://forum.springsource.org/showthread.php?110258-dual-select-dropdown-lists -->
<!-- http://api.jquery.com/jQuery.getJSON/ -->

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/additional-methods.min.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi">
    </script>
    <script type="text/javascript">

      // Load the Google Transliterate API
      google.load("elements", "1", {
            packages: "transliteration"
          });

      function onLoad() {
        var options = {
            sourceLanguage:
                google.elements.transliteration.LanguageCode.ENGLISH,
            destinationLanguage:
                [google.elements.transliteration.LanguageCode.HINDI],
        //shortcutKey: 'ctrl+g',
            transliterationEnabled: true
        };

        // Create an instance on TransliterationControl with the required
        // options.
        var control =
            new google.elements.transliteration.TransliterationControl(options);

        // Enable transliteration in the textbox with id
        // 'transliterateTextarea'.
        control.makeTransliteratable(['transliterateTextarea']);   showCtype();
      }
   
      google.setOnLoadCallback(onLoad);
    </script>
<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
<style type="text/css">
select {
	width: 180px;
	height: 30px;
}
</style>


</head>
<body onload="onLoad()">

	<c:url var="getFlavourBySpfId" value="/getFlavourBySpfId" />
	<c:url var="findAddOnRate" value="/getAddOnRate" />
	

	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


	<div class="container" id="main-container">

		<!-- BEGIN Sidebar -->
		<div id="sidebar" class="navbar-collapse collapse">

			<jsp:include page="/WEB-INF/views/include/navigation.jsp"></jsp:include>

			<div id="sidebar-collapse" class="visible-lg">
				<i class="fa fa-angle-double-left"></i>
			</div>
			<!-- END Sidebar Collapse Button -->
		</div>
		<!-- END Sidebar -->


		<!-- BEGIN Content -->
		<div id="main-content">
			<!-- BEGIN Page Title -->
			<!-- 	<div class="page-title">
				<div>
					<h1>
						<i class="fa fa-file-o"></i> Franchisee
					</h1>
				</div>
			</div> -->
			<!-- END Page Title -->


			<!-- BEGIN Main Content -->
			<div class="row">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-12">
							<div class="box">
								<div class="box-title">
									<h3>
										<i class="fa fa-bars"></i>SP Manual Bill
									</h3>
									<div class="box-tool">
										<%-- 	<a href="${pageContext.request.contextPath}/configuredFrMenus">Back to
											List</a> <a data-action="collapse" href="#"><i
											class="fa fa-chevron-up"></i></a> --%>
									</div>
								</div>


			<c:set var="allFranchiseeAndMenuList"	value="${allFranchiseeAndMenuList}" />
			<div class="box-content">
			<form action="${pageContext.request.contextPath}/getSpCakeForManBill" class="form-horizontal" id="validation-form" method="post">
	

										<div class="form-group">
											<div class="col-md-2">Franchisee</div>
											<div class="col-md-3">
												<select data-placeholder="Select Franchisee" name="fr_id"
													class="form-control chosen" tabindex="-1" id="fr_id"
													data-rule-required="true">
													<option value=""> </option>
													<!-- <optgroup label="All Franchisee"> -->
													<option value="">Select Franchise</option>
													<c:forEach items="${unSelectedFrList}" var="franchiseeList">
														<c:choose>
															<c:when test="${frId==franchiseeList.frId}">
																<option selected value="${franchiseeList.frId}">${franchiseeList.frName}</option>
															</c:when>
															<c:otherwise>
																<option value="${franchiseeList.frId}">${franchiseeList.frName}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
											</div>
											<div class="col-md-1">Sp List</div>
											<div class="col-md-3">
												<select data-placeholder="Select Menu" name="sp_cake_id"
													class="form-control chosen" tabindex="-1" id="sp_cake_id"
													data-rule-required="true">
													<c:forEach items="${specialCakeList}" var="spCake">
														<c:choose>
															<c:when test="${specialCake.spCode==spCake.spCode}">
																<option selected value="${spCake.spCode}">${spCake.spCode}-${spCake.spName}</option>
															</c:when>
															<c:otherwise>
																<option value="${spCake.spCode}">${spCake.spCode}-${spCake.spName}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
											</div>
										<div class="col-md-2">
											<c:choose>
											<c:when test="${billBy==0}">
											By Rate &nbsp;&nbsp;<input type="radio" name="sel_rate" id="sel_rate"
													  value="1">
											By MRP  &nbsp;&nbsp;<input type="radio" name="sel_rate"
													id="sel_rate" checked   value="0">
											</c:when>
											<c:otherwise>
											By Rate<input type="radio" name="sel_rate" id="sel_rate"
													checked  value="1">
											By MRP <input type="radio" name="sel_rate"
													id="sel_rate"    value="0">
											</c:otherwise>
											</c:choose>
											</div>
											<div
												class="col-md-1">
										<input type="submit" class="btn btn-primary" value="Search">
								</div>
						</div>
				</form>	<hr>
											
		<form action="${pageContext.request.contextPath}/insertManualSpBill"  method="post" class="form-horizontal" name="from_ord" id="validation-form" enctype="multipart/form-data"onsubmit="return validate()">
<input type="hidden" name="fr_id" value="${frId}"> 
<input type="hidden" name="billBy" value="${billBy}"> 					
<input type="hidden" name="menu_title" value="${menuTitle}"> 
<input type="hidden" name="mode_add" id="mode_add" value="add_book">
<input type="hidden" name="sp_id" id="sp_id" value="${specialCake.spId}">
<input type="hidden" name="sp_min_weight" id="sp_min_weight" value="${specialCake.spMinwt}">
<input type="hidden" name="sp_max_weight" id="sp_max_weight" value="${specialCake.spMaxwt}">
<input type="hidden" name="sp_est_del_date" id="sp_est_del_date" value="${convDate}">

<input type="hidden" name="sp_pro_time" id="sp_pro_time" value="${specialCake.spBookb4}">
<input type="hidden" name="production_time" id="production_time" value="${specialCake.spBookb4} ">
<input type="hidden" name="sp_code" id="sp_code" value="${specialCake.spCode}">
<input type="hidden" name="sp_name" id="sp_name" value="${specialCake.spName}">
<input type="hidden" name="fr_code" id="fr_code" value="4">
<input type="hidden" name="spPhoUpload" id="spPhoUpload" value="${specialCake.spPhoupload}">
<input type="hidden" name="isCustCh" id="isCustCh" value="${specialCake.isCustChoiceCk}">
<input type="hidden" name="prevImage" id="prevImage" value="${specialCake.spImage}">
<input type="hidden" name="isCustChoiceCk" id="isCustChoiceCk" value="${specialCake.isCustChoiceCk}">
<input type="hidden" name="spPhoUpload" id="spPhoUpload" value="${specialCake.spPhoupload}">
<input type="hidden" name="isSlotUsed" id="isSlotUsed" value="${specialCake.isSlotUsed}">					
						<div class="form-group">
							<div class="col-md-2">Cake Name</div>
							<div class="col-md-3" id="spDesc" style="color:#eb62ad;">
									-${specialCake.spName}
							</div>	
							<div class="col-md-2">Min Weight <b>${specialCake.spMinwt} Kg </b> </div>
							<div class="col-md-2">Max Weight <b>${specialCake.spMaxwt} Kg </b></div>
							<c:set var = "dbRate" scope="session" value = "${sprRate}"/>
		         				 <input type="hidden" name="spBackendRate" id="spBackendRate" value="${spBackendRate}">	
									<!-----------------------1-------------------------------->
									<h4 class="inrbox" id="INR" style="font-weight: bold;"><span style="padding:5px;font-weight: bold;">INR -  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> &nbsp;&nbsp;${(sprRate*specialCake.spMinwt)}</h4>
									<input type="hidden" name="sp_grand" id="sp_grand" value="${(sprRate*specialCake.spMinwt)}">
									<!-----------------------1---End-------------------------->
						</div>
									
						<div class="form-group">
						<div class="col-md-2">Flavour Type</div>
						<div class="col-md-3"><select name="sptype" tabindex="-1" id="sptype" class="form-control chosen" data-rule-required="true">
             									 <option value="">Select Type</option>
                								 <c:set var= "spCakeType" value="${specialCake.spType}"></c:set>
             									  <c:choose>
                   								  <c:when test="${spCakeType=='1'}"> <option value="1">Chocolate</option>   </c:when> 
                    							  <c:when test="${spCakeType=='2'}"> <option value="2">FC</option>          </c:when>
                    							  <c:when test="${spCakeType=='3'}"> <option value="3">BC</option>          </c:when>
                       							  <c:when test="${spCakeType=='4'}"> 
												  <option value="1">Chocolate</option> <option value="2">FC</option> 
                     							  </c:when>
                      							  <c:when test="${spCakeType=='5'}"> 
												  <option value="1">Chocolate</option> <option value="3">BC</option> 
                    						      </c:when>
                     						      <c:when test="${spCakeType=='6'}"> 
												  <option value="2">FC</option> <option value="3">BC</option> 
                    						      </c:when>
                       							  <c:otherwise>
                      							  <option value="1">Chocolate</option>
                        						  <option value="2">FC</option>
                       							  <option value="3">BC</option>
								                </c:otherwise>    
              									</c:choose>
            								</select>
						</div>
						<div class="col-md-1">Flavour</div>
							<div class="col-md-3" >
									<select data-placeholder="Select Flavour" name="spFlavour" required
											class="form-control chosen" tabindex="-1" id="spFlavour"
											onchange="onChangeFlavour()">
									</select>
							</div>
							<!--------------------------2------------------------------->
							<div class="col-md-1"style="border:1px dashed;" ><b>Type</b></div>
							<div class="col-md-1"style="border:1px dashed;"><span style="color:#eb4bad;"><b>Premium</b></span></div>
							<!--------------------------2- End-------------------------->
						</div>
						<div class="form-group">
						   <div class="col-md-2">Weight</div> 
						   <div class="col-md-1">
						   <input type="hidden" name="dbRate" id="dbRate" value="${sprRate}">
						   
						      <select name="spwt" id="spwt" class="form-control" onchange="onChange('${sprRate}')" required>
            				     <c:forEach items="${weightList}" var="weightList">
                  				 <option value="${weightList}">${weightList}</option>
            				     </c:forEach> 
          				      </select>
          				   </div>	
						<div class="col-md-2">
						<select name="sp_event" id="sp_event" class="form-control chosen" data-placeholder="Select Message" required>
  
             				 <c:forEach items="${eventList}" var="eventList">
           					   <option value="${eventList.spMsgText}"><c:out value="${eventList.spMsgText}" /></option>
            				 </c:forEach>
           			    </select>
           			    </div>
           			    
           			    <div class="col-md-1" >Name</div>
		 				<div class="col-md-3"><input  class="form-control" placeholder="Name" name="event_name" type="text" id="event_name" required>
						</div>
						<!--------------------------3------------------------------->
						<div class="col-md-1" style="border:1px dashed;"><b>Price</b></div>
						<div class="col-md-1" id="price"style="border:1px dashed;font-weight: bold;">${sprRate*specialCake.spMinwt}</div>
						<input name="sp_calc_price" id="sp_calc_price" value="${sprRate*specialCake.spMinwt}" type="hidden">	
						<!--------------------------3 End--------------------------->
											
	 				    </div>
    				<div class="form-group">
					<div class="col-md-2">Delivery Date</div>
					<div class="col-md-3">
					<c:choose>
					   <c:when test="${menuId==46}">
							<input id="date" class="form-control date-picker"  value=""  name="datepicker" type="text" readonly>
							<input id="datepicker" class="form-control"  value=""  name="datepicker" type="hidden" />

					   </c:when>
					   <c:otherwise>
						<input id="datepicker" class="form-control date-picker"  data-date-format="dd-mm-yyyy" autocomplete="off" value="" required name="datepicker" type="text" required>
					   </c:otherwise>
					</c:choose>
					</div>
					<div class="col-md-1">Prod Date:</div>
					<div class="col-md-3" ><input id="spProdDate"  data-date-format="dd-mm-yyyy" value="" autocomplete="off" class="form-control date-picker" placeholder="" name="spProdDate" type="text" required>
					</div>
					
					<div class="col-md-1"style="border:1px dashed;font-weight: bold;">Add Rate </div>
					<div class="col-md-1"  id="rate" style="border:1px dashed;font-weight: bold;">00</div>
					 <input name="sp_add_rate" id="sp_add_rate"  type="hidden" value="0">
					</div>
	
					<div class="form-group">
	   				<div class="col-md-2">Customer Name</div>
					<div class="col-md-3"><input class="form-control" placeholder="Customer Name" required name="sp_cust_name" type="text" id="sp_cust_name"required></div>
		
					<div class="col-md-1">DOB</div>
					<div class="col-md-3" ><input id="datepicker4"  data-date-format="dd-mm-yyyy" required autocomplete="off" class="form-control date-picker" placeholder="" name="datepicker4" type="text"required>
					</div>
    				
    				<!-----------------------4-------------------------------->
    				<div class="col-md-1"><b>E.Charges</b></div>
					<div class="col-md-1"><input name="sp_ex_charges" required id="sp_ex_charges"  type="text"  value="0" oninput="chChange()"  style="width:80px;border-radius:10px;text-align:center;height: 27px;"></div>
				    <!-----------------------4 End---------------------------->
    			
					</div>								
	 
	 				 <div class="form-group">
					 <div class="col-md-2">Select Language</div>
      				 <div class="col-md-3">
                      <select id="show" class="form-control" name="showtextarea" onchange="showDiv(this)" required>
                              <option value="1" id="marathi" >Marathi</option>
                              <option value="2" id="english" >English</option>
                       </select>
        			</div>
	    			<div class="col-md-1">Sp Instructions</div>
					<div class="col-md-2" id="marathiDiv">
					<textarea id="transliterateTextarea"  name="sp_inst1" cols="" rows="" style="width:240px;height:50px"maxlength="300" ></textarea>
					</div>
	    			<div class="col-md-2" id="englishDiv" style="display: none;">
	   					 <textarea id="textarea"  name="sp_inst2" cols="" rows="" style="width:240px;height:50px"maxlength="300"></textarea>
	   			   </div>
	   			  
	   			   <div class="col-md-1" ></div>
	   			  <!-----------------------5-------------------------------->
	   			  <div class="col-md-1" style="font-weight: bold;">Discount(%)</div>
					<div class="col-md-1"><input name="sp_disc" id="sp_disc" required type="text"  value="0"  oninput="chChange()" style="width:80px;border-radius:10px;text-align:center;height: 27px;"></div>
				    <!-----------------------5-End-------------------------->
	               </div>
					
					<div class="form-group">
						<div class="col-md-2">Franchise Name</div>
						<div class="col-md-3"><input name="fr_name" id="fr_name" class="form-control" type="text"></div>
						
						<div class="col-md-1">GST  No</div>
						<div class="col-md-3"><input name="gst_no" id="gst_no" class="form-control" type="text"></div>
						  <!-----------------------6-------------------------------->
	   			    <div class="col-md-1" style="border:1px dashed;font-weight: bold;"><b>Sub Total</b></div>
					<div class="col-md-1" style="border:1px dashed;font-weight: bold;" id="subtotal">${sprRate*specialCake.spMinwt}</div>
					<input name="sp_sub_total" id="sp_sub_total"  type="hidden"value="${sprRate*specialCake.spMinwt}">
				 <!-----------------------6-End------------------------------->
				
						
					</div>
		
					<div class="form-group">
					<div class="col-md-2">Cust Email</div>
						<div class="col-md-3"><input name="cust_email" id="cust_email" class="form-control" type="text"></div>
					<div class="col-md-1">Cust Mobile.</div>
						<div class="col-md-3"><input name="cust_mobile" id="cust_mobile" class="form-control" type="text"></div>  
					<!--  <div class="col-md-4" style="text-align: center;"></div> -->
					  <!-----------------------7-------------------------------->
	    		   <div class="col-md-1"style="border:1px dashed;"><b>GST (%)</b></div>
				   <div class="col-md-1" id="taxPer3" style="border:1px dashed;font-weight:bold;"> ${specialCake.spTax1+specialCake.spTax2} </div>
				   <input type="hidden" id="tax3" name="tax3" value="${specialCake.spTax1+specialCake.spTax2}">
				    <!-----------------------7-End------------------------------->
				    </div>
				<div class="form-group">
				<div class="col-md-2">Order No:</div>
					<div class="col-md-3"><input class="form-control" placeholder="Order No" name="sp_place" id="sp_place" type="text" value="${spNo}" readonly></div>
			         	<div class="col-md-1">Select Menu</div>
											<div class="col-md-3">
											<select name="spMenuId" class="form-control chosen" data-placeholder="Menu" 
												id="spMenuId" required>
												<option value="">Select Menu</option>
												<c:forEach items="${frMenuList}" var="frMenuList">
													<c:choose>
														<c:when test="${frMenuList.mainCatId==5}">
															<option value="${frMenuList.menuId}">
															<c:out value="${frMenuList.menuTitle}" /></option>
														</c:when>
													</c:choose>
												</c:forEach>
											</select>
                                           </div>
			       
		       
					 <!---------------------8-------------------------------->
						<div class="col-md-1"style="border:1px dashed;font-weight: bold;">GST RS.</div>
						<c:set var="varGstRs" value="${(((sprRate*specialCake.spMinwt)*100)/((specialCake.spTax1+specialCake.spTax2)+100))*(specialCake.spTax1+specialCake.spTax2)/100}" />  
						<fmt:formatNumber var="fGstRs" minFractionDigits="2" maxFractionDigits="2" type="number" value="${varGstRs}" />  
					
						<div class="col-md-1" id="gstrs"style="border:1px dashed;font-weight: bold;"><c:out value="${fGstRs}" /></div>
						<input type="hidden" id="gst_rs" name="gst_rs" value="${fGstRs}">
					<!---------------------8-End----------------------------->	
					</div>
					<div class="form-group">
					
<c:choose>
<c:when test="${specialCake.isCustChoiceCk=='1'}">
	  <div class="col-md-1">Photo Cake1</div>

		<div class="col-sm-2 col-lg-2 controls">
										<div class="fileupload fileupload-new"
											data-provides="fileupload">
											<div class="fileupload-new img-thumbnail"
												style="width: 120px; height: 40px;">
												<img
													src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
													alt="" />
											</div>
											<div
												class="fileupload-preview fileupload-exists img-thumbnail"
												style="max-width: 40px; max-height:40px; line-height: 20px;"></div>
											<div>
												<span class="btn btn-default btn-file"><span
													class="fileupload-new">Select image</span> <span
													class="fileupload-exists">Change</span> <input type="file"
													class="file-input" id="order_photo" name="order_photo"/></span>
												<a href="#" class="btn btn-default fileupload-exists"
													data-dismiss="fileupload">Remove</a>
											</div>
										</div>

									</div>
<div class="col-md-1">Photo Cake2</div>
									
	<div class="col-sm-2 col-lg-2 controls">
										<div class="fileupload fileupload-new"
											data-provides="fileupload">
											<div class="fileupload-new img-thumbnail"
												style="width: 120px; height: 40px;">
												<img
													src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
													alt="" />
											</div>
											<div
												class="fileupload-preview fileupload-exists img-thumbnail"
												style="max-width: 40px; max-height:40px; line-height: 20px;"></div>
											<div>
												<span class="btn btn-default btn-file"><span
													class="fileupload-new">Select image</span> <span
													class="fileupload-exists">Change</span> <input type="file"
													class="file-input" id="cust_choice_ck" name="cust_choice_ck"/></span>
												<a href="#" class="btn btn-default fileupload-exists"
													data-dismiss="fileupload">Remove</a>
											</div>
										</div>

									</div>

	
	
   </c:when>
   <c:when test="${specialCake.spPhoupload=='1'}">
	  <div class="col-md-1">Photo Cake</div>
	 	<div class="col-sm-2 col-lg-2 controls">
										<div class="fileupload fileupload-new"
											data-provides="fileupload">
											<div class="fileupload-new img-thumbnail"
												style="width: 100px; height: 50px;">
												<img
													src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
													alt="" />
											</div>
											<div
												class="fileupload-preview fileupload-exists img-thumbnail"
												style="max-width: 40px; max-height:40px; line-height: 20px;"></div>
											<div>
												<span class="btn btn-default btn-file"><span
													class="fileupload-new">Select image</span> <span
													class="fileupload-exists">Change</span> <input type="file"
													class="file-input" id="order_photo" name="order_photo"/></span>
												<a href="#" class="btn btn-default fileupload-exists"
													data-dismiss="fileupload">Remove</a>
											</div>
										</div>

									</div>
									<div class="col-md-3"></div>
	</c:when>
	<c:otherwise><div class="col-md-6"></div></c:otherwise>
</c:choose> 
					<div class="col-md-2" style="text-align: center;">
					<input class="btn btn-primary" onclick="callSubmit()" value="SUBMIT"  type="submit" id="click" >
						<!-- <input name="" class="btn btn-danger" class="btnReset" value="RESET" type="reset"> -->
					</div>
		        <div class="col-md-4" style="text-align: center;"></div>
					<!----------------------9-------------------------------->    
					<c:set var="varMgstamt" value="${(((sprRate*specialCake.spMinwt)*100)/((specialCake.spTax1+specialCake.spTax2)+100))}"/>
					<fmt:formatNumber var="fMgstamt" minFractionDigits="2" maxFractionDigits="2" type="number" value="${varMgstamt}" />  
					
					<div class="col-md-2" id="mgstamt" style="border:1px dashed;font-weight: bold;">AMT-<c:out value="${fMgstamt}"></c:out></div>
					
				   <input type="hidden" name="m_gst_amt" id="m_gst_amt" type="hidden" value="${fMgstamt}">
				
					<div class="col-md-2"id="tot" style="border:1px dashed;font-weight: bold;">TOTAL -${(sprRate*specialCake.spMinwt)}</div>
										 <input type="hidden" name="total_amt" id="total_amt" value="${(sprRate*specialCake.spMinwt)}">
					
 				    <!----------------------9----End-------------------------->   				
											<input type="hidden" id="tax1" name="tax1"	value="${specialCake.spTax1}"> 
											<input type="hidden" id="tax2" name="tax2" value="${specialCake.spTax2}">
											
											<c:if	test="${specialCake.spTax1==0 or specialCake.spTax1==0.00}">
												<input type="hidden" id="t1amt" name="t1amt" value="0.0">
											</c:if>
											
											<c:if	test="${specialCake.spTax1!=0 or specialCake.spTax1!=0.00}">
												<input type="hidden" id="t1amt" name="t1amt" value="${(sprRate*specialCake.spMinwt)*(specialCake.spTax1)/100}">
											</c:if>
											<c:if	test="${specialCake.spTax2==0 or specialCake.spTax2!=0.00}">
												<input type="hidden" id="t2amt" name="t2amt" value="0.0">
											</c:if>
											<c:if test="${specialCake.spTax2!=0 or specialCake.spTax2!=0.00}">
												<input type="hidden" id="t2amt" name="t2amt" value="${(sprRate*specialCake.spMinwt)*(specialCake.spTax2)/100}">
											</c:if>
											<input type="hidden" id="dbAdonRate" name="dbAdonRate">
										    <input type="hidden" id="dbPrice" name="dbPrice" value="${sprRate}"> 
										    <input type="hidden" id="sp_id" name="sp_id"	value="${specialCake.spId}">
										</div>
									 <div class="form-group">
										  <div  id="ctype1">
											<div class="col-md-2" id="cktype">Cake Type</div>
											<div class="col-md-2"><input class="form-control"  name="ctype" type="text" id="ctype"  ></div>
										  </div> 
										<input class="texboxitemcode"  name="temp" type="hidden" id="temp" value="${cutSec}" required >
									</div>	
											
											
											<%--<div class="col-md-2">Select Menu</div>
											<div class="col-md-3">
											<select name="spMenuId" class="form-control chosen" data-placeholder="Menu" 
												id="spMenuId" required>
												<option value="">Select Menu</option>
												<c:forEach items="${frMenuList}" var="frMenuList">
													<c:choose>
														<c:when test="${frMenuList.mainCatId==5}">
															<option value="${frMenuList.menuId}">
															<c:out value="${frMenuList.menuTitle}" /></option>
														</c:when>
													</c:choose>
												</c:forEach>
											</select>
                                           </div>
										</div> --%>
										<!--rightForm-->	
<%-- <div class="right">
	<div class="box-content">
		<h2 class="inrbox" id="INR">INR - ${(sprRate*specialCake.spMinwt)}</h2>
		 <input type="hidden" name="sp_grand" id="sp_grand" value="${(sprRate*specialCake.spMinwt)}">
		 <section class="form-control">
		    
		<div class="form-group">
								
			
					<div class="col-md-1">Type  </div>
					<div class="col-md-1"><span>Premium</span></div>
				
					<div class="col-md-1">Price </div>
					<div class="col-md-1" id="price">${sprRate*specialCake.spMinwt}</div>
					<input name="sp_calc_price" id="sp_calc_price" value="${sprRate*specialCake.spMinwt}" type="hidden">
			
					<div class="col-md-1">Add Rate </div>
					<div class="col-md-1"  id="rate" >00</div>
					 <input name="sp_add_rate" id="sp_add_rate"  type="hidden" value="0">
			
					<div class="col-md-1">Sub Total </div>
					<div class="col-md-1" id="subtotal">${sprRate*specialCake.spMinwt}</div>
					<input name="sp_sub_total" id="sp_sub_total"  type="hidden"value="${sprRate*specialCake.spMinwt}">
					</div>
					</section>
					 <section class="form-control">
					<div class="form-group">
				
					<div class="col-md-1">GST (%)</div>
					<div class="col-md-1" id="taxPer3"> ${specialCake.spTax1+specialCake.spTax2} </div>
					<input type="hidden" id="tax3" name="tax3" value="${specialCake.spTax1+specialCake.spTax2}">
					
					<div class="col-md-1">GST RS.</div>
					<c:set var="varGstRs" value="${(((sprRate*specialCake.spMinwt)*100)/((specialCake.spTax1+specialCake.spTax2)+100))*(specialCake.spTax1+specialCake.spTax2)/100}" />  
					<fmt:formatNumber var="fGstRs" minFractionDigits="2" maxFractionDigits="2" type="number" value="${varGstRs}" />  
					
					<div class="col-md-1" id="gstrs"><c:out value="${fGstRs}" /></div>
					<input type="hidden" id="gst_rs" name="gst_rs" value="${fGstRs}">
				
				<c:set var="varMgstamt" value="${(((sprRate*specialCake.spMinwt)*100)/((specialCake.spTax1+specialCake.spTax2)+100))}"/>
					<fmt:formatNumber var="fMgstamt" minFractionDigits="2" maxFractionDigits="2" type="number" value="${varMgstamt}" />  
					
					<div class="col-md-2" id="mgstamt">AMT-<c:out value="${fMgstamt}"></c:out></div>
					
				   <input type="hidden" name="m_gst_amt" id="m_gst_amt" type="hidden" value="${fMgstamt}">
				
					<div class="col-md-2"id="tot">TOTAL AMT -${(sprRate*specialCake.spMinwt)}</div>
					</div>
					</section>
					 <section class="form-control" style="border-bottom: none; border-left: none;border-right: none;" >
					
		<div class="remainamount">
			<div class="priceLeft">Remaining Amount</div>
					<div class="priceRight" id="rmAmt">${(sprRate*specialCake.spMinwt)}</div>
				    <input type="hidden" name="rm_amount" id="rm_amount" value="${(sprRate*specialCake.spMinwt)}">
		</div>
	</div>
	
	<div class="order-btn" style="text-align: center;">
		<input class="btn btn-primary" onclick="callSubmit()" value="SUBMIT"  type="button" id="click" >
		<input name="" class="btn btn-danger" class="btnReset" value="RESET" type="reset">
	</div>
	</section>
	
	
</div>

<input type="hidden" id="tax1" name="tax1" value="${specialCake.spTax1}">
<input type="hidden" id="tax2" name="tax2" value="${specialCake.spTax2}">


<c:if test="${specialCake.spTax1==0 or specialCake.spTax1==0.00}">
<input type="hidden" id="t1amt" name="t1amt" value="0.0">
</c:if>
<c:if test="${specialCake.spTax1!=0 or specialCake.spTax1!=0.00}">
<input type="hidden" id="t1amt" name="t1amt" value="${(sprRate*specialCake.spMinwt)*(specialCake.spTax1)/100}">

</c:if>
<c:if test="${specialCake.spTax2==0 or specialCake.spTax2!=0.00}">
<input type="hidden" id="t2amt" name="t2amt" value="0.0">
</c:if>
<c:if test="${specialCake.spTax2!=0 or specialCake.spTax2!=0.00}">
<input type="hidden" id="t2amt" name="t2amt" value="${(sprRate*specialCake.spMinwt)*(specialCake.spTax2)/100}">

</c:if>

<input type="hidden" id="dbAdonRate" name="dbAdonRate">
 <input type="hidden" id="dbPrice" name="dbPrice"  value="${sprRate}">
<input type="hidden" id="sp_id" name="sp_id"  value="${specialCake.spId}">

</div> --%>
									</form>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- END Main Content -->

			<footer>
				<p>2019 � MONGINIS.</p>
			</footer>

			<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
				class="fa fa-chevron-up"></i></a>
		</div>
		<!-- END Content -->
	</div>
	<!-- END Container -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		
	/* 	function callSubmit() {
			//alert("HI");
			var form=document.getElementById("validation-form");
			//alert("form "+form);
			form.action=("insertManualSpBill");
			form.submit();
			
		}
		 */
		</script>
		<script type="text/javascript">
$(document).ready(function() { 
	$('#sptype').change(
			function() {
				$.getJSON('${getFlavourBySpfId}', {
					spType : $(this).val(),
					ajax : 'true'
				}, function(data) {
					var html = '<option value="">Flavour</option>';
					//alert(JSON.stringify(data));
					var len = data.length;
					
					for ( var i = 0; i < len; i++) {
						html += '<option value="' + data[i].spfId + '">'
								+ data[i].spfName + '</option>';
					}
					html += '</option>';
					$('#spFlavour').html(html);
				    $("#spFlavour").trigger("chosen:updated");

				});
			});
});
</script>
<script type="text/javascript">
$(document).ready(function() { 
	$('#spFlavour').change(
			function() {
				$.getJSON('${findAddOnRate}', {
					spfId : $(this).val(),
					ajax : 'true'
				}, function(data) {
					 $('#rate').empty();	
					 $("#dbAdonRate").val(data.spfAdonRate);
					$("#rate").html(data.spfAdonRate);
				
					document.getElementById("sp_add_rate").setAttribute('value',data.spfAdonRate);
				
					
					var wt = $('#spwt').find(":selected").text();
					
					var flavourAdonRate =data.spfAdonRate;
					
					var tax3 = parseFloat($("#tax3").val());
					var tax1 = parseFloat($("#tax1").val());
					var tax2 = parseFloat($("#tax2").val());
					var sp_ex_charges= parseFloat($("#sp_ex_charges").val());
					//alert("sp_ex_charges"+sp_ex_charges);
					var sp_disc=parseFloat($("#sp_disc").val());
					//alert("sp_disc"+sp_disc);
					var price = $("#dbPrice").val();
				
					var totalFlavourAddonRate= wt*flavourAdonRate;
					var billBy=${billBy};
					//alert("Bill by " +billBy);
					
					if(billBy==1){
						totalFlavourAddonRate= wt*(flavourAdonRate*0.8);
					}	totalFlavourAddonRate.toFixed(2);
					//alert("spFlavour .chnge " +totalFlavourAddonRate)
					
					//totalFlavourAddonRate.toFixed(2);

					 var totalCakeRate= wt*price;
					 var totalAmount=parseFloat(totalCakeRate+totalFlavourAddonRate)+sp_ex_charges;
					 var disc_amt=(totalAmount*sp_disc)/100;
					 totalAmount=totalAmount-disc_amt;
					 
					 var mrpBaseRate=parseFloat((totalAmount*100)/(tax3+100));
				    /*  var gstInRs=parseFloat((mrpBaseRate*tax3)/100);
				     
				        var taxPerPerc1=parseFloat((tax1*100)/tax3);
						var taxPerPerc2=parseFloat((tax2*100)/tax3);
			         
						var tax1Amt=parseFloat((gstInRs*taxPerPerc1)/100);
						var tax2Amt=parseFloat((gstInRs*taxPerPerc2)/100); */
						var gstInRs=0;
						var taxPerPerc1=0;
						var taxPerPerc2=0;
						var tax1Amt=0;
						var tax2Amt=0;
						if(tax3==0)
							{
							    gstInRs=0;
							
							}
					    else
						{
						   gstInRs=(mrpBaseRate*tax3)/100;
							
						   if(tax1==0)
							{
							   taxPerPerc1=0;
							}
						   else
							{
							    taxPerPerc1=parseFloat((tax1*100)/tax3);
							    tax1Amt=parseFloat((gstInRs*taxPerPerc1)/100);

							}
						   if(tax2==0)
							{
							   taxPerPerc2=0;
							}
						   else
							{
								taxPerPerc2=parseFloat((tax2*100)/tax3);
								tax2Amt=parseFloat((gstInRs*taxPerPerc2)/100);

							}
						}
						
					  var grandTotal=parseFloat(totalCakeRate+totalFlavourAddonRate);
					  
					    $('#price').html(totalCakeRate);$('#sp_calc_price').html(totalCakeRate);
						$('#rate').html(totalFlavourAddonRate);$('#sp_add_rate').html(totalFlavourAddonRate);
						document.getElementById("sp_add_rate").setAttribute('value',totalFlavourAddonRate);
						$('#subtotal').html(totalAmount);
						
						document.getElementById("sp_sub_total").setAttribute('value',totalAmount);
						$('#INR').html('INR-'+totalAmount);
						document.getElementById("sp_grand").setAttribute('value',totalAmount);
						$('#tot').html('TOTAL-'+totalAmount);
						document.getElementById("total_amt").setAttribute('value',totalAmount);
						//$('#rmAmt').html(grandTotal);
						//document.getElementById("rm_amount").setAttribute('value',totalAmount);
						
						document.getElementById("t1amt").setAttribute('value',tax1Amt.toFixed(2));
						
						document.getElementById("t2amt").setAttribute('value',tax2Amt.toFixed(2));
						
						$('#gstrs').html(gstInRs.toFixed(2)); 
						document.getElementById("gst_rs").setAttribute('value',gstInRs.toFixed(2));
						$('#mgstamt').html('AMT-'+mrpBaseRate.toFixed(2)); 
						document.getElementById("m_gst_amt").setAttribute('value',mrpBaseRate.toFixed(2));
						
				});
			});
});
</script>

<script type="text/javascript">
		function onChange(dbRate) {
			//alert("db Rate "+dbRate);
			var wt = $('#spwt').find(":selected").text();
			
			var flavourAdonRate =$("#dbAdonRate").val();
			//alert(flavourAdonRate);
			
			
			var tax3 = parseFloat($("#tax3").val());
			var tax1 = parseFloat($("#tax1").val());
			var tax2 = parseFloat($("#tax2").val());
			//alert("tax1:"+tax1+"tax2"+tax2+"tax3"+tax3);
			var sp_ex_charges= parseFloat($("#sp_ex_charges").val());
			var sp_disc=parseFloat($("#sp_disc").val());
			//document.getElementById("adv").value=0;

			var totalCakeRate = wt*dbRate;
		//	var totalFlavourAddonRate;//= wt*flavourAdonRate;
			
			var billBy=${billBy};
			//alert("Bill by " +billBy);
			var totalFlavourAddonRate = wt*flavourAdonRate;
			//alert("totalFlavourAddonRate by " +totalFlavourAddonRate);
			if(billBy==1){
				totalFlavourAddonRate= wt*(flavourAdonRate*0.8);
				//alert("totalFlavourAddonRate in if by =1 " +totalFlavourAddonRate);
			}	
			//alert("spFlavour .chnge " +totalFlavourAddonRate)
			totalFlavourAddonRate.toFixed(2);
		    var add=parseFloat(totalCakeRate+totalFlavourAddonRate);
		    var grandTotal=parseFloat(add);
			var spSubtotal=add+sp_ex_charges;
			
			var mrpBaseRate=parseFloat((spSubtotal*100)/(tax3+100));
			
			var gstInRs=0;
			var taxPerPerc1=0;
			var taxPerPerc2=0;
			var tax1Amt=0;
			var tax2Amt=0;
			if(tax3==0)
				{
				    gstInRs=0;
				
				}
		    else
			{
			   gstInRs=(mrpBaseRate*tax3)/100;
				
			   if(tax1==0)
				{
				   taxPerPerc1=0;
				}
			   else
				{
				    taxPerPerc1=parseFloat((tax1*100)/tax3);
				    tax1Amt=parseFloat((gstInRs*taxPerPerc1)/100);

				}
			   if(tax2==0)
				{
				   taxPerPerc2=0;
				}
			   else
				{
					taxPerPerc2=parseFloat((tax2*100)/tax3);
					tax2Amt=parseFloat((gstInRs*taxPerPerc2)/100);

				}
			}
			
         

			$('#gstrs').html(gstInRs.toFixed(2));  
			document.getElementById("gst_rs").setAttribute('value',gstInRs.toFixed(2));

			var mGstAmt=mrpBaseRate;
			$('#mgstamt').html('AMT-'+mGstAmt.toFixed(2)); 
			document.getElementById("m_gst_amt").setAttribute('value',mGstAmt.toFixed(2));
			
		//alert("x" +x);
			$('#price').html(wt*dbRate);
			$('sp_calc_price').html(wt*dbRate);
			//$('#rate').html(wt*flavourAdonRate);	
			//document.getElementById("sp_add_rate").setAttribute('value',wt*flavourAdonRate);
			
			$('#rate').html(totalFlavourAddonRate);$('#sp_add_rate').html(totalFlavourAddonRate);
			document.getElementById("sp_add_rate").setAttribute('value',totalFlavourAddonRate);
			$('#subtotal').html(spSubtotal);	
			document.getElementById("sp_sub_total").setAttribute('value',spSubtotal);
			
			$('#INR').html('INR-'+spSubtotal);
			document.getElementById("sp_grand").setAttribute('value',spSubtotal);
			$('#tot').html('TOTAL-'+grandTotal);
			document.getElementById("total_amt").setAttribute('value',spSubtotal);
			//$('#rmAmt').html(spSubtotal);
		//	document.getElementById("rm_amount").setAttribute('value',spSubtotal);
			
			document.getElementById("t1amt").setAttribute('value',tax1Amt.toFixed(2));
			
			document.getElementById("t2amt").setAttribute('value',tax2Amt.toFixed(2));
			
	}</script> 

	<script type="text/javascript">
		$(document)
				.ready(
						function() { // if all label selected set all items selected

							$('#fr_id')
									.change(
											function() {
												var selected = $('#fr_id')
														.val();

												if (selected == -1) {
													$
															.getJSON(
																	'${setAllFrIdSelected}',
																	{
																		//	selected : selected,
																		ajax : 'true'
																	},
																	function(
																			data) {
																		var html = '<option value="">Select Franchise</option>';

																		var len = data.length;

																		$(
																				'#fr_id')
																				.find(
																						'option')
																				.remove()
																				.end()
																		$(
																				"#fr_id")
																				.append(
																						$(
																								"<option></option>")
																								.attr(
																										"value",
																										-1)
																								.text(
																										"ALL"));

																		for (var i = 0; i < len; i++) {

																			$(
																					"#fr_id")
																					.append(
																							$(
																									"<option selected></option>")
																									.attr(
																											"value",
																											data[i].frId)
																									.text(
																											data[i].frName));
																		}

																		$(
																				"#fr_id")
																				.trigger(
																						"chosen:updated");
																	});
												}
											});
						});
	</script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() { // if all label selected set all items selected

							$('#menu')
									.change(
											function() {
												var selected = $('#menu').val();

												if (selected == -1) {
													$
															.getJSON(
																	'${setAllMenuSelected}',
																	{
																		//	selected : selected,
																		ajax : 'true'
																	},
																	function(
																			data) {
																		var html = '<option value="">Select Menus</option>';

																		var len = data.length;

																		$(
																				'#menu')
																				.find(
																						'option')
																				.remove()
																				.end()
																		$(
																				"#menu")
																				.append(
																						$(
																								"<option></option>")
																								.attr(
																										"value",
																										-1)
																								.text(
																										"ALL"));

																		for (var i = 0; i < len; i++) {

																			$(
																					"#menu")
																					.append(
																							$(
																									"<option selected></option>")
																									.attr(
																											"value",
																											data[i].settingId)
																									.text(
																											data[i].menuTitle));
																		}

																		$(
																				"#menu")
																				.trigger(
																						"chosen:updated");
																	});
												}
											});
						});
	</script>
	
<script>

function chChange() {
	var wt = $('#spwt').find(":selected").text();
	var flavourAdonRate =$("#dbAdonRate").val();
	var tax3 = parseFloat($("#tax3").val());
	var tax1 = parseFloat($("#tax1").val());
	var tax2 = parseFloat($("#tax2").val());
	//document.getElementById("adv").value=0;
	var sp_ex_charges= parseFloat($("#sp_ex_charges").val());
	var sp_disc=parseFloat($("#sp_disc").val());
	//alert("sp_disc"+sp_disc);
	var dbRate = $("#dbPrice").val();//dbRate
	//alert("tax1:"+tax1+"tax2"+tax2+"tax3"+tax3);
	var billBy=${billBy};
	
	var totalCakeRate = wt*dbRate;
	var totalFlavourAddonRate = wt*flavourAdonRate;
	if(billBy==1){
		totalFlavourAddonRate= wt*(flavourAdonRate*0.8);
		//alert("totalFlavourAddonRate in if by =1 " +totalFlavourAddonRate);
	}	
    var add=parseFloat(totalCakeRate+totalFlavourAddonRate);
    var grandTotal=parseFloat(add);
    //alert("without sp_ex_charges"+add);
	var spSubtotal=add+sp_ex_charges;
	//alert("with sp_ex_charges"+spSubtotal);
	//document.getElementById("adv").value=0;
	
	var disc_amt=(spSubtotal*sp_disc)/100;
	//alert("disc_amt"+disc_amt);
	
	spSubtotal=spSubtotal-disc_amt;
	
	
	//alert("final "+spSubtotal);
	
	
	var mrpBaseRate=parseFloat((spSubtotal*100)/(tax3+100));
	
	var gstInRs=0;
	var taxPerPerc1=0;
	var taxPerPerc2=0;
	var tax1Amt=0;
	var tax2Amt=0;
	if(tax3==0)
		{
		    gstInRs=0;
		
		}
    else
	{
	   gstInRs=(mrpBaseRate*tax3)/100;
		
	   if(tax1==0)
		{
		   taxPerPerc1=0;
		}
	   else
		{
		    taxPerPerc1=parseFloat((tax1*100)/tax3);
		    tax1Amt=parseFloat((gstInRs*taxPerPerc1)/100);

		}
	   if(tax2==0)
		{
		   taxPerPerc2=0;
		}
	   else
		{
			taxPerPerc2=parseFloat((tax2*100)/tax3);
			tax2Amt=parseFloat((gstInRs*taxPerPerc2)/100);

		}
	}
	
 

	$('#gstrs').html(gstInRs.toFixed(2));  document.getElementById("gst_rs").setAttribute('value',gstInRs.toFixed(2));

	var mGstAmt=mrpBaseRate;
	$('#mgstamt').html('AMT-'+mGstAmt.toFixed(2));  document.getElementById("m_gst_amt").setAttribute('value',mGstAmt.toFixed(2));
	
	$('#price').html(wt*dbRate);
	document.getElementById("sp_calc_price").value=wt*dbRate;
	$('#rate').html(wt*flavourAdonRate);	
	document.getElementById("sp_add_rate").setAttribute('value',wt*flavourAdonRate);
	//$('#subtotal').html(grandTotal);	
	
	$('#subtotal').html(spSubtotal);	
	/* document.getElementById("sp_sub_total").setAttribute('value',add); */
	document.getElementById("sp_sub_total").setAttribute('value',spSubtotal);
	
	$('#INR').html('INR-'+spSubtotal);
	document.getElementById("sp_grand").setAttribute('value',spSubtotal);
	$('#tot').html('TOTAL-'+spSubtotal);
	document.getElementById("total_amt").setAttribute('value',spSubtotal);
	//$('#rmAmt').html(spSubtotal);
	//document.getElementById("rm_amount").setAttribute('value',spSubtotal);
	
	document.getElementById("t1amt").setAttribute('value',tax1Amt.toFixed(2));
	
	document.getElementById("t2amt").setAttribute('value',tax2Amt.toFixed(2));
	
}


</script>
	
	<script>
function showDiv(elem){
   if(elem.value == 1)
	   {
         document.getElementById('marathiDiv').style.display= "block";
         document.getElementById('englishDiv').style="display:none";
	   }
   else if(elem.value == 2)
   {
	   document.getElementById('englishDiv').style.display = "block";
	   document.getElementById('marathiDiv').style="display:none";
   }
 
}
</script>

<script type="text/javascript">
function showCtype(){
var temp=document.getElementById('temp').value;
	if(temp==0)
		{
		document.getElementById('cktype').innerHTML = 'Alphabetical';

		}else if(temp==1)
		{
			document.getElementById('cktype').innerHTML = 'Numerical';
		}else
	if (temp == 2 ) {  ///regular
		document.getElementById("ctype1").style = "display:none" //hide numeric
	}
	
}

</script>
<!------------------------------BLANK VALIDATION FOR SPCODE------------------------------------------>	
	
<script type="text/javascript">
function validateForm() {
    var spCode = document.forms["form"]["sp_code"].value;
    if (spCode == "") {
        alert("Special Cake Code must be filled out");
        document.getElementById('sp_code').focus();
        return false;
    }
}
</script>	
<!-------------------------------------------ALL VALIDATIONS----------------------------------------->	
 <script type="text/javascript">
function validate() {
	
	 var phoneNo = /^\d{10}$/;  

	
    var eventName,spId,spCustName,spPlace,spCustMob,spType,spFlavour,spCode,spWt;
    eventName = document.getElementById("event_name").value;
    spPlace = document.getElementById("sp_place").value;
    spCustName=document.getElementById("sp_cust_name").value;
    spCustMob=document.getElementById("sp_cust_mobile_no").value; 
    spType=document.getElementById("sptype").value; 
    spFlavour=document.getElementById("spFlavour").value;
    spCode=document.getElementById("sp_code").value;
    spWt=document.getElementById("spwt").value;
    var isValid=true;
    
    if (spCode == "") {
        alert("Special Cake Code must be filled out");
      
        isValid= false;
    }else 
    if (spType == "") {
        alert("Please Select Special Cake Type");
      
        isValid= false;
    }else  if (spWt == "") {
        alert("Please Select Special Cake Weight");
      
        isValid= false;
    }else if (spFlavour == "") {
        alert("Please Select Flavour");
  
        isValid=false;
    }else  if (eventName == "") {
        alert("Please Enter Message");
        document.getElementById('event_name').focus();
        
        isValid=false;
    }else if (spPlace == "") {
        alert("Please Enter Place of delivery");
        document.getElementById('sp_place').focus();

        isValid= false;
    }else if (spCustName == "") {
        alert("Please Enter Customer Name");
        document.getElementById('sp_cust_name').focus();

        isValid= false;
    }else  if(spCustMob.match(phoneNo))  
	  {  
	      return true;  
	  }  
	  else  
	  {  
	     alert("Not a valid Mobile Number");  
	     document.getElementById('sp_cust_mobile_no').value="";
	     document.getElementById('sp_cust_mobile_no').focus();
	     return false;  
	  }  

    
    return isValid;
 
}
</script> 
</body>
</html>