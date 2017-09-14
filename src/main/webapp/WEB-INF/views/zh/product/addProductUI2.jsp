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
<link rel="stylesheet" type="text/css" href="${path}/js/jquery-AutoComplete/jquery.autocomplete.css">
</head>
<body>
<input type="hidden" value="${path}" id="baseUrl">
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>
<div class="right f_l" >
	<!-- 边框start -->
	 <input type="hidden" id="language" value="${language}">
	 <input type="hidden" id="sessionId" value="${sid}" />
	 <input type="hidden" id="productId" value="${stime}" />
	 <input type="hidden" id="supplierType" value="${supplierType}" />
	<form method="post" id="productAction" enctype="multipart/form-data">
		<input type="hidden" name="supplierProduct.prodLineId" value="${catePub.prodLineId}">
		<input type="hidden" name="supplierProduct.businessCatePubId" value="${catePub.businessNo}">
		<input type="hidden" id="cid" name="supplierProduct.catePubId" value="${catePub.catePubId}">
		<div class="right f_l">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;>&nbsp;</p>
					<p>商品管理&nbsp;>&nbsp;</p>
					<p class="c1">发布商品</p>
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
						<h2>产品基本信息</h2>
						<div class="app">
						<span>你当前选择的类目是：</span>
						<c:forEach items="${cateNames}"  var="cateName" varStatus="var">
							<span>${fn:escapeXml(cateName.pubNameCn)}</span>
						<c:if test="${!var.last}">
							<span>&gt;</span>
						</c:if>
						</c:forEach>
						</div>
						<div class="blank15"></div>
						<div class="p_box">
							<p class="p1">
								<i class="c_red">*</i> 商品标题：
							</p>
							<p class="p2">
							
								<input type="text"  required="required" title="商品名称+品牌中文/英文名称+产品类别（功能性修饰语+商品卖点修饰语）+三千万商城特色" 
								id="productinfo" name="pname" placeholder="商品名称+品牌中文/英文名称+产品类别（功能性修饰语+商品卖点修饰语）+三千万商城特色" value="">
								<i class="J_PopTip poptip-help" rel="tooltip" tip="“+”代表半角一个空格商品名称不能包含“特供”“专供”“促销”“特价”“包邮”“正品”“买赠”等与商品本身无关的字样品牌（需英文品牌在前,中文品牌在后,无英文品牌只填写中文品牌即可,英文品牌的大小写以厂家注册为准）请使用半角符号简体单位应当为半角英文g,  ml,  L,不应该是中文产品数量为1的产品不用写:1瓶1盒1罐等多包装商品在单个商品规格后乘以数字即可例:125g*2。如：意大利 ARMANI COLLEAIONI阿玛尼 女士时尚经典连衣裙 34485988ke 蓝色 XL">					
								</i><br>
								<span class="dpl-tip-inline-warning" id="productMsg" >商品标题不能是空的</span>
							</p>
								
							<div class="blank10"></div>
							<p class="p1">产品属性：</p>
							<div class="p3" id="attrobjs" >
								<div class="bb">
									<p class="blank10"></p>
									<p class="p1">
									<i class="c_red">*</i> 品牌：</p>
									<p class="s_1">
<!-- 									<select id="firstcategory" name="brandId" >
										<option value="">请选择</option>
									</select>  -->
									<input id="keyword" style="float: left;margin-right:5px;height:25px;"/>  
                                    <input id="firstcategory" name="brandId" type="hidden" />  
						 			<!-- <select id="secondcategory" name="subBrandId"></select>  -->
									</p>
									<span class="dpl-tip-inline-warning"></span>
									<p class="blank10"></p>
									<div id="attrdiv">
										<input type="button" id="addTable" value="添加普通属性"/>
									<span id="tblError" class="dpl-tip-inline-warning"></span>
									<table id="tbl" style="margin-top:10px;border:1px;border-style: solid; border-color: #c3c3c3;">
									<colgroup>
									<col style="width: 35px;border:1px;border-style: solid; border-color: #c3c3c3;">
									<col style="width: 65px;border:1px;border-style: solid; border-color: #c3c3c3;">
									<col style="width: 80px;border:1px;border-style: solid; border-color: #c3c3c3;">
									<col style="width: 450px;border:1px;border-style: solid; border-color: #c3c3c3;">
									<col style="width: 50px;border:1px;border-style: solid; border-color: #c3c3c3;">
									</colgroup>
										<tr style="height: 30px;">
											<th>排序</th>
											<th>形式</th>
											<th>属性</th>
											<th>属性值</th>
											<th>操作</th>
										</tr>
									</table>
									</div>
									
									<p class="blank10"></p>
							
									<!-- <p class="p1"><i class="c_red">*</i> 原产国：</p>
									<p class="s_1">
									<select name="supplierProduct.originplace">
										<c:forEach items="${countries}" var="country">
											<option value="${country.countryid}">${fn:escapeXml(country.name)}</option>
										</c:forEach>
									</select> -->
									<input type="hidden" name="supplierProduct.originplace" value="141957609135423570">
									<input type="hidden"  value="3" id="hqj" name="hqjcode"/>
									<input type="hidden"  value="1" id="fhed" name="fhedcode"/>
									<input type="hidden"  value="${costPriceMultiple}" id="scj" name="scjcode"/>
									<p class="blank10"></p>
									<p class="p1" style="display: none"><i class="c_red">*</i> 制造商：</p>
									<p class="t2" style="display: none">
									<input required="required" name="supplierProduct.manufacturers" type="text" value="制造商">
									<span class="dpl-tip-inline-warning">
									制造商只能1-200字
									</span>
									</p>

<%-- 新加 b2c字段开始部分 start--%>

									<p class="blank10" style="display: none"></p>
									<p class="p1" style="display: none"><i class="c_red">*</i> 发货地：</p>
									<p class="t2" style="display: none">
										<input required="b2cOriginCountry" name="b2cProductDetail.OriginCountry" type="text" value="发货地">
									<span class="dpl-tip-inline-warning">
									发货地只能1-200字
									</span>
									</p>

									<p class="blank10"></p>
									<p class="p1" style="display: none"><i class="c_red">*</i> 国外币种：</p>
									<p class="s_1" style="display: none">
										<select name="b2cProductDetail.b2cMoneyUnitId">
											<option value="1" selected="selected">人民币</option>
											<option value="2">欧元</option>
											<option value="4">英镑</option>
											<option value="5">日元</option>
											<option value="6">美元</option>
											<option value="15">新台币</option>
											<option value="17">阿联酋迪拉姆</option>
											<option value="18">澳元</option>
											<option value="19">澳门元</option>
											<option value="20">埃及磅</option>
											<option value="21">俄罗斯卢布</option>
											<option value="22">丹麦克朗</option>
											<option value="23">新西兰元</option>
											<option value="24">新加坡元</option>
											<option value="25">文莱元</option>
											<option value="26">匈牙利福林</option>
											<option value="27">越南盾</option>
											<option value="28">印度卢比</option>
											<option value="29">印尼卢比</option>
											<option value="30">智利比索</option>
											<option value="31">瑞士法郎</option>
											<option value="32">瑞典克朗</option>
											<option value="33">斯里兰卡卢比</option>
											<option value="34">泰铢</option>
											<option value="35">肯尼亚先令</option>
											<option value="36">老挝基普</option>
											<option value="37">缅甸元</option>
											<option value="38">马来西亚林吉特</option>
											<option value="39">墨西哥元</option>
											<option value="40">挪威克朗</option>
											<option value="41">南非兰特</option>
											<option value="42">加元</option>
											<option value="43">韩元</option>
											<option value="44">港元</option>
											<option value="45">菲律宾比索</option>
											<option value="46">柬埔寨瑞尔</option>
											<option value="47">哥伦比亚比索</option>
											<option value="49">新土耳其里拉</option>
										</select>
									<%--<span class="dpl-tip-inline-warning">--%>
									<%--发货地只能1-200字--%>
									<%--</span>--%>
									</p>

									<p class="blank10" style="display: none"></p>
									<p class="p1" style="display: none"><i class="c_red">*</i>货源种类：</p>
									<p class="s_1" style="display: none">
										<select name="b2cProductDetail.b2cSupply">
											<option value="1" >一般贸易</option>
											<option value="11">海外直邮</option>
											<option value="12">保税区发货</option>
											<option value="21">韩国直邮</option>
											<option value="50">海外预售</option>
											<option value="51" selected="selected">第三方国际发货(POP)</option>
										</select>
									<%--<span class="dpl-tip-inline-warning">--%>
									<%--发货地只能1-200字--%>
									<%--</span>--%>
									</p>

									<div style="display: none;">
										<p class="blank10"></p>
										<p class="p1"><i class="c_red">*</i>行邮税（%）：</p>
										<p class="s_1">
											<select name="b2cProductDetail.tariff">
												<option value="0">无</option>
												<option value="10">10</option>
												<option value="20">20</option>
												<option value="30">30</option>
												<option value="50">50</option>
											</select>
										</p>
									</div>
<%-- 新加 b2c字段开始部分 end--%>


									<p class="blank10"></p>
									<p class="p1">保质期：</p>
									<p class="t2">
									<input  id="sheilLife" name="supplierProductDetail.sheilLife" type="text" style="width:178px">
									<select name="supplierProductDetail.sheilLifeType">
										<option value="2">年</option>
										<option value="1">月</option>
										<option value="0">日</option>
									</select>
									</p>
									<span class="dpl-tip-inline-warning"></span>
									
									<p class="blank10" style="display: none"></p>
									<p class="blank10" style="display: none"></p>
									<p class="p1"style="display: none">海关税则代码：</p>
									<p class="t2"style="display: none">
										<textarea id="customCode"  style="width: 400px; height: 150px;"  name="supplierProductDetail.customCode"></textarea>
									</p>
									<span class="dpl-tip-inline-warning">海关税则代码不能大于50字</span>
									<p class="blank10"></p>
									
									<p class="blank10" style="display: none"></p>
									<p class="p1">搜索关键词：</p>
									<p class="t2">
										<textarea id="remark"  style="width: 400px; height: 150px;"  name="supplierProduct.remark"></textarea>
									</p>
									<span class="dpl-tip-inline-warning">搜索关键词不能大于200字</span>
									<p class="blank10" style="display: none"></p>
									
									
								</div>

								<p class="blank10"></p>
								</div>
							<div class="blank15"></div>
							 <!-- <div  class="z" id="zizhi">
								
								<div class='wenzi'>证明资质的图片:
								<input id='00_upload'  name='button'   type='submit'  value='上传资质' />
								<i class="J_PopTip poptip-help" rel="tooltip" tip="请上传商标注册证明（若商品经过注册须提供）、品牌销售授权（非生产厂家须提供）、商品合格证明（必须提供）和其他相关证明文件（如包装上宣称获得的一些奖项等）。">						
								</i>
								
								
								<span id="zizhiImg" class='dpl-tip-inline-warning'>请至少上传一张资质图片</span></div>
								<div class='gshi' style="color:red">资质图片格式只能是'*.jpg;*.png;*.jpeg;',只能小于1M 一次最多上传6张。</div>
								<ul id="00_img">
								<li class="img-1">
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								<li class="img-6">
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								</ul>
							</div> -->
						<div id="uploader_00" class="wu-example" style="display: none;">
							<input value="00_Http://image01.3qianwan.com/h0/group1/111" name="imgUrl" type="hidden">
							<span id="zizhiImg" class='dpl-tip-inline-warning'>请至少上传一张资质图片</span>
						</div>
						<!-- <div id="uploader_mm" class="wu-example">
							<span id="zizhiImg" class='dpl-tip-inline-warning'>请至少上传一张资质图片</span>
						</div> -->

						<!-- 填写基本信息  -->
						<!-- 填写基本信息  -->
						<div class="blank15"></div>
						<div class="jinben">
							<div class="chanp">
								<p>产品规格:</p>
							</div>
							<div class="p3">
							<input type="button" id="addSaleTable" value="添加规格属性"/><input type="button" id="delSaleTable" value="删除规格属性"/>
							<span class="dpl-tip-inline-warning" id="tblError1"></span>
								<div class="chim2">
								<table id="tblSale" style="margin-top:10px;border:1px;border-style: solid; border-color: #c3c3c3;">
									<colgroup>
									<col style="width: 100px;border:1px;border-style: solid; border-color: #c3c3c3;">
									<col style="width: 540px;border:1px;border-style: solid; border-color: #c3c3c3;">
									<col style="width: 50px;border:1px;border-style: solid; border-color: #c3c3c3;">
									</colgroup>
									<tr style="height: 30px;">
										<th>规格属性</th>
										<th>属性值</th>
										<th>操作</th>
									</tr>
									<tr name="chimTr">
									<td>
										<input type="text" id="saleAttrNm0" name="saleAttrName0" value="默认" style="width: 100px;"/>
									</td>
        							<td id="addSaleAttrvals0" class="chima0">
        								<img src="../images/img_+bg.jpg" onclick="addSaleAttrval(0)">
        								<input type="text" name="saleAttrval0" alt='00' id="saleAttrval00" value="" style="width: 100px;"/>
        							</td>
	        							<td>
	        								<input type="hidden" name="saleAttrRows" value="0"/>
	        								<input type="button" value="删除属性值" onclick="delSaleAttrval(0)" />
	        							</td>
										</tr>
									</table>
									<span class="dpl-tip-inline-warning" style="display: none" >请至少选择一项</span>
								</div>
								
								<div class="yanse2">
								<table id="tblBuy" style="margin-top:10px;border:1px;border-style: solid; border-color: #c3c3c3;">
									<colgroup>
									<col style="width: 100px;border:1px;border-style: solid; border-color: #c3c3c3;">
									<col style="width: 550px;border:1px;border-style: solid; border-color: #c3c3c3;">
									<col style="width: 50px;border:1px;border-style: solid; border-color: #c3c3c3;">
									</colgroup>
									<tr style="height: 30px;">
										<th>展示属性</th>
										<th>属性值</th>
										<th>操作</th>
									</tr>
									<tr>
										<td><input type='text' id="buyAttrNm" name="buyAttrName" value="默认" style="width: 100px;"/></td>
            							<td id="addBuyAttrvals" class="yanse1"><img src="../images/img_+bg.jpg" onclick="addBuyAttrval()">
            							<input type="text" name="buyAttrval" alt="0" id="buyAttrval0" value="" style="width: 100px;"/>
            							</td>
            							<td><input type="button" value="删除属性值" onclick="delBuyAttrval()" /></td>
            						</tr>
								</table>
								<span class="dpl-tip-inline-warning" style="display: none" >至少选择一项</span>
								</div>
								<span class="dpl-tip-inline-warning" id="tblError2"></span>
								
							<!--  <div class="z">
									
								<div id ="d">
				
							</div>						
							</div>  -->
							
						</div>

							
							<div class='gshi'>
							
							上传的图片格式只能是.jpg、.png、.jpeg，尺寸不得小于800*800像素，大小小于400K，图片数量不得少于1张
							<i class="J_PopTip poptip-help" rel="tooltip" tip="图片上传要求：<br>
								1.像素：图片大小800*800像素，分辨率不低于72像素/英寸,图片质量要清晰，不要虚化<br>
								2.纵横比要求1:1<br>
								3.大小：商品的主图上传大小≥30K且≤100K<br>
								4.格式：商品的主图上传格式需为jpg, gif, png, bmp<br>
								5.背景：白色<br>
								6.数量：至少1张（如：产品外部包装正面图、背面图、侧面图、食用方法或配料、内部包装细节图、内部商品细节图、图片应多多展示商品细节）">
								</i>
							</div>
							
							
						</div>
					</div>
					<div class="blank"></div>
					<!-- 填写基本信息  -->
					<div class="i_box">
						<h2 style="display: none">产品销售信息</h2>
						<div class="blank5"></div>
						<div class="p_box">
							<div class="blank20"></div>
							<p class="p1" style="display: none">交易信息：</p>
							<div class="p3" style="display: none">
								<p class="blank5"></p>
								<p class="t1"><i class="c_red">*</i>计量单位：</p>

								<p class="s_1">
								<select  name="supplierProductPackage.measureid">
									<c:forEach items="${measure}" var="measure">
										<option value="${measure.measureid}">${fn:escapeXml(measure.cname)}</option>
									</c:forEach>
								</select></p>

								<p class="blank5"></p>
								<p class="t1"><i class="c_red">*</i>计价单位：</p>
								<p class="s_1">
									<select  name="supplierProductSaleSetting.moneyUnitId">
										<c:forEach items="${price}" var="price">
											<option value="${price.id}">${fn:escapeXml(price.moneyUnitCn)}</option>
										</c:forEach>
									</select>
								</p>



								<div <c:if test="${supplierType eq 3 }">style="display: none"</c:if> >
										<p class="blank5"></p>
										<p class="t1"><i class="c_red">*</i> 价格类型：</p>
										<div class="select-quote" style="margin-left:120px" id="priceTypes">
											<input type="radio" name="priceType" value="0" checked="checked" id="priceType"/>
											<strong>FOB价格</strong>&nbsp;&nbsp;离岸港口名称<input type="text" id="priceType0text" name="fobPort" value="1">
											<span id="priceType0warning" class="dpl-tip-inline-warning"></span>
											<div class="clear"></div>
											<input type="radio"  name="priceType" value="1" id="priceType"/>
											<strong>CIF价格</strong>&nbsp;&nbsp;&nbsp;到岸港口名称<input type="text" id="priceType1text" name="cifPort" value="1">
											<span id="priceType1warning" class="dpl-tip-inline-warning"></span>
											<div class="clear"></div>
											<input type="radio"  name="priceType" value="2" id="priceType"/>
											<strong>EXW价格</strong>
										</div>

										<p class="blank5"></p>

										<p class="t1">
										<i class="c_red">*</i> 报价：</p>
										<div class="select-quote">
											<input type="radio"  id="pic_count"  name="cost" class="cp1" value="1" checked="checked"/>
											<strong>按产品数量报价</strong>
											<input type="radio"  id="pic_sku" name="cost" value="2" class="cp2"/>
											<strong>按产品规格报价</strong>
										</div>
								</div>
								<div class="tqz" style="display: none">
									<!--<p class="tq1"><i class="c_red">*</i>价格区间：</p>-->

									 <div class="tq2" <c:if test="${supplierType eq 3 }">style="display: none"</c:if>>
										<span class="b1"><b></b></span>
										<p class="pp">
										   <span class="b2">起批量：<input type="text" name="start" id="startNum" value="1"><span class="danwei"> ${fn:escapeXml(measure[0].cname)}</span>及以上
											<input type="text" name="pic" value="1">
											<span class="price"> ${fn:escapeXml(price[0].moneyUnitCn)}</span>/<span class="danwei">${fn:escapeXml(measure[0].cname)} </span>
											</span>
										</p>
											<span class="dpl-tip-inline-warning" id="inputwarning">
										</span>

										<span class="b3">
											<img src="../images/img_+bg.jpg"> 增加数量区间
										</span>
									</div>
								<div class="g" style="display: none;">
								<p class="blank"></p>
								<div class="blank10"></div>
								<div class="tab_box">
									<i class="c_red">*</i>
									最小起订量：
									<input type='text' id="minNum" name='minNum' class="xiao" value="1">
									<table id="tb-speca-quotation"  border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;">
										<colgroup>
					            			<col class="color" >
					                       	<col class="size" >
											<col class="cm2" style="width: 50px;">
					                       	<col class="cm3" style="width: 50px;">
					                       	<col class="cm3" style="width: 50px;">
											<col class="price" >
											<!-- <col class="operate" >		 -->
										</colgroup>
										<thead>
											<tr >
												<th>
													<!-- ${fn:escapeXml(buyAttrName[0])} -->
													<span id="zhan1"></span>
												</th>
												<th class="cm1">
													<!-- ${fn:escapeXml(saleAttrName[0])} -->
													<span></span>
												</th>
												<th class="cm2" style="display: none;"><span></span></th>
												<th class="cm3" style="display: none;"><span></span></th>
												<th class="cm4" style="display: none;"><span></span></th>
												<th><span class="c_red"> *</span>单价<br />
													<input id="same_price" type="checkbox">全部相同
												</th>
											</tr>
										</thead>


									</table>

								</div>
								<span class="dpl-tip-inline-warning" id="g1"></span>
								<!-- <span class="dpl-tip-inline-warning" id="g2"></span>
								<span class="dpl-tip-inline-warning" id="g3"></span> -->

								<!-- 表格 end -->



								<p class="blank15"></p>
							</div>

						</div>

						 <p class="blank5"></p>
						 <div <c:if test="${supplierType eq 3 }">style="display: none"</c:if>>
							<p class="t1">
							<i class="c_red">*</i> 订单收集类型：</p>
							<div class="select-quote">
								<input type="radio" name="supplierProductDetail.orderType"  value="1" checked="checked" onchange="changeOrderType('1')"/>
								<strong>现货库存</strong>
								<input type="radio" name="supplierProductDetail.orderType"  value="0" onchange="changeOrderType('2')"/>
								<strong>收集订单</strong>
							</div>
						</div>

						<div id="collection" style="display:none">
							<p class="blank15"></p>
						<p class="t1"><i class="c_red">*</i>预计发货日期：</p>
						<p class="s_1">
							<input type="text" name="supplierProductDetail.deliverDate" readonly="readonly" id="delivery" onClick="WdatePicker({minDate:'%y-%M-%d'})">
							<span id="deliveryDateWarning" class="dpl-tip-inline-warning"></span>
						</p>
							<p class="blank15"></p>
							<p class="t1"><i class="c_red">*</i>生产能力：</p>
							<p class="s_3">
									<input id="produceNum" type="text" name="supplierProductDetail.produceNum"/><span class="danwei">${fn:escapeXml(measure[0].cname)}</span>
									<select name="supplierProductDetail.produceType">
											<option value="0">天</option>
											<option value="4">周</option>
											<option value="1">月</option>
											<option value="2">年</option>
									</select>
									<span id="produceNumWarning" class="dpl-tip-inline-warning"></span>
									<br>
								<span class="dpl-tip-inline-warning"></span>
								</p>
																<p class="blank15"></p>
								<p class="t1"><i class="c_red">*</i>最后收单日期：</p>
								<p class="s_1">
									<input type="text" name="supplierProductDetail.receiveDate" readonly="readonly" id="closing" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'delivery\')}',minDate:'%y-%M-%d'})">
									<span id="closingWarning" class="dpl-tip-inline-warning"></span>
								</p>
								<p class="blank15"></p>
								<p class="t1"><i class="c_red">*</i>最大收单量：</p>
								<p class="s_1">
									<input type="text" id="maxProdNum" name="supplierProductDetail.maxProdNum">
									<span id="maxProdNumWarning" class="dpl-tip-inline-warning"></span>
								</p>


							<p class="blank15"></p>

						</div>
					</div>

					<div class="blank20"></div>
					<p class="p1">条形码信息：</p>
					<div class="p3">
						<p class="blank5"></p>

						<div class="tab_box" style="margin-left:20px;"
							id="skuCodeTable">
							

							<span style="color:red;">请如实填写条形码，条形码应为8,10,12,13,16位数字</span><br>
							<span ><input type="checkbox"  name="auto"  value="1" >自动生成</span>
							<i class="J_PopTip poptip-help" rel="tooltip" 
							tip="如果商品没有条形码，请选择自动生成。 <br>
							保存商品后可以查看生成的条形码信息。">						
								</i><br>
							<table cellspacing="0" cellpadding="0" border="0"
								style="margin-top:10px;" id="tb-tiaoxingma" width="100%">
								<colgroup>
									<!-- <col class="color">
									<col class="size">
									<col class="cm2" style="width: 70px;">
									<col class="cm3" style="width: 70px;">
									<col class="cm4" style="width: 70px;">
									<col class="price"> -->
									<!-- <col class="operate"> -->

								</colgroup>
								<thead>
									<tr>
										<th>
										<span id="zhan2"></span></th>
										<th class="cm1"><span></span></th>
										<th class="cm2" style="display: none;"><span></span></th>
										<th class="cm3" style="display: none;"><span></span></th>
										<th class="cm4" style="display: none;"><span></span></th>
										<th>条形码</th>
									</tr>
									<!-- <tr><td class='chi'  id='0-0'></td><td></td><td><input class='pro_price' type='text' name='skuCode'></td><td><div class='preview_fake'  id="0-0_img" ></div></td><td><input class='file'  id="0-0_upload" name='button'   type='submit' /></td></tr> -->
								</thead>
								<!-- <tbody>
								</tbody> -->
							</table>
						</div>
						<span class="dpl-tip-inline-warning" style="margin-left: 60px;"></span>
						<!-- 表格 end -->
						<p class="blank15"></p>
					</div>


<!-- b2c 价格录入 start-->
							<div class="blank20"></div>
							<p class="p1">商品价格信息：</p>
							<div class="p3">
								<p class="blank5"></p>

								<div class="tab_box" style="margin-left:20px;" id="skuPriceTable">
									<table cellspacing="0" cellpadding="0" border="0" style="margin-top:10px;" id="tb-skuprice" width="100%">
										<colgroup>
											<!-- <col class="color">
											<col class="size">
											<col class="price">
											<col class="tiao"> -->
											<!-- <col class="operate"> -->

										</colgroup>
										<thead>
										<tr>
											<th>
											<span id="zhan3"></span></th>
											<th class="cm1"><span></span></th>
											<th class="cm2" style="display: none;"><span></span></th>
											<th class="cm3" style="display: none;"><span></span></th>
											<th class="cm4" style="display: none;"><span></span></th>
											<th style="display: none;">商品货号</th>
											<th><i class="c_red">*</i>市场价</th>
											<th><i class="c_red">*</i>零售价</th>
											<th style="display: none;"><i class="c_red">*</i>翼支付价(￥)</th>
											<th style="display: none;"><i class="c_red"></i>分红额度</th>
										</tr>
										</thead>
									</table>
								</div>
								<span class="dpl-tip-inline-warning" style="margin-left: 60px;"></span>
								<!-- 表格 end -->
								<p class="blank15"></p>
							</div>
<!-- b2c 价格录入 end-->
							
					<div class="mingxi" style="display: none">
						<div class="m1">商品明细：</div>
						<div class="mm">
							<p class="m2"><span> 包装清单：</span>
							<textarea id="packingList"  name="supplierProductDetail.packingList"></textarea>
							</p>
							<span class="dpl-tip-inline-warning">请填写 包装清单</span>
							<p class="m3"><span>售后服务：</span>
							<textarea id="salesService" name="supplierProductDetail.salesServiceDescription"></textarea>
							</p>
							<span class="dpl-tip-inline-warning" style="display: none">请填写 售后服务</span>
							
							<p class="m4"><span class="s1">售后电话：</span>
							
							
								<select >
										<option>39</option>
								</select>-
								<input  type="text" name="fristPhone" id="area"/>-
								<input  type="text" name="subPhone" id="number"/>
							</p>
							<span class="dpl-tip-inline-warning" id="mobiletext" style="margin-right:100px; "></span>
							
							
						</div>
					</div>
					</div>
						

						<!-- 文本编辑框 -->

						<div class="blank30"></div>
						
						
						
					</div>
					<!-- 内容 end -->
					<div class="i_box">
							<h2>图文详情
							<i class="J_PopTip poptip-help" rel="tooltip" 
							tip="一、上传图片，要求如下（包含但不仅限于以下内容）：<br>
								1.像素：图片大小800*800像素，分辨率不低于72像素/英寸,图片质量要清晰，不要虚化<br>
								2.纵横比要求1:1<br>
								3.大小：商品的主图上传大小≥30K且≤400K<br>
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
					<button class="fabu_btn" id="saveProd" type="button">提交审核</button>
					<%--<button class="fabu_btn" id="draftProd" type="button">保存草稿</button>--%>
					<!-- <button class="fabu_btn" id="previewProd" type="button">商品预览</button> -->
					<p class="clear"></p>
				</div>
			</div>
			<div class="clear"></div>
			<p class="blank30"></p>
		</div>
		 </form>
 </div>
<div id="previewprod" style="left:0; top:0; z-index:999;height:0px;width:0px">
	<div id="previewcontent" style="width:100%;height:100%;overflow-y:scroll"></div>
</div>
<div class="blank10"></div>
	 <!-- 底部 start -->
	 <%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	<!-- 底部 end -->
 
<script type="text/javascript" src="${path}/js/product/zh/editProduct2.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/queue.js"></script>
<script type="text/javascript" src="${path}/js/product/swfUploadEventHandler.js"></script>
<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>


<!--引入JS-->
<script type="text/javascript" src=' ${path}/js/ueditor/third-party/webuploader/webuploader.js'></script>
<script type="text/javascript" src="${path}/js/product/zh/webuploaderhandler.js"></script>
<script type="text/javascript" src="${path}/js/jquery-AutoComplete/jquery.autocomplete.js"></script>
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
                 $("#keyword").autocomplete(msg, {
                     minChars: 0,					//最少输入字条
                     max: 1000,
                     autoFill: false,				//是否选多个,用","分开
                     mustMatch: false,				//是否全匹配, 如数据中没有此数据,将无法输入
                     matchContains: true,			//是否全文搜索,否则只是前面作为标准
                     scrollHeight:500,
                     width:240,
                     multiple: false,
                     formatItem: function (row, i, max) {//显示格式
                         return ""+row.nameCn;
                     },
                     formatMatch: function (row, i, max) {//以什么数据作为搜索关键词,可包括中文,
                         return row.nameCn;
                     },
                     formatResult: function (row) {//返回结果
                         return row.id;
                     }
                 }).result(function(event, data, formatted) { //回调  
                 	  $('#keyword').val(data.nameCn);   //不知为何自动返回值后总是加了个“,”,所以改成后赋值  
                      $("#firstcategory").val(data.id); 
                      onChange(data.id);
                 });
/*				$.each(msg,function(i,n){
					$("#firstcategory").append("<option value='"+n.id+"'>"+n.nameCn+"</option>");
				});	*/
		}
		}); 
		inituploader("证明资质的图片","00",[]);
		/* inituploader1("上传文件","mm",[]); */
		addupload("-","buyAttrval0",[]);
	});

	function changeOrderType(type) {
		if (type == 2) {
			$("#collection").show();			
		}else{
			$("#collection").hide();			
		}
	}
</script>
 </body>
</html>