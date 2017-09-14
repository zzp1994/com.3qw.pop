<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%  
    String path = request.getContextPath();
	request.setAttribute("path",path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title><spring:message code="registResultTitle" /></title>
    <link type="text/css" rel="stylesheet" href="${path}/css/regist.css"/>
    <link rel="shortcut icon" href="${path}/images/favicon1.ico" />
   <script type="text/javascript" src="${path}/js/commons/jquery-1.8.3.min.js"></script>
    <style type="text/css">
body{
    color: #333333;
    font-family: Arial,"宋体",Lucida,Verdana,Helvetica,sans-serif;
    font-size: 12px;
    line-height: 150%;
    background: none repeat scroll 0 0 #F2F2F2;
    margin: 0;
}
    </style>
</head>
<body>
    <div id="shortcut-2013">
     <div class="w">
                <ul class="fr lh">
                    <li id="loginbar" class="fore1" clstag="homepage|keycount|home2013|01b">
                      <%--<a  href="${path}/supplier/registUI?locale=zh_CN">中文 &nbsp; </a>
		              <a href="${path}/supplier/registUI?locale=en">English&nbsp;  </a>   --%>
                    <spring:message code="welcome" />
                    <span>
                    <a href="${path}/user/loginUI"> [<spring:message code="login" />] </a>
                    <a class="link-regist" href="${path}/supplier/registUI">[<spring:message code="regist" />]</a>
                    </span>
                    </li>
                </ul>
            </div>
        </div>
<div class="w">
    <div id="logo"><a href="${path}/user/loginUI" clstag="passport|keycount|login|01">
    <img src="${path}/images/login-logo-sm.png" alt="<spring:message code="logo" />" width="170"
                                                     height="60"/></a>
     <b style="background: url('${path}/images/regist-wel-<spring:message code="language" />.png') no-repeat scroll 0 0 rgba(0, 0, 0, 0);"></b></div>
</div>


<div class="w" id="regist">
    <div class="mt">
        <div class="extra">
        <span style="text-align: right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <span> <spring:message code="registMessage" />&nbsp;<a
                href="${path}/user/loginUI"
                class="flk13"><spring:message code="login" /></a></span>
        </div>
    </div>
    <div class="mc">
        <form id="formcompany" method="post" >
            <!-- <div class=" w1" id="entry">
                <div class="mc " id="bgDiv"> -->
                    <div class="form ">
                        <div class="succ">
                            <div class="pic">
                                <img src="${path}/images/rig.png" alt="" /><span>注册成功，请 <a href="${path}/user/loginUI"> [<spring:message code="login" />] </a>
                                <spring:message code="registSuccess" /></span>
                            </div>
                            <div style="clear:both"></div>
                            <p class="xian"></p>
                            <div class="tx">
                            <c:if test="${language=='en'}">
                             <p><spring:message code="registHi" />${fn:escapeXml(name)}<spring:message code="registName" /> </p>
                            </c:if>
                             <c:if test="${language=='zh'}">
                              <p>${fn:escapeXml(name)}，<spring:message code="registHi" /><spring:message code="registName" /> </p>
                            </c:if>
                               
                                <p><spring:message code="registEnter" /><%--  <a href="${path}/user/loginUI"><spring:message code="login" /> </a> --%></p>
                            </div>
                        </div>
                        <!-- <div class="item login-btn2013">
                            <span class="label"> </span>
                            <input type="button" class="btn-img btn-entry" id="registsubmit" value="注册" tabindex="8" clstag="passport|keycount|login|06"/>
                        </div> -->
                    </div>
               <!--  </div>
            </div> -->
        </form>
    </div>
</div>


<div class="w1">
    <div id="mb-bg" class="mb"></div>
</div>
<div class="w">
    <div id="footer-2013"><%--
        <div class="copyright">Copyright</div>
    --%></div>
</div>
    <script type="text/javascript" src="${path}/js/user/validateRegExp.js"></script>
    <script type="text/javascript" src="${path}/js/user/validateprompt.js"></script>
   	<%@include file="/WEB-INF/views/zh/include/foot.jsp"%>
</body>
   
</html>

