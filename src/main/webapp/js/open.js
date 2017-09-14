$(document).ready(function(){	
	atopPro();
	chushou();
	mchu();
	jiben();
	xuaze();	
});

$(document).ready(function(){
	 $.ajaxSetup({
        contentType:"application/x-www-form-urlencoded;charset=utf-8",
        complete:function(XMLHttpRequest,textStatus){
	       var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); 
	        if(sessionstatus=="timeout"){
	        	tipMessage("登录超时，请重新登录！",function(){
	        		location.href="../user/logout";
	        	});
	        } /* else{
	        	$("#load-div").show(20);
	        }*/
        }
	 });
/*	 $(document).ajaxComplete(function() {
		 setTimeout(function () {
			 $("#load-div").hide(30);
		    }, 2000);
		});*/
	 $('#go').bind('input propertychange', function() {
		 var  matchnum = /^[0-9]*$/;
		 var val = $("#go").val();
		    if(!matchnum.test(val)){
		    	$("#go").val("");
		     }
		});	 
});

function showloadpage(){
	
}

//表单重置
function resetfm(){
	$("form input[type='text']").each(function(){
		$(this).val("");
	});
	$('form').find('select').each(function () {
		  $(this).find('option:first').attr('selected', true);
	});
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
//清空按钮的value值开始
var atopPro=function(){
	var t=$(".text1").val();
	$("#czhi").click(function(){
		$(".text1").val('');
	});
};
//清空按钮的value值结束

/*var atopPro1=function(){
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
};*/




//出售中的商品开始
var chushou=function(){
	$(".top li").each(function(index){
		$(this).click(function(){
			var i = $(this).index();
		    $(this).addClass('list').siblings().removeClass('list');
			$(".c5_box .qb:eq("+index+")").show().siblings().hide();
			
		})
	});
}


//已卖出的货品开始
var mchu=function(){
	$(".c22 .top li").each(function(index){
		$(this).click(function(){
			var i = $(this).index();
		    $(this).addClass('list').siblings().removeClass('list');
			$(".c3 table:eq("+index+")").show().siblings().hide();
			
		})
	});
}
//出售中的商品-已卖出的货品结束


//选择分类开始
/*var fenlei=function(){
	$('.s2 ul li').on('click',function(){
		var xt = $(this).text();
		console.log(xt);
		$('.app').append(xt+'&nbsp;>&nbsp;'); 
		var ht = $('.app').html(); 
	})
	
	$(".s2 ul li").on("click",function(){
		 $(".y").show()
	})
	$(".y").on("click",function(){
		 $(".z").show()
	})
}*/
//选择分类结束




//基本信息开始
var jiben=function(){
	$('.i1').attr('disabled','disabled');
	$('.te').attr('disabled','disabled');
	$('.fabu_btn').on('click',function(){
		$('.i1').removeAttr('disabled');
		$('.te').removeAttr('disabled');
	});	
}
//基本信息结束


//全选开始 
	var xuaze=function(){
	    $(".f_l").click(function(){
			var flg=this.checked
			$(":checkbox[name='topPro']").attr("checked",flg);
		});
		$(":checkbox[name='topPro']").click(function(){
			$(".f_l").attr("checked",$(":checkbox[name='topPro']").length==$(":checkbox"))
		});
	}
	
		/*var xuaze1=function(){
	    $(".gg").click(function(){
			var flg=this.checked
			$(":checkbox[name='topPro']").attr("checked",flg);
		});
		$(":checkbox[name='topPro']").click(function(){
			$(".gg").attr("checked",$(":checkbox[name='topPro']").length==$(":checkbox"))
		});
	}*/
//全选结束
var xiug3=function(){
	$('.tq4').hide();
	$(".cp1").click(function(){
		$(".tq2").show();
		$(".tqz .tq4").hide();
		$(".g").hide();
	});
	$(".cp2").click(function(){
		$(".tqz .tq2").hide();
		$(".tqz .tq4").show();
		$(".g").show();
	});
}
//修改商品结束




//经销商-买家中心-合并提交订单开始
/*var heb=function(){
	$(".c3 .two .two2").hide();
	$(".sm").click(function(){
		$(".c3 .two .two2").show();
		$(".two").css("border","2px solid #ff4f00");
	});	
}
*/
//经销商-买家中心-合并提交订单结束
function clearCookie(url){
	window.parent.location=url;
}
