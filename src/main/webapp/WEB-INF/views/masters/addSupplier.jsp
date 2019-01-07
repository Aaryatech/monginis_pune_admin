<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	 

	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	<body>
	
	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>




<c:url var="getSupplierDetails" value="/getSupplierDetails" />
<c:url var="getRmItems" value="/getRmItems" />


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
						<i class="fa fa-file-o"></i>Supplier Master
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
								<i class="fa fa-bars"></i>Add Supplier 
							</h3>
							<div class="box-tool">
								<a href="${pageContext.request.contextPath}/showSupplierList">Back to List</a> <a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
							</div>
							<!-- <div class="box-tool">
								<a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a> <a data-action="close" href="#"><i
									class="fa fa-times"></i></a>
							</div> -->
						</div>


					<div class="box-content">
							<form action="${pageContext.request.contextPath}/addSupplier" method="post" class="form-horizontal" id=
									"validation-form"
										enctype="multipart/form-data" method="post">
							
						<div class="form-group">
										<label class="col-sm-3 col-lg-2 control-label">Supplier Name*</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_name" class="form-control"placeholder="Enter Supplier Name "data-rule-required="true" />
									</div>

									<label class="col-sm-3 col-lg-2 control-label">Supplier GSTIN* </label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_gstin" class="form-control" placeholder="Enter GSTIN " data-rule-required="true"/>
									</div>
								 
								</div>
							 
								
								
								<div class="form-group">
										<label class="col-sm-3 col-lg-2 control-label">Address*</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_addr" class="form-control" placeholder="Address" data-rule-required="true"/>
									</div>

									<label class="col-sm-3 col-lg-2 control-label">City*</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_city" class="form-control"  placeholder="Enter City "data-rule-required="true"/>
									</div>
								 
								</div>
							
								<div class="form-group">
										<label class="col-sm-3 col-lg-2 control-label">State*</label>
									<div class="col-sm-6 col-lg-4 controls">
										<select data-placeholder="Select State" class="form-control chosen" name="supp_state" tabindex="-1"
											id="supp_state"  >
											<option  value="">Select State</option>
										<option value="35-Andaman and Nicobar Islands-AN">35-Andaman and Nicobar Islands-AN</option>
										<option value="28-Andhra Pradesh-AP">28-Andhra Pradesh-AP</option>
										<option value="37-Andhra Pradesh (New)-AD">37-Andhra Pradesh (New)-AD</option>
										<option value="12-Arunachal Pradesh-AR">12-Arunachal Pradesh-AR</option>
										<option value="18-Assam-AS">18-Assam-AS</option>
										<option value="10-Bihar-BH">10-Bihar-BH</option>
										<option value="4-Chandigarh-CH">4-Chandigarh-CH</option>
										<option value="22-Chattisgarh-CT">22-Chattisgarh-CT</option>
										<option value="26-Dadra and Nagar Haveli-DN">26-Dadra and Nagar Haveli-DN</option>
										<option value="25-Daman and Diu-DD">25-Daman and Diu-DD</option>
										<option value="7-Delhi-DL">7-Delhi-DL</option>
										<option value="30-Goa-GA">30-Goa-GA</option>
										<option value="24-Gujarat-GJ">24-Gujarat-GJ</option>
										<option value="6-Haryana-HR">6-Haryana-HR</option>
										<option value="2-Himachal Pradesh-HP">2-Himachal Pradesh-HP</option>
										<option value="1-Jammu and Kashmir-JK">1-Jammu and Kashmir-JK</option>
										<option value="20-Jharkhand-JH">20-Jharkhand-JH</option>
										<option value="29-Karnataka-KA">29-Karnataka-KA</option>
										<option value="32-Kerala-KL">32-Kerala-KL</option>
										<option value="31-Lakshadweep Islands-LD">31-Lakshadweep Islands-LD</option>
										<option value="23-Madhya Pradesh-MP">23-Madhya Pradesh-MP</option>
										<option value="27-Maharashtra-MH">27-Maharashtra-MH</option>
										<option value="14-Manipur-MN">14-Manipur-MN</option>
										<option value="17-Meghalaya-ME">17-Meghalaya-ME</option>
										<option value="15-Mizoram-MI">15-Mizoram-MI</option>
										<option value="13-Nagaland-NL">13-Nagaland-NL</option>
										<option value="21-Odisha-OR">21-Odisha-OR</option>
										<option value="34-Pondicherry-PY">34-Pondicherry-PY</option>
										<option value="3-Punjab-PB">3-Punjab-PB</option>
										<option value="8-Rajasthan-RJ">8-Rajasthan-RJ</option>
										<option value="11-Sikkim-SK">11-Sikkim-SK</option>
										<option value="33-Tamil Nadu-TN">33-Tamil Nadu-TN</option>
										<option value="36-Telangana-TS">36-Telangana-TS</option>
										<option value="16-Tripura-TR">16-Tripura-TR</option>
										<option value="9-Uttar Pradesh-UP">9-Uttar Pradesh-UP</option>
										<option value="5-Uttarakhand-UT">5-Uttarakhand-UT</option>
										<option value="19-West Bengal-WB">19-West Bengal-WB</option>
								</select>
									
									</div>

									<label class="col-sm-3 col-lg-2 control-label">Country*</label>
									<div class="col-sm-6 col-lg-4 controls">
										  <!--<select  name="supp_country"  class="form-control">
										<option value="1">India</option>
								</select>-->
								<input type="text" name="supp_country" class="form-control"  placeholder="Enter County "data-rule-required="true" value="India"/>
								
									</div>
								 
								</div>
								 	<br />
							 
								
								<div class="form-group">
										<label class="col-sm-3 col-lg-2 control-label">Mobile 1*</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_mob1" class="form-control" placeholder="Enter Mobile 1 " data-rule-required="true" 
													 pattern="^\d{10}$" required
													onKeyPress="return isNumberCommaDot(event)" />
									</div>

									<label class="col-sm-3 col-lg-2 control-label">Email 1*</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="email" name="supp_email1" class="form-control"  placeholder="Enter Email 1 "data-rule-required="true"
													data-rule-email="true" />
									</div>
								 
								</div>
							 
								
							 <div class="form-group">
										<label class="col-sm-3 col-lg-2 control-label">Mobile 2*</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_mob2" class="form-control" placeholder="Enter Mobile 2 " data-rule-required="true"
														 pattern="^\d{10}$" required
													onKeyPress="return isNumberCommaDot(event)"  />
									</div>

									<label class="col-sm-3 col-lg-2 control-label">Email 2</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="email" name="supp_email2" class="form-control"placeholder="Enter Email 2 "
													data-rule-email="true" />
									</div>
								 
								</div>
								 <div class="form-group">
										<label class="col-sm-3 col-lg-2 control-label">Mobile 3</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_mob3" class="form-control" placeholder="Enter Mobile 3 "pattern="^\d{10}$" 
													onKeyPress="return isNumberCommaDot(event)"   />
									</div>

									<label class="col-sm-3 col-lg-2 control-label">Email 3</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="email" name="supp_email3" class="form-control"placeholder="Enter Email 3 " 
													data-rule-email="true"/>
									</div>
								 
								</div>
							 
									<div class="form-group">
										<label class="col-sm-3 col-lg-2 control-label">Phone 1</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="number" name="supp_phone1" class="form-control" placeholder="Enter Phone 1 " data-rule-minlength="10"
													data-rule-maxlength="11"
													onKeyPress="return isNumberCommaDot(event)" />
									</div>
										<label class="col-sm-3 col-lg-2 control-label">RM Group</label>
											<div class="col-sm-6 col-lg-4 controls">
												<select name="rm_group" id="rm_group" class="form-control chosen" tabindex="6">
												<option value="-1" disabled="disabled" selected="selected">Select RM Group</option>
													 <c:forEach items="${rmItemGroupList}" var="rmItemGroupList" varStatus="count">
									  						 <option value="${rmItemGroupList.grpId}"><c:out value="${rmItemGroupList.grpName}"/></option>
		 											</c:forEach> 
												</select>
											</div>
									
								 
								</div>
								<div class="form-group">
								 <label class="col-sm-3 col-lg-2 control-label">RM Items</label>
									<div class="col-sm-6 col-lg-4 controls">
									<select data-placeholder="Select RM Items" class="form-control chosen" name="supp_email4"  multiple="multiple"
											id="supp_email4"  >
										</select>
									</div>
									</div>
								<div class="form-group">
										<label class="col-sm-3 col-lg-2 control-label">Phone 2</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="number" name="supp_phone2" class="form-control" placeholder="Enter Phone 2 " data-rule-minlength="10"
													data-rule-maxlength="11"
													onKeyPress="return isNumberCommaDot(event)" />
									</div>

									<label class="col-sm-3 col-lg-2 control-label">Lead Time</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_email5" class="form-control" placeholder="Lead Time"
													data-rule-required="true"/>
									</div>
								 
								</div>
							 	<br />
								<br />
							
								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">Supplier Contact Person*</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_c_person" class="form-control" placeholder="Supplier contact person" data-rule-required="true"/>
									</div>

									<label class="col-sm-3 col-lg-2 control-label">Supplier Pan No*
									</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_panno" class="form-control"  placeholder="Supplier Pan No"data-rule-required="true"/>
									</div>

								</div>
								 
								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">Supplier FDA Lic*</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_fdalic" class="form-control" placeholder="Supplier FDA Lic"data-rule-required="true" />
									</div>

									<label class="col-sm-3 col-lg-2 control-label">Supplier Pay Id*</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_pay_id" class="form-control" placeholder=" Supplier Pay Id" data-rule-number="true"  data-rule-required="true"/>
									</div>
								</div>
							 
								<div class="form-group" >
									<label class="col-sm-3 col-lg-2 control-label">Supplier Credit days*</label>
									<div class="col-sm-6 col-lg-4 controls">
										<input type="text" name="supp_credit_days" class="form-control"  placeholder="Supplier Credit days" onKeyPress="return isNumberCommaDot(event)"data-rule-number="true" data-rule-required="true"/>
									</div>
										
							</div>
								<br />
								 
								
								 <div class="row">
					<div class="col-md-12" style="text-align: center">
						<input type="submit" class="btn btn-info" value="Submit">
					 


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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>

			<script type="text/javascript"
				src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/jquery.validate.min.js"></script>
			<script type="text/javascript"
				src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/additional-methods.min.js"></script>
<script type="text/javascript">
$(document).ready(function() { 
	$('#rm_group').change(
			function() {
				$.getJSON('${getRmItems}', {
					grpId : $(this).val(),
					ajax : 'true'
				}, function(data) {
               var html = '<option value="" disabled="disabled"  >Select Raw Material</option>';
					
					var len = data.length;
					for ( var i = 0; i < len; i++) {
						html += '<option value="' + data[i].rmId + '">'
								+ data[i].rmName + '</option>';
					}
					html += '</option>';
					$('#supp_email4').html(html);
					$("#supp_email4").trigger("chosen:updated");

				});
			});
});
</script>
</body>
</html>