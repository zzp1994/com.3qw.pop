<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	  <title>商家后台管理系统-用户管理</title>
      <%@include file="/WEB-INF/views/zh/include/base.jsp"%>
	  <link rel="stylesheet" type="text/css" href="${path}/css/zh/user.css">
      <link rel="stylesheet" type="text/css" href="${path}/css/zh/juese.css">
	</head>
	<body>
    <!-- 弹框 start -->
		<div id="addDiv" class="alert_user2">
			<div class="bg"></div>
			<div class="w">
				<div class="box1">
					<h2>创建新用户</h2>
					<img src="${path}/images/close.jpg" class="w_close">
				</div>
				<div class="box3">
					<form id="addForm" action="${path}/user/save" method="post">
						<table>
							<tr>
							    <input type="hidden" name="token" value="${token}">
								<td>用户名：</td><td><input id="name"  type="text" name="loginName" ${loginUser.loginName}></td>
							</tr>
							<tr>
								<td>密码：</td><td><input id="password" oncopy="return false" onpaste="return false" type="password" name="password"  ></td>
							</tr>
							<tr>
								<td>再次输入密码：</td><td><input id="repassword" oncopy="return false" onpaste="return false" type="password" name="repassword"></td>
							</tr>
							<tr>
								<td>角色：</td><td><select  id="roleId" name ="roleId" >
							    <option value="" selected="selected">请选择</option>
							    <c:forEach items="${roles}" varStatus="status" var="role">
								        <c:if test="${'Sub-Supplier'==role.name}">
								       	  <option value="${role.roleId}" >子供应商</option>
								        </c:if>
								         <c:if test="${'Sub-Supplier'!=role.name}">
								       	  <option value="${role.roleId}" >${fn:escapeXml(role.name)}</option>
								        </c:if>
								  </c:forEach>
							</select></td>
							</tr>
						</table>
					<%-- 	<span class="s1">用户名：</span> <input id="name"  type="text" name="loginName" ><br>
						<span class="s2">密码：</span><input id="password" oncopy="return false" onpaste="return false" type="password" name="password"  ><br>
						<span>再次输入密码：</span><input id="repassword" oncopy="return false" onpaste="return false" type="password" name="repassword">
						<span class="s3">角色：</span>
                            <select  id="roleId" name ="roleId" >
							    <option value="" selected="selected">请选择</option>
							    <c:forEach items="${roles}" varStatus="status" var="role">
							        <option value="${role.roleId}" >${role.name}</option>
							    </c:forEach>
							</select> --%>
						<button id="addUser" type="button" class="bt1">确定</button>
						<button id="addUserCancel" type="button" class="bt2" >取消</button>
					</form>
				</div>
				<div class="blank20"></div>
			</div>
		</div>
		
		
		<div id="editDiv" class="alert_user2" style="display:none;">
		<div class="bg"></div>
		<div class="w">
			<div class="box1">
				<h2>修改新用户</h2>
				<img src="<%=path%>/images/close.jpg" class="w_close">
			</div>
			<div class="box3">
				<form id="editForm" action="${path}/user/update" method="post" >
				        <input type="hidden" name="token" value="${token}">
						<input id="userId"  type="hidden" name="userId" >
				         <input id="hiddenName"  type="hidden" name="hiddenName" >
						<table>
							<tr>
								<td>用户名：</td><td><input id="name1"   type="text" name="loginName" disabled="disabled"></td>
							</tr>
							<tr>
								<td>密码：</td><td><input id="password1" oncopy="return false" onpaste="return false" type="password" name="password"  ></td>
							</tr>
							<tr>
								<td>再次输入密码：</td><td><input id="repassword1" oncopy="return false" onpaste="return false"  type="password" name="repassword"  ></td>
							</tr>
							<tr>
								<td>角色：</td><td><select  id="roleId1" name ="roleId" >
							    <option value="" selected="selected">请选择</option>
							    <c:forEach items="${roles}" varStatus="status" var="role">
							        <c:if test="${'Sub-Supplier'==role.name}">
							       	  <option value="${role.roleId}" >子供应商</option>
							        </c:if>
							         <c:if test="${'Sub-Supplier'!=role.name}">
							       	  <option value="${role.roleId}" >${fn:escapeXml(role.name)}</option>
							        </c:if>
							    </c:forEach>
							</select></td>
							</tr>
						</table>
				        
						<%-- <span class="s1">用户名：</span> <input id="name1"   type="text" name="loginName" disabled="disabled"><br>
						<span class="s2">密码：<span><input id="password1" oncopy="return false" onpaste="return false" type="password" name="password"  ><br>
						<span>再次输入密码：<span><input id="repassword1" oncopy="return false" onpaste="return false"  type="password" name="repassword"  >
						<span class="s3">角色：<span>
                            <select  id="roleId1" name ="roleId" >
							    <option value="" selected="selected">请选择</option>
							    <c:forEach items="${roles}" varStatus="status" var="role">
							        <option value="${role.roleId}" >${role.name}</option>
							    </c:forEach>
							</select> --%>
						<button id="userEidt" type="button"  class="bt1">修改</button>
						<button id="userEidtCancel" type="button"  class="bt2" >取消</button>
				</form>
			</div>
			<div class="blank20"></div>
		</div>
	</div>
	<!-- 弹框 end -->

        <%@include file="/WEB-INF/views/zh/include/header.jsp"%>	
	    
		<div class="wrap">
			<%@include file="/WEB-INF/views/zh/include/leftUser.jsp"%>
			
			<form  id="SearchFrom"  action="${path}/user/list" method="post">
			     <input name="sortFields"   type="hidden" value="${page.sortFields}"/> 
		         <input name="order"  type="hidden" value="${page.order}"/> 
			</form>
			
			
			<form id="deleteForm"  action="${path}/user/deleteByIds" method="post">
		        <input id="token" type="hidden" name="token" value="${token}">
		       	<!-- 右边 start -->
				<div class="right f_l">
					<div class="title">
						<p class="c1">用户管理</p>
						<div class="clear"></div>
					</div>
					<div class="blank5"></div>
					<div class="cont">
						<div class="u_list user-list">
							<ul class="title_1">
								<li class="p1 f_l">
									<%--<input type="checkbox" class="f_l c_mtop2">
									<p class="f_l">&nbsp;全选</p>
								--%></li>
								<li class="p2 f_l">
									<button type="button" class="btn1 f_l">创建新用户</button>
								</li>
								<li class="p2 f_l">
									<button type="button" onclick="deleteAll();"  class="btn2 f_l">删除</button>
								</li>
								
								<li class="clear"></li>
							</ul>
							<p class="blank5"></p>
							<h2>
								<p class="p1">选项</p><%--
								<p>序号</p>
								--%><p>用户名</p>
								<p>角色</p>
								<p>操作</p>
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
										<c:if test="${'Sub-Supplier'==key}">
								       	<p class="p3" title="子供应商">子供应商  </p>
								        </c:if>
								         <c:if test="${'Sub-Supplier'!=key}">
								       	<p class="p3" title="${key}">${key}&nbsp; </p>
								        </c:if>
									
										<p class="p5">
										     <c:if test="${loginUser.userId!=user.userId}">
												<span class="c_poin dele" onclick="delUser('${user.userId}')">[删除]</span>
											</c:if>
											<span class="c_poin span2" onclick="editUser('${user.userId}','${fn:escapeXml(user.loginName)}','${rolemap[key]}')" >[修改]</span>
										</p>
										<span style="display:block;clear:both;"></span>
									</li>
								</c:if>
							  	</c:forEach>
						    </ul>
						</div>
					</div>
					<%@include file="/WEB-INF/views/zh/include/page.jsp"%>
				</div>
				<!-- 右边 end -->
			    </form>
		</div>	
			
		<!-- 底部 start -->
     	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	<!-- 底部 end -->
   </body>
   <script type="text/javascript" src="${path}/js/user/zh/jiben.js"></script>
   <script type="text/javascript">	
			function  editUser(id,name,t){
				$("#userId").val(id);
				$("#name1").val(name);
				$("#hiddenName").val(name);
				$("#roleId1").val(t);
			}
			function  delUser(id){
				var token=$("#token").val();
				$.dialog.confirm('确定删除此用户?', function(){
					$.ajax( {
						url : '${path}'+"/user/delete?id="+id+"&token="+token,
						type : 'POST',
						timeout : 30000,		
						success: function (data) {
							if(data.status==0){ 
								tipMessage("操作失败!",function(){
									location.reload();
								}); 
							}else{ 
								tipMessage("操作成功!",function(){
									location.reload();
								});
							}  
						}, 
						error: function (XMLHttpRequest, textStatus, errorThrown) { 
							alert("服务器忙，请稍后再试！"); 
						} 
					}, function(){
					   // $.dialog.tips('执行取消操作');
					});
		    	});
			}
			function  deleteAll(){
				if($(":checkbox[name='nn'][checked]").length<=0){
					alert("请选择要删除的选项!");
				}else{
					$.dialog.confirm('确定删除选中用户?', function(){
						   //$("#deleteForm").submit();
					        ajaxSubmit("#deleteForm");	
					}, function(){
						   // $.dialog.tips('执行取消操作');
						});
			    	}
				}
	 </script> 
</html>