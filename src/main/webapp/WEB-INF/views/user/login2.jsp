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
    <title><spring:message code="loginTitle" /></title>
     <link type="text/css" rel="stylesheet" href="${path}/css/login.css"/>
	<link rel="shortcut icon" href="${path}/images/favicon1.ico" />
     <script type="text/javascript" src="${path}/js/commons/jquery-1.8.3.min.js"></script>
    <style type="text/css">
  body{
    color: #333333;
    font-family: Arial,"宋体",Lucida,Verdana,Helvetica,sans-serif;
    font-size: 12px; 
    line-height: 150%;
    background: none repeat scroll 0 0 #F2F2F2;
}
    </style>
    <script type="text/javascript">
    $(document).ready(function(){
	    $("#loginsubmit").click(function(){
	    	var submit = true;
	         if($("#loginname").val() == ""){
	           //  $("#loginname_error").addClass("error");
	            // $("#loginname_error").removeClass("hide");
	             $("#loginname_error").fadeIn("slow");
	            // $("#loginname").get(0).focus();
	             submit = false;
	         } 
	         if ($("#password").val() ==""){
	             //$("#loginpwd_error").addClass("error");
	            // $("#loginpwd_error").removeClass("hide");
	             $("#loginpwd_error").fadeIn(1000);
	             //$("#password").get(0).focus();
	             submit = false;
	         }
	         if($("#kaptcha").val() ==""){
	       	  $("#logincode_error").fadeIn(1000);
	       	  submit = false;
	         }
	         
	         if(submit){
	        	var kaptcha = $("#kaptcha").val();
	       	  	
	   	    	  $.ajax({
	   		   		     type: "POST",
	   		   		     dataType:"html",
	   		   		     async: false,
	   		   		     url : "${path}/supplier/validateNum?uid=${uid}&rd="+Math.random(), 
	   		   		     success : function(msg) {
	   			   		     if(msg.toLowerCase()!=(kaptcha).toLowerCase()){
	   			   		    	$("#logincode_error1").fadeIn(1000);
	   			   		  		changeCode();
	   			   		    	$("#kaptcha").val("");
	   			   		  		 submit = false;
	   			   		     }
	   			   			
	   		   			},
	   	  			
	   	  			});    
	       	 	
	         }
	         
	         if(submit){
	        	 $("#formlogin").submit();
	        	 
	         }
	         
	    });
    	
    });	
      
      function clearError(){
         $("#loginname_error").fadeOut("slow");
         $("#loginpwd_error").fadeOut("slow");
         $("#loginpwd_error1").fadeOut("slow");
         $("#logincode_error").fadeOut("slow");
         $("#logincode_error1").fadeOut("slow");
      }
      $(function(){
    	var mess= $("#message").val();
  
    	if(mess.length>0){
    		$("#loginpwd_error1").html(mess);
    	    $("#loginpwd_error1").fadeIn(1000);
    	}
    	
    	var $inp = $("#kaptcha"); //所有的input元素 
    	$inp.keypress(function (e){ //这里给function一个事件参数命名为e，叫event也行，随意的，e就是IE窗口发生的事件。 
    	var key = e.which; //e.which是按键的值 
    	if (key == 13) { 
    		$("#loginsubmit").click();
    	} 
    	});
    	
      })
    </script>
        
</head>
<body>
<br>
<div class="w">
    <div id="logo"><a href="index.html" clstag="passport|keycount|login|01">
    <img src="${path}/images/login-logo-sm.png" alt="<spring:message code="logo" />" width="170" height="60"/></a><%--
    <b style="background: url('${path}/images/login-wel-<spring:message code="language" />.png') no-repeat scroll 0 0 !important;"></b>
    --%>
    </div>
     <%--<span style="display:block; float:right; margin:-92px 50px 0 0;">
		 <a href="${path}/user/loginUI?locale=zh_CN">中文</a>  &nbsp;
		 <a href="${path}/user/loginUI?locale=en">English</a>  
	</span> --%>
</div>
<form id="formlogin"  action="${path}/user/login2" method="post" >
 <input id="language" type="hidden" name="language" value="<spring:message code="language" />" />
    <div class=" w1" id="entry">
        <div class="mc " id="bgDiv">
            <div id="entry-bg" clstag="passport|keycount|login|02" style="width: 511px; height: 455px; 
             background: url('${path}/images/login-sm1.jpg') no-repeat scroll 0px 0px transparent; position: absolute;">

            </div>
            <div class="form ">
                <div class="item fore1">
                    <span><spring:message code="name" /></span>
                    <div class="item-ifo">
                        <input type="text" id="loginname" name="loginname"  value="${fn:escapeXml(loginname)}" class="text" onfocus="clearError()"  
                               autocomplete="off"/>
                               <div class="i-name ico"></div>
                        <label id="loginname_error" onclick="clearError()" class="hide error"><spring:message code="login.name" /></label>
                    </div>
                </div>
                <div class="item fore2">
                    <span><spring:message code="password" /></span>
                    <div class="item-ifo">
                        <input type="password" id="password" name="password" onfocus="clearError()" class="text" autocomplete="off"/>
                        <div class="i-pass ico"></div>
                        <label id="loginpwd_error" onclick="clearError()" class="hide error" ><spring:message code="login.password" /></label>
                    </div>
                </div>   
                
                <div class="item form-group">
						   <span><spring:message code="login.randomCode"/></span> 
						   <div class="item-ifo">
							   <input type="text" id="kaptcha" name="kaptcha"  onfocus="clearError()"  maxlength="4" class="text form-control"  />
							   <input type="hidden" name="uid"   value="${uid}" />
							   <i class="i-pass"></i>
	                            <label id="kaptcha_succeed" class="blank"></label>
	                           <label id="kaptcha_error" class="hide"></label>
						   <div class="yzm-bar"> 
						   <%-- <input type="text" value="${code}"/> --%>
						   <img src="${path}/supplier/validateCode?uid=${uid}" id="kaptchaImage" width="85" height="34" />       
						   <a href="javascript:;" onclick="changeCode()"><spring:message code="login.codenewone" /></a>
					   </div>
                        <label id="logincode_error" onclick="clearError()" class="hide error"><spring:message code="login.codeNumEmpty" /></label>
                        <label id="logincode_error1" onclick="clearError()" class="hide error"><spring:message code="login.codeNumError" /></label>
                        <label id="loginpwd_error1" onclick="clearError()" class="hide error" ></label>
                       </div>
					   
		    		</div> 
                 <div class="item" style="height:20px; min-height: 20px;">
                    <a href="${path}/supplier/findPwd"><spring:message code="findPwd" /></a>
                </div>       
                <div class="item login-btn2013">
                    <input type="button" class="btn-img btn-entry-<spring:message code="language" />"   id="loginsubmit" value="<spring:message code="login" />" clstag="passport|keycount|login|06"/>
                </div>
            </div>

        </div>
        <div class="free-regist">
            <span><a href="${path}/supplier/registUI" clstag="passport|keycount|login|08"><spring:message code="regist" />&gt;&gt;</a></span>
            <%-- <span><a href="${path}/supplier/registUI2?userid=10">注册2</a></span> --%>
        </div>
    </div> 
     <input id="message" type="hidden" value="${message}" />
     
     
     
     
     
     
</form>
  
<div class="w1">
    <div id="mb-bg" class="mb"></div>
</div>
<div class="w">
    <div id="footer-2013"><%--
        <div class="copyright">Copyright</div>
    --%></div>
</div>
<!-- 	<div style="width: 1020;text-align: center;margin: 0 auto;background: url(../images/sjmanger.png) repeat-x;height: 20px; padding: 10px;"> -->
<!-- 	 	<h1 class="logo_dl"></h1> -->
<!-- 	</div> -->
	 <!-- 底部 start -->
	<%@include file="/WEB-INF/views/zh/include/foot.jsp"%>
</body>
</html>

<script type="text/javascript">

$(function(){  //生成验证码         
    $("#kaptchaImage").click(function () {  
    $(this).hide().attr("src", "${path}/supplier/validateCode?uid=${uid}&"+Math.random()*100 ).fadeIn(); });      
});   
/* window.onbeforeunload = function(){  
    //关闭窗口时自动退出  
    if(event.clientX>360&&event.clientY<0||event.altKey){     
        alert(parent.document.location);  
    }  
};    */       
function changeCode() {  //刷新
    $("#kaptchaImage").hide().attr("src", "${path}/supplier/validateCode?uid=${uid}&"+Math.random()*100).fadeIn();  
    event.cancelBubble=true;  
};




</script>



