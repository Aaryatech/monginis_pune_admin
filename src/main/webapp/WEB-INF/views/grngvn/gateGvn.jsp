<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>

	<c:url var="insertGateGvnProcessAgree"
		value="/insertGateGvnProcessAgree" />


	<c:url var="insertGateGvnProcessDisAgree"
		value="/insertGateGvnProcessDisAgree" />

	<c:url var="getDateForGvnGate" value="/getDateForGvnGate" />

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
						<i class="fa fa-file-o"></i>GVN
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
								<i class="fa fa-bars"></i> GVN for Gate
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


							<form
								action="${pageContext.request.contextPath}/insertGateGvnByCheckBoxes"
								class="form-horizontal" method="post" id="validation-form">
									<input type="hidden" value="${headerId}" id="headerId"
									name="headerId">

								<div class="box">
									<div class="box-title">
										<h3>
											<i class="fa fa-table"></i> GVN List GVN List Date-${grnDate} srNo-${srNo}
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
												<thead style="background-color:#f3b5db; ">
													<tr>
														<!-- <th width="30"></th>
														<th width="50" style="width: 18px" align="left">Sr No</th>
														<th width="100" align="left">Bill No</th>
														<th width="120" align="left">Franchise Name</th>
														<th width="120" align="left">Item Name</th>
														<th width="100" align="left">GVN Quantity</th>
														<th width="100" align="left">PHOTO 1</th>
														<th width="100" align="left">PHOTO 2</th>
														<th width="100" align="left">Status</th>
														<th width="100" align="left">Action</th> -->


													<c:choose>
														<c:when test="${sts==1}">
														 <th><input type="checkbox" onClick="selectedGvn(this)" disabled/><br/></th>
														</c:when>
														<c:otherwise>
														<th><input type="checkbox" onClick="selectedGvn(this)" /></th>
														</c:otherwise>
												</c:choose>
														<th>Sr No</th>
														<th>Invoice No</th>
														<th>Invoice Date</th>
														<th>Franchise Name</th>
														<th>Item Name</th>
														<th>Gvn Qty</th>
														<th>Edited Qty</th>
														<th>PHOTO 1</th>
														<th>PHOTO 2</th>
														<th>Status</th>
														<th>Action</th>



													</tr>


												</thead>
												<tbody>
													<c:forEach items="${gvnList}" var="gvnList"
														varStatus="count">
														<%-- <c:choose>
															<c:when
																test="${gvnList.grnGvnQtyAuto!=gvnList.grnGvnQty}">

																<c:set var="color" value="red"></c:set>
															</c:when>
															<c:otherwise>
																<c:set var="color" value=""></c:set>
															</c:otherwise>
														</c:choose> --%>

														<tr>
															<c:choose>


																<c:when test="${gvnList.grnGvnStatus==1}">
																	<td><input type="checkbox" name="select_to_agree"
																		id="${gvnList.grnGvnId}" value="${gvnList.grnGvnId}"></></td>


																</c:when>

																<c:when test="${gvnList.grnGvnStatus==3}">
																	<td><input type="checkbox" name="select_to_agree"
																		id="${gvnList.grnGvnId}" value="${gvnList.grnGvnId}"></></td>

																</c:when>


																<c:otherwise>

																	<td><input type="checkbox" name="select_to_agree"
																		disabled="disabled" id="${gvnList.grnGvnId}"
																		value="${gvnList.grnGvnId}"></></td>


																</c:otherwise>
															</c:choose>
															<td><c:out value="${count.index+1}" /></td>

															<td align="left"><c:out value="${gvnList.invoiceNo}" /></td>
															
															<td align="left"><c:out value="${gvnList.refInvoiceDate}" /></td>

															<td align="left"><c:out value="${gvnList.frName}" /></td>


															<td align="left"><c:out value="${gvnList.itemName}" /></td>


															<td align="center"><c:out
																	value="${gvnList.grnGvnQty}" /> <input type="hidden"
																name="approve_gate_login${gvnList.grnGvnId}"
																id="approve_gate_login${gvnList.grnGvnId}"
																value="${gvnList.approvedLoginGate}" /></td>




															<c:set var="qty" value="0"></c:set>

															<c:choose>
																<c:when test="${gvnList.grnGvnStatus==1}">
																	<c:set var="qty" value="${gvnList.grnGvnQty}"></c:set>
																</c:when>
																<c:otherwise>
																	<c:set var="qty" value="${gvnList.aprQtyGate}"></c:set>
																</c:otherwise>
															</c:choose>



															<td><input type="text"
																name="gate_gvn_qty${gvnList.grnGvnId}"
																style="width: 50px" class="form-control"
																id='gate_gvn_qty${gvnList.grnGvnId}' value="${qty}"
																onkeyup="checkQty(${gvnList.grnGvnId},${gvnList.grnGvnQty},${gvnList.aprQtyGate},${qty})" /></td>

															<%-- 
																<td align="center"><input type="text" name="gate_gvn_qty${gvnList.grnGvnId}" style="width: 50px" class="form-control"
															id='gate_gvn_qty${gvnList.grnGvnId}' value="${gvnList.grnGvnQty}"/></td>
																 --%>

															<td><a href="${url}${gvnList.gvnPhotoUpload1}"
																data-lightbox="image-1">Image 1</a></td>

															<td><a href="${url}${gvnList.gvnPhotoUpload2}"
																data-lightbox="image-1">Image 2</a></td>
															<c:choose>
																<c:when test="${gvnList.grnGvnStatus==1}">
																	<td align="left"><c:out value="Pending"></c:out></td>

																</c:when>

																<c:when test="${gvnList.grnGvnStatus==2}">
																	<td align="left"><c:out
																			value="Approved From Dispatch"></c:out></td>

																</c:when>

																<c:when test="${gvnList.grnGvnStatus==3}">
																	<td align="left"><c:out
																			value="Reject From Dispatch"></c:out></td>

																</c:when>

																<c:when test="${gvnList.grnGvnStatus==4}">
																	<td align="left"><c:out value="Approved From Sales"></c:out></td>

																</c:when>

																<c:when test="${gvnList.grnGvnStatus==5}">
																	<td align="left"><c:out value="Reject From Sales"></c:out></td>

																</c:when>

																<c:when test="${gvnList.grnGvnStatus==6}">
																	<td align="left"><c:out
																			value="Approved From Account"></c:out></td>

																</c:when>

																<c:when test="${gvnList.grnGvnStatus==7}">
																	<td align="left"><c:out
																			value="Reject From Account"></c:out></td>

																</c:when>

															</c:choose>

															<c:choose>
																<c:when test="${gvnList.grnGvnStatus==1}">

																	<td>
																		<ul class="table-menu">

																			<li><a href="" id="callSubmit"
																				onclick="insertGrnCall(${gvnList.grnGvnId})"> <i
																					class="fa fa-check"></i></a></li>

																			<li>
																				<div class="dropdown">
																					<a class="dropdown-toggle" href="#"
																						data-toggle="dropdown"><i class="fa fa-times"></i></a>
																					<div class="dropdown-menu">
																						<div class="form">

																							<select name="gate_remark${gvnList.grnGvnId}"
																								id="gate_remark${gvnList.grnGvnId}"
																								class="form-control">
																								<c:forEach items="${remarkList}"
																									var="remarkList">
																									<option value="${remarkList.remark}">${remarkList.remark}</option>
																								</c:forEach>
																							</select> </br> <input class="btn btn-primary" value="Submit"
																								onclick="insertGrnDisAgree(${gvnList.grnGvnId})" />

																						</div>
																					</div>
																				</div>
																			</li>
																			<li>
																				<div class="dropdown">
																					<a class="dropdown-toggle" href="#"
																						data-toggle="dropdown"><i
																						class="fa fa-info-circle"></i></a>
																					<div class="dropdown-menu">
																						<div class="form">
																							Franchisee Remark
																							<textarea name="t1" readonly="readonly"
																								class="form-control"><c:out value="${gvnList.frGrnGvnRemark}"></c:out></textarea>

																						</div>
																					</div>
																				</div>
																			</li>

																		</ul>
																	</td>

																</c:when>



																<c:when test="${gvnList.grnGvnStatus==2}">

																	<td>

																		<ul class="table-menu">

																			<li><a href="" id="callSubmit"
																				class="disableClick"
																				onclick="insertGrnCall(${gvnList.grnGvnId})"> <i
																					class="fa fa-check"></i></a></li>

																			<li>
																				<div class="dropdown">
																					<a class="dropdown-toggle" href="#"
																						data-toggle="dropdown"><i class="fa fa-times"></i></a>
																					<div class="dropdown-menu">
																						<div class="form">

																							<select name="gate_remark${gvnList.grnGvnId}"
																								id="gate_remark${gvnList.grnGvnId}"
																								class="form-control">
																								<c:forEach items="${remarkList}"
																									var="remarkList">
																									<option value="${remarkList.remark}">${remarkList.remark}</option>
																								</c:forEach>
																							</select> </br> <input class="btn btn-primary" value="Submit"
																								onclick="insertGrnDisAgree(${gvnList.grnGvnId})" />

																						</div>
																					</div>
																				</div>
																			</li>
																			<li>
																				<div class="dropdown">
																					<a class="dropdown-toggle" href="#"
																						data-toggle="dropdown"><i
																						class="fa fa-info-circle"></i></a>
																					<div class="dropdown-menu">
																						<div class="form">
																							Franchisee Remark
																							<textarea name="t1" readonly="readonly"
																								class="form-control"><c:out value="${gvnList.frGrnGvnRemark}"></c:out></textarea>

																						</div>
																					</div>
																				</div>
																			</li>

																		</ul>

																	</td>

																</c:when>

																<c:when test="${gvnList.grnGvnStatus==3}">

																	<td>

																		<ul class="table-menu">

																			<li><a href="" id="callSubmit"
																				onclick="insertGrnCall(${gvnList.grnGvnId})"> <i
																					class="fa fa-check"></i></a></li>

																			<li>
																				<div class="dropdown">
																					<a class="dropdown-toggle" href="#" id="disableMe"
																						data-toggle="dropdown"><i class="fa fa-times"></i></a>
																					<div class="dropdown-menu">
																						<div class="form">

																							<select name="gate_remark${gvnList.grnGvnId}"
																								id="gate_remark${gvnList.grnGvnId}"
																								class="form-control">
																								<c:forEach items="${remarkList}"
																									var="remarkList">
																									<option value="${remarkList.remark}">${remarkList.remark}</option>
																								</c:forEach>
																							</select> </br> <input class="btn btn-primary" value="Submit"
																								onclick="insertGrnDisAgree(${gvnList.grnGvnId})" />

																						</div>
																					</div>
																				</div>
																			</li>
																			<li>
																				<div class="dropdown">
																					<a class="dropdown-toggle" href="#"
																						data-toggle="dropdown"><i
																						class="fa fa-info-circle"></i></a>
																					<div class="dropdown-menu">
																						<div class="form">
																							Franchisee Remark
																							<textarea name="t1" readonly="readonly"
																								class="form-control"><c:out value="${gvnList.frGrnGvnRemark}"></c:out></textarea>

																						</div>
																					</div>
																				</div>
																			</li>

																		</ul> <%-- <input class="btn btn-primary" value="Approve"
																		id="callSubmit"
																		onclick="insertGrnCall(${gvnList.grnGvnId})">

																		<input class="accordion btn btn-primary"
																		value="DisApprove" disabled="disabled" />
																		<div class="panel" align="left">
																			Enter Remark
																			<textarea name="gate_remark${gvnList.grnGvnId}"
																				id="gate_remark${gvnList.grnGvnId}"></textarea>
																			<input class="btn btn-primary" value="Submit"
																				onclick="insertGrnDisAgree(${gvnList.grnGvnId})" />

																		</div> <input class="accordion btn btn-primary" value="Show" />
																		<div class="panel" align="left">
																			Franchisee Remark
																			<textarea name="t1" readonly="readonly"
																				class="form-control"> ${gvnList.frGrnGvnRemark}</textarea>
																			Dispatch remark
																			<textarea name="t1" readonly="readonly"
																				class="form-control">${gvnList.approvedRemarkGate}</textarea>
																		</div> --%>



																	</td>

																</c:when>

																<c:otherwise>
																	<c:choose>
																		<c:when test="${gvnList.grnGvnStatus==5}">


																			<td><ul class="table-menu">

																					<li><a href="" id="callSubmit"
																						class="disableClick"
																						onclick="insertGrnCall(${gvnList.grnGvnId})">
																							<i class="fa fa-check"></i>
																					</a></li>

																					<li>
																						<div class="dropdown">
																							<a class="dropdown-toggle" href="#"
																								id="disableMe" data-toggle="dropdown"><i
																								class="fa fa-times"></i></a>
																							<div class="dropdown-menu">
																								<div class="form">

																									<select name="gate_remark${gvnList.grnGvnId}"
																										id="gate_remark${gvnList.grnGvnId}"
																										class="form-control">
																										<c:forEach items="${remarkList}"
																											var="remarkList">
																											<option value="${remarkList.remark}">${remarkList.remark}</option>
																										</c:forEach>
																									</select> </br> <input class="btn btn-primary" value="Submit"
																										onclick="insertGrnDisAgree(${gvnList.grnGvnId})" />

																								</div>
																							</div>
																						</div>
																					</li>
																					<li>
																						<div class="dropdown">
																							<a class="dropdown-toggle" href="#"
																								data-toggle="dropdown"><i
																								class="fa fa-info-circle"></i></a>
																							<div class="dropdown-menu">
																								<div class="form">
																									Franchisee Remark
																									<textarea name="t1" readonly="readonly"
																										class="form-control"><c:out value="${gvnList.frGrnGvnRemark}"></c:out></textarea>

																								</div>
																							</div>
																						</div>
																					</li>

																				</ul></td>


																		</c:when>


																		<c:when test="${gvnList.grnGvnStatus==7}">


																			<td>
																				<ul class="table-menu">

																					<li><a href="" id="callSubmit"
																						class="disableClick"
																						onclick="insertGrnCall(${gvnList.grnGvnId})">
																							<i class="fa fa-check"></i>
																					</a></li>

																					<li>
																						<div class="dropdown">
																							<a class="dropdown-toggle" href="#"
																								id="disableMe" data-toggle="dropdown"><i
																								class="fa fa-times"></i></a>
																							<div class="dropdown-menu">
																								<div class="form">

																									<select name="gate_remark${gvnList.grnGvnId}"
																										id="gate_remark${gvnList.grnGvnId}"
																										class="form-control">
																										<c:forEach items="${remarkList}"
																											var="remarkList">
																											<option value="${remarkList.remark}">${remarkList.remark}</option>
																										</c:forEach>
																									</select> </br> <input class="btn btn-primary" value="Submit"
																										onclick="insertGrnDisAgree(${gvnList.grnGvnId})" />

																								</div>
																							</div>
																						</div>
																					</li>
																					<li>
																						<div class="dropdown">
																							<a class="dropdown-toggle" href="#"
																								data-toggle="dropdown"><i
																								class="fa fa-info-circle"></i></a>
																							<div class="dropdown-menu">
																								<div class="form">
																									Franchisee Remark
																									<textarea name="t1" readonly="readonly"
																										class="form-control"><c:out value="${gvnList.frGrnGvnRemark}"></c:out></textarea>

																								</div>
																							</div>
																						</div>
																					</li>

																				</ul>

																			</td>


																		</c:when>
																		<c:otherwise>

																			<td>
																				<%-- <input class="btn btn-primary"
																				value="Approve" id="callSubmit" disabled="disabled"
																				onclick="insertGrnCall(${gvnList.grnGvnId})" /> <input
																				class="accordion btn btn-primary" value="DisApprove"
																				disabled="disabled" />
																				<div class="panel" align="left">
																					Enter Remark
																					<textarea name="gate_remark${gvnList.grnGvnId}"
																						id="gate_remark${gvnList.grnGvnId}"></textarea>
																					<input class="btn btn-primary" value="Submit"
																						onclick="insertGrnDisAgree(${gvnList.grnGvnId})" />

																				</div> --%>

																				<ul class="table-menu">

																					<li><a href="" id="callSubmit"
																						class="disableClick"
																						onclick="insertGrnCall(${gvnList.grnGvnId})">
																							<i class="fa fa-check"></i>
																					</a></li>

																					<li>
																						<div class="dropdown">
																							<a class="dropdown-toggle" href="#"
																								id="disableMe" data-toggle="dropdown"><i
																								class="fa fa-times"></i></a>
																							<div class="dropdown-menu">
																								<div class="form">

																									<select name="gate_remark${gvnList.grnGvnId}"
																										id="gate_remark${gvnList.grnGvnId}"
																										class="form-control">
																										<c:forEach items="${remarkList}"
																											var="remarkList">
																											<option value="${remarkList.remark}">${remarkList.remark}</option>
																										</c:forEach>
																									</select> </br> <input class="btn btn-primary" value="Submit"
																										onclick="insertGrnDisAgree(${gvnList.grnGvnId})" />

																								</div>
																							</div>
																						</div>
																					</li>
																					<li>
																						<div class="dropdown">
																							<a class="dropdown-toggle" href="#"
																								data-toggle="dropdown"><i
																								class="fa fa-info-circle"></i></a>
																							<div class="dropdown-menu">
																								<div class="form">
																									Franchisee Remark
																									<textarea name="t1" readonly="readonly"
																										class="form-control"><c:out value="${gvnList.frGrnGvnRemark}"></c:out></textarea>

																								</div>
																							</div>
																						</div>
																					</li>

																				</ul>

																			</td>
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose>
														</tr>

													</c:forEach>

												</tbody>

											</table>
										</div>

										<!-- this is for ajax call<input type="submit" class="btn btn-primary" value="Submit"
										id="callSubmit" onclick="callSubmitGrn(); getGrnId();"> -->


										<div
											class="col-sm-25 col-sm-offset-3 col-lg-30 col-lg-offset-0">
											<input type="submit" value="Submit" class="btn btn-primary">


										</div>
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
				<p>2017 © MONGINIS.</p>
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

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap/js/lightbox.js"></script>
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
	<!-- <script type="text/javascript">
		/* $(document).ready(function() { */
			/* $('#callSubmit').submit(function() { */
				function callSubmitGrn(){
					//var selectedGrn = $("#selectFr").val();
					
					
					
					
				
			
			//alert("hello"),
				 $.ajax({
					type : "get",
					
					
					
					url : "insertGateGrnProcess" //this is my servlet
				/*  data: "input=" +$('#ip').val()+"&output="+$('#op').val(), */

				});
			
 
		};
	</script>
 -->


	<!-- insertGrnDisAgree -->


	<script type="text/javascript">


function insertGrnDisAgree(grnGvnId){
//alert("second function called ");
var grnId=grnGvnId;
var approve_gate_login=$("#approve_gate_login"+grnGvnId).val();
var gate_remark=$("#gate_remark"+grnId).val();
var gate_gvn_qty=$("#gate_gvn_qty"+grnGvnId).val();
var headerId=$("#headerId").val();

if($("#gate_remark"+grnGvnId).val() == ''){
	alert("Please Enter Grn Remark!");
	
}
else{
	
	
	$.getJSON('${insertGateGvnProcessDisAgree}',
			{
			
			grnId : grnId,
			approveGateLogin : approve_gate_login,
			gateRemark : gate_remark,		
			gate_gvn_qty : gate_gvn_qty,
			headerId : headerId,
				ajax : 'true',
			

			}
);


	




callRefreshDisAgree();
/* callSecondRefresh();
callThirdRefresh();
callfourthRefresh(); */
}
}


</script>

	<script type="text/javascript">
function callRefreshDisAgree(){
	
		alert("DisApproved Successfully");
		window.location.reload();
	//document.getElementById("validation-form").reload();
	}

</script>



	<!-- insertGrnDisAgree -->


	<!-- insertGrnAgree -->

	<script type="text/javascript">


function insertGrnCall(grnGvnId){
//alert("second function called ");
var grnId=grnGvnId;
var approve_gate_login=$("#approve_gate_login"+grnGvnId).val();
var gate_remark=$("#gate_remark"+grnGvnId).val();
var gate_gvn_qty=$("#gate_gvn_qty"+grnGvnId).val();
var headerId=$("#headerId").val();


/* alert(grnId);
alert(approve_gate_login); */

	

	$.getJSON('${insertGateGvnProcessAgree}',
							{
							
							grnId : grnId,
							approveGateLogin:approve_gate_login,
							gate_gvn_qty:gate_gvn_qty,	
							headerId : headerId,
								ajax : 'true',
							
	 complete: function() {
	       //alert("ajax completed");
	       
 	  }
}
);

callRefresh();
/* callSecondRefresh();
callThirdRefresh();
callfourthRefresh(); */
}


</script>

	<script type="text/javascript">
function callRefresh(){
	alert("Approved Successfully");
		window.location.reload();
	//document.getElementById("validation-form").reload();
	}

</script>

	<script type="text/javascript">

function callSecondRefresh(){

	window.location.reload();

	
}


</script>

	<script type="text/javascript">

function callThirdRefresh(){
	window.location.reload();

}

</script>

	<script type="text/javascript">

function callfourthRefresh(){
	window.reload();


}

</script>
	<!-- insertGrnAgree -->


	<script>
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].onclick = function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.maxHeight){
      panel.style.maxHeight = null;
    } else {
      panel.style.maxHeight = panel.scrollHeight + "px";
    } 
  }
}
</script>


	<script type="text/javascript">

function showGateGvnDetails(){
	
	//alert("hi");
		var fromDate=$("#from_date").val();
	
		var toDate=$("#to_date").val();
		
		//alert(fromDate);
		//alert(toDate);
		
		$.getJSON('${showGateGvnDetails}',
				{
				
				from_date :fromDate,
				to_date	: toDate,
					
					ajax : 'true',
				
				});


}

</script>


	<script type="text/javascript">

function getDate(){
	
	
	var fromDate=$("#from_date").val();
	var toDate=$("#to_date").val();
	
	
	
	
	$.getJSON('${getDateForGvnGate}',
			{
			
			fromDate : fromDate,
			toDate:toDate,
				
				ajax : 'true',
			

}
);

	
}


</script>

	<script>
	$(document).ready(function(){
	    //Handles menu drop down
	    $('.dropdown-menu').find('.form').click(function (e) {
	        e.stopPropagation();
	    });
	});
</script>

	<script type="text/javascript">

function checkQty(grnId,grnQty,aprQty,qty){
	//alert("JJJ");
	var entered=$("#gate_gvn_qty"+grnId).val();
	//alert("received = " +entered);
	if(entered>grnQty){
		alert("Can not Enter Qty Greater than auto Qty ");
		document.getElementById("gate_gvn_qty"+grnId).value=qty;
	}
}

</script>

	<script>
	
		function selectedGvn(source) {
			checkboxes = document.getElementsByName('select_to_agree');
			$.getJSON('${getGvnStatus}', {
				
				ajax : 'true'
			}, function(data) {
				
				for(var i=0;i<data.length;i++){
					checkboxes[data[i]].checked = source.checked;
				}
			});	
				
		/* checkboxes = document.getElementsByName('select_to_agree');
			
			for (var i = 0, n = checkboxes.length; i < n; i++) {
				checkboxes[i].checked = source.checked;
				
			} */
			
			
		}
		
	</script>



</body>
</html>