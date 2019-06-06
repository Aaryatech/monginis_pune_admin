<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
 --%>
<!-- <script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script> -->

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body onload="routListByAbcType()">

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
	<c:url var="routListByAbcType" value="/routListByAbcType"></c:url>
	<c:url var="getBillList" value="/getPDispatchReportByRoute"></c:url>
	<c:url var="getMenuListBySectionId" value="/getMenuListBySectionId"></c:url>
	<c:url var="getFranchisees" value="/getFranchiseByRoute"></c:url>


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
		<div class="page-title">
			<div>
				<h1>
					<i class="fa fa-file-o"></i>Dispatch Item Report
				</h1>
				<h4></h4>
			</div>
		</div>
		<!-- END Page Title -->

		<!-- BEGIN Breadcrumb -->
		<%-- <div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="fa fa-home"></i> <a
					href="${pageContext.request.contextPath}/home">Home</a> <span
					class="divider"><i class="fa fa-angle-right"></i></span></li>
				<li class="active">Dispatch Report</li>
			</ul>
		</div> --%>
		<!-- END Breadcrumb -->

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i>Dispatch Report
				</h3>

			</div>

			<form id="submitBillForm"
				action="${pageContext.request.contextPath}/searchPDispatchItemReportNew"
				method="get">
				<div class="box-content">
					<div class="row">


						<div class="form-group">
							<label class="col-sm-3 col-lg-2	 control-label">Delivery
								Date</label>
							<div class="col-sm-6 col-lg-4 controls date_select">
								<input class="form-control date-picker" id="billDate"
									name="billDate" size="30" type="text" value="${todaysDate}" />
							</div>
							<label class="col-sm-3 col-lg-2 control-label">Select
								Station</label>
							<div class="col-sm-6 col-lg-4 controls">
								<select data-placeholder="Select Route"
									class="form-control chosen" name="stanId" id="stanId"
									multiple="multiple">
									<option value="-1">All</option>
									<c:forEach items="${stationList}" var="stationList"
										varStatus="count">
										<option value="${stationList}"><c:out
												value="${stationList}" />
										</option>

									</c:forEach>
								</select>

							</div>
						</div>

					</div>

					<br>
					<div class="row">

						<div class="form-group">

							<label class="col-sm-3 col-lg-2 control-label">Select ABC
								Type</label>
							<div class="col-sm-3 col-lg-4">

								<select data-placeholder="Choose Category"
									class="form-control chosen" onchange="routListByAbcType()"
									id="abcType" name="abcType">

									<option value="0">All</option>
									<option value="1">A</option>
									<option value="2">B</option>
									<option value="3">C</option>
									<%-- <c:forEach items="${catList}" var="cat" varStatus="count">
									<option value="${cat.catId}"><c:out value="${cat.catName}"/></option>
								</c:forEach> --%>
								</select>
							</div>

							<label class="col-sm-3 col-lg-2 control-label">Select
								Route</label>
							<div class="col-sm-6 col-lg-4 controls">
								<select data-placeholder="Select Route"
									class="form-control chosen" name="selectRoute" id="selectRoute">

								</select>

							</div>
							<br>

						</div>



					</div>
					<br>

					<div class="row">

						<div class="form-group">

							<label class="col-sm-3 col-lg-2 control-label">Select
								Section</label>
							<div class="col-sm-3 col-lg-4">

								<select data-placeholder="Choose Category"
									class="form-control chosen" onchange="getMenuListBySectionId()"
									id="sectionId" name="sectionId">

									<option value="" selected>Select Section</option>

									<c:forEach items="${sectionList}" var="sectionList">
										<option value="${sectionList.sectionId}"><c:out
												value="${sectionList.sectionName}" /></option>
									</c:forEach>
								</select>
							</div>

							<label class="col-sm-3 col-lg-2 control-label">Select
								Menu </label>
							<div class="col-sm-3 col-lg-4">

								<select data-placeholder="Select Menu "
									class="form-control chosen" id="menuId" name="menuId"
									multiple="multiple" required
									onchange="onChangeMenu(this.value)">

									<%--  <option value="0" selected>All</option>
								<c:forEach items="${menuList}" var="menuList" >
									<option value="${menuList.menuId}"><c:out value="${menuList.menuTitle}"/> </option>

								</c:forEach> --%>
								</select>
							</div>

						</div>



					</div>
					<br>

					<div class="row">

						<div class="form-group" align="center">

							<input type="submit" id="submit" class="btn btn-primary"
								value="Search">
							<!-- <button class="btn btn-info" onclick="searchReport()">Search
							Report</button> 
						<button class="btn btn-primary" value="PDF" id="PDFButton"
							onclick="genPdf()">PDF</button> -->
							<input type="button" class="btn btn-primary" value="PDF"
								id="PDFButton" onclick="genPdf()" value="PDF" />
								<input type="button" class="btn btn-primary"
								id="PDFButtonNew" onclick="genPdfNew()" value="PDF 1" />  <input
								type="button" class="btn btn-primary" value="PDF FOR DOT MATRIX"
								id="PDFButton" onclick="genPdfForDotMatrix()"
								value="PDF FOR DOT MATRIX" />
						</div>



					</div>

				</div>
			</form>

			<%-- <div class="box">
				<div class="box-title">
					<h3>
						<i class="fa fa-list-alt"></i>Dispatch Item List
					</h3>

				</div>
				<form id="submitBillForm"
					action="${pageContext.request.contextPath}/submitEditedQty"
					method="post">
					
				
					<div class="box-content" >
					<div id="routeName"></div>
						<div class="row">
							<div class="col-md-12 table-responsive">
							<div style="">
							
								<table class="table table-bordered table-striped fill-head "
								style="width: 100%" id="table_grid">
									<thead style="background-color: #f3b5db;">
										<tr>
											<!-- <th>Sr.No.</th>
											<th>Franchisee Name</th>
											<th>Category</th>
											<th>Item Name</th>
											<th>Bill Qty</th> -->
											
										</tr>
									</thead>
									<tbody>

									</tbody>
								</table>
							</div>
							</div>
								<div style="text-align:center;">
											 <input type="submit" id="submit" class="btn btn-primary" value="SUBMIT" disabled>
											</div>
							<div class="form-group" style="display: none;" id="range">
								 
											 
											 
											<div class="col-sm-3  controls">
											 <input type="button" id="expExcel" class="btn btn-primary" value="EXPORT TO Excel" onclick="exportToExcel();" disabled="disabled">
											</div>
											</div>
						</div>

					</div>

					<div id="chart_div" style="width: 100%; height: 700px; background-color: white;" ></div>
					<div id="PieChart_div" style="width: 100%; height: 700px;"></div>

				</form>
			</div> --%>
		</div>
		<!-- END Main Content -->

		<footer>
			<p>2019 © Monginis.</p>
		</footer>

		<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
			class="fa fa-chevron-up"></i></a>



		<script type="text/javascript">
			function onChangeMenu(menuId) {

				if (menuId == 0) {
					var sectionId = $("#sectionId").val();
					if (sectionId == "" || sectionId == null) {
						$('#menuId').find('option').remove().end()
						$("#menuId").trigger("chosen:updated");
					} else {
						$
								.getJSON(
										'${getMenuListBySectionId}',
										{

											sectionId : sectionId,
											ajax : 'true'
										},
										function(data) {
											var html = '<option value="">Select Section</option>';

											var len = data.length;

											$('#menuId').find('option')
													.remove().end()

											$("#menuId").append(
													$("<option ></option>")
															.attr("value", 0)
															.text("All"));

											for (var i = 0; i < len; i++) {
												$("#menuId")
														.append(
																$(
																		"<option selected></option>")
																		.attr(
																				"value",
																				data[i].menuId)
																		.text(
																				data[i].menuTitle));
											}
											$("#menuId").trigger(
													"chosen:updated");
										});
					}
				}
			}

			function getMenuListBySectionId() {

				var sectionId = $("#sectionId").val();

				if (sectionId == "" || sectionId == null) {

					$('#menuId').find('option').remove().end()
					$("#menuId").trigger("chosen:updated");
				} else {
					$.getJSON('${getMenuListBySectionId}', {

						sectionId : sectionId,
						ajax : 'true'
					}, function(data) {
						var html = '<option value="">Select Section</option>';

						var len = data.length;

						$('#menuId').find('option').remove().end()

						$("#menuId").append(
								$("<option ></option>").attr("value", 0).text(
										"All"));

						for (var i = 0; i < len; i++) {
							$("#menuId").append(
									$("<option></option>").attr("value",
											data[i].menuId).text(
											data[i].menuTitle));
						}
						$("#menuId").trigger("chosen:updated");
					});
				}

			}

			function routListByAbcType() {

				var abcType = $("#abcType").val();

				if (abcType != 0) {

					$.getJSON('${routListByAbcType}', {

						abcType : abcType,
						ajax : 'true'
					}, function(data) {
						var html = '<option value="">Select Rout</option>';

						var len = data.length;

						$('#selectRoute').find('option').remove().end()

						$("#selectRoute").append(
								$("<option></option>").attr("value", 0).text(
										"All"));

						for (var i = 0; i < len; i++) {
							$("#selectRoute").append(
									$("<option></option>").attr("value",
											data[i].routeId).text(
											data[i].routeName));
						}
						$("#selectRoute").trigger("chosen:updated");
					});
				} else {
					$('#selectRoute').find('option').remove().end()
					$("#selectRoute")
							.append(
									$("<option></option>").attr("value", 0)
											.text("All"));
					$("#selectRoute").trigger("chosen:updated");
				}
			}

			function getFranchise(routeId) {

				$.getJSON('${getFranchisees}', {

					routeId : routeId,
					ajax : 'true'
				}, function(data) {
					var html = '<option value="">Select Franchisee</option>';

					var len = data.length;

					$('#fraId').find('option').remove().end()

					$("#fraId").append(
							$("<option></option>").attr("value", 0).text(
									"Select Franchisee"));

					for (var i = 0; i < len; i++) {
						$("#fraId").append(
								$("<option></option>").attr("value",
										data[i].frId).text(data[i].frName));
					}
					$("#fraId").trigger("chosen:updated");
				});
			}
		</script>
		<script type="text/javascript">
			function searchReport() {
				var isValid = validate();
				if (isValid == true) {
					//document.getElementById('chart').style.display = "block";
					document.getElementById("PieChart_div").style = "display:none";
					document.getElementById("chart_div").style = "display:none";

					var routeId = $("#selectRoute").val();

					var routeName = $("#selectRoute option:selected").text();
					document.getElementById("routeName").innerText = "Route: "
							+ $("#selectRoute option:selected").text();
					document.getElementById("routeName").style.fontWeight = "900";
					var isGraph = 0;

					var selectedCat = $("#selectCat").val();

					var billDate = $("#billDate").val();
					$('#loader').show();

					$
							.getJSON(
									'${getBillList}',

									{
										bill_date : billDate,
										route_id : routeId,
										cat_id_list : JSON
												.stringify(selectedCat),
										routeName : routeName,
										ajax : 'true'

									},
									function(data) {
										document.getElementById("submit").disabled = false;
										$('#table_grid th').remove();

										$('#table_grid td').remove();

										$('#loader').hide();
										var frListLength = data.frList.length;
										if (data == "") {
											alert("No records found !!");
											document.getElementById("expExcel").disabled = true;
											document.getElementById("submit").disabled = true;
										}

										var tr;
										tr = document
												.getElementById('table_grid').tHead.children[0];
										tr.insertCell(0).outerHTML = "<th align='left'>Sr.No.</th>"

										tr.insertCell(1).outerHTML = "<th style='width=170px'>ItemName</th>"
										var i = 0;
										var j = 0;
										$
												.each(
														data.frList,
														function(key, fr) {
															i = key + 2;
															tr.insertCell(i).outerHTML = "<th style='width=80px'>"
																	+ fr.frName
																	+ "</th>"
														});//franchise for end    
										/* 								         tr.insertCell(i+1).outerHTML = "<th style='font-weight:bold'>Total</th>"
										 */

										$
												.each(
														data.subCatList,
														function(key, subCat) {
															var tr = $('<tr></tr>');
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					" "));
															tr
																	.append($(
																			'<td style="font-weight:bold"></td>')
																			.html(
																					subCat.subCatName));
															for (var i = 0; i <= frListLength; i++) {
																tr
																		.append($(
																				'<td></td>')
																				.html(
																						" "));
															}

															$(
																	'#table_grid tbody')
																	.append(tr);

															var srNo = 0;
															$
																	.each(
																			data.itemList,
																			function(
																					key,
																					item) {
																				if (item.itemGrp2 == subCat.subCatId) {
																					srNo = srNo + 1;
																					var tr = $('<tr></tr>');
																					tr
																							.append($(
																									'<td></td>')
																									.html(
																											srNo));
																					tr
																							.append($(
																									'<td></td>')
																									.html(
																											item.itemName));
																					$
																							.each(
																									data.frList,
																									function(
																											key,
																											franchise) {
																										//alert(franchise.frId)
																										var orderId = 'o';
																										var orderQty = 0;
																										var isBillGenerated = 0;
																										$
																												.each(
																														data.dispatchReportList,
																														function(
																																key,
																																report) {
																															if (franchise.frId == report.frId
																																	&& item.id == report.itemId) {
																																orderId = report.orderId;
																																orderQty = report.orderQty;
																																isBillGenerated = report.isBillGenerated;
																															}

																														});
																										if (isBillGenerated == 2) {
																											tr
																													.append($(
																															'<td style="color:blue;"></td>')
																															.html(
																																	"Qty: "
																																			+ orderQty
																																			+ " <input type=number style='text-align:right; width:60px' min=0 class=form-control name=itemQty"+franchise.frId+""+item.id+""+orderId+" id=itemQty"+franchise.frId+""+item.id+""+orderId+" value=0 disabled/>"));
																										} else {
																											if (orderId == 'o') {
																												tr
																														.append($(
																																'<td style="color:red;"></td>')
																																.html(
																																		"Qty: "
																																				+ orderQty
																																				+ " <input type=number style='text-align:right; width:60px' min=0 class=form-control name=itemQty"+franchise.frId+""+item.id+""+orderId+" id=itemQty"+franchise.frId+""+item.id+""+orderId+" value=0 disabled/>"));
																											} else {
																												tr
																														.append($(
																																'<td style="color:green;"></td>')
																																.html(
																																		"Qty: "
																																				+ orderQty
																																				+ " <input type=number style='text-align:right; width:60px' min=0 class=form-control name=itemQty"+franchise.frId+""+item.id+""+orderId+" id=itemQty"+franchise.frId+""+item.id+""+orderId+" value=0 />"));

																											}
																										}
																									});
																					/*  tr
																						.append($(
																								'<td></td>')
																								.html("<input type=text style='text-align:right; width:60px' class=form-control name=total"+key+""+item.id+" id=total"+key+""+item.id+" value=0 disabled/>"));
																					 */$(
																							'#table_grid tbody')
																							.append(
																									tr);
																				}//end if
																			});//itemList for end
														});//subCatList for end
										//	var srNo = 0;
										$
												.each(
														data.dispatchReportList,
														function(key, report) {

															document
																	.getElementById('itemQty'
																			+ report.frId
																			+ ''
																			+ report.itemId
																			+ ''
																			+ report.orderId).value = report.editQty;

														});

										/* $.each(data.itemList,
													function(key,item) {
												 var total=0;
										 		 $.each(data.frList, function(key,franchise){  	
										 			 var tot=parseFloat($("#itemQty"+franchise.frId+''+item.id).val());
										 			
										 			 total=total+tot;
										 			 
										     		
										
										 		 });
										 		  document.getElementById('total'+key+''+item.id).value =total;
										 	});	 */

									});
				}

			}
		</script>


		<script type="text/javascript">
			function showChart() {

				$("#PieChart_div").empty();
				$("#chart_div").empty();
				//document.getElementById('chart').style.display = "block";
				document.getElementById("table_grid").style = "display:none";
				document.getElementById("PieChart_div").style = "block";
				document.getElementById("chart_div").style = "block";

				var selectedFr = $("#selectFr").val();
				var routeId = $("#selectRoute").val();
				var selectedCat = $("#selectCat").val();
				var from_date = $("#fromDate").val();
				var to_date = $("#toDate").val();

				var isGraph = 1;
				$('#loader').show();

				$
						.getJSON(
								'${getBillList}',

								{
									fr_id_list : JSON.stringify(selectedFr),
									fromDate : from_date,
									toDate : to_date,
									route_id : routeId,
									cat_id_list : JSON.stringify(selectedCat),
									is_graph : isGraph,

									ajax : 'true'

								},
								function(data) {

									$('#loader').hide();

									if (data == "") {
										alert("No records found !!");

									}
									var i = 0;

									google.charts.load('current', {
										'packages' : [ 'corechart', 'bar' ]
									});
									google.charts.setOnLoadCallback(drawStuff);

									function drawStuff() {

										// alert("Inside DrawStuff");

										var chartDiv = document
												.getElementById('chart_div');
										document.getElementById("chart_div").style.border = "thin dotted red";

										var PiechartDiv = document
												.getElementById('PieChart_div');
										document.getElementById("PieChart_div").style.border = "thin dotted red";

										var dataTable = new google.visualization.DataTable();
										dataTable.addColumn('string',
												'Category'); // Implicit domain column.
										dataTable.addColumn('number', 'NetQty'); // Implicit data column.
										dataTable.addColumn('number',
												'NetValue');

										var piedataTable = new google.visualization.DataTable();
										piedataTable.addColumn('string',
												'Category'); // Implicit domain column.
										piedataTable.addColumn('number',
												'NetValue');

										$
												.each(
														data.categoryList,
														function(key, cat) {
															var netQty = 0;
															var netValue = 0;
															$
																	.each(
																			data.salesReportRoyalty,
																			function(
																					key,
																					report) {

																				if (cat.catId === report.catId) {
																					netQty = netQty
																							+ report.tBillQty
																							- (report.tGrnQty + report.tGvnQty);
																					//netQty=netQty.toFixed(2);
																					netValue = netValue
																							+ report.tBillTaxableAmt
																							- (report.tGrnTaxableAmt + report.tGvnTaxableAmt);
																					//netValue=netValue.toFixed(2);
																					var catName = report.cat_name;
																					//alert("CatName"+catName);

																					//alert("netValue"+netValue);
																					//alert("netQty"+netQty);

																					dataTable
																							.addRows([
																									[
																											catName,
																											netQty,
																											netValue ], ]);

																					piedataTable
																							.addRows([
																									[
																											catName,
																											netValue ], ]);
																				}
																			})

														})
										// Instantiate and draw the chart.

										var materialOptions = {

											width : 500,
											chart : {
												title : 'Date wise Tax Graph',
												subtitle : 'Total tax & Taxable Amount per day',

											},
											series : {
												0 : {
													axis : 'distance'
												}, // Bind series 0 to an axis named 'distance'.
												1 : {
													axis : 'brightness'
												}
											// Bind series 1 to an axis named 'brightness'.
											},
											axes : {
												y : {
													distance : {
														label : 'Total Tax'
													}, // Left y-axis.
													brightness : {
														side : 'right',
														label : 'Taxable Amount'
													}
												// Right y-axis.
												}
											}
										};

										function drawMaterialChart() {
											var materialChart = new google.charts.Bar(
													chartDiv);

											materialChart
													.draw(
															dataTable,
															google.charts.Bar
																	.convertOptions(materialOptions));

										}

										var chart = new google.visualization.ColumnChart(
												document
														.getElementById('chart_div'));

										var Piechart = new google.visualization.PieChart(
												document
														.getElementById('PieChart_div'));
										chart
												.draw(
														dataTable,
														{
															width : 1000,
															height : 600,
															title : 'Sales Summary Group By Month'
														});

										Piechart
												.draw(
														piedataTable,
														{
															width : 1000,
															height : 600,
															title : 'Sales Summary Group By Month',
															is3D : true
														});
										// drawMaterialChart();
									}
									;

								});

			}
		</script>


		<script type="text/javascript">
			function validate() {

				var selectCat = $("#selectCat").val();
				var selectedRoute = $("#selectRoute").val();

				var isValid = true;

				if (selectedRoute == "0" || selectedRoute == null) {

					alert("Please Select Route");
					isValid = false;

				} else if (selectCat == "" || selectCat == null) {

					isValid = false;
					alert("Please Select Category");

				}
				return isValid;

			}
		</script>

		<script type="text/javascript">
			function updateTotal(orderId, rate) {

				var newQty = $("#billQty" + orderId).val();

				var total = parseFloat(newQty) * parseFloat(rate);

				$('#billTotal' + orderId).html(total);
			}
		</script>

		<script>
			$('.datepicker').datepicker({
				format : {
					/*
					 * Say our UI should display a week ahead,
					 * but textbox should store the actual date.
					 * This is useful if we need UI to select local dates,
					 * but store in UTC
					 */
					format : 'mm/dd/yyyy',
					startDate : '-3d'
				}
			});
		</script>

		<script type="text/javascript">
			function disableFr() {

				//alert("Inside Disable Fr ");
				document.getElementById("selectFr").disabled = true;

			}

			function disableRoute() {

				//alert("Inside Disable route ");
				var x = document.getElementById("selectRoute")
				//alert(x.options.length);
				var i;
				for (i = 0; i < x; i++) {
					document.getElementById("selectRoute").options[i].disabled;
					//document.getElementById("pets").options[2].disabled = true;
				}
				//document.getElementById("selectRoute").disabled = true;

			}
		</script>
		<script type="text/javascript">
			function genPdf() {

				var date = $("#billDate").val();
				var stationId = $("#stanId").val();
				var abcType = $("#abcType").val();
				var routId = $("#selectRoute").val();
				var menuIds = $("#menuId").val();

				window.open('pdfForDisReport?url=pdf/getPDispatchReportNewPdf/'
						+ date + '/' + stationId + '/' + abcType + '/' + routId
						+ '/' + menuIds);

			}
		</script>
		<script type="text/javascript">
			function genPdfNew() {

				var date = $("#billDate").val();
				var stationId = $("#stanId").val();
				var abcType = $("#abcType").val();
				var routId = $("#selectRoute").val();
				var menuIds = $("#menuId").val();

				window.open('pdfForDisReport?url=pdf/getPDispatchReportNewPdf1/'
						+ date + '/' + stationId + '/' + abcType + '/' + routId
						+ '/' + menuIds);

			}
		</script>

		<script type="text/javascript">
			function genPdfForDotMatrix() {

				var date = $("#billDate").val();
				var stationId = $("#stanId").val();
				var abcType = $("#abcType").val();
				var routId = $("#selectRoute").val();
				var menuIds = $("#menuId").val();

				window
						.open('${pageContext.request.contextPath}/getPDispatchReportNewPdforDtMatrix/'
								+ date
								+ '/'
								+ stationId
								+ '/'
								+ abcType
								+ '/'
								+ routId + '/' + menuIds);

			}
		</script>



		<script type="text/javascript">
			/* function genPdf() {
				var billDate = $("#billDate").val();
				var routeId = $("#selectRoute").val();
				var selectedCat = $("#selectCat").val();
				
				window.open('pdfForDisReport?url=pdf/getPDispatchReportPdf/'
						+ billDate + '/'+routeId+'/'+selectedCat);

			} */
			function exportToExcel() {

				window.open("${pageContext.request.contextPath}/exportToExcel");
				document.getElementById("expExcel").disabled = true;
			}
			function genPdfBill() {
				var billDate = $("#billDate").val();
				var routeId = $("#selectRoute").val();
				var selectedCat = $("#selectCat").val();
				var frId = $("#fraId").val();

				window
						.open('pdfForDisReport?url=pdf/getDispatchPReportPdfForBill/'
								+ billDate
								+ '/'
								+ routeId
								+ '/'
								+ selectedCat
								+ '/' + frId);

			}
		</script>
		<script type="text/javascript">
			function genDispatchPdf() {
				var billDate = $("#billDate").val();
				var routeId = $("#selectRoute").val();
				var selectedCat = $("#selectCat").val();
				var frId = $("#fraId").val();

				window.open('pdf/getDispatchPReportPdfForDispatch/' + billDate
						+ '/' + routeId + '/' + selectedCat + '/' + frId);

			}
		</script>
		<!--basic scripts-->
		<script
			src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
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
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/chosen-bootstrap/chosen.jquery.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-inputmask/bootstrap-inputmask.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/jquery-tags-input/jquery.tagsinput.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/jquery-pwstrength/jquery.pwstrength.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-fileupload/bootstrap-fileupload.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-duallistbox/duallistbox/bootstrap-duallistbox.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/dropzone/downloads/dropzone.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/clockface/js/clockface.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/date.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/daterangepicker.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-switch/static/js/bootstrap-switch.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/ckeditor/ckeditor.js"></script>

		<!--flaty scripts-->
		<script src="${pageContext.request.contextPath}/resources/js/flaty.js"></script>
		<script
			src="${pageContext.request.contextPath}/resources/js/flaty-demo-codes.js"></script>
</body>
</html>