var sessionId = '';
var productId='';
$(document).ready(function(){
	//initimg();
	$(".chim").delegate("input", "change", changebox);
	$(".yanse").delegate("input", "change", changebox);
	$("#same_price").bind("change",sameprice);
	$("table#tb-speca-quotation input").live("input propertychange", checknum);
	$("table#tb-speca-quotation input").live("blur", checknum1);
	$(".b2 input").live("blur",numpricecheck); 
	
	sessionId = $("#sessionId").val();
	productId= $("#productId").val();
	
	
	
	changebox();
	xiug1();
	xiug3();
	
	
	$("#editPrice").click(function(){
		
		var isSubmit = saveProduct();
		if(!isSubmit){
			alert("商品信息不完整或不符合规范，请修改。");
			
		}else{
			
			$(".fabu_btn").attr("disabled",true);
			$.ajax({
				type:'post',
				url:'../product/updateProdPrice',
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