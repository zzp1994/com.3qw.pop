<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.mall.mybatis.utility.PageBean" %>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<table class="tb-stock" width="100%">
						<colgroup>
						<col width="60%">
						<col width="40%">
						</colgroup>
						
						
						<c:forEach items="${data}" var="stockProd">
							<thead>
								<tr>
									<th colspan="2" class="title"><h3>Product Name:${stockProd.key}</h3>
									<p>Maximum Quantity：<span>${stockProd.value[0].sumQty }</span></p>
									<p>Total Order Reserved：<span>${stockProd.value[0].sumPresubQty }</span></p></th>
								</tr>
								<tr>
									<th>Specification</th>
									<th>Order Reserved</th>
								</tr>
							</thead>
							<tbody>
									<c:forEach items="${stockProd.value}" var="prodSku">
										<tr>
											<td>${prodSku.skuNameEn}</td>
											<td>${prodSku.presubQty}</td>
										</tr>
									</c:forEach>
							
							</tbody>
						</c:forEach>
						
					</table>
					<c:if test="${!empty data}">
					<%@include file="/WEB-INF/views/en/include/paging.jsp"%>
					</c:if>
