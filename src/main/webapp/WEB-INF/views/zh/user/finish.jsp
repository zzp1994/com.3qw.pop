<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%  
    String path = request.getContextPath();
	request.setAttribute("path",path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>找回密码</title>
    <link type="text/css" rel="stylesheet" href="${path}/css/regist.css"/>
    <link href="${path}/css/findPwd.css" rel="stylesheet" type="text/css">
    <link rel="shortcut icon" href="${path}/images/favicon1.ico" />
   <script type="text/javascript" src="${path}/js/commons/jquery-1.8.3.min.js"></script>
    <style type="text/css">
body{
    color: #333333;
    font-family: Arial,"宋体",Lucida,Verdana,Helvetica,sans-serif;
    font-size: 12px;
    line-height: 150%;
    background: none repeat scroll 0 0 #F2F2F2;
    margin: 0;
}
    </style>
</head>
<body>
    <div id="shortcut-2013">
     <div class="w">
                <ul class="fr lh">
                    <li id="loginbar" class="fore1" clstag="homepage|keycount|home2013|01b">
                   <!--    <a  href="?locale=zh_CN">中文 &nbsp; </a>    
		              <a href="?locale=en">English&nbsp;  </a>     -->
                          您好，欢迎来到三千万
                    <span>
                    <a href="${path}/user/loginUI"> [登录] </a>
                    <a class="link-regist" href="${path}/supplier/registUI">[免费注册]</a>
                    </span>
                    </li>
                </ul>
            </div>
        </div>
<div class="w">
    <div id="logo"><a href="${path}/user/loginUI" clstag="passport|keycount|login|01">
    <img src="${path}/images/login-logo-sm.png" alt="<spring:message code="logo" />" width="170"
                                                     height="60"/></a>
     <b style="background: url('${path}/images/regist-wel-cn.png') no-repeat scroll 0 0 rgba(0, 0, 0, 0);"></b></div>
</div>
<div id="entry" class="w m">
	<div class="mt">
		<h2>找回密码</h2>
		<b></b> </div>
	<div class="mc">
		<div class="step">
			<ul>
				<li class="one one1">填写账户名</li>
				<li class="two two1">验证身份</li>
				<li class="three">设置新密码</li>
				<li class="four cur four1">完成</li>
			</ul>
		</div>
		<div class="formpwd">
			<div class="call suc m-return"> <b></b><span><strong>新密码设置成功!</strong><br>
				请牢记您新设置的密码。<a href="${path}/user/loginUI">返回登录</a></span> </div>
		</div>
		<span class="clr"></span> </div>
</div>
<script type="text/javascript" src="${path}/js/user/zh/validate_findPwd.js"></script>
</body>
<%@include file="/WEB-INF/views/zh/include/foot.jsp"%>
</html>

