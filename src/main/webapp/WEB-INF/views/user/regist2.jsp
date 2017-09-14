<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%  
    String path = request.getContextPath();
	request.setAttribute("path",path);
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><spring:message code="registTitle" /></title>
    <link type="text/css" rel="stylesheet" href="${path}/css/regist.css"/>
    <link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />
    <link rel="shortcut icon" href="${path}/images/favicon1.ico" />
    <script type="text/javascript" src="${path}/js/commons/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>
    <style type="text/css">
		body{
		    color: #333333;
		    font-family: Arial,"宋体",Lucida,Verdana,Helvetica,sans-serif;
		    font-size: 12px;
		    line-height: 150%;
		    background: none repeat scroll 0 0 #F2F2F2;
		    margin: 0;
		}
    </style>
     <script type="text/javascript" >
     
   
     
     function checkName(){
    	 if($.trim($("#regName").val())==""||$.trim($("#regName").val())==undefined){
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
   
   
    
     
     function checkName1(){
    	 if($.trim($("#companyname").val())==""||$.trim($("#companyname").val())==undefined){
    		 return ;
    	 }
         var url='${path}/user/isPinName';
    	 var data="stringName="+$("#companyname").val();
    	 $.ajax({
	         type: "POST",
	         dataType:"html",
	         url: url,
	         data: data,
	         success: function (result) {
	        	 if(result>0){
	        		// $("#realname_error").removeClass("hide");
	        		 //$("#realname_error").addClass("error"); 
	        		 $("#company_error").show();
	        	 }else{
	        		 $("#company_error").hide();
	        	 }
	         }
	     });
     
     }
     $(function(){
     	var mess= $("#message").val();
     	if(mess.length>0){
     		alert(mess);
     	}
     })
     
     </script>
  
</head>
<body>
    <div id="shortcut-2013">
    <div class="w">
                <ul class="fr lh">
                    <li id="loginbar" class="fore1" clstag="homepage|keycount|home2013|01b">
                     <%-- <a  href="${path}/supplier/registUI?locale=zh_CN">中文 &nbsp; </a>
		              <a href="${path}/supplier/registUI?locale=en">English&nbsp;  </a>   --%>
                    <spring:message code="welcome" />
                    <span>
                   
                    </span>
                    </li>
                </ul>
            </div>
        </div>
<div class="w">
    <div id="logo"><a href="${path}/user/loginUI" clstag="passport|keycount|login|01">
    <img src="${path}/images/login-logo-sm.png" alt="<spring:message code="logo" />" width="170"
                                                     height="60"/></a>
     <b style="background: url('${path}/images/regist-wel-<spring:message code="language" />.png') no-repeat scroll 0 0  !important;"></b></div>
</div>


<div class="w" id="regist">
    <div class="mt">
        <div class="extra">
        <span style="text-align: right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <span> </span>
        </div>
    </div>

    <div class="mc">

        <form id="formcompany"  method="post" action="${path}/supplier/regist2"  >
           <input id="language" type="hidden" name="language" value="<spring:message code="language" />"  />
           <input type="hidden" name="status" value="0" />
           <input type="hidden" name="userId" value="${userid}" />
           <input type="hidden" id="message" name="message" value="${message}" />
            <!-- <div class=" w1" id="entry">
                <div class="mc " id="bgDiv"> -->
                    <div class="form ">
                        
                     
                        <div class="item" id="select-regName">
                            <span class="label"><b class="ftx04">*</b>家庭号名称：</span>
                            <div class="f1 item-ifo">
                            <c:out value="${name}"></c:out>
                                <input type="text" id="companyname" name="companyName" onblur="checkName1();" value="<c:out value='${name}'></c:out>" class="text" 
                                       autocomplete="off"  tabindex="1"/>
                                <label id="company_error" class="error" style="display: none"> <spring:message code="user.comNameRegisted" /></label>
                                <label id="companyname_succeed" class="blank"></label>
                                <label id="companyname_error"></label>
                            </div>
                        </div>
 						    
				    	<div class="item"  style="height: 80px;display:none;" id="">
				    	<span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyNature" />：</span>
							<div class="item-ifo" >
								<%--<div class="nature">
									
							<!-- 		<input type="text" id="companytype" name="companyNature" class="text" tabindex="2"/> -->
									<input type="checkbox" name="companytype"  value="1" tabindex="2"  class="checkbox" />
									<label></label>
									
									<input type="checkbox" name="companytype" value="2" tabindex="3" class="checkbox" />
									<label><spring:message code="supplier.companyType2" /></label>
									</br>
									<input type="checkbox" name="companytype" value="5" tabindex="3" class="checkbox" />
									<label><spring:message code="supplier.companyType5" /></label>
									
									<input type="checkbox" name="companytype" value="3" tabindex="3" class="checkbox" />
									<label><spring:message code="supplier.companyType3" /></label>
									
									
									<input id="companytype"  name="companyNature"  type="hidden" value="" sta="0">
										
								</div>
		                              --%>
		                              <select  id="companytype" name ="companyNature"   rel="select"  tabindex="3">
									      <%-- <option value="-1" selected="selected"><spring:message code="supplier.pleaseSelect" /></option> --%>
									      <option  value="1" ><spring:message code="supplier.companyType1" /></option>
								          <option  value="2" selected="selected"><spring:message code="supplier.companyType2" /></option>
							              <option  value="5" ><spring:message code="supplier.companyType5" /></option>
							              <option  value="3" ><spring:message code="supplier.companyType3" /></option>
									  </select>
		                              <label id="companytype_succeed" class="blank"></label>
		                              <label id="companytype_error"></label>
                            </div>
                        </div>
                        <div class="item"  style="height: 80px;display:none;" id="">
                        <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyType" />：</span>
                        	<div class="item-ifo" >
                        		<select  id="supplyType" name ="supplyType"   rel="select" >
								          <option  value="51" selected="selected"><spring:message code="supplier.supplyType" /></option>
								</select>
                        	</div>
                        </div>
                        <%-- <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyArea" />：</span>
                            <div class="item-ifo">
                                
                             <!--   <input type="text" id="companyarea" name="countryArea" class="text" tabindex="3"/>   --> 
                             
                              <select  id="companyarea" name ="countryArea"   rel="select"  tabindex="4">
							    <option value="-1" selected="selected"><spring:message code="supplier.pleaseSelect" /></option>
							      <c:forEach items="${country}" varStatus="status" var="coun">
							         <option id="${coun}" value="${coun}" code="${callingCode[status.index]}" <c:if test="${fn:containsIgnoreCase(coun, '中国')}">selected="selected"</c:if> >${coun}</option>
							    </c:forEach>
							  </select>
                                <label id="companyarea_succeed" class="blank"></label>
                                <label id="companyarea_error"></label>
            
                            </div>
                        </div> --%>
                       <%--  <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companySimpleName" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="nameJC" name="nameJC" class="text"  tabindex="5" />
                                
                                <label class="blank" id="nameJC_succeed"></label>
                                <label id="nameJC_error"></label>
                         
                            </div>
                        </div> --%>
<!--                         <div class="item" id=""> -->
<%--                             <span class="label"><b class="ftx04">*</b><spring:message code="supplier.supplierCode" />：</span> --%>
<!--                             <div class="item-ifo"> -->
<!--                                 <input type="text" id="supplierCode" name="supplierCode" class="text"  tabindex="5" /> -->
                                
<!--                                 <label class="blank" id="supplierCode_succeed"></label> -->
<!--                                 <label id="supplierCode_error"></label> -->
                         
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="item" id=""> -->
<%--                             <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyType" />：</span> --%>
<!--                             <div class="item-ifo" > -->
<!-- 	                              <select  id="type" name ="type"   rel="select"  tabindex="3"> -->
<%-- 								      <option  value="0" selected="selected"><spring:message code="supplier.qyCompany" /></option> --%>
<%-- 							          <option  value="1" ><spring:message code="supplier.companyChild" /></option> --%>
<%-- 						              <option  value="2" ><spring:message code="supplier.companyLS" /></option> --%>
<!-- 								  </select> -->
<!-- 	                              <label id="type_succeed" class="blank"></label> -->
<!-- 	                              <label id="type_error"></label> -->
<!--                             </div> -->
<!--                         </div> -->
                        <%-- <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyLevel" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="companyLevel" name="companyLevel" class="text"  tabindex="5" />
                                
                                <label class="blank" id="companyLevel_succeed"></label>
                                <label id="companyLevel_error"></label>
                         
                            </div>
                        </div> --%>
<!--                         <div class="item"  style="height: 60px;display:;" id=""> -->
<%-- 				    	<span class="label"><b class="ftx04">*</b><spring:message code="supplier.companySettledArea" />：</span> --%>
<!-- 							<div class="item-ifo" > -->
<!-- 	                              <select  id="companyRegion" name ="companyRegion"   rel="select"  tabindex="3"> -->
<%-- 								      <option  value="1" selected="selected"><spring:message code="supplier.companySettledArea1" /></option> --%>
<%-- 							          <option  value="2" ><spring:message code="supplier.companySettledArea2" /></option> --%>
<%-- 						              <option  value="3" ><spring:message code="supplier.companySettledArea3" /></option> --%>
<%-- 						              <option  value="4" ><spring:message code="supplier.companySettledArea4" /></option> --%>
<!-- 								  </select> -->
<!-- 	                              <label id="companyRegion_succeed" class="blank"></label> -->
<!-- 	                              <label id="companyRegion_error"></label> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         	平台折扣去掉 -->
<!--                         <div class="item" id=""> -->
<%--                             <span class="label"><b class="ftx04">*</b><spring:message code="supplier.platformDiscount" />：</span> --%>
<!--                             <div class="item-ifo"> -->
<!--                                 <input type="text" id="platformDiscount" name="platformDiscount" class="text"  tabindex="5" /> -->
                                
<!--                                 <label class="blank" id="platformDiscount_succeed"></label> -->
<!--                                 <label id="platformDiscount_error"></label> -->
                         
<!--                             </div> -->
<!--                         </div> -->
                        <%-- <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.businessManager" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="manager" name="manager" class="text"  tabindex="5" />
                                
                                <label class="blank" id="manager_succeed"></label>
                                <label id="manager_error"></label>
                         
                            </div>
                        </div> --%>
                        <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b>客服电话：</span>
                            <div class="item-ifo">
                                <input type="text" id="managerTel" name="kfTel" class="text"  tabindex="5" />
                                
                                <label class="blank" id="managerTel_succeed"></label>
                                <label id="managerTel_error"></label>
                         
                            </div>
                        </div>
                       <%--  <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.customerServerTele" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="kfTel" name="kfTel" class="text"  tabindex="5" />
                                
                                <label class="blank" id="kfTel_succeed"></label>
                                <label id="kfTel_error"></label>
                         
                            </div>
                        </div> --%>
                        
                        <%-- <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyAddress" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="companyaddr" name="address" class="text"  tabindex="5" />
                                
                                <label class="blank" id="companyaddr_succeed"></label>
                                <label id="companyaddr_error"></label>
                         
                            </div>
                        </div> --%>
                         <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b>真实姓名：</span>
                            <div class="item-ifo">
                                <input type="text" id="contactname" name="contact" class="text"  tabindex="6"/>
                                <label id="contactname_succeed" class="blank"></label>
                                <label id="contactname_error"></label>                     
                            </div>
                        </div>
                      

                        <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyMail" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="mailbox" name="email" class="text"  tabindex="8"/>
                                <label id="mailbox_succeed" class="blank"></label>
                                <label id="mailbox_error"></label>
                               
                            </div>
                        </div>
                        
                       <%--  <div class="item" id="">
                            <span class="label"><spring:message code="supplier.companyTelOrFax" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="contacttele" name="fax" class="text"  autocomplete="off"  tabindex="9"/>
                                <label id="contacttele_succeed" class="blank"></label>
                                <label id="contacttele_error"></label>
                            </div>
                        </div> --%>
                        <%-- <div class="item" id="">
                            <span class="label"><spring:message code="supplier.companyPostcode" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="postalcode" name="post" class="text"  autocomplete="off"  tabindex="10"/>
                                <label id="postalcode_succeed" class="blank"></label>
                                <label id="postalcode_error"></label>
                            </div>
                        </div> --%>
                        <%-- <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier" />：</span>
                            <div class="item-ifo">
                                <textarea style="outline:none;resize:none;" rows="6" cols="35" name="companyInfo" ></textarea>
                                <label class="blank" id="companyInfo_succeed"></label>
                                <label id="companyInfo_error"></label>
                         
                            </div>
                        </div></br></br></br>
                       <div class="item"  style="height: 80px;display:none;" id=""></div>
                        <div class="item" id="" >
                        <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyFile" />：</span>
                        <div class="item-ifo" style="width:320px;">
                            <input id="textfield" class="text" type="text" name="textfield" readonly="readonly" tabindex="11">
                                <span id="filespan">
                                <label for="fileField"  onClick="document.getElementById('textfield').focus();" >
                                    <input id="fileField" class="file" type="file" onchange="document.getElementById('textfield').value=this.value;"  tabindex="-1"   size="28" name="myfile" >
                                    <input class="btn" type="button" value="<spring:message code="upload" />" tabindex="12"   >
                                </label>
                               </span>
                            <label id="fileField_succeed" class="blank"></label>
                            <label id="fileField_error"></label></br>
                            <!--  <span style="color:#c7c7c7; line-height:24px;">上传图片格式为jpg、png、jepg</span>     -->
                        </div>
                    </div>
            <div class="item" id="" >
                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyDetailFile" />：(<a href="${path}/modelFile/supplierInfo_20161103.docx"><span style="color:blue"><spring:message code="supplier.companyDetailFileTemplate" /></span></a> ) </span>
                            <div class="item-ifo" style="width:320px;">
                                <input id="textfield1" class="text" type="text" name="textfield" readonly="readonly"  tabindex="13">
                                <span id="filespan">
                                <label for="fileField1">
                                <input id="fileField1" class="file" type="file" onchange="document.getElementById('textfield1').value=this.value" size="28" name="myfile1">
                                <input class="btn" type="button" value="<spring:message code="upload" />"   tabindex="14" >
                                </label>
                               </span>
                                <label id="fileField1_succeed" class="blank"></label>
                                <label id="fileField1_error"></label><br>
                            </div>
                        </div>
                        <div class="item" id="" >
                            <span class="label"><spring:message code="supplier.companyLogo" />： </span>
                            <div class="item-ifo" style="width:320px;">
                                <input id="textfield2" class="text" type="text" name="textfield" readonly="readonly"  tabindex="13">
                                <span id="filespan">
                                <label for="fileField2">
                                <input id="fileField2" class="file" type="file" onchange="document.getElementById('textfield2').value=this.value" size="28" name="myfile2">
                                <input class="btn" type="button" value="<spring:message code="upload" />"   tabindex="14" >
                                </label>
                               </span>
                                <label id="fileField2_succeed" class="blank"></label>
                                <label id="fileField2_error"></label><br>
                            </div>
                        </div> --%>
                        
                       <%--  <h3><spring:message code="product" /></h3>
                        <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="product.categories" />：</span>
                            <div class="f1 item-ifo">
                          <!--     <input type="text" id="mer-cgr" name="categories" class="text"    tabindex="10"
                                       autocomplete="off"/>
                                <label id="mer-cgr_succeed" class="blank"></label>
                                <label id="mer-cgr_error"></label>  -->
                          <input id="mer-cgr"  name="categories1"  class="text"  rel="select" onclick="IndustrySelect()" readonly="readonly"  tabindex="15">
                          <input id="mercgr" type="hidden" name="categories" value="">
						  <input id="IndustryID" type="hidden" name="IndustryID" value="">
						  <label id="mer-cgr_succeed" class="blank"></label>
						  <label id="mer-cgr_error"></label>
                            </div>
                        </div>
                        <div class="item" id="">
                            <span class="label">
                            <spring:message code="product.brand" />：</span>
                            <div class="f1 item-ifo">
                                <input type="text" id="mer-brand" name="brand" class="text"   
                                       autocomplete="off"  tabindex="16" value=""/>
                                
                                <label id="mer-brand_succeed" class="blank"></label>
                                <label id="mer-brand_error"></label>
                            </div>
                           
                            </div> --%>
                     
                   <%--      <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="product.skuNum" />：</span>
                            <div class="f1 item-ifo">
                                <input type="text" id="skunum" name="skuNum" class="text"  autocomplete="off"  tabindex="15"/>
                                
                                <label id="skunum_succeed" class="blank"></label>
                                <label id="skunum_error"></label>
                            </div>
                            </div> --%>
                        <!-- 企业个人账号 start -->
                       <%--  <h3><spring:message code="company.account" /></h3>
                        <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="company.userName" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="userName" name="userName" class="text"  tabindex="6"/>
                                <label id="userName_succeed" class="blank"></label>
                                <label id="userName_error"></label>                     
                            </div>
                        </div>
                        <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="company.mobile" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="userMobile" name="userMobile" class="text"  tabindex="7"/>
                                <label id="userMobile_succeed" class="blank"></label>
                                <label id="userMobile_error"></label>
                            </div>
                        </div>
                        <div class="" id="" style="margin:0px 0px 10px 250px;">
                           <span id="userMobile_info" style="color: red;">请注意：手机号即为登录名、初始密码与商家后台密码一致，请注册成功后登录修改!</span>
                      	</div>
<!--                         <div class="item" id=""> -->
                            <span class="label"><b class="ftx04">*</b><spring:message code="company.accountName" />：</span>
<!--                             <div class="item-ifo"> -->
<!--                                 <input type="text" id="accountName" name="accountName" class="text"  tabindex="6"/> -->
<!--                                 <label id="accountName_succeed" class="blank"></label> -->
<!--                                 <label id="accountName_error"></label>                      -->
<!--                             </div> -->
<!--                         </div> -->
                        <div class="item" id="o-password2">
                            <div id="capslock2"><i></i><s></s><spring:message code="company.keyboardLock" /></div>
                            <span class="label"><b class="ftx04">*</b><spring:message code="company.hqqPayPW" />：</span>
                            <div class="item-ifo">
                                <input type="password" id="hqqPwd" name="hqqPwd"  class="text" autocomplete="off" onpaste="return  false"  tabindex="18"/>
                                <i class="i-pass"></i>
                                <label id="hqqPwd_succeed" class="blank"></label>
                                <label id="hqqPwd_error" class="hide"></label>
                                <span class="clr"></span>
                                </label>
                            </div>
                        </div> --%>
                         <div class="item" id="o-password2">
                            <div id="capslock2"><i></i><s></s><spring:message code="company.keyboardLock" /></div>
                            <span class="label"><b class="ftx04">*</b><spring:message code="company.hqqPayPW" />：</span>
                            <div class="item-ifo">
                                <input type="password" id="hqqPwd" name="hqqPwd"  class="text" autocomplete="off" onpaste="return  false"  tabindex="18"/>
                                <i class="i-pass"></i>
                                <label id="hqqPwd_succeed" class="blank"></label>
                                <label id="hqqPwd_error" class="hide"></label>
                                <span class="clr"></span>
                                </label>
                            </div>
                        </div>
                        <script type="text/javascript">
                            $('#hqqPwd')[0].onkeypress = function(event){
                                var e = event||window.event,
                                    $tip = $('#capslock2'),
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
                            <span class="label"><b class="ftx04">*</b><spring:message code="company.hqqPayPWRepeat" />：</span>
                            <div class="item-ifo">
                                <input type="password" id="hqqPwdRepeat" name="hqqPwdRepeat" class="text" autocomplete="off"  tabindex="19"/>
                                <i class="i-pass"></i>
                                <label id="hqqPwdRepeat_succeed" class="blank"></label>
                                <label id="hqqPwdRepeat_error"></label>
                            </div>
                        </div>
                     
                        <h3><spring:message code="user" /></h3>
                        <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="user.loginName" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="regName" name="loginName" class="text"  autocomplete="off" onblur="checkName();"  tabindex="17" />
                                
                                <i class="i-name"></i>
                                <label id="realname_error" class="error" style="display: none"> <spring:message code="user.loginNameRegisted" /></label>
                                <!-- <ul id="intelligent-regName" class="hide"></ul> -->
                                <label id="regName_succeed" class="blank"></label>
                                <label id="regName_error"></label>
                            </div>
                        </div>  
                        <div class="item" id="o-password">
                            <div id="capslock"><i></i><s></s><spring:message code="user.keyboardLock" /></div>
                            <span class="label"><b class="ftx04">*</b><spring:message code="user.password" />：</span>
                            <div class="item-ifo">
                                <input type="password" id="pwd" name="password"  class="text" autocomplete="off" onpaste="return  false"  tabindex="18"/>
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
                            <span class="label"><b class="ftx04">*</b><spring:message code="user.pwdRepeat" />：</span>
                            <div class="item-ifo">
                                <input type="password" id="pwdRepeat" name="pwdRepeat" class="text" autocomplete="off"  tabindex="19"/>
                                <i class="i-pass"></i>
                                <label id="pwdRepeat_succeed" class="blank"></label>
                                <label id="pwdRepeat_error"></label>
                            </div>
                        </div>
                          <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyPhone" />：</span>
                            <div class="item-ifo">
                                <input type="hidden" id="teleCode" name="phoneCode"  readonly="readonly"  class="text" style="width:30px;"/>
                                <input type="text" id="tele" name="phone11" class="text" style="width:135px;" tabindex="7" readonly="readonly" value="${moblie}"/>
                                <input type="hidden" id="tele2" name="phone" value="${moblie}"/>
                                <label id="tele_succeed" class="blank"></label>
                                <label id="tele_error"></label>
                               
                            </div>
                        </div>
                        
                        
                        
                    <%--     <div class="item" id="">
                            <span class="label"><spring:message code="supplier.sjSupplierCode" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="sjSupplierId" name="sjSupplierId" class="text"  autocomplete="off"  tabindex="19"/>
                                <label id="sjSupplierId_succeed" class="blank"></label>
                                <label id="sjSupplierId_error"></label>
                            </div>
                        </div>
                        <div class="" id="" style="margin:0px 0px 10px 250px;">
                             <span id="sjSupplierId_info" style=""></span>
                        </div> --%>
                    <%--     <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.refereeName" />：</span>
                            <div class="item-ifo">
                                <input type="text" id="userTj" name="userTj" class="text"  autocomplete="off"  tabindex="19"/>
<!--                                 <i class="i-pass"></i> -->
                                <label id="userTj_succeed" class="blank"></label>
                                <label id="userTj_error"></label>
                            </div>
                        </div> --%>
                        
                         <%--  
                         <div class="item" id="">
                            <span class="label"><b class="ftx04">*</b>验证码：</span>
	                         <div class="item-ifo">
	                                <input type="text" id="randomCode" name="randomCode" class="text"    tabindex="10"  autocomplete="off"/ onblur="checkRandomCode()">
	                                
	                                
	                                this.src='../verify/image?a=0&uid=de54c695-dff0-42ef-885a-7c20253b87ac&yys='+new Date().getTime()
	                                
	                                <img title="点击更换" onclick="javascript:refresh(this);" id = "img" src="${path}/supplier/validateCode&yys='+new Date().getTime()   "/>
	                                <img title="点击更换" onclick="this.src='../supplier/validateCode?Math.floor(Math.random()*100) ).fadeIn()'" id = "img" src="${path}/supplier/validateCode"/>
	                                
	                                 <a href="#"  onclick="javascript:refresh(document.getElementById('img'));"">看不清?换一张</a>  
	                                <label id="randomCode_succeed" class="blank"></label>
	                                <label id="randomCode_error"></label>
	                            </div>
                        </div>
                         <br/>   --%>
                         
                           <div class="item form-group">
						   <span class="label"><b class="ftx04">*</b><spring:message code="login.randomCode" />：</span> 
						   <div class="item-ifo">
							   <input type="text" id="kaptcha" name="kaptcha" maxlength="4" class="text form-control"  tabindex="20" onfocus="del()"/ >
							   <input type="hidden" name="uid" id="uid"  value="${uid}" />
							   <i class="i-pass"></i>
	                            <label id="kaptcha_succeed" class="blank"></label>
	                           <label id="kaptcha_error" class="hide"></label>
	                           <label style="color:red" id="kaptcha_error1" ></label>
                           </div>
						   <div class="yzm-bar"> 
						   <img src="${path}/supplier/validateCode?uid=${uid}" id="kaptchaImage" />       
						   <a href="javascript:;" onclick="changeCode()"><spring:message code="login.codenewone"  /></a>
					   </div>  
		    		</div> 
		    		 <div class="item" id="">
		    		<!--  <span class="label"><input type="button" style="color:red;" onclick="getVerificationCode1()" id="codeLink" value="发送验证码"></span> -->
                           <span class="label" style="margin-left:150px;"><input type="text" class="text" id="verificationCode" name="verificationCode"  style="width:135px;" tabindex="7"></span>
                            <div class="item-ifo">
                                 <a href="javascript:void(0);" style="color:red;"  onclick="getVerificationCode1()" id="codeLink">请点此处发送验证码</a>
                            </div>
                            
                            <span class="error" id="verificationCodeError"></span>
                        </div>
                        
                     <div class="item" id="">
                           
                            
                             <span class="label" style="margin-left:205px;">同意<a href="http://www.3qianwan.com/view/special_family.html" target="_Blank">《用户注册协议》</a></span>
                             <div class="item-ifo">
                               <input type="checkbox" checked="checked" name="address"  id="agreement">
                               <span  id="agreementError"></span>
                            </div>
                            
                        </div>
                      
                        <div class="item">
                            <span class="label">&nbsp;</span>
                            <input type="button" class="btn-img btn-regist-<spring:message code="language" />" id="registsubmit"  tabindex="21" value="<spring:message code="registsubmit" />" >
                        	
                        </div>
                        <!-- <div class="item login-btn2013">
                            <span class="label"> </span>
                            <input type="button" class="btn-img btn-entry" id="registsubmit" value="注册" tabindex="8" clstag="passport|keycount|login|06"/>
                        </div> -->
                    </div>
               <!--  </div>
            </div> -->
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


  
  
<div class="w1">
    <div id="mb-bg" class="mb"></div>
</div>
<div class="w">
    <div id="footer-2013"><%--
        <div class="copyright">Copyright</div>
    --%></div>
</div>
    <script type="text/javascript" src="${path}/js/user/validateRegExp2.js"></script>
    <script type="text/javascript" src="${path}/js/user/validateprompt2.js"></script>
    <script  type="text/javascript" src="${path}/js/user/drag.js"></script> 
   
   
	<%-- <script  type="text/javascript" src="${path}/js/user/industry_arr.js"></script>  --%>
	<script type="text/javascript">
	
	
	$(function(){
		var phone= $('#tele').val();
		 var mphone = phone.substr(0, 3) + '****' + phone.substr(7);
		 $('#tele').val(mphone);
		
		
	})
	
	 var ind_a=${category};
	/*  var anArray=;
	 //var  anArray= ['one','two','three'];  
     $.each(anArray,function(n,value) {  
        alert(n+' '+value);  
        ind_a.push(value);
	});  
 */
	/*  for (var i = 0; i < array.length; i++) {
		 ind_a[array[i]]=array[i];
	} */
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
		}
	

	
	
	$(function(){  //生成验证码         
    $("#kaptchaImage").click(function () {  
    $(this).hide().attr("src", "${path}/supplier/validateCode?uid=${uid}&"+Math.random()*100 ).fadeIn(); });      
});   
/* window.onbeforeunload = function(){  
    //关闭窗口时自动退出  
    if(event.clientX>360&&event.clientY<0||event.altKey){     
        alert(parent.document.location);  
    }  
};    */       
function changeCode() {  //刷新
    $("#kaptchaImage").hide().attr("src", "${path}/supplier/validateCode?uid=${uid}&"+Math.random()*100).fadeIn();  
    event.cancelBubble=true;  
};


function del(){
	$("#kaptcha_error1").hide();
}

	</script> 
	<script type="text/javascript" src="${path}/js/user/industry_func.js"></script>
		 <!-- 底部 start -->
	<%@include file="/WEB-INF/views/zh/include/foot.jsp"%>
</body>
</html>


