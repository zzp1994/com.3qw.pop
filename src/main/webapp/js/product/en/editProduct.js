var sessionId='';
var productId='';
$(document).ready(function(){
	//initimg();
	$(".chim").delegate("input", "change", changebox);
	$(".yanse").delegate("input", "change", changebox);
	$(".yanse").delegate("input", "change", changeimg);
	$("input[name='auto']").live("change",tiaoxingma);
	$("#same_price").bind("change",sameprice);
	$("table#tb-speca-quotation input").live("input propertychange", checknum);
	$("table#tb-speca-quotation input").live("blur", checknum1);
	$("table#tb-tiaoxingma input").live("blur", checktiao);
	$(".operate .toleft").live('click', pre);
	$(".operate .toright").live('click', next);
 	$(".operate .del").live('click' , dele);
	$(".b2 input").live("blur",numpricecheck); 
//    xiug();
	sessionId = $("#sessionId").val();
	productId= $("#productId").val();
//	if (flashDetect()) { // 探测到已经安装了flash插件 则初始化上传按钮和提示
//	    // 初始化swfUpload组件
//	        $("#00_upload").uploadify({
//	        	'height': 30,
//	            'swf': '../js/uploadify/uploadify.swf',
//	            'uploader': '../product/imageUp?supplier_session_id='+sessionId+"&productId="+productId,
//	            'width': 100,
//	            'cancelImg': '../js/img/uploadify-cancel.png',
//	            'auto': true,
//	            'buttonText': 'upload',
//	            file_size_limit: "1024K",
//	            file_queue_limit: 6,
//	            fileTypeExts: '*.gif;*.jpg;*.jpeg;*.png',
//	            file_types: "*.jpg;*.png;*.jpeg;",
//	            file_types_description: "*.jpg;*.jpeg;*.png;*.JPG;*.JPEG;*.PNG;",
//
//	            file_dialog_start_handler: fileDialogStart,
//	            file_queued_handler: fileQueued,
//	            file_queue_error_handler: fileQueueError,
//	            file_dialog_complete_handler: fileDialogComplete,
//	            upload_start_handler: uploadStart,
//	            upload_progress_handler: uploadProgress,
//	            upload_error_handler: uploadError,
//	            upload_success_handler: uploadSuccess,
//	            upload_complete_handler: uploadComplete,
//	            queue_complete_handler: queueComplete
//	        });
//	    } else { // 探测到没有flash支持，给出提示。
//	    	if(confirm("Hi，您的浏览器OUT了，它未安装新版的Flash Player，快去安装最新版flashplayer")){
//	    		location.href="http://get.adobe.com/flashplayer/";
//	    	}
//	    }
	
	
	changebox();
	xiug1();
	xiug3();
	loadingBrand();
	
	
	$("#saveProd").click(function(){
		var isSubmit = saveProduct();
		if(!isSubmit){
			alert("Commodity information is incomplete or do not conform to the specifications, please amend.");
			
		}else{
			var cateId = $("#cid").val();
			$(".fabu_btn").attr("disabled",true);
			$.ajax({
				type:'post',
				url:'../product/add',
				data:$("#productAction").serialize(),
				error:function(){
					alert('error');
				},
				success:function(data){
					if(data=="0"){
						alert('save product error');
						$(".fabu_btn").attr("disabled",false);
					}
					if(data=="1"){
						$.dialog.confirm('Successful! Return to posted product list?', function(){
							window.location.href="../product/onSaleList";
							}, function(){
								window.location.href="../product/toCreateUI?cid="+cateId;
							});
					}
				}
			});
		
		}
	});
	
	$("#editProd").click(function(){
		var isSubmit = saveProduct();
		if(!isSubmit){
			alert("Commodity information is incomplete or do not conform to the specifications, please amend.");
			
		}else{
		//	var editorValue = UE.getEditor('editor').getContent();
			$(".fabu_btn").attr("disabled",true);
			$.ajax({
				type:'post',
				url:'../product/editProduct',
				data:$("#productAction").serialize(),
				error:function(){
					alert('error');
				},
				success:function(data){
					if(data=="0"){
						alert('edit product error');
						$(".fabu_btn").attr("disabled",false);
					}
					if(data=="1"){
						tipMessage("Successful! Return to posted product list",function(){
							window.location.href="../product/onSaleList";
						});
					}
				}
			});
		
		}
	});
	
	
	$("#draftProd").click(function(){
		
		   //var editorValue =UE.getEditor('editor').getContent();
			var cateId = $("#cid").val();
			$(".fabu_btn").attr("disabled",true);
			$.ajax({
				type:'post',
				url:'../product/saveDraft',
				data:$("#productAction").serialize(),
				error:function(){
					$(".fabu_btn").attr("disabled",false);
					alert('error');
				},
				success:function(data){
					if(data=="0"){
						$(".fabu_btn").attr("disabled",false);
						alert('');
					}
					if(data=="1"){
						$.dialog.confirm('Successful! Return to posted draft list？', function(){
							window.location.href="../product/draftList";
							}, function(){
								window.location.href="../product/toCreateUI?cid="+cateId;
							});
						}
				}
			});
	});
	
	$("#editDraft").click(function(){
		
		//var editorValue =UE.getEditor('editor').getContent();
		var cateId = $("#cid").val();
		$(".fabu_btn").attr("disabled",true);
		$.ajax({
			type:'post',
			url:'../product/updateDraft',
			data:$("#productAction").serialize(),
			error:function(){
				$(".fabu_btn").attr("disabled",false);
				alert('error');
			},
			success:function(data){
				if(data=="0"){
					$(".fabu_btn").attr("disabled",false);
					alert('error');
				}
				if(data=="1"){
					$.dialog.confirm('Successful! Return to posted draft list？', function(){
						window.location.href="../product/draftList";
					}, function(){
						window.location.href="../product/toCreateUI?cid="+cateId;
					});
				}
			}
		});
	});
});

function saveProduct(){
	var isSubmit = true;
	$('#attrdiv div[required=\'required\']').has('input[type=\'checkbox\']').each(function () {
	    if ($(this).find('input[type=\'checkbox\']:checked').length < 1) {
	    	 isSubmit = false;
	        $(this).find('.dpl-tip-inline-warning').text("Select at least one").css('display','block');
	    }else{
	    	 $(this).find('.dpl-tip-inline-warning').hide();
	    }
	});
	
	numpricecheck();
	
	var allattrobjtest = $(".p3 .bb").find("input[required='required']");
	$.each(allattrobjtest,function(i,v){
		if($(this).val()==""){
			isSubmit=false;
		}
	});
	
	
	
	//交易信息验证
	//国内经销商不需要填写价格信息	
	var supplierType = $("#supplierType").val();
	
	if(3 != supplierType){
			//价格类型验证
			var priceType=$('input:radio[name="priceType"]:checked').val();
			if(priceType==0){
				var thisvals=$("#priceType0text").val();
				if(thisvals=="" || thisvals.length>200){
					$("#priceType0warning").text("FOB port cannot be empty or less than 200 characters").show();
					isSubmit=false;
				} else {
					$("#priceType0warning").hide();
				}
			}
			
			if(priceType==1){
				var thisvals=$("#priceType1text").val();
				if(thisvals=="" || thisvals.length>200){
					$("#priceType1warning").text("CIF port cannot be empty or less than 200 characters").show();
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
					$("#deliveryDateWarning").text("Delivery Date cannot be empty!").show();
					isSubmit=false;
				}
				 var produceNum = $("#produceNum").val();
				 if(produceNum==""){
					 isSubmit = false;
					 $('#produceNumWarning').text('Supply ability cannot be empty!').show();
				 }else if(!/^[1-9]{1}[0-9]*$/.test(produceNum)){
				 	 isSubmit = false;
				 	 $('#produceNumWarning').text('Supply ability cannot be empty or less than 1').show();
				 }else	if(!/^[0-9]{1,8}$/.test(produceNum)){
					 isSubmit = false;
					 $('#produceNumWarning').text('Supply ability should be less than 8 integers').show();
				 };
				var closing=$("#closing").val();
				if(closing==""){
					$("#closingWarning").text("Order closing date cannot be empty!").show();
					isSubmit=false;
				}
				 var maxProdNum = $("#maxProdNum").val();
				 if(maxProdNum==""){
					 isSubmit = false;
					 $('#maxProdNumWarning').text('Maximum quantity cannot be empty!').show();
				 }else if(!/^[1-9]{1}[0-9]*$/.test(maxProdNum)){
				 	 isSubmit = false;
				 	 $('#maxProdNumWarning').text('Maximum quantity cannot be empty or less than 1').show();
				 }else	if(!/^[0-9]{1,8}$/.test(maxProdNum)){
					 isSubmit = false;
					 $('#maxProdNumWarning').text('Maximum quantity should be less than 8 integers').show();
				 };
			};
			
			
			
			
			
		
		var radioval=$('input:radio[name="cost"]:checked').val();
		
		//根据提示判断
		
		
		if(radioval==1){
		   
			var index = 0;
			$(".pp").find("input[type='text']").each(function(){
				var thisvals = $(this).val();
				
				
				if(index%2==0){
					if(!/^[1-9]{1}[0-9]*$/.test(thisvals)){
						$(".tq2 #inputwarning").text("MQQ cannot be empty or less than 1").show();
					  	isSubmit=false;
					}else if(!/^[0-9]{1,5}$/.test(thisvals)){
						  isSubmit = false;
						  $(".tq2 #inputwarning").text('The batch should be less than 6 integers').show();
					}
				} 
				if(thisvals==""){
					$(".tq2 #inputwarning").text("Quote according to quantity，must fill in all the numeric values").show();
				  	isSubmit=false;
				} else if(!$(".tq2 .dpl-tip-inline-warning").is(":hidden")){
					isSubmit=false;
				}
				index++;
				
			});
			index = 0;
			
			var startNum = $("#startNum").val();
			
			if(startNum!=""&&startNum<1){
				isSubmit=false;
				$(".tq2 #inputwarning").text("MQQ cannot be empty or less than 1").show();
			}
		}
		if(radioval==2){
			var isShow = 1;
			$("#tb-speca-quotation").find("input[type='text']").each(function(){
				if($(this).val()==""){
					isSubmit=false;
					isShow = 0;
				}
			});
			
			if(isShow==0){
				$(".g .dpl-tip-inline-warning").text("All values cannot be empty").show();
			}else{
				$(".g .dpl-tip-inline-warning").text("All values cannot be empty").hide();
			}
			
			var minNum = $("#minNum").val();
			 var num =  /^[1-9]{1}[0-9]*$/;
			  if(minNum==""){
				  isSubmit = false;
			      $('.g .dpl-tip-inline-warning').text('MQQ cannot be empty').show();
			  }else if(!num.test(minNum)){
				  isSubmit = false;
				  $('.g .dpl-tip-inline-warning').text('MQQ cannot be empty or less than 1').show();
			  }else	if(!/^[0-9]{1,5}$/.test(minNum)){
				  isSubmit = false;
				  $('.g .dpl-tip-inline-warning').text('The batch should be less than 6 integers').show();
			  }
			  
			  if($(".tab_box .dpl-tip-inline-warning:visible").length>0){
				  isSubmit = false;
			}
		}
	
	//价格信息验证END
	}
	
	
	 
	if(!$("input[name='auto']").is(":checked")){
		 var isSkuCode = 1;
		 var objSkuCode = $("#skuCodeTable").find("input[type='text']");
		 $.each(objSkuCode,function(){
		   if($(this).val()==""){
			   isSkuCode=0;
		       isSubmit = false;
		   }
		 })
		 if(isSkuCode==0){
			 isSubmit=false;
			 $("#skuCodeTable").next(".dpl-tip-inline-warning").text("All values cannot be empty,If not exist bar codes, please select generate system").show();
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
				$("#skuCodeTable").next(".dpl-tip-inline-warning").text("Barcode Image cannot be empty").show();
			} else {
				$("#skuCodeTable").next(".dpl-tip-inline-warning").hide();
			}
		}
	}
	 
	
	
	var firstcategory  = $("#firstcategory").val();
	if(firstcategory==""){
		$("#firstcategory").parent().next().text("Please choose brand").show();
	  	isSubmit=false;
	} else{
		$("#firstcategory").parent().next().text("Please choose brand").hide();
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
	
	/*属性检测*/
	var obj = $(".cont input[type='text'][required='required']");
	$.each(obj,function(i,item){
		if(item.value == ""){
			isSubmit=false;
			$(item).next().text("Please fill out the options with an asterisk!").show();
		}else if(item.value.length>200){
			isSubmit=false;
			$(item).next().text("The length is not greater than 200!").show();
		}else{
			$(item).next().hide();
		}
	});
	var objattrnotrequired = $("#attrdiv").find("input[type='text']:not([required='required'])");
	$.each(objattrnotrequired,function(i,item){
		 if(item.value.length>200){
			isSubmit=false;
			$(item).next().text("The length is not greater than 200!").show();
		}else{
			$(item).next().hide();
		}
	});
	
	
	/*图片检测*/
	var imgs = $(".jinben .wu-example");
	$.each(imgs,function(i,item){
		var num = $(item).find("input[name='imgUrl']").length;
		if(num < 3){
			isSubmit = false;
			$(item).prepend("<span class='dpl-tip-inline-warning' style='display:inline'>Please upload three pictures at least</span>");
		}else{
			$(item).find(".dpl-tip-inline-warning").remove();
		}
			
	});
		
	var zizhiimgs = $("#uploader_00");
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
		$("#productMsg").text("Product title must be 4-200 characters");
	} 
	
	
	
	var remark = $("#customCode").val();
	if(remark.length>50){
		isSubmit = false;
		$("#customCode").parent().next().css("display","inline");
	} else {
		$("#customCode").parent().next().css("display","none");
	}
	var remark = $("#remark").val();
	if(remark.length>200){
		isSubmit = false;
		$("#remark").parent().next().css("display","inline");
	} else {
		$("#remark").parent().next().css("display","none");
	}
	
	
	var salesService = $("#salesService").val();
	if(salesService.length>200){
		isSubmit = false;
		$("#salesService").parent().next().css("display","inline");
		$("#salesService").parent() .next().text("Input must be 0-200 characters");
	}
	
	var packingList = $("#packingList").val();
	
	if(packingList.length>200){
		isSubmit = false;
		$("#packingList").parent().next().css("display","inline");
		$("#packingList").parent().next().text("Input must be 0-200 characters");
	}
	
	
	
	var area = $("#area").val();
	var number = $("#number").val();
	var testArea = new RegExp("^\\d{1,8}$");
	var testNumber = new RegExp("^\\d{1,20}$");
	if(area!=""||number!=""){   
		if(!testArea.test(area)){
			$("#mobiletext").text("Please enter Area Code,must be 1-8 integers").show();
		} else if(!testNumber.test(number)){
			$("#mobiletext").text("Please enter Phone Number,must be 1-20 integers").show();
		}else {
			$("#mobiletext").hide();
		}
	}
	
	
	var regd = new RegExp("^\\d{0,5}$");
	var sheilLife = $("#sheilLife").val();
	if(sheilLife!=undefined){
		if(!regd.test(sheilLife)){
			$("#sheilLife").parent().next(".dpl-tip-inline-warning").text("Shelf life must be less than 5 digits").show();
			isSubmit = false;
		}else {
			$("#sheilLife").parent().next(".dpl-tip-inline-warning").hide();
		}
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
				$('.bb').append( "<p class='addP' style='margin-left:20px;'><input type='text' value='' style='width:50px;'> ：<input type='text' value='' style='width:198px;'> <span class='del'>Delete</span></p>" );
			});
			$(document).on('click','.del',function(){
				$(this).parent('.addP').remove();
			});

		};
		var xiug1=function(){
			$(".tqz span.b3").click(function(){
				$(".tq2 .dpl-tip-inline-warning[id!='inputwarning']").remove();
				var vali = true;
				$(".tqz .b2 input").each(function(){
					if(this.value == "" ){
							$(this).closest("span").after($('<span class="dpl-tip-inline-warning" style="display:block">Please add after complete</span>'));
							vali = false;
							return false;
					}
				});
				if(vali){
					$('.pp').append( "<span class='b2'>Above：<input type='text' name='start'> (Order Quantity) <input type='text' name='pic'><span class='price'> price("+$("select[name='supplierProductSaleSetting.moneyUnitId'] option:selected").text()+"</span>)/<span class='danwei'> "+ $("select[name='supplierProductPackage.measureid'] option:selected").text()+"</span><span class='del'> Delete</span></span>" );
					var length = $(".pp .b2").length;
					if(length == 3){
						$($(".pp .b2:eq(1)")).find(".del").remove();
						$(".b3").hide();
					}
				}
				
			});
			
			$("select[name='supplierProductPackage.measureid']").bind('change',function(){
				var that = this;
				$("span.danwei").text($(that).find("option:selected").text());
			});
			
			$("select[name='supplierProductSaleSetting.moneyUnitId']").bind('change',function(){
				var that = this;
				$("span.price").text("price("+$(that).find("option:selected").text()+")");
			});
			
			$(".tqz").on('click','.del',function(){
				$(this).parent('.b2').remove();
				if($('.pp .b2').length == 2){
					$($(".pp .b2:eq(1)")).append("<span class='del'> Delete</span>");
					$(".b3").show();
				}
				numpricecheck();
			});

		}

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
		}

		
		//加载二级品牌
		function loadingBrand(){
			var path = $("#host").val();
			
			var brandId = '';
			
			$("#firstcategory").change(
			function() {
				$("#secondcategory").empty();
				brandId = $(this).val();
				$.ajax({
					type : "post",
					url : path+ "/product/getOtherBrand",
					data : "brandId="+ brandId,
					success : function(msg) {
						if(msg.length>2){
							var fistBrandlist = "";
								$.each(eval(msg),function(i,n) {
									fistBrandlist += "<option value='"+ n.id+ "'>"+ n.nameEn + "</option>";
								});
								$("#secondcategory").append(fistBrandlist).show();
						} else{
							$("#secondcategory").hide();
							

							$.ajax({
								type : "post",
								url : path+ "/product/descriptionBrand",
								data : "sysBrandId="+ brandId,
								success : function(msg) {
									if(null != msg){
										UE.getEditor('editor').setContent(msg);
									}
								}
							});
						}
					}
				});
			});
		}
		
		
		


function numpricecheck(){
	var value1 = "";
	var value2 = "";
	$(".tq2 #inputwarning").text("").hide();
	$(".tq2 .dpl-tip-inline-warning[id!='inputwarning']").remove();
	var isnull = true;
	$.each($(".pp .b2 input"),function(){
		if ($(this).attr("name") == "start" ){
			if(!RegExp("^\\d{1,6}$").test(this.value) || this.value =="0"){
				
			
		
				$(this).closest("span").after($('<span class="dpl-tip-inline-warning" style="display:block">The batch should be less than 6 integers</span>'));
				isnull = false;
			}
		}else if($(this).attr("name") == "pic"){
			if((!RegExp("^\\d{1,18}\\.\\d+$").test(this.value) && !RegExp("^\\d{1,18}\\.?$").test(this.value))|| Number(this.value)<=0){
				$(this).closest("span").after($('<span class="dpl-tip-inline-warning" style="display:block">The price should be less than 18 digits</span>'));
				isnull = false;
			}else {
				var str= this.value;
				this.value = Number(str).toFixed(4);
			}
			
		}
	});
	if ($(".pp .b2").length>1 && isnull){
		$.each($(".pp .b2"),function(i,item){
			var object = $(item);
			var val1 = object.children()[0].value;
			var val2 = object.children()[1].value;
//			if((!RegExp("^\\d{1,6}$").test(val1)&&val1!="")|| (!RegExp("^\\d*\\.?\\d+$").test(val2)&&val2!="")){
//				$(".tq2 .dpl-tip-inline-warning").text("必须填入数字。").show();
//				return;
//			}
			if(i>0){
				var value11 = parseFloat(val1);
				var value22 = parseFloat(val2); 
				if(value1 < value11 && value2 > value22){
					value1 = value11;
					value2 = value22;
				}else if(value1 >= value11){
					$(".tq2 #inputwarning").text("Price range A-B, B has to be larger than A").show();
					return false;
				}else{
					$(".tq2 #inputwarning").text("Each price must be lower than the previous one above").show();
				}
				
			}else{
				value1 = parseFloat(object.children()[0].value);
				value2 = parseFloat(object.children()[1].value);
			}
		});
	}
//	else{
//		var object = $($(".pp .b2")[0]);
//		if((!RegExp("^\\d*\\.?\\d+$").test(object.children()[0].value)&&object.children()[0].value!="")|| (!RegExp("^\\d*\\.?\\d+$").test(object.children()[1].value)&&object.children()[1].value!="")){
//			$(".tq2 .dpl-tip-inline-warning").text("必须填入数字。").show();
//			return;
//		}
//	}
	
}

function checknum(event){
	var mm = event.target;
	setTimeout(function(){
		var str =  mm.value;
		if(!RegExp("^\\d+\\.?\\d+$").test(str) && !RegExp("^\\d+\\.?$").test(str)){
			mm.value="";;
			//$(mm).delay(100000000).val("");
		}else if($("#same_price").attr("checked")=="checked"){
			changeprice(event);
		}
	
	},1000);
	
}

function checknum1(event){
	var mm = event.target;	
	var str =  mm.value;
	$(".tab_box .dpl-tip-inline-warning").remove();
	if(str!=""){
		var str =  mm.value;
		if((!RegExp("^\\d{1,18}\\.\\d+$").test(str) && !RegExp("^\\d{1,18}\\.?$").test(str)) || Number(str)<0){
			mm.value="";
			$("#tb-speca-quotation").after($('<span class="dpl-tip-inline-warning" style="display:block">The price should be less than 18 digits</span>'))
			//$(mm).delay(100000000).val("");
		}else {
			mm.value = Number(str).toFixed(4);
		}	
		
		if($("#same_price").attr("checked")=="checked"){
			changeprice(event);
		}
	}	
}


function checktiao(event){

	var mm = event.target;	
	var str =  mm.value;
	$(".tab_box .dpl-tip-inline-warning").remove();
	if(str!=""){
		var str =  mm.value;
		var flag = false;
		if(str.length!=19){
			if(str.length ==16){
				if(!RegExp("^\\d{13}-\\d{2}$").test(str)){
					flag = true;
				}
			}else if(str.length ==12){
				if(!RegExp("^\\d{12}$").test(str)){
					flag = true;	
				}
			}else if(str.length ==13){
				if(!RegExp("^\\d{13}$").test(str)){
					flag = true;
				}
			}else if(str.length ==8){
				if(!RegExp("^\\d{8}$").test(str)){
					flag = true;
				}
			}else if(str.length ==10){
				if(!RegExp("^\\d{10}$").test(str)){
					flag = true;
				}
			}else{
				flag = true;
			}
			/*else if(!RegExp("^\\d{8}$||^\\d{12,13}$").test(str)){
				mm.value="";
				$("#tb-tiaoxingma").after($('<span class="dpl-tip-inline-warning" style="display:block">条形码应为8,10,12,13,16位数字</span>'));
				//$(mm).delay(100000000).val(""); 
			}*/
		}
		if(flag){
			mm.value="";
			$("#tb-tiaoxingma").after($('<span class="dpl-tip-inline-warning" style="display:block">Bar  codes should be 8,10,12,13,16 digits</span>'));
		}
	}	

	
/*	
	var mm = event.target;	
	var str =  mm.value;
	$(".tab_box .dpl-tip-inline-warning").remove();
	if(str!=""){
		var str =  mm.value;
		if(str.length!=19){
			if(str.length ==16){
				if(!RegExp("^\\d{13}-\\d{2}$").test(str)){
					mm.value="";
					$("#tb-tiaoxingma").after($('<span class="dpl-tip-inline-warning" style="display:block">Bar  codes should be 8,10,12,13,16 digits</span>'))
				}
			}else if(!RegExp("^\\d{8}$||^\\d{10}$||^\\d{12,13}$").test(str)){
				mm.value="";
				$("#tb-tiaoxingma").after($('<span class="dpl-tip-inline-warning" style="display:block">Bar  codes should be 8,10,12,13,16 digits</span>'))
				//$(mm).delay(100000000).val("");
			}
		}
	}	*/
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
	var operate =$("<div class='operate'><i class='toleft'>Left</i><i class='toright'>Right</i><i class='del'>Delete</i></div>");
	if(url.length == 0){
		var img1 = $("<li class='img-1'></li>").append(p_img.clone()).append(operate.clone());
		var img6 = $("<li class='img-6'></li>").append(p_img.clone()).append(operate.clone());
		var img = $("<li></li>").append(p_img.clone()).append(operate.clone());
		var ul = $("<ul id='"+ id +"_img'></ul>").append(img1).append(img.clone()).append(img.clone()).append(img.clone()).append(img).append(img6);
	}else{
		var ul = $("<ul id='"+ id +"_img'></ul>");
		$.each(url,function(i,item){
			if(i == 0){
				ul.append($("<li class='img-1'><div id='diddendiv'></div></li>").append(p_img.clone().append("<img src='"+ url[i]+"'><input type='hidden' name='imgUrl' value='" + id+"_"+url[i]+"'/></img>")).append(operate.clone().show()));
			}else if(i == 5){
				ul.append($("<li class='img-6'>" +
						"<div id='diddendiv'></div></li>").append(p_img.clone().append("<img src='"+ url[i]+"'><input type='hidden' name='imgUrl' value='" + id+"_"+url[i]+"'/></img>")).append(operate.clone().show()));
			}else{
				ul.append($("<li><div id='diddendiv'></div></li>").append(p_img.clone().append("<img src='"+ url[i]+"'><input type='hidden' name='imgUrl' value='" + id+"_"+url[i]+"'/></img>" )).append(operate.clone().show()));
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
	
	var div = $("<div></div>").append("<div class='wenzi'>"+value+" images:<input id='"+ id +"_upload' name='button' type='submit'  value='upload' /><span class='dpl-tip-inline-warning'>Please upload at least 3 images</span></div>").append(ul);
	var object = $("<div class='z' id='" + id +"_xianshi'></div>").append(div);
	$(".jinben").append(object);
	if (flashDetect()) { // 探测到已经安装了flash插件 则初始化上传按钮和提示
    // 初始化swfUpload组件
        $("#"+id+"_upload").uploadify({
        	'height': 30,
            'swf': '../js/uploadify/uploadify.swf',
            'uploader': '../product/imageUp?supplier_session_id='+sessionId+"&productId="+productId,
            'width': 100,
            'cancelImg': '../js/img/uploadify-cancel.png',
            'auto': true,
            'buttonText': 'upload',
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
    	if(confirm("Hi，Your browser is OUT, it does not install the new version of the Flash Player, fast to install the latest version of the flashplayer")){
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
				
			});
//			$(obj[0]).bind("input propertychange", changeprice);
		}	
	}else{
		if(obj.length > 1){
			$.each(obj,function(i,item){
				if(i>0){
					$(this).removeAttr("readonly");
				}
				
			});
//			$(obj[0]).unbind("input propertychange", changeprice);
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
		});
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
            'buttonText': 'upload',
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