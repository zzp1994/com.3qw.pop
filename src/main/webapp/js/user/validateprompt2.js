if($("#language").val() == "en"){
    $.extend(validatePrompt2, {
        regName: {

            onFocus: "",
            succeed: "",
            isNull: "Please enter your login  name.",
            error: {
                beUsed: "userName",
                badLength: "login name must be 4-20 characters",
                badFormat: "login name format is not correct",
                fullNumberName: "userName"
            }
            // ,
            // onFocusExpand: function () {
            //     // $("#morePinDiv").removeClass().addClass("intelligent-error hide");
            // }
        },

        pwd: {
            onFocus: "",
            succeed: "",
            isNull: "Please enter your password.",
            error: {
                badLength: "Password  must be 6-20 characters",
                badFormat: "Password  format is not correct",
                simplePwd: "<span>The password is simple, risk of theft, you are advised to change for the complex password</span>",
                weakPwd: "<span>The password is simple, risk of theft, you are advised to change for the complex password</span>"
            }
        // ,
        // onFocusExpand: function () {
        //     $("#pwdstrength").hide();
        // }
    },
        pwdRepeat: {
            onFocus: "",
            succeed: "",
            isNull: "Pleast re-enter your password",
            error: {
                badLength: "<span>Password  must be 6-20 characters<span>",
                badFormat2: "Passwords must be consistent",
                badFormat1: "<span>The password can only consist of English, Numbers and punctuation<span>"
            }
        },
        companyname: {
            onFocus: "<span>Must be same as the company name on the certificate<span>",
            succeed: "",
            isNull: "<span>Please input the registered company name<span>",
            error: {
                badFormat: "<span><span>",
                badLength: "Input must be 1-100 characters"
            }
            //error: "format is not correct"
        },
        companytype: {
            onFocus: "",
            succeed: "",
            isNull: "Please select the type of the company",
            error: {
                badFormat: "<span>badFormat<span>",
                badLength: "Input must be 1-100 characters"
            }
        },
        companyarea: {
            onFocus: "",
            succeed: "",
            isNull: "<span>Please enter the company country<span>",
            error: {
                badFormat: "<span>badFormat<span>",
                badLength: "Input must be 1-100 characters"
            }
        },
        companyaddr: {
            onFocus: "<span>Registered business address<span>",
            succeed: "",
            isNull: "<span>Please input your registered business address<span>",
            error: {
                badFormat: "<span>badFormat<span>",
                badLength: "Input must be 1-100 characters"
            }
        },
        contactname: {
            onFocus: "",
            succeed: "",
            isNull: "Please input the contact name",
            error: {
                badFormat: "<span>badFormat<span>",
                badLength: "Input must be 1-40 characters"
            }
        },
        tele: {
            onFocus: "",
            succeed: "",
            isNull: "Please input the mobile phone number",
            error: "phone number format is not correct"
        },
        contacttele: {
            onFocus: "Please input a contact telephone",
            succeed: "",
            isNull: "",
            error: "telephone format is not correct"
        },
        postalcode: {
            onFocus: "",
            succeed: "",
            isNull: "",
            error: "format is not correct"
        },
        textfield: {
            onFocus: "<span>Please upload certificate confirming incorporation of company<span>",
            succeed: "",
            isNull: "<span>Please upload certificate confirming incorporation of company<span>",
            error: {
                badFormat: "<span>badFormat<span>",
                badLength: "<span>Please upload certificate confirming incorporation of company<span>"
            }
        },
        textfield1: {
            onFocus: "Details file is limited to xls ,xlsx format",
            succeed: "",
            isNull: "",
            error: {
                badFormat: "<span>Details file is limited to xls ,xlsx format <span>",
            }
        },
        cgr: {
            onFocus: "",
            succeed: "",
            isNull: "Please input the product category",
            error: {
                badFormat: "<span>badFormat<span>",
                badLength: "Input must be 1-100 characters"
            }
        },
        brand: {
            onFocus: "<span>Can be more complete,with '/' interval between brands</span>",
            succeed: "",
            isNull: "Please input the product brand",
            error: {
                badFormat: "<span>badFormat</span>",
                badLength: "Input must be 1-100 characters"
            }
           // error: "commodity brand format is not correct"
        },
        skunum: {
            onFocus: "",
            succeed: "",
            isNull: "Please input the sku amount",
            error: {
                badFormat: "sku amount format is not correct!",
                badLength: "Input must be 1-10 characters!"
            }
        },
        mail: {
            onFocus: "",
            succeed: "",
            isNull: "Please input the commonly used E-mail",
            error: {
                beUsed: "Email",
                badFormat: "Please input a valid email address",
                badLength: "Please input a valid email address"
            }
        },
        kaptcha:{
        	onFocus: "",
            succeed: "",
            isNull: "please input the Verification code",
            error: "Verification code is wrong"
        }
    });

}else{
    $.extend(validatePrompt2, {
        companyname: {
            onFocus: "请认真填写，信息一旦注册不能修改！",
            succeed: "",
            isNull: "请输入公司名称",
            error: {
                badFormat: "<span>含有非法字符</span>",
                badLength: "公司名称长度只能在1-100位字符之内"
            }
        },
        companytype: {
            onFocus: "",
            succeed: "",
            isNull: "请选择公司性质",
            error: ""
        },
        companyarea: {
            onFocus: "",
            succeed: "",
            isNull: "请选择公司所在国家地区",
            error: ""
        },
        companyaddr: {
            onFocus: "公司注册地址",
            succeed: "",
            isNull: "请输入公司地址",
            error: {
                badFormat: "<span>含有非法字符</span>",
                badLength: "公司地址长度只能在1-100位字符以内"
            }
        },
        contactname: {
            onFocus: "请认真填写，信息一旦注册不能修改！",
            succeed: "",
            isNull: "请输入联系人姓名",
            error: {
                badFormat: "<span>含有非法字符</span>",
                badLength: "联系人姓名长度只能在40位字符以内"
            }
        },
        contacttele: {
            onFocus: "",
            succeed: "",
            isNull: "",
            error:  "请输入正确格式的电话或传真",           
        },
        postalcode: {
            onFocus:"请输入正确的邮政编码",
            succeed: "",
            isNull: "",
            error: "请输入正确的邮政编码"
        },
        textfield: {
            onFocus: "请上传能够证明企业合法性的证明文件",
            succeed: "",
            isNull: "请上传能够证明企业合法性的证明文件",
            error: {
                badFormat: "<span>证明文件格式有误<span>",
                badLength: "<span>请上传能够证明企业合法性的证明文件<span>"
            }
        },
        textfield1: {
            onFocus: "详情文件限于 doc,docx 格式",
            succeed: "",
            isNull: "请上传公司详情文件",
            error: {
                badFormat: "<span>详情文件限于 doc,docx 格式<span>",
            }
        },
        textfield2: {
            onFocus: "上传图片限于 jpg,png 格式",
            succeed: "",
            isNull: "",
            error: {
                badFormat: "<span>上传图片限于 jpg,png 格式<span>",
                badSize: "图片大小不能大于12K!"
            }
        },
        cgr: {
            onFocus: "",
            succeed: "",
            isNull: "请选择商品类别",
            error: ""
        },
        brand: {
            onFocus: "可多填，品牌之间以'/'间隔",
            succeed: "",
            isNull: "请输入商品品牌",
            error: {
                badFormat: "<span>含有非法字符</span>",
                badLength: "长度只能在100位字符以内"
            }
        },
        skunum: {
            onFocus: "",
            succeed: "",
            isNull: "请输入sku数量",
            error: {
                badFormat: "sku数量只能输入数字!",
                badLength: "您填写的数字过长，请输入10位以内的数字!"
            }
        },
        mail: {
            onFocus: "请输入常用的邮箱，用于找回密码！",
            succeed: "",
            isNull: "请输入邮箱",
            error: {
                beUsed: "该邮箱已被使用，请更换其它邮箱",
                badFormat: "请输入有效的邮箱地址!",
                badLength: "请输入有效的邮箱地址!"
            }
        },
        kaptcha:{
        	onFocus: "",
            succeed: "",
            isNull: "请输入验证码",
            error: "验证码不正确"
        },
        userTj:{
        	onFocus: "请输入邀请码",
            succeed: "",
            isNull: "请输入邀请码",
            error: "邀请码不存在，请重新输入"
        },
        sjSupplierId:{
        	onFocus: "请输入上级企业代码,如果没有不填",
            succeed: "",
            isNull: "",
            error: "上级企业代码不存在，请重新输入"
        },
        userName:{
        	onFocus: "请填写真实姓名",
            succeed: "",
            isNull: "姓名不能为空",
            error: ""
        },
        userMobile:{
        	onFocus: "即为登录名、初始密码与商家后台密码一致，请注册成功后登录修改",
            succeed: "",
            isNull: "请输入手机号码",
            /*error: "手机号格式错误，请重新输入"*/
            error:{
            	badFormat: "手机号格式错误，请重新输入",
                badExist: "手机号存在,请重新输入!"
            }
        }
    });
}







$.extend(validateFunction, {
    mail: function (option) {
        var format = validateRules.isEmail(option.value);
        var format2 = validateRules.betweenLength(option.value, 0, 50);
        if (!format) {
            validateSettings.error.run(option, option.prompts.error.badFormat);
        } else {
            if (!format2) {
                validateSettings.error.run(option, option.prompts.error.badLength);
            } else {
                // if (!emailstate || emailold != option.value) {
                //     if (emailold != option.value) {
                //         emailold = option.value;
                //         validateSettings.succeed.run(option);
                //         emailstate = true;
                //     } else {
                //         validateSettings.error.run(option, option.prompts.error.beUsed);
                //         emailstate = false;
                //     }
                // } else {
                //     if ($("#email_linker")) {
                //         $("#email_linker").text(option.value);
                //     }
                    validateSettings.succeed.run(option);
                // }
            }
        }
    },
    
    kaptcha:function (option){
    	var uid = $("#uid").val();
    	var bool = validateRules.isNull(option.value);
    	
    	if (bool) {
            validateSettings.error.run(option, option.prompts.error);
            return false;
        } else {
        	$.ajax({
   	   		     type: "POST",
   	   		     url : "../supplier/validateNum?uid="+uid, 
   	   		     dataType:'html',
   	   		     success : function(msg) {
   	   		    	 
   	   		     if(msg!=null&&msg.toLowerCase()==(option.value).toLowerCase()){
   	   		    	// validateSettings.succeed.run(option);
   	   		    	validateSettings.succeed.run(option);
   	   		    	 return true;
   	   		     }else{
   	   		    	 validateSettings.error.run(option, option.prompts.error);
   	   		    	 return false;
   	   		    	 
   	   		    	// validateSettings.error.run(option,  "<span>" + option.prompts.error.beUsed.replace("{1}", option.value) + "</span>");  
   	   		     }
   	   			},
        			
        	});         
        }
    },
    
    
    
    
    
    
    postalcode:function(option){
    	 var bool = validateRules.isPostalcode(option.value);
    	 var flag = validateRules.isNull(option.value);
    	 if (!bool && !flag) {
             validateSettings.error.run(option, option.prompts.error);
             return;
         } else {
             validateSettings.succeed.run(option);
         }
    },

    companyname: function (option) {
        var length = validateRules.betweenLength(option.value.replace(/[^\x00-\xff]/g, "**"), 1, 100);
        var format = validateRules.isCompanyname(option.value);
        if (!length) {
            validateSettings.error.run(option, option.prompts.error.badLength);
        }
        else {
            if (!format) {
                validateSettings.error.run(option, option.prompts.error.badFormat);
            } else {
                validateSettings.succeed.run(option);
            }
        }
    },
    
    
    
    
    
    
    
    
//    companyname: function (option) {
//        var bool = validateRules.isNull(option.value);
//        if (bool) {
//            validateSettings.error.run(option, option.prompts.error);
//            return;
//        } else {
//            validateSettings.succeed.run(option);
//        }
//    },

    companyaddr: function (option) {
        var length = validateRules.betweenLength(option.value.replace(/[^\x00-\xff]/g, "**"), 1, 100);
        var format = validateRules.isCompanyaddr(option.value);
        if (!length) {
            validateSettings.error.run(option, option.prompts.error.badLength);
        } else {
            if (!format) {
                validateSettings.error.run(option, option.prompts.error.badFormat);
            }
            else {
                validateSettings.succeed.run(option);
            }
        }
    },
    

    
    
//    mobile: function (option) {
//        var format = validateRules.isMobile(option.value);
//        if (!format) {
//            validateSettings.error.run(option, option.prompts.error);
//        }
//        else {
//            validateSettings.succeed.run(option);
//        }
//    },
    sku: function (option) {
    	var length = validateRules.betweenLength(option.value.replace(/[^\x00-\xff]/g, "**"), 1,10);
        var format = validateRules.fullNumberName(option.value);
        if (!length) {
            validateSettings.error.run(option, option.prompts.error.badLength);
        } else {
            if (!format) {
                validateSettings.error.run(option, option.prompts.error.badFormat);
            }
            else {
                validateSettings.succeed.run(option);
            }
        }
    },
    
/*    companytype: function (option) {
	        var type = $("input:checkbox[name='companytype']");
        if (validateFunction.checkGroup(type)) {
            validateSettings.succeed.run(option);
        } else {
            validateSettings.error.run(option, option.prompts.isNull);
        }
    },*/
    companytype: function (option) {
        var bool = (option.value == -1);
        if (bool) {
            validateSettings.isNull.run(option, "");
        }
        else {
            validateSettings.succeed.run(option);
        }
    },
    
    mercgr: function (option) {
        var bool = ($("#IndustryID") =="");
        if (bool) {
            validateSettings.isNull.run(option, "");
        }
        else {
            validateSettings.succeed.run(option);
        }
    },
    
    companyarea: function (option) {
        var bool = (option.value == -1);
        if (bool) {
            validateSettings.isNull.run(option, "");
        }
        else {
            validateSettings.succeed.run(option);
             var code = $("#"+option.value).attr('code');
          //  alert(code);
           // alert(option.code);
            $("#teleCode").val(code);
            
        }
    },
    
    fileField: function (option) {
        var bool = validateRules.isNull(option.value);
        if (bool) {
            validateSettings.error.run(option, option.prompts.error.badLength);
            return;
        } else {
        	   var filepath=option.value;
               var extStart=filepath.lastIndexOf(".");
               var ext=filepath.substring(extStart,filepath.length).toUpperCase();
             /*  if(ext!=".PNG"&&ext!=".JPG"&&ext!=".JPEG"){
              // if(ext!=".BMP"&&ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG"){
            	   validateSettings.error.run(option, option.prompts.error.badFormat);
            	   //  alert("图片限于bmp,png,gif,jpeg,jpg格式");
                validateSettings.error.run(option, option.prompts.error.badFormat);
                return ;
               } */
       	     validateSettings.succeed.run(option);
       		};
        
    },

    fileField1: function (option) {
        var bool = validateRules.isNull(option.value);
        if(!bool){
        	  var filepath=option.value;
              var extStart=filepath.lastIndexOf(".");
              var ext=filepath.substring(extStart,filepath.length).toUpperCase();
              if(ext!=".DOC"&&ext!=".DOCX"){
           	   validateSettings.error.run(option, option.prompts.error.badFormat);
           	   //  alert("图片限于bmp,png,gif,jpeg,jpg格式");
               //validateSettings.error.run(option, option.prompts.error.badFormat);
               return ;
              } 
        }
        validateSettings.succeed.run(option);
    	
    },
    fileField2: function (option) {
    	var bool = validateRules.isNull(option.value);
    	if(!bool){
    		var filepath=option.value;
            var extStart=filepath.lastIndexOf(".");
            var ext=filepath.substring(extStart,filepath.length).toUpperCase();
            if(ext!=".PNG"&&ext!=".JPG"){
         	   validateSettings.error.run(option, option.prompts.error.badFormat);
         	   return ;
            }
            var ua = window.navigator.userAgent;
            if(ua.indexOf("MSIE")>=1){
            	var obj_file = document.getElementById("fileuploade");
            }else{
            	var size = option.element[0].files[0].size;
            	if(size > 12*1024){		//图片大小不能大于12K
            		validateSettings.error.run(option, option.prompts.error.badSize);
            		return ;
            	}
            }
            
    	}
    	validateSettings.succeed.run(option);
    	
    },
    userTj:function (option) {
    	var userTjName = $("#userTj").val();
        var bool = validateRules.isNull(option.value);
        if (bool) {
            validateSettings.error.run(option, option.prompts.error);
        }
        else {
        	$.ajax({
  	   		     type:"POST",
  	   		     url:"../user/checkTJUserIsExists?tjName="+userTjName, 
  	   		     dataType:'html',
  	   		     success : function(result) {
  	   		     if(result != 0){
  	   		    	validateSettings.succeed.run(option);
  	   		    	/*var sjSupplieCode = $("#sjSupplierId").val();
	  	   		   $.ajax({
		    			type:"POST",
		    			url:"../supplier/getNameByTjUser?mobile="+userTjName, 
		    			dataType:'html',
		    			success : function(result) {
		    				if(sjSupplieCode == '' || sjSupplieCode == null){
		    					$("#sjSupplierId_info").html("你的上级为 : "+result);
    		    				$("#sjSupplierId_info").attr("display","block");
		    				}
		    			},
		    		});*/
  	   		    	 return true;
  	   		     }else{
  	   		    	 validateSettings.error.run(option, option.prompts.error);
  	   		    	 $("#userTj").val("");
  	   		    	 return false;
  	   		     }
  	   			},
        	}); 
        }
    },
    sjSupplierId:function (option) {
    	var sjSupplieCode = $("#sjSupplierId").val();
    	var bool = validateRules.isNull(option.value);
    	if (!bool) {
//    		validateSettings.error.run(option, option.prompts.error);
    		$.ajax({
    			type:"POST",
    			url:"../supplier/checkSupplierCodeIsExists?supplierCode="+sjSupplieCode, 
    			dataType:'html',
    			success : function(result) {
    				if(result == 1){
    					validateSettings.succeed.run(option);
    		    		$.ajax({
    		    			type:"POST",
    		    			url:"../supplier/getCompanyNameBySupplierCode?supplierCode="+sjSupplieCode, 
    		    			dataType:'html',
    		    			success : function(result) {
    		    				$("#sjSupplierId_info").html("你的上级为 : "+result);
    		    				$("#sjSupplierId_info").attr("display","block");
    		    			},
    		    		});
    				}else if(result == 0){
    					validateSettings.error.run(option, option.prompts.error);
    					$("#sjSupplierId").val("");
    					$("#sjSupplierId_info").html('');
	    				$("#sjSupplierId_info").attr("display","none");
    					return false;
    				}else if(result == 2){
    					validateSettings.error.run(option,"<span>该企业无企业个人账号，无法分配!</span>");
    					$("#sjSupplierId").val("");
    					$("#sjSupplierId_info").html('');
	    				$("#sjSupplierId_info").attr("display","none");
    					return false;
    				}
    			},
    		}); 
    	}else {
    		
    	}
    },
    userName:function (option) {
        var bool = validateRules.isNull(option.value);
        if (bool) {
            validateSettings.error.run(option, option.prompts.error);
        }
        else {
            validateSettings.succeed.run(option);
        }
    },
    userMobile:function (option) {
    	var userMobileVal = $("#userMobile").val().trim();
        var format = validateRules.isMobile(option.value);
        var bool = validateRules.isNull(option.value);
        if (!format && !bool) {
            validateSettings.error.run(option, option.prompts.error.badFormat);
        }
        else {
        	$.ajax({
 	   		     type:"POST",
 	   		     url:"../user/checkTJUserIsExists?tjName="+userMobileVal, 
 	   		     dataType:'html',
 	   		     success : function(result) {
	 	   		     if(result != 0){
	 	   		    	 validateSettings.error.run(option, option.prompts.error.badExist);
	 	   		    	 $("#userMobile").val("");
	 	   		    	 return false;
	 	   		     }else{
	 	   		    	 validateSettings.succeed.run(option);
	 	   		    	 return true;
	 	   		      }
 	   			},
        	}); 
        }
    },
    
    emRegCompany_validate: function () {

        $("#regName").jdValidatee(validatePrompt2.regName, validateFunction.regName, true);
        $("#pwd").jdValidatee(validatePrompt2.pwd, validateFunction.pwd, true);
        $("#pwdRepeat").jdValidatee(validatePrompt2.pwdRepeat, validateFunction.pwdRepeat, true);

        $("#companyname").jdValidatee(validatePrompt2.companyname, validateFunction.companyname, true);
       /* $("[name = companyNature]:checkbox").jdValidate(validatePrompt.companytype, validateFunction.checkGroup, true);*/
        /*$("#companytype").jdValidate(validatePrompt.companytype, validateFunction.companytype, true);
        $("#companyaddr").jdValidate(validatePrompt.companyaddr, validateFunction.companyaddr, true);
        $("#companyarea").jdValidate(validatePrompt.companyarea, validateFunction.companyarea, true);*/

     /*   $("#companyarea").jdValidate(validatePrompt.companyarea, validateFunction.checkSelectGroup, true);*/

        $("#contactname").jdValidatee(validatePrompt2.contactname, validateFunction.companyname, true);
       
        $("#mailbox").jdValidatee(validatePrompt2.mail, validateFunction.mail, true);
        /*$("#contacttele").jdValidate(validatePrompt.contacttele, validateFunction.tel, true);*/
       /* $("#postalcode").jdValidate(validatePrompt.postalcode, validateFunction.postalcode, true);
        $("#fileField").jdValidate(validatePrompt.textfield, validateFunction.fileField, true);
        $("#fileField1").jdValidate(validatePrompt.textfield1, validateFunction.fileField1, true);
        $("#fileField2").jdValidate(validatePrompt.textfield2, validateFunction.fileField2, true);*/

        /*$("#mer-cgr").jdValidate(validatePrompt.cgr, validateFunction.mercgr, true);*/
//        $("#mer-brand").jdValidate(validatePrompt.brand, validateFunction.companyname, true);
        /*$("#skunum").jdValidate(validatePrompt.skunum, validateFunction.sku, true);*/

        
        $("#kaptcha").jdValidatee(validatePrompt2.kaptcha, validateFunction.kaptcha, true);
        /*$("#userTj").jdValidate(validatePrompt.userTj, validateFunction.userTj, true);
        $("#sjSupplierId").jdValidate(validatePrompt.sjSupplierId, validateFunction.sjSupplierId, true);*/
      /*  $("#chinacompanyaddr").jdValidate(validatePrompt.companyaddr, validateFunction.companyaddr, true);
        $("#chinacontactname").jdValidate(validatePrompt.contactname, validateFunction.companyname, true);
        $("#chinacontacttele").jdValidate(validatePrompt.contacttele, validateFunction.tel, true);
        $("#chinacompanyname").jdValidate(validatePrompt.companyname, validateFunction.companyname, true);*/
        
     /*   $("#chinamail").jdValidate(validatePrompt.mail, validateFunction.mail, true);
*/
       $("#hqqPwd").jdValidatee(validatePrompt2.hqqPwd, validateFunction.hqqPwd, true);
       $("#hqqPwdRepeat").jdValidatee(validatePrompt2.hqqPwdRepeat, validateFunction.hqqPwdRepeat, true);
        /*$("#userName").jdValidate(validatePrompt.userName, validateFunction.userName, true);
        $("#userMobile").jdValidate(validatePrompt.userMobile, validateFunction.userMobile, true);*/
        return validateFunction.FORM_submit(["#regName", "#pwd", "#pwdRepeat",  "#companyname", "#contactname",  "#kaptcha","#hqqPwd","#hqqPwdRepeat"]);//,"#skunum"
        
    }
});


$("#pwd").bind("keyup", function () {
    validateFunction.pwdstrength();}).jdValidatee(validatePrompt2.pwd, validateFunction.pwd);
$("#pwdRepeat").jdValidatee(validatePrompt2.pwdRepeat, validateFunction.pwdRepeat);
$("#regName").jdValidatee(validatePrompt2.regName, validateFunction.regName);

$("#companyname").jdValidatee(validatePrompt2.companyname, validateFunction.companyname);
/*$("#companytype").jdValidate(validatePrompt.companytype, validateFunction.companytype);
$("#companyaddr").jdValidate(validatePrompt.companyaddr, validateFunction.companyaddr);
$("#companyarea").jdValidate(validatePrompt.companyarea, validateFunction.companyarea);*/

$("#contactname").jdValidatee(validatePrompt2.contactname, validateFunction.companyname);

$("#mailbox").jdValidatee(validatePrompt2.mail, validateFunction.mail);
/*$("#contacttele").jdValidate(validatePrompt.contacttele, validateFunction.tel);
$("#postalcode").jdValidate(validatePrompt.postalcode, validateFunction.postalcode);
$("#fileField").jdValidate(validatePrompt.textfield, validateFunction.fileField);
$("#fileField1").jdValidate(validatePrompt.textfield1, validateFunction.fileField1);
$("#fileField2").jdValidate(validatePrompt.textfield2, validateFunction.fileField2);

$("#mer-cgr").jdValidate(validatePrompt.cgr, validateFunction.mercgr);*/
//$("#mer-brand").jdValidate(validatePrompt.brand, validateFunction.companyname);
//$("#skunum").jdValidate(validatePrompt.skunum, validateFunction.sku);


$("#kaptcha").jdValidatee(validatePrompt2.kaptcha, validateFunction.kaptcha);
/*$("#userTj").jdValidate(validatePrompt.userTj, validateFunction.userTj);
$("#sjSupplierId").jdValidate(validatePrompt.sjSupplierId, validateFunction.sjSupplierId);*/
/*$("#chinacompanyaddr").jdValidate(validatePrompt.companyaddr, validateFunction.companyaddr);
$("#chinacontactname").jdValidate(validatePrompt.contactname, validateFunction.companyname);
$("#chinacontacttele").jdValidate(validatePrompt.contacttele, validateFunction.tel);
$("#chinacompanyname").jdValidate(validatePrompt.companyname, validateFunction.companyname);
*/
/*$("#chinamail").jdValidate(validatePrompt.mail, validateFunction.mail);
*/
/*$("#userName").jdValidate(validatePrompt.userName, validateFunction.userName);
$("#userMobile").jdValidate(validatePrompt.userMobile, validateFunction.userMobile);*/

$("#hqqPwd").bind("keyup", function () {
    validateFunction.pwdstrength();}).jdValidatee(validatePrompt2.hqqPwd, validateFunction.hqqPwd);
$("#hqqPwdRepeat").jdValidatee(validatePrompt2.hqqPwdRepeat, validateFunction.hqqPwdRepeat);

$("#viewpwd").bind("click", function () {
    if ($(this).attr("checked") == true) {
        validateFunction.showPassword("text");
        $("#o-password").addClass("pwdbg");
    } else {
        validateFunction.showPassword("password");
        $("#o-password").removeClass("pwdbg");
    }
});

//公司所在地
// $("select[@name2='hncompanyarea']").bind("change", function () {
//     var elements = $("select[@name2='hncompanyarea']");
//     if (validateFunction.checkSelectGroup(elements)) {
//         $("#hncompanyarea").val("1");
//         $("#hncompanyarea").attr("sta", 2);
//         $("#hncompanyarea_error").html("");
//         $("#hncompanyarea_error").removeClass();
//         $("#hncompanyarea_succeed").addClass("succeed");
//     } else {
//         $("#hncompanyarea").val("-1");
//         $("#hncompanyarea").attr("sta", 0);
//         $("#hncompanyarea_error").html("");
//         $("#hncompanyarea_succeed").removeClass("succeed");
//     }
// });

//公司类型
/*$("input:checkbox[name='companytype']").bind("click", function () {
    var value1 = $.trim($("#companytype").val());
    var value2 = $(this).val();
    if ($(this).attr("checked") == "checked") {
        if (value1.indexOf(value2) == -1) {
            $("#companytype").val(value1 +" "+ value2);
            $("#companytype").attr("sta", 2);
            $("#companytype_error").html("");
            $("#companytype_error").removeClass();
            $("#companytype_succeed").addClass("succeed");
        }
    } else {
        if (value1.indexOf(value2) != -1) {
            value1 = $.trim(value1.replace(value2, ""));
            $("#companytype").val(value1);
            if ($("#companytype").val() == "") {
                $("#companytype").attr("sta", 0);
                $("#companytype_succeed").removeClass("succeed");
            }
        }
    }
});*/

function protocolReg() {
    $("#closeBox").click();
    $("#registsubmit").click();
}
$("#registsubmit").click(function () {
    // var agreeProtocol = checkReadMe();
    // var regnameOk = validateRegName();
	
    var flag = validateFunction.emRegCompany_validate();
	 
	var object = $("#company_error").attr("style");
//	var oop = object.display;
	if(object == ""){
		flag = false;
	}
	var agreement = $("#agreement").attr("checked");
	if(!agreement) {
		$("#agreementError").text("请同意用户注册协议").show();
		return;
	} else {
		$("#agreementError").hide();
	}
//	flag = false;
    if (flag) {
    	$("#formcompany").submit();
        // $("#registsubmit").attr({
        //     "disabled": "disabled"
        //     // }).removeClass().addClass("btn-img btn-regist wait-btn");
        // }).removeClass().addClass("btn-img btn-regist wait-btn");
       /* $.ajax({
            type: "POST",
            url: "regist",
            contentType: "multipart/form-data; charset=utf-8",
            data: $("#formcompany").serialize(),
            success: function (result) {
                if (result) {
                    var obj = eval(result);
                    if (obj.info) {
                        $("#registsubmit").removeAttr("disabled").removeClass().addClass("btn-img btn-regist");
                        alert(obj.info);
                        verc();
                    }
                    if (obj.success == true) {
                        window.location = obj.dispatchUrl;
                    }
                }
            }
        });*/
    	
    }
})
$(

function () {
    refreshAreas(1, 0);

    function refreshAreas(level, parentId) {
        var myname;
        if (level == 1) {
            myname = "companycity";
            if (parentId == -1) {
                $("#companycity").empty();
                $("#companycity").append("<option value=\"-1\" selected>请选择</option>");
                $("#companycity").css({
                    "width": "auto"
                });
                $("#companyarea").empty();
                $("#companyarea").append("<option value=\"-1\" selected>请选择</option>");
                $("#companyarea").css({
                    "width": "auto"
                });
            }
        } else {
            myname = "companyarea";
            if (parentId == -1) {
                $("#companyarea").empty();
                $("#companyarea").append("<option value=\"-1\" selected>请选择</option>");
                $("#companyarea").css({
                    "width": "auto"
                });
            }
        }
        if (parentId > 0) {
            $.getJSON(
                "../reg/area?level=" + level + "&parentId=" + parentId + "&r=" + Math.random(),

            function (result) {
                if (result.Areas != null) {
                    $("#" + myname).empty();
                    $("#" + myname).append("<option value=\"-1\"  selected>请选择</option>");
                    for (var i = 0; i < result.Areas.length; i++) {
                        var area = result.Areas[i];
                        $("#" + myname).append("<option  value=\"" + area.Id + "\">" + area.Name + "</option>");
                    }
                    $("#" + myname).css({
                        "width": "Auto"
                    });
                }
            });
        }
    }

    $("#companyprovince").change(

    function () {
        $("#hncompanyarea_error").removeClass();
        refreshAreas(1, parseInt($(this).val()));
        $("#companyarea").empty();
        $("#companyarea").append("<option value=\"-1\" selected>请选择</option>");
    })

    $("#companycity").change(

    function () {
        $("#hncompanyarea_error").removeClass();
        refreshAreas(2, parseInt($(this).val()));
    });
})

function checkReadMe() {
    if ($("#readme").attr("checked") == true) {
        $("#protocol_error").removeClass().addClass("error hide");
        return true;
    } else {
        $("#protocol_error").removeClass().addClass("error");
        return false;
    }
}

function agreeonProtocol() {
    if ($("#readme").attr("checked") == true) {
        $("#protocol_error").removeClass().addClass("error hide");
        return true;
    }
}