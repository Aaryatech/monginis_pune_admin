<%@page import="com.ats.adminpanel.model.franchisee.SubCategory"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page
	import="java.io.*, java.util.*, java.util.Enumeration, java.text.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Monginis Admin</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!--base css styles-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/data-tables/bootstrap3/dataTables.bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap-fileupload/bootstrap-fileupload.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/chosen-bootstrap/chosen.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap-timepicker/compiled/timepicker.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/clockface/css/clockface.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap-datepicker/css/datepicker.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/daterangepicker.css" />

<!--page specific css styles-->

<!--flaty css styles-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/flaty.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/flaty-responsive.css">

<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/img/favicon.png">

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/common.js"></script>

<!--basic scripts-->

<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
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
<!-- http://forum.springsource.org/showthread.php?110258-dual-select-dropdown-lists -->
<!-- http://api.jquery.com/jQuery.getJSON/ -->

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/additional-methods.min.js"></script>
<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
<style type="text/css">
select {
    width: 180px;
    height: 30px;
}
</style>


</head>
<body>

    <c:url var="setAllMenuSelected"  value="/setAllMenuSelected" />
    <c:url var="setAllFrIdSelected"  value="/setAllFrIdSelected" />
	<c:url var="setAllItemSelected" value="/setAllItemSelected" />

	<c:url var="findItemsByCatId" value="/getCommonByMenuId" />
	<c:url var="findAllMenus" value="/getAllMenus" />
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
						<i class="fa fa-file-o"></i> Franchisee
					</h1>
				</div>
			</div> -->
			<!-- END Page Title -->


			<!-- BEGIN Main Content -->
			<div class="row">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-12">
							<div class="box">
								<div class="box-title">
									<h3>
										<i class="fa fa-bars"></i> Configure Menu To Franchisee
									</h3>
									<div class="box-tool">
										<a href="${pageContext.request.contextPath}/configuredFrMenus">Back to
											List</a> <a data-action="collapse" href="#"><i
											class="fa fa-chevron-up"></i></a>
									</div>
								</div>


								<c:set var="allFranchiseeAndMenuList"
									value="${allFranchiseeAndMenuList}" />
								<div class="box-content">
									<form action="${pageContext.request.contextPath}/configureMenuToFr" class="form-horizontal"
										id="validation-form" method="post">





										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Franchisee</label>
											<div class="col-sm-9 col-lg-10 controls">
												<select data-placeholder="Select Franchisee" name="fr_id"
													class="form-control chosen" tabindex="-1" id="fr_id" multiple="multiple"
													data-rule-required="true">
													<option value=""> </option>
													<!-- <optgroup label="All Franchisee"> -->
														<option value="">Select Franchise</option>
														<option value="-1">ALL</option>
														<c:forEach
															items="${allFranchiseeAndMenuList.getAllFranchisee()}"
															var="franchiseeList">
															<option value="${franchiseeList.frId}">${franchiseeList.frName}</option>

														</c:forEach>
												<!-- 	</optgroup> -->

												</select>
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Menus</label>
											<div class="col-sm-9 col-lg-10 controls">
												<select data-placeholder="Select Menu" name="menu"
													class="form-control chosen" tabindex="-1" id="menu" multiple="multiple"
													data-rule-required="true">
	                                             <!-- <optgroup label="All Menus">                                                     

													</optgroup> -->
														<option value="-1">ALL</option>
                                              <c:forEach items="${configureFrList}"
															var="menu">
															<option value="${menu.settingId}">${menu.menuTitle}</option>

														</c:forEach>
												</select>
											</div>
										</div>

											

										<div class="form-group">
											<div
												class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2">
												<input type="submit" class="btn btn-primary"
													value="Configure">
												<button type="button" class="btn">Cancel</button>
											</div>
										</div>
									</form>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- END Main Content -->

			<footer>
				<p>2018 � MONGINIS.</p>
			</footer>

			<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
				class="fa fa-chevron-up"></i></a>
		</div>
		<!-- END Content -->
	</div>
	<!-- END Container -->
 <script
	src="${pageContext.request.contextPath}/resources/assets/bootstrap/js/bootstrap.min.js"></script> 

<script type="text/javascript">
$(document).ready(function() { // if all label selected set all items selected
	
$('#fr_id').change(
		function () {
			 var selected=$('#fr_id').val();
	
        if(selected==-1){
			$.getJSON('${setAllFrIdSelected}', {
			//	selected : selected,
				ajax : 'true'
			}, function(data) {
				var html = '<option value="">Select Franchise</option>';
			
				var len = data.length;
				
				$('#fr_id')
			    .find('option')
			    .remove()
			    .end()
				 $("#fr_id").append($("<option></option>").attr( "value",-1).text("ALL"));

				for ( var i = 0; i < len; i++) {
    
                   $("#fr_id").append(
                           $("<option selected></option>").attr(
                               "value", data[i].frId).text(data[i].frName)
                       );
				}
		
				   $("#fr_id").trigger("chosen:updated");
			});
  }
});
});



</script>
<script type="text/javascript">
$(document).ready(function() { // if all label selected set all items selected
	
$('#menu').change(
		function () {
			 var selected=$('#menu').val();
	
        if(selected==-1){
			$.getJSON('${setAllMenuSelected}', {
			//	selected : selected,
				ajax : 'true'
			}, function(data) {
				var html = '<option value="">Select Menus</option>';
			
				var len = data.length;
				
				$('#menu')
			    .find('option')
			    .remove()
			    .end()
				 $("#menu").append($("<option></option>").attr( "value",-1).text("ALL"));

				for ( var i = 0; i < len; i++) {
    
                   $("#menu").append(
                           $("<option selected></option>").attr(
                               "value", data[i].settingId).text(data[i].menuTitle)
                       );
				}
		
				   $("#menu").trigger("chosen:updated");
			});
  }
});
});



</script>
</body>
</html>