var path = '';
$(document).ready(function(){
	path = $("#host").val();
	$("#cancel").live("click",hideandcancel);
	$("#closeboxformviewacount").live("click",hideandcancel);
	$("input[name='qty']").live("input propertychange", checknum);
	$("input[name='amount']").live("input propertychange", checknum);
	$("input[name='supplyQty']").live("input propertychange", checknum);

	/**
	加库存
	 */
	clickSubmit();
	
	$("#sqty").change(function(){
		var sqty = $("#sqty").val();
		var  matchnum = /^[0-9]*$/;
		if(!matchnum.test(sqty)){
			alert("Only numbers can be entered in Item in stock！");
			$("#sqty").val("");
			$("#sqty").focus();
		}
	});

	$("#eqtyNum").change(function(){
		var eqtyNum = $("#eqtyNum").val();
		var  matchnum = /^[0-9]*$/;
		if(!matchnum.test(eqtyNum)){
			alert("Only numbers can be entered in Item in stock！");
			$("#eqtyNum").val("");
			$("#eqtyNum").focus();
		}
	});
	$("#sProductionQty").change(function(){
		var eqtyNum = $("#sProductionQty").val();
		var  matchnum = /^[0-9]*$/;
		if(!matchnum.test(eqtyNum)){
			alert("Only numbers can be entered in Maximum quantity！");
			$("#sProductionQty").val("");
			$("#sProductionQty").focus();
		}
	});
	$("#eProductionQty").change(function(){
		var eqtyNum = $("#eProductionQty").val();
		var  matchnum = /^[0-9]*$/;
		if(!matchnum.test(eqtyNum)){
			alert("Only numbers can be entered in Maximum quantity！");
			$("#eProductionQty").val("");
			$("#eProductionQty").focus();
		}
	});
	
	
	/**
			 		创建有批次的sku
	 */ 

	$("#fmc").click(function(){
		var flag = true;
		var batchNo = $("#batchNum").val();
		var qty = $("#amount").val();
		var startTime=$("#startTime").val();
		var endTime=$("#endTime").val();
		var skuId = $("#skuId").val();
		var sheilLife = $("#sheilLife").val();
		var pid = $("#pid").val();

		if(batchNo==null||batchNo==""){
			flag = false;
			alert("Batch number can't be empty");
			return false;
		}
		var reg = new RegExp("^[0-9a-zA-Z]*$");  
		if (!reg.test(batchNo)) {
			flag = false;
			return false;
		}
		if(qty==null||qty==""){
			flag = false;
			alert("Inventory number can't be empty");
			return false;
		}

		var number = new RegExp("^[1-9][0-9]*$");
		if (!number.test(qty)) {
			flag = false;
			alert("Only numbers can be entered in Inventories");
			return false;
		}
		if(startTime==null||startTime==""){
			flag =false;
			alert("Please select a date of production");
			return false;
		}
		if(endTime==null||endTime==""){
			flag =false;
			alert("Please select a valid date");
			return false;
		}

		if(startTime!=""&&endTime!=""){
			if(startTime > endTime){
				alert("Start time must be smaller than the end of time");
			}
		}

		if(flag){
			var fmc_array = new Array();
			fmc_array.push("batchNo="+batchNo);
			fmc_array.push("qty="+qty);
			fmc_array.push("startTime="+startTime);
			fmc_array.push("endTime="+endTime);
			fmc_array.push("sheilLife="+sheilLife);
			fmc_array.push("pid="+pid);
			fmc_array.push("skuId="+skuId);
			$.ajax({
				async:false,
				type : "post", 
				url    : path+"/inventory/createBatch", 
				data :fmc_array.join("&"),
				success : function(data) { 
					if(data=="1"){
						alert("success");
						var pageContext = $("#pageContext").val();
						clickSubmit(pageContext);
					}
					else{
						alert("error");
					}
					$(".alert_user").toggle();
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert("The query fails, please try again later.");
					$(".alert_user").toggle();
				}
			});
		}else{
			alert("Please fill in the data before submission");
			return flag;
		}

	});


	/**
   	批量修改库存
	 */ 
	$("#editInventoryOnBatch").click(function(){

		var isSubmit = 0;
		$("#showBach input[name='qty']").each(function(){
			var thisvals = $(this).val();
			if(!/^[1-9]{1}[0-9]*$/.test(thisvals)){
				alert("Only numbers can be entered in Inventories");
				isSubmit++;
			}
		});

		if(isSubmit==0){

			var td_String = "";
			var tr_String = new Array();
			$("#showBach tr").each(function(){

				$(this).find("input").each(function(){
					td_String+=$(this).val();
					td_String+=",";
				});
				tr_String.push(td_String);
				td_String="";
			});

			$.ajax({
				type : "post", 
				url    : path+"/inventory/upBach", 
				data :"bathList="+tr_String.join("_"),
				success : function(msg) { 
					if(msg == 1){
						alert("success");
						var pageContext = $("#pageContext").val();
						clickSubmit(pageContext);
					}else{
						alert("error");
					}

					$(".alert_shul").toggle();
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert("The query fails, please try again later.");
				}
			});
		}

	});

});

function clickSubmit(page){
	var array_inventory = new Array();
	var pname = $("#productName").val();

	if(page!=""&&page!=null&&page!=undefined){
		array_inventory.push("page="+page);
	}
	if(pname!=""){
		array_inventory.push("pName="+pname);
	}

	var stat = checkLabel();

	if(stat == '1'){
		$.ajax({
			async:false,
			type: "post", 
			url: path+"/inventory/getInventory", 
			data :array_inventory.join("&")+"&math="+Math.random(),
			dataType: "html",
			success : function(msg) { 
				$("#c24").html(msg);
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("查询失败 ，请稍后再试。。");
			}
			
		});
	}
	if(stat == '0'){
		$.ajax({
			async:false,
			type: "post", 
			url: path+"/inventory/collection", 
			data :array_inventory.join("&")+"&math="+Math.random(),
			dataType: "html",
			success : function(msg) { 
				$("#c24").html(msg);
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("查询失败 ，请稍后再试。。");
			}
	
		});
	}

}
/**
		Model赋值操作
 */
/**
		创建
 */
function createbatchsingel(skuId,pid,sheilLife){	

	$(".box2 input").each(function(){
		$(this).val("");
	});

	$("#skuId").val(skuId);
	$("#pid").val(pid);
	$("#sheilLife").val(sheilLife);
	$(".alert_user").toggle();
}	

/**
		修改或查看批次数量
 */
function inventoryAmountByEditType(skuId,editType,viewType)
{
	/**
		加载对应sku的批次 库存量
	 */
	
	/**
	加载对应sku的批次 库存量
	*/
		$.ajax({
			type : "post", 
			url    : path+"/inventory/getSkuQty", 
			data :"skuId="+skuId+"&mathrandom="+Math.random(),
			success : function(msg) {
				var showBachList ="";
				$.each(eval(msg),function(i,n){
					showBachList+="<tr><td><input type='hidden'  name='id' id='editId' value='"+n.id+"'>"+n.presubQty+"</td>" +
					"<td><input type='text' class='in1' name='supplyQty' id='supplyQty' value='"+n.qty+"'></td></tr>";
				});	
				$("#bachsingle").html('');
				$("#bachsingle").html(showBachList);
				$(".alert_shul1").toggle();
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("Service is busy, please try again later");
			}
		});  
	
}	

/**
				onclick获取列表
 */
function getInventoryListByLabel(status){
	$("#zeroCount").show();
	if(status==1){
		$.ajax({
			async:false,
			type : "post", 
			url    :path+ "/inventory/getInventory", 
			data: "status="+status,
			dataType: "html",
			success : function(msg) { 
				$("#showAllList").attr("class","list");
				$("#showZeroList").attr("class","");
				$("#c24").html(msg);
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("The query fails, please try again later.");
			}
		}); 
	}else if(status==0){
		$("#zeroCount").hide();
		$("#sqty").val("");
		$("#eqtyNum").val("");
		$.ajax({

			async:false,
			type: "post", 
			url:path+ "/inventory/collection", 
			data: "status="+status,
			dataType: "html",
			success : function(msg) { 
				$("#showAllList").attr("class","");
				$("#showZeroList").attr("class","list");
				$("#c24").html(msg);
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("The query fails, please try again later.");
			}
		}); 
	}else{
		var status = '';
		var attr = $("showAllList").attr("class");
		if(attr=='list'){
			status = '1';
		}else{
			status = '0';
		}

		$.ajax({
			async:false,
			type : "post", 
			url    :path+ "/inventory/getInventory", 
			data: "status="+status,
			dataType: "html",
			success : function(msg) { 
				$("#c24").html(msg);
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("The query fails, please try again later.");
			}
		}); 
	}
}




		/**
		更新信息
		*/        
		function fmToUp(){
			var flag = true;
			var editId = $("#editId").val();
			var supplyQty = $("#supplyQty").val();
			
				if(editId==""){
					flag = false;
					$("#tipmsg").text("Inventory number can't be empty");
					return false;
				}
		
			if(supplyQty==""){
				flag = false;
				$("#tipmsg").text("Inventory number can't be empty");
				return false;
			}
			var reg = new RegExp("^[0-9]{1,9}$");  
			if (!reg.test(supplyQty)) {
			flag = false;
			$("#tipmsg").text("Only numbers can be entered in Inventories");
			return false;
		}
			
		$(".tipmsg").text('');
		//var pic = $('<tr  class="tooltip"><td colspan="3"><span style="border:1px solid red;color:red;  display:block;line-height:15px; margin:5px 0 5px 0; font-size:12px; text-align:center;"></span></td></tr>');
		//$("#bachsingle").find("tr").each(function(){
		//var compared = Number($(this).find("td").eq(0).text());
		//var obj =  $(this).find("input[type='text']");
		//if(Number(obj.eq(0).val())+Number(obj.eq(1).val())<compared){
		//flag = false;
		//$(pic).find("span").text("现货库存不能小于订单占用数量！");
		//$(obj).closest("tr").after(pic);
		//return false;
		//}
		//});
		
		if(flag){
		
		var fmc_array = new Array();
		
		fmc_array.push("editId="+editId);
		fmc_array.push("supplyQty="+supplyQty);
		
		$.ajax({
		async:false,
		type : "post", 
		url    : path+"/inventory/upAmount", 
		data :fmc_array.join("&"),
		success : function(msg) { 
			if(msg==1){
				alert("Successful");
				var pageContext = $("#pageContext").val();
				clickSubmit(pageContext);
			}
			else{
				alert("Error");
			}
			$(".alert_shul1").toggle();
		
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("The query fails, please try again later.");
		}
		}); 
		}
		}









/**
  更新信息
 */        
function editInventoryOnNotBatch(){
	var flag = true;
	var upAmount = $("#upAmount").val();
	var supplyQty = $("#supplyQty").val();
	if(upAmount==null||upAmount==""){
		flag = false;
		$("#tipmsg").text("Please fill in the data before submission");
	}
	var reg = new RegExp("^[0-9]*$");  
	if (!reg.test(upAmount)) {
		alert("Only numbers can be entered");
		return false;
	}
	if(supplyQty==null||supplyQty==""){
		flag = false;
		$("#tipmsg").text("Please fill in the data before submission");
		return false;
	}
	var reg = new RegExp("^[0-9]*$");  
	if (!reg.test(supplyQty)) {
		flag = false;
		$("#tipmsg").text("Only numbers can be entered");
		return false;
	}
	
	$(".tooltip").remove();
	var pic = $('<tr  class="tooltip"><td colspan="3"><span style="border:1px solid red;color:red;  display:block;line-height:15px; margin:5px 0 5px 0; font-size:12px; text-align:center;"></span></td></tr>');
	$("#bachsingle").find("tr").each(function(){
		  var compared = Number($(this).find("td").eq(0).text());
		  var obj =  $(this).find("input[type='text']");
		  if(Number(obj.eq(0).val())+Number(obj.eq(1).val())<compared){
			  flag = false;
			  $(pic).find("span").text("Maximum quantity and Item in stock cannot be less than the number of Order reserved to take up");
			  $(obj).closest("tr").after(pic);
			  return false;
		}
	});




	if(flag){
		var fmc_array = new Array();
		var repertoryId = $("#editId").val();

		fmc_array.push("repertoryId="+repertoryId);
		fmc_array.push("upAmount="+upAmount);
		fmc_array.push("supplyQty="+supplyQty);

		$.ajax({
			async:false,
			type : "post", 
			url    : path+"/inventory/upAmount", 
			data :fmc_array.join("&"),
			success : function(msg) { 
				$(".alert_shul1").toggle();
				if(msg==1){
					alert("success");
					var pageContext = $("#pageContext").val();
					clickSubmit(pageContext);
				}else{
					alert("error");
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("The query fails, please try again later.");
			}
		}); 
	}
}

function checkLabel(){
	var status = '';
	var showZeroList = $("#showZeroList").attr('class');
	if(showZeroList=='list'){
		status='0';
	}else{
		status='1';
	}
	return status;
}
function checknum(event){
	var mm = event.target;
	setTimeout(function(){
		var str =  mm.value;
		if(!RegExp("^\\d+$").test(str) ){
			mm.value="";;
			//$(mm).delay(100000000).val("");
		}
	},1000);

}
function vali(event){
	$(".tooltip").remove();
	var that = event.target?event.target:event.srcElement;
	var matchnum = /^[0-9]*$/;
	var value = Number(that.value);
	var presubQty = Number($(that).parent().prev().text());
	var comparedata = Number($(that).attr("comparedata"));
		if (matchnum.test(that.value)){
			var pic = $('<div class="tooltip"><span style="border:1px solid red;color:red;  display:block; width:120px; line-height:15px; margin:5px 0 5px 0; font-size:12px; text-align:center;"></span></div>');
			/*if(value > comparedata){
				that.value = comparedata;
				$(pic).find("span").text("请输入正确的数量！");
				$(that).closest("td").append(pic);
				that.focus();		
			}else */if(presubQty>value){
				that.value = comparedata;
				$(pic).find("span").text("Maximum quantity and Item in stock cannot be less than the number of Order reserved to take up");
				$(that).closest("td").append(pic);
				that.focus();
			}							
		}else{
			that.value = comparedata;
			that.focus();
		}
}

var hideandcancel = function(){
	$(".alert_user").hide(50);
	$(".alert_shul").hide(50);
	$(".alert_shul1").hide(50);

};
