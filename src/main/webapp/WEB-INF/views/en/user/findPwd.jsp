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
                      <a  href="?locale=zh_CN">中文 &nbsp; </a>    
		              <a href="?locale=en">English&nbsp;  </a>    
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
				<li class="one cur">Fill in login name</li>
				<li class="">Verification of identity</li>
				<li class="">Reset your password</li>
				<li class="four">Complete</li>
			</ul>
		</div>
		<form  id="findPwdForm" action="${path}/supplier/findPwdNext" method="post">
		<div class="formpwd">
			<div class="item"> <span class="label">login name：</span>
				<div class="fl">
					<input type="text" tabindex="1" class="text text-color" onfocus="usernameOnfocus();" onblur="usernameOnblur();" id="username" name="username" value="login name">
				    <input type="hidden" name="uid" value="${uid}">
					<span class="clr"></span>
					<label id="username_error" calss=""></label>
				</div>
			</div>
			<div class="item"> <span class="label">verification code：</span>
				<div class="fl">
					<input type="text" tabindex="3" name="authCode" id="authCode" class="text text-1" onfocus="authCodeFocus();" onblur="authCodeBlur();" >
					<label class="img"><img id="JD_Verification1" src="${path}/supplier/validateCode?uid=${uid}" alt="verification code" style="cursor:pointer;width:100px;height:26px;" /></label>
					<label class="ftx23">&nbsp;<a class="flk13" href="javascript:changeCode();">Try a new one</a></label>
					<span class="clr"></span>
					<label id="authCode_error" class=""></label>
				</div>
			</div>
			<div class="item"> <span class="label"></span>
				<input type="button" tabindex="4" value="Next"  id="findPwdSubmit" class="btn-img btn-entry">
			</div>
		</div>
		</form>
		<span class="clr"></span> </div>
</div>
<script type="text/javascript" src="${path}/js/user/en/validate_findPwd.js"></script>
<script type="text/javascript" >
$(function(){  //生成验证码       
	var msg='${message}';
	if(''!=msg){
		alert(msg);
	}
    $("#JD_Verification1").click(function () {  
    $(this).hide().attr("src", "${path}/supplier/validateCode?uid=${uid}&"+Math.random()*100 ).fadeIn(); });
    $("#findPwdSubmit").click(function(){
    	 var submit = true;
    	 submit= checkAuthCode();
         if(submit){
        	var kaptcha = $("#authCode").val();
   	    	  $.ajax({
   		   		     type: "POST",
   		   		     dataType:"html",
   		   		     async: false,
   		   		     url : "${path}/supplier/validateNum?uid=${uid}&rd="+Math.random(), 
   		   		     success : function(msg) {
   			   		     if(msg.toLowerCase()!=(kaptcha).toLowerCase()){
   			   			    $("#authCode").removeClass().addClass("text text-1 highlight2");
   			 		        $("#authCode_error").removeClass().addClass("msg-error").html("please enter the verification code");
   			   		  		changeCode();
   			   		    	$("#authCode").val("");
   			   		  		submit = false;
   			   		  		return submit;
   			   		     }else{
   			        		$("#findPwdForm").submit();
   			   		     }
   		   			},
   	  			});    
         }
        
    });
});   
/* window.onbeforeunload = function(){  
    //关闭窗口时自动退出  
    if(event.clientX>360&&event.clientY<0||event.altKey){     
        alert(parent.document.location);  
    }  
};    */       
function changeCode() {  //刷新
    $("#JD_Verification1").hide().attr("src", "${path}/supplier/validateCode?uid=${uid}&"+Math.random()*100).fadeIn();  
};

</script>
</body>
   
</html>

