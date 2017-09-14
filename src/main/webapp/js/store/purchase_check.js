	//初步加载此项目这个页面时
	$(document).ready(function(){
		$(".ov").delegate('input[name="skuPriceTax"]','blur',onBlur);
		$(".ov").delegate('input[name="qty"]','blur',onBlurQty);
		$("#paymentDays").live("blur",onBlurPaymentDays);
		$("#exchangeRate").live("blur",onBlurExchangeRate);
		
	});
	var validateRegExp = {
// price:"^[0-9]{1,9}|[0-9]+(/.[0-9]{0,7})$",
		    price:"^([1-9]+)|([1-9]+(.[1-9]{0,4}))$",
		    iZero:"^([0-9]+)|([0-9]+(.[0-9]{0,4}))$",
		    qty:"^([1-9]+)|[1-9][0-9]{1,9}$",
		    paymentDays:"^[1-9]{1,5}\\d*$",
		    exchangeRate:"^([0-9]+)|([0-9]+(.[0-9]{0,4}))$",
	};
	// 验证规则
	var validateRules = {
	   betweenLength: function (str, _min, _max) {
	        return (str.length >= _min && str.length <= _max);
	    },
	    isNull: function (str) {
	        return (str == "" || typeof str != "string");
	    },
	    isPrice:function(str){
	        return new RegExp(validateRegExp.price).test(str);
	    },
	    
	    isIzero:function(str){
	        return new RegExp(validateRegExp.iZero).test(str);
	    },
	    
	    isQty:function(str){
	        return new RegExp(validateRegExp.qty).test(str);
	    },
	    isPaymentDays:function(str){
	        return new RegExp(validateRegExp.paymentDays).test(str);
	    },
	    
	    isExchangeRate:function(str){
	        return new RegExp(validateRegExp.exchangeRate).test(str);
	    }
	};

	function clickBox(){
		var aCheck=$(':checkbox[name=isGive]');
		for(var i=0;i<aCheck.length;i++){
			aCheck[i].onclick=function(){
				if(this.checked==false){
					var oInp=this.parentNode.parentNode.children[9].children[0];
					oInp.value='';
				}
			};
		}
	}
	
	
function onBlur(){
	var flag = true;
	var that = $(this);
	// 单价(含税)$("#skuPriceTax")
	var skuPriceTax = that.val();
	var isNull = validateRules.isNull(skuPriceTax);
	var format = validateRules.isPrice(skuPriceTax);
	
	var iZero = validateRules.isPrice(skuPriceTax);
	var info = validateRules.isIzero(iZero);
	
	var st= that.parent().prev().find("input[name='isGive']").is(':checked');
	
	if(isNull){
		alert("请填写正确的金额数字!");
		flag = false;
		return flag;
	}else if(!st && !format){
		alert("请填写正确的金额数字!");
		that.val("");
		flag = false;
		return flag;
	}else if(st && info){
		//alert("请填写正确的金额数字!");
		//that.val("");
		flag = true;
		return flag;
	}else{
		if(isNaN(skuPriceTax)){
			alert("请填写正确的金额数字!");
			that.val("");
			}else{
				that.val(Number(skuPriceTax).toFixed(8));
				flag = true;
				return flag;
			} 
	}
	
}


function onBlurQty(){
	var that = $(this);
	var qty = that.val();
	var isNull = validateRules.isNull(qty);
	var format = validateRules.isQty(qty);
	if(isNull){
		alert("请填写数量!");
		return;
	}else if(!format){
		alert("请填写最大10位正整数!");
		that.val("");
		return;
	}
}

function onBlurPaymentDays(){
	var that = $(this);
	var paymentDays= that.val();
	var isNull = validateRules.isNull(paymentDays);
	var format = validateRules.isPaymentDays(paymentDays);
	if(isNull){
// alert("请填写数量!");
		return;
	}else if(!format){
		alert("请填写正整数!");
		that.val("");
		return;
	}else{
		var length = that.val().length;
		if(length>5){
			alert("天数长度不能超过五位");
			that.val("");
			return;
		}
	}
}
function onBlurExchangeRate(){
	
	var that = $(this);
	var exchangeRate= that.val();
	var isNull = validateRules.isNull(exchangeRate);
	var format = validateRules.isExchangeRate(exchangeRate);
	if(isNull){
		alert("请填写汇率!");
		return;
	}else if(!format){
		alert("请输入正确的汇率,最长四位小数!");
		that.val("");
		return;
	}
}
