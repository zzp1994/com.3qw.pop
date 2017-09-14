var  CONTEXTPATH  = $("#conPath").val();

$(document).ready(function(){
	clickSubmit(0);
});

/*	查询条件	*/
//page  页数  istate 是否上架 0 否，1 是  statu 
//审核状态:0-待审核/审核中 1-审核不通过 2-审核通过 3-无效记录 4-审核中、5 新增的商品（待修改）
function clickSubmit(page){

	var pro_array  = new Array();
	
	if(page!=""&&page!=undefined){
		pro_array.push("page="+page);
	}
	
	$.ajax({
		type : "post", 
		url : CONTEXTPATH+"/product/getPurchasePriceByConditions", 
		data:pro_array.join("&"),
		dataType:"html",
		success : function(msg) { 
			$("#c3").html(msg);
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(errorThrown);
			alert("对不起，数据异常请稍后再试!");
		}
	}); 


}
