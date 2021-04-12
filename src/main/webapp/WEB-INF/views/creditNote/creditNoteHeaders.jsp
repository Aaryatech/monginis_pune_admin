<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


<style>

/* Absolute Center Spinner */
.loading {
	position: fixed;
	z-index: 999;
	height: 2em;
	width: 2em;
	overflow: show;
	margin: auto;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
}

/* Transparent Overlay */
.loading:before {
	content: '';
	display: block;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: radial-gradient(rgba(20, 20, 20, .8), rgba(0, 0, 0, .8));
	background: -webkit-radial-gradient(rgba(20, 20, 20, .8),
		rgba(0, 0, 0, .8));
}

/* :not(:required) hides these rules from IE9 and below */
.loading
:not
 
(
:required
 
)
{
/* hide "loading..." text */
font
:
 
0/0
a
;

	
color
:
 
transparent
;

	
text-shadow
:
 
none
;

	
background-color
:
 
transparent
;

	
border
:
 
0;
}
.loading:not (:required ):after {
	content: '';
	display: block;
	font-size: 10px;
	width: 1em;
	height: 1em;
	margin-top: -0.5em;
	-webkit-animation: spinner 150ms infinite linear;
	-moz-animation: spinner 150ms infinite linear;
	-ms-animation: spinner 150ms infinite linear;
	-o-animation: spinner 150ms infinite linear;
	animation: spinner 150ms infinite linear;
	border-radius: 0.5em;
	-webkit-box-shadow: rgba(255, 255, 255, 0.75) 1.5em 0 0 0,
		rgba(255, 255, 255, 0.75) 1.1em 1.1em 0 0, rgba(255, 255, 255, 0.75) 0
		1.5em 0 0, rgba(255, 255, 255, 0.75) -1.1em 1.1em 0 0,
		rgba(255, 255, 255, 0.75) -1.5em 0 0 0, rgba(255, 255, 255, 0.75)
		-1.1em -1.1em 0 0, rgba(255, 255, 255, 0.75) 0 -1.5em 0 0,
		rgba(255, 255, 255, 0.75) 1.1em -1.1em 0 0;
	box-shadow: rgba(255, 255, 255, 0.75) 1.5em 0 0 0,
		rgba(255, 255, 255, 0.75) 1.1em 1.1em 0 0, rgba(255, 255, 255, 0.75) 0
		1.5em 0 0, rgba(255, 255, 255, 0.75) -1.1em 1.1em 0 0,
		rgba(255, 255, 255, 0.75) -1.5em 0 0 0, rgba(255, 255, 255, 0.75)
		-1.1em -1.1em 0 0, rgba(255, 255, 255, 0.75) 0 -1.5em 0 0,
		rgba(255, 255, 255, 0.75) 1.1em -1.1em 0 0;
}

/* Animation */
@
-webkit-keyframes spinner { 0% {
	-webkit-transform: rotate(0deg);
	-moz-transform: rotate(0deg);
	-ms-transform: rotate(0deg);
	-o-transform: rotate(0deg);
	transform: rotate(0deg);
}

100%
{
-webkit-transform


:

 

rotate


(360
deg
);


    

-moz-transform


:

 

rotate


(360
deg
);


    

-ms-transform


:

 

rotate


(360
deg
);


    

-o-transform


:

 

rotate


(360
deg
);


    

transform


:

 

rotate


(360
deg
);


  

}
}
@
-moz-keyframes spinner { 0% {
	-webkit-transform: rotate(0deg);
	-moz-transform: rotate(0deg);
	-ms-transform: rotate(0deg);
	-o-transform: rotate(0deg);
	transform: rotate(0deg);
}

100%
{
-webkit-transform


:

 

rotate


(360
deg
);


    

-moz-transform


:

 

rotate


(360
deg
);


    

-ms-transform


:

 

rotate


(360
deg
);


    

-o-transform


:

 

rotate


(360
deg
);


    

transform


:

 

rotate


(360
deg
);


  

}
}
@
-o-keyframes spinner { 0% {
	-webkit-transform: rotate(0deg);
	-moz-transform: rotate(0deg);
	-ms-transform: rotate(0deg);
	-o-transform: rotate(0deg);
	transform: rotate(0deg);
}

100%
{
-webkit-transform


:

 

rotate


(360
deg
);


    

-moz-transform


:

 

rotate


(360
deg
);


    

-ms-transform


:

 

rotate


(360
deg
);


    

-o-transform


:

 

rotate


(360
deg
);


    

transform


:

 

rotate


(360
deg
);


  

}
}
@
keyframes spinner { 0% {
	-webkit-transform: rotate(0deg);
	-moz-transform: rotate(0deg);
	-ms-transform: rotate(0deg);
	-o-transform: rotate(0deg);
	transform: rotate(0deg);
}
100%
{
-webkit-transform


:

 

rotate


(360
deg
);


    

-moz-transform


:

 

rotate


(360
deg
);


    

-ms-transform


:

 

rotate


(360
deg
);


    

-o-transform


:

 

rotate


(360
deg
);


    

transform


:

 

rotate


(360
deg
);


  

}
}
</style>










<body>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

	<c:url var="getHeaders" value="/getHeaders" />
	<c:url var="excelForCreaditNote" value="/excelForCreaditNote" />

	<c:url var="excelForCreaditNoteReport" value="/exportToExcelReport" />
	<c:url value="/excelForCrnExcel" var="excelForCrnExcel" />

	<div class="container" id="main-container">


		<div class="loading" id="loaderFullScr" style="display: none;"></div>



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
						<i class="fa fa-file-o"></i>Credit Note Header
					</h1>

				</div>
			</div>
			<!-- END Page Title -->

			<!-- BEGIN Main Content -->
			<div class="row">
				<div class="col-md-12">
					<div class="box">
						<div class="box-title">
							<h3>
								<i class="fa fa-bars"></i>Search Credit Note Header
							</h3>
							<div class="box-tool">
								<a href="">Back to List</a> <a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
							</div>

						</div>


						<div class="box-content">
							<form action="" class="form-horizontal" method="get"
								id="validation-form1">

								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">From
										Date</label>
									<div class="col-sm-5 col-lg-3 controls">
										<input class="form-control date-picker" id="from_date"
											autocomplete="off" size="16" type="text" name="from_date"
											value="${fromDate}" required />
									</div>
									<!-- </div>


								<div class="form-group"> -->
									<label class="col-sm-3 col-lg-2 control-label">To Date</label>
									<div class="col-sm-5 col-lg-3 controls">
										<input class="form-control date-picker" id="to_date" size="16"
											autocomplete="off" type="text" value="${toDate}"
											name="to_date" required />
									</div>

									<!-- <div
										class="col-sm-25 col-sm-offset-3 col-lg-30 col-lg-offset-0">
										<input type="button" value="Submit" onclick="getHeader()"
											class="btn btn-primary">

									</div> -->
								</div>

								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">Franchise</label>

									<div class="col-sm-5 col-lg-3 controls">

										<select data-placeholder="Choose Franchisee"
											class="form-control chosen" multiple="multiple" tabindex="6"
											id="selectFr" name="selectFr">
											<option value="-1"><c:out value="All" /></option>

											<c:forEach items="${unSelectedFrList}" var="fr"
												varStatus="count2">
												<option value="${fr.frId}"><c:out
														value="${fr.frName}" /></option>
											</c:forEach>

										</select>
									</div>

									<label class="col-sm-3 col-lg-2 control-label">Is
										Grn/Gvn</label>

									<div class="col-sm-5 col-lg-3 controls">

										<select data-placeholder="Choose Franchisee"
											class="form-control chosen" tabindex="6" id="isGrn"
											name="isGrn">
											<option value="-1">All</option>
											<option value="1">Is GRN</option>
											<option value="0">IS GVN</option>


										</select>
									</div>

									<div
										class="col-sm-25 col-sm-offset-3 col-lg-30 col-lg-offset-0">
										<input type="button" value="Submit" onclick="getHeader()"
											class="btn btn-primary">

									</div>


								</div>

							</form>

							<form action="getCrnCheckedHeaders" class="form-horizontal"
								method="post" id="validation-form">

								<div class="box">
									<div class="box-title">
										<h3>
											<i class="fa fa-table"></i> Crn List
										</h3>
										<div class="box-tool">
											<a data-action="collapse" href="#"><i
												class="fa fa-chevron-up"></i></a>
											<!--<a data-action="close" href="#"><i class="fa fa-times"></i></a>-->
										</div>
									</div>

									<div class="box-content">

										<div class="clearfix"></div>
										<div class="table-responsive" style="border: 0">
											<table width="100%"
												class="table table-advance table-responsive table-position"
												id="table1">
												<thead style="background-color: #f3b5db;">
													<tr>
														<th></th>
														<th>Sr No <input type="checkbox"
															name="select_to_agree" onclick="selectBillNo(this)" /></th>
														<th class="col-md-1">Date</th>
														<th class="col-md-2">Crn Id</th>
														<th class="col-md-2">Franchise Name</th>
														<th class="col-md-2">Taxable Amt</th>
														<th class="col-md-2">Tax Amt</th>
														<th class="col-md-2">Amount</th>
														<th class="col-md-2">Action</th>

													</tr>

												</thead>
												<tbody>
											</table>
										</div>

										<!-- 	<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label"> </label>
											<div class="col-sm-2 col-lg-2 controls">
												<input type="button" value="PDF Report "
													onclick="genPdfReport()" class="btn btn-primary">
											</div>

											<div class="col-sm-5 col-lg-1 controls">
												<input type="button" id="expExcel" class="btn btn-primary"
													value="Excel Report" onclick="createExelReport();">
											</div>

											<label class="col-sm-3 col-lg-2 control-label"></label>
											<div class="col-sm-2 col-lg-3 controls">
												<input type="button" value="Generate PDF For Franchise"
													onclick="genPdf()" class="btn btn-primary">
											</div>


											<div class="col-sm-5 col-lg-1 controls">
												<input type="button" id="expExcel" class="btn btn-primary"
													value="EXPORT TO Excel For ERP" onclick="createExel();">

											</div>

										</div> -->
										<div id="overlay2" 	style="display: none;">
				<div id="text2">
					<img
						src="${pageContext.request.contextPath}/resources/img/loader1.gif"
						alt="pune_logo">
				</div>
			</div>
										<div class="form-group">
											<div class="col-sm-2 col-lg-2 controls">
												<input type="button" value="PDF Report "
													onclick="genPdfReport()" class="btn btn-primary">
											</div>

											<div class="col-sm-5 col-lg-1 controls">
												<input type="button" id="expExcel" class="btn btn-primary"
													value="Excel Report" onclick="createExelReport();">
											</div>

											<label class="col-sm-3 col-lg-1 control-label"></label>
											<div class="col-sm-2 col-lg-2 controls">
												<input type="button" value="Generate PDF For Fr"
													onclick="genPdf()" class="btn btn-primary">
											</div>


											<div class="col-sm-5 col-lg-3 controls">
												<input type="button" id="expExcel" class="btn btn-primary"
													value="EXP TO Excel Itemwise(ERP)" onclick="createExel();">
											</div>
											<div class="col-sm-2 col-lg-2 controls">
												<input type="button" id="expExcel" class="btn btn-primary"
													value="Excel Hsnwise Summary"
													onclick="createExelHsnwise();">
											</div>
										</div>
										<input type="button" id="btn_submit" class="btn btn-primary"
											onclick="showVehNo()" value="Gen E-INVOICE Bill" /> <input
											type="button" id="btn_submit" class="btn btn-primary"
											onclick="showCancelEWB()" style="display: none;"
											value="Cancel E-way Bill" />


										<div class="form-group"></div>

										<div id="eway_submit" style="display: none">

											<%-- <input type="text" name="vehNo" id="vehNo"
												style="width: 20%;" list="vehlist">

											<datalist id="vehlist">
												<c:forEach var="veh" items="${vehicleList}"
													varStatus="count">
													<option value="${veh.vehNo}">
												</c:forEach>

											</datalist> --%>


											<input type="button" id="genEwayBill_button"
												class="btn btn-primary" value="Gen E-Invoice"
												style="width: 20%;" /> <input type="button"
												id="genEwayBillJson_button" class="btn btn-primary"
												value="E-Invoice Bill JSON Format"
												style="width: 20%; display: none;" />

										</div>

										<div id="eway_cancel" style="display: none">

											<input type="text" name="cancelRemark" id="cancelRemark"
												style="width: 40%;" value="Data entry clerical error">

											<input type="button" id="cancelEwayBill_button"
												class="btn btn-primary" value="Cancel E-Invoice"
												style="width: 20%;">

										</div>




										<div class="table-wrap">

											<table id="table2" class="table table-advance" border="1"
												style="display: none">
												<thead>
													<tr style="background-color: red;">
														<th class="col-sm-1" align="left">Sr No</th>
														<th class="col-md-2" align="left">Invoice No</th>
														<th class="col-md-2" align="left">Error Code</th>
														<th class="col-md-4" align="left">Error Desc</th>
													</tr>
												</thead>
												<tbody>


												</tbody>
											</table>
										</div>


										<!-- <div class="form-group">
										
										<div
											class="col-sm-25 col-sm-offset-3 col-lg-30 col-lg-offset-5">
											<input type="button" value="Generate PDF Franchise" onclick="genPdf()"
												class="btn btn-primary">
												<input type="button" id="expExcel" class="btn btn-primary" value="EXPORT TO Excel Franchise" onclick="createExel();" >
										</div>
										
										
										<div
											class="col-sm-25 col-sm-offset-3 col-lg-30 col-lg-offset-5">
											<input type="button" value="Generate Report PDF" onclick="genPdfReport()"
												class="btn btn-primary">
												<input type="button" id="expExcel" class="btn btn-primary" value="EXPORT TO Excel Report" onclick="createExelReport();" >
										</div>
										</div> -->

										<!-- </form> -->
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- END Main Content -->
			<footer>
				<p>2019 © MONGINIS.</p>
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

	<script type="text/javascript">
		function getHeader() {

			var fromDate = $("#from_date").val();
			var toDate = $("#to_date").val();
			var selectedFr = $("#selectFr").val();
			var isGrn = $("#isGrn").val();
			$
					.getJSON(
							'${getHeaders}',
							{
								fromDate : fromDate,
								toDate : toDate,
								fr_id_list : JSON.stringify(selectedFr),
								isGrn : isGrn,
								ajax : 'true',

							},
							function(data) {
								var len = data.length;
							//	document.getElementById("overlay2").style.display = "block";
								$("overlay2").show();

								$('#table1 td').remove();

								$
										.each(
												data,
												function(key, headers) {
													var eInv=headers.exVarchar2;
													var ackNo = "-";
													var ak="-"
													try{
														ackNo = eInv.split("~");
														ak=ackNo[1];
													}catch (e) {
														ak="-"
													}
													var tr = $('<tr></tr>');

													tr.append($('<td></td>')
															.html(key + 1));

													tr
															.append($('<td><input type=checkbox name="select_to_agree" id="select_to_agree'+key+'"  value='+headers.crnId+'>'+ak+'</td>'));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			headers.crnDate));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			headers.crnNo));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			headers.frName));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			headers.crnTaxableAmt));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			headers.crnTotalTax));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			headers.crnGrandTotal));

													tr
															.append($('<td ><a href="#" class="action_btn" onclick="getCrnDetail('
																	+ headers.crnId
																	+ ')"><abbr title="Detail"><i class="fa fa-list"></i></abbr></a></td>'));

													$('#table1 tbody').append(
															tr);

												})

							});
			//document.getElementById("overlay2").hide();
			$("overlay2").hide();
		}
	</script>
	<script type="text/javascript">
		function showVehNo() {
			document.getElementById("eway_submit").style.display = "block";
			//document.getElementById("vehNo").style.display="block";
		}

		function showCancelEWB() {
			document.getElementById("eway_cancel").style.display = "block";
			//document.getElementById("vehNo").style.display="block";
		}

		$('#genEwayBill_button')
				.click(
						function() {

							

							//var form = document.getElementById("validation-form")
									//$('#validation-form').attr('method', 'post');

							var atLeastOneIsChecked = $('input:checkbox').is(
									':checked');
							
							//form.action ="${pageContext.request.contextPath}/genEInvBill1";
						   // form.submit();
							//alert(atLeastOneIsChecked);
							if (atLeastOneIsChecked) {
								document.getElementById("overlay2").style.display = "block";
								var select_to_agree = document
										.getElementsByName('select_to_agree');
								//alert(JSON.stringify(select_to_agree))
								checkboxes = document
										.getElementsByName("select_to_agree");
								$
										.ajax({
											type : "POST",
											url : "${pageContext.request.contextPath}/genEInvBill1",
											data : $('#validation-form').serialize(),
											dataType : 'json',
											success : function(data) {

												document
														.getElementById("overlay2").style.display = "none";

												//alert(JSON.stringify(data));
												if (data.length > 0) {
													document
															.getElementById("table2").style.display = "block";

													$('#table2 td').remove();
													if (data == "") {
														alert("No Bill Found");
														$("overlay2").hide();
													}

													$
															.each(
																	data,
																	function(
																			key,
																			bill) {

																		var tr = $('<tr></tr>');

																		tr
																				.append($(
																						'<td class="col-sm-1"></td>')
																						.html(
																								key + 1));

																		tr
																				.append($(
																						'<td class="col-md-1"></td>')
																						.html(
																								bill.invoiceNo));
																		tr
																				.append($(
																						'<td class="col-md-1"></td>')
																						.html(
																								bill.errorCode));
																		tr
																				.append($(
																						'<td class="col-md-1"></td>')
																						.html(
																								bill.message));

																		$(
																				'#table2 tbody')
																				.append(
																						tr);

																	});

												}

												getHeader();
											}
										})
							} else {
								alert("Please select  some bills by checking checkbox")
								$("overlay2").hide();
								//document.getElementById("overlay2").style.display = "none";

							}
							//document.getElementById("overlay2").style.display = "none";
							$("overlay2").hide();
						});
	</script>

	<script type="text/javascript">
		function getCrnDetail(crnId) {
			//alert("HIII");
			//alert("header ID "+headerId)

			//alert("HHHHHH");
			var form = document.getElementById("validation-form");
			$('#validation-form').attr('method', 'get');
			form.action = "${pageContext.request.contextPath}/getCrnDetailList/"
					+ crnId;
			form.submit();
		}
	</script>
	<script>
		function createExelHsnwise() {

			var select_to_print = document.forms[1];
			var txt = "";
			var i;
			var flag = 0;
			var all = 0;
			for (i = 0; i < select_to_print.length; i++) {
				if (select_to_print[i].checked
						&& select_to_print[i].value != "on") {
					txt = txt + select_to_print[i].value + ",";
					flag = 1;
				}
			}
			if (flag == 1) {

				document.getElementById("loaderFullScr").style.display = "block";

				$
						.getJSON(
								'${excelForCrnExcel}',
								{
									checkboxes : txt,

									ajax : 'true'
								},
								function(data) {

									//alert("Excel Ready");

									document.getElementById("loaderFullScr").style.display = "none";

									exportToExcel();

								});
			} else {
				alert("Please select minimum 1 CRN Note ");
			}

		}
	</script>
	<script>
		function genPdf() {
			//alert("Inside Gen Pdf ");
			checkboxes = document.getElementsByName('select_to_agree');

			var selArray;

			for (var x = 0; x < checkboxes.length; x++) {
				if (document.getElementById("select_to_agree" + x).checked == true) {
					if (x == 0) {
						selArray = document.getElementById("select_to_agree"
								+ x).value;
					} else {
						selArray = selArray
								+ ","
								+ document
										.getElementById("select_to_agree" + x).value;
					}
				}

			}

			//var check = document.getElementById("select_to_agree").value;

			/*  var str =selArray;

			 str = str.replace(/^,|,$|,(?=,)/g, '');
			 alert(str); */
			window
					.open('${pageContext.request.contextPath}/pdf?url=pdf/getCrnCheckedHeaders/'
							+ selArray);

			// window.open('${pageContext.request.contextPath}/getGrnPdf/'+fromDate+'/'+'/'+toDate+'/'+headerId+'/'+1);

		}

		function genPdfReport() {
			//alert("Inside Gen Pdf ");
			checkboxes = document.getElementsByName('select_to_agree');
			var fromDate = $("#from_date").val();
			var toDate = $("#to_date").val();
			var selArray;

			for (var x = 0; x < checkboxes.length; x++) {
				if (document.getElementById("select_to_agree" + x).checked == true) {
					if (x == 0) {
						selArray = document.getElementById("select_to_agree"
								+ x).value;
					} else {
						selArray = selArray
								+ ","
								+ document
										.getElementById("select_to_agree" + x).value;
					}
				}

			}

			//var check = document.getElementById("select_to_agree").value;

			/*  var str =selArray;

			 str = str.replace(/^,|,$|,(?=,)/g, '');
			 alert(str); */
			window.open('${pageContext.request.contextPath}/genCrnReport/'
					+ selArray + '/' + fromDate + '/' + toDate);

			// window.open('${pageContext.request.contextPath}/getGrnPdf/'+fromDate+'/'+'/'+toDate+'/'+headerId+'/'+1);

		}

		function selectBillNo(source) {
			checkboxes = document.getElementsByName('select_to_agree');

			for (var i = 0, n = checkboxes.length; i < n; i++) {
				checkboxes[i].checked = source.checked;
			}

		}
		function createExel() {

			checkboxes = document.getElementsByName('select_to_agree');

			var flag = 0;
			var selArray = "";

			for (var x = 0; x < checkboxes.length; x++) {

				if (document.getElementById("select_to_agree" + x).checked == true) {
					flag = 1;
					if (selArray == "")
						selArray = document.getElementById("select_to_agree"
								+ x).value;
					else
						selArray = selArray
								+ ","
								+ document
										.getElementById("select_to_agree" + x).value;

				}

			}

			if (flag == 1) {
				$.getJSON('${excelForCreaditNote}', {
					checkboxes : selArray,
					ajax : 'true'
				}, function(data) {

					exportToExcel();

				});
			} else {
				alert("Select Minimum 1  ");
			}

		}

		function exportToExcel() {

			window.open("${pageContext.request.contextPath}/exportToExcel");
		}

		//new code excel Report

		function createExelReport() {

			checkboxes = document.getElementsByName('select_to_agree');

			var flag = 0;
			var selArray = "";

			for (var x = 0; x < checkboxes.length; x++) {

				if (document.getElementById("select_to_agree" + x).checked == true) {
					flag = 1;
					if (selArray == "")
						selArray = document.getElementById("select_to_agree"
								+ x).value;
					else
						selArray = selArray
								+ ","
								+ document
										.getElementById("select_to_agree" + x).value;

				}

			}
			if (flag == 1) {
				$.getJSON('${excelForCreaditNoteReport}', {
					checkboxes : selArray,
					ajax : 'true'
				}, function(data) {

					exportToExcel();

				});
			} else {
				alert("Select Minimum 1  ");
			}

		}

		/* function exportToExcel()
		 {
		
		 window.open("${pageContext.request.contextPath}/exportToExcel"); 
		 } */
	</script>



</body>
</html>
