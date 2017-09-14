

/*
 *	Create the file
 *	This javascript contains all the validation 
 *	Author: Troy Young
 *	Date: 2012-6-6 17:46:52
 *	Version: 1.0
 */
 
 
 
/*
 *	Modify the file
 * 	Change the function to use the name to find the json data, and change the function that when click the submit, show the error message
 *  Modify Author: Troy Young
 *  Date: 2012-6-7 14:52:23
 *  Version: 1.1
 */
 
 
/*
 *	Define the error count so we can prevent the error input submit to the server
 *
 *	Please make sure that your DOM structure like the follow style:
 *  <div class="*"><input onblur="validateSingle(this, 1)"/></div>
 *	<div class="*"></div>
 *
 *	And the thief warning you can set the div where you want like this:
 *	<div id="thief_warning"></div>
 *
 *	Finally If you want to show the thief warning message
 *
 */

// define the error count so that we can use it to judge if all the input field is validate
var errorCount = 0;
 
/*
 *	You can define the validate rules here. 
 *	Just remember the name, you will use in the page when invoke the function
 *
 */
var validateConfig = [
	{
		name: "notnull",
		reg: "^.{1,}$",
		message: "不能为空!"
	},
	{
		name: "name",
		/*reg: "[a-zA-Z0-9_\\-\\.]{6}",*/
		reg: "^[\u4E00-\u9FA5A-Za-z0-9_]{1,28}$",
		message: "信息不能小于1个或大于28个字符且不能包含特殊字符!"
	},
	{
		name: "username",
		/*reg: "[a-zA-Z0-9_\\-\\.]{6}",*/
		reg: "[\u4E00-\u9FA5A-Za-z0-9_]{4,28}",
		message: "输入信息不能小于4个字符且不能大于28个字符!"
	},
	{
		name: "password",
		reg: "[a-zA-Z0-9_\\-\\.]{6}",
		message: "密码不能为空且大于6位!"
	},
	{
		name: "repassword",
		reg: null,
		message: "密码必须一致!"
	},
	{
		name: "email",
		reg: "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$",
		message: "邮箱格式不正确!"
	},
	{
		name: "birthday",
		reg: "[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}",
		message: "日期格式不正确!"
	},
		{
		name: "telphone",
		reg: "^[+0-9\-()（）]{7,18}$",
		message: "电话格式不正确!"
	},
	{
		name: "phone",
		reg: "^[+0-9\-()（）]{7,18}$",
		message: "手机格式不正确!"
	},
	{
		name: "IdNumber",
		reg: "^[0-9]{15}|[0-9]{18}$",
		message: "身份证号不合法!"
	},
	{
		name: "number",
		reg: "^[0-9]+$",
		message: "请输入正确数字!"
	},{
		name: "post",
		reg: "^\\d{1,18}$",
		message: "请输入正确邮编!"
		
	},
	{
		name: "long",
		reg: "^.{0,32}$",
		message: "输入不能大于32个字符!"
	},
	{
		name: "biglong",
		reg: "^.{0,100}$",
		message: "输入不能大于100个字符!"
	}
];

var errorStyle = [
	{
		name: "error",
		styleName: "border",
		style: "1px solid #F00"
	},
	{
		name: "right",
		styleName: "border",
		style: "1px solid #CCC"
	}
];
 
/*
 *	This function must provide:
 *  1.validate input box
 *  2.config ID you defined before
 */

function validateSingle(obj, validateName,countWrong){
	// find the configId through the name
	var configId = 0;
	for(var i = 0; i < validateConfig.length; i += 1){
		if(validateName == validateConfig[i].name){
			configId = i;
		}
	}
	
	// This can find the warning field
	var warning = $(obj).next();
	
	if(validateConfig[configId].reg != null){
		var borderStyle = errorStyle[0];
		
		if($(obj).val().match(validateConfig[configId].reg)){
			warning.html("");
			if(errorCount > 0){
				errorCount =errorCount- 1;
			}
			borderStyle = errorStyle[1];
		} else {
			warning.html(validateConfig[configId].message).css("color", "red");
			errorCount = errorCount +1;
			countWrong=countWrong+ 1;
		}
		$(obj).css(borderStyle.styleName, borderStyle.style);
		return countWrong;
	} else {
		var borderStyle = errorStyle[0];
		if($(obj).val() == null || $(obj).val() == ""){
			warning.html(validateConfig[configId].message).css("color", "red");
			
			errorCount = errorCount +1;
		} else {
			warning.html("");
			if(errorCount > 0){
				errorCount =errorCount- 1;
			}
			borderStyle = errorStyle[1];
		}
		$(obj).css(borderStyle.styleName, borderStyle.style);
	}
}
/*
 *	This function must provide:
 *  1.validate input box
 *  2.config ID you defined before
 */
function validateOne(obj, validateName,countWrong){
	// find the configId through the name
	var configId = 0;
	for(var i = 0; i < validateConfig.length; i += 1){
		if(validateName == validateConfig[i].name){
			configId = i;
		}
	}
	
	// This can find the warning field
	var warning = $(obj).next();
	
	if(validateConfig[configId].reg != null){
		var borderStyle = errorStyle[0];
		
		if($(obj).val().match(validateConfig[configId].reg)){
			warning.html("");
			borderStyle = errorStyle[1];
		} else {
			warning.html(validateConfig[configId].message).css("color", "red");
			countWrong = countWrong+1;
		}
		$(obj).css(borderStyle.styleName, borderStyle.style);
		
	} else {
		var borderStyle = errorStyle[0];
		if($(obj).val() == null || $(obj).val() == ""){
			warning.html(validateConfig[configId].message).css("color", "red");
			countWrong= countWrong+1;
		} else {
			warning.html("");
			
			borderStyle = errorStyle[1];
		}
		$(obj).css(borderStyle.styleName, borderStyle.style);
	}
	
	return countWrong;
}


/*
 *	many validate
 *
 *  Dear user you can change the thief warning style and message
 *
 */
function validate(obj, validateNames){
	var countWrong=0;
	if(validateNames.length>0){
		 var arr= new Array();   
		 arr=validateNames.split(",");
		 for (var i=0;i<arr.length;i++){
			 if(countWrong>0){
				 break;
			 }
			 countWrong= validateOne(obj,arr[i],countWrong);
		 }
			 
		}
}
/*
 *	Submit validate
 *
 *  Dear user you can change the thief warning style and message
 *
 */
function formSubmit(){
	// find all the input field
	// if the field's value is null give a thief warning and set the errorCount's value isn't 0
	var countWrong=0;
	 $("input:[onblur]").each(function(){
		if($.trim($(this).val()) == "" || $(this).val() == null){
			countWrong=+ 1;
			var warning = $(this).next();
			var borderStyle = errorStyle[0];
			$(this).css(borderStyle.styleName, borderStyle.style);
			warning.html("不能为空!").css("color", "red");
		}
		else{
			var onblur = $(this).attr("onblur").toString();
		//alert($(this).attr("onblur") +"=ks="+onblur.indexOf("'")+"=js="+onblur.lastIndexOf("'"));
			//	alert(onblur+"--onblur="+ onblur.substring(onblur.IndexOf("'"), onblur.lastIndexOf("'")));
			//var errorType= new Array()
			var errorType = onblur.substring(onblur.indexOf("'")+1, onblur.lastIndexOf("'")).split(",");
			 for (var i=0;i<errorType.length;i++){
				 if(countWrong>0){
					 break;
				 }
				 countWrong= validateOne(this,errorType[i],countWrong);
			 }
		}
	});
	if(countWrong > 0){
		//$("#thief_warning").css("color", "red").html("You must finish all the field...");
		return false;
	} else {
		return true;
	}
}

// Validate the password and the repassword
// that means find the previous input
function validateRePassword(obj, validateName){
	// find the configId through the name
	var configId = 0;
	for(var i = 0; i < validateConfig.length; i += 1){
		if(validateName == validateConfig[i].name){
			configId = i;
		}
	}
	
	// This can find the warning field
	var warning = $(obj).parent().next();
	// This can find the password
	var password = $("input:password")[0].value;
	
	var borderStyle = errorStyle[0];
	if($(obj).val() == password){
		warning.html("");
		if(errorCount > 0){
			errorCount =errorCount- 1;
		}
		borderStyle = errorStyle[1];
	} else {
		warning.html(validateConfig[configId].message).css("color", "red");
		errorCount =errorCount+ 1;
	}
	$(obj).css(borderStyle.styleName, borderStyle.style);
}
