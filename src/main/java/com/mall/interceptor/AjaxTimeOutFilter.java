package com.mall.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.rubyeye.xmemcached.MemcachedClient;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.mall.utils.Constants;
import com.mall.utils.CookieTool;


public class AjaxTimeOutFilter implements HandlerInterceptor{

	/**
	 * Sping注入mencached缓存客户端.
	 */
	@Autowired
	private  MemcachedClient memCachedClient;  



	public MemcachedClient getMemCachedClient() {
		return memCachedClient;
	}

	public void setMemCachedClient(MemcachedClient memCachedClient) {
		this.memCachedClient = memCachedClient;
	}
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
					throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object obj) throws Exception {
		String url=request.getServletPath();
	    boolean  falg =	isfilterChain(url,isNotLogin());
	    if(falg){
	    	return true ;
	    }
		Cookie cookie = CookieTool.getCookie(request,Constants.SESSION_ID);
	   /* if(url.equals("/product/imageUp")){
	    	if(!Common.isEmpty(request.getParameter("jsid"))){
		    	cookie.setValue(request.getParameter("jsid"));
		    }
	    }*/
		if(cookie!=null){
			String sid = cookie.getValue();
			Object supplier = memCachedClient.get(sid);
			if(supplier==null){
				String header = request.getHeader("x-requested-with");
				if (header != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest"))
				{
					response.setHeader("sessionstatus", "timeout");
					return false;
				}
			}

		}else{
			String header = request.getHeader("x-requested-with");
			if (header != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest"))
			{
				response.setHeader("sessionstatus", "timeout");
				return false;
			}
		}
		return true;
	}

	/***
	 * 没有登录 可以访问的URl.
	 * **/
	public List<String> isNotLogin(){
		List<String> result = new ArrayList<String>();
		result.add("/isPinEngaged");
		result.add("/isPinName");
		result.add("/supplier/validateNum");
		result.add("/findPwd");
		result.add("/sendMail");
		result.add("/resetPwd");
		result.add("/finish");
		result.add("/checkTJUserIsExists");
		result.add("/checkSupplierCodeIsExists");
		result.add("/getCompanyNameBySupplierCode");
		result.add("/getNameByTjUser");
		result.add("/getVerificationCode");
		return result;
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
