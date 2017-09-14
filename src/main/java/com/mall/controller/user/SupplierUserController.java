package com.mall.controller.user;

import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.common.utils.StringUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.mall.annotation.Token;
import com.mall.controller.base.BaseController;
import com.mall.csec.ApiRequest;
import com.mall.csec.ApiResponse;
import com.mall.csec.BspAPI;
import com.mall.customer.dto.HomeNumRecordDto;
import com.mall.customer.model.User;
import com.mall.customer.service.HomeNumRecordService;
import com.mall.customer.service.UserService;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.mybatis.utility.PageBean;
import com.mall.supplier.model.Supplier;
import com.mall.supplier.model.SupplierMenu;
import com.mall.supplier.model.SupplierRole;
import com.mall.supplier.model.SupplierUser;
import com.mall.supplier.model.SupplierUserRole;
import com.mall.supplier.model.SupplierUserRoleDTO;
import com.mall.supplier.service.SupplierManagerService;
import com.mall.utils.Common;
import com.mall.utils.Constants;
import com.mall.utils.CookieTool;
import com.mall.utils.MD5;
import com.mall.utils.SendSMSUtil;

/**
 * 跳转用户登录页面.
 * 
 * @author wdj
 */
@Controller
public class SupplierUserController extends BaseController {
	
	
	@Autowired
	private HomeNumRecordService homeNumRecordService;
	@Autowired
	private SupplierManagerService supplierManagerServiceImpl;
	/**
	 * log.
	 */
	private static final Logger logger = Logger
			.getLogger(SupplierUserController.class);
	
	
	
	
	

	/**
	 * 跳转用户登录页面.
	 * 
	 * @param User
	 * @return 添加的用户id
	 */
	@RequestMapping("/user/loginUI")
	public String toLoginUI(Map<String, Object> map, String lang,
			HttpServletRequest request, HttpServletResponse response) {
		String uid = UUID.randomUUID().toString();
		map.put("uid", uid);
		try {
			memcachedClient.set(uid, 60 * 60, uid);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return "/user/login";
	}
	
	
/*	@RequestMapping("/user/loginUI2")
	public String toLoginUI2(Map<String, Object> map, String lang,
			HttpServletRequest request, HttpServletResponse response) {
		String uid = UUID.randomUUID().toString();
		map.put("uid", uid);
		try {
			memcachedClient.set(uid, 60 * 60, uid);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return "/user/login2";
	}*/

	/**
	 * 跳转用户登录页面.
	 * 
	 * @param User
	 * @return 添加的用户id
	 */
	@RequestMapping("/user/index")
	public String index() {
		return getLanguage() + "/user/index";
	}

	/**
	 * @Description: 获取用户列表.
	 * @param map
	 *            返回Map
	 * @param paramUser
	 *            查询参数
	 * @param paramPage
	 *            分页对象
	 * @param request
	 *            请求
	 * @return String 返回类型
	 * @author wangdj
	 */
	@RequestMapping("/user/list")
	@Token(saveToken = true, nameOfPageBean = "page", nameOfIdInPb = "userId")
	public String userList(Map<String, Object> map, SupplierUser paramUser,
			PageBean<SupplierUser> paramPage, HttpServletRequest request) {
		if (paramPage.getPage() < 0) {
			paramPage.setPage(1);
		}
		// 查询参数 当前用户的商户id (supplierId)
		paramUser.setSupplierId(getCurrentSupplierId());
		// 查询参数 未被删除用户
		paramUser.setStatus(1);
		// 查询参数 分页大小
		paramPage.setPageSize(Constants.PAGE_NUM_TEN);
		// 查询参数 排序字段
		paramPage.setSortFields("user_id");
		// 查询参数 升序降序
		paramPage.setOrder("asc");
		// 查询对象放到 parameter中
		paramPage.setParameter(paramUser);
		// 结果list插入PageBean
		paramPage = RemoteServiceSingleton.getInstance()
				.getSupplierUserManagerService().getPageList(paramPage);
		// PageBean放入map 给前台
		map.put("page", paramPage);
		// 查询当前商户的角色-用户 VO
		List<SupplierUserRoleDTO> voList = RemoteServiceSingleton.getInstance()
				.getSupplierUserManagerService()
				.findUsersBySupplierId(getCurrentSupplierId());
		Map<String, String> mapvo = new HashMap<String, String>();
		for (SupplierUserRoleDTO vo : voList) {
			if (vo == null) {
				continue;
			}
			mapvo.put(vo.getUsername(), vo.getRolename());
		}
		map.put("mapvo", mapvo);
		// 查询当前商户的角色

		List<Long> ids = new ArrayList<Long>();
		Supplier supplier = RemoteServiceSingleton.getInstance()
				.getSupplierManagerService()
				.findSupplier(getCurrentSupplierId());
		if (null != supplier) {
			ids.add(supplier.getSupplierId());
		}
		List<SupplierRole> roles = RemoteServiceSingleton.getInstance()
				.getSupplierRoleManagerService().selectRolesBySupplierIds(ids);
		// 下拉列表用角色
		map.put("roles", roles);
		if (null != roles) {
			Map<String, String> rolemap = new HashMap<String, String>();
			for (SupplierRole role : roles) {
				if (role == null) {
					continue;
				}
				rolemap.put(role.getName(), role.getRoleId() + "");
			}
			map.put("rolemap", rolemap);
		}
		return getLanguage() + "/user/list";
	}

	/**
	 * 注册用户名验证.
	 * 
	 * @param pin
	 *            用户名称
	 * @param response
	 *            HttpServletResponse
	 * @return int count
	 */
	@RequestMapping("/user/isPinEngaged")
	@ResponseBody
	public String isPinEngaged(String pin, HttpServletResponse response) {
		Map<String, String> pmap = new LinkedHashMap<String, String>();
		int count = 1;
		if (!Common.isEmpty(pin)) {
			pmap.put("loginName", pin);
			count = RemoteServiceSingleton.getInstance()
					.getSupplierUserManagerService().getUserByName(pmap);
		}
		return count + "";
	}
	

	
	/**
	 * 获取注册的验证码
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	public String getRegCode(Model model, HttpServletRequest request,
			HttpServletResponse response) {
		String mobile = request.getParameter("mobile");
		String captcha = request.getParameter("captcha");
		String uid = request . getParameter("uid");
		logger.info("mobile value is : " + mobile);
		logger.info("captcha value is : " + captcha);
		
		
		String sid =getSessionId();
		String memcachedCaptcha = null;
		
		try {
				memcachedCaptcha = memcachedClient.get(uid
						+ Constants.KAPTCHA_SESSION_KEY);
		} catch (Exception e2) {
			e2.printStackTrace();
		} 
		logger.info("memcachedCaptcha value is : " + memcachedCaptcha);
		//传入的验证码和缓存中的验证码不一样
		if(!captcha.equalsIgnoreCase(memcachedCaptcha)){
			return "captchaError";
		}
		
		
	
		Integer msgCode = SendSMSUtil.sendMessage(mobile);
		if (msgCode != null) {
			try {
				logger.info("mobile :" + mobile + "---msgCode:" + msgCode);
				memcachedClient.setOpTimeout(5000L);
				// 缓存电话
				memcachedClient.set(Constants.SEND_REG_MESSAGE +mobile + "mobile", Constants.MEMCACHEDAGE, mobile);
				// 缓存验证码
				memcachedClient.set(Constants.SEND_REG_MESSAGE + mobile,Constants.MEMCACHEDAGE, msgCode);
			
			} catch (Exception e) {
				logger.info("send message error...." + mobile);
			}
			return "success"; // 发送成功
		}

		return "error";
	}
	
	
	public String getRegCode2(Model model, HttpServletRequest request,
			HttpServletResponse response) {
		String mobile = request.getParameter("mobile");
		String captcha = request.getParameter("captcha");
		String uid = request . getParameter("uid");
		logger.info("mobile value is : " + mobile);
		logger.info("captcha value is : " + captcha);
		
		
		String sid =getSessionId();
		String memcachedCaptcha = null;
		
		try {
				memcachedCaptcha = memcachedClient.get(uid
						+ Constants.KAPTCHA_SESSION_KEY);
		} catch (Exception e2) {
			e2.printStackTrace();
		} 
		logger.info("memcachedCaptcha value is : " + memcachedCaptcha);
		//传入的验证码和缓存中的验证码不一样
		/*if(!captcha.equalsIgnoreCase(memcachedCaptcha)){
			return "captchaError";
		}*/
		
		
	
		Integer msgCode = SendSMSUtil.sendMessage(mobile);
		if (msgCode != null) {
			try {
				logger.info("mobile :" + mobile + "---msgCode:" + msgCode);
				memcachedClient.setOpTimeout(5000L);
				// 缓存电话
				memcachedClient.set(Constants.SEND_REG_MESSAGE +mobile + "mobile", Constants.MEMCACHEDAGE, mobile);
				// 缓存验证码
				memcachedClient.set(Constants.SEND_REG_MESSAGE + mobile,Constants.MEMCACHEDAGE, msgCode);
			
			} catch (Exception e) {
				logger.info("send message error...." + mobile);
			}
			return "success"; // 发送成功
		}

		return "error";
	}

	/**
	 * 注册用户名验证.
	 * 
	 * @param pin
	 *            商户名称名称校验
	 * @param response
	 *            HttpServletResponse
	 * @return int count
	 */
	@RequestMapping("/user/isPinName")
	@ResponseBody
	public String isPinName(String stringName, HttpServletResponse response){
		System.out.println("********************"+stringName.trim());
		System.out.println("_______________________"+stringName);
		Map<String, String> pmap = new LinkedHashMap<String, String>();
		int count = 1;
		if (!Common.isEmpty(stringName.trim())) {
			pmap.put("companyName", stringName.trim());
			int num = RemoteServiceSingleton.getInstance().getSupplierManagerService().getSuppliersByName(stringName.trim());
			if(num>0){
				count = 1;
			}else {
				count = 0;
			}
			
		}
		return count + "";
	}
	
	/**
	 * 获取注册的请求吗
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/user/getVerificationCode")
	@ResponseBody
	public String getVerificationCode(Model model, HttpServletRequest request,
            HttpServletResponse response) {
		logger.info("toRegGetCode execute start.....................");
        String res = getRegCode(model, request, response);
        logger.info("toRegGetCode execute end.....................");
        logger.info("toRegGetCode result is : " + res);
        return res;
		
	}
	
	@RequestMapping("/user/getVerificationCode2")
	@ResponseBody
	public String getVerificationCode2(Model model, HttpServletRequest request,
            HttpServletResponse response) {
		logger.info("toRegGetCode execute start.....................");
        String res = getRegCode2(model, request, response);
        logger.info("toRegGetCode execute end.....................");
        logger.info("toRegGetCode result is : " + res);
        return res;
		
	}
	
	/**
	 *  修改 密码 原密码校验
	 *  
	 */
	@RequestMapping("/user/isPwd")
	@ResponseBody
	public String isPwd(String pwd1, HttpServletResponse response){
		int flag = 0; //密码 查询 错误
		
		SupplierUser user;
		String pwd = MD5.encrypt(pwd1);//加密 后的 原密码
		
		SupplierUser user1 = getCurrentUser();
		//查询 供应商 用户  
//		user = RemoteServiceSingleton.getInstance().getSupplierUserManagerService().;
		if(pwd.equals(user1.getPassword())){//密码 一致 
			flag = 1;
			return flag+"";
		}
		
		return 0+"";
	}
	
	/**
	 * pop 密码修改
	 * 
	 */
	@RequestMapping("/user/forUpdatePwd")
	@ResponseBody
	public String forUpdatePwd(String pwd3,Map<String,Object> map,HttpServletRequest request,HttpServletResponse response){
		String flag = "0";
		//保存 修改后的 密码
		try {
			SupplierUser user1 = getCurrentUser();
			user1.setPassword(MD5.encrypt(pwd3));
			int count = RemoteServiceSingleton.getInstance().getSupplierUserManagerService().update(user1);
			logger.info("修改密码 成功"+count+" : "+MD5.encrypt(pwd3));
			return "1";
		} catch (Exception e) {
			logger.info("SupplierUser update fail..."+e);
		}
		
		map.put("language", getLanguage().substring(1));
//		return getLanguage()+"/user/updatePwd";
		return flag;
	}
	
	private String getIpAddr(HttpServletRequest request) {
	    String ip = request.getHeader("x-forwarded-for");
	    if(ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {
	        ip = request.getRemoteAddr();
	    }
	    return ip;
	 }
	
	/*** 
	 * 获取客户端IP地址;这里通过了Nginx获取;X-Real-IP, 
	 * @param request 
	 * @return 
	 */  
	private static String getClientIP(HttpServletRequest request) {  
	    String fromSource = "X-Real-IP";  
	    String ip = request.getHeader("X-Real-IP");  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("X-Forwarded-For");  
	        fromSource = "X-Forwarded-For";  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("Proxy-Client-IP");  
	        fromSource = "Proxy-Client-IP";  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("WL-Proxy-Client-IP");  
	        fromSource = "WL-Proxy-Client-IP";  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getRemoteAddr();  
	        fromSource = "request.getRemoteAddr";  
	    }  
	    //appLog.info("App Client IP: "+ip+", fromSource: "+fromSource);  
	    return ip;  
	}  
	
	/**
	 * 商户用户.
	 * 
	 * @param loginname
	 *            name
	 * @param password
	 *            此处为未经过md5加密的密码
	 * @param request
	 *            请求
	 * @param response
	 *            response
	 * @return 返回登录成功的用户id
	 */
	/*@RequestMapping("/user/login")
	public String loginUser(String loginname, String password, String kaptcha,
			HttpServletRequest request, HttpServletResponse response,
			String uid, Model model) {
		String kaptchaExpected = "";
		if (Common.isEmpty(uid)) {
			uid = UUID.randomUUID().toString();
			model.addAttribute("uid", uid);
			try {
				memcachedClient.set(uid, 60 * 60, uid);
			} catch (Exception e) {
				logger.error(e.getMessage(), e);
			}
			if (getLanguage().equals("/en")) {
				request.setAttribute("message", " please try again！");
			} else {
				request.setAttribute("message", "登录失败,请重新登录！");
			}
			logger.info("uid为空，请重新登录！");
			return "/user/login";
		}
		try {
			kaptchaExpected = memcachedClient.get(uid
					+ Constants.KAPTCHA_SESSION_KEY);
		} catch (Exception e) {
			logger.error("登录获取服务器验证码失败" + e.getMessage(), e);
		}
		if (!kaptcha.toLowerCase().equals(kaptchaExpected.toLowerCase())) {
			if (getLanguage().equals("/en")) {
				request.setAttribute("message", "Verification code is wrong！");
			} else {
				request.setAttribute("message", "验证码有误！");
			}
			logger.info("登录验证码不一致！");
			return "/user/login";
		}
		if (Common.isEmpty(password) || Common.isEmpty(loginname)) {
			request.setAttribute("loginname", loginname);
			if (getLanguage().equals("/en")) {
				request.setAttribute("message",
						"User name and Password cannot be empty");
			} else {
				request.setAttribute("message", "用户名密码不能为空!");
			}
			logger.info("用户名密码不能为空！");
			return "/user/login";
		}
		
		try {
		*//**-------------------------安防验证开始-----------------------**//*
		Map<String, String> args = new TreeMap<String, String>();

         帐号信息参数 
        args.put("accountType", "0");
        args.put("uid", uid);
        args.put("associateAccount","373909726");
        args.put("nickName", "helloword");
        args.put("phoneNumber", "086+15166666666");
        args.put("emailAddress", "hellword@qq.com");
        args.put("registerTime", "1440416972");
        args.put("registerIp", "121.14.96.121");
        args.put("passwordHash", "f158abb2a762f7919846ee9bf8445c7f22a244c5");

        行为信息参数 
       // getClientIP(request);
        logger.info("getClientIP:" + getClientIP(request));
       // logger.info("getIpAddr:" + getIpAddr(request));
        
        //getIpAddr(request);
        //args.put("loginIp", "121.14.96.121");
        args.put("loginIp", getClientIP(request));
        args.put("loginTime", new Date().getTime()+"");
        args.put("loginSource","4");
        args.put("loginType", "3");
        args.put("referer", "https://ui.ptlogin2.qq.com/cgi-bin/login");
        args.put("jumpUrl", "D692D87319F2098C3877C3904B304706");
        args.put("cookieHash", "D692D87319F2098C3877C3904B304706");
        args.put("userAgent", "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.132 Safari/537.36");
        args.put("xForwardedFor", "121.14.96.121");
        args.put("mouseClickCount", "10");
        args.put("keyboardClickCount", "34");
        args.put("result", "2");
        args.put("reason", "4");

         设备信息 
        args.put("macAddress","00-05-9A-3C-7A-00");
        args.put("vendorId","tencent.com");
        args.put("imei","54654654646");
        args.put("appVersion","10.0.1");

         其他信息 
        args.put("businessId","1");

        String url;
        ApiResponse resCsec=null;
		
		url = BspAPI.makeURL("GET", "LoginProtection", "bj", Constants.CSEC_SECRET_ID, Constants.CSEC_SECRET_KEY, args, "utf-8");
		 resCsec = ApiRequest.sendGet(url, "");
	      //System.out.println(resCsec.getBody());
		 if(resCsec != null){
			 logger.info("安全防护返回的数据:" + resCsec.getBody());
			 JSONObject temp  = JSONObject.fromObject(resCsec.getBody());
			 String code = temp.getString("code");
			 int level = Integer.parseInt(temp.getString("level")==null?"0":temp.getString("level"));
			 if(level > 2 ){
				 request.setAttribute("message", "账户异常，请联系管理员!");
				 return "/user/login";
			 }
		 }
		} catch (InvalidKeyException e1) {
			// TODO Auto-generated catch block
			//e1.printStackTrace();
		} catch (NoSuchAlgorithmException e1) {
			// TODO Auto-generated catch block
			//e1.printStackTrace();
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			//e1.printStackTrace();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			//e1.printStackTrace();
		} 
        
        *//**-------------------------安防验证结束-----------------------**//*
		
		Map<String, String> map = new HashMap<String, String>();
		// 登录方式判断 邮箱 手机或者用户名
		SupplierUser user = null;
		SupplierUser user1 = null;
		map.put("password", MD5.encrypt(password));
		map.put("loginName", loginname);
		user = RemoteServiceSingleton.getInstance()
				.getSupplierUserManagerService().login(map);
	
		//非 pop供应商类型不能登录
		Map<String, String> m=new HashMap<String, String>();
		m.put("loginName", loginname);
		int res= RemoteServiceSingleton.getInstance().getSupplierUserManagerService().getUserByName(m);
		if(res==0){
			if (getLanguage().equals("/en")) {
				request.setAttribute("message","User name password does not match");
			} else {
				request.setAttribute("message", "该用户不存在!");
			}
			return "/user/login";
		}
		
		if(null!=user){
			Supplier supplier1 = RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(user.getSupplierId());
			int supplerType = supplier1.getSupplyType();
			if(51!=supplerType){
				logger.info("用户:" + loginname + "该用户非POP类型供应商!");
				if (getLanguage().equals("/en")) {
					request.setAttribute("message",
							"Your Acount has registed,Please wait for audit!");
				} else {
					request.setAttribute("message", "该用户非POP类型供应商,请注册！");
				}
				return "/user/login";
			}
			if(supplier1.getStatus()!=null&&supplier1.getStatus()==5)
			{
				request.setAttribute("message", "该用户已被冻结");
				return "/user/login";
			}
		}
		if (null != user) {
			if (user.getStatus() == Constants.USER_STATUS_UNCHECK) {
				logger.info("用户:" + loginname + "您已经注册,请等待审核!");
				if (getLanguage().equals("/en")) {
					request.setAttribute("message",
							"Your Acount has registed,Please wait for audit!");
				} else {
					request.setAttribute("message", "您已经注册,请等待审核!");
				}
				return "/user/login";
			} else if (user.getStatus() == Constants.USER_STATUS_CHECKFAIL) {
				logger.info("用户:" + loginname + "您的注册信息,审核未通过!");
				if (getLanguage().equals("/en")) {
					request.setAttribute("message",
							"Your registration information, does not pass the examination!");
				} else {
					request.setAttribute("message", "您的注册信息,审核未通过!");
				}

				return "/user/login";
			} else if (user.getStatus() == Constants.USER_STATUS_DELETED) {
				logger.info("用户:" + loginname + "您的账号已禁用,请联系管理员!");
				if (getLanguage().equals("/en")) {
					request.setAttribute("message",
							"Your account has been disabled, please contact the administrator!");
				} else {
					request.setAttribute("message", "您的账号已禁用,请联系管理员!");
				}
				return "/user/login";
			}
			String sid = request.getSession().getId();
			// 设置cookie的有效期
			CookieTool.setCookie(response, Constants.SESSION_ID, sid,
					Constants.OUT_TIME_FOREVER);
			// 菜单名称key url作为value 前台用
			Map<String, String> menuMap = new HashMap<String, String>();
			// url作为value 拦截器用 过滤URL
			List<String> menuList = new ArrayList<String>();
			List<SupplierMenu> menus = new ArrayList<SupplierMenu>();
			if (null == user.getIsAdmin() || user.getIsAdmin() != 1) {// 0 or
																		// null
				// 查询当前非管理员用户的权限
				menus = RemoteServiceSingleton.getInstance()
						.getSupplierRoleManagerService()
						.getMenusByUserId(user.getUserId());
			} else { // 1 查询所有权限做为 管理员权限
				menus = RemoteServiceSingleton.getInstance()
						.getSupplierRoleManagerService().findAllMenus();
			}
			Supplier supplier = null;
			if (user.getSupplierId() != null) {
				supplier = RemoteServiceSingleton.getInstance()
						.getSupplierManagerService()
						.findSupplier(user.getSupplierId());
				if (null != supplier && null != supplier.getCompanyNature()) {
					List<SupplierMenu> rmMenusList = new ArrayList<SupplierMenu>();
					if (Constants.MANUFACTURER.equals(supplier
							.getCompanyNature())) {
						if (null != menus && menus.size() > 0) {
							for (int i = 0; i < menus.size(); i++) {
								if ("子供应商管理".equals(menus.get(i).getName())) {
									rmMenusList.add(menus.get(i));
								}
								;
							}
						}
					} else if (Constants.DOMESTIC_DEALER.equals(supplier
							.getCompanyNature())) {
						if (null != menus && menus.size() > 0) {
							for (int i = 0; i < menus.size(); i++) {
								if ("子供应商管理".equals(menus.get(i).getName())
										|| "库存管理"
												.equals(menus.get(i).getName())) {
									rmMenusList.add(menus.get(i));
								}
								;
							}
						}
					} else if (Constants.SUB_SUPPLIER.equals(supplier
							.getCompanyNature())) {
						if (null != menus && menus.size() > 0) {
							for (int i = 0; i < menus.size(); i++) {
								if ("用户中心".equals(menus.get(i).getName())
										|| "品牌管理"
												.equals(menus.get(i).getName())
										|| "基本信息管理".equals(menus.get(i)
												.getName())
										|| "用户管理"
												.equals(menus.get(i).getName())
										|| "权限管理"
												.equals(menus.get(i).getName())
										|| "子供应商管理".equals(menus.get(i)
												.getName())) {
									rmMenusList.add(menus.get(i));
								}
								;
							}
						}
					}

					for (int i = 0; i < rmMenusList.size(); i++) {
						if (menus.contains(rmMenusList.get(i))) {
							menus.remove(rmMenusList.get(i));
						}
					}

				} else {
					if (getLanguage().equals("/en")) {
						request.setAttribute("message",
								"Your company information is illegal!");
					} else {
						request.setAttribute("message", "您的商户信息不正确!");
					}
				}
			} else {
				if (getLanguage().equals("/en")) {
					request.setAttribute("message",
							"Your company information is illegal!");
				} else {
					request.setAttribute("message", "您的商户信息不正确!");
				}

			}

			Map<Long, SupplierMenu> defaultUrlMap = new LinkedHashMap<Long, SupplierMenu>();
			Map<String, String> defaultUrlMapReslut = new LinkedHashMap<String, String>();
			if (null != menus && menus.size() > 0) {
				for (int i = 0; i < menus.size(); i++) {
					if (null == menus.get(i).getParentMenuId()) {
						defaultUrlMap.put(menus.get(i).getMenuId(),
								menus.get(i));
					}
					menuMap.put(null != menus.get(i).getName() ? menus.get(i)
							.getName() : "",
							null != menus.get(i).getUrl() ? menus.get(i)
									.getUrl() : "");
					menuList.add(null != menus.get(i).getUrl() ? menus.get(i)
							.getUrl() : "");
				}
			}
			if (defaultUrlMap.size() > 0) {
				for (Long key : defaultUrlMap.keySet()) {
					SupplierMenu menu = getDefaultUrlByPid(menus, key);
					defaultUrlMapReslut.put(defaultUrlMap.get(key).getName(),
							menu.getUrl());
				}
			}
			if(supplier.getActiveStatus()==-1)
			{
				try {
					// 用户放入Mencached缓存
					memcachedClient.set(sid, Constants.OUT_TIME_1800, user);
					// 权限菜单Map放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_MAP,
							Constants.OUT_TIME_1800, menuMap);
					// 默认菜单放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_URL_MAP,
							Constants.OUT_TIME_1800, defaultUrlMapReslut);
					// 权限菜单List放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_LIST,
							Constants.OUT_TIME_1800, menuList);

					if (null != supplier) {
						// 当前用户的商户信息放入Mencached缓存
						memcachedClient.set(sid + Constants.SUPPLIER,
								Constants.OUT_TIME_1800, supplier);
					}
				} catch (Exception e) {
					logger.error("Memcached服务器存放登录信息出错" + e.getMessage(), e);
				}
				logger.info("用户:" + loginname + "登录成功");
				return "redirect:/supplier/jiben";
				
			}

			try {
				// 用户放入Mencached缓存
				memcachedClient.set(sid, Constants.OUT_TIME_1800, user);
				// 权限菜单Map放入Mencached缓存
				memcachedClient.set(sid + Constants.MENUS_MAP,
						Constants.OUT_TIME_1800, menuMap);
				// 默认菜单放入Mencached缓存
				memcachedClient.set(sid + Constants.MENUS_URL_MAP,
						Constants.OUT_TIME_1800, defaultUrlMapReslut);
				// 权限菜单List放入Mencached缓存
				memcachedClient.set(sid + Constants.MENUS_LIST,
						Constants.OUT_TIME_1800, menuList);

				if (null != supplier) {
					// 当前用户的商户信息放入Mencached缓存
					memcachedClient.set(sid + Constants.SUPPLIER,
							Constants.OUT_TIME_1800, supplier);
				}
			} catch (Exception e) {
				logger.error("Memcached服务器存放登录信息出错" + e.getMessage(), e);
			}
			logger.info("用户:" + loginname + "登录成功");
			return "redirect:/product/onSaleList";
		} else {
			request.setAttribute("loginname", loginname);
			if (getLanguage().equals("/en")) {
				request.setAttribute("message",
						"User name password does not match");
			} else {
				request.setAttribute("message", "用户名密码不匹配!");
			}
			logger.info("用户:" + loginname + "用户名密码不匹配!");
			return "/user/login";
		}
	}*/

	
	//家庭号登陆
	@RequestMapping("/user/login")
	public String loginUser(String loginname, String password, String kaptcha,
			HttpServletRequest request, HttpServletResponse response,
			String uid, Model model) {
		String kaptchaExpected = "";
	/*	if (Common.isEmpty(uid)) {
			uid = UUID.randomUUID().toString();
			model.addAttribute("uid", uid);
			try {
				memcachedClient.set(uid, 60 * 60, uid);
			} catch (Exception e) {
				logger.error(e.getMessage(), e);
			}
			if (getLanguage().equals("/en")) {
				request.setAttribute("message", " please try again！");
			} else {
				request.setAttribute("message", "登录失败,请重新登录！");
			}
			logger.info("uid为空，请重新登录！");
			return "/user/login";
		}*/
		try {
			kaptchaExpected = memcachedClient.get(uid
					+ Constants.KAPTCHA_SESSION_KEY);
		} catch (Exception e) {
			logger.error("登录获取服务器验证码失败" + e.getMessage(), e);
		}
		if (!kaptcha.toLowerCase().equals(kaptchaExpected.toLowerCase())) {
			if (getLanguage().equals("/en")) {
				request.setAttribute("message", "Verification code is wrong！");
			} else {
				request.setAttribute("message", "验证码有误！");
			}
			logger.info("登录验证码不一致！");
			return "/user/login";
		}
		if (Common.isEmpty(password) || Common.isEmpty(loginname)) {
			request.setAttribute("loginname", loginname);
			if (getLanguage().equals("/en")) {
				request.setAttribute("message",
						"User name and Password cannot be empty");
			} else {
				request.setAttribute("message", "用户名密码不能为空!");
			}
			logger.info("用户名密码不能为空！");
			return "/user/login";
		}
		
		try {
		/**-------------------------安防验证开始-----------------------**/
		Map<String, String> args = new TreeMap<String, String>();

        /* 帐号信息参数 */
        args.put("accountType", "0");
        args.put("uid", uid);
        /*args.put("associateAccount","373909726");
        args.put("nickName", "helloword");
        args.put("phoneNumber", "086+15166666666");
        args.put("emailAddress", "hellword@qq.com");
        args.put("registerTime", "1440416972");
        args.put("registerIp", "121.14.96.121");
        args.put("passwordHash", "f158abb2a762f7919846ee9bf8445c7f22a244c5");*/

       /* 行为信息参数 */
       // getClientIP(request);
        logger.info("getClientIP:" + getClientIP(request));
       // logger.info("getIpAddr:" + getIpAddr(request));
        
        //getIpAddr(request);
        //args.put("loginIp", "121.14.96.121");
        args.put("loginIp", getClientIP(request));
        args.put("loginTime", new Date().getTime()+"");
        /*args.put("loginSource","4");
        args.put("loginType", "3");
        args.put("referer", "https://ui.ptlogin2.qq.com/cgi-bin/login");
        args.put("jumpUrl", "D692D87319F2098C3877C3904B304706");
        args.put("cookieHash", "D692D87319F2098C3877C3904B304706");
        args.put("userAgent", "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.132 Safari/537.36");
        args.put("xForwardedFor", "121.14.96.121");
        args.put("mouseClickCount", "10");
        args.put("keyboardClickCount", "34");
        args.put("result", "2");
        args.put("reason", "4");*/

        /* 设备信息 */
       /* args.put("macAddress","00-05-9A-3C-7A-00");
        args.put("vendorId","tencent.com");
        args.put("imei","54654654646");
        args.put("appVersion","10.0.1");*/

        /* 其他信息 */
       /* args.put("businessId","1");*/

        String url;
        ApiResponse resCsec=null;
		
		url = BspAPI.makeURL("GET", "LoginProtection", "bj", Constants.CSEC_SECRET_ID, Constants.CSEC_SECRET_KEY, args, "utf-8");
		 resCsec = ApiRequest.sendGet(url, "");
	      //System.out.println(resCsec.getBody());
		 if(resCsec != null){
			 logger.info("安全防护返回的数据:" + resCsec.getBody());
			 JSONObject temp  = JSONObject.fromObject(resCsec.getBody());
			 String code = temp.getString("code");
			 int level = Integer.parseInt(temp.getString("level")==null?"0":temp.getString("level"));
			 if(level > 2 ){
				 request.setAttribute("message", "账户异常，请联系管理员!");
				 return "/user/login";
			 }
		 }
		} catch (InvalidKeyException e1) {
			// TODO Auto-generated catch block
			//e1.printStackTrace();
		} catch (NoSuchAlgorithmException e1) {
			// TODO Auto-generated catch block
			//e1.printStackTrace();
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			//e1.printStackTrace();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			//e1.printStackTrace();
		} 
        
        /**-------------------------安防验证结束-----------------------**/
		
		Map<String, String> map = new HashMap<String, String>();
		// 登录方式判断 邮箱 手机或者用户名
		SupplierUser user = null;
		SupplierUser user1 = null;
		map.put("password", MD5.encrypt(password));
		map.put("loginName", loginname);
		user = RemoteServiceSingleton.getInstance()
				.getSupplierUserManagerService().login(map);
		
	
		//非 pop供应商类型不能登录
		Map<String, String> m=new HashMap<String, String>();
		m.put("loginName", loginname);
		int res= RemoteServiceSingleton.getInstance().getSupplierUserManagerService().getUserByName(m);
		if(res==0){
			if (getLanguage().equals("/en")) {
				request.setAttribute("message","User name password does not match");
			} else {
				request.setAttribute("message", "该用户不存在!");
			}
			return "/user/login";
		}
		
		if(null!=user){
			Supplier supplier1 = RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(user.getSupplierId());
			int supplerType = supplier1.getSupplyType();
			if(51!=supplerType){
				logger.info("用户:" + loginname + "该用户非POP类型供应商!");
				if (getLanguage().equals("/en")) {
					request.setAttribute("message",
							"Your Acount has registed,Please wait for audit!");
				} else {
					request.setAttribute("message", "该用户非POP类型供应商,请注册！");
				}
				return "/user/login";
			}
			//冻结的不能登录
			if(supplier1.getStatus()!=null && supplier1.getStatus()==5){
				request.setAttribute("message", "您的账号已被冻结！");
				return "/user/login";
			}
			//过期的把acticve设为-1
			 HomeNumRecordDto homeNumRecordDto;
				try {
					if(supplier1.getUserId()!=null){
						homeNumRecordDto = homeNumRecordService.selectRecordByUserid((supplier1.getUserId()).intValue());
						
						Integer jiaTingStatus = homeNumRecordDto.getStatus();
						if(jiaTingStatus==1){
							
							model.addAttribute("noPub", jiaTingStatus);
							System.out.println("---"+jiaTingStatus);
							
						}
						
					}
					
				} catch (Exception e1) {
					
					
				}
		}
		if (null != user) {
			if (user.getStatus() == Constants.USER_STATUS_UNCHECK) {
				logger.info("用户:" + loginname + "您已经注册,请等待审核!");
				if (getLanguage().equals("/en")) {
					request.setAttribute("message",
							"Your Acount has registed,Please wait for audit!");
				} else {
					request.setAttribute("message", "您已经注册,请等待审核!");
				}
				return "/user/login";
			} else if (user.getStatus() == Constants.USER_STATUS_CHECKFAIL) {
				logger.info("用户:" + loginname + "您的注册信息,审核未通过!");
				if (getLanguage().equals("/en")) {
					request.setAttribute("message",
							"Your registration information, does not pass the examination!");
				} else {
					request.setAttribute("message", "您的注册信息,审核未通过!");
				}

				return "/user/login";
			} else if (user.getStatus() == Constants.USER_STATUS_DELETED) {
				logger.info("用户:" + loginname + "您的账号已禁用,请联系管理员!");
				if (getLanguage().equals("/en")) {
					request.setAttribute("message",
							"Your account has been disabled, please contact the administrator!");
				} else {
					request.setAttribute("message", "您的账号已禁用,请联系管理员!");
				}
				return "/user/login";
			}
			String sid = request.getSession().getId();
			// 设置cookie的有效期
			CookieTool.setCookie(response, Constants.SESSION_ID, sid,
					Constants.OUT_TIME_FOREVER);
			// 菜单名称key url作为value 前台用
			Map<String, String> menuMap = new HashMap<String, String>();
			// url作为value 拦截器用 过滤URL
			List<String> menuList = new ArrayList<String>();
			List<SupplierMenu> menus = new ArrayList<SupplierMenu>();
			if (null == user.getIsAdmin() || user.getIsAdmin() != 1) {// 0 or
																		// null
				// 查询当前非管理员用户的权限
				menus = RemoteServiceSingleton.getInstance()
						.getSupplierRoleManagerService()
						.getMenusByUserId(user.getUserId());
			} else { // 1 查询所有权限做为 管理员权限
				menus = RemoteServiceSingleton.getInstance()
						.getSupplierRoleManagerService().findAllMenus();
			}
			Supplier supplier = null;
			if (user.getSupplierId() != null) {
				supplier = RemoteServiceSingleton.getInstance()
						.getSupplierManagerService()
						.findSupplier(user.getSupplierId());
				if (null != supplier && null != supplier.getCompanyNature()) {
					List<SupplierMenu> rmMenusList = new ArrayList<SupplierMenu>();
					if (Constants.MANUFACTURER.equals(supplier
							.getCompanyNature())) {
						if (null != menus && menus.size() > 0) {
							for (int i = 0; i < menus.size(); i++) {
								if ("子供应商管理".equals(menus.get(i).getName())) {
									rmMenusList.add(menus.get(i));
								}
								;
							}
						}
					} else if (Constants.DOMESTIC_DEALER.equals(supplier
							.getCompanyNature())) {
						if (null != menus && menus.size() > 0) {
							for (int i = 0; i < menus.size(); i++) {
								if ("子供应商管理".equals(menus.get(i).getName())
										|| "库存管理"
												.equals(menus.get(i).getName())) {
									rmMenusList.add(menus.get(i));
								}
								;
							}
						}
					} else if (Constants.SUB_SUPPLIER.equals(supplier
							.getCompanyNature())) {
						if (null != menus && menus.size() > 0) {
							for (int i = 0; i < menus.size(); i++) {
								if ("用户中心".equals(menus.get(i).getName())
										|| "品牌管理"
												.equals(menus.get(i).getName())
										|| "基本信息管理".equals(menus.get(i)
												.getName())
										|| "用户管理"
												.equals(menus.get(i).getName())
										|| "权限管理"
												.equals(menus.get(i).getName())
										|| "子供应商管理".equals(menus.get(i)
												.getName())) {
									rmMenusList.add(menus.get(i));
								}
								;
							}
						}
					}

					for (int i = 0; i < rmMenusList.size(); i++) {
						if (menus.contains(rmMenusList.get(i))) {
							menus.remove(rmMenusList.get(i));
						}
					}

				} else {
					if (getLanguage().equals("/en")) {
						request.setAttribute("message",
								"Your company information is illegal!");
					} else {
						request.setAttribute("message", "您的商户信息不正确!");
					}
				}
			} else {
				if (getLanguage().equals("/en")) {
					request.setAttribute("message",
							"Your company information is illegal!");
				} else {
					request.setAttribute("message", "您的商户信息不正确!");
				}

			}

			Map<Long, SupplierMenu> defaultUrlMap = new LinkedHashMap<Long, SupplierMenu>();
			Map<String, String> defaultUrlMapReslut = new LinkedHashMap<String, String>();
			if (null != menus && menus.size() > 0) {
				for (int i = 0; i < menus.size(); i++) {
					if (null == menus.get(i).getParentMenuId()) {
						defaultUrlMap.put(menus.get(i).getMenuId(),
								menus.get(i));
					}
					menuMap.put(null != menus.get(i).getName() ? menus.get(i)
							.getName() : "",
							null != menus.get(i).getUrl() ? menus.get(i)
									.getUrl() : "");
					menuList.add(null != menus.get(i).getUrl() ? menus.get(i)
							.getUrl() : "");
				}
			}
			if (defaultUrlMap.size() > 0) {
				for (Long key : defaultUrlMap.keySet()) {
					SupplierMenu menu = getDefaultUrlByPid(menus, key);
					defaultUrlMapReslut.put(defaultUrlMap.get(key).getName(),
							menu.getUrl());
				}
			}
			if(supplier.getActiveStatus()==-1 && supplier.getOrganizationType()!=null && supplier.getOrganizationType()==5)
			{
				try {
					// 用户放入Mencached缓存
					memcachedClient.set(sid, Constants.OUT_TIME_1800, user);
					// 权限菜单Map放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_MAP,
							Constants.OUT_TIME_1800, menuMap);
					// 默认菜单放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_URL_MAP,
							Constants.OUT_TIME_1800, defaultUrlMapReslut);
					// 权限菜单List放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_LIST,
							Constants.OUT_TIME_1800, menuList);

					if (null != supplier) {
						// 当前用户的商户信息放入Mencached缓存
						memcachedClient.set(sid + Constants.SUPPLIER,
								Constants.OUT_TIME_1800, supplier);
					}
				} catch (Exception e) {
					logger.error("Memcached服务器存放登录信息出错" + e.getMessage(), e);
				}
				logger.info("用户:" + loginname + "登录成功");
				return "redirect:/supplier/jiben2";
				
			}
			if(supplier.getActiveStatus()==-1 && supplier.getOrganizationType()!=null && supplier.getOrganizationType()==6)
			{
				try {
					// 用户放入Mencached缓存
					memcachedClient.set(sid, Constants.OUT_TIME_1800, user);
					// 权限菜单Map放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_MAP,
							Constants.OUT_TIME_1800, menuMap);
					// 默认菜单放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_URL_MAP,
							Constants.OUT_TIME_1800, defaultUrlMapReslut);
					// 权限菜单List放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_LIST,
							Constants.OUT_TIME_1800, menuList);

					if (null != supplier) {
						// 当前用户的商户信息放入Mencached缓存
						memcachedClient.set(sid + Constants.SUPPLIER,
								Constants.OUT_TIME_1800, supplier);
					}
				} catch (Exception e) {
					logger.error("Memcached服务器存放登录信息出错" + e.getMessage(), e);
				}
				logger.info("用户:" + loginname + "登录成功");
				return "redirect:/supplier/jiben3";
				
			}
			if(supplier.getActiveStatus()==-1 && supplier.getOrganizationType()==null )
			{
				try {
					// 用户放入Mencached缓存
					memcachedClient.set(sid, Constants.OUT_TIME_1800, user);
					// 权限菜单Map放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_MAP,
							Constants.OUT_TIME_1800, menuMap);
					// 默认菜单放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_URL_MAP,
							Constants.OUT_TIME_1800, defaultUrlMapReslut);
					// 权限菜单List放入Mencached缓存
					memcachedClient.set(sid + Constants.MENUS_LIST,
							Constants.OUT_TIME_1800, menuList);

					if (null != supplier) {
						// 当前用户的商户信息放入Mencached缓存
						memcachedClient.set(sid + Constants.SUPPLIER,
								Constants.OUT_TIME_1800, supplier);
					}
				} catch (Exception e) {
					logger.error("Memcached服务器存放登录信息出错" + e.getMessage(), e);
				}
				logger.info("用户:" + loginname + "登录成功");
				return "redirect:/supplier/jiben";
				
			}

			try {
				// 用户放入Mencached缓存
				memcachedClient.set(sid, Constants.OUT_TIME_1800, user);
				// 权限菜单Map放入Mencached缓存
				memcachedClient.set(sid + Constants.MENUS_MAP,
						Constants.OUT_TIME_1800, menuMap);
				// 默认菜单放入Mencached缓存
				memcachedClient.set(sid + Constants.MENUS_URL_MAP,
						Constants.OUT_TIME_1800, defaultUrlMapReslut);
				// 权限菜单List放入Mencached缓存
				memcachedClient.set(sid + Constants.MENUS_LIST,
						Constants.OUT_TIME_1800, menuList);

				if (null != supplier) {
					// 当前用户的商户信息放入Mencached缓存
					memcachedClient.set(sid + Constants.SUPPLIER,
							Constants.OUT_TIME_1800, supplier);
				}
			} catch (Exception e) {
				logger.error("Memcached服务器存放登录信息出错" + e.getMessage(), e);
			}
			logger.info("用户:" + loginname + "登录成功");
			return "redirect:/product/onSaleList";
		} else {
			request.setAttribute("loginname", loginname);
			if (getLanguage().equals("/en")) {
				request.setAttribute("message",
						"User name password does not match");
			} else {
				request.setAttribute("message", "用户名密码不匹配!");
			}
			logger.info("用户:" + loginname + "用户名密码不匹配!");
			return "/user/login";
		}
	}
	/**
	 * 添加一个用户.
	 * 
	 * @param user
	 *            user
	 * @param roleId
	 *            roleid
	 * @return 用户列表页
	 */
	@RequestMapping("/user/save")
	@Token(validateToken = true)
	@ResponseBody
	public String saveUser(SupplierUser user, Long roleId) {
		user.setIsAdmin(0);
		user.setStatus(1);
		user.setPassword(MD5.encrypt(user.getPassword()));
		user.setSupplierId(getCurrentSupplierId());
		Long userId = RemoteServiceSingleton.getInstance()
				.getSupplierUserManagerService().add(user);
		SupplierUserRole userRole = new SupplierUserRole();
		userRole.setRoleId(roleId);
		userRole.setUserId(userId);
		int result = RemoteServiceSingleton.getInstance()
				.getSupplierRoleManagerService().addUserRole(userRole);
		if (result > 0) {
			logger.info("用户:" + getCurrentUser().getLoginName() + "添加"
					+ user.getLoginName() + "用户操作成功");
			return JSON.toJSONString(1);
		} else {
			logger.info("用户:" + getCurrentUser().getLoginName() + "添加"
					+ user.getLoginName() + "用户操作失败");
			return JSON.toJSONString(0);
		}
		// return "redirect:/user/list";

	}

	/**
	 * 修改用户信息 .
	 * 
	 * @param user
	 *            user
	 * @param roleId
	 *            roleid
	 * @return 用户列表页
	 */
	@RequestMapping("/user/update")
	@Token(validateToken = true, nameOfId = "userId")
	@ResponseBody
	public String updateUser(SupplierUser user, Long roleId) {
		user.setIsAdmin(0);
		user.setStatus(1);
		user.setPassword(MD5.encrypt(user.getPassword()));
		user.setSupplierId(getCurrentSupplierId());
		RemoteServiceSingleton.getInstance().getSupplierUserManagerService()
				.update(user);
		SupplierUserRole userRole = new SupplierUserRole();
		userRole.setRoleId(roleId);
		userRole.setUserId(user.getUserId());
		int result = RemoteServiceSingleton.getInstance()
				.getSupplierRoleManagerService().updateUserRole(userRole);
		if (result > 0) {
			logger.info("用户:" + getCurrentUser().getLoginName() + "更新ID："
					+ user.getUserId() + "用户操作成功");
			return JSON.toJSONString(1);
		} else {
			logger.info("用户:" + getCurrentUser().getLoginName() + "更新ID："
					+ user.getUserId() + "用户操作失败");
			return JSON.toJSONString(0);
		}
		// return "redirect:/user/list";
	}

	/**
	 * 删除单个用户.
	 * 
	 * @param id
	 *            id
	 * @return 用户列表页
	 */
	@RequestMapping("/user/delete")
	@Token(validateToken = true, nameOfId = "id")
	@ResponseBody
	public String deleteUserById(Long id) {
		int result = RemoteServiceSingleton.getInstance()
				.getSupplierUserManagerService().delete(id);
		if (result > 0) {
			logger.info("用户:" + getCurrentUser().getLoginName() + "删除id:" + id
					+ "用户操作成功");
			return JSON.toJSONString(1);
		} else {
			logger.info("用户:" + getCurrentUser().getLoginName() + "删除id:" + id
					+ "用户操作失败");
			return JSON.toJSONString(0);
		}
		// return "redirect:/user/list";
	}

	/**
	 * 批量删除用户.
	 * 
	 * @param nn
	 *            userIds
	 * @return 用户列表页
	 */
	@RequestMapping("/user/deleteByIds")
	@Token(validateToken = true)
	@ResponseBody
	public String delUserByIds(Long[] nn) {
		Common.isEmptyArray(nn);
		List<Long> ids = Arrays.asList(nn);
		int result = RemoteServiceSingleton.getInstance()
				.getSupplierUserManagerService().deleteAll(ids);
		if (result > 0) {
			logger.info("用户:" + getCurrentUser().getLoginName() + "删除用户操作成功");
			return JSON.toJSONString(1);
		} else {
			logger.info("用户:" + getCurrentUser().getLoginName() + "删除用户操作失败");
			return JSON.toJSONString(0);
		}
		// return "redirect:/user/list";
	}

	/**
	 * 退出登录.
	 *
	 * @return登录页
	 */
	@RequestMapping("/user/logout")
	public String logout(HttpServletRequest request,
			HttpServletResponse response) {
		
		
		try {
		
			
				String sid = getSessionId();
				if (!Common.isEmpty(sid)) {
					memcachedClient.delete(sid);
					memcachedClient.delete(Constants.SESSION_ID);
					memcachedClient.delete(Constants.SUPPLIER);
					memcachedClient.delete(Constants.MENUS_MAP);
					memcachedClient.delete(Constants.MENUS_LIST);
				}
				CookieTool.clear(request, response, "language");
			
			
			
		} catch (Exception e) {
			logger.error("Memcached服务器存清除信息出错" + e.getMessage(), e);
		}
		return "redirect:/user/loginUI";
		
	}

	/**
	 * 添加用户名验证.
	 * 
	 * @param pin
	 *            用户名称
	 * @param response
	 *            HttpServletResponse
	 * @return int count
	 */
	@RequestMapping("/user/checkUserName")
	@ResponseBody
	public String checkUserName(String pin, HttpServletResponse response) {
		Map<String, String> pmap = new LinkedHashMap<String, String>();
		int count = 0;
		if (!Common.isEmpty(pin)) {
			pmap.put("loginName", pin);
			count = RemoteServiceSingleton.getInstance()
					.getSupplierUserManagerService().getUserByName(pmap);
		}
		return count + "";
	}

	/**
	 * 获取权限.
	 */
	public SupplierMenu getDefaultUrlByPid(List<SupplierMenu> list, Long pid) {
		if (null != pid) {
			for (int i = 0; i < list.size(); i++) {
				if (null != list.get(i).getParentMenuId()
						&& pid == Long.parseLong(list.get(i).getParentMenuId()
								+ "")) {
					if (!list.get(i).getUrl().contains("/")) {
						return getDefaultUrlByPid(list, list.get(i).getMenuId());
					} else {
						return list.get(i);
					}
				}
			}
		}
		return new SupplierMenu();
	}
	
	/**
	 * 判断推荐人是否存在
	 * @param tjName
	 * @return
	 */
	@RequestMapping("/user/checkTJUserIsExists")
	@ResponseBody
	public String checkTJUserIsExists(String tjName) {
		int flag = 1;
		if(StringUtils.isEmpty(tjName)){
			flag = 0;
		}else{
			User tjUser = new User();
			tjUser.setMobile(tjName);;
			String tjUserExists = RemoteServiceSingleton.getInstance()
					.getUserService().isTJUserExists(tjUser);
			if(tjUserExists.equals("false")){		//不存在
				flag = 0;
			}
		}
		return JSON.toJSONString(flag);
	}

}
