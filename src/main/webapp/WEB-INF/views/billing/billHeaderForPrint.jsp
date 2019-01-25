<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<style>
	table{
  width:100%;
  border:1px solid #ddd;
      border-collapse: collapse;
  
}
th {
    border: 1px #DDD solid;
}
td {
    border: 1px #DDD solid;
    padding: 3px 6px;
 
}
.selected{
    background:#ffffff;
}
</style>
<body>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

<c:url var="excelForFrBill" value="/excelForFrBill" />
	<c:url var="callGetBillListProcess" value="/getBillListProcessForPrint" />

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
						<i class="fa fa-file-o"></i>View Your Bills for Print
					</h1>

				</div>
			</div> -->
			<!-- END Page Title -->



			<!-- BEGIN Main Content -->
			<div class="row">
				<div class="col-md-12">
					<div class="box">
						<div class="box-title">
							<h3>
								<i class="fa fa-bars"></i> View Your Bills for Print
							</h3>
							<div class="box-tool">
								<a href="">Back to List</a> <a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
							</div>
							<!-- <div class="box-tool">
								<a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a> <a data-action="close" href="#"><i
									class="fa fa-times"></i></a>
							</div> -->
						</div>


						<div class="box-content">
							<form class="form-horizontal" method="get" id="validation-form">
	                        <input type="hidden" class="form-control" name="billnumber" id="billnumber"	value="0"  />
							<input type="hidden" class="form-control" name="issinglepdf" id="issinglepdf" 	value="0" />
						
								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">From
										Date</label>
									<div class="col-sm-5 col-lg-3 controls">
										<input class="form-control date-picker" id="dp1" size="16"
											value="${todaysDate}" type="text" name="from_date" required />
									</div>


									<label class="col-sm-3 col-lg-2 control-label">To Date</label>
									<div class="col-sm-5 col-lg-3 controls">
										<input class="form-control date-picker" id="dp2" size="16"
											value="${todaysDate}" type="text" name="to_date" required />

									</div>

								</div>

								<div class="form-group">

									<label for="textfield2" class="col-xs-3 col-lg-2 control-label">Select
										Franchise </label>
									<div class="col-sm-9 col-lg-3 controls">

										<select class="form-control chosen" multiple="multiple"
											tabindex="6" name="fr_id" id="fr_id">

											<option value="-1">All</option>
											<c:forEach items="${allFrIdNameList}" var="allFrIdNameList"
												varStatus="count">
												<option value="${allFrIdNameList.frId}">${allFrIdNameList.frName}</option>
											</c:forEach>

										</select>
									</div>

                          
							


									<label for="textfield2" class="col-xs-3 col-lg-2 control-label"> <b>OR</b>  &nbsp; Select
										Route </label>
									<div class="col-sm-9 col-lg-3 controls">


										<select class="form-control chosen" tabindex="6"
											name="route_id" id="route_id">

											<option value="0">Select Route</option>
											<c:forEach items="${routeList}" var="route" varStatus="count">
												<option value="${route.routeId}"> ${route.routeName}</option>

											</c:forEach>

										</select>
									</div>
							<!-- 	</div>









								<div align="center" class="form-group"> -->
									<div
										class="col-sm-1">
										<input class="btn btn-primary" type="button" value="Search" id="callSubmit"
											onclick="callSearch()">


									</div>
									<!-- <label for="textfield2" class="col-xs-3 col-lg-2 control-label">Transport Mode<input type="text" class="form-control" name="transport_mode" value="By Road"/></label>
									
									<label for="textfield2" class="col-xs-3 col-lg-2 control-label">Vehicle No
										<input type="text" class="form-control" name="vehicle_no" value="0"/> </label>
									 -->
								</div>



								<div align="center" id="loader" style="display: none">

									<span>
										<h4>
											<font color="#343690">Loading</font>
										</h4>
									</span> <span class="l-1"></span> <span class="l-2"></span> <span
										class="l-3"></span> <span class="l-4"></span> <span
										class="l-5"></span> <span class="l-6"></span>
								</div>

								<!-- </form>
 -->
								<!-- <tion="getBillListProcess" class="form-horizontal"
								method="post" id="validation-form"> -->
								<div class="box1">
								<!-- 	<div class="box-title">
										<h3>
											<i class="fa fa-table"></i> Bill List
										</h3>
										<div class="box-tool">
											<a data-action="collapse" href="#"><i
												class="fa fa-chevron-up"></i></a>
											<a data-action="close" href="#"><i class="fa fa-times"></i></a>
										</div>
									</div> -->

									<div class="box-content">

										<div align="center" class="form-group" style="color:white; height:65px; background: #0288d1;
    background: -webkit-linear-gradient(45deg, #0288d1 0%, #26c6da 100%);
    background: linear-gradient(45deg, #e693c6 0%,  #5cc8d6 100%);box-shadow: 0 6px 20px 0 rgba(38, 198, 218, 0.5);  ">
										<br>	<label class="col-sm-3 col-lg-2 control-label">Transport
												Mode </label>
											<div class="col-sm-5 col-lg-3 controls">
												<input type="text" class="form-control"
													name="transport_mode" value="By Road"
													data-rule-required="true" />
											</div>
											<label class="col-sm-3 col-lg-2 control-label">Vehicle No
												</label>
											<div class="col-sm-5 col-lg-3 controls">
												<input type="text" class="form-control" name="vehicle_no"
													value="0" data-rule-required="true" />
											</div>
														</div>


										<div class="clearfix"></div>
										<div class="table-responsive" style="border: 0">
											<table width="100%" class="table table-bordered table-striped" id="table1"  border="1">
												<thead style="background-color: #f3b5db; ">
													<tr>
													<th class="col-sm-1"><input type="checkbox" 
													onClick="selectBillNo(this)" /> All<br /></th>
														<th class="col-sm-1">Sr</th>
														<th class="col-md-1">Inv No</th>
														<th class="col-md-1">Date</th>
														<th class="col-md-2">Franchise</th>
														<th class="col-md-2">Taxable Amt</th>
														<th class="col-sm-1">Tax Amt</th>
														<th class="col-md-1">Total</th>
														<th class="col-md-2">Action</th>
														

														<!-- 	<th width="300" align="center">Action</th> -->

													</tr>
												</thead>
												<tbody>
													<c:forEach items="${billHeadersList}" var="billHeadersList"
														varStatus="count">

														<tr>
														
															<td class="col-sm-1"><input type="checkbox" name="select_to_print"
																id="${billHeadersList.billNo}"
																value="${billHeadersList.billNo}"/></td>
                                                          
															<td class="col-sm-1"><c:out value="${count.index+1}" /></td>
                                                           
															<td class="col-md-1"><c:out
																	value="${billHeadersList.invoiceNo}" /></td>

															<td class="col-md-1"><c:out
																	value="${billHeadersList.billDate}" /></td>

															<td class="col-md-2"><c:out
																	value="${billHeadersList.frName}" /></td>
															<td class="col-md-2" style="text-align:right;"><c:out
																	value="${billHeadersList.taxableAmt}" /></td>
															<td class="col-sm-1" style="text-align:right;"><c:out
																	value="${billHeadersList.totalTax}" /></td>
															
															<td class="col-md-1" style="text-align:right;">
															
															<fmt:formatNumber type="number" maxFractionDigits="2" value="${billHeadersList.taxableAmt + billHeadersList.totalTax}" /></td>
															
															<td class="col-md-2" align="center">
															<div class="form-group">
															
															<input type="button"  id="btn_submit"
															class="btn btn-primary" onclick="submitBill()"
															value="BillDetail" />&nbsp;&nbsp;<input type="button"  id="btn_submit_pdf"
															class="btn btn-primary"
															value="PDF" /></div></td>

																

														</tr>
													</c:forEach>

												</tbody>
											</table>
										</div>



										<!-- <button class="btn btn-info pull-right"
								style="margin-right: 5px;" onclick="submitBill()">Get
								PDF</button> -->

										<input type="button" margin-right: 5px;" id="btn_submit"
											class="btn btn-primary" onclick="submitBill()"
											value="BillDetail" />
											<input type="button" id="expExcel" class="btn btn-primary" value="EXPORT TO Excel" onclick="createExel();" >
											 
									</div>
								</div>
							</form>
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

	<script type="text/javascript">
		function submitBill() {
			//submitBillForm.submit();
			// window.open("${pageContext.request.contextPath}/pdf?url=showBillPdf");

			// window.open("${pageContext.request.contextPath}/showBillListForPrint");
var form = document.getElementById("validation-form")
form.action = "${pageContext.request.contextPath}/getBillDetailForPrint";
form.submit();
		}
		$('#btn_submit')
				.click(
						function() {
							var form = document.getElementById("validation-form")
							form.action = "${pageContext.request.contextPath}/getBillDetailForPrint";
							form.submit();
						});	
		
	</script>


	<script type="text/javascript">
		
		$('#btn_submit_pdf')
				.click(
						function() {
							document.getElementById("validation-form").target = "_blank";

							var form = document.getElementById("validation-form");

							form.action = "${pageContext.request.contextPath}/getBillDetailForPrintPdf";
							form.submit();
						});
		function submitBillPdf() {
			document.getElementById("validation-form").target = "_blank";

			var form = document.getElementById("validation-form");

			form.action = "${pageContext.request.contextPath}/getBillDetailForPrintPdf";
			form.submit();
		}
		
	</script>
<script type="text/javascript">
	function validate() {

		var selectedFr = $("#fr_id").val();
		var selectedRoute = $("#route_id").val();


		var isValid = true;
	
		if ((selectedFr == "" || selectedFr == null ) && (selectedRoute==0)) { 

				alert("Please Select Route  Or Franchisee");
				isValid = false;
		
		}
		return isValid;

	}
	</script>
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
		$(document).ready(function() {
			$('#callSubmit2').submit(function() {
				alert("searching");
				$.ajax({
					type : "get",
					url : "/getBillListProcess", //this is my servlet
					/*   data: "input=" +$('#ip').val()+"&output="+$('#op').val(), */
					success : function(data) {
						alert("success");

					}

				});
			});

		});
	</script>

	<script type="text/javascript">
		function callSearch() {

			//var frId = document.getElementById("fr_id").value;
			var array = [];
			var frIds = $("#fr_id").val();
			var fromDate = document.getElementById("dp1").value;
			var toDate = document.getElementById("dp2").value;

			var routeId = document.getElementById("route_id").value;
			var isValid=validate();
			if(isValid==true){
			$('#loader').show();

			$
					.getJSON(
							'${callGetBillListProcess}',
							{
								fr_id_list : JSON.stringify(frIds),
								from_date : fromDate,
								to_date : toDate,
								route_id : routeId,
								ajax : 'true'
							},
							function(data) {
								$('#table1 td').remove();
								$('#loader').hide();
								if (data == "") {
									alert("No Bill Found");
								}

								$
										.each(
												data,
												function(key, bill) {

													var tr = $('<tr></tr>');
													
															
													tr
															.append($(
																	'<td class="col-sm-1"></td>')
																	.html(
																			"<input type='checkbox' name='select_to_print' value="+bill.billNo+">"));

													tr.append($('<td class="col-sm-1"></td>')
															.html(key + 1));

													tr
															.append($(
																	'<td class="col-md-1"></td>')
																	.html(
																			bill.invoiceNo));

													tr
															.append($(
																	'<td class="col-md-1"></td>')
																	.html(
																			bill.billDate));

													tr.append($('<td class="col-md-2"></td>')
															.html(bill.frName));

													tr
															.append($(
																	'<td class="col-md-2" style="text-align:right;"></td>')
																	.html(
																			bill.taxableAmt.toFixed(2)));

													tr
															.append($(
																	'<td class="col-sm-1" style="text-align:right;"></td>')
																	.html(
																			bill.totalTax.toFixed(2)));

													tr
															.append($(
																	'<td class="col-md-1" style="text-align:right;"></td>')
																	.html(
																			bill.grandTotal.toFixed(2)));
													
													

													//tr.append($('<td></td>').html("<a href='${pageContext.request.contextPath}/updateBillDetails/"+bill.billNo+"/"+bill.frName+"'><input type='button' name='update' value='Update'/></a><a href='${pageContext.request.contextPath}/viewBillDetails/"+bill.billNo+"/"+bill.frName+"'><input type='button' name='view' value='View'/></a><a href='${pageContext.request.contextPath}/deleteBill/"+bill.billNo+"/"+bill.frName+"'><input type='button' name='deleteBill' value='Delete'/></a>"));
													
													
													tr.append($('<td class="col-md-2"></td>').html("<input type='button' id='btn_submit' name='btn_submit' onClick='submitBill()' value='BillDetail'  class='btn btn-primary'/> &nbsp;&nbsp; <input type='button' id='btn_submit_pdf' value='PDF'  class='btn btn-primary' onClick='submitBillPdf()'/>"));

													$('#table1 tbody').append(
															tr);

													/* var index = key + 1;
													
													var tr = "<tr>";

													var index = "<td>&nbsp;&nbsp;&nbsp;"
															+ index + "</td>";
															
													var billNo = "<td>&nbsp;&nbsp;&nbsp;"
															+ bill.billNo
															+ "</td>";
															
													var billDate = "<td>&nbsp;&nbsp;&nbsp;"
															+ bill.billDate
															+ "</td>";
															
													var frName = "<td>&nbsp;&nbsp;&nbsp;&nbsp;"
															+ bill.frName
															+ "</td>";
															
													var taxableAmt = "<td>&nbsp;&nbsp;&nbsp;&nbsp;"
															+ bill.taxableAmt
															+ "</td>";
															
													
													var totalTax = "<td>&nbsp;&nbsp;&nbsp;&nbsp;"
															+ bill.totalTax
															+ "</td>";
															
													var grandTotal = "<td>&nbsp;&nbsp;&nbsp;&nbsp;"
															+ bill.grandTotal
															+ "</td>"; 
															
															
													if (bill.status == 1) {
														var status = "<td>&nbsp;&nbsp;&nbsp;&nbsp;Pending</td>";

													} else if (bill.status == 2) {
														var status = "<td>&nbsp;&nbsp;&nbsp;&nbsp;Received</td>";

													} else if (bill.status == 3) {
														var status = "<td>&nbsp;&nbsp;&nbsp;&nbsp;GVN Applied/td>";

													} else if (bill.status == 4) {
														var status = "<td>&nbsp;&nbsp;&nbsp;&nbsp;GVN Approved</td>";

													} else if (bill.status == 5) {
														var status = "<td>&nbsp;&nbsp;&nbsp;&nbsp;GRN Applied</td>";

													} else if (bill.status == 6) {
														var status = "<td>&nbsp;&nbsp;&nbsp;&nbsp;GRN Approved</td>";

													} else if (bill.status == 7) {
														var status = "<td>&nbsp;&nbsp;&nbsp;&nbsp;Closed</td>";

													}
													
													var remark = "<td>&nbsp;&nbsp;&nbsp;&nbsp;"
															+ bill.remark
															+ "</td>";
															
													var action="<td>"+ "<a href='${pageContext.request.contextPath}/updateBillDetails/"+bill.billNo+"/"+bill.frName+"'><input type='button' name='update' value='Update'/></a><a href='${pageContext.request.contextPath}/viewBillDetails/"+bill.billNo+"/"+bill.frName+"'><input type='button' name='view' value='View'/></a><a href='${pageContext.request.contextPath}/deleteBill/"+bill.billNo+"/"+bill.frName+"'><input type='button' name='deleteBill' value='Delete'/></a>"+"</td>";

													var trclosed = "</tr>";

													$('#table1 tbody').append(tr);
													$('#table1 tbody').append(index);
													$('#table1 tbody').append(billNo);
													$('#table1 tbody').append(billDate);
													$('#table1 tbody').append(frName);
													$('#table1 tbody').append(taxableAmt);
													
													$('#table1 tbody').append(totalTax);
													$('#table1 tbody').append(grandTotal);
													$('#table1 tbody').append(status);
													$('#table1 tbody').append(remark);
													$('#table1 tbody').append(action);

													$('#table1 tbody').append(trclosed);
													 */
												})

							});
			}

		}
	</script>
	
	<script type="text/javascript">
	 
		function createExel() {
 
			var fromDate = document.getElementById("dp1").value;
			var toDate = document.getElementById("dp2").value;
			  var select_to_print = document.forms[0];
			 // alert(JSON.stringify(select_to_print));
    	var txt = "";
    	var i;
    	var flag=0;
    	var all=0;
    	 for (i = 0; i < select_to_print.length; i++) {
        if (select_to_print[i].checked  && select_to_print[i].value!="on") {
            txt = txt + select_to_print[i].value + ",";
            flag=1;
        }
    } 
			
			 if(flag==1)
				 {
			$
					.getJSON(
							'${excelForFrBill}',
							{
								checkboxes : txt ,
								all : all,
								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true'
							},
							function(data) {
								
							 alert("Excel Ready");
								 exportToExcel();
							 
							});
				 }
			 else
				 {
				 alert("Select Minimum 1 Bill ");
				 }

		}
		
		function exportToExcel()
		{
			alert("Export Excel");
			window.open("${pageContext.request.contextPath}/exportToExcel"); 
		}
	</script>


	<script>
	
		function selectBillNo(source) {
			checkboxes = document.getElementsByName('select_to_print');
			
			for (var i = 0, n = checkboxes.length; i < n; i++) {
				checkboxes[i].checked = source.checked;
			}
			
		}
		
	</script>
	<script type="text/javascript">
	$(document).ready(function () {
	    $(document).on('click', 'tbody tr', function () {
	        var checked= $(this).find('input[type="checkbox"]');
	        checked.prop('checked', !checked.is(':checked'));
	        $(this).toggleClass('selected'); // or anything else for highlighting purpose
	    });
	    $(document).on('click', 'input[type="checkbox"]', function () {
	        $(this).prop('checked', !$(this).is(':checked'));
	        $(this).parent('tr').toggleClass('selected'); // or anything else for highlighting purpose
	    });
	});
	</script>

</body>
</html>