<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Monginis</title>
</head>

<body
	style="margin: 0px; padding: 0px; font-family: Verdana, Geneva, sans-serif; font-size: 13px; line-height: 20px; text-transform: uppercase;">

	<table width="96%" border="0" cellspacing="12" cellpadding="12"
		align="center">
		<tr>
			<!--1 box-start-here-->
			<c:forEach items="${spCakeOrder}" var="spCakeOrder" varStatus="count">



				<td width="48%" style="width: 48%; float: left;">
					<table width="100%" border="0" cellspacing="4" cellpadding="4">
						<tr>
							<td width="33.333%">SLIP.No : &nbsp; ${spCakeOrder.slipNo}</td>
							<td width="33.333%" align="center"><strong><b><c:choose>
											<c:when test="${spCakeOrder.frRType==1}">A</c:when>
											<c:when test="${spCakeOrder.frRType==2}">B</c:when>
											<c:when test="${spCakeOrder.frRType==3}">C</c:when>
										</c:choose></b></strong></td>
							<td width="33.333%" align="right">M.R.P:
								${spCakeOrder.slipMrp}</td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						style="border: 1px dashed #CCC;">
						<tr
							style="border-bottom: 1px dashed #CCC; display: inline-block; width: 100%;">
							<td width="20%"
								style="padding: 8px 10px; border-right: 1px dashed #CCC; float: left;">DEL
								DT</td>
							<td width="70%" style="padding: 8px 10px; float: left;"><strong>${spCakeOrder.spDeliveryDate}
									-- ${spCakeOrder.spDeliveryPlace}</strong></td>
						</tr>
						<tr
							style="border-bottom: 1px dashed #CCC; display: inline-block; width: 100%;">
							<td width="20%"
								style="padding: 8px 10px; border-right: 1px dashed #CCC; float: left;">ORD
								DT :</td>
							<td width="70%" style="padding: 8px 10px; float: left;">
								${spCakeOrder.orderDate}</td>
						</tr>
						<tr
							style="border-bottom: 1px dashed #CCC; display: inline-block; width: 100%; height: 50px;">
							<td width="20%"
								style="padding: 8px 10px; height: 78px; border-right: 1px dashed #CCC; float: left;">SHOP
								:</td>
							<c:set var="frName" value="${fn:toUpperCase(spCakeOrder.frName)}" />
							<c:set var="frCity" value="${fn:toUpperCase(spCakeOrder.frCity)}" />
							<td width="70%"
								style="padding: 8px 10px; height: 78px; float: left;">
								${frName}<strong>${frCity}</strong>
							</td>
						</tr>
						<tr
							style="border-bottom: 1px dashed #CCC; display: inline-block; width: 100%;">
							<td width="20%"
								style="padding: 8px 10px; border-right: 1px dashed #CCC; float: left;">QTY
								:</td>
							<td width="70%" style="padding: 8px 10px; float: left;">1</td>
						</tr>
						<c:set var="spName" value="${fn:toUpperCase(spCakeOrder.spName)}" />
						<tr
							style="border-bottom: 1px dashed #CCC; display: inline-block; width: 100%; height: 50px;">
							<td width="20%"
								style="padding: 8px 10px; height: 78px; border-right: 1px dashed #CCC; float: left;">ITEM
								:</td>
							<td width="70%"
								style="padding: 8px 10px; height: 78px; float: left;"><strong>${spName}.--${spCakeOrder.itemId}--${spCakeOrder.exVar1}</strong></td>
						</tr>
						<c:set var="spSelectedWeight"
							value="${fn:toUpperCase(spCakeOrder.spSelectedWeight)}" />
						<tr
							style="border-bottom: 1px dashed #CCC; display: inline-block; width: 100%;">
							<td width="20%"
								style="padding: 8px 10px; border-right: 1px dashed #CCC; float: left;">WEIGHT
								:</td>
							<td width="70%" style="padding: 8px 10px; float: left;"><strong>${spSelectedWeight}
									Kg.</strong></td>
						</tr>
						<tr
							style="border-bottom: 1px dashed #CCC; display: inline-block; width: 100%;">
							<c:set var="spfName"
								value="${fn:toUpperCase(spCakeOrder.spfName)}" />
							<td width="20%"
								style="padding: 8px 10px; border-right: 1px dashed #CCC; float: left;">FLAV
								:</td>
							<td width="70%" style="padding: 8px 10px; float: left;"><strong>
									${spfName} </strong></td>
						</tr>
						<tr
							style="border-bottom: 1px dashed #CCC; display: inline-block; width: 100%; height: 50px;">
							<td width="20%"
								style="padding: 8px 10px; border-right: 1px dashed #CCC; float: left; height: 78px;">MESSG
								:</td>
							<c:set var="spEvents"
								value="${fn:toUpperCase(spCakeOrder.spEvents)}" />
							<td width="70%"
								style="padding: 8px 10px; float: left; height: 78px;"><strong>
									${spEvents}</strong></td>
						</tr>
						<tr
							style="border-bottom: 1px dashed #CCC; display: inline-block; width: 100%; height: 78px;">
							<td width="20%"
								style="padding: 8px 10px; border-right: 1px dashed #CCC; float: left; height: 78px;">SPL.INST
								:</td>
							<c:set var="spInstructions"
								value="${fn:toUpperCase(spCakeOrder.spInstructions)}" />
							<td width="70%" style="padding: 8px 10px; float: left;">${spInstructions}</td>
						</tr>
						<tr style="display: inline-block; width: 100%;">
							<td width="20%"
								style="padding: 8px 10px; border-right: 1px dashed #CCC; float: left;">
								PHOTO :</td>
							<td width="70%" style="padding: 8px 10px; float: left;"><c:choose>
									<c:when test="${spCakeOrder.orderPhoto ne ''}">
										<a href="${imgUrl2}${spCakeOrder.orderPhoto}" height="60"
											width="60" style="border: medium;" alt="NA1" target="_blank;">PHOTO1</a>
									</c:when>
									<c:otherwise>NA1</c:otherwise>
								</c:choose>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:choose>
									<c:when test="${spCakeOrder.cusChoicePhoto ne ''}">
										<a href="${imgUrl}${spCakeOrder.cusChoicePhoto}" height="60"
											width="60" style="border: medium;" alt="NA2" target="_blank;">PHOTO2</a>
									</c:when>
									<c:otherwise>NA1</c:otherwise>
								</c:choose></td>
						</tr>
					</table>
				</td>

			</c:forEach>


		</tr>
	</table>


</body>
</html>