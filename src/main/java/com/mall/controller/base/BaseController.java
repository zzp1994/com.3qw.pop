package com.mall.controller.base;

import java.io.BufferedInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.rubyeye.xmemcached.MemcachedClient;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.alibaba.fastjson.JSON;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.supplier.model.Supplier;
import com.mall.supplier.model.SupplierBrandDTO;
import com.mall.supplier.model.SupplierUser;
import com.mall.utils.Common;
import com.mall.utils.Constants;
import com.mall.utils.CookieTool;

/**
 * Controller中公用的方法抽象到该类.
 * 
 * @author wangdj
 */
public class BaseController extends MultiActionController {
	/**
	 * Sping注入mencached缓存客户端.
	 */
	@Autowired
	public MemcachedClient memcachedClient;
	/**
	 * spring 注入CookieLocaleResolver .
	 */
	@Autowired
	public CookieLocaleResolver localeResolver;

	/**
	 * log.
	 */
	private static final Logger BASELOGGER = Logger
			.getLogger(BaseController.class);

	/**
	 * 语言(en or zh).
	 * 
	 * @return String language
	 */
	public String getLanguage() {
		String language = localeResolver.resolveLocale(getRequest())
				.getLanguage();
		if (!"zh".equals(language)) {
			language = "en";
		}
		return "/" + language;
	}

	/**
	 * 获取子供应商品牌信息
	 * 
	 * @return
	 */
	public String[] getBrandsBySubSupplierId() {

		String[] brands = {};

		try {
			List<SupplierBrandDTO> sBrands = new ArrayList<SupplierBrandDTO>();

			sBrands = RemoteServiceSingleton.getInstance()
					.getSupplierBrandManagerService()
					.findSupplierBrandsBySubSupplierId(getCurrentSupplierId());

			List<String> sysBrands = new ArrayList<String>();

			for (SupplierBrandDTO supplierBrandDTO : sBrands) {

				Long systemBrandId = supplierBrandDTO.getSystemBrandId();
				if (null != systemBrandId && 0 != systemBrandId) {
					sysBrands.add("" + systemBrandId);

				}
			}

			brands = sysBrands.toArray(new String[sysBrands.size()]);

			logger.info("getBrandsBySubSupplierId() 供应商id："
					+ getCurrentSupplierId() + "----------- brands:"
					+ JSON.toJSONString(brands));
		} catch (Exception e) {
			logger.error("获取品牌信息失败！！！" + e.getMessage(), e);

		}
		return brands;
	}

	/**
	 * 获取供应商品牌信息
	 * 
	 * @return
	 */
	public String[] getBrandsBySupplierId() {

		String[] brands = {};

		try {
			List<SupplierBrandDTO> sBrands = new ArrayList<SupplierBrandDTO>();

			sBrands = RemoteServiceSingleton.getInstance()
					.getSupplierBrandManagerService()
					.findSupplierBrandsBySupplierId(getCurrentSupplierId());

			List<String> sysBrands = new ArrayList<String>();

			for (SupplierBrandDTO supplierBrandDTO : sBrands) {

				Long systemBrandId = supplierBrandDTO.getSystemBrandId();
				if (null != systemBrandId && 0 != systemBrandId) {
					sysBrands.add("" + systemBrandId);

				}
			}

			brands = sysBrands.toArray(new String[sysBrands.size()]);
			logger.info("getBrandsBySupplierId() 供应商id："
					+ getCurrentSupplierId() + " brands:"
					+ JSON.toJSONString(brands));
		} catch (Exception e) {
			logger.error("获取品牌信息失败！！！" + e.getMessage(), e);

		}
		return brands;
	}

	/**
	 * http request请求.
	 */
	private HttpServletRequest request;

	/**
	 * 此方法用于日期的转换.
	 * 
	 * @param binder
	 *            date
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(true);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				dateFormat, true));
	}

	/**
	 * 功能：该方法将request对象中的值封装到相应的pojo对象中.
	 * 
	 * @param obj
	 *            对象
	 * @param request
	 *            HttpServletRequest
	 */
	public static void getObjectFromRequest(Object obj,
			HttpServletRequest request) {
		Class<?> cla = obj.getClass();// 获得对象类型
		Field field[] = cla.getDeclaredFields();// 获得该类型中的所有属性
		for (int i = 0; i < field.length; i++) {// 遍历属性列表
			field[i].setAccessible(true);// 禁用访问控制检查
			Class<?> fieldType = field[i].getType();// 获得属性类型
			String attr = request.getParameter(field[i].getName());// 获得属性值
			if (attr == null) {// 如果属性值为null则不做任何处理，直接进入下一轮循环
				continue;
			}
			/**
			 * 根据对象中属性类型的不同，将request对象中的字符串转换为相应的属性
			 */
			try {
				if (fieldType == String.class) {
					field[i].set(obj, attr);
				} else if (fieldType == int.class || fieldType == Integer.class) {// 当转换失败时，设置0
					field[i].set(obj, Integer.parseInt(request
							.getParameter(field[i].getName())));
				} else if (fieldType == long.class || fieldType == Long.class) {// 当转换失败时，设置0
					field[i].set(obj, Long.parseLong(request
							.getParameter(field[i].getName())));
				} else if (fieldType == Date.class) {// 当转换失败时，设置为null
					field[i].set(obj, Common.stringToDate(
							request.getParameter(field[i].getName()),
							"yyyy-MM-dd"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
	}

	/**
	 * 功能：cookie中取出Session_id 然后去Xmemcacaed中取当前登录用户.
	 * 
	 * @return SupplierUser 用户
	 */
	public SupplierUser getCurrentUser() {
		Cookie cookie = CookieTool
				.getCookie(getRequest(), Constants.SESSION_ID);
		if (cookie != null) {
			try {
				SupplierUser user = (SupplierUser) memcachedClient.get(cookie
						.getValue());
				return user;
			} catch (Exception e) {
				BASELOGGER.error(
						"分布式缓存中没有sid=" + cookie.getValue() + "的用户"
								+ e.getMessage(), e);
			}

		}
		return null;
	}

	/**
	 * 功能：cookie中取出Session_id 然后去Xmemcacaed中取当前登录用户.
	 * 
	 * @return SupplierUser 用户
	 */
	public Long getCurrentUserId() {
		Cookie cookie = CookieTool
				.getCookie(getRequest(), Constants.SESSION_ID);
		if (cookie != null) {
			try {
				SupplierUser user = (SupplierUser) memcachedClient.get(cookie
						.getValue());
				return user.getUserId();
			} catch (Exception e) {
				BASELOGGER.error(
						"分布式缓存中没有sid=" + cookie.getValue() + "的用户"
								+ e.getMessage(), e);
			}

		}
		return null;
	}

	public List<Long> getSupplierIds() {
		List<Long> ids = new ArrayList<Long>();

		ids.add(getCurrentSupplierId());

		String companyNature = getSupplier().getCompanyNature();

		if (Constants.MANUFACTURER_TRADERS.equals(companyNature)
				|| Constants.TRADERS.equals(companyNature)) {
			List<Long> list = RemoteServiceSingleton.getInstance()
					.getSupplierManagerService()
					.getSubSupplierIdsByPid(getCurrentSupplierId());
			ids.addAll(list);
		}

		return ids;
	}

	/**
	 * 当前用户类型
	 * 
	 * @return 1:生产商 2:贸易商 3:国内经销商 4:子供应商 5:生产商&贸易商
	 */
	public String getSupplierType() {

		String type = "" + Constants.SYSTEM_ERROR;

		Supplier supplier = getSupplier();

		if (null != supplier) {

			type = supplier.getCompanyNature();
		} else {

			type = "" + Constants.SYSTEM_ERROR;
		}

		logger.info("供应商类型：1:生产商  2:贸易商  3:国内经销商 4:子供应商  5:生产商&贸易商-----------"
				+ type);
		return type;

	}

	/**
	 * 功能：cookie中取出Session_id 然后去Xmemcacaed中取当前登录用户商户ID.
	 * 
	 * @return 用户商户ID
	 */
	public Long getCurrentSupplierId() {

		SupplierUser user = getCurrentUser();

		if (user != null) {
			return user.getSupplierId();
		}
		return null;
	}

	/**
	 * 功能：cookie中取出Session_id.
	 * 
	 * @return Session_id
	 */
	public String getSessionId() {

		Cookie cookie = CookieTool
				.getCookie(getRequest(), Constants.SESSION_ID);
		if (cookie != null) {
			return cookie.getValue();
		}
		return "";
	}

	/**
	 * 功能：cookie中取出Session_id 然后去Xmemcacaed中取当前登录用户.
	 * 
	 * @return SupplierUser 用户
	 */
	public Supplier getSupplier() {
		Cookie cookie = CookieTool
				.getCookie(getRequest(), Constants.SESSION_ID);
		if (cookie != null) {
			try {
				Supplier supplier = (Supplier) memcachedClient.get(cookie
						.getValue() + Constants.SUPPLIER);
				return supplier;
			} catch (Exception e) {
				logger.error(
						"分布式缓存中没有sid=" + cookie.getValue() + "的商户"
								+ e.getMessage(), e);
			}

		}
		return null;
	}

	/**
	 * 功能：下载.
	 * 
	 * @param response
	 *            HttpServletResponse
	 * @param filepath
	 *            图片服务器给的URL
	 *            (例如：group1/M00/00/00/wKgBOlOzgFCAKzT5AAVg-j-S1to345.jpg)
	 *            (例如1：Http
	 *            ://192.168.1.59/group1/M00/00/00/wKgBOlOzgFCAKzT5AAVg-
	 *            j-S1to345.jpg)
	 * @param fileName
	 *            要显示的文件名称
	 */
	public void download(HttpServletResponse response, String filepath,
			String fileName) {
		String old_url = filepath;
		String realName = null;
		if (Common.isEmpty(fileName)) {
			realName = filepath.substring(filepath.lastIndexOf("/"));
		} else {
			realName = fileName;
		}
		// 进行编码转换，防止不能正确显示中文名
		try {
			response.reset();
			if (!old_url.startsWith("Http")) {
				old_url = Constants.FILESERVER1 + old_url;
			}
			logger.info("下载文件路径：" + old_url);
			URL url = new URL(old_url);
			HttpURLConnection uc = (HttpURLConnection) url.openConnection();
			uc.setDoInput(true);// 设置是否要从 URL 连接读取数据,默认为true
			uc.connect();
			InputStream iputstream = uc.getInputStream();
			// 设置响应类型和响应头
			response.setContentType("application/x-msdownload;charset=UTF-8");
			response.setContentLength(uc.getContentLength());
			String userAgent = getRequest().getHeader("User-Agent");
			// name.getBytes("UTF-8")处理safari的乱码问题
			/*
			 * realName = userAgent.contains("Firefox") ? new
			 * String(fileName.getBytes
			 * ("GB2312"),"ISO-8859-1"):URLEncoder.encode(fileName, "UTF-8") ;
			 * // 文件名外的双引号处理firefox的空格截断问题
			 * response.setHeader("Content-disposition"
			 * ,"attachment; filename="+realName);
			 */
			if (userAgent.contains("Firefox"))
				response.addHeader(
						"Content-Disposition",
						"attachment;filename="
								+ new String(realName.getBytes("GB2312"),
										"ISO-8859-1"));
			else
				response.addHeader(
						"Content-Disposition",
						"attachment;filename="
								+ URLEncoder.encode(realName, "UTF-8"));
			// 读取文件
			BufferedInputStream bis = new BufferedInputStream(iputstream);
			ServletOutputStream output = response.getOutputStream();
			byte[] buf = new byte[Constants.PUBLIC_STATIC_NUM_1024];
			int r = 0;
			while ((r = bis.read(buf)) != -1) {
				output.write(buf, 0, r);
			}
			// 释放资源
			iputstream.close();
			bis.close();
			output.flush();
			output.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 功能：该方法将PTO对象转化成JSON传给前台.
	 * 
	 * @param obj
	 *            输出对象
	 * @param response
	 *            HttpServletResponse
	 */
	public static void responseJson(Object obj, HttpServletResponse response) {
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.write(JSON.toJSONString(obj));
			BASELOGGER.info("响应JSON：" + JSON.toJSONString(obj));
		} catch (Exception e) {
			BASELOGGER.error(e.getMessage(), e);
		} finally {
			if (null != out) {
				out.flush();
				out.close();
			}
		}
	}

	public HttpServletRequest getRequest() {
		RequestAttributes ra = RequestContextHolder.getRequestAttributes();
		this.request = ((ServletRequestAttributes) ra).getRequest();
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

}
