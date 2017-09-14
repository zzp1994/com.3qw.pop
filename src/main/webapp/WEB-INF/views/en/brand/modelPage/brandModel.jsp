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
				<button type="button" class="btn1 f_l" onclick="addBrand()">Create Brand </button>
			</li>
			<li class="clear"></li>
		</ul>
		<p class="blank5"></p>
		<h2>
			<p class="p1">Serial ID</p><%--
			<p>序号</p>
			--%><p>Brand Name</p>
			<p>Brand Type</p>
			<c:if test="${supplierType eq 2 || supplierType eq 5}">
				<p>Subsupplier</p>
			</c:if>
			<p>Approval Status<p>
			<p class="p5">Operate</p>
		</h2>
		<ul class="title_2">
			<c:forEach items="${pb.result}" var="brand" varStatus="num">
		     
				 	<li class="">
					    
						<p class="p1">${(pb.page-1)*pb.pageSize+num.count }</p>
						
						<p class="p2" title="${brand.name}">${brand.name}&nbsp;</p>
				       	<p class="p3" title="">
				       		<c:if test="${brand.type == 0 }">Agent</c:if>
				       		<c:if test="${brand.type == 1 }">Exclusive Agent</c:if>
				       		<c:if test="${brand.type == 2 }">Own Brand</c:if>
				       	</p>
				       	
				       	<c:if test="${supplierType eq 2 || supplierType eq 5}">
							<p class="p2" title="${brand.subSupplierName}">${brand.subSupplierName}&nbsp;</p>
						</c:if>
						
				       	<p class="p3" title="">
							<c:if test="${brand.status == 0 }">To Be Approved</c:if>
				       		<c:if test="${brand.status == 1 }">Approved</c:if>
				       		<c:if test="${brand.status == 2 }">Not Approved </c:if>
						</p>
						<p class="p5">
						     
								<span class="c_poin dele" onclick="delBrand('${brand.brandId}')">[Delete]</span>
							<c:if test="${brand.status == 2 }">
							<a href="${path}/brand/toEditUI?id=${brand.brandId}">[Edit]</a>
							</c:if>
							<c:if test="${(supplierType eq 2 || supplierType eq 5) && brand.status == 1 }">
							<span class="c_poin span2" onclick="manage('${brand.brandId}','${brand.name}')">[Manage]</span>
							</c:if>
						</p>
						<span style="display:block;clear:both;"></span>
					</li>
			
		  	</c:forEach>
		     
	    
	    </ul>
	</div>
</div>
<c:if test="${!empty pb.result}">
<%@include file="/WEB-INF/views/en/include/paging.jsp" %>	
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