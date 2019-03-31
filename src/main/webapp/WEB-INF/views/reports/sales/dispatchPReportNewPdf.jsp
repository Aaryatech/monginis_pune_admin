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
	font-size: 14;
	width:100%;
page-break-inside: auto !important 

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
<h4 align="center">MONGINIS</h4>
<p align="center">PUNE</p>



<c:forEach items="${staionListWithFranchiseeList}" var="staionListWithFranchiseeList">
		<div align="left"> <h5> Station No : ${staionListWithFranchiseeList.stationNo}, &nbsp; Production Date : ${date},&nbsp; 
		<c:choose><c:when test="${abcType==0}"> All Rout</c:when><c:when test="${abcType==1}"> A Rout</c:when><c:when test="${abcType==2}"> B Rout</c:when><c:when test="${abcType==3}"> C Rout</c:when> </c:choose>  </h5></div>	
		
		
		<table  align="center" border="1" cellspacing="0" cellpadding="1" 
		id="table_grid" class="table table-bordered">
		<thead>
			<tr class="bgpink">
				<th width="3%">Sr.No.</th>
				<th >Franchisee Name</th>
			  	<c:set var="itemCount" value="2"></c:set> 
											 
				<c:forEach items="${itemList}" var="itemList">
					<c:choose>
					 <c:when test="${itemList.itemMrp2==staionListWithFranchiseeList.stationNo}">
						 <th style="font-size: 12px;">${itemList.itemName}</th> 
						 <c:set var="itemCount" value="${itemCount+1}"></c:set>
					 </c:when>
					</c:choose>
			
				</c:forEach>
				 
			</tr>
		</thead>
		<tbody>
		
											<c:choose>
												<c:when test="${abcType==0 || abcType==1}">
											<c:set var="sr" value="0"></c:set>
											<c:forEach items="${staionListWithFranchiseeList.list}" var="list" > 
													<c:forEach items="${allFrIdNameList}" var="allFrIdNameList" varStatus="count">
															<c:choose> 
																<c:when test="${list.frId==allFrIdNameList.frId and list.abcType==1}">
																	<tr>
																		<td width="3%"><c:out value="${sr+1}" /><c:set var="sr" value="${sr+1}"></c:set></td> 
																		<td align="left"  ><c:out value="${list.frName}" />
																		</td>
																		  <c:forEach items="${list.itemList}" var="itemList" >
																		  <td style="text-align: right;">
																		  
																		   <c:choose>
																			  <c:when test="${itemList.orderQty>0}">
																			 
																			<fmt:formatNumber type="number"	minFractionDigits="0" maxFractionDigits="0"	value="${itemList.orderQty}"/>
																			 
																			  </c:when>
																			  <c:otherwise>
																			 
																			  
																			  </c:otherwise>
																			  
																			  </c:choose>
																		  </td> 
																		  </c:forEach>
																		</tr>
																	
																
																</c:when>
															</c:choose>
															
														</c:forEach>
												
												</c:forEach> 
												<tr bgcolor="#D3D3D3">  
													<td colspan="2"  style="text-align: center;"><b> Rout A Total </b></td> 
													<c:forEach items="${itemListStatioinWiseList}" var="itemListStatioinWiseList" >  
															<c:choose> 
																<c:when test="${itemListStatioinWiseList.stationNo==staionListWithFranchiseeList.stationNo}"> 	
																	<c:forEach items="${itemListStatioinWiseList.typeWiseItemTotalList}" var="typeWiseItemTotalList" > 
																		  <td style="text-align: right;"><b>${typeWiseItemTotalList.aTotal}</b></td>  
																	</c:forEach>
																</c:when>
															</c:choose>
														 
												</c:forEach>  
												</tr>
												</c:when>
												</c:choose>
												
												<c:choose>
												<c:when test="${abcType==0 || abcType==2}">
												<c:forEach items="${staionListWithFranchiseeList.list}" var="list" > 
													<c:forEach items="${allFrIdNameList}" var="allFrIdNameList" varStatus="count">
															<c:choose> 
																<c:when test="${list.frId==allFrIdNameList.frId and list.abcType==2}">
																	<tr>
																		<td><c:out value="${sr+1}" /><c:set var="sr" value="${sr+1}"></c:set></td> 
																		<td align="left"><c:out value="${list.frName}" />
																		</td>
																		  <c:forEach items="${list.itemList}" var="itemList" >
																		  <td style="text-align: right;">
																		   <c:choose>
																			  <c:when test="${itemList.orderQty>0}">
																			 
																			<fmt:formatNumber type="number"	minFractionDigits="0" maxFractionDigits="0"	value="${itemList.orderQty}"/>
																			 
																			  </c:when>
																			  <c:otherwise>
																			 
																			  
																			  </c:otherwise>
																			  
																			  </c:choose>
																		  </td> 
																		  </c:forEach>
																		</tr>
																	
																
																</c:when>
															</c:choose>
															
														</c:forEach> 
												</c:forEach> 
												<tr bgcolor="#D3D3D3">  
													<td colspan="2"  style="text-align: center;"> <b>Rout B Total</b> </td> 
													<c:forEach items="${itemListStatioinWiseList}" var="itemListStatioinWiseList" >  
															<c:choose> 
																<c:when test="${itemListStatioinWiseList.stationNo==staionListWithFranchiseeList.stationNo}"> 	
																	<c:forEach items="${itemListStatioinWiseList.typeWiseItemTotalList}" var="typeWiseItemTotalList" > 
																		  <td style="text-align: right;"><b>${typeWiseItemTotalList.bTotal}</b></td>  
																	</c:forEach>
																</c:when>
															</c:choose>
														 
												</c:forEach>  
												</tr>
												</c:when>
												</c:choose>
												
												<c:choose>
												<c:when test="${abcType==0 || abcType==3}">
												<c:forEach items="${staionListWithFranchiseeList.list}" var="list" > 
													<c:forEach items="${allFrIdNameList}" var="allFrIdNameList" varStatus="count">
															<c:choose> 
																<c:when test="${list.frId==allFrIdNameList.frId and list.abcType==3}">
																	<tr>
																		<td><c:out value="${sr+1}" /><c:set var="sr" value="${sr+1}"></c:set></td> 
																		<td align="left"><c:out value="${list.frName}" />
																		</td>
																		  <c:forEach items="${list.itemList}" var="itemList" >
																		  <td style="text-align: right;">
																		   <c:choose>
																			  <c:when test="${itemList.orderQty>0}">
																			 
																			<fmt:formatNumber type="number"	minFractionDigits="0" maxFractionDigits="0"	value="${itemList.orderQty}"/>
																			 
																			  </c:when>
																			  <c:otherwise>
																			 
																			  
																			  </c:otherwise>
																			  
																			  </c:choose>
																		  </td> 
																		  </c:forEach>
																		</tr>
																	
																
																</c:when>
															</c:choose>
															
														</c:forEach>
												
												</c:forEach>
												<tr bgcolor="#D3D3D3">  
													<td colspan="2"  style="text-align: center;"><b> Rout C Total </b> </td> 
													<c:forEach items="${itemListStatioinWiseList}" var="itemListStatioinWiseList" >  
															<c:choose> 
																<c:when test="${itemListStatioinWiseList.stationNo==staionListWithFranchiseeList.stationNo}"> 	
																	<c:forEach items="${itemListStatioinWiseList.typeWiseItemTotalList}" var="typeWiseItemTotalList" > 
																		  <td style="text-align: right;"><b>${typeWiseItemTotalList.cTotal}</b></td>  
																	</c:forEach>
																</c:when>
															</c:choose>
														 
												</c:forEach>  
												</tr>
												</c:when>
												</c:choose>
												
												<tr bgcolor="#D3D3D3">  
													<td colspan="2"  style="text-align: center;"><b> Station ${staionListWithFranchiseeList.stationNo} Total </b> </td> 
													<c:forEach items="${itemListStatioinWiseList}" var="itemListStatioinWiseList" >  
															<c:choose> 
																<c:when test="${itemListStatioinWiseList.stationNo==staionListWithFranchiseeList.stationNo}"> 	
																	<c:forEach items="${itemListStatioinWiseList.typeWiseItemTotalList}" var="typeWiseItemTotalList" > 
																		  <td style="text-align: right;"><b>${typeWiseItemTotalList.aTotal+typeWiseItemTotalList.bTotal+
																		  typeWiseItemTotalList.cTotal}</b></td>  
																	</c:forEach>
																</c:when>
															</c:choose>
														 
												</c:forEach> 
													 
												
												</tr>
				 
		</tbody>
	</table>  
	<!-- <div style="page-break-after: always;"></div> -->
				</c:forEach>
 
	<!-- END Main Content -->

</body>
</html>