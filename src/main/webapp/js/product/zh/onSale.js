
$(document).ready(function(){
	$(".close-box").live('click',closebox);
	$("#inv-edit-box .close-box").live('click', close_editinv_box);
	$("#stopReasonType").live('change',changeReasonType);
	$("#stopReason").live('keyup',goLimitCharacterNumber);
	clickSubmit(1);
	loadingBrand();
	$(".left_menu").each(function(){
		$(this).attr("class","p2");
	});

	$("#selectProdId").change(function(){
		var selectProdId = $("#selectProdId").val();
		var  matchnum = /^[0-9]*$/;
		if(!matchnum.test(selectProdId)){
			alert("商品id只能为数字！");
			$("#selectProdId").val("");
			$("#selectProdId").focus();
		}
	});

	/*  加载一级目录  */
	$.ajax({
		type : "post", 
		url : "../product/getFirstDisp", 
		success : function(msg) { 
			$.each(eval(msg),function(i,n){
				$("#firstcategory").append("<option value='"+n.catePubId+"'>"+n.pubNameCn+"</option>");
			});	
		}
	}); 



	/* 加载二级目录 */
	$("#firstcategory").change(function(){
		$("#secondcategory").empty();
		$("#thirdcategory").empty();
		$("#fourthcategory").empty();
		$.ajax({
			type : "post", 
			url : "../product/getOtherDisp", 
			data:"parCateDispId="+$(this).val(),
			success : function(msg) { 
				var fistdisplist="<option value=''>请选择</option>";
				$.each(eval(msg),function(i,n){
					fistdisplist+="<option value='"+n.catePubId+"'>"+n.pubNameCn+"</option>";
				});	
				$("#secondcategory").append(fistdisplist);
			}
		}); 
	});


	/* 加载三级目录 */
	$("#secondcategory").change(function(){
		$("#thirdcategory").empty();
		$("#fourthcategory").empty();
		$.ajax({
			type : "post", 
			url : "../product/getOtherDisp", 
			data:"parCateDispId="+$(this).val(),
			success : function(msg) { 
				var fistdisplist="<option value=''>请选择</option>";
				$.each(eval(msg),function(i,n){
					fistdisplist+="<option value='"+n.catePubId+"'>"+n.pubNameCn+"</option>";
				});	
				$("#thirdcategory").append(fistdisplist);
			}
		}); 
	});

	/* 加载四级目录 */
	$("#thirdcategory").change(function(){
		$("#fourthcategory").empty();
		$.ajax({
			type : "post", 
			url : "../product/getOtherDisp", 
			data:"parCateDispId="+$(this).val(),
			success : function(msg) { 
				var fistdisplist="<option value=''>请选择</option>";
				$.each(eval(msg),function(i,n){
					fistdisplist+="<option value='"+n.catePubId+"'>"+n.pubNameCn+"</option>";
				});	
				$("#fourthcategory").append(fistdisplist);
			}
		}); 
	});

	$("#all-selector").click(function(){
		if ($(this).attr("checked") == "checked") { // 全选 
			$("input[type='checkbox']").each(function() { 
				$(this).attr("checked", true); 
			}); 
		}else{ // 反选 
			$("#showListTbody input[type='checkbox']").each(function() { 
				$(this).attr("checked", false);

			});
		}

	});

	$("#showListTbody input[type='checkbox']").click(function(){
		if(this.checked == false){
			$("#all-selector").attr("checked", false);
		}else if($("#showListTbody input[type='checkbox']").length == $("#showListTbody input[type='checkbox']:checked").length){
			$("#all-selector").attr("checked", true);


		}
	});
});



//加载二级品牌
function loadingBrand(){
	var path = $("#host").val();
	$("#brands").change(
	function() {
		$("#subBrand").empty();
		$.ajax({
			type : "post",
			url : path+ "/product/getOtherBrand",
			data : "brandId="+ $(this).val(),
			success : function(msg) {
				if(msg.length>2){
					var fistBrandlist = "";
						$.each(eval(msg),function(i,n) {
							fistBrandlist += "<option value='"+ n.id+ "'>"+ n.nameCn + "</option>";
						});
						$("#subBrand").append(fistBrandlist).show();
				} else{
					$("#subBrand").hide();
				}
			}
		});
	});
}

/* 批量下架 */
function allUpType(s){
	var pid_array = new Array();
	$("input[name='topPro']:checked").each(function() {
		pid_array.push($(this).attr("id"));
	}); 
	
	if(s=="1"){
		proDown(pid_array.toString());
	}
	if(s=="2"){
		proUp(pid_array.toString());
	}
}	


function alertProductStopReason(productId){
	$("#stopReasonType").find('option:first').attr('selected', true);
	$('#boxwarn').text('');
	$("#alertProductStopReasonId").val('');
	$("#stopReason").val("");
	$("#stopReason").attr('disabled','disabled');
	var pid_array = new Array();
	if(productId==""||productId == undefined){
		$("input[name='topPro']:checked").each(function() {
			pid_array.push($(this).attr("id"));
		}); 
		if(pid_array.toString().length==0){
			alert("请先选择商品。");
			return false;
		}
	}else{
		pid_array.push(productId);
	}
	if(pid_array.length>0){
		var join=pid_array.join(",");
		$("#alertProductStopReasonId").val(join);
		$("#goout-box").css("display","block");
	}
}

function close_editinv_box() {
	$("#inv-edit-box").fadeOut();
}

function editInventory(pId, supplierId) {
	$.ajax({
		type : "GET",
		cache:false,
		url  : "../inventory/editInventory",
		data : "pId=" + pId + "&supplierId=" + supplierId,
		//data : "pId=223919539923729&supplierId=" + supplierId,
		dataType: 'html',
		success : function(msg) {
			if(msg == undefined) {
				alert("查询失败 ，请稍后再试。。");
			} else {
				$("#edit_inv_qty").html(msg);
				$("#inv-edit-box").css("display","block");
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("查询失败 ，请稍后再试。。");
		}
	});
}

function editInventorySubmit(pId, warehouseCode){
	var requestStr = "";
	var  matchnum = /^[0-9]*$/;

	var array = $("#showSkuQty input[name='editNotBatchQty']");
	for(var i=0,len=array.length;i<len;i++){
		var sku = $(array[i]).attr("sku");
		var skuName = $(array[i]).attr("skuName");
		var lockQty = Number($(array[i]).attr("lockQty"));
		var preSubQty = Number($(array[i]).attr("preSubQty"));
		var qty = Number($(array[i]).val());

		if(!matchnum.test(qty)){
			alert("库存数量必须是正整数！");
			return false;
		}

		if(qty < preSubQty+lockQty){
			alert("修改库存数量需大于等于订单占用数量！");
			return false;
		}

		if(i != 0) {
			requestStr += "^";
		}

		requestStr += sku+";"+skuName+";"+lockQty+";"+preSubQty+";"+qty;
	}

	$.ajax({
		type : "post",
		url  : "../inventory/saveEditInventory",
		data : {data: requestStr, pId: pId, warehouseCode: warehouseCode},
		dataType: 'html',
		success : function(msg) {
			if(msg == 'true') {
				alert("修改成功");
				close_editinv_box();
			} else {
				alert("修改失败 ，请稍后再试。。");
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("修改失败，请稍后再试。。");
		}
	});
}

/* 下架 */
function proDown(){
	var stopReasonType = $("#stopReasonType").val();
	if(stopReasonType=='其他'){
		stopReasonType = $('#stopReason').val();
	}
	//var stopReason = $('#stopReason').val();
	var pid = $('#alertProductStopReasonId').val();
	if(pid==null||pid==""){
		alert("选择数据再操作");
		return false;
	}else{
		if(stopReasonType==""){
			$('#boxwarn').text("请填写下架原因！");
			return false;
		}else{
			var pid_array = new Array();
			pid_array.push('pid='+pid);
			pid_array.push('stopReason='+stopReasonType);
			$.ajax({
				type : "post", 
				url : "updateProductTateByIds", 
				data:pid_array.join("&")+"&math="+Math.random(),
				success : function(msg) { 
					if(msg==1){
						alert("操作成功");
						$("#goout-box").css("display","none");
						clickSubmit();
					}else{
						alert("操作失败 ，请稍后再试");
					}
				}
			});
		}
	}
}
/* 上架 */
function proUp(pid){
	if(pid==null&&pid==""){
		alert("选择数据再操作");
		return false;
	}else{
		var pid_array = new Array();
		pid_array.push(pid);
		$.ajax({
			type : "post", 
			url : "upProductByIds", 
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
function getCate(){
	var cateId = "";
	var firstcategory =$("#firstcategory").val();
	var secondcategory = $("#secondcategory").val();
	var  thirdcategory = $("#thirdcategory").val();
	var fourthcategory  = $("#fourthcategory").val();
	if(fourthcategory!=""&&fourthcategory!=null){
		cateId = fourthcategory;
	}else if(thirdcategory!=""&&thirdcategory!=null){
		cateId = thirdcategory;
	}else if(secondcategory!=""&&thirdcategory!=null){
		cateId = secondcategory;
	}else{
		cateId=firstcategory;
	}
	return cateId;
}
function clickSubmit(page){
	/* 获取选中类目 */
	var status = $(".top").find(".list").find("a").attr("id");

	
	var productName =$.trim($("#findProductName").val());

	var productId = $.trim($("#selectProdId").val());
	
	
	var subId = $("#subSupplier").val();
	
	var brand = $("#brands").val();
	
	var subBrand = $("#subBrand").val();
	
	if(null!=subBrand && undefined != subBrand){
		brand = subBrand;
	}
	

	var  cate = getCate();

	var pro_array  = new Array();

	if(productName!=""){
		pro_array.push("productName="+productName);
	}
	if(productId!=""){
		pro_array.push("productId="+productId);
	}
	if(status!=""){
		pro_array.push("auditStatus="+status);
	}
	if(page!=""&&page!=undefined){
		pro_array.push("page="+page);
	}
	if(cate!=""&&cate!=undefined){
		pro_array.push("cate="+cate);
	}
	if(subId!=null&&subId!=undefined){
		pro_array.push("subId="+subId);
	}
	if(brand!=null&&brand!=undefined){
		pro_array.push("brandId="+brand);
	}

	$.ajax({
		async:false,
		type : "post", 
		url : "../product/getProductByConditions", 
		data:pro_array.join("&"),
		dataType:"html",
		success : function(msg) { 
			$("#c3").html(msg);
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("查询失败 ，请稍后再试。。");
		}
	}); 


}


function checkClick(statu){
	if(statu=='1'){
		$("#li_chushou").attr("class","list");
		$("#li_shenhe").removeClass("list");
		$("#li_meishenhe").removeClass("list");
		$("#li_xiajia").removeClass("list");
		$("#li_xinzeng").removeClass("list");
	}
	if(statu=='2'){
		$("#li_shenhe").attr("class","list");
		$("#li_chushou").removeClass("list");
		$("#li_meishenhe").removeClass("list");
		$("#li_xiajia").removeClass("list");
		$("#li_xinzeng").removeClass("list");
	}
	if(statu=='3'){
		$("#li_meishenhe").attr("class","list");
		$("#li_shenhe").removeClass("list");
		$("#li_chushou").removeClass("list");
		$("#li_xiajia").removeClass("list");
		$("#li_xinzeng").removeClass("list");
	}
	if(statu=='4'){
		$("#li_xiajia").attr("class","list");
		$("#li_shenhe").removeClass("list");
		$("#li_meishenhe").removeClass("list");
		$("#li_chushou").removeClass("list");
		$("#li_xinzeng").removeClass("list");
	}
	if(statu=='5'){
		$("#li_xinzeng").attr("class","list");
		$("#li_xiajia").removeClass("list");
		$("#li_shenhe").removeClass("list");
		$("#li_meishenhe").removeClass("list");
		$("#li_chushou").removeClass("list");
	}
}





function getDownProduct(s){
	var pro_array  = new Array();
	pro_array.push("auditStatus="+s);
	$.ajax({
		type : "post", 
		url  : "../product/getProductByConditions", 
		data : pro_array.join("&"),
		dataType: "html",
		success : function(msg) { 
			checkClick(s);
			$("#c3").html(msg);
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("查询失败，请稍后再试。。");
		}
	}); 

}



//page  页数  istate 是否上架 0 否，1 是  statu 
//审核状态:0-待审核/审核中 1-审核不通过 2-审核通过 3-无效记录 4-审核中、5 新增的商品（待修改）
function getPage(page){
	clickSubmit(page);
}

//上架
function getProUp(){
	window.location.href="getProUp";
}


var closebox = function(){
//	close-box
	$("#goout-box").fadeOut();
};

//控制文本框的是否可操作
var changeReasonType = function(){
	var stopReasonType = $("#stopReasonType").val();

	if(stopReasonType == '其他'){
		$("#stopReason").removeAttr("disabled");
	}else{
		$("#stopReason").val("");
		$("#stopReason").attr('disabled','disabled');
		
	}
};

function showmsg(msg){
	$("#showmsgplat").empty();
	$("#showmsgplat").html(msg);
	$(".alert_user3").show();
}

function goLimitCharacterNumber(){
	var stopReason =  $('#stopReason').val();
	var num =stopReason.length;
	if(num>=100){
		stopReason=stopReason.substr(0,100); 
    	$('#stopReason').val(stopReason);
    	$('#boxwarn').text("最多可为100个字符！");
	}else{
		$('#boxwarn').text("");
	}	
}  