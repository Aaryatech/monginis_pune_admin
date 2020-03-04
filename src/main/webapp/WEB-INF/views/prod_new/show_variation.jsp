<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date"%>
<style>
table {
	border: 1px solid #ddd;
}
.form-control1 {
	display: block;
	width: 100%;
	height: 34px;
	padding: 5px 5px;
	font-size: 14px;
	line-height: 1.428571429;
	color: #555;
	vertical-align: middle;
	background-color: #fff;
	background-image: none;
	border: 1px solid #ccc;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	-webkit-transition: border-color ease-in-out .15s, box-shadow
		ease-in-out .15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>
	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
	<c:url var="getProdForVariation" value="/getProdForVariationProcess"></c:url>
	<c:url var="getFinGoodStockByOrder" value="/getFinGoodStockByOrder"></c:url>


	<c:url var="finishedGoodDayEnd" value="/finishedGoodDayEnd"></c:url>


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
						<i class="fa fa-file-o"></i>Finished Goods Stock
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
								<i class="fa fa-bars"></i> Finished Goods Stock Prod Variation
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
							<form class="form-horizontal" id="validation-form1" method="post"
								style="background-color: #ffffff;" action="insertProdForVaria">


								<div class="form-group">
<div class="colOuter">

										<div class="col-md-1">
											<div class="col1title">Previous Menu</div>
										</div>
										<div class="col-md-9" align="left">
											<select class="form-control chosen" tabindex="6"
												name="menuIds" id="menuIds" multiple="multiple">
												<option value="" disabled>Select Menu</option>
												<option value="0" >No Menu</option>
												<c:forEach items="${menuList}" var="menuList">
												<c:if test="${menuList.mainCatId==2}">
													<option value="${menuList.menuId}">${menuList.menuTitle}</option>
</c:if>
												</c:forEach>

											</select>

										</div>

									</div>

								<div class="form-group">
								</div>

									<div class="colOuter">
										<div class="col-md-1">
											<div class="col1title">Date:</div>
										</div>
										<div class="col-md-3" align="left">

											<input class="form-control date-picker"
												placeholder="From Date" name="from_datepicker"
												id="from_datepicker" type="text">

										</div>

										<div class="col-md-1"></div>

										<div class="col-md-1">
											<div class="col1title">Menu</div>
										</div>
										<div class="col-md-3" align="left">
											<select class="form-control chosen" tabindex="6"
												name="menuId" id="menuId">
												<option value="" disabled>Select Menu</option>
												
												<c:forEach items="${menuList}" var="menuList">
												<c:if test="${menuList.mainCatId==2}">
													<option value="${menuList.menuId}">${menuList.menuTitle}</option>
</c:if>
												</c:forEach>

											</select>

										</div>
										<div class="col-sm-2">

											<input type="button" class="btn btn-info" name="submit"
												value="Search " onclick="searchItemsByCategory()" />


										</div>

									</div>


								</div>



								<div class="form-group">


									<div align="center" id="loader" style="display: none">

										<span>
											<h3>
												<font color="#343690">Loading</font>
											</h3>
										</span> <span class="l-1"></span> <span class="l-2"></span> <span
											class="l-3"></span> <span class="l-4"></span> <span
											class="l-5"></span> <span class="l-6"></span>
									</div>
								</div>
								<input type="hidden" id="selectedCatId" name="selectedCatId" />

						<!-- 	</form>
							<form method="post" id="validation-form"> -->

								<div class="box" style="background-color: #ffffff;">
									
									<div style="background-color: #ffffff;">
										<div
											class="col-sm-25 col-sm-offset-3 col-lg-30 col-lg-offset-4"
											id="dayEndDiv">
											<input type="submit" class="btn btn-danger"
												value="Add to Prod" id="dayEndButton" disabled="disabled" />
												
									
	<span class="validation-invalid-label"
												id="showErrorMsg" style="display: none; color: red;" >Please close previous productions first !!</span>
												
												<input type="button" value="PDF" class="btn btn-primary"
													onclick="genPdf()" />
													
										</div>

										<div class="box-content">
<%-- 												<jsp:include page="/WEB-INF/views/include/tableSearch.jsp"></jsp:include>
 --%>
											<div class="clearfix"></div>
											<div id="table-scroll" class="table-scroll">
												<div id="faux-table" class="faux-table" aria="hidden">
													<table class="table table-advance" id="table" border="1"
														width="100%">
														<thead>

														</thead>

													</table>
												</div>
												<div class="table-wrap">
													<table class="table table-advance" id="table1" border="1"
														width="100%">
														<thead>
															<tr class="bgpink">
																<th class="col-md-1" align="left">Sr</th>
																	<th class="col-md-1" align="left">ID</th>
																<th class="col-md-2" align="left">Item</th>
																<th class="col-md-1" align="center">Current Stock</th>
																<th class="col-md-1" align="center">Menu Order Qty</th>
																<th class="col-md-1" align="center">Variation</th>
															</tr>
														</thead>
														<tbody>

														</tbody>
													</table>
												</div>
											</div>

										</div>

										<div align="center" class="form-group"
											style="background-color: #ffffff;">

											<div
												class="col-sm-25 col-sm-offset-3 col-lg-30 col-lg-offset-0">
												<!-- 										<input type="submit" class="btn btn-primary" value="Submit">
 -->
												<input type="button" id="expExcel" class="btn btn-primary"
													value="EXPORT TO Excel" onclick="exportToExcel();" disabled>


											</div>

										</div>

										<!-- <input type="button" class="btn btn-primary"
										value="Closing Qty PDF" id="PDFButtonClosing"
										onclick="genClosingQtyPdf()" disabled> <input
										type="button" id="expExcelClosing" class="btn btn-primary"
										value="EXPORT TO Excel For Closing Qty"
										onclick="exportToExcel2();" disabled> <input
										type="button" class="btn btn-primary" value="Summery PDF"
										id="PDFButtonSummery" onclick="genSummeryPdf()" disabled>
									<input type="button" id="expExcelSummery"
										class="btn btn-primary" value="EXPORT TO Excel Summery"
										onclick="exportToExcel1();" disabled> -->
									</div>
								</div>
							</form>
						</div>


					</div>
					</form>
				</div>
			</div>
		</div>


		<!-- END Main Content -->
		<footer>
			<center>
				<p>2018 © MONGINIS.</p>
			</center>
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
		function searchItemsByCategory() {
			//$('#table_grid td').remove();
			var from_datepicker = $('#from_datepicker').val();
			var menuId = $('#menuId').val();
			
			var menuId = $('#menuId').val();
		var menuName=	$("#menuId option:selected").text();
//alert(menuName)
			//	alert("Hi" +from_datepicker +"menu id " +menuId)
		    document.getElementById("dayEndButton").disabled = true;
			var selectedMenu = $("#menuIds").val();

			$('#loader').show();
			$
					.getJSON(
							'${getProdForVariation}',
							{
								menuId : menuId,
								menu_id_list : JSON.stringify(selectedMenu),

								menuName : menuName,
								from_datepicker : from_datepicker,
								ajax : 'true',
							},
							function(data) {
								$('#table1 td').remove();
								//$('#table1 tbody').remove();
								$("#showErrorMsg").hide();	
								$('#loader').hide();
								//alert(data.status)	
								//data.status=0;
								if (parseInt(data.status)==1) {
									document.getElementById("dayEndButton").disabled = false;
									$("#showErrorMsg").hide();	
								} else if (data.status == 0) {
									document.getElementById("dayEndButton").disabled = true;
									$("#showErrorMsg").show();
								}

								if (data == "") {
									alert("No records found !!");
								}
								$
										.each(
												data.prodVarList,
												function(key, stock) {
													//alert(stock)
													var index = key + 1;

													var tr = "<tr>";

													var index = "<td>" + index
															+ "</td>";
															
															var item_id = "<td>" + stock.id
															+ "</td>";

													var itemName = "<td>"
															+ stock.itemName
															+ "</td>";
													var curStock = 0;
													curStock = (parseFloat(stock.opTotal)
															+ (parseFloat(stock.productionQty)
																	- parseFloat(stock.rejectedQty)) - parseFloat(stock.otherMenuOrderQty));
													//alert(curStock);

													var menuOrdQty = "<td>"
															+ stock.selMenuOrderQty
															+ "</td>";
													var variation = 0;
													variation = (parseFloat(curStock) - parseFloat(stock.selMenuOrderQty));
													//alert(variation);
													var posvariation = 0;//parseInt(variation)*-1;

													if (parseInt(variation) < 0) {
														posvariation = parseInt(variation)* -1;
													} else {
														posvariation = "-";
													}

													var tr4,tr5,tr6;
													tr4  = "<td>" + curStock
													+ "</td>";
													
													tr6  = "<td>" + posvariation
													+ "</td>";


													var trclosed = "</tr>";

													$('#table1 tbody').append(
															tr);
													$('#table1 tbody').append(
															index);
													
													$('#table1 tbody').append(
															item_id);
													$('#table1 tbody').append(
															itemName);
													$('#table1 tbody').append(
															tr4);
													$('#table1 tbody').append(
															menuOrdQty);


													$('#table1 tbody').append(
															tr6);

													$('#table1 tbody').append(
															trclosed);
												})
											
							});
		}
	</script>

	<script type="text/javascript">
		$('#dayEndButton')
				.click(
						function() {
								var dayEnd = confirm("Confirm Add to Production !!");
								if (dayEnd == true) {
									var form = document.getElementById("validation-form1")

									 //alert(form);
									form.action ="${pageContext.request.contextPath}/insertProdForVaria";
									form.submit();

								}
						
						});
	</script>
	


	<script type="text/javascript">
		function genClosingQtyPdf() {

			window.open('${pageContext.request.contextPath}/closingQtyPdf');

		}

		function genSummeryPdf() {

			window.open('${pageContext.request.contextPath}/summeryPdf');

		}

		function exportToExcel1() {

			window.open("${pageContext.request.contextPath}/exportToExcel1");
			document.getElementById("expExcelSummery").disabled = true;
		}

		function exportToExcel2() {

			window.open("${pageContext.request.contextPath}/exportToExcel2");
			document.getElementById("expExcelClosing").disabled = true;
		}
	</script>

	<script>
		function showDiv(elem) {
			if (elem.value == 1) {
				document.getElementById('select_month_year').style = "display:none";
				document.getElementById('select_date').style = "display:none";
				document.getElementById("dayEndDiv").style.display = "block";

			} else if (elem.value == 2) {
				document.getElementById('select_month_year').style.display = "block";
				document.getElementById('select_date').style = "display:none";
			} else if (elem.value == 3) {
				document.getElementById('select_date').style.display = "block";
				document.getElementById('select_month_year').style = "display:none";
				document.getElementById('type').value = 1;
				document.getElementById('select_menu').style = "display:none";
				$("#type").trigger("chosen:updated");
				document.getElementById("dayEndDiv").style.display = "block";
			}

		}
		function exportToExcel() {

			window.open("${pageContext.request.contextPath}/exportToExcel");
			document.getElementById("expExcel").disabled = true;
		}
		function onTypeChange(type) {
			if (type == 1) {
				document.getElementById("dayEndDiv").style.display = "block";
				document.getElementById('select_menu').style = "display:none";
			} else {
				document.getElementById("dayEndDiv").style = "display:none";

				document.getElementById('select_date').style = "display:none";
				document.getElementById('select_menu').style.display = "block";
				document.getElementById('selectStock').value = 1;
				$("#selectStock").trigger("chosen:updated");
			}
		}
	</script>
	
	<script>
function myFunction() {
	//alert("Hi")
  var input, filter, table, tr, td, i,td1,td2;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("table1");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[1];
    td1 = tr[i].getElementsByTagName("td")[2];
    td2 = tr[i].getElementsByTagName("td")[3];
    if (td||td1||td2) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else  if (td1.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      }else   if (td2.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      }else {
        tr[i].style.display = "none";
      }
    }    
   
    
  }
}
</script>
<script type="text/javascript">

function genPdf(){
	window.open('${pageContext.request.contextPath}/currentStockPdf/');
}

</script>
</body>

</html>