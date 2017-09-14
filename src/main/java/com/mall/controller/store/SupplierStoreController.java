package com.mall.controller.store;

import com.mall.controller.base.BaseController;
import com.mall.dealer.order.po.BasContracts;
import com.mall.dealer.product.api.pop.DealerPopProductService;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.mybatis.utility.PageBean;
import com.mall.supplier.model.Supplier;
import com.mall.supplier.model.SupplierStore;
import com.mall.supplier.model.SupplierUser;
import com.mall.supplier.order.dto.ItemBatchDto;
import com.mall.supplier.order.dto.PurchaseItemBatchDto;
import com.mall.supplier.order.dto.PurchaseOrderDto;
import com.mall.supplier.product.dto.SupplierProductObjectDTO;
import com.mall.supplier.product.po.SupplierProduct;
import com.mall.supplier.service.SupplierManagerService;
import com.mall.supplier.service.SupplierStoreService;
import com.mall.utils.Common;
import com.mall.utils.Constants;
import com.mall.utils.Floor1;
import com.mall.utils.Floor2;
import com.mall.utils.Floor3;
import com.mall.utils.Preview;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.awt.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.StringReader;
import java.util.*;
import java.util.List;

/**
 *
 * 店铺设置
 * @author
 */

@Controller
@RequestMapping(value = "/store")
public class SupplierStoreController extends BaseController {


	private static final Logger LOGGER = Logger.getLogger(SupplierStoreController.class);

	@Autowired
	private SupplierStoreService supplierStoreService;
	
	@Autowired
	private SupplierManagerService supplierManagerService;
	
	@Autowired
	private DealerPopProductService dealerPopProductService;


	public final String edit_page = "/zh/store/storeEdit";
	
	private final String default_template = "1"; // 默认模板

	/**
	 * 页面编辑-进入编辑页面
	 * @return String 地址
	 */
	@RequestMapping(value = "initEdit", method = RequestMethod.GET)
	public ModelAndView initEdit() {
		ModelAndView mav = new ModelAndView();

		SupplierStore store = null;
		long supplierId = getCurrentSupplierId();

		try {

			if(supplierId > 0){
				store = supplierStoreService.findSupplierStoreBySupplierId((int)supplierId);
				String string1 = store.getPreviewContent();
				if("".equals(string1)){
					string1 = null;
				}
				if(null!=string1){
					JSONObject jsonObject = JSONObject.fromObject(string1);
					LOGGER.info("jsonObject="+jsonObject);
					Map<String, Class> classMap = new HashMap<String, Class>();
					classMap.put("floor1", Floor1.class);
					classMap.put("floor2", Floor2.class);
					classMap.put("floor3", Floor3.class);
					
					Preview preview1 = (Preview) JSONObject.toBean(jsonObject, Preview.class,classMap);
					
					mav.addObject("preview", preview1);
					mav.addObject("files", Constants.FILESERVER1);
					System.out.println(preview1.getFloorName1()+" floor1= "+preview1.getFloor1().get(0).getPid());
					LOGGER.info("previewJosn="+store.getPreviewContent());
				}else {
					mav.addObject("preview", null);
				}
			}
		}catch (Exception e){
			e.printStackTrace();
		}

		mav.setViewName(edit_page);
		mav.addObject("store",store);
		return mav;
	}

	@RequestMapping(value="/modle/getManagementModle")
	public ModelAndView getModle(){
		int  templateId = 1;
		Long supplierId = this.getCurrentSupplierId();
		SupplierStore store = supplierStoreService.findSupplierStoreBySupplierId(supplierId.intValue());

		if(store != null){
			templateId = store.getTemplateType();
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName(getLanguage() + "/modle/managementModle");
		mav.addObject("templateId",templateId);
		return mav;
	}
	
	@RequestMapping(value="/modle/preview")
	public String preview(String modleNum){
		if(StringUtils.isBlank(modleNum)){
			modleNum = default_template;
		}
		return getLanguage() + "/modle/preview" + modleNum;
	}
	
	@RequestMapping(value="/modle/mobile")
	public String mobile(String modleNum){
		if(StringUtils.isBlank(modleNum)){
			modleNum = default_template;
		}
		return getLanguage() + "/modle/mobile" + modleNum;
	}
	
	@RequestMapping(value="/modle/setModle")
	public ModelAndView setModle(String modleNum){
		LOGGER.info("开始设置模板！！！！！！！");
		if(null != modleNum){
			supplierStoreService.updateStoreTemplate(getCurrentSupplierId().intValue(),Integer.parseInt(modleNum));
		}
		LOGGER.info("设置模板成功！！！！");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(getLanguage() + "/modle/managementModle");
		mav.addObject("templateId",modleNum);
		return mav;

	}
	
	/**
	 * 
	 * 触发 该 供应商 下商品信息
	 * @param 
	 * @return model页面
	 */
	@RequestMapping("/toModelPage")
	public String toModelPage(Model model){
		
		
		long supplierId = getCurrentSupplierId();
		
//		supplierId = 27458l;
		
		List<Map<String, Object>> list1 = dealerPopProductService.getDealerPOPProductListBySupplierId(supplierId);
		
		model.addAttribute("supplierList", list1);
		model.addAttribute("files", Constants.FILESERVER1);
		return "/zh/store/supplierProduct";
	}
	
	/**
	 * 页面 编辑 提交预览功能
	 * preview_content
	 * banner:imgUrl
	 */
	@RequestMapping("/toPreview")
	@ResponseBody
	public String toPreview(
			String bannerUrls,
			String storeName,
			String[] imgUrl,
			//floor1
			String floorName1,
			String[] productid,
			String[] imageurl,
			String[] productName,
			String[] domesticPrice,
			String[] unitPrice,
			//floor2
			String floorName2,
			String[] productid1,
			String[] imageurl1,
			String[] productName1,
			String[] domesticPrice1,
			String[] unitPrice1,
			//floor3
			String floorName3,
			String[] productid2,
			String[] imageurl2,
			String[] domesticPrice2,
			String[] unitPrice2,
			String[] productName2){
		String  flag = "0"; 
		/*if(null == imgUrl){
			return "0";
		}*/
		StringBuilder qualification = new StringBuilder();
		String bannerUrl = "";
		if(null != imgUrl && imgUrl.length > 0){
			for(int i = 0;i < imgUrl.length;i++){
				if(i>0){
					qualification.append(",");
				}
				String url = imgUrl[i];
				url = url.substring(url.indexOf("group"));
				bannerUrl = imgUrl[0].substring(url.indexOf("group"));
				qualification.append(url);
			}
		}
		
		long supplierId = getCurrentSupplierId();
		// 组装json
		JSONObject root  = new JSONObject();
		root.put("supplierId", supplierId);
		root.put("storeName", storeName);
		
		if(null == imgUrl){
			root.put("bannerUrl", bannerUrls);
		}else {
			root.put("bannerUrl", imgUrl[0].substring(imgUrl[0].indexOf("group")));
		}
		
		root.put("floorName1", floorName1);
		root.put("floorName2", floorName2);
		root.put("floorName3", floorName3);
		// floor1
		JSONArray f1 = new JSONArray();
		if(productid != null && productid.length > 0){
			for (int i = 0; i < productid.length; i++) {
				JSONObject temp  = new JSONObject();
				temp.put("pid", productid[i]);
				temp.put("productName", productName[i]);
				temp.put("imgUrl", imageurl[i]);
				temp.put("domesticPrice", domesticPrice[i]);
				temp.put("unitPrice", unitPrice[i]);
				
				f1.add(temp);
			}
		}
		
		// floor2
		JSONArray f2 = new JSONArray();
		if(productid1 != null && productid1.length > 0){
			for (int i = 0; i < productid1.length; i++) {
				JSONObject temp  = new JSONObject();
				temp.put("pid", productid1[i]);
				temp.put("productName", productName1[i]);
				temp.put("imgUrl", imageurl1[i]);
				temp.put("domesticPrice", domesticPrice1[i]);
				temp.put("unitPrice", unitPrice1[i]);
				
				f2.add(temp);
			}
		}
		
		// floor3
		JSONArray f3 = new JSONArray();
		if(productid2 != null && productid2.length > 0){
			for (int i = 0; i < productid2.length; i++) {
				JSONObject temp  = new JSONObject();
				temp.put("pid", productid2[i]);
				temp.put("productName", productName2[i]);
				temp.put("imgUrl", imageurl2[i]);
				temp.put("domesticPrice", domesticPrice2[i]);
				temp.put("unitPrice", unitPrice2[i]);
				
				f3.add(temp);
			}
		}
		
		root.put("floor1", f1);
		root.put("floor2", f2);
		root.put("floor3", f3);
		LOGGER.info("预览 模板 josn==>"+root.toString());
//		supplierId = 27458;
		//previewContent 27458
		supplierStoreService.updateSupplierStorePreview((int)supplierId, storeName, root.toString());
		
		return "1";
	}
	
	/**
	 * 页面编辑 提交发布功能
	 * online_content
	 */
	@RequestMapping("/toOnline")
	@ResponseBody
	public String toOnline(
			String bannerUrls,
			String storeName,
			String[] imgUrl,
			//floor1
			String floorName1,
			String[] productid,
			String[] imageurl,
			String[] productName,
			String[] domesticPrice,
			String[] unitPrice,
			//floor2
			String floorName2,
			String[] productid1,
			String[] imageurl1,
			String[] productName1,
			String[] domesticPrice1,
			String[] unitPrice1,
			//floor3
			String floorName3,
			String[] productid2,
			String[] imageurl2,
			String[] domesticPrice2,
			String[] unitPrice2,
			String[] productName2){
		String  flag = "0"; 
		/*if(null == imgUrl){
			return "0";
		}*/
		StringBuilder qualification = new StringBuilder();
		String bannerUrl = "";
		if(null != imgUrl && imgUrl.length > 0){
			for(int i = 0;i < imgUrl.length;i++){
				if(i>0){
					qualification.append(",");
				}
				String url = imgUrl[i];
				url = url.substring(url.indexOf("group"));
				bannerUrl = imgUrl[0].substring(url.indexOf("group"));
				qualification.append(url);
			}
		}
		
		long supplierId = getCurrentSupplierId();
		// 组装json
		JSONObject root  = new JSONObject();
		root.put("supplierId", supplierId);
		root.put("storeName", storeName);
		if(null == imgUrl){
			root.put("bannerUrl", bannerUrls);
		}else {
			root.put("bannerUrl", imgUrl[0].substring(imgUrl[0].indexOf("group")));
		}
//		root.put("bannerUrl", imgUrl[0].substring(imgUrl[0].indexOf("group")));
		
		
		root.put("floorName1", floorName1);
		root.put("floorName2", floorName2);
		root.put("floorName3", floorName3);
		
		// floor1
		JSONArray f1 = new JSONArray();
		if(productid != null && productid.length > 0){
			for (int i = 0; i < productid.length; i++) {
				JSONObject temp  = new JSONObject();
				temp.put("pid", productid[i]);
				temp.put("productName", productName[i]);
				temp.put("imgUrl", imageurl[i]);
				temp.put("domesticPrice", domesticPrice[i]);
				temp.put("unitPrice", unitPrice[i]);
				
				f1.add(temp);
			}
		}
		
		// floor2
		JSONArray f2 = new JSONArray();
		if(productid1 != null && productid1.length > 0){
			for (int i = 0; i < productid1.length; i++) {
				JSONObject temp  = new JSONObject();
				temp.put("pid", productid1[i]);
				temp.put("productName", productName1[i]);
				temp.put("imgUrl", imageurl1[i]);
				temp.put("domesticPrice", domesticPrice1[i]);
				temp.put("unitPrice", unitPrice1[i]);
				
				f2.add(temp);
			}
		}
		
		// floor3
		JSONArray f3 = new JSONArray();
		if(productid2 != null && productid2.length > 0){
			for (int i = 0; i < productid2.length; i++) {
				JSONObject temp  = new JSONObject();
				temp.put("pid", productid2[i]);
				temp.put("productName", productName2[i]);
				temp.put("imgUrl", imageurl2[i]);
				temp.put("domesticPrice", domesticPrice2[i]);
				temp.put("unitPrice", unitPrice2[i]);
				
				f3.add(temp);
			}
		}
		
		root.put("floor1", f1);
		root.put("floor2", f2);
		root.put("floor3", f3);
		LOGGER.info("发布 模板 josn==>"+root.toString());
		
		supplierStoreService.publishStoreTemplateData((int)supplierId, storeName, root.toString(), (int)supplierId);//发布 模板 onlineContent
		
		return "1";
	}

	/**
	 * 店铺首页加载店铺主页信息对象
	 * @param supplierId
	 * @return
     */
	@RequestMapping("/info")
	public String getStoreInfo(HttpServletRequest request,HttpServletResponse response,String supplierId){
		String returnStr = "";
		String callback = request.getParameter("callback");

		// online=1是线上 online=2是预览
		String online = request.getParameter("online");

		try {
			if(StringUtils.isNotBlank(supplierId)){

					SupplierStore store = supplierStoreService.findSupplierStoreBySupplierId(Integer.parseInt(supplierId));
					if(store != null){
						if(StringUtils.isBlank(online)){
							returnStr = store.getOnlineContent();
						}else if("1".equals(online)){
							returnStr = store.getOnlineContent();
						}else if("2".equals(online)){
							returnStr = store.getPreviewContent();
						}else{
							returnStr = store.getOnlineContent();
						}


					}
			}
			response.setHeader("Content-type", "text/html;charset=UTF-8");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(callback+"("+returnStr+")");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
}
