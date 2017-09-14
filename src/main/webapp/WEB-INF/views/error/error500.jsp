<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!doctype>
<html>
  <head>
    <%@include file="/WEB-INF/views/zh/include/base.jsp"%>
    <%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    <title><spring:message code="error.500" /></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" type="text/css" href="${path}/css/error_all.css">
  </head>
  <body class="error-404">
<%--   <%@include file="/WEB-INF/views/zh/include/header.jsp" %> --%>
  <input id="language" type="hidden" name="language" value="<spring:message code="language" />"  />
  <div id="doc_main">
	<section class="bd clearfix">
		<div class="module-error">
			<div class="error-main clearfix">
				<div class="label"></div>
				<div class="info">
					<h3 class="title" ><spring:message code="error.500message1" /></h3>
					<div class="reason">
					    <br>
						<p><spring:message code="error.500message2" /></p>
					</div>
					<div class="oper">
						<p><a href="javascript:history.go(-1);"><spring:message code="error.404message5" />&gt;</a></p>
						<p><a href="${path}/user/index"><spring:message code="error.404message6" />&gt;</a></p>
					</div>
				</div>
			</div>
		</div>
	</section>
  </div>
</body>
</html>
