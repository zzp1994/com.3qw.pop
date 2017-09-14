<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="t" uri="/ccigmalltag"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.mall.mybatis.utility.PageBean"%>
<%  
    String path = request.getContextPath();
    String url = request.getServletPath();
	request.setAttribute("url",url);
	request.setAttribute("path",path);
%>
<link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
<link rel="shortcut icon" href="${path}/images/favicon1.ico" />
<!-- <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script> -->
<!-- <script type="text/javascript" src="${path}/js/commons/jquery-1.8.3.min.js"></script>-->
<%-- <script type="text/javascript" src="${path}/js/user/jquery-1.7.2.js"></script> --%>
 <script type="text/javascript" src="${path}/js/user/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${path}/js/open.js"></script>
<script type="text/javascript" src="${path}/js/lhgdialog/lhgdialog_zh.js?skin=idialog"></script>
<!-- <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
 -->
 <script type="text/javascript" >
    //重写alert方法 调用框架的弹出框
	window.alert =function(message){
		message = "<span style='line-height:20px;'>"+message+"</span>"
	    $.dialog({ 
		   title:'<h1>三千万商城提示您</h1>',
	 	   content:message,
	 	   lock: true, //遮挡
	 	   max: false, 
	       min: false ,
	       resize:false,
	       width:'290px',
	       height:'120px',
	       button: [
	           {
	         	 name: '确定'
	           }
	           
	       ]
	    });
	};
	//相当于confirm 提示+回调函数
	tipMessage =function(content ,yes){
	   $.dialog.tipMessage(content,yes);
	};
	//统一form的ajax提交 操作类型(保存+更新+删除)
	var ajaxSubmit=function(formID){
	     var url=$(formID).attr("action");
		 $.ajax({ 
			type: "post", 
			url:url , 
			data:$(formID).serialize(),
			dataType: "json",
			success: function (data) {
				$(formID)[0].reset();
				if(data==0){ 
					tipMessage("操作失败!",function(){
						location.reload();
					}); 
				}else if(data==1){ 
					tipMessage("操作成功!",function(){
						location.reload();
					});
				}else{
					tipMessage(data,function(){
						location.reload();
					});
				} 
			}, 
			error: function (XMLHttpRequest, textStatus, errorThrown) { 
				alert("服务器忙，请稍后再试！"); 
				} 
			});
	};
</script>
 <script type="text/javascript" src="${path}/js/commons/open3.js"></script>
 <script language="javascript" type="text/javascript" src="${path}/js/my97/My97DatePicker/WdatePicker.js"></script>
<input id="conPath" type="hidden" value="${path}">