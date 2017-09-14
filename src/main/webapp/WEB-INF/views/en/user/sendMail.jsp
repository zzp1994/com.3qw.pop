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
    <title>Password Forgotten</title>
    <link type="text/css" rel="stylesheet" href="${path}/css/regist.css"/>
        <link href="${path}/css/findPwd.css" rel="stylesheet" type="text/css">
    <link rel="shortcut icon" href="${path}/images/favicon.ico" />
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
                 <!--    <a href="?locale=zh_CN">中文 &nbsp; </a>    
		            <a href="?locale=en">English&nbsp;  </a>     -->
                     Hello, welcome to 3QIANWAN 
                    <span>
                    <a href="${path}/user/loginUI"> [Login] </a>
                    <a class="link-regist" href="${path}/supplier/registUI"> [Register] </a>
                    </span>
                    </li>
                </ul>
            </div>
        </div>
<div class="w">
    <div id="logo"><a href="${path}/user/loginUI" clstag="passport|keycount|login|01">
    <img src="${path}/images/login-logo-sm.png" alt="<spring:message code="logo" />" width="170"
                                                     height="60"/></a>
     <b style="background: url('${path}/images/regist-wel-en.png') no-repeat scroll 0 0 rgba(0, 0, 0, 0);"></b></div>
</div>
<div id="entry" class="w m">
	<div class="mt">
		<h2>Retrieve Password</h2>
		<b></b> </div>
	<div class="mc">
		<div class="step step-en">
			<ul>
				<li class="one">Fill in login name</li>
				<li class="two cur">Verification of identity</li>
				<li class="">Reset your password</li>
				<li class="four">Complete</li>
			</ul>
		</div>
		<div class="formpwd">
		   <c:if test="${!empty uid and !empty username and !empty email }">
			   <div id="emailDiv">
					<div class="item"> <span class="label">login name：</span>
						<div class="fl">
							<label class="text-ifo text-two">${username}</label>
							<label class="blank invisible" id="username_succeed"></label>
							<span class="clr"></span> </div>
					</div>
					<div class="item"> <span class="label">email：</span>
						<div class="fl">
							<label class="text-ifo text-two">${email}</label>
						</div>
					</div>
					<div class="item"> <span class="label">&nbsp;</span>
						<input type="button" tabindex="4" value="sendMail"  onclick="sendFindPwdEmail('${uid}');"  id="sendMail" class="btn-img btn-entry">
					 <a class="e-ifon" href="javascript:"></a> </div>
				</div>
		   </c:if>
		   <c:if test="${!empty uid and empty username and empty email }">
			  <!--Email发送成功-->
			<div class="call suc"> <b></b><span>Validation email has been sent, please<strong></strong><!-- <a onclick="window.location.href='http://mail.163.com'" href="javascript:void(0);"> </a>--> login your email after finish validation</span> </div>
			  
		   </c:if>
		   <c:if test="${empty uid and empty username and empty email }">
			  <div class="fl">
			     <span class="ftx-02">Retrieve password link has expired！</span><br>
				 You can ：<a href="${path}/supplier/findPwd" class="btn btn-7"><s></s>resend mail</a>
		     </div>
			 <div class="clr"></div>
		   </c:if>
		</div>
		<span class="clr"></span>
	 </div>
</div> 	
<script type="text/javascript" src="${path}/js/user/en/validate_findPwd.js"></script>
</body>
</html>

