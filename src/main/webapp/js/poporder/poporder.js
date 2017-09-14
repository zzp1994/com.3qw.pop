
/*function hsz(page){	
	var orderId = $.trim($("#orderId").val());
	var startTime  = $("#startTime").val();
	var endTime  = $("#endTime").val();
	var pName  = $.trim($("#pName").val());
	var receiveName  = $.trim($("#receiveName").val());
	var status  = $("#status").val();
	var userName = $("#userName").val();
	var customerOrder_array = new Array();
	var matchnum = /^[0-9]*$/;
	var orderPlatform = $("#orderPlatform").val();

	$(".lyan").live("hover",onMouseOver);
	$(".lyan").live("mouseleave",onMouseLeave);

if(!matchnum.test(orderId)){
		alert("订单编号只能是数字！");
		 $("#orderId").val("");
		 $("#orderId").focus();
		 return false;
	}
if(orderId != ""){
	customerOrder_array.push("orderId="+orderId);
}
if(startTime != ""){
	customerOrder_array.push("startTime="+startTime);
}
if(endTime != ""){
	customerOrder_array.push("endTime="+endTime);
}
if(receiveName != ""){
	customerOrder_array.push("receiveName="+receiveName);
}
if(pName != ""){
	customerOrder_array.push("pName="+pName);
}
if(userName != ""){
	customerOrder_array.push("userName="+userName);
}
if(status!=""){
	customerOrder_array.push("status="+status);
}
if(orderPlatform!=""){
	customerOrder_array.push("orderPlatform="+orderPlatform);
}
if(page!=undefined&&page!=null&&page!=""){
	customerOrder_array.push("page="+page);
}
 console.log("------"+orderPlatform);
$.ajax({
	 type : "post", 
	 url : "../order/gethsz", 
	 data:customerOrder_array.join('&')+"&random="+Math.random(),
	 dataType:"html",
	 success : function(customerOrder) {
		$(".c3").html(customerOrder);
	 },
	 error: function(jqXHR, textStatus, errorThrown){
        alert("查询失败 ，请稍后再试。。");
	 }
}); }*/


function xfgOrder(){
	$.ajax({
		 type : "post", 
   	 url : "../order/getXfgOrder", 
  /* 	 data:customerOrder_array.join('&')+"&random="+Math.random(),*/
   	 dataType:"html",
   	 success : function(customerOrder) {
			$(".c3").html(customerOrder);
   	 },
		 error: function(jqXHR, textStatus, errorThrown){
	        alert("查询失败 ，请稍后再试。。");
		 }
	}); 
	
}


function byConditionSearchCustomerOrder(page){
	var orderId = $.trim($("#orderId").val());
	var startTime  = $("#startTime").val();
	var endTime  = $("#endTime").val();
	var pName  = $.trim($("#pName").val());
	var receiveName  = $.trim($("#receiveName").val());
	var status  = $("#status").val();
	var userName = $("#userName").val();
	var customerOrder_array = new Array();
	var matchnum = /^[0-9]*$/;
	var orderPlatform = $("#orderPlatform").val();
	var orderType=$("#orderType").val();

	$(".lyan").live("hover",onMouseOver);
	$(".lyan").live("mouseleave",onMouseLeave);
	
	if(!matchnum.test(orderId)){
  		alert("订单编号只能是数字！");
  		 $("#orderId").val("");
  		 $("#orderId").focus();
  		 return false;
  	}
	if(orderId != ""){
		customerOrder_array.push("orderId="+orderId);
	}
	if(startTime != ""){
		customerOrder_array.push("startTime="+startTime);
	}
	if(endTime != ""){
		customerOrder_array.push("endTime="+endTime);
	}
	if(receiveName != ""){
		customerOrder_array.push("receiveName="+receiveName);
	}
	if(pName != ""){
		customerOrder_array.push("pName="+pName);
	}
	if(userName != ""){
		customerOrder_array.push("userName="+userName);
	}
	if(status!=""){
		customerOrder_array.push("status="+status);
	}
	if(orderPlatform!=""){
		customerOrder_array.push("orderPlatform="+orderPlatform);
	}
	if(orderType!=""){
		customerOrder_array.push("orderType="+orderType);
	}
	if(page!=undefined&&page!=null&&page!=""){
		customerOrder_array.push("page="+page);
	}
	 console.log("------"+orderPlatform);
	$.ajax({
		 type : "post", 
    	 url : "../order/getCustomerOrderPageBeanByCondition", 
    	 data:customerOrder_array.join('&')+"&random="+Math.random(),
    	 dataType:"html",
    	 success : function(customerOrder) {
    		
			$(".c3").html(customerOrder);
    	 },
		 error: function(jqXHR, textStatus, errorThrown){
	        alert("查询失败 ，请稍后再试。。");
		 }
	}); 
}

function onMouseOver(){
	var td = $(this);
	td.parent(".tcolr").next().show();
}

function onMouseLeave(){
	var td = $(this);
	td.parent(".tcolr").next().hide();
}

function toPage(page){
	byConditionSearchCustomerOrder(page);
}


function exportCustomerOrderExcel(){
	var orderType=$("#orderType").val();
	var orderId = $.trim($("#orderId").val());
	var startTime  = $("#startTime").val();
	var endTime  = $("#endTime").val();
	var pName  = $.trim($("#pName").val());
	var receiveName  = $.trim($("#receiveName").val());
	var status  = $("#status").val();
	var userName = $("#userName").val();
	var orderPlatform = $("#orderPlatform").val();

	var customerOrder_array = new Array();
	var matchnum = /^[0-9]*$/;
	if(!matchnum.test(orderId)){
  		alert("订单编号只能是数字！");
  		 $("#orderId").val("");
  		 $("#orderId").focus();
  		 return false;
  	}
	if(orderId != ""){
		customerOrder_array.push("orderId="+orderId);
	}
	if(startTime != ""){
		customerOrder_array.push("startTime="+startTime);
	}
	if(endTime != ""){
		customerOrder_array.push("endTime="+endTime);
	}
	if(receiveName != ""){
		customerOrder_array.push("receiveName="+receiveName);
	}
	if(pName != ""){
		customerOrder_array.push("pName="+pName);
	}
	if(userName != ""){
		customerOrder_array.push("userName="+userName);
	}
	if(status!=""){
		customerOrder_array.push("status="+status);
	}
	if(orderPlatform!=""){
		customerOrder_array.push("orderPlatform="+orderPlatform);
	}
	if(orderType!=""){
		customerOrder_array.push("orderType="+orderType);
	}
    console.log("------"+orderPlatform);
   
	window.location.href = "../order/exportCustomerOrderExcel?"+customerOrder_array.join("&");
}



function exportExcel(){
	
	var startTime  = $("#fromDate").val();
	var endTime  = $("#toDate").val();
	

	var customerOrder_array = new Array();
	
	if(startTime != ""){
		customerOrder_array.push("startTime="+startTime);
	}
	if(endTime != ""){
		customerOrder_array.push("endTime="+endTime);
	}
	
    console.log("------"+orderPlatform);
   
	window.location.href = "../order/exportExcel?"+customerOrder_array.join("&");
}

//显示物流补录框
function showWuLiu(id,receiveName, receivePhone, receiveAddress){
	
	$("#error").text("");
	$("#receiveNameField").text(receiveName);
	$("#receivePhoneField").text(receivePhone);
	$("#receiveAddressField").text(receiveAddress);
	
	popCenterWindow();
	
	$("#logistic").val("");
	$("#logisticCode").val("");
	$("#shipOrderId").val("");
	$("#logistic").empty();
	getLogistic();
	$("#shipOrderId").val(id);
	$(".logw").show();
}


//异步加载所有物流商
function getLogistic(){
	$("#logistic").append("<option value='0'>请选择</option>"); 
	$.ajax({
		type:"post",
		url:"../order/getLogistic",
		dataType:"json",
		success:function(jsonStock){
			$.each(jsonStock,function(i,n){
				$("#logistic").append("<option value='"+n.providerId+"'>"+n.providerName+"</option>"); 
			});
		},
		error:function(jqXHR,textStatus,errorThrown){
			alert("网络异常,请稍后再试。。。。");
		}
	});
}


//经销商补录物流信息
function goUpdateShipOrderLogistic(){
	var providerId = $("#logistic").val();
	var logisticCode = $("#logisticCode").val();
	var id = $("#shipOrderId").val();
	var providerName = $("#logistic").find("option:selected").text();
	var page = $("#currentPageId").val();
	if(providerId==0){
		$(".error").text("请选择物流商!");
		return false;
	}else if(logisticCode==""){
		$(".error").text("请输入物流单号!");
		return false;
	}else if (logisticCode.length > 20) {
		$(".error").text("物流单号长度不能超过20位!");
		return false;
	}
	else {
		$(".error").text("");
		$.ajax({
			type:"post",
			url:"../order/updateOrderLogisticsById",
			data:{'orderId':id,'logisticsCarriersName':providerName,'logisticsCarriersId':providerId,'logisticsNumber':logisticCode},
			dataType:"html",
			success:function(result){
				if(result=='1'){
					alert("发货成功!");
					$("#center").hide("slow"); 
					
					$(".logw").hide();
					$("#logistic").val("");
					$("#logisticCode").val("");
					$("#shipOrderId").val("");
					$("#logistic").val(0);
					byConditionSearchCustomerOrder(page);
				}else{
					alert(result);
				}
			},
			error:function(jqXHR,textStatus,errorThrown){
				alert("网络异常,请稍后再试。。。。");
			}
		});
	}	
}