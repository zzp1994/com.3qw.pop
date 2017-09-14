package com.mall.annotation;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import com.mall.utils.Constants;

/**
 * <p>
 * 防止重复提交注解，用于方法上<br/>
 * 在新建页面方法上，设置needSaveToken()为true，此时拦截器会在Session中保存一个token，
 * 同时需要在新建的页面中添加
 * <input type="hidden" name="token" value="${token}">
 * <br/>
 * 保存方法需要验证重复提交的，设置needRemoveToken为true
 * 此时会在拦截器中验证是否重复提交
 * </p>
 *
 */
@Target(java.lang.annotation.ElementType.METHOD)
@Retention(java.lang.annotation.RetentionPolicy.RUNTIME)
public @interface Token {
    boolean saveToken() default false;
    boolean validateToken() default false;
    String  nameOfPageBean() default Constants.NAMEOFPAGEBEAN;
    String  nameOfIdInPb() default Constants.NAMEOFIDINPB;
    String  nameOfObject() default Constants.NAMEOFOBJECT;
    String  nameOfId() default Constants.NAMEOFID;
}