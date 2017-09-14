<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<%@include file="/WEB-INF/views/en/include/base.jsp"%>
    
    <title>Supplier-Print Despatch</title>
    
<style>
.wrap{font:14px/1.14 "simsun";width:1210px;margin:0 auto;padding-top:10px;clear:both;}
.wrap .fhd-hd{height:75px;font-size:24px;}
.wrap td{height:40px;padding:2px 8px;border:1px solid #d0d0d0;}
.wrap label{margin:0 10px;}
.dayin-btn{display:block;width:100px;height:40px;font-size:16px;line-height:40px;text-align:center;margin:80px auto;padding:0;border:0;outline:none;cursor:pointer;background-color:#f40;color:#fff;}
</style>

<script type="text/javascript">
	function print(){
	var content = $("#contentVal").html();
	  $("#content").val(content);
	  $("#print").submit();
	}
</script>
</head>

<body>
<%@include file="/WEB-INF/views/en/include/header.jsp" %>

<form action="${path}/order/printDespatch" id="print" method="post">
	<input type="hidden" name="content" id="content">
	<input type="hidden" name="orderId" value="${contract.poId}">
</form>
<div class="wrap" id="contentVal">
	<table cellspacing="0" cellpadding="0" width="100%" border="1" bordercolor="#d0d0d0">
		<col width="138">
		<col width="168">
		<col width="236">
		<col width="162">
		<col width="102">
		<col width="142">
		<col width="116">
		<col width="146">
		<tr>
			<td colspan="8" align="center" class="fhd-hd">${fn:escapeXml(contract.basContracts.supplierName}公司发货单/Dispatch Bill</td>
		</tr>
		<tr>
			<td>装运时间/Time of Shipment：</td>
			<td></td>
			<td colspan="3">合同编号<br />
				Contract No.：${fn:escapeXml(contract.basContracts.contractNo)}</td>
			<td>发货单号<br/>
				TrackingNo.：</td>
			<td colspan="2">${fn:escapeXml(contract.basContracts.purchaseOrder)}</td>
		</tr>
		<tr>
			<td rowspan="2" align="center">收货信息<br />
				Recipient Information</td>
			<td colspan="4">名称<br />
				Name：${fn:escapeXml(contract.basContracts.dealerName)}</td>
			<td>联系人<br />
				Contact：</td>
			<td colspan="2">${fn:escapeXml(contract.basContracts.dealerName)}</td>
		</tr>
		<tr>
			<td colspan="4">收货地址<br />
				Consignee Add：${fn:escapeXml(contract.basContracts.dealerName)}</td>
			<td>联系电话<br />
				Tel No.：</td>
			<td colspan="2">${fn:escapeXml(contract.basContracts.tel)}</td>
		</tr>
		<tr align="center" valign="middle">
			<td>序 号/No.</td>
			<td>条 码<br />
				Bar Code</td>
			<td>商品（货物）名称<br />
				Name of Goods</td>
			<td>规 格<br />
				Specification</td>
			<td>单 位<br />
				Company</td>
			<td>数 量<br />
				quantity</td>
			<td>单 价<br />
				Unit Price</td>
			<td>金 额<br />
				Amount</td>
		</tr>
		<c:forEach items="${contract.itemlist}" var="orderData">
		<tr>
			<td></td>
			<td></td>
			<td>${fn:escapeXml(contract.pName )}</td>
			<td>${fn:escapeXml(orderData.skuNameCn )}</td>
			<td>${fn:escapeXml(contract.measureid )}</td>
			<td>${fn:escapeXml(orderData.qty )}</td>
			<td>${fn:escapeXml(orderData.skuPrice )}</td>
			<td>${fn:escapeXml(orderData.price )}</td>
		</tr>
		</c:forEach>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td>合计金额：</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>${fn:escapeXml(contract.price)}</td>
		</tr>
		<tr>
			<td colspan="8">合计金额（大写）/Amount    in total()：</td>
		</tr>
		<tr>
			<td>毛 重<br />
				GrossWeight：</td>
			<td></td>
			<td>净 重<br />
				Net Weight：</td>
			<td></td>
			<td colspan="2">运 输 方 式<br />
				Type of Shipping：</td>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td colspan="3">尺码<br />
				Size：</td>
			<td colspan="3">装运：可否分批装运、转运<br />
				Partial Shipment &amp; Transport Allowed</td>
			<td colspan="2"><label>是
					<input type="radio" name="RadioGroup2" value="单选" id="RadioGroup2_0">
				</label>
				<label>否
					<input type="radio" name="RadioGroup2" value="单选" id="RadioGroup2_1">
				</label></td>
		</tr>
		<tr>
			<td colspan="3">运费Fare：
				<label>运费预付Prepay
					<input type="radio" name="RadioGroup1" value="单选" id="RadioGroup1_0">
				</label>
				<label>运费到付Freight Collect
					<input type="radio" name="RadioGroup1" value="单选" id="RadioGroup1_1">
				</label></td>
			<td colspan="5">集装箱号/Container No.：</td>
		</tr>
		<tr>
			<td colspan="8">发货人Consigner：${fn:escapeXml(contract.basContracts.supplierName)}</td>
		</tr>
		<tr>
			<td colspan="8">发货地址Ship Add：${fn:escapeXml(contract.basContracts.sAddress)}</td>
		</tr>
	</table>
	
</div>
<input type="button" class="dayin-btn" onclick="print()" value="Print Dispatch Bill" />
</body>
</html>