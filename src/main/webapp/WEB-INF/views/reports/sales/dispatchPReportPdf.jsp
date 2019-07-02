<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Dispatch Report Pdf</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->



<style type="text/css">
table {
	border-collapse: collapse;
	font-size: 16;
	width: 100%;
	page-break-inside: auto !important
}

p {
	color: black;
	font-family: arial;
	font-size: 60%;
	margin-top: 0;
	padding: 0;
}

h6 {
	color: black;
	font-family: arial;
	font-size: 80%;
}

th {
	background-color: #EA3291;
	color: white;
}
</style>
</head>
<body onload="myFunction()">
	<h4 align="center">MONGINIS</h4>
	<p align="center">PUNE</p>
	<div align="center">
		<h5>Production Start Date &nbsp; ${billDate} &nbsp;&nbsp;
			Dispatch Sheet &nbsp;&nbsp; Route ${routeName} &nbsp;&nbsp;Dispatch
			Date: ${convertedDate}</h5>
	</div>
	</h5>
	</div>


	<table align="center" border="1" cellspacing="0" cellpadding="1"
		id="table_grid" class="table table-bordered">
		<thead>
			<tr class="bgpink">
				<th height="25">Sr.No.</th>
				<th>Item Name</th>
				<c:forEach items="${frList}" var="fr" varStatus="count">
					<th style="font-size: 12px;">${fr.frName}</th>
				</c:forEach>
				<th>Total</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="allTotal" value="0" />

			<c:forEach items="${subCatList}" var="subCat" varStatus="count">
				<tr>
					<td bgcolor="lightgray"><c:out value="" /></td>
					<td bgcolor="lightgray"><b>${subCat.subCatName}</b></td>
					<c:forEach items="${frList}" var="fr" varStatus="count">
						<td bgcolor="lightgray"><c:out value="" /></td>
					</c:forEach>
					<td bgcolor="lightgray"><c:out value="" /></td>
				</tr>
				<c:set var="srNo" value="1"></c:set>
				<c:forEach items="${itemList}" var="item" varStatus="count">
					<c:set var="total" value="0" />
					<c:set var="frTotal" value="0" />
					<c:choose>
						<c:when test="${item.itemGrp2==subCat.subCatId}">

							<tr>
								<td width="100"><c:out value="${srNo}" /></td>
								<c:set var="srNo" value="${srNo+1}"></c:set>
								<td width="250"><c:out value="${item.itemName}" /></td>

								<c:forEach items="${frList}" var="fr" varStatus="count">
									<c:set var="editQty" value="0"></c:set>
									<c:forEach items="${dispatchReportList}" var="report"
										varStatus="count">
										<c:choose>
											<c:when test="${report.itemId==item.id}">
												<c:choose>
													<c:when test="${report.frId==fr.frId}">

														<c:set var="editQty" value="${report.editQty}"></c:set>
														<c:set var="total" value="${report.editQty+total}"></c:set>
													</c:when>
												</c:choose>
											</c:when>

										</c:choose>
										<c:set var="frTotal" value="${report.editQty+frTotal}" />
									</c:forEach>
									<td width="40px" align="right">${editQty}</td>

								</c:forEach>

								<td width="40px" align="right">${total}</td>
								<c:set var="allTotal" value="${total+allTotal}"></c:set>
							</tr>
						</c:when>
					</c:choose>


				</c:forEach>


			</c:forEach>

			<c:forEach items="${subCatList}" var="subCat" varStatus="count">
				<tr>
					<td bgcolor="#fc67ca"><c:out value="" /></td>
					<td bgcolor="#fc67ca"><b>${subCat.subCatName}</b></td>
					<c:set var="totalItems" value="0" />
					<c:forEach items="${frList}" var="fr" varStatus="count">
						<c:set var="itemTotal" value="0" />
						<c:forEach items="${dispatchReportList}" var="report"
							varStatus="count">
							<c:choose>
								<c:when test="${report.subCatId==subCat.subCatId}">
									<c:choose>
										<c:when test="${report.frId==fr.frId}">
											<c:set var="itemTotal" value="${report.editQty+itemTotal}" />
										</c:when>
									</c:choose>
								</c:when>
							</c:choose>
						</c:forEach>
						<c:set var="totalItems" value="${itemTotal+totalItems}" />
						<td align="right" bgcolor="#fc67ca"><fmt:formatNumber
								type="number" maxFractionDigits="2" value="${itemTotal}" /></td>
					</c:forEach>
					<td align="right" bgcolor="#fc67ca"><b><fmt:formatNumber
								type="number" maxFractionDigits="2" value="${totalItems}" /></b></td>
				</tr>
			</c:forEach>

			<tr>

				<td colspan='2'><b>Total</b></td>


				<c:forEach items="${frList}" var="fr" varStatus="count">
					<c:set var="itemTotal" value="0" />
					<c:forEach items="${dispatchReportList}" var="report"
						varStatus="count">

						<c:choose>
							<c:when test="${report.frId==fr.frId}">
								<c:set var="itemTotal" value="${report.editQty+itemTotal}" />
							</c:when>
						</c:choose>

					</c:forEach>
					<td align="right"><b><fmt:formatNumber type="number"
								maxFractionDigits="2" value="${itemTotal}" /></b></td>
				</c:forEach>
				<td align="right"><b><fmt:formatNumber type="number"
							maxFractionDigits="2" value="${allTotal}" /></b></td>
			</tr>
		</tbody>
	</table>

	<input type="button"
		onclick="tableToExcel('table_grid', 'name', 'Stationwise.xls')"
		value="Export to Excel">


	<!-- END Main Content -->

	<script type="text/javascript">
		function tableToExcel(table, name, filename) {
			let uri = 'data:application/vnd.ms-excel;base64,', template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><title></title><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body><table>{table}</table></body></html>', base64 = function(
					s) {
				return window.btoa(decodeURIComponent(encodeURIComponent(s)))
			}, format = function(s, c) {
				return s.replace(/{(\w+)}/g, function(m, p) {
					return c[p];
				})
			}

			if (!table.nodeType)
				table = document.getElementById(table)
			var ctx = {
				worksheet : name || 'Worksheet',
				table : table.innerHTML
			}

			var link = document.createElement('a');
			link.download = filename;
			link.href = uri + base64(format(template, ctx));
			link.click();
		}
	</script>

</body>
</html>