<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

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
						<i class="fa fa-file-o"></i> Route
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
								<i class="fa fa-bars"></i> Edit Route Tray Management
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
							<form action="editRouteProcessMgmt" class="form-horizontal"
								method="post" id="validation-form">



								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">Route</label>
									<div class="col-sm-9 col-lg-10 controls">
										<input type="text" name="route_name" id="route_name"
											placeholder="Route" class="form-control"
											value="${route.routeName }" data-rule-required="true" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">ABC Type</label>
									<div class="col-sm-3 col-lg-3 controls">
										<select class="form-control chosen" name="acbType"
											id="acbType">
											<c:choose>
												<c:when test="${route.routeType==1}">
													<option value="1" selected>A</option>
													<option value="2">B</option>
													<option value="3">C</option>
												</c:when>
												<c:when test="${route.routeType==2}">
													<option value="1">A</option>
													<option value="2" selected>B</option>
													<option value="3">C</option>
												</c:when>
												<c:when test="${route.routeType==3}">
													<option value="1">A</option>
													<option value="2">B</option>
													<option value="3" selected>C</option>
												</c:when>
												<c:otherwise>
													<option value="1">A</option>
													<option value="2">B</option>
													<option value="3">C</option>
												</c:otherwise>
											</c:choose>


										</select>
									</div>

									<label class="col-sm-3 col-lg-2 control-label">Delivery
										Type</label>
									<div class="col-sm-6 col-lg-4 controls">
										<select class="form-control chosen" name="isSameDay"
											id="isSameDay">

											<c:choose>
												<c:when test="${route.isSameDay==1}">

													<option value="1" selected>First Delivery</option>
													<option value="2">Second Delivery</option>
												</c:when>
												<c:when test="${route.isSameDay==2}">
													<option value="1">First Delivery</option>
													<option value="2" selected>Second Delivery</option>
												</c:when>

												<c:otherwise>
													<option value="1">First Delivery</option>
													<option value="2">Second Delivery</option>
												</c:otherwise>
											</c:choose>



										</select>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">Seq. No.</label>
									<div class="col-sm-3 col-lg-3 controls">
										<input type="number" name="seqNo" id="seqNo"
											value="${route.srNo}" placeholder="Route"
											class="form-control" data-rule-required="true" />
									</div>


									<div class="form-group row">
										<label class="col-sm-3 col-lg-2 control-label">Select
											Franchise</label>
										<div class="col-sm-6 col-lg-4">
											<select data-placeholder="Choose Franchisee"
												class="form-control chosen" multiple="multiple" tabindex="6"
												id="frIds" name="frIds" onchange="disableRoute()">


												<c:forEach items="${unSelectedFrList}" var="location">
													<c:set var="flag" value="0"></c:set>
													<c:forEach items="${frIdList}" var="selFr"
														varStatus="count2">
														<c:choose>
															<c:when test="${selFr==location.frId}">
																<option selected value="${location.frId}"><c:out
																		value="${location.frName}" /></option>
																<c:set var="flag" value="1"></c:set>
															</c:when>
															<c:otherwise>

															</c:otherwise>
														</c:choose>
													</c:forEach>
													<c:choose>
														<c:when test="${flag==0}">
															<option value="${location.frId}"><c:out
																	value="${location.frName}" /></option>
														</c:when>
													</c:choose>
												</c:forEach>

											</select> <span class="validation-invalid-label" id="error_locId"
												style="display: none;">This field is required.</span>
										</div>
									</div>



								</div>

								<div class="form-group">
									<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2">
										<button type="submit" class="btn btn-primary"
											style="width: 70px">Save</button>
										<!--<button type="button" class="btn">Cancel</button>-->
									</div>
								</div>

							</form>
							<!-- newly added /form to be tested -->


							<div class="box">
								<div class="box-title">
									<h3>
										<i class="fa fa-table"></i> Route Tray Management List
									</h3>
									<div class="box-tool">
										<a data-action="collapse" href="#"><i
											class="fa fa-chevron-up"></i></a>
										<!--<a data-action="close" href="#"><i class="fa fa-times"></i></a>-->
									</div>
								</div>

								<div class="box-content">
									<jsp:include page="/WEB-INF/views/include/tableSearch.jsp"></jsp:include>
									<div class="clearfix"></div>
									<div class="table-responsive" style="border: 0">
										<table width="100%" class="table table-advance" id="table1">
											<thead style="background-color: #f3b5db;">
												<tr>
													<th width="45" style="width: 18px">Select</th>


													<th width="500" align="left">Name</th>

													<th width="400" align="left">Franchisee</th>
													<th width="81" align="right">Sequence No</th>
													<th width="81" align="right">ABC Type</th>
													<th width="81" align="left">Action</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${routeList}" var="routeList"
													varStatus="count">
													<tr>
														<%-- <td><input type="checkbox" class="chk"
															name="select_to_print" id="${routeList.routeId}"
															value="${routeList.routeId}" /></td> --%>

														<td><c:out value="${count.index+1}" /></td>
														<td align="left"><c:out
																value="${routeList.routeName}"></c:out></td>

														<td align="left"><c:out value="${routeList.frName}"></c:out></td>
														<td align="right"><c:out value="${routeList.srNo}"></c:out></td>

														<c:set value="-" var="type">
														</c:set>
														<c:choose>
															<c:when test="${routeList.routeType==1}">
																<c:set value="A" var="type">
																</c:set>
															</c:when>
															<c:when test="${routeList.routeType==2}">
																<c:set value="B" var="type">
																</c:set>
															</c:when>
															<c:when test="${routeList.routeType==3}">
																<c:set value="C" var="type">
																</c:set>
															</c:when>
														</c:choose>

														<td align="left"><c:out value="${type}"></c:out></td>


														<td align="left"><a
															href="${pageContext.request.contextPath}/updateRouteMgmt/${routeList.routeTrayId}"><span
																class="glyphicon glyphicon-edit"></span></a>&nbsp;&nbsp;&nbsp;&nbsp;

															<a
															href="${pageContext.request.contextPath}/deleteRouteMgmt/${routeList.routeTrayId}"
															onClick="return confirm('Are you sure want to delete this record');"><span
																class="glyphicon glyphicon-remove"></span></a></td>
													</tr>

												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								<!-- <div class="form-group" style="background-color: white;">
									&nbsp; &nbsp; &nbsp; &nbsp; <input type="button"
										margin-right: 5px;" id="btn_delete" class="btn btn-primary"
										onclick="deleteById()" value="Delete" />
								</div> -->
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
		function deleteById() {

			var checkedVals = $('.chk:checkbox:checked').map(function() {
				return this.value;
			}).get();
			checkedVals = checkedVals.join(",");

			if (checkedVals == "") {
				alert("Please Select Route")
			} else {
				window.location.href = '${pageContext.request.contextPath}/deleteRoute/'
						+ checkedVals;

			}

		}
	</script>
</body>
</html>