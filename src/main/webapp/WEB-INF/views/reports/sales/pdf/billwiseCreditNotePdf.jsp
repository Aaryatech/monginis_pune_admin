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
<title>Sales Report Billwise PDF</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->


<style type="text/css">
table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	text-align: left;
	padding: 2px;
	font-size: 10;
}

tr:nth-child(even) {
	background-color: #f2f2f2
}

th {
	background-color: #EA3291;
	color: white;
}
</style>
</head>
<body onload="myFunction()">
	<h3 align="center">Galdhar Foods Pvt Ltd</h3>
	<p align="center">A-89, Shendra M.I.D.C., Aurangabad</p>
	<p align="center">(All Sales)</p>
	<p align="center">Sales Report (Month wise)</p>
	<!-- Report 4 R4 -->

	<div align="center">From ${fromDate}- To ${toDate}</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		id="table_grid" class="table table-bordered">
		<thead>
			<tr class="bgpink">
				<th>Sr.No.</th>
				<th>Bill No</th>
				<th>Bill Date</th>
				<th>Credit No</th>
				<th>CRN Date</th>
				<th>Item Name</th>
				<th>Qty</th>
				<th>Grnad Total</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="totalQty" value="${0}" />
			<c:set var="totalAmt" value="${0 }" />

			<c:forEach items="${report}" var="report" varStatus="count">
				<tr>
					<td><c:out value="${count.index+1}" /></td>
					<td><c:out value="${report.month}" /></td>
					<td><c:out value="${report.taxableAmt}" /></td>

					<c:set var="totalQty" value="${totalQty + report.grnGvnQty}" />

					<c:set var="totalAmt" value="${totalAmt+report.grnGvnAmt}" />
					<td><c:out value="${report.roundOff}" /></td>
					<%-- <td><c:out value="${total}" /></td> --%>

					<td><fmt:formatNumber type="number" maxFractionDigits="2"
							value="${total}" /></td>
				</tr>

			</c:forEach>
			<tr>

				<td colspan='2'><b>Total</b></td>
				<td><b><fmt:formatNumber type="number"
							maxFractionDigits="2" value="${taxAmount}" /></b></td>
				<td><b><fmt:formatNumber type="number"
							maxFractionDigits="2" value="${cgst}" /></b></td>
				<td><b><fmt:formatNumber type="number"
							maxFractionDigits="2" value="${sgst}" /></b></td>
				<td><b><fmt:formatNumber type="number"
							maxFractionDigits="2" value="${igst}" /></b></td>
				<td></td>
				<td><b><fmt:formatNumber type="number"
							maxFractionDigits="2" value="${grandTotal}" /></b></td>
				<!--  <td><b>Total</b></td> -->
			</tr>
		</tbody>
	</table>


	<!-- END Main Content -->

</body>
</html>