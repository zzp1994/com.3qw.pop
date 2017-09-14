/**
 * 
 */
package com.mall.interceptor;

import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

/**
 * @author jianping.gao
 * 
 *         Override org.springframework.web.servlet.i18n.LocaleChangeInterceptor
 *         class
 * 
 *         If you are interested in it ,you would read it from spring resource
 *
 */
public class LocaleChangeInterceptor extends HandlerInterceptorAdapter {

	/**
	 * Default name of the locale specification parameter: "locale".
	 */
	public static final String DEFAULT_PARAM_NAME = "locale";

	private String paramName = DEFAULT_PARAM_NAME;

	/**
	 * Set the name of the parameter that contains a locale specification in a
	 * locale change request. Default is "locale".
	 */
	public void setParamName(String paramName) {
		this.paramName = paramName;
	}

	/**
	 * Return the name of the parameter that contains a locale specification in
	 * a locale change request.
	 */
	public String getParamName() {
		return this.paramName;
	}

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler)
			throws ServletException {

		String newLocale = request.getParameter(this.paramName);
/*		if (newLocale != null) {
			LocaleResolver localeResolver = RequestContextUtils
					.getLocaleResolver(request);
			if (localeResolver == null) {
				throw new IllegalStateException(
						"No LocaleResolver found: not in a DispatcherServlet request?");
			}
			Locale locale = new Locale("en", "US");
			if (newLocale.equals("zh") || newLocale.equals("zh_CN")) {
				locale = new Locale("zh", "CN");

			} else if (newLocale.equals("en")) {
				locale = new Locale("en", "US");

			}
			localeResolver.setLocale(request, response, locale);
		}*/


		// pop项目第一期不要英文
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
		Locale locale = new Locale("zh", "CN");
		localeResolver.setLocale(request, response, locale);

		// Proceed in any case.
		return true;
	}

}
