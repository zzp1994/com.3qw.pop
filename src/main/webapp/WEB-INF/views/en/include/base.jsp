<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<%-- <link rel="shortcut icon" type="image/icon" href="${path}/images/favicon.ico"/> --%>

<link rel="shortcut icon" href="${path}/images/favicon.ico" mce_href="${path}/images/favicon.ico" type="image/x-icon">
<script type="text/javascript" src="${path}/js/user/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${path}/js/lhgdialog/lhgdialog_en.js?skin=idialog"></script>
<script type="text/javascript" >
   //重写alert方法 调用框架的弹出框
	window.alert =function(message){
	     $.dialog({ 
		   title:'<h1>3qianwan Message</h1>',
	 	   content:message,
	 	   lock: true, //遮挡
	 	   max: false, 
	       min: false ,
	       resize:false,
	       width:'290px',
	       height:'120px',
	       button: [
	           {
	         	 name: 'Confirm'
	           }
	           
	       ]
	    }); 
	}; 
	//相当于confirm 提示+回调函数
	tipMessage =function(content,yes){
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
					tipMessage("Error!",function(){
						location.reload();
					}); 
				}else if(data==1){ 
					tipMessage("Successful!",function(){
						location.reload();
					});
				}else{
					tipMessage(data,function(){
						location.reload();
					});
				}
			}, 
			error: function (XMLHttpRequest, textStatus, errorThrown) { 
				alert("Server is busy, please try again later!"); 
				} 
			});
	};
</script>
 <script type="text/javascript" src="${path}/js/commons/open.js"></script>
 <script language="javascript" type="text/javascript" src="${path}/js/my97/en/My97DatePicker/WdatePicker.js"></script>
 <link rel="stylesheet" type="text/css" href="${path}/css/commonwidget.css" />