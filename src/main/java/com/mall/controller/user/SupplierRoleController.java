package com.mall.controller.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.mall.annotation.Token;
import com.mall.controller.base.BaseController;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.supplier.model.Supplier;
import com.mall.supplier.model.SupplierMenu;
import com.mall.supplier.model.SupplierRole;
import com.mall.supplier.model.SupplierRolePopedom;
import com.mall.utils.Common;
import com.mall.utils.Constants;
@Controller
@RequestMapping(value="/role")
public class SupplierRoleController extends BaseController  {
	/**
	 * log.
	 */
	private static final Logger logger = Logger.getLogger(SupplierRoleController.class);
	
	
	
	/**
	 * spring 注入messageSource .
	 */
	@Autowired
	public ResourceBundleMessageSource messageSource;
	/** 
	* @Description:全查询所有角色.
	* @param  request HttpServletRequest
	* @param  response HttpServletResponse
	* @param  role SupplierRole
	* @return ModelAndView    返回类型 
	* @author wangdj
	*/
	@RequestMapping(value = "/list")
	@Token(saveToken=true)
	public ModelAndView findAllRoles(HttpServletRequest request,HttpServletResponse response, SupplierRole role) {
		
		 Map<String,Object> map = new HashMap<String,Object>();
		//根据当前登录用户 取其(供应商) 角色集合
		 List<SupplierRole> list = null;
		 List<Long> ids=new ArrayList<Long>();
		 map.put("editable", false);
		 try {
			ids.add(getCurrentSupplierId());
   			list = RemoteServiceSingleton.getInstance().getSupplierRoleManagerService().selectRolesBySupplierIds(ids);
		 } catch (Exception e) {
			 logger.error(e.getMessage(), e);
		 }
		 //查询全部权限组成树形结构给前台
		 List<SupplierMenu> listMenu = null;
		 try {
			 listMenu = RemoteServiceSingleton.getInstance().getSupplierRoleManagerService().findAllMenus();
		 } catch (Exception e) {
			 logger.error(e.getMessage(), e);
		 }
		 List<Long> userMenuStrList=new ArrayList<Long>();
		 if(null!=role.getRoleId()){
  			 List<SupplierMenu> userMenu= RemoteServiceSingleton.getInstance().getSupplierRoleManagerService().
  					 findMenusByRoleId(role.getRoleId());
  			 if(null!=userMenu&&userMenu.size()>0){
  				 for (SupplierMenu supplierMenu : userMenu) {
  					userMenuStrList.add(supplierMenu.getMenuId());
  				} 
  			 }
  			 map.put("roleId", role.getRoleId());
  		   }
         if(listMenu!=null&&!listMenu.isEmpty()){
    	    List<Map<String,Object>> datalist =new ArrayList<Map<String,Object>>();
    		Map<String,Object> map0=new LinkedHashMap<String, Object>();
				map0.put("id", 0);
			    if(getLanguage().equals("/en")){
					map0.put("name", "Select All");
	            }else{
	            	map0.put("name", "全选");
	            }
				map0.put("pId", "root");
				map0.put("squeuces", 0);
				
				if(userMenuStrList.size()>0){
					map0.put("checked", true);
				}
				datalist.add(map0);
    	    for (int i = 0; i < listMenu.size(); i++) {
				Map<String,Object> map2=new LinkedHashMap<String, Object>();
				if(null!=listMenu.get(i).getMenuId()){
					map2.put("id", listMenu.get(i).getMenuId());
					  if(getLanguage().equals("/en")){
							map2.put("name", null==listMenu.get(i).getExeName()?"":listMenu.get(i).getExeName());
			            }else{
			            	map2.put("name", null==listMenu.get(i).getName()?"":listMenu.get(i).getName());
			            }
				
					map2.put("pId", null==listMenu.get(i).getParentMenuId()?0:listMenu.get(i).getParentMenuId());
					map2.put("squeuces", i+1);
					if(userMenuStrList.contains(listMenu.get(i).getMenuId())){
						map2.put("checked", true);
					}
					datalist.add(map2);
				}
    	    }
    		map.put("tree",JSON.toJSONString(datalist));
         }
		 map.put("roleList", list);
	     return new ModelAndView(getLanguage()+"/user/role",map);
	}
	
	/**
	 * 创建一个新角色.
	 * @param supplierRole role
	 * @return
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	@Token(validateToken=true)
	public String insertSupplierRole(SupplierRole supplierRole) {
		supplierRole.setSupplierId(getCurrentSupplierId());
		supplierRole.setStatus(1);
		int result= RemoteServiceSingleton.getInstance().getSupplierRoleManagerService().addRole(supplierRole);
		
		if(result>0){
			logger.info("用户:"+getCurrentUser().getLoginName()+"添加"+supplierRole.getName()+"角色成功");
			return JSON.toJSONString(1);
		}else{
			logger.info("用户:"+getCurrentUser().getLoginName()+"添加"+supplierRole.getName()+"角色失败");
			return JSON.toJSONString(0);	
		}
		
	}
 
	 /**
	 * 
	 * @return
	 */
	
	/** 
	* @Description: 修改角色名称.
	* @param request HttpServletRequest
	* @param  supplierRole supplierRole
	* @return ModelAndView    返回类型 
	* @author wangdj
	*/
	@RequestMapping(value = "/update")
	@ResponseBody
	@Token(validateToken=true)
	public String updateRole(HttpServletRequest request,SupplierRole supplierRole) {
		int result= RemoteServiceSingleton.getInstance().getSupplierRoleManagerService().updateRole(supplierRole);
		if(result>0){
			logger.info("用户:"+getCurrentUser().getLoginName()+"更新"+supplierRole.getName()+"角色成功");
			return JSON.toJSONString(1);
		}else{
			logger.info("用户:"+getCurrentUser().getLoginName()+"更新"+supplierRole.getName()+"角色失败");
			return JSON.toJSONString(0);
		}
	  }

	/** 
	* @Description:修改角色权限.
	* @param request HttpServletRequest
	* @param roleId roleId
	* @param menus  menus
	* @return ModelAndView    返回类型 
	* @author wangdj
	*/
	@RequestMapping(value = "/updateRoleMenu")
	@ResponseBody
	@Token(validateToken=true)
	public String  updateRoleMenu(HttpServletRequest request,Long roleId,Long[] menus) {
		List<SupplierRolePopedom> list=new ArrayList<SupplierRolePopedom>();
		SupplierRolePopedom rp=null;
		if(null!=menus&&menus.length>0){
			for (int i = 0; i < menus.length; i++) {
				if(menus[i]!=0){
					rp= new SupplierRolePopedom();
					rp.setMenuId(menus[i]);
					rp.setRoleId(roleId);
					list.add(rp);
				}
			}
		}else{
			rp= new SupplierRolePopedom();
			rp.setRoleId(roleId);
			list.add(rp);
		}
		int result= RemoteServiceSingleton.getInstance().getSupplierRoleManagerService().updateRolePopedomByRoleId(list);
		if(result>0){
			logger.info("用户:"+getCurrentUser().getLoginName()+"更新角色id:"+roleId+"权限成功");
			return JSON.toJSONString(1);
		}else{
			logger.info("用户:"+getCurrentUser().getLoginName()+"更新角色id:"+roleId+"权限失败");
			return JSON.toJSONString(0);
		}
	  }
	 /**
	 * 单个查询角色名称.
	 * @param  response  HttpServletResponse
	 * @param  roleId roleId
	 */
	@RequestMapping(value = "/findRoleById")
	@ResponseBody
	public String findRoleById(HttpServletResponse response,Long roleId) {
		SupplierRole supplierRole=RemoteServiceSingleton.getInstance().getSupplierRoleManagerService().getRoleById(roleId);
		if(null!=supplierRole){
			return supplierRole.getName();
		}
		return  null;
		
   }
	 /**
	 * 删除某个角色.
	 * @param  request  HttpServletRequest
	 * @param  roleId roleId
	 * @return ModelAndView model
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	@Token(validateToken=true)
	public String deleteByRoleId(HttpServletRequest request,Long roleId) {
		int countUserByRoleId = RemoteServiceSingleton.getInstance().getSupplierRoleManagerService().countUserByRoleId(roleId);
		if(countUserByRoleId<=0){
			int result =RemoteServiceSingleton.getInstance().getSupplierRoleManagerService().deleteRoleById(roleId);
			if(result>0){
				logger.info("用户:"+getCurrentUser().getLoginName()+"删除角色id:"+roleId+"权限成功");
				return JSON.toJSONString(1);
			}else{
				logger.info("用户:"+getCurrentUser().getLoginName()+"删除角色id:"+roleId+"权限失败");
				return JSON.toJSONString(0);
			}
		}else{
		    logger.info("用户:"+getCurrentUser().getLoginName()+"删除角色id:"+roleId+"权限失败 用户关联该角色");
			if(getLanguage().equals("/en")){
			    return JSON.toJSONString("Have users binding the role, cannot be delete!");
	        }else{
	            return JSON.toJSONString("有用户绑定了该角色，不能删除！");
	        }
		}
		
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
	@RequestMapping("/isPinEngaged")
	@ResponseBody
	public String isPinEngaged(String pin, HttpServletResponse response) {
		int count = 1;
		if (!Common.isEmpty(pin)) {
			
			if("Sub Supplier".equals(pin)){
				count=-1;
			}else{
				count = RemoteServiceSingleton.getInstance().getSupplierRoleManagerService()
						.countRoleByNameAndMerchId(pin, getCurrentSupplierId());
			}
		}
		return count+"";
	}
	/**
	 * 验证是否有关联角色的用户.
	 * @param pin 用户名称
	 * @param response HttpServletResponse
	 * @return int count
	 */
	@RequestMapping("/checkRoleDel")
	@ResponseBody
	public String checkRoleDel(Long roleId, HttpServletResponse response) {
		int count = 0;
		if (roleId!=null) {
			count = RemoteServiceSingleton.getInstance().getSupplierRoleManagerService()
					.countUserByRoleId(roleId);
		}
		logger.info("用户:"+getCurrentUser().getLoginName()+"验证是否有关联角色id:"+roleId+"的用户个数："+count);
		return count+"";
	}
	
}
