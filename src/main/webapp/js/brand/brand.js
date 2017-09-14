$(document).ready(function(){
/*	jiben();
	tianjia();
	tianjia2();
	tianjia3();
	edituser();
	xuaze();
	gai();
	color();*/
});
function addBrand(){
	window.location.href="../brand/toAddUI";
};
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
	$(".title_2 li").each(function(){
		$(".title_2 li:even").css("background","#f1f1f1");
	});
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
	$(".btn1").on("click",function(){
		window.location.href="../brand/toAddUI";
	});
	
};
//用修改用户
var edituser=function(){
	$("#editDiv").hide();
	$("#editDiv .w_close").click(function(){
		$("#editDiv").hide();
		$("#editForm")[0].reset();	
	});
	
	$("#userEidtCancel").click(function(){
		$("#editDiv").hide();
		$("#editForm")[0].reset();	
	});
};
function betweenLength(str, _min, _max) {
    return (str.length >= _min && str.length <= _max);
 }
