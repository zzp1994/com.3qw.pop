package com.mall.interceptor;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.rubyeye.xmemcached.MemcachedClient;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.resource.DefaultServletHttpRequestHandler;

import com.alibaba.fastjson.JSON;
import com.mall.annotation.Token;
import com.mall.mybatis.utility.PageBean;
import com.mall.utils.Common;
import com.mall.utils.Constants;
import com.mall.utils.CookieTool;

public class TokenInterceptor extends HandlerInterceptorAdapter {

	/**
	 * spring 注入memcachedClient .
	 */
	@Autowired
	private MemcachedClient memcachedClient;

	/**
	 * spring 注入CookieLocaleResolver .
	 */
	@Autowired
	public CookieLocaleResolver localeResolver;
	/**
	 * The timestamp used most recently to generate a token value.
	 */
	private long previous;

	public MemcachedClient getMemcachedClient() {
		return memcachedClient;
	}

	public void setMemcachedClient(MemcachedClient memcachedClient) {
		this.memcachedClient = memcachedClient;
	}

	/**
	 * Logger.
	 */
	private static final Logger LOGGER = Logger
			.getLogger(TokenInterceptor.class);

	/**
	 * <p>
	 * 防止重复提交过滤器
	 * </p>
	 *
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String url = request.getServletPath();
		List<String> noLoginURL = isUeditorHtml();
		boolean flag = isfilterChain(url, noLoginURL);
		if (flag) {
			return true;
		}
		if (handler instanceof DefaultServletHttpRequestHandler) {
			return true;
		}
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		Method method = handlerMethod.getMethod();
		Token annotation = method.getAnnotation(Token.class);
		if (annotation != null) {
			boolean needSaveSession = annotation.saveToken();
			if (needSaveSession) {
				Cookie cookie = CookieTool.getCookie(request,
						Constants.SESSION_ID);
				String sid = request.getSession().getId();
				if (cookie != null) {
					sid = cookie.getValue();
				} else {
					CookieTool.setCookie(response, Constants.SESSION_ID, sid,
							Constants.OUT_TIME_1800);
				}
				String token = generateToken(request);
				request.getSession(false).setAttribute(Constants.TOKEN, token);
				if (null == memcachedClient.get(sid + "token")) {
					memcachedClient.add(sid + "token", Constants.OUT_TIME_1800,
							token);
				} else {
					memcachedClient.replace(sid + "token",
							Constants.OUT_TIME_1800, token);
				}
				LOGGER.info("memcachedClient token+"
						+ memcachedClient.get(sid + "token"));

			}

			boolean needRemoveSession = annotation.validateToken();
			if (needRemoveSession) {
				Cookie cookie = CookieTool.getCookie(request,
						Constants.SESSION_ID);
				String sid = "";
				if (cookie != null) {
					sid = cookie.getValue();
				}
				if (isTokenValid(sid, request.getParameter("token"))) {
					LOGGER.warn("请勿重复提交, url:" + request.getServletPath());
					if (request.getHeader("USER-AGENT").toLowerCase()
							.indexOf("msie") > 0) {
						response.setContentType("text/plain;charset=GBK");
					} else {
						response.setContentType("html;charset=GBK");
					}
					response.setHeader("Cache-Control", "no-cache");
					String language = localeResolver.resolveLocale(request)
							.getLanguage();
					if (!"zh".equals(language)) {
						response.getWriter()
								.write("<script language='javascript'>alert('Please do not submit duplicate!'); window.location.href='"
										+ request.getHeader("referer")
										+ "'</script>");
					} else {
						response.getWriter().write(
								"<script language='javascript'>alert('请勿重复提交！'); window.location.href='"
										+ request.getHeader("referer")
										+ "'</script>");
					}
					return false;
				}
				if (!Constants.NAMEOFID.equals(annotation.nameOfId())) {
					LOGGER.info("验证用户操作ID是否在 可操作的id列表中");
					if (!isIdInList(request.getParameter("token"),
							request.getParameter(annotation.nameOfId()))) {
						LOGGER.warn("非法的用户操作更新或者删除  没有操作此ID的权限, url:"
								+ request.getServletPath() + " id="
								+ request.getParameter(annotation.nameOfId()));
						if (request.getHeader("USER-AGENT").toLowerCase()
								.indexOf("msie") > 0) {
							response.setContentType("text/plain;charset=GBK");
						} else {
							response.setContentType("html;charset=GBK");
						}
						response.setHeader("Cache-Control", "no-cache");
						String language = localeResolver.resolveLocale(request)
								.getLanguage();
						if (!"zh".equals(language)) {
							response.getWriter()
									.write("<script language='javascript'>alert('invalid operation!'); window.location.href='"
											+ request.getHeader("referer")
											+ "'</script>");
						} else {
							response.getWriter().write(
									"<script language='javascript'>alert('无效的操作!'); window.location.href='"
											+ request.getHeader("referer")
											+ "'</script>");
						}
						return false;
					}

				}
				memcachedClient.delete(sid + "token");
			}
		}
		return true;
	}

	/**
	 * This implementation is empty.
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if (handler instanceof DefaultServletHttpRequestHandler) {
			return;
		}
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		Method method = handlerMethod.getMethod();
		Token annotation = method.getAnnotation(Token.class);
		// 是否有注解的标签
		if (annotation != null) {
			String pbName = annotation.nameOfPageBean();
			String idNameInPb = annotation.nameOfIdInPb();
			String objName = annotation.nameOfObject();
			String idName = annotation.nameOfId();
			List<String> idList = new ArrayList<String>();
			// 如果 注解的idNameInPb 不等于默认值 就表明需要 遍历pageBean 控制操作元素的ID集合
			if (!Constants.NAMEOFIDINPB.equals(idNameInPb)) {
				Object pb = modelAndView.getModel().get(pbName);
				if (null != pb && pb instanceof PageBean<?>) {
					PageBean<?> pageBean = (PageBean<?>) pb;
					List<?> list = pageBean.getResult();
					for (Object object : list) {
						Field[] fields = object.getClass().getDeclaredFields();
						for (int j = 0; j < fields.length; j++) {
							fields[j].setAccessible(true);
							// 字段名
							if (idNameInPb.equals(fields[j].getName())) {
								idList.add(fields[j].get(object).toString());
								// System.out.print( fields[j].getName()+ "="+
								// fields[j].get(object));
							}
						}
					}
				}
			}
			;

			// 如果 注解的nameOfId 不等于默认值 就表明需要 遍历Object对象 控制操作元素的ID
			if (!Constants.NAMEOFID.equals(idName)) {
				Object obj = modelAndView.getModel().get(objName);
				if (null != obj) {
					Field[] fields = obj.getClass().getDeclaredFields();
					for (int j = 0; j < fields.length; j++) {
						fields[j].setAccessible(true);
						// 字段名
						if (idName.equals(fields[j].getName())) {
							idList.add(fields[j].get(obj).toString());
							// System.out.print( fields[j].getName()+ "="+
							// fields[j].get(obj));
						}
					}
				}
			}
			;
			// 前提是已放入needSaveSession 注解 Session对象中有token值 else(什么也不做)
			if (idList.size() > 0) {
				String token = (String) request.getSession().getAttribute(
						Constants.TOKEN);
				if (!Common.isEmpty(token)) {
					if (null == memcachedClient.get(token)) {
						memcachedClient.add(token, Constants.OUT_TIME_1800,
								idList);
					} else {
						memcachedClient.replace(token, Constants.OUT_TIME_1800,
								idList);
					}
				}
				LOGGER.info("memcachedClient IdList="
						+ JSON.toJSONString(memcachedClient.get(token)));
			}
		}
		;
	}

	/**
	 * validate token
	 */
	private boolean isTokenValid(String sid, String clinetToken)
			throws Exception {
		// 获取sid 获取缓存中token
		String serverToken = memcachedClient.get(sid + "token");
		if (Common.isEmpty(serverToken)) {
			LOGGER.warn("服务端Token为空");
			return true;
		}
		if (Common.isEmpty(clinetToken)) {
			LOGGER.warn("客户端Token为空");
			return true;
		}
		if (!serverToken.equals(clinetToken)) {
			LOGGER.warn("Token不一致  服务端Token:" + serverToken + " 客户端Token:="
					+ clinetToken + ",可能非法请求或重复提交.");
			return true;
		}
		return false;
	}

	/**
	 * validate id is in idList
	 */
	private boolean isIdInList(String token, String id) throws Exception {
		if (Common.isEmpty(token) || Common.isEmpty(id)) {
			return false;
		} else {
			List<String> idList = memcachedClient.get(token);
			memcachedClient.delete(token);
			if (null != idList) {
				if (idList.contains(id)) {
					return true;
				}
			}
			return false;
		}

	}

	/**
	 * Generate a new transaction token, to be used for enforcing a single
	 */
	public synchronized String generateToken(HttpServletRequest request) {
		try {
			byte id[] = request.getSession().getId().getBytes();
			long current = System.currentTimeMillis();
			if (current == previous) {
				current++;
			}
			previous = current;

			byte now[] = new Long(current).toString().getBytes();
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(id);
			md.update(now);
			return toHex(md.digest());
		} catch (Exception e) {
			return null;
		}

	}

	/**
	 * Convert a byte array to a String of hexadecimal digits and return it.
	 * 
	 * @param buffer
	 *            The byte array to be converted
	 */
	private String toHex(byte buffer[]) {
		StringBuffer sb = new StringBuffer(buffer.length * 2);
		for (int i = 0; i < buffer.length; i++) {
			sb.append(Character.forDigit((buffer[i] & 0xf0) >> 4, 16));
			sb.append(Character.forDigit(buffer[i] & 0x0f, 16));
		}
		return sb.toString();
	}

	/***
	 * 涉及到Ueditor 会导致类型转换错误 故排除这两个页面.
	 * **/
	public List<String> isUeditorHtml() {
		List<String> result = new ArrayList<String>();
		result.add("/download");
		result.add("/product/");
		result.add("/img");
		result.add("/product/imageUp");
		result.add("/product/add");
		result.add("/product/editProduct");
		return result;
	}

	/**
	 * 是否可以访问.
	 * 
	 * @param url
	 *            url
	 * @param str
	 *            str的List
	 * @return boolean
	 * **/
	public boolean isfilterChain(String url, List<String> str) {

		boolean result = false;
		if (str == null) {
			return false;
		}
		for (String ss : str) {
			if (url.indexOf(ss) != -1) {
				result = true;
				break;
			}
		}
		return result;
	}
}