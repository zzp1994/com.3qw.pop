<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.mall.mybatis.utility.PageBean" %>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:if test="${empty invList}">
    <table class="ui_dialog">
        <tr>
            <td class="ui_icon" style="display: none;"></td>
            <td class="ui_main" style="width: 290px; height: 120px;">
                <div class="ui_content" style="padding: 10px;"><span style="line-height:20px;">未获取到商品SKU列表信息</span></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="ui_buttons">
                    <input type="button" class="lightbox-btn true-btn" value="确定" onclick="close_editinv_box()">
                </div>
            </td>
        </tr>
        </tr>
    </table>
</c:if>
<c:if test="${!empty invList}">
    <div style="height:500px; width:400px; overflow:auto">
    <table id="showSkuQty">
        <tr>
            <th>规格</th>
            <th style="display:none;">锁定数量</th>
            <th>订单占用数量</th>
            <th>库存数量</th>
        </tr>
        <c:forEach items="${invList}" var="skuInv">
            <tr>
                <td style="width: 100px; height: 40px;">${skuInv.skunamecn}</td>
                <td style="width: 100px; height: 40px; display:none;">${skuInv.lockQty}</td>
                <td style="width: 100px; height: 40px;">${skuInv.preSubQty}</td>
                <td style="width: 100px; height: 40px;">
                    <input style="border:1px solid #ff4800;" sku="${skuInv.sku_id}" skuName="${skuInv.skunamecn}" lockQty="${skuInv.lockQty}" preSubQty="${skuInv.preSubQty}" version="${skuInv.version}" type="text" name="editNotBatchQty" class="frame" value="${skuInv.qty}">
                </td>
            </tr>
        </c:forEach>
    </table>
    </div>
    <div class="lightbox-box-bar">
        <a href="javascript:void(0);" class="lightbox-btn true-btn" onclick="editInventorySubmit('${pId}', '${warehouseCode}')">提交</a>
        <a href="javascript:void(0);" class="lightbox-btn true-btn" onclick="close_editinv_box()">取消</a>
        <span style="margin-left: 20px;color: red;" id="boxwarn1"></span>
    </div>
</c:if>

