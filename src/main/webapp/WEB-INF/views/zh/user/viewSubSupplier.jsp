<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!doctype html>
	<head>
	  <title>子供应商管理</title>
      <%@include file="/WEB-INF/views/zh/include/base.jsp"%>
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
        <%@include file="/WEB-INF/views/zh/include/header.jsp"%>	
		<div class="wrap">
			<%@include file="/WEB-INF/views/zh/include/leftUser.jsp" %>
			<div class="right f_l">
				<div class="title">
					<p class="c1">查看-子供应商 </p>
					<div class="clear"></div>
				</div>
				<div class="blank5"></div>
				<div class="cont">
				<div class="w" id="regist">
				    <div class="mc">
				        <form id="formcompany"  method="post" action="${path}/subsupplier/update" enctype="multipart/form-data" >
				          <input id="language" type="hidden" name="language" value="<spring:message code="language" />"  />
				           <input type="hidden" name="supplierId" value="${data.supplierId}"  />
				            <!-- <div class=" w1" id="entry">
				                <div class="mc " id="bgDiv"> -->
				                    <div class="form ">
				                        <h3><spring:message code="supplier" /></h3>
				                        
				                        <div class="item" id="select-regName">
				                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyName" />：</span>
				                            <div class="f1 item-ifo">
				                                <input type="text" id="companyname" name="companyName" value="${fn:escapeXml(data.name)}" class="text" disabled="disabled"
				                                       autocomplete="off"  tabindex="1"/>
				                                <label id="companyname_succeed" class="blank"></label>
				                                <label id="companyname_error"></label>
				                            </div>
				                        </div>
				                        <input id="companytype"  name="companytype" type="hidden" value="2" sta="0">
				                        <input id="companytype"  name="companyNature" type="hidden" value="2" sta="0">
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyArea" />：</span>
				                            <div class="item-ifo">
											      <c:forEach items="${country}" varStatus="status" var="coun">
											         <c:if test="${data.countryArea==coun }"> 
											          <input type="text" id="companyarea" name="companyName"  code="${callingCode[status.index]}"  value="${fn:escapeXml(data.countryArea)}" class="text" disabled="disabled"
				                                       autocomplete="off"  tabindex="1"/>
											         </c:if>
											    </c:forEach>
				                                <label id="companyarea_succeed" class="blank"></label>
				                                <label id="companyarea_error"></label>
				            
				                            </div>
				                        </div>
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyAddress" />：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="companyaddr" name="address" class="text" disabled="disabled"  tabindex="5" value="${fn:escapeXml(data.address)}" />
				                                
				                                <label class="blank" id="companyaddr_succeed"></label>
				                                <label id="companyaddr_error"></label>
				                         
				                            </div>
				                        </div>
				                         <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyContact" />：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="contactname" name="contact" class="text" disabled="disabled"  tabindex="6" value="${fn:escapeXml(data.contact)}"/>
				                                <label id="contactname_succeed" class="blank"></label>
				                                <label id="contactname_error"></label>                     
				                            </div>
				                        </div>
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyPhone" />：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="tele" name="phone" class="text" disabled="disabled" tabindex="7" value="${fn:escapeXml(data.phone)}"/>
				                                <label id="tele_succeed" class="blank"></label>
				                                <label id="tele_error"></label>
				                               
				                            </div>
				                        </div>
				
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b><spring:message code="supplier.companyMail" />：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="mailbox" name="email" class="text"  disabled="disabled" tabindex="8" value="${fn:escapeXml(data.email)}"/>
				                                <label id="mailbox_succeed" class="blank"></label>
				                                <label id="mailbox_error"></label>
				                               
				                            </div>
				                        </div>
				                        
				                        <div class="item" id="">
				                            <span class="label"><spring:message code="supplier.companyTelOrFax" />：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="contacttele" name="fax" class="text"  disabled="disabled" autocomplete="off"  tabindex="9"  value="${fn:escapeXml(data.fax)}"/>
				                                <label id="contacttele_succeed" class="blank"></label>
				                                <label id="contacttele_error"></label>
				                            </div>
				                        </div>
				                        <div class="item" id="">
				                            <span class="label"><spring:message code="supplier.companyPostcode" />：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="postalcode" name="post" class="text" disabled="disabled"  autocomplete="off"  tabindex="10"  value="${fn:escapeXml(data.post)}" />
				                                <label id="postalcode_succeed" class="blank"></label>
				                                <label id="postalcode_error"></label>
				                            </div>
				                        </div>
				                        <div class="item" id="" >
				                            <span class="label"><b class="ftx04">*</b>企业合法证明文件：</span>
				                            <c:if test="${not empty data.companyLegitimacyUrl }">
												<div class="item-ifo" >
												<a  href="${path}/supplier/download?url=${data.companyLegitimacyUrl}" target="downloadFileIframe">证明文件下载</a>&nbsp;&nbsp;
					                      		</div>
									       </c:if>
									       <c:if test="${empty data.companyLegitimacyUrl }">
										        <div class="item-ifo" >
					                                <span style="color: red;">未上传</span>
					                                <label id="fileField_succeed" class="blank" style="width: 205px; right: -210px; "></label>
					                                <label id="fileField_error" style="width: 205px; right: -210px;"></label></br>
					                            </div>
									        </c:if>
				                            
				                            
				                            
				                          
				                        </div> 
				                         <div class="item" id="" >
				                            <span class="label"><spring:message code="supplier.companyDetailFile" />： </span>
				                          <c:if test="${not empty data.companyDetailedUrl }">
												<div class="item-ifo">
												<a  href="${path}/supplier/download?url=${data.companyDetailedUrl}" target="downloadFileIframe">详情文件下载</a>&nbsp;&nbsp;
					                      		</div>
									       </c:if>
									       <c:if test="${empty data.companyDetailedUrl }">
										        <div class="item-ifo">
				                                <span style="color: red;">未上传</span>
				                            </div>
									        </c:if>
				                        </div>
				                        <h3><spring:message code="product" /></h3>
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b><spring:message code="product.categories" />：</span>
				                            <div class="f1 item-ifo">
				                          <!--     <input type="text" id="mer-cgr" name="categories" class="text"    tabindex="10"
				                                       autocomplete="off"/>
				                                <label id="mer-cgr_succeed" class="blank"></label>
				                                <label id="mer-cgr_error"></label>  -->
				                          <input id="mer-cgr"  name="categories1"  class="text"  rel="select" onclick="IndustrySelect()"  disabled="disabled"  tabindex="15">
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
				                    <c:if test="${data.status==1}">
				                      <h3><spring:message code="user" /></h3>
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b><spring:message code="user.loginName" />：</span>
				                            <div class="item-ifo">
				                                <input type="text" id="regName" name="loginName" class="text"  disabled="disabled"  value="${fn:escapeXml(user.loginName)}" autocomplete="off" onblur="checkName();"  tabindex="17" />
				                                <input type="hidden" id="regNameOld" value="${fn:escapeXml(user.loginName)}" />
				                                <input type="hidden" name="userId" value="${fn:escapeXml(user.userId)}" />
				                                <i class="i-name"></i>
				                                <label id="realname_error" class="error" style="display: none"> <spring:message code="user.loginNameRegisted" /></label>
				                                <!-- <ul id="intelligent-regName" class="hide"></ul> -->
				                                <label id="regName_succeed" class="blank"></label>
				                                <label id="regName_error"></label>
				                            </div>
				                        </div>  
				                    </c:if>
				                    <c:if test="${data.status==2}">
				                      <h3>审核未通过</h3>
				                        <div class="item" id="">
				                            <span class="label"><b class="ftx04">*</b>未通过原因：</span>
				                            <div class="item-ifo">
				                               <textarea id="reason" rows="3" style="width: 300px;height: 80px;" disabled="disabled"  name="reason" >${fn:escapeXml(data.checkFailReason)}</textarea>
				                            </div>
				                        </div>  
				                          <br><br>  <br><br>  <br><br>
				                    </c:if>
				 
				                    
				                    <div class="item">
				                           <span class="label">&nbsp;</span>
				                           <div class="item-ifo">
				                            <input type="button" class="btn-img sub_btn2" id="registcancel" onclick="javascript:history.go(-1)"  tabindex="22" value="返回" >
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
<script  type="text/javascript" src="${path}/js/user/zh/drag.js"></script> 
<script type="text/javascript" >

	$(document).ready(function(){
		var tele =$("#tele").val();
		if(''!=tele){
			var code=$("#companyarea").attr("code");
			if(tele.indexOf(code)!=-1){
				$("#tele").val(code+" "+tele.substr(code.length));
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
<script type="text/javascript" src="${path}/js/user/zh/industry_func.js"></script>
<script type="text/javascript">
  showText();
</script> 
</html>