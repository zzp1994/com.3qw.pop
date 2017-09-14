<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>


<%@include file="/WEB-INF/views/en/include/base.jsp"%>
<title>Supplier-Edit Draft
</title>
<link rel="stylesheet" href="${path}/css/en/shang.css">
<link href="${path}/css/uploadify.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${path}/js/ueditor/third-party/webuploader/webuploader.css">
<link rel="stylesheet" type="text/css" href="${path}/css/webuploaderframe.css">
</head>
<body>
<%@include file="/WEB-INF/views/en/include/header.jsp"%>
<%@include file="/WEB-INF/views/en/include/leftProduct.jsp"%>
<div class="right f_l">
	<!-- 边框start -->
	<form method="post" id="productAction" enctype="multipart/form-data">
		<input type="hidden" id="language" value="${language}">
		<input type="hidden" id="sessionId" value="${sid}"/> 
		<input type="hidden" id="supplierType" value="${supplierType}" />
		<input type="hidden" name="supplierProduct.prodLineId"	value="${proObj.supplierProduct.prodLineId }"> 
		<input type="hidden" id="cid"	name="supplierProduct.catePubId" value="${proObj.supplierProduct.catePubId}">
		<input type="hidden" id="productId"	name="productId" value="${proObj.productId}">
		<div class="right f_l">
			<div class="c21">
				<div class="title">
					<p>Seller Center&nbsp;>&nbsp;</p>
					<p>Product Management&nbsp;>&nbsp;</p>
					<p class="c1">

									Edit Product
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


								<input type="text" required="required" name="pname" id="productinfo" title="Country of origin + brand name (foreign brand name + Chinese brand name) + product categories (functional groups + modifier + product generic) + product attributes (art.no., color, quantity, size, etc.)"
									value="${fn:escapeXml(proObj.supplierProductBase.productname)}"> 
									<i class="J_PopTip poptip-help" rel="tooltip"
										tip="'+' Represents a half-size spaceProduct name cannot contain 'special for', 'designed for', 'promotion' 'special' 'free shipping,' 'authentic,' 'freebie' and other words that unrelated to the product itselfBrand (need English brand front, Chinese brand in the post, no English brand only fill in Chinese brands, the capital letter or small letter of English brand the  manufacturers registration shall prevail )Please use simplified half-width symbolsUnit shall be the half Angle English g, ml, L, and should not be in ChineseProduct quantity of 1 do not need write: 1 bottle 1 box 1 tank, etcMulti-packaged goods single commodity specification can be multiplied by the number Example: 125g * 2						
									<br> German Aptamil infant formula 1 segment 0 ~ 6 months 800 g * 2.">
									</i><br>
									
									<span class="dpl-tip-inline-warning" id="productMsg">Please fill in Product Title </span>
							</p>
							<div class="blank10"></div>
							<p class="p1">Product Attribute：</p>
							<div class="p3"  id="attrobjs">
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
									<!-- 基本属性属性值 -->
									<div id="attrdiv">
										<c:forEach items="${proObj.supplierProductAttrDTOs}" var="supplierProductAttr" varStatus="vs">
											<c:if test="${supplierProductAttr.supplierProductAttr.saleAttr != 1 && supplierProductAttr.supplierProductAttr.buyAttr != 1 }">
												<p class="p1" title="${fn:escapeXml(supplierProductAttr.supplierProductAttr.attrName)}">
													<c:if test="${supplierProductAttr.supplierProductAttr.isneed == 1}">
														<i class="c_red">*</i>
													</c:if>
													<span>${fn:escapeXml(supplierProductAttr.supplierProductAttr.attrName)}</span>
													<c:if test="${not empty supplierProductAttr.supplierProductAttr.ismeasure }">
														<i class="J_PopTip poptip-help" rel="tooltip" tip="${supplierProductAttr.supplierProductAttr.ismeasure}">						
														</i>
													</c:if>
													
													：
												</p>
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.attrNameCn"
													value="${supplierProductAttr.supplierProductAttr.attrName}">
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.attrId"
													value="${supplierProductAttr.supplierProductAttr.attrId}">
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.type"
													value="${supplierProductAttr.supplierProductAttr.type}">
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.style"
													value="${supplierProductAttr.supplierProductAttr.style}">
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.isneed"
													value="${supplierProductAttr.supplierProductAttr.isneed}">
														
												<c:if test="${supplierProductAttr.supplierProductAttr.type == 1}">
													<div class="i_radio" id="checkboxattr"<c:if test="${supplierProductAttr.supplierProductAttr.isneed == 1}">required="required"
													</c:if>>
															<c:forEach items="${supplierProductAttr.supplierProductAttrvals}"
															var="proAttrVal" varStatus="cbs">
																<span class="r2" title="${fn:escapeXml(proAttrVal.lineAttrvalName)}"><input type="checkbox"
																	name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[${cbs.index}].lineAttrvalNameCn"
																	<c:if test="${proAttrVal.isProdAttr}">checked</c:if> value="${fn:escapeXml(proAttrVal.lineAttrvalName)}"/>
																${fn:escapeXml(proAttrVal.lineAttrvalName)}</span>
														</c:forEach>
														<span class="dpl-tip-inline-warning"></span>
													</div>
												</c:if>
														
														<c:if test="${supplierProductAttr.supplierProductAttr.type ==2}">
															<p class="s_1">
																<select name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn">
																	<c:forEach items="${supplierProductAttr.supplierProductAttrvals}" var="supplierProductAttrval">
																		<option value="${fn:escapeXml(supplierProductAttrval.lineAttrvalName)}" 
																			<c:if test="${supplierProductAttrval.isProdAttr}">selected</c:if>>
																			${fn:escapeXml(supplierProductAttrval.lineAttrvalName )} 
																		</option>
																	</c:forEach>
																</select>
															</p> 
														</c:if>
														
														<c:if test="${supplierProductAttr.supplierProductAttr.type == 3}">
																<p class="t2">
																<c:choose>
																	<c:when test="${supplierProductAttr.supplierProductAttrvals[0].isProdAttr}">
																		<c:choose>
																			<c:when test="${supplierProductAttr.supplierProductAttr.isneed == 1}">
																				<input type="text" required="required"
																				    name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn"
																					value="${fn:escapeXml(supplierProductAttr.supplierProductAttrvals[0].lineAttrvalNameCn)}" />
																					<span class="dpl-tip-inline-warning" >${fn:escapeXml(supplierProductAttr.supplierProductAttr.attrName)}must be 1-100 characters</span>
																			</c:when>
																			<c:otherwise>
																				<input type="text" 
																				    name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn"
																					value="${fn:escapeXml(supplierProductAttr.supplierProductAttrvals[0].lineAttrvalNameCn)}" />
																			</c:otherwise>
																		</c:choose>
																	</c:when>
																	<c:otherwise>
																		<input type="text"
																		    name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn"
																			value="" />
																		
																	</c:otherwise>
																</c:choose>
																<span class="dpl-tip-inline-warning"></span>
																</p>
														</c:if>
														
												<p class="blank10"></p>
												</c:if>
										</c:forEach>
									</div>
									<!-- 基本属性属性值 -->


									<p class="blank10"></p>
									<p class="p1">
										<i class="c_red">*</i> Country of Origin：
									</p>
									<p class="s_1">
										<select required="required" name="supplierProduct.originplace">
											<c:forEach items="${countries}" var="country">
												<option 
												<c:if test="${proObj.supplierProduct.originplace == country.countryid}">selected</c:if>
												value="${fn:escapeXml(country.countryid)}">${fn:escapeXml(country.description)}</option>
											</c:forEach>
										</select>
										<span class="dpl-tip-inline-warning">Please fill in Country of Origin</span>
									</p>
									</p>
									<p class="blank10"></p>
									<p class="p1">
										<i class="c_red">*</i> Manufacturer：
									</p>
									<p class="t2">
										<input required="required"
											name="supplierProduct.manufacturers" type="text"
											value="${fn:escapeXml(proObj.supplierProduct.manufacturers)}"> 
											<span class="dpl-tip-inline-warning">Manufacturer must be 1-100 characters</span>
									</p>
									</p>
									<p class="blank10"></p>
										<p class="p1">Shelf life：</p>
										<p class="t2">
											<input name="supplierProductDetail.sheilLife" type="text"
												id="sheilLife"
												style="width:200px"
												value="${proObj.supplierProductDetail.sheilLife}">
												
												<select name="supplierProductDetail.sheilLifeType">
										<option value="2" <c:if test="${proObj.supplierProductDetail.sheilLifeType==2}">selected</c:if>>Year</option>
										<option value="1" <c:if test="${proObj.supplierProductDetail.sheilLifeType==1}">selected</c:if>>Month</option>
										<option value="0" <c:if test="${proObj.supplierProductDetail.sheilLifeType==0}">selected</c:if>>Day</option>
									</select>
										</p>
									<p class="blank10"></p>
									<p class="blank10"></p>
									<p class="p1">Custom Code：</p>
									<p class="t2">
										<textarea id="customCode"  style="width: 400px; height: 150px;"  name="supplierProductDetail.customCode">${proObj.supplierProductDetail.customCode}</textarea>
									</p>
									<span class="dpl-tip-inline-warning">Custom Code must be 0-50 characters</span>
									<p class="blank10"></p>

									<p class="blank10"></p>
									<p class="p1">Product Remark：</p>
									<p class="t2">
										<textarea id="remark"  style="width: 400px; height: 150px;"  name="supplierProduct.remark">${proObj.supplierProduct.remark}</textarea>
									</p>
									<span class="dpl-tip-inline-warning">Product Remark must be 0-200 characters</span>
									<p class="blank10"></p>
								</div>

								<p class="blank10"></p>
							</div>
						</div> 
						<div class="blank15"></div>
						<%--  <div  class="z" id="zizhi">
								
								<div class='wenzi'>Qualification Images:<input id='00_upload'  name='button'   type='submit'  value='上传资质' />
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
							<p class="blank15"></p>


						<div class="jinben">
							<div class="chanp">
								<p>Product Specification:</p>
							</div>
							
							<div class="p3" >
							<!-- 规格属性 -->
							<c:forEach items="${proObj.supplierProductAttrDTOs }" var="attr" varStatus="saleVs">
								<c:if test="${attr.supplierProductAttr.buyAttr == 1}">
									<!-- 购买属性 -->
									<div class="yanse">
										<div class="yanse1" title="${fn:escapeXml(attr.supplierProductAttr.attrName)}">
											<span>*</span>${fn:escapeXml(attr.supplierProductAttr.attrName)}
											<c:if test="${not empty attr.supplierProductAttr.ismeasure }">
												<i class="J_PopTip poptip-help" rel="tooltip" tip="${attr.supplierProductAttr.ismeasure}">						
												</i>
											</c:if>
											： 
											<input type="hidden" name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrId"  value="${attr.supplierProductAttr.attrId}">
											<input type="hidden" name="buyIndex" value="${saleVs.index}">
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrNameCn"
												value="${attr.supplierProductAttr.attrName}" id="${saleVs.index}">
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.type"
												value="${attr.supplierProductAttr.type}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.style"
												value="${attr.supplierProductAttr.style}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.isneed"
												value="${attr.supplierProductAttr.isneed}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.buyAttr"
												value="${attr.supplierProductAttr.buyAttr}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.saleAttr"
												value="${attr.supplierProductAttr.saleAttr}">
										</div>
										<div class="yanse2">
											<p>
												<c:forEach items="${attr.supplierProductAttrvals}" var="av" varStatus="vars">
													<span  title="${fn:escapeXml(av.lineAttrvalName)}">
													<input type="hidden"
														name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].attrValId"
														value="${av.attrValId}" >
														
														
												<c:choose>
															<c:when test="${proObj.isUpdateSku }">
																<input type="checkbox"
																	name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].lineAttrvalNameCn"
																	value="${fn:escapeXml(av.lineAttrvalName)}" 
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	id="${vars.index}">
															</c:when>
															<c:otherwise>
																<input type="checkbox" disabled="disabled"
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	value="${fn:escapeXml(av.lineAttrvalName)}" 
																	id="${vars.index}">	
																	<c:if test="${av.isProdAttr}">
																		<input type="hidden" name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].lineAttrvalNameCn" value="${fn:escapeXml(av.lineAttrvalName)}" >														
																	</c:if>
															</c:otherwise>
														
														</c:choose>
														
														${fn:escapeXml(av.lineAttrvalName)}</span>
												</c:forEach>
											</p>
												<span class="dpl-tip-inline-warning" style="display: none">Select at least one</span>
										</div>
									</div>
									<br>
								</c:if>

								<c:if test="${attr.supplierProductAttr.saleAttr==1}">
									<!-- 规格属性 -->
									<div class="chim">
										<div class="chim1" title="${attr.supplierProductAttr.attrName}">
											<span>*</span> ${attr.supplierProductAttr.attrName}
											<c:if test="${not empty attr.supplierProductAttr.ismeasure }">
												<i class="J_PopTip poptip-help" rel="tooltip" tip="${attr.supplierProductAttr.ismeasure}">						
												</i>
											</c:if>
											： 
											<input
												type="hidden" name="saleIndex" value="${saleVs.index}">
												<input type="hidden" name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrId"  value="${attr.supplierProductAttr.attrId}">
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrNameCn"
												value="${attr.supplierProductAttr.attrName}" id="${saleVs.index}">
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.type"
												value="${attr.supplierProductAttr.type}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.style"
												value="${attr.supplierProductAttr.style}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.isneed"
												value="${attr.supplierProductAttr.isneed}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.buyAttr"
												value="${attr.supplierProductAttr.buyAttr}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.saleAttr"
												value="${attr.supplierProductAttr.saleAttr}">
										</div>
										<div class="chim2">
											<p>
												<c:forEach items="${attr.supplierProductAttrvals}" var="av" varStatus="vs">
													<span title="${fn:escapeXml(av.lineAttrvalName)}">
													<input type="hidden"
														name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].attrValId"
														value="${fn:escapeXml(av.attrValId)}" >
														
													<c:choose>
															<c:when test="${proObj.isUpdateSku }">
																<input type="checkbox"
																	name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].lineAttrvalNameCn"
																	value="${fn:escapeXml(av.lineAttrvalName)}" 
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	id="${vs.index}">
																
															</c:when>
															<c:otherwise>
																<input type="checkbox" disabled="disabled"
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	value="${fn:escapeXml(av.lineAttrvalName)}" 
																	id="${vs.index}">	
																<c:if test="${av.isProdAttr}">
																	<input type="hidden" name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].lineAttrvalNameCn" value="${fn:escapeXml(av.lineAttrvalName)}" >											
																</c:if>
															</c:otherwise>
														
														</c:choose>
														
														
														${fn:escapeXml(av.lineAttrvalName)}
														</span>
												</c:forEach>
											</p>
												<span class="dpl-tip-inline-warning" style="display: none">Select at least one</span>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<!-- 规格属性 -->
							
							
							<div class="z">
								<div id="d"></div>
							</div>
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
								<p class="t1"><i class="c_red">*</i>Unit of Measurement：</p>
								<input name="supplierProductPackage.packageid" type="hidden" value="${proObj.supplierProductPackage.packageid}"></input>
								<p class="s_1"><select name="supplierProductPackage.measureid">
								<c:forEach items="${measure}" var="measure">
									<option value="${measure.measureid}" <c:if test="${proObj.supplierProductPackage.measureid == measure.measureid}">selected</c:if> >${fn:escapeXml(measure.name)}</option>
								</c:forEach>
								</select>
								</p>
								<p class="blank5"></p>
								<p class="t1"><i class="c_red">*</i>Unit of Price：</p>
								<p class="s_1">
									<select  name="supplierProductSaleSetting.moneyUnitId" id="price">
									<c:forEach items="${price}" var="price">
										<option value="${price.id}" <c:if test="${proObj.supplierProductSaleSetting.moneyUnitId == price.id}">selected</c:if>>${fn:escapeXml(price.momeyUnitEn)}</option>
									</c:forEach>
								    </select>
								</p>
								
								<div <c:if test="${supplierType eq 3 }">style="display: none"</c:if> >
									<p class="blank5"></p>
									<p class="t1"><i class="c_red">*</i> Type of Price：</p>
									<div class="select-quote" style="margin-left:140px" id="priceTypes">
										
										<input type="radio"  name="priceType" value="0" <c:if test="${proObj.supplierProductDetail.priceType==0}">checked</c:if>  id="priceType"/>
										<strong>FOB Price</strong>&nbsp;&nbsp;FOB Port Name<input  id="priceType0text" type="text" name="fobPort" <c:if test="${proObj.supplierProductDetail.priceType==0}">value="${proObj.supplierProductDetail.portName}"</c:if> >
										<span id="priceType0warning" class="dpl-tip-inline-warning"></span> 
										<div class="clear"></div>
										<input type="radio"  name="priceType" value="1" <c:if test="${proObj.supplierProductDetail.priceType==1}">checked</c:if> id="priceType"/>
										<strong>CIF Price</strong>&nbsp;&nbsp;&nbsp;CIF Port Name<input id="priceType1text" type="text" name="cifPort" <c:if test="${proObj.supplierProductDetail.priceType==1}">value="${proObj.supplierProductDetail.portName}"</c:if>>
										<span id="priceType1warning" class="dpl-tip-inline-warning"></span> 
										<div class="clear"></div>
										<input type="radio"  name="priceType" value="2" <c:if test="${proObj.supplierProductDetail.priceType==2}">checked</c:if> id="priceType"/>
										<strong>EXW Price</strong>
									</div>
									<p class="blank5"></p>
									
									<p class="t1">
										<i class="c_red">*</i>Price：
									</p>
									<div class="select-quote">
										<input type="radio" name="cost"   id="pic_count" class="cp1" value="1"/>
										<strong>Quote according to quantity</strong>
										<input type="radio" name="cost" id="pic_sku" value="2" class="cp2" />
										<strong>Quote according to specification</strong>
									</div>

								</div>
								<div class="tqz" <c:if test="${supplierType eq 3 }">style="display: none"</c:if>>
									<div class="tq2" >
										<span class="b1"><b></b></span>
										<p class="pp">
										   <span class="b2">Above：<input type="text" name='start' id="startNum"> (Order Quantity)
											<input type="text" name='pic'>
												<span class="price">price(${fn:escapeXml(proObj.supplierProductSaleSetting.moneyUnitNameEn)})</span>/<span class="danwei">${proObj.supplierProductPackage.measureEname}</span>
											</span>
										</p>
											<span class="dpl-tip-inline-warning" id="inputwarning">
										</span>
										
										<span class="b3">
											<img src="../images/img_+bg.jpg">Add quantity range
										</span>
									</div>
									<div class="g">
										<p class="blank"></p>
										<div class="blank10"></div>
										<div class="tab_box">
											MOQ：<input type='text' id="minNum" name='minNum' value="${fn:escapeXml(proObj.supplierProductSaleSetting.minWholesaleQty )}">
											<table id="tb-speca-quotation" border="0" cellpadding="0"
												cellspacing="0">
												<colgroup>
													<col class="color">
													<col class="size">
													<col class="price">
													<col class="operate">
												</colgroup>
												<thead>
													<tr>
														<th>${fn:escapeXml(buyAttrName[1])}</th>
														<th>${fn:escapeXml(saleAttrName[1])}</th>
														<th>
															<span class="c_red"> 
															*
															</span>Price<br/> 
															<input id="same_price" type="checkbox">All the Same</th>
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
									<p class="blank10"></p>
								</div>					
								<p class="blank15"></p>
<%-- 						<p class="t1">Supply ability：</p>
						<p class="s_3">
								<input  type="text" name="supplierProductDetail.produceNum" value="${proObj.supplierProductDetail.produceNum}"/><span class="danwei">${proObj.supplierProductPackage.measureEname}</span>
								<select name="supplierProductDetail.produceType">
										<option value="0" <c:if test="${proObj.supplierProductDetail.produceType==0}">selected</c:if>>Day</option>
										<option value="4" <c:if test="${proObj.supplierProductDetail.produceType==4}">selected</c:if>>Week</option>
										<option value="1" <c:if test="${proObj.supplierProductDetail.produceType==1}">selected</c:if>>Month</option>
										<option value="2" <c:if test="${proObj.supplierProductDetail.produceType==2}">selected</c:if>>Year</option>
								</select>
							</p>
							<p class="blank15"></p>
							<p class="t1">Delivery Date：</p>
							<p class="s_1">
								<input type="text" name="supplierProductDetail.deliverDate" value="<fmt:formatDate value="${proObj.supplierProductDetail.deliverDate}" pattern="yyyy-MM-dd" />" readonly="readonly" id="delivery" onClick="WdatePicker({minDate:'%y-%M-%d'})">
							</p>
							<p class="blank15"></p>
							<p class="t1">Closing date for collections：</p>
							<p class="s_1">
								<input type="text" name="supplierProductDetail.receiveDate" value="<fmt:formatDate value="${proObj.supplierProductDetail.receiveDate}" pattern="yyyy-MM-dd"/>"
									readonly="readonly" id="closing" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'delivery\')}',minDate:'%y-%M-%d'})">
							</p>
						
						<p class="blank15"></p> --%>
							<div <c:if test="${supplierType eq 3 }">style="display: none"</c:if>>
								    <p class="t1">
									<i class="c_red">*</i> Order Type：</p>
									<div class="select-quote">
									
									<c:choose>
										<c:when test="${proObj.isUpdateSku}">
											<input type="radio" name="supplierProductDetail.orderType" <c:if test="${proObj.supplierProductDetail.orderType==1}">checked</c:if>  value="1"  onchange="changeOrderType('1')"/>
											<strong>Item in Stock</strong>
											<input type="radio" name="supplierProductDetail.orderType" <c:if test="${proObj.supplierProductDetail.orderType==0}">checked</c:if> value="0" onchange="changeOrderType('2')"/>
											<strong>Collection</strong>
										</c:when>
										<c:otherwise>
											<input type="radio" disabled="disabled" name="supplierProductDetail.orderType" <c:if test="${proObj.supplierProductDetail.orderType==1}">checked</c:if>  value="1"  onchange="changeOrderType('1')"/>
											<strong>Item in Stock</strong>
											<input type="radio" disabled="disabled" name="supplierProductDetail.orderType" <c:if test="${proObj.supplierProductDetail.orderType==0}">checked</c:if> value="0" onchange="changeOrderType('2')"/>
											<strong>Collection</strong>
											<input type="hidden" name="supplierProductDetail.orderType" value="${proObj.supplierProductDetail.orderType}">
										</c:otherwise>
									
									</c:choose>
									
									</div>
								</div>
								<div id="collection" style="display:none">
								<p class="blank15"></p>
								<p class="t1"><i class="c_red">*</i>Delivery Date：</p>
								<p class="s_1">
									<input type="text" name="supplierProductDetail.deliverDate" value="<fmt:formatDate value="${proObj.supplierProductDetail.deliverDate}" pattern="yyyy-MM-dd"/>"
											readonly="readonly" id="delivery" onClick="WdatePicker({minDate:'%y-%M-%d'})">
									<span id="deliveryDateWarning" class="dpl-tip-inline-warning"></span>	
								</p>
									<p class="blank15"></p>
									<p class="t1"><i class="c_red">*</i>Supply Ability：</p>
									<p class="s_3">
										<input id="produceNum"  type="text" name="supplierProductDetail.produceNum" value="${proObj.supplierProductDetail.produceNum}"/><span class="danwei">${fn:escapeXml(proObj.supplierProductPackage.measureCname)}</span>
										<select name="supplierProductDetail.produceType" >
												<option value="0" <c:if test="${proObj.supplierProductDetail.produceType==0}">selected</c:if>>Day</option>
												<option value="4" <c:if test="${proObj.supplierProductDetail.produceType==4}">selected</c:if>>Week</option>
												<option value="1" <c:if test="${proObj.supplierProductDetail.produceType==1}">selected</c:if>>Month</option>
												<option value="2" <c:if test="${proObj.supplierProductDetail.produceType==2}">selected</c:if>>Year</option>
										</select>
											<span id="produceNumWarning" class="dpl-tip-inline-warning"></span> 
											<br>
									</p>
																		<p class="blank15"></p>
										<p class="t1"><i class="c_red">*</i>Order Closing Date：</p>
										<p class="s_1">
										<input type="text" name="supplierProductDetail.receiveDate" 
											readonly="readonly" id="closing" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'delivery\')}',minDate:'%y-%M-%d'})"
											value="<fmt:formatDate value="${proObj.supplierProductDetail.receiveDate}" pattern="yyyy-MM-dd"/>"
											>
												<span id="closingWarning" class="dpl-tip-inline-warning"></span> 
											
									</p>
									<span id="orderDate" class="dpl-tip-inline-warning"></span> 
										<p class="blank15"></p>
										<p class="t1"><i class="c_red">*</i>Maximum Quantity：</p>
										<p class="s_1">
											<input  id="maxProdNum" type="text" name="supplierProductDetail.maxProdNum" value="${proObj.supplierProductDetail.maxProdNum}" <c:if test="${!proObj.isUpdateSku}">readonly="readonly"</c:if>>
										<span id="maxProdNumWarning" class="dpl-tip-inline-warning"></span>
										</p>
									<p class="blank15"></p>		
								</div>
							</div>
							<div class="blank20"></div>
							<p class="p1">Barcode Info：</p>
							<div class="p3">							
								<p class="blank5"></p>
								<div class="tab_box" style="margin-left:60px;" id="skuCodeTable">
					
									<span style="color:red;">Please fill in the barcode,Barcodes should be 8,12,13,16 digits</span><br>
									<c:if test="${proObj.isUpdateSku }">
										<span ><input type="checkbox"  name="auto"  value="1" >Auto-generate</span>
											<i class="J_PopTip poptip-help" rel="tooltip" 
											tip="Please select the Auto-generate check box if the product has no barcode.<br> 
											The generated barcode will be displayed after the product is saved.">						
											</i>
									</c:if>
									<table cellspacing="0" cellpadding="0" border="0" style="margin-top:10px;" id="tb-tiaoxingma">
										<colgroup>
					            			<col class="color">
					                       	<col class="size">
											<col class="price">
											<!-- <col class="operate">	 -->	
										</colgroup>
										<thead>
											<tr >
												<th>${fn:escapeXml(buyAttrName[1])}</th>
												<th>${fn:escapeXml(saleAttrName[1])}</th>
												<th><span class="c_red"> *</span>Barcode<br /></th>
												<th><span class="c_red"> *</span>Barcode Images</th>
												<th>Upload</th>
												
											</tr>
										</thead>
									    <tbody>
										</tbody>
									    
									</table>
									
								</div>
								<span class="dpl-tip-inline-warning" style="margin-left: 60px;"></span>
								<!-- 表格 end -->

								
								
							
							<p class="blank15"></p>
					
						
					</div>
							<div class="mingxi">
								<div class="m1">Product Details：</div>
								<div class="mm">
									<p class="m2">
										<span>Packing List：</span>
										<textarea id="packingList" name="supplierProductDetail.packingList">${fn:escapeXml(proObj.supplierProductDetail.packingList )}</textarea>
									</p>
									<span class="dpl-tip-inline-warning">Please fill in Packing List</span>
									<p class="m3">
										<span>After-sales service：</span>
										<textarea id="salesService"  name="supplierProductDetail.salesServiceDescription">${fn:escapeXml(proObj.supplierProductDetail.salesServiceDescription)}</textarea>
									</p>
									<span class="dpl-tip-inline-warning"></span>
									<p class="m4">
										<span  class="s1">After-sales phone：</span>
										
											
											<select >
													<option>39</option>
											</select>-
											<input  type="text" name="fristPhone"  id="area" value="${fn:escapeXml(phoneNumber[1])}"/>-
											<input  type="text" name="subPhone" id="number" value="${fn:escapeXml(phoneNumber[2])}"/>
									</p>
									<span class="dpl-tip-inline-warning" id="mobiletext" style="margin-right:100px;"></span>
									
								</div>
							</div>
						</div>


						<!-- 文本编辑框 -->

						<div class="blank30"></div>
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
									 detailed picture of original goods (such as the   profile of chocolate, bread and cake, which shall make the exquisite and soft characteristics be clear),
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
							<div class="blank20"></div>
							<input type="hidden" name="supplierProductAttachs[0].productattachid" value="${proObj.supplierProductAttachs[0].productattachid}">
							<input type="hidden" name="supplierProductAttachs[0].fileurl" value="${proObj.supplierProductAttachs[0].fileurl}">
							<!--style给定宽度可以影响编辑器的最终宽度-->
							<div>
							<span class="dpl-tip-inline-warning" id="Details"></span>
								<script id="editor" type="text/plain">
									${attch}
    							</script>
							</div>
							</div>
						<!-- 文本编辑框结束 -->
						<div class="blank"></div>
						<!-- 填写基本信息  -->

						<div class="blank30"></div>
					</div>
					<!-- 内容 end -->
				</div>
				<!-- 边框 end -->
				<div class="blank10"></div>
				<div class="btn_box">
				
				
				<button class="fabu_btn" id="editDraft" type="button">Save Draft</button>
				<button type="button" id="saveProd" class="fabu_btn" >Submit</button>
				
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
<div class="clear"></div>
<div class="blank10"></div>

<!-- 底部 start -->
<%@include file="/WEB-INF/views/en/include/last.jsp"%>
</body>
</html>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/queue.js"></script>
<script type="text/javascript" src="${path}/js/product/swfUploadEventHandler.js"></script>
<script type="text/javascript" src="${path}/js/product/en/editProduct.js"></script>
<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>

<!--引入JS-->
<script type="text/javascript" src=' ${path}/js/ueditor/third-party/webuploader/webuploader.js'></script>
<script type="text/javascript" src="${path}/js/product/en/webuploaderhandler.js"></script>


<script type="text/javascript">

	//实例化编辑器
 	//var ue = UE.getEditor('editor');
 	
		//实例化编辑器
	 var ue = new UE.ui.Editor();
   	ue.render("editor");
	
	$(document).ready(function(){
		var url_array = ${jsonImg};
		$.each(url_array,function(n,value){
			//adduploadimg(value[1],value[2],value[3]); 
			addupload(value[1],value[2],value[3]); 
		});
		
		var qualification =  ${qualificationUrl};
	    inituploader("Qualification Images","00",qualification);
		
		var sku_array= ${skuPriceAndCount};
		
		var price = $("#price").find("option:selected").text();
		var measure = $("#measure").find("option:selected").text();
		
 	 	$.each(sku_array,function(keys,values){
 	 	
 	 			var statu = values.type;
 	 			   if(statu=='0'){
 	 			  
 	 			   changebox();
 	 			  $("#pic_count").attr("checked","checked");
 	 			  $('.pp').empty();
 	 			  $.each(values.start,function(key,value){
 	 			  
 	 			  	var startLength = values.start.length;
 	 			  	if(key==startLength-1&&key!=0){
 	 					$('.pp').append( "<span class='b2'>Above：<input type='text' name='start' value='"+value+"'> (Order Quantity) <input name='pic' type='text'  value='"+values.pic[key]+"'><span class='price'>price("+price+")</span>/<span class='danwei'>"+measure+"</span><span class='del'>Delete</span></span>" );
 	 			 	}else{
 	 			 		$('.pp').append( "<span class='b2'>Above：<input type='text' name='start' value='"+value+"'> (Order Quantity) <input name='pic' type='text'  value='"+values.pic[key]+"'><span class='price'>price("+price+")</span>/<span class='danwei'>"+measure+"</span></span>" );
 	 			 	}
 	 			 	var length = $(".pp .b2").length;
						if (length>=3){
							$(".b3").hide();
						}
						
						$(".g").hide();
				
 	 			  });
 
 	 				}else{
 	 			 	var pku = values.pic;
 	 			 	
 	 			 	$("#pic_sku").attr("checked","checked");
 	 			 	$(".g").show();
 	 			 	$(".tq2").hide();
 	 				var pku_array = new Array();
 	 				$.each(pku,function(key,value){
 	 					pku_array.push(value);
 	 					var new_array = new Array();
 	 					new_array.push(pku_array);
 	 					changebox();
 	 					_fShowTableInfo(pku,"tb-speca-quotation"); 
 	 				});
 	 			 }; 
 	 		});
 	 		
 	 		var skuCode = ${skusCode};
 	 		
 	 		var skuCode_array = new Array();
			$.each(skuCode,function(key,value){
				skuCode_array.push(value);
				var new_array = new Array();
				new_array.push(skuCode_array);
				_fShowTableInfo(skuCode,"tb-tiaoxingma"); 
			});
			
			
			
			
		var cid = $("#cid").val();
		var brandId='${proObj.brand.id}';
		$.ajax({
			 type : "post", 
         	 url : "../product/getBrands",
         	 data:"cid="+cid,
         	 dataType:"json", 
          	 success : function(msg) {
          	 	var firstcategory="";
          	 	if(msg!=''){
					$.each(eval(msg),function(i,n){
						if(brandId==n.id){
							firstcategory += "<option selected='selected' value='"+n.id+"'>"+n.nameEn+"</option>";
						}else{
							firstcategory += "<option value='"+n.id+"'>"+n.nameEn+"</option>";
						}
					});	
					$("#firstcategory").append(firstcategory);
						var subBrandId = $("subBrandId").val();
						$.ajax({
							type : "post",
							url : "../product/getOtherBrand",
							data : "brandId="+ brandId,
							success : function(msg) {
								if(msg.length>2){
									var fistBrandlist = "";
									$.each(eval(msg),function(i,n) {
											if('${proObj.subBrand.id}'!=''){
												if(n.id=='${proObj.subBrand.id}'){
													fistBrandlist += "<option selected='selected' value='"+ n.id+ "'>"+ n.nameEn + "</option>";
												}
											}else{
												fistBrandlist += "<option value='"+ n.id+ "'>"+ n.nameEn + "</option>";
											}
									});
									$("#secondcategory").append(fistBrandlist).show();
								} else{
									$("#secondcategory").hide();
								}
							}
						});
				}
		}
		}); 
	 		
	});  
	
	var orderType=$('input:radio[name="supplierProductDetail.orderType"]:checked').val();
	if(orderType==0){
		$("#collection").css('display','block'); 
	}
	function changeOrderType(type) {
		if (type == 2) {
			$("#collection").show();			
		}else{
			$("#collection").hide();			
		}
	};

</script>
