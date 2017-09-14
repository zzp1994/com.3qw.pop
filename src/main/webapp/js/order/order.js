		var path = '';
		var language = '';
		$(document).ready(function(){
			language = $("#language").val();
			path = $("#host").val();
			$.ajax({
				 type : "post", 
	         	 url :path+ "/order/getOrder", 
	         	 data:"status="+999,
	         	 dataType:"html",
		         success : function(msg){
					$(".c3").html(msg);
				 },
				 error: function(jqXHR, textStatus, errorThrown){
			        alert("error");
			     }
			}); 
			
			
			
			
		});
		
		/**
		 * 填写合同
		 */
		function editContract(orderId){
			window.location.href=path+"/order/toEditContractUI?orderId="+orderId;
		}
		
		/**
		 * 打印发货单
		 */
		function printDespatch(orderId){
			window.location.href=path+"/order/toPrintDespatchUI?orderId="+orderId;
		}
		/**
		 *合同预览
		 */
		function viewerContract(orderId){
	    	  window.location.href=path+"/order/viewerContract?orderId="+orderId;
	     }
	
		function clickSubmit(page){
				
					var orderId = $("#orderId").val();
					var startTime  = $("#startTime").val();
					var endTime  = $("#endTime").val();
					var pName  = $("#pName").val();
					var dealerName  = $("#dealerName").val();
					
					var click_array = new Array();
					
					if(page!=undefined&&page!=null&&page!=""){
						click_array.push("page="+page);
					}
					
					
					if(startTime!="" && endTime!=""){
						if(startTime>endTime){
							if("en"==language){
								alert("Start time must be smaller than the end of time");
							} else {
								alert("开始时间必须小于结束时间");
							}
							return false;
						}
					}
					
					click_array.push("poId="+orderId);
					click_array.push("createTime="+startTime);
					click_array.push("endTime="+endTime);
					click_array.push("pName="+pName);
					click_array.push("dealerName="+dealerName);
					
					var statuslist1 =$("#suoyou").attr("class");
					var statuslist2 =$("#queren").attr("class");
					var statuslist3 =$("#dengdai").attr("class");
					var statuslist4 =$("#shouhuo").attr("class");
					var statuslist5 =$("#wancheng").attr("class");
					
					var statu ='';
					
					if(statuslist1=='list'){
						statu = $("#state").val();
					}
					if(statuslist2=='list'){
						statu = '998';
					}
					if(statuslist3=='list'){
						statu = '62';
					}
					if(statuslist4=='list'){
						statu = '71';
					}
					if(statuslist5=='list'){
						statu = '81';
					}
					
					click_array.push("status="+statu);
						$.ajax({
								 type : "post", 
					         	 url : path+"/order/getOrder", 
					         	 data:click_array.join('&'),
					         	 dataType:"html",
						         success : function(msg) {
									$(".c3").html(msg);
							},
							 error: function(jqXHR, textStatus, errorThrown){
						        alert("error");
						     }
					}); 
	}
	function confirmOrder(orderId,status){
		$.ajax({
				 type : "post", 
	         	 url : path+"/order/validationMoney", 
	         	 data:"orderId="+orderId+"&status="+status,
	         	 dataType:"html",
	         	 success:function(msg){
	         		
	         		if("en"==language){
	         			if(msg=='1'){
	         				alert("success");
	         			} else {
	         				alert("error");
	         			}
					} else {
						if(msg=='1'){
							alert("确认成功");
						} else{
							alert("服务器异常，请稍后再试！");
						}
					}
	         	 	clickSubmit();
	         	 },
	         	 error: function () {
			            alert("error");
			        }
		});
	}
	
	
	function getOrder(statu){
		
		
		$.ajax({
				 type : "post", 
	         	 url : path+"/order/getOrder", 
	         	 data:"status="+statu,
	         	 dataType:"html",
		         success : function(msg) {
		         if(statu=='999'){
		         	$("#suoyou").attr("class","list");
		         	$("#queren").removeClass("list");
		         	$("#dengdai").removeClass("list");
		         	$("#wancheng").removeClass("list");
		         	$("#shouhuo").removeClass("list");
		         }
				if(statu=='998'){
		         	$("#suoyou").removeClass("list");
		         	$("#dengdai").removeClass("list");
		         	$("#queren").attr("class","list");
		         	$("#wancheng").removeClass("list");
		         	$("#shouhuo").removeClass("list");
		         }
		         if(statu=='62'){
	         		$("#suoyou").removeClass("list");
		         	$("#queren").removeClass("list");
		         	$("#dengdai").attr("class","list");
		         	$("#wancheng").removeClass("list");
		         	$("#shouhuo").removeClass("list");
		         }
		         if(statu=='71'){
		        	 $("#suoyou").removeClass("list");
		        	 $("#queren").removeClass("list");
		        	 $("#wancheng").removeClass("list");
		        	 $("#shouhuo").attr("class","list");
		        	 $("#dengdai").removeClass("list");
		         }
		         if(statu=='81'){
	         		$("#suoyou").removeClass("list");
		         	$("#queren").removeClass("list");
		         	$("#wancheng").attr("class","list");
		         	$("#dengdai").removeClass("list");
		         	$("#shouhuo").removeClass("list");
		         }
					$(".c3").html(msg);
			},
				 error: function(jqXHR, textStatus, errorThrown){
			        alert("error");
			     }
			}); 
	}
	
	function lineitem(orderId){
		window.location.href=path+"/order/getOrderMinute?orderId="+orderId;
	}
