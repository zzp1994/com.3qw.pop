package com.mall.interceptor;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.rubyeye.xmemcached.MemcachedClient;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.mall.supplier.model.SupplierUser;
import com.mall.utils.Common;
import com.mall.utils.Constants;
import com.mall.utils.CookieTool;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	/**
	 * spring 注入memcachedClient .
	 */
	@Autowired
	private MemcachedClient memcachedClient;
	

	public MemcachedClient getMemcachedClient() {
		return memcachedClient;
	}

	public void setMemcachedClient(MemcachedClient memcachedClient) {
		this.memcachedClient = memcachedClient;
	}
	/**
	 * Logger.
	 */
	private static final Logger LOGGER= Logger.getLogger(LoginInterceptor.class);
	/**
	 * 在业务处理器处理请求之前被调用.
	 * 如果返回false
	 *     从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链
	 * 
	 * 如果返回true
	 *    执行下一个拦截器,直到所有的拦截器都执行完毕 再执行被拦截的Controller  然后进入拦截器链, 从最后一个拦截器往回执行所有的postHandle()
	 *    接着再从最后一个拦截器往回执行所有的afterCompletion()
	 *    @param request request
	 *    @param response response
	 *    @param handler handler
	 *    @return boolean
	 */
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) {
		//System.out.println("==============执行顺序: 1、preHandle================");
		String url = request.getServletPath();
		List<String> isProductList = isCanWithHtml();
		boolean  flag =	isfilterChain(url,isProductList);
		//------判断url是否为不用登录就能访问的url列表中-----//
		List<String> noLoginURL = isNotLogin();
	    flag =	isfilterChain(url,noLoginURL);
	    // logger.info("本次访问的URL："+url);
	    if(flag){
	    	return true ;
	    }
	    //3、如果用户已经登录 放行    
	    Cookie cookie = CookieTool.getCookie(request, Constants.SESSION_ID);
        if(url.equals("/product/imageUp")){
        	if(!Common.isEmpty(request.getParameter(Constants.SESSION_ID))){
        		cookie=new Cookie(Constants.SESSION_ID, request.getParameter(Constants.SESSION_ID));
        	}
        }
	    
	    if(cookie!= null) {  
	        //更好的实现方式的使用cookie  
	    	String sid = cookie.getValue();
	    	
			//更新cookie的有效期
			CookieTool.setCookie(response, Constants.SESSION_ID, sid, Constants.OUT_TIME_FOREVER);
			
			//缓存中获取user信息 
			Object object=null;
			try {
				object = memcachedClient.get(sid);
			} catch (Exception e1) {
				LOGGER.error("Memcached服务器获取信息失败!"+e1.getMessage(), e1);
			}
			
			//缓存中没有user重新登录
			if(null==object){
				    try {
						response.sendRedirect("../user/loginUI");
					} catch (IOException e) {
						LOGGER.error("Memcached服务器缓存中没有user重新登录!"+e.getMessage(), e);
					} 
					return false;
			}else{
				SupplierUser user=(SupplierUser) object;
				Map<String, String> menus_map=new HashMap<String, String>();
				try {
					
					
					 menus_map = memcachedClient.get(sid+Constants.MENUS_MAP);
					 memcachedClient.replace(sid,Constants.OUT_TIME_1800, object);
					 memcachedClient.replace(sid+Constants.MENUS_MAP,Constants.OUT_TIME_1800,menus_map); 
					 memcachedClient.replace(sid+Constants.MENUS_LIST,Constants.OUT_TIME_1800
							 ,memcachedClient.get(sid+Constants.MENUS_LIST)); 
					 memcachedClient.replace(sid+Constants.SUPPLIER,Constants.OUT_TIME_1800,
					 		 memcachedClient.get(sid+Constants.SUPPLIER));  
					 memcachedClient.replace(sid+Constants.MENUS_URL_MAP,Constants.OUT_TIME_1800,
							 memcachedClient.get(sid+Constants.MENUS_URL_MAP));  
					 
					  request.setAttribute("loginUser", object);
					  request.setAttribute("sid", sid);
					  request.setAttribute("supplierId",user.getSupplierId());
					  request.setAttribute("supplier",memcachedClient.get(sid+Constants.SUPPLIER));
					  request.setAttribute("defaultUrlMapReslut",memcachedClient.get(sid+Constants.MENUS_URL_MAP));
					  request.setAttribute("meunMap",menus_map);
				} catch (Exception e) {
					LOGGER.error("Memcached服务器获取信息失败!"+e.getMessage(), e);
					return false;
				}
			    LOGGER.info("用户:"+user.getLoginName()+"本次访问的URL："+url);
				  //memcachedClient.replace(sid, 30*60, object);
				  if(null!=user.getIsAdmin()&&user.getIsAdmin()>0&&menus_map.containsKey("用户中心")){  //是管理员不用权限拦截
						  return true ; 					 
				  }else if(initUrl(url)){     //用户操作部分update delete save等from 不拦截
					  return true ;
				  }else{                       //获取用户的角色中权限URl
					  List<String> role_url=new ArrayList<String>();
					  try {
							role_url =memcachedClient.get(sid+Constants.MENUS_LIST);
					  } catch (Exception e1) {
						    LOGGER.error("Memcached服务器获取信息失败!"+e1.getMessage(), e1);
					  }
					  if(isfilterChain(url,role_url)){
						  //request.setAttribute("meunMap1","-=-=-=-=-=-=");
						  return true ;
					  }else{
						  //返回到指定的页面
						 // request.getRequestDispatcher("/not_role.jsp").forward(request, response);
						  try {
							response.sendRedirect("../user/loginUI");
						} catch (IOException e) {
							LOGGER.error("Memcached服务器缓存中没有user重新登录!"+e.getMessage(), e);
						} 
						  return  false;
					  }
				  }
			}
		
	    }  
	    
	    //4、非法请求 即这些请求需要登录后才能访问  
	    //重定向到登录页面  
	    try {
			response.sendRedirect("../user/loginUI");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return false;
	}

	/**
	 * 在业务处理器处理请求执行完成后,生成视图之前执行的动作 .
	 *    @param request request
	 *    @param response response
	 *    @param handler handler
	 *    @param modelAndView modelAndView
	 */
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) {
	}
	
	/**
	 * 在DispatcherServlet完全处理完请求后被调用 .
	 * 当有拦截器抛出异常时,会从当前拦截器往回执行所有的拦截器的afterCompletion()
	 *    @param request request
	 *    @param response response
	 *    @param handler handler
	 *    @param ex Exception
	 */
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex){
		//System.out.println("==============执行顺序: 3、afterCompletion================");
	}
	
	/**
	 * 截取.htm 的url.
	 * @param 获取url
	 * **/
	public  String getUrlPath(String url ){
		StringBuilder builder = new StringBuilder();
		int flag = url.indexOf(".htm");
		if(flag!=-1){
			String str =url.substring(0, flag);
			builder.append(str);
			builder.append(".htm");
		}
	  return builder.toString();
	}
	
	/***
	 *可以带html.
	 * **/
	public List<String> isCanWithHtml(){
		List<String> result = new ArrayList<String>();
		result.add("/product/add");
		result.add("/product/editProduct");
		result.add("/order/printDespatch");
		result.add("/order/printContract");
		return result;
	}
	/***
	 * 没有登录 可以访问的URl.
	 * **/
	public List<String> isNotLogin(){
		List<String> result = new ArrayList<String>();
		result.add("/user/login");
		result.add("/loginUI");
		result.add("/registUI");
		result.add("/supplier/validateNum");
		result.add("/supplier/validateCode");
		result.add("/findPwd");
		result.add("/sendMail");
		result.add("/resetPwd");
		result.add("/finish");
		result.add("/user/isPinEngaged");
		result.add("/user/isPinName");
		result.add("/group");
		result.add("/supplier/regist");
		result.add("/supplier/download");
		result.add("/supplier/download");
		result.add("/store/info");
		result.add("/user/checkTJUserIsExists");
		result.add("/supplier/checkSupplierCodeIsExists");
		result.add("/supplier/getCompanyNameBySupplierCode");
		result.add("/supplier/getNameByTjUser");
		result.add("/user/isPwd");
		result.add("/user/forUpdatePwd");
		result.add("/user/getVerificationCode");
		return result;
	}
	
   /**
    * 初始化的URl 登录后可以访问的URl.
    * @param str url 
    * **/
	public boolean initUrl(String str){
	    List<String> result = new ArrayList<String>();
	    //result.add("list");//查看列表
	    result.add("user/index");//添加按钮
	    result.add("product");
	    result.add("inventory");
	    result.add("order");
	    result.add("get");
	    result.add("add");//添加按钮
	    result.add("edit");//修改按钮
	    result.add("save");//保存
	    result.add("update");//更新
	    result.add("ajax");//ajax请求
	    result.add("download"); //各类下载
	    result.add("del");//删除按钮
	    result.add("imageUp");//删除按钮
	    result.add("check");
	    
	    result.add("preview");
	    result.add("setModle");
	    result.add("toAddUI");
	    result.add("initPOPShowDealerProduct");
	    result.add("toPreview");
	    result.add("toOnline");
	    result.add("findBrandByCondition");
	    
	    return   isfilterChain(str,result);
    }
	/**
	 * 是否可以访问.
	 * @param url url
	 * @param  str str的List
	 * @return  boolean
	 * **/
	public boolean isfilterChain(String url,List<String> str){
		
		boolean result = false;
		if(str==null){
			return false ;
		}
		for(String ss : str){
			if(url.indexOf(ss)!=-1){
				result = true ;
				break;
			}
		}
		return result;
	}
	
}
