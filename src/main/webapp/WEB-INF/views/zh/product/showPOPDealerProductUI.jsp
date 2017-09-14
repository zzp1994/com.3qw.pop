<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/views/zh/include/base.jsp"%>

	<title>商家后台管理系统-查看商品</title>
	<link rel="stylesheet" href="${path}/css/zh/shang.css">
	<link href="${path}/css/uploadify.css" rel="stylesheet" type="text/css" />
	<link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />

	<link rel="stylesheet" type="text/css" href="${path}/js/ueditor/third-party/webuploader/webuploader.css">
	<link rel="stylesheet" type="text/css" href="${path}/css/webuploaderframe.css">

</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp"%>
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp"%>
<div class="right f_l">
	<!-- 边框start -->
		<div class="right f_l">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;>&nbsp;</p>
					<p>货品列表&nbsp;>&nbsp;</p>
					<p class="c1">
						查看商品
					</p>
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
						<h2>商品基本信息</h2>
						<div class="app">
							<span>你当前所在的类目是：</span>
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

								<input type="text"  name="pname" id="productinfo" readonly="readonly"
									   value="${fn:escapeXml(proObj.b2cProductDetail.b2cProductName)}">
							</p>
							<div class="blank10"></div>
							<p class="p1">产品属性：</p>
							<div class="p3">
								<div class="bb">
									<p class="blank10"></p>
									<!-- 基本属性属性值 -->
									<p class="p1">
										<i class="c_red">*</i> 主品牌：
									</p>
									<p class="t2">
										<input type="text" value="${fn:escapeXml(proObj.brand.nameCn)}" readonly="readonly">
									</p>
									<p class="blank10"></p>
									<c:if test="${!empty proObj.subBrand.nameCn}">
										<p class="p1">
											<i class="c_red">*</i> 子品牌：
										</p>
										<p class="t2">
											<input type="text" value="${fn:escapeXml(proObj.subBrand.nameCn)}" readonly="readonly">
										</p>
									</c:if>
									<p class="blank10"></p>
									<c:forEach items="${proObj.dealerProductAttrDTOs}" var="dealerProductAttr" varStatus="vs">
										<c:if test="${dealerProductAttr.dealerProductAttr.saleAttr != 1 && dealerProductAttr.dealerProductAttr.buyAttr != 1 }">
											<p class="p1" title="${fn:escapeXml(dealerProductAttr.dealerProductAttr.attrNameCn)}">
													<%-- <c:if test="${dealerProductAttr.dealerProductAttr.isneed == 1}">
                                                        <i class="c_red">*</i>
                                                    </c:if> --%>

													${fn:escapeXml(dealerProductAttr.dealerProductAttr.attrNameCn)}：
											</p>
											<c:if test="${dealerProductAttr.dealerProductAttr.type == 1}">
												<p class="i_radio f_l">
													<c:forEach items="${dealerProductAttr.dealerProductAttrvals}"
															   var="proAttrVal" varStatus="cbs">
																		<span class="r2" title="${fn:escapeXml(proAttrVal.lineAttrvalNameCn)}"><input type="checkbox" disabled="disabled"
																																					  name="dealerProductAttrDTOs[${vs.index}].dealerProductAttrvals[${cbs.index}].lineAttrvalNameCn"
																																					  <c:if test="${proAttrVal.isProdAttr}">checked</c:if>/>
																				${fn:escapeXml(proAttrVal.lineAttrvalNameCn)}</span>
													</c:forEach>
												</p>
											</c:if>

											<c:if test="${dealerProductAttr.dealerProductAttr.type ==2}">
												<p class="s_1">
													<select name="dealerProductAttrDTOs[${vs.index}].dealerProductAttrvals[0].lineAttrvalNameCn" disabled="disabled">
														<c:forEach items="${dealerProductAttr.dealerProductAttrvals}" var="dealerProductAttrval">
															<option value="${fn:escapeXml(dealerProductAttrval.lineAttrvalNameCn)}"
																	<c:if test="${dealerProductAttrval.isProdAttr}">selected</c:if>>
																	${fn:escapeXml(dealerProductAttrval.lineAttrvalNameCn)}
															</option>
														</c:forEach>
													</select>
												</p>
											</c:if>

											<c:if test="${dealerProductAttr.dealerProductAttr.type == 3}">
												<p class="t2">
												<c:choose>
													<c:when test="${dealerProductAttr.dealerProductAttrvals[0].isProdAttr}">
														<input type="text" readonly="readonly"
															   value="${fn:escapeXml(dealerProductAttr.dealerProductAttrvals[0].lineAttrvalNameCn)}" /></p>
													</c:when>
													<c:otherwise>
														<input type="text" disabled="disabled"
															   value="" /></p>

													</c:otherwise>
												</c:choose>
											</c:if>

											<p class="blank10"></p>
										</c:if>
									</c:forEach>
									<!-- 基本属性属性值 -->


									<p class="blank10"></p>
									<!-- <p class="p1">
										<i class="c_red">*</i> 原产国：
									</p>
									<p class="t2">
										<input  name="dealerProduct.originplace" disabled="disabled"
												type="text" value="${fn:escapeXml(proObj.dealerProduct.originplaceCName)}">
									</p>
									</p> -->
									<p class="blank10" style="display: none;"></p>
									<p class="p1" style="display: none;">
										<i class="c_red">*</i> 制造商：
									</p>
									<p class="t2" style="display: none;">
										<input readonly="readonly"
											   name="dealerProduct.manufacturers" type="text"
											   value="${fn:escapeXml(proObj.dealerProduct.manufacturers)}">
									</p>


									<%-- 新加 b2c字段开始部分 start--%>

									<p class="blank10" style="display: none"></p>
									<p class="p1" style="display: none"><i class="c_red">*</i> 发货地：</p>
									<p class="t2" style="display: none">
										<input required="b2cOriginCountry" name="b2cProductDetail.originCountry" type="text" value="${proObj.b2cProductDetail.originCountry}">
									<span class="dpl-tip-inline-warning">
									发货地只能1-200字
									</span>
									</p>

									<p class="blank10" style="display: none;"></p>
									<p class="p1" style="display: none;"><i class="c_red">*</i> 国外币种：</p>
									<p class="s_1" style="display: none;">
										<select name="b2cProductDetail.b2cMoneyUnitId">
											<option value="1" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==1}">selected</c:if> >人民币</option>
											<option value="2" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==2}">selected</c:if> >欧元</option>
											<option value="4" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==4}">selected</c:if> >英镑</option>
											<option value="5" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==5}">selected</c:if> >日元</option>
											<option value="6" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==6}">selected</c:if> >美元</option>
											<option value="15" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==15}">selected</c:if> >新台币</option>
											<option value="17" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==17}">selected</c:if> >阿联酋迪拉姆</option>
											<option value="18" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==18}">selected</c:if> >澳元</option>
											<option value="19" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==19}">selected</c:if> >澳门元</option>
											<option value="20" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==20}">selected</c:if> >埃及磅</option>
											<option value="21" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==21}">selected</c:if> >俄罗斯卢布</option>
											<option value="22" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==22}">selected</c:if> >丹麦克朗</option>
											<option value="23" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==23}">selected</c:if> >新西兰元</option>
											<option value="24" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==24}">selected</c:if> >新加坡元</option>
											<option value="25" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==25}">selected</c:if> >文莱元</option>
											<option value="26" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==26}">selected</c:if> >匈牙利福林</option>
											<option value="27" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==27}">selected</c:if> >越南盾</option>
											<option value="28" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==28}">selected</c:if> >印度卢比</option>
											<option value="29" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==29}">selected</c:if> >印尼卢比</option>
											<option value="30" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==30}">selected</c:if> >智利比索</option>
											<option value="31" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==31}">selected</c:if> >瑞士法郎</option>
											<option value="32" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==32}">selected</c:if> >瑞典克朗</option>
											<option value="33" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==33}">selected</c:if> >斯里兰卡卢比</option>
											<option value="34" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==34}">selected</c:if> >泰铢</option>
											<option value="35" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==35}">selected</c:if> >肯尼亚先令</option>
											<option value="36" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==36}">selected</c:if> >老挝基普</option>
											<option value="37" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==37}">selected</c:if> >缅甸元</option>
											<option value="38" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==38}">selected</c:if> >马来西亚林吉特</option>
											<option value="39" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==39}">selected</c:if> >墨西哥元</option>
											<option value="40" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==40}">selected</c:if> >挪威克朗</option>
											<option value="41" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==41}">selected</c:if> >南非兰特</option>
											<option value="42" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==42}">selected</c:if> >加元</option>
											<option value="43" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==43}">selected</c:if> >韩元</option>
											<option value="44" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==44}">selected</c:if> >港元</option>
											<option value="45" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==45}">selected</c:if> >菲律宾比索</option>
											<option value="46" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==46}">selected</c:if> >柬埔寨瑞尔</option>
											<option value="47" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==47}">selected</c:if> >哥伦比亚比索</option>
											<option value="49" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==49}">selected</c:if> >新土耳其里拉</option>
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
												<option value="0" selected="selected">无</option>
												<option value="10">10</option>
												<option value="20">20</option>
												<option value="30">30</option>
												<option value="50">50</option>
											</select>
											<%--<span class="dpl-tip-inline-warning">--%>
											<%--发货地只能1-200字--%>
											<%--</span>--%>
										</p>
									</div>

									<%-- 新加 b2c字段开始部分 end--%>

									<p class="blank10"></p>
									<p class="p1">保质期：</p>
									<p class="t2">
										<input name="dealerProductDetail.sheilLife" type="text"
											   style="width:200px"
											   disabled="disabled"
											   value="${proObj.dealerProductDetail.sheilLife}">
										<c:if test="${proObj.dealerProductDetail.sheilLifeType==2}">年</c:if>
										<c:if test="${proObj.dealerProductDetail.sheilLifeType==1}">月</c:if>
										<c:if test="${proObj.dealerProductDetail.sheilLifeType==0}">天</c:if>
										</select>
									</p>
								</div>


								<p class="blank10" style="display: none;"></p>
								<p class="blank10" style="display: none;"></p>
								<p class="p1" style="display: none;">海关税则代码：</p>
								<p class="t2" style="display: none;">
									<textarea id="customCode"  disabled="disabled" style="width: 400px; height: 150px;"  name="dealerProductDetail.customCode">${proObj.dealerProductDetail.customCode}</textarea>
								</p>
								<span class="dpl-tip-inline-warning">海关税则不能大于200字</span>
								<p class="blank10" style="display: none;"></p>
								<p class="blank10" style="display: none;"></p>

								<p class="blank10" style="display: none;"></p>
								<p class="p1" style="display: none;">商品备注：</p>
								<p class="t2" style="display: none;">
										<textarea id="remark" disabled="disabled"  style="width: 400px; height: 150px;"  name="dealerProduct.remark">${proObj.dealerProduct.remark}
										</textarea>
								</p>
								<p class="blank10" style="display: none;"></p>
							</div>
						</div>

						<p class="blank15"></p>
						<div  class="z" id="zizhi" style="display: none;">

							<div class='wenzi'>证明资质的图片:</div>

							<ul id="00_img">
								<c:forEach items="${qualificationUrl}" var="qualification">
									<li class="img-1">
										<div class="p-img"><img src="${qualification}"></div>
									</li>
								</c:forEach>

							</ul>
						</div>
						<p class="blank15"></p>



						<div class="jinben">
							<div class="chanp">
								<p>产品规格:</p>
							</div>

							<div class="p3">
								<!-- 规格属性 -->
								<c:forEach items="${proObj.dealerProductAttrDTOs }" var="attr" varStatus="saleVs">
									<c:if test="${attr.dealerProductAttr.buyAttr == 1}">
										<!-- 购买属性 -->
										<div class="yanse">
											<div class="yanse1" title="${fn:escapeXml(attr.dealerProductAttr.attrNameCn)}">
												<span>*</span>${fn:escapeXml(attr.dealerProductAttr.attrNameCn)}：
											</div>
											<div class="yanse2">
												<p>
													<c:forEach items="${attr.dealerProductAttrvals}" var="av" varStatus="vars">
													<span title="${fn:escapeXml(av.lineAttrvalNameCn)}">
													<input type="checkbox" disabled="disabled"
														   name="dealerProductAttrDTOs[${saleVs.index}].dealerProductAttrvals[${vars.index}].lineAttrvalNameCn"
														   <c:if test="${av.isProdAttr}">checked</c:if>
														   value="${fn:escapeXml(av.lineAttrvalNameCn)}" id="${vars.index}">${fn:escapeXml(av.lineAttrvalNameCn)}</span>
													</c:forEach>
												</p>
											</div>
										</div>
										<br>
									</c:if>

									<c:if test="${attr.dealerProductAttr.saleAttr==1}">
										<!-- 规格属性 -->
										<div class="chim">
											<div class="chim1" title="${fn:escapeXml(attr.dealerProductAttr.attrNameCn)}">
												<span>*</span> ${fn:escapeXml(attr.dealerProductAttr.attrNameCn)}：
											</div>
											<div class="chim2">
												<p>
													<c:forEach items="${attr.dealerProductAttrvals}" var="av" varStatus="vs">
													<span title="${fn:escapeXml(av.lineAttrvalNameCn)}">
													<input type="checkbox" disabled="disabled"
														   name="dealerProductAttrDTOs[${saleVs.index}].dealerProductAttrvals[${vs.index}].lineAttrvalNameCn"
														   value="${fn:escapeXml(av.lineAttrvalNameCn)}"
														   <c:if test="${av.isProdAttr}">checked="checked"</c:if>
														   id="${vs.index}">
														${fn:escapeXml(av.lineAttrvalNameCn)}
														</span>
													</c:forEach>
												</p>
											</div>
										</div>
									</c:if>
								</c:forEach>
								<!-- 规格属性 -->


								<div class="z">
									<div id="d"></div>
								</div>
							</div>

						</div>
					</div>
					<div class="blank"></div>
					<!-- 填写基本信息  -->
					<div class="i_box">
						<h2>产品销售信息</h2>
						<div class="blank5"></div>
						<div class="p_box">
							<div class="blank20"></div>
							<%--<p class="p1">交易信息：</p>--%>
							<div class="p3" style="display: none;">
								<p class="blank5"></p>
								<p class="t1"><i class="c_red">*</i>计量单位：</p>
								<p class="s_1">
									<input type="text" id="measure" disabled="disabled" value="${fn:escapeXml(proObj.dealerProductPackage.measureCname)}">
								</p>
								<p class="blank5"></p>
								<p class="t1"><i class="c_red">*</i>计价单位：</p>

								<p class="s_1">
									<input type="text" id="price" disabled="disabled" value="">
								</p>
								<p class="blank5"></p>


								<div <c:if test="${dealerType eq 3 }">style="display: none"</c:if> >
									<p class="t1"><i class="c_red">*</i> 价格类型：</p>
									<div class="select-quote" style="margin-left:120px" id="priceTypes">

										<input type="radio"  disabled="disabled"  name="priceType" value="0" <c:if test="${proObj.dealerProductDetail.priceType==0}">checked</c:if>  id="priceType"/>
										<strong>FOB价格</strong>&nbsp;&nbsp;离岸港口名称<input  id="priceType0text"  disabled="disabled" type="text" name="fobPort" <c:if test="${proObj.dealerProductDetail.priceType==0}">value="${proObj.dealerProductDetail.portName}"</c:if> >
										<span id="priceType0warning" class="dpl-tip-inline-warning"></span>
										<div class="clear"></div>
										<input type="radio"  disabled="disabled"  name="priceType" value="1" <c:if test="${proObj.dealerProductDetail.priceType==1}">checked</c:if> id="priceType"/>
										<strong>CIF价格</strong>&nbsp;&nbsp;&nbsp;到岸港口名称<input id="priceType1text"  disabled="disabled" type="text" name="cifPort" <c:if test="${proObj.dealerProductDetail.priceType==1}">value="${proObj.dealerProductDetail.portName}"</c:if>>
										<span id="priceType1warning" class="dpl-tip-inline-warning"></span>
										<div class="clear"></div>
										<input type="radio"  disabled="disabled"  name="priceType" value="2" <c:if test="${proObj.dealerProductDetail.priceType==2}">checked</c:if> id="priceType"/>
										<strong>EXW价格</strong>
									</div>
									<p class="blank5"></p>



									<p class="t1">
										<i class="c_red">*</i>报价：</p>
									<div class="select-quote">
										<input type="radio" name="cost"  disabled="disabled" id="pic_count" class="cp1" value="1"/>

										<strong>按产品数量报价</strong>
										<input type="radio" name="cost" disabled="disabled" id="pic_sku" value="2" class="cp2" />
										<strong>按产品规格报价</strong>
									</div>

									<div class="tqz">
										<!--<p class="tq1"><i class="c_red">*</i>价格区间：</p>-->

										<div class="tq2">
											<p class="pp">

											</p>
										</div>
										<div class="g">
											<p class="blank"></p>
											<div class="blank10"></div>
											<div class="tab_box">
												最小起订量：<input type='text' disabled="disabled" name='minNum' value="${proObj.dealerProductSaleSetting.minWholesaleQty }">
												<table id="tb-speca-quotation" border="0" cellpadding="0"
													   cellspacing="0">
													<colgroup>
														<col class="color">
														<col class="size">
														<col class="cm2" style="width: 50px;">
					                       				<col class="cm3" style="width: 50px;">
					                       				<col class="cm4" style="width: 50px;">
														<col class="price">
														<col class="operate">
													</colgroup>
													<thead>
													<tr>
														<th><span id="zhan1"></span></th>
														<th class="cm1"><span></span></th>
														<th class="cm2" style="display: none;"><span></span></th>
														<th class="cm3" style="display: none;"><span></span></th>
														<th class="cm4" style="display: none;"><span></span></th>
														<th><span class="c_red"> *</span>单价（元）<br />

															<input id="same_price" type="hidden"></th></th>
													</tr>
													</thead>
													<tbody>
													</tbody>

												</table>

											</div>
											<!-- 表格 end -->



											<p class="blank15"></p>
										</div>
										<p class="blank10"></p>
									</div>



									<!-- 	<p class="blank15"></p> -->
									<p class="blank5"></p>
									<p class="t1">
										<i class="c_red">*</i> 订单收集类型：</p>
									<div class="select-quote">
										<input type="radio" disabled="disabled" name="dealerProductDetail.orderType" <c:if test="${proObj.dealerProductDetail.orderType==1}">checked</c:if>  value="1"  onchange="changeOrderType('1')"/>
										<strong>现货库存</strong>
										<input type="radio" disabled="disabled" name="dealerProductDetail.orderType" <c:if test="${proObj.dealerProductDetail.orderType==0}">checked</c:if> value="0" onchange="changeOrderType('2')"/>
										<strong>收集订单</strong>
									</div>

								</div>

								<div id="collection"  <c:if test="${proObj.dealerProductDetail.orderType!=0}">style="display:none"</c:if>>
									<p class="blank15"></p>
									<p class="t1"><i class="c_red">*</i>预计发货日期：</p>
									<p class="s_1">
										<input type="text" disabled="disabled" name="dealerProductDetail.deliverDate" value="<fmt:formatDate value="${proObj.dealerProductDetail.deliverDate}" pattern="yyyy-MM-dd"/>"
											   readonly="readonly" id="delivery" onClick="WdatePicker({minDate:'%y-%M-%d'})">
										<span id="deliveryDateWarning" class="dpl-tip-inline-warning"></span>
									</p>
									<p class="blank15"></p>
									<p class="t1"><i class="c_red">*</i>生产能力：</p>
									<p class="s_3">
										<input id="produceNum" disabled="disabled"  type="text" name="dealerProductDetail.produceNum" value="${proObj.dealerProductDetail.produceNum}"/><span class="danwei">${fn:escapeXml(proObj.dealerProductPackage.measureCname)}</span>
										<select name="dealerProductDetail.produceType" disabled="disabled" >
											<option value="0" <c:if test="${proObj.dealerProductDetail.produceType==0}">selected</c:if>>天</option>
											<option value="4" <c:if test="${proObj.dealerProductDetail.produceType==4}">selected</c:if>>周</option>
											<option value="1" <c:if test="${proObj.dealerProductDetail.produceType==1}">selected</c:if>>月</option>
											<option value="2" <c:if test="${proObj.dealerProductDetail.produceType==2}">selected</c:if>>年</option>
										</select>
										<span id="produceNumWarning" class="dpl-tip-inline-warning"></span>
										<br>
									</p>
									<p class="blank15"></p>
									<p class="t1"><i class="c_red">*</i>最后收单日期：</p>
									<p class="s_1">
										<input type="text" name="dealerProductDetail.receiveDate" disabled="disabled"
											   readonly="readonly" id="closing" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'delivery\')}',minDate:'%y-%M-%d'})"
											   value="<fmt:formatDate value="${proObj.dealerProductDetail.receiveDate}" pattern="yyyy-MM-dd"/>"
										>
										<span id="closingWarning" class="dpl-tip-inline-warning"></span>

									</p>
									<span id="orderDate" class="dpl-tip-inline-warning"></span>
									<p class="blank15"></p>
									<p class="t1"><i class="c_red">*</i>最大收单量：</p>
									<p class="s_1">
										<input  id="maxProdNum" type="text" name="dealerProductDetail.maxProdNum" disabled="disabled" value="${proObj.dealerProductDetail.maxProdNum}">
										<span id="maxProdNumWarning" class="dpl-tip-inline-warning"></span>
									</p>

									<p class="blank15"></p>

								</div>
							</div>

							<div class="blank20"></div>
							<p class="p1">条形码信息：</p>
							<div class="p3">
								<p class="blank5"></p>
								<div class="tab_box" style="margin-left:60px;" id="skuCodeTable">

									<!-- 	<span style="color:red;">请如实填写条形码</span> -->
									<table cellspacing="0" cellpadding="0" border="0" style="margin-top:10px;" id="tb-tiaoxingma" width="100%">
										<colgroup>
											<!-- <col class="color">
											<col class="size">
											<col class="cm2" style="width: 70px;">
					                       	<col class="cm3" style="width: 70px;">
					                       	<col class="cm3" style="width: 70px;">
											<col class="price"> -->
											<!-- <col class="operate">	 -->
										</colgroup>
										<thead>
										<tr >
											<th><span id="zhan2"></span></th>
														<th class="cm1"><span></span></th>
														<th class="cm2" style="display: none;"><span></span></th>
														<th class="cm3" style="display: none;"><span></span></th>
														<th class="cm4" style="display: none;"><span></span></th>
											<th><span class="c_red"> *</span>条形码<br /></th>
											<th style="display: none;">条形码图片</th>
										</tr>
										</thead>
										<tbody>
										</tbody>

									</table>

								</div>
								<span class="dpl-tip-inline-warning"></span>
								<!-- 表格 end -->




								<p class="blank15"></p>


							</div>
							<!-- b2c 价格录入 start-->
							<div class="blank20"></div>
							<p class="p1">商品价格信息：</p>
							<div class="p3">
								<p class="blank5"></p>

								<div class="tab_box" style="margin-left:60px;" id="skuPriceTable">
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
											<th><span id="zhan3"></span></th>
														<th class="cm1"><span></span></th>
														<th class="cm2" style="display: none;"><span></span></th>
														<th class="cm3" style="display: none;"><span></span></th>
														<th class="cm4" style="display: none;"><span></span></th>
												<th style="display: none;">商品货号</th>
											<th><i class="c_red">*</i>市场价格(￥)</th>
											<th><i class="c_red">*</i>零售价(￥)</th>
											<c:if test="${type!=5}">
												<th>现金比例(%)</th>
											</c:if>
											<c:if test="${type==5}">
												<th><input type="text"></th>
											</c:if>
											<th style="display: none;"><i class="c_red">*</i>翼支付价(￥)</th>
											<th style="display: none;"><i class="c_red"></i>赠送红旗劵</th>
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
							<div class="mingxi" style="display: none;">
								<div class="m1">商品明细：</div>
								<div class="mm">
									<p class="m2">
										<span>包装清单：</span>
										<textarea disabled="disabled" name="dealerProductDetail.packingList">${fn:escapeXml(proObj.dealerProductDetail.packingList)}</textarea>
									</p>
									<p class="m3">
										<span>售后服务：</span>
										<textarea disabled="disabled" name="dealerProductDetail.salesServiceDescription">${fn:escapeXml(proObj.dealerProductDetail.salesServiceDescription)}</textarea>
									</p>
									<p class="m4">
										<span  class="s1">售后电话：</span>
										<input type="text" disabled="disabled"
											   name="dealerProductDetail.salesCalls"
											   value="${proObj.dealerProductDetail.salesCalls}" />
									</p>

								</div>
							</div>
						</div>


						<!-- 文本编辑框 -->

						<div class="blank30"></div>
						<div class="i_box">
							<h2>图文详情</h2>
							<div class="blank20"></div>
							<!--style给定宽度可以影响编辑器的最终宽度-->
							<div style="max-width:820px; height:auto; overflow:auto;" id="attach">
								<c:catch var="catchAtach">
									<c:import url="${fileurl}" charEncoding="utf-8"></c:import>
								</c:catch>
							</div>
						</div>
						<!-- 文本编辑框结束 -->
						<div class="blank"></div>
						<!-- 填写基本信息  -->


						<!--有审核标记才可以审核-->
						<c:if test="${revewFlag==1}">

							<!-- 项目 -->
							<div class="blank30"></div>
							<div class="blank30"></div>
							<div class="i_box">
								<h2>商品审核</h2>
								<div class="mingxi">
									<div class="mm">
										<p class="m2">
											<span>审核意见：</span>
											<textarea id="rejectReason" name="rejectReason" cols="60" rows="5"></textarea>
										</p>

									</div>
								</div>
							</div>
						</c:if>

						<div class="blank30"></div>
					</div>
					<!-- 内容 end -->


				</div>
				<!-- 边框 end -->
					<div class="blank10"></div>
					<div class="btn_box">

						<button type="button" id="retBtn" class="fabu_btn">返回</button>
						<%--<button type="button" id="editProd" class="fabu_btn" >修改商品</button>--%>



						<!-- 					<input  type="submit" id="previewProd" class="fabu_btn" >预览商品</button> -->
						<p class="clear"></p>
					</div>
				</div>
				<div class="clear"></div>
				<p class="blank30"></p>
			</div>
</div>
</div>
</div>
<input type="hidden" name="dpro" id="dpro" value="${dpro}">
<input type="hidden" name="page" id="page" value="${page}">
<div class="clear"></div>
<div class="blank10"></div>
<!-- 底部 start -->
<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
</body>
</html>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/queue.js"></script>
<script type="text/javascript" src="${path}/js/product/swfUploadEventHandler.js"></script>
<script type="text/javascript" src="${path}/js/product/zh/editProduct_popshow2.js"></script>
<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>

<!--引入JS-->
<script type="text/javascript" src=' ${path}/js/ueditor/third-party/webuploader/webuploader.js'></script>
<script type="text/javascript" src="${path}/js/product/zh/webuploaderhandler.js"></script>

<script type="text/javascript">


	$(document).ready(function(){
		var url_array = ${jsonImg};
		$.each(url_array,function(n,value){
			adduploadimg(value[1],value[2],value[3]);
		});


		var skuCode = ${skusCode};

		var skuCode_array = new Array();
		$.each(skuCode,function(key,value){
			skuCode_array.push(value);
			var new_array = new Array();
			new_array.push(skuCode_array);
			_fShowTableInfo(skuCode,"tb-tiaoxingma");
			_fShowTableInfo(skuCode,"skuPriceTable");
		});

        $("#retBtn").click(function(){
            location.href="../product/onSaleList?page="+$("#page").val()+"&dpro="+$("#dpro").val();
        });
	});

</script>
</body>
</html>