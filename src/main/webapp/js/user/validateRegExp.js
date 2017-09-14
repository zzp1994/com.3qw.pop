function pwdLevel(value) {
    var pattern_1 = /^.*([\W_])+.*$/i;
    var pattern_2 = /^.*([a-zA-Z])+.*$/i;
    var pattern_3 = /^.*([0-9])+.*$/i;
    var level = 0;
    if (value.length > 10) {
        level++;
    }
    if (pattern_1.test(value)) {
        level++;
    }
    if (pattern_2.test(value)) {
        level++;
    }
    if (pattern_3.test(value)) {
        level++;
    }
    if (level > 3) {
        level = 3;
    }
    return level;
}

var weakPwdArray = ["123456", "123456789", "111111", "5201314", "12345678", "123123", "password", "1314520", "123321", "7758521", "1234567", "5211314", "666666", "520520", "woaini", "520131", "11111111", "888888", "hotmail.com", "112233", "123654", "654321", "1234567890", "a123456", "88888888", "163.com", "000000", "yahoo.com.cn", "sohu.com", "yahoo.cn", "111222tianya", "163.COM", "tom.com", "139.com", "wangyut2", "pp.com", "yahoo.com", "147258369", "123123123", "147258", "987654321", "100200", "zxcvbnm", "123456a", "521521", "7758258", "111222", "110110", "1314521", "11111111", "12345678", "a321654", "111111", "123123", "5201314", "00000000", "q123456", "123123123", "aaaaaa", "a123456789", "qq123456", "11112222", "woaini1314", "a123123", "a111111", "123321", "a5201314", "z123456", "liuchang", "a000000", "1314520", "asd123", "88888888", "1234567890", "7758521", "1234567", "woaini520", "147258369", "123456789a", "woaini123", "q1q1q1q1", "a12345678", "qwe123", "123456q", "121212", "asdasd", "999999", "1111111", "123698745", "137900", "159357", "iloveyou", "222222", "31415926", "123456", "111111", "123456789", "123123", "9958123", "woaini521", "5201314", "18n28n24a5", "abc123", "password", "123qwe", "123456789", "12345678", "11111111", "dearbook", "00000000", "123123123", "1234567890", "88888888", "111111111", "147258369", "987654321", "aaaaaaaa", "1111111111", "66666666", "a123456789", "11223344", "1qaz2wsx", "xiazhili", "789456123", "password", "87654321", "qqqqqqqq", "000000000", "qwertyuiop", "qq123456", "iloveyou", "31415926", "12344321", "0000000000", "asdfghjkl", "1q2w3e4r", "123456abc", "0123456789", "123654789", "12121212", "qazwsxedc", "abcd1234", "12341234", "110110110", "asdasdasd", "123456", "22222222", "123321123", "abc123456", "a12345678", "123456123", "a1234567", "1234qwer", "qwertyui", "123456789a", "qq.com", "369369", "163.com", "ohwe1zvq", "xiekai1121", "19860210", "1984130", "81251310", "502058", "162534", "690929", "601445", "1814325", "as1230", "zz123456", "280213676", "198773", "4861111", "328658", "19890608", "198428", "880126", "6516415", "111213", "195561", "780525", "6586123", "caonima99", "168816", "123654987", "qq776491", "hahabaobao", "198541", "540707", "leqing123", "5403693", "123456", "123456789", "111111", "5201314", "123123", "12345678", "1314520", "123321", "7758521", "1234567", "5211314", "520520", "woaini", "520131", "666666", "RAND#a#8", "hotmail.com", "112233", "123654", "888888", "654321", "1234567890", "a123456"];

function verc() {
    $("#JD_Verification1").click();
}

var validateRegExp = {
    decmal: "^([+-]?)\\d*\\.\\d+$", //浮点数
    decmal1: "^[1-9]\\d*.\\d*|0.\\d*[1-9]\\d*$", //正浮点数
    decmal2: "^-([1-9]\\d*.\\d*|0.\\d*[1-9]\\d*)$", //负浮点数
    decmal3: "^-?([1-9]\\d*.\\d*|0.\\d*[1-9]\\d*|0?.0+|0)$", //浮点数
    decmal4: "^[1-9]\\d*.\\d*|0.\\d*[1-9]\\d*|0?.0+|0$", //非负浮点数（正浮点数 + 0）
    decmal5: "^(-([1-9]\\d*.\\d*|0.\\d*[1-9]\\d*))|0?.0+|0$", //非正浮点数（负浮点数 + 0）
    intege: "^-?[1-9]\\d*$", //整数
    intege1: "^[1-9]\\d*$", //正整数
    intege2: "^-[1-9]\\d*$", //负整数
    num: "^([+-]?)\\d*\\.?\\d+$", //数字
    num1: "^[1-9]\\d*|0$", //正数（正整数 + 0）
    num2: "^-[1-9]\\d*|0$", //负数（负整数 + 0）
    ascii: "^[\\x00-\\xFF]+$", //仅ACSII字符
    chinese: "^[\\u4e00-\\u9fa5]+$", //仅中文
    color: "^[a-fA-F0-9]{6}$", //颜色
    date: "^\\d{4}(\\-|\\/|\.)\\d{1,2}\\1\\d{1,2}$", //日期
    email: "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$", //邮件
    idcard: "^[1-9]([0-9]{14}|[0-9]{17})$", //身份证
    ip4: "^(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)$", //ip地址
    letter: "^[A-Za-z]+$", //字母
    letter_l: "^[a-z]+$", //小写字母
    letter_u: "^[A-Z]+$", //大写字母
    mobile: "^0?(13|15|17|18|14)[0-9]{9}$", //手机
    notempty: "^\\S+$", //非空
    password: "^.*[A-Za-z0-9\\w_-]+.*$", //密码
    fullNumber: "^[0-9]+$", //数字
    picture: "(.*)\\.(jpg|bmp|gif|ico|pcx|jpeg|tif|png|raw|tga)$", //图片
    qq: "^[1-9]*[1-9][0-9]*$", //QQ号码
    rar: "(.*)\\.(rar|zip|7zip|tgz)$", //压缩文件
    //tel: "^[0-9\-()（）]{7,18}$", //电话号码的函数(包括验证国内区号,国际区号,分机号)
    tel: "^[0-9\\+()\\-]{4,20}$", //电话号码的函数(包括验证国内区号,国际区号,分机号) \(?0\d{2}[) -]?\d{8}
    url: "^http[s]?:\\/\\/([\\w-]+\\.)+[\\w-]+([\\w-./?%&=]*)?$", //url
    username: "^.{1,100}$", //户名
    deptname: "^.{1,100}$", //单位名
    zipcode: "^\\d{1,10}$", //邮编
    realname: "^[A-Za-z\\s\\u4e00-\\u9fa5]+$", // 真实姓名
    companyname: "^.{1,100}$",
    companyaddr: "^.{1,100}$",
    companysite: "^http[s]?:\\/\\/([\\w-]+\\.)+[\\w-]+([\\w-./?%&#=]*)?$"
};
//主函数
(function ($) {
    $.fn.jdValidate = function (option, callback, def) {
        var ele = this;
        var id = ele.attr("id");
        var type = ele.attr("type");
        var rel = ele.attr("rel");
        var _onFocus = $("#" + id + validateSettings.onFocus.container);
        var _succeed = $("#" + id + validateSettings.succeed.container);
        var _isNull = $("#" + id + validateSettings.isNull.container);
        var _error = $("#" + id + validateSettings.error.container);
        if (def == true) {
            var str = ele.val();
            var tag = ele.attr("sta");
            if ((str == "" || str == "-1") && option.isNull!="") {
                validateSettings.isNull.run({
                    prompts: option,
                    element: ele,
                    isNullEle: _isNull,
                    succeedEle: _succeed
                }, option.isNull);
            } else if (tag == 1 || tag == 2) {
                return;
            } else {
                callback({
                    prompts: option,
                    element: ele,
                    value: str,
                    errorEle: _error,
                    succeedEle: _succeed
                });
            }
        } else {
            if (typeof def == "string") {
                ele.val(def);
            }
            if (type == "checkbox" || type == "radio") {
                if (ele.attr("checked") == true) {
                    ele.attr("sta", validateSettings.succeed.state);
                }
            }
            switch (type) {
                case "text":
                case "password":
                    ele.bind("focus", function () {
                        var str = ele.val();
                        if (str == def) {
                            ele.val("");
                        }
                        
                        validateSettings.onFocus.run({
                        prompts: option,
                        element: ele,
                        value: str,
                        onFocusEle: _onFocus,
                        succeedEle: _succeed
                        }, option.onFocus, option.onFocusExpand);
                        
                        
                    })
                        .bind("blur", function () {
                        var str = ele.val();
                        if (str == "") {
                            ele.val(def);
                        }
                        if (validateRules.isNull(str)) {
                            validateSettings.isNull.run({
                                prompts: option,
                                element: ele,
                                value: str,
                                isNullEle: _isNull,
                                succeedEle: _succeed
                            }, "");
                        } else {
                            callback({
                                prompts: option,
                                element: ele,
                                value: str,
                                errorEle: _error,
                                isNullEle: _isNull,
                                succeedEle: _succeed
                            });
                        }
                    });
                    break;
                case "file":
                    ele.bind("click", function () {
                        _error.empty();
                        if (!validateRules.checkType(ele)) {
                            ele.removeClass(validateSettings.INPUT_style1).removeClass(validateSettings.INPUT_style2);
                        } 
                        _error.removeClass();
                        validateSettings.onFocus.run({
                            prompts: option,
                            element: ele,
                            value: str,
                            onFocusEle: _onFocus,
                            succeedEle: _succeed
                       }, option.onFocus, option.onFocusExpand);
                    })
                    .bind("change",function(){
                    	var str = ele.val();
                        if (str == "") {
                            ele.val(def);
                        }
                        if (validateRules.isNull(str)) {
                            validateSettings.isNull.run({
                                prompts: option,
                                element: ele,
                                value: str,
                                isNullEle: _isNull,
                                succeedEle: _succeed
                            }, "");
                        } else {
                            callback({
                                prompts: option,
                                element: ele,
                                value: str,
                                errorEle: _error,
                                isNullEle: _isNull,
                                succeedEle: _succeed
                            });
                        }
                    })
                    break;
                default:
                    if (rel && rel == "select") {
                        ele.bind("change", function () {
                            var str = ele.val();
                            callback({
                                prompts: option,
                                element: ele,
                                value: str,
                                errorEle: _error,
                                isNullEle: _isNull,
                                succeedEle: _succeed
                            });
                        })
                    } else {
                        ele.bind("click", function () {
                            callback({
                                prompts: option,
                                element: ele,
                                errorEle: _error,
                                isNullEle: _isNull,
                                succeedEle: _succeed
                            });
                        })
                    }
                    break;
            }
        }
    }
})(jQuery);

//配置
var validateSettings = {
    onFocus: {
        state: null,
        container: "_error",
        style: "focus",
        run: function (option, str, expands) {
            if (!validateRules.checkType(option.element)) {
                option.element.removeClass(validateSettings.INPUT_style2).addClass(validateSettings.INPUT_style1);
                
            }
            if(str != ""){
                option.succeedEle.removeClass(validateSettings.succeed.style);
                option.onFocusEle.removeClass().addClass(validateSettings.onFocus.style).html(str);
                if (expands) {
                    expands();
                }
            }else{
                option.onFocusEle.empty().removeClass();
            }
            
        }
    },
    isNull: {
        state: 0,
        container: "_error",
        style: "null",
        run: function (option, str) {
            option.element.attr("sta", 0);
            if (!validateRules.checkType(option.element)) {
                if (str == "") {
                    option.element.removeClass(validateSettings.INPUT_style2).removeClass(validateSettings.INPUT_style1);
                } else {
                    option.element.removeClass(validateSettings.INPUT_style1).addClass(validateSettings.INPUT_style2);
                }
            }

            option.succeedEle.removeClass(validateSettings.succeed.style);
            if (str == "") {
                option.isNullEle.removeClass().addClass(validateSettings.isNull.style).html(str);
                if(option.element.selector == '#sjSupplierId'){
                	$("#sjSupplierId_info").html('');
    				$("#sjSupplierId_info").attr("display","none");
                }
            } else {
                option.isNullEle.removeClass().addClass(validateSettings.error.style).html(str);
            }
        }
    },
    error: {
        state: 1,
        container: "_error",
        style: "error",
        run: function (option, str) {
            option.element.attr("sta", 1);
            if (!validateRules.checkType(option.element)) {
                option.element.removeClass(validateSettings.INPUT_style1).addClass(validateSettings.INPUT_style2);
            }

            option.succeedEle.removeClass(validateSettings.succeed.style);
            option.errorEle.removeClass().addClass(validateSettings.error.style).html(str);
        }
    },
    succeed: {
        state: 2,
        container: "_succeed",
        style: "succeed",
        run: function (option) {
            option.element.attr("sta", 2);
            option.errorEle.empty();
            if (!validateRules.checkType(option.element)) {
                option.element.removeClass(validateSettings.INPUT_style1).removeClass(validateSettings.INPUT_style2);
            }

            option.succeedEle.addClass(validateSettings.succeed.style);
            option.errorEle.removeClass();
        }
    },
    INPUT_style1: "highlight1",
    INPUT_style2: "highlight2"
}

//验证规则
var validateRules = {
    isNull: function (str) {
        return (str == "" || typeof str != "string");
    },
    betweenLength: function (str, _min, _max) {
        return (str.length >= _min && str.length <= _max);
    },
    isUid: function (str) {
        return new RegExp(validateRegExp.username).test(str);
    },
    fullNumberName: function (str) {
        return new RegExp(validateRegExp.fullNumber).test(str);
    },
    isPwd: function (str) {
        return /^.*([\W_a-zA-z0-9-])+.*$/i.test(str);
    },
    isPwdRepeat: function (str1, str2) {
        return (str1 == str2);
    },
    isEmail: function (str) {
        return new RegExp(validateRegExp.email).test(str);
    },
    isTel: function (str) {
        return new RegExp(validateRegExp.tel).test(str);
    },
    isMobile: function (str) {
        return new RegExp(validateRegExp.mobile).test(str);
    },
    isPostalcode: function (str) {
        return new RegExp(validateRegExp.zipcode).test(str);
    },
    checkType: function (element) {
        return (element.attr("type") == "checkbox" || element.attr("type") == "radio" || element.attr("rel") == "select");
    },
    isRealName: function (str) {
        return new RegExp(validateRegExp.realname).test(str);
    },
    isCompanyname: function (str) {
        return new RegExp(validateRegExp.companyname).test(str);
    },
    isCompanyaddr: function (str) {
        return new RegExp(validateRegExp.companyaddr).test(str);
    },
    isCompanysite: function (str) {
        return new RegExp(validateRegExp.companysite).test(str);
    },
    simplePwd: function (str) {
        //        var pin = $("#regName").val();
        //        if (pin.length > 0) {
        //            pin = strTrim(pin);
        //            if (pin == str) {
        //                return true;
        //            }
        //        }
        return pwdLevel(str) == 1;
    },
    weakPwd: function (str) {
        for (var i = 0; i < weakPwdArray.length; i++) {
            if (weakPwdArray[i] == str) {
                return true;
            }
        }
        return false;
    }
};
//验证文本
var validatePrompt = {
    regName: {
        onFocus: "",
        succeed: "",
        isNull: "请输入用户名",
        error: {
            beUsed: "该用户名已被使用，请重新输入或使用推荐用户名",
            badLength: "用户名长度只能在4-20位字符之间",
            badFormat: "用户名只能由中文、英文、数字及“_”、“@”、“ ”、“.”组成",
            fullNumberName: "<span>用户名不能是纯数字，请确认输入的是手机号或者重新输入</span>"
        }
        // ,
        // onFocusExpand: function () {
        //     // $("#morePinDiv").removeClass().addClass("intelligent-error hide");
        // }
    },

    pwd: {
        onFocus: "<span>6-20位字符，可使用字母、数字或符号的组合，不建议使用纯数字，纯字母，纯符号</span>",
        succeed: "",
        isNull: "请输入密码",
        error: {
            badLength: "密码长度只能在6-20位字符之间",
            badFormat: "密码只能由英文、数字及标点符号组成",
            simplePwd: "<span>该密码比较简单，有被盗风险，建议您更改为复杂密码，如字母+数字的组合</span>",
            weakPwd: "<span>该密码比较简单，有被盗风险，建议您更改为复杂密码</span>"
        }
        // ,
        // onFocusExpand: function () {
        //     $("#pwdstrength").hide();
        // }
    },
    pwdRepeat: {
        onFocus: "请再次输入密码",
        succeed: "",
        isNull: "请输入密码",
        error: {
            badLength: "密码长度只能在6-20位字符之间",
            badFormat2: "两次输入密码不一致",
            badFormat1: "密码只能由英文、数字及标点符号组成"
        }
    },
    mobileCode: {
        onFocus: "",
        succeed: "",
        isNull: "请输入短信验证码",
        error: "验证码错误"
    },
    protocol: {
        onFocus: "",
        succeed: "",
        isNull: "请先阅读并同意《京东用户注册协议》",
        error: ""
    },
    empty: {
        onFocus: "",
        succeed: "",
        isNull: "",
        error: ""
    },
    userName:{
    	onFocus: "请填写真实姓名",
        succeed: "",
        isNull: "请填写真实姓名",
        error: ""
    },
    userMobile:{
    	onFocus: "即为登录名、初始密码与商家后台密码一致，请注册成功后登录修改",
        succeed: "",
        isNull: "请输入手机号",
        error: ""
    },
    hqqPwd: {
        onFocus: "<span>6-20位字符，可使用字母、数字或符号的组合，不建议使用纯数字，纯字母，纯符号</span>",
        succeed: "",
        isNull: "请输入红旗券支付密码",
        error: {
            badLength: "密码长度只能在6-20位字符之间",
            badFormat: "密码只能由英文、数字及标点符号组成",
            simplePwd: "<span>该密码比较简单，有被盗风险，建议您更改为复杂密码，如字母+数字的组合</span>",
            weakPwd: "<span>该密码比较简单，有被盗风险，建议您更改为复杂密码</span>"
        }
    },
    hqqPwdRepeat: {
        onFocus: "请再次输入密码",
        succeed: "",
        isNull: "请输入红旗券支付密码",
        error: {
            badLength: "密码长度只能在6-20位字符之间",
            badFormat2: "两次输入密码不一致",
            badFormat1: "密码只能由英文、数字及标点符号组成"
        }
    },
};

var nameold, morePinOld, emailResult;
var namestate = false;
//回调函数
var validateFunction = {
    regName: function (option) {
        // $("#intelligent-regName").empty().hide();
        var regName = option.value;
        if (validateRules.isNull(regName)) {
            option.element.removeClass(validateSettings.INPUT_style2).removeClass(validateSettings.INPUT_style1);
            $("#regName_error").removeClass().empty();
            return;
        }

        validateSettings.succeed.run(option);
        //验证是否为邮箱或者手机
        // if (regName.indexOf("@") > -1) {
        //     $("#mobileCodeDiv").removeClass().addClass("item hide");
        //     $("#authcodeDiv").show();
        //     checkEmail(option);
        //     return;
        // }
        // if (validateRules.isMobile(regName)) {
        //     checkMobile(option);
        //     return;
        // }
        // $("#mobileCodeDiv").removeClass().addClass("item hide");
        // $("#authcodeDiv").show();
         checkPin(option);
    },

    pwd: function (option) {
    	var hqqPwdVal = $("#hqqPwd").val().trim();
        var str1 = option.value;
        if(hqqPwdVal != null && hqqPwdVal != ''){
        	if(hqqPwdVal == str1){
        		 validateSettings.error.run(option, "<span>登录密码不能跟红旗券支付密码一致！请重新输入</span>");
        		 $("#pwd").val('');
                 return false;
        	}
        }
        var regName = $("#regName").val();
        if ((validateRules.isNull(regName) == false) && (regName != '邮箱/用户名/手机号') && regName == str1) {
            // $("#pwdstrength").hide();
            validateSettings.error.run(option, "<span>您的密码与账户信息太重合，有被盗风险，请换一个密码</span>");
            return;
        }

        var str2 = $("#pwdRepeat").val();
        //$("#pwdRepeat").blur();
        var format = validateRules.isPwd(option.value);
        var length = validateRules.betweenLength(option.value, 6, 20);

        // $("#pwdstrength").hide();
        if (!length && format) {
            validateSettings.error.run(option, option.prompts.error.badLength);
        } else if (!length && !format) {
            validateSettings.error.run(option, option.prompts.error.badFormat);
        } else if (length && !format) {
            validateSettings.error.run(option, option.prompts.error.badFormat);
        } else if (validateRules.weakPwd(str1)) {
            validateSettings.error.run(option, option.prompts.error.weakPwd);
        } else {

            validateSettings.succeed.run(option);
            // validateFunction.pwdstrength();
            if (validateRules.simplePwd(str1)) {
                $("#pwd_error").removeClass().addClass("focus");
                $("#pwd_error").empty().html(option.prompts.error.simplePwd);
                return;
            }
        }
        if (str2 == str1) {
            $("#pwdRepeat").focus();
        }
    },
    pwdRepeat: function (option) {
        var str1 = option.value;
        var str2 = $("#pwd").val();
        var length = validateRules.betweenLength(option.value, 6, 20);
        var format2 = validateRules.isPwdRepeat(str1, str2);
        var format1 = validateRules.isPwd(str1);
        if (!length) {
            validateSettings.error.run(option, option.prompts.error.badLength);
        } else {
            if (!format1) {
                validateSettings.error.run(option, option.prompts.error.badFormat1);
            } else {
                if (!format2) {
                    validateSettings.error.run(option, option.prompts.error.badFormat2);
                } else {
                    validateSettings.succeed.run(option);
                }
            }
        }
    },
    hqqPwd: function (option) {
    	var str1 = option.value;
    	
    	var pwdVal = $("#pwd").val().trim();
        if(pwdVal != null && pwdVal != ''){
        	if(pwdVal == str1){
        		 validateSettings.error.run(option, "<span>登录密码不能跟红旗券支付密码一致！请重新输入</span>");
        		 $("#hqqPwd").val('');
                 return false;
        	}
        }
    	
    	var str2 = $("#hqqPwdRepeat").val();
    	var format = validateRules.isPwd(option.value);
    	var length = validateRules.betweenLength(option.value, 6, 20);
    	
    	if (!length && format) {
    		validateSettings.error.run(option, option.prompts.error.badLength);
    	} else if (!length && !format) {
    		validateSettings.error.run(option, option.prompts.error.badFormat);
    	} else if (length && !format) {
    		validateSettings.error.run(option, option.prompts.error.badFormat);
    	} else if (validateRules.weakPwd(str1)) {
    		validateSettings.error.run(option, option.prompts.error.weakPwd);
    	} else {
    		
    		validateSettings.succeed.run(option);
    		if (validateRules.simplePwd(str1)) {
    			$("#hqqPwd_error").removeClass().addClass("focus");
    			$("#hqqPwd_error").empty().html(option.prompts.error.simplePwd);
    			return;
    		}
    	}
    	if (str2 == str1) {
    		$("#hqqPwdRepeat").focus();
    	}
    },
    hqqPwdRepeat: function (option) {
    	var str1 = option.value;
    	var str2 = $("#hqqPwd").val();
    	var length = validateRules.betweenLength(option.value, 6, 20);
    	var format2 = validateRules.isPwdRepeat(str1, str2);
    	var format1 = validateRules.isPwd(str1);
    	if (!length) {
    		validateSettings.error.run(option, option.prompts.error.badLength);
    	} else {
    		if (!format1) {
    			validateSettings.error.run(option, option.prompts.error.badFormat1);
    		} else {
    			if (!format2) {
    				validateSettings.error.run(option, option.prompts.error.badFormat2);
    			} else {
    				validateSettings.succeed.run(option);
    			}
    		}
    	}
    },

    mobileCode: function (option) {
        var bool = validateRules.isNull(option.value);
        if (bool) {
            validateSettings.error.run(option, option.prompts.error);
            return;
        } else {
            validateSettings.succeed.run(option);
        }
    },
    protocol: function (option) {
        if (option.element.attr("checked") == true) {
            option.element.attr("sta", validateSettings.succeed.state);
            option.errorEle.html("");
        } else {
            option.element.attr("sta", validateSettings.isNull.state);
            option.succeedEle.removeClass(validateSettings.succeed.style);
        }
    },
    pwdstrength: function () {
        var element = $("#pwdstrength");
        var value = $("#pwd").val();
        if (value.length >= 6 && validateRules.isPwd(value)) {
            $("#pwd_error").removeClass('focus');
            $("#pwd_error").empty();
            element.show();
            var level = pwdLevel(value);
            switch (level) {
                case 1:
                    element.removeClass().addClass("strengthA");
                    break;
                case 2:
                    element.removeClass().addClass("strengthB");
                    break;
                case 3:
                    element.removeClass().addClass("strengthC");
                    break;
                default:
                    break;
            }
        } else {
            element.hide();
        }
    },
    checkGroup: function (elements) {
        for (var i = 0; i < elements.length; i++) {
            if (elements[i].checked) {
                return true;
            }
        }
        return false;
    },
    checkSelectGroup: function (elements) {
        for (var i = 0; i < elements.length; i++) {
            if (elements[i].value == -1) {
                return false;
            }
        }
        return true;
    },

    FORM_submit: function (elements) {
        var bool = true;
        for (var i = 0; i < elements.length; i++) {
            if ($(elements[i]).attr("sta") == 2) {
                bool = true;
            } else {
                bool = false;
                break;
            }
        }

        return bool;
    }
};

var checkpin = -10;

 function checkPin(option) {
     var pin = option.value;
     if (!validateRules.betweenLength(pin.replace(/[^\x00-\xff]/g, "**"), 4, 20)) {
         validateSettings.error.run(option, option.prompts.error.badLength);
         return false;
     }

     if (!validateRules.isUid(pin)) {
         validateSettings.error.run(option, option.prompts.error.badFormat);
         return;
     }
//     if (validateRules.fullNumberName(pin)) {
//         validateSettings.error.run(option, option.prompts.error.fullNumberName);
//         return;
//     }
//     if (!namestate || nameold != pin) {
//         if (nameold != pin) {
//             nameold = pin;
//             option.errorEle.html("<em style='color:#999'>检验中……</em>");
//             $.getJSON("../validate/isPinEngaged?pin=" + escape(pin) + "&r=" + Math.random(), function (date) {
//                 checkpin = date.success;
//                 if (date.success == 0) {
//                     validateSettings.succeed.run(option);
//                     namestate = true;
//                 } else if (date.success == 2) {
//                     validateSettings.error.run(option, "用户名包含了非法词");
//                     namestate = false;
//                 } else {
//                     validateSettings.error.run(option, "<span>" + option.prompts.error.beUsed.replace("{1}", option.value) + "</span>");
//                     namestate = false;
//                     morePinOld = date.morePin;
//                     if (date.morePin != null && date.morePin.length > 0) {
//                         var html = ""
//                         for (var i = 0; i < date.morePin.length; i++) {
//                             html += "<div class='item-fore'><input name='morePinRadio' onclick='selectMe(this);' type='radio' class='radio' value='" + date.morePin[i] + "'/><label>" + date.morePin[i] + "</label></div>"
//                         }
//                         $("#morePinGroom").empty();
//                         $("#morePinGroom").html(html);
//                         // $("#morePinDiv").removeClass().addClass("intelligent-error");
//                     }
//                 }
//             });
//         } else {

//             if (checkpin == 2) {
//                 validateSettings.error.run(option, "用户名包含了非法词");
//             } else {
//                 validateSettings.error.run(option, "<span>" + option.prompts.error.beUsed.replace("{1}", option.value) + "</span>");
//                 if (morePinOld != null && morePinOld.length > 0) {
//                     // $("#morePinDiv").removeClass().addClass("intelligent-error");
//                 }
//             }
//             namestate = false;
//         }
//     } else {
//         validateSettings.succeed.run(option);
//     }
 }

function selectMe(option) {
    // $("#morePinDiv").removeClass().addClass("intelligent-error hide");
    $("#regName").val(option.value);
    $("#regName").blur();
}

// function checkEmail(option) {
//     var email = option.value;
//     var email = strTrim(option.value);
//     var format = validateRules.isEmail(email);
//     var format2 = validateRules.betweenLength(email, 0, 50);
//     if (!format) {
//         validateSettings.error.run(option, "邮箱地址不正确，请重新输入");
//     } else {
//         if (!format2) {
//             validateSettings.error.run(option, "邮箱地址长度应在4-50个字符之间");
//         } else {
//             if (!namestate || nameold != email) {
//                 if (nameold != email) {
//                     nameold = email;
//                     option.errorEle.html("<em style='color:#999'>检验中……</em>");
//                     $.getJSON("../validate/isEmailEngaged?email=" + escape(option.value) + "&r=" + Math.random(), function (date) {

//                         emailResult = date.success;
//                         if (date.success == 0) {
//                             validateSettings.succeed.run(option);
//                             namestate = true;
//                             if ($("#mail")) {
//                                 $("#mail").val(option.value);
//                             }
//                         }
//                         if (date.success == 1) {
//                             validateSettings.error.run(option, "该邮箱已存在，立刻<a  class='flk13' href='https://passport.jd.com/uc/login'>登录</a>");
//                             namestate = false;
//                         }
//                         if (date.success == 2) {
//                             validateSettings.error.run(option, "邮箱地址不正确，请重新输入");
//                             namestate = false;
//                         }
//                         if (date.success == 3) {
//                             validateSettings.error.run(option, "<span>中国雅虎邮箱已经停止服务,请您换一个邮箱</span>");
//                             namestate = false;
//                         }
//                     })
//                 } else {
//                     namestate = false;
//                     if (emailResult == 1) {
//                         validateSettings.error.run(option, "该邮箱已存在，立刻<a  class='flk13' href='https://passport.jd.com/uc/login'>登录</a>");
//                     }
//                     if (emailResult == 2) {
//                         validateSettings.error.run(option, "邮箱地址不正确，请重新输入");

//                     }
//                     if (emailResult == 3) {
//                         validateSettings.error.run(option, "<span>中国雅虎邮箱已经停止服务,请您换一个邮箱</span>");
//                     }
//                 }
//             } else {
//                 validateSettings.succeed.run(option);
//             }
//         }
//     }
// }

// function checkMobile(option) {
//     var mobileValue = option.value;
//     mobileValue = strTrim(mobileValue);
//     var isMobile = validateRules.isMobile(mobileValue);
//     if (!isMobile || mobileValue.length > 11) {
//         validateSettings.error.run(option, option.prompts.error.badFormat);
//     } else {
//         if (!namestate || nameold != option.value) {
//             if (nameold != option.value) {
//                 nameold = option.value;
//                 option.errorEle.html("<em style='color:#999'>检验中……</em>");
//                 $.getJSON("../validate/isMobileEngaged?mobile=" + option.value + "&r=" + Math.random(), function (date) {
//                     if (date.success == 0) {
//                         validateSettings.succeed.run(option);
//                         $("#mobileCodeDiv").removeClass().addClass("item");
//                         $("#authcodeDiv").hide();
//                         namestate = true;

//                         if ($("#mobile")) {
//                             $("#mobile").val(option.value);
//                         }
//                     } else {
//                         validateSettings.error.run(option, "该手机号已存在，立刻<a  class='flk13' href='https://passport.jd.com/uc/login'>登录</a>");
//                         namestate = false;
//                     }
//                 })
//             } else {
//                 validateSettings.error.run(option, "该手机号已存在，立刻<a  class='flk13' href='https://passport.jd.com/uc/login'>登录</a>");
//                 namestate = false;
//             }
//         } else {
//             validateSettings.succeed.run(option);
//         }
//     }
// }

//获取短信验证码
// function sendMobileCode() {
//     var mobile = $("#regName").val();
//     if (validateRules.isNull(mobile) || !validateRules.isMobile(mobile)) {
//         $("#regName_error").html("<span>手机号码格式有误，请输入以13/14/15/17/18开头的11位数字。<span>");
//         $("#regName_error").removeClass().addClass("error");
//         //  $("#regName").removeClass().addClass("text highlight2");
//         $("#regName_error").show();
//         return;
//     }
//     if ($("#sendMobileCode").attr("disabled")) {
//         return;
//     }
//     $("#sendMobileCode").attr("disabled", "disabled");

//     jQuery.ajax({
//         type: "get",
//         url: "../notify/mobileCode?mobile=" + $("#regName").val() + "&r=" + Math.random(),
//         success: function (result) {
//             if (result) {
//                 var obj = eval(result);
//                 if (obj.rs == 1 || obj.remain) {
//                     $("#mobileCode_error").addClass("hide");
//                     $("#dyMobileButton").html("120秒后重新获取");
//                     if (obj.remain) {
//                         $("#mobileCodeSucMessage").empty().html(obj.remain);
//                     } else {
//                         $("#mobileCodeSucMessage").empty().html("验证码已发送，请查收短信。");
//                     }

//                     setTimeout(countDown, 1000);
//                     $("#sendMobileCode").removeClass().addClass("btn btn-15").attr("disabled", "disabled");
//                     $("#mobileCode").removeAttr("disabled");
//                 }
//                 if (obj.rs == -1) {
//                     $("#regName_error").html("<span>手机号码格式有误，请输入以13/14/15/17/18开头的11位数字。</span>");
//                     $("#regName_error").removeClass().addClass("error");
//                     $("#regName").removeClass().addClass("text highlight2");
//                     $("#sendMobileCode").removeClass().addClass("btn").removeAttr("disabled");
//                 }
//                 if (obj.info) {
//                     mobileCodeError(obj.info);
//                 }

//                 if (obj.rs == -2) {
//                     mobileCodeError("网络繁忙，请稍后重新获取验证码");
//                 }
//             }
//         }
//     });
// }

function mobileCodeError(content) {
    $("#mobileCode_error").html(content);
    $("#mobileCode_error").removeClass().addClass("error");
    $("#mobileCode_error").show();
    $("#sendMobileCode").removeClass().addClass("btn").removeAttr("disabled");
}
var delayTime = 120;

function countDown() {
    delayTime--;
    $("#dyMobileButton").html(delayTime + '秒后重新获取');
    if (delayTime == 0) {
        delayTime = 120;
        $("#mobileCodeSucMessage").empty();
        $("#dyMobileButton").html("获取短信验证码");
        $("#mobileCode_error").addClass("hide");
        $("#sendMobileCode").removeClass().addClass("btn").removeAttr("disabled");
    } else {
        setTimeout(countDown, 1000);
    }
}

function strTrim(str) {
    return str.replace(/(^\s*)|(\s*$)/g, "");
}
var emailSurfixArray = ['@163.com', '@126.com', '@qq.com', '@sina.com', '@gmail.com', '@sohu.com', '@vip.163.com', '@vip.126.com', '@188.com', '@139.com', '@yeah.net'];

// function moreName(event) {
//     var sval = this.value;
//     event = event ? event : window.event;
//     var keyCode = event.keyCode;
//     var vschool = $('#intelligent-regName');
//     if (keyCode == 40 || keyCode == 38 || keyCode == 13) {
//         var tipindex = $("#hnseli").val() == "" ? -1 : $("#hnseli").val();
//         var fobj;
//         if (keyCode == 40) {
//             tipindex++;
//             if (tipindex == vschool.find("li").length) {
//                 tipindex = 0;
//                 vschool.find("li").eq(vschool.find("li").length - 1).css("background-color", "");
//             }
//             fobj = vschool.find("li").eq(tipindex);
//             vschool.find("li").eq(tipindex - 1).css("background-color", "");
//             fobj.css("background-color", "#EEEEEE");
//             $("#regName").val(fobj.html().replace(/<(\S*?)[^>]*>|<.*? \/>/g, ""));
//             $("#schoolid").val(fobj.attr("value"));
//             $("#hnseli").val(tipindex);
//             return;
//         } else if (keyCode == 38) {
//             tipindex--;
//             if (tipindex <= -1) {
//                 tipindex = vschool.find("li").length - 1;
//                 vschool.find("li").eq(0).css("background-color", "");
//             }
//             vschool.find("li").eq(tipindex + 1).css("background-color", "");
//             fobj = vschool.find("li").eq(tipindex);
//             fobj.css("background-color", "#EEEEEE");
//             if (fobj.html() != null) {
//                 $("#regName").val(fobj.html().replace(/<(\S*?)[^>]*>|<.*? \/>/g, ""));
//                 $("#schoolid").val(fobj.attr("value"));
//             }
//             $("#hnseli").val(tipindex);
//             return;
//         } else if (keyCode == 13) {
//             $("#hnseli").val("-1");
//             if ($("#regName").val().length >= 1) {
//                 var combinedValue = vschool.find("li").eq(tipindex).html();
//                 if (combinedValue != null) {
//                     $("#regName").val(combinedValue.replace(/<(\S*?)[^>]*>|<.*? \/>/g, ""));
//                 }
//                 vschool.empty().hide();
//                 if ($("#schoolid").val() != "") {
//                     $("#hnschool").val("1");
//                     $("#hnschool").attr("sta", 2);
//                     $("#regName").blur();
//                 } else {
//                     $("#hnschool").val("-1");
//                     $("#hnschool").attr("sta", 0);
//                     $("#regNamel_error").html("");
//                     $("#regName_succeed").removeClass("succeed");
//                 }
//                 return;
//             }
//         }
//     } else {
//         //hide morePin
//         // $("#morePinDiv").removeClass().addClass("intelligent-error hide");

//         if (sval != "") {
//             var userinput = sval;
//             var oldSval = "";
//             var pos = sval.indexOf("@");
//             if (pos >= 0) {
//                 oldSval = sval.substring(0, pos);
//             }

//             $("#schoolid").val("");
//             $("#hnseli").val("-1");
//             var html = "";
//             if (/[\u4E00-\u9FA5]/g.test(sval) || sval.indexOf("-") > -1 || sval.indexOf("_") > -1) {
//                 html = "<li>" + sval + "</li>";
//             } else {
//                 if (oldSval != '') {
//                     sval = oldSval;
//                 }
//                 if (userinput.indexOf("@") == 0) {
//                     sval = "";
//                 }
//                 html = "<li>" + userinput + "</li>";
//                 var partSurfix = initEmailSurfixArray(userinput);
//                 if (partSurfix != null) {
//                     for (var i = 0; i < partSurfix.length; i++) {
//                         html += "<li>" + sval + partSurfix[i] + "</li>";
//                     }
//                 }
//             }
//             if (sval.length > 25) {
//                 $('#intelligent-regName').hide();
//             } else {
//                 $('#intelligent-regName').show();
//                 $('#intelligent-regName').html(html).find("li").mousedown(function () {
//                     $("#regName").val($(this).html());
//                     $("#schoolid").val($(this).attr("value"));
//                     $("#hnseli").val("-1");
//                 });
//             }
//         } else {
//             $('#intelligent-regName').html("").hide();
//             $("#schoolid").val("");
//             $("#hnseli").val("-1");
//         }
//     }
// }

// $("#regName").keyup(moreName);
// $("#regName").focus(moreName);

function initEmailSurfixArray(str) {
    var pos = str.indexOf("@");
    if (pos < 0 || pos == (str.length - 1)) {
        return emailSurfixArray;
    }
    var inputSurfix = str.substring(pos, str.length);
    var suitableSurfixArray = [];
    var j = 0;
    for (var i = 0; i < emailSurfixArray.length; i++) {
        if (emailSurfixArray[i].indexOf(inputSurfix) == 0) {
            suitableSurfixArray[j] = emailSurfixArray[i];
            j++;
        }
    }

    return suitableSurfixArray;
}

//用户名下拉框
// $("#intelligent-regName li").livequery("mouseover", function () {
//     var vi = $(this).attr("dex");
//     var tipindex = $("#hnseli").val() == "" ? -1 : $("#hnseli").val();
//     if (tipindex <= 0) {
//         tipindex = 0;
//     }
//     $('#intelligent-regName').find("li").eq(tipindex).css("background-color", "");
//     $(this).css("background-color", "#EEEEEE");
//     $("#hnseli").val($(this).attr("dex"));
// }).livequery("mouseleave", function () {
//     var tipindex = $("#hnseli").val() == "" ? -1 : $("#hnseli").val();
//     if (tipindex <= 0) {
//         tipindex = 0;
//     }
//     $(this).css("background-color", "");
//     $("#hnseli").val("-1");
// });

// $("#regName").blur(function () {
//     setTimeout(function () {
//         if ($("#schoolid").val() == "") {
//             $("#schoolinput").val("");
//             $("#hnschool").val("-1");
//             $("#hnschool").attr("sta", 0);
//             $("#schoolinput_succeed").removeClass("succeed");
//         } else {
//             $("#hnschool").val("1");
//             $("#hnschool").attr("sta", 2);
//             $("#schoolinput_error").html("");
//             $("#schoolinput_succeed").addClass("succeed");
//         }
//         $('#intelligent-school').hide().empty();
//         $("#hnseli").val("-1");
//     }, 200)
// })

// 用户协议
// $(function () {
//     $('#protocol').click(function () {
//         jQuery.jdThickBox({
//             type: "text",
//             title: "京东用户注册协议",
//             width: 922,
//             height: 450,
//             source: "<div class=\" regist-2013\">" + "<div class=\"regist-bor\">" + "<div class=\"mc\">" + "<div id=\"protocol-con\">" + "<h4>京东用户注册协议</h4>" +

//             "<p>" + "本协议是用户（以下简称“您”）与京东网站（网址：包括但不限于www.jd.com等，简称“本站”）所有者及其关联公司（以下简称为“京东”）之间就京东网站服务等相关事宜所订立的契约，请您仔细阅读本注册协议，您点击\"同意并继续\"按钮后，即视为您接受并同意遵守本协议的约定。</p>" + "<h5> 第1条 本站服务条款的确认和接纳</h5>" +

//             "<p>" + "<strong>1.1</strong>本站的各项电子服务的所有权和运作权归京东所有。您同意所有注册协议条款并完成注册程序，才能成为本站的正式用户。您确认：本协议条款是处理双方权利义务的依据，始终有效，法律另有强制性规定或双方另有特别约定的，依其规定或约定。" + "</p>" +

//             "<p>" + "<strong>1.2</strong>您点击同意本协议的，即视为您确认自己具有享受本站服务、下单购物等相应的权利能力和行为能力，能够独立承担法律责任。</p>" +

//             "<p>" + "<strong>1.3</strong>您确认，如果您在18周岁以下，您只能在父母或其他监护人的监护参与下才能使用本站。</p>" +

//             "1.4<strong><em>京东保留在中华人民共和国大陆地区施行之法律允许的范围内独自决定拒绝服务、关闭用户账户、清除或编辑内容或取消订单的权利。</em></strong>" +

//             "<p>" + "<strong>1.5</strong>您使用本站提供的服务时，应同时接受适用于本站特定服务、活动等的准则、条款和协议（以下统称为“其他条款”）；如果以下使用条件与“其他条款”有不一致之处，则以“其他条款”为准。</p>" +

//             "<p>" + "<strong>1.6</strong>为表述便利，商品和服务简称为“商品”或“货物”。</p>" + "<h5> 第2条 本站服务</h5>" +

//             "<p>" + "<strong>2.1</strong>京东通过互联网依法为您提供互联网信息等服务，您在完全同意本协议及本站相关规定的情况下，方有权使用本站的相关服务。</p>" +

//             "<p>" + "<strong>2.2</strong>您必须自行准备如下设备和承担如下开支：（1）上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；（2）上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。" + "</p>" + "<p>" + "<strong>2.2.1</strong>上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；" + "</p>" + "<p>" + "<strong>2.2.2</strong>上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。" + "</p>" + "<h5> 第3条 用户信息收集及保护</h5>" +

//             "<p>" + "<strong>3.1</strong>您应自行诚信向本站提供注册资料，您保证提供的注册资料真实、准确、完整、合法有效，您的注册资料如有变动的，应及时更新其注册资料。如果您提供的注册资料不合法、不真实、不准确、不详尽的，您需承担因此引起的相应责任及后果，并且京东保留单方终止您使用京东各项服务的权利。" + "</p>" +

//             "<p>" + "<strong>3.2</strong>您在本站进行注册、浏览、下单购物、评价、参加活动等行为时，涉及您真实姓名/名称、通信地址、联系电话、电子邮箱、订单详情、评价或反馈、投诉内容、cookies等信息的，本站有权从完成交易、提供配送、售后及客户服务、开展活动、完成良好的客户体验等多种角度予以收集，并将对其中涉及个人隐私信息予以严格保密，除非得到您的授权、为履行强行性法律义务（如国家安全机关指令）或法律另有规定、本注册协议或其他条款另有约定外，本站不会向外界披露您的隐私信息。" + "</p>" +

//             "<p>" + "<strong>3.3</strong>您注册成功后，将产生用户名和密码等账户信息，您可以根据本站规定更改您的密码。您应谨慎合理的保存、使用您的账户信息。您若发现任何非法使用您的账户或其他存在安全漏洞的情况的，请立即通知本站并向公安机关报案。" + "</p>" +

//             "<p>" + "<strong>3.4</strong><strong>您同意，京东拥有通过邮件、短信、电话、网站通知或声明等形式，向在本站注册、购物的用户、收货人发送订单信息、促销活动、售后服务、客户服务等告知信息的权利。如您不希望接收上述信息，可退订。</strong></p>" +

//             "<p>" + "<strong>3.5</strong><strong>您同意：您选择向本站的商品销售商或服务提供商（以下统称为“销售商”，含京东及第三方卖家）提交订单购买商品或服务的，视为您向销售商披露个人相关信息，接受销售商向您提供商品销售、配送、售后服务、客户服务、处理信用卡付款、数据分析、市场营销帮助或其他必要事宜；如前述全部或部分事宜之一涉及由销售商外的第三方履行的，销售商有权将您的信息以必要方式向第三方披露，第三方有权以履行上述事宜为目的联系您。</strong></p>" +

//             "<p>" + "<strong>3.6</strong><strong>您不得将在本站注册获得的账号、密码等账户信息提供给他人使用，否则您应承担由此产生的全部责任，并与实际使用人承担连带责任。</strong>" + "</p>" + "<p>" + "<strong>3.7</strong><strong>您同意，京东有权使用您的注册信息、用户名、密码等信息，登陆进入您的注册账户，进行证据保全，包括但不限于公证、见证、协助司法机关进行调查取证等。</strong>" + "</p>" + "<h5> 第4条 用户依法言行义务</h5>" +

//             "<p> 本协议依据国家相关法律法规规章制定，您同意严格遵守以下义务：</p>" +

//             "<p>" + "<strong>4.1</strong>不得传输或发表：煽动抗拒、破坏宪法和法律、行政法规实施的言论，煽动颠覆国家政权，推翻社会主义制度的言论，煽动分裂国家、破坏国家统一的言论，煽动民族仇恨、民族歧视、破坏民族团结的言论；" + "</p>" + "<p>" + "<strong>4.2</strong>从中国大陆向境外传输资料信息时必须符合中国有关法律法规；" + "<p>" + "<strong>4.3</strong>不得利用本站从事洗钱、窃取商业秘密、窃取个人信息等违法犯罪活动；" + "</p>" + "<p>" + "<strong>4.4</strong>不得干扰本站的正常运转，不得侵入本站及国家计算机信息系统；" + "</p>" + "<p>" + "<strong>4.5</strong>不得传输或发表任何违法犯罪的、骚扰性的、中伤他人的、辱骂性的、恐吓性的、伤害性的、庸俗的，淫秽的、不文明的等信息资料；" + "</p>" + "<p>" + "<strong>4.6</strong>不得传输或发表损害国家社会公共利益和涉及国家安全的信息资料或言论；" + "</p>" + "<p>" + "<strong>4.7</strong>不得教唆他人从事本条所禁止的行为；" + "</p>" + "<p>" + "<strong>4.8</strong>除本注册协议、其他条款或另有其他约定外，您不得利用在本站注册的账户进行经营活动、牟利行为及其他未经本站许可的行为，包括但不限于以下行为：" + "</p>" + "<p>" + "<strong>4.8.1</strong>您账户内的任何京东优惠信息（包括但不限于京券、东券、京豆及其他形式优惠或折扣等）由京东享有解释权和修改权，您仅享有在京东购物时的使用权，严禁转卖京东账户、京券、东券、京豆或其他类型的优惠券、京东卡、或利用京东账户进行其他经营性行为等；" + "<p>" + "<strong>4.8.2</strong>恶意利用技术手段或其他方式，为获取优惠、折扣或其他利益而注册账户、下单等行为，影响其他用户正常消费行为或相关合法权益、影响京东正常销售秩序的行为；" + "</p>" + "<p>" + "<strong>4.8.3</strong>发布广告、垃圾邮件；" + "</p>" + "<p>" + "<strong>4.8.4</strong>以再销售或商业使用为目的对本站商品或服务进行购买的（与京东另有合同约定的除外）；" + "</p>" + "<p>" + "<strong>4.8.5</strong>商品或服务的供应商、代理商对其所供商品进行回购的行为；" + "</p>" + "<p>" + "<strong>4.8.6</strong>任何对商品目录、说明、价格、数量、其他用户信息或其他内容的下载、转载、收集、衍生利用、复制、出售、转售或其他形式的使用，无论是否通过Robots、Spiders、自动仪器或手工操作；" + "</p>" + "<p>" + "<strong>4.8.7</strong>本站相关规则、政策、或网页活动规则中限制、禁止的行为；" + "</p>" + "<p>" + "<strong>4.8.8</strong>其他影响京东对用户账户正常管理秩序的行为。" + "</p>" + "<p>" + "<strong>4.9</strong>您不得利用任何非法手段获取其他用户个人信息，不得将其他用户信息用于任何营利或非营利目的，不得泄露其他用户或权利人的个人隐私，否则京东有权采取本协议规定的合理措施制止您的上述行为，情节严重的，将提交公安机关进行刑事立案。" + "</p>" + "<p>" + "<strong>4.10</strong>您不得发布任何侵犯他人著作权、商标权等知识产权或其他合法权利的内容；如果有其他用户或权利人发现您发布的信息涉嫌知识产权、或其他合法权益争议的，这些用户或权利人有权要求京东删除您发布的信息，或者采取其他必要措施予以制止，京东将会依法采取这些措施。" + "</p>" + "<p>" + "<strong>4.11</strong>您应不时关注并遵守本站不时公布或修改的各类规则规定。本站保有删除站内各类不符合法律政策或不真实的信息内容而无须通知您的权利。" + "</p>" + "<p>" + "<strong>4.12</strong>若您未遵守以上规定的，本站有权做出独立判断并采取暂停或关闭您的账号、冻结账号内余额及京东卡金额、关闭相应交易订单、停止发货等措施。您须对自己在网上的言论和行为承担法律责任。" + "</p>" +


//             "<h5> 第5条 商品信息</h5>" + "<strong>5.1</strong><strong><em>" + "本站上的商品价格、数量、是否有货等商品信息随时都有可能发生变动，本站不作特别通知。由于网站上商品信息的数量极其庞大，虽然本站会尽最大努力保证您所浏览商品信息的准确性，但由于众所周知的互联网技术因素等客观原因存在，本站网页显示的信息可能会有一定的滞后性或差错，对此情形您知悉并理解；京东欢迎纠错，并会视情况给予纠错者一定的奖励。" + "</em></strong>" +

//             "<p> <strong>5.1</strong>本站售后服务政策为本协议的组成部分，京东有权以声明、通知或其他形式变更售后服务政策。</p>" + "<h5> 第6条 订单</h5>" +

//             "<p>" + "<strong>6.1</strong>在您下订单时，请您仔细确认所购商品的名称、价格、数量、型号、规格、尺寸、联系地址、电话、收货人等信息。<span>收货人与您本人不一致的，收货人的行为和意思表示视为您的行为和意思表示，您应对收货人的行为及意思表示的法律后果承担连带责任。</span>" + "</p>" +

//             "<strong>6.2</strong>除法律另有强制性规定外，双方约定如下：<strong><em>本站上销售商展示的商品和价格等信息仅仅是要约邀请，您下单时须填写您希望购买的商品数量、价款及支付方式、收货人、联系方式、收货地址（合同履行地点）、合同履行方式等内容；系统生成的订单信息是计算机信息系统根据您填写的内容自动生成的数据，仅是您向销售商发出的合同要约；销售商收到您的订单信息后，只有在销售商将您在订单中订购的商品从仓库实际直接向您发出时（以商品出库为标志），方视为您与销售商之间就实际直接向您发出的商品建立了合同关系；如果您在一份订单里订购了多种商品并且销售商只给您发出了部分商品时，您与销售商之间仅就实际直接向您发出的商品建立了合同关系；只有在销售商实际直接向您发出了订单中订购的其他商品时，您和销售商之间就订单中该其他已实际直接向您发出的商品才成立合同关系。您可以随时登陆您在本站注册的账户，查询您的订单状态。对于电子书、数字音乐、在线手机充值等数字化商品，您下单并支付货款后合同即成立。</em></strong>" +

//             "<p>" + "<strong>6.3</strong><strong>尽管销售商做出最大的努力，但商品目录里的一小部分商品可能会有定价错误。如果发现错误定价，将采取下列之一措施，且不视为违约行为：</strong>" + "</p>" + "<p>" + "<strong>6.3.1</strong><strong>如果某一商品的正确定价低于销售商的错误定价，销售商将按照较低的定价向您销售交付该商品。</strong>" + "</p>" + "<p>" + "<strong>6.3.2</strong><strong>如果某一商品的正确定价高于销售商的错误定价，销售商会通知您，并根据实际情况决定是否取消订单、停止发货、为已付款用户办理退款等。</strong>" + "</p>" + "<p>" + "<strong>6.4</strong><strong>由于市场变化及各种以合理商业努力难以控制的因素的影响，本站无法保证您提交的订单信息中希望购买的商品都会有货；如您下单所购买的商品，发生缺货，您有权取消订单，销售商亦有权取消订单，并为已付款的用户办理退款。</strong>" + "</p>" +

//             "<h5> 第7条 配送</h5>" +

//             "<p>" + "<strong>7.1</strong>销售商将会把商品（货物）送到您所指定的收货地址，所有在本站上列出的送货时间为参考时间，参考时间的计算是根据库存状况、正常的处理过程和送货时间、送货地点等相关信息估计得出的。" + "</p>" +

//             "<p>" + "<strong>7.2</strong>因如下情况造成订单延迟或无法配送、交货等，销售商不承担延迟配送、交货的责任：</p>" +

//             "<p>" + "<strong>（1）</strong>您提供的信息错误、地址不详细等原因导致的；" + "</p>" +

//             "<p>" + "<strong>（2）</strong>货物送达后无人签收，导致无法配送或延迟配送的；</p>" +

//             "<p>" + "<strong>（3）</strong>情势变更因素导致的；</p>" +

//             "<p>" + "<strong>（4）</strong>未能在本站所示的送货参考时间内送货的；</p>" + "<p>" + "<strong>（5）</strong>因节假日、大型促销活动、店庆、预购或抢购人数众多等原因导致的；</p>" + "<p>" + "<strong>（6）</strong>不可抗力因素导致的，例如：自然灾害、交通戒严、突发战争等。</p>" + "<h5> 第8条 所有权及知识产权条款</h5>" +

//             "<p>" + "<strong>8.1</strong><strong>您一旦接受本协议，即表明您主动将其在任何时间段在本站发表的任何形式的信息内容（包括但不限于客户评价、客户咨询、各类话题文章等信息内容）的财产性权利等任何可转让的权利，如著作权财产权（包括并不限于：复制权、发行权、出租权、展览权、表演权、放映权、广播权、信息网络传播权、摄制权、改编权、翻译权、汇编权以及应当由著作权人享有的其他可转让权利），全部独家且不可撤销地转让给京东所有，您同意京东有权就任何主体侵权而单独提起诉讼。</strong>" + "</p>" +

//             "<p>" + "<strong>8.2</strong><strong>本协议已经构成《中华人民共和国著作权法》第二十五条（条文序号依照2011年版著作权法确定）及相关法律规定的著作财产权等权利转让书面协议，其效力及于您在京东网站上发布的任何受著作权法保护的作品内容，无论该等内容形成于本协议订立前还是本协议订立后。</strong>" + "</p>" +

//             "<p>" + "<strong>8.3</strong><strong>您同意并已充分了解本协议的条款，承诺不将已发表于本站的信息，以任何形式发布或授权其他主体以任何方式使用（包括但限于在各类网站、媒体上使用）。</strong>" + "</p>" +

//             "<p>" + "<strong>8.4</strong><strong>京东有权不时地对本协议及本站的内容进行修改，并在本站张贴，无须另行通知您。在法律允许的最大限度范围内，京东对本协议及本站内容拥有解释权。</strong>" + "</p>" +

//             "<p>" + "<strong>8.5</strong><strong>除法律另有强制性规定外，未经京东明确的特别书面许可,任何单位或个人不得以任何方式非法地全部或部分复制、转载、引用、链接、抓取或以其他方式使用本站的信息内容，否则，京东有权追究其法律责任。</strong>" + "</p>" +

//             "<p>" + "<strong>8.6</strong>本站所刊登的资料信息（包括但不限于文字、图表、商标、logo、标识、按钮图标、图像、声音文件片段、数字下载、数据编辑和软件等），均是京东或其内容提供者的财产，受中国和国际相关版权法规、公约等的保护，未经京东书面许可，任何第三方无权将上述资料信息复制、出版、发行、公开展示、编码、翻译、传输或散布至任何其他计算机、服务器、网站或其他媒介。本站上所有内容的汇编是京东的排他财产，受中国和国际版权法的保护。本站上所有软件都是京东或其关联公司或其软件供应商的财产，受中国和国际版权法的保护。您不得鼓励、协助或授权任何其他人复制、修改、反向工程、反向编译或反汇编、拆解或者试图篡改全部或部分软件，或利用软件创设衍生产品。" + "</p>" +

//             "<h5> 第9条 责任限制及不承诺担保</h5>" +

//             "<p>" + "<strong>9.1</strong>除非另有明确的书面说明,本站及其所包含的或以其他方式通过本站提供给您的全部信息、内容、材料、产品（包括软件）和服务，均是在“按现状”和“按现有”的基础上提供的。" + "</p>" +

//             "<p><strong>9.2</strong>除非另有明确的书面说明,京东不对本站的运营及其包含在本站上的信息、内容、材料、产品（包括软件）或服务作任何形式的、明示或默示的声明或担保（根据中华人民共和国法律另有规定的以外）。" + "</p>" +

//             "<p><strong>9.3</strong>京东不担保本站所包含的或以其他方式通过本站提供给您的全部信息、内容、材料、产品（包括软件）和服务、其服务器或从本站发出的电子信件、信息没有病毒或其他有害成分。" + "</p>" +

//             "<p><strong>9.4</strong>如因不可抗力或其他本站无法控制的原因使本站销售系统崩溃或无法正常使用导致网上交易无法完成或丢失有关的信息、记录等，京东会合理地尽力协助处理善后事宜。" + "</p>" +

//             "<p><strong>9.5</strong>您应对账户信息及密码承担保密责任，因您未能尽到信息安全和保密责任而致使您的账户发生任何问题的，您应承担全部责任。同时，因网络环境存在众多不可预知因素，因您自身终端网络原因（包括但不限于断网、黑客攻击、病毒等）造成您的京东账户或个人信息等被第三方窃取的，京东不承担赔偿责任。" + "</p>" +

//             "<p><strong>9.6</strong>您了解并同意，京东有权应国家有关机关的要求，向其提供您在京东的用户信息和交易记录等必要信息。如您涉嫌侵犯他人合法权益，则京东有权在初步判断涉嫌侵权行为可能存在的情况下，向权利人提供您必要的个人信息。" + "</p>" +


//             "<h5> 第10条 协议更新及用户关注义务</h5>" + "根据国家法律法规变化及网站运营需要，京东有权对本协议条款不时地进行修改，修改后的协议一旦被张贴在本站上即生效，并代替原来的协议。您可随时登陆查阅最新协议；<strong><em>您有义务不时关注并阅读最新版的协议、其他条款及网站公告。如您不同意更新后的协议，可以且应立即停止接受京东网站依据本协议提供的服务；如您继续使用本站提供的服务的，即视为同意更新后的协议。京东建议您在使用本站之前阅读本协议及本站的公告。</em></strong>" + "如果本协议中任何一条被视为废止、无效或因任何理由不可执行，该条应视为可分的且并不影响任何其余条款的有效性和可执行性。" + "<h5> 第11条 法律管辖和适用</h5>" + "本协议的订立、执行和解释及争议的解决均适用在中华人民共和国大陆地区适用之有效法律（但不包括其冲突法规则）。如发生本协议与适用之法律相抵触时，则这些条款将完全按法律规定重新解释，而其他条款继续有效。如缔约方就本协议内容或其执行发生任何争议，双方应尽力友好协商解决；协商不成时，任何一方均可向有管辖权的中华人民共和国大陆地区法院提起诉讼。" + "<h5> 第12条 其他</h5>" +

//             "<p>" + "<strong>12.1</strong>京东网站所有者是指在政府部门依法许可或备案的京东网站经营主体。</p>" +

//             "<p>" + "<strong>12.2</strong>京东尊重您的合法权利，本协议及本站上发布的各类规则、声明、售后服务政策等其他内容，均是为了更好的、更加便利的为您提供服务。本站欢迎您和社会各界提出意见和建议，京东将虚心接受并适时修改本协议及本站上的各类规则。" + "</p>" +

//             "<p>" + "<strong>12.3</strong><span>本协议内容中以黑体、加粗、下划线、斜体等方式显著标识的条款，请您着重阅读。</span></p>" +

//             "<p>" + "<strong>12.4</strong><span>您点击本协议下方的“同意并继续”按钮即视为您完全接受本协议，在点击之前请您再次确认已知悉并完全理解本协议的全部内容。</span></p>" + "</div>" + "      <div class=\"btnt\">" + "         <input  class=\"btn-img\"  type=\''button\" value='同意并继续' onclick='protocolReg();'/>" + "     </div>" + "</div>" + "</div>" + "</div>",
//             _autoReposi: true
//         });
//     });
// });

// function showHideProtocol() {
//     var protocolNode = $('.protocol-box');
//     if (!protocolNode.is(':hidden')) {
//         protocolNode.hide();
//     } else {
//         protocolNode.show();
//     }
//     return false;
// }

function validateRegName() {
    var loginName = $("#regName").val();
    if (validateRules.isNull(loginName) || loginName == '邮箱/用户名/手机号') {
        $("#regName").val("");
        $("#regName").attr({
            "class": "text highlight2"
        });
        $("#regName_error").html("请输入邮箱/用户名/手机号").show().attr({
            "class": "error"
        });
        return false;
    }
    return true;
}
// $("#regist .tab li").hover(function () {
//     if ($(this).hasClass("curr")) {} else {
//         $(this).addClass("new");
//     }
// }, function () {
//     if ($(this).hasClass("curr")) {} else {
//         $(this).removeClass("new");
//     }
// })

$("#registsubmit").hover(function () {
    $(this).addClass("hover-btn")
}, function () {

    $(this).removeClass("hover-btn")
})