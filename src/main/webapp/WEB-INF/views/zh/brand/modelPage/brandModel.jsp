<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.mall.mybatis.utility.PageBean" %>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%  
    String path = request.getContextPath();
    String url = request.getServletPath();
	request.setAttribute("path",path);
%>
<div class="cont">
	<div class="u_list brand-list">
		<ul class="title_1">
			<li class="p1 f_l">
				<%--<input type="checkbox" class="f_l c_mtop2">
				<p class="f_l">&nbsp;全选</p>
			--%></li>
			<li class="p2 f_l">
				<button type="button" class="btn1 f_l" onclick="addBrand()">新建品牌</button>
			</li>
			<li class="clear"></li>
		</ul>
		<p class="blank5"></p>
		<h2>
			<p class="p1">序列号</p><%--
			<p>序号</p>
			--%><p>品牌名称</p>
			<p>品牌类型</p>
			<%-- <c:if test="${supplierType eq 2 || supplierType eq 5}">
				<p>子供应商</p>
			</c:if> --%>
			<p>审核状态<p>
			<!-- <p class="p5">操作</p> -->
		</h2>
		<ul class="title_2">
			<c:forEach items="${pb.result}" var="brand" varStatus="num">
		     
				 	<li class="">
					    
						<p class="p1">${(pb.page-1)*pb.pageSize+num.count }</p>
						
						<p class="p2" title="${brand.name}">${brand.name}&nbsp;</p>
				       	<p class="p3" title="">
				       		<c:if test="${brand.type == 0 }">普通代理</c:if>
				       		<c:if test="${brand.type == 1 }">独家代理</c:if>
				       		<c:if test="${brand.type == 2 }">自主品牌</c:if>
				       	</p>
				       	<%-- <c:if test="${supplierType eq 2 || supplierType eq 5}">
							<p class="p2" title="${brand.subSupplierName}">${brand.subSupplierName}&nbsp;</p>
				       	</c:if> --%>
				       	<p class="p3" title="">
							<c:if test="${brand.status == 0 }">待审核</c:if>
				       		<c:if test="${brand.status == 1 }">审核通过</c:if>
				       		<c:if test="${brand.status == 2 }">审核不通过</c:if>
						</p>
						<%-- <p class="p5">
						     
								<span class="c_poin dele" onclick="delBrand('${brand.brandId}')">[删除]</span>
								<c:if test="${brand.status == 2 }">
									<a href="${path}/brand/toEditUI?id=${brand.brandId}">[修改]</a>
								</c:if>
								<c:if test="${brand.status == 1 && (supplierType eq 2 || supplierType eq 5)}">
										<span class="c_poin span2" onclick="manage('${brand.brandId}','${brand.name}')">[管理]</span>
								</c:if>
						</p> --%>
						<span style="display:block;clear:both;"></span>
					</li>
			
		  	</c:forEach>
		    
		</ul>
	</div>
</div>

<c:if test="${!empty pb.result}">
<%@include file="/WEB-INF/views/zh/include/paging.jsp" %>	
</c:if>


<script type="text/javascript">
$(document).ready(function(){
	
	$("#editDiv").hide();
	$("#editDiv .w_close").click(function(){
		$("#editDiv").hide();
		$("#editForm")[0].reset();	
	});
	
	$("#userEidtCancel").click(function(){
		$("#editDiv").hide();
		$("#editForm")[0].reset();	
	});
	
});
</script>
