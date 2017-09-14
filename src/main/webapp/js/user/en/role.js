$(document).ready(function(){
	addRole();
	editRole();
	xuaze();
	color();
});
//基本信息开始


// 奇偶行背景颜色
var color=function(){
	$(".title_2 li").each(function(){
		$(".title_2 li:even()").css("background","#f1f1f1")
	})
}

//全选开始 
var xuaze=function(){
    $(".f_l").click(function(){
		var flg=this.checked
		$(":checkbox[name='nn']").attr("checked",flg);
	});
	$(":checkbox[name='nn']").click(function(){
		$(".f_l").attr("checked",$(":checkbox[name='nn']").length==$(":checkbox"))
	});
}
//全选结束

//用户页创建新用户
var addRole=function(){
	$("#add_div").hide();
	$("#addbutton").click(function(){
		$("#add_div").show();
	})
	$("#add_div .w_close").click(function(){
		$("#add_div").hide();
		$("#addForm")[0].reset();	
	})
	
	$("#addBtn").click(function(){
		
		var nameVal = $.trim($("#name").val());
		$("#name").val(nameVal);
		if(nameVal.length<=0){
			  alert("Role name cannot be empty!");
			$("#name").focus();
			return;
		}
		 if(nameVal=="Sub-Supplier"||nameVal=="子供应商"){
	      	    alert("System reserved role, please do not create!");
	      	    return;
	     }
		/*if(! new RegExp("^[A-Za-z0-9_\\@\\.\\-\\u4e00-\\u9fa5]+$").test(nameVal)){
			 alert("角色名只能由中文、英文、数字及“_”、“@”、“.”组成");
			 return false;
		}*/
		if (!betweenLength(nameVal.replace(/[^\x00-\xff]/g, "**"), 4, 20)) {
			alert("Role name must be 4-20 characters!");
			return false;
		}
		$.ajax({
 	         type: "POST",
 	         dataType:"html",
 	         url: "./isPinEngaged",
 	         data: "pin="+nameVal,
 	         success: function (result) {
 	        	 if(result==-1){
	        		  alert("System reserved role, please do not create!");
	        	    return false;
	        	 }
 	        	 if(result>0){
 	        		  alert("Role name already existed!");
 	        	    return false;
 	        	 }else{
 	        		 $("#add_div").hide();
	        		 ajaxSubmit("#addForm");
 	        	 }
 	          }
	 	   });
	})
	$("#addBtnCancel").click(function(){
		$("#add_div").hide();
		$("#addForm")[0].reset();	
	})
}
//用修改用户
var editRole=function(){
	$("#edit_div").hide();
	
	$("#edit_div .w_close").click(function(){
		$("#edit_div").hide();
		$("#editForm")[0].reset();	
	})
	
	$("#editBtn").click(function(){
		var flag=true;
		var nameVal =$.trim($("#name1").val());
		$("#name1").val(nameVal);
		if(nameVal.length<=0){
		    alert("Role name cannot be empty");
			$("#name1").focus();
			return;
		}
		if (!betweenLength(nameVal.replace(/[^\x00-\xff]/g, "**"), 4, 20)) {
			alert("Role name must be 4-20 characters!");
			return false;
		}
		var hiddenName=$.trim($("#hiddenName").val());
		var newName=$.trim($("#name1").val());
        if(hiddenName!=newName){
        	$.ajax({
    	         type: "POST",
    	         dataType:"html",
    	         url: "./isPinEngaged",
    	         data: "pin="+newName,
    	         success: function (result) {
    	        	 if(result==-1){
   	        		  alert("System reserved role, please do not create!");
   	        	    return false;
   	        	 }
    	        	 if(result>0){
    	        		  alert("Role name already existed!");
    	        	    return false;
    	        	 }else{
    	        		 $("#edit_div").hide();
    	        		 ajaxSubmit("#editForm");
    	        	 }
    	          }
   	 	   });
        }else{
        	 $("#edit_div").hide();
    		 ajaxSubmit("#editForm");
        }
		
		
	})
	$("#editBtnCancel").click(function(){
		$("#edit_div").hide();
		$("#editForm")[0].reset();	
	})
}
function betweenLength(str, _min, _max) {
    return (str.length >= _min && str.length <= _max);
 }


