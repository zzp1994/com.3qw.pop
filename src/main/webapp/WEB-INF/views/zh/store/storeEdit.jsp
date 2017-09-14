<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>商家后台管理系统-发布商品</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
	<link rel="stylesheet" href="${path}/css/zh/shang.css">
	<link href="${path}/css/uploadify.css" rel="stylesheet" type="text/css" />
	<link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="${path}/js/ueditor/third-party/webuploader/webuploader.css">
	<link rel="stylesheet" type="text/css" href="${path}/css/webuploaderframe.css">
	<%-- <link href="${path}/css/store/purchaseOrder.css" rel="stylesheet" type="text/css" />
	<link href="${path}/css/store/reset.css" rel="stylesheet" type="text/css" /> --%>
	<link href="${path}/css/store/purchaseOrder.css" rel="stylesheet" type="text/css" />
</head>
<body>
<input type="hidden" value="${path}" id="baseUrl">
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>

<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>

<div class="right f_l" >
	<!-- 边框start -->
	<input type="hidden" id="preview" value="${preview}">
	<input type="hidden" id="language" value="${language}">
	<input type="hidden" id="sessionId" value="${sid}" />
	<input type="hidden" id="productId" value="${stime}" />
	<input type="hidden" id="supplierType" value="${supplierType}" />
	<input type="hidden" id="supplierId" value="${store.supplierId}" />
	<input type="hidden" id="templateType" value="${store.templateType}" />
	<form method="post" id="storeAction" enctype="multipart/form-data">
		<input type="hidden" name="supplierProduct.prodLineId" value="${catePub.prodLineId}">
		<input type="hidden" name="supplierProduct.businessCatePubId" value="${catePub.businessNo}">
		<input type="hidden" id="cid" name="supplierProduct.catePubId" value="${catePub.catePubId}">
		<div class="right f_l">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;>&nbsp;</p>
					<p>店铺管理&nbsp;>&nbsp;</p>
					<p class="c1">页面编辑</p>
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
						<!-- <h2>店铺页面数据编辑</h2> -->
						<div class="blank15"></div>
						<div class="p_box">
							<!-- <p class="p1">
								<i class="c_red">*</i> 店铺名称：
							</p>
							<p class="p2">
								<input type="text"  required="required" name="pname"  value="" style="width: 300px;">
								<br>
								<span class="dpl-tip-inline-warning" id="productMsg" >请输入店铺名称</span>
							</p> -->
							<p class="p1">
								<i class="c_red">*</i> 店铺名称：
							</p>
							<p class="p2">
								<input type="text"  required="required" name="storeName"  value="${store.storeName} " style="width: 300px;">
								<br>
								<span class="dpl-tip-inline-warning" id="productMsg" >请输入店铺名称</span>
							</p>


							<div class="blank15"></div>

							<div id="uploader_00" class="wu-example">
								<span id="zizhiImg" class='dpl-tip-inline-warning'>请上传一张图片</span>
							</div>
							<c:if test="${null!= preview }">
								<div><a><img alt="" src="${ files}${preview.bannerUrl}" height="100" width="100"></a></div>
								<input type="hidden" id="bannerUrls" name="bannerUrls" value="${preview.bannerUrl}">
							</c:if>
							<!-- <div id="uploader_mm" class="wu-example">
                                <span id="zizhiImg" class='dpl-tip-inline-warning'>请至少上传一张资质图片</span>
                            </div> -->

							<!-- 填写基本信息  -->
							<!-- 填写基本信息  -->
							<div class="blank15"></div>
							<div class="blank53"></div>
						<!-- floor1 楼层 -->
						<div class="pu_w">
							
					  		<div class="btn"><button type="button" id ="addProduct1">添加</button>
					  		<button type="button" id ="deleteTr">删除</button>
					  		<input type="hidden" id="chkTrue" name="chkTrue">
					  		</div>
					  		<div class="pu_h"><h3>商品专栏1</h3>
					  		</div>
					  		<div class="pu_b scroll-x">
					  		<c:choose>
					  			<c:when test="${null!= preview }">
					  				<div style="margin-bottom: 8px;margin-left: 5px;">专栏名称：<input name="floorName1" maxlength="150" value="${preview.floorName1 }"></div>
					  			</c:when>
					  			<c:otherwise>
					  				<div style="margin-bottom: 8px;margin-left: 5px;">专栏名称：<input name="floorName1" maxlength="150"></div>
					  			</c:otherwise>
					  		</c:choose>
					  			<table class="ov" id="productTab">
					  				<tr class="order_hd">
					  					<th width="60px" nowrap="nowrap">序号</th>
						  				<th width="60px" nowrap="nowrap">选择</th>
						  				<th>商品名称</th>
						  				<th>商品PID</th>
						  				<!-- <th>商品图片</th> -->
						  				<th>市场价格</th>
						  				<th>零售价格</th>
					  				</tr>
					  				<c:choose>
					  					<c:when test="${null== preview }">
					  						<tr class="append">
						  					<td nowrap="nowrap">1</td>
							  				<td nowrap="nowrap"><input type="checkbox" class="checkbox sm"></td>
							  				<td><input type="text" id="productName"  style="width:150px;;border: 1px solid #ccc;" >
							  				<input type="hidden" id="productName" name="productName" >
							  				<input type="hidden" id="businessProdid" name="businessProdid">
							  				</td>
							  				<td><input  type="text" id="productid" name="productid" readonly="readonly" style="width:120px;"></td>
							  				<input type="hidden"  type="text" id="imageurl" name="imageurl" readonly="readonly" style="width:120px;">
							  				<td><input  type="text" id="domesticPrice" name="domesticPrice" readonly="readonly" style="width:60px;"></td>
							  				<td><input  type="text" id="unitPrice" name="unitPrice" readonly="readonly" style="width:60px;"></td>
						  				</tr>
					  					</c:when>
					  					<c:otherwise>
						  					<c:forEach items="${preview.floor1 }" var="floor1" varStatus="i">
								  				<tr class="append">
								  					<td nowrap="nowrap">${i.index+1 }</td>
									  				<td nowrap="nowrap"><input type="checkbox" class="checkbox sm"></td>
									  				<td><input type="text" id="productName"  style="width:150px;border: 1px solid #ccc;" value="${floor1.productName }">
									  				<input type="hidden" id="productName" name="productName" value="${floor1.productName }">
									  				<input type="hidden" id="businessProdid" name="businessProdid">
									  				</td>
									  				<td><input value="${floor1.pid }" type="text" id="productid" name="productid" readonly="readonly" style="width:120px;"></td>
									  				<input type="hidden" value="${floor1.imgUrl }" type="text" id="imageurl" name="imageurl" readonly="readonly" style="width:120px;">
									  				<%-- <td><a target="_blank" href="${files}${floor1.imgUrl }">商品图片</a></td> --%>
									  				<td><input value="${floor1.domesticPrice }" type="text" id="domesticPrice" name="domesticPrice" readonly="readonly" style="width:60px;"></td>
									  				<td><input value="${floor1.unitPrice }" type="text" id="unitPrice" name="unitPrice" readonly="readonly" style="width:60px;"></td>
								  				</tr>
						  					</c:forEach>
					  					</c:otherwise>
					  				</c:choose>
					  				
					  			</table>
					  		</div>
					  		
						</div>
						
						<!-- 触发 table 1 -->
						<div class="alert_c" id="skuDiv" style="display:none;">
						  <div class="bg"></div>
							<div class="wrap">
								<div class="pic"></div>
								<div class="box1">
									<div id="boxtitle">
										<h2>选择商品</h2>
									</div>
									<div id="suppliernametext" style="display: block;">
										<!-- <input type="text" id="productName">
										<button type="button" onclick="searchSku();">查询</button> -->
										<button type="button" onclick="hideShow();">退出</button>
									</div>
								</div>
								<div class="box2" id="skubox">
								
								</div>
								<div class="box3">
									<button type="button" class="bt1" id="supplierclick" onclick="loadSku()">确定</button>
								</div>
							</div>
						</div>
						
						<div class="blank15"></div>
						<div class="blank53"></div>
						<!-- floor2 楼层 -->
						<div class="pu_w">
							
					  		<div class="btn"><button type="button" id ="addProduct2">添加</button>
					  		<button type="button" id ="deleteTr1">删除</button>
					  		<input type="hidden" id="chkTrue" name="chkTrue">
					  		</div>
					  		<div class="pu_h"><h3>商品专栏2</h3></div>
					  		<div class="pu_b scroll-x">
					  		<c:choose>
					  			<c:when test="${null!= preview }">
							  		<div style="margin-bottom: 8px;margin-left: 5px;">专栏名称：<input name="floorName2" maxlength="150" value="${preview.floorName2 }"></div>
					  			</c:when>
					  			<c:otherwise>
					  				<div style="margin-bottom: 8px;margin-left: 5px;">专栏名称：<input name="floorName2" maxlength="150" ></div>
					  			</c:otherwise>
					  		</c:choose>
					  			<table class="ov" id="productTab1">
					  				<tr class="order_hd">
					  					<th width="60px" nowrap="nowrap">序号</th>
						  				<th width="60px" nowrap="nowrap">选择</th>
						  				<th>商品名称</th>
						  				<th>商品PID</th>
						  				<!-- <th>商品图片</th> -->
						  				<th>市场价格</th>
						  				<th>零售价格</th>
					  				</tr>
					  				<c:choose>
					  					<c:when test="${null== preview }">
					  						<tr class="append">
								  					<td nowrap="nowrap">1</td>
									  				<td nowrap="nowrap"><input type="checkbox" class="checkbox sm"></td>
									  				<td><input type="text" id="productName1"  style="width:150px;border: 1px solid #ccc;" >
									  				<input type="hidden" id="productName1" name="productName1" >
									  				<input type="hidden" id="businessProdid1" name="businessProdid1">
									  				</td>
									  				<td><input  type="text" id="productid1" name="productid1" readonly="readonly" style="width:120px;"></td>
									  				<input type="hidden"  type="text" id="imageurl1" name="imageurl1" readonly="readonly" style="width:120px;">
									  				<td><input  type="text" id="domesticPrice1" name="domesticPrice1" readonly="readonly" style="width:60px;"></td>
									  				<td><input  type="text" id="unitPrice1" name="unitPrice1" readonly="readonly" style="width:60px;"></td>
								  				</tr>
					  					</c:when>
					  					<c:otherwise>
							  						<c:forEach items="${preview.floor2 }" var="floor2" varStatus="i">
								  				<tr class="append">
								  					<td nowrap="nowrap">${i.index+1 }</td>
									  				<td nowrap="nowrap"><input type="checkbox" class="checkbox sm"></td>
									  				<td><input type="text" id="productName1"  style="width:150px;border: 1px solid #ccc;" value="${floor2.productName }">
									  				<input type="hidden" id="productName1" name="productName1" value="${floor2.productName }">
									  				<input type="hidden" id="businessProdid1" name="businessProdid1">
									  				</td>
									  				<td><input value="${floor2.pid }" type="text" id="productid1" name="productid1" readonly="readonly" style="width:120px;"></td>
									  				<input type="hidden" value="${floor2.imgUrl }" type="text" id="imageurl1" name="imageurl1" readonly="readonly" style="width:120px;">
									  				<td><input value="${floor2.domesticPrice }" type="text" id="domesticPrice1" name="domesticPrice1" readonly="readonly" style="width:60px;"></td>
									  				<td><input value="${floor2.unitPrice }" type="text" id="unitPrice1" name="unitPrice1" readonly="readonly" style="width:60px;"></td>
								  				</tr>
							  				</c:forEach>
					  					</c:otherwise>
					  				</c:choose>
					  				
					  			</table>
					  		</div>
					  		
						</div>
						
						<!-- 触发 table 2 -->
						<div class="alert_c" id="skuDiv1" style="display:none;">
						  <div class="bg"></div>
							<div class="wrap">
								<div class="pic"></div>
								<div class="box1">
									<div id="boxtitle">
										<h2>选择商品</h2>
									</div>
									<div id="suppliernametext" style="display: block;">
										<!-- <input type="text" id="productName">
										<button type="button" onclick="searchSku();">查询</button> -->
										<button type="button" onclick="hideShow();">退出</button>
									</div>
								</div>
								<div class="box2" id="skubox1">
								
								</div>
								<div class="box3">
									<button type="button" class="bt1" id="supplierclick" onclick="loadSku1()">确定</button>
								</div>
							</div>
						</div>
						
						<div class="blank15"></div>
						<div class="blank53"></div>
						<!-- floor3楼层 -->
						<div class="pu_w">
							
					  		<div class="btn"><button type="button" id ="addProduct3">添加</button>
					  		<button type="button" id ="deleteTr2">删除</button>
					  		<input type="hidden" id="chkTrue" name="chkTrue">
					  		</div>
					  		<div class="pu_h"><h3>商品专栏3</h3></div>
					  		<div class="pu_b scroll-x">
					  		<c:choose>
					  			<c:when test="${null!= preview }">
							  		<div style="margin-bottom: 8px;margin-left: 5px;">专栏名称：<input name="floorName3" maxlength="150" value="${preview.floorName3 }"></div>
					  			</c:when>
					  			<c:otherwise>
					  					<div style="margin-bottom: 8px;margin-left: 5px;">专栏名称：<input name="floorName3" maxlength="150" ></div>
					  				
					  			</c:otherwise>
					  		</c:choose>
					  			<table class="ov" id="productTab2">
					  				<tr class="order_hd">
					  					<th width="60px" nowrap="nowrap">序号</th>
						  				<th width="60px" nowrap="nowrap">选择</th>
						  				<th>商品名称</th>
						  				<th>商品PID</th>
						  				<!-- <th>商品图片</th> -->
						  				<th>市场价格</th>
						  				<th>零售价格</th>
					  				</tr>
					  				<c:choose>
					  					<c:when test="${null== preview }">
					  						<tr class="append">
								  					<td nowrap="nowrap">1</td>
									  				<td nowrap="nowrap"><input type="checkbox" class="checkbox sm"></td>
									  				<td><input type="text" id="productName2"  style="width:150px;    border: 1px solid #ccc;" >
									  				<input type="hidden" id="productName2" name="productName2" >
									  				<input type="hidden" id="businessProdid2" name="businessProdid2">
									  				</td>
									  				<td><input  type="text" id="productid2" name="productid2" readonly="readonly" style="width:120px;"></td>
									  				<input type="hidden"  type="text" id="imageurl2" name="imageurl2" readonly="readonly" style="width:120px;">
									  				<td><input  type="text" id="domesticPrice2" name="domesticPrice2" readonly="readonly" style="width:60px;"></td>
									  				<td><input  type="text" id="unitPrice2" name="unitPrice2" readonly="readonly" style="width:60px;"></td>
								  				</tr>
					  					</c:when>
					  					<c:otherwise>
							  						<c:forEach items="${preview.floor3 }" var="floor3" varStatus="i">
								  				<tr class="append">
								  					<td nowrap="nowrap">${i.index+1 }</td>
									  				<td nowrap="nowrap"><input type="checkbox" class="checkbox sm"></td>
									  				<td><input type="text" id="productName2"  style="width:150px;border: 1px solid #ccc;" value="${floor3.productName }">
									  				<input type="hidden" id="productName2" name="productName2" value="${floor3.productName }">
									  				<input type="hidden" id="businessProdid2" name="businessProdid2">
									  				</td>
									  				<td><input value="${floor3.pid }" type="text" id="productid2" name="productid2" readonly="readonly" style="width:120px;"></td>
									  				<input type="hidden" value="${floor3.imgUrl }" type="text" id="imageurl2" name="imageurl2" readonly="readonly" style="width:120px;">
									  				<td><input value="${floor3.domesticPrice }" type="text" id="domesticPrice2" name="domesticPrice2" readonly="readonly" style="width:60px;"></td>
									  				<td><input value="${floor3.unitPrice }" type="text" id="unitPrice2" name="unitPrice2" readonly="readonly" style="width:60px;"></td>
								  				</tr>
							  				</c:forEach>
					  					</c:otherwise>
					  				</c:choose>
					  				
					  			</table>
					  		</div>
					  		
						</div>
						
						<!-- 触发 table 3 -->
						<div class="alert_c" id="skuDiv2" style="display:none;">
						  <div class="bg"></div>
							<div class="wrap">
								<div class="pic"></div>
								<div class="box1">
									<div id="boxtitle">
										<h2>选择商品</h2>
									</div>
									<div id="suppliernametext" style="display: block;">
										<!-- <input type="text" id="productName">
										<button type="button" onclick="searchSku();">查询</button> -->
										<button type="button" onclick="hideShow();">退出</button>
									</div>
								</div>
								<div class="box2" id="skubox2">
								
								</div>
								<div class="box3">
									<button type="button" class="bt1" id="supplierclick" onclick="loadSku2()">确定</button>
								</div>
							</div>
						</div>
						<!-- 内容 end -->
						<div class="i_box" hidden="hidden">
							<h2>图文详情
								<i class="J_PopTip poptip-help" rel="tooltip"
								   tip="一、上传图片，要求如下（包含但不仅限于以下内容）：<br>
								1.像素：图片大小800*800像素，分辨率不低于72像素/英寸,图片质量要清晰，不要虚化<br>
								2.纵横比要求1:1<br>
								3.大小：商品的主图上传大小≥30K且≤3M<br>
								4.格式：商品的主图上传格式需为jpg, gif, png, bmp<br>
								5.背景：不限<br>
								6.数量：至少6张。图片应多多展示商品细节和突出商品卖点，如：商品实物细节图（例：巧克力、面包、糕点剖面展示，则突出细腻、松软等特点）、生产线图片、原料图片等。<br>
								主要作用是展示商品的颜色、食用方法、主要特点、增加购买欲、丰富美化页面等<br>
								二、上传文字描述，要求如下（包含但不仅限于以下内容）：<br>
								1.商品卖点，如商品生产工艺，加工流程、商品生产环节的详细介绍，或凸出商品与同行产品的差异等介绍说明<br>
								2.商品介绍<br>
								3.商品使用、食用方法<br>
								4.品牌介绍、商品口号（广告词等）<br>
								5.温馨提示<br>">
								</i>
							</h2>
							<!--style给定宽度可以影响编辑器的最终宽度-->
							<div>
								<span class="dpl-tip-inline-warning" id="Details"></span>
								<script id="editor"  type="text/plain" style="width:818px;">
        						<p>请编辑商品详细信息</p>
    						</script>
							</div>

						</div>
						<!-- 填写基本信息  -->

						<div class="blank30"></div>
					</div>

					<!-- 边框 end -->
					<div class="blank10"></div>
					<div class="btn_box">
						<button class="fabu_btn" id="saveStore" type="button">提交预览</button>
						<button class="fabu_btn" id="saveStores" type="button">提交发布</button>
						<%--<button class="fabu_btn" id="draftProd" type="button">保存草稿</button>--%>
						<!-- <button class="fabu_btn" id="previewProd" type="button">商品预览</button> -->
						<p class="clear"></p>
					</div>
				</div>
				<div class="clear"></div>
				<p class="blank30"></p>
			</div>
	
</div>
</div>
</form>
</div>

</div>

<div id="previewprod" style="left:0; top:0; z-index:999;height:0px;width:0px">
	<div id="previewcontent" style="width:100%;height:100%;overflow-y:scroll"></div>
</div>

<!-- 底部 start -->
<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
<!-- 底部 end -->

<script type="text/javascript" src="${path}/js/product/zh/editProduct.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/queue.js"></script>
<script type="text/javascript" src="${path}/js/product/swfUploadEventHandler.js"></script>
<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>


<!--引入JS-->
<script type="text/javascript" src=' ${path}/js/ueditor/third-party/webuploader/webuploader.js'></script>
<script type="text/javascript" src="${path}/js/product/zh/webuploaderhandler_store.js"></script>
<script type="text/javascript" src="${path}/js/store/purchase_check.js"></script>
<script type="text/javascript" src=' ${path}/js/store/store.js'></script>
<script type="text/javascript">
	//实例化编辑器
	var ue = new UE.ui.Editor();
	ue.render("editor");

	$(document).ready(function(){
		var cid = $("#cid").val();
		$.ajax({
			type : "post",
			url : "../product/getBrands",
			data:"cid="+cid,
			dataType:"json",
			success : function(msg) {
				$.each(msg,function(i,n){
					$("#firstcategory").append("<option value='"+n.id+"'>"+n.nameCn+"</option>");
				});
			}
		});

		inituploader("店铺Banner图片:图片尺寸为1920*450像素","00",[]);
		/* inituploader1("上传文件","mm",[]); */
	});

	function changeOrderType(type) {
		if (type == 2) {
			$("#collection").show();
		}else{
			$("#collection").hide();
		}
	}
	
	//页面编辑预览功能
	$("#saveStore").click(function(){
		var form = $("#storeAction").serialize();
		var supplierId = $("#supplierId").val();
		var templateType = $("#templateType").val();
		$.ajax({
			type:'post',
			url:'../store/toPreview',
			data:$("#storeAction").serialize(),
			error:function(){
				//$(".fabu_btn").attr("disabled",false);
				alert('服务器忙，请稍后再试！');
			},
			success:function(data){
				if(data=="0"){
					//$(".fabu_btn").attr("disabled",false);
					alert('内容不全，请稍后再试！');
				}
				if(data=="1"){
					window.open('http://www.3qianwan.com/store/'+supplierId  +'/'+ templateType +'/index.html?online=2');
					//location.href='http://www.3qianwan.com/store/'+supplierId  +'/'+ templateType +'/index.html';
					
				}	
			}
		});
		
	});
	
	$("#saveStores").click(function(){
		var form = $("#storeAction").serialize();
		
		$.ajax({
			type:'post',
			url:'../store/toOnline',
			data:$("#storeAction").serialize(),
			error:function(){
				//$(".fabu_btn").attr("disabled",false);
				alert('服务器忙，请稍后再试！');
			},
			success:function(data){
				if(data=="0"){
					//$(".fabu_btn").attr("disabled",false);
					alert('内容不全，请稍后再试！');
				}
				if(data=="1"){
					//location.reload();
					//alert("发布成功！");
					tipMessage("发布成功！",function(){
						location.reload();
					});
				}	
			}
		});
		
	});
	
</script>
</body>
</html>