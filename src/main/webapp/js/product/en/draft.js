
$(document).ready(function(){
	clickSubmit(1);
});


function clickSubmit(page){

	$.ajax({
		async:false,
		type : "post", 
		url : "../product/getProductDrafts", 
		data:"page="+page,
		dataType:"html",
		success : function(msg) { 
			$("#c3").html(msg);
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("error");
		}
	}); 


}

function proDel(id){
	
	$.dialog.confirm('Want to delete?', function(){
			$.ajax({
				type : "post", 
				url : "deleteDraft", 
				data:"id="+id,
				success : function(msg) { 
					if(msg==1){
						alert("success");
						clickSubmit(1);
					}else{
						alert("error");
					}
				}
			});
		}, function(){
		});
}



function getDownProduct(){
	$.ajax({
		type : "post", 
		url  : "../product/getProductDrafts", 
		dataType: "html",
		success : function(msg) { 
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
