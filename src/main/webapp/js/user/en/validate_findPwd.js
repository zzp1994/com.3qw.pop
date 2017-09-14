
function historyBlur(){
	$("#mobileTwo").val($("#mobile").val());
	$("#mobile").removeClass().addClass("text text-1 text-mar");
	$("#mobile_error").removeClass().html("");
	var mobile = $("#mobile").val();
	if(!mobile){
		$("#mobile").removeClass().addClass("text text-1 text-mar");
		$("#mobile_error").removeClass().html("");
		return;
	}
	checkHistoryMobile();
}

function codeFocus(){
	$("#code").removeClass().addClass("text text-1 highlight1");
	$("#code_error").removeClass().addClass("msg-text").html("");
}

function codeBlur(){
	$("#code").removeClass().addClass("text text-1");
	$("#code_error").removeClass().html("");
}

function checkCode(){
	var code = $("#code").val();
	if(!code){
		$("#code").removeClass().addClass("text text-1 highlight2");
		$("#code_error").removeClass().addClass("msg-error").html("Please input the verification code!");
		return false;
	}
	$("#code").removeClass().addClass("text text-1");
	$("#code_error").removeClass().html("");
	return true;
}


function authCodeFocus(){
	$("#authCode").removeClass().addClass("text text-1 highlight1");
	$("#authCode_error").removeClass().addClass("msg-text").html("");
}

function authCodeBlur(){
	$("#authCode").removeClass().addClass("text text-1");
	$("#authCode_error").removeClass().html("");
}

function historyNameFocus(){
	$("#historyName_error").html("");
	$("#historyName").removeClass().addClass("text highlight1"); 
}


function passwordFocus(passwordId){
	$("#pwdstrength").removeClass().hide();
	$("#password").removeClass().addClass("text highlight1"); 
	$("#password_error").removeClass().addClass("msg-text").html("Password must be 6-20 characters");
}

function passwordBlur(){
	$("#password").removeClass().addClass("text");
	var password = $("#password").val();
	if(!password){
		$("#password").removeClass().addClass("text");
		$("#password_error").removeClass().html("");
		$("#pwdstrength").hide();
		$("#pwdstrength").removeClass();
		return;
	}
	checkNewPasswordForm();
	$("#repassword").focus();
}

function passwordKeyup(){
	var password = $("#password").val();
	var reg = new RegExp("^.*([\u4E00-\u9FA5])+.*$", "g");
	if (password.length < 6) {
		$("#password").removeClass().addClass("text text-error highlight1");
		$("#password_error").removeClass().html("");
		return false;
	}else {
		var   pattern_1   =   /^.*([\W_])+.*$/i; 
		var   pattern_2   =   /^.*([a-zA-Z])+.*$/i; 
		var   pattern_3   =   /^.*([0-9])+.*$/i; 
		var strength = 0;
		if(password.length>10){
			strength++;
		}
		if(pattern_1.test(password)){
			strength++;
		}
		if(pattern_2.test(password)){
			strength++;
		}
		if(pattern_3.test(password)){
			strength++;
		}
		if(strength<=1){
			$("#pwdstrength").show();
			$("#pwdstrength").removeClass().addClass("strengthA");
			$("#password").removeClass().addClass("text");
			$("#password_error").removeClass().html("");
		}
		if(strength==2){
			$("#pwdstrength").show();
			$("#pwdstrength").removeClass().addClass("strengthB");
			$("#password").removeClass().addClass("text");
			$("#password_error").removeClass().html("");
		}
		if(strength>=3){
			$("#pwdstrength").show();
			$("#pwdstrength").removeClass().addClass("strengthC");
			$("#password").removeClass().addClass("text");
			$("#password_error").removeClass().html("");
		}
	}
}

function repasswordFocus(passwordId){
	$("#repassword").removeClass().addClass("text highlight1"); 
	$("#repassword_error").removeClass().addClass("msg-text").html("Pleast re-enter your password");
}

function repasswordBlur(){
	$("#repassword").removeClass().addClass("text");
	var repassword = $("#repassword").val();
	if(!repassword){
		$("#repassword").removeClass().addClass("text");
		$("#repassword_error").removeClass().html("");
		return;
	}
	isSamePassword();
}

function isSamePassword(){
	var password = $("#password").val();
	var repassword = $("#repassword").val();
	if(!repassword){
		$("#repassword").removeClass().addClass("text highlight2"); 
		$("#repassword_error").removeClass().addClass("msg-error").html("Please re-enter your password");
		return false;
	}
	if(password != repassword){
		$("#repassword").removeClass().addClass("text highlight2");
		$("#repassword_error").removeClass().addClass("msg-error").html("Passwords must be consistent");
		return false;
	}
	$("#repassword_error").removeClass().html("");
	return true;
}


function checkNewPasswordForm(){
	var password = $("#password").val();
	if(!password){
		$("#password").removeClass().addClass("text text-error highlight2");
		$("#password_error").removeClass().addClass("msg-error").html("Password must be 6-20 characters");
		return false;
	}
     if (password.length < 6) {
		$("#password").removeClass().addClass("text text-error highlight2");
		$("#password_error").removeClass().addClass("msg-error").html("Password must be 6-20 characters");
		return false;
	} else if (password.length > 20) {
		$("#password").removeClass().addClass("text text-error highlight2");
		$("#password_error").removeClass().addClass("msg-error").html("Password must be 6-20 characters");
		return false;
	} else {
		var   pattern_1   =   /^.*([\W_])+.*$/i; 
		var   pattern_2   =   /^.*([a-zA-Z])+.*$/i; 
		var   pattern_3   =   /^.*([0-9])+.*$/i; 
		var strength = 0;
		if(password.length>10){
			strength++;
		}
		if(pattern_1.test(password)){
			strength++;
		}
		if(pattern_2.test(password)){
			strength++;
		}
		if(pattern_3.test(password)){
			strength++;
		}
		if(strength<=1){
			$("#password").removeClass().addClass("text text-error highlight2");
			$("#password_error").removeClass().addClass("msg-error").html("The password is too simple,change complex one");
			return false;
		}
		if(strength==2){
			$("#pwdstrength").show();
			$("#pwdstrength").removeClass().addClass("strengthB");
			$("#password").removeClass().addClass("text");
			$("#password_error").removeClass().html("");
		}
		if(strength>=3){
			$("#pwdstrength").show();
			$("#pwdstrength").removeClass().addClass("strengthC");
			$("#password").removeClass().addClass("text");
			$("#password_error").removeClass().html("");
		}
	}
	return true;
}

function usernameOnblur(){
	$("#username").removeClass().addClass("text");
	var username = $("#username").val();
	if(!username){
		$("#username").removeClass().addClass("text");
		$("#username_error").removeClass().html("");
		return;
	}
	checkUsername();
}

function usernameOnfocus(){
	var username = $("#username").val();
	if(username == "login name"){
		$("#username").val("");
	}
	$("#username").removeClass().addClass("text highlight1"); 
	$("#username_error").removeClass().addClass("msg-text").html("Please enter your login name");
}

function checkUsername(){
	var username = $("#username").val(); 
	if(!username){
		$("#username").removeClass().addClass("text highlight2");
		$("#username_error").removeClass().addClass("msg-error").html("Please enter your login name");
		return false;
	}
	
	if(username == "login name"){
		$("#username").val("");
		$("#username").removeClass().addClass("text highlight2");
		$("#username_error").removeClass().addClass("msg-error").html("Please enter your login name");
		return false;
	}
	
	$("#username").removeClass().addClass("text");
	$("#username_error").removeClass().html("");
	return true;
}

function nameOnfocus(){
	var username = $("#username").val();
	$("#username").removeClass().addClass("text highlight1"); 
	$("#username_error").removeClass().addClass("msg-text").html("Please enter your login name");
}

function nameOnblur(){
	$("#username").removeClass().addClass("text");
	var username = $("#username").val();
	if(!username){
		$("#username").removeClass().addClass("text");
		$("#username_error").removeClass().html("");
		return;
	}
	checkName();
}
function checkName(){
	var username = $("#username").val(); 
	if(!username){
		$("#username").removeClass().addClass("text highlight2");
		$("#username_error").removeClass().addClass("msg-error").html("Please enter your login name");
		return false;
	}
	
	if(username.replace(/[^\x00-\xff]/g,"**").length > 20||username.replace(/[^\x00-\xff]/g,"**").length <4){
		$("#username").removeClass().addClass("text highlight2");
		$("#username_error").removeClass().addClass("msg-error").html("login name must be 4-20 characters");
		return false;
	}
	
	$("#username").removeClass().addClass("text");
	$("#username_error").removeClass().html("");
	return true;
}

function selectVerifyType(){
	var type = $("#type").val();
	if(type == "mobile"){
		$("#mobileDiv").show();
		$("#emailDiv").hide();
	}else if(type == "email"){
		$("#mobileDiv").hide();
		$("#emailDiv").show();
	}
}

function noChooseEmail(){
	$("#usernameDiv").hide();
}

function chooseInputUsername(email){
	if($("#chooseSubmit").attr("disabled")) {
		return;
	}
	if(!checkName()){
		 return;
	}
	$("#chooseSubmit").attr("disabled","disabled");
	var username = $("#username").val();
	jQuery.ajax({
		type : "post",
		dataType: "json",
		url : "/findPwd/chooseInputUsername.action?email="+email+"&username="+escape(username),
		success : function(data) {
			if(data && data.result == "ok"){
				window.location.href="/findPwd/findPwd.action?k="+data.k;
			}else if(data && data.result == "none"){
				$("#username").removeClass().addClass("text highlight2");
				$("#username_error").removeClass().addClass("msg-error").html("邮箱与用户名不匹配，请重新输入");
				$("#chooseSubmit").removeAttr("disabled");
				verc(uuid);
			}else{
				alert("网络连接超时，请您稍后重试");
				$("#chooseSubmit").removeAttr("disabled");
				verc(uuid);
			}
		},
    	error : function() {
			alert("网络连接超时，请您稍后重试");
			$("#chooseSubmit").removeAttr("disabled");
			verc(uuid);
    	}
	});
}

function updatePassword(key) {
	var newPassword = $("#password").val();
	if($("#resetPwdSubmit").attr("disabled")) {
		return;
	}
	if(!checkNewPasswordForm(newPassword)){
		 return;
	}
	if(!isSamePassword()){
		return;
	} 
	$("#resetPwdSubmit").attr("disabled","disabled");
	jQuery.ajax({
		type : "post",
		dataType: "html",
		url : "../supplier/finish?password="+newPassword+"&uid="+key,
		success : function(data) {
			if(data == "ok"){
				window.location.href = "../supplier/finishSuccess?uid="+key;
			}else if(data == "passwordError"){
				$("#pwdstrength").removeClass().hide();
				$("#password").removeClass().addClass("text highlight2");
				$("#password_error").removeClass().addClass("msg-error").html("Password must be 6-20 characters");
				$("#resetPwdSubmit").removeAttr("disabled");
			}else if(data== "timeOut"){
				alert("Operation timed out. Please modify the password again");
				window.location.href="../supplier/findPwd";
			}else{
				alert("Network connection timeout, please try again later");
				window.location.href="../supplier/findPwd";
			}
		},
    	error : function() {
			alert("Network connection timeout, please try again later");
			window.location.href="../supplier/findPwd";
    	}
	});
	
}


function sendFindPwdCode(k){
	if($("#sendMobileCode").attr("disabled")) {
		return;
	}
	$("#sendMobileCode").attr("disabled","disabled");
	jQuery.ajax({
		type : "get",
		url : "/findPwd/getCode.action?k="+k,
		success : function(data) {
			if(data == "1") {
				$("#ftx-01").text(119);
				$("#sendMobileCodeDiv").hide();
				$("#timeDiv").show();
				setTimeout(countDown, 1000);
				$("#code").removeAttr("disabled");
				$("#submitCode").removeAttr("disabled");
			}else if(data == "kError"){
				window.location.href="/findPwd/index.action";
			}else if(data == "-2") {
				alert("120秒内仅能获取一次验证码，请稍后重试");
				$("#sendMobileCode").removeAttr("disabled");
			}else if(data == "-3") {
				window.location.href="/findPwd/getCodeCountOut.action";
			}else if(data == "lock"){
				window.location.href="/findPwd/lock.action";
			}else{
				alert("网络连接超时，请重新获取验证码");
				$("#sendMobileCode").removeAttr("disabled");
			}
		},
    	error : function() {
			alert("网络连接超时，请您稍后重试");
			$("#sendMobileCode").removeAttr("disabled");
    	}
	});
}

function sendFindPwdHistoryCode(k){
	if($("#sendMobileCode").attr("disabled")) {
		return;
	}
	
	if(!checkHistoryMobile()){
		return;
	}
	
	$("#sendMobileCode").attr("disabled","disabled");
	jQuery.ajax({
		type : "get",
		url : "/findPwd/getHistoryCode.action?k="+k+"&mobile="+$("#mobile").val(),
		success : function(data) {
			if(data == "1") {
				$("#ftx-01").text(119);
				$("#sendMobileCodeDiv").hide();
				$("#timeDiv").show();
				setTimeout(countDown, 1000);
				$("#code").removeAttr("disabled");
				$("#submitCode").removeAttr("disabled");
			}else if(data == "-6"){
				$("#mobile").removeClass().addClass("text text-1 text-mar highlight2");
				$("#mobile_error").removeClass().addClass("msg-error").html("未在历史订单中查到该号码，或该号码是小额虚拟订单号码。请重新输入");
				$("#sendMobileCode").removeAttr("disabled");
			}else if(data == "-2") {
				alert("120秒内仅能获取一次验证码，请稍后重试");
				$("#sendMobileCode").removeAttr("disabled");
			}else if(data == "-3") {
				window.location.href="/findPwd/getCodeCountOut.action";
			}else if(data == "lock"){
				window.location.href="/findPwd/lock.action";
			}else if(data.status == "mobileFailure"){
				$("#mobile").removeClass().addClass("text text-1 text-mar highlight2");
				$("#mobile_error").removeClass().addClass("msg-error").html("手机号格式错误，请重新输入");
				$("#sendMobileCode").removeAttr("disabled");
			}else if(data == "unpass") {
				alert("请通过其他已验证类型进行身份验证");
				window.location.href="/findPwd/index.action";
			}else{
				alert("网络连接超时，请重新获取验证码");
				$("#sendMobileCode").removeAttr("disabled");
			}
		},
    	error : function() {
			alert("网络连接超时，请您稍后重试");
			$("#sendMobileCode").removeAttr("disabled");
    	}
	});
}

function sendFindPwdEmail(k){
	if($("#sendMail").attr("disabled")) {
		return;
	}
	$("#sendMail").attr("disabled","disabled");
	jQuery.ajax({
    	type : "post",
    	url : "../supplier/sendMail?uid="+k,
    	dataType:"html",
    	success : function(data) {
    		if(data == "1"){
    			window.location.href="../supplier/sendMailSuccess?uid="+k;
    		}else{
    			alert("Network connection timeout, please try again later");
    			window.location.href="../supplier/findPwd";
    		}
    	},
    	error : function() {
			alert("Network connection timeout, please try again later");
			window.location.href="../supplier/findPwd";
			//$("#sendMail").removeAttr("disabled");
    	}
    });
}

function doIndex(uuid){
	if($("#findPwdSubmit").attr("disabled")) {
		return;
	}
	if(!checkUsername()){
		return;
	}
	if(!checkAuthCode()){
		return;
	}
	$("#findPwdSubmit").attr("disabled","disabled");
	var authCode = $("#authCode").val();
	var username = $("#username").val();
	jQuery.ajax({
		type : "get",
		dataType: "json",
		url : "/findPwd/doIndex.action",
		data : "&uuid="+uuid+"&authCode="+authCode+"&username="+escape(username),
		success : function(data) {
			if(data && data.result == "ok"){
				window.location.href="/findPwd/findPwd.action?k="+data.k;
			}else if(data && data.result == "choose"){
				window.location.href="/findPwd/choose.action?k="+data.k;
			}else if(data && data.result == "authCodeFailure"){
				$("#authCode").removeClass().addClass("text text-1 highlight2");
				$("#authCode_error").removeClass().addClass("msg-error").html("验证码错误");
				$("#findPwdSubmit").removeAttr("disabled");
				vercAcid(uuid);
			}else if(data && data.result == "none"){
				$("#username").removeClass().addClass("text highlight2");

				$("#username_error").removeClass().addClass("msg-error").html("您输入的账户名不存在，请核对后重新输入。");
				$("#findPwdSubmit").removeAttr("disabled");
				vercAcid(uuid);
			}else if(data && data.result == "needUsername"){
				window.location.href="/findPwd/inputUsername.action?email="+username;
			}else if(data && data.result == "usernameFailure"){
				$("#username").removeClass().addClass("text highlight2");
				$("#username_error").removeClass().addClass("msg-error").html("请输入用户名");
				$("#findPwdSubmit").removeAttr("disabled");
				vercAcid(uuid);
			}else{
				alert("网络连接超时，请重新修改登录密码");
				$("#findPwdSubmit").removeAttr("disabled");
				vercAcid(uuid);
			}
		},
    	error : function() {
			alert("网络连接超时，请您稍后重试");
			$("#findPwdSubmit").removeAttr("disabled");
			vercAcid(uuid);
    	}
	});
}

function checkEmailOnly(email){
	
	if($("alreadyCheck").val() == "1"){
		if($("needUsername").val() == "1"){
			$('#usernameDiv').show();
		}
		return;
	}
	
	jQuery.ajax({
		type : "get",
		url : "/findPwd/checkEmailOnly.action?email="+email,
		success : function(data) {
			if(data == "only"){
				$("#needUsername").val("0");
				$("#alreadyCheck").val("1");
				$('#usernameDiv').hide();
			}else if(data == "notOnly"){
				$("#needUsername").val("1");
				$("#alreadyCheck").val("1");
				$('#usernameDiv').show();
			}else if(data == "none"){
				window.location.href = "/findPwd/index.action";
			}else{
				$("#usernameRadio").attr("checked","checked");
			}
		},
    	error : function() {
			$("#usernameRadio").attr("checked","checked");
    	}
	});
}

function doChoose(k){
	if($("#chooseSubmit").attr("disabled")){
		return ;
	}
	
	if($("input:checked").val() == "email" && $("#needUsername").val() == "1" && !checkName()){
		return;
	}
	var username = $("#username").val();
	$("#chooseSubmit").attr("disabled","disabled");
	jQuery.ajax({
		type : "get",
		url : "/findPwd/doChoose.action?k="+k+"&type="+$("input:checked").val()+"&username="+escape(username),
		success : function(data) {
			if(data && data == "ok"){
				window.location.href = "/findPwd/findPwd.action?k="+k;
			}else if(data && data == "none"){
				window.location.href = "/findPwd/index.action";
			}else if(data && data == "notSame"){
				$("#username").removeClass().addClass("text highlight2");
				$("#username_error").removeClass().addClass("msg-error").html("邮箱与用户名不匹配，请重新输入");
				$("#chooseSubmit").removeAttr("disabled");
			}else if(data && data == "usernameError"){
				$("#username").removeClass().addClass("text highlight2");
				$("#username_error").removeClass().addClass("msg-error").html("邮箱与用户名不匹配，请重新输入");
				$("#chooseSubmit").removeAttr("disabled");
			}else if(data && data == "emailInfoError"){
				window.location.href = "/findPwd/index.action";
			}else{
				alert("网络连接超时，请重试");
				$("#chooseSubmit").removeAttr("disabled");
			}
		},
    	error : function() {
			alert("网络连接超时，请重试");
			$("#chooseSubmit").removeAttr("disabled");
    	}
	});
}

function validFindPwdCode(k){
	if($("#submitCode").attr("disabled")){
		return ;
	}
	var code = $("#code").val();
	if(!checkCode()){
		return ;
	}
	$("#submitCode").attr("disabled","disabled");
	jQuery.ajax({
		type : "get",
		dataType: "json",
		url : "/findPwd/validFindPwdCode.action?code="+code+"&k="+k,
		success : function(data) {
			if(data && data.result == "ok"){
				window.location.href = "/findPwd/resetPassword.action?key="+data.key;
			}else if(data && data.result == "codeFailure"){
				$("#code").removeClass().addClass("text text-1 highlight2");
				$("#code_error").removeClass().addClass("msg-error").html("Verification code error");
				$("#submitCode").removeAttr("disabled");
			}else if(data && data.result == "visitLock"){
				$("#code").removeClass().addClass("text text-1 highlight2");
				$("#code_error").removeClass().addClass("msg-error").html("Verification code error");
				$("#submitCode").removeAttr("disabled");
			}else if(data && data.result == "lock"){
				window.location.href = "/findPwd/lock.action";
			}else{
				alert("Network connection timeout, please try again later");
				$("#submitCode").removeAttr("disabled");
			}
		},
    	error : function() {
			alert("Network connection timeout, please try again later");
			$("#submitCode").removeAttr("disabled");
    	}
	});
}

function validFindPwdHistoryCode(k){
	if($("#submitCode").attr("disabled")){
		return ;
	}
	var code = $("#code").val();
	if(!checkCode()){
		return ;
	}
	$("#submitCode").attr("disabled","disabled");
	jQuery.ajax({
		type : "get",
		dataType: "json",
		url : "/findPwd/validFindPwdHistoryCode.action?code="+code+"&k="+k,
		success : function(data) {
			if(data && data.result == "ok"){
				window.location.href = "/findPwd/resetPassword.action?key="+data.key;
			}else if(data && data.result == "timeOut"){
				window.location.href = "/findPwd/index.action";
			}else if(data && data.result == "codeFailure"){
				$("#code").removeClass().addClass("text text-1 highlight2");
				$("#code_error").removeClass().addClass("msg-error").html("验证码错误");
				$("#submitCode").removeAttr("disabled");
			}else if(data && data.result == "visitLock"){
				$("#code").removeClass().addClass("text text-1 highlight2");
				$("#code_error").removeClass().addClass("msg-error").html("验证码错误");
				$("#submitCode").removeAttr("disabled");
			}else if(data && data.result == "lock"){
				window.location.href = "/findPwd/lock.action";
			}else{
				alert("网络连接超时，请您稍后重试");
				$("#submitCode").removeAttr("disabled");
			}
		},
    	error : function() {
			alert("网络连接超时，请您稍后重试");
			$("#submitCode").removeAttr("disabled");
    	}
	});
}

function checkCode(){
	var code = $("#code").val();
	if(!code){
		$("#code_error").removeClass().addClass("msg-error").html("Please enter the verification code");
		return false;
	}
	$("#code_error").removeClass().html("");
	return true;
}

function checkAuthCode(){
	var authCode = $("#authCode").val();
	if(!authCode){
		$("#authCode").removeClass().addClass("text text-1 highlight2");
		$("#authCode_error").removeClass().addClass("msg-error").html("Please enter the verification code");
		return false;
	}
	$("#authCode").removeClass().addClass("text text-1");
	$("#authCode_error").removeClass().html("");
	return true;
}

function countDown(){
	var time = $("#ftx-01").text();
	$("#ftx-01").text(time - 1);
	if (time == 1) {
		$("#sendMobileCode").removeAttr("disabled");
		$("#timeDiv").hide();
		$("#sendMobileCodeDiv").show();
		$("#send_text").hide();
	} else {
		setTimeout(countDown, 1000);
	}
}

function verc(uuid){
	$("#authCode").val("");
	$("#authCode").focus();
	$("#JD_Verification1").attr("src","http://verify.jd.com/verify/image?uuid="+uuid+"&yys="+new Date().getTime());
}


function vercAcid(uuid){
	$("#authCode").val("");
	$("#authCode").focus();
	$("#JD_Verification1").attr("src","http://captcha.jd.com/verify/image?acid="+uuid+"&yys="+new Date().getTime());
}