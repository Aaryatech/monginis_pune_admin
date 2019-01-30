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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
<style type="text/css">
select {
	width: 180px;
	height: 30px;
}
</style>


</head>
<body>

	<c:url var="getFlavourBySpfId" value="/getFlavourBySpfId" />

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
										<i class="fa fa-bars"></i>Manual Billing
									</h3>
									<div class="box-tool">
										<%-- 	<a href="${pageContext.request.contextPath}/configuredFrMenus">Back to
											List</a> <a data-action="collapse" href="#"><i
											class="fa fa-chevron-up"></i></a> --%>
									</div>
								</div>


								<c:set var="allFranchiseeAndMenuList"
									value="${allFranchiseeAndMenuList}" />
								<div class="box-content">
									<form
										action="${pageContext.request.contextPath}/getSpCakeForManBill"
										class="form-horizontal" id="validation-form" method="post">
										
										
										<input type="hidden" name="menu_title" value="${menuTitle}"> 
<input type="hidden" name="mode_add" id="mode_add" value="add_book">
<input type="hidden" name="sp_id" id="sp_id" value="${specialCake.spId}">
<input type="hidden" name="sp_min_weight" id="sp_min_weight" value="${specialCake.spMinwt}">
<input type="hidden" name="sp_max_weight" id="sp_max_weight" value="${specialCake.spMaxwt}">
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
											<label class="col-sm-3 col-lg-2 control-label">Franchisee</label>
											<div class="col-sm-9 col-lg-10 controls">
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
										</div>

										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Special
												Cake List</label>
											<div class="col-sm-9 col-lg-10 controls">
												<select data-placeholder="Select Menu" name="sp_cake_id"
													class="form-control chosen" tabindex="-1" id="sp_cake_id"
													data-rule-required="true">
													<c:forEach items="${specialCakeList}" var="spCake">
														<c:choose>
															<c:when test="${specialCake.spCode==spCake.spCode}">
																<option selected value="${spCake.spCode}">${spCake.spCode}</option>

															</c:when>
															<c:otherwise>
																<option value="${spCake.spCode}">${spCake.spCode}</option>

															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="form-group">
											<div
												class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2">
												<input type="submit" class="btn btn-primary" value="Search">
												<button type="reset" class="btn">Cancel</button>
											</div>
										</div>
										<div class="row">
											<div class="col-md-1"></div>
											<div class="col-md-1">Flavour TYPE</div>
											<div class="col-md-4">

												 <select name="sptype" tabindex="-1" id="sptype" class="form-control chosen" >
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
											<div class="col-md-1"></div>
											<div class="col-md-1">Select Flavour</div>
											<div class="col-md-4">

												<select data-placeholder="Select Fla" name="spFlavour"
													class="form-control chosen" tabindex="-1" id="spFlavour"
													 onchange="onChangeFlavour()">
													<%-- <c:forEach items="${specialCakeList}" var="spCake">
														<c:choose>
															<c:when test="${specialCake.spCode==spCake.spCode}">
																<option selected value="${spCake.spCode}">${spCake.spCode}</option>

															</c:when>
															<c:otherwise>
																<option value="${spCake.spCode}">${spCake.spCode}</option>

															</c:otherwise>
														</c:choose>
													</c:forEach> --%>
												</select>
											</div>

										</div>
										<div class="form-group"></div>

										<div class="row">
											<div class="col-md-1"></div>
											<div class="col-md-1">Min Weight</div>
											<div class="col-md-1">${specialCake.spMinwt} Kg</div>
											<div class="col-md-1">Max Weight</div>
											<div class="col-md-1">${specialCake.spMaxwt} Kg</div>
											
			<div class="col-md-5">Weight <select name="spwt" id="spwt" class="form-control chosen" onchange="onChange('${dbRate}')">
            <c:forEach items="${weightList}" var="weightList">
                  <option value="${weightList}">${weightList}</option>
            </c:forEach> 
           
          </select>
          </div>

										</div>
										
										<!--rightForm-->	
<div class="right">
	<div class="priceBox">
		<h2 class="inrbox" id="INR">INR - ${(sprRate*specialCake.spMinwt)}</h2>
		 <input type="hidden" name="sp_grand" id="sp_grand" value="${(sprRate*specialCake.spMinwt)}">   
		<div class="inrboxmiddle">
			<ul>
				<li>
					<div class="priceLeft">Type </div>
					<div class="priceRight"><span>Premium</span></div>
				</li>
				<li>
					<div class="priceLeft">Price </div>
					<div class="priceRight" id="price">${sprRate*specialCake.spMinwt}</div>
					<input name="sp_calc_price" id="sp_calc_price" value="${sprRate*specialCake.spMinwt}" type="hidden">
				</li>
				<li>
					<div class="priceLeft">Add Rate </div>
					<div class="priceRight"  id="rate" >00</div>
					 <input name="sp_add_rate" id="sp_add_rate"  type="hidden" value="0">
				</li>
				<li>
					<div class="priceLeft">Sub Total </div>
					<div class="priceRight"id="subtotal">${sprRate*specialCake.spMinwt}</div>
					<input name="sp_sub_total" id="sp_sub_total"  type="hidden"value="${sprRate*specialCake.spMinwt}">
				</li>
				<li>
					<div class="priceLeft">GST (%)</div>
					<div class="priceRight" id="taxPer3"> ${specialCake.spTax1+specialCake.spTax2} </div>
					<input type="hidden" id="tax3" name="tax3" value="${specialCake.spTax1+specialCake.spTax2}">
				</li>
				<li>
					<div class="priceLeft">GST IN RS.</div>
					<c:set var="varGstRs" value="${(((sprRate*specialCake.spMinwt)*100)/((specialCake.spTax1+specialCake.spTax2)+100))*(specialCake.spTax1+specialCake.spTax2)/100}" />  
					<fmt:formatNumber var="fGstRs" minFractionDigits="2" maxFractionDigits="2" type="number" value="${varGstRs}" />  
					
					<div class="priceRight" id="gstrs"><c:out value="${fGstRs}" /></div>
					<input type="hidden" id="gst_rs" name="gst_rs" value="${fGstRs}">
				</li>
				<li class="total">
				<c:set var="varMgstamt" value="${(((sprRate*specialCake.spMinwt)*100)/((specialCake.spTax1+specialCake.spTax2)+100))}"/>
					<fmt:formatNumber var="fMgstamt" minFractionDigits="2" maxFractionDigits="2" type="number" value="${varMgstamt}" />  
					
					<div class="priceLeft" id="mgstamt">AMT-<c:out value="${fMgstamt}"></c:out></div>
					
				   <input type="hidden" name="m_gst_amt" id="m_gst_amt" type="hidden" value="${fMgstamt}">
				
					<div class="priceRight"id="tot">TOTAL-${(sprRate*specialCake.spMinwt)}</div>
					
					 <input type="hidden" name="total_amt" id="total_amt" value="${(sprRate*specialCake.spMinwt)}">
				</li>
				
				<li class="advance">
					<div class="priceLeft">Advance</div>
					<div class="priceRight"><input name="adv" id="adv" value="00" class="tableInput" type="text" onkeyup="advanceFun()"></div>
					
				</li>
			</ul>
		</div>
		<div class="remainamount">
			<div class="priceLeft">Remaining Amount</div>
					<div class="priceRight" id="rmAmt">${(sprRate*specialCake.spMinwt)}</div>
				    <input type="hidden" name="rm_amount" id="rm_amount" value="${(sprRate*specialCake.spMinwt)}">
		</div>
	</div>
	
	<div class="order-btn">
		<input name="" class="btnSubmit" value="SUBMIT"  type="button" id="click" >
		<input name="" class="btnReset" value="RESET" type="hidden">
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
	<script
		src="${pageContext.request.contextPath}/resources/assets/bootstrap/js/bootstrap.min.js"></script>
		
		<script type="text/javascript">
$(document).ready(function() { 
	$('#sptype').change(
			function() {
				$.getJSON('${getFlavourBySpfId}', {
					spType : $(this).val(),
					ajax : 'true'
				}, function(data) {
					var html = '<option value="">Flavour</option>';
					alert(JSON.stringify(data));
					var len = data.length;
					
					for ( var i = 0; i < len; i++) {
						html += '<option value="' + data[i].spfId + '">'
								+ data[i].spfName + '</option>';
					}
					html += '</option>';
					$('#spFlavour').html(html);
				$("#spFlavour")
				.trigger(
						"chosen:updated");
					//$('#spFlavour').form-control('refresh');

				});
			});
});
</script>

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
</body>
</html>