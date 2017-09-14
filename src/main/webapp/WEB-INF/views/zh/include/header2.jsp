<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%-- <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String path = request.getContextPath();
	request.setAttribute("path",path);
%>
<link rel="stylesheet" type="text/css" href="${path}/css/reset.css"/>
<script src="${path}/js/commons/jquery-1.8.3.min.js"></script> --%>
	<!-- 导航 start -->
	<input type="hidden" id="host"  value="${path}">
	<div class="t_nav">
		<div class="box">
			<ul class="ul_horizontal u2">
<%-- 一期屏蔽看后期需求	<li><a href="${path}/user/index">首页</a></li> --%>

<!-- 						<li> -->
<%-- 							<a href="${path}/product/getPro">卖家中心</a> --%>
<!-- 				    	</li> -->
				    	<c:if test="${ !empty defaultUrlMapReslut['卖家中心']}" >
						<li>
							<a href="${path}${defaultUrlMapReslut['卖家中心']}">卖家中心</a>
				    	</li>
				    </c:if>
				<c:if test="${ !empty defaultUrlMapReslut['系统中心']}" >
					<li>
	                <a href="${path}${defaultUrlMapReslut['系统中心']}">系统中心</a>
	                </li>
			    </c:if>
				<!-- <li><a href="#">联系客服</a></li> -->
				<!-- <span style="display:block; float:right; margin:-92px 50px 0 0;">  
					 <a href="?locale=zh_CN">中文</a>  &nbsp;
					 <a href="?locale=en">Enlish</a>  
				</span>  -->
				<!-- <li class="kk">
					<a href="?locale=zh_CN">中文</a>	 
				</li>
				<li><a href="?locale=en">Enlish</a></li> -->
			</ul>
			<!-- <div class="eng">
				<a href="?locale=zh_CN">中文</a>
				<a href="?locale=en">English</a>	
			</div> -->
			<div class="t_user f_r">
	        <c:if test="${  !empty defaultUrlMapReslut['系统中心']}" >
					<ul class="u1 ul_horizontal f_l">
					<a href="${path}${defaultUrlMapReslut['系统中心']}">
					<p class="f_l"><img src="${path}/images/img_heard.png" alt=""></p>
					   <c:if test="${!empty supplier.icon}"> 
					   		<%-- <li><img src="${supplier.icon}"  height="32" alt=""></li> --%>
					   </c:if>
						<li class="m1">${loginUser.loginName}</li>
<!-- 						<li class="m2"><img src="../images/img_t.png" alt=""></li> -->
					</a>
						<li class="m3" onclick="clearCookie()" style="cursor:pointer;color:#FFF" >退出</li>
				    </ul>
			     
		   </c:if>
		     <c:if test="${ empty defaultUrlMapReslut['系统中心']}" >
					<ul class="u1 ul_horizontal f_l">
				      <c:if test="${!empty supplier.icon}"> 
					   		<li><img src="${supplier.icon}"  height="32" alt=""></li>
					   </c:if>
						<li class="m1" style="color:#FFF">${loginUser.loginName}</li>
<!-- 						<li class="m2" style="color:#FFF"><img src="../images/img_t.png" alt=""></li> -->
						<li class="m3" onclick="clearCookie()" style="cursor:pointer;color:#FFF" >退出</li>
				    </ul>
		   </c:if>
			</div>	
		</div>
	</div>
<!-- 导航 end -->
	
	