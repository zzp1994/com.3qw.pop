<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	  <title>商家后台管理系统-基本信息管理</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
     
      <link rel="stylesheet" type="text/css" href="${path}/css/zh/jiben.css"/>
      <link rel="stylesheet" type="text/css" href="${path}/js/validation/validationEngine.jquery.css"/>
      <link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
	     input:focus{
			border:1px solid #09F;
			outline-style:none;
		}
		.input_warning{
			float:left;
		    font-family:Arial,"宋体",Lucida,Verdana,Helvetica,sans-serif;
			font-size:12px;
			padding-top:4px;
			padding-left:24px;
		}
		.divfile{
		   display: none;
		}
		#thief_warning{
			height:12px;
		}
	    .t2 {
		    border: 1px solid #c8c8c8;
		    float: left;
		    font-size: 12px;
		    height: 23px;
		    line-height: 23px;
		    margin-top: 2px;
		    margin-left: 20px;
		    padding: 0 5px;
		    width: 175px;
		}
		#filespan {margin:0;}
		
	</style>
	<script type="text/javascript">
	  var subUpdate =function(){
		if($('.fabu_btn').val()=="保存") {//已经 为 提交按钮	
			if(checkPwd()){
				
				
				/* $("#formID").submit();
				console.log("submit ok"); */
				var form = $("#formID").serialize();
				$.ajax({
					type:'post',
					url:'../user/forUpdatePwd',
					data:$("#formID").serialize(),
					error:function(){
						//$(".fabu_btn").attr("disabled",false);
						alert('服务器忙，请稍后再试！');
					},
					success:function(data){
						if(data=="0"){
							//$(".fabu_btn").attr("disabled",false);
							alert("请稍后再试！");
							$("#pwd1").val("");
							$("#pwd2").val("");
							$("#pwd3").val("");
							
						}
						if(data=="1"){
							alert("密码修改成功,请重新登录！");
							clearCookie();
						}	
					}
				});
				
				
			};
			//$("#submitButton").click();
		}else{
			$('.i1').removeAttr('disabled');
			$('.te').removeAttr('disabled');
			$('.div1').css('display','block');
			$('.fabu_btn').val("提交");
		}
	};
	
	</script>
	
    </head>
	<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp"%>
	 <div class="wrap">
		<%@include file="/WEB-INF/views/zh/include/leftUser.jsp"%>
		<form  id="formID"  action="${path}/user/forUpdatePwd" method="post" enctype="multipart/form-data">
		 <input type="hidden" name="token" value="${token}">
		<input id="language" type="hidden" name="language" value="${language}" />
		<input class="i1" type="hidden" name ="supplierId" value="${data.supplierId}"/>
		<div class="right f_l">
			<div class="title">

				<p class="c1">修改密码</p>
				<div class="clear"></div>
			</div>
			<div class="blank5"></div>
			<div class="cont">
				<ul class="ul_vertical">
					<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>原密码：</p>
						<input type="password" class="i1" id ="pwd1" name="pwd1" onblur="checkName1();" maxlength="20"/><!-- <span>密码不正确</span> -->
					</li>
					  <li class="blank20"></li>
					  
					  <li>
						<p class="p1"><b style=" color: #FF0000;">*</b>新密码：</p>
						<input type="password" class="i1" id ="pwd2" name="pwd2" maxlength="20"/>
					</li>
					    <li class="blank20"></li>
					    
					    <li>
						<p class="p1"><b style=" color: #FF0000;">*</b>再次输入新密码：</p>
						<input type="password" class="i1" id ="pwd3" name="pwd3" maxlength="20"/>
					</li>
					
					<p class="blank30"></p>
				    <input type="button"  class="fabu_btn" onclick="subUpdate()" value="修改" ></input>	 
				    <input id="submitButton" type="submit" style="display: none" ></input>	 
					<p class="blank30"></p>
			</div>
			
			 <div id="maskLayer" style="display: none;">
				<div id="alphadiv" style="filter: alpha(opacity=50);opacity: 0.5;"></div>
				<div id="drag">
					<h4 id="drag_h"></h4>
					<div id="drag_con">
						<div id="jobAreaAlpha"> </div>
					</div>
				</div>
			</div>
		</div>
		  </form>
		 
		<!-- 右边 end -->
	</div>
	 <iframe name="downloadFileIframe" style="display:none">
	     
	 </iframe> 
	<p class="blank30"></p>
		<!-- 底部 start -->
		 <script type="text/javascript" src="${path}/js/user/zh/jiben.js"></script>
		 <script  type="text/javascript" src="${path}/js/validation/jquery.validationEngine.min.js"></script> 
		 <script  type="text/javascript" src="${path}/js/validation/jquery.validationEngine-zh_CN.js"></script> 
		 <script  type="text/javascript" src="${path}/js/user/zh/drag.js"></script> 
	<%-- <script  type="text/javascript" src="${path}/js/user/industry_arr.js"></script>  --%>
		 <script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>
		 <script type="text/javascript">
		 function checkName1(){
	    	 if($.trim($("#pwd1").val())==""||$.trim($("#pwd1").val())==undefined){
	    		 return ;
	    	 }
	         var url='${path}/user/isPwd';
	    	 var data="pwd1="+$("#pwd1").val();
	    	 $.ajax({
		         type: "POST",
		         dataType:"json",
		         url: url,
		         data: data,
		         success: function (result) {
		        	 if(result>0){
		        		 //$("#company_error").show();
		        		 //alert("密码 正确");
		        	 }else{
		        		 alert("原密码输入 错误!");
		        		 $("#pwd1").val("");
		        		 //$("#company_error").hide();
		        	 }
		         }
		     });
	     
	     }
		 
		 function checkPwd(){
			 var pa=/^[0-9_a-zA-Z]{6,20}$/;
			 var pwd2 = $.trim($("#pwd2").val());
			 var pwd3 = $.trim($("#pwd3").val());
			 if(!pwd2.match(pa)){
				 alert("请输入长度6-20位,并包含数字或字母！");
				 return;
			 }else if(!pwd3.match(pa)){
				 alert("请输入长度6-20位,并包含数字或字母！");
				 return;
			 }
			 
			 if($.trim($("#pwd2").val())==""||$.trim($("#pwd2").val())==undefined){
					 alert("密码不能为空");
					 return;
			 }else if($.trim($("#pwd3").val())==""||$.trim($("#pwd3").val())==undefined){
				 alert("密码不能为空");
				 return;
			 }else if($.trim($("#pwd3").val())!=$.trim($("#pwd2").val())){
				 alert("密码不一致!");
				 return;
			 }else if($.trim($("#pwd1").val())==""||$.trim($("#pwd1").val())==undefined){
				 alert("原密码不能为空");
				 return;
			 }else{
				 return true;
			 }
			 
			 
		 }
		 
		 </script>
	 <script type="text/javascript">
	 	$(document).ready(function(){
	 		var pa=/^[0-9_a-zA-Z]{6,20}$/;
	 		$('.i1').removeAttr('disabled');
			$('.te').removeAttr('disabled');
			$('.div1').css('display','block');
			$('.fabu_btn').val("保存");
			$("#pwd2").bind("blur",function(){
				var pwd2 = $("#pwd2").val().trim();
				if(pwd2 == ""){
					alert("新密码不能为空!");
					return;
				}else if(!pwd2.match(pa)){
					alert("请输入长度6-20位,并包含数字或字母！");
					$("#pwd2").val("");
					 return;
				}
			});
			$("#pwd3").bind("blur",function(){
				var pwd2 = $("#pwd2").val().trim();
				var pwd3 = $("#pwd3").val().trim();
				if(pwd3 == ""){
					alert("确认密码不能为空!");
					return;
				}
				if(pwd2 != pwd3){
					alert("新密码不一致，请重新输入!");
					$("#pwd3").val("");
				}
			});
	 	});
	 </script>
		 
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	<!-- 底部 end -->
     </body>
</html>