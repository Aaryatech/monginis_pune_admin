<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  
	
<style>
@media only screen and (min-width: 1200px) {
	.franchisee_label, .menu_label {
		width: 22%;
	}
	.franchisee_select, .menu_select {
		width: 76%;
	}
	.date_label {
		width: 40%;
	}
	.date_select {
		width: 50%;
		padding-right: 0px;
	}
}
</style>
 
  	<style>
 table{
  width:100%;
 
  border:1px solid #ddd;
}
 </style>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>

<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
	<c:url var="getNonOrderFrList" value="/getNonOrderFrList"></c:url>
	<c:url var="getOrderItemList" value="/getOrderItemList"></c:url>

	


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
					<i class="fa fa-file-o"></i>Dump Orders
				</h1>
			</div>
		</div> -->
		<!-- END Page Title -->

	<form id="submitDumpOrderForm"
				action="${pageContext.request.contextPath}/submitDumpOrder" onsubmit="submitOrder.disabled = true; return confirm('Do you want to Submit ?');"
				method="post">
		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i>Dump Orders For Franchise
				</h3>

			</div>
			<div class="box-content">
				
					
					<div class="form-group">
				<label class=" col-md-2 control-label menu_label">Menu</label>
						<div class=" col-md-4 controls menu_select">

							<select data-placeholder="Choose Menu"
								class="form-control chosen" tabindex="6" id="selectMenu"
								name="selectMenu" onchange="getFr()">

								<option value="-1"><c:out value=""/></option>

								<c:forEach items="${unSelectedMenuList}" var="unSelectedMenu"
									varStatus="count">
									<option value="${unSelectedMenu.menuId}"><c:out value="${unSelectedMenu.menuTitle}"/></option>
								</c:forEach>


							</select>
						</div>
					<!-- </div>
					<div class="form-group col-md-8">
					<label class=" col-md-3 control-label franchisee_label"></label> -->
						<label class=" col-md-2 control-label menu_label">Previous Order
										Date
							</label>
						<div class=" col-md-4 controls menu_select">

							<input value="${todayDate}" class="form-control date-picker" id="dp2" size="16"
											type="text" name="order_date"/>
						</div>
					 </div>
					 <br><br>
					<div class="form-group"> 
<!-- 					<label class=" col-md-3 control-label franchisee_label"></label>
 -->								<label class=" col-md-2 control-label franchisee_label">Franchise </label>
						<div class=" col-md-4 controls franchisee_select">
							<select data-placeholder="Choose Franchisee"
								class="form-control chosen " multiple="multiple" tabindex="6"
								id="selectFr" name="selectFr">

								<%-- <option value="-1"><c:out value=""/></option>



								<c:forEach items="${unSelectedFrList}" var="fr"
									varStatus="count">
									<option value="${fr.frId}"><c:out value="${fr.frName}"/></option>
								</c:forEach> --%>



							</select>
						</div>
						<label class=" col-md-2 control-label franchisee_label">Discount % </label>
						<div class="col-md-1">
							<input type="text" name="discPer" id="discPer" value="0" class="form-control" width="30px"/>
						</div>
					<!-- </div>
					
					

				

				<div class="row">
					<div class="col-md-12" style="text-align: center"> -->
					
					
						<input type="button" id="searchFr" class="btn btn-info" value="Search"
							onclick="searchOrders()" />
						
					</div>
				</div>

				<div align="center" id="loader" style="display: none;background-color: white;">

					<span>
						<h4>
							<font color="#343690">Loading</font>
						</h4>
					</span> <span class="l-1"></span> <span class="l-2"></span> <span
						class="l-3"></span> <span class="l-4"></span> <span class="l-5"></span>
					<span class="l-6"></span>
				</div>

			</div>
		


		<div class="box">
		<!-- 	<div class="box-title">
				<h3>
					<i class="fa fa-list-alt"></i>Dump Orders
				</h3>

			</div> -->

		
				<div class=" box-content">
					<div id="table-scroll" class="table-scroll">
							 
									<div id="faux-table" class="faux-table" aria="hidden">
									<!-- <table id="table2" class="table table-advance" border="1">
											<thead>
												<tr class="bgpink">
												<th class="col-md-1"></th>
									
												</tr>
												</thead>
												</table> -->
									
									</div>
									<div class="table-wrap">
									
										<table id="table_grid" class="table table-advance" border="1">
											<thead>
												<tr class="bgpink">
											
												</tr>
												</thead>
					<!-- 	<div class="col-md-12 table-responsive">
							<table class="table table-advance "
								style="width: 100%" id="table_grid">
								<thead>
									<tr>
										
										
									</tr>

									

								</thead> -->
								<tbody>

								</tbody>
							</table>
						</div>
					



					<div class="row" align="center">
					<label class=" col-md-1 control-label franchisee_label">Production Date</label>
						<div class="col-sm-3 col-lg-2 controls">
										<input class="form-control date-picker" placeholder="dd-mm-yyyy" id="date" size="19"
											type="text" name="date" value="" required />
									</div>
				<label class=" col-md-1 control-label franchisee_label">Delivery Date</label>
						<div class="col-sm-3 col-lg-2 controls">
										<input class="form-control date-picker" placeholder="dd-mm-yyyy" id="deldate" size="19"
											type="text" name="deldate" value="" required />
									</div>
						<div class="col-md-offset-0 col-md-1" align="center">

							<button class="btn btn-info pull-left"
								style="margin-right: 5px;" onclick="submitOrder()" id="submitOrder" disabled>Submit</button>
						</div>
					</div>
				</div>
				</div>
			
		</div></form>
	</div>
	<!-- END Main Content -->
			<footer>
			<p>2019 © MONGINIS.</p>
			</footer>

	<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
		class="fa fa-chevron-up"></i></a>
		


	<script type="text/javascript">
	 
 
				function getFr() {
					 
					$.getJSON('${getNonOrderFrList}', {
						menu_id : $("#selectMenu").val(),
						ajax : 'true'
					}, function(data) {
						//alert(data);
						var html = '<option value="-1"><c:out value=""/></option>';

						

						var len = data.length;

						$('#selectFr')

					    .find('option')

					    .remove()

					    .end()

							

					    	//alert(len);

						for ( var i = 0; i < len; i++) {

							

							 $("#selectFr").append(

			                           $("<option ></option>").attr(

			                               "value", data[i].frId).text(data[i].frName)

			                       );

						} 
						$("#selectFr").trigger("chosen:updated");
	 
					});

				}
	
	</script>
<script type="text/javascript">
	
		function searchOrders() {
			
			
			$('#table_grid td').remove();
			$('#table_grid th').remove();
			
			var isValid = validate();
			
			if (isValid) {
				document.getElementById("searchFr").disabled=true;
				var selectedMenu = $("#selectMenu").val();
				var discPer = $("#discPer").val();
				var selectedFr = $("#selectFr").val();
				var preOrderDate = document.getElementById("dp2").value;
				franchasee();
				var frId = [];
			       
				
		        $.each($("#selectFr option:selected"), function(){            
		        	frId.push($(this).val());
		           
		            
		        });
				
		       
		        $('#loader').show();
				$.getJSON('${getOrderItemList}',{
					
									menu_id : selectedMenu,
									fr_id_list : JSON.stringify(frId),
									preOrder_Date : preOrderDate,
									ajax : 'true'

								},
								function(data) {

									//$('#table_grid td').remove();
											document.getElementById("searchFr").disabled=false;
									$('#loader').hide();

									if (data == "") {
										alert("No records found !!");

									}

									else{ 
										document.getElementById("submitOrder").disabled=false;
									$.each(data,function(key, orderdata) {

														var index = key + 1;

													 
														var tr = $('<tr></tr>');
														tr.append($('<td></td>').html(""+index));
													  	tr.append($('<td></td>').html(orderdata.itemName));
														tr.append($('<td></td>').html("<input type='text' name=disc_per"+orderdata.itemId+" style='width:45px' class='form-control' id=disc_per"+orderdata.itemId+" value="+discPer+" > "));
													  
													      $.each(frId, function(key, id){    
													    	 	 var qty=0;
													    	 	 if(orderdata.orderData!=null)
													    	 		 {
													    	  $.each(orderdata.orderData, function(key, frData){
													    	if (frData.frId==id){
													    	 qty=frData.orderQty;
													    	}
													    	 						    	
													    	
													    	  });	
													    	 		 }
													    		 //var orderQty = "<td align=center><input onkeypress='return IsNumeric(event);' ondrop='return false;' onpaste='return false;' type=number min=0 max=500 class=form-control   id=itemId"+orderdata.itemId+"orderQty"+ id+ " name=itemId"+orderdata.itemId+"orderQty"+id+" value = "+qty +"></td>"; 
																
													    		 tr.append($('<td></td>').html("<input onkeypress='return IsNumeric(event);' ondrop='return false;' style='  height: 24px;'  onpaste='return false;' type=number min=0 max=500 class=form-control   id=itemId"+orderdata.itemId+"orderQty"+ id+ " name=itemId"+orderdata.itemId+"orderQty"+id+" value = "+qty +">"));
													      });
													    
														
													  
  
													  	
													  	$('#table_grid tbody').append(tr);
													})
									}
														

								});

			}
		}
	</script>
	
	
	
		<script type="text/javascript">
		function validate() {
		
			var selectedMenu = $("#selectMenu").val();
			var selectedFr = $("#selectFr").val();
			var selectOrderDate =$("#dp2").val();
			

			var isValid = true;

			if($('#selectMenu :selected').text() == ''){
				    			
				isValid = false;
				alert("Please select Menu");

			} else if (selectedFr == "" || selectedFr == null) {

				isValid = false;
				alert("Please select Franchise");

			}
			else if (selectOrderDate == "" || selectOrderDate == null) {

				isValid = false;
				alert("Please select Previous Order Date");
			}
			return isValid;

		}
	</script>

	

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
function franchasee() {
        var frName = [];
       
        var i=0;
   
        var tr;
        tr = document.getElementById('table_grid').tHead.children[0];

        tr.insertCell(0).outerHTML = "<th>Sr.</th>"
        tr.insertCell(1).outerHTML = "<th>ItemName</th>"
        tr.insertCell(2).outerHTML = "<th>Disc%</th>"
        $.each($("#selectFr option:selected"), function(){            
        	frName.push($(this).text());
        	i++;
        });
        i=i-1;
        $.each(frName, function(){  
       
            tr.insertCell(3).outerHTML = "<th>"+frName[i] +"</th>"
            i--;
       });
        	
        
	}
	
	var specialKeys = new Array();
    specialKeys.push(8); //Backspace
    function IsNumeric(e) {
        var keyCode = e.which ? e.which : e.keyCode
        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1 || keyCode==9);
       // document.getElementById("error").style.display = ret ? "none" : "inline";
        return ret;
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