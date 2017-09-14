

function toPage(page){
	byConditionSearchcustomerRefundOrder(page);
}
function onMouseOver(){
	var td = $(this);
	td.parent(".tcolr").next().show();
}
function onMouseLeave(){
	var td = $(this);
	td.parent(".tcolr").next().hide();
}

function byConditionSearchcustomerRefundOrder(page){
	var orderId = $.trim($("#orderId").val());
	var startTime  = $("#startTime").val();
	var endTime  = $("#endTime").val();
	var pName  = $.trim($("#pName").val());
	var receiveName  = $.trim($("#receiveName").val());
	var status  = $("#status").val();
	var userName = $("#userName").val();
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
	
	if(page!=undefined&&page!=null&&page!=""){
		customerOrder_array.push("page="+page);
	}
	$.ajax({
		 type : "post", 
    	 url : "../order/getCustomerRefundOrderPageBeanByCondition", 
    	 data:customerOrder_array.join('&')+"&random="+Math.random(),
    	 dataType:"html",
    	 success : function(customerOrder) {
			$(".tab-bd").html(customerOrder);
    	 },
		 error: function(jqXHR, textStatus, errorThrown){
	        alert("查询失败 ，请稍后再试。。");
		 }
	}); 
}

//wofe操作审核失败订单退款
function goRefundOrderByOrderId(orderId){
	$.dialog.confirm('此订单确定要退款吗?',function(){
		$.ajax({
			 type : "post", 
		   	 url : "../order/goRefundOrderByOrderId", 
		   	 data:"orderId="+orderId,
		   	 dataType:"html",
		   	 success : function(resultMsg) {
		   		 tipMessage(resultMsg,function(){
		   			byConditionSearchcustomerRefundOrder(1);
		   		 });
		   	 },
		}); 
	});
}


//确认收货后的不良退单
function refundOrderByOrderId(orderId){
	$.dialog.confirm('此订单确定要退款吗?',function(){
		$.ajax({
			 type : "post", 
		   	 url : "../order/refundOrderByOrderId", 
		   	 data:"orderId="+orderId,
		   	 dataType:"html",
		   	 success : function(resultMsg) {
		   		 tipMessage(resultMsg,function(){
		   			byConditionSearchcustomerRefundOrder(1);
		   		 });
		   	 },
		}); 
	});
}