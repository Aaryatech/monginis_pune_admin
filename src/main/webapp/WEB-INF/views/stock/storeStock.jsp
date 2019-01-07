<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	 

	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	 
	
	<!--  <style type="text/css">
	table {
            width: 100%;
        }

        thead, tbody, trtd, , th { display: block; }

        tr:after {
            content: ' ';
            display: block;
            visibility: hidden;
            clear: both;
        }

        thead th {
            height: 35px;

             text-align: left; 
        }

        tbody {
            height: 500px;
            overflow-y: auto;
           
        }

        thead {
             fallback  
        }

 
	 
	   tbody td, thead th {
            width: 16.2%;
            float: left;
        }
	</style> -->
	 
	<body>
 	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
<c:url var="getCurrentStoreStock" value="/getCurrentStoreStock" />
<c:url var="getMonthWiseStoreStock" value="/getMonthWiseStoreStock" />
<c:url var="getDateWiseStoreStock" value="/getDateWiseStoreStock" />
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
						<i class="fa fa-file-o"></i>Store
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
								<i class="fa fa-bars"></i>Search Store Stock
							</h3>
							<div class="box-tool">
								<a href=""></a> <a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
							</div>
							
						</div>


						<div class="box-content">
							<%-- <form action="${pageContext.request.contextPath}/getBmsStock"
								class="form-horizontal" method="post" id="validation-form">
							 --%>	



								<div class="form-group">
									<label class="col-sm-3 col-lg-1 control-label">Option</label>
									<div class="col-sm-5 col-lg-2 controls">
										<select name="selectStock"  class="form-control chosen"
											tabindex="6" id="selectStock" onchange="showDiv(this)"
											required>

											<option value="-1">Select Option</option>
											<option value="1" id="currentStock">Get Current Stock</option>
										<option value="2" id="monthStock">Get Stock Between Month</option>
											<option value="3" id="dateStock">Get Stock Between Dates</option>

										</select>
									</div>
                                   <label class="col-sm-2 col-lg-1 control-label">Group</label>
														<div class="col-sm-1 col-lg-2 controls">
															<select data-placeholder="Select Category"
																class="form-control chosen" tabindex="6" name="group_id" onchange="onGrpChange(this.value)"
																id="group_id">
																	<option value="0">Select Group</option>
																<c:choose>
																<c:when test="${subCatId==1}">
                                                                    <option  value="1" selected><c:out value="Raw Materials"/></option>
																	<option  value="2"><c:out value="Packing Materials"/></option>
                                                                    <option  value="3"><c:out value="Celebrations & Party Items"/></option>
                                                                </c:when>
                                                                <c:when test="${subCatId==2}">
                                                                    <option  value="1" ><c:out value="Raw Materials"/></option>
																	<option  value="2" selected><c:out value="Packing Materials"/></option>
                                                                    <option  value="3"><c:out value="Celebrations & Party Items"/></option>
                                                                </c:when>
                                                                <c:when test="${subCatId==3}">
                                                                    <option  value="1" ><c:out value="Raw Materials"/></option>
																	<option  value="2"><c:out value="Packing Materials"/></option>
                                                                    <option  value="3" selected><c:out value="Celebrations & Party Items"/></option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                 <option  value="1" ><c:out value="Raw Materials"/></option>
																 <option  value="2"><c:out value="Packing Materials"/></option>
                                                                 <option  value="3" ><c:out value="Celebrations & Party Items"/></option>
                                                       
                                                                </c:otherwise>
																</c:choose>
															</select>
														</div>
								<!--	</div>
								
							<br/>

						 <div class="form-group">
								<div> -->
									<div  style="display: none"
										id=select_month_year>
										<!-- <div class="col-md-1">
											 From :
										</div> -->
										<div class="col-md-2">


											  <input type='text' placeholder="Select From Date" 
												name="from_stockdate" id="from_stockdate"  class="form-control date-picker" required /> 
												 
										</div> 

										 
<!-- 
										<div class="col-md-1">
										To :
										</div> -->
										<div class="col-md-2">
											<input type='text' placeholder="Select To Date" 
												name="to_stockdate" id="to_stockdate"  class="form-control date-picker" required />
										</div>

									
</div>
									<!-- <div class="colOuter" style="display: none" id=select_date>
										<div class="col-md-2"><br/>
											<div class="col1title">From Date:</div>
										</div>
										<div class="col-md-3" align="center">

											<input id="fromdatepicker" class="form-control date-picker"
												placeholder="From Date" name="from_datepicker" type="text">

										</div>

										<div class="col-md-1"></div>

										<div class="col-md-2">
											<div class="col1title">To Date:</div>
										</div>
										<div class="col-md-3" align="center">
											<input id="todatepicker" class="form-control date-picker"
												placeholder="To Date" name="to_datepicker" type="text">

										</div>

									</div> -->

								<!-- </div>

							</div> --><!-- <br/><br/> --> 
							
							<!-- <div class="row"> -->
					<div class="col-md-1" >
						<input type="button"  class="btn btn-primary" value="Get Stock" onclick="getStock()">
					 


				<!-- 	</div> -->
				</div><br/>
							
							<!-- </form> -->


							<form action="${pageContext.request.contextPath}/dayEndStoreStock"
								class="form-horizontal" method="post" id="validation-form">

<input type="hidden" id="subCat" name="subCat"/>
			<div align="center" id="loader" style="display:none">

	<span>
	<h6><font color="#343690">Loading</font></h6></span>
	<span class="l-1"></span>
	<span class="l-2"></span>
	<span class="l-3"></span>
	<span class="l-4"></span>
	<span class="l-5"></span>
	<span class="l-6"></span>
	</div>
	
								<div class="box1">
									<!-- <div class="box-title">
										<h3>
											<i class="fa fa-table"></i> BMS Stock List
										</h3>
										<div class="box-tool">
											<a data-action="collapse" href="#"><i
												class="fa fa-chevron-up"></i></a>
											<a data-action="close" href="#"><i class="fa fa-times"></i></a>
										</div>
									</div> -->

									<div class="box-content">
<jsp:include page="/WEB-INF/views/include/tableSearch.jsp"></jsp:include>

										<div class="clearfix"></div>
										<div class="table-responsive" style="display: none;" id="div1">
											<table
												class="table table-advance table-responsive table-position"
												id="table1">
												<thead style="background-color:#f3b5db;">
													<tr>

														<th class="col-md-1">Sr No</th>
														<th class="col-md-1">Code</th>
														<th class="col-md-2">Material Name</th>
														<th class="col-md-2">Inward Qty</th>
														<th class="col-md-1">BOM Qty</th>
														 
														<th class="col-md-1">Op Stock</th>
														<th class="col-md-1">Clos Qty</th>
														<th class="col-md-1">Min Qty</th>
														<th class="col-md-1">Max Qty</th>
														<th class="col-md-1">ROL Qty</th>
													<!-- 	<th>Status</th> -->

													</tr>

												</thead>
												 <tbody>
													<%--<c:forEach items="${stockList}" var="stockList"
														varStatus="count">

														<tr>
															<td><c:out value="${count.index+1}"></c:out></td>
															<td><c:out value="${stockList.rmName}"></c:out></td>
															<td><c:out value="${stockList.invertQty}"></c:out>
															</td>
															<td><c:out value="${stockList.bomQty}"></c:out>
															</td>
															 
															<td><c:out value="${stockList.openingQty}"></c:out>
															<td><c:out value="${stockList.closingQty}"></c:out>
															<td><c:out value="Status"></c:out></td>

														</tr>
													</c:forEach>--%>
												</tbody> 

											</table>
										</div>
											<div class="table-responsive" style="display: none;" id="div2">
											<table
												class="table table-advance table-responsive table-position"
												id="table2">
												<thead style="background-color:#f3b5db;">
													<tr>

														<th class="col-md-1">Sr No</th>
														<th class="col-md-3">Material Name</th>
														<th class="col-md-2">Inward Qty</th>
														<th class="col-md-2">BOM Qty</th>
														 
														<th class="col-md-2">Op Stock</th>
														<th class="col-md-2">Clos Qty</th>
														
													<!-- 	<th>Status</th> -->

													</tr>

												</thead>
												 <tbody>
													<%--<c:forEach items="${stockList}" var="stockList"
														varStatus="count">

														<tr>
															<td><c:out value="${count.index+1}"></c:out></td>
															<td><c:out value="${stockList.rmName}"></c:out></td>
															<td><c:out value="${stockList.invertQty}"></c:out>
															</td>
															<td><c:out value="${stockList.bomQty}"></c:out>
															</td>
															 
															<td><c:out value="${stockList.openingQty}"></c:out>
															<td><c:out value="${stockList.closingQty}"></c:out>
															<td><c:out value="Status"></c:out></td>

														</tr>
													</c:forEach>--%>
												</tbody> 

											</table>
										</div>
<input type="hidden" id="stockDate">
										<!-- this is for ajax call<input type="submit" class="btn btn-primary" value="Submit"
										id="callSubmit" onclick="callSubmitGrn(); getGrnId();"> -->


										 
											 <div class="row">
					<div class="col-md-12" style="text-align: center" >

											<input type="button" value="Day End Process"
												class="btn btn-warning" id="submitDay" onclick="dayEnd()"  disabled="disabled">  

</div>
										</div>
										<!-- </form> -->

									</div>
								</div>

							</form>
						</div>
					</div>
				</div>
			</div></div></div>
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
		$("#datepicker").datepicker({
			format : "mm-yyyy",
			startView : "months",
			minViewMode : "months"
		});
	</script>
	<script>
		/* function showDiv(elem) {
			if (elem.value == 1) {
				document.getElementById('select_month_year').style = "display:none";
				document.getElementById('select_date').style = "display:none";
			} else if (elem.value == 2) {
				document.getElementById('select_month_year').style.display = "block";
				document.getElementById('select_date').style = "display:none";
			} else if (elem.value == 3) {
				document.getElementById('select_date').style.display = "block";
				document.getElementById('select_month_year').style = "display:none";
			}
		}
		 */
		 </script>
			<script>
		 
			//document.getElementById("stockDate").value;
			
			var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!

var yyyy = today.getFullYear();
if(dd<10){
    dd='0'+dd;
} 
if(mm<10){
    mm='0'+mm;
} 
var today = dd+'-'+mm+'-'+yyyy;


//document.getElementById("stockDate").value = today;


		function getStock(){
			 
			  var selectId=document.getElementById("selectStock").value;
			  var grpId=document.getElementById("group_id").value;
			if(selectId!='-1')
			  {
			   if(selectId==1) {
			        document.getElementById("div1").style.display="block";
			        document.getElementById("div2").style.display="none";
				   $('#loader').show();
					$.getJSON('${getCurrentStoreStock}', {
						fromDate : fromDate,
						toDate : toDate,
						grpId:grpId,
						ajax : 'true'
					}, function(data) {
						$('#loader').hide();
						$('#table1 td').remove();
						if(data=="")
						{
						alert("No Record Found");
						}
					else
						{
					
						 document.getElementById("submitDay").disabled = false;
					 
					 $.each(data,function(key, stockList) {
												 
					var tr = $('<tr></tr>');

				  	tr.append($('<td class="col-md-1"></td>').html(key+1));			  	
				  	tr.append($('<td class="col-md-1"></td>').html(stockList.rmCode));
				  	tr.append($('<td class="col-md-2"></td>').html(stockList.rmName));
				  	tr.append($('<td class="col-md-2"></td>').html(stockList.purRecQty));
				  	tr.append($('<td class="col-md-1"></td>').html(stockList.bmsIssueQty));
				  	tr.append($('<td class="col-md-1"></td>').html(stockList.storeOpeningStock));
				  	tr.append($('<td class="col-md-1"></td>').html(stockList.storeClosingStock));
				  	tr.append($('<td class="col-md-1"></td>').html(stockList.rmMinQty));
				  	tr.append($('<td class="col-md-1"></td>').html(stockList.rmMaxQty));
				  	tr.append($('<td class="col-md-1"></td>').html(stockList.rmRolQty));

				  	//alert(stockList.storeStockDate);
				  	document.getElementById("stockDate").value = stockList.storeStockDate;
				$('#table1 tbody').append(tr);
				
											})
											
						}
					});
				} 
			  
			   else if(selectId==2){
				   document.getElementById("div1").style.display="none";
			        document.getElementById("div2").style.display="block";
			        
				var fromDate=document.getElementById("from_stockdate").value;
				  var toDate=document.getElementById("to_stockdate").value;
				 
				if(fromDate!=null && fromDate!="" && toDate!=null && toDate!=""){
					$('#loader').show();
				$.getJSON('${getMonthWiseStoreStock}', {
					fromDate : fromDate,
					toDate : toDate,
					grpId:grpId,
					ajax : 'true'
				}, function(data) {
					$('#loader').hide();
					$('#table2 td').remove();
					if(data=="")
					{
						alert("No Record Found");
					}
				else
					{
					

				 
				 $.each(data,function(key, stockList) {
											
				var tr = $('<tr></tr>');

			  	tr.append($('<td class="col-md-1"></td>').html(key+1));			  	
			  	tr.append($('<td class="col-md-3"></td>').html(stockList.rmName));
			  	tr.append($('<td class="col-md-2"></td>').html(stockList.purRecQty));
			  	tr.append($('<td class="col-md-2"></td>').html(stockList.bmsIssueQty));
			  	tr.append($('<td class="col-md-2"></td>').html(stockList.storeOpeningStock));
			  	tr.append($('<td class="col-md-2"></td>').html(stockList.storeClosingStock));
			  	document.getElementById("stockDate").value = stockList.storeStockDate;

			$('#table2 tbody').append(tr);
			
										})
										
					}
										
					});
				}
				else{
				alert("Please Select Months");
				}
			}
			else if(selectId=3){
				 document.getElementById("div1").style.display="none";
			        document.getElementById("div2").style.display="block";
				var fromDate=document.getElementById("from_stockdate").value;
				  var toDate=document.getElementById("to_stockdate").value;
				 
				if(fromDate!=null && fromDate!="" && toDate!=null && toDate!=""){
					  $('#loader').show();
					$.getJSON('${getDateWiseStoreStock}', {
						fromDate : fromDate,
						toDate : toDate,
						grpId:grpId,
						ajax : 'true'
					}, function(data) {
					 
						$('#loader').hide();
						$('#table2 td').remove();
						if(data=="")
						{
						alert("No Record Found");
						}
					else
						{
						
					 
					 $.each(data,function(key, stockList) {
												 
					var tr = $('<tr></tr>');

				  	tr.append($('<td class="col-md-1"></td>').html(key+1));			  	
				  	tr.append($('<td class="col-md-3"></td>').html(stockList.rmName));
				  	tr.append($('<td class="col-md-2"></td>').html(stockList.purRecQty));
				  	tr.append($('<td class="col-md-2"></td>').html(stockList.bmsIssueQty));
				  	tr.append($('<td class="col-md-2"></td>').html(stockList.storeOpeningStock));
				  	tr.append($('<td class="col-md-2"></td>').html(stockList.storeClosingStock));
				$('#table2 tbody').append(tr);
				
											})
											
						}
					});
				}
				else{
					alert("Please Select Dates");
					}
			}
			
			
		}else
			{
			alert("Please Select Stock Type");
			}
		}
		
		
		function dayEnd()
		{
			var stockDate=document.getElementById("stockDate").value;
			if(stockDate>today)
				alert(" You can't day end today, please try tomarrow !!");
			else{
				  document.getElementById("validation-form").submit();
			}
		}
	</script>
	 
	 <script>
	 $(document).ready(function() { 
	$('#selectStock').change(
			function() {
				//alert("hh");
				var select=$(this).val();
			 
				
				if (select == 1) {
					document.getElementById('select_month_year').style = "display:none";
					document.getElementById('submitDay').disabled =true;
				} else if (select == 2) {
					document.getElementById('select_month_year').style.display = "block";

				  	document.getElementById('submitDay').disabled =true; 
				} else if (select == 3) {

				  	document.getElementById('submitDay').disabled =true; 
					document.getElementById('select_month_year').style.display = "block";
				}
				
				

			});

});
	 
	 </script>
	 <script type="text/javascript">
	 function onGrpChange(grpId)
	 {
		 
		 document.getElementById("subCat").value=grpId;
		 document.getElementById("submitDay").disabled = true;

	 }
	 
	 </script>
</body>
</html>


