<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/WEB-INF/views/zh/include/base2.jsp"%>

<script type="text/javascript">
	$(document).ready(function(){
			$("#all-b2b-selector").click(function(){
				if ($(this).attr("checked") == "checked") { // 全选 
					$("input[type='checkbox'][name='topProB2B']").each(function() { 
						$(this).attr("checked", true); 
					}); 
				}else{ // 反选 
					$("input[type='checkbox'][name='topProB2B']").each(function() { 
						$(this).attr("checked", false); 
					});
				}
			});
			$("#all-b2c-selector").click(function(){
				if ($(this).attr("checked") == "checked") { // 全选 
					$("input[type='checkbox'][name='topProB2C']").each(function() {
						if($(this).attr("disabled")){
						}else{
							$(this).attr("checked", true);
						}
					});
				}else{ // 反选 
					$("input[type='checkbox'][name='topProB2C']").each(function() {
						if($(this).attr("disabled")){
						}else{
							$(this).attr("checked", false);
						}
					});
				}
			});
	});
</script>


<script type="text/javascript">
/* 删除 */
function prodel(pid){
	if(pid==null&&pid==""){
		alert("选择数据再操作");
		return false;
	}else{
		
		if(window.confirm("确定删除商品!")){
			var pid_array = new Array();
			pid_array.push(pid);
			$.ajax({
				type : "post", 
				url : "deletePros", 
				data:"pid="+pid_array.join(","),
				success : function(msg) { 
					if(msg==1){
						alert("操作成功");
						clickSubmit();
					}else{
						alert("操作失败 ，请稍后再试");
					}
				}
			});

		}

	}
}

//删除dealer
function prodelDealer(pid){
	if(pid==null&&pid==""){
		alert("选择数据再操作");
		return false;
	}else{
		
		if(window.confirm("确定删除商品!")){
			var pid_array = new Array();
			pid_array.push(pid);
			$.ajax({
				type : "post", 
				url : "deleteProsDealer", 
				data:"pid="+pid_array.join(","),
				success : function(msg) { 
					if(msg==1){
						alert("操作成功");
						clickSubmit();
					}else{
						alert("操作失败 ，请稍后再试");
					}
				}
			});

		}

	}
}
</script>


<table id="J_BoughtTable" class="bought-table" data-spm="9"
style="width:100%;">
	<thead>
		<tr class="col-name">
			<c:if test="${pb.parameter.auditStatus == 2 }">
				<th>商品&nbsp;&nbsp;&nbsp;(<i style="color: #f10180;font-size: 13px;">${pb.totalCount }</i>)&nbsp;条</th>
			</c:if>
			<c:if test="${pb2.parameter.auditStatus == 1 }">
				<th>商品&nbsp;&nbsp;&nbsp;(<i style="color: #f10180;font-size: 13px;">${pb2.totalCount }</i>)&nbsp;条</th>
			</c:if>
			<th>价格(元)</th>
			<%-- <c:if test="${supplier==1}">
			<th>现金比例</th>
			</c:if> --%>
			<%-- <c:if test="${supplier!=1}">
			<th>  </th>
			</c:if> --%>
			<c:if test="${pb2.parameter.auditStatus == 1 }">
			<th>库存</th>
			</c:if>
			<th>发布时间</th>
			<th>修改时间</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody class="data">
		<tr class="sep-row">
			<c:forEach items="${pb2.result}" var="pbr" begin="0" end="0">

				<td colspan="6" style="padding:5px 0 5px 0;">

						<div class="operations">
							<c:if test="${! empty pb2.result}">
								<c:if test="${pb2.parameter.auditStatus == 1 }">
									<%--<input class="all-selector gg" id="all-b2b-selector" type="checkbox">--%>
									<%--<label>B2B全选/反选</label>--%>
									<%--<a class="tm-btn" href="javascript:void(0);" onclick="selectProductPutAway(0)" role="button">B2B上架</a>--%>
									<%--<a class="tm-btn" href="javascript:void(0);" onclick="alertProductStopReason('',0)" role="button">B2B下架</a>--%>
									<%--<c:if test="${!empty buttonsMap['POP货品列表-批量下架']  || !empty buttonsMap['POP货品列表-批量上架'] }">--%>
									<input class="all-selector gg" id="all-b2c-selector" type="checkbox">
									<label>商品全选/反选</label>
									<a class="tm-btn" href="javascript:void(0);" onclick="selectProductPutAway(1)" role="button">批量上架</a>
									<a class="tm-btn" href="javascript:void(0);" onclick="alertProductStopReason('',1)" role="button">批量下架</a>
									<%--</c:if>--%>
								</c:if>
<%-- 								<c:if test="${!empty buttonsMap['货品列表-批量下架']  || !empty buttonsMap['货品列表-批量上架'] }">


<%-- 									<c:if test="${(pbr.istate==0&&pbr.counterfeittypeid==2)||pbr.istate==3}">

<%-- 										<input class="all-selector gg" id="all-b2b-selector" type="checkbox"> --%>

<%-- 										<label>B2B全选/反选</label> --%>

<%-- 										<a class="tm-btn" href="javascript:void(0);" onclick="selectProductPutAway()" role="button">B2B上架</a> --%>

<%-- 										<label>B2C全选/反选</label> --%>

<%-- 										<a class="tm-btn" href="javascript:void(0);" onclick="selectProductPutAway()" role="button">B2C上架</a> --%>

<%-- 									</c:if> --%>

<%-- 									<c:if test="${pb.parameter.auditStatus==11}"> --%>

<!-- 										<input class="all-selector gg" id="all-b2b-selector" type="checkbox"> -->
<!-- 										<label>B2B全选/反选</label> -->
<!-- 										<a class="tm-btn" href="javascript:void(0);" onclick="selectProductPutAway(0)" role="button">B2B上架</a> -->
<!-- 										<a class="tm-btn" href="javascript:void(0);" onclick="alertProductStopReason('',0)" role="button">B2B下架</a> -->

<!-- 										<input class="all-selector gg" id="all-b2c-selector" type="checkbox"> -->
<!-- 										<label>B2C全选/反选</label> -->
<!-- 										<a class="tm-btn" href="javascript:void(0);" onclick="selectProductPutAway(1)" role="button">B2C上架</a> -->
<!-- 										<a class="tm-btn" href="javascript:void(0);" onclick="alertProductStopReason('',1)" role="button">B2C下架</a> -->

<%-- 									</c:if> --%>

<%-- 								</c:if> --%>

							</c:if>

						</div>
				</td>

			</c:forEach>

		</tr>
	</tbody>

	<tbody class="data"  id="showListTbody">
	
	<!-- B2B商品 -->
			<c:if test="${pb.parameter.auditStatus == 2 }">
			
			<c:if test="${empty pb.result}">
				<tr>
					<td colspan="6">
						<center><img src="${path }/images/no.png" /></center>
					</td>
				</tr>
			</c:if>
			
				<c:forEach items="${pb.result}" var="pbr">
					<tr class="order-hd" >
						<td  colspan="1">
							<c:if test="${pbr.counterfeittypeid==2}">
								<input class="selector" type="checkbox" id="${pbr.productId}" name="topPro">
							</c:if>
						</td>
						<td colspan="6"><p style="width:166px;" title="${pbr.productId}">商品ID：${pbr.productId}</p>
							<c:if test="${not empty pbr.subBrand}">
							  <p title="${pbr.brand.nameCn}>>${pbr.subBrand.nameCn}" style="width:180px;">商品品牌：${pbr.brand.nameCn}>>${pbr.subBrand.nameCn}</p>
							</c:if> 
							<c:if test="${empty pbr.subBrand}">
							   <p title="${pbr.brand.nameCn}" style="width:180px;">商品品牌：${pbr.brand.nameCn}</p>
							</c:if>
							<c:if test="${pbr.counterfeittypeid == 1}">
								
								<%   
                        		   request.setAttribute("vEnter", "\n");   
								  request.setAttribute("aEnter", "</br>"); 
                      
                   				 %> 
								
								<button type="text" class="sr" onclick="showmsg('${fn:replace(pbr.description, vEnter , aEnter)}')">未通过原因</button>
							
								
							</c:if>
							<c:if test="${pbr.istate==0&&pbr.counterfeittypeid==2}">
							<c:if test="${pbr.stopReason eq '缺货' || pbr.stopReason eq '滞销' || pbr.stopReason eq '汰换' || pbr.stopReason eq '更新商品信息'}">
								
								<strong class="ss">下架原因 : ${fn:escapeXml(pbr.stopReason)}</strong>
							
							</c:if>
							<c:if test="${pbr.stopReason != '缺货' && pbr.stopReason != '滞销' && pbr.stopReason != '汰换' && pbr.stopReason != '更新商品信息'}">
								
								<button type="button" class="sr" onclick="showmsg('${fn:escapeXml(pbr.stopReason)}')">下架原因:其他</button>
							
							</c:if>
							</c:if>
							<c:if test="${pbr.counterfeittypeid==5}">
								<c:if test="${pbr.description eq '缺货' || pbr.description eq '滞销' || pbr.description eq '汰换' || pbr.description eq '更新商品信息'}">
									
									<strong class="ss">违规下架原因 : ${fn:escapeXml(pbr.description)}</strong>
								
								</c:if>
								<c:if test="${pbr.description != '缺货' && pbr.description != '滞销' && pbr.description != '汰换' && pbr.description != '更新商品信息'}">
									
									<button type="button" class="sr" onclick="showmsg('${fn:escapeXml(pbr.description)}')">违规下架原因:其他</button>
								
								</c:if>
							</c:if>
						</td>
					</tr>
					<tr class="order-bd">
						<td class="baobei" colspan="1">
						    <a class="pic J_MakePoint">
						    <c:if test="${pbr.prodType==6}">"幸福购商品"</c:if><img src="${pbr.imgURL}" alt="商品图片"> </a>
							<div class="desc" title="${fn:escapeXml(pbr.productName)}">
								<p class="baobei-name">
									<i> ${fn:escapeXml(pbr.productName)} </i>
								</p>
							</div>
						</td>
						<td>
							<i>
								<span>${pbr.moneyUnitSymbols} 
									<c:choose>
										<c:when test="${pbr.productPriceMin==pbr.productPriceMax}">
											<fmt:formatNumber pattern="0.00#" value="${pbr.productPriceMin}"></fmt:formatNumber>
										</c:when>
										<c:otherwise>
											<fmt:formatNumber pattern="0.00#" value="${pbr.productPriceMin}"></fmt:formatNumber>
											 ~
											 <fmt:formatNumber pattern="0.00#" value="${pbr.productPriceMax}"></fmt:formatNumber>
										</c:otherwise>
									</c:choose>
								</span>
							</i>
						</td>
					
					<%-- 	<td class="trade-status">
						<c:if test="${pbr.counterfeittypeid!=0 && supplier==1} ">
						如已申请现金比例，请<a class="tm-btn" href="javascript:void(0)" onclick="zPro('${path}/product/toEditPOPUI?productId=${pbr.productId}')" target="_blank">设置</a>
						</c:if>
						</td> --%>
						<%-- <c:if test="${pbr.cashRatio ==null}">未设置现金比例，如需设置，请联系客服。</c:if></td>
						<c:if test="${pbr.cashRatio !=null}">${pbr.cashRatio }</c:if></td> --%>
<%-- 						<td><i> ${pbr.futures } </i></td> --%>
						<td class="trade-status">${pbr.strCreatedate }</td>
						<td class="trade-status">${pbr.strCreatedate }</td>
						<c:if test="${pbr.counterfeittypeid==0}">
						<td class="b2"><i> 待审核 </i></td>
						</c:if>
						<c:if test="${pbr.counterfeittypeid==1}">
						<td class="b2"><i> 未通过 </i></td>
						</c:if>
						<c:if test="${pbr.counterfeittypeid==5}">
						<td class="b2"><i>审核驳回 </i></td>
						</c:if>
						<td class="trade-operate">
								<c:if test="${supplierId == pbr.supplierid }">
									<c:choose>
										<c:when test="${pbr.counterfeittypeid==1}">
											<p><a class="tm-btn" href="javascript:void(0);" onclick="zPro('${pageContext.request.contextPath}/product/toEditPOPUI?productId=${pbr.productId}&type=1')">修改</a></p>
											<p><a class="tm-btn" href="javascript:void(0);" onclick="prodel('${pbr.productId}')">删除</a></p>
										</c:when>
										<c:when test="${pbr.counterfeittypeid==5}">
											<p><a class="tm-btn" href="javascript:void(0);" onclick="zPro('${pageContext.request.contextPath}/product/toEditPOPUI?productId=${pbr.productId}&type=1')">修改</a></p>
											<p><a class="tm-btn" href="javascript:void(0);" onclick="prodel('${pbr.productId}')">删除</a></p>
										</c:when>
									</c:choose>
									<p><a class="tm-btn" href="javascript:void(0);" onclick="zPro('${pageContext.request.contextPath}/product/toShowPOPUI?productId=${pbr.productId}')">查看</a></p>
									
							</c:if>
							<c:if test="${supplierId != pbr.supplierid }">
								<p><a class="tm-btn" href="javascript:void(0);" onclick="zPro('showProduct?productId=${pbr.productId}')">查看</a></p>
								<p><a class="tm-btn" href="javascript:void(0);" onclick="editInventory(${pbr.productId}, ${supplierId})">修改库存</a></p>
							</c:if>
							
							</td>
					</tr>
					<tr style="height:10px;"></tr>
				</c:forEach>
			</c:if>
	
		<c:if test="${pb2.parameter.auditStatus == 1 }">
		<c:if test="${empty pb2.result}">
			<tr>
				<td colspan="6">
					<center><img src="${path }/images/no.png" /></center>
				</td>
			</tr>
		</c:if>
		</c:if>
		
		<c:forEach items="${pb2.result}" var="pbr">
		
			<!-- B2C商品 -->
			<c:if test="${pbr.isB2c && pb2.parameter.auditStatus == 1 }">
			
			<tr class="order-hd">
				<td colspan="8">
<%-- 					<p  title=" ${fn:escapeXml(pbr.suppliername)}"> --%>
<%-- 						     供应商 ：${fn:escapeXml(pbr.suppliername)} --%>
<!-- 					</p> -->
					<p>
						<c:if test="${pbr.counterfeittypeid==2}">
							<c:choose>
								<c:when test="${pbr.isNationalAgency==2}">
									<input class="selector" type="checkbox" id="${pbr.productId}" name="topProB2C">
								</c:when>
								<c:otherwise>
									<input class="selector" type="checkbox" disabled="disabled" id="${pbr.productId}" name="topProB2C">
								</c:otherwise>
							</c:choose>
						</c:if>
						商品编码：${fn:escapeXml(pbr.businessProdId)}</p>
					<p>商品ID：${fn:escapeXml(pbr.productId)} </p>
					 
					 
					 <c:if test="${! empty buttonsMap['货品列表-查看审核未通过原因'] }">	
						<c:if test="${ pbr.counterfeittypeid == 1 }">
							<button type="button" class="sr" onclick="showmsg('${fn:escapeXml(pbr.description)}')">未通过原因</button>
						</c:if>
					</c:if>
					
					<c:if test="${! empty buttonsMap['货品列表-查看删除原因'] }">	
						<c:if test="${pbr.istate==2}">
							<button type="button" class="sr" onclick="showmsg('${fn:escapeXml(pbr.description)}')">删除原因</button>
						</c:if>
					</c:if>
					
					<%-- 
					<c:if test="${ pbr.isSupplierUpdate == 1 &&!(pbr.istate==2&&pbr.counterfeittypeid==4)}">
						<a class="sr_left" href="${path}/product/showUpdate?productId=${pbr.productId}" target="_blank">查看修改记录</a>
					</c:if> --%>
					
<%-- 					<c:if test="${! empty buttonsMap['货品列表-查看下架原因'] }">	 --%>
					
						<c:if test="${pbr.istate==0&&pbr.counterfeittypeid==2}">
						
							<c:if test="${pbr.stopReason eq '缺货' || pbr.stopReason eq '滞销' || pbr.stopReason eq '汰换' || pbr.stopReason eq '更新商品信息'}">
								
								<strong class="ss">下架原因 : ${fn:escapeXml(pbr.stopReason)}</strong>
							
							</c:if>
							<c:if test="${pbr.stopReason != '缺货' && pbr.stopReason != '滞销' && pbr.stopReason != '汰换' && pbr.stopReason != '更新商品信息'}">
								
								<button type="button" class="sr" onclick="showmsg('${fn:escapeXml(pbr.stopReason)}')">下架原因:其他</button>
							
							</c:if>
							
						</c:if>
						
<%-- 					</c:if> --%>
					
				</td>
				
			</tr>
			
				<tr class="order-bd">
					<td class="baobei">
						
					
						<a class="pic J_MakePoint" target="_blank" href="http://www.3qianwan.com/item/get/${pbr.productId}">
						<c:if test="${pbr.prodType==6}">"幸福购商品"</c:if>
							<img style="width: 80px;height: 80px;" src="${pbr.b2cImage}" title="${fn:escapeXml(pbr.b2cProductName)}">
						</a>
						<div class="desc">
						 <!-- <p class="bc"><button type="button">B2C</button></p> -->
							<p class="baobei-name">
								<i title="${fn:escapeXml(pbr.b2cProductName)}"> <a target="_blank" href="http://www.3qianwan.com/item/get/${pbr.productId}">${fn:escapeXml(pbr.b2cProductName)}</a> </i>
							</p>
						</div>
					</td>
					<td class="b1">
						<i>
							<span>
								${fn:escapeXml(pbr.b2cMinPrice)} ~ ${fn:escapeXml(pbr.b2cMaxPrice)}
							</span>
						</i>
					</td>
					<%-- <c:if test="${supplier==1 }">
					<td class="trade-status">
					如已申请现金比例，请<a class="tm-btn" href="javascript:void(0)" onclick="zPro('${path}/product/toEditPOPUI?productId=${pbr.productId}')" target="_blank">设置</a>
					</td>
					</c:if> --%>
				<%-- 	<c:if test="${supplier!=1 }">
					<td class="trade-status">
					
					</td>
					</c:if> --%>
 					<td class="b2"> 
						<i> ${fn:escapeXml(pbr.spot)}</i><%--<br> --%>
<%-- 						<c:if test="${! empty buttonsMap['货品列表-补录库存'] }">	 --%>
<%-- 							<c:if test="${pbr.supply==11}"> --%>
<%-- 								<a class="bur" href="${path}/product/getAddInventoryView?productId=${pbr.productId}&supply=${pbr.supply}" target="_blank">补录海外库存</a> --%>
<%-- 							</c:if> --%>
<%-- 							<c:if test="${pbr.supply==12}"> --%>
<%-- 								<a class="bur" href="${path}/product/getAddInventoryView?productId=${pbr.productId}&supply=${pbr.supply}" target="_blank">补录海外库存</a> --%>
<%-- 							</c:if> --%>
<%-- 						</c:if> --%>
					</td> 
	
					<td class="trade-status"><fmt:formatDate value="${pbr.b2cOperateTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td class="trade-status"><fmt:formatDate value="${pbr.b2cCreatedDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					
					<c:if test="${(pbr.b2cIsTate==0||pbr.b2cIsTate==3)}">
							<td class="b2"><i> 已下架 </i></td>
					</c:if>
					<c:if test="${pbr.b2cIsTate==1}">	
						<td class="b2"><i> 已上架 </i></td>
					</c:if>
					<td class="trade-operate">
						<p><a class="tm-btn" href="javascript:void(0)" onclick="zPro('${path}/initPOPShowDealerProduct?productId=${pbr.productId}')">查看</a></p>
						<c:if test="${pbr.b2cIsTate==0 || pbr.b2cIsTate==3}">
							<c:if test="${pbr.isNationalAgency == 2}">
								<a class="tm-btn" href="javascript:void(0)" onclick="proUp('${pbr.productId}','1')">上架</a>
								<p><a class="tm-btn" href="javascript:void(0);" onclick="prodelDealer('${pbr.productId}')">删除</a></p>
							</c:if>
							<a class="tm-btn" href="javascript:void(0)" onclick="zPro('${path}/product/toEditPOPUI?productId=${pbr.productId}')" target="_blank">修改商品</a>
						</c:if>
						<c:if test="${pbr.b2cIsTate==1}">
							<%--<c:if test="${! empty buttonsMap['POP货品列表-下架商品'] }">--%>
								<a class="tm-btn" href="javascript:void(0)" onclick="alertProductStopReason('${pbr.productId}','1')">下架</a>
							<%--</c:if>--%>
						</c:if>
						<a class="tm-btn" href="javascript:void(0);" onclick="editInventory('${pbr.productId}', '${supplierId}')">设置库存</a>
					</td>
				</tr>
			</c:if>
			<tr style="height:10px;"></tr>
		</c:forEach>
	</tbody>
</table>
<c:if test="${!empty pb.result}">
	<%@include file="/WEB-INF/views/zh/include/paging.jsp" %>
</c:if>
<c:if test="${!empty pb2.result}">
	<%@include file="/WEB-INF/views/zh/include/paging2.jsp" %>
</c:if>
