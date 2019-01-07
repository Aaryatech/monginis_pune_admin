<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body onload="onRmIdChange(${rmId})">

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>




	<c:url var="getRmRateVerification" value="/getRmRateVerification" />
	<c:url var="getUomTax" value="/getUomTax" />


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
			<div class="page-title">
				<div>
					<h1>
						<i class="fa fa-file-o"></i>Raw Material Master
					</h1>

				</div>
			</div>
			<!-- END Page Title -->


			<c:set var="isView" value="0">
			</c:set>
			<c:set var="isAdd" value="0">
			</c:set>

			<c:forEach items="${sessionScope.newModuleList}" var="modules">
				<c:forEach items="${modules.subModuleJsonList}" var="subModule">

					<c:choose>
						<c:when
							test="${subModule.subModuleMapping eq 'showRmRateVerification'}">
							<c:choose>
								<c:when test="${subModule.view=='visible'}">
									<c:set var="isView" value="1">
									</c:set>
								</c:when>
								<c:otherwise>
									<c:set var="isView" value="0">
									</c:set>
								</c:otherwise>
							</c:choose>


							<c:choose>
								<c:when test="${subModule.addApproveConfig=='visible'}">
									<c:set var="isAdd" value="1">
									</c:set>
								</c:when>
								<c:otherwise>
									<c:set var="isAdd" value="0">
									</c:set>
								</c:otherwise>
							</c:choose>


						</c:when>
					</c:choose>
				</c:forEach>
			</c:forEach>





			<!-- BEGIN Main Content -->
			<div class="row">
				<div class="col-md-12">
					<div class="box">
						<div class="box-title">
							<h3>
								<i class="fa fa-bars"></i>Raw material Rate Verification
							</h3>
							<div class="box-tool">
								<a href=""></a> <a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
							</div>
							<!-- <div class="box-tool">
								<a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a> <a data-action="close" href="#"><i
									class="fa fa-times"></i></a>
							</div> -->
						</div>


						<div class="box-content">
							<form action="${pageContext.request.contextPath}/submitRmRateVerification" method="post"
								class="form-horizontal" id="validation-form"
								enctype="multipart/form-data" method="post">

								<div class="form-group">

									<%-- <label class="col-sm-3 col-lg-2 control-label">Select
										Supplier</label>
									<div class="col-sm-6 col-lg-4 controls">
										<select name="supp_id" id="supp_id"
											class="form-control chosen">
											<option value="-1">Select Supplier</option>
											<c:forEach items="${supplierList}" var="supplierList"
												varStatus="count">
												<option value="${supplierList.suppId}"><c:out value="${supplierList.suppName}"/></option>
											</c:forEach>
										</select>
									</div> --%>
									<input type="hidden" name="grpId" id="grpId" value="${groupId}"/>
									
									<label class="col-sm-1 col-lg-1 control-label">RM</label>
									<div class="col-sm-6 col-lg-2 controls">
										<select name="rm_id" id="rm_id" onchange="onRmIdChange(this.value)" class="form-control chosen">
											<option value="-1">Select Material</option>
											<c:choose>
											
											<c:when test="${groupId==2 || groupId==3}">
											
											<c:forEach items="${itemList}" var="itemList"
												varStatus="count">
												<c:choose>
												<c:when test="${rmId==itemList.id}">
												<option value="${itemList.id}" selected><c:out value="${itemList.itemName}"/></option>
												</c:when>
												<c:otherwise>
												<option value="${itemList.id}"><c:out value="${itemList.itemName}"/></option>
												</c:otherwise>
												</c:choose>
												
											</c:forEach>
											</c:when>
											<c:otherwise>
											<c:forEach items="${RawmaterialList}" var="RawmaterialList"
												varStatus="count">
												<c:choose>
												<c:when test="${rmId==RawmaterialList.rmId}">
												<option value="${RawmaterialList.rmId}" selected><c:out value="${RawmaterialList.rmName}"/></option>
												</c:when>
												<c:otherwise>
												<option value="${RawmaterialList.rmId}"><c:out value="${RawmaterialList.rmName}"/></option>
												</c:otherwise>
												</c:choose>
												
											</c:forEach>
											
											
											</c:otherwise>
											</c:choose>
										</select>
									</div>



								
							
									<label class="col-sm-3 col-lg-1 control-label">UOM </label>
									<div class="col-sm-6 col-lg-2 controls">
										<input type="text" name="uom_id" id="uom_id"
											class="form-control" disabled="disabled" />
									</div>
									<label class="col-sm-3 col-lg-2 control-label">Tax
										Description </label>
									<div class="col-sm-6 col-lg-2 controls">
										<input type="text" name="tax_desc" id="tax_desc"
											class="form-control" disabled="disabled" /> <input
											type="hidden" name="tax_id" id="tax_id">
									</div>

								
								
								
									<div class="col-md-1" >
										<input type="button" id="search" class="btn btn-info"
											value="Search" onclick="onRmChange()" />



									</div>
								</div>
								<hr>



								<div class="form-group">
                                      <label class="col-sm-3 col-lg-1 control-label">Supplier</label>
									<div class="col-sm-6 col-lg-2 controls">
										<select name="supp_id" id="supp_id" onchange="onSearch()"
											class="form-control chosen">
											<option value="-1">Select Supplier</option>
											<c:forEach items="${supplierList}" var="supplierList"
												varStatus="count">
												<option value="${supplierList.suppId}"><c:out value="${supplierList.suppName}"/></option>
											</c:forEach>
										</select>
									</div> 
									<label class="col-sm-3 col-lg-1 control-label">Rate Date </label>
									<div class="col-sm-6 col-lg-2 controls">
										<input class="form-control date-picker" id="dp2" size="16"
											type="text" name="curr_rate_date" value="${currentDate}" data-rule-required="true" />
									</div>


									<!-- <label class="col-sm-3 col-lg-2 control-label"></label> -->
									<!-- <div class="col-sm-6 col-lg-4 controls">
										 	</div> -->

								<!-- </div>


								<div class="form-group"> -->
									<!-- <div class="col-sm-6 col-lg-2 controls">
										<label class=" "><b>Tax Rate Extra</b></label>
									</div>

									<div class="col-sm-6 col-lg-2 controls" >
										<label class=" "><b>Tax Rate Include </b></label>
									</div> -->
							<!-- 	</div>

								<div class="form-group"> -->
<!-- 
									<label class="col-sm-3 col-lg-1 control-label">Current
										Rate </label> -->
									<div class="col-sm-6 col-lg-2 controls">
										<input type="text" name="curr_rate_tax_extra"
											id="curr_rate_tax_extra" class="form-control"
											placeholder="Tax Rate Extra" data-rule-required="true"
											pattern="[+-]?([0-9]*[.])?[0-9]+" />
									</div>


									<!-- <label class="col-sm-3 col-lg-2 control-label"></label> -->
									<div class="col-sm-6 col-lg-2 controls">
										<input type="text" name="curr_rate_tax_incl"
											id="curr_rate_tax_incl" class="form-control"
											placeholder="Tax Rate Inclusive" data-rule-required="true"
											pattern="[+-]?([0-9]*[.])?[0-9]+" />
									</div>
	<c:choose>

											<c:when test="${isAdd==1}">
												<input type="submit" class="btn btn-primary" id="submit"
													value="Add" >

											</c:when>
											<c:otherwise>
												<input type="submit" class="btn btn-primary" id="submit"
													value="Add" disabled>

											</c:otherwise>
										</c:choose> 
								</div>
                         	<div class="box-content" >
					<div class="row">
						<div class="col-md-12 table-responsive">
							<table class="table table-bordered table-striped fill-head "
							 id="table_grid1">
								<thead style="background-color: #f3b5db;">
									<tr>
										<th>Sr.No.</th>
										<th>Name</th>
										<th>Mobile</th>
										<th>City</th>
										<th>State</th>
										<th>Lead Time</th>
										<th>Rate Inclusive</th>
										<th>Rate Extra</th>

									</tr>
								</thead>
								<tbody>
	                <c:forEach items="${supplierLists}" var="supplier" varStatus="count">
											<tr>
												<td>	
											<c:out value="${count.index+1}"/>  
												</td>
												<td align="left"><c:out
														value="${supplier.suppName}" /></td>
											
												<td align="left"><c:out
														value="${supplier.suppMob1}" /></td>
											
												<td align="left"><c:out
														value="${supplier.suppCity}" /></td>		
								        		<td align="left"><c:out
						  								value="${supplier.suppState}" /></td>		
										        <td align="left"><c:out
														value="${supplier.suppEmail5}" /></td>	
												 <td align="left"><c:out
														value="${supplier.suppPhone1}" /></td>	
												<td align="left"><c:out
														value="${supplier.suppPhone2}" /></td>		
												<%-- <td align="left"><a
													href="${pageContext.request.contextPath}/showDirectPurchaseOrder/${supplier.suppId}">PO</a></td>	 --%>
														</tr>
														
										</c:forEach>  
								</tbody>
							</table>
						</div>
					</div>

 
		</div>
		
		<hr>	<div class="col-sm-6 col-lg-5 controls"  id="sup" style="color:green;"></div><br><div class="form-group">
		
		
							 
									<label class="col-sm-3 col-lg-2 control-label" id="date1">
									</label> <input type="hidden" name="rate_date" id="rate_date">
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="rate_tax_extra" id="rate_tax_extra"
											class="form-control" disabled="disabled" /> <input
											type="hidden" name="tax_extra" id="tax_extra">
									</div>

<!-- 									<label class="col-sm-3 col-lg-2 control-label"> </label>
 -->									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="rate_tax_incl" id="rate_tax_incl"
											class="form-control" disabled="disabled" /> <input
											type="hidden" name="tax_incl" id="tax_incl">
									</div>

								</div> 

								 <div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label" id="date2">
									</label> <input type="hidden" name="rate_date1" id="rate_date1">
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="rate_tax_extra1" id="rate_tax_extra1"
											class="form-control" disabled="disabled" /> <input
											type="hidden" name="tax_extra1" id="tax_extra1">
									</div>

<!-- 									<label class="col-sm-3 col-lg-2 control-label">Last Date 1 Tax Rate Extra</label>
 -->									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="rate_tax_incl1" id="rate_tax_incl1"
											class="form-control" disabled="disabled" /> <input
											type="hidden" name="tax_incl1" id="tax_incl1">
									</div>
								</div>

							 	<div class="form-group">

									<label class="col-sm-3 col-lg-2 control-label" id="date3">
									</label> <input type="hidden" name="rate_date2" id="rate_date2">
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="rate_tax_extra2" id="rate_tax_extra2"
											class="form-control" disabled="disabled" />
									</div>


<!-- 									<label class="col-sm-3 col-lg-2 control-label">Last Date 2</label>
 -->									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="rate_tax_incl2" id="rate_tax_incl2"
											class="form-control" disabled="disabled" />
									</div>
								</div> 
								<input type="hidden" name="rm_rate_ver_id" id="rm_rate_ver_id">

								<div class="row">
									<div class="col-md-12" style="text-align: center">


									<%-- 	<c:choose>

											<c:when test="${isAdd==1}">
												<input type="submit" class="btn btn-primary" id="submit"
													value="Submit" >

											</c:when>
											<c:otherwise>
												<input type="submit" class="btn btn-primary" id="submit"
													value="Submit" disabled>

											</c:otherwise>
										</c:choose>  --%>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="${pageContext.request.contextPath}/showRawMaterial"><input type="button" class="btn btn-info" value="Back to Raw Material List"></a>	
										<!-- <input type="button" id="search" class="btn btn-info"
											value="Edit" onclick="onEdit()" /> -->


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
			function onRmIdChange(rmId) {
				
				var grpId = $("#grpId").val();
			
				$.getJSON('${getUomTax}', {
					rmId : rmId,
					grpId:grpId,
					ajax : 'true'
				}, function(data) {
					 
					document.getElementById("uom_id").value=data.uom;
					document.getElementById("tax_id").value=data.taxId;
					document.getElementById("tax_desc").value=data.taxDesc;
					
				

				});
			}
function onSearch()
{	
	 




	var selectedRmId = $("#rm_id").val();
	var selectedSuppId = $("#supp_id").val();
	var grpId = $("#grpId").val();
   var supName=$("#supp_id  option:selected").text(); 
   document.getElementById("sup").innerHTML="Rate Of "+supName;

   
    
	$.getJSON('${getRmRateVerification}',{
		
						rm_id : selectedRmId,
						supp_id : selectedSuppId,
						grpId:grpId,
						ajax : 'true'

					},
					function(data) {

document.getElementById('date1').innerHTML = data.rateDate;

document.getElementById("rate_date").value=data.rateDate;
document.getElementById("tax_extra").value=data.rateTaxExtra;
document.getElementById("rate_tax_extra").value=data.rateTaxExtra;
document.getElementById("tax_incl").value=data.rateTaxIncl;
document.getElementById("rate_tax_incl").value=data.rateTaxIncl;


document.getElementById('date2').innerHTML = data.date1;

document.getElementById("rate_date1").value=data.date1;
document.getElementById("tax_extra1").value=data.rateTaxExtra1;
document.getElementById("rate_tax_extra1").value=data.rateTaxExtra1;
document.getElementById("tax_incl1").value=data.rateTaxIncl1;
document.getElementById("rate_tax_incl1").value=data.rateTaxIncl1;

document.getElementById('date3').innerHTML = data.date2;

document.getElementById("rate_date2").value=data.date1;
document.getElementById("rate_tax_extra2").value=data.rateTaxExtra2;
document.getElementById("rate_tax_incl2").value=data.rateTaxIncl2;
document.getElementById("rm_rate_ver_id").value=data.rmRateVerId;
document.getElementById("submit").disabled=false;

					});
}

function onEdit()
{	
	

	document.getElementById("dp2").value=document.getElementById("rate_date").value;
	document.getElementById("rate_date").value=document.getElementById("rate_date1").value;
	document.getElementById("rate_date1").value=document.getElementById('rate_date2').value;
		
	document.getElementById("curr_rate_tax_extra").value=document.getElementById("tax_extra").value;
	document.getElementById("tax_extra").value=document.getElementById("tax_extra1").value;
	document.getElementById("tax_extra1").value=document.getElementById("rate_tax_extra2").value;
	
	document.getElementById("curr_rate_tax_incl").value=document.getElementById("tax_incl").value;
	document.getElementById("tax_incl").value=document.getElementById("tax_incl1").value;
	document.getElementById("tax_incl1").value=document.getElementById("rate_tax_incl2").value;
	
	/* document.getElementById("tax_extra").value;
	document.getElementById("rate_tax_extra").value;
	document.getElementById("tax_incl").value;
	document.getElementById("rate_tax_incl").value;


	

	document.getElementById("rate_date1").value;
	document.getElementById("tax_extra1").value;
	document.getElementById("rate_tax_extra1").value;
	document.getElementById("tax_incl1").value;
	document.getElementById("rate_tax_incl1").value;

	
	document.getElementById("rate_tax_extra2").value;
	document.getElementById("rate_tax_incl2").value;
	document.getElementById("rm_rate_ver_id").value;
	
	
	
	
	
	
	
	document.getElementById('date1').innerHTML = data.rateDate;

	document.getElementById("rate_date").value=data.rateDate;
	document.getElementById("tax_extra").value=data.rateTaxExtra;
	document.getElementById("rate_tax_extra").value=data.rateTaxExtra;
	document.getElementById("tax_incl").value=data.rateTaxIncl;
	document.getElementById("rate_tax_incl").value=data.rateTaxIncl;


	document.getElementById('date2').innerHTML = data.date1;

	document.getElementById("rate_date1").value=data.date1;
	document.getElementById("tax_extra1").value=data.rateTaxExtra1;
	document.getElementById("rate_tax_extra1").value=data.rateTaxExtra1;
	document.getElementById("tax_incl1").value=data.rateTaxIncl1;
	document.getElementById("rate_tax_incl1").value=data.rateTaxIncl1;

	document.getElementById('date3').innerHTML = data.date2;
	document.getElementById("rate_tax_extra2").value=data.rateTaxExtra2;
	document.getElementById("rate_tax_incl2").value=data.rateTaxIncl2;
	document.getElementById("rm_rate_ver_id").value=data.rmRateVerId; */
}
</script>
<script type="text/javascript">
function onRmChange()
{
	var grpId  = $("#grpId").val();
	var selectedRmId = $("#rm_id").val();
    window.location.href = "${pageContext.request.contextPath}/showRmRateVerification/"+grpId+'/'+selectedRmId;

}
</script>
</body>
</html>