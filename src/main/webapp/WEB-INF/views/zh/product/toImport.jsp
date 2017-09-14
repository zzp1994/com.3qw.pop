<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">
	<head>
	  <meta charset="UTF-8">
	  <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" >
	  <title>商家后台管理系统-商品采购</title>
		<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
		<link rel="stylesheet" type="text/css" href="${path }/css/product.css"/>
		<link rel="stylesheet" type="text/css" href="${path }/css/product/reset.css"/>
		<link rel="stylesheet" type="text/css" href="${path }/css/product/reset2.css"/>
		<link rel="stylesheet" type="text/css" href="<%=path%>/css/Storage.css">
		<script type="text/javascript" src="${path }/js/purchase_list_fn.js"></script>
	  <script type="text/javascript">
	  
	  $(document).ready(function(){
		  
		  var v = '${message}';
		  if(v!=''){
			  
			  alert(eval(v)[0].msg);
		  }
	  });
	  
		function import_(){
			var v = $("#file").val();
			if(v==''){
				alert("请选择文件");
				return;
			}
			$("#form").submit();
		}
			
	 </script> 
	</head>
	<body>
	<%@include file="/WEB-INF/views/zh/include/header.jsp"%>
	<div class="blank10"></div>
	<!-- 导航 end -->

		<!-- 左边 start -->
			<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp"%>
	

		<!-- 左边 end -->
		<div class="right">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;&gt;&nbsp;</p>
					<p>商品采购&nbsp;&gt;&nbsp; </p>
					<p class="c1">采购列表</p>
				</div>
			</div>
			<form id="form"  action="${path}/product/settingPurchasePriceExcel" method="post"  enctype="multipart/form-data">
			<div class="xia" style="min-height:50px; margin-bottom:20px;">
				<p class="p1">
					<span>文件导入:</span>
					<input type="file" name="file" id="file" >

				</p>
				<p class="p2">
					<button type="button" onclick="javascript:import_();">导入</button>
				</p>
			</div>
			</form>


		<div class="c3" id="c3"></div>
		
	</div>
</div>

	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
</body>
</html>