<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	  <title>Supplier-Profile Management</title>
	<%@include file="/WEB-INF/views/en/include/base.jsp"%>
      <link rel="stylesheet" type="text/css" href="${path}/css/en/jiben.css">
            <link rel="stylesheet" type="text/css" href="${path}/js/validation/validationEngine.jquery.css"/>
      <link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
	     input:focus{
			border:1px solid #09F;
			outline-style:none;
		}
		.input_warning{
			float:left;
		    font-family:Arial,"宋体",Lucida,Verdana,Helvetica,sans-serif;
			font-size:12px;
			padding-top:4px;
			padding-left:24px;
		}
		#thief_warning{
			height:12px;
		}
	    .divfile{
		   display: none;
		}
		.t2 {
		    border: 1px solid #c8c8c8;
		    float: left;
		    font-size: 12px;
		    height: 23px;
		    line-height: 23px;
		    margin-top: 2px;
		    margin-left: 8px;
		    padding: 0 5px;
		    width: 135px;
		}
		#filespan {margin:0;}
	</style>
	<script type="text/javascript">
	  var subUpdate =function(){
		if($('.fabu_btn').val()=="Submit") {	
			$("#submitButton").click();
		}else{
			$('.i1').removeAttr('disabled');
			$('.te').removeAttr('disabled');
			$('.div1').css('display','block');
			$('#name').attr("disabled","disabled"); 
			$('#companyNature').attr("disabled","disabled"); 
			$('#countryArea').attr("disabled","disabled"); 
			$('.divfile').css('display','inline');
			$('.fabu_btn').val("Submit");
		}
	}	
	</script>
    </head>
	<body>
<%@include file="/WEB-INF/views/en/include/header.jsp"%>
	 <div class="wrap">
		<%@include file="/WEB-INF/views/en/include/leftUser.jsp"%>
		<form  id="formID"  action="${path}/supplier/update" method="post" enctype="multipart/form-data">
		 <input id="language" type="hidden" name="language" value="${language}" />
		  <input type="hidden" name="token" value="${token}">
		<input class="i1" type="hidden" name ="supplierId" value="${data.supplierId}"/>
		<div class="right f_l">
			<div class="title">

				<p class="c1">Profile Management</p>
				<div class="clear"></div>
			</div>
			<div class="blank5"></div>
			<div class="cont">
				<ul class="ul_vertical">
					<li>
						<p class="p1">Photo：</p>
						<p class="i2">

						<c:if test="${!empty data.icon}">
							<img src="${data.icon}" alt="" width="100%"><p>
						</c:if>
						<p class="bt">
						    <div class="div1"  style="display: none;">
								<div class="div2">Upload</div>
								<input type="file" name="iconUrl"  class="inputstyle">
							</div>
						</p>
					</li>
					<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>Name：</p>
						<input class="i1"  id ="name" value="${fn:escapeXml(data.name)}" readonly="readonly"  />
					</li>
					   <li class="blank20"></li>
				      <li>
						<p class="p1"><b style=" color: #FF0000;">*</b>Type：</p>
						
   						 <c:if test="${data.companyNature eq 1}">
						 <input class="i1" id="companyNature" value="MANUFACTURER" readonly="readonly" />	
						</c:if>
						<c:if test="${data.companyNature eq 2}">
						 <input class="i1" id="companyNature" value="TRADERS" readonly="readonly" />	
						</c:if>
						<c:if test="${data.companyNature eq 3}">
						 <input class="i1" id="companyNature" value="DOMESTIC_DEALER" readonly="readonly" />	
						</c:if>
   					    <c:if test="${data.companyNature eq 5}">
						 <input class="i1" id="companyNature" value="MANUFACTURER&TRADERS" readonly="readonly" />	
						</c:if>
					</li>
					    <li class="blank20"></li>
				      <li>
						<p class="p1"><b style=" color: #FF0000;">*</b>Country/Region：</p>
						<input class="i1" id="countryArea" value="${fn:escapeXml(data.countryArea)}" readonly="readonly"  />		
					</li>
						<li class="blank20"></li>
				    <li>
						<p class="p1"><b style=" color: #FF0000;">*</b>Address：</p>
					    <input class="i1 validate[required ,minSize[1],maxSize[100]]" name="address" value="${fn:escapeXml(data.address)}"  /><%--
					    <i class="J_PopTip poptip-help" rel="tooltip" tip="">	</i>
					--%></li>
						<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>Contact：</p>
						<input class="i1 validate[required,minSize[1],maxSize[50]]" name ="contact" value="${fn:escapeXml(data.contact)}" />
						
					</li>
						<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>Mobile Phone：</p>
						<input class="i1 validate[required,custom[ccigphone]]" name ="phone" value="${fn:escapeXml(data.phone)}" />
					</li>
						<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>Email：</p>
					<input class="i1 validate[required,custom[email]]" name="email"  value="${fn:escapeXml(data.email)}"/>
					</li>
						<li class="blank20"></li>
					<li>
						<p class="p1">Tel：</p>
					<input class="i1 validate[custom[ccigphone]]" name ="fax" value="${fn:escapeXml(data.fax)}" />
					</li>
						<li class="blank20"></li>
					<li>
						<p class="p1">Zip Code：</p>
						<c:if test="${data.post==0}">
						 	<input class="i1 validate[custom[number],minSize[1],maxSize[10]]" name="post" />
						</c:if>
						<c:if test="${data.post!=0}">
					   		<input class="i1 validate[custom[number],minSize[1],maxSize[10]]" name="post" value="${fn:escapeXml(data.post)}"  />
					   	</c:if>
					</li>
					 <li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>Categories：</p>
						<input class="i1 validate[required,minSize[1],maxSize[100]]" id="mer-cgr"  name="categories1" onclick="IndustrySelect()" readonly="readonly"   />
						<input id="mercgr" class="validate[required]" type="hidden" name="categories" value="${fn:escapeXml(product.categories)}">
					</li>
					<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>Brand：</p>
						<input class="i1 validate[required,minSize[1],maxSize[100]]" id="mer-brand" name="brand" value="${fn:escapeXml(product.brand)}" />
					</li>
					<%--<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>SKU Amount：</p>
					    <input class="i1 validate[required,custom[number],minSize[1],maxSize[10]]" id="skunum" name="skuNum"  value="${fn:escapeXml(product.skuNum)}"/>
					</li>
					 --%><li class="blank20"></li>
					    <li>
							<p class="p1">Certificate：</p>
						    <c:if test="${not empty data.companyLegitimacyUrl }">
								<a  href="${path}/supplier/download?url=${data.companyLegitimacyUrl}" target="downloadFileIframe">Certificate Download&nbsp;&nbsp;&nbsp;&nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;
						    <span id="filespan" class="divfile">
						       <input id="textfield" class="t2 " type="text" readonly="readonly" >
						       
							   <input id="fileField" class="file " type="file" onchange="document.getElementById('textfield').value=this.value"  size="28" name="myfile" >
		                       <input class="btn" type="button"  value="Reset"   style="float: none;" tabindex="-1"   >
	                       </span>
					       </c:if>
					       <c:if test="${empty data.companyLegitimacyUrl }">
						         <span id="filespan" class="divfile">
						           <input id="textfield" class="t2 " type="text" readonly="readonly" >
								   <input id="fileField" class="file" type="file" onchange="document.getElementById('textfield').value=this.value"  size="28" name="myfile" >
			                       <input class="btn" type="button"  value="Upload"   style="float: none;" tabindex="-1"   >
			                      </span>
					        </c:if>
						</li>				
				    <li class="blank20"></li>
					    <li>
							<p class="p1">Other Details：</p>
						    <c:if test="${not empty data.companyDetailedUrl }">
								<a  href="${path}/supplier/download?url=${data.companyDetailedUrl}" target="downloadFileIframe">Other Details Download</a>&nbsp;&nbsp;&nbsp;&nbsp;
						    <span id="filespan" class="divfile">
						       <input id="textfield1" class="t2 " type="text" readonly="readonly" >
							   <input id="fileField" class="file " type="file" onchange="document.getElementById('textfield1').value=this.value"  size="28" name="myfile1" >
		                       <input class="btn" type="button"  value="Reset"   style="float: none;" tabindex="-1"   >
	                       </span>
					       </c:if>
					       <c:if test="${empty data.companyDetailedUrl }">
						         <span id="filespan" class="divfile">
						           <input id="textfield1" class="t2 " type="text" readonly="readonly" >
								   <input id="fileField" class="file" type="file" onchange="document.getElementById('textfield1').value=this.value"  size="28" name="myfile1" >
			                       <input class="btn" type="button"  value="Upload"   style="float: none;" tabindex="-1"   >
			                      </span>
					        </c:if>
						</li>
					<p class="blank30"></p>
				   	    <input type="button"  class="fabu_btn" onclick="subUpdate()" value="Edit" ></input>	 
				    <input id="submitButton" type="submit" style="display: none" ></input>	 
					<p class="blank30"></p>
			</div>
			 <div id="maskLayer" style="display: none;">
				<div id="alphadiv" style="opacity: 0.5;FILTER:ALPHA(opacity=50)"></div>
				<div id="drag">
					<h4 id="drag_h"></h4>
					<div id="drag_con">
						<div id="jobAreaAlpha"> </div>
					</div>
				</div>
			</div>
		</div>
		  </form>
		 
		<!-- 右边 end -->
	</div>
	
	 <iframe name="downloadFileIframe" style="display:none">
	     
	 </iframe> 
	<p class="blank30"></p>
		<!-- 底部 start -->
		 <script type="text/javascript" src="${path}/js/user/zh/jiben.js"></script>
		 <script  type="text/javascript" src="${path}/js/validation/jquery.validationEngine.min.js"></script> 
		 <script  type="text/javascript" src="${path}/js/validation/jquery.validationEngine-en.js"></script> 
		 <script  type="text/javascript" src="${path}/js/user/zh/drag.js"></script> 
	<%-- <script  type="text/javascript" src="${path}/js/user/industry_arr.js"></script>  --%>
	<script type="text/javascript">
	
	
	jQuery(document).ready(function(){
		  var message='${meaages}';
		  if(message!=''){
			  alert("Network connection timeout, please try again later");
		  }
		// binds form submission and fields to the validation engine
		/* jQuery("#formID").validationEngine('attach', {
				onValidationComplete: function(form, status){
					ajaxSubmit(form, status);
				} ,
				scroll: false,
				//binded: false,
				//showArrow: false,
				promptPosition: 'centerRight',
				maxErrorsPerField: 1,
				showOneMessage: true,
				addPromptClass: 'formError-noArrow formError-text'
			}); */
			 jQuery('#formID').validationEngine({ 
				scroll: false,
				//binded: false,
				//showArrow: false,
				promptPosition: 'centerRight',
				maxErrorsPerField: 1,
				showOneMessage: true,
				addPromptClass: 'formError-noArrow formError-text'
			});
			
		});
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
	  //categories根据Id显示文本框的值
	  showText();
	</script> 
	<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>
	<%@include file="/WEB-INF/views/en/include/last.jsp"%>
	<!-- 底部 end -->
     </body>
</html>