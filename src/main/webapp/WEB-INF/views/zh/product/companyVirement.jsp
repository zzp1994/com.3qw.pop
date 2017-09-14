<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>商家后台管理系统-企业与企业个人转账</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/poporder/poporder.css"/>
    <script type="text/javascript" src="${path}/js/poporder/poporder.js"></script>
    <style>
		input{
			width: 80px;
		}
	</style>
</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>

	 <!--左边右边-->
	 <div class="c2">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;>&nbsp; </p>
					<p>订单管理&nbsp;>&nbsp; </p>
					<p class="c1">企业与企业个人转账</p>
				</div>
			</div>
			<div class="blank10"></div>
			<input type="hidden" value="${path}">
			<div class="c22">
				<div class="xia" style="width: 840px;height:300px;background:#f2f2f2;overflow:hidden;">
				  <form id="submitFrom" action="${path}/company/virementSaving" method="post">
				  	<input type="hidden" id="message" value="${message}"/>
				  	<input type="hidden" id="code" value="${code}"/>
				  	<input type="hidden" id="phone" name="phone" value="${phone}"/>
				  	<input type="hidden" id="trueName" name="trueName" value="${trueName}"/>
					<p class="p1">
						<span>对方账户:</span>
						<input type="text" id="phoneShow" value="${phone}" readonly="true">
					</p>
					<p class="p1">
						<span>真实姓名:</span>
						<input type="text" id="trueNameShow" value="${trueName}" readonly="true">
					</p>
					<p class="p1">
						<span>转出红旗券:</span>
						<input tabindex="1" type="text" id="virementPrice" name="virementPrice" value="">
						<label id="virementPrice_error" class=""></label>
					</p>
					<p class="p1">
						<span>转账密码:</span>
						<input tabindex="2" type="password"
							id="virementPassword" name="virementPassword" value="">
						<label id="virementPassword_error" class=""></label>
					</p>
					<p class="p1">
						<span>验证码:</span>
						<input type="text" tabindex="3" maxlength="4" name="authCode" id="authCode" class="text text-1">
						&nbsp;
						<label class="img">
							<img id="JD_Verification1" src="${path}/company/validateCode?phone=${phone}"
								alt="验证码" style="cursor:pointer;width:100px;height:26px;"/>
						</label>
						<label class="ftx23">&nbsp;看不清？<a class="flk13" href="javascript:changeCode();" tabindex="3">换一张</a></label>
						<label id="authCode_error" class=""></label>
					</p>
					<p class="p3">
						<button tabindex="5" id="virementSubmit" type="button">提交</button>
                       	<a id="forgetPwdLinkA" href="${path}/company/forgotVirementPassword" tabindex="6" id="czhi">忘记密码</a>
					</p>
				  </form>
				</div>
				<div class="clear:both;"></div>
		</div>
  </div>
	  <div class="blank10"></div>
	<!--下一页-->
</div>

<script type="text/javascript">
    $(function(){
    	var msg='${message}';
    	var codeValue = $("#code").val();

    	if(''!=msg){
    	/*
    		if(codeValue != "0" && codeValue != "1"){
    			$("#virementSubmit").css('display','none');
    			$("#forgetPwdLinkA").css('display','none');
				$("#forgetPwdLinkA").attr('href','');
    			$("#virementSubmit").attr("disabled", true);
    		}
    	*/
    		alert(msg);
    	}

        $("#JD_Verification1").click(function () {
        	$(this).attr("src", "${path}/company/validateCode?phone=${phone}&"+Math.random()*100 ).fadeIn();
        });

        $("#virementSubmit").click(function(){
        	 var submit = true;
        	 submit= checkForm();
        	 
             if(submit){
            	var authCodeValue = $("#authCode").val();
       	    	  $.ajax({
       		   		     type: "POST",
       		   		     dataType:"html",
       		   		     async: false,
       		   		     url : "${path}/company/getValidateCode?phone=${phone}&rd="+Math.random(),
       		   		     success : function(msg) {
       			   		     if(msg.toLowerCase()!=(authCodeValue).toLowerCase()){
       			   			    $("#authCode").removeClass().addClass("text text-1 highlight2");
       			 		        $("#authCode_error").removeClass().addClass("msg-error").html("请输入验证码");
       			   		  		changeCode();
       			   		    	$("#authCode").val("");
       			   		  		submit = false;
       			   		  		return submit;
       			   		     }else{
       			   		     	if(checkForm()){
       			        			$("#submitFrom").submit();
       			   		     	}
       			   		     }
       		   			},
       	  			});
             }

        });
    });

    function checkAuthCode(){
    	var authCode = $("#authCode").val().replace(/(^\s*)|(\s*$)/g, "");
    	if(authCode == ''){
    		$("#authCode").removeClass().addClass("text text-1 highlight2");
    		$("#authCode_error").removeClass().addClass("msg-error").html("请输入验证码");
    		return false;
    	} else if(authCode.length < 4){
    		$("#authCode").removeClass().addClass("text text-1 highlight2");
            $("#authCode_error").removeClass().addClass("msg-error").html("请输入4位验证码");
            return false;
    	} else{
			$("#authCode").removeClass().addClass("text text-1");
			$("#authCode_error").removeClass().html("");
			return true;
    	}
    }

    function checkForm(){
    	// 验证输入红旗券数
    	var virementPrice = $("#virementPrice").val();
    	virementPrice = virementPrice.replace(/(^\s*)|(\s*$)/g, "");
    	if(virementPrice == ''){
    		$("#virementPrice").removeClass().addClass("text text-1 highlight2");
    		$("#virementPrice_error").removeClass().addClass("msg-error").html("请输入红旗券!");
    		return false;
    	} else if (isNaN(virementPrice) || parseInt(virementPrice) <= 0){
    		$("#virementPrice").removeClass().addClass("text text-1 highlight2");
			$("#virementPrice_error").removeClass().addClass("msg-error").html("请输入正确红旗券数!");
			return false;
		} else {
			$("#virementPrice").val(virementPrice);
			$("#virementPrice").removeClass().addClass("text text-1");
            $("#virementPrice_error").removeClass().html("");
		}

		// 验证输入转账密码数
    	var virementPassword = $("#virementPassword").val();
    	virementPassword = virementPassword.replace(/(^\s*)|(\s*$)/g, "");
		if(virementPassword == ''){
			$("#virementPassword").removeClass().addClass("text text-1 highlight2");
			$("#virementPassword_error").removeClass().addClass("msg-error").html("请输入转账密码!");
			return false;
		}else{
            $("#virementPassword").removeClass().addClass("text text-1");
            $("#virementPassword_error").removeClass().html("");
		}

    	// 验证码
		if(!checkAuthCode()){
			return false;
		}
		return true;
	}

	function changeCode() {
		$("#JD_Verification1").hide().attr("src", "/company/validateCode?phone=${phone}&"+Math.random()*100).fadeIn();
	};
</script>

<div class="blank10"></div>
<!-- 底部 start -->
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
<!-- 底部 end -->
</body>
</html>