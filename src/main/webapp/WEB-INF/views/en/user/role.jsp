<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	   <title>Supplier-Authority Management</title>

	<%@include file="/WEB-INF/views/en/include/base.jsp"%>
    <link rel="stylesheet" type="text/css" href="${path}/css/en/juese.css">
	  <script type="text/javascript" src="${path}/js/user/en/role.js"></script>
      <link rel="stylesheet" type="text/css" href="${path}/css/en/quanxian.css">
      <link rel="stylesheet" href="${path}/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
	 <script type="text/javascript" src="${path}/js/ztree/jquery.ztree.core-3.5.js"></script>
	 <script type="text/javascript" src="${path}/js/ztree/jquery.ztree.excheck-3.5.js"></script>
	</head>
	<body>
    <!-- 弹框 start -->
		<div id="add_div" class="alert_user2" style="display:none;">
			<div class="bg"></div>
			<div class="w">
				<div class="box1">
					<h2>Create Role</h2>
					<img src="${path}/images/close.jpg" class="w_close">
				</div>
				<div class="box3">
					<form id="addForm" action="${path}/role/save" method="post" onkeydown="if(event.keyCode==13){$('#addBtn').click(); return false;}" >
					 <input type="hidden" name="token" value="${token}">
						<span class="s1" style="margin-left:1px;">RoleName：</span><input id="name"  type="text" name="name" ><br>
						<button id="addBtn" type="button" class="bt1">Confirm</button>
						<button id="addBtnCancel" type="button" class="bt2" >Cancel</button>
					</form>
				</div>
				<div class="blank20"></div>
			</div>
		</div>
		
		
		<div id="edit_div" class="alert_user2" style="display:none;">
		<div class="bg"></div>
		<div class="w">
			<div class="box1">
				<h2>Edit Role</h2>
				<img src="<%=path%>/images/close.jpg" class="w_close">
			</div>
			<div class="box3">
				<form id="editForm" action="${path}/role/update" method="post" onkeydown="if(event.keyCode==13){$('#editBtn').click(); return false;}"  >
				        <input id="hiddenName"  type="hidden" name="hiddenName" >
				         <input type="hidden" name="token" value="${token}">
				        <input id="roleId1"  type="hidden" name="roleId" >
						<span class="s1" style="margin-left:1px;">RoleName：</span><input id="name1"   type="text" name="name"  ><br>
						<button id="editBtn" type="button"  class="bt1">Edit</button>
						<button id="editBtnCancel" type="button"  class="bt2" >Cancel</button>
				</form>
			</div>
			<div class="blank20"></div>
		</div>
	</div>
	<!-- 弹框 end -->
		
   <%@include file="/WEB-INF/views/en/include/header.jsp"%>	
   
   <div class="wrap">
		
		<%@include file="/WEB-INF/views/en/include/leftUser.jsp"%>

         <!-- 右边 start -->
		<div class="right f_l">
			<div class="title">
				<p class="c1">Authorization Management</p>
				<div class="clear"></div>
			</div>
			<div class="blank5"></div>
			<div  class="list f_l">
				<h2>Role</h2>
				<div class="au">
				  <c:forEach items="${roleList}" var="role" varStatus="vs">
					<li  <c:if test="${roleId==role.roleId}"> class="i0"</c:if> <c:if test="${roleId!=role.roleId}"> class="i1"</c:if>  >
						<a href="<%=path%>/role/list?roleId=${role.roleId}" class="le"> ${fn:escapeXml(role.name)}</a>
						<div style="float: right;">
							<%-- <a class="delname" href="<%=path%>/role/delete?roleId=${role.roleId}">[删除]</a> --%>
							<a class="delname" onclick="checkRoleDel('${role.roleId}')" href="javascript:void(0)">[Delete]</a>
							<a class="xiug4"  href="javascript:editUser('${role.roleId}','${fn:escapeXml(role.name)}')">[Edit]</a>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</li>
				</c:forEach>
				</div>
					<%--<li class="i1" style="background:#cccccc;">
						<a href="<%=path%>/role/list?roleId=" >kk</a>
						<div style="float: right;">
							<a class="delname" href="<%=path%>/role/delete?roleId=kk" style="color:#ffffff;">[删除]</a>
							<a class="xiug4"  href="javascript:editUser('k','kk')" style="color:#ffffff;">[修改]</a>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</li>
				--%><div class="clear"></div>
			</div>
			<div class="list2 f_l">
				<button id="addbutton" class="b1 f_l">Create Role</button>
				<button type="button" onclick="submitForm()" class="b2 f_l">Confirm </button>
				<p class="blank15"></p>
				<h2>Select which pages can be accessed by the role</h2>
				<!-- 折叠菜单begin -->						
				 <div class="zTreeDemoBackground left">
					<ul id="treeDemo" class="ztree"></ul>
				</div>
				<!-- 折叠菜单over -->
			</div>
			
			<form id="updateRoleMenu" action="${path}/role/updateRoleMenu" method="post">
			  <div id="hiddenBox" style="display: none;">
			   <input type="hidden" name="token" value="${token}">
			     <input id="roleId2"  type="hidden" name="roleId" value="${roleId}" >
			  </div>
			</form>
			<form id="deleteForm" action="${path}/role/delete" method="post" >
		        <input type="hidden" name="token" value="${token}">
		        <input id="roleId3"  type="hidden" name="roleId" >
			</form>
			
		</div>
		<!-- 右边 end -->
	</div>
	<!-- 内容 end -->
	<p class="blank30"></p>
		<!-- 底部 start -->
	<%@include file="/WEB-INF/views/en/include/last.jsp"%>
	<!-- 底部 end -->
</body>
 <script type="text/javascript">
 
		var setting = {
			check: {
				enable: true
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			view: {
				showIcon: false
		    }
		};
		function checkSelect(){
		     var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
             var nodes = treeObj.getCheckedNodes();
             $(nodes).each(function(){
		        var hiddenString = '<input type="hidden" name="menus" value="'+this.id+'"/>';
                $("#hiddenBox").append(hiddenString);
		     });
		}
		
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, ${tree});
			$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
		});
		
		function  editUser(id,name){
			$("#roleId1").val(id);
			$("#name1").val(name);
			$("#hiddenName").val(name);
			$("#edit_div").show();
		}
		function submitForm(){
			if($.trim($("#roleId2").val()).length<=0){
				alert("Please select one role!");
				return;
			}else{
				checkSelect();
				ajaxSubmit("#updateRoleMenu");
				//$("#updateRoleMenu").submit();
			}
			
		}
		
		function checkRoleDel(roleId){
			$("#roleId3").val(roleId);
			$.dialog.confirm('Are you sure to delete this role?', function(){
					$.ajax({
			 	         type: "POST",
			 	         dataType:"html",
			 	         url: "./checkRoleDel",
			 	         data: "roleId="+roleId,
			 	         success: function (result) {
			 	        	 if(result>0){
			 	        	    alert("Have users binding the role, cannot be delete!");
			 	        	    return false;
			 	        	 }else{
			 	        		ajaxSubmit("#deleteForm");
			 	        		//window.location.href="../role/delete?roleId="+roleId;
			 	        	 }
			 	          }
			 	   });
				}, function(){
				   // $.dialog.tips('执行取消操作');
				});
		}
	 </script> 
</html>