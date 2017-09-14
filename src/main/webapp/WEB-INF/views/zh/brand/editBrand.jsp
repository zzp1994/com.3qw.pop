<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>商家后台管理系统-添加品牌</title>
<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
<link rel="stylesheet" href="${path}/css/zh/shang.css">
<link rel="stylesheet" type="text/css" href="${path}/js/ueditor/third-party/webuploader/webuploader.css">
<link rel="stylesheet" type="text/css" href="${path}/css/webuploaderframe.css">
<link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />
</head>
<body>
<input type="hidden" value="${path}" id="baseUrl">
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>
<div class="right f_l" >
 <input type="hidden" id="language" value="${language}">
	<!-- 边框start -->
	<form method="post" id="brandAction" enctype="multipart/form-data">
	<input type="hidden" name="brandId" value="${brand.brandId}">
		<div class="right f_l">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;>&nbsp;</p>
					<p>商品管理&nbsp;>&nbsp;</p>
					<p class="c1">品牌管理</p>
					<div class="clear"></div>
				</div>
			</div>
			<div class="blank10"></div>

			<!-- 边框start -->
			<div class="border">
				<div class="blank"></div>
				<div class="cont">
					<!-- 填写基本信息  --> 
					<div class="i_box">
						<h2>品牌信息</h2>
						
						<div class="blank15"></div>
						<div class="p_box">
							<div class="blank10"></div>
							<p class="p1">品牌属性：</p>
							<div class="p3" id="attrobjs" >
								<div class="bb">
									<p class="blank10"></p>
									<p class="p1">品牌名称：</p>
									<p class="t2">
									<input name="name" type="text" value="${brand.name}">
									<span id="brandMsg" class="dpl-tip-inline-warning">请选择品牌</span>
									</p>
									
									<p class="blank10"></p>
							
									<p class="p1"><i class="c_red">*</i>品牌类型：</p>
									<p class="s_1">
									<select name="type">
											<option value="2" <c:if test="${brand.type == 2}">selected</c:if>>自主品牌</option>
											<option value="1" <c:if test="${brand.type == 1}">selected</c:if>>独家代理</option>
											<option value="0" <c:if test="${brand.type == 0}">selected</c:if>>普通代理</option>
									</select>
									
									<p class="blank10"></p>
									
								</div>
							<div class="blank15"></div>
							<div id="uploader_00" class="wu-example">
								<p style="color: red">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;上传的图片格式只能是.jpg、.png、.jpeg，尺寸不得小于800*800像素，大小小于3M，图片数量不得少于1张
								</p>
							
							</div>
						 

						<!-- 填写基本信息  -->
						<div class="blank15"></div>
						
						<p class="blank10"></p>
					<div class="i_box">
							<h2>品牌介绍：</h2>
							<!--style给定宽度可以影响编辑器的最终宽度-->
							<div>
							<span class="dpl-tip-inline-warning" id="Details"></span>
							 <script id="editor"  type="text/plain" style="width:818px;">${brand.description}</script>
    						</div>
							
						</div>
					
					<!-- 填写基本信息  -->
						<div class="blank30"></div>
						
					</div>
					<div class="blank"></div>
					<!-- 填写基本信息  -->
						<div class="blank30"></div>
						
						
						
					</div>
						<!-- 填写基本信息  -->

						<div class="blank30"></div>
				</div>
				
				<!-- 边框 end -->
				<div class="blank10"></div>
				<div class="btn_box">
					<button class="fabu_btn" id="saveBrand" type="button">提交审核</button>
					<!-- <button class="fabu_btn" id="previewProd" type="button">商品预览</button> -->
					<p class="clear"></p>
				</div>
			</div>
			<div class="clear"></div>
			<p class="blank30"></p>
		</div>
		 </form>
 </div>
</div>
<div class="blank10"></div>
</div>
	 <!-- 底部 start -->
	 <%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	<!-- 底部 end -->


<script type="text/javascript" src="${path}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/queue.js"></script>
<script type="text/javascript" src=' ${path}/js/ueditor/third-party/webuploader/webuploader.js'></script>
<script type="text/javascript" src="${path}/js/product/zh/webuploaderhandler.js"></script>
<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	inituploader("品牌资质图片","00",${urls});
	
	//实例化编辑器
	 var ue = new UE.ui.Editor();
 	 ue.render("editor");
	
	
	
	var brandType = $("select[name='type']").val();
	if(0==brandType){
		$("#uploader_00").css("display","none");
	}
	
	$("select[name='type']").bind('change',function(){
		var that = $(this).val();
		if(0==that){
			$("#uploader_00").css("display","none");
		} else {
			$("#uploader_00").css("display","inline");
		}
	});
	
	
	$("#saveBrand").click(function(){
		var isSubmit = true;
		var imgs = $(".wu-example:visible");
		$.each(imgs,function(i,item){
			var num = $(item).find("input[name='imgUrl']").length;
			if(num < 1){
				isSubmit = false;
				$(item).prepend("<span class='dpl-tip-inline-warning' style='display:inline'>请上传一张以上的图片</span>");
			}else{
				$(item).find(".dpl-tip-inline-warning").remove();
			}
				
		});
		
		var otherBrand = $.trim($("input[name='name']").val());
			
			
			if(""==otherBrand){
				isSubmit = false;
				$("#brandMsg").text("请输入品牌名称").show();
			} else if(otherBrand.length>200){
				isSubmit = false;
				$("#brandMsg").text("品牌名称不能大于200字").show();
			} else {
				$("#brandMsg").hide();
			}
		
		
		
		/* var remark = $("#remark").val();
		if(remark.length>200){
			isSubmit = false;
			$("#remarkMsg").css("display","inline");
		} else {
			$("#remarkMsg").css("display","none");
		} */
		
		
		
		if(isSubmit){
			$(".fabu_btn").attr("disabled",true);
				$.ajax({
					type:'post',
					url:'../brand/editBrand',
					data:$("#brandAction").serialize(),
					error:function(){
						$(".fabu_btn").attr("disabled",false);
						alert('服务器忙，请稍后再试！');
					},
					success:function(data){
						if(data=="0"){
							$(".fabu_btn").attr("disabled",false);
							alert('保存失败，请稍后再试！');
						}
						if(data=="1"){
							$.dialog.confirm('保存成功，是否返回到品牌列表？', function(){
								window.location.href="../brand/getBrand";
								}, function(){
									window.location.href="../brand/toAddUI";
								});
							}
					}
				});
		}
	});
});
</script>
 </body>
</html>