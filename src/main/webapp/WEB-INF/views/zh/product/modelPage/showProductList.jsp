<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
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
			<th colspan="2">宝贝名称</th>
			<th>价格</th>
			<th>库存量</th>
			<th>发布时间</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody class="data">
		<tr class="sep-row">
			<c:forEach items="${pb.result}"  var="pbr" begin="1" end="1">
				<c:if test="${pbr.istate==1&&pbr.counterfeittypeid==2}">
				<td><input class="all-selector gg" id="all-selector" type="checkbox"></td>
				<td colspan="5">
					<div class="operations">
					<label>全选</label>
					
					
					<a class="tm-btn" href="javascript:void(0);" onclick="alertProductStopReason('')" role="button">下架</a>
					
					
					</div>
				</td>
				</c:if>
				
				<c:if test="${pbr.istate==0&&pbr.counterfeittypeid==2}">
				<td><input class="all-selector gg" id="all-selector" type="checkbox"></td>
				<td colspan="5">
					<div class="operations">
					<label>全选</label>
					
					
					<a class="tm-btn" href="javascript:void(0);" onclick="allUpType('2')" role="button">上架</a>
					
					
					</div>
				</td>
				</c:if>
				
				
				
			</c:forEach>
		</tr>
	</tbody>

	<tbody class="data" id="showListTbody">
		<c:forEach items="${pb.result}" var="pbr">
			<tr class="order-hd">
				<td>
					<c:if test="${pbr.counterfeittypeid==2}">
						<input class="selector" type="checkbox" id="${pbr.productId}" name="topPro">
					</c:if>
				</td>
				<td colspan="1">商品ID：${pbr.productId} 
					
					</td>
				<td colspan="4">商品品牌：${pbr.brand.nameCn}
					<c:if test="${not empty pbr.subBrand}">
						>>${pbr.subBrand.nameCn}
					</c:if> 
					<c:if test="${pbr.counterfeittypeid == 1}">
						<button type="text" class="sr" onclick="showmsg('${pbr.description}')">未通过原因</button>
					</c:if>
					<c:if test="${pbr.istate==0&&pbr.counterfeittypeid==2}">
					<c:if test="${pbr.stopReason eq '缺货' || pbr.stopReason eq '滞销' || pbr.stopReason eq '汰换' || pbr.stopReason eq '更新商品信息'}">
						
						<strong class="ss">下架原因 : ${fn:escapeXml(pbr.stopReason)}</strong>
					
					</c:if>
					<c:if test="${pbr.stopReason != '缺货' && pbr.stopReason != '滞销' && pbr.stopReason != '汰换' && pbr.stopReason != '更新商品信息'}">
						
						<button type="button" class="sr" onclick="showmsg('${fn:escapeXml(pbr.stopReason)}')">下架原因:其他</button>
					
					</c:if>
					</c:if>
				</td>
			</tr>
			<tr class="order-bd">
				<td class="baobei" colspan="2">
				    <a class="pic J_MakePoint"><img src="${pbr.imgURL}" alt="商品图片"> </a>
					<div class="desc" title="${fn:escapeXml(pbr.productName)}">
						<p class="baobei-name">
							<i> ${fn:escapeXml(pbr.productName)} </i>
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
				<td><i> ${pbr.futures } </i></td>
				<td class="trade-status">${pbr.strCreatedate }</td>
				<td class="trade-operate">
						<c:if test="${supplierId == pbr.supplierid }">
							<c:choose>
								<c:when test="${pbr.istate==1&&pbr.counterfeittypeid==2}">
										<p><a class="tm-btn" href="showProduct?productId=${pbr.productId}">查看</a></p>
									
										<p><a class="tm-btn" href="toEditUI?productId=${pbr.productId}&type=1">修改</a></p>
										
										<p><a class="tm-btn" href="javascript:void(0)" onclick="alertProductStopReason(${pbr.productId})" <%-- onclick="proDown('${pbr.productId}')" --%>>下架</a></p>								
										<%-- <p><a class="tm-btn" href="toEditAttribute?productId=${pbr.productId}">修改商品</a></p>
										<p><a class="tm-btn" href="toEditPrice?productId=${pbr.productId}">修改价格</a></p> --%>
								</c:when>
								<c:when test="${pbr.istate==0&&pbr.counterfeittypeid==2}">
									<p><a class="tm-btn" href="showProduct?productId=${pbr.productId}">查看</a></p>
									<p><a class="tm-btn" href="toEditUI?productId=${pbr.productId}&type=1">修改</a></p>
									<p><a class="tm-btn" href="javascript:void(0)" onclick="proUp('${pbr.productId}')">上架</a></p>
									<%-- <p><a class="tm-btn" href="javascript:void(0)" onclick="prodel('${pbr.productId}')">删除</a></p> --%>
								</c:when>
								<c:when test="${pbr.counterfeittypeid==0}">
									<p><a class="tm-btn" href="showProduct?productId=${pbr.productId}">查看</a></p>
								</c:when>
								<c:otherwise>
									<p><a class="tm-btn" href="showProduct?productId=${pbr.productId}">查看</a></p>
									<p><a class="tm-btn" href="toEditUI?productId=${pbr.productId}&type=1">修改</a></p>
									<%-- <p><a class="tm-btn" href="javascript:void(0)" onclick="prodel('${pbr.productId}')">删除</a> --%>
								</c:otherwise>
							</c:choose>
					</c:if>
					<c:if test="${supplierId != pbr.supplierid }">
						<p><a class="tm-btn" href="showProduct?productId=${pbr.productId}">查看</a></p>
					</c:if>
					
					<p><a class="tm-btn" href="toEditUI?productId=${pbr.productId}&type=2">克隆</a></p>
					<p><a class="tm-btn" href="javascript:void(0);" onclick="editInventory(${pbr.productId}, ${supplierId})">修改库存</a></p>
					</td>
			</tr>
			<tr style="height:10px;"></tr>
		</c:forEach>
	</tbody>
</table>
			
<c:if test="${!empty pb.result}">
	<%@include file="/WEB-INF/views/zh/include/paging.jsp" %>	
</c:if>