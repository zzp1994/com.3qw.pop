$(document).ready(function(){
	$("#skuId").live('click',showSku);
	$("#addProduct").live('click',addProduct);
	$("#currencyType").live('change',currencyTypeChange);
	$("#addWareHouse").live('click',addWareHouse);
	$("#con").hide();
	$(".ov").delegate('input[name="skuPriceTax"]','change',calculate);
	$(".ov").delegate('select[name="dutyRate"]','change',dutyRateChange);
	$(".ov").delegate('input[name="qty"]','change',qtyChange);
	$("#deleteTr").live('click',deleteTr);
	$("#deleteTrKC").live('click',deleteTrKC);	
	$("[name='servicePeople']").live("blur",checktext );
	$("[name='receiveAddress']").live("blur",checkAddresstext );
	$("#contractNumber").live("blur",checkAllText);
//	$(".ov").delegate('input[name="telephone"]','blur',checktel);
	$(".ov").delegate('input[name="contact"]','blur',checkContact);
	$(".inputnot input").attr("disabled",true);
	$("[name='remark']").live("blur",checkRemarkText);
	
	
});

var  CONTEXTPATH  = $("#baseUrl").val();
//选择供应商后初次加载此供应商下所有商品
function showSku(event){
	if(event == 1){
		var that = $(this);
		return that;
	}else{
//		var supplierId = $("#supplierId").val();
		
		$.ajax({
			type : "post", 
			url : CONTEXTPATH+"/store/toModelPage", 
//			data:{"supplierId":supplierId},
			dataType:"html",
			success : function(msg) { 
				$("#skubox").html(msg);
				$("#skuDiv").show();
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("对不起，数据异常请稍后再试!");
			}
		});
//		if(supplierId != ""){
//			
//		}else{
//			alert("请先选择供应商!!");
//		} 
	}	
}

//根据商品名称查询商品列表
function searchSku(){
	var skuName = $.trim($("#productName").val());
	var skuArray = new Array();
	
		var supplierId = $("#supplierId").val();
		if(supplierId != ""){
			skuArray.push("supplierId="+supplierId);
			skuArray.push("skuName="+skuName);
			$.ajax({
				type : "post", 
				url : CONTEXTPATH+"/pchaseOrder/findskuList", 
				data:skuArray.join("&"),
				dataType:"html",
				success : function(msg) { 
					$("#skubox").html(msg);
					$("#skuDiv").show();
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert("对不起，数据异常请稍后再试!");
				}
			});
		}else{
			alert("请先选择供应商!!");
		} 
	}	
//选择商品赋值到文本框中去
function loadSku(){
	var sku = $('input[name="productRadio"]:checked');
	var falg = true;
	if(sku.length>0){
		var length = $("#productTab").find(".append").length;
		$("#productTab").find(".append").each(function(i,item){
			if(length==i+1){
				var skuCode = sku.attr("skuCode");
				var skuNameCn = sku.attr("skuNameCn");
				var prodName = sku.attr("prodName");
				var skuId = sku.val();
				var businessProdId = sku.attr("businessProdId");
				var unit = sku.attr("measure");
				
				$("input[name='skuId']").each(function(i,item){
					if($(item).val() == skuId){
						falg = false;
						alert("此明细已经存在,请重新选择!");
					}
				});
				if(falg){
					//这一行实际是商品编码
					$(item).find("td").find("input[name='skuId']").val(skuId).attr("readonly",true);
					$(item).find("td").find("#skuId").val(businessProdId);
					if(businessProdId!=''){
						
						$(item).find("td").find("#businessProdid").val(businessProdId);
					}else{
						
						$(item).find("td").find("#businessProdid").val("");
					}
					
					$(item).find("td").find("#barCode").val(skuCode).attr("readonly",true);
					$(item).find("td").find("#pName").val(prodName).attr("readonly",true);
					$(item).find("td").find("#format").val(skuNameCn).attr("readonly",true);
					$(item).find("td").find("#unit").val(unit).attr("readonly",false);
					$("#skuDiv").hide();
					$(item).find("td").find("#skuId").attr("disabled",true);
				}else{
					showSku();
				}
				
			}
		});	
		
		
	}else{
		alert("请先选择商品信息!");
	}
}



//初始化加载所有服务商
function showService(){
	$.ajax({
		type : "post", 
		url : CONTEXTPATH+"/pchaseOrder/findServiceList", 
		dataType:"html",
		success : function(msg) { 
			$("#servicebox").html(msg);
			$("#serviceDiv").show();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("对不起，数据异常请稍后再试!");
		}
	}); 
}


//条件检索服务商
function selService(){
	var pro_array  = new Array();
	if($("#serName").val()!=""&&$("#serName").val()!=undefined)
	{
		pro_array.push("serviceName="+$("#serName").val());
	}
	$.ajax({
		type : "post", 
		url : CONTEXTPATH+"/pchaseOrder/findServiceList", 
		dataType:"html",
		data:pro_array.join("&"),
		success : function(msg) { 
			$("#servicebox").html(msg);
			$("#serviceDiv").show();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("对不起，数据异常请稍后再试!");
		}
	}); 
}


//选择服务商之后赋值到文本框中
function loadPurchasePage(){
	var service=$('input[name="serviceSupply"]:checked');
	if(service.length>0){
	var serviceCode = service.attr("serviceCode");
	var serviceName = service.attr("serviceName");
	var serviceContact = service.attr("serviceContact");
	var servicePhone = service.attr("servicePhone");
	$("#serviceName").val(serviceName);
	$("#serviceCode").val(serviceCode);
	$("#servicePeople").val(serviceContact);
	$("#serviceTel").val(servicePhone);
	$("#serviceDiv").hide();
	}else{
		alert("请选择服务商");
	}
}


//初始化加载所有供应商
function showSupplier(){
	var supplyType = $("#supplyType").val();
	if (null == supplyType) {
		supplyType = "1";
	}
	$.ajax({
		type : "post", 
		url : CONTEXTPATH+"/pchaseOrder/findSupplierListByNameAndType", 
		dataType:"html",
		data:{"supplyType":supplyType},
		success : function(msg) { 
			$("#supplierBox").html(msg);
			$("#supplyDiv").show();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("对不起，数据异常请稍后再试!");
		}
	});
}


//根据条件加载供应商
function showSupplierByName(){
	
	var supplyType = $("#supplyType").val();
	if (null == supplyType) {
		supplyType = "1";
	}
	var supplierName = $.trim($("#suppilerName1").val());
	$.ajax({
		type : "post", 
		url : CONTEXTPATH+"/pchaseOrder/findSupplierListByNameAndType", 
		dataType:"html",
		data:{"supplierName":supplierName, "supplyType":supplyType},
		success : function(msg) { 
			$("#supplierBox").html(msg);
			$("#supplyDiv").show();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("对不起，数据异常请稍后再试!");
		}
	}); 
}


//选中供应商复制文本框
function loadSupplier(){
	var checked = $('input[name="service"]:checked');
	if(checked.length>0){
		var contact = checked.attr("contact");
		var phone = checked.attr("phone");
		var supplierId = checked.attr("supplierId");
		var name = checked.val();
		$("#paymentDays").val("");
		$("#qxz").attr("selected",'selected');
		$("#supplierName").val(name);
		$("#supplierId").val(supplierId);
		$("#supplierBy").val(contact);
		$("#supplierPhone").val(phone);
		$("#supplyDiv").hide();
	}else{
		alert("请务必勾选供应商!");
	}
}


//初始化加载所有仓库列表
function showWareHouse(){
	$.ajax({
		type : "post", 
		url : CONTEXTPATH+"/pchaseOrder/findwareHouseList", 
		dataType:"html",
		success : function(msg) { 
			$("#wareHousebox").html(msg);
			$("#wareHouseDiv").show();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("对不起，数据异常请稍后再试!");
		}
	}); 
}


//根据条件查询所有仓库
function wareHouseByWareHouseName(){
	var wareHouseName = $.trim($("#WareHouseName").val());
	$.ajax({
		type : "post", 
		url : CONTEXTPATH+"/pchaseOrder/findwareHouseList", 
		dataType:"html",
		data:{"warehouseName":wareHouseName},
		success : function(msg) { 
			$("#wareHousebox").html(msg);
			$("#wareHouseDiv").show();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("对不起，数据异常请稍后再试!");
		}
	}); 
}


//赋值到选中值到文本框中去
function loadWareHouse(){
	var wareHouse = $('input[name="wareHouse"]:checked');
	var flag= true;
	if(wareHouse.length>0){
		var length = $("#wareHouseTab").find(".appendWareHouse").length;
		$("#wareHouseTab").find(".appendWareHouse").each(function(i,item){
			if(length==i+1){
				
				var warehouseName = wareHouse.attr("warehouseName");
				var address = wareHouse.attr("address");
				var contact = wareHouse.attr("contact");
				var telephone = wareHouse.attr("telephone");
				var wareHouseCode = wareHouse.attr("warehouseCode");
				

				$("input[name='wareHouseName']").each(function(i,item){
					if($(item).val() == warehouseName){
						flag = false;
						alert("此仓库已经存在,请重新选择!");
					}
				});
				if(flag){
				$(item).find("td").find("input[name='wareHouseName']").val(warehouseName);
				$(item).find("td").find("input[name='address']").val(address);
				$(item).find("td").find("input[name='contact']").val(contact);
				$(item).find("td").find("input[name='telephone']").val(telephone);
				$(item).find("td").find("input[name='wareHouseCode']").val(wareHouseCode);
				$("#wareHouseDiv").hide();
				}
			}
		});	
	}else{
		alert("请务必勾选仓库!");
	}
}


function addWareHouse(){
//	var t01  =$("#wareHouseTab tr").length;
	var t01;
	if($("#wareHouseTab tr:last").find("td:eq(0)").text()=='')
	{
		t01=1;
	}else{
		t01 = parseInt($("#wareHouseTab tr:last").find("td:eq(0)").text())+1;
	}

	var tr = "<tr class='appendWareHouse'>" 
		+"<td nowrap='nowrap'>"+t01+"</td>"
		+"<td><input type='checkbox' class='checkbox1'></td>"
		+"<td><input type='text' name='wareHouseName' onclick='showWareHouse()' readonly='readonly'></td>"
		+"<td><input type='text' name='address' readonly='readonly'></td>"
		+"<td><input type='text' name='contact' readonly='readonly'></td>"
		+"<td><input type='text' name='telephone' readonly='readonly'></td>"
		+"<td width='0px'><input type='hidden' name='wareHouseCode'></td>"
		+"</tr>";
	var length = $("#wareHouseTab").find(".appendWareHouse").length;
	$("#wareHouseTab").find(".appendWareHouse").each(function(i,item){
		if(length==i+1){
			var val = $(item).find("td").find("input[name='wareHouseName']").val();
			if(val != ""){
				$("#wareHouseTab").append(tr);
			}else{
				alert("先完善数据在添加下一个明细!");
			}
		}
	});	
}


//条件查询商品的信息
function selSku(){
	productName = $.trim($("#productName").val());
	$.ajax({
		type : "post", 
		url : CONTEXTPATH+"/pchaseOrder/findwareHouseList", 
		dataType:"html",
		data:{"productName":productName},
		success : function(msg) { 
			$("#skubox").html(msg);
			$("#skuDiv").show();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("对不起，数据异常请稍后再试!");
		}
	}); 
}



//点击添加出现的商品显示框
function addProduct(){
//	var t01  =$("#productTab tr").length;
	var t01;
	if($("#productTab tr:last").find("td:eq(0)").text()=='')
	{
		t01=1;
	}else{
		t01 = parseInt($("#productTab tr:last").find("td:eq(0)").text())+1;
	}

	var tr ="<tr class='append'>"
		+"<td nowrap='nowrap'>"+t01+"</td>"
		+"<td><input type='checkbox' class='checkbox sm' ></td>"
		+"<td><input type='text' id='skuId' onclick='showSku()' style='width:130px;'><input type='hidden' name='skuId'><input type='hidden' id='businessProdid' name='businessProdid'></td>"
		+"<td><input type='text' id='barCode' name='barCode' style='width:140px;'></td>"
		+"<td><input type='text' id='pName' name='pName' style='width:130px;'></td>"
		+"<td><input type='text' id='format' name='format'></td>"

		+"<td><input type='text' id='unit' name='unit'></td>"
		+"<td><input type='text' id='qty' name='qty'></td>"
		+"<td><input type='checkbox'   id='isGive' name='isGive' class='checkbox sm' style='width:110px;'></td>"
		
		+"<td><input type='text' id='skuPriceTax' name='skuPriceTax'  onchange='calculate()' style='text-align: right; width:70px;'></td>"
		+"<td><select id='dutyRate' name='dutyRate'></select><input type='hidden' name='dutyCode'  id='dutyCode' value='dutyCode'></td>"
		+"<td><input type='text' id='skuPrice' name='skuPrice' readonly='readonly' style='text-align: right; width:80px;'></td>"

		+"<td><input type='text' id='subtotalPrice' name='subtotalPrice' readonly='readonly' style='text-align: right; width:100px;'></td>"
		+"<td><input type='text' id='totalPrice' name='totalPrice1' readonly='readonly' style='text-align: right'></td>"
		+"<td><input type='text' id='currencyType' name='currencyType1' readonly='readonly'></td>"
		+"<td><input type='text' id='exchangeRate' name='exchangeRate1' readonly='readonly'></td>"
		+"<td><input type='text' id='localPrice' name='localPrice' readonly='readonly' style='text-align: right; width:80px;'></td>"

		+"<td><input type='text' id='totalLocalPrice' name='totalLocalPrice' readonly='readonly' style='text-align: right; width:80px;'></td>"
		+"<td><input type='text' id='localNuTaxPrice' name='localNuTaxPrice' readonly='readonly' style='width:105px;'></td>"
		+"<td><input type='text' id='totalLocalNuTaxPrice' name='totalLocalNuTaxPrice' readonly='readonly' style='text-align: right; width:105px;'></td>"
		
	+"</tr>";
	
	var length = $("#productTab").find(".append").length;
	$("#productTab").find(".append").each(function(i,item){
		if(length==i+1){
			var val = $(item).find("td").find("input[name='skuId']").val();
			
			if(val != ""){
				$("#productTab").append(tr);
				var dutyRate = $(item).next().find("td").find("select[name='dutyRate']");
				var purchaseType =$("#purchaseType").val();
				var exchangeRate =$("#exchangeRate").val();
				var  currencyType= $("#currencyType").val();
				if(2==purchaseType&&exchangeRate!=undefined){
					$(item).next().find("td").find("input[name='exchangeRate1']").val(exchangeRate);
					$(item).next().find("td").find("input[name='currencyType1']").val(currencyType);
				}else{
					$(item).next().find("td").find("input[name='exchangeRate1']").val(1);
					$(item).next().find("td").find("input[name='currencyType1']").val("RMB");
				}
				
				var exchangeRate1 = $(item).next().find("td").find("input[name='exchangeRate1']");
				findTaxList(dutyRate);
			}else{
				alert("先完善数据在添加下一个明细!");
			}
			
		}
		
	});	
	var aCheck=$(':checkbox[name=isGive]');
	for(var i=0;i<aCheck.length;i++){
		aCheck[i].onclick=function(){
			if(this.checked==false){
				var oInp=this.parentNode.parentNode.children[9].children[0];
				oInp.value='';
				console.log(oInp);
			}
		};
	}
}



function currencyTypeChange(){
	var Rate=$("input[name='exchangeredio']:checked").val();
	var currencyType= $("#currencyType").val();
	$("input[name='currencyType1']").val(currencyType);
	if(Rate=="2"){
		var exchangeRate = $("#currencyType option:selected").attr("exchangeRate");
		$("#exchangeRate").val(exchangeRate);
		$("input[name='exchangeRate1']").val(exchangeRate);
	}else {
		$("#exchangeRate").val("");
	}
	$("#productTab").find(".append").each(function(i,item){
		if($(item).find("input[name='qty']").val()=="" || $(item).find("input[name='skuPriceTax']").val()==""){
			return;
		}else{
			//数量
			var qty = $(item).find("input[name='qty']").val();
			//单价
			var skuPriceTax = $(item).find("input[name='skuPriceTax']").val();
			//税率
			var dutyRate = $(item).find("select[name='dutyRate'] option:selected").val()/100;
			//不含税单价
			var skuPrice = skuPriceTax/(1+dutyRate);
			//不含税总金额
			var totalPrice = Number(skuPrice) * Number(qty);
			//含税总金额
			var totalPrice1 = Number(skuPriceTax) * Number(qty);
			//汇率
			var exchangeRate1 = $(item).find("input[name='exchangeRate1']").val();
			//本币单价
			var localPrice = Number(skuPriceTax) * Number(exchangeRate1);
			//本币总金额
			var totalLocalPrice = Number(totalPrice1) * Number(exchangeRate1);
			//本币不含税单价
			var localNuTaxPrice = Number(skuPrice) * Number(exchangeRate1);
			//本币不含税金额（不含税总金额×汇率）
			var totalLocalNuTaxPrice =  Number(totalPrice) * Number(exchangeRate1);
			$(item).find("input[name='skuPrice']").val(Number(skuPrice).toFixed(4));
			$(item).find("input[name='localPrice']").val(localPrice.toFixed(4));
			$(item).find("input[name='subtotalPrice']").val(totalPrice.toFixed(4));
			$(item).find("input[name='totalPrice1']").val(totalPrice1.toFixed(4));
			$(item).find("input[name='totalLocalPrice']").val(totalLocalPrice.toFixed(4));
			$(item).find("input[name='localNuTaxPrice']").val(localNuTaxPrice.toFixed(4));
			$(item).find("input[name='totalLocalNuTaxPrice']").val(totalLocalNuTaxPrice.toFixed(4));
			var itemTotalPrice =0;
			$("input[name='totalPrice1']").each(function(i,item){
				itemTotalPrice = Number(itemTotalPrice) + Number($(item).val());
			});
			$("input[name='itemTotalPrice']").val(itemTotalPrice);
			$("#itemTotalPrice").val(itemTotalPrice);
		}
	});
	
	
	
}



//function updateOrder(){
//	var data = $('#purchaseSumit').serialize();	
//	var falg = true;
//	if($("select[name='emergency'] option:selected").val() == ""){
//		alert("请选择紧急程度!");
//		falg = false;
//		return;
//	}
//	if($("select[name='purchaseEntity'] option:selected").val() == ""){
//		alert("请选择采购公司!");
//		falg = false;
//		return false;
//	}
//	if($("select[name='purchaseType'] option:selected").val() == ""){
//		alert("请选择采购订单类型!");
//		falg = false;
//		return false;
//	}else if($("select[name='purchaseType']").val() == "2"){
//		if($("select[name='payment'] option:selected").val() == ""){
//			alert("请选择付款方式!");
//			falg = false;
//			return false;
//		}
//		if($("select[name='article'] option:selected").val() == ""){
//			alert("请选择成交条款!");
//			falg = false;
//			return false;
//		}
//		if($("select[name='currencyType'] option:selected").val() == ""){
//			alert("请选择币别!");
//			falg = false;
//			return false;
//		}
//	}
//	if($("select[name='shipper'] option:selected").val() == ""){
//		alert("请选择承运方!");
//		falg = false;
//		return false;
//	}
//	if(falg){
//		$.ajax({
//			type : "post", 
//			url  : CONTEXTPATH+"/pchaseOrder/updateOrder", 
//			data :data+"&random="+Math.random(),
//			success : function(msg) {
//				alert(msg);
//			},
//			error: function(jqXHR, textStatus, errorThrown){
//				alert("保存失败 ，请稍后再试。。");
//			}
//		});
//	}
//}
function gosumitPurchase(operationType){
	var data = $('#purchaseSumit').serialize();	
	var falg = true;
//	if($("input[name='sendate']").val()==""){
//		
//		alert("请填写送达日期!");
//		falg = false;
//		return;
//	}
	if($("select[name='emergency'] option:selected").val() == ""){
		alert("请选择紧急程度!");
		falg = false;
		return;
	}
	if($("#productType").val()==""){
		
		alert("请选择采购商品类型!");
		falg = false;
		return;
		
	}
	
	if($("input[name='contractNumber']").val() == ""){
		alert("请填写采购合同号!");
		falg = false;
		return false;
	}
	if($("select[name='purchaseEntity'] option:selected").val() == ""){
		alert("请选择采购公司!");
		falg = false;
		return false;
	}
	if($("select[name='purchaseType'] option:selected").val() == ""){
		alert("请选择采购订单类型!");
		falg = false;
		return false;
	}else if($("select[name='purchaseType']").val() == "2"){
		if($("select[name='payment'] option:selected").val() == ""){
			alert("请选择付款方式!");
			falg = false;
			return false;
		}
		if($("select[name='article'] option:selected").val() == ""){
			alert("请选择成交条款!");
			falg = false;
			return false;
		}
		
		if($("select[name='currencyType'] option:selected").val() == ""){
			alert("请选择币别!");
			falg = false;
			return false;
		}
		if($("#exchangeRate").val()==""){
			alert("请通过选择填入汇率");
			flag=false;
			return false;
		}
	}
	if($("input[name='supplierName']").val()==''){
		
		alert("请选择供应商");
		flag=false;
		return false;
	}
	if($("select[name='paymentFunction']").val()==""){
		
		alert("请选择账期计算方法");
		flag=false;
		return false;
	}
	
		
	if($("select[name='shipper'] option:selected").val() == ""){
		alert("请选择承运方!");
		falg = false;
		return false;
	}
	
	
	if($("select[name='shipper'] option:selected").val()=='002'){
		if($("select[name='shipperType'] option:selected").val() == ""){
		
		alert("请选择承运方式!");
		falg = false;
		return false;
		
		}
		if($("#serviceName").val()==''){
			
			alert("请选择服务商!");
			falg = false;
			return false;
			
		}
	}
	
	//采购明细商品校验
	$("#productTab").find(".append").each(function(){
			//数量
			var qty = $(this).find("input[name='qty']").val();
			//单价
			var skuPriceTax = $(this).find("input[name='skuPriceTax']").val();
			//税率
			var dutyRate = $(this).find("select[name='dutyRate']").val();
			//商品ID
			var skuId = $(this).find("input[name='skuId']").val();
			
			if(skuId==""){
				alert("请先完善商品信息!");
				falg = false;
				return false;
			}
			if(qty==""){
				alert("采购明细商品数量!");
				falg = false;
				return false;
			}
			if(skuPriceTax==""){
				alert("采购明细商品单价(含税)!");
				falg = false;
				return false;
			}
			if(dutyRate==""){
				alert("请先选择税率");
				falg = false;
				return false;
			}
			
	});
	
	//服务商的校验
	
	var shipperCode = $(("select[name='shipper'] option:selected")).val();
	if(shipperCode=="002"){
		var serviceName= $("input[name='serviceName']").val();
		if(serviceName==''){
			
			alert("承运方是本公司情况下，请选择服务商");
			falg = false;
			return false;
		}
	}
	if($.trim($("#receiveAddress").val()).length==0){
		alert("请填写接货地址");
		falg = false;
		return false;
	}
	//仓库信息校验
	$("#wareHouseTab").find(".appendWareHouse").each(function(){
			//仓库名称
			var wareHouseName = $(this).find("input[name='wareHouseName']").val();
			if(wareHouseName==""){
				alert("仓库名称不能为空!");
				falg = false;
				return false;
			}
	});
	
	
	if(operationType=='save'){
		var flagId  = getPurchaseId();
	if(falg){
		if(flagId){		
			setTimeout(submitOrder, 3000);
		}
	}
	}
	if(operationType=="update"){
		
		if(falg){
			
			updateOrder("update");
			
		}
	}
	if(operationType=="check"){
		
		if(falg){
			
			updateOrder("check");
		}
	}
	
}


function submitOrder() {
	var chkTrue = "";
	$("input[type='checkbox'][name='isGive']").each(function() {
		if (this.checked) {
			chkTrue = chkTrue + "1,";
		} else {
			chkTrue = chkTrue + "0,";
		}
	});

	chkTrue = chkTrue.substring(0, chkTrue.length - 1);
	if (chkTrue != "") {
		$("#chkTrue").val(chkTrue);
	}
	
	var data = $('#purchaseSumit').serialize();	
	$.ajax({
		type : "post", 
		url  : CONTEXTPATH+"/pchaseOrder/goAddpurchaseorder", 
		data :data+"&random="+Math.random(),
		success : function(msg) {
//			alert(msg);
//			window.location.href
			tipMessage(msg,function(){
			window.location.href="../pchaseOrder/getPurchaseOrder";
	   		 });
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("保存失败 ，请稍后再试。。");
		}
	});
	
}

function updateOrder(type){
	var chkTrue = "";
	$("input[type='checkbox'][name='isGive']").each(function() {
		if (this.checked) {
			chkTrue = chkTrue + "1,";
		} else {
			chkTrue = chkTrue + "0,";
		}
	});

	chkTrue = chkTrue.substring(0, chkTrue.length - 1);
	if (chkTrue != "") {
		$("#chkTrue").val(chkTrue);
	}
	var data = $('#purchaseSumit').serialize();
	$.ajax({
		type : "post", 
		url  : CONTEXTPATH+"/pchaseOrder/updateOrder", 
		data :data+"&random="+Math.random()+"&zhao="+type,
		success : function(msg) {
			tipMessage(msg,function(){
				window.location.href="../pchaseOrder/getPurchaseOrder";
		   		 });
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("保存失败 ，请稍后再试。。");
		}
	});
	
}
function checkOrder(){
	var data = $('#purchaseSumit').serialize();
	$.ajax({
		type : "post", 
		url  : CONTEXTPATH+"/pchaseOrder/updateOrder", 
		data :data+"&random="+Math.random(),
		success : function(msg) {
			tipMessage(msg,function(){
				window.location.href="../pchaseOrder/getPurchaseOrder";
		   		 });
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("保存失败 ，请稍后再试。。");
		}
	});
	
}






function findTaxList(obj) {
	$.ajax({
		 type : "post", 
    	 url : "../pchaseOrder/findTaxList", 
    	 dataType:"json",
        success : function(taxList){
        	if($("#purchaseType").val()=='2')
        	{
        		obj.append("<option value='0' dutyCode='0' selected='selected'>无税率</option>"); 
        		obj.addClass('foreign');
        	}else{
        		$.each(taxList,function(i,n){
            		if(i==0){
            			obj.append("<option value='' dutyCode='0'>请选择</option>"); 
            			obj.append("<option value='"+n.tax+"' dutyCode='"+n.code+"'>"+n.tax+"</option>"); 
            		}
            		if(i!=0){
            			obj.append("<option value='"+n.tax+"' dutyCode='"+n.code+"'>"+n.tax+"</option>"); 
            		}
    			});
        	}
        	
		},
		 error: function(jqXHR, textStatus, errorThrown){
	        alert("查询失败 ，请稍后再试。。");
	     }
	});
}

//查询税率列表
function findTax() {
	var taxjsonArray;
	$.ajax({
		 type : "post", 
    	 url : "../pchaseOrder/findTaxList",
    	 async:false, 
    	 dataType:"json",
        success : function(taxList){
        		
        	taxjsonArray=taxList;
		},
		 error: function(jqXHR, textStatus, errorThrown){
	        alert("查询失败 ，请稍后再试。。");
	     }
	});
	var optionList="";
	$.each(taxjsonArray,function(i,n){
		
		if(i==0){
			optionList+="<option value='' dutyCode='0'>请选择</option>" 
			+"<option value='"+n.tax+"' dutyCode='"+n.code+"'>"+n.tax+'</option>'
		}
		if(i!=0){
			optionList+="<option value='"+n.tax+"' dutyCode='"+n.code+"'>"+n.tax+"</option>" 
		}
		
		
	});
	return optionList;
}

function batchOperation(type){
	//采购订单类型内
	if(type==1){
	$("input[name='skuPrice']").val("");
	$("input[name='subtotalPrice']").val("");
	$("input[name='localNuTaxPrice']").val("");
	$("input[name='totalLocalNuTaxPrice']").val("");
	}
	//采购订单类型国外
	if(type==2){
		$("select[name='dutyRate']").each(function(i,item){
//			
			var that = $(item);
			//单价(含税)$("#skuPriceTax")
			var dutyRate = that.val();
			
			//$("select[name='dutyRate'] option:selected")
			
			var dutyCode = that.find("option:selected").attr("dutyCode");
			that.next().val(dutyCode);
			
			var qty = that.parents("tr").find("input[name='qty']").val();
			//数量
			var skuPriceTax = that.parents("tr").find("input[name='skuPriceTax']").val();
			//税率
			var dutyRate = that.parents("tr").find("select[name='dutyRate'] option:selected").val()/100;
			
			//不含税单价
			var skuPrice = skuPriceTax/(1+dutyRate);
			//不含税总金额
			var totalPrice = Number(skuPrice) * Number(qty);
			//含税总金额
			var totalPrice1 = Number(skuPriceTax) * Number(qty);
			
			//税额
			var duty = totalPrice1-totalPrice;
			//汇率
			var exchangeRate1 = that.parents("tr").find("input[name='exchangeRate1']").val();
			//本币单价
			var localPrice = Number(skuPriceTax) * Number(exchangeRate1);
			if($.trim(skuPriceTax)==""){
				
				return;
			}else if($.trim(qty)==""){
				
				return;
			}

			that.parents("tr").find("input[name='skuPrice']").val(Number(skuPrice).toFixed(8));
			that.parents("tr").find("input[name='localPrice']").val(localPrice.toFixed(8));
			that.parents("tr").find("input[name='subtotalPrice']").val(totalPrice.toFixed(2));
			that.parents("tr").find("input[name='totalPrice1']").val(totalPrice1.toFixed(2));
			//本币总金额
			var totalLocalPrice = Number(totalPrice1) * Number(exchangeRate1);
			that.parents("tr").find("input[name='totalLocalPrice']").val(totalLocalPrice.toFixed(2));
			//本币不含税单价
			var localNuTaxPrice = Number(skuPrice) * Number(exchangeRate1);
			that.parents("tr").find("input[name='localNuTaxPrice']").val(localNuTaxPrice.toFixed(8));
			//本币不含税金额（不含税总金额×汇率）
			var totalLocalNuTaxPrice =  Number(totalPrice) * Number(exchangeRate1);
			that.parents("tr").find("input[name='totalLocalNuTaxPrice']").val(totalLocalNuTaxPrice.toFixed(2));
			
			var itemTotalPrice =0;
			$("input[name='totalPrice1']").each(function(i,item){
				itemTotalPrice = (Number(itemTotalPrice) + Number($(item).val())).toFixed(2);
			});
			$("input[name='itemTotalPrice']").val(itemTotalPrice);
			$("#itemTotalPrice").val(itemTotalPrice);
		});
	}
}
//运输信息

function ship()
{
	var shipp = $("#shipper").val();
 	if(shipp==001){
		$(".inputnot input").attr("disabled",true);
		$(".inputnot input").val("");
		$("#addShipType").html("承运方式:");
		$("#addServiceName").html("服务商名称:");
		$(".inputnot input").attr('style',"background:#d0cdcd");
	}else if(shipp==002){
		
		$(".inputnot input").attr("disabled",false);
		$(".inputnot input").removeAttr("style")
		$("#addShipType").html("<i class='red'>*</i>承运方式:");
		$("#addServiceName").html("<i class='red'>*</i>服务商名称:");

	}
}

//当合同汇率手动输入的时候
function getExchange(){
	
	var exchangeRate =$("#exchangeRate").val();
	$("input[name='exchangeRate1']").val(exchangeRate);
	
	$("#productTab").find(".append").each(function(i,item){
		if($(item).find("input[name='qty']").val()=="" || $(item).find("input[name='skuPriceTax']").val()==""){
			return;
		}else{
			//数量
			var qty = $(item).find("input[name='qty']").val();
			//单价
			var skuPriceTax = $(item).find("input[name='skuPriceTax']").val();
			//税率
			var dutyRate = $(item).find("select[name='dutyRate'] option:selected").val()/100;
			//不含税单价
			var skuPrice = skuPriceTax/(1+dutyRate);
			//不含税总金额
			var totalPrice = Number(skuPrice) * Number(qty);
			//含税总金额
			var totalPrice1 = Number(skuPriceTax) * Number(qty);
			
			//汇率
			var exchangeRate1 = $(item).find("input[name='exchangeRate1']").val();
			//本币单价
			var localPrice = Number(skuPriceTax) * Number(exchangeRate1);
			//本币总金额
			var totalLocalPrice = Number(totalPrice1) * Number(exchangeRate1);
			//本币不含税单价
			var localNuTaxPrice = Number(skuPrice) * Number(exchangeRate1);
			//本币不含税金额（不含税总金额×汇率）
			var totalLocalNuTaxPrice =  Number(totalPrice) * Number(exchangeRate1);
			$(item).find("input[name='skuPrice']").val(Number(skuPrice).toFixed(8));
			$(item).find("input[name='localPrice']").val(localPrice.toFixed(8));
			$(item).find("input[name='subtotalPrice']").val(totalPrice.toFixed(2));
			$(item).find("input[name='totalPrice1']").val(totalPrice1.toFixed(2));
			$(item).find("input[name='totalLocalPrice']").val(totalLocalPrice.toFixed(2));
			$(item).find("input[name='localNuTaxPrice']").val(localNuTaxPrice.toFixed(8));
			$(item).find("input[name='totalLocalNuTaxPrice']").val(totalLocalNuTaxPrice.toFixed(8));
			var itemTotalPrice =0;
			$("input[name='totalPrice1']").each(function(i,item){
				itemTotalPrice = Number(itemTotalPrice) + Number($(item).val());
			});
			$("input[name='itemTotalPrice']").val(itemTotalPrice);
			$("#itemTotalPrice").val(itemTotalPrice);
		}
	});
	
	
}




//单价文本框的change事件
function calculate(event){
	var that = $(this);
	
	var purchaseType = $("#purchaseType").val();
	//单价(含税)$("#skuPriceTax")
	var skuPriceTax = that.val();
	//数量
	var qty = that.parents("tr").find("input[name='qty']").val();
	//税率
	var dutyRate = that.parents("tr").find("select[name='dutyRate'] option:selected").val()/100;
	
	
	//不含税单价
	var skuPrice = skuPriceTax/(1+dutyRate);
	//不含税总金额
	var totalPrice = Number(skuPrice) * Number(qty);
	
	//含税总金额
	var totalPrice1 = Number(skuPriceTax) * Number(qty);
	
	//汇率
	var exchangeRate1 = that.parents("tr").find("input[name='exchangeRate1']").val();
	//本币单价
	var localPrice = Number(skuPriceTax) * Number(exchangeRate1);
	if($.trim(qty)==""){
//		alert("请填写采购明细的数量!");
		return;
	}else if($.trim(dutyRate)==0 && purchaseType!=2){
//		alert("请选择商品汇率!");
		return;
	}
	that.parents("tr").find("input[name='skuPrice']").val(Number(skuPrice).toFixed(8));
	that.parents("tr").find("input[name='localPrice']").val(localPrice.toFixed(8));
	that.parents("tr").find("input[name='subtotalPrice']").val(totalPrice.toFixed(2));
	that.parents("tr").find("input[name='totalPrice1']").val(totalPrice1.toFixed(2));
	//本币总金额
	var totalLocalPrice = Number(totalPrice1) * Number(exchangeRate1);
	that.parents("tr").find("input[name='totalLocalPrice']").val(totalLocalPrice.toFixed(2));
	//本币不含税单价
	var localNuTaxPrice = Number(skuPrice) * Number(exchangeRate1);
	that.parents("tr").find("input[name='localNuTaxPrice']").val(localNuTaxPrice.toFixed(8));
	//本币不含税金额（不含税总金额×汇率）
	var totalLocalNuTaxPrice =  Number(totalPrice) * Number(exchangeRate1);
	that.parents("tr").find("input[name='totalLocalNuTaxPrice']").val(totalLocalNuTaxPrice.toFixed(2));
	
	var itemTotalPrice =0;
	$("input[name='totalPrice1']").each(function(i,item){
		itemTotalPrice = (Number(itemTotalPrice) + Number($(item).val())).toFixed(2);;
	});
	$("input[name='itemTotalPrice']").val(itemTotalPrice);
	$("#itemTotalPrice").val(itemTotalPrice);
	
}


//数量文本框的change事件
function qtyChange(event){
	var that = $(this);
	//单价(含税)$("#skuPriceTax")
	var qty = that.val();
	//数量
	var skuPriceTax = that.parents("tr").find("input[name='skuPriceTax']").val();
	//税率
	var dutyRate = that.parents("tr").find("select[name='dutyRate'] option:selected").val()/100;
	//不含税单价
	var skuPrice = skuPriceTax/(1+dutyRate);
	//不含税总金额
	var totalPrice = Number(skuPrice) * Number(qty);
	//含税总金额
	var totalPrice1 = Number(skuPriceTax) * Number(qty);
	//汇率
	var exchangeRate1 = that.parents("tr").find("input[name='exchangeRate1']").val();
	//本币单价
	var localPrice = Number(skuPriceTax) * Number(exchangeRate1);
	if($.trim(skuPriceTax)==""){
//		alert("请填写采购明细商品的价格!");
		return;
	}else if($.trim(dutyRate)==0){
//		alert("请选择商品汇率!");
		return;
	}

	that.parents("tr").find("input[name='skuPrice']").val(Number(skuPrice).toFixed(8));
	that.parents("tr").find("input[name='localPrice']").val(localPrice.toFixed(8));
	that.parents("tr").find("input[name='subtotalPrice']").val(totalPrice.toFixed(2));
	that.parents("tr").find("input[name='totalPrice1']").val(totalPrice1.toFixed(2));
	//本币总金额
	var totalLocalPrice = Number(totalPrice1) * Number(exchangeRate1);
	that.parents("tr").find("input[name='totalLocalPrice']").val(totalLocalPrice.toFixed(2));
	//本币不含税单价
	var localNuTaxPrice = Number(skuPrice) * Number(exchangeRate1);
	that.parents("tr").find("input[name='localNuTaxPrice']").val(localNuTaxPrice.toFixed(8));
	//本币不含税金额（不含税总金额×汇率）
	var totalLocalNuTaxPrice =  Number(totalPrice) * Number(exchangeRate1);
	that.parents("tr").find("input[name='totalLocalNuTaxPrice']").val(totalLocalNuTaxPrice.toFixed(8));
	
	var itemTotalPrice =0;
	$("input[name='totalPrice1']").each(function(i,item){
		itemTotalPrice = (Number(itemTotalPrice) + Number($(item).val())).toFixed(2);;
	});
	$("input[name='itemTotalPrice']").val(itemTotalPrice);
	$("#itemTotalPrice").val(itemTotalPrice);
	
}

//税率的change事件
function dutyRateChange(event){
	
	var that = $(this);
	//单价(含税)$("#skuPriceTax")
	var dutyRate = that.val();
	
	//$("select[name='dutyRate'] option:selected")
	
	var dutyCode = that.find("option:selected").attr("dutyCode");
	that.next().val(dutyCode);
	
	var qty = that.parents("tr").find("input[name='qty']").val();
	//数量
	var skuPriceTax = that.parents("tr").find("input[name='skuPriceTax']").val();
	//税率
	var dutyRate = that.parents("tr").find("select[name='dutyRate'] option:selected").val()/100;
	
	//不含税单价
	var skuPrice = skuPriceTax/(1+dutyRate);
	//不含税总金额
	var totalPrice = Number(skuPrice) * Number(qty);
	//含税总金额
	var totalPrice1 = Number(skuPriceTax) * Number(qty);
	
	//税额
	var duty = totalPrice1-totalPrice;
	//汇率
	var exchangeRate1 = that.parents("tr").find("input[name='exchangeRate1']").val();
	//本币单价
	var localPrice = Number(skuPriceTax) * Number(exchangeRate1);
	if($.trim(skuPriceTax)==""){
		
		return;
	}else if($.trim(qty)==""){
		
		return;
	}

	that.parents("tr").find("input[name='skuPrice']").val(Number(skuPrice).toFixed(8));
	that.parents("tr").find("input[name='localPrice']").val(localPrice.toFixed(8));
	that.parents("tr").find("input[name='subtotalPrice']").val(totalPrice.toFixed(2));
	that.parents("tr").find("input[name='totalPrice1']").val(totalPrice1.toFixed(2));
	//本币总金额
	var totalLocalPrice = Number(totalPrice1) * Number(exchangeRate1);
	that.parents("tr").find("input[name='totalLocalPrice']").val(totalLocalPrice.toFixed(2));
	//本币不含税单价
	var localNuTaxPrice = Number(skuPrice) * Number(exchangeRate1);
	that.parents("tr").find("input[name='localNuTaxPrice']").val(localNuTaxPrice.toFixed(8));
	//本币不含税金额（不含税总金额×汇率）
	var totalLocalNuTaxPrice =  Number(totalPrice) * Number(exchangeRate1);
	that.parents("tr").find("input[name='totalLocalNuTaxPrice']").val(totalLocalNuTaxPrice.toFixed(2));
	
	var itemTotalPrice =0;
	$("input[name='totalPrice1']").each(function(i,item){
		itemTotalPrice = (Number(itemTotalPrice) + Number($(item).val())).toFixed(2);
	});
	$("input[name='itemTotalPrice']").val(itemTotalPrice);
	$("#itemTotalPrice").val(itemTotalPrice);
	
}

	   
   

function totalCount(){
	var itemTotalPrice =0;
	$("input[name='subtotalPrice']").each(function(i,item){
		itemTotalPrice = Number(itemTotalPrice) + Number($(item).val());
	});
	$("input[name='itemTotalPrice']").val(itemTotalPrice);
	$("#itemTotalPrice").val(itemTotalPrice);
}

function deleteTr(){
	var length = $("#productTab").find(".checkbox").length;
	var checkedLength=$("#productTab").find(".checkbox:checked").length;
	if(checkedLength>=length){
		
		$("#productTab").find(".checkbox").each(function(i,item){
			
			if(i==0){
				$(item).parent().parents("tr").find("input").val("");
				$(item).parent().parents("tr").find("#skuId").attr("disabled",false);
				$(item).attr("checked",false);
			}else{
			if($(item).attr("checked")){
				$(item).closest(".append").remove();
			}
			}
		});
	}else {
	
		$("#productTab").find(".checkbox").each(function(i,item){			
			if($(item).attr("checked")){
				$(item).closest(".append").remove();
			}
		});
		
		$("#productTab").find();
	}
	
	totalCount();
}



function deleteTrKC(){
	var length = $("#wareHouseTab").find(".checkbox1").length;
	var checkedLength = $("#wareHouseTab").find(".checkbox1:checked").length;
	if(checkedLength>=length){
		$("#wareHouseTab").find(".checkbox1").each(function(i,item){
			
			if(i==0){
				$(item).parent().parents("tr").find("input").val("");
				$(item).attr("checked",false);
			}else{
				if($(item).attr("checked")){
				$(item).closest(".appendWareHouse").remove();
			}
			}
		});
		
	}else{
		
		$("#wareHouseTab").find(".checkbox1").each(function(i,item){			
			if($(item).attr("checked")){
				$(item).closest(".appendWareHouse").remove();
			}
		});
	}
}

//校验电话
function checktel(){
	var that = $(this),val = that.val();
	if(!RegExp("^0?(13|15|17|18|14)[0-9]{9}$").test(val)){
		alert("请输入正确的电话号码");
		that.val("");
	}
}
//校验文本内容
function checktext(){
	var that = $(this),val = that.val();
	if(val.length > 50){
		alert("字符长度不能超于50");
		that.val("");
	}
}

//校验收货地址
function checkAddresstext(){
	var that = $(this),val = that.val();
	if(val.length > 100){
		alert("字符长度不能超于100");
		that.val("");
	}
}

//校验合同号
function checkNumber(){
	
	if($.trim($("#contractNumber").val()).length>20){
		alert("合同号长度不能超过20位");
		$("#contractNumber").val("");
	}
	
}

//校验备注
function checkRemarkText(){
//	if(!RegExp("^[A-Za-z0-9_()（）\\-\\u4e00-\\u9fa5]$").test($("#remark").val())){
//		alert("备注不能有特殊字符");
//		$("#remark").val("");
//	}else 
		if($("#remark").val().length>1000){
		alert("备注信息过长，长度不能超过1000");
		$("#remark").val("");
	}
}
//校验仓库联系人
function checkContact(){
//	if(!RegExp("^[A-Za-z0-9_()（）\\-\\u4e00-\\u9fa5]$").test($(this).val())){
//		alert("联系人不能有特殊字符");
//		$(this).val("");
//	}else 
		if($(this).val().length>5){
		alert("联系人长度不能超过5");
		$(this).val("");
	}
	
}
function checkAllText(){
	
	var textLength= $(this).val().length;
	if(textLength>25){
		$(this).val("");
		alert("输入信息最大长度为"+25);
	}
	
	
}
//隐藏弹出框
function hideShow(){
	

	$(".alert_bu").hide();
	$(".alert_c").hide();
}
//订单审核
function audit(id){
	$.ajax({
		type : "post", 
		url  : CONTEXTPATH+"/pchaseOrder/confirmOrder", 
		data:{"id":id},
		success : function(msg) {
//			alert(msg);
//			window.location.href
			tipMessage(msg,function(){
			if(msg=='审核成功'){
				
				window.location.href="../pchaseOrder/getPurchaseOrder";
			}else{
				
				alert("审核失败 ，请稍后再试。。");
			}
		
	   		 });
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("审核失败 ，请稍后再试。。");
		}
	});
}


function getPurchaseId(){
	var flag  =false;
	var skuType = $("#productType").val();
	//采购公司的编码
	var purchaseEntity = $("#purchaseEntity").val();
	$.ajax({
		type : "post", 
		url  : CONTEXTPATH+"/pchaseOrder/getPurchaseId", 
		data:{"skuType":skuType,"purchaseEntity":purchaseEntity},
		async:false,
		success : function(msg) {
			if(msg=="生成采购单编码失败"){
				alert("生成采购单编号失败，请稍后重试");
				flag =false;
			}else{
				flag =true;
				$("input[name='purchaseCode1']").val(msg);
				$("input[name='purchaseCode']").val(msg);
			}
			
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("获取采购单编码失败，请稍后再试。。");
		}
	});
	return flag;
	
}
