<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	  <title>商家后台管理系统-基本信息管理</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
     
      <link rel="stylesheet" type="text/css" href="${path}/css/zh/jiben.css"/>
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
		.divfile{
		   display: none;
		}
		#thief_warning{
			height:12px;
		}
	    .t2 {
		    border: 1px solid #c8c8c8;
		    float: left;
		    font-size: 12px;
		    height: 23px;
		    line-height: 23px;
		    margin-top: 2px;
		    margin-left: 20px;
		    padding: 0 5px;
		    width: 175px;
		}
		#filespan {margin:0;}
		
	</style>
	<script type="text/javascript">
	  var subUpdate =function(){
		  var activeStatus=$("#activeStatus").val().trim();

		if($('.fabu_btn').val()=="提交审核") {	
			
			var flag = checkInfo();
			if(flag == 2){
				$("#formID").submit();
			}else if(flag == 1){
				alert("有必填数据,请认真填写!");
			}else if(flag == 3){
				alert("没有做什么修改,请修改后再进行操作!");
			}
// 		 	if(formSubmit()){
// 				$("#formID").submit();
// 			}; 
// 			$("#submitButton").click();
		}else{
			if(activeStatus!=-1)
				{
				$('.i1').removeAttr('disabled');
				$('.te').removeAttr('disabled');
				$('.div1').css('display','block');
				$('#name').attr("disabled","disabled"); 
				$('#nameJC').attr("disabled","disabled"); 
				$('#supplierCode').attr("disabled","disabled"); 
				$('#type').attr("disabled","disabled"); 
				$('#companyQy').attr("disabled","disabled"); 
				$('#companyRegion').attr("disabled","disabled"); 
				$('#companyLevel').attr("disabled","disabled"); 
				$('#userTj').attr("disabled","disabled"); 
				$('#companyInfo').attr("disabled","disabled"); 
				$('#sjSupplierId').attr("disabled","disabled"); 
				$('#companyInfoBackup').attr("disabled","disabled"); 
				$('#userId1').attr("disabled","disabled");
				$('#userMobileId1').attr("disabled","disabled");
				$('#noPayhqqId').attr("disabled","disabled");
				$('#remainBalanceAmountId').attr("disabled","disabled");
				$('#checkFailReaId').attr("disabled","disabled");
				//$('#countryArea').attr("disabled","disabled"); 
				$('.divfile').css('display','inline');
				
				$('.fabu_btn').val("提交审核");
					}
			else{
				
				$('.i1').removeAttr('disabled');
				$('.te').removeAttr('disabled');
				$('.div1').css('display','block');
			 /* 	$('#name').attr("disabled","disabled");  */
			 	/* $('#nameJC').attr("disabled","disabled"); */ 
				$('#supplierCode').attr("disabled","disabled"); 
				/* $('#contactBackup').attr("disabled","disabled");  */
				 $('#type').attr("disabled","disabled"); 
				 $('#companyQy').attr("disabled","disabled");
				 $('#companyRegion').attr("disabled","disabled"); 
				 $('#companyLevel').attr("disabled","disabled");  
				$('#userTj').attr("disabled","disabled"); 
			/* 	$('#companyInfo').attr("disabled","disabled");  */
				$('#sjSupplierId').attr("disabled","disabled"); 
				/* $('#companyInfoBackup').attr("disabled","disabled");  */
				$('#userId1').attr("disabled","disabled");
				$('#userMobileId1').attr("disabled","disabled");
				$('#noPayhqqId').attr("disabled","disabled");
				$('#remainBalanceAmountId').attr("disabled","disabled");
				$('#checkFailReaId').attr("disabled","disabled"); 
				//$('#countryArea').attr("disabled","disabled"); 
				$('.divfile').css('display','inline');
				
				$('.fabu_btn').val("提交审核");
				
			}
			
		}
	};
	
	</script>
	<script type="text/javascript">
		function checkInfo(){
			
			var managerTelBackup = $("#managerTelBackup").val();
			var phoneBackup = $("#phoneBackup").val();
			var emailBackup = $("#emailBackup").val();
// 			var faxBackup = $("#faxBackup").val().trim();
// 			var postBackup = $("#postBackup").val().trim();
			/* var textfield2 = $("#textfield2").val().trim(); */
			if( managerTelBackup == "" ||  phoneBackup == "" || emailBackup == "" ){
				return 1;
			}else{
				return 2;
			}
			
			var managerTel = $("#managerTel").val();
			
			
			var email = $("#email").val();
			
			
		}
	</script>
	
<!-- 	  var ajaxSubmit=function(form,status){ -->
<!-- 		  if(status){ -->
<!-- 			  var data=$("#formID").serialize(); -->
<!-- 			  alert(data); -->
<!-- 			  $.ajax({ -->
<!-- 		   		     type: "POST", -->
<!-- 		   		     dataType:"html", -->
<%-- 		   		     url:"${path}/supplier/update?rd="+Math.random(),  --%>
<!-- 		   		     data:data, -->
<!-- 		   		     success : function(msg) { -->
<!-- 			   		     if(msg=="ok"){ -->
<%-- 			   		  	    window.location.href="${path}/supplier/jiben"; --%>
<!-- 			   		     }else{ -->
<!-- 			   		    	 alert("修改失败"); -->
<!-- 			   		     } -->
<!-- 		   			}, -->
<!-- 	  			});   -->
<!-- 		  } -->
<!-- 	  }; -->
	
    </head>
	<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp"%>
	 <div class="wrap">
		<%@include file="/WEB-INF/views/zh/include/leftUser.jsp"%>
		<form  id="formID"  action="${path}/supplier/update2" method="post" >
		 <input type="hidden" name="token" value="${token}">
		<input id="language" type="hidden" name="language" value="${language}" />
		<input class="i1" type="hidden" name ="supplierId" value="${data.supplierId}"/>
		<input type="hidden" id="activeStatus" name="activeStatus" value="${fn:escapeXml(data.activeStatus)}"/>
		<div class="right f_l">
			<div class="title">

				<p class="c1">基本信息管理</p>
				<div class="clear"></div>
			</div>
			<div class="blank5"></div>
			<div class="cont">
				<ul class="ul_vertical">
					<%-- <li>
						<p class="p1">当前头像：</p>
						<p class="i2">
						<c:if test="${!empty data.icon}">
							<img src="${data.icon}" alt="" width="100%"><p>
						</c:if>
						<p class="bt">
						    <div class="div1"  style="display: none;">
								<div class="div2">上传图像</div>
								<input type="file" name="iconUrl"  class="inputstyle ">
							</div>
						</p>
					</li> --%>
					<li class="blank20"></li>
					
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>家庭号名称：</p>
						<input class="i1" id ="name" name="name" value="${fn:escapeXml(data.name)}" />
						<input type="hidden" id="name1" name="name1" value="${fn:escapeXml(data.name)}"/>
					</li>
					
					
					<%-- <li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>企业编号：</p>
						<input type="hidden" id="supplierCode1" name="supplierCode" value="${fn:escapeXml(data.supplierCode)}"/>
						<c:if test="${ data.activeStatus ne -1}" >
							<input class="i1" id ="supplierCode" name="supplierCode" value="${fn:escapeXml(data.supplierCode)}" readonly="readonly" />
						</c:if>
						<c:if test="${ data.activeStatus eq -1}" >
							<input class="i1" id ="supplierCode" name="supplierCode" value="" readonly="readonly" />
						</c:if>
					</li> --%>
					<%-- <li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>未付红旗券总额：</p>
						<input class="i1" id ="noPayhqqId" name="noPayhqq" value="${fn:escapeXml(data.noPayhqq)}" readonly="readonly"/>
					</li>
					<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>剩余欠款额度：</p>
						<input class="i1" id ="remainBalanceAmountId" name="remainBalanceAmount" value="${fn:escapeXml(data.remainBalanceAmount)}" readonly="readonly"/>
					</li>
					<li class="blank20"></li>
					<li> --%>
						<%-- <p class="p1"><b style=" color: #FF0000;">*</b>企业类型：</p>
						<input type="hidden" id="type1" name="type" value="${fn:escapeXml(data.type)}"/>
						<c:choose>
							<c:when test="${data.type eq 0 }">
								<input class="i1" name= "type" id ="type" value="非自营企业"  />
							</c:when>
							<c:when test="${data.type eq 1 }">
								<input class="i1" name= "type" id ="type" value="子公司"  />
							</c:when>
							<c:when test="${data.type eq 2 }">
								<input class="i1" name= "type" id ="type" value="连锁企业"  />
							</c:when>
							<c:when test="${data.type eq 3 }">
								<input class="i1" name= "type" id ="type" value="连锁子公司"  />
							</c:when>
							<c:when test="${data.type eq 4 }">
								<input class="i1" name= "type" id ="type" value="自营企业"  />
							</c:when>
							<c:when test="${data.type eq 5 }">
								<input class="i1" name= "type" id ="type" value="项目产业"  />
							</c:when>
							<c:otherwise>
								<input class="i1" name= "type" id ="type" value=""  />
							</c:otherwise>
						</c:choose>
					</li>
					<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>企业评级：</p>
						<input class="i1" id ="companyLevel" name="companyLevel" value="${fn:escapeXml(data.companyLevel)}" />
						<input type="hidden" id="companyLevel1" name="companyLevel" value="${fn:escapeXml(data.companyLevel)}"/>
					</li>
					<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>入驻区域类型：</p>
						<input type="hidden" id="companyRegion1" name="companyRegion" value="${fn:escapeXml(data.companyRegion)}"/>
						<c:choose>
							<c:when test="${fn:containsIgnoreCase(data.companyRegion, '1')}">
								<input class="i1" id ="companyRegion" value="自营"  />
							</c:when>
							<c:when test="${fn:containsIgnoreCase(data.companyRegion, '2')}">
								<input class="i1" id ="companyRegion" value="非自营"  />
							</c:when>
							<c:otherwise>
								<input class="i1" id ="companyRegion" value=""  />
							</c:otherwise>
						</c:choose>
					</li> --%>
					<%-- <li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>入驻区域：</p>
						<input type="hidden" id="companyQy1" name="companyQy" value="${fn:escapeXml(data.companyQy)}"/>
						<c:forEach items="${regionList}" var="reg">
							<c:if test="${data.companyQy==reg.regionId}">
								<input class="i1" id ="companyQy" value="${reg.regionText}" />
							</c:if>
						</c:forEach> --%>
						<%-- <c:choose>
							<c:when test="${fn:containsIgnoreCase(data.companyQy, '1')}">
								<input class="i1" id ="companyQy" value="自营" readonly="readonly" />
							</c:when>
							<c:when test="${fn:containsIgnoreCase(data.companyQy, '2')}">
								<input class="i1" id ="companyQy" value="孵化" readonly="readonly" />
							</c:when>
							<c:when test="${fn:containsIgnoreCase(data.companyQy, '3')}">
								<input class="i1" id ="companyQy" value="高新" readonly="readonly" />
							</c:when>
							<c:when test="${fn:containsIgnoreCase(data.companyQy, '4')}">
								<input class="i1" id ="companyQy" value="普通" readonly="readonly" />
							</c:when>
							<c:otherwise>
								<input class="i1" id ="companyQy" value="" readonly="readonly" />
							</c:otherwise>
						</c:choose> --%>
				<!-- 	</li> -->
					
					<%-- <li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>企业经理人：</p>
						<input class="i1" id ="managerBackup" name="managerBackup" value="${fn:escapeXml(data.manager)}"/>
						<input type="hidden" id="manager" name="manager" value="${fn:escapeXml(data.manager)}"/>
					</li> --%>
					<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>客服电话：</p>
						<input class="i1" id ="managerTelBackup" name="kfTelBackup" value="${fn:escapeXml(data.kfTel)}"/>
						<input type="hidden" id="managerTel" name="kfTel" value="${fn:escapeXml(data.kfTel)}"/>
					</li>
					<li class="blank20"></li>
					<%-- <li>
						<p class="p1"><b style=" color: #FF0000;">*</b>客服电话：</p>
						<input class="i1" id ="kfTelBackup" name="kfTelBackup" value="${fn:escapeXml(data.kfTel)}"/>
						<input type="hidden" id="kfTel" name="kfTel" value="${fn:escapeXml(data.kfTel)}"/>
					</li> --%>
<!-- 					  <li class="blank20"></li> -->
				      <%-- <li>
						<p class="p1"><b style=" color: #FF0000;">*</b>公司性质：</p>
						
					    <c:if test="${data.companyNature eq 1}">
						 <input class="i1" id="companyNature" value="生产商" readonly="readonly" />	
						</c:if>
						<c:if test="${data.companyNature eq 2}">
						 <input class="i1" id="companyNature" value="贸易商" readonly="readonly" />	
						</c:if>
						<c:if test="${data.companyNature eq 3}">
						 <input class="i1" id="companyNature" value="国内经销商" readonly="readonly" />	
						</c:if>
   					    <c:if test="${data.companyNature eq 5}">
						 <input class="i1" id="companyNature" value="生产商&贸易商" readonly="readonly" />	
						</c:if>
						
							
					</li> --%>
					   <%--  <li class="blank20"></li>
				      <li>
						<p class="p1"><b style=" color: #FF0000;">*</b>国家地区：</p>
						<input class="i1" id="countryAreaBackup" name="countryAreaBackup" value="${fn:escapeXml(data.countryArea)}" />
						<input type="hidden" id="countryArea" name="countryArea" value="${fn:escapeXml(data.countryArea)}"/>		
					</li> --%>
					<%-- 	<li class="blank20"></li>
				    <li>
						<p class="p1"><b style=" color: #FF0000;">*</b>公司地址：</p>
						<input class="i1 validate[required ,minSize[1],maxSize[100]]" id="addressBackup" name="addressBackup" value="${fn:escapeXml(data.address)}"  />
						<input type="hidden" id="address" name="address" value="${fn:escapeXml(data.address)}"/>
						<i class="J_PopTip poptip-help" rel="tooltip" tip="公司注册地址">	</i>
					</li> --%>
						<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>真实姓名：</p>
						<input class="i1 validate[required,minSize[1],maxSize[50]]" id="contactBackup" name ="contactBackup" value="${fn:escapeXml(data.contact)}" />
						<input type="hidden" id="contact" name="contact" value="${fn:escapeXml(data.contact)}"/>
					</li>
						<li class="blank20"></li>
					<%-- <li>
						<p class="p1"><b style=" color: #FF0000;">*</b>手机：</p>
						<input class="i1 validate[required,custom[ccigphone]]" id="phoneBackup" name ="phoneBackup" value="${fn:escapeXml(data.phone)}" />
						<input type="hidden" id="phone" name="phone" value="${fn:escapeXml(data.phone)}"/>
					</li> --%>
						<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>邮箱：</p>
						<input class="i1 validate[required,custom[email]]" id="emailBackup" name="emailBackup"  value="${fn:escapeXml(data.email)}"/>
						<input type="hidden" id="email" name="email" value="${fn:escapeXml(data.email)}"/>
					</li>
						<li class="blank20"></li>
					<%-- <li>
						<p class="p1">固定电话：</p>
						<input class="i1 validate[custom[ccigphone]]" id="faxBackup" name ="faxBackup" value="${fn:escapeXml(data.fax)}" />
						<input type="hidden" id="fax" name="fax" value="${fn:escapeXml(data.fax)}"/>
					</li>
						<li class="blank20"></li>
					<li>
						<p class="p1">邮政编码：</p>
						<c:if test="${data.post==0}">
						 	<input class="i1 validate[custom[number],minSize[1],maxSize[10]]" id="postBackup" name="postBackup"  />
						</c:if>
						<c:if test="${data.post!=0}">
					   		<input class="i1 validate[custom[number],minSize[1],maxSize[10]]" id="postBackup" name="postBackup" value="${fn:escapeXml(data.post)}" />
					   		<input type="hidden" id="post" name="post" value="${fn:escapeXml(data.post)}"/>
					   	</c:if>
					</li>
					<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>企业信息：</p>
						<input class="i1 validate[required ,minSize[1],maxSize[100]]" name="address" value="${fn:escapeXml(data.companyInfo)}"  />
						<textarea class="i1" id="companyInfo" name="companyInfo" style="height: 80px;" rows="6" cols="35" >${fn:escapeXml(data.companyInfo)}</textarea>
						<input type="hidden" id="companyInfo1" name="companyInfo1" value="${fn:escapeXml(data.companyInfo)}"/>
					</li>
				   <li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>商品类别：</p>
						<input class="i1 validate[required,minSize[1],maxSize[100]]" id="mer-cgr"  name="categories1" onclick="IndustrySelect()" readonly="readonly" />
						<input id="mercgr" class="validate[required]" type="hidden" name="categoriesBackup" value="${fn:escapeXml(product.categories)}" >
						<input id="categoriesBackup" name="categories" type="hidden" value="${fn:escapeXml(product.categories)}"/>
					</li>
					<li class="blank20"></li>
					<li>
						<p class="p1">商品品牌：</p>
						<input class="i1" id="mer-brand" name="brandBackup" value="${fn:escapeXml(product.brand)}" />
						<input type="hidden" name="brand" value="${fn:escapeXml(product.brand)}"/>
					</li> --%><%--
					<li class="blank20"></li>
					<li>
						<p class="p1"><b style=" color: #FF0000;">*</b>SKU数量：：</p>
						<input class="i1 validate[required,custom[number],minSize[1],maxSize[10]]" id="skunum" name="skuNum"  value="${fn:escapeXml(product.skuNum)}"/>
					</li>
					--%><%-- <li class="blank20"></li>
						<li>
					<p class="p1">资质文件：</p>
						<c:if test="${not empty data.companyLegitimacyUrl }">
						<a  href="${path}/supplier/download?url=${data.companyLegitimacyUrl}" target="downloadFileIframe">资质文件下载</a>&nbsp;&nbsp;&nbsp;&nbsp;
						  <span id="filespan" class="divfile" >
						    <input id="textfield" class="t2 " type="text" readonly="readonly" >
	                        <input id="fileField" class="file" type="file" onchange="document.getElementById('textfield').value=this.value" size="28" name="myfile" >
	                        <input class="btn" type="button" value="变更" style="float: none;" tabindex="-1"   >
                       </span>
						</c:if>
						<c:if test="${empty data.companyLegitimacyUrl }">
<!-- 						  <span id="filespan" class="divfile" > -->
<!-- 						    <input id="textfield" class="t2 " type="text" readonly="readonly" > -->
<!-- 	                        <input id="fileField" class="file" type="file" onchange="document.getElementById('textfield').value=this.value" size="28" name="myfile" > -->
<!-- 	                        <input class="btn" type="button" value="上传" style="float: none;" tabindex="-1"   > -->
<!--                           </span> -->
					  </c:if>
					</li>				
				    <li class="blank20"></li>
					<li>
					<p class="p1">详情文件：</p>
					    <c:if test="${not empty data.companyDetailedUrl }">
							<a  href="${path}/supplier/download?url=${data.companyDetailedUrl}" target="downloadFileIframe">详情文件下载</a>&nbsp;&nbsp;&nbsp;&nbsp;
					    <span id="filespan" class="divfile">
					       <input id="textfield1" class="t2 " type="text" readonly="readonly" >
						   <input id="fileField" class="file " type="file" onchange="document.getElementById('textfield1').value=this.value"  size="28" name="myfile1" >
	                       <input class="btn" type="button"  value="变更"   style="float: none;" tabindex="-1"   >
                       </span>
				       </c:if>
				       <c:if test="${empty data.companyDetailedUrl }">
<!-- 					         <span id="filespan" class="divfile"> -->
<!-- 					           <input id="textfield1" class="t2 " type="text" readonly="readonly" > -->
<!-- 							   <input id="fileField" class="file" type="file" onchange="document.getElementById('textfield1').value=this.value"  size="28" name="myfile1" > -->
<!-- 		                       <input class="btn" type="button"  value="上传"   style="float: none;" tabindex="-1"   > -->
<!-- 		                      </span> -->
				        </c:if>
					</li>
				    <li class="blank20"></li>
					<li>
					<p class="p1">企业Logo：</p>
					    <c:if test="${not empty data.logoImgurl }">
					    	<img alt="企业logo" src="http://image01.3qianwan.com/${data.logoImgurl}">
					    	<input name="logoImgurl" type="hidden" id="logoImgurlId" value="${data.logoImgurl}"/>
				       </c:if>
				       <c:if test="${empty data.logoImgurl }">
				       		<img alt="企业默认logo" src="${path}/images/popmorenlogo.jpg">
<!-- 					         <span id="filespan" class="divfile"> -->
<!-- 					           <input id="textfield2" class="t2 " type="text" readonly="readonly" > -->
<!-- 							   <input id="fileField" class="file" type="file" onchange="document.getElementById('textfield2').value=this.value"  size="28" name="myfile2" > -->
<!-- 		                       <input class="btn" type="button"  value="上传"   style="float: none;" tabindex="-1"   > -->
<!-- 		                      </span> -->
				        </c:if>
					    	<li class="blank20"></li>
					    <span id="filespan" class="divfile">
					       <input id="textfield2" class="t2 " type="text" readonly="readonly" >
						   <input id="fileField" class="file " type="file" onchange="document.getElementById('textfield2').value=this.value"  size="28" name="myfile2" >
	                       <input class="btn" type="button"  value="变更"   style="float: none;" tabindex="-1"   >
                       </span>--%>
                       <li class="blank20"></li> 
					<li>
						<c:if test="${data.activeStatus==-1 && data.status==0 }">
							请等待审核
						</c:if>
						<%-- <c:if test="${data.activeStatus==-1 && data.status==1 && data.organizationType==5 }">
							审核未通过或账号已过期
						</c:if> --%>
						<c:if test="${data.activeStatus==-1 && data.status==2 }">
							审核未通过，请修改并重新提交
						</c:if>
						<c:if test="${data.activeStatus==-1 && data.status==1 && data.organizationType==5}">
							已过期或审核未通过，请联系后台
						</c:if>
						
						
						
						<p class="p1">审核留言：</p>
						<textarea class="i1" id="checkFailReaId" name="checkFailReason" style="height: 80px;" rows="6" cols="35" readonly="readonly">${fn:escapeXml(data.checkFailReason)}</textarea>
<%-- 						<input type="hidden" id="companyInfo" name="companyInfo" value="${fn:escapeXml(data.companyInfo)}"/> --%>
					</li>
					</li>
					
					<p class="blank30"></p>
					<c:if test="${data.status!=0 && data.activeStatus==-1}">
				    <input type="button"  class="fabu_btn" onclick="subUpdate()" value="修改" ></input>
				    </c:if>
				    <input id="submitButton" type="submit" style="display: none" ></input>
					<p class="blank30"></p>
			</div>
			 <div id="maskLayer" style="display: none;">
				<div id="alphadiv" style="filter: alpha(opacity=50);opacity: 0.5;"></div>
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
		 <script  type="text/javascript" src="${path}/js/validation/jquery.validationEngine-zh_CN.js"></script> 
		 <script  type="text/javascript" src="${path}/js/user/zh/drag.js"></script> 
	<%-- <script  type="text/javascript" src="${path}/js/user/industry_arr.js"></script>  --%>
	<script type="text/javascript">
	
	
	jQuery(document).ready(function(){
		  var message='${meaages}';
		  if(message!=''){
			  alert("网络连接超时，请您稍后重试");
		  }
		  var msg='${message}';
		  if(msg == 'ok'){
			  alert("修改内容需后台审核才能生效");
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
	<script type="text/javascript" src="${path}/js/user/zh/industry_func2.js"></script>
	<script type="text/javascript">
	  //categories根据Id显示文本框的值
	 
	</script> 
	<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	<!-- 底部 end -->
     </body>
</html>