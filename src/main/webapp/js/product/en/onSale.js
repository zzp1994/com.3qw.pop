$(document).ready(function(){
	$(".close-box").live('click',closebox);
	$("#stopReasonType").live('change',changeReasonType);
	$("#stopReason").live('keyup',goLimitCharacterNumber);
	$(".left_menu").each(function(){
		$(this).attr("class","p2");
	});


	clickSubmit(1);

	$("#selectProdId").change(function(){
		var selectProdId = $("#selectProdId").val();
		var  matchnum = /^[0-9]*$/;
		if(!matchnum.test(selectProdId)){
			alert("Only numbers can be entered in productId！");
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
				$("#firstcategory").append("<option value='"+n.catePubId+"'>"+n.pubName+"</option>");
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
				var fistdisplist="<option value=''>please select</option>";
				$.each(eval(msg),function(i,n){
					fistdisplist+="<option value='"+n.catePubId+"'>"+n.pubName+"</option>";
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
				var fistdisplist="<option value=''>please select</option>";
				$.each(eval(msg),function(i,n){
					fistdisplist+="<option value='"+n.catePubId+"'>"+n.pubName+"</option>";
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
				var fistdisplist="<option value=''>please select</option>";
				$.each(eval(msg),function(i,n){
					fistdisplist+="<option value='"+n.catePubId+"'>"+n.pubName+"</option>";
				});	
				$("#fourthcategory").append(fistdisplist);
			}
		}); 
	});


	$("#showListTbody input[type='checkbox']").click(function(){
		if(this.checked == false){
			$("#all-selector").attr("checked", false);
		}else if($("#showListTbody input[type='checkbox']").length == $("#showListTbody input[type='checkbox']:checked").length){
			$("#all-selector").attr("checked", true);


		}
	})
});

/* 批量下架 */
function allUpType(){
	var pid_array = new Array();
	$("input[name='topPro']:checked").each(function() {
		pid_array.push($(this).attr("id"));
	}); 
	proDown(pid_array.toString());
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
			alert("please select product。");
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


/* 下架 */
function proDown(){
	var stopReasonType = $("#stopReasonType").val();
	if(stopReasonType=='其他'){
		stopReasonType = $('#stopReason').val();
	}
	var stopReason = $('#stopReason').val();
	var pid = $('#alertProductStopReasonId').val();
	if(pid==null||pid==""){
		alert("please select product");
		return false;
	}else{
		if(stopReasonType==""){
			$('#boxwarn').text("Please fill in the reason!");
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
						alert("success");
						$("#goout-box").css("display","none");
						clickSubmit();
					}else{
						alert("error");
					}
				}
			});
		}
	}
}
/* 下架 */
/*function proDown(pid){
	if(pid==null||pid==""){
		alert("please select product");
		return false;
	}else{
		var pid_array = new Array();
		pid_array.push(pid);
		$.ajax({
			type : "post", 
			url : "updateProductTateByIds", 
			data:"pid="+pid_array.join(","),
			success : function(msg) { 
				if(msg==1){
					alert("success");
					clickSubmit();
				}else{
					alert("error");
				}
			}
		});
	}
}*/
/* 上架 */
function proUp(pid){
	if(pid==null&&pid==""){
		alert("please select");
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
					alert("success");
					clickSubmit();
				}else{
					alert("please select");
				}
			}
		});
	}
}
/* 删除 */
function prodel(pid){
	if(pid==null&&pid==""){
		alert("please select");
		return false;
	}else{
		if(confirm("Want to delete?")){
			deleteProduct(pid);
		};
	}



	function deleteProduct(pid){
		var pid_array = new Array();
		pid_array.push(pid);
		$.ajax({
			type : "post", 
			url : "deletePros", 
			data:"pid="+pid_array.join(","),
			success : function(msg) { 
				if(msg==1){
					alert("success");
					clickSubmit();
				}else{
					alert("error");
				}
			}
		});

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

	var  cate = getCate();
	
	var subId = $("#subSupplier").val();
	
	var brand = $("#brands").val();
	
	var subBrand = $("#subBrand").val();
	
	if(null!=subBrand && undefined != subBrand){
		brand = subBrand;
	}
	
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
			alert("error");
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
			alert("error");
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
    	$('#boxwarn').text("Reason must be 1-100 characters");
	}else{
		$('#boxwarn').text("");
	}	
}  