<%@page
	import="org.apache.taglibs.standard.tag.common.core.ForEachSupport"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Dashboard - MONGINIS Admin</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

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
</head> --%>
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	<c:url var="findEventList" value="/findEventList" />
<c:url var="getFlavoursByType" value="/getFlavoursByType" />
<body onload="calTotalGstOnLoad()">

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include> 



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
			<!-- <div class="page-title">
				<div>
					<h1>
						<i class="fa fa-file-o"></i>Special Cake
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
										<i class="fa fa-bars"></i> Edit Special Cake
									</h3>
                                   <div class="box-tool">
								<a href="${pageContext.request.contextPath}/showSpecialCake">Back to List</a> <a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
							    </div>
								</div>
								<div class="box-content">
									<form action="updateSpCakeProcess" class="form-horizontal" id="validation-form"
										enctype="multipart/form-data" method="post">

<input type="hidden" name="suppId" id="suppId" value="${spCkSupp.id}" />


										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Code</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="spc_code" id="spc_code"
													placeholder="Code" class="form-control"
													value="${specialCake.spCode}" data-rule-required="true"
													 />
											</div>
										</div>

											<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Name </label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="spc_name" id="spc_name"
												value="${specialCake.spName}" 
													class="form-control" data-rule-required="true"/>
											</div> 
											
										</div>
												<div> <input type="hidden" name="prevImage" value="${specialCake.spImage}"></div>

										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Image</label>
											<div class="col-sm-9 col-lg-10 controls">
												<div class="fileupload fileupload-new"
													data-provides="fileupload">
													<div class="fileupload-new img-thumbnail"
														style="width: 200px; height: 150px;">
														 <img src="${url}${specialCake.spImage}" width="150" height="100"  onerror="this.src='${pageContext.request.contextPath}/resources/img/No_Image_Available.jpg';"/> 
													</div>
													<div
														class="fileupload-preview fileupload-exists img-thumbnail"
														style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
													<div>
														<span class="btn btn-default btn-file"><span
															class="fileupload-new">Select image</span> <span
															class="fileupload-exists">Change</span> <input
															type="file" class="file-input" name="sp_image"
															id="sp_image" value="${specialCake.spImage }" /></span> <a
															href="#" class="btn btn-default fileupload-exists"
															data-dismiss="fileupload">Remove</a>
													</div>
												</div>

											</div>
										</div>
                                        <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Description</label>
											<div class="col-sm-9 col-lg-10 controls">
												<textarea class="form-control" name="sp_desc"
													cols="" rows="" id="sp_desc" placeholder="Description"
													data-rule-required="true"
													 ><c:out value="${specialCake.spDesc}"/></textarea>

											</div>

										</div>
		<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">HSN Code</label>
									<div class="col-sm-9 col-lg-10 controls">
										<input type="text" name="spck_hsncd" id="spck_hsncd"
											placeholder="HSN Code" class="form-control"
											data-rule-required="true" value="${spCkSupp.spHsncd}" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">UOM</label>
									<div class="col-sm-9 col-lg-10 controls">
										<select name="spck_uom" id="spck_uom" class="form-control"
											placeholder="Special Cake UOM" data-rule-required="true"
											onchange="uomChanged()">
											<option value="">Select Special Cake UOM</option>
											<c:forEach items="${rmUomList}" var="rmUomList"
												varStatus="count">
												<c:choose>
													<c:when test="${rmUomList.uomId==spCkSupp.uomId}">
														<option value="${rmUomList.uomId}" selected><c:out value="${rmUomList.uom}"/></option>
													</c:when>
													<c:otherwise>
														<option value="${rmUomList.uomId}"><c:out value="${rmUomList.uom}"/></option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>
								<input type="hidden" name="sp_uom_name" id="sp_uom_name"
									value="${spCkSupp.spUom}" />
							

								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">Cut
										Section</label>
									<div class="col-sm-9 col-lg-10 controls">
										<select name="cut_section" id="cut_section"
											class="form-control" data-rule-required="true">
											<option value="">Select Cut Section</option>

											<c:choose>
												<c:when test="${spCkSupp.cutSection==0}">
													<option value="0" selected>Not Applicable</option>
													<option value="1">Single Cut</option>
													<option value="2">Double Cut</option>
												</c:when>
												<c:when test="${spCkSupp.cutSection==1}">
													<option value="0">Not Applicable</option>
													<option value="1" selected>Single Cut</option>
													<option value="2">Double Cut</option>
												</c:when>
												<c:when test="${spCkSupp.cutSection==2}">
													<option value="0">Not Applicable</option>
													<option value="1">Single Cut</option>
													<option value="2" selected>Double Cut</option>
												</c:when>
												<c:otherwise>
													<option value="0">Not Applicable</option>
													<option value="1">Single Cut</option>
													<option value="2">Double Cut</option>
												</c:otherwise>
											</c:choose>
										</select>
									</div>
								</div>
										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Type</label>
											<div class="col-sm-9 col-lg-10 controls">
											
											<select class="form-control input-sm" name="spc_type"
													 id="spc_type" required>
													 
													
													
												<c:choose>
												<c:when test="${specialCake.spType==0}">
												    <option value="1">Chocolate</option>
													<option value="2">FC</option>
													<option value="3">BC</option>
													<option value="4">Chocolate+FC</option>
													<option value="5">Chocolate+BC</option>
													<option value="6">FC+BC</option>
													<option value="0" selected>All</option>
												</c:when>
													<c:when test="${specialCake.spType==1}">
												
												<option value="1" selected>Chocolate</option>
													<option value="2">FC</option>
													<option value="3">BC</option>
													<option value="4">Chocolate+FC</option>
													<option value="5">Chocolate+BC</option>
													<option value="6">FC+BC</option>
													<option value="0" >All</option>
												</c:when>
													<c:when test="${specialCake.spType==2}">
												<option value="1" >Chocolate</option>
													<option value="2" selected>FC</option>
													<option value="3">BC</option>
													<option value="4">Chocolate+FC</option>
													<option value="5">Chocolate+BC</option>
													<option value="6">FC+BC</option>
													<option value="0" >All</option>
												</c:when>
													<c:when test="${specialCake.spType==3}">
												
												<option value="1" >Chocolate</option>
													<option value="2" >FC</option>
													<option value="3" selected>BC</option>
													<option value="4">Chocolate+FC</option>
													<option value="5">Chocolate+BC</option>
													<option value="6">FC+BC</option>
													<option value="0" >All</option>
												</c:when>
													<c:when test="${specialCake.spType==4}">
												
												<option value="1" >Chocolate</option>
													<option value="2" >FC</option>
													<option value="3" >BC</option>
													<option value="4" selected>Chocolate+FC</option>
													<option value="5">Chocolate+BC</option>
													<option value="6">FC+BC</option>
													<option value="0" >All</option>
												</c:when>
													<c:when test="${specialCake.spType==5}">
												
												<option value="1" >Chocolate</option>
													<option value="2" >FC</option>
													<option value="3" >BC</option>
													<option value="4" >Chocolate+FC</option>
													<option value="5" selected>Chocolate+BC</option>
													<option value="6">FC+BC</option>
													<option value="0" >All</option>
												</c:when>
													<c:when test="${specialCake.spType==6}">
												
											<option value="1" >Chocolate</option>
													<option value="2" >FC</option>
													<option value="3" >BC</option>
													<option value="4" >Chocolate+FC</option>
													<option value="5" >Chocolate+BC</option>
													<option value="6"selected>FC+BC</option>
													<option value="0" >All</option>
												</c:when>
											<c:otherwise>
												
												</c:otherwise>
												
												</c:choose>
												</select>
													
											</div>
										</div>


										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Min
												Weight</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="min_weight" id="min_weight"
													value="${specialCake.spMinwt }" placeholder="Min Weight"
													class="form-control" data-rule-number="true"  data-rule-required="true"/>
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Max
												Weight</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="max_weight" id="max_weight"
													value="${specialCake.spMaxwt }" placeholder="Max Weight"
													class="form-control" data-rule-number="true" data-rule-required="true" />
											</div>
										</div>


										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Book
												Before</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="book_before"
													value="${specialCake.spBookb4 }" id="book_before"
													placeholder="Book Before" class="form-control"
													data-rule-number="true"  data-rule-required="true" /> <input type="hidden"
													name="spId" value="${specialCake.spId}">
											</div>
										</div>
<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Weight Increment By
											</label>
											<div class="col-sm-9 col-lg-10 controls">
										<select class="form-control input-sm" name="sp_rate2" id="sp_rate2" data-rule-required="true">
													<option value="">Select Weight Increment By</option>
													<c:choose>
													<c:when test="${specialCake.spRate2==0.5}">
													<option value="0.5" selected>0.5</option>
													<option value="1">1</option>
													<option value="1.5">1.5</option>
													<option value="2">2</option>
													<option value="2.5">2.5</option>
													<option value="3">3</option>
													<option value="3.5">3.5</option>
													<option value="4">4</option>
													<option value="4.5">4.5</option>
													<option value="5">5</option>
													
													</c:when>
													<c:when test="${specialCake.spRate2==1}">
													<option value="0.5" >0.5</option>
													<option value="1" selected>1</option>
													<option value="1.5">1.5</option>
													<option value="2">2</option>
													<option value="2.5">2.5</option>
													<option value="3">3</option>
													<option value="3.5">3.5</option>
													<option value="4">4</option>
													<option value="4.5">4.5</option>
													<option value="5">5</option>
													
													</c:when>
													<c:when test="${specialCake.spRate2==1.5}">
													<option value="0.5" >0.5</option>
													<option value="1" >1</option>
													<option value="1.5" selected>1.5</option>
													<option value="2">2</option>
													<option value="2.5">2.5</option>
													<option value="3">3</option>
													<option value="3.5">3.5</option>
													<option value="4">4</option>
													<option value="4.5">4.5</option>
													<option value="5">5</option>
													
													</c:when>
													<c:when test="${specialCake.spRate2==2.0}">
													<option value="0.5" >0.5</option>
													<option value="1" >1</option>
													<option value="1.5" >1.5</option>
													<option value="2" selected>2</option>
													<option value="2.5">2.5</option>
													<option value="3">3</option>
													<option value="3.5">3.5</option>
													<option value="4">4</option>
													<option value="4.5">4.5</option>
													<option value="5">5</option>
													
													</c:when>
													<c:when test="${specialCake.spRate2==2.5}">
													<option value="0.5" >0.5</option>
													<option value="1" >1</option>
													<option value="1.5" >1.5</option>
													<option value="2" >2</option>
													<option value="2.5" selected>2.5</option>
													<option value="3">3</option>
													<option value="3.5">3.5</option>
													<option value="4">4</option>
													<option value="4.5">4.5</option>
													<option value="5">5</option>
													
													</c:when>
													<c:when test="${specialCake.spRate2==3.0}">
													<option value="0.5" >0.5</option>
													<option value="1" >1</option>
													<option value="1.5" >1.5</option>
													<option value="2" >2</option>
													<option value="2.5" >2.5</option>
													<option value="3" selected>3</option>
													<option value="3.5">3.5</option>
													<option value="4">4</option>
													<option value="4.5">4.5</option>
													<option value="5">5</option>
													
													</c:when>
													<c:when test="${specialCake.spRate2==3.5}">
													<option value="0.5" >0.5</option>
													<option value="1" >1</option>
													<option value="1.5" >1.5</option>
													<option value="2" >2</option>
													<option value="2.5" >2.5</option>
													<option value="3" >3</option>
													<option value="3.5" selected>3.5</option>
													<option value="4">4</option>
													<option value="4.5">4.5</option>
													<option value="5">5</option>
													
													</c:when>
													<c:when test="${specialCake.spRate2==4.0}">
													<option value="0.5" >0.5</option>
													<option value="1" >1</option>
													<option value="1.5" >1.5</option>
													<option value="2" >2</option>
													<option value="2.5" >2.5</option>
													<option value="3" >3</option>
													<option value="3.5" >3.5</option>
													<option value="4" selected>4</option>
													<option value="4.5" >4.5</option>
													<option value="5">5</option>
													
													</c:when>
													<c:when test="${specialCake.spRate2==4.5}">
													<option value="0.5" >0.5</option>
													<option value="1" >1</option>
													<option value="1.5" >1.5</option>
													<option value="2" >2</option>
													<option value="2.5" >2.5</option>
													<option value="3" >3</option>
													<option value="3.5" >3.5</option>
													<option value="4">4</option>
													<option value="4.5" selected>4.5</option>
													<option value="5">5</option>
													
													</c:when>
													<c:when test="${specialCake.spRate2==5.0}">
													<option value="0.5" >0.5</option>
													<option value="1" >1</option>
													<option value="1.5" >1.5</option>
													<option value="2" >2</option>
													<option value="2.5" >2.5</option>
													<option value="3" >3</option>
													<option value="3.5" >3.5</option>
													<option value="4">4</option>
													<option value="4.5" >4.5</option>
													<option value="5" selected>5</option>
													
													</c:when>
													<c:otherwise>
													<option value="0.5" >0.5</option>
													<option value="1" >1</option>
													<option value="1.5" >1.5</option>
													<option value="2" >2</option>
													<option value="2.5" >2.5</option>
													<option value="3" >3</option>
													<option value="3.5" >3.5</option>
													<option value="4">4</option>
													<option value="4.5" >4.5</option>
													<option value="5" >5</option>
													
													</c:otherwise>
													</c:choose>
												
												</select>
												</div>
										</div>
										
					
										  <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">MRP</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="mrp_rate1" id="mrp_rate1" onchange="calMrp()"
													 placeholder="MRP Rate 1" class="form-control"
													data-rule-number="true"  data-rule-required="true" value="${specialCake.mrpRate1}"/>
											</div>
										</div>
										<input type="hidden" name="mrp_rate2" id="mrp_rate2" value="${specialCake.mrpRate2}"/>
										<%-- <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">OutStation MRP Rate
											</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="mrp_rate2" id="mrp_rate2"
													 placeholder="MRP Rate 2" class="form-control"
													data-rule-number="true"  data-rule-required="true" value="${specialCake.mrpRate2}"/>
											</div>
										</div> --%>
										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Special MRP
											</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="mrp_rate3" id="mrp_rate3"
									                placeholder="MRP Rate 3" class="form-control" onchange="calMrp()"
													data-rule-number="true"  data-rule-required="true" value="${specialCake.mrpRate3}"/>
											</div>
										</div>
								<fmt:formatNumber var="marginPer"
  value="${(specialCake.mrpRate1-specialCake.spRate1)/(specialCake.mrpRate1/100)}"
  maxFractionDigits="0" />
											 <div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">Margin %</label>
									<div class="col-sm-9 col-lg-10 controls">
										<input type="text" name="margin" id="margin"
											placeholder="Enter Margin %" class="form-control"
											data-rule-required="true" data-rule-number="true" value="${marginPer}" onchange="calMrp()"/>
									</div>
								</div>
 <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Rate
											</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="sp_rate1" id="sp_rate1" 
													 placeholder="Special Cake Rate 1" class="form-control"
													data-rule-number="true" data-rule-required="true" value="${specialCake.spRate1}" />
											</div>
										</div>
										
										<%-- <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Sp OutStation Rate
											</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="sp_rate2" id="sp_rate2"
													 placeholder="Special Cake Rate 2" class="form-control" onchange="calMrp()"
													data-rule-number="true"  data-rule-required="true" value="${specialCake.spRate2}"/>
											</div>
										</div> --%>
										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Special Rate
											</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="sp_rate3" id="sp_rate3"
									                placeholder="Special Cake Rate 3" class="form-control" 
													data-rule-number="true"  data-rule-required="true" value="${specialCake.spRate3}"/>
											</div>
										</div>
                                      <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Order Qty
											</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="order_qty" id="order_qty"
												value="${specialCake.orderQty}"
											        placeholder="Order Quantity" class="form-control"
													data-rule-required="true" data-rule-number="true" />
											</div>
										</div>
                                       <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Order Discount %
											</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="order_disc" id="order_disc"
												 value="${specialCake.orderDiscount}"
											        placeholder="Order Discount" class="form-control"
													data-rule-required="true" data-rule-number="true"/>
											</div>
										</div>
                                       <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">IGST %
											</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="tax_3" id="tax_3"
													value="${specialCake.spTax3}" placeholder="IGST"
													class="form-control"  data-rule-required="true"  data-rule-number="true" onchange="calTotalGst()"/>
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">CGST %
											</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="tax_1"
													value="${specialCake.spTax1 }" id="tax_1"
													placeholder="CGST" class="form-control"
													data-rule-required="true" data-rule-number="true"  onchange="calTotalGst()"/>
											</div>
										</div>
										
                                       <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">SGST %
											</label>
											<div class="col-sm-9 col-lg-10 controls">
												<input type="text" name="tax_2" id="tax_2"
													value="${specialCake.spTax2}" placeholder="SGST"
													class="form-control" data-rule-required="true" data-rule-number="true" onchange="calTotalGst()"/>
											</div>
										</div>
                                    <div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">Cess(%)</label>
									<div class="col-sm-9 col-lg-10 controls">
										<input type="text" name="sp_cess" id="sp_cess"
											placeholder="Cess %" class="form-control"
											data-rule-required="true" data-rule-number="true"
											value="${spCkSupp.spCess}" />
									</div>
								</div>
                                 <div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">Total GST Applicable %</label>
									<div class="col-sm-9 col-lg-10 controls">
										<input type="text" name="total_gst_appli" id="total_gst_appli"
											placeholder="Total GST Applicable" class="form-control"
											data-rule-required="true" data-rule-number="true" disabled/>
									</div>
								</div>


										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Events</label>
											<div class="col-sm-9 col-lg-10 controls">
												<select data-placeholder="Select Events"
													class="form-control chosen" multiple="multiple"
													tabindex="6" name="spe_id_list[]" id="spe_id_list"data-rule-required="true" onchange="eventChange()">
													<option value="0" >All</option>

														<c:forEach items="${speEventNameId}" var="eventName">

															<option selected value="${eventName.id}">${eventName.name}</option>
														</c:forEach>
														<c:forEach items="${eventList}" var="eventList">

															<option value="${eventList.speId}">${eventList.speName}</option>
														</c:forEach>

												</select>
											</div>
										</div>
			
										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Flavours </label>
											<div class="col-sm-9 col-lg-10 controls">
												   <select data-placeholder="Select Flavours" name="erplinkcode"
													class="form-control chosen" tabindex="-1" id="erplinkcode" multiple="multiple"
													>
                                                <c:forEach items="${flavoursListSelected}" var="flavoursListSelected">

															<option value="${flavoursListSelected.spfId}" selected>${flavoursListSelected.spfName}</option>
												</c:forEach>
												<c:forEach items="${flavoursListNotSelected}" var="flavoursListNotSelected">

															<option value="${flavoursListNotSelected.spfId}">${flavoursListNotSelected.spfName}</option>
												</c:forEach>		
												</select>
											</div>
										</div>

                                      <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Is Customer Choice Cake?</label>
											<div class="col-sm-9 col-lg-10 controls">
												<c:choose>
													<c:when test="${strIsCustChoiceCk.equals('1')}">	
												
												
												
												<label class="radio-inline">
												<input type="radio"
													name="is_cust_choice_ck" id="is_cust_choice_ck" value="0"
													>No
												</label> <label class="radio-inline"> <input type="radio"
													name="is_cust_choice_ck" id="is_cust_choice_ck" value="1" checked="checked">
													Yes
												</label>
												
													</c:when>
													<c:otherwise>
														
												
												
												<label class="radio-inline"> 
												<input type="radio"
													name="is_cust_choice_ck" id="is_cust_choice_ck" value="0"checked="checked"
													>No
												</label> <label class="radio-inline"> <input type="radio"
													name="is_cust_choice_ck" id="is_cust_choice_ck" value="1">
													Yes
												</label>
															
													</c:otherwise>

												</c:choose>						
																									
													
											</div>
										</div>
                                       <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Is Addon Rate Appli?</label>
											<div class="col-sm-9 col-lg-10 controls">
											<c:choose>
													<c:when test="${strIsAddonRateAppli.equals('1')}">	
												
											
											
												<label class="radio-inline"> <input type="radio"
													name="is_addon_rate_appli" id="is_addon_rate_appli" value="0"
													>No
												</label> <label class="radio-inline"> <input type="radio"
													name="is_addon_rate_appli" id="is_addon_rate_appli" value="1" checked="checked">
													Yes
												</label>
												
												</c:when>
													<c:otherwise>
													
												<label class="radio-inline"> <input type="radio"
													name="is_addon_rate_appli" id="is_addon_rate_appli" value="0"
													checked="checked">No
												</label> <label class="radio-inline"> <input type="radio"
													name="is_addon_rate_appli" id="is_addon_rate_appli" value="1">
													Yes
												</label>
													
												</c:otherwise>

												</c:choose>
												
											</div>
										</div>
										
										<%-- <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Type 2
												Applicable ?</label>
											<div class="col-sm-9 col-lg-10 controls">
											
												<c:choose>
													<c:when test="${strTimeTwoappli.equals('1')}">

													

														<label class="radio-inline"> <input type="radio"
															name="type_2_applicable" id="type_2_applicable" 
															value="0" /> No
														</label>
															<label class="radio-inline"> <input type="radio"
															name="type_2_applicable" id="type_2_applicable" value="1"checked="checked" />
															Yes
														</label>
														

													</c:when>
													<c:otherwise>
														
														<label class="radio-inline"> <input type="radio"
															name="type_2_applicable" id="type_2_applicable" value="0" checked="checked"/> No
														</label>
														<label class="radio-inline"> <input type="radio"
															name="type_2_applicable" id="type_2_applicable" 
															value="1" /> Yes
														</label>
													</c:otherwise>

												</c:choose>

											</div>
										</div> --%>
								 <input type="hidden"	name="type_2_applicable" id="type_2_applicable" value="1" />
										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Is Used ?</label>
											<div class="col-sm-9 col-lg-10 controls">
												
												<c:choose>
													<c:when test="${strIsUsed.equals('1')}">

													

														<label class="radio-inline"> <input type="radio"
															name="is_used" id="is_used" 
															value="0" /> No
														</label>
															<label class="radio-inline"> <input type="radio"
															name="is_used" id="is_used" value="1"checked="checked" />
															Yes
														</label>
														

													</c:when>
													<c:otherwise>
														
														<label class="radio-inline"> <input type="radio"
															name="is_used" id="is_used" value="0"checked="checked" /> No
														</label>
														<label class="radio-inline"> <input type="radio"
															name="is_used" id="is_used" 
															value="1" /> Yes
														</label>
													</c:otherwise>

												</c:choose>

											</div>
										</div>
									
 			                         <div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Allow to upload Photo ?</label>
											<div class="col-sm-9 col-lg-10 controls">
									
												<c:choose>
													<c:when test="${strallowPhUp.equals('0')}">

													

														<label class="radio-inline"> <input type="radio"
															name="allowphupload" id="allowphupload" checked="checked"
															value="0" /> No
														</label>
															<label class="radio-inline"> <input type="radio"
															name="allowphupload" id="allowphupload" value="1" />
															Yes
														</label>
														

													</c:when>
													<c:otherwise>
														
														<label class="radio-inline"> <input type="radio"
															name="allowphupload" id="allowphupload" value="0" /> No
														</label>
														<label class="radio-inline"> <input type="radio"
															name="allowphupload" id="allowphupload" checked="checked"
															value="1" /> Yes
														</label>
													</c:otherwise>

												</c:choose>

											</div>
										</div>
											<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Is Slot Used?</label>
											<div class="col-sm-9 col-lg-10 controls">
											<c:choose>
													<c:when test="${isSlotUsed.equals('0')}">
											
											
											    	<label class="radio-inline"> <input type="radio"
													name="isSlotUsed" id="isSlotUsed" value="0" checked>
													No
												   </label> <label class="radio-inline"> <input type="radio"
													name="isSlotUsed"  id="isSlotUsed" value="1" />
													Yes
												    </label>
												
												</c:when>
													<c:otherwise>
													
													<label class="radio-inline"> <input type="radio"
													name="isSlotUsed" id="isSlotUsed" value="0" >
													No
												    </label> <label class="radio-inline"> <input type="radio"
													name="isSlotUsed"  id="isSlotUsed" value="1" checked/>
													Yes
												    </label>
													
													</c:otherwise>

												</c:choose>
											</div>
										</div>
										
										<div>
          
											</div>
 
										<div class="form-group">
											<div
												class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2">
												<!-- <button type="submit" class="btn btn-primary">
															<i class="fa fa-check"></i> Save
														</button> -->
												<input type="submit" class="btn btn-primary" value="Submit">
												<!-- <button type="button" class="btn">Cancel</button> -->

												<!--<button type="button" class="btn">Cancel</button>-->
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>

				</div>

			</div>
			<!-- END Main Content -->
			<footer>
			<p>2018 © MONGINIS.</p>
			</footer>

			<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
				class="fa fa-chevron-up"></i></a>
		</div>
		<!-- END Content -->
	</div>
	<!-- END Container -->

	<!--basic scripts-->
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
	<script>
		window.jQuery|| document.write('<script src="${pageContext.request.contextPath}/resources/assets/jquery/jquery-2.0.3.min.js"><\/script>')
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


	<!--page specific plugin scripts-->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/jquery.validate.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/additional-methods.min.js"></script>

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
		
<script>
    function calTotalGst() {
   
	  var igst=parseFloat($("#tax_3").val());
	  var cgst=parseFloat($("#tax_1").val());
	  var sgst=parseFloat(igst-cgst);
	  var totGst=parseFloat(cgst+sgst);
	  document.getElementById("tax_2").setAttribute('value',sgst);
	  document.getElementById("total_gst_appli").setAttribute('value', totGst);
}
</script>	
<script>
function calTotalGstOnLoad() {
   
	  var sgst=parseFloat($("#tax_1").val());
	  var cgst=parseFloat($("#tax_2").val());
	  var totalGst=parseFloat(cgst+sgst);
	
	  document.getElementById("total_gst_appli")
		.setAttribute('value', totalGst);
}
</script>	
<script type="text/javascript">
function calMrp()
{
	var mrp1 = parseFloat($("#mrp_rate1").val());
	//var mrp2 = parseFloat($("#item_mrp2").val());
	var mrp3 = parseFloat($("#mrp_rate3").val());
	var margin= parseFloat($("#margin").val());
	

	var calRate1=mrp1-((mrp1*margin)/100);      
	//var calRate2=((mrp2*100)/(100+margin));  
	var calRate3=mrp3-((mrp3*margin)/100);  
	document.getElementById("sp_rate1").setAttribute('value', (calRate1).toFixed(2));
	//document.getElementById("item_rate2").setAttribute('value', (calRate2).toFixed(2));
	document.getElementById("sp_rate3").setAttribute('value', (calRate3).toFixed(2));
}
</script>
<!-- <script type="text/javascript">
function calMrp()
{
	var rate1 = parseFloat($("#sp_rate1").val());
	var rate2 = parseFloat($("#sp_rate2").val());
	var rate3 = parseFloat($("#sp_rate3").val());
	var margin= parseFloat($("#margin").val());
	
	var calRate1=rate1+(rate1*margin/100);
	var calRate2=rate2+(rate2*margin/100);
	var calRate3=rate3+(rate3*margin/100);
	document.getElementById("mrp_rate1").setAttribute('value', calRate1);
	document.getElementById("mrp_rate2").setAttribute('value', calRate2);
	document.getElementById("mrp_rate3").setAttribute('value', calRate3);
}
</script> -->
<script>
function eventChange()
{
 var event=$('#spe_id_list option:selected').val()
  if(event==0){
	  $.getJSON('${findEventList}', {
			ajax : 'true'
		}, function(data) {
			$('#spe_id_list')
		    .find('option')
		    .remove()
		    .end()

	var html = '<option value="0">ALL</option>';
	var len = data.length;
	
	
	for ( var i = 0; i < len; i++) {

       $("#spe_id_list").append(
               $("<option selected></option>").attr(
                   "value", data[i].speId).text(data[i].speName)
           );
	}

	   $("#spe_id_list").trigger("chosen:updated");
		});
  }
}
</script>

<script type="text/javascript">
	function uomChanged() {

		document.getElementById('sp_uom_name').value = $(
				'#spck_uom option:selected').text();

	}
</script>
<script type="text/javascript">
$(document).ready(function() { 
	$('#spc_type').change(
			function() {
				$.getJSON('${getFlavoursByType}', {
					type : $(this).val(),
					ajax : 'true'
				}, function(data) {
					var html = '<option value="" disabled>Flavours</option>';
				
					var len = data.length;
					
					$('#erplinkcode')
				    .find('option')
				    .remove()
				    .end()
				    
				 $("#erplinkcode").append(
                                $("<option></option>").attr(
                                    "value", 0).text("Select Flavours")
                            );
					
					for ( var i = 0; i < len; i++) {
                        $("#erplinkcode").append(
                                $("<option></option>").attr(
                                    "value", data[i].spfId).text(data[i].spfName)
                            );
					}
					   $("#erplinkcode").trigger("chosen:updated");
				});
			});
});
</script>
</body>
</html>