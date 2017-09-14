package com.mall.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieTool {

	public static String cookieDomain = "";

	public static String cookiePath = "/";

	/**
	 * 获取COOKIE
	 * 
	 * @param request
	 * @param name
	 */
	public static Cookie getCookie(HttpServletRequest request, String name) {
		Cookie[] cookies = request.getCookies();
		if (cookies == null)
			return null;
		for (int i = 0; i < cookies.length; i++) {
			if (name.equals(cookies[i].getName())) {
				return cookies[i];
			}
		}
		return null;
	}

	/**
	 * 设置COOKIE
	 * 
	 * @param request
	 * @param response
	 * @param name
	 * @param value
	 * @param maxAge
	 */
	public static void setCookie(HttpServletResponse response, String name,
			String value, int maxAge) {
		/*
		 * Cookie cookie = new Cookie(name, value); cookie.setMaxAge(maxAge);
		 * if(cookieDomain!=null && cookieDomain.indexOf('.')!=-1) {
		 * cookieDomain="."+cookieDomain; cookie.setDomain('.' + cookieDomain);
		 * } cookie.setPath(cookiePath);
		 */
		// String
		// cookie=name+"="+value+";Path="+cookiePath+";Domain="+cookieDomain+";Max-Age="+maxAge+";HttpOnly";
		// response.addHeader("Set-Cookie",
		// "__wsidd=hhghgh;Path=/;Domain=wap.domain.cn;Max-Age=36000;HTTPOnly");
		// response.addHeader("Set-Cookie",cookie);
		// response.addHeader("set-", value);

		Cookie cookie = new Cookie(name, value);
		cookie.setMaxAge(maxAge);
		if (cookieDomain != null && cookieDomain.indexOf('.') != -1) {
			cookie.setDomain('.' + cookieDomain);
		}
		cookie.setPath(cookiePath);
		response.addCookie(cookie);
	}

	/**
	 * 从URL地址中解析出URL前缀，例如 http://www.sina.com.cn:8081/index.jsp ->
	 * http://www.sina.com.cn:8081
	 * 
	 * @param request
	 * @return
	 */
	public static String getUrlPrefix(HttpServletRequest request) {
		StringBuffer url = new StringBuffer(request.getScheme());
		url.append("://");
		url.append(request.getServerName());
		int port = request.getServerPort();
		if (port != 80) {
			url.append(":");
			url.append(port);
		}
		return url.toString();
	}

	/**
	 * 获取访问的URL全路径
	 * 
	 * @param request
	 * @return
	 */
	public static String getRequestURL(HttpServletRequest request) {
		StringBuffer url = new StringBuffer(request.getRequestURI());
		String param = request.getQueryString();
		if (param != null) {
			url.append('?');
			url.append(param);
		}
		String path = url.toString();
		return path.substring(request.getContextPath().length());
	}

	/**
	 * 清除所有cookie.
	 * 
	 * @param req
	 * @param res
	 */
	public static void clear(HttpServletRequest req, HttpServletResponse res,
			String remain) {
		Cookie[] cookies = req.getCookies();
		for (int i = 0, len = cookies.length; i < len; i++) {
			if (remain != null && !"".equals(remain)
					&& cookies[i].getName().equals(remain)) {
				continue;
			}
			Cookie cookie = new Cookie(cookies[i].getName(), null);
			cookie.setMaxAge(0);
			cookie.setPath("/");
			res.addCookie(cookie);
		}
	}
}
