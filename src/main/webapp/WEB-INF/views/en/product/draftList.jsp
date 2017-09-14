<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Supplier-Drafts</title>
<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/css/zh/chus.css" />
</head>
<body>
<%@include file="/WEB-INF/views/en/include/header.jsp" %>
<%@include file="/WEB-INF/views/en/include/leftProduct.jsp" %>
<div class="alert_user3" style="display: none;">
	<div class="bg"></div>
	<div class="w">
		<div class="box1">
			<img src="${path}/images/close.jpg" class="w_close">
		</div>
		<div class="box3">
			<p id="showmsgplat"></p>
		</div>
		<div class="blank20"></div>
	</div>
</div>

	<div class="c2">
			<div class="c21">
			<div class="title">
				<p>Seller Center&nbsp;>&nbsp; </p>
				<p>Product&nbsp;>&nbsp; </p>
				<p class="c1">Drafts</p>
			</div>
			</div>
			<div class="blank10"></div>
			
			<div class="c22">
 			<div class="c3" id="cp3">
			<!-- <div class="xia">
				<form>
				
					<p class="p3">
						<button type="button" onclick="clickSubmit()">搜索</button>
						<a href="#" id="czhi" onclick="resetfm()">重置</a>
					</p>
				</form>	
			</div> -->
			
				
				
			<div class="blank5"></div>
					
			<div class="c3"  id="c3">
	
	            	
			</div>
			</div>
	  		</div>
	</div>
	</div>
	
  <div class="blank10"></div>
 <!-- 底部 start -->
	<%@include file="/WEB-INF/views/en/include/last.jsp"%>
	<!-- 底部 end -->
	
<script type="text/javascript" src="${path}/js/product/en/draft.js"></script>
<script type="text/javascript">

	$(document).ready(function() {

		$(".alert_user3").hide();
		$(".sr").click(function() {
			$(".alert_user3").show();
		});
		$(".w_close").click(function() {
			$(".alert_user3").hide();
		})
	});
	function showmsg(msg) {
		$("#showmsgplat").html(msg);
		$(".alert_user3").show();
	}
</script>
</body>
</html>
