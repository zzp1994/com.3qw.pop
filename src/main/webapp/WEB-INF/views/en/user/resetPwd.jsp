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
                  <!--   <a  href="?locale=zh_CN">中文 &nbsp; </a>    
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
<c:if test="${message == 1}">
<div id="entry" class="w m">
	<div class="mt">
		<h2>Retrieve Password</h2>
		<b></b> </div>
	<div class="mc">
		<div class="step step-en">
			<ul>
				<li class="one one1">Fill in login name</li>
				<li class="two">Verification of identity</li>
				<li class="three cur">Reset your password</li>
				<li class="four">Complete</li>
			</ul>
		</div>
		<div class="formpwd">
			<div class="item"> <span class="label">New password：</span>
				<div class="fl">
					<input type="password" name="password" tabindex="1" onfocus="passwordFocus();" onblur="passwordBlur();" class="text" id="password"/>
					<input id="" type="hidden" name="uid" value="${uid}">
					<span class="clr"></span>
					<label id="password_error" class=""></label>
				</div>
			</div>
			<div class="item"> <span class="label">Re-enter Password：</span>
				<div class="fl">
					<input type="password" name="repassword" tabindex="2" onfocus="repasswordFocus();" onblur="repasswordBlur();" class="text" id="repassword"/>
					<span class="clr"></span>
					<label id="repassword_error" class=""></label>
				</div>
			</div>
			<div class="item"> <span class="label">&nbsp;</span>
				<input type="button" tabindex="8" value="Submit" id="resetPwdSubmit" onclick="updatePassword('${uid}');"  class="btn-img btn-entry">
			</div>
		</div>
		<span class="clr"></span> </div>
</div>
</c:if>
<c:if test="${message == 0}">
<div id="entry" class="w m">
			<div class="mt"> 
				<h2>Retrieve Password</h2>
				<b></b>
			</div>
		    <div class="mc">
				<div class="m1 succeed">
					<div class="i-m">
						<div class="fl"><span class="ftx-02">Retrieve password link has expired!</span><br>
						You can：<a href="${path}/supplier/findPwd" class="btn btn-7"><s></s>resend mail</a></div>
						<div class="clr"></div>
					</div>
				</div>
			</div>
			<span class="clr"></span> 
	</div>
</div>
</c:if>

<script type="text/javascript" src="${path}/js/user/en/validate_findPwd.js"></script>
<script type="text/javascript" >
$(function(){  //生成验证码         
//	forget
    /* $("#resetPwdSubmit").click(function(){
    	 var submit = true;
    	 submit= checkAuthCode();
         if(submit){
        	var kaptcha = $("#authCode").val();
   	    	  $.ajax({
   		   		     type: "POST",
   		   		     dataType:"html",
   		   		     async: false,
   		   		     url : "${path}/supplier/?uid=${uid}&rd="+Math.random(), 
   		   		     success : function(msg) {
   			   		     if(msg.toLowerCase()!=(kaptcha).toLowerCase()){
   			   			    $("#authCode").removeClass().addClass("text text-1 highlight2");
   			 		        $("#authCode_error").removeClass().addClass("msg-error").html("请输入验证码");
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
    }); */
});   
       
function resetPassword() {  //刷新
    $("#JD_Verification1").hide().attr("src", "${path}/supplier/validateCode?uid=${uid}&"+Math.random()*100).fadeIn();  
};

</script>
</body>
</html>