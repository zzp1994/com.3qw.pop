$(document).ready(function(){
	//initimg();

//    xiug();
	changebox();
	xiug1();
	xiug3();
	loadingBrand();
	changeboxth();
});
        //全部发布商品开始
		var xiug=function(){
			$(".i_box .jia").click(function(){
				$('.bb').append( "<p class='addP' style='margin-left:20px;'><input type='text' value='' style='width:50px;'> ：<input type='text' value='' style='width:198px;'></p>" );
			});
			$(document).on('click','.del',function(){
				$(this).parent('.addP').remove();
			});

		}
		var xiug1=function(){
			$("span.b3").click(function(){
				$('.pp').append( "<span class='b2'>Above：<input type='text' name='start'> (Order Quantity) <input type='text' name='pic'>Price（RMB）/Unit</span>" );
				var length = $(".pp .b2").length;
				if (length>=3){
					$(".b3").hide();
				}
			});
			$(document).on('click','.del',function(){
				$(this).parent('.b2').remove();
				$(".b3").show();
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
									fistBrandlist += "<option value='"+ n.id+ "'>"+ n.nameEn + "</option>";
								});
								$("#secondcategory").append(fistBrandlist).show();
						} else{
							$("#secondcategory").hide();
						}
					}
				});
			});
		}
		
		
		






var tableInfo=[];

var test=[];

function inituploadzizhi(url){
	$.each(url,function(i,item){
		$("#zizhi .p-img").eq(i).append("<img src='"+ url[i]+"'></img>");
	});
}


function adduploadimg(value,id,url){
	var p_img = $("<div class='p-img'></div>");
	//var operate =$("<div class='operate'><i class='toleft'>左移</i><i class='toright'>右移</i><i class='del'>删除</i></div>");
	if(url.length == 0){
		var img1 = $("<li class='img-1'></li>").append(p_img.clone());
		var img6 = $("<li class='img-6'></li>").append(p_img.clone());
		var img = $("<li></li>").append(p_img.clone());
		var ul = $("<ul id='"+ id +"_img'></ul>").append(img1).append(img.clone()).append(img.clone()).append(img.clone()).append(img).append(img6);
	}else{
		var ul = $("<ul id='"+ id +"_img'></ul>");
		$.each(url,function(i,item){
			if(i == 0){
				ul.append($("<li class='img-1'><div id='diddendiv'><input type='hidden' name='imgUrl' value='" + id+"_"+url[i]+"'/></div></li>").append(p_img.clone().append("<img src='"+ url[i]+"'/>")));
			}else if(i == 5){
				ul.append($("<li class='img-6'>" +
						"<div id='diddendiv'><input type='hidden' name='imgUrl' value='" + id+"_"+url[i]+"'/></div></li>").append(p_img.clone().append("<img src='"+ url[i]+"'/>")));
			}else{
				ul.append($("<li><div id='diddendiv'><input type='hidden' name='imgUrl' value='" + id+"_"+url[i]+"'/></div></li>").append(p_img.clone().append("<img src='"+ url[i]+"'/>" )));
			}
		});
		if(url.length<6){
			for(var j = url.length;j<6;j++){
				if(j == 5){
					ul.append($("<li class='img-6'></li>").append(p_img.clone()));
				}else{
					ul.append($("<li></li>").append(p_img.clone()));
				}
			}
		}			
	}
	
	var div = $("<div class='wenzi'>"+value+" 的图片:</div>").append(ul);
	var object = $("<div class='z' id='" + id +"_xianshi'></div>").append(div);
	$(".jinben").append(object);
	
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
				$(".cm1 eq["+e+"]").show();
				$(".cm1 span").text(title);
			}
			if(e == 1){
				chim2 = $(this).find('input[type=\'checkbox\']');
				var title = $(this).children("div:eq(0)").attr("title");
				$(".cm2 eq["+e+"]").show();
				$(".cm2 span").text(title);
			}
			if(e == 2){
				chim3 = $(this).find('input[type=\'checkbox\']');
				var title = $(this).children("div:eq(0)").attr("title");
				$(".cm3 eq["+e+"]").show();
				$(".cm3 span").text(title);
			}
			if(e == 3){
				chim4 = $(this).find('input[type=\'checkbox\']');
				var title = $(this).children("div:eq(0)").attr("title");
				$(".cm4 eq["+e+"]").show();
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
				"<input class='pro_price' type='text'  value=''></td></tr>");


				tr2 = $("<tr ><td id='' class='yan' rowspan='"+ chimlen +"'></td><td class='chi' id='"+ n.id +"'>"+ n.value +"</td><td></td><td>" +
						"<input class='pro_price' type='text'  value=''></td><td><input class='pro_price' type='text'  value=''></td>" +
						"<td ><input class='hqj_price' type='text' readonly='readonly' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text'  value=''></td></tr>");

			}else{
				tr = $("<tr><td class='chi'>"+ n.value +"</td><td id='"+ n.id +"'>" +
						"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
						"<input type='hidden' name='buyName' value='"+n.value+"'>" +
						"<input class='pro_price' type='text' name='productPic'></td></tr>");
				tr1 = $("<tr><td class='chi'>"+ n.value +"</td><td id='"+ n.id +"'>" +
						"<input class='pro_price' type='text' name='skuCode'></td></tr>");


				tr2 = $("<tr><td class='chi'>"+ n.value +"</td><td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td id='"+ n.id +"'>" +
						"<input class='price_id_input' type='hidden' name='priceId'><input class='price_unitPrice_input' name='unitPrice' type='text'  value=''></td><td><input class='price_domesticPrice_input' type='text' name='domesticPrice'></td><td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
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
					"<input class='pro_price' type='text'></td></tr></tbody>");

			tr2 = $("<tbody><tr><td class='yan' id='"+ n.id +"'>"+ n.value +"</td><td class='chi' id=''></td><td></td><td>" +
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
	if(yanselen > 0 && chimlen >0 && chimlen2 ==0){
		var saleAttrName1 = $("#saleAttrNm0").val();		
		$(".cm1 span").text(saleAttrName1);
		$.each(yanse,function(i,n){
			var tbody = $("<tbody></tbody>");
			var tbody1 = $("<tbody></tbody>");
			var tbody2 = $("<tbody></tbody>");

			var tr = $("");
			var tr1 = $("");
			$.each(chim,function(j,m){
				if(j == 0){
					tr = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen +"'>"+ n.value +"</td><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input type='hidden' name='buyVal' value='"+n.alt+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.alt+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input class='pro_price' type='text' name='productPic'></td></tr>");
					tr1 = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen +"'>"+ n.value +"</td><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input class='pro_price' type='text' name='skuCode'></td></tr>")


					tr2 = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen +"'>"+ n.value +"</td><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td>" +
							"<input class='price_id_input' type='hidden' name='priceId'><input class='price_domesticPrice_input' type='text' name='domesticPrice'></td><td><input class='price_unitPrice_input' name='unitPrice' type='text'  value=''></td><td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' name='hqj' readonly='readonly'></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed'></td></tr>")

				}else{
					tr = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input type='hidden' name='buyVal' value='"+n.id+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.id+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input class='pro_price' type='text' name='productPic'></td></tr>");
					tr1 = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td>" +
							"<input class='pro_price' type='text' name='skuCode'></td></tr>");


					tr2 = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td><td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td>" +
							"<input class='price_id_input' type='hidden' name='priceId'><input class='price_domesticPrice_input' type='text' name='domesticPrice'></td><td><input class='price_unitPrice_input' name='unitPrice' type='text'  value=''></td><td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' name='hqj' readonly='readonly' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed' value=''></td></tr>");


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
	if(yanselen > 0 && chimlen >0 && chimlen2 >0 && chimlen3 ==0){
		$(".cm2").show();
		var saleAttrName1 = $("#saleAttrNm0").val();
		var saleAttrName2 = $("#saleAttrNm1").val();		
		$(".cm1 span").text(saleAttrName1);
		$(".cm2 span").text(saleAttrName2);
		$.each(yanse,function(i,n){
			var tbody = $("<tbody></tbody>");
			var tbody1 = $("<tbody></tbody>");
			var tbody2 = $("<tbody></tbody>");

			var tr = $("");
			var tr1 = $("");
			$.each(chim,function(j,m){
				$.each(chim2,function(k,l){
				if(j == 0 && k == 0){
					tr = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen*chimlen2 +"'>"+ n.value +"</td>" +
							"<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
							"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
							"<td><input type='hidden' name='buyVal' value='"+n.alt+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.alt+"'>" +
							"<input type='hidden' name='saleVal2' value='"+l.alt+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input type='hidden' name='saleName2' value='"+l.value+"'>" +
							"<input class='pro_price' type='text' name='productPic'></td></tr>");
					tr1 = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen*chimlen2 +"'>"+ n.value +"</td>" +
							"<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
							"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
							"<td><input class='pro_price' type='text' name='skuCode'></td></tr>");


					tr2 = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen*chimlen2 +"'>"+ n.value +"</td>" +
							"<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
							"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
							"<td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td>" +
							"<input class='price_id_input' type='hidden' name='priceId'>" +
							"<input class='price_domesticPrice_input' type='text' name='domesticPrice'></td>" +
							"<td><input class='price_unitPrice_input' name='unitPrice' type='text'  value=''></td>" +
							"<td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' name='hqj' readonly='readonly' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed' value=''></td></tr>");

				}else{
					tr = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
							"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
							"<td><input type='hidden' name='buyVal' value='"+n.alt+"'>" +
							"<input type='hidden' name='saleVal' value='"+m.alt+"'>" +
							"<input type='hidden' name='saleVal2' value='"+l.alt+"'>" +
							"<input type='hidden' name='buyName' value='"+n.value+"'>" +
							"<input type='hidden' name='saleName' value='"+m.value+"'>" +
							"<input type='hidden' name='saleName2' value='"+l.value+"'>" +
							"<input class='pro_price' type='text' name='productPic'></td></tr>");
					tr1 = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
							"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
							"<td><input class='pro_price' type='text' name='skuCode'></td></tr>");


					tr2 = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
							"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
							"<td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td>" +
							"<td><input class='price_id_input' type='hidden' name='priceId'>" +
							"<input class='price_domesticPrice_input' type='text' name='domesticPrice'></td>" +
							"<td><input class='price_unitPrice_input' name='unitPrice' type='text'  value=''></td>" +
							"<td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' name='hqj' readonly='readonly' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed' value=''></td></tr>");


					}
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
	if(yanselen > 0 && chimlen >0 && chimlen2 >0 && chimlen3 >0 && chimlen4==0){
		$(".cm2").show();
		$(".cm3").show();
		var saleAttrName1 = $("#saleAttrNm0").val();
		var saleAttrName2 = $("#saleAttrNm1").val();	
		var saleAttrName3 = $("#saleAttrNm2").val();		
		$(".cm1 span").text(saleAttrName1);
		$(".cm2 span").text(saleAttrName2);
		$(".cm3 span").text(saleAttrName3);
		$.each(yanse,function(i,n){
			var tbody = $("<tbody></tbody>");
			var tbody1 = $("<tbody></tbody>");
			var tbody2 = $("<tbody></tbody>");

			var tr = $("");
			var tr1 = $("");
			$.each(chim,function(j,m){
				$.each(chim2,function(k,l){
					$.each(chim3,function(q,s){
						if(j == 0 && k == 0 && q == 0){
							tr = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen*chimlen2*chimlen3 +"'>"+ n.value +"</td>" +
									"<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td><input type='hidden' name='buyVal' value='"+n.alt+"'>" +
									"<input type='hidden' name='saleVal' value='"+m.alt+"'>" +
									"<input type='hidden' name='saleVal2' value='"+l.alt+"'>" +
									"<input type='hidden' name='saleVal3' value='"+s.alt+"'>" +
									"<input type='hidden' name='buyName' value='"+n.value+"'>" +
									"<input type='hidden' name='saleName' value='"+m.value+"'>" +
									"<input type='hidden' name='saleName2' value='"+l.value+"'>" +
									"<input type='hidden' name='saleName3' value='"+s.value+"'>" +
									"<input class='pro_price' type='text' name='productPic'></td></tr>");
							tr1 = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen*chimlen2*chimlen3 +"'>"+ n.value +"</td>" +
									"<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td><input class='pro_price' type='text' name='skuCode'></td></tr>");
		
		
							tr2 = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen*chimlen2*chimlen3 +"'>"+ n.value +"</td>" +
									"<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td>" +
									"<input class='price_id_input' type='hidden' name='priceId'>" +
									"<input class='price_domesticPrice_input' type='text' name='domesticPrice'></td>" +
									"<td><input class='price_unitPrice_input' name='unitPrice' type='text'  value=''></td>" +
									"<td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' name='hqj' readonly='readonly' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed' value=''></td></tr>");
		
						}else{
							tr = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td><input type='hidden' name='buyVal' value='"+n.alt+"'>" +
									"<input type='hidden' name='saleVal' value='"+m.alt+"'>" +
									"<input type='hidden' name='saleVal2' value='"+l.alt+"'>" +
									"<input type='hidden' name='saleVal3' value='"+s.alt+"'>" +
									"<input type='hidden' name='buyName' value='"+n.value+"'>" +
									"<input type='hidden' name='saleName' value='"+m.value+"'>" +
									"<input type='hidden' name='saleName2' value='"+l.value+"'>" +
									"<input type='hidden' name='saleName3' value='"+s.value+"'>" +
									"<input class='pro_price' type='text' name='productPic'></td></tr>");
							tr1 = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td><input class='pro_price' type='text' name='skuCode'></td></tr>");
		
		
							tr2 = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td>" +
									"<td><input class='price_id_input' type='hidden' name='priceId'>" +
									"<input class='price_domesticPrice_input' type='text' name='domesticPrice'></td>" +
									"<td><input class='price_unitPrice_input' name='unitPrice' type='text'  value=''></td>" +
									"<td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' name='hqj' readonly='readonly' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed' value=''></td></tr>");
		
		
						}
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
	if(yanselen > 0 && chimlen >0 && chimlen2 >0 && chimlen3 >0 && chimlen4 >0){
		$(".cm2").show();
		$(".cm3").show();
		$(".cm4").show();
		var saleAttrName1 = $("#saleAttrNm0").val();
		var saleAttrName2 = $("#saleAttrNm1").val();	
		var saleAttrName3 = $("#saleAttrNm2").val();	
		var saleAttrName4 = $("#saleAttrNm3").val();		
		$(".cm1 span").text(saleAttrName1);
		$(".cm2 span").text(saleAttrName2);
		$(".cm3 span").text(saleAttrName3);
		$(".cm4 span").text(saleAttrName4);
		$.each(yanse,function(i,n){
			var tbody = $("<tbody></tbody>");
			var tbody1 = $("<tbody></tbody>");
			var tbody2 = $("<tbody></tbody>");

			var tr = $("");
			var tr1 = $("");
			$.each(chim,function(j,m){
				$.each(chim2,function(k,l){
					$.each(chim3,function(q,s){
						$.each(chim4,function(r,t){
							if(j == 0 && r == 0 && q == 0 && k == 0){
							tr = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen*chimlen2*chimlen3*chimlen4 +"'>"+ n.value +"</td>" +
									"<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td class='chi3' id='"+ t.id +"'>"+ t.value +"</td>" +
									"<td><input type='hidden' name='buyVal' value='"+n.alt+"'>" +
									"<input type='hidden' name='saleVal' value='"+m.alt+"'>" +
									"<input type='hidden' name='saleVal2' value='"+l.alt+"'>" +
									"<input type='hidden' name='saleVal3' value='"+s.alt+"'>" +
									"<input type='hidden' name='saleVal4' value='"+t.alt+"'>" +
									"<input type='hidden' name='buyName' value='"+n.value+"'>" +
									"<input type='hidden' name='saleName' value='"+m.value+"'>" +
									"<input type='hidden' name='saleName2' value='"+l.value+"'>" +
									"<input type='hidden' name='saleName3' value='"+s.value+"'>" +
									"<input type='hidden' name='saleName4' value='"+t.value+"'>" +
									"<input class='pro_price' type='text' name='productPic'></td></tr>");
							tr1 = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen*chimlen2*chimlen3*chimlen4 +"'>"+ n.value +"</td>" +
									"<td class='chi1' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi2' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi3' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td class='chi' id='"+ t.id +"'>"+ t.value +"</td>" +
									"<td><input class='pro_price' type='text' name='skuCode'></td></tr>");
		
		
							tr2 = $("<tr ><td class='yan' id='"+ n.id +"' rowspan='"+ chimlen*chimlen2*chimlen3*chimlen4 +"'>"+ n.value +"</td>" +
									"<td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td class='chi3' id='"+ t.id +"'>"+ t.value +"</td>" +
									"<td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td><td>" +
									"<input class='price_id_input' type='hidden' name='priceId'>" +
									"<input class='price_domesticPrice_input' type='text' name='domesticPrice'></td>" +
									"<td><input class='price_unitPrice_input' name='unitPrice' type='text'  value=''></td>" +
									"<td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td><input class='hqj_price' type='text' name='hqj' readonly='readonly' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed' value=''></td></tr>");
		
						}else{
							tr = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td class='chi3' id='"+ t.id +"'>"+ t.value +"</td>" +
									"<td><input type='hidden' name='buyVal' value='"+n.alt+"'>" +
									"<input type='hidden' name='saleVal' value='"+m.alt+"'>" +
									"<input type='hidden' name='saleVal2' value='"+l.alt+"'>" +
									"<input type='hidden' name='saleVal3' value='"+s.alt+"'>" +
									"<input type='hidden' name='saleVal4' value='"+t.alt+"'>" +
									"<input type='hidden' name='buyName' value='"+n.value+"'>" +
									"<input type='hidden' name='saleName' value='"+m.value+"'>" +
									"<input type='hidden' name='saleName2' value='"+l.value+"'>" +
									"<input type='hidden' name='saleName3' value='"+s.value+"'>" +
									"<input type='hidden' name='saleName4' value='"+t.value+"'>" +
									"<input class='pro_price' type='text' name='productPic'></td></tr>");
							tr1 = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td class='chi3' id='"+ t.id +"'>"+ t.value +"</td>" +
									"<td><input class='pro_price' type='text' name='skuCode'></td></tr>");
		
		
							tr2 = $("<tr><td class='chi' id='"+ m.id +"'>"+ m.value +"</td>" +
									"<td class='chi1' id='"+ l.id +"'>"+ l.value +"</td>" +
									"<td class='chi2' id='"+ s.id +"'>"+ s.value +"</td>" +
									"<td class='chi3' id='"+ t.id +"'>"+ t.value +"</td>" +
									"<td style='display: none;'><input class='productCode_input' type='text' name='productCode'></td>" +
									"<td><input class='price_id_input' type='hidden' name='priceId'>" +
									"<input class='price_domesticPrice_input' type='text' name='domesticPrice'></td>" +
									"<td><input class='price_unitPrice_input' name='unitPrice' type='text'  value=''></td>" +
									"<td style='display: none;'><input class='price_bestoayPrice_input' type='text' name='bestoayPrice' value='0'></td>" +
						"<td ><input class='hqj_price' type='text' name='hqj' readonly='readonly' value=''></td><td style='display: none;'><input class='fhed_price' readonly='readonly' type='text' name='fhed' value=''></td></tr>");
		
		
							}
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
			var price = '0';
			var img = '0';
			var price_id_input = $(item1).find(".price_id_input").val();
			var price_domesticPrice_input = $(item1).find(".price_domesticPrice_input").val();
			var price_unitPrice_input = $(item1).find(".price_unitPrice_input").val();
			var price_bestoayPrice_input = $(item1).find(".price_bestoayPrice_input").val();
			var productCode_input = $(item1).find(".productCode_input").val();
			var tr = [];
			tr.push(color_id);
			tr.push(chi_id);
			tr.push(price);
			tr.push(img);
			tr.push(price_id_input);
			tr.push(price_domesticPrice_input);
			tr.push(price_unitPrice_input);
			tr.push(price_bestoayPrice_input);
			tr.push(productCode_input);
			
			g_table.push(tr);
		});
	});
	return g_table;
}

function _Itiaoimg(){
	$("#tb-tiaoxingma input.file").each(function(i,item){
		var id = item.id;
		$("#"+id).uploadify({
        	'height': 24,
            'swf': '../js/uploadify/uploadify.swf',
            'uploader': '../product/imageUp',
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
					var chi_id1 = $(item1).find(".chi").attr("id");
					var chi_id2 = $(item1).find(".chi1").attr("id");
					var chi_id3 = $(item1).find(".chi2").attr("id");
					var chi_id4 = $(item1).find(".chi3").attr("id");
					if(typeof(chi_id2)=="undefined"&&typeof(chi_id3)=="undefined"&&typeof(chi_id4)=="undefined"){
						if(chi_id1 == tableInfo[k][1][0]){
							$(item1).find(".pro_price").val(tableInfo[k][2]);
							if(tablename == "tb-tiaoxingma"){
								$(item1).find(".preview_fake").html(tableInfo[k][3]);
							}
	
							if((tablename == "skuPriceTable" || tablename == "tb-skuprice") && typeof (tableInfo[k][4]) != 'undefined'){
								// 设置商品价格
								//console.info(tableInfo[k][0]);
	
								$(item1).find(".price_id_input").val(tableInfo[k][4]);
	//							alert(tableInfo[k][5]+" "+tableInfo[k][6]+" "+tableInfo[k][7]);
								$(item1).find(".price_domesticPrice_input").val(tableInfo[k][5]);
								$(item1).find(".price_unitPrice_input").val(tableInfo[k][6]);
								
								$(item1).find(".price_bestoayPrice_input").val('0');
								$(item1).find(".productCode_input").val(tableInfo[k][8]);
								$(item1).find(".hqj_price").val(tableInfo[k][9]);
								$(item1).find(".fhed_price").val(tableInfo[k][10]);
								$(item1).find(".hqj_price").attr("readonly","readonly");
								$(item1).find(".fhed_price").attr("readonly","readonly");
							}
						}
					}
					//console.info(typeof (tableInfo[k][4]))
					if(typeof(chi_id2)!="undefined"&&typeof(chi_id3)=="undefined"&&typeof(chi_id4)=="undefined"){
						if(chi_id1 == tableInfo[k][1][0] && chi_id2 == tableInfo[k][1][1]){
							$(item1).find(".pro_price").val(tableInfo[k][2]);
							if(tablename == "tb-tiaoxingma"){
								$(item1).find(".preview_fake").html(tableInfo[k][3]);
							}
	
							if((tablename == "skuPriceTable" || tablename == "tb-skuprice") && typeof (tableInfo[k][4]) != 'undefined'){
								// 设置商品价格
								//console.info(tableInfo[k][0]);
	
								$(item1).find(".price_id_input").val(tableInfo[k][4]);
	//							alert(tableInfo[k][5]+" "+tableInfo[k][6]+" "+tableInfo[k][7]);
								$(item1).find(".price_domesticPrice_input").val(tableInfo[k][5]);
								$(item1).find(".price_unitPrice_input").val(tableInfo[k][6]);
								$(item1).find(".price_bestoayPrice_input").val('0');
								$(item1).find(".productCode_input").val(tableInfo[k][8]);
								$(item1).find(".hqj_price").val(tableInfo[k][9]);
								$(item1).find(".fhed_price").val(tableInfo[k][10]);
								$(item1).find(".hqj_price").attr("readonly","readonly");
								$(item1).find(".fhed_price").attr("readonly","readonly");
							}
						}
					}
					if(typeof(chi_id2)!="undefined"&&typeof(chi_id3)!="undefined"&&typeof(chi_id4)=="undefined"){
						if(chi_id1 == tableInfo[k][1][0] && chi_id2 == tableInfo[k][1][1] && chi_id3 == tableInfo[k][1][2]){
							$(item1).find(".pro_price").val(tableInfo[k][2]);
							if(tablename == "tb-tiaoxingma"){
								$(item1).find(".preview_fake").html(tableInfo[k][3]);
							}
	
							if((tablename == "skuPriceTable" || tablename == "tb-skuprice") && typeof (tableInfo[k][4]) != 'undefined'){
								// 设置商品价格
								//console.info(tableInfo[k][0]);
	
								$(item1).find(".price_id_input").val(tableInfo[k][4]);
	//							alert(tableInfo[k][5]+" "+tableInfo[k][6]+" "+tableInfo[k][7]);
								$(item1).find(".price_domesticPrice_input").val(tableInfo[k][5]);
								$(item1).find(".price_unitPrice_input").val(tableInfo[k][6]);
								$(item1).find(".price_bestoayPrice_input").val('0');
								$(item1).find(".productCode_input").val(tableInfo[k][8]);
								$(item1).find(".hqj_price").val(tableInfo[k][9]);
								$(item1).find(".fhed_price").val(tableInfo[k][10]);
								$(item1).find(".hqj_price").attr("readonly","readonly");
								$(item1).find(".fhed_price").attr("readonly","readonly");
							}
						}
					}
					if(typeof(chi_id2)!="undefined"&&typeof(chi_id3)!="undefined"&&typeof(chi_id4)!="undefined"){
						if(chi_id1 == tableInfo[k][1][0] && chi_id2 == tableInfo[k][1][1] && chi_id3 == tableInfo[k][1][2] && chi_id4 == tableInfo[k][1][3]){
							$(item1).find(".pro_price").val(tableInfo[k][2]);
							if(tablename == "tb-tiaoxingma"){
								$(item1).find(".preview_fake").html(tableInfo[k][3]);
							}
	
							if((tablename == "skuPriceTable" || tablename == "tb-skuprice") && typeof (tableInfo[k][4]) != 'undefined'){
								// 设置商品价格
								//console.info(tableInfo[k][0]);
	
								$(item1).find(".price_id_input").val(tableInfo[k][4]);
	//							alert(tableInfo[k][5]+" "+tableInfo[k][6]+" "+tableInfo[k][7]);
								$(item1).find(".price_domesticPrice_input").val(tableInfo[k][5]);
								$(item1).find(".price_unitPrice_input").val(tableInfo[k][6]);
								$(item1).find(".price_bestoayPrice_input").val('0');
								$(item1).find(".productCode_input").val(tableInfo[k][8]);
								$(item1).find(".hqj_price").val(tableInfo[k][9]);
								$(item1).find(".fhed_price").val(tableInfo[k][10]);
								$(item1).find(".hqj_price").attr("readonly","readonly");
								$(item1).find(".fhed_price").attr("readonly","readonly");
							}
						}
					}
				});
			}
		});
	});
}
function changeboxth(){
	var buyAttrName = $(".yanse1").attr("title");
	$("#zhan1").text(buyAttrName);
	$("#zhan2").text(buyAttrName);
	$("#zhan3").text(buyAttrName);
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