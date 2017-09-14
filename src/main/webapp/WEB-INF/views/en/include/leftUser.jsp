<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!-- 左边 start -->
 <script type="text/javascript">
    $(document).ready(function(){
		var url='${url}';
		//alert(url);
		if(url.indexOf("jiben")!=-1){
			$("#user_info").attr("class","p2 c_cut2");
		}
		if(url.indexOf("account")!=-1){
			$("#user_account").attr("class","p2 c_cut2");
		}
		if(url.indexOf("user/list")!=-1){
			$("#user_list").attr("class","p2 c_cut2");
		}
		if(url.indexOf("role")!=-1){
			$("#user_role").attr("class","p2 c_cut2");
		}
		if(url.toLowerCase().indexOf("subsupplier")!=-1){
			$("#subsupplier").attr("class","p2 c_cut2");
		}
	});
   
	 </script> 
     <!-- 左边 start -->
		<div class="left f_l">
			<p class="blank15"></p>
			<div class="title">
				<p class="f_l"><img src="${path}/images/img_title2.png" alt=""></p>
				<p class="f_l p1">User Center</p>
				<p class="clear"></p>
			</div>
			<p class="blank5"></p>
			<div class="list_box">
				<div class="demo">
					<h2><p class="p1 gl">Administration</p></h2>
					<div class="p_b">					 			 
					   <c:if test="${ !empty meunMap['基本信息管理']}" >
	                       <p id="user_info" class="p2 "><a href="${path}${ meunMap['基本信息管理']}"  >Profile</a></p>
					   </c:if>
					   <%-- 
					 
					  <c:if test="${ !empty meunMap['账号管理']}" >
	                       <p id="user_account" class="p2 "><a href="${path}${ meunMap['账号管理']}"  >账号管理</a></p>
					   </c:if> 

					 --%>
					 <c:if test="${ !empty meunMap['用户管理']}" >
	                       <p id="user_list" class="p2 "><a href="${path}${ meunMap['用户管理']}"  >User Mgmt</a></p>
					 </c:if> 
					 <c:if test="${ !empty meunMap['子供应商管理']}" >
	                       <p id="subsupplier" class="p2 "><a href="${path}${ meunMap['子供应商管理']}"  >Subsupplier Mgmt</a></p>
					  </c:if> 
					  <c:if test="${ !empty meunMap['权限管理']}" >
	                       <p id="user_role" class="p2 "><a href="${path}${ meunMap['权限管理']}"  >Authorization</a></p>
					   </c:if> 

					</div>
				</div>
				
			</div>
		</div>
		<!-- 左边 end -->
 <%--  old ----
     function ajaxRight(url) {
			 alert(url);
			 var data = $("#formID").serialize();
				$.ajax( {
					url : url,
					type : 'POST',
					timeout : 30000,
					data : data,
					error : function() {
						alert('Error loading ');
					},
					success : processJson
				});
			};
			function processJson(contentHtml) {
				$("#content").html(contentHtml);
			};
    <div class="left f_l">
	<h2><img src="${path}/images/img_15.jpg" alt=""></h2>
	<p class="p2 cut"><a href="${path}/supplier/jiben"  >基本信息管理</a></p>
	<p class="p2"><a href="#" onclick="ajaxRight('${path}/account/right')" >账号管理</a></p>
	<p class="p2"><a href="#" onclick="ajaxRight('${path}/user/right')" >用户管理</a></p>
	<p class="p2"><a href="#" onclick="ajaxRight('${path}/role/right')" >权限管理</a></p>
--%>