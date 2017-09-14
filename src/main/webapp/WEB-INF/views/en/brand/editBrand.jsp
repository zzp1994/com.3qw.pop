<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Supplier-EditBrand</title>
<%@include file="/WEB-INF/views/en/include/base.jsp"%>
<link rel="stylesheet" href="${path}/css/zh/shang.css">
<link rel="stylesheet" type="text/css" href="${path}/js/ueditor/third-party/webuploader/webuploader.css">
<link rel="stylesheet" type="text/css" href="${path}/css/webuploaderframe.css">
<link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />
</head>
<body>
<input type="hidden" value="${path}" id="baseUrl">
 <input type="hidden" id="language" value="${language}">
<%@include file="/WEB-INF/views/en/include/header.jsp" %>
<%@include file="/WEB-INF/views/en/include/leftProduct.jsp" %>
<div class="right f_l" >
	<!-- 边框start -->
	<form method="post" id="brandAction" enctype="multipart/form-data">
	<input type="hidden" name="brandId" value="${brand.brandId}">
		<div class="right f_l">
			<div class="c21">
				<div class="title">
					<p>Seller Center&nbsp;>&nbsp;</p>
					<p>Products&nbsp;>&nbsp;</p>
					<p class="c1">Brand</p>
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
						<h2>Brand Info</h2>
						
						<div class="blank15"></div>
						<div class="p_box">
							<div class="blank10"></div>
							<p class="p1">Brand Attribute：</p>
							<div class="p3" id="attrobjs" >
								<div class="bb">
									<p class="blank10"></p>
									<p class="p1">Brand Name：</p>
									<p class="t2">
										<input name="name" type="text" value="${brand.name}" id="otherBrand">
									<span id="brandMsg" class="dpl-tip-inline-warning">Please select a brand</span>
									</p>
									
									<p class="blank10"></p>
							
									<p class="p1"><i class="c_red">*</i> Brand Type：</p>
									<p class="s_1">
									<select name="brandType">
											<option value="2" <c:if test="${brand.type == 2}">selected</c:if>>Own Brand</option>
											<option value="1" <c:if test="${brand.type == 1}">selected</c:if>>Exclusive Agent</option>
											<option value="0" <c:if test="${brand.type == 0}">selected</c:if>> Agent</option>
									</select>
									
									<p class="blank10"></p>
								</div>

								<p class="blank10"></p>
								</div>
							<div class="blank15"></div>
							
							<div id="uploader_00" class="wu-example">
								<p style="color: red">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The image format should be “jpg”,”png” or “jpeg”, the size of each photo should be less than 3M bytes,Size is not less 
								than 800 * 800 pixels, the total number of photos should not be less than 1.<br>
								</p>
							</div>
							
						 

						<!-- 填写基本信息  -->
						<div class="blank15"></div>
						
					</div>
					<div class="blank"></div>
					<!-- 填写基本信息  -->
						<div class="blank30"></div>
						<div class="i_box">
							<h2>Description：</h2>
							<!--style给定宽度可以影响编辑器的最终宽度-->
							<div>
							<span class="dpl-tip-inline-warning" id="Details"></span>
							 <script id="editor"  type="text/plain" style="width:818px;">${brand.description}</script>
    						</div>
							
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
					<button class="fabu_btn" id="saveBrand" type="button">Submit</button>
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
	 <%@include file="/WEB-INF/views/en/include/last.jsp"%>
	<!-- 底部 end -->

<script type="text/javascript" src="${path}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/queue.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/third-party/webuploader/webuploader.js"></script>
<script type="text/javascript" src="${path}/js/product/en/webuploaderhandler.js"></script>
<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	inituploader("Brand Qualification Pictures","00",${urls});
	
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
		
		var otherBrand = $.trim($("input[name='name']").val());
		if(""==otherBrand){
			isSubmit = false;
			$("#other").find('.dpl-tip-inline-warning').text("Please enter the brand name").show();
		} else if(otherBrand.length>200){
			isSubmit = false;
			$("#other").find('.dpl-tip-inline-warning').text("Brand name is not greater than 200 words").show();
		} else {
			$("#other").find('.dpl-tip-inline-warning').hide();
		}
		
		var imgs = $(".wu-example:visible");
		
		$.each(imgs,function(i,item){
			var num = $(item).find("input[name='imgUrl']").length;
			if(num < 1){
				isSubmit = false;
				$(item).prepend("<span class='dpl-tip-inline-warning' style='display:inline'>Please upload one pictures at least</span>");
			}else{
				$(item).find(".dpl-tip-inline-warning").remove();
			}
				
		});
		
		if(isSubmit){
			$(".fabu_btn").attr("disabled",true);
			$.ajax({
				type:'post',
				url:'../brand/editBrand',
				data:$("#brandAction").serialize(),
				error:function(){
					$(".fabu_btn").attr("disabled",false);
					alert('Server is busy, please try again later!');
				},
				success:function(data){
					if(data=="0"){
						$(".fabu_btn").attr("disabled",false);
						alert('Save failed, please try again later!');
					}
					if(data=="1"){
						$.dialog.confirm('Save success, whether to return to the brand list?', function(){
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