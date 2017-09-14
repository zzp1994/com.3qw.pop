var sessionId = '';
var productId='';
$(document).ready(function(){
	
	//initimg();
	$(".chim").delegate("input", "change", changebox);
	$(".yanse").delegate("input", "change", changebox);
	$(".yanse").delegate("input", "change", changeimg);
	$("input[name='auto']").live("change",tiaoxingma);
	$(".price_domesticPrice_input").live("blur", changefh);
	$("#same_price").bind("change",sameprice);
	$("table#tb-speca-quotation input").live("input propertychange", checknum);
	$("table#tb-speca-quotation input").live("blur", checknum1);
	$("table#tb-tiaoxingma input").live("blur", checktiao);
	$(".operate .toleft").live('click', pre);
	$(".operate .toright").live('click', next);
 	$(".operate .del").live('click' , dele);
	$(".b2 input").live("blur",numpricecheck); 
	
	sessionId = $("#sessionId").val();
	productId= $("#productId").val();
	
	changebox();
	xiug1();
	xiug3();
	changeboxth();
	//商品预览
	$("#previewProd").click(function(){
			$.ajax({
				type:'post',
				url:'../product/previewProd',
				dataType:"html",
				error:function(){
					alert('error');
				},
				success:function(data){
				}
			});
		
	});
	
	
	$("#saveProd").click(function(){
	
		var isSubmit = saveProduct();
		if(!isSubmit){
			alert("商品信息不完整或不符合规范，请修改。");
			
		}else{
		   //var editorValue =UE.getEditor('editor').getContent();
			var cateId = $("#cid").val();
			$(".fabu_btn").attr("disabled",true);
			$.ajax({
				type:'post',
				url:'../product/add',
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
						$.dialog.confirm('保存成功，是否返回到商品列表？', function(){
							window.location.href="../product/onSaleList";
							}, function(){
								window.location.href="../product/toCreateUI?cid="+cateId;
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
					alert('服务器忙，请稍后再试！');
				},
				success:function(data){
					if(data=="0"){
						$(".fabu_btn").attr("disabled",false);
						alert('保存失败，请稍后再试！');
					}
					if(data=="1"){
						$.dialog.confirm('保存成功，是否返回到草稿箱？', function(){
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
				alert('服务器忙，请稍后再试！');
			},
			success:function(data){
				if(data=="0"){
					$(".fabu_btn").attr("disabled",false);
					alert('保存失败，请稍后再试！');
				}
				if(data=="1"){
					$.dialog.confirm('保存成功，是否返回到草稿箱？', function(){
						window.location.href="../product/draftList";
					}, function(){
						window.location.href="../product/toCreateUI?cid="+cateId;
					});
				}
			}
		});
	});
	
	
	
	
	
	$("#editProd").click(function(){
		
		var isSubmit = saveProduct();
		if(!isSubmit){
			alert("商品信息不完整或不符合规范，请修改。");
			
		}else{
			
			$(".fabu_btn").attr("disabled",true);
			$.ajax({
				type:'post',
				url:'../product/editPOPProduct',
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
		
		numpricecheck();
		
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

			
			var radioval=$('input:radio[name="cost"]:checked').val();
			//根据提示判断
			if(radioval==1){
				
				var index = 0;
				$(".pp").find("input[type='text']").each(function(){
					var thisvals = $(this).val();
					
					if(index%2==0){
						if(!/^[1-9]{1}[0-9]*$/.test(thisvals)){
							$(".tq2 #inputwarning").text("起批量必须是整数并且不能以0开头").show();
						  	isSubmit=false;
						}else if(!/^[0-9]{1,5}$/.test(thisvals)){
							  isSubmit = false;
							  $(".tq2 #inputwarning").text('起批量只能是小于六位的整数！').show();
						};
					} 
					if(thisvals==""){
						$(".tq2 #inputwarning").text("按照数量报价 所有数值必填").show();
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
					$(".tq2 #inputwarning").text("起批量不能为空或小于1！").show();
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
					$(".g .dpl-tip-inline-warning").text("所有数值不能为空！").show();
				}else{
					$(".g .dpl-tip-inline-warning").text("所有数值不能为空！").hide();
				}
				
				var minNum = $("#minNum").val();
				 var num =  /^[1-9]{1}[0-9]*$/;
				  if(minNum==""){
					  isSubmit = false;
				      $('.g .dpl-tip-inline-warning').text('最小起订量不能为空！').show();
				  }else if(!num.test(minNum)){
					  isSubmit = false;
					  $('.g .dpl-tip-inline-warning').text('最小起订量只能整数不能已0开头！').show();
				  }else	if(!/^[0-9]{1,5}$/.test(minNum)){
					  isSubmit = false;
					  $('.g .dpl-tip-inline-warning').text('最小起订量只能是小于六位的整数！').show();
				  }
				  
				  if($(".tab_box .dpl-tip-inline-warning:visible").length>0){
					  isSubmit = false;
				}
			}
			
			//价格验证结束
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
		 
		
		// b2c价格校验
		var objPriceCode = $("#skuPriceTable").find("input[type='text']");
		var isPriceCode = 1;
		$.each(objPriceCode,function(r){
			if($(this).val()==""&&r%6!=0){
				isPriceCode=0;
				isSubmit = false;
			}
		});

		if(isPriceCode == 0){
			isSubmit=false;
			$("#skuPriceTable").next(".dpl-tip-inline-warning").text("请填写完整的商品价格").show();
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
			if(num < 1){
				isSubmit = false;
				$(item).prepend("<span class='dpl-tip-inline-warning' style='display:inline'>请至少上传一张图片</span>");
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
		if(remark.length>50){
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
		var xiug1=function(){
			$(".tqz span.b3").click(function(){
				$(".tq2 .dpl-tip-inline-warning[id!='inputwarning']").remove();
				var vali = true;
				$(".tqz .b2 input").each(function(){
					if(this.value == "" ){
							$(this).closest("span").after($('<span class="dpl-tip-inline-warning" style="display:block">请填写完整后再添加</span>'));
							vali = false;
							return false;
					}
				});
				if(vali){
					$('.pp').append( "<span class='b2'>起批量：<input type='text' name='start'>" +
							"<span class='danwei'>"+ $("select[name='supplierProductPackage.measureid'] option:selected").text()+"</span>及以上 " +
							"<input type='text' name='pic'><span class='price'>"+$("select[name='supplierProductSaleSetting.moneyUnitId'] option:selected").text()+"</span>/<span class='danwei'> "+ $("select[name='supplierProductPackage.measureid'] option:selected").text()+"</span><span class='del'> 删除</span></span>" );
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
				$("span.price").text($(that).find("option:selected").text());
			});
			$(".tqz").on('click','.del',function(){
				$(this).parent('.b2').remove();
				if($('.pp .b2').length == 2){
					$($(".pp .b2:eq(1)")).append("<span class='del'> 删除</span>");
					$(".b3").show();
				}
				numpricecheck();
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
			var brandId = '';
			$("#firstcategory").change(function() {
				
				brandId = $(this).val();
				$("#secondcategory").empty();
				$.ajax({
					type : "post",
					url : path+ "/product/getOtherBrand",
					data : "brandId="+ brandId,
					success : function(msg) {
						if(msg.length>2){
							var fistBrandlist = "";
								$.each(eval(msg),function(i,n) {
									fistBrandlist += "<option value='"+ n.id+ "'>"+ n.nameCn + "</option>";
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
		
		
		
		function loadingDescription(){
			
			var path = $("#host").val();
			$("#secondcategory").change(function() {
				var brandId = $(this).val();
				
				$.ajax({
					type : "post",
					url : path+ "/product/descriptionBrand",
					data : "sysBrandId="+ brandId,
					success : function(msg) {
						if(null != msg){
						 UE.getEditor('editor').execCommand('insertHtml',msg);
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
				$(this).closest("span").after($('<span class="dpl-tip-inline-warning" style="display:block">起批量应为小于6位的整数</span>'));
				isnull = false;
			}
		}else if($(this).attr("name") == "pic"){
			if((!RegExp("^\\d{1,18}\\.\\d+$").test(this.value) && !RegExp("^\\d{1,18}\\.?$").test(this.value))|| Number(this.value)<=0){
				$(this).closest("span").after($('<span class="dpl-tip-inline-warning" style="display:block">价格应小于18位数</span>'));
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
			var val1 = object.find("input")[0].value;
			var val2 = object.find("input")[1].value;
			if(i>0){
				var value11 = parseFloat(val1);
				var value22 = parseFloat(val2); 
				if(value1 < value11 && value2 > value22){
					value1 = value11;
					value2 = value22;
				}else if(value1 >= value11){
					$(".tq2 #inputwarning").text("起批量必须后者大于前者。").show();
					return false;
				}else{
					$(".tq2 #inputwarning").text("产品单价必须后者小于前者。").show();
				}
				
			}else{
				value1 = parseFloat(object.find("input")[0].value);
				value2 = parseFloat(object.find("input")[1].value);
			}
		});
	}
	
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
		if((!RegExp("^\\d{1,18}\\.\\d+$").test(str) && !RegExp("^\\d{1,18}\\.?$").test(str)) || Number(str)<0){
			mm.value="";
			$("#tb-speca-quotation").after($('<span class="dpl-tip-inline-warning" style="display:block">价格应小于18位数</span>'));
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
			$("#tb-tiaoxingma").after($('<span class="dpl-tip-inline-warning" style="display:block">条形码应为8,10,12,13,16位数字</span>'));
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
	
	var div = $("<div></div>").append("<div class='wenzi'>"+value+"的图片:<input id='"+ id +"_upload' name='button' type='submit'  value='图片上传' /><span class='dpl-tip-inline-warning'>请至少上传一张图片</span></div>").append(ul);
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
	var chilen = $(".chim").length;
	var chim;
	var chim2;
	var chim3;
	var chim4;
	if(chilen >= 1){
		$(".chim").each(function(e,n){
			if(e == 0){
				chim = $(this).find('input[type=\'checkbox\']');
				var title = $(this).children("div:eq(0)").attr("title");
				$(".cm1").show();
				$(".cm1 span").text(title);
			}
			if(e == 1){
				chim2 = $(this).find('input[type=\'checkbox\']');
				var title = $(this).children("div:eq(0)").attr("title");
				$(".cm2").show();
				$(".cm2 span").text(title);
			}
			if(e == 2){
				chim3 = $(this).find('input[type=\'checkbox\']');
				var title = $(this).children("div:eq(0)").attr("title");
				$(".cm3").show();
				$(".cm3 span").text(title);
			}
			if(e == 3){
				chim4 = $(this).find('input[type=\'checkbox\']');
				var title = $(this).children("div:eq(0)").attr("title");
				$(".cm4").show();
				$(".cm4 span").text(title);
			}
		});
	}else{
		chim = $(".chim input:checked");
	}
	var yanse = $(".yanse input:checked");
	var chimlen = chim.length;
	var chimlen2 = 0;
	if(typeof(chim2)!="undefined"){
		chimlen2 = chim2.length;
	}
	var chimlen3 = 0;
	if(typeof(chim3)!="undefined"){
		chimlen3 = chim3.length;
	}
	var chimlen4 = 0;
	if(typeof(chim4)!="undefined"){
		chimlen4 = chim4.length;
	}
	var yanselen = yanse.length;
	if(yanselen == 0 && chimlen == 0){
		$("#tb-speca-quotation").hide();
		return;
	}

	tableInfo = _fStoreTableInfo("tb-speca-quotation");
	tiaoxingmainfo = _fStoreTableInfo("tb-tiaoxingma");
	skupriceInfo = _fStoreTableB2CPrice("tb-skuprice");

	$("#tb-speca-quotation tbody").remove();
	$("#tb-tiaoxingma tbody").remove();
	$("#tb-skuprice tbody").remove();

	$("#skuCodeTable > .dpl-tip-inline-warning").empty().hide();
	document.getElementById("same_price").checked = false;
	$("#tb-speca-quotation").show();	
	

	if(yanselen == 0){
		var tbody = $("<tbody></tbody>");
		var tbody1 = $("<tbody></tbody>");
		var tbody2 = $("<tbody></tbody>");
		var tr = $("");
		var tr1 = $("");
		var tr2 = $("");
		$.each(chim,function(i,n){
			if(i == 0){
				tr = $("<tr ><td id='' class='yan' rowspan='"+ chimlen +"'></td><td class='chi' id='"+ n.id +"'>"+ n.value +"</td><td>" +
						"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
						"<input type='hidden' name='buyName' value='"+n.value+"'>" +
						"<input class='pro_price' type='text'  value=''></td></tr>");
				tr1 = $("<tr ><td id='' class='yan' rowspan='"+ chimlen +"'></td><td class='chi' id='"+ n.id +"'>"+ n.value +"</td><td>" +
				"<input class='pro_price' type='text'  value=''></td><td><div class='preview_fake'  id='-"+n.id+"_img' ></div></td><td><input class='file'  id='-"+n.id+"_upload' name='button'   type='submit' /></td></tr>");


				tr2 = $("<tr ><td id='' class='yan' rowspan='"+ chimlen +"'></td><td class='chi' id='"+ n.id +"'>"+ n.value +"</td><td>" +
						"<input class='pro_price' type='text'  value=''></td><td><input class='pro_price' type='text'  value=''></td>" +
						"<td ><input class='hqj_price' type='text' readonly='readonly' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text'  value=''></td></tr>");

			}else{
				tr = $("<tr><td class='chi'>"+ n.value +"</td><td id='"+ n.id +"'>" +
						"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
						"<input type='hidden' name='buyName' value='"+n.value+"'>" +
						"<input class='pro_price' type='text' name='productPic'></td></tr>");
				tr1 = $("<tr><td class='chi'>"+ n.value +"</td><td id='"+ n.id +"'>" +
						"<input class='pro_price' type='text' name='skuCode'></td><td><div class='preview_fake'  id='-"+n.id+"_img' ></div></td><td><input class='file'  id='-"+n.id+"_upload' name='button'   type='submit' /></td></tr>");


				tr2 = $("<tr><td class='chi'>"+ n.value +"</td><td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td id='"+ n.id +"'>" +
						"<input class='price_id_input' type='hidden' name='priceId'><input class='price_domesticPrice_input' type='text' name='domesticPrice'></td><td><input class='price_unitPrice_input' readonly='readonly' name='unitPrice' type='text'  ></td><td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' readonly='readonly' name='hqj' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed' value=''></td></tr>");

			}

			tbody.append(tr);
			tbody1.append(tr1);
			tbody2.append(tr2);
		});
		$("#tb-speca-quotation").append(tbody);
		//条形码
		$("#tb-tiaoxingma").append(tbody1);
		$("#tb-skuprice").append(tbody2);
		_Itiaoimg();
		_fShowTableInfo(tableInfo,"tb-speca-quotation");
		_fShowTableInfo(tiaoxingmainfo,"tb-tiaoxingma");
		_fShowTableInfo(skupriceInfo,"tb-skuprice");

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

			tr2 = $("<tbody><tr><td class='yan' id='"+ n.id +"'>"+ n.value +"</td><td class='chi' id=''></td><td>" +
					"<input class='pro_price' type='text'></td><td><input class='pro_price' type='text'  value=''></td>" +
						"<td ><input class='hqj_price' type='text' readonly='readonly' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' value=''></td></tr></tbody>");



			$("#tb-speca-quotation").append(tr);
			$("#tb-tiaoxingma").append(tr1);
			$("#tb-skuprice").append(tr2);
		});
		_Itiaoimg();
		_fShowTableInfo(tableInfo,"tb-speca-quotation");
		_fShowTableInfo(tiaoxingmainfo,"tb-tiaoxingma");
		_fShowTableInfo(skupriceInfo,"tb-skuprice");
		return;
	}
	if(yanselen > 0 && chimlen >0 && chimlen2 == 0){
		$.each(yanse,function(i,n){
			var tbody = $("<tbody></tbody>");
			var tbody1 = $("<tbody></tbody>");
			var tbody2 = $("<tbody></tbody>");

			var tr = $("");
			var tr1 = $("");
			var tr2 = $("");
			$.each(chim,function(j,m){
				if(j == 0){
					tr = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen +"'>"+ n.value +"</td><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.id+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input class='pro_price' type='text' name='productPic'></td></tr>");
					tr1 = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen +"'>"+ n.value +"</td><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input class='pro_price' type='text' name='skuCode'><input type='hidden' name='barCodeImg' value='Http://image01.3qianwan.com/h0/group1/1'/></td></tr>")


					tr2 = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen +"'>"+ n.value +"</td><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td>" +
							"<input class='price_id_input' type='hidden' name='priceId'><input class='price_domesticPrice_input' type='text' name='domesticPrice'></td><td><input class='price_unitPrice_input' readonly='readonly' name='unitPrice' type='text'  value=''></td><td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' name='hqj' readonly='readonly'></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed'></td></tr>")

				}else{
					tr = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.id+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input class='pro_price' type='text' name='productPic'></td></tr>");
					tr1 = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input class='pro_price' type='text' name='skuCode'><input type='hidden' name='barCodeImg' value='Http://image01.3qianwan.com/h0/group1/1'/></td></tr>");


					tr2 = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td>" +
							"<input class='price_id_input' type='hidden' name='priceId'><input class='price_domesticPrice_input' type='text' name='domesticPrice'></td><td><input class='price_unitPrice_input' readonly='readonly' name='unitPrice' type='text'  value=''></td><td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' name='hqj' readonly='readonly'></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed'></td></tr>");

				}
				tbody.append(tr);
				tbody1.append(tr1);
				tbody2.append(tr2);
			});
			
			$("#tb-speca-quotation").append(tbody);
			$("#tb-tiaoxingma").append(tbody1);
			$("#tb-skuprice").append(tbody2);
		});
		_Itiaoimg();
		_fShowTableInfo(tableInfo,"tb-speca-quotation");
		_fShowTableInfo(tiaoxingmainfo,"tb-tiaoxingma");
		_fShowTableInfo(skupriceInfo,"tb-skuprice");
	}	
	if(yanselen > 0 && chimlen >0 && chimlen2 > 0 && chimlen3 == 0){
		$.each(yanse,function(i,n){
			var tbody = $("<tbody></tbody>");
			var tbody1 = $("<tbody></tbody>");
			var tbody2 = $("<tbody></tbody>");

			var tr = $("");
			var tr1 = $("");
			var tr2 = $("");
			$.each(chim,function(j,m){
				$.each(chim2,function(k,l){
					tr = $("<tr></tr>");
					if(j == 0 && k == 0){
						tr.append($("<td class='yan' id='"+ n.id +"' rowspan='"+ chimlen * chimlen2 +"'>"+ n.value +"</td>" +
								"<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
								"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>"));
					}else{
						tr.append($("<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
								"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>"));
					}
					tr1 = tr.clone();
					tr2 = tr.clone();
					
					tr.append($("<td><input type='hidden' name='buyVal' value='"+n.id+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.id+"'>" +
							"<input type='hidden' name='saleVal2' value='"+l.id+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input type='hidden' name='saleName2' value='"+l.value+"'>" +
							"<input class='pro_price' type='text' name='productPic'></td>"));
					tr1.append($("<td><input class='pro_price' type='text' name='skuCode'><input type='hidden' name='barCodeImg' value='Http://image01.3qianwan.com/h0/group1/1'/></td>"));


					tr2.append($("<td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td>" +
							"<input class='price_id_input' type='hidden' name='priceId'>" +
							"<input class='price_domesticPrice_input' type='text' name='domesticPrice'></td>" +
							"<td><input class='price_unitPrice_input' readonly='readonly' name='unitPrice' type='text'  value=''></td>" +
							"<td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' name='hqj' readonly='readonly'></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed'></td>"));
					tbody.append(tr);
					tbody1.append(tr1);
					tbody2.append(tr2);
				});
			});
			$("#tb-speca-quotation").append(tbody);
			$("#tb-tiaoxingma").append(tbody1);
			$("#tb-skuprice").append(tbody2);
		});
		_Itiaoimg();
		_fShowTableInfo(tableInfo,"tb-speca-quotation");
		_fShowTableInfo(tiaoxingmainfo,"tb-tiaoxingma");
		_fShowTableInfo(skupriceInfo,"tb-skuprice");
	}	
	if(yanselen > 0 && chimlen >0 && chimlen2 > 0 && chimlen3 > 0 && chimlen4 == 0){
		$.each(yanse,function(i,n){
			var tbody = $("<tbody></tbody>");
			var tbody1 = $("<tbody></tbody>");
			var tbody2 = $("<tbody></tbody>");

			var tr = $("");
			var tr1 = $("");
			var tr2 = $("");
			$.each(chim,function(j,m){
				$.each(chim2,function(k,l){
					$.each(chim3,function(q,s){
						tr = $("<tr></tr>");
						if(j == 0 && k == 0 && q == 0){
							tr.append($("<td class='yan' id='"+ n.id +"' rowspan='"+ chimlen * chimlen2 * chimlen3 +"'>"+ n.value +"</td>" +
									"<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>"));
						}else{
							tr.append($("<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>"));
						}
						tr1 = tr.clone();
						tr2 = tr.clone();
					
						tr.append($("<td><input type='hidden' name='buyVal' value='"+n.id+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.id+"'>" +
							"<input type='hidden' name='saleVal2' value='"+l.id+"'>" +
							"<input type='hidden' name='saleVal3' value='"+s.id+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input type='hidden' name='saleName2' value='"+l.value+"'>" +
							"<input type='hidden' name='saleName3' value='"+s.value+"'>" +
							"<input class='pro_price' type='text' name='productPic'></td>"));
						tr1.append($("<td><input class='pro_price' type='text' name='skuCode'><input type='hidden' name='barCodeImg' value='Http://image01.3qianwan.com/h0/group1/1'/></td>"));


						tr2.append($("<td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td>" +
							"<input class='price_id_input' type='hidden' name='priceId'>" +
							"<input class='price_domesticPrice_input' type='text' name='domesticPrice'></td>" +
							"<td><input class='price_unitPrice_input' readonly='readonly' name='unitPrice' type='text'  value=''></td>" +
							"<td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' name='hqj' readonly='readonly'></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed'></td>"));
						tbody.append(tr);
						tbody1.append(tr1);
						tbody2.append(tr2);
					});
				});
			});
			$("#tb-speca-quotation").append(tbody);
			$("#tb-tiaoxingma").append(tbody1);
			$("#tb-skuprice").append(tbody2);
		});
		_Itiaoimg();
		_fShowTableInfo(tableInfo,"tb-speca-quotation");
		_fShowTableInfo(tiaoxingmainfo,"tb-tiaoxingma");
		_fShowTableInfo(skupriceInfo,"tb-skuprice");
	}	
	if(yanselen > 0 && chimlen >0 && chimlen2 > 0 && chimlen3 > 0 && chimlen4 > 0){
		$.each(yanse,function(i,n){
			var tbody = $("<tbody></tbody>");
			var tbody1 = $("<tbody></tbody>");
			var tbody2 = $("<tbody></tbody>");

			var tr = $("");
			var tr1 = $("");
			var tr2 = $("");
			$.each(chim,function(j,m){
				$.each(chim2,function(k,l){
					$.each(chim3,function(q,s){
						$.each(chim4,function(r,t){
							tr = $("<tr></tr>");
							if(j == 0 && k == 0 && q == 0 && r == 0){
								tr.append($("<td class='yan' id='"+ n.id +"' rowspan='"+ chimlen * chimlen2 * chimlen3 * chimlen4 +"'>"+ n.value +"</td>" +
										"<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
										"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
										"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
										"<td class='chi3' id='"+ t.id +"'>"+ t.value +"</td>"));
							}else{
								tr.append($("<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
										"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
										"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
										"<td class='chi3' id='"+ t.id +"'>"+ t.value +"</td>"));
							}
							tr1 = tr.clone();
							tr2 = tr.clone();
					
							tr.append($("<td><input type='hidden' name='buyVal' value='"+n.id+"'>" +
								"<input type='hidden' name='saleVal' value='"+m.id+"'>" +
								"<input type='hidden' name='saleVal2' value='"+l.id+"'>" +
								"<input type='hidden' name='saleVal3' value='"+s.id+"'>" +
								"<input type='hidden' name='saleVal4' value='"+t.id+"'>" +
								"<input type='hidden' name='buyName' value='"+n.value+"'>" +
								"<input type='hidden' name='saleName' value='"+m.value+"'>" +
								"<input type='hidden' name='saleName2' value='"+l.value+"'>" +
								"<input type='hidden' name='saleName3' value='"+s.value+"'>" +
								"<input type='hidden' name='saleName4' value='"+t.value+"'>" +
								"<input class='pro_price' type='text' name='productPic'></td>"));
							tr1.append($("<td><input class='pro_price' type='text' name='skuCode'><input type='hidden' name='barCodeImg' value='Http://image01.3qianwan.com/h0/group1/1'/></td>"));
	
	
							tr2.append($("<td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td>" +
								"<input class='price_id_input' type='hidden' name='priceId'>" +
								"<input class='price_domesticPrice_input' type='text' name='domesticPrice' value=''></td>" +
								"<td><input class='price_unitPrice_input' readonly='readonly' name='unitPrice' type='text'  value=''></td>" +
								"<td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td><input class='hqj_price' type='text' name='hqj' readonly='readonly' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed'></td>"));
							tbody.append(tr);
							tbody1.append(tr1);
							tbody2.append(tr2);
						});
					});
				});
			});
			$("#tb-speca-quotation").append(tbody);
			$("#tb-tiaoxingma").append(tbody1);
			$("#tb-skuprice").append(tbody2);
		});
		_Itiaoimg();
		_fShowTableInfo(tableInfo,"tb-speca-quotation");
		_fShowTableInfo(tiaoxingmainfo,"tb-tiaoxingma");
		_fShowTableInfo(skupriceInfo,"tb-skuprice");
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
	var hqj = $("#hqj").val();
	var fhed = $("#fhed").val();
	$.each(tableInfo,function(k){
		$.each(obj,function(i,item){
			var color_id = $(item).find(".yan").attr("id");
			if(color_id == tableInfo[k][0]){
				
				$.each($(item).children(),function(j,item1){
					/*$(item1).find(".price_unitPrice_input").val(tableInfo[k][6]);
					$(item1).find(".price_domesticPrice_input").val(tableInfo[k][5]);
					$(item1).find(".hqj_price").val(tableInfo[k][9]);*/
					var chi_id = $(item1).find(".chi").attr("id");
					var chi_id2 = $(item1).find(".chi1").attr("id");
					var chi_id3 = $(item1).find(".chi2").attr("id");
					var chi_id4 = $(item1).find(".chi3").attr("id");
					if(typeof(chi_id2)=="undefined"&&typeof(chi_id3)=="undefined"&&typeof(chi_id4)=="undefined"){
						if(chi_id == tableInfo[k][1][0]){
							
							$(item1).find(".pro_price").val(tableInfo[k][2]);
							if(tablename == "tb-tiaoxingma"){
								$(item1).find(".pro_price").attr('readonly','readonly');
								$(item1).find(".preview_fake").html(tableInfo[k][3]);
								
							}
	
							if(tablename == "skuPriceTable" && typeof (tableInfo[k][4]) != 'undefined'){
								// 设置商品价格
								//console.info(tableInfo[k][0]);
								
								
								$(item1).find(".price_id_input").val(tableInfo[k][4]);
								$(item1).find(".price_domesticPrice_input").val(tableInfo[k][5]);
								$(item1).find(".price_unitPrice_input").val(tableInfo[k][6]);
								$(item1).find(".price_bestoayPrice_input").val('0');
								$(item1).find(".productCode_input").val(tableInfo[k][8]);
								if(typeof(hqj)!="undefined"&&typeof(fhed)!="undefined"){
									$(item1).find(".hqj_price").val(tableInfo[k][9]);
									$(item1).find(".fhed_price").val(tableInfo[k][6]*fhed);
								}else{
									$(item1).find(".hqj_price").val(tableInfo[k][9]);
									$(item1).find(".fhed_price").val(tableInfo[k][10]);
								}
								$(item1).find(".hqj_price").attr("readonly","readonly");
								$(item1).find(".fhed_price").attr("readonly","readonly");
								$(item1).find(".price_unitPrice_input").attr("readonly","readonly");
							}
						}
					//console.info(typeof (tableInfo[k][4]))
					}
					if(typeof(chi_id2)!="undefined"&&typeof(chi_id3)=="undefined"&&typeof(chi_id4)=="undefined"){
						
						if(chi_id == tableInfo[k][1][0] && chi_id2 == tableInfo[k][1][1]){
							$(item1).find(".pro_price").val(tableInfo[k][2]);
							if(tablename == "tb-tiaoxingma"){
								$(item1).find(".pro_price").attr('readonly','readonly');
								$(item1).find(".preview_fake").html(tableInfo[k][3]);
							}
	
							if(tablename == "skuPriceTable" && typeof (tableInfo[k][4]) != 'undefined'){
								// 设置商品价格
								//console.info(tableInfo[k][0])
								
	
								$(item1).find(".price_id_input").val(tableInfo[k][4]);
								$(item1).find(".price_domesticPrice_input").val(tableInfo[k][5]);
								$(item1).find(".price_unitPrice_input").val(tableInfo[k][6]);
								$(item1).find(".price_bestoayPrice_input").val('0');
								$(item1).find(".productCode_input").val(tableInfo[k][8]);
								if(typeof(hqj)!="undefined"&&typeof(fhed)!="undefined"){
									$(item1).find(".hqj_price").val(tableInfo[k][9]);
									$(item1).find(".fhed_price").val(tableInfo[k][6]*fhed);
								}else{
									$(item1).find(".hqj_price").val(tableInfo[k][9]);
									$(item1).find(".fhed_price").val(tableInfo[k][10]);
								}
								$(item1).find(".hqj_price").attr("readonly","readonly");
								$(item1).find(".fhed_price").attr("readonly","readonly");
								$(item1).find(".price_unitPrice_input").attr("readonly","readonly");
							}
						}
					}
					if(typeof(chi_id2)!="undefined"&&typeof(chi_id3)!="undefined"&&typeof(chi_id4)=="undefined"){
						
						if(chi_id == tableInfo[k][1][0] && chi_id2 == tableInfo[k][1][1] && chi_id3 == tableInfo[k][1][2]){
							
							$(item1).find(".pro_price").val(tableInfo[k][2]);
							if(tablename == "tb-tiaoxingma"){
								$(item1).find(".pro_price").attr('readonly','readonly');
								$(item1).find(".preview_fake").html(tableInfo[k][3]);
							}
	
							if(tablename == "skuPriceTable" && typeof (tableInfo[k][4]) != 'undefined'){
								// 设置商品价格
								//console.info(tableInfo[k][0])
	
								
								$(item1).find(".price_id_input").val(tableInfo[k][4]);
								$(item1).find(".price_domesticPrice_input").val(tableInfo[k][5]);
								$(item1).find(".price_unitPrice_input").val(tableInfo[k][6]);
								$(item1).find(".price_bestoayPrice_input").val('0');
								$(item1).find(".productCode_input").val(tableInfo[k][8]);
								if(typeof(hqj)!="undefined"&&typeof(fhed)!="undefined"){
									$(item1).find(".hqj_price").val(tableInfo[k][9]);
									$(item1).find(".fhed_price").val(tableInfo[k][6]*fhed);
								}else{
									$(item1).find(".hqj_price").val(tableInfo[k][9]);
									$(item1).find(".fhed_price").val(tableInfo[k][10]);
								}
								$(item1).find(".hqj_price").attr("readonly","readonly");
								$(item1).find(".fhed_price").attr("readonly","readonly");
								$(item1).find(".price_unitPrice_input").attr("readonly","readonly");
							}
						}
					}
					if(typeof(chi_id2)!="undefined"&&typeof(chi_id3)!="undefined"&&typeof(chi_id4)!="undefined"){
						
						if(chi_id == tableInfo[k][1][0] && chi_id2 == tableInfo[k][1][1] && chi_id3 == tableInfo[k][1][2] && chi_id4 == tableInfo[k][1][3]){
							$(item1).find(".pro_price").val(tableInfo[k][2]);
							if(tablename == "tb-tiaoxingma"){
								$(item1).find(".pro_price").attr('readonly','readonly');
								$(item1).find(".preview_fake").html(tableInfo[k][3]);
							}
	
							if(tablename == "skuPriceTable" && typeof (tableInfo[k][4]) != 'undefined'){
								// 设置商品价格
								//console.info(tableInfo[k][0])
	
								
								$(item1).find(".price_id_input").val(tableInfo[k][4]);
								$(item1).find(".price_domesticPrice_input").val(tableInfo[k][5]);
								$(item1).find(".price_unitPrice_input").val(tableInfo[k][6]);
								$(item1).find(".price_bestoayPrice_input").val('0');
								$(item1).find(".productCode_input").val(tableInfo[k][8]);
								if(typeof(hqj)!="undefined"&&typeof(fhed)!="undefined"){
									$(item1).find(".hqj_price").val(tableInfo[k][9]);
									$(item1).find(".fhed_price").val(tableInfo[k][6]*fhed);
								}else{
									$(item1).find(".hqj_price").val(tableInfo[k][9]);
									$(item1).find(".fhed_price").val(tableInfo[k][10]);
								}
								$(item1).find(".hqj_price").attr("readonly","readonly");
								$(item1).find(".fhed_price").attr("readonly","readonly");
								$(item1).find(".price_unitPrice_input").attr("readonly","readonly");
							}
						}
					}
				});
			}
		});
	});

}


/**
 * 加入B2c价格选择table
 * @param tablename
 * @returns {Array}
 * @private
 */
function _fStoreTableB2CPrice(tablename){
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
/*根据一级品牌查询子品牌*/
function onChange(brandId){
    var path = $("#host").val();
	$("#secondcategory").empty();
	$.ajax({
		type : "post",
		url : path+ "/product/getOtherBrand",
		data : "brandId="+ brandId,
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
}
var i=0;
var j=0;
var m=0;
$(document).ready(function(){
	
	$("#addTable").click(function(){
		
   		var tr="<tr><td><input type='text' id='attrOrd"+i+"' name='attrOrd' value='"+i+"' style='width: 30px;'/><input type='hidden' name='attrRows' value='"+i+"'/></td>"+
   		"<td><select name='type"+i+"'><option value='3'>文本</option><option value='1'>多选框</option></select></td>"+
   		"<td><input type='text' id='attrNm"+i+"' name='attrName' style='width: 80px;'/></td>"+
   		"<td id='addAttrvals"+i+"'><img src='../images/img_+bg.jpg' onclick='addAttrval("+i+")'></td>"+
   		"<td><input type='button' onclick='delAttr(this)' value='删除'/></td></tr>";
   		$("#tbl").append(tr);
		i++;
	});
});
function addAttrval(obj){
	var tr = $("<input type='text' name='attrval"+obj+"' id='attrval"+j+"' style='width: 100px;'/><img src='../images/img_23.png' id='img"+j+"' onclick='delAttrval("+j+")'>");
	var id = "#addAttrvals"+obj;
	$(id).append(tr);
	j++;
}
function delAttr(obj){
	document.getElementById("tbl").deleteRow(obj.parentElement.parentElement.rowIndex);
}
function delAttrval(obj){
	document.getElementById("attrval"+obj).remove();
	document.getElementById("img"+obj).remove();
}
function addBuyAttrval(){
	//var nums = $(".yanse2 input[type=\'checkbox\']:checked").length;
	var tr = $("<input type='checkbox' checked='checked' disabled='disabled' name='buyAttrvalch' id='buyAttrvalch"+m+"' alt='0'/><input type='text' name='buyAttrval' alt='"+m+"' id='buyAttrval"+m+"' style='width: 100px;'/>");
	var id = "#addBuyAttrvals";
	$(id).append(tr);
	m++;
}
function delBuyAttrval(obj){
	var obj = $("input[name='buyAttrval']").length;
	$("input[name='buyAttrval']").last().remove();
	var x = obj-1;
	var ss = document.getElementById("buyAttrval"+x+"_xianshi");
	ss.parentNode.removeChild(ss);
	changebox();
}
function addSaleAttrval(obj){
	var num1 = $("#addSaleAttrvals"+obj+" input[name='saleAttrval"+obj+"']").length;
	var tr = $("<input type='checkbox' checked='checked' disabled='disabled' name='saleAttrvalch' id='saleAttrvalch"+obj+""+num1+"' alt='0'/><input type='text' name='saleAttrval"+obj+"' alt='0' id='saleAttrval"+obj+""+num1+"' style='width: 100px;'/>");
	var id = "#addSaleAttrvals"+obj;
	$(id).append(tr);
}
function delSaleAttrval(obj){
	$("input[name='saleAttrval"+obj+"']").last().remove();
	$("input[id='saleAttrvalch"+obj+"']").last().remove();
	//document.getElementById("saleAttrval"+obj).remove();
	//document.getElementById("saleImg"+obj).remove();
	//document.getElementById("saleAttrvalch"+obj).remove();
}
function changeboxth(){
	var buyAttrName = $(".yanse1").attr("title");
	$("#zhan1").text(buyAttrName);
	$("#zhan2").text(buyAttrName);
	$("#zhan3").text(buyAttrName);
}
function changefh(event){
	var unitpri = event.target;
	var scj = $("#scj").val();
	var hqj = $("#hqj").val();
	var fhed = $("#fhed").val();
	var trthis = $(unitpri).parent().parent();
	trthis.find('.price_unitPrice_input').val(Math.round(parseFloat($(unitpri).val()*scj)));
	/*trthis.find('.hqj_price').val(Math.round(parseFloat(Math.round(parseFloat($(unitpri).val()*scj))*hqj)));*/
	trthis.find('.fhed_price').val(Math.round(parseFloat($(unitpri).val()*scj*fhed)));
}