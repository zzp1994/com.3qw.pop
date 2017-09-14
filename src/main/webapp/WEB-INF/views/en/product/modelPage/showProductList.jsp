<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"	contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.mall.mybatis.utility.PageBean"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript">
$("#all-selector").click(function(){
	if ($(this).attr("checked") == "checked") { // 全选 
		$("input[type='checkbox']").each(function() { 
			$(this).attr("checked", true); 
		}); 
	}else{ // 反选 
		$("#showListTbody input[type='checkbox']").each(function() { 
			$(this).attr("checked", false);

		});
	}

});

</script>
<table id="J_BoughtTable" class="bought-table" data-spm="9" width="100%">
	<colgroup>
		<col class="select">
		<col class="baobei">
		<col class="price">
		<col class="stock">
		<col class="release-time">
		<col class="trade-operate">

	</colgroup>
	<thead>
		<tr class="col-name">
			<th colspan="2">Product Name</th>
			<th>Price</th>
			<th>Stocks</th>
			<th>Post Time</th>
			<th>Operation</th>
		</tr>
	</thead>
	<tbody class="data">
		<tr class="sep-row">
			<c:forEach items="${pb.result}"  var="pbr" begin="1" end="1">
				<c:if test="${pbr.istate==1&&pbr.counterfeittypeid==2}">
				<td><input class="all-selector gg" id="all-selector" type="checkbox"></td>
				<td colspan="5">
					<div class="operations">
					<label>Select All</label>
					<a class="tm-btn" href="javascript:void(0);" onclick="alertProductStopReason('')" role="button">Suspend</a>
					</div>
				</td>
				</c:if>
			</c:forEach>
		</tr>
	</tbody>

	<tbody class="data" id="showListTbody">
		<c:forEach items="${pb.result}" var="pbr">
			<tr class="order-hd">
				<td><c:if test="${pbr.istate==1&&pbr.counterfeittypeid==2}">
						<input class="selector" type="checkbox" id="${pbr.productId}"
							name="topPro">
					</c:if>
				</td>
				<td colspan="1">Product ID：${pbr.productId}</td>
					<td colspan="4">Brand：${pbr.brand.nameEn}
						<c:if test="${not empty pbr.subBrand}">
							>>${pbr.subBrand.nameEn}
						</c:if> 
							<c:if test="${pbr.counterfeittypeid == 1}">
						<button type="text" class="sr"
							onclick="showmsg('${pbr.description}')">Reason</button>
					</c:if>
					
					<c:if test="${pbr.istate==0&&pbr.counterfeittypeid==2}">
					<c:if test="${pbr.stopReason eq '缺货' || pbr.stopReason eq '滞销' || pbr.stopReason eq '汰换' || pbr.stopReason eq '更新商品信息'}">
						
						<strong class="ss">From the shelves because : ${fn:escapeXml(pbr.stopReason)}</strong>
					
					</c:if>
					<c:if test="${pbr.stopReason != '缺货' && pbr.stopReason != '滞销' && pbr.stopReason != '汰换' && pbr.stopReason != '更新商品信息'}">
						
						<button type="button" class="sr" onclick="showmsg('${fn:escapeXml(pbr.stopReason)}')">From the shelves because:Other</button>
					
					</c:if>
					</c:if>
				</td>
			</tr>
			<tr class="order-bd">
				<td class="baobei" colspan="2">
				    <a class="pic J_MakePoint"><img src="${pbr.imgURL}" alt="Product Image"> </a>
					<div class="desc" title="${fn:escapeXml(pbr.productName )}">
						<p class="baobei-name">
							<i> ${fn:escapeXml(pbr.productName )} </i>
						</p>
					</div>
				</td>
				<td>
					<i>
						<span>${pbr.moneyUnitSymbols} 
							<c:choose>
								<c:when test="${pbr.productPriceMin==pbr.productPriceMax}">
									<fmt:formatNumber pattern="0.0000#" value="${pbr.productPriceMin}"></fmt:formatNumber>
								</c:when>
								<c:otherwise>
									<fmt:formatNumber pattern="0.0000#" value="${pbr.productPriceMin}"></fmt:formatNumber>
									 ~
									 <fmt:formatNumber pattern="0.0000#" value="${pbr.productPriceMax}"></fmt:formatNumber>
								</c:otherwise>
							</c:choose>
						</span>
					</i>
				</td>
				<td><i> ${fn:escapeXml(pbr.futures )} </i></td>
				<td class="trade-status">${fn:escapeXml(pbr.strCreatedate )}</td>
				<td class="trade-operate">
				
						
						<c:if test="${supplierId == pbr.supplierid }">
							<c:choose>
								<c:when test="${pbr.istate==1&&pbr.counterfeittypeid==2}">
									<p><a class="tm-btn" href="showProduct?productId=${pbr.productId}">View</a></p>
									<p><a class="tm-btn" href="toEditUI?productId=${pbr.productId}&type=1">Edit</a></p>
									<p><a class="tm-btn" href="javascript:void(0)" onclick="alertProductStopReason(${pbr.productId})">Suspend</a></p>								
								</c:when>
								<c:when test="${pbr.istate==0&&pbr.counterfeittypeid==2}">
									<p><a class="tm-btn" href="showProduct?productId=${pbr.productId}">View</a></p>
									<p><a class="tm-btn" href="toEditUI?productId=${pbr.productId}&type=1">Edit</a></p>
									<p><a class="tm-btn" href="javascript:void(0)" onclick="proUp('${pbr.productId}')">Resume</a></p>
								</c:when>
								<c:when test="${pbr.counterfeittypeid==0}">
									<p><a class="tm-btn" href="showProduct?productId=${pbr.productId}">View</a></p>
								</c:when>
								<c:otherwise>
									<p><a class="tm-btn" href="showProduct?productId=${pbr.productId}">View</a></p>
									<p><a class="tm-btn" href="toEditUI?productId=${pbr.productId}&type=1">Edit</a></p>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${supplierId != pbr.supplierid }">
							<p><a class="tm-btn" href="showProduct?productId=${pbr.productId}">View</a></p>
						</c:if>
						
						<p><a class="tm-btn" href="toEditUI?productId=${pbr.productId}&type=2">Clone</a></p>
					</td>
			</tr>
			<tr style="height:10px;"></tr>
		</c:forEach>
	</tbody>
</table>
<c:if test="${!empty pb.result }">
	<%@include file="/WEB-INF/views/en/include/paging.jsp"%>
</c:if>