<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	 

	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	<body>
	
	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
<c:url var="gateEntryList" value="/gateEntryList"></c:url>
	<c:url var="editRmQtyOnGate" value="/editRmQtyOnGate"></c:url>
	<c:url var="deleteRmItem" value="/deleteRmItem"></c:url>
<c:url var="getRmItemsByGrp" value="/getRmItemsByGrp"></c:url>
<c:url var="getItemsByGrp" value="/getItemsByGrp"></c:url>

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
						<i class="fa fa-file-o"></i>Material Receipt Gate Entry
					</h1>
				</div>
			</div> -->
			<!-- END Page Title -->

			<div class="row">
				<div class="col-md-12">

					<div class="box">
						<div class="box-title">
							<h3>
								<i class="fa fa-table"></i>Add Gate Purchases
							</h3>
							
							<div class="box-tool">
								<a href="${pageContext.request.contextPath}/gateEntries">MRN ENTRY</a> <a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
							</div>
							
						</div>
						
						<form id="submitMaterialStore" action="${pageContext.request.contextPath}/materialReceiptStore" method="post"
							enctype="multipart/form-data">
						<div class="box-content">

							
							<div class="box-content">
								<div class="col-md-2">InwardNo:</div>
								<div class="col-md-1"><input type="text" id="mrn_no" name="mrn_no" value="${mrnno}" class="form-control" readonly>
								</div>
								
							<div class="col-md-1"> Date</div> 
							<div class="col-md-2">
							<jsp:useBean id="now" class="java.util.Date"/>    
                                   <%--  <fmt:formatDate value="${now}" pattern="dd-MMM-yyyy"/> --%>
                                    <input type="hidden" id="nowDate1" name="nowDate" value=" <fmt:formatDate value="${now}" pattern="dd-mm-yyyy"/>" class="form-control" readonly>
								<input class="form-control date-picker" id="date" size="16"
											type="text" name="nowDate" value="${date}" required />
							</div>
							<input type="hidden" id="rm_group" name="rm_group"  class="form-control" value="6" >
					<input type="hidden" id="no_of_items" name="no_of_items"  class="form-control" value="1" pattern="\d+" >
					<input type="hidden" id="remark" name="remark" class="form-control" >
					<input type="hidden" id="lr_no" name="lr_no"  value="0"	class="form-control"   >
					<input type="hidden" id="vehicle_no" name="vehicle_no"  value="0"class="form-control"   >
					<input type="hidden" id="tran_id" name="tran_id"  value="0" class="form-control" >	
					<input type="hidden" id="isGateDaily" name="isGateDaily" 
									class="form-control" value="1" >			<%-- <div class="col-md-2">
										<select name="rm_group" id="rm_group" class="form-control" tabindex="6">
										<option value="-1">Select Group</option>
											 <c:forEach items="${groupList}" var="groupList"
							varStatus="count">
							
									<c:choose>
													<c:when test="${groupList.grpId==grpId}">
														<option selected value="${groupList.grpId}"><c:out value="${groupList.grpName}"/></option>
												</c:when>
													<c:otherwise>
  														 <option value="${groupList.grpId}"><c:out value="${groupList.grpName}"/></option>
 													 </c:otherwise>
 													 </c:choose>
												</c:forEach>
						

										</select>
									</div> --%>
								<!-- 	<div class="col-md-2">Vehicle No</div>
									<div class="col-md-2">
									<input class="form-control" id="vehicle_no" size="16"
											type="text" name="vehicle_no"  required />
									</div> -->
								
									
									<!-- </div>
							<br>
							
							<div class="box-content"> -->
							
								<div class="col-md-2">Supplier</div>
									<div class="col-md-2">
									
									<select name="supp_id" id="supp_id" class="form-control chosen" tabindex="6" required>
											<option value="">Select Supplier</option>
											<c:forEach items="${supplierList}" var="supplierList"> 
												<option value="${supplierList.suppId}"><c:out value="${supplierList.suppName}"></c:out> </option>
											 </c:forEach>
										</select>
									
									</div>
								
				 <!-- 
							</div><br>
							
							
							<div class="box-content"> -->
							
						<%-- 	<div class="col-md-2" >LR No</div>
									<div class="col-md-2">
										<input type="text" id="lr_no" name="lr_no" 
									class="form-control" pattern="\d+" required >
									</div>
									
									<div class="col-md-2">Transporter</div>
									<div class="col-md-2">
									
									<select name="tran_id" id="tran_id" class="form-control chosen" tabindex="6" required>
									<option  value="">Select Transporter</option>
									<c:forEach items="${transporterList}" var="transporterList">
                                              
                                              
								<option value="${transporterList.tranId}"><c:out value="${transporterList.tranName}"></c:out> </option>
													

											</c:forEach>
									</select>
								</div>
								 --%>
							</div>
							<input type="hidden"class="file-input" name="image1" id="image1"/>
							<input type="hidden"class="file-input" name="image2" id="image2" />						 
							<!-- <br>
							
							
							
							<div class="box-content">
							
									<div class="col-md-2" >Remark</div>
									<div class="col-md-6"><input type="text" id="remark" name="remark" class="form-control" required>
									</div> -->
									
									<!-- <div class="col-md-2">No of Items</div> -->
										<!-- <div class="col-md-3"> --><input type="hidden" id="no_of_items" name="no_of_items"  class="form-control" value="1" pattern="\d+" required>
									<!-- </div> -->
							
						<!-- 	</div><br>
							
							
							<div class="box-content">
								 <div class="form-group"> -->
									
								<!-- 	<div class="col-md-1">Image1</div> -->
								<!-- 	<div class="col-md-1">
										<div class="fileupload fileupload-new"
											data-provides="fileupload">
											<div class="fileupload-new img-thumbnail"
												style="width: 00px; height: 00px;">
												<img
													src="http://www.placehold.it/150x150/EFEFEF/AAAAAA&amp;text=no+image"
													alt="" />
											</div>
											<div
												class="fileupload-preview fileupload-exists img-thumbnail"
												style="max-width:00px; max-height:00px; line-height: 00px;"></div>
											<div>
												<span class="btn btn-default btn-file"><span
													class="fileupload-new">Select image1</span> <span
													class="fileupload-exists">Change</span> <input type="file"
													class="file-input" name="image1" id="image1"
													 /></span> <a href="#"
													class="btn btn-default fileupload-exists"
													data-dismiss="fileupload">Remove</a>
											</div>
										</div>

									</div> -->
									<!-- <div class="col-md-1"></div> -->
									<!-- <div class="col-md-1">Image2</div> -->
								<!-- 	<div class="col-md-1">
										<div class="fileupload fileupload-new"
											data-provides="fileupload">
											<div class="fileupload-new img-thumbnail"
												style="width: 0px; height: 00px;">
												<img
													src="http://www.placehold.it/150x150/EFEFEF/AAAAAA&amp;text=no+image"
													alt="" />
											</div>
											<div
												class="fileupload-preview fileupload-exists img-thumbnail"
												style="max-width:00px; max-height:00px; line-height:0px;"></div>
											<div>
												<span class="btn btn-default btn-file"><span
													class="fileupload-new">Select image2</span> <span
													class="fileupload-exists">Change</span> <input type="file"
													class="file-input" name="image2" id="image2"
													 /></span> <a href="#"
													class="btn btn-default fileupload-exists"
													data-dismiss="fileupload">Remove</a>
											</div>
										</div>

									</div>
									
								</div> --><br><br><br>
							</div>
						<%-- 	<div style="box-shadow: 0 6px 20px 0 rgba(38, 198, 218, 0.5);  "><br>
						<div class="box-content">
								
									<div class="col-md-2" >Select Raw Material Name</div>
									<div class="col-md-3">
										<select data-placeholder="Select RM Name" class="form-control chosen" name="rm_id" tabindex="-1"
											id="rm_id" required>
											<option selected value="">Select Raw Material Name</option>
											
											<c:forEach items="${rmlist}" var="rmlist">
                                              
                                              
														<option value="${rmlist.rmId}"><c:out value="${rmlist.rmName}"></c:out> </option>
													

											</c:forEach>
											</select>
									</div>
									
									
									<div class="col-md-2" for="rm_qty">Qty</div>
									<div class="col-md-3">
										<input type="text" name="rm_qty" id="rm_qty"
											placeholder="Qty" class="form-control"
											 pattern="\d+" required/>
												 
									</div>
									
									
									
									<div class="col-md-2">
									
								<div><input type="button" class="btn btn-info pull-right" onclick="addItem()" value="Add Item"></div>
					 
									</div>
								</div> --%>
						<!-- 	
							
								<div align="center" id="loader" style="display: none">

							<span>
								<h4>
									<font color="#343690">Loading</font>
								</h4>
							</span> <span class="l-1"></span> <span class="l-2"></span> <span
						class="l-3"></span> <span class="l-4"></span> <span class="l-5"></span>
					<span class="l-6"></span>
				</div> -->
											
							
							
							<div class=" box-content">
					<div class="row">
						<div class="col-md-12 table-responsive">
							<table class="table table-bordered table-striped fill-head "
								style="width: 100%" id="table_grid">
								<thead style="background-color:#f3b5db ;">
									<tr>
										<th>Sr.No.</th>
										<th class="col-md-4">Name</th> 
										<th>Qty</th>

									</tr>
								</thead>
								<tbody>
                                   <c:forEach items="${rmlist}" var="rmList"
															varStatus="count">
															<tr>
																<td><c:out value="${count.index+1}" /></td>

																<td align="left"><c:out value="${rmList.rmName}" /></td>

																<td align="left"><input type="number" id="recdQty${count.index}" name="recdQty${count.index}" onkeyup="changeQty(${count.index+1});" value="${rmList.recdQty}" class="form-control"></td>

                                   </tr>
                                   </c:forEach>
								</tbody>
							</table>
						</div>
					</div>
								
							<br><br>	
							<div class="form-group">
									<div class="col-sm-9 col-sm-offset-3 col-lg-5 col-lg-offset-5">
										<input type="submit" class="btn btn-primary" value="Submit" onclick="check();">
<!-- 										<button type="button" class="btn">Cancel</button>
 -->									</div>
								</div>
						<br><br>
							
							</div>

						</form>
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
		
		
		function addItem() {

			
				var rm_id = $("#rm_id").val();
				var rm_qty = $("#rm_qty").val();
				var rm_group = $("#rm_group").val();
				if(validation()==true){	
					
				
				$('#loader').show();

				$
						.getJSON(
								'${gateEntryList}',

								{
									 
									rm_id : rm_id,
									rm_qty : rm_qty,
									rm_group:rm_group,
									ajax : 'true'

								},
								function(data) {

									$('#table_grid td').remove();
									$('#loader').hide();

									if (data == "") {
										alert("No records found !!");

									}
								 
  
								  $.each(
												data,
												function(key, itemList) {
												

													var tr = $('<tr></tr>');

												  	tr.append($('<td></td>').html(key+1));

												  	tr.append($('<td></td>').html(itemList.rmName));
												  	

												  	tr.append($('<td></td>').html('<input type="text" id="recdQty'+key+'" onkeyup="changeQty('+key+');" value="'+itemList.recdQty+'" class="form-control" disabled="true">'));
												  	tr.append($('<td></td>').html('<span class="glyphicon glyphicon-edit" id="edit'+key+'" onclick="edit('+key+');"> </span><span style="visibility: hidden;" class="glyphicon glyphicon-ok" onclick="submit('+key+');" id="ok'+key+'"></span><span class="glyphicon glyphicon-remove"  onclick="del('+key+')" id="del'+key+'"></span>'));
												    $('#table_grid tbody').append(tr);

													 
 
												})  
								});

			 
		}
				
				
			
	}
		
		function edit(key)
		{
			
			document.getElementById("recdQty"+key).disabled = false;
			document.getElementById("edit"+key).style.visibility="hidden";
			document.getElementById("ok"+key).style.visibility="visible";
			
			//style="visibility: hidden;"
		}
		function submit(key)
		{
			
			var qty=document.getElementById("recdQty"+key).value;
			document.getElementById("recdQty"+key).disabled = true;
			document.getElementById("edit"+key).style.visibility="visible";
			document.getElementById("ok"+key).style.visibility="hidden";
			
			$
			.getJSON(
					'${editRmQtyOnGate}',

					{
						 
						index : key,
						updateQty : qty,
					
						ajax : 'true'

					},
					function(data) {
						
					});
			
			
		}
		function del(key)
		{
			
			var key=key;
			$('#loader').show();
			$
			.getJSON(
					'${deleteRmItem}',

					{
						 
						index : key,
						ajax : 'true'

					},
					function(data) {
						
						$('#table_grid td').remove();
						$('#loader').hide();

						if (data == "") {
							alert("No records found !!");

						}
					 

					  $.each(
									data,
									function(key, itemList) {
									

										var tr = $('<tr></tr>');
										var tr = $('<tr></tr>');
										tr.append($('<td></td>').html(key+1));
										tr.append($('<td></td>').html(itemList.rmName));
									  	tr.append($('<td></td>').html('<input type="text" id="recdQty'+key+'" onkeyup="changeQty('+key+');" value="'+itemList.recdQty+'" class="form-control" disabled="true">'));
									  	tr.append($('<td></td>').html('<span class="glyphicon glyphicon-edit" id="edit'+key+'" onclick="edit('+key+');"> </span><span style="visibility: hidden;" class="glyphicon glyphicon-ok" onclick="submit('+key+');" id="ok'+key+'"></span><span class="glyphicon glyphicon-remove"  onclick="del('+key+')" id="del'+key+'"></span>'));
									    $('#table_grid tbody').append(tr);
									  	
									})
						
					});
			
			
		}
	</script>
<script type="text/javascript">
function validation()
{
	
	var rm_id = $("#rm_id").val();
	var rm_qty = $("#rm_qty").val();
	var isValid = true;
	if(isNaN(rm_id) || rm_id < 0 || rm_id=="")
	{
	isValid = false;
	alert("Please enter Raw Material");
	}
	
	else if(isNaN(rm_qty) || rm_qty < 0 || rm_qty=="")
	{
	isValid = false;
	alert("Please enter Quantity");
	}
	
return isValid;
	
}
function check()
{
	
	var supp_id = $("#supp_id").val();
	var tran_id = $("#tran_id").val();
	if(supp_id=="")
		{
		alert("Select Supplier");
		}
	else if(tran_id=="")
	{
	alert("Select Tranporter");
	}
}
</script>

<script type="text/javascript">
$(document).ready(function() {
	
	
    $('#rm_group').change(
            function() {
            	
            	if(($(this).val())==1){
                $.getJSON('${getRmItemsByGrp}', {
                	grpId : $(this).val(),
                    ajax : 'true'
                }, function(data) {
                    var len = data.length;

					$('#rm_id')
				    .find('option')
				    .remove()
				    .end()
				    $("#rm_id").append(
                                 $("<option></option>").attr(
                                     "value","0").text("Select Rm Item")
                             );
                    for ( var i = 0; i < len; i++) {
                    	 
                                
                        $("#rm_id").append(
                                $("<option></option>").attr(
                                    "value", data[i].rmId).text(data[i].rmName)
                            );
                    }

                    $("#rm_id").trigger("chosen:updated");
                });
            	}else
            	if(($(this).val())==2 || ($(this).val())==3){
                    $.getJSON('${getItemsByGrp}', {
                    	grpId : $(this).val(),
                        ajax : 'true'
                    }, function(data) {
                        var len = data.length;

    					$('#rm_id')
    				    .find('option')
    				    .remove()
    				    .end()
    				    $("#rm_id").append(
                                     $("<option></option>").attr(
                                         "value","0").text("Select Rm Item")
                                 );
                        for ( var i = 0; i < len; i++) {
                        	 
                                    
                            $("#rm_id").append(
                                    $("<option></option>").attr(
                                        "value", data[i].id).text(data[i].itemName)
                                );
                        }

                        $("#rm_id").trigger("chosen:updated");
                    });
                	}
            });
});
</script>
	
								
							
	
</body>
</html>