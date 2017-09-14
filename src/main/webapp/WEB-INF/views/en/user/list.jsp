<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	  <title>Supplier-User Management</title>
<%@include file="/WEB-INF/views/en/include/base.jsp"%>
	  <link rel="stylesheet" type="text/css" href="${path}/css/en/user.css">
      <link rel="stylesheet" type="text/css" href="${path}/css/en/juese.css">
	  <script type="text/javascript" src="${path}/js/user/en/jiben.js"></script>
	  <script type="text/javascript">	
			function  editUser(id,name,t){
				$("#userId").val(id);
				$("#name1").val(name);
				$("#hiddenName").val(name);
				$("#roleId1").val(t);
			}
			function  delUser(id){
				var token=$("#token").val();
				$.dialog.confirm('Are you sure to delete this user?', function(){
					$.ajax( {
						url : '${path}'+"/user/delete?id="+id+"&token="+token,
						type : 'POST',
						timeout : 30000,		
						success: function (data) {
							if(data==0){ 
								tipMessage("Error!",function(){
									location.reload();
								}); 
							}else{ 
								tipMessage("Successful!",function(){
									location.reload();
								});
							} 
						}, 
						error: function (XMLHttpRequest, textStatus, errorThrown) { 
							alert("Server is busy, please try again later!"); 
						} 
					}, function(){
					   // $.dialog.tips('执行取消操作');
					});
		    	});
			}
			function  deleteAll(){
				if($(":checkbox[name='nn'][checked]").length<=0){
					alert("Please select a item to delete!");
				}else{
					$.dialog.confirm('Are you sure to delete selected items?', function(){
						ajaxSubmit("#deleteForm");	
						//$("#deleteForm").submit();
						}, function(){
						   // $.dialog.tips('执行取消操作');
						});
				}
			}
	 </script> 
	</head>
	<body>
    <!-- 弹框 start -->
		<div id="addDiv" class="alert_user2">
			<div class="bg"></div>
			<div class="w">
				<div class="box1">
					<h2>Create User</h2>
					<img src="${path}/images/close.jpg" class="w_close">
				</div>
				<div class="box3">
					<form id="addForm" action="${path}/user/save" method="post">
						<table>
							<tr>
							 <input type="hidden" name="token" value="${token}">
								<td  style="width: 120px;">User Name:</td><td><input id="name"  type="text" name="loginName" ></td>
							</tr>
							<tr>
								<td>Password：</td><td><input id="password" oncopy="return false" onpaste="return false"  type="password" name="password"></td>
							</tr>
							<tr>
								<td>Confirm Password：</td><td><input id="repassword" oncopy="return false" onpaste="return false" type="password" name="repassword"></td>
							</tr>
							<tr>
								<td>Role：</td><td><select  id="roleId" name ="roleId" >
					    <option value="" selected="selected">Please Select</option>
					    <c:forEach items="${roles}" varStatus="status" var="role">
					        <option value="${role.roleId}" >${fn:escapeXml(role.name)}</option>
					    </c:forEach>
					    </select></td>
							</tr>
						</table>
						<button id="addUser" type="button" class="bt1">Confirm</button>
						<button id="addUserCancel" type="button" class="bt2" >Cancel</button>
					</form>
				</div>
				<div class="blank20"></div>
			</div>
		</div>
		
		
		<div id="editDiv" class="alert_user2" style="display:none;">
		
		<div class="bg"></div>
		<div class="w">
			<div class="box1">
				<h2>Edit User</h2>
				<img src="<%=path%>/images/close.jpg" class="w_close">
			</div>
			<div class="box3">
				<form id="editForm" action="${path}/user/update" method="post" >
						<input type="hidden" name="token" value="${token}">
				        <input id="userId"  type="hidden" name="userId" >
				        <input id="hiddenName"  type="hidden" name="hiddenName" >
				        <table>
							<tr>
								<td  style="width: 120px;">User Name:</td><td><input id="name1"   type="text" name="loginName" disabled="disabled"></td>
							</tr>
							<tr>
								<td>Password：</td><td><input id="password1" oncopy="return false" onpaste="return false" type="password" name="password"  ></td>
							</tr>
							<tr>
								<td>Confirm Password：</td><td><input id="repassword1" oncopy="return false" onpaste="return false" type="password" name="repassword"  ></td>
							</tr>
							<tr>
								<td>Role：</td><td><select  id="roleId1" name ="roleId" >
						    <option value="" selected="selected">Please Select</option>
						    <c:forEach items="${roles}" varStatus="status" var="role">
						        <option value="${role.roleId}" >${fn:escapeXml(role.name)}</option>
						    </c:forEach>
					     </select></td>
							</tr>
						</table>

						<button id="userEidt" type="button"   class="bt1">Edit</button>
						<button id="userEidtCancel" type="button"  class="bt2" >Cancel</button>
				</form>
			</div>
			<div class="blank20"></div>
		</div>
	</div>
	<!-- 弹框 end -->

        <%@include file="/WEB-INF/views/en/include/header.jsp"%>	
	    
		<div class="wrap">
			<%@include file="/WEB-INF/views/en/include/leftUser.jsp"%>
			
			<form  id="SearchFrom"  action="${path}/user/list" method="post">
			     <input name="sortFields"   type="hidden" value="${page.sortFields}"/> 
		         <input name="order"  type="hidden" value="${page.order}"/> 
			</form>
			<form id="deleteForm"  action="${path}/user/deleteByIds" method="post">
		       <input id="token" type="hidden" name="token" value="${token}">
		       	<!-- 右边 start -->
				<div class="right f_l">
					<div class="title">
						<p class="c1">User Management</p>
						<div class="clear"></div>
					</div>
					<div class="blank5"></div>
					<div class="cont">
						<div class="u_list">
							<ul class="title_1">
								<li class="p1 f_l">
									<%--<input type="checkbox" class="f_l c_mtop2">
									<p class="f_l">&nbsp;Select All</p>
								--%></li>
								<li class="p2 f_l">
									<button type="button" class="btn1 f_l">Create User</button>
								</li>
								<li class="p2 f_l">
									<button type="button" onclick="deleteAll();"  class="btn2 f_l">Delete</button>
								</li>
								
								<li class="clear"></li>
							</ul>
							<p class="blank5"></p>
							<h2>
								<p>Option</p><%--
								<p>序号</p>
								--%><p>User Name</p> 	
								<p>Role</p>
								<p>Operate</p>
							</h2>
							<ul class="title_2">
							<%--
						  <div id="content">
							<jsp:include page="./right.jsp" flush="true" />
						  </div>
						    --%>
							     <c:forEach  items="${page.result}" var="user" varStatus="vs">
							     <c:if test="${user.isAdmin!=1}">
								 	<li class="">
								     	 <c:if test="${loginUser.userId==user.userId}">
											<p class="p1"><input disabled="disabled" type="checkbox" name="nn" value="${user.userId}"></p>
										</c:if>
									    <c:if test="${loginUser.userId!=user.userId}">
											<p class="p1"><input  type="checkbox" name="nn" value="${user.userId}"></p>
										</c:if>
										<%--
									    <p class="p2"> <span>${vs.count}</span></p>
										--%>
										<p class="p2" title="${fn:escapeXml(user.loginName)}">${fn:escapeXml(user.loginName)}&nbsp;</p>
										<c:set var="key" value="${fn:escapeXml(mapvo[user.loginName])}" ></c:set>
										<p class="p3" title="${key}">${key}&nbsp; </p>
										<p class="p5">
											<c:if test="${loginUser.userId!=user.userId}">
												<span class="c_poin dele" onclick="delUser('${user.userId}')">[Delete]</span>
											</c:if>
											<span class="c_poin span2" onclick="editUser('${user.userId}','${fn:escapeXml(user.loginName)}','${rolemap[key]}')" >[Edit]</span>
										</p>
										<span style="display:block;clear:both;"></span>
									</li>
								</c:if>
							  	</c:forEach>
						    </ul>
						</div>
					</div>
					<%@include file="/WEB-INF/views/en/include/page.jsp"%>
				</div>
				<!-- 右边 end -->
			    </form>
		</div>	
			
		<!-- 底部 start -->
	<%@include file="/WEB-INF/views/en/include/last.jsp"%>
	<!-- 底部 end -->
   </body>
</html>