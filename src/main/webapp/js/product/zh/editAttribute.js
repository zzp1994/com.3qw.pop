var sessionId = '';
var productId='';
$(document).ready(function(){
	//initimg();
	$(".chim").delegate("input", "change", changebox);
	$(".yanse").delegate("input", "change", changebox);
	$(".yanse").delegate("input", "change", changeimg);
	$("input[name='auto']").live("change",tiaoxingma);
	$("table#tb-tiaoxingma input").live("blur", checktiao);
	$(".operate .toleft").live('click', pre);
	$(".operate .toright").live('click', next);
 	$(".operate .del").live('click' , dele);
	
	sessionId = $("#sessionId").val();
	productId= $("#productId").val();
	

	
	changebox();
	xiug3();
	loadingBrand();
	
	
	
	$("#editProdAttr").click(function(){
		
		var isSubmit = saveProduct();
		if(!isSubmit){
			alert("商品信息不完整或不符合规范，请修改。");
			
		}else{
			
			$(".fabu_btn").attr("disabled",true);
			$.ajax({
				type:'post',
				url:'../product/updateAttribute',
				data:$("#productAction").serialize(),
				error:function(){
					$(".fabu_btn").attr("disabled",false);
					alert('服务器忙，请稍后再试！');
				},
				success:function(data){
					if(data=="0"){
						$(".fabu_btn").attr("disabled",false);
						alert('保存失败，请稍后再试！');
					}
					if(data=="1"){
						tipMessage("保存成功，返回到商品列表",function(){
							window.location.href="../product/onSaleList";
						});
					}
				}
			});
		}
	});
	
	
	
});

//function upImage() {
//	d = myEditorImage.getDialog("insertimage");
//	d.render();
//	d.open();
//}

//验证信息
function saveProduct(){

	
		var isSubmit = true;
		 $('.dpl-tip-inline-warning').hide();
		$('#attrobjs p[required=\'required\']').has('input[type=\'checkbox\']').each(function () {
		    if ($(this).find('input[type=\'checkbox\']:checked').length < 1) {
		    	 isSubmit = false;
		        $(this).find('.dpl-tip-inline-warning').text("带星号的属性值必填！").css('display','block');
		    }else{
		    	 $(this).find('.dpl-tip-inline-warning').hide();
		    }
		});
		
		
		
		var allattrobjtest = $(".p3 .bb").find("input[required='required']");
		$.each(allattrobjtest,function(i,v){
			if($(this).val()==""){
				isSubmit=false;
			}
		});

		
		//交易信息验证
		
		
		//国内经销商不涉及价格信息
		
		var supplierType = $("#supplierType").val();
		
		if(3 != supplierType){
			//价格类型验证
			var priceType=$('input:radio[name="priceType"]:checked').val();
			if(priceType==0){
				var thisvals=$("#priceType0text").val();
				if(thisvals=="" || thisvals.length>200){
					$("#priceType0warning").text("按照FOB计算价格  离岸港口名称必须1-200字").show();
					isSubmit=false;
				} else {
					$("#priceType0warning").hide();
				}
			}
			
			if(priceType==1){
				var thisvals=$("#priceType1text").val();
				if(thisvals=="" || thisvals.length>200){
					$("#priceType1warning").text("按照CIF计算价格  到岸港口名称必须1-200字").show();
					isSubmit=false;
				} else {
					$("#priceType1warning").hide();
				}
			}
			//订单收集类型验证
			var orderType=$('input:radio[name="supplierProductDetail.orderType"]:checked').val();
	
			if(orderType==0){
				var thisvals=$("#delivery").val();
				if(thisvals==""){
					$("#deliveryDateWarning").text("预计发货日期不能为空！").show();
					isSubmit=false;
				}
				 var produceNum = $("#produceNum").val();
				 if(produceNum==""){
					 isSubmit = false;
					 $('#produceNumWarning').text('生产能力不能为空！').show();
				 }else if(!/^[1-9]{1}[0-9]*$/.test(produceNum)){
				 	 isSubmit = false;
				 	 $('#produceNumWarning').text('生产能力只能整数不能已0开头！').show();
				 }else	if(!/^[0-9]{1,8}$/.test(produceNum)){
					 isSubmit = false;
					 $('#produceNumWarning').text('生产能力只能是小于8位的整数！').show();
				 };
				var closing=$("#closing").val();
				if(closing==""){
					$("#closingWarning").text("最后收单日期不能为空！").show();
					isSubmit=false;
				}
				 var maxProdNum = $("#maxProdNum").val();
				 if(maxProdNum==""){
					 isSubmit = false;
					 $('#maxProdNumWarning').text('最大收单量不能为空！').show();
				 }else if(!/^[1-9]{1}[0-9]*$/.test(maxProdNum)){
				 	 isSubmit = false;
				 	 $('#maxProdNumWarning').text('最大收单量只能整数不能已0开头！').show();
				 }else	if(!/^[0-9]{1,8}$/.test(maxProdNum)){
					 isSubmit = false;
					 $('#maxProdNumWarning').text('最大收单量只能是小于8位的整数！').show();
				 };
			};
		
		}
		
		 
		 if(!$("input[name='auto']").is(":checked")){
			 var isSkuCode = 1;
			 var objSkuCode = $("#skuCodeTable").find("input[type='text']");
			 $.each(objSkuCode,function(){
			   if($(this).val()==""){
				   isSkuCode=0;
			       isSubmit = false;
			   }
			 });
			 if(isSkuCode==0){
				 isSubmit=false;
				 $("#skuCodeTable").next(".dpl-tip-inline-warning").text("条形码不能为空,如果没有条形码请选择系统生成").show();
			} else{
				var isImages = 1;
				//条形码图片
				var barImages = $("#tb-tiaoxingma .preview_fake");
				$.each(barImages,function(i,item){
					var num = $(item).find("img").length;
					if(num == 0){
						isImages = 0;
					}				
				});
				
				if(isImages==0){
					isSubmit = false;
					$("#skuCodeTable").next(".dpl-tip-inline-warning").text("条形码图片不能为空").show();
				} else{
					 $("#skuCodeTable").next(".dpl-tip-inline-warning").hide();
				}
			}
		}
		 
		
		 
		
		
		var firstcategory  = $("#firstcategory").val();
		if(firstcategory==""){
			$("#firstcategory").parent().next().text("请选择品牌！").show();
		  	isSubmit=false;
		} else{
			$("#firstcategory").parent().next().text("请选择品牌！").hide();
		}
		
		if($(".yanse2 input[type='checkbox']:checked").length==0){
			$(".yanse2 ").children(".dpl-tip-inline-warning").css("display","inline");
		  	isSubmit=false;
		} else {
			$(".yanse2 ").children(".dpl-tip-inline-warning").css("display","none");
		}
		
		if($(".chim2 input[type='checkbox']:checked").length==0){
			$(".chim2 ").children(".dpl-tip-inline-warning").css("display","inline");
		  	isSubmit=false;
		} else {
			$(".chim2 ").children(".dpl-tip-inline-warning").css("display","none");
		}
		
		var obj = $(".cont input[required='required']");
		$.each(obj,function(i,item){
			if(item.value == ""){
				isSubmit=false;
				$(item).next().text("请填写带星号的选项!").show();
			}else if(item.value.length>200){
				isSubmit=false;
				$(item).next().text("长度不能大于200位!").show();
			}else{
				$(item).next().hide();
			}
		});
		var objattrnotrequired = $("#attrdiv").find("input[type='text']:not([required='required'])");
		$.each(objattrnotrequired,function(i,item){
			 if(item.value.length>200){
				isSubmit=false;
				$(item).next().text("长度不能大于200位!").show();
			}else{
				$(item).next().hide();
			}
		});
		/*		var allattrobj = $('.p3 .bb') .find("input[type='text']");
		$.each(allattrobj, function (i, v) {
		  if ($(this) .val() != '') {
		    if ($(this) .val().length > 200) {
		    	$(this).next().text("长度不能大于200位。").show();
		    	isSubmit=false;
		    }else{
		    	$(this).next().hide();
		    }
		  }
		  
		});
		
		*/
		
		
		var imgs = $(".jinben .wu-example");
		$.each(imgs,function(i,item){
			var num = $(item).find("input[name='imgUrl']").length;
			if(num < 3){
				isSubmit = false;
				$(item).prepend("<span class='dpl-tip-inline-warning' style='display:inline'>请至少上传三张图片</span>");
			}else{
				$(item).find(".dpl-tip-inline-warning").remove();
			}
				
		});
		
			var num1 = $("#uploader_00 input[name='imgUrl']").length;
			if(num1 < 1){
				isSubmit = false;
				$("#zizhiImg").css("display","inline");
			}else{
				$("#zizhiImg").css("display","none");
			}

		
		
			
		
		var mingxitext= $(".mingxi textarea[required='required']");
		$.each(mingxitext,function(i,item){
			if(item.value == ""){
				isSubmit = false;
				$(item).parent().next().css("display","inline");
			}else{
				$(item).parent().next().css("display","none");
			}
		});
		
		var mingxiinput= $(".mingxi input[required='required']");
		$.each(mingxiinput,function(i,item){
			if(item.value == ""){
				isSubmit = false;
				$(item).parent().next().css("display","inline");
			}else{
				$(item).parent().next().css("display","none");
			}
		});
		
		var productinfo = $("#productinfo").val();
		if(productinfo.length>200 || productinfo.length<4){
			isSubmit = false;
			$("#productMsg").css("display","inline");
			$("#productMsg").text("商品标题只能4-200字");
		}  else {
			$("#productMsg").css("display","none");
		}
		
		
		var remark = $("#remark").val();
		if(remark.length>200){
			isSubmit = false;
			$("#remark").parent().next().css("display","inline");
		} else {
			$("#remark").parent().next().css("display","none");
		}
		
		var remark = $("#customCode").val();
		if(remark.length>200){
			isSubmit = false;
			$("#customCode").parent().next().css("display","inline");
		} else {
			$("#customCode").parent().next().css("display","none");
		}
		
		
		var salesService = $("#salesService").val();
		if(salesService.length>200){
			isSubmit = false;
			$("#salesService").parent().next().css("display","inline");
			$("#salesService").parent() .next().text("售后服务不能大于200字");
		} else {
			$("#salesService").parent().next().css("display","none");
		}
		
		var packingList = $("#packingList").val();
		if(packingList.length>200){
			isSubmit = false;
			$("#packingList").parent().next().css("display","inline");
			$("#packingList").parent().next().text("包装清单不能大于200字");
		} else {
			$("#packingList").parent().next().css("display","none");
		}
		
		
		var area = $("#area").val();
		var number = $("#number").val();
		var testArea = new RegExp("^\\d{1,5}$");
		var testNumber = new RegExp("^\\d{1,20}$");
		if(area!=""||number!=""){
			if(!testArea.test(area)){
				$("#mobiletext").text("售后电话的区号不能大于5位且只能为数字").show();
			} else if(!testNumber.test(number)){
				$("#mobiletext").text("售后电话号只能为数字且小于20位").show();
			}else {
				$("#mobiletext").hide();
			}
		}
		
		
		
		var regd = new RegExp("^\\d{0,5}$");
		var sheilLife = $("#sheilLife").val();
		if(sheilLife!=undefined){
			if(!regd.test(sheilLife)){
				$("#sheilLife").parent().next(".dpl-tip-inline-warning").text("保质期不能大于5位 ,且只能是数字").show();
				isSubmit = false;
			}else {
				$("#sheilLife").parent().next(".dpl-tip-inline-warning").hide();
			}
		}
		
		
		
		if(!UE.getEditor('editor').hasContents()){
			isSubmit=false;
			$("#Details").text("图文详情不能为空！").show();
		} else {
			$("#Details").hide();
		}
		
		if($(".dpl-tip-inline-warning:visible").length>0){
			isSubmit=false;
		}
		 if($(".tab_box .dpl-tip-inline-warning:visible").length>0){
			isSubmit = false;
		 }
		return isSubmit;
	
	
	}

        //全部发布商品开始
		var xiug=function(){
			$(".i_box .jia").click(function(){
				$('.bb').append( "<p class='addP' style='margin-left:20px;'><input type='text' value='' style='width:50px;'> ：<input type='text' value='' style='width:198px;'> <span class='del'>删除</span></p>" );
			});
			$(document).on('click','.del',function(){
				$(this).parent('.addP').remove();
			});

		};

		var xiug3=function(){
			
			$(".cp1").click(function(){
				$(".tq2").show();
				$(".tqz .tq4").hide();
				$(".g").hide();
			});
			$(".cp2").click(function(){
				changebox();
				$(".tqz .tq2").hide();
				$(".tqz .tq4").show();
				$(".g").show();
				
			});
		};

		
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
									fistBrandlist += "<option value='"+ n.id+ "'>"+ n.nameCn + "</option>";
								});
								$("#secondcategory").append(fistBrandlist).show();
						} else{
							$("#secondcategory").hide();
						}
					}
				});
			});
		}




function checktiao(event){
	var mm = event.target;	
	var str =  mm.value;
	$(".tab_box .dpl-tip-inline-warning").remove();
	if(str!=""){
		var str =  mm.value;
		if(str.length!=19){
			if(str.length ==16){
				if(!RegExp("^\\d{13}-\\d{2}$").test(str)){
					mm.value="";
					$("#tb-tiaoxingma").after($('<span class="dpl-tip-inline-warning" style="display:block">条形码应为8,12,13,16位数字</span>'));
				}
			}else if(!RegExp("^\\d{8}$|^\\d{12,13}$").test(str)){
				mm.value="";
				$("#tb-tiaoxingma").after($('<span class="dpl-tip-inline-warning" style="display:block">条形码应为8,12,13,16位数字</span>'));
				//$(mm).delay(100000000).val("");
			}
		}
	}	
}




//图片处理函数
        function pre(event) {
        	var but = event.target;
        	var li = $(but).parent().parent();
        	var id = li.attr("class");
        	var theimg = li.find(".p-img");
            var src = li.find("img").attr("src");
            if (src != null && id != "img-1") {
                if (li.prev().children(".p-img").children().is("img")) {
                    var imgboxpre = li.prev().children(".p-img");
                    li.prev().find(".p-img").remove();
                    li.prev().prepend(theimg);
                    li.find(".p-img").remove();
                    li.prepend(imgboxpre);
                } else {
                    li.find(".operate").hide();
                    li.prev().find(".p-img").remove();
                    li.prev().prepend(theimg);
                    li.prepend($("<div class='p-img'></div>"));
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
            var theimg = li.find(".p-img");
            var src = li.find("img").attr("src");
            if (src != null && id != "img-6") {
                if (li.next().children(".p-img").children().is("img")) {
                    var imgboxnext = li.next().children(".p-img");
                    li.next().find(".p-img").remove();
                    li.next().prepend(theimg);
                    li.find(".p-img").remove();
                    li.prepend(imgboxnext);
                } else {
                    li.find(".operate").hide();
                    li.next().find(".p-img").remove();
                    li.next().prepend(theimg);
                    li.prepend($("<div class='p-img'></div>"));
                    li.next().children(".operate").show();
                }
                
            } else {
                return false;
            }
        }
        function dele(event) {
        	var but = event.target;
        	var li = $(but).parent().parent();
        	var inhid = li.find("#diddendiv");
            var theimg = li.find("img");
            var src = theimg.attr("src");
            if (src != null) {
                li.find(".operate").hide();
                theimg.parent().empty();
                inhid.empty();
               
            } else {
                return false;
            }
        }

var tableInfo=[];

var test=[];

//function inituploadzizhi(url){
//	$.each(url,function(i,item){
//		$("#zizhi .p-img").eq(i).append("<img src='"+ url[i]+"'><input type='hidden' name='imgUrl' value='00_"+url[i]+"'/></img>");
//		$("#zizhi .operate").eq(i).show();
//	});
//}

function addupload(value,id,urllist){
	var object = $('<div id="uploader_'+id+'" class="wu-example"></div>');
	var flag =true;
	if($(".jinben > div.wu-example").length >0){
		$(".jinben > div.wu-example").each(function(i,item){
			var iid =Number(item.id.split("_")[1]);
			if(Number(id)<iid && flag){
				$(item).before(object);
				flag = false;
			}
		});	
	}
	if(flag){
		$(".jinben").append(object);
	}
	inituploader(value,id,urllist);
}
function adduploadimg(value,id,url){
	var p_img = $("<div class='p-img'></div>");
	var operate =$("<div class='operate'><i class='toleft'>左移</i><i class='toright'>右移</i><i class='del'>删除</i></div>");
	if(url.length == 0){
		var img1 = $("<li class='img-1'></li>").append(p_img.clone()).append(operate.clone());
		var img6 = $("<li class='img-6'></li>").append(p_img.clone()).append(operate.clone());
		var img = $("<li></li>").append(p_img.clone()).append(operate.clone());
		var ul = $("<ul id='"+ id +"_img'></ul>").append(img1).append(img.clone()).append(img.clone()).append(img.clone()).append(img).append(img6);
	}else{
		var ul = $("<ul id='"+ id +"_img'></ul>");
		$.each(url,function(i,item){
			if(i == 0){
				ul.append($("<li class='img-1'></li>").append(p_img.clone().append("<img src='"+ url[i]+"'><input type='hidden' name='imgUrl' value='" + id+"_"+url[i]+"'/></img>")).append(operate.clone().show()));
			}else if(i == 5){
				ul.append($("<li class='img-6'></li>").append(p_img.clone().append("<img src='"+ url[i]+"'><input type='hidden' name='imgUrl' value='" + id+"_"+url[i]+"'/></img>")).append(operate.clone().show()));
			}else{
				ul.append($("<li></li>").append(p_img.clone().append("<img src='"+ url[i]+"'><input type='hidden' name='imgUrl' value='" + id+"_"+url[i]+"'/></img>" )).append(operate.clone().show()));
			}
		});
		if(url.length<6){
			for(var j = url.length;j<6;j++){
				if(j == 5){
					ul.append($("<li class='img-6'></li>").append(p_img.clone()).append(operate.clone()));
				}else{
					ul.append($("<li></li>").append(p_img.clone()).append(operate.clone()));
				}
			}
		}			
	}
	
	var div = $("<div></div>").append("<div class='wenzi'>"+value+"的图片:<input id='"+ id +"_upload' name='button' type='submit'  value='图片上传' /><span class='dpl-tip-inline-warning'>请至少上传三张图片</span></div>").append(ul);
	var object = $("<div class='z' id='" + id +"_xianshi'></div>").append(div);
	var flag =true;
	if($(".jinben > div.z").length >0){
		$(".jinben > div.z").each(function(i,item){
			var iid =Number(item.id.split("_")[0]);
			if(Number(id)<iid && flag){
				$(item).before(object);
				flag = false;
			}
		});	
	}
	if(flag){
		$(".jinben").append(object);
	}
	
	//$(".jinben").append(object);
	if (flashDetect()) { // 探测到已经安装了flash插件 则初始化上传按钮和提示
    // 初始化swfUpload组件
        $("#"+id+"_upload").uploadify({
        	'height': 30,
            'swf': '../js/uploadify/uploadify.swf',
            'uploader': '../product/imageUp?supplier_session_id='+sessionId+"&productId="+productId,
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
       /* $(".ifile").html('<span class="no-flash-tip">' +
        'Hi，您的浏览器OUT了，它未安装新版的Flash Player，' +
        '<a href="http://get.adobe.com/flashplayer/" target="_blank">去安装>></a>' +
        '</span>');*/
    	if(confirm("Hi，您的浏览器OUT了，它未安装新版的Flash Player，快去安装最新版flashplayer")){
    		location.href="http://get.adobe.com/flashplayer/";
    	}
    }
	
}

function initimg(){
	var ss = $(".yanse input:checked");
	if(ss.length>0){
		$.each(ss,function(i,item){
			var value = item.value;
			var id = item.id;
			adduploadimg(value,id,test);
		});
	}
}

function changeimg(event){
	var obj = event.target;
	var id = obj.id;
	var value = obj.value;
	if(obj.checked){		
		//adduploadimg(value,id,[]);
		addupload(value,id,[]);
	}else{
		var ss = document.getElementById("uploader_"+id);
		ss.parentNode.removeChild(ss);
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

	tableInfo = _fStoreTableInfo("tb-speca-quotation");
	tiaoxingmainfo = _fStoreTableInfo("tb-tiaoxingma");
	$("#tb-speca-quotation tbody").remove();
	$("#tb-tiaoxingma tbody").remove();
	$("#skuCodeTable > .dpl-tip-inline-warning").empty().hide();
	document.getElementById("same_price").checked = false;
	$("#tb-speca-quotation").show();	
	

	if(yanselen == 0){
		var tbody = $("<tbody></tbody>");
		var tbody1 = $("<tbody></tbody>");
		var tr = $("");
		var tr1 = $("");
		$.each(chim,function(i,n){
			if(i == 0){
				tr = $("<tr ><td id='' class='yan' rowspan='"+ chimlen +"'></td><td class='chi' id='"+ n.id +"'>"+ n.value +"</td><td>" +
						"<input class='pro_price' type='text'  value=''></td></tr>");
				tr1 = $("<tr ><td id='' class='yan' rowspan='"+ chimlen +"'></td><td class='chi' id='"+ n.id +"'>"+ n.value +"</td><td>" +
				"<input class='pro_price' type='text'  value=''></td><td><div class='preview_fake'  id='-"+n.id+"_img' ></div></td><td><input class='file'  id='-"+n.id+"_upload' name='button'   type='submit' /></td></tr>");
			}else{
				tr = $("<tr><td class='chi'>"+ n.value +"</td><td id='"+ n.id +"'>" +
						"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
						"<input type='hidden' name='buyName' value='"+n.value+"'>" +
						"<input class='pro_price' type='text' name='productPic'></td></tr>");
				tr1 = $("<tr><td class='chi'>"+ n.value +"</td><td id='"+ n.id +"'>" +
						"<input class='pro_price' type='text' name='skuCode'></td><td><div class='preview_fake'  id='-"+n.id+"_img' ></div></td><td><input class='file'  id='-"+n.id+"_upload' name='button'   type='submit' /></td></tr>");

			} 
			tbody.append(tr);
			tbody1.append(tr1);
		});
		$("#tb-speca-quotation").append(tbody);
		//条形码
		$("#tb-tiaoxingma").append(tbody1);
		_Itiaoimg();
		_fShowTableInfo(tableInfo,"tb-speca-quotation");
		_fShowTableInfo(tiaoxingmainfo,"tb-tiaoxingma");
		return;
	}
	if(chimlen == 0){
		var tr = $("");
		var tr1 = $("");
		$.each(yanse,function(i,n){
			
			tr = $("<tbody><tr><td class='yan' id='"+ n.id +"'>"+ n.value +"</td><td class='chi' id=''></td><td>" +
					"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
					"<input type='hidden' name='buyName' value='"+n.value+"'>" +
					"<input class='pro_price' type='text'></td></tr></tbody>");
			tr1 = $("<tbody><tr><td class='yan' id='"+ n.id +"'>"+ n.value +"</td><td class='chi' id=''></td><td>" +
					"<input class='pro_price' type='text'></td><td><div class='preview_fake'  id='"+n.id+"-_img' ></div></td><td><input class='file'  id='"+n.id+"-_upload' name='button'   type='submit' /></td></tr></tbody>");

			$("#tb-speca-quotation").append(tr);
			$("#tb-tiaoxingma").append(tr1);
		});
		_Itiaoimg();
		_fShowTableInfo(tableInfo,"tb-speca-quotation");
		_fShowTableInfo(tiaoxingmainfo,"tb-tiaoxingma");
		return;
	}
	if(yanselen > 0 && chimlen >0){
		$.each(yanse,function(i,n){
			var tbody = $("<tbody></tbody>");
			var tbody1 = $("<tbody></tbody>");
			var tr = $("");
			var tr1 = $("");
			$.each(chim,function(j,m){
				if(j == 0){
					tr = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen +"'>"+ n.value +"</td><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.id+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input class='pro_price' type='text' name='productPic'></td></tr>");
							tr1 = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen +"'>"+ n.value +"</td><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input class='pro_price' type='text' name='skuCode'></td><td><div class='preview_fake'  id='"+n.id+"-"+m.id+"_img' ></div></td><td><input class='file'  id='"+n.id+"-"+m.id+"_upload' name='button'   type='submit' /></td></tr>")
				}else{
					tr = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.id+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input class='pro_price' type='text' name='productPic'></td></tr>");
					tr1 = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input class='pro_price' type='text' name='skuCode'></td><td><div class='preview_fake'  id='"+n.id+"-"+m.id+"_img' ></div></td><td><input class='file'  id='"+n.id+"-"+m.id+"_upload' name='button'   type='submit' /></td></tr>");
				} 
				tbody.append(tr);
				tbody1.append(tr1);
			});
			
			$("#tb-speca-quotation").append(tbody);
			$("#tb-tiaoxingma").append(tbody1);
		});
		_Itiaoimg();
		_fShowTableInfo(tableInfo,"tb-speca-quotation");
		_fShowTableInfo(tiaoxingmainfo,"tb-tiaoxingma");
	}	
}

function changebox1(event){	
	var src = event.target?event.target:event.srcelement;
	var chi = $(".chim2 input:checked") ,yan = $(".yanse2 input:checked"),
		   chilen = chi.length, yanlen = yan.length;
	var id = src.id, value = src.value, toinitiimglist = [];
	var type = $(src).closest("div").attr("class");

	if(src.checked){
		if(type == "chim2"){
			var index = 0;
			chi.each(function(i,m){
				if(m.id == id){
					index = i;
				}		
			});
			if(chilen == 1 && yanlen >0){
				//直接赋值 不用append
				$("#tb-tiaoxingma tbody tr td.chi").each(function(i,item){
					item.id = id;
					item.innerHTML = value;
				});
				$("#tb-speca-quotation tbody tr td.chi").each(function(i,item){
					item.id = id;
					item.innerHTML = value;
					
					$(item).closest("tr").find("td").append("<input type='hidden' name='buyVal' value='"+n.id+"'>" +
							"<input type='hidden' name='saleVal' value='"+id+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+value+"'>" );
				});
			}else if(yanlen == 0 && chilen == 1 ){
				//append一个新的new 从null到一行
				var tbody=$("<tbody></tbody>");
				var tbody1=$("<tbody></tbody>");
				var inputid = "-"+id;
				var tr = $("<tr ><td class='yan' id=''></td><td class='chi' id='"+ id +"'>"+ value +"</td><td>" +
						"<input class='pro_price' type='text'  value=''></td><td><div class='preview_fake' id = '"+inputid+"_img'></div></td><td><input class='file'   id = '"+inputid+"_upload'  name='button'   type='submit' /></td></tr>");
				var tr1 = $("<tr ><td class='yan' id=''></td><td class='chi' id='"+ id +"'>"+ value +"</td><td>" +
						"<input class='pro_price' type='text'  name='productPic'></td></tr>");
				//init img button
				toinitiimglist.push(inputid);
				tbody.append(tr);
				tbody1.append(tr1);
				$("#tb-tiaoxingma").append(tbody);
				$("#tb-speca-quotation").append(tbody1);
			}else{
				//多行多列
				$("#tb-tiaoxingma tbody").each(function(i,item){
					var iid = $(item).find(".yan").attr("id");
					var vvalue = $(item).find(".yan:eq(0)").text();
					var inputid = iid+"-"+id;
					var tr = $("<tr ><td class='yan' id='"+ iid +"'>"+vvalue+"</td><td class='chi' id='"+ id +"'>"+ value +"</td><td>" +
					"<input class='pro_price' type='text'  value=''></td><td><div class='preview_fake' id = '"+inputid+"_img'></div></td><td><input class='file'  id = '"+inputid+"_upload'  name='button'   type='submit' /></td></tr>");
					var tr1 = $("<tr ><td class='yan' id='"+ iid +"'>"+vvalue+"</td><td class='chi' id='"+ id +"'>"+ value +"</td><td>" +
							"<input class='pro_price' type='text'  value='' name='productPic'></td>"+
					"<input type='hidden' name='buyVal' value='"+iid+"'>" +
					"<input type='hidden' name='saleVal' value='"+id+"'>" +
					"<input type='hidden' name='buyName' value='"+vvalue+"'>" +
					"<input type='hidden' name='saleName' value='"+value+"'>" +
					"<input class='pro_price' type='text' name='productPic'></td></tr>");
					toinitiimglist.push(inputid);
					if(index != chilen -1){
						$(item).find("tr").eq(index).before(tr);
						$("#tb-speca-quotation tbody:eq("+i+")").find("tr").eq(index).before(tr1);
					}else{
						$(item).append(tr);
						$("#tb-speca-quotation tbody:eq("+i+")").append(tr1);
					}	
				});
			}
			
			
		}else{
			var index = 0;
			yan.each(function(i,m){
				if(m.id == id){
					index = i;
				}		
			});
			if(yanlen == 1 && chilen >0){
				//直接赋值 不用append
				$("#tb-tiaoxingma tbody tr td.yan").each(function(i,item){
					item.id = id;
					item.innerHTML = value;
				});
				$("#tb-speca-quotation tbody tr td.yan").each(function(i,item){
					item.id = id;
					item.innerHTML = value;
					$(item).closest("tr").find("td").append("<input type='hidden' name='buyVal' value='"+n.id+"'>" +
							"<input type='hidden' name='saleVal' value='"+id+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+value+"'>" );
				});
			}else if(chilen == 0 && yanlen == 1 ){
				//从null append一个tbody
				var tbody=$("<tbody></tbody>");
				var tbody1=$("<tbody></tbody>");
				var inputid = id+"-";
				var tr = $("<tr ><td class='yan' id='"+ id +"'>"+ value +"</td><td class='chi' id=''></td><td>" +
						"<input class='pro_price' type='text'  value=''></td><td><div class='preview_fake' id = '"+inputid+"_img'></div></td><td><input class='file'  id = '"+inputid+"_upload' name='button'   type='submit' /></td></tr>");
				var tr1 = $("<tr ><td class='yan' id='"+ id +"'>"+value+"</td><td class='chi' id=''></td><td>" +
				"<input class='pro_price' type='text'  value='' name='productPic'></td></tr>");
				
				//init img button
				toinitiimglist.push(inputid);
				tbody.append(tr);
				tbody1.append(tr1);
				$("#tb-tiaoxingma").append(tbody);
				$("#tb-speca-quotation").append(tbody1);
			}else{
				//多行多列
				var tbody=$("<tbody></tbody>");
				var tbody1=$("<tbody></tbody>");
				if(chilen == 0){
					var inputid = id+"-";
					var tr = $("<tr ><td class='yan' id='"+ id +"'>"+ value +"</td><td class='chi' id=''></td><td>" +
					"<input class='pro_price' type='text'  value=''></td><td><div class='preview_fake'  id = '"+inputid+"_img'></div></td><td><input class='file'  id = '"+inputid+"_upload'  name='button'   type='submit' /></td></tr>");
					var tr1 = $("<tr ><td class='yan' id='"+ id +"'>"+value+"</td><td class='chi' id=''></td><td>" +
					"<input class='pro_price' type='text'  value='' name='productPic'></td>" +
				"<input type='hidden' name='buyVal' value='"+id+"'>" +
				"<input type='hidden' name='saleVal' value=''>" +
				"<input type='hidden' name='buyName' value='"+value+"'>" +
				"<input type='hidden' name='saleName' value=''>" +
				"<input class='pro_price' type='text' name='productPic'></td></tr>");
					
					tbody.append(tr);
					tbody1.append(tr1);
					toinitiimglist.push(inputid);
				}else{
					chi.each(function(i,item){
						var iid = item.id;
						var vvalue = item.value;
						var inputid = id+"-"+iid;
						var tr = $("<tr ><td class='yan' id='"+ id +"'>"+ value +"</td><td class='chi' id='"+iid +"'>"+ vvalue +"</td><td>" +
						"<input class='pro_price' type='text'  value=''></td><td><div class='preview_fake'  id = '"+inputid+"_img' ></div></td><td><input class='file'  id = '"+inputid+"_upload'  name='button'   type='submit' /></td></tr>");
						var tr1 = $("<tr ><td class='yan' id='"+ id +"'>"+value+"</td><td class='chi' id='"+iid +"'>"+ vvalue +"</td><td>" +
						"<input class='pro_price' type='text'  value='' name='productPic'></td>" +
						"<input type='hidden' name='buyVal' value='"+id+"'>" +
						"<input type='hidden' name='saleVal' value='"+iid+"'>" +
						"<input type='hidden' name='buyName' value='"+value+"'>" +
						"<input type='hidden' name='saleName' value='"+vvalue+"'>" +
						"<input class='pro_price' type='text' name='productPic'></td></tr>");	
						tbody.append(tr);
						tbody1.append(tr1);
						toinitiimglist.push(inputid);
					});
				}
				if(index != yanlen -1){
					$("#tb-tiaoxingma tbody:eq("+index+")").before(tbody);	
					$("#tb-speca-quotation tbody:eq("+index+")").before(tbody1);	
				}else{
					$("#tb-tiaoxingma").append(tbody);	
					$("#tb-speca-quotation").append(tbody1);	
				}
				
			}
		}
		
		_Itiaoimgeq(toinitiimglist);
	}else{
		if(chilen == 0 && yanlen == 0){
			$("#tb-tiaoxingma tbody").remove();
			$("#tb-speca-quotation tbody").remove();
			$("#skuCodeTable > .dpl-tip-inline-warning").empty().hide();
//			document.getElementById("same_price").checked = false;
			return;
		}
		if(type == "chim2"){
			$("#tb-tiaoxingma tbody tr td.chi").each(function(i,item){
				if(item.id == id){
					if(chilen == 0){
						item.id ="";
						item.innerHTML ="";
					}else{
						$(item).closest("tr").remove();	
					}	
				}
			});
			$("#tb-speca-quotation tbody tr td.chi").each(function(i,item){
				if(item.id == id){
					if(chilen == 0){
						item.id ="";
						item.innerHTML ="";
					}else{
						$(item).closest("tr").remove();	
					}	
				}
			});
		}else{
			$("#tb-tiaoxingma tbody tr td.yan").each(function(i,item){
				if(item.id == id){
					if(yanlen == 0){
						item.id ="";
						item.innerHTML ="";
					}else{
						$(item).closest("tbody").remove();	
					}	
				}
			});
			$("#tb-speca-quotation tbody tr td.yan").each(function(i,item){
				if(item.id == id){
					if(yanlen == 0){
						item.id ="";
						item.innerHTML ="";
					}else{
						$(item).closest("tbody").remove();	
					}	
				}
			});
		}
	}
	
}


function _Itiaoimg(){
	$("#tb-tiaoxingma input.file").each(function(i,item){
		var id = item.id;
		$("#"+id).uploadify({
        	'height': 24,
            'swf': '../js/uploadify/uploadify.swf',
            'uploader': '../product/imageUp?supplier_session_id='+sessionId,
            'width': 63,
            'cancelImg': '../js/img/uploadify-cancel.png',
            'multi ':false,
            'auto': true,
            'buttonText': '上传',
            file_size_limit: "1024K",
            fileTypeExts: '*.gif;*.jpg;*.jpeg;*.png',
            file_types: "*.jpg;*.png;*.jpeg;",
            file_types_description: "*.jpg;*.jpeg;*.png;*.JPG;*.JPEG;*.PNG;",
            
            upload_start_handler: uploadStart1,
            upload_success_handler: uploadSuccess1,
        });
	});
}
//储存表格价格和数量
function _fStoreTableInfo(tablename){
	var g_table=[];
	var obj=$("#"+tablename+" tbody");
	$.each(obj,function(i,item){
		var color_id = $(item).find(".yan").attr("id");
		$.each($(item).children(),function(j,item1){
			var chi_id = $(item1).find(".chi").attr("id");
			var price=$(item1).find(".pro_price").val();
			var img = $(item1).find(".preview_fake");
			var tr = [];
			tr.push(color_id);
			tr.push(chi_id);
			tr.push(price);
			if(img.length !=0){
				tr.push(img.html());
			}
			g_table.push(tr);
		});
	});
	return g_table;
}

//遍历并显示表格价格和数量
function _fShowTableInfo(tableInfo,tablename){
	var obj=$("#"+tablename+" tbody");
	$.each(tableInfo,function(k){
		$.each(obj,function(i,item){
			var color_id = $(item).find(".yan").attr("id");
			if(color_id == tableInfo[k][0]){
				$.each($(item).children(),function(j,item1){
					var chi_id = $(item1).find(".chi").attr("id");
					if(chi_id == tableInfo[k][1]){
						$(item1).find(".pro_price").val(tableInfo[k][2]);
						if(tablename == "tb-tiaoxingma"){
							$(item1).find(".preview_fake").html(tableInfo[k][3]);
						}
					}
				});
			}
		});
	});
//	if($("input[name='auto']").is(":checked") && tablename == "tb-tiaoxingma"){
//		$("#tb-tiaoxingma tbody input.pro_price").attr("disabled","disabled");
//	}
}

function tiaoxingma(event){
	var src = event.target || event.srcelement;
	if(src.checked){
		$("#tb-tiaoxingma").hide();
		$("#skuCodeTable").next(".dpl-tip-inline-warning").hide();
		$(".tab_box .dpl-tip-inline-warning").remove();
		//$(".tab_box input.pro_price").attr("disabled","disabled");
	}else{
		$("#tb-tiaoxingma").show();
		//$(".tab_box input.pro_price").attr("disabled",false);
	}
	
}


