<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Item wise Purchase Report</title>
<style type="text/css">
 table {
	border-collapse: collapse;
	font-size: 10;
	width:100%;

} 
p  {
    color: black;
    font-family: arial;
    font-size: 60%;
	margin-top: 0;
	padding: 0;

}
h6  {
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
<h3 align="center">LUTF FOODS PVT. LTD.</h3>
<p align="center">Sr No 37, Near Angraj Hotel, Kondhwa, Pune, Maharashtra 411048</p>

<div align="center"> <h5>Purchase Report (Item wise )&nbsp;&nbsp;&nbsp;&nbsp; From &nbsp; ${fromDate}  &nbsp;To &nbsp; ${toDate}</h5></div>

<table  align="center" border="1" cellspacing="0" cellpadding="1" 
		id="table_grid" class="table table-bordered">
								<thead >
									<tr class="bgpink">
									
									<th style="text-align:center;height: 25px">Sr.No.</th>
										<th style="text-align:center;">RM Name</th>
										<th  style="text-align:center;">HNCD Code</th>
										<th  style="text-align:center">Tax Rate</th> 
										<th  style="text-align:center">Received Qty</th> 
										<th  style="text-align:center">CGST</th>
										<th  style="text-align:center">SGST</th>
										<th  style="text-align:center">IGST</th> 
										<th  style="text-align:center">Total</th>
								  </tr>
								</thead>
								
								 <tbody >
								  <tbody >
								  
								<c:set var="igst"  value="${0 }"/>
								<c:set var="cgst"  value="${0 }"/>
								<c:set var="sgst"  value="${0 }"/>
								<c:set var="taxableAmt"  value="${0 }"/>
								  	<c:forEach items="${staticlist}" var="staticlist" varStatus="count">
												<tr>
													<td><c:out value="${count.index+1}" /></td>
													 
													<td><c:out value="${staticlist.rmName}" /></td>
													<td  style="text-align:center"><c:out value="${staticlist.hsncdNo}" /></td>
													<td  style="text-align:right"><c:out value="${staticlist.taxRate}" /></td>
													<td  style="text-align:right"><c:out value="${staticlist.recdQty}" /></td>  
													<td  style="text-align:right"><fmt:formatNumber type = "number"  maxFractionDigits = "2" minFractionDigits="2" value = "${staticlist.cgst}"/>
													 </td> <c:set var="cgst"  value="${cgst+staticlist.cgst }"/>
													<td  style="text-align:right"><fmt:formatNumber type = "number"  maxFractionDigits = "2" minFractionDigits="2"  value = "${staticlist.sgst}"/>
													 </td> <c:set var="sgst"  value="${sgst+staticlist.sgst }"/>
													<td  style="text-align:right"><fmt:formatNumber type = "number"  maxFractionDigits = "2" minFractionDigits="2"  value = "${staticlist.igst}"/>
													  </td> <c:set var="igst"  value="${igst + staticlist.igst}"/> 
													<td  style="text-align:right"><fmt:formatNumber type = "number"  maxFractionDigits = "2" minFractionDigits="2" value = "${staticlist.taxableAmt}"/>
													  </td> 
													 
														<c:set var="taxableAmt"  value="${taxableAmt+staticlist.taxableAmt }"/>
													
												</tr>
												</c:forEach>
								  <tr>
								  <td colspan='5'><b>Total</b></td>
								   
								  <td  style="text-align:right"><b><fmt:formatNumber type = "number"  maxFractionDigits = "2" minFractionDigits="2" value = "${cgst}"/></b></td>
								   <td  style="text-align:right"><b><fmt:formatNumber type = "number"  maxFractionDigits = "2"  minFractionDigits="2" value = "${sgst}"/></b></td>
								     <td  style="text-align:right"><b><fmt:formatNumber type = "number"  maxFractionDigits = "2"  minFractionDigits="2" value = "${igst}"/></b></td> 
								    
								     <td  style="text-align:right"><b><fmt:formatNumber type = "number"  maxFractionDigits = "2"  minFractionDigits="2" value = "${taxableAmt}"/></b></td>
								      <!--  <td><b>Total</b></td> -->
								  </tr>
							 </tbody>
								</table>

	
</body>
</html>