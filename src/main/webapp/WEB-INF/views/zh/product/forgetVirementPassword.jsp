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
					<p class="c1">忘记企业转账密码</p>
				</div>
			</div>
			<div class="blank10"></div>
			<input type="hidden" value="${path}">
			<div class="c22">
				<div class="xia" style="width: 840px;height:300px;background:#f2f2f2;overflow:hidden;">
				  <form id="submitFrom" action="/company/savingVirementPassword" method="post">
				  	<input type="hidden" id="phone" name="phone" value="${phone}"/>
				  	<input type="hidden" id="code" value="${code}"/>
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
						<span>新转账密码:</span>
						<input tabindex="2" type="password"
							id="newPassword" name="newPassword" value="">
						<label id="newPassword_error" class=""></label>
					</p>
					<p class="p1">
						<span>确认转账密码:</span>
						<input tabindex="3" type="password" id="newPasswordCfm"
							name="newPasswordCfm" value="">
						<label id="newPasswordCfm_error" class=""></label>
					</p>
					<p class="p1">
						<span>验证码:</span>
						<input type="text" tabindex="4" name="authCode"
							id="authCode" class="text text-1">
						<label class="ftx23">
							<input tabindex="5" type="button" id="btnR" onclick="javascript:sendMessageCode();"
								value="发送验证码" class="send-a" style="border:0px;" />
						</label>
						<label id="authCode_error" class=""></label>
					</p>
					<p class="p3">
						<button tabindex="6" id="virementSubmit" type="button">提交</button>
						<a id="virementSetting" href="${path}/company/virementSetting" tabindex="6" id="czhi">返回</a>
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
	var wait = 60;

	function checkAuthCode(){
		var authCode = $("#authCode").val();
		if(!authCode){
			$("#authCode").removeClass().addClass("text text-1 highlight2");
			$("#authCode_error").removeClass().addClass("msg-error").html("请输入验证码");
			return false;
		}
		$("#authCode").removeClass().addClass("text text-1");
		$("#authCode_error").removeClass().html("");
		return true;
	}

	function checkForm(){
		// 验证 新密码
		var newPassword = $("#newPassword").val();
		newPassword = newPassword.replace(/(^\s*)|(\s*$)/g, "");
		var wordNumPat=new RegExp("^.*([\W_a-zA-z0-9-])+.*$");
		if(newPassword.length < 6 || newPassword.length > 20){
			$("#newPassword").removeClass().addClass("text text-1 highlight2");
			$("#newPassword_error").removeClass().addClass("msg-error").html("请输入新转账密码,长度6-20位!");
			return false;
		}else if(!(wordNumPat.test(newPassword))){
			$("#newPassword").removeClass().addClass("text text-1 highlight2");
			$("#newPassword_error").removeClass().addClass("msg-error").html("新转账密码必须是数字,字母混合!");
			return false;
		}else{
			$("#newPassword").removeClass().addClass("text text-1");
			$("#newPassword_error").removeClass().html("");
		}

		// 新密码 确认密码一致
		var newPasswordCfm = $("#newPasswordCfm").val();
		newPasswordCfm = newPasswordCfm.replace(/(^\s*)|(\s*$)/g, "");
		if(newPasswordCfm.length < 6 || newPasswordCfm.length > 20){
			$("#newPasswordCfm").removeClass().addClass("text text-1 highlight2");
			$("#newPasswordCfm_error").removeClass().addClass("msg-error").html("请输入确认转账密码,长度6-20位!");
			return false;
		}else if (newPasswordCfm != newPassword){
			$("#newPassword").removeClass().addClass("text text-1 highlight2");
			$("#newPassword_error").removeClass().addClass("msg-error").html("新转账密码不一致!");
			$("#newPasswordCfm").removeClass().addClass("text text-1 highlight2");
			$("#newPasswordCfm_error").removeClass().addClass("msg-error").html("新转账密码不一致!");
			return false;
		}else if(!(wordNumPat.test(newPasswordCfm))){
			$("#newPassword").removeClass().addClass("text text-1 highlight2");
			$("#newPassword_error").removeClass().addClass("msg-error").html("确认转账密码必须是数字,字母混合!");
			return false;
		} else {
			$("#newPassword").removeClass().addClass("text text-1");
			$("#newPassword_error").removeClass().html("");
			$("#newPasswordCfm").removeClass().addClass("text text-1");
			$("#newPasswordCfm_error").removeClass().html("");
		}

		// 验证码
		if(!checkAuthCode()){
			return false;
		}
		return true;
	}

    $(function(){
    	var msg='${message}';
    	if(''!=msg){
    		var code = $("#code").val();
			if(code == "0"){
				tipMessage(msg,function(){
					location.href='../company/virementSetting';
				});
			}else{
				alert(msg);
			}
    	}

        $("#virementSubmit").click(function(){
        	 var submit = true;
        	 submit= checkForm();
             if(submit){
            	var authCodeValue = $("#authCode").val();
       	    	  $.ajax({
       		   		     type: "POST",
       		   		     dataType:"html",
       		   		     async: false,
       		   		     url : "${path}/company/checkSecurityCode?phone=${phone}&inputCode="+authCodeValue+"&rd="+Math.random(),
       		   		     success : function(msg) {
       			   		     if(msg != "0"){
       			   			    $("#authCode").removeClass().addClass("text text-1 highlight2");
       			 		        $("#authCode_error").removeClass().addClass("msg-error").html("请输入验证码");
       			   		  		sendMessageCode();
       			   		    	$("#authCode").val("");
       			   		  		submit = false;
       			   		  		return submit;
       			   		     }else{
       			        		$("#submitFrom").submit();
       			   		     }
       		   			}
       	  			});
             }

        });
    });

	function sendMessageCode() {
		<!-- 发送验证码 -->
		$.ajax({
			 type: "get",
			 dataType:"html",
			 async: false,
			 url : "${path}/company/sendSecurityCode?phone=${phone}&rd="+Math.random(),
			 success : function(msg) {
				function time(o) {
					if (wait == 0) {
						o.removeAttribute("disabled");
						o.value = "发送验证码";
						wait = 60;
					} else {
						o.setAttribute("disabled", true);
						o.value = wait + "秒后,重新获取";
						wait--;
						setTimeout(function () {
							time(o)
						},1000)
					}
				}

				if(msg == "2"){
					$("#authCode").removeClass().addClass("text text-1 highlight2");
					$("#authCode_error").removeClass().addClass("msg-error").html("验证码已经发送,请耐心等待!");
					$("#authCode").val("");
					submit = false;
					document.getElementById("btnR").disabled = true;
                    time(document.getElementById("btnR"));
					return submit;
					
				 }else if(msg == "1"){
					$("#authCode").removeClass().addClass("text text-1 highlight2");
					$("#authCode_error").removeClass().addClass("msg-error").html("系统错误,请稍后重试!!");
					$("#authCode").val("");
					submit = false;
					return submit;
				 }else{
					document.getElementById("btnR").disabled = true;
					time(document.getElementById("btnR"));
				 }
			}
		});
	};
</script>

<div class="blank10"></div>
<!-- 底部 start -->
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
<!-- 底部 end -->
</body>
</html>