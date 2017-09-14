$(document).ready(function(){
	$(".chim").delegate("input", "change", changebox);
	$(".yanse").delegate("input", "change", changebox);
	$(".yanse").delegate("input", "change", changeimg);
	$("#same_price").bind("change",sameprice);
	$("table input").live("input propertychange", checknum);
	$(".jinben .operate .toleft").live('click', pre);
	$(".jinben .operate .toright").live('click', next);
 	$(".jinben .operate .del").live('click' , dele);
	$(".b2 input").live("blur",numpricecheck);

	$("#pic_sku").attr("checked","checked");
   $(".tq2").hide();
//    xiug();
	xiug1();
	xiug3();
	loadingBrand();
	saveProduct();
});

//全部发布商品开始
var xiug=function(){
	$(".i_box .jia").click(function(){
		$('.bb').append( "<p class='addP' style='margin-left:20px;'><input type='text' name='start' value='' style='width:50px;'> ：<input type='text' name='pic' value='' style='width:198px;'> <span class='del'>删除</span></p>" );
	});
	$(document).on('click','.del',function(){
		$(this).parent('.addP').remove();
	})

}
var xiug1=function(){
	$(".b3").click(function(){
		$('.pp').append( "<span class='b2'>起批量：<input type='text' name='start' value=''> 件以上 <input type='text' name='pic' value=''> 元/件<span class='del'> 删除</span></span>" );
	});
	$(document).on('click','.del',function(){
		$(this).parent('.b2').remove();
	})

}

var xiug3=function(){
	$(".cp1").click(function(){
		$(".tq2").show();
		$(".tab_box").hide();
		
	});
	$(".cp2").click(function(){
		$(".tq2").hide();
		$(".tab_box").show();
	});
}

//验证信息
function saveProduct(){
	
		$(".fabu_btn").click(function(){
		var submit = true;
		if($(".yanse2 input[type='checkbox']:checked").length==0){
			$(".yanse2 ").children(".dpl-tip-inline-warning").css("display","inline");
			submit = false;
		}
		if($(".chim2 input[type='checkbox']:checked").length==0){
			$(".chim2 ").children(".dpl-tip-inline-warning").css("display","inline");
			submit = false;
		}
		var obj = $(".cont input[required='required']");
		$.each(obj,function(i,item){
			if(item.value == ""){
				submit = false;
				$(item).parent().children(".dpl-tip-inline-warning").css("display","inline");
			}else{
				$(item).parent().children(".dpl-tip-inline-warning").css("display","none");
			}
		})
		var mingxitext= $(".mingxi textarea[required='required']");
		$.each(mingxitext,function(i,item){
			if(item.value == ""){
				submit = false;
				$(item).parent().next().css("display","inline");
			}else{
				$(item).parent().next().css("display","none");
			}
		})
		var mingxiinput= $(".mingxi input[required='required']");
		$.each(mingxiinput,function(i,item){
			if(item.value == ""){
				submit = false;
				$(item).parent().next().css("display","inline");
			}else{
				$(item).parent().next().css("display","none");
			}
		})
		
		
		var productinfo = $("#productinfo").val();
		if(productinfo.length>30){
			$("#productinfo").next().css("display","inline");
			$("#productinfo").next().text("商品标题不能大于30个字");
			submit = false;
		}
		var servicephone = $("#servicephone").val();
		var reg = new RegExp("^[0-9]{11}$");  
		if (!reg.test(servicephone)) {
			$("#servicephone").parent().next().css("display","inline");
			$("#servicephone").parent().next().text("服务电话只能是数字");
			$("#servicephone").focus();
		}
		if(submit){
			// 提交数据库
			$(".fabu_btn").submit();
		}
	
	
	});
	}

//加载二级品牌
function loadingBrand(){
	var path = $("#host").val();
	$("#firstcategory").change(
	function() {
		$("#secondcategory").empty();
		$.ajax({
			type : "post",
			url : path+ "/product/getOtherBrand",
			data : "brandId="+ $(this).val(),
			success : function(msg) {
				if(msg.length>2){
				var fistBrandlist = "";
					$.each(eval(msg),function(i,n) {
						fistBrandlist += "<option value='"+ n.id+ "'>"+ n.nameCn + "</option>";});
					$("#secondcategory").append(fistBrandlist);
				} 
			}
		});
	});
}

function numpricecheck(){
	var value1 = "";
	var value2 = "";
	$(".tq2 .dpl-tip-inline-warning").text("").hide();

	if ($(".pp .b2").length>1){
		$.each($(".pp .b2"),function(i,item){
			var object = $(item);
			if((!RegExp("^\\d*\\.?\\d+$").test(object.children()[0].value)&&object.children()[0].value!="")|| (!RegExp("^\\d*\\.?\\d+$").test(object.children()[1].value)&&object.children()[1].value!="")){
				$(".tq2 .dpl-tip-inline-warning").text("必须填入数字。").show();
				return;
			}
			if(i>0){
				var value11 = parseFloat(object.children()[0].value);
				var value22 = parseFloat(object.children()[1].value); 
				if(value1 < value11 && value2 > value22){
					value1 = value11;
					value2 = value22;
				}else if(value1 >= value11){
					$(".tq2 .dpl-tip-inline-warning").text("价格区间的数量必须后者大于前者。").show();
					return;
				}else{
					$(".tq2 .dpl-tip-inline-warning").text("产品单价必须下面价格小于上面价格").show();
				}
				
			}else{

				value1 = parseFloat(object.children()[0].value);
				value2 = parseFloat(object.children()[1].value);
			}
		})
	}else{
		var object = $($(".pp .b2")[0]);
		if((!RegExp("^\\d*\\.?\\d+$").test(object.children()[0].value)&&object.children()[0].value!="")|| (!RegExp("^\\d*\\.?\\d+$").test(object.children()[1].value)&&object.children()[1].value!="")){
			$(".tq2 .dpl-tip-inline-warning").text("必须填入数字。").show();
			return;
		}
	}
	
}

function checknum(event){
	var mm = event.target;
	var str =  mm.value;
	if(!RegExp("^\\d*\\.?\\d+$").test(str)){
		setTimeout(function(){mm.value="";},500);
		//$(mm).delay(100000000).val("");
	}
}

//图片处理函数
function pre(event) {
	var but = event.target;
	var li = $(but).parent().parent();
	var id = li.attr("class");
	var theimg = li.find("img");
	var src = theimg.attr("src");
	var filename = theimg.attr("filename");
	var type = theimg.attr("imgtype");
	if (src != null && id != "img-1") {
		if (li.prev().children(".p-img").children().is("img")) {
			var imgboxpre = li.prev().children(".p-img").children("img");
			li.prev().children(".p-img").empty().append(theimg);
			li.children(".p-img").empty().append(imgboxpre);
		} else {
			li.find(".operate").hide();
			li.prev().children(".p-img").empty().append(theimg);
			li.prev().children(".operate").show();
		}    
	} else {
		return false;
	}
}

function next(event) {
	var but = event.target;
	var li = $(but).parent().parent();
	var id = li.attr("class");
	var theimg = li.find("img");
	var src = theimg.attr("src");
	var filename = theimg.attr("filename");
	var type = theimg.attr("imgtype");
	if (src != null && id != "img-6") {
		if (li.next().children(".p-img").children().is("img")) {
			var imgboxnext = li.next().children(".p-img").children("img");
			li.next().children(".p-img").empty().append(theimg);
			li.children(".p-img").empty().append(imgboxnext);
		} else {
			li.find(".operate").hide();
			li.next().children(".p-img").empty().append(theimg);
			li.next().children(".operate").show();
		}
		
	} else {
		return false;
	}
}

function dele(event) {
	var but = event.target;
	var li = $(but).parent().parent();
	var theimg = li.find("img");
	var src = theimg.attr("src");
	if (src != null) {
		li.find(".operate").hide();
		theimg.parent().empty()
	} else {
		return false;
	}
}

var tableInfo=[];

function changeimg(event){
	var obj = event.target;
	var id = obj.id;
	var value = obj.value;
	if(obj.checked){		
		var p_img = $("<div class='p-img'></div>");
		var operate =$("<div class='operate'><i class='toleft'>左移</i><i class='toright'>右移</i><i class='del'>删除</i></div>");
		var img1 = $("<li class='img-1'></li>").append(p_img.clone()).append(operate.clone());
		var img6 = $("<li class='img-6'></li>").append(p_img.clone()).append(operate.clone());
		var img = $("<li></li>").append(p_img.clone()).append(operate.clone());
		var ul = $("<ul id='"+ id +"_img'></ul>").append(img1).append(img.clone()).append(img.clone()).append(img.clone()).append(img).append(img6);
		var div = $("<div></div>").append("<div class='wenzi'>"+value+"的图片:<input id='"+ id +"_upload' name='button' type='submit'  value='图片上传' /></div>").append(ul);
		var obj = $("<div class='z' id='" + id +"_xianshi'></div>").append(div);
		$(".jinben").append(obj);
		if (flashDetect()) { // 探测到已经安装了flash插件 则初始化上传按钮和提示
        // 初始化swfUpload组件
	        $("#"+id+"_upload").uploadify({
	            // File Upload Settings
	            'height': 30,
	            'swf': '../js/uploadify/uploadify.swf',
	            'uploader': '../product/imageUp',
	            'width': 100,
	            'cancelImg': '../js/img/uploadify-cancel.png',
	            'auto': true,
	            'buttonText': '上传图片',
	            file_size_limit: "1024K",
	            file_queue_limit: 6,
	            fileTypeExts: '*.gif;*.jpg;*.jpeg;*.png',
	            file_types: "*.jpg;*.png;*.jpeg;",
	            file_types_description: "*.jpg;*.jpeg;*.png;*.JPG;*.JPEG;*.PNG;",

	            file_dialog_start_handler: fileDialogStart,
	            file_queued_handler: fileQueued,
	            file_queue_error_handler: fileQueueError,
	            file_dialog_complete_handler: fileDialogComplete,
	            upload_start_handler: uploadStart,
	            upload_progress_handler: uploadProgress,
	            upload_error_handler: uploadError,
	            upload_success_handler: uploadSuccess,
	            upload_complete_handler: uploadComplete,
	            queue_complete_handler: queueComplete
	        });
	        //$("#file_upload").append('<span class="upload-tip">一次可选6张图片哦～</span>');
	    } else { // 探测到没有flash支持，给出提示。
	        $(".ifile").html('<span class="no-flash-tip">' +
	        'Hi，您的浏览器OUT了，它未安装新版的Flash Player，' +
	        '<a href="http://get.adobe.com/flashplayer/" target="_blank">去安装>></a>' +
	        '</span>');
	    }
	}else{
		var ss = document.getElementById(id+"_xianshi");
		ss.parentNode.removeChild(ss);
		//$("#" + id + "_xianshi").html("");
	}
}


function sameprice(event){
	var but = event.target;
	var obj = $("#tb-speca-quotation tbody .pro_price");
	if (but.checked){
		if(obj.length > 1){
			var price = obj[0].value;
			$.each(obj,function(i,item){
				item.value = price;
				if(i>0){
					$(this).attr("readonly","readonly");
				}
				
			})
			$(obj[0]).bind("input propertychange", changeprice);
		}	
	}else{
		if(obj.length > 1){
			$.each(obj,function(i,item){
				if(i>0){
					$(this).removeAttr("readonly");
				}
				
			})
			$(obj[0]).unbind("input propertychange", changeprice);
		}
	}
}

function changeprice(event){
	var value = event.target.value;
	var obj = $("#tb-speca-quotation tbody .pro_price");
	if(obj.length > 1){
		var price = obj[0].value;
		$.each(obj,function(i,item){
			item.value = price;		
		})
	}
}

function changebox(event){	
	var chim = $(".chim input:checked");
	var yanse = $(".yanse input:checked");
	var chimlen = chim.length;
	var yanselen = yanse.length;
	if(yanselen == 0 && chimlen == 0){
		$("#tb-speca-quotation").hide();
		return;
	}

	tableInfo = _fStoreTableInfo();
	$("#tb-speca-quotation tbody").remove();
	document.getElementById("same_price").checked = false;
	$("#tb-speca-quotation").show();	
	

	if(yanselen == 0){
		var tbody = $("<tbody></tbody>");
		var tr = $("");
		$.each(chim,function(i,n){
			if(i == 0){
				tr = $("<tr ><td id='' class='yan' rowspan='"+ chimlen +"'></td><td class='chi'>"+ n.value +"</td><td>" +
						"<input class='pro_price' name='productPic' type='text'></td><td><a>设置</a></td></tr>")
			}else{
				tr = $("<tr><td class='chi'>"+ n.value +"</td><td>" +
						"<input class='pro_price' name='productPic' type='text'></td><td><a>设置</a></td></tr>")
			} 
			tbody.append(tr);
		})
		$("#tb-speca-quotation").append(tbody);
		_fShowTableInfo(tableInfo);
		return;
	}
	if(chimlen == 0){
		var tr = $("");
		$.each(yanse,function(i,n){
			
				
			tr = $("<tbody><tr><td class='yan' id=''>"+ n.value +"</td><td class='chi' id=''></td><td>" +
					"<input class='pro_price' name='productPic' type='text'></td><td><a>设置</a></td></tr></tbody>")
			$("#tb-speca-quotation").append(tr);
		})
		_fShowTableInfo(tableInfo);
		return;
	}
	if(yanselen > 0 && chimlen >0){
		$.each(yanse,function(i,n){
			var tbody = $("<tbody></tbody>");
			$.each(chim,function(j,m){
				if(j == 0){
					tr = $("<tr ><td class='yan' id='' rowspan='"+ chimlen +"'>"+ n.value +"</td><td class='chi' id=''>"+ m.value +"</td><td>" +
							"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.id+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input class='pro_price' name='productPic' type='text'></td><td><a>设置</a></td></tr>")
				}else{
					tr = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.id+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input class='pro_price' name='productPic' type='text'></td><td><a>设置</a></td></tr>")
				} 
				tbody.append(tr);
			})
			$("#tb-speca-quotation").append(tbody);
		})
		_fShowTableInfo(tableInfo);
	}
	
}

//储存表格价格和数量
function _fStoreTableInfo(){
	var g_table=[];
	var obj=$("#tb-speca-quotation tbody");
	$.each(obj,function(i,item){
		var color_id = $(item).find(".yan").attr("id");
		$.each($(item).children(),function(j,item1){
			var chi_id = $(item1).find(".chi").attr("id");
			var price=$(item1).find(".pro_price").val();
			var tr = [];
			tr.push(color_id);
			tr.push(chi_id);
			tr.push(price);
			g_table.push(tr);;
		});
	});
	return g_table;
}

//遍历并显示表格价格和数量
function _fShowTableInfo(tableInfo){
	var obj=$("#tb-speca-quotation tbody");
	$.each(tableInfo,function(k){
		$.each(obj,function(i,item){
			var color_id = $(item).find(".yan").attr("id");
			if(color_id == tableInfo[k][0]){
				$.each($(item).children(),function(j,item1){
					var chi_id = $(item1).find(".chi").attr("id");
					if(chi_id == tableInfo[k][1]){
						$(item1).find(".pro_price").val(tableInfo[k][2]);
					}
				});
			}
		});
	});
}
