<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>商家后台管理系统-发布商品</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp" %>
	<link rel="stylesheet" type="text/css" href="${path}/css/zh/fenlei.css">
	<link rel="stylesheet" type="text/css" href="${path}/css/resetmobile.css">
	<link rel="stylesheet" type="text/css" href="${path}/css/rshop.css">
	<script type="text/javascript" src="${path}/js/product/zh/category.js"></script>
	</script>
</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>
		<div class="c2">
		
			<div class="c21">
				<div class="title">
					<p>店铺装修&nbsp;>&nbsp; </p>
					<p class="c1">模板管理</p>
				</div>
			</div>
			<div class="blank10"></div>
			
			<!-- 模板管理页面开始 -->
		<div class="center">


			<div class="right">

				<div class="shop">
					<ul>
						
						<li>
							<div class="pre_t">
								<a href="#"><img src="${path}/images/te8.jpg"></a>
							</div>
							<div class="pre_b">
								<%-- <button type="button" class="btn1" onclick="javascript:window.open('${path}/store/modle/preview','_blank');">预览效果</button> --%>
								<button type="button" class="btn2 b1" onclick="javascript:location.href='${path}/store/modle/setModle?modleNum=1';">立即使用</button>
							</div>
						</li>
						<li>
							<div class="pre_t">
								<a href="#"><img src="${path}/images/te9.jpg"></a>
							</div>
							<div class="pre_b">
								<%-- <button type="button" class="btn1" onclick="javascript:window.open('${path}/store/modle/preview?modleNum=2','_blank');">预览效果</button> --%>
								<button type="button" class="btn2 b2" onclick="javascript:location.href='${path}/store/modle/setModle?modleNum=2';">立即使用</button>
							</div>
						</li>
						<li>
							<div class="pre_t">
								<a href="#"><img src="${path}/images/te0.jpg"></a>
							</div>
							<div class="pre_b">
								<%-- <button type="button" class="btn1" onclick="javascript:window.open('${path}/store/modle/preview?modleNum=3','_blank');" >预览效果</button> --%>
								<button type="button" class="btn2 b3" onclick="javascript:location.href='${path}/store/modle/setModle?modleNum=3';">立即使用</button>
							</div>
						</li>

					</ul>
				</div>


			</div>

		</div>
		<!-- 模板管理页面结束 -->

		<div class="clear"></div>
		<div class="dw_temp" style="display:none;">
			<ul>
				<li value=""><a href="javascript:;"></a></li>
			</ul>
			<div class="blank10"></div>

		</div>
	</div>
</div>
<!-- 底部 start -->
<%@include file="/WEB-INF/views/zh/include/last.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	var num = ${templateId};
	
	if(num == 1){
		$('.b1').addClass('btn2-no');
		$('.b1').html('已选模板');
		
	}
	if(num == 2){
		$('.b2').addClass('btn2-no');
		$('.b2').html('已选模板');
		
	}
	if(num == 3){
		$('.b3').addClass('btn2-no');
		$('.b3').html('已选模板');
		
	}
	
	
	
});
</script>

</body>
</html>