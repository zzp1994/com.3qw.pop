<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>商家后台管理系统-合同预览</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
	<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/zh/hetong.css"/>
    <script type="text/javascript">
	$(document).ready(function(){
	    var shipVals = ${shipPackVals};
	    var saleVals = ${salePackVals};
		$.each(shipVals,function(n,value) {
			$("input[name='shippingPackage']").each(function (i) {
				if(value==$(this).val()){
					$(this).attr("checked",true);
				}	
			});
       });
       
       $.each(saleVals,function(n,value) {
			$("input[name='salePackage']").each(function (i) {
				if(value==$(this).val()){
					$(this).attr("checked",true);
				}	
			});
       });
	});
    </script>
</head>
<body>


		<form action="${path}/order/printContract" id="print" method="post">
			<input type="hidden" name="content" id="content">
			<input type="hidden" name="orderId" value="${contract.poId}">
		</form>
		<div class="conter1" id="contentVal">
			<div class="table-wrap top1">
				<table cellspacing="0" cellpadding="0" width="100%">
					<tr>
						<th class="top" colspan="2"><h1>进口合同<br>Import Contact</h1></th>
					</tr>
					<tr>
						<td><h2 title="${fn:escapeXml(contract.basContracts.dealerName)}">买方the Buyer ：<span class="h_r">${fn:escapeXml(contract.basContracts.dealerName)}</span></h2></td>
						<td><h2 title="${fn:escapeXml(contract.basContracts.supplierName)}">卖方the seller ：<span class="h_r">${fn:escapeXml(contract.basContracts.supplierName)}</span></h2></td>
					</tr>
					<tr>
						<td><p title="${fn:escapeXml(contract.basContracts.address)}"><span>地址Address ：</span>${fn:escapeXml(contract.basContracts.address)}</p></td>
						<td><p title="${fn:escapeXml(contract.basContracts.supplierName)}"><span>地址Address ：</span>${fn:escapeXml(contract.basContracts.sAddress)}</p></td>
					</tr>
					<tr>
						<td><p><span>电话 Tel ：</span>${fn:escapeXml(contract.basContracts.tel)}</p></td>
						<td><p><span>电话 Tel ：</span>${fn:escapeXml(contract.basContracts.sTel)}</p></td>
					</tr>
					<tr>
						<td><p><span>传真Fax ：</span>${fn:escapeXml(contract.basContracts.fax)}</p></td>
						<td><p><span>传真Fax ：</span>${fn:escapeXml(contract.basContracts.sFax)}</p></td>
					</tr>
					<tr>
						<td><p><span>邮箱Email ：</span>${fn:escapeXml(contract.basContracts.email)}</p></td>
						<td><p><span>邮箱Email :</span>${fn:escapeXml(contract.basContracts.sEmail)}</p></td>
					</tr>
				</table>
			</div>
			<%-- <div class="top">
			    <h1>进口合同<br>Import Contact</h1>
			</div>
			<div class="top1">
				<div class="mmf-mod f_l">
					<h2 title="${fn:escapeXml(contract.basContracts.dealerName)}">买方the Buyer ：<span class="h_r">${fn:escapeXml(contract.basContracts.dealerName)}</span></h2>
					<div class="p1">
						<p title="${fn:escapeXml(contract.basContracts.address)}"><span>地址Address ：</span>${fn:escapeXml(contract.basContracts.address)}</p>
						<p><span>电话 Tel ：</span>${fn:escapeXml(contract.basContracts.tel)}</p>
						<p><span>传真Fax ：</span>${fn:escapeXml(contract.basContracts.fax)}</p>
						<p><span>邮箱Email ：</span>${fn:escapeXml(contract.basContracts.email)}</p>
					</div>
				</div>
				<div class="mmf-mod f_r">
					<h2 title="${fn:escapeXml(contract.basContracts.supplierName)}">卖方the seller ：<span class="h_r">${fn:escapeXml(contract.basContracts.supplierName)}</span></h2>
					<div class="p1">
						<p title="${fn:escapeXml(contract.basContracts.supplierName)}"><span>地址Address ：</span>${fn:escapeXml(contract.basContracts.sAddress)}</p>
						<p><span>电话Tel ：</span>${fn:escapeXml(contract.basContracts.sTel)}</p>
						<p><span>传真Fax ：</span>${fn:escapeXml(contract.basContracts.sFax)}</p>
						<p><span>邮箱Email :</span>${fn:escapeXml(contract.basContracts.sEmail)}</p>
					</div>
				</div>
			</div> --%>

			<div class="he">
                兹经买卖双方同意,由买方购进、卖方出售下列货物,并按下列条款履行本合同：This Contract is made by and between the Buyer and the Seller, whereby the Buyer agrees to buy a
                nd the Seller agrees to sell the under-mentioned goods according to the terms and conditions stipulated below:
			</div>
			

			<div class="he1">
				<h3>1、货物（商品）描述 DESCRIPTION OF GOODS</h3>
				<p>货物描述明细表 List of goods description </p>
				<div class="table-wrap">
				<table cellspacing="0" cellpadding="5" width="100%" border="1" bordercolor="#d0d0d0">
					<tr>
						<td>upc码<br>upc</td>
						<td>货物（商品）名称<br>Name of goods</td>
						<td>规格<br>Specification</td>
						<td>单位<br>Unit</td>
						<td>数量<br>Quantity</td>
						<td>单价<br>Unit Price</td>
						<td>金额<br>Total Amount</td>
					</tr>
					<c:forEach items="${contract.itemlist}" var="orderData">
					<tr>
						<td>${fn:escapeXml(orderData.skuCode)}</td>
						<td>${fn:escapeXml(contract.pName )}</td>
						<td>${fn:escapeXml(orderData.skuNameCn)}/${fn:escapeXml(orderData.skuNameEn)}</td>
						<td>${fn:escapeXml(contract.measureCname)}/${fn:escapeXml(contract.measureEname)}</td>
						<td>${fn:escapeXml(orderData.qty )}</td>
						<td>${fn:escapeXml(contract.moneyUnitSymbols)}<fmt:formatNumber pattern="0.0000#" value="${fn:escapeXml(orderData.price)}"></fmt:formatNumber></td>
						<td>${fn:escapeXml(contract.moneyUnitSymbols)}<fmt:formatNumber pattern="0.0000#" value="${orderData.price*orderData.qty}"></fmt:formatNumber></td>
					</tr>
					</c:forEach>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>总金额：Total Value</td>
						<td>${fn:escapeXml(contract.moneyUnitSymbols)}<fmt:formatNumber pattern="0.0000#" value="${fn:escapeXml(contract.price)}"></fmt:formatNumber></td>
					</tr>
				</table>
				</div>
			</div>
			
			<div class="he2">
				<h3>2、支付条款Payment Terms</h3>
				<p>
			      2.1 买方以下列第  <span class="txt-line">${fn:escapeXml(contract.basContracts.paymentTerms)}</span> 项方式支付在本合同项下的所有款项：<br>
				  2.1 All payment under this Contract to be made by the Buyer be effected in <span class="txt-line">${fn:escapeXml(contract.basContracts.paymentTerms)}</span><br>  
				 （1）全额信用证：100%发运前开出不可撤消的信用证。<br>
				 （1）100% of the total contract value to be paid by an irrevocable letter of credit to be issued before shipment.<br>
				 （2）买方在本合同生效后3个工作日内将合同金额的30%支付给卖方作为预付款，买方在收到第11条约定的单据后7个工作日内开出合同金额70%不可撤销信用证。<br>
				 （2）0% of the Contract Value as down payment to be paid within 3 working days after this Contract being effective, and 70% of the Contract Value to be paid by an irrevocable letter of credit to be issu ed within 7 working days after receipt of documents required by Article 11 hereof.<br>
				 （3）买方在本合同生效后3个工作日内将合同金额的30%支付给卖方作为预付款，买方在收到货物且签署验收证明后7个工作日内向卖方支付合同金额的70%货款。<br>
				 （3）30% of the Contract Value as down payment to be paid within 3 working days after this Contract being effective, and 70% of the Contract Value to be paid within 7 working days after receipt of goo<br>ds and the Acceptance of contract goods signed by the Buyer. <br>
				  2.2 买方采取第（2）或第（3）项方式的，以买方收到相同金额的订单预付款为前提。<br>
				  2.2 The Buyer chooses the (2) or the (3) payment measure on the basis that the Buyer receives the same value of the down payment of orders. 
                </p>
			</div>
			
			<div class="he3">
				<h3>3、生产国别及直接制造（经销、代理）商:<span class="txt-line f-tal">${fn:escapeXml(contract.basContracts.manufacturesCn)}</span><br/>
				3、Country of Origin and Manufactures (Distributors, Agency):<span class="txt-line f-tal">${fn:escapeXml(contract.basContracts.manufacturesEn)}</span>
				
				</h3>
				<h3>4、包装Packing</h3>
				<p>
					除非附件对包装另有特别规定，货物应根据恶劣条件下长途运输和储存的要求作适合空运/海运包装，以确保货物以安全和完好状态运抵目的港。卖方应采取适当的预防和措施以保护货
物不会受湿、受潮、雨淋、生锈、震坏和变形，特别是基于货物的特性需要考虑的其他具体措施，与此相关的全部费用均由卖方单方承担和支付。<br>
Unless otherwise provided for by the Appendix, to be packed by airway/sea packing, suitable for long distance transportation and storage, to ensure that the goods are arrived at the port of destination 
in safe and good conditions.  The Seller shall take appropriate measures to protect the goods against wet, moisture, rain, rust, shock and distortion, especially the measures to be considered and taken 
based on the characteristics of the goods, with all costs and fees relating born and paid by the Seller. 
				</p>
				<h3 style="margin-left:20px;">包装类型选项Packaging Types:</h3>
				<div class="table-wrap he3_l">
						<table cellspacing="0" cellpadding="10" width="100%" border="1" bordercolor="#d0d0d0" align="center">
		<tr valign="middle">
			<td rowspan="2" valign="middle" align="center">货物运输包装<br />
				Cargo Transportation Packing</td>
			<td align="center"><input type="checkbox" name="shippingPackage" disabled="disabled" id="checkbox1" value="1"/></td>
			<td align="left"><label for="checkbox1">单体包装<br />
					Single Packing</label></td>
			<td align="center"><input type="checkbox" name="shippingPackage" disabled="disabled"  id="checkbox2" value="2"/></td>
			<td><label for="checkbox2">集合包装<br />
					Collective Packing</label></td>
			<td align="center"><input type="checkbox" name="shippingPackage" disabled="disabled"  id="checkbox3" value="3"/></td>
			<td><label for="checkbox3">纸包装<br />
					Paper Packing</label></td>
			<td align="center"><input type="checkbox" name="shippingPackage" disabled="disabled"  id="checkbox4" value="4"/></td>
			<td><label for="checkbox4">铁包装<br />
					Iron Packing</label></td>
			<td align="center"><input type="checkbox" name="shippingPackage" disabled="disabled"  id="checkbox5" value="5"/></td>
			<td><label for="checkbox5">木质包装<br />
					Wooden Packing</label></td>
		</tr>
		<tr valign="middle">
			<td align="center"><input type="checkbox" name="shippingPackage" disabled="disabled"  id="checkbox6" value="6"/></td>
			<td><label for="checkbox6">塑料包装<br />
					Plastic Packing</label></td>
			<td align="center"><input type="checkbox" name="shippingPackage" disabled="disabled"  id="checkbox7" value="7"/></td>
			<td><label for="checkbox7">全部包装<br />
					Whole-set Packing</label></td>
			<td colspan="6" align="left">其他 Others：<em class="other-txt">${fn:escapeXml(others[1])}</em></td>
		</tr>
		<tr valign="middle">
			<td rowspan="2" align="center">货物销售包装<br />
				Cargo Sales Packing</td>
			<td align="center"><input type="checkbox" name="salePackage" disabled="disabled"  id="checkbox9" value="1"/></td>
			<td><label for="checkbox9">堆叠式包装<br />
					Stack Packing</label></td>
			<td align="center"><input type="checkbox" name="salePackage" disabled="disabled"  id="checkbox10" value="2"/></td>
			<td><label for="checkbox10">挂式包装<br />
					Hanging Packing</label></td>
			<td align="center"><input type="checkbox" name="salePackage" disabled="disabled"  id="checkbox11" value="3"/></td>
			<td><label for="checkbox11">携带式包装<br />
					Portable Packing</label></td>
			<td align="center"><input type="checkbox" name="salePackage" disabled="disabled"  id="checkbox12" value="4"/></td>
			<td><label for="checkbox12">透明式包装<br />
					Transparent Packing</label></td>
			<td align="center"><input type="checkbox" name="salePackage" disabled="disabled" id="checkbox13" value="5"/></td>
			<td><label for="checkbox13">配套式包装<br />
					A-Set Packing</label></td>
		</tr>
		<tr valign="middle">
			<td align="center"><input type="checkbox" name="salePackage" disabled="disabled" id="checkbox14" value="6"/></td>
			<td><label for="checkbox14">礼品式包装<br />
					Gift Packing</label></td>
			<td colspan="8" align="left">其他 Others：<em class="other-txt">${fn:escapeXml(others[0])}</em></td>
		</tr>
	</table>
				</div>
			</div>
			
			<div class="he4">
				<h3>5、唛头Shipping Mark</h3>
				<p>
					卖方须在每件货物的包装外表上以不褪色的颜料刷明件号、毛重、净重、尺码，“勿近潮湿”“小心轻放”“ 怕压”“液体物品”“防火””此边向上”“堆码极限”“请勿倒置”“
易碎物品”等字迹及下列唛头，具体包装标识由卖方提供，最终由买方确认：
				</p>
				<p>
					The Seller shall mark on each package with fadeless paint about Package Number, Gross Weight, Net Weight, Measurement and the wordings: “KEEP AWAY FROM MOISTURE”“HANDLE WITH C
ARE”“NOT TO BE STOWED UNDER OTHER CARGO” “LIQUID” “THIS SIDE UP””STACK LIMIT” “DO NOT PLACE UPSIDE DOWN” “FRAGILE” and the following shipping mark.  The package labels wil
l be provided by the Seller and confirmed by the Buyer.
				</p>
				<div class="table-wrap">
				<table cellspacing="0" cellpadding="10" width="100%" border="1" bordercolor="#d0d0d0">
					<tr>
						<td>发货人Consigner: </td>
						<td></td>
						<td>收货人Consignee: </td>
						<td></td>
					</tr>
					<tr>
						<td>合同号及其签署日期 Contract No. and Signing Date</td>
						<td></td>
						<td>目的港口/机场Contract No. and Signing Date</td>
						<td></td>
					</tr>
					<tr>
						<td>原产国Country of Origin</td>
						<td></td>
						<td>产品描述Goods Description</td>
						<td></td>
					</tr>
					<tr>
						<td>许可证号License No</td>
						<td></td>
						<td>箱件号Package No</td>
						<td></td>
					</tr>
					<tr>
						<td>毛重/净重Gross/Net Weight</td>
						<td></td>
						<td>尺寸Measurement </td>
						<td></td>
					</tr>
				</table>
				</div>
			</div>
			
			<div class="he5">
				<h3>6、最迟装运期：合同生效后<span class="txt-line">${fn:escapeXml(contract.basContracts.latestDate)}</span>日内 
				 Latest date of Shipment: Within  <span class="txt-line">${fn:escapeXml(contract.basContracts.latestDate)}</span>  days after this Contract being effective. </h3>
				<h3>7、装运港： <span class="txt-line"> ${fn:escapeXml(contract.basContracts.seaPortOfShipmentCn)}</span>  海港/  <span class="txt-line">${fn:escapeXml(contract.basContracts.airPortOfShipmentCn)}</span>  机场 
				Port of Shipment:  <span class="txt-line">${fn:escapeXml(contract.basContracts.seaPortOfShipmentEn)}</span>   Main Seaport/  <span class="txt-line">${fn:escapeXml(contract.basContracts.airPortOfShipmentEn)}</span>  Main Airport </h3>
				<h3>8、目的港/机场：<span class="txt-line"> ${fn:escapeXml(contract.basContracts.portAirportCn)}</span>  Port/Airport of Destination:  <span class="txt-line">${fn:escapeXml(contract.basContracts.portAirportEn)}</span>  </h3>
				<h3>9、保险：由买方（卖方/买方）投保，按照发票金额110%，投保一切险和战争险。Insurance: To be covered by the   (Seller/Buyer), covering 110% of the invoice value for all risks and war risks.</h3>
				<h3>10、成交贸易术语：FOB Trade Terms: FOB</h3>
			</div>
			
			<div class="he6">
				<h3>11、单据Documents:</h3>
				<p>
				11.1 卖方于装运后立即将下列全套单据副本一份航空邮寄买方：<br>
				11.1 The Seller shall, immediately after shipment, send by airmail one copy of the following documents to the Buyer.<br>
				（1）全套清洁、已装船海运提单,注明“运费预付/到付”、空白抬头、空白背书并通知目的港收货人<br>
				（1）Full set of clean on board bills of lading marked “FREIGHT PREPAID/COLLECT” made out to order, blank endorsed notifying the consignees at the port of destination<br>
				（2）发票5份,注明合同号、唛头及合同规定的详细内容<br>
				（2） Invoice in 5 originals indicating contract number and shipping mark, made out in details as per this Contract<br>
				（3）装箱单3份<br>
				（3）Packing List in 3 copies<br>
				（4）品质证、重量证、数量证（由独立机构提供），植物检疫证（由官方提供）一式三份<br>
				（4）Certificate of quality, weight, quantity (issued by independent agency), Phytosantiary Certificate (issued by official authority), in 3 copies<br>
				（5）原产地证明书一式三份<br>
				（5）Certificate of Origin in 3 copies<br>
				（6）由卖方出具的非木质包装证明、有ISPM标记木质包装材料或IPPC热处理标示<br>
				（6） Non-wood packing material certificate or ISPM stamped wood certificate or heat treatment certificate IPPC marks issued by the Seller<br>
				（7）保险单一式2份<br>
				（7）Insurance Policy or Certificate in 2 copies<br>
				（8）其他<br>
				（8）IOthers<br>
				11.2 装船通知: 卖方应于货物装运立即将合同编号、商品名称、数量、发票金额、毛/净重、船名及起运日期等以传真/电邮等通知买方。<br>
				11.2 The Seller shall, immediately upon the completion of the loading of the goods, advise by fax/email the Buyer of Contract No., name of goods, quantity, invoiced
					 value, gross/net weight, name of vessel and date of sailing etc.
				</p>
			</div>
			
			<div class="he7">
				<h3>12、验收：验收在买方收到货物后  30    日内进行。如果试验结果全部符合合同规定的相应要求,买方签署验收证明。Inspection: The Buyer shall inspect the goods within  30  days after receipt of the goods. When the inspection proved to be in conformity with all specifications as stipulated in the Contract, an Acceptan
                           ce of contract goods shall be signed by the Buyer.</h3>
				<h3>13、品质保证Guarantee of Quality:</h3>
				<p>
					卖方保证所提供货物订货是用最上等的材料和头等工艺制成，全新，未曾用过，并完全符合国际标准以及本合同规定的质量、规格、性能等要求。卖方保证本合同货物在用户正确安装、
正常使用和维护下，质保期为买方用户签署合同货物验收证明之日起算，质保期为
<span class="txt-line">${fn:escapeXml(contract.basContracts.qualityDate)}</span>个月。如果由于买方原因货物在以提单日期为凭的交货日后
<span class="txt-line">${fn:escapeXml(contract.basContracts.waitDate)}</span>个月内仍未验收，质保期将不晚于交
货后<span class="txt-line">${fn:escapeXml(contract.basContracts.mixDate)}</span>个月结束
				</p>
				<p>
					The Seller guarantees that the goods hereof is made of according to the best materials with first class workmanship, brand new, unused and complies with international standards and all requires of q
uality, specification and performance stipulated in the Contract. The Seller shall also guarantee that the warranty period of goods is         
<span class="txt-line">(${fn:escapeXml(contract.basContracts.qualityDate)})</span> months, counting from the date of Acceptance of contract 
goods signed by the Buyer, when the goods are correctly mounted and normally used and maintained.  However the warranty period shall expire no later than 
<span class="txt-line">(${fn:escapeXml(contract.basContracts.waitDate)})</span> months after the date of shipment evi
denced by Bill of Lading if the inspection of the goods were postponed   <span class="txt-line">(${fn:escapeXml(contract.basContracts.mixDate)})</span> months because of failure of the buyer.
				</p>
				<h3>14、不可抗力Force Majeure:</h3>
				<p>由于不可抗力发生在制造、装载或运输过程中致使卖方延期交货或不能交货,卖方可免除责任。在不可抗力事件发生后,卖方须立即告知买方及在14天内以空邮向买方提供事故发生地点的
政府授权的商会出具的证明文件。在上述情况下,卖方仍须负责采取必要措施尽快交货。如延期或不能交货超过28天，买方有权解除本合同。</p>
				<p>The Seller shall not be held responsible for the delay-delivery or non-delivery of the goods due to Force Majeure which might occur during the process of manufacturing or in the course of loading or tra
nsit.  The Seller shall advise the Buyer immediately of the occurrence mentioned above and within 14 days thereafter, the Seller shall send by airmail to the Buyer for a certificate of the accident issued 
by the Competent Government Authorities where the accident occurs as evidence thereof. Under such circumstances, the Seller, however, are still under the obligation to take all necessary measures to 
hasten the delivery of the goods.  In case the delay or non-delivery lasts for more than 28 days, the Buyer shall have the right to terminate the Contract.</p>
				<h3>15、违约责任Events of Default:</h3>
				<p>15.1 货物到达到货目的港30天内, 如发现到货的品质、规格或数量与合同不符,买方或零售商有权拒绝接收货物，或者要求卖方更换货物或按照本条约定赔偿损失,所有费用由卖方负
责。</p>
				<p>15.1  Within 30 days after the arrival of the goods at the port of destination, in the event that the quality, specification, or quantity of the goods are found not in conformity this Contract, the Buyer or
 the retailers shall have the right to refuse taking delivery of the goods or request the Seller to change the goods or compensate for loss according to this article, with all costs and fees borne by the Selle
r.</p>
				<p>15.2 如由于卖方的责任不能按合同规定期限交货以及/或迟延交货，除本合同第14条不可抗力原因外,卖方同意付款银行在议付货款时扣除相应违约金，违约金按合同总金额每天1‰计算
如超过合同规定装运期限4周后卖方仍不能交付，买方有权撤销合同，而卖方仍立即付给买方上述违约金。上述违约金不足以支付买方包括预期利益损失的，卖方仍应当继续承担违约责任。
此外,卖方还应当将已经收到的预付款及其按年利率5%计算的利息退还给买方。如果由于买方原因导致发货迟延，则由此发生的仓储费等费用，将由买方承担。</p>
				<p>15.2  Should the Seller fail to make delivery and/or make delivery on time due to the Seller’s responsibility as stipulated in the Contract, with exception of Force Majeure causes specified in Article 
14 of the Contract, the Seller agrees to pay a penalty which shall be deducted by the paying bank from the payment. The rate of penalty is charged at 1‰ of the total contract value for each day. In case
 the Seller fails to make delivery and/or delay delivery four (4) weeks later than the time of shipment stipulated in the Contract, the Buyer shall have the right to terminate the Contract and the Seller, in sp
ite of cancellation, shall still pay the aforesaid penalty to the Buyer without delay.  The Seller shall also return to the Buyer the down payment received from the Buyer plus its interest calculated at 5% p
er year. If the delivery time were postponed because of failure of the Buyer, storage charges and other fees arising from shall be borne by the Buyer.</p>
				<p>15.3 如因货物质量等缺陷或因货物不符合国家法律法规规定造成财产或人身损害的，不论货物是否处于保质期内，卖方均应当承担赔偿责任，包括但不限于买方、零售商、最终用户的
实际和预期利润损失、赔偿款、诉讼费、律师费等。</p>
				<p>15.3  The Seller shall take the compensation liability for any property or personal damage caused by the defective quality of the goods or that the goods are not in conformity with the laws and regu
lations, regardless the warranty of period, including but not limited to actual and expected profit loss, compensation payments, litigation fees, attorney fees of the Buyer, the retailers and the end users.</p>
			</div>
			<h3>16、仲裁 Arbitration:</h3>
			<p>凡因本合同引起的或与本合同有关的一切争执应通过友好协商解决, 如协商不能解决, 则应提交中国国际经济贸易仲裁委员会按照申请仲裁时该会现行有效的仲裁规则（规则）进行仲裁
仲裁决定为终局的,双方均受其约束。仲裁地点北京。仲裁语言为中文</p>
			<p> Any dispute arising from or in connection with this Contract shall be settled by friendly negotiation.  If not settled by negotiation, the dispute(s) shall be sub
mitted to China International Economic and Trade Arbitration Commission（CIETAC）for arbitration which shall be conducted in accordance with CIETAC’s arbitration rul
es in effect at the time of applying for arbitration. The arbitral award is final and binding upon both parties. The place of arbitration shall be Beijing and the lan
guage of arbitration shall be Chinese</p>
			<h3>17、适用法律Governing Law:</h3>
			<p>
			  本合同的订立、效力、解释、履行和争议的解决均适用中华人民共和国法律。 
			  The execution, validity, interpretation, performance and disputes of this Contract shall be governed by the law of the People’s Republic of China.
			</p>
			<h3>18、其他Others：</h3>
			<p>
				18.1 本合同为中英文对照文本，如有不一致，以中文为准。
				<i>买方和卖方均已认真阅读并理解合同条款内容，本合同自买方和卖方点击确认同意即自动生效。</i><br>
				18.1 This Contract is executed in both Chinese and English.  In the event of any discrepancy between Chinese and English versions, the Chinese shall prevail.
				<i> The Buyer and the Seller shall read carefully and understand the terms and conditions of this Contract.  This Contract shall become effective at the time when the Buyer and the Seller press the “Agree” button.</i><br>
				18.2 附件与本合同具有同等法律效力。<br>
				18.2 The Appendixes shall have the same legal force with this Contract.
			</p>
			
			</div>
			<div class="accept">
			<button style="width:200px; height:30px; background:#fa4800;color:#fff;border: none;" 
			id="qiandingBtn" onclick="print()">打印合同</button>
			
			
			<script type="text/javascript">
				function print(){
				var content = $("#contentVal").html();
				  $("#content").val(content);
				  $("#print").target="_blank";
				  $("#print").submit();
				  
				}
			</script>
		</div>
	<%-- <div class="fhui">
		<a href="${path}/order/getOrder">返回</a>
	</div> --%>
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>	
</body>
</html>
