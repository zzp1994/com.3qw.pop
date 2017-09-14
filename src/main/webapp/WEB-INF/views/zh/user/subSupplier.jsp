<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>子供应商管理</title>
<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/css/zh/user.css">
<link rel="stylesheet" type="text/css" href="${path}/css/zh/juese.css">
	</head>
	<body>
        <%@include file="/WEB-INF/views/zh/include/header.jsp"%>	
		<div class="wrap">
			<%@include file="/WEB-INF/views/zh/include/leftUser.jsp" %>
			<!--分页查询开始 -->
			<form  id="SearchFrom"  action="${path}/subsupplier/list" method="post">
			     <input name="sortFields"   type="hidden" value="${page.sortFields}"/> 
		         <input name="order"  type="hidden" value="${page.order}"/> 
			</form>
			<!--分页查询结束 -->
			
			
		       	<!-- 右边 start -->
				<div class="right f_l">
					<div class="title">
						<p class="c1">子供应商 </p>
						<div class="clear"></div>
					</div>
					<div class="blank5"></div>
					<div class="cont">
					<form id="deleteForm"  action="${path}/subsupplier/deleteByIds" method="post">
						<div class="u_list">
							<ul class="title_1">
								<li class="p1 f_l">
									<%--<input type="checkbox" class="f_l c_mtop2">
									<p class="f_l">&nbsp;全选</p>
								--%></li>
								<li class="p2 f_l">
									<button type="button" class="btn1 f_l" onclick="toAdd()" >新建子供应商</button>
								</li>
								<li class="clear"></li>
							</ul>
							<p class="blank5"></p>
							<h2>
								<p style="width: 30px;">序号</p>
								<p >子供应商名称</p>
								<p >地址</p>
								<p style="width: 110px;">联系人</p>
								<p style="width: 115px;">联系电话</p>
								<p style="width: 80px;">状态</p>
								<p>操作</p>
							</h2>
							<ul class="title_2">
							     <c:forEach  items="${page.result}" var="data" varStatus="vs">
								 	<li class="">
									    <p class="p2" style="width: 30px;"> <span>${(page.page-1)*page.pageSize+vs.count }</span></p>
										<p class="p2" title="${fn:escapeXml(data.name)}">${fn:escapeXml(data.name)}&nbsp;</p>
										<p class="p2"  title="${fn:escapeXml(data.address)}">${fn:escapeXml(data.address)}&nbsp;</p>
										<p class="p2" style="width: 110px;" title="${fn:escapeXml(data.contact)}">${fn:escapeXml(data.contact)}&nbsp;</p>
										<p class="p2" style="width: 115px;" title="${fn:escapeXml(data.phone)}">${fn:escapeXml(data.phone)}&nbsp;</p>
										<p class="p2" style="width: 80px;">
										<c:if test="${data.status==0}">未审核</c:if>
										<c:if test="${data.status==1}">审核通过</c:if>
										<c:if test="${data.status==2}">审核未通过</c:if>&nbsp;</p>
										<p class="p5">
										    <c:if test="${data.status==0}"><span class="c_poin span2" onclick="edit('${data.supplierId}')" >[修改]</span></c:if>
											<span class="c_poin span2"  onclick="del('${data.supplierId}')" >[删除]</span>
											<span class="c_poin span2"  onclick="view('${data.supplierId}')" >[查看]</span>
										</p>
										<span style="display:block;clear:both;"></span>
									</li>
							  	</c:forEach>
							</ul>
						</div>
				    </form>
					</div>
					<%@include file="/WEB-INF/views/zh/include/page.jsp"%>
				</div>
				<!-- 右边 end -->
		</div>	
		<!-- 底部 start -->
     	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	   <!-- 底部 end -->
	<script type="text/javascript" src="${path}/js/user/subsupplier.js"></script>
   </body>
   <script type="text/javascript">
   			function toAdd(){
   				window.location.href="${path}/subsupplier/toAddUI";
   			};
   			function edit(id){
   				window.location.href="${path}/subsupplier/toEditUI?id="+id;
   			};
   			function view(id){
   				window.location.href="${path}/subsupplier/toViewUI?id="+id;
   			};
   			/* function del(id){
				$.dialog.confirm('Are you sure to delete this subsupplier?', function(){
					$.ajax( {
						url : '${path}'+"/subsupplier/delete?id="+id,
						type : 'POST',
						timeout : 30000,		
						success: function (data) {
							if(data.status==0){ 
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
			}; */
		    function del(id){
				$.dialog.confirm('确定要删除此子供应商?', function(){
					$.ajax( {
						url : '${path}'+"/subsupplier/delete?id="+id,
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
							alert("服务器忙,请稍后再试!"); 
						} 
					}, function(){
					   // $.dialog.tips('执行取消操作');
					});
		    	});
			}; 
			$(document).ready(function(){
				var message='${message}';
				if(''!=message){
					alert(message);
					//$.dialog.tips(message,600,'tips.gif');
				}
			});
	 </script> 
</html>