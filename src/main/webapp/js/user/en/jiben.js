$(document).ready(function(){
	jiben();
	tianjia();
	tianjia2();
	tianjia3();
	edituser();
	xuaze();
	gai();
	color();
});
//基本信息开始
var jiben=function(){
	$('.i1').attr('disabled','disabled');
	$('.te').attr('disabled','disabled');
};
//基本信息结束

// 权限页创建新角色
var tianjia=function(){
	$(".alert_user").hide();
	$(".b1").click(function(){
		$(".alert_user").show();
	});
	$(".b_colse").click(function(){
		$(".alert_user").hide();
	});
};



// 权限页创建新角色
var tianjia3=function(){
	$(".alert_user").hide();
	$(".w .box1 h2").click(function(){
		$(".alert_user").show();
	});
	$(".b_colse").click(function(){
		$(".alert_user").hide();
	});
};


// 奇偶行背景颜色
var color=function(){
	if($(".title_2").size()>0){
		$(".title_2").each(function(){
			$(".title_2 li:even").css("background","#f1f1f1");
		});
	}
};

//全选开始 
var xuaze=function(){
    $(".f_l").click(function(){
		var flg=this.checked;
		$(":checkbox[name='nn']").attr("checked",flg);
	});
	$(":checkbox[name='nn']").click(function(){
		$(".f_l").attr("checked",$(":checkbox[name='nn']").length==$(":checkbox"));
	});
};

//修改
var gai=function(){
	$(".span2").click(function(){
		$("#editDiv").show();
	});
};

//用户页创建新用户
var tianjia2=function(){
	$("#addDiv").hide();
	$(".btn1").click(function(){
		$("#addDiv").show();
	});
	$("#addDiv .w_close").click(function(){
		$("#addDiv").hide();
		$("#addForm")[0].reset();	
	});
	
	$("#addUser").click(function(){
		var nameVal = $.trim($("#name").val());
		$("#name").val(nameVal);
		if(nameVal.length<=0){
			alert("User name cannot be empty!");
			$("#name").focus();
			return;
		}
	    if(! new RegExp("^[A-Za-z0-9_\\@\\.\\-\\u4e00-\\u9fa5]+$").test(nameVal)){
	    	//English user name must be 3-26 characters
			 alert("User name can only by the Chinese, English, Numbers and '_', '@','.'");
			 return false;
		}
		if (!betweenLength(nameVal.replace(/[^\x00-\xff]/g, "**"), 4, 20)) {
			alert("User name must be 4-20 characters!");
			return false;
		}
		if (!betweenLength($.trim($("#password").val()).replace(/[^\x00-\xff]/g, "**"), 6, 20)) {
			alert("Password must be 6-20 characters!");
			return false;
		}
		if (!betweenLength($.trim($("#repassword").val()).replace(/[^\x00-\xff]/g, "**"), 6, 20)) {
			alert("Password must be 6-20 characters!");
			return false;
		}

		if($.trim($("#repassword").val())!=$.trim($("#password").val())){
			alert("Passwords inconsistent!");
			$("#repassword").focus();
			return;
		}	
		
		var roleVal = $.trim($("#roleId").val());
		if(roleVal.length<=0){
			alert("Role cannot be empty!");
			$("#roleId").focus();
			return;
		}
		$.ajax({
 	         type: "POST",
 	         dataType:"html",
 	         url: "./isPinEngaged",
 	         data: "pin="+nameVal,
 	         success: function (result) {			 
 	        	 if(result>0){
 	        	    alert("User name already existed!");
 	        	    return false;
 	        	 }else{
 	        		$("#addDiv").hide();
 	        		ajaxSubmit("#addForm");
 	        		//$("#addForm").submit();
 	        	 }
 	          }
	 	   });
	});
	$("#addUserCancel").click(function(){
		$("#addDiv").hide();
		$("#addForm")[0].reset();	
	});
};
//用修改用户
var edituser=function(){
	$("#editDiv").hide();
	$("#editDiv .w_close").click(function(){
		$("#editDiv").hide();
		$("#editForm")[0].reset();	
	});
	
	$("#userEidt").click(function(){
		var nameVal = $.trim($("#name1").val());
		if(nameVal.length<=0){
			alert("User name cannot be empty!");
			$("#name1").focus();
			return false;
		}
	   if(! new RegExp("^[A-Za-z0-9_\\@\\.\\-\\u4e00-\\u9fa5]+$").test(nameVal)){
		   alert("User name can only by the Chinese, English, Numbers and '_', '@','.'");
			 return false;
		}
		if (!betweenLength(nameVal.replace(/[^\x00-\xff]/g, "**"), 4, 20)) {
			alert("User name must be 4-20 characters!");
			return false;
		}
		if (!betweenLength($.trim($("#password1").val()).replace(/[^\x00-\xff]/g, "**"), 6, 20)) {
			alert("Password name must be 6-20 characters!");
			return false;
		}
		if (!betweenLength($.trim($("#repassword1").val()).replace(/[^\x00-\xff]/g, "**"), 6, 20)) {
			alert("Password name must be 6-20 characters!");
			return false;
		}

		if($.trim($("#password1").val())!=$.trim($("#repassword1").val())){
			alert("Passwords inconsistent!");
			$("#repassword").focus();
			return false;
		}	
		
		var roleVal = $.trim($("#roleId1").val());
		if(roleVal.length<=0){
			alert("Role cannot be empty!");
			$("#roleId1").focus();
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
    	        	 if(result>0){
    	        		  alert("User name already existed!");
    	        	    return false;
    	        	 }else{
	        			$("#editDiv").hide();
    	        		ajaxSubmit("#editForm");
    	        			//$("#editForm").submit();
    	        	 }
    	          }
   	 	   });
        }else{
        	$("#editDiv").hide();
    		ajaxSubmit("#editForm");
        	//$("#editForm").submit();
        }
			
	});
	$("#userEidtCancel").click(function(){
		$("#editDiv").hide();
		$("#editForm")[0].reset();	
	});
};
function betweenLength(str, _min, _max) {
    return (str.length >= _min && str.length <= _max);
 }
