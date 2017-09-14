<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>商家后台管理系统-商品详情页</title>
<!-- css -->
<link href="${path}/css/zh/base.css" rel="stylesheet" type="text/css">
<link href="${path}/css/zh/pshow.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="w">
	<div class="crumb">
	<c:forEach items="${cateDispList }" var="cateDisp" varStatus="status">
		<c:choose>
			<c:when test="${!status.first}">
				> <a href="${path}/search?categoryId=${cateDisp.cateDispId }">${fn:escapeXml(cateDisp.dispNameCn)}</a>
			</c:when>
			<c:otherwise>
				<strong> <a href="${path}/search?categoryId=${cateDisp.cateDispId }">${fn:escapeXml(cateDisp.dispNameCn)}</a></strong>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	 > ${fn:escapeXml(productDetailVo.productName)}
	 </div>
	<div id="preview">
		<div class="xw-pic"><img id="tt" class="lazy-load1" src="" width="320" height="320" /></div>
		<div class="xw-list">
		<div class="bx_wrap">
<!-- 		<a class="prev" href="">left</a><a class="next" href="">right</a> -->
		<a class="xw-control xw-prev prev"></a> <a class="xw-control xw-next next"></a>
			<div class="xw-items" id="ISL_Cont">
				<ul id="ul1">
<%-- 					<li pic= "1"><img src="<%=path %>/commons/images/p1.jpg"  alt=""></li>  --%>
<%-- 					<li pic= "2"><img src="<%=path %>/commons/images/p2.jpg"  alt=""></li>  --%>
<%-- 					<li pic= "3"><img src="<%=path %>/commons/images/p3.jpg"  alt=""></li>  --%>
<%-- 					<li pic= "4"><img src="<%=path %>/commons/images/p4.jpg"  alt=""></li>  --%>
<%-- 					<li pic= "5"><img src="<%=path %>/commons/images/p5.jpg"  alt=""></li>  --%>
<%-- 					<li pic= "6"><img src="<%=path %>/commons/images/p6.jpg"  alt=""></li>  --%>
					<!-- 遍历map，加载图片url -->
					<c:if test="${not empty buyAttrvals.map}">
<!-- 				 		第一步：遍历map集合 -->
						<c:forEach items="${buyAttrvals.map}" var="m" varStatus="status">
<!-- 							第二步：获取当前map对象的key和value -->
<!-- 								遍历当前map对象中的value（value为一个List集合） -->
							<c:forEach items="${m.value}" var="v">
								
								<li pic= "${fn:escapeXml(v.attrValId)}"><img class="lazy-load1" src="${picStr}${v.imgurl}"   alt=""></li>
							</c:forEach>
						</c:forEach>
					</c:if> 
				</ul>
			</div>
		</div>
		</div>
	</div>
	
	<div class="product-intro">
		<div class="p-name">
		<h1 style="height: 72px;">${fn:escapeXml(productDetailVo.productName)}</h1>
		</div>
		<div class="p-summary">
			<div class="p-batch">
				<c:if test="${not empty dealerProductWholesaleRanges}">
				<dl>
					<dt>起批量（${fn:escapeXml(productDetailVo.measure)}）</dt>
					<dd>价格</dd>
				</dl>
				<!-- 遍历阶梯价位 -->
					<c:forEach items="${dealerProductWholesaleRanges}" var="ProRanges" varStatus="statu">
						<c:choose>
							<c:when test="${statu.last}">
								<dl  data-range="{'begin':'${fn:escapeXml(ProRanges.startQty)}','price':'<fmt:formatNumber value="${fn:escapeXml(ProRanges.discount)}" pattern="#0.00"/>'}">
									<dt>>=${fn:escapeXml(ProRanges.startQty)}</dt>
									<dd><strong>￥<fmt:formatNumber value="${fn:escapeXml(ProRanges.discount)}" pattern="#0.00" /></strong>/${fn:escapeXml(productDetailVo.measure)}</dd>
								</dl>
							</c:when>
							<c:otherwise>
								<dl data-range="{'begin':'${fn:escapeXml(ProRanges.startQty)}','end':'${fn:escapeXml(ProRanges.endQty)}','price':'<fmt:formatNumber value="${fn:escapeXml(ProRanges.discount)}" pattern="#0.00"/>'}">
									<dt>${fn:escapeXml(ProRanges.startQty)}-${fn:escapeXml(ProRanges.endQty)}</dt>
									<dd><strong>￥<fmt:formatNumber value="${fn:escapeXml(ProRanges.discount)}" pattern="#0.00" /></strong>/${fn:escapeXml(productDetailVo.measure)}</dd>
								</dl>
							</c:otherwise>
						</c:choose>
						
					</c:forEach>
				</c:if>
				
			</div>
			<div class="p-market">
				<dl>
					<dt>原产国：</dt>
					<dd>${fn:escapeXml(productDetailVo.originplace)}</dd>
				</dl>
				<dl>
					<dt>建议零售：</dt>
					<dd>￥<fmt:formatNumber value="${fn:escapeXml(productDetailVo.retailPrice)}" pattern="#0.00" />/${fn:escapeXml(productDetailVo.measure)}</dd>
				</dl>
				<dl>
					<dt>发货\物流：</dt>
					<dd>每公斤3.0元，全国统一</dd>
				</dl>
				<dl>
					<dt>期货预付款比率：</dt>
					<dd>${fn:escapeXml(productDetailVo.retaiPrePayPercent)}%</dd>
				</dl>
				
				
				<c:if test="${status==0 }">
					<div style="color:#F00" >该商品缺货,暂无法购买....</div>
				</c:if>
			</div>
		</div>
		<div class="p-shop" style="display: none;">
			<dl class="bot-line">
				<dt>原 产 国：</dt>
				<dd><span class="blue">${fn:escapeXml(productDetailVo.originplace)}</span></dd>
			</dl>
			<dl class="bot-line" id="evaluate">
				<dt>总合评分：</dt>
				<dd><span class="star"><span class="star-white"><span class="star-yellow h4">&nbsp;</span></span></span><font class="red">9.8分</font></dd>
			</dl>
			<dl>
				<dt>原 产 国：</dt>
				<dd>${fn:escapeXml(productDetailVo.originplace)}</dd>
			</dl>
			<dl>
				<dt>商品评分：</dt>
				<dd>10分</dd>
			</dl>
			<dl>
				<dt>服务评分：</dt>
				<dd>10分</dd>
			</dl>
			<dl>
				<dt>时效评分：</dt>
				<dd>10分</dd>
			</dl>
			<dl>
				<dt>公司名称：</dt>
				<dd>意大利化妆品生产</dd>
			</dl>
			<dl class="bot-line">
				<dt>所 在 地：</dt>
				<dd>意大利</dd>
			</dl>
			<div class="enter-shop"><a href="#">进入店铺</a></div>
		</div>
	</div>
	<div class="product-right">
		<div class="p-content">
			<h6>友情提示：请选择 ${fn:escapeXml(buyAttrNameCn)}，及您想要 的<c:if test="${not empty salAttrVos}">
							
								<c:forEach items="${salAttrVos}" var="salAttrVos" begin="0" end="0" varStatus="status">
								
										<span>${fn:escapeXml(salAttrVos.dealerProductAttr.attrNameCn)}</span>	
									
								</c:forEach>
							
							</c:if>采购量，最小起批量为${fn:escapeXml(productDetailVo.minWholesaleQty)}${fn:escapeXml(productDetailVo.measure)}。</h6>
			<div class="p-choose">
				<div class="choose-color">
					<c:if test="${not empty buyAttrvals.dealerProductAttrvals}">
					<ul>
						<c:forEach items="${buyAttrvals.dealerProductAttrvals}" var="buyAttrvals" varStatus="status">
							<c:choose>
										<c:when test="${status.index==0 && buyAttrvals.isProdAttr ==true}">
											<h2>${fn:escapeXml(buyAttrvals.attrNameCn)}:</h2>
											<li><a class="buyAttr" value="${fn:escapeXml(buyAttrvals.prodAttrValId)}" buyIndex="${fn:escapeXml(buyAttrvals.attrValId)}">${fn:escapeXml(buyAttrvals.lineAttrvalNameCn)}<b></b></a></li>
										</c:when>
										
										<c:when test="${status.index==0 && buyAttrvals.isProdAttr ==false}">
											<h2>${fn:escapeXml(buyAttrvals.attrNameCn)}:</h2>
											<li><a class="buyAttr select" value="${fn:escapeXml(buyAttrvals.prodAttrValId)}" buyIndex="${fn:escapeXml(buyAttrvals.attrValId)}">${fn:escapeXml(buyAttrvals.lineAttrvalNameCn)}<b></b></a></li>
										</c:when>
										
										<c:when test="${buyAttrvals.isProdAttr ==false}">
											<li><a class="buyAttr select" value="${fn:escapeXml(buyAttrvals.prodAttrValId)}" buyIndex="${fn:escapeXml(buyAttrvals.attrValId)}">${fn:escapeXml(buyAttrvals.lineAttrvalNameCn)}<b></b></a></li>
										</c:when>
										<c:otherwise>
											<li><a class="buyAttr" value="${fn:escapeXml(buyAttrvals.prodAttrValId)}" buyIndex="${fn:escapeXml(buyAttrvals.attrValId)}">${fn:escapeXml(buyAttrvals.lineAttrvalNameCn)}<b></b></a></li>
										</c:otherwise>
									
									</c:choose>
						</c:forEach>
						</ul>
					</c:if>
					
				</div>
				<div class="choose-sku">
				<ul class="sku-list sku-title">
				<c:if test="${not empty salAttrVos}">
				<c:forEach items="${salAttrVos}" var="salAttrVos" varStatus="status">
					<li class="size">${salAttrVos.dealerProductAttr.attrNameCn}</li>
				</c:forEach>
					
				</c:if>
					<c:if test="${empty isWofe }">
						<li class="price">单价（元）</li>
						
							<li class="spot-stock">现货库存</li>
							<li class="spot-amount">采购量</li>
						
						<li class="futures-stock">期货库存</li>
						<li class="futures-amount">采购量</li>
						<c:if test="${empty dealerProductWholesaleRanges}">
							<li style="width:100px;">建议零售价(元)</li>
						</c:if>
					</c:if>
					<c:if test="${isWofe==1 }">
						<li class="price">单价（元）</li>
						<li class="futures-stock">期货库存</li>
						<li class="futures-amount">采购量</li>
						<c:if test="${empty dealerProductWholesaleRanges}">
							<li style="width:100px;">建议零售价(元)</li>
						</c:if>
					</c:if>
					</ul>
					
					
						<c:if test="${not empty skushowMap}">
							<c:forEach items="${skushowMap}" var="showMap" varStatus="status">
								<c:forEach items="${showMap.value}" var="map" varStatus="statu">
									<ul class="sku-list list" name="${fn:escapeXml(showMap.key)}" skuId = "${fn:escapeXml(map.skuID)}">
										<li class="size">${fn:escapeXml(map.skuvalName )}</li>
										<li class="price"><span class="orange"><fmt:formatNumber value="${fn:escapeXml(map.dealerPrice)}" pattern="#0.00"/></span></li>
										<c:if test="${empty isWofe }">
											<li class="spot-stock">${fn:escapeXml(map.num)}</li>
												<li class="spot-amount">
													<div class="amount-control" id="xh"><a class="amount-down">—</a>
														<input type="text"  value="0" class="amount-input"  name="" maxlength="10">
														<a class="amount-up">+</a></div>
											</li>
										</c:if>
										<li class="futures-stock">${fn:escapeXml(map.num1)}</li>
										<li class="futures-amount">
											<div class="amount-control" id="qh"><a class="amount-down" >—</a>
												<input type="text" value="0" class="amount-input"  name="" maxlength="10">
												<a class="amount-up" >+</a></div>
										</li>
										<!-- 如果无阶梯价格，针对单个sku显示一个建议零售价 -->
										<c:if test="${empty dealerProductWholesaleRanges}">
											<li style="color:red; width:100px;" class="retailPrice"><fmt:formatNumber value="${fn:escapeXml(map.retailPrice)}" pattern="#0.00"/></li>
										</c:if>
									</ul>
									
								</c:forEach>
							</c:forEach>
						</c:if>
					
				</div>
			</div>
			<div class="shop-list" >
				<div class="shop-list-hd">
					<h2>采购清单</h2>
					<span style="display:none;"><a href="#">详单</a></span> </div>
				<div class="shop-list-bd">
					<dl class="fl">
						<dt>现货</dt>
						<c:if test="${not empty buyAttrvals.dealerProductAttrvals}">
						<c:forEach items="${buyAttrvals.dealerProductAttrvals}" var="buyAttrvals" varStatus="status">
							<dd>
								<p class="s-list-color">${fn:escapeXml(buyAttrvals.lineAttrvalNameCn)}</p>
								<p class="s-list-amount" ><span id="xhAttrValId${fn:escapeXml(buyAttrvals.attrValId)}" value="0">0</span>${fn:escapeXml(productDetailVo.measure)}</p>
							</dd>
						</c:forEach>
						</c:if>
					</dl>
					<dl class="fr">
						<dt>期货</dt>
						<c:if test="${not empty buyAttrvals.dealerProductAttrvals}">
						<c:forEach items="${buyAttrvals.dealerProductAttrvals}" var="buyAttrvals" varStatus="status">
							<dd>
								<p class="s-list-color" >${fn:escapeXml(buyAttrvals.lineAttrvalNameCn)}</p>
								<p class="s-list-amount" ><span id="qhAttrValId${fn:escapeXml(buyAttrvals.attrValId)}" value="0">0</span>${fn:escapeXml(productDetailVo.measure)}</p>
							</dd>
						</c:forEach>
						</c:if>
					</dl>
				</div>
				<div class="shop-list-bar">
					<div class="list-total">
						<p class="amount"><span class="value countNum">0</span><span class="unit">${fn:escapeXml(productDetailVo.measure)}</span></p>
						<p class="price"><span class="value">0.00</span><span class="unit">元</span></p>
					</div>
					<div class="order-action">
						<input type="button" name="button2" id="button2" class="order-btn do-purchase"style="<c:if test="${status==0 }">display:none;</c:if>" value="立即订购">
						<input type="button" name="button" id="button" style="display:none;" class="order-btn do-cart" value="加入进货单">
					</div>
				</div>
			</div>
		</div>
		<div class="product-detail">
			<div class="p-detail-hd tab-hd">
				<ul>
					<li class="cur"><a href="javascript:;">商品介绍</a></li>
					<li><a href="javascript:;">规格参数</a></li>
					<li><a href="javascript:;">服务条款</p></li>
				</ul>
			</div>
			<div class="p-detail-bd tab-bd">
				<ul class="detail-list">
					<li title="${fn:escapeXml(productDetailVo.productName)}">商品名称：${fn:escapeXml(productDetailVo.productName)}</li>
						<li title="${fn:escapeXml(productDetailVo.productCode)}">商品编号：${fn:escapeXml(productDetailVo.productCode)}</li>
						<li title="${fn:escapeXml(productDetailVo.subBrandName)}">品牌：${fn:escapeXml(productDetailVo.subBrandName)}</li>
						<li title="<fmt:formatDate value="${productDetailVo.rackTime}" type="date" dateStyle="default"/>">上架时间：<%-- <fmt:parseDate value="${productDetailVo.rackTime} pattern="yyyy/MM/dd"/> --%><fmt:formatDate value="${productDetailVo.rackTime}" type="date" dateStyle="default"/></li>
						<%-- <span title="${productDetailVo.productName}g">商品毛重：${productDetailVo.productName}g</span> --%>
						<li title="${fn:escapeXml(productDetailVo.originplace)}">商品产地：${fn:escapeXml(productDetailVo.originplace)}</li>
				
						
						<c:if test="${not empty attrValsList}">
							<c:forEach items="${attrValsList}" var="attrvals" varStatus="status" >
							
							<li  title="<c:forEach items="${attrvals.dealerProductAttrvals}" var="attval" varStatus="statu"><c:choose><c:when test="${statu.index == 0}">${fn:escapeXml(attval.lineAttrvalNameCn)}</c:when><c:otherwise>,${fn:escapeXml(attval.lineAttrvalNameCn)}</c:otherwise></c:choose></c:forEach>">	
								<c:forEach items="${attrvals.dealerProductAttrvals}" var="attval" varStatus="statu">
									<c:choose>
										<c:when test="${statu.index == 0}">${fn:escapeXml(attval.attrNameCn)}：${fn:escapeXml(attval.lineAttrvalNameCn)}</c:when>
										<c:otherwise>,${fn:escapeXml(attval.lineAttrvalNameCn)}</c:otherwise>
									</c:choose>
								</c:forEach>
							</li>
						</c:forEach>
						</c:if>
					</ul>
			</div>
			<div class="p-detail-bd tab-bd hide">
				<ul class="detail-list">
					<li title="${fn:escapeXml(productDetail.packingList)}">包装清单：${fn:escapeXml(productDetail.packingList)}</li>
					<li title="${fn:escapeXml(productDetail.salesCalls)}">售后电话：${fn:escapeXml(productDetail.salesCalls)}</li>
					<li title="${fn:escapeXml(productDetail.salesServiceDescription)}">售后服务描述：${fn:escapeXml(productDetail.salesServiceDescription)}</li>
					<li title="${fn:escapeXml(productDetail.logisticsDescription)}">物流描述：${fn:escapeXml(productDetail.logisticsDescription)}</li>
				</ul>
			</div>
			
			<div class="p-detail-bd tab-bd hide">
				<!-- demo 开始 -->
				<div class="tab_box2">
					<p class="p1" style="width:900px; height:260px; display: block; font-size:13px; color:#858384;">
						<b style="font-size:14px; color:#4b4b4b;">服务条款：</b><br/>
						三千万保证所售商品均为正品行货，开具机打发票或电子发票，与您亲临商场选购的商品享受相同的质量保证。三千万还为您提供具有竞争力的商品价格和运费政策，请您放心购买！<br/>
						注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！若本商城没有及时更新，请大家谅解！<br/>
						<b style="font-size:14px; color:#FC4D01;">权利声明：</b><br/>
						三千万上的所有商品信息、客户评价、商品咨询、网友讨论等内容，是三千万重要的经营资源，未经许可，禁止非法转载使用。
					</p>
				</div>
			</div>
		</div>
		<div class="p-detail-content">
			<center>
				<c:catch var="catchException">
					<c:import url="${itemDetailImg }" charEncoding="UTF-8" />
				</c:catch>
			</center>
		</div>
	</div>
</div>

<script type="text/javascript">
	
	
	$("img.lazy-load").lazyload({
	    effect : "fadeIn"
	});
	
	
	$(function(){
		
		$("li[pic]").hide();
		$(".sku-list.list").hide();
		//修改后，默认默认显示isProdAttr=false的展示属性值，表示是主图
		var attr_val=$(".select");
		var attr_val_ID = attr_val.attr("buyIndex");
		$("li[pic="+attr_val_ID+"]").show();
		$("ul[name="+attr_val_ID+"]").show();
		
		var  imgicUrl = $("li[pic="+attr_val_ID+"]").first().children("img").attr("src");
		$("#tt").attr("src",imgicUrl);
		
		//绑定属性按钮
		$(".buyAttr").bind("click",function(){
			//修改点击属性后，修改选中效果
			$(".buyAttr.select").attr("class","buyAttr");
			$(this).attr("class","buyAttr select");
			//隐藏图片和属性相关规格
			$("li[pic]").hide();
			$(".sku-list.list").hide();
			//获取当前属性buyIndex
			var dex= $(this).attr("buyIndex");
			//显示图片和规格
			$("li[pic="+dex+"]").show();
			var  imgicUrl = $("li[pic="+dex+"]").first().children("img").attr("src");
			$("#tt").attr("src",imgicUrl);
			$("ul[name="+dex+"]").show();
		});
		//绑定小图片mouseover事件，修改大图src
		$("li[pic]").bind("mouseover",function(){
			//修改大图片src
			$("#tt").attr("src",$(this).children("img").attr("src"));
		});
		
		counttotalnum();
		
		//绑定上下滚动事件
		$(".prev").click(function(){
			$(".xw-items li:last").prependTo($(".xw-items ul"));
		});
		$(".next").click(function(){
			$(".xw-items li:first").appendTo($(".xw-items ul"));
		});
		
		//不允许文本框输入非数字，如果输入的数字大于库存量，自动修改为库存量最大值
		$(".amount-input").bind({
			keyup:
				function(){
					this.value=this.value.replace(/\D/g,'');//只允许输入数字正则表达式
					var numVal = Number($(this).closest("li").prev().text());//库存量
					if(numVal <= Number($(this).val())){
						$(this).val(numVal);
						$(this).next("a").disabled = true;
					}else if(Number($(this).val())<=0){
						$(this).prev("a").disabled = true;
					}else{
						$(this).siblings("a").disabled = false;
					}
					counttotalnum();
				},
			afterpaste:
				function(){
					this.value=this.value.replace(/\D/g,'');
					var numVal =Number( $(this).closest("li").prev().text());
					if(numVal <= Number($(this).val())){
						$(this).val(numVal);
						$(this).next("a").disabled = true;
					}else if(Number($(this).val())<=0){
						$(this).prev("a").disabled = true;
					}else{
						$(this).siblings("a").disabled = false;
					}
					counttotalnum();
				}
		 });
		//加减按钮功能实现
		$(".amount-down,.amount-up").bind({
			click : function(){
				if($(this).attr("class")=="amount-down"){
					$(this).siblings("input").val(Number($(this).siblings("input").val())-1);
				}else{
					$(this).siblings("input").val(Number($(this).siblings("input").val())+1);
				}
				var numVal =Number( $(this).closest("li").prev().text());
				if(numVal <= Number($(this).siblings("input").val())){
					$(this).siblings("input").val(numVal);
					$(this).disabled = true;
				}else if(Number($(this).siblings("input").val())<=0){
					$(this).siblings("input").val(0);
					$(this).disabled = true;
				}else{
					$(this).siblings("a").disabled = false;
				}
				counttotalnum();
			}
		});
		//计算期货现货量
		function counttotalnum(){
			
			var countNum = 0;
			$(".sku-list.list").each(function(){
				var AttrValId = $(this).attr("name");
				var xhNum = $(this).children("li").children("div[id='xh']").children("input").val();
				var qhNum = $(this).children("li").children("div[id='qh']").children("input").val();
				if(xhNum==undefined){
					xhNum = 0;
				}
				
				if(qhNum==undefined){
					qhNum = 0;
				}
				
				countNum += Number(xhNum)+Number(qhNum);
				
				$("#xhAttrValId"+AttrValId).val(Number($("#xhAttrValId"+AttrValId).val())+Number(xhNum));
				$("#qhAttrValId"+AttrValId).val(Number($("#qhAttrValId"+AttrValId).val())+Number(qhNum));
				
				$("#xhAttrValId"+AttrValId).html($("#xhAttrValId"+AttrValId).val());
				$("#qhAttrValId"+AttrValId).html($("#qhAttrValId"+AttrValId).val());
			})
			$(".countNum").html(countNum);
			$(".s-list-amount").children("span").val("");
			
			var pervalue = 0;
			var values = 0;
			
			//计算所属阶梯价格范围
			var datarangelist = $("dl[data-range]");
			if(datarangelist.length >0){
				$.each(datarangelist,function(i,item){		
					var range = eval('(' + $(item).attr("data-range")+ ')');
					if(i == 0){
						pervalue = range.price;
					}
					if(countNum >= Number(range.begin) && (countNum <= Number(range.end) || range.end == undefined)){
						e = i;
						pervalue = range.price;
					}
				});
				
				$.each($(".orange"),function(i,item){
					$(item).text(pervalue);
				});
				//修改订单总价格
				if (!isNaN(parseFloat(pervalue)) ){
					values =countNum* parseFloat(pervalue);
					$("p[class='price']").children("span[class='value']").text(values.toFixed(2));
				}
			}else{
				//无阶梯价位按照规格单价计算
				$(".orange").each( function (){
					var count = 0;
					var $tjis = $( this );
					var pervalue = parseFloat($( this ).text());
					var xhNum = $(this).parent().parent().children("li").children("div[id='xh']").children("input").val();
					var qhNum = $(this).parent().parent().children("li").children("div[id='qh']").children("input").val();
					if(xhNum==undefined){
						xhNum = 0;
					}
					if(qhNum==undefined){
						qhNum = 0;
					}
					count = Number(xhNum)+Number(qhNum);
					if (!isNaN(pervalue)){	
						values += Number(count) *pervalue;
					}
				} )	;
				$("p[class='price']").children("span[class='value']").text(values.toFixed(2));
			}
			
		}
		
			$(".do-purchase").click(function(){
				
				//自定义集合,用于存放所有的sku采购信息
				var itemSkus = new Array(); 
				var cartItemCount  = 0;
				var pid = $("input[name='pid']").val();
				$(".sku-list.list").each(function(i,item){
					//获得sku的id
					//进行非空判断，排除期货和现货采购数量均为0的sku
					if($(this).find("input").first().val()!="0" || $(this).find("input").last().val()!="0"){
						var price = parseFloat($(this).find(".orange").text());
						var futureQty = $(this).find("input").last().val();
						var cashQty = $(this).find("input").first().val();
						<c:if test="${isWofe==1}">
							cashQty = 0;
						</c:if>
						
						
						$("#addCartForm").append("<input type='hidden' name='cartes["+i+"].futureQty' value="+futureQty+" />");
						$("#addCartForm").append("<input type='hidden' name='cartes["+i+"].cashQty' value="+cashQty+" />");
						$("#addCartForm").append("<input type='hidden' name='cartes["+i+"].price' value="+price+" />");
						$("#addCartForm").append("<input type='hidden' name='cartes["+i+"].pid' value="+pid+" />");
						$("#addCartForm").append("<input type='hidden' name='cartes["+i+"].skuid' value="+$(this).attr("skuID")+" />");
						$("#addCartForm").append("<input type='hidden' name='cartes["+i+"].shopCar.productId' value="+pid+" />");
						$("#addCartForm").append("<input type='hidden' name='cartes["+i+"].shopCar.skuid' value="+$(this).attr("skuID")+" />");
						
						//自定义对象，用于存放单个sku的采购信息，包括价钱、期货采购数量和现货采购数量
						var sku = new Object;  
						//获取页面数据，组装sku对象
						sku.skuid = $(this).attr("skuID");  //规格ID
						sku.price = $(this).find(".orange").text();  //价格
						sku.cashQty =  $(this).find("input").first().val();  //现货购买量
						sku.futureQty = $(this).find("input").last().val();  //期货购买量
						//将当前已组装的sku对象放入集合中
						itemSkus[i]=sku;
					}
				});
				
				$.post("<%=path%>/item/checkCartItemCount",
						{PID : pid},
						function(date){
							cartItemCount = date;
							//获取页面当前商品的最大采购量 
							var BigNumber = ${productDetailVo.minWholesaleQty};
							
							//获取当前 采购总数量，判断是否满足最小采购量
							var Number =$(".countNum").text();
							//alert(Number);
							
							//将集合对象转化成json串传递到后台
							var json = JSON.stringify(itemSkus);
							
							//未选择任何sku信息
							if(json=="[]"){
								$("#addCartForm").html("<input  name='pid' type='hidden' value='${productDetailVo.productID}'>");
								alert("请选择购买数量！");
							}else if(parseInt(Number)+parseInt(cartItemCount)<BigNumber){
								$("#addCartForm").html("<input  name='pid' type='hidden' value='${productDetailVo.productID}'>");
								alert("不满足此商品的最小起批量！");
							}else{
								$("#addCartForm").submit();
							}
						},
					 "text");
				
				
			});
		});
	
</script>

</body>
</html>