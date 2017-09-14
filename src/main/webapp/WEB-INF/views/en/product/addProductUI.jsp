<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Supplier-Post Products</title>
<%@include file="/WEB-INF/views/en/include/base.jsp"%>
<link rel="stylesheet" href="${path}/css/en/shang.css">
<link href="${path}/css/uploadify.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${path}/js/ueditor/third-party/webuploader/webuploader.css">
<link rel="stylesheet" type="text/css" href="${path}/css/webuploaderframe.css">
</head>
<body>
<input type="hidden" value="${path}" id="baseUrl">
<%@include file="/WEB-INF/views/en/include/header.jsp" %>
<%@include file="/WEB-INF/views/en/include/leftProduct.jsp" %>
<div class="right f_l">
	<!-- 边框start -->
   <input type="hidden" id="language" value="${language}">
   <input type="hidden" id="sessionId" value="${sid}" />
   <input type="hidden" id="supplierType" value="${supplierType}" />
    <input type="hidden" id="productId" value="${stime}" />
	<form method="post"  id="productAction" enctype="multipart/form-data">
		<input type="hidden" name="supplierProduct.prodLineId" value="${catePub.prodLineId }">
		<input type="hidden" name="supplierProduct.businessCatePubId" value="${catePub.businessNo}">
		<input type="hidden" id="cid" name="supplierProduct.catePubId" value="${catePub.catePubId}">
		<div class="right f_l">
			<div class="c21">
				<div class="title">
					<p>Seller Center&nbsp;>&nbsp;</p>
					<p>Product Management&nbsp;>&nbsp;</p>
					<p class="c1">Post Products</p>
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
						<h2>Basic Info</h2>
						
						<div class="app">
						<span>Currently Selected Category：</span>
						<c:forEach items="${cateNames}"  var="cateName" varStatus="var">
							<span>${fn:escapeXml(cateName.pubName)}</span>
						<c:if test="${!var.last}">
							<span>&gt;</span>
						</c:if>
						</c:forEach>
						</div>
						
						<div class="blank15"></div>
						<div class="p_box">
							<p class="p1">
								<i class="c_red">*</i> Product Title：
							</p>
							<p class="p2">
							
								<input type="text"  required="required" width="80%" id="productinfo" title="Country of origin + brand name (foreign brand name + Chinese brand name) + product categories (functional groups + modifier + product generic) + product attributes (art.no., color, quantity, size, etc.)"
								 name="pname" placeholder="Country of origin + brand name (foreign brand name + Chinese brand name) + product categories (functional groups + modifier + product generic) + product attributes (art.no., color, quantity, size, etc.)" value=""> 
								 <i class="J_PopTip poptip-help" rel="tooltip"
										tip="'+' Represents a half-size spaceProduct name cannot contain 'special for', 'designed for', 'promotion' 'special' 'free shipping,' 'authentic,' 'freebie' and other words that unrelated to the product itselfBrand (need English brand front, Chinese brand in the post, no English brand only fill in Chinese brands, the capital letter or small letter of English brand the  manufacturers registration shall prevail )Please use simplified half-width symbolsUnit shall be the half Angle English g, ml, L, and should not be in ChineseProduct quantity of 1 do not need write: 1 bottle 1 box 1 tank, etcMulti-packaged goods single commodity specification can be multiplied by the number Example: 125g * 2						
									<br> German Aptamil infant formula 1 segment 0 ~ 6 months 800 g * 2.">
									</i><br>
								
								
								<span class="dpl-tip-inline-warning" id="productMsg">Please fill in Product Title</span>
							</p>
								
							<div class="blank10"></div>
							<p class="p1">Product Attribute：</p>
							<div class="p3" id="attrobjs">
								<div class="bb">
									<p class="blank10"></p>
									<p class="p1">
									<i class="c_red">*</i> Brand：</p>
									<p class="s_1">
									<select id="firstcategory" name="brandId" >
										<option value="">please select</option>
									</select> 
									
						 			<select id="secondcategory" name="subBrandId"></select>
						 			
									</p>
									<span class="dpl-tip-inline-warning"></span>
									<p class="blank10"></p>
									
									
									<div id="attrdiv">
										<c:forEach items="${attrList}" var="attr2" varStatus="vs">
											<c:if test="${attr2.key.saleAttr != 1 && attr2.key.buyAttr != 1}">
												<p class="p1" title="${fn:escapeXml(attr2.key.lineAttrName)}">
													<c:if test="${attr2.key.required == 1}">
														<i class="c_red">*</i>
													</c:if>
													<span>${fn:escapeXml(attr2.key.lineAttrName)}</span>
													<c:if test="${not empty attr2.key.attrDescribe}">
														<i class="J_PopTip poptip-help" rel="tooltip" tip="${attr2.key.attrDescribe }">						
														</i>
													</c:if>
													
													：
												</p>
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.attrNameCn"
													value="${fn:escapeXml(attr2.key.lineAttrName)}">
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.type"
													value="${fn:escapeXml(attr2.key.type)}">
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.style"
													value="${fn:escapeXml(attr2.key.style)}">
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.isneed"
													value="${fn:escapeXml(attr2.key.required)}">
												<c:if test="${attr2.key.type == 1}">
													<div class="i_radio" <c:if test="${attr2.key.required == 1}">required="required"</c:if>>
														<c:forEach items="${attr2.value}" var="attrVal"
															varStatus="cbs">
															<p>
																<span class="r2" title="${fn:escapeXml(attrVal.lineAttrvalName)}">
																<input type="checkbox" name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[${cbs.index}].lineAttrvalNameCn" value="${attrVal.lineAttrvalName}" />
																${fn:escapeXml(attrVal.lineAttrvalName)}</span>
															</p>
														</c:forEach>
														<span class="dpl-tip-inline-warning"></span>
													</div>
												</c:if>
												<c:if test="${attr2.key.type == 2}">
													<p class="s_1">
														<select name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn">
															<c:forEach items="${attr2.value}" var="attrVal">
																<option value="${fn:escapeXml(attrVal.lineAttrvalName)}">${fn:escapeXml(attrVal.lineAttrvalName)}</option>
															</c:forEach>
														</select>
													</p>
												</c:if>
												<c:if test="${attr2.key.type == 3}">
													<p class="t2">
														<c:choose>
															<c:when test="${attr2.key.required == 1}">
																<input type="text" required="required"
																name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn"
																value="${fn:escapeXml(attrVal.lineAttrvalName)}" />${fn:escapeXml(attrVal.lineAttrvalName)}
																<span class="dpl-tip-inline-warning" >${fn:escapeXml(attr2.key.lineAttrName)} must be 1-100 characters</span>
															</c:when>
															<c:otherwise>
																<input type="text"
																name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn"
																value="${fn:escapeXml(attrVal.lineAttrvalName)}" />${fn:escapeXml(attrVal.lineAttrvalName)}
															</c:otherwise>
														</c:choose>
														<span class="dpl-tip-inline-warning"></span>
													</p>
												</c:if>
												<p class="blank10"></p>
											</c:if>
										</c:forEach>
									</div>
									
									<p class="blank10"></p>
							
									<p class="p1"><i class="c_red">*</i> Country of Origin：</p>
									<p class="s_1">
									<select name="supplierProduct.originplace">
										<c:forEach items="${countries}" var="country">
											<option value="${fn:escapeXml(country.countryid)}">${fn:escapeXml(country.description)}</option>
										</c:forEach>
									</select>
									
									<p class="blank10"></p>
									<p class="p1"><i class="c_red">*</i> Manufacturer：</p>
									<p class="t2">
									<input required="required" name="supplierProduct.manufacturers" type="text">
									<span class="dpl-tip-inline-warning">
									Manufacturer must be 4-100 characters
									</span>
									</p>
									</p>
									
									<p class="blank10"></p>
									<p class="p1">Shelf life：</p>
									<p class="t2">
									<input  id="sheilLife" name="supplierProductDetail.sheilLife" type="text" style="width:178px">
									<select name="supplierProductDetail.sheilLifeType">
										<option value="2">Year</option>
										<option value="1">Month</option>
										<option value="0">Day</option>
									</select>
									</p>
									<span class="dpl-tip-inline-warning"></span>
									
									
									<p class="blank10"></p>
									<p class="p1">Custom Code：</p>
									<p class="t2">
										<textarea id="customCode"  style="width: 400px; height: 150px;"  name="supplierProductDetail.customCode"></textarea>
									</p>
									<span class="dpl-tip-inline-warning">Custom Code must be 0-50 characters</span>
									<p class="blank10"></p>
									
									<p class="blank10"></p>
									<p class="p1">Product Remark：</p>
									<p class="t2">
										<textarea id="remark"  style="width: 400px; height: 150px;"  name="supplierProduct.remark"></textarea>
									</p>
									<span class="dpl-tip-inline-warning">Product Remark must be 0-200 characters</span>
									<p class="blank10"></p>
								</div>

								<p class="blank10"></p>
							</div>
						
						
						
						<div class="blank15"></div>
						<%--  <div  class="z" id="zizhi">
								
								<div class='wenzi'>Qualification Images:<input id='00_upload'  name='button'   type='submit'  value='upload' />
								<i class="J_PopTip poptip-help" rel="tooltip" tip="Please upload the certificate of trademark registration (must be provided if the goods is registered), 
								                                                   sales  authorization of <br> brand (must be provided by the non-manufacturer), certificate of qualified goods 
								                                                   (must be provided) and other relevant certificate documents (such as some awards, etc., declared on the package).">						
								</i>
								<span id="zizhiImg" class='dpl-tip-inline-warning'>Please upload a picture at least</span></div>
								<div class='gshi' style="color:grey">The image format should be “jpg”,”png” or “jpeg”, the size of each photo should be less than 1024K bytes, the total number of photos is no more than 6.</div>
								<ul id="00_img">
								<li class="img-1">
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">left</i>
								<i class="toright">right</i>
								<i class="del">delete</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">left</i>
								<i class="toright">right</i>
								<i class="del">delete</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">left</i>
								<i class="toright">right</i>
								<i class="del">delete</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">left</i>
								<i class="toright">right</i>
								<i class="del">delete</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">left</i>
								<i class="toright">right</i>
								<i class="del">delete</i>
								</div>
								</li>
								<li class="img-6">
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">left</i>
								<i class="toright">right</i>
								<i class="del">delete</i>
								</div>
								</li>
								</ul>
							</div> --%>
							<div id="uploader_00" class="wu-example">
								<span id="zizhiImg" class='dpl-tip-inline-warning'>Please upload a picture at least</span>
							</div>
						</div> 

					<div class="blank15"></div>

						<!-- 填写基本信息  -->
						<!-- 填写基本信息  -->
						<div class="jinben">
							<div class="chanp">
								<p>Product Specification:</p>
							</div>
							<div class="p3">
							<c:forEach items="${attrList}" var="attr" varStatus="saleVs">
								<c:if test="${attr.key.buyAttr == 1}">
									<!-- 购买属性 -->
									<div class="yanse">
										<div class="yanse1" title="${fn:escapeXml(attr.key.lineAttrName)}">
											<span>*</span> 
											${fn:escapeXml(attr.key.lineAttrName)}
											<c:if test="${not empty attr.key.attrDescribe}">
												<i class="J_PopTip poptip-help" rel="tooltip" tip="${attr.key.attrDescribe }">						
												</i>
											</c:if>
											：
											<input type="hidden" name="buyIndex" value="${saleVs.index}">
											 <input	type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrNameCn"
												value="${fn:escapeXml(attr.key.lineAttrName)}" id="${saleVs.index}">
											
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.type"
												value="${fn:escapeXml(attr.key.type)}"> <input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.style"
												value="${fn:escapeXml(attr.key.style)}"> <input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.isneed"
												value="${fn:escapeXml(attr.key.required)}"> <input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.buyAttr"
												value="${fn:escapeXml(attr.key.buyAttr)}"> <input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.saleAttr"
												value="${fn:escapeXml(attr.key.saleAttr)}">
										</div>
										<div class="yanse2">
											<p>
												<c:forEach items="${attr.value}" var="av" varStatus="vars">
													<span title="${fn:escapeXml(av.lineAttrvalName)}"><input type="checkbox"
														name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].lineAttrvalNameCn"
														value="${fn:escapeXml(av.lineAttrvalName)}" id="${vars.index}">${fn:escapeXml(av.lineAttrvalName)}</span>
												</c:forEach>
												
											</p>
											<span class="dpl-tip-inline-warning" style="display: none" >Select at least one</span>
										</div>
									</div>
									<br>
								</c:if>

								<c:if test="${attr.key.saleAttr==1}">
									<!-- 规格属性 -->
									<div class="chim">
										<div class="chim1" title="${fn:escapeXml(attr.key.lineAttrName)}">
											<span>*</span> ${fn:escapeXml(attr.key.lineAttrName)}
											<c:if test="${not empty attr.key.attrDescribe}">
												<i class="J_PopTip poptip-help" rel="tooltip" tip="${attr.key.attrDescribe }">						
												</i>
											</c:if>
											
											：
											<input type="hidden" name="saleIndex" value="${saleVs.index}">
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrNameCn"
												value="${fn:escapeXml(attr.key.lineAttrName)}" id="${saleVs.index}">
											
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.type"
												value="${fn:escapeXml(attr.key.type)}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.style"
												value="${fn:escapeXml(attr.key.style)}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.isneed"
												value="${fn:escapeXml(attr.key.required)}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.buyAttr"
												value="${fn:escapeXml(attr.key.buyAttr)}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.saleAttr"
												value="${fn:escapeXml(attr.key.saleAttr)}">
                                         </div>
											
										<div class="chim2">
											<p>
												<c:forEach items="${attr.value}" var="av" varStatus="vs">
													<span title="${fn:escapeXml(av.lineAttrvalName)}"><input type="checkbox" 
														name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].lineAttrvalNameCn"
														value="${fn:escapeXml(av.lineAttrvalName)}" id="${vs.index}">${fn:escapeXml(av.lineAttrvalName)}</span>
												</c:forEach>
											</p>
											<span class="dpl-tip-inline-warning" style="display: none" >Select at least one</span>
										</div>
									</div>
								</c:if>


							</c:forEach>
							<!-- <div class="z">
								
								<div id ="d">
				
							</div>						
							</div> -->
						</div>
							<div class='gshi'>

							The image format should be “jpg”,”png” or “jpeg”, the size of each photo should be less than 3M bytes,Size is not less 
							than 800 * 800 pixels, the total number of photos should not be less than 3.
							<i class="J_PopTip poptip-help" rel="tooltip" tip="Requirements on picture uploading:<br>
							1. Pixel: picture size: 800*800 pixels, resolution: not lower than 72 pixels/inch, the picture quality shall be clear but not blurred;<br>
							2. Aspect ratio: 1:1;<br>
							3.Size: main goods pictures which are uploaded shall be ≥30K and ≤3M;<br>
							4. Format: main goods pictures which are uploaded shall be in jpg, gif, png and bmp;<br>
							5. Background: white;<br>
							6.Quantity: at least 6 pictures (e.g., the front view, back view <br> and side view of
							outside goods package, edible method or ingredients, detailed picture of inside package and
							detailed picture of inside goods, the pictures shall show goods details at maximum).">						
								</i>
							</div>
						</div>
					</div>
					<div class="blank"></div>
					<!-- 填写基本信息  -->
					<div class="i_box">
						<h2>Product Sales Info</h2>
						<div class="blank5"></div>
						<div class="p_box">
							<div class="blank20"></div>
							<p class="p1">Trading Info：</p>
							<div class="p3">		
								<p class="blank5"></p>
								<p class="t1"><i class="c_red">*</i>Unit of Measurement：</p>
								
								<p class="s_1"><select name="supplierProductPackage.measureid">
									<c:forEach items="${measure}" var="measure">
										<option value="${fn:escapeXml(measure.measureid)}">${fn:escapeXml(measure.name)}</option>
									</c:forEach>
								</select></p>
								<p class="blank5"></p>
								<p class="t1"><i class="c_red">*</i>Unit of Price：</p>
								<p class="s_1"><select  name="supplierProductSaleSetting.moneyUnitId">
									<c:forEach items="${price}" var="price">
										<option value="${price.id}">${fn:escapeXml(price.momeyUnitEn)}</option>
									</c:forEach>
								</select></p>
								
								<p class="blank5"></p>
								<div <c:if test="${supplierType eq 3 }">style="display: none"</c:if> >
									<p class="t1"><i class="c_red">*</i> Type of Price：</p>
									<div class="select-quote" style="margin-left:140px" id="priceTypes">
										<input type="radio" name="priceType" value="0" checked="checked" id="priceType"/>
										<strong>FOB Price</strong>&nbsp;&nbsp;FOB Port Name<input type="text" id="priceType0text" name="fobPort">
										<span id="priceType0warning" class="dpl-tip-inline-warning"></span> 
										<div class="clear"></div>
										<input type="radio"  name="priceType" value="1" id="priceType"/>
										<strong>CIF Price</strong>&nbsp;&nbsp;&nbsp;CIF Port Name <input type="text" id="priceType1text" name="cifPort">
										<span id="priceType1warning" class="dpl-tip-inline-warning"></span> 
										<div class="clear"></div>
										<input type="radio"  name="priceType" value="2" id="priceType"/>
										<strong>EXW Price</strong>
									</div>
									
									<p class="blank5"></p>
									<p class="t1">
									<i class="c_red">*</i> Price：</p>
									<div class="select-quote">
									<input type="radio"  id="pic_count"  name="cost" class="cp1" value="1" checked="checked"/>
									<strong>Quote according to quantity</strong>
									<input type="radio"  id="pic_sku" name="cost" value="2" class="cp2"/>
									<strong>Quote according to specification</strong> </p>
									</div>
								</div>
								<div class="tqz">
									<!--<p class="tq1"><i class="c_red">*</i>价格区间：</p>-->
									
									<div class="tq2" <c:if test="${supplierType eq 3 }">style="display: none"</c:if>>
										<span class="b1"><b></b></span>
										<p class="pp">
										   <span class="b2">Above：<input type="text" name='start' id="startNum"> (Order Quantity)
											<input type="text" name='pic'  >
											<span class="price">price(${fn:escapeXml(price[0].momeyUnitEn)})</span>/<span class="danwei">${fn:escapeXml(measure[0].name)}</span>
											</span>
										</p>
											<span class="dpl-tip-inline-warning" id="inputwarning">
										</span>
										
										<span class="b3">
											<img src="../images/img_+bg.jpg"> Add quantity range
										</span>
									</div>
								<div class="g" style="display: none;">
								<p class="blank"></p>
								<div class="blank10"></div>
								<div class="tab_box">
									<i class="c_red">*</i>
									MOQ：
									<input type='text' id="minNum" name='minNum' class="xiao">
									<table id="tb-speca-quotation"  border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;">
										<colgroup>
					            			<col class="color" >
					                       	<col class="size" >
											<col class="price" >
											<!-- <col class="operate" >		 -->
										</colgroup>
										<thead>
											<tr >
												<th>
													${fn:escapeXml(buyAttrName[1])}
												</th>
												<th>
													${fn:escapeXml(saleAttrName[1])}
												</th>
												<th><span class="c_red"> *</span>Price<br />
													<input id="same_price" type="checkbox">All the Same
												</th>
											</tr>
										</thead>
									    <tbody>
										</tbody>
									    
									</table>
									
								</div>
								<span class="dpl-tip-inline-warning" id="g1"></span>
								<!-- <span class="dpl-tip-inline-warning" id="g2"></span>
								<span class="dpl-tip-inline-warning" id="g3"></span> -->

								<!-- 表格 end -->

								
								
								<p class="blank15"></p>
							</div>
							
						</div>
						
						<%-- <p class="blank15"></p>
						<p class="t1">Supply ability：</p>
						<p class="s_3">
								<input  type="text" name="supplierProductDetail.produceNum" /><span class="danwei">${fn:escapeXml(measure[0].name)}</span>
								<select name="supplierProductDetail.produceType">
										<option value="0" >Day</option>
										<option value="4" >Week</option>
										<option value="1" >Month</option>
										<option value="2" >Year</option>
								</select><br>
									<span class="dpl-tip-inline-warning"></span> 
							</p>
							<p class="blank15"></p>
							<p class="t1">Delivery Date：</p>
							<p class="s_1">
								<input type="text" name="supplierProductDetail.deliverDate"  readonly="readonly" id="delivery" onClick="WdatePicker({minDate:'%y-%M-%d'})">
							</p>
							<p class="blank15"></p>
							<p class="t1">Closing date for collections：</p>
							<p class="s_1">
								<input type="text" name="supplierProductDetail.receiveDate"  readonly="readonly" id="closing" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'delivery\')}',minDate:'%y-%M-%d'})">
							</p>
							<span id="orderDate" class="dpl-tip-inline-warning"></span> 
						<p class="blank15"></p> --%>
						<p class="blank5"></p>
						<div <c:if test="${supplierType eq 3 }">style="display: none"</c:if>>
							<p class="t1">
							<i class="c_red">*</i>Order Type：</p>
							<div class="select-quote">
								<input type="radio" name="supplierProductDetail.orderType"  value="1" checked="checked" onchange="changeOrderType('1')"/>
								<strong>Item in Stock</strong>
								<input type="radio" name="supplierProductDetail.orderType"  value="0" onchange="changeOrderType('2')"/>
								<strong>Collection</strong>
							</div>
						</div>
						
						<div id="collection" style="display:none">
						<p class="blank15"></p>
						<p class="t1"><i class="c_red">*</i>Delivery Date：</p>
						<p class="s_1">
							<input type="text" name="supplierProductDetail.deliverDate" readonly="readonly" id="delivery" onClick="WdatePicker({minDate:'%y-%M-%d'})">
							<span id="deliveryDateWarning" class="dpl-tip-inline-warning"></span>  	
						</p>
							<p class="blank15"></p>
							<p class="t1"><i class="c_red">*</i>Supply Ability：</p>
							<p class="s_3">
									<input id="produceNum" type="text"  name="supplierProductDetail.produceNum"/><span class="danwei">${fn:escapeXml(measure[0].name)}</span>
									<select name="supplierProductDetail.produceType">
											<option value="0">Day</option>
											<option value="4">Week</option>
											<option value="1">Month</option>
											<option value="2">Year</option>
									</select>
									<span id="produceNumWarning" class="dpl-tip-inline-warning"></span> 
									<br>
								<span class="dpl-tip-inline-warning"></span> 
								</p>
																<p class="blank15"></p>
								<p class="t1"><i class="c_red">*</i>Order Closing Date：</p>
								<p class="s_1">
									<input type="text" name="supplierProductDetail.receiveDate" readonly="readonly" id="closing" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'delivery\')}',minDate:'%y-%M-%d'})">
									<span id="closingWarning" class="dpl-tip-inline-warning"></span> 
								</p>
								<p class="blank15"></p>
								<p class="t1"><i class="c_red">*</i>Maximum Quantity：</p>
								<p class="s_1">
									<input type="text" id="maxProdNum" name="supplierProductDetail.maxProdNum">
									<span id="maxProdNumWarning" class="dpl-tip-inline-warning"></span>
								</p>
								
							 
							<p class="blank15"></p>
							
						</div>
						
					</div>
					<div class="blank20"></div>
					<p class="p1">Barcode Info：</p>
					<div class="p3">
						<p class="blank5"></p>

						<div class="tab_box" style="margin-left:60px;"
							id="skuCodeTable">

							<span style="color:red;">Please fill in the barcode,Barcodes should be 8,10,12,13,16 digits</span><br>
							<span ><input type="checkbox"  name="auto"  value="1" >Auto-generate</span>
							<i class="J_PopTip poptip-help" rel="tooltip" 
							tip="Please select the Auto-generate check box if the product has no barcode.<br> 
							The generated barcode will be displayed after the product is saved.">						
								</i>
							 
							<table cellspacing="0" cellpadding="0" border="0"
								style="margin-top:10px;" id="tb-tiaoxingma">
								<colgroup>
									<col class="color">
									<col class="size">
									<col class="price">
								</colgroup>
								<thead>
									<tr>
										<th>${fn:escapeXml(buyAttrName[1])}</th>
										<th>${fn:escapeXml(saleAttrName[1])}</th>
										<th>Barcode<br /></th>
										<th>Barcode Images</th>
										<th>Upload</th>
									</tr>
								</thead>
							</table>
						</div>
						<span class="dpl-tip-inline-warning" style="margin-left: 60px;"></span>
						<!-- 表格 end -->
						<p class="blank15"></p>
					</div>
					<div class="mingxi">
						<div class="m1">Product Details：</div>
						<div class="mm">
							<p class="m2"><span>Packing List：</span>
							<textarea id="packingList"  name="supplierProductDetail.packingList"  ></textarea>
							</p>
							<span class="dpl-tip-inline-warning">Please fill in Packing List</span>
							<p class="m3"><span>After-sales service：</span>
							<textarea id="salesService" name="supplierProductDetail.salesServiceDescription"></textarea>
							</p>
							<span class="dpl-tip-inline-warning" style="display: none"></span>
							
							<p class="m4">
								<span class="s1">After-sales phone：</span>
								<select >
										<option>39</option>
								</select>-
								<input  type="text" name="fristPhone"  placeholder="area"  id="area"/>-
								<input  type="text" name="subPhone" placeholder="number" id="number"/>
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
							<h2>Details( photos and words)
							
							<i class="J_PopTip poptip-help" rel="tooltip" 
							tip="I. Requirements on picture uploading (including but not limited by the following content):<br>
									&nbsp;1. Pixel: picture size: 800*800 pixels, resolution: not lower than 72 pixels/inch,the picture quality shall be clear but not blurred;<br>
									&nbsp;2. Aspect ratio: 1:1;<br>
									&nbsp;3.Size: main goods pictures which are uploaded shall be ≥30K and ≤3M;<br>
									&nbsp;4. Format: main goods pictures which are uploaded shall be in jpg, gif, png and bmp;<br>
									&nbsp;5. Background: unlimited;<br>
									&nbsp;6. Quantity: at least 6 pictures. The pictures shall show goods details and make goods advantages be vivid at maximum, e.g.,
									 detailed picture of original goods (such as the &nbsp; profile of chocolate, bread and cake, which shall make the exquisite and soft characteristics be clear),
									 picture of production line, picture of raw material, etc. Their main &nbsp; functions shall display the color, edible method and main characteristics of the goods, 
									 promote the desire to purchase, enrich and beautify the page, etc.<br>
									
								II.Text which is uploaded is required as follows (including but not limited by the following content):<br>
								&nbsp;1. Goods selling points, such as the detailed introduction of goods production technology, processing flow and goods production section <br>
								&nbsp;or the introduction which makes the difference between the goods and the goods in the same industry be vivid;<br>
								&nbsp;2. Goods introduction;<br>
								&nbsp;3. Usage and edible methods of goods;<br>
								&nbsp;4. Brand introduction and goods slogans (advertising verbal, etc.);<br>
								&nbsp;5. Warm prompts ">						
							</i><br>
								
							</h2>
							
							<!--style给定宽度可以影响编辑器的最终宽度-->
							<div>
							<span class="dpl-tip-inline-warning" id="Details"></span>
							 <script id="editor" type="text/plain" style="width:818px;">
        						<p>Please fill in Details( photos and words)</p>
    						</script>
    						</div>
    						
							
						</div>
						<!-- 填写基本信息  -->

						<div class="blank30"></div>
				</div>
				
				<!-- 边框 end -->
				<div class="blank10"></div>
				<div class="btn_box">
				
						<button class="fabu_btn" id="draftProd" type="button">Save Draft</button>
						<button type="button" id="saveDraftProd" class="fabu_btn" >Submit</button>
				
				<!-- 	<button class="fabu_btn" id="saveProd" type="button">Submit</button> -->
					<p class="clear"></p>
				</div>
			</div>
			<div class="clear"></div>
			<p class="blank30"></p>
		</div>
		 </form>
 </div>
</div>
</div>

<%@include file="/WEB-INF/views/en/include/last.jsp"%>
  </body>
</html>
<script type="text/javascript" src="${path}/js/product/en/editProduct.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/queue.js"></script>
<script type="text/javascript" src="${path}/js/product/swfUploadEventHandler.js"></script>
<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>

<!--引入JS-->
<script type="text/javascript" src=' ${path}/js/ueditor/third-party/webuploader/webuploader.js'></script>
<script type="text/javascript" src="${path}/js/product/en/webuploaderhandler.js"></script>
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
					$("#firstcategory").append("<option value='"+n.id+"'>"+n.nameEn+"</option>");
				});	
		}
		}); 
		inituploader("Qualification Images","00",[]);
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