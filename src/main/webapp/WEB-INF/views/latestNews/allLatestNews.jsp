<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	<body>
	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tableSearch.css">
	
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
						<i class="fa fa-file-o"></i> Latest News
					</h1>
				</div>
			</div> -->
			<!-- END Page Title -->

			<div class="row">
				<div class="col-md-12">

					<div class="box">
						<div class="box-title">
							<h3>
								<i class="fa fa-table"></i> Latest News List
							</h3>
							<div class="box-tool">
								<a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
								<!--<a data-action="close" href="#"><i class="fa fa-times"></i></a>-->
							</div>
						</div>

       	<div class="box-content">
<div class="col-md-9" ></div> 
					<label for="search" class="col-md-3" id="search">
    <i class="fa fa-search" style="font-size:20px"></i>
									<input type="text"  id="myInput" onkeyup="myFunction()" style="border-radius: 25px;" placeholder="Search by message.." title="Type in a name">
										</label>  

							<div class="clearfix"></div>
							
							
							
							
							
								<div id="table-scroll" class="table-scroll">
							 
									<div id="faux-table" class="faux-table" aria="hidden">
									<table id="table2" class="table table-advance">
											<thead>
												<tr class="bgpink">
					                    <th width="17" style="width: 18px">SELECT</th>
										    <th width="17" style="width: 18px">#</th>
											<th width="163" align="left">Date</th>
											<th width="358" align="left">Message</th>
											<th width="194" align="left">Occasion Name</th>
											<th width="102" align="left">Status</th>
											<th width="88" align="left">Action</th>
												</tr>
												</thead>
												</table>
									
									</div>
									<div class="table-wrap">
									
										<table id="table1" class="table table-advance">
											<thead>
										<tr class="bgpink">
								            <th width="17" style="width: 18px">SELECT</th>
											<th width="17" style="width: 18px">#</th>
											<th width="163" align="left">Date</th>
											<th width="358" align="left">Message</th>
											<th width="194" align="left">Occasion Name</th>
											<th width="102" align="left">Status</th>
											<th width="88" align="left">Action</th>
										</tr>
												</thead>
												<tbody>
											
	<%int c=1; %>
										<c:forEach items="${schedulerList}" var="schedulerList">



											<tr>
						<td><input type="checkbox" class="chk" name="select_to_print" id="${schedulerList.schId}"	value="${schedulerList.schId}"/></td>
					
												<td>	<%=c++%>
											<c:out
														value="${c}" /> 
												</td>
												<td align="left"><c:out
														value="${schedulerList.schDate} - ${schedulerList.schTodate}" /></td>
												<td align="left"><c:out
														value="${schedulerList.schMessage}" /></td>
												<td align="left"><c:out
														value="${schedulerList.schOccasionname}" /></td>
														
														<c:choose>
																			<c:when test="${schedulerList.isActive==1}">
																			<td align="left"><c:out value="Active"></c:out></td>
																				
																			</c:when>
																			<c:otherwise>
																			<td align="left"><c:out value="In Active"></c:out></td>
																				
																			</c:otherwise>
																			
																			
																		</c:choose>
														
														
												<%-- <td align="left"><c:out
														value="${schedulerList.isActive}" /></td> --%>
												<td align="left"><a
													href="updateNews/${schedulerList.schId}"><span
														class="glyphicon glyphicon-edit"></span></a>&nbsp;&nbsp;&nbsp;&nbsp;

													<a href="deleteNews/${schedulerList.schId}"
													onClick="return confirm('Are you sure want to delete this record');"><span
														class="glyphicon glyphicon-remove"></span></a></td>
											</tr>
										</c:forEach>



							</tbody>

						</table>
					</div>
				</div>
				
				
               <div >&nbsp;&nbsp;&nbsp;&nbsp;
               	<input type="button" margin-right: 5px;" id="btn_delete"
											class="btn btn-primary" onclick="deleteById()" 
											value="Delete" />
               
               </div>

						<%-- <div class="box-content">

							<div class="clearfix"></div>

							<div class="table-responsive" style="border: 0">
								<table width="100%" class="table table-advance" id="table1">
									<thead>
										<tr>
											<th width="17" style="width: 18px">#</th>
											<th width="163" align="left">Date</th>
											<th width="358" align="left">Message</th>
											<th width="194" align="left">Occasion Name</th>
											<th width="102" align="left">Status</th>
											<th width="88" align="left">Action</th>
										</tr>
									</thead>
									<tbody>
									<%int c=1; %>
										<c:forEach items="${schedulerList}" var="schedulerList">



											<tr>
												<td>	<%=c++%>
											<c:out
														value="${c}" /> 
												</td>
												<td align="left"><c:out
														value="${schedulerList.schDate} - ${schedulerList.schTodate}" /></td>
												<td align="left"><c:out
														value="${schedulerList.schMessage}" /></td>
												<td align="left"><c:out
														value="${schedulerList.schOccasionname}" /></td>
														
														<c:choose>
																			<c:when test="${schedulerList.isActive==1}">
																			<td align="left"><c:out value="Active"></c:out></td>
																				
																			</c:when>
																			<c:otherwise>
																			<td align="left"><c:out value="In Active"></c:out></td>
																				
																			</c:otherwise>
																			
																			
																		</c:choose>
														
														
												<td align="left"><c:out
														value="${schedulerList.isActive}" /></td>
												<td align="left"><a
													href="updateNews/${schedulerList.schId}"><span
														class="glyphicon glyphicon-edit"></span></a>&nbsp;&nbsp;&nbsp;&nbsp;

													<a href="deleteNews/${schedulerList.schId}"
													onClick="return confirm('Are you sure want to delete this record');"><span
														class="glyphicon glyphicon-remove"></span></a></td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
						</div> --%></div>
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
</body>
<script>
function myFunction() {
  var input, filter, table, tr, td, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("table1");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[2];
    if (td) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}
</script>
<script type="text/javascript">
function deleteById()
{

var checkedVals = $('.chk:checkbox:checked').map(function() {
    return this.value;
}).get();
checkedVals=checkedVals.join(",");

if(checkedVals=="")
	{
	alert("Please Select Record")
	}
else
	{
	window.location.href='${pageContext.request.contextPath}/deleteNews/'+checkedVals;

	}

}
</script>
</html>