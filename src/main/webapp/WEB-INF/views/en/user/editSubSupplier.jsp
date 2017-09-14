<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!doctype html>
	<head>
	  <title>Subsupplier</title>
      <%@include file="/WEB-INF/views/en/include/base.jsp"%>
	  <link rel="stylesheet" type="text/css" href="${path}/css/zh/user.css">
      <link rel="stylesheet" type="text/css" href="${path}/css/zh/juese.css">
      <link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />
      <link type="text/css" rel="stylesheet" href="${path}/css/subregist.css"/>
      <link rel="shortcut icon" href="${path}/images/favicon.ico" />
	  <style type="text/css">
		body{
		    font-family: Arial,"宋体",Lucida,Verdana,Helvetica,sans-serif;
		    font-size: 12px;
		    line-height: 100%;
		}
    </style>
     <script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>
     
	</head>
	<body>
        <%@include file="/WEB-INF/views/en/include/header.jsp"%>	
		<div class="wrap">
			<%@include file="/WEB-INF/views/en/include/leftUser.jsp" %>
			<div class="right f_l">
				<div class="title">
					<p class="c1">Edit Subsupplier </p>
					<div class="clear"></div>
				</div>
				<div class="blank5"></div>
				<div class="cont">
				<div class="w" id="regist">
				    <div class="mc">
				        <form id="formcompany"  method="post" action="${path}/subsupplier/update" enctype="multipart/form-data" >
				           <input id="language" type="hidden" name="language" value="en"  />
				           <input type="hidden" name="supplierId" value="${data.supplierId}"  />
				            <!-- <div class=" w1" id="entry">
				                <div class="mc " id="bgDiv"> -->
				                    <div class="form ">
				                        <h3>Company Information<span class="tishi-en">The filled content must be true and valid! Fields marked with * are mandatory</span></h3>
				                        
				                        <div class="item" id="select-regName">
				                            <span class="label"><b class="ftx04">*</b>Name：</span>
				                            <div class="f1 item-ifo">
				                                <input type="text" id="companyname" name="companyName" value="${fn:escapeXml(data.name)}" class="text"  <c:if test="${data.status==1 }"> disabled="disabled"</c:if>
				                                       autocomplete="off"  tabindex="1"/>
				                                <label id="companyname_succeed" class="blank"></label>
				                                <label id="companyname_error"></label>
				                            </div>
				                        </div>
				                                <input id="companytype"  name="companytype" type="hidden" value="1" sta="0">
				                        <input  name="companyNature" type="hidden" value="4" sta="0">
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b>Country/Region：</span>
				                            <div class="item-ifo">
				                              <select  id="companyarea" name ="countryArea"   rel="select"  tabindex="4">
											      <option value="-1" >Please Select</option>
											      <c:forEach items="${country}" varStatus="status" var="coun">
											         
											         <option id="${coun}" value="${coun}" <c:if test="${data.countryArea==coun }"> selected="selected"</c:if> code="${callingCode[status.index]}" >${coun}</option>
											    </c:forEach>
											  </select>
				                                <label id="companyarea_succeed" class="blank"></label>
				                                <label id="companyarea_error"></label>
				            
				                            </div>
				                        </div>
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b>Address：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="companyaddr" name="address" class="text"  tabindex="5" value="${fn:escapeXml(data.address)}" />
				                                
				                                <label class="blank" id="companyaddr_succeed"></label>
				                                <label id="companyaddr_error"></label>
				                         
				                            </div>
				                        </div>
				                         <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b>Contact：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="contactname" name="contact" class="text"  tabindex="6" value="${fn:escapeXml(data.contact)}"/>
				                                <label id="contactname_succeed" class="blank"></label>
				                                <label id="contactname_error"></label>                     
				                            </div>
				                        </div>
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b>Mobile Phone：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="teleCode" name="phoneCode"  readonly="readonly"  class="text" style="width:30px;" /> -
				                                <input type="text" id="tele" name="phone" class="text" style="width:135px;" tabindex="7" value="${fn:escapeXml(data.phone)}"/>
				                                <label id="tele_succeed" class="blank"></label>
				                                <label id="tele_error"></label>
				                               
				                            </div>
				                        </div>
				
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b>Email：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="mailbox" name="email" class="text"  tabindex="8" value="${fn:escapeXml(data.email)}"/>
				                                <label id="mailbox_succeed" class="blank"></label>
				                                <label id="mailbox_error"></label>
				                               
				                            </div>
				                        </div>
				                        
				                        <div class="item" id="">
				                            <span class="label">Tel：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="contacttele" name="fax" class="text"  autocomplete="off"  tabindex="9"  value="${fn:escapeXml(data.fax)}"/>
				                                <label id="contacttele_succeed" class="blank"></label>
				                                <label id="contacttele_error"></label>
				                            </div>
				                        </div>
				                        <div class="item" id="">
				                            <span class="label">Zip Code：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="postalcode" name="post" class="text"  autocomplete="off"  tabindex="10"  value="${fn:escapeXml(data.post)}" />
				                                <label id="postalcode_succeed" class="blank"></label>
				                                <label id="postalcode_error"></label>
				                            </div>
				                        </div>
				                        <div class="item" id="" >
				                            <span class="label"><b class="ftx04">*</b>Certificate：</span>
				                            <c:if test="${not empty data.companyLegitimacyUrl }">
												<div class="item-ifo" style="width:320px;">
												&nbsp;&nbsp;<a  href="${path}/supplier/download?url=${data.companyLegitimacyUrl}" target="downloadFileIframe"> Download</a>&nbsp;&nbsp;&nbsp;&nbsp;
										         <span id="filespan">
				                                <label for="fileField">
				                                 <input id="textfield" class="shorttext"  type="text" readonly="readonly" >
				                                <input id="fileField" class="file" type="file" onchange="document.getElementById('textfield').value=this.value" tabindex="-1"   size="28" name="myfile">
				                                <input class="btn" type="button" value="change"   tabindex="12" >
				                                </label>
				                               </span>
										        
										     <!--    <span id="filespan" class="divfile">
											       <input id="textfield" class="shorttext" type="text" readonly="readonly" >
												   <input id="fileField" class="file " type="file" onchange="document.getElementById('textfield').value=this.value" tabindex="-1"    size="28" name="myfile1" >
							                       <input class="btn" type="button"  value="change"   style="float: none;" tabindex="12"   >
					                      		 </span> -->
					                      		 <label id="fileField_succeed" class="blank" style="width: 205px; right: -210px; "></label>
					                             <label id="fileField_error" style="width: 205px; right: -210px;"></label></br>
					                      		</div>
									       </c:if>
									       <c:if test="${empty data.companyLegitimacyUrl }">
										        <div class="item-ifo" style="width:320px;">
					                                <input id="textfield" class="text" type="text" name="textfield" readonly="readonly" tabindex="11">
					                                <span id="filespan">
					                                <label for="fileField"  onClick="document.getElementById('textfield').focus();" >
						                                <input id="fileField" class="file" type="file" onchange="document.getElementById('textfield').value=this.value;"  value="${data.companyLegitimacyUrl}"   tabindex="-1"   size="28" name="myfile" >
						                                <input class="btn" type="button" value="upload" tabindex="12"   >
					                                </label>
					                               </span>
					                                <label id="fileField_succeed" class="blank" style="width: 205px; right: -210px; "></label>
					                                <label id="fileField_error" style="width: 205px; right: -210px;"></label></br>
					                               <!--  <span style="color:#c7c7c7; line-height:24px;">上传图片格式为jpg、png、jepg</span>     --> 
					                            </div>
									        </c:if>
				                            
				                            
				                            
				                          
				                        </div> 
				                         <div class="item" id="" >
				                            <span class="label">DetailFile：(<a href="${template_url}">DetailFileTemplate</a> ) </span>
				                          <c:if test="${not empty data.companyDetailedUrl }">
												<div class="item-ifo" style="width:320px;">
												&nbsp;&nbsp;<a  href="${path}/supplier/download?url=${data.companyDetailedUrl}" target="downloadFileIframe">DetailFile Download</a>&nbsp;&nbsp;&nbsp;&nbsp;
					                      		 <span id="filespan">
				                                <label for="fileField1">
				                                 <input id="textfield1" class="shorttext"  type="text" readonly="readonly" >
				                                <input id="fileField1" class="file" type="file" onchange="document.getElementById('textfield1').value=this.value" tabindex="-1"   size="28" name="myfile1">
				                                <input class="btn" type="button" value="change"   tabindex="14" >
				                                </label>
				                               </span>
					                      		<label id="fileField1_succeed" class="blank" style="width: 205px; right: -210px;"></label>
				                                <label id="fileField1_error" style="width: 205px; right: -210px;"></label><br>
					                      		</div>
									       </c:if>
									       <c:if test="${empty data.companyDetailedUrl }">
										        <div class="item-ifo" style="width:320px;">
				                                <input id="textfield1" class="text" type="text" name="textfield" readonly="readonly"  tabindex="13">
				                                <span id="filespan">
				                                <label for="fileField1">
				                                <input id="fileField1" class="file" type="file" onchange="document.getElementById('textfield1').value=this.value" tabindex="-1"   size="28" name="myfile1">
				                                <input class="btn" type="button" value="upload"   tabindex="14" >
				                                </label>
				                               </span>
				                                <label id="fileField1_succeed" class="blank" style="width: 205px; right: -210px;"></label>
				                                <label id="fileField1_error" style="width: 205px; right: -210px;"></label><br>
				                            </div>
									        </c:if>
				                        </div>
				                        <h3>Product Information</h3>
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b>Categories：</span>
				                            <div class="f1 item-ifo">
				                          <!--     <input type="text" id="mer-cgr" name="categories" class="text"    tabindex="10"
				                                       autocomplete="off"/>
				                                <label id="mer-cgr_succeed" class="blank"></label>
				                                <label id="mer-cgr_error"></label>  -->
				                          <input id="mer-cgr"  name="categories1"  class="text"  rel="select" onclick="IndustrySelect()" readonly="readonly"  tabindex="15">
				                          <input id="mercgr" type="hidden" name="categories" value="${fn:escapeXml(product.categories)}">
										  <input id="IndustryID" type="hidden" name="IndustryID" value="">
										  <label id="mer-cgr_succeed" class="blank"></label>
										  <label id="mer-cgr_error"></label>
				                            </div>
				                        </div>
				                      <!--   <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b>
				                            <spring:message code="product.brand" />：</span>
				                            <div class="f1 item-ifo">
				                                <input type="text" id="mer-brand" name="brand" class="text"   
				                                       autocomplete="off"  tabindex="16"/>
				                                <label id="mer-brand_succeed" class="blank"></label>
				                                <label id="mer-brand_error"></label>
				                            </div>
				                        </div> -->
				               
				                        <h3>User Information</h3>
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b>Login Name：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="regName" name="loginName" class="text"   <c:if test="${data.status==1 }"> disabled="disabled"</c:if> value="${fn:escapeXml(user.loginName)}" autocomplete="off" onblur="checkName();"  tabindex="17" />
				                                <input type="hidden" id="regNameOld" value="${fn:escapeXml(user.loginName)}" />
				                                <input type="hidden" name="userId" value="${fn:escapeXml(user.userId)}" />
				                                <i class="i-name"></i>
				                                <label id="realname_error" class="error" style="display: none"> <spring:message code="user.loginNameRegisted" /></label>
				                                <!-- <ul id="intelligent-regName" class="hide"></ul> -->
				                                <label id="regName_succeed" class="blank"></label>
				                                <label id="regName_error"></label>
				                            </div>
				                        </div>  
				                        <div class="item" id="o-password">
				                            <div id="capslock"><i></i><s></s><spring:message code="user.keyboardLock" /></div>
				                            <span class="label"><b class="ftx04">*</b>Password：</span>
				                            <div class="item-ifo">
				                                <input type="password" id="pwd" name="password"   class="text" autocomplete="off" onpaste="return  false"  tabindex="18"/>
				                                <!-- <label id="loginpwd_error" class="hide" >请输入您的密码</label>
				                                <label id="loginpwd_error1" class="hide" >密码字符长度不少于六位</label> -->
				                                <i class="i-pass"></i>
				                                <label id="pwd_succeed" class="blank"></label>
				                                <label id="pwd_error" class="hide"></label>
				                                <span class="clr"></span>
				                                <!-- <label id="pwdstrength" class="hide">
				                                <span class="fl">安全程度：</span>
				                                <b></b> -->
				                                </label>
				                            </div>
				                        </div>
				                            <script type="text/javascript">
				                                $('#pwd')[0].onkeypress = function(event){
				                                    var e = event||window.event,
				                                        $tip = $('#capslock'),
				                                            kc  =  e.keyCode||e.which, // 按键的keyCode
				                                            isShift  =  e.shiftKey ||(kc  ==   16 ) || false ; // shift键是否按住
				                                    if (((kc >=65&&kc<=90)&&!isShift)|| ((kc >=97&&kc<=122)&&isShift)){
				                                            $tip.show();
				                                    }
				                                    else{
				                                            $tip.hide();
				                                    }
				                                };
				                            </script>
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b>Re-enter Password：</span>
				                            <div class="item-ifo">
				                                <input type="password" id="pwdRepeat" name="pwdRepeat" class="text" autocomplete="off"  tabindex="19"/>
				                                <i class="i-pass"></i>
				                                <label id="pwdRepeat_succeed" class="blank"></label>
				                                <label id="pwdRepeat_error"></label>
				                            </div>
				                        </div>
				                      <br>
				                        <div class="item">
				                           <span class="label">&nbsp;</span>
				                           <div class="item-ifo">
				                            <input type="button" class="btn-img sub_btn" id="registsubmit"  tabindex="21" value="Edit" >
				                            <input type="button" class="btn-img sub_btn2" id="registcancel" onclick="javascript:history.go(-1)"  tabindex="22" value="GoBack" >
				                        </div>
				                    </div>
				            <div id="maskLayer" style="display: none;">
								<div id="alphadiv" style="filter:alpha(opacity=50);opacity:.5"></div>
								<div id="drag">
									<h4 id="drag_h"></h4>
									<div id="drag_con">
										<div id="jobAreaAlpha"> </div>
									</div>
								</div>
							</div>            
				        </form>
				    </div>
				</div>
			</div>
		</div>	
</body>
 <iframe name="downloadFileIframe" style="display:none"></iframe> 
<script type="text/javascript" src="${path}/js/user/validateRegExp.js"></script>
<script type="text/javascript" src="${path}/js/user/zh/validatepromptUp.js"></script>
<script  type="text/javascript" src="${path}/js/user/en/drag.js"></script> 
<script type="text/javascript" >

	$(document).ready(function(){
		var tele =$("#tele").val();
		if(''!=tele){
			var code=$("#companyarea  option:selected").attr("code");
			if(tele.indexOf(code)!=-1){
				$("#teleCode").val(code);
				$("#tele").val(tele.substr(code.length));
			};

		};
	});

    function checkName(){
    	 if($.trim($("#regName").val())==""||$.trim($("#regName").val())==undefined){
    		 return ;
    	 }
    	 if($.trim($("#regNameOld").val())==$.trim($("#regName").val())){
    		 return ;
    	 }
         var url='${path}/user/isPinEngaged';
    	 var data="pin="+$("#regName").val();
    	 $.ajax({
	         type: "POST",
	         dataType:"html",
	         url: url,
	         data: data,
	         success: function (result) {
	        	 if(result>0){
	        		// $("#realname_error").removeClass("hide");
	        		 //$("#realname_error").addClass("error"); 
	        		 $("#realname_error").show();
	        	 }else{
	        		 $("#realname_error").hide();
	        	 }
	         }
	     });
     }

	var category='${category}';
	var ind_a='';
	if(category.length>0){
		ind_a=${category};	
	}
	// 是否在数组内ind_a
		function in_array(needle, haystack) {
			if(typeof needle == 'string' || typeof needle == 'number') {
				for(var i in haystack) {
					if(haystack[i] == needle) {
							return true;
					}
				}
			}
			return false;
		};
		
</script> 
<script type="text/javascript" src="${path}/js/user/en/industry_func.js"></script>
<script type="text/javascript">
  showText();
</script> 
</html>