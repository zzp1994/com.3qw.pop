var host = '';

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}

$(document).ready(function(){
	shous();
	ann();
	chushou();
	host = $("#host").val();
	mchu();
//	xuaze();
	//xuaze1();
	ann1();
//	window.onerror = function(event) {
//	     alert(event);
//	     return true; 
//	}
	$(document).keydown(function (e) {
        var doPrevent;
        if (e.keyCode == 8||e.keyCode==13) {   //注：8为Backspace键，13为Enter键
            var d = e.srcElement || e.target;
            if (d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA') {
                doPrevent = d.readOnly || d.disabled;
            }
            else
                doPrevent = true;
        }
        else
            doPrevent = false;

        
        if (doPrevent)
            e.preventDefault();
     }); 
 
	
	$.ajaxSetup({
	       contentType:"application/x-www-form-urlencoded;charset=utf-8",
	       complete:function(XMLHttpRequest,textStatus){
		       var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); 
		        if(sessionstatus=="timeout"){  
		        	alert("登录超时，请重新登录！");
		        	//    alert("Login Timeout, please log in again！");
		        	location.href="../user/logout";
		        }  
	       }
	});
	
	
//	$('#go').live('input propertychange', function() {
	//	 var  matchnum = /^[0-9]*$/;
	//	 var val = $("#go").val();
	//	    if(!matchnum.test(val)){
	//	    	$("#go").val("");
	//	     }
	//	});
});


//表单重置
function resetfm(){
	$("form input[type='text']").each(function(){
		$(this).val("");
	});
	$('form').find('select').each(function () {
		$(this).find('option:first').attr('selected', true);
	});
	$('form').find('#reloadspan').each(function () {
		  $(this).remove();
	});
}



//退出
function clearCookie(){
	window.parent.location=host+"/user/logout";
	
}
//订单
function getAllOrder(){
	window.parent.location=host+"/order/getOrder";
	
}

//结算订单
function goBalanceOrderListPage() {
	window.parent.location=host+"/order/balanceOrderList";
}

function goOrderListPage() {
	window.parent.location=host+"/order/getOrder";
}
//发布
function addProduct(){
	window.parent.location=host+"/product/selectCategory";
}
//发布幸福购商品
function addXfProduct(){
	window.parent.location=host+"/product/selectCategory2";
}

//商品
function getProduct(){
	window.parent.location=host+"/product/onSaleList";
}

//POP商品
function getPOPProduct(){
	window.parent.location=host+"/product/onSaleList";
}

////POP导入商品
//function getPOPImportProduct(){
//	window.parent.location=host+"/product/getImportPro";
//}

//库存
function getInventory(){
	window.parent.location=host+"/inventory/getInventory";
}
//品牌
function getBrand(){
	window.parent.location=host+"/brand/getBrand";
}
//商品发布草稿箱
function getDrafts(){
	window.parent.location=host+"/product/draftList";
}
//模板管理
function getManagementModle(){
	window.parent.location=host+"/modle/getManagementModle";
}

// start 左边导航收缩、展开 
var shous=function(){
var ap=$(".list_box .demo .p1");
		var bp=$(".list_box .demo .p_b");
		$(".list_box .demo .p1").each(function(index){
			$(this).click(function(){
				if($(bp[index]).css("display")=="block"){
					$(this).addClass("djt2");
					$(this).removeClass("p1");
					$(bp[index]).slideUp(200);
				}else{
					$(this).removeClass("djt2");
					$(this).addClass("p1");
					$(bp[index]).slideDown(200);
				}
			})
		})

};
// end 左边导航收缩、展开

//全部清空按钮的value值开始
var ann=function(){
	var t=$(".text1").val();
	$("#czhi").click(function(){
		$(".text1").val('');
	});
};
//全部清空按钮的value值结束

var ann1=function(){
	$(".il").attr("disabled","disabled");
	$('.t5').on('click',function(){
		if($(this).text()=="修改"){ 
			$(this).siblings('td').find('input').removeAttr("disabled").css('border','1px solid #fa4b00') 
			$(this).text("保存");
		}else{
			$(".il").attr("disabled","disabled");
			$(this).siblings('td').find('input').css('border','none')
			$(this).text("修改");
		}
	   }); 
};





//出售中的商品开始
var chushou=function(){
	$(".top li").each(function(index){
		$(this).click(function(){
			var i = $(this).index();
		    $(this).addClass('list').siblings().removeClass('list');
			$(".c5_box .qb:eq("+index+")").show().siblings().hide();
			
		})
	})
}
//出售中的商品结束

//已卖出的货品开始
var mchu=function(){
	
	$(".c22 .top li").each(function(index){
		$(this).click(function(){
			var i = $(this).index();
			if($(this).attr("id") == "suoyou"){
				$("#statusList").show();
				$(".p2 select").show();
			}else{
				$("#statusList").hide();
				$(".p2 select").hide();
			}
		    $(this).addClass('list').siblings().removeClass('list');
			$(".c3 table:eq("+index+")").show().siblings().hide();
			
		})
	});
}
//出售中的商品-已卖出的货品结束
//已卖出的货品开始

//全选开始 
//	var xuaze=function(){
//	    $(".f_l").click(function(){
//			var flg=this.checked;
//			$(":checkbox[name='nn']").attr("checked",flg);
//		});
//		$(":checkbox[name='nn']").click(function(){
//			$(".f_l").attr("checked",$(":checkbox[name='nn']").length==$(":checkbox"))
//		});
//	}
	
	/*var xuaze1=function(){
	    $(".gg").click(function(){
			var flg=this.checked
			$(":checkbox[name='nn']").attr("checked",flg);
		});
		$(":checkbox[name='nn']").click(function(){
			$(".gg").attr("checked",$(":checkbox[name='nn']").length==$(":checkbox"))
		});
	}*/
//全选结束


