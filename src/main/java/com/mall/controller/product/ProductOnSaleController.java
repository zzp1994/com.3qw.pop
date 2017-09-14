package com.mall.controller.product;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;
import org.csource.upload.UploadFileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.category.po.MoneyUnit;
import com.mall.category.po.TcCountry;
import com.mall.category.po.TcMeasure;
import com.mall.category.po.TdCatePub;
import com.mall.category.po.TdCatePubAttr;
import com.mall.category.po.TdCatePubAttrval;
import com.mall.controller.base.BaseController;
import com.mall.customer.model.ProductCostPriceSetting;
import com.mall.dealer.product.dto.DealerProductAttrDTO;
import com.mall.dealer.product.dto.DealerProductObjectDTO;
import com.mall.dealer.product.po.DealerProductAttach;
import com.mall.dealer.product.po.DealerProductAttrval;
import com.mall.dealer.product.po.DealerProductBuyAttrval;
import com.mall.dealer.product.po.DealerProductWholesaleRange;
import com.mall.dealer.product.po.LimitNum;
import com.mall.dealer.product.po.ProductTags;
import com.mall.dealer.productTags.api.ProductTagsService;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.mybatis.utility.PageBean;
import com.mall.supplier.model.Supplier;
import com.mall.supplier.model.SupplierBrandDTO;
import com.mall.supplier.product.api.SupplierProductAuditService;
import com.mall.supplier.product.dto.SupplierPordUpdateTateDto;
import com.mall.supplier.product.dto.SupplierProductAttrDTO;
import com.mall.supplier.product.dto.SupplierProductObjectDTO;
import com.mall.supplier.product.dto.SupplierProductSelectConDTO;
import com.mall.supplier.product.dto.SupplierProductShowDTO;
import com.mall.supplier.product.dto.SupplierProductSkuDTO;
import com.mall.supplier.product.exception.SupplierProException;
import com.mall.supplier.product.po.*;
import com.mall.utils.Common;
import com.mall.utils.Constants;
import com.mall.utils.CopyBeanUtil;
import com.mall.utils.DateUtil;
import com.mall.utils.JBarCodeUtil;
import com.mall.utils.MD5;

/**
 * 出售中的商品.
 * 
 * @author xusq
 */
@Controller
public class ProductOnSaleController extends BaseController {
	
	
	

    /**
     * .
     * 
     */
    private static final Logger LOGGER = Logger
            .getLogger(ProductOnSaleController.class);


//    /**
//     * .
//     * 
//     * @param model
//     *            model .
//     * @param productSelectConVO
//     *            查询dto
//     * @return String
//     */
//    @RequestMapping(value = "/product/onSaleList")
//    public String getPro(Model model,
//            SupplierProductSelectConDTO productSelectConVO) {
//    	List<SupplierBrandDTO> brands = new ArrayList<SupplierBrandDTO>();
//    	
//    	if(Constants.MANUFACTURER_TRADERS.equals(getSupplierType())||Constants.TRADERS.equals(getSupplierType())){
//    		List<Supplier> subSuppliers  = RemoteServiceSingleton.getInstance().getSupplierManagerService().getSubSuppliersByPid(getCurrentSupplierId());
//    		
//    		model.addAttribute("subSuppliers", subSuppliers);
//    	} 
//    	
//    	if(Constants.SUB_SUPPLIER.equals(getSupplierType())){
//    		
//    		brands = RemoteServiceSingleton.getInstance().getSupplierBrandManagerService().findSupplierBrandsBySubSupplierId(getCurrentSupplierId());
//    	} else {
//    		
//    		brands = RemoteServiceSingleton.getInstance().getSupplierBrandManagerService().findSupplierBrandsBySupplierId(getCurrentSupplierId());
//    		
//    	}
//
//    	logger.info("品牌信息"+JSON.toJSONString(brands));
//    	model.addAttribute("brands", brands);
//        
//    	return getLanguage() + "/product/onSaleList";
//    }

    /**
     * 利用ajax加载product.
     * @param productName productName
     * @param model model
     * @param cate category
     * @param auditStatus status状态吗
     * @param page pagenum
     * @param istate istate
     * @param productId productId
     * @return  success
     */
    @RequestMapping(value = "/product/getProductByConditions")
    public String getModel(String productName, Model model, String cate,Long subId,
            Short auditStatus, Integer page, String istate, Long productId,String brandId) {
    	LOGGER.info("getProductByConditions!!!auditStatus:"+auditStatus+";supplierId:"+getCurrentSupplierId());
        try {
            PageBean<SupplierProductShowDTO> pageBean = new PageBean<SupplierProductShowDTO>();
            SupplierProductSelectConDTO productSelectConVO = new SupplierProductSelectConDTO();
            List<String> list = new ArrayList<String>();
            if (cate != null) {
                list.add(cate);
                productSelectConVO.setCatePubIds(list);
            }

            productSelectConVO.setSupplierId(getCurrentSupplierId());

            if (null != productId && productId != 0) {
                productSelectConVO.setProductId(productId);
            }

            if (null != productName && !productName.equals("")) {
                productSelectConVO.setProductName(productName);
            }
            
            List<Long> supplierIds = new ArrayList<Long>();
            
            if(null != subId && !"".equals(subId)){
            	
            	supplierIds.add(subId);
            	
            } else {
            	supplierIds = getSupplierIds();
            }
            
            
           	productSelectConVO.setSupplierIds(supplierIds);

           	if(null != brandId && !"".equals(brandId)){

           		productSelectConVO.setBrandId(brandId);
           	}
            
            if (null != page && page != 0) {
                pageBean.setPage(page);
            } else {
                pageBean.setPage(1);
            }
            pageBean.setSortFields("PRODUCTNAME");
            pageBean.setOrder("ASC");

            PageBean<SupplierProductShowDTO> findProductsByConditions = new PageBean<SupplierProductShowDTO>();
            
            productSelectConVO.setAuditStatus(auditStatus);
            pageBean.setPageSize(Constants.PAGE_NUM_TEN);
            
            pageBean.setParameter(productSelectConVO);
            
            findProductsByConditions = 
                    RemoteServiceSingleton.getInstance().getSupplierProductService().findProductsByConditions(pageBean);
           
            
            // 设置图片的地址
            List<SupplierProductShowDTO> result = findProductsByConditions.getResult();
            for (SupplierProductShowDTO supplierProductShowVO : result) {
                String imgURL = supplierProductShowVO.getImgURL();
                if (!imgURL.startsWith("http") || !imgURL.startsWith("Http")) {
                    imgURL = Constants.IMAGES_VIEW1 + imgURL;
                    supplierProductShowVO.setImgURL(imgURL);
                }
            }
            model.addAttribute("pb", findProductsByConditions);
            return getLanguage() + "/product/modelPage/showProductList";
        } catch (Exception e) {
            logger.error("查询商品失败！！！auditStatus:"+auditStatus+";supplierId:"+getCurrentSupplierId()+e.getMessage(),e);

            return "1";

        }
    }

    /**
     * 查看商品信息.
     *
     * @param model 
     *            model
     * @param productId
     *            productid
     * @return String
     */
    @RequestMapping("/product/showProduct")
    public String showProduct(Model model, Long productId, @RequestParam(required = false) String page, @RequestParam(required = false)  String dpro) {
        LOGGER.info("viewProduct!!!productId:"+productId+";supplierId:"+getCurrentSupplierId());
        SupplierProductObjectDTO proObjVo = new SupplierProductObjectDTO();
        
        
        Map<TdCatePubAttr, List<TdCatePubAttrval>> categoryAttrAndValList = 
                new LinkedHashMap<TdCatePubAttr, List<TdCatePubAttrval>>();
        
        List<TdCatePub> cateNames = new ArrayList<TdCatePub>();
        
        
        try {
        	
            proObjVo = RemoteServiceSingleton.getInstance()
                    .getSupplierProductService().findProductObjectById(productId, "");
            
            String categoryId = proObjVo.getSupplierProduct().getCatePubId();
            
            categoryAttrAndValList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc()
                    .getCategoryAttrAndValList(categoryId);
            
            cateNames = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCategoryNameByDigui(categoryId);
            
        } catch (Exception e) {
        	
            LOGGER.error("获取商品信息失败：" + e.getMessage(),e);
        }
        
        ProductService serviceController = new ProductService();
        

        // //属性和属性值回显
        List<SupplierProductAttrDTO> productAttrVOs = proObjVo.getSupplierProductAttrDTOs();
        List<SupplierProductAttrDTO> pageAttrs = serviceController.showAttrAndAttrVal(
                categoryAttrAndValList, productAttrVOs);

        // 图片回显
        List<LinkedHashMap<String, Object>> imgUrl = imgShow(pageAttrs);

        JSONArray returnImgUrlAndName = JSONArray.fromObject(imgUrl);
        
        logger.info("图片回显：---"+returnImgUrlAndName.toString());

        // 价格或者sku回显
        List<SupplierProductWholesaleRange> supplierProductWholesaleRanges = proObjVo
                .getSupplierProductWholesaleRanges();

        Map<String, Object> productPic = new LinkedHashMap<String, Object>();
        List<Long> countList = new ArrayList<Long>();
        List<BigDecimal> picList = new ArrayList<BigDecimal>();

        if (supplierProductWholesaleRanges != null && supplierProductWholesaleRanges.size() > 0) {
            
            for (SupplierProductWholesaleRange supplierProductWholesaleRange : supplierProductWholesaleRanges) {
                Long startQty = supplierProductWholesaleRange.getStartQty();
                countList.add(startQty);
                BigDecimal discountPic = supplierProductWholesaleRange.getDiscount();
                picList.add(discountPic);
            }

            productPic.put("type", 0);
            productPic.put("start", countList);
            productPic.put("pic", picList);
        } else {
            // 按照sku的价格回显
            List<Object> skusPic = serviceController.showSkuPic(proObjVo);
            productPic.put("type", 1);
            productPic.put("start", 0);
            productPic.put("pic", skusPic);
        }
        JSONArray jsonProductPic = JSONArray.fromObject(productPic);

        proObjVo.setSupplierProductAttrDTOs(pageAttrs);

        
        //将默认日期设置为null
        Date receiveDate = proObjVo.getSupplierProductDetail().getReceiveDate();
        Date deliverDate = proObjVo.getSupplierProductDetail().getDeliverDate();
        
        if(DateUtil.getDateYear(receiveDate)==1999){
        	proObjVo.getSupplierProductDetail().setReceiveDate(null);
        }
        if(DateUtil.getDateYear(deliverDate)==1999){
        	proObjVo.getSupplierProductDetail().setDeliverDate(null);
        }
        
        
        // 图文详情和资质图片
        String fileurl = "";
        List<SupplierProductAttach> productAttachs = proObjVo.getSupplierProductAttachs();
        String attch = "";
        List<String> qualification = new ArrayList<String>();
        for (SupplierProductAttach supplierProductAttach : productAttachs) {
        	if(Constants.PRODUCT_DESCRIPTIONS == supplierProductAttach.getType()){
        		fileurl = Constants.IMAGES_VIEW2 + supplierProductAttach.getFileurl();
        	}
        	
        	if(supplierProductAttach.getType() == Constants.PRODUCT_QUALIFICATION){
        		qualification.add(Constants.IMAGES_VIEW1+supplierProductAttach.getFileurl());
        	}
		}
        
        JSONArray qualificationUrl = JSONArray.fromObject(qualification);
        

        JSONArray skusCode = JSONArray.fromObject(serviceController.showSkuCode(proObjVo));
        
        Set<TdCatePubAttr> keySet = categoryAttrAndValList.keySet();
        List<String> buyAttrName = new ArrayList<String>();
		List<String> saleAttrName = new ArrayList<String>();
		
		for (TdCatePubAttr tdCatePubAttr : keySet) {
			if(tdCatePubAttr.getBuyAttr()==1){
				String buyAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
				String buyAttrNameEn = tdCatePubAttr.getLineAttrName();
				buyAttrName.add(0, buyAttrNameCn);
				buyAttrName.add(1, buyAttrNameEn);
			}
			if(tdCatePubAttr.getSaleAttr()==1){
				String saleAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
				String saleAttrNameEn = tdCatePubAttr.getLineAttrName();
				saleAttrName.add(0, saleAttrNameCn);
				saleAttrName.add(1, saleAttrNameEn);
				
			}
			
		}


		
		
		
		
		
		model.addAttribute("supplierType", getSupplierType());
		model.addAttribute("fileurl", fileurl);
		model.addAttribute("buyAttrName", buyAttrName);
		model.addAttribute("saleAttrName", saleAttrName);
        model.addAttribute("qualificationUrl", qualificationUrl);
        model.addAttribute("skusCode", skusCode);
        model.addAttribute("cateNames", cateNames);
        model.addAttribute("attch", attch);
        model.addAttribute("proObj", proObjVo);
        model.addAttribute("jsonImg", returnImgUrlAndName);
        model.addAttribute("skuPriceAndCount", jsonProductPic);
        model.addAttribute("page",page);
        model.addAttribute("dpro",dpro);
        return getLanguage() + "/product/showProduct";
    }

    
    /**
     * 暂时不使用此方法加载文件服务器文件
     * @param fileurl
     * @return
     */
    @SuppressWarnings("unused")
	private String getAttrach(String fileurl) {
        if (!fileurl.startsWith("Http")) {
            fileurl = Constants.IMAGES_VIEW2 + fileurl;
        }

        StringBuffer buf = new StringBuffer();
        try {
            URL url = new URL(fileurl);
            HttpURLConnection uc = (HttpURLConnection) url.openConnection();
            uc.setDoInput(true);
            uc.connect();   
            Thread.sleep(Constants.PUBLIC_STATIC_NUM_1000);
            // 创建输入流
            InputStream iputstream = uc.getInputStream();

            InputStreamReader is = new InputStreamReader(iputstream);
            BufferedReader bis = new BufferedReader(is);

            // 从输入流读取数据
            while (bis.ready()) {
                int c = bis.read();
                buf.append((char) c);
            }
            // 关闭输入流
            bis.close();
            is.close();
            iputstream.close();

        } catch (Exception e) {
            LOGGER.error("读取图文详情失败！url:"+fileurl+e.getMessage(), e);
        }
        return buf.toString();
    }

    /**
     * 下架.
     *
     * @param pid
     *            productid
     * @return String
     */
    @RequestMapping(value = "/product/updateProductTateByIds")
    @ResponseBody
    public String updateProductTateByIds(String pid,String stopReason) {
    	logger.info("商品下架productId："+pid+";supplierId:"+getCurrentSupplierId());
    	logger.info("商品下架原因："+stopReason);
        if (pid.length() > 0) {
            try {
                String[] cates = pid.split(",");
                Long[] catels = new Long[cates.length];
                for (int i = 0; i < cates.length; i++) {
                    catels[i] = Long.parseLong(cates[i]);
                }
                // updateProductTateByIds(id数组, 状态, 操作人, 分表（暂时传空）);
                SupplierPordUpdateTateDto productStatus = new SupplierPordUpdateTateDto();
                productStatus.setProductIds(catels);
                productStatus.setOperatorId(getCurrentUserId());
                productStatus.setStatus((short)0);
                productStatus.setStopReason(stopReason);
				RemoteServiceSingleton.getInstance()
                .getSupplierProductService().updateProductTateByIds(productStatus);
				System.out.println("下架原因："+productStatus.getStopReason());
                return "1";
            } catch (Exception e) {
            	logger.error("商品下架失败productId："+pid+";supplierId:"+getCurrentSupplierId()+e.getMessage(),e);
                return "0";
            }
        } else {
            return "0";
        }
    }

    /**
     * 上架.
     *
     * @param pid
     *            productid
     * @return String 是否成功
     */
    @RequestMapping(value = "/product/upProductByIds")
    @ResponseBody
    public String upProductByIds(String pid) {
    	logger.info("商品上架productId："+pid+";supplierId:"+getCurrentSupplierId());
        if (pid.length() > 0) {
            try {
                String[] cates = pid.split(",");
                Long[] catels = new Long[cates.length];
                for (int i = 0; i < cates.length; i++) {
                    catels[i] = Long.parseLong(cates[i]);
                }
                // updateProductTateByIds(id数组, 状态, 操作人, 分表（暂时传空）);
                SupplierPordUpdateTateDto productStatus = new SupplierPordUpdateTateDto();
                productStatus.setOperatorId(getCurrentUserId());
                productStatus.setProductIds(catels);
                productStatus.setStatus((short)1);
                
                RemoteServiceSingleton.getInstance().getSupplierProductService()
                        .updateProductTateByIds(productStatus);
                return "1";
            } catch (Exception e) {
            	logger.error("商品上架失败！！！productId："+pid+";supplierId:"+getCurrentSupplierId());
                return "0";
            }
        } else {
            return "0";
        }
    }

    /**
     * 删除商品.
     *
     * @param pid
     *            商品id
     * @return String 返回值
     */
    @RequestMapping(value = "/product/deletePros")
    @ResponseBody
    public String deletePros(String pid) {
    	logger.info("删除商品productId："+pid+";supplierId:"+getCurrentSupplierId());
        if (pid.length() > 0) {
            try {
                String[] cates = pid.split(",");
                Long[] catels = new Long[cates.length];
                for (int i = 0; i < cates.length; i++) {
                    catels[i] = Long.parseLong(cates[i]);
                }
                // updateProductTateByIds(id数组, 操作人, 分表（暂时传空）);
                RemoteServiceSingleton.getInstance()
                        .getSupplierProductService()
                        .deleteProductById(catels, "", "");
                return "1";
            } catch (Exception e) {
                return "0";
            }
        } else {
            return "0";
        }
    }
    
    
    
    /**
     * 删除dealer商品.
     *
     * @param pid
     *            商品id
     * @return String 返回值
     */
    @RequestMapping(value = "/product/deleteProsDealer")
    @ResponseBody
    public String deleteProsDealer(String pid) {
    	logger.info("删除商品productId："+pid+";supplierId:"+getCurrentSupplierId());
        if (pid.length() > 0) {
            try {
                String[] cates = pid.split(",");
                Long[] catels = new Long[cates.length];
                for (int i = 0; i < cates.length; i++) {
                    catels[i] = Long.parseLong(cates[i]);
                }
                // updateProductTateByIds(id数组, 操作人, 分表（暂时传空）);
                RemoteServiceSingleton.getInstance()
                        .getSupplierProductService()
                        .deleteProductById(catels, "", "");
                RemoteServiceSingleton.getInstance().getDealerProductService().deleteProductById(catels, "", "");
                return "1";
            } catch (Exception e) {
                return "0";
            }
        } else {
            return "0";
        }
    }
    
    
    /**
     * 删除訂單.
     *
     * @param oid
     *            訂單id
     * @return String 返回值
     */
    @RequestMapping(value = "/order/deleteOrder")
    @ResponseBody
    public String deleteOrder(String oid) {
    	logger.info("刪除訂單id："+oid+";supplierId:"+getCurrentSupplierId());
        if (oid!=null) {
            try {
                
                // updateProductTateByIds(id数组, 操作人, 分表（暂时传空）);
            	
                RemoteServiceSingleton.getInstance().getCustomerOrderService().deleteOrder(Long.parseLong(oid));
                
                return "1";
            } catch (Exception e) {
            	System.out.println(e.getMessage());
                return "0";
            }
        } else {
            return "0";
        }
    }
    
  

    
    
    
    /**
     * 加载一级类目.
     * 
     * @return json 字符串
     */
    @RequestMapping(value = "/product/getFirstDisp")
    @ResponseBody
    public String getFirstDisp() {
        List<TdCatePub> list = new ArrayList<TdCatePub>();
        try {
//        	if(Constants.SUB_SUPPLIER.equals(getSupplierType())){				
//				list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFilterTopCategoryList(getBrandsBySubSupplierId());	
//			} else {
//				list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFilterTopCategoryList(getBrandsBySupplierId());	
//			} 
        	list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFirstCategoryList();
            logger.info("加载一级类目");
        } catch (Exception e) {
            logger.error("获取类目失败：" + e.getMessage(),e);
        }
        return JSONArray.fromObject(list).toString();
    }

    /**
     * 加载子类目.
     * 
     * @param parCateDispId
     *            父目录id
     * @return json串
     */
    @RequestMapping(value = "/product/getOtherDisp")
    @ResponseBody
    public String getOtherDisp(String parCateDispId) {
        List<TdCatePub> list = new ArrayList<TdCatePub>();
        try {
//        	if(Constants.SUB_SUPPLIER.equals(getSupplierType())){
//				list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFilterChildrenCategoryList(parCateDispId,getBrandsBySubSupplierId());
//			} else{
//				list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFilterChildrenCategoryList(parCateDispId,getBrandsBySupplierId());
//				
//			} 
        	list = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getFirstChildrenCategoryList(parCateDispId);
            LOGGER.info("获取二三级目录");
        } catch (Exception e) {
            LOGGER.error("获取子类目失败：" + e.getMessage(),e);
        }
        return JSONArray.fromObject(list).toString();
    }

    /**
     * 转向修改商品页.
     * 
     * @param model
     *            model
     * @param productId
     *            productid
     * @return StringUrl
     */
    @RequestMapping("/product/toEditUI")
    public String updataProduct(Model model, Long productId) {

    	logger.info("toEditProductUI!!!productId："+productId+";supplierId:"+getCurrentSupplierId());
    	
        Map<TdCatePubAttr, List<TdCatePubAttrval>> categoryAttrAndValList = new LinkedHashMap<TdCatePubAttr, List<TdCatePubAttrval>>();
        
        
        SupplierProductObjectDTO proObjVo = new SupplierProductObjectDTO();
        
        List<TcMeasure> allMeasure = new ArrayList<TcMeasure>();
        List<TcCountry> countries = new ArrayList<TcCountry>();
        List<TdCatePub> cateNames = new ArrayList<TdCatePub>();
        List<MoneyUnit> momeyUnits = new ArrayList<MoneyUnit>();
        
        try {
        	
        	
            allMeasure = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().findAllMeasure();
            
            proObjVo = RemoteServiceSingleton.getInstance().getSupplierProductService()
                    .findProductObjectById(productId, "");
            
            String categoryId = proObjVo.getSupplierProduct().getCatePubId();
            
            categoryAttrAndValList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc()
                    .getCategoryAttrAndValList(categoryId);
            
            countries = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getTcCountries();
            
            cateNames = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCategoryNameByDigui(categoryId);
            
            momeyUnits = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getMomeyUnits();
            
            
        } catch (Exception e) {
        	
            LOGGER.error("获取商品信息失败productId"+productId+";supplierId:"+getCurrentSupplierId() + e.getMessage(),e);
            return "/error/notFind";
        }

        Long supplierid = proObjVo.getSupplierProduct().getSupplierid();
        
        Long currentSupplierId = getCurrentSupplierId();
        
        if (currentSupplierId.equals(supplierid)) {

        	ProductService serviceController = new ProductService();
        	
        	
            // 属性和属性值回显
            List<SupplierProductAttrDTO> productAttrVOs = proObjVo
                    .getSupplierProductAttrDTOs();
            List<SupplierProductAttrDTO> pageAttrs = serviceController.showAttrAndAttrVal(
                    categoryAttrAndValList, productAttrVOs);

            // 图片回显
            List<LinkedHashMap<String, Object>> imgUrl = imgShow(pageAttrs);

            JSONArray returnImgUrlAndName = JSONArray.fromObject(imgUrl);

            // 价格或者sku回显
            List<SupplierProductWholesaleRange> supplierProductWholesaleRanges =
                    proObjVo.getSupplierProductWholesaleRanges();

            Map<String, Object> productPic = new LinkedHashMap<String, Object>();
            List<Long> countList = new ArrayList<Long>();
            List<BigDecimal> picList = new ArrayList<BigDecimal>();

            if (supplierProductWholesaleRanges != null && supplierProductWholesaleRanges.size() > 0) {
                for (SupplierProductWholesaleRange supplierProductWholesaleRange : supplierProductWholesaleRanges) {
                    Long startQty = supplierProductWholesaleRange.getStartQty();
                    countList.add(startQty);
                    BigDecimal discountPic = supplierProductWholesaleRange
                            .getDiscount();
                    picList.add(discountPic);
                }

                productPic.put("type", 0);
                productPic.put("start", countList);
                productPic.put("pic", picList);
            } else {
                // 按照sku的价格回显
                List<Object> skusPic = serviceController.showSkuPic(proObjVo);
                productPic.put("type", 1);
                productPic.put("start", 0);
                productPic.put("pic", skusPic);
            }
            JSONArray jsonProductPic = JSONArray.fromObject(productPic);

            proObjVo.setSupplierProductAttrDTOs(pageAttrs);

            // 图文详情和资质图片
            
            String fileurl = "";
            List<SupplierProductAttach> productAttachs = proObjVo.getSupplierProductAttachs();
            String attch = "";
            Long prodAttachId = 0L;
            List<String> qualification = new ArrayList<String>();
            for (SupplierProductAttach supplierProductAttach : productAttachs) {
            	if(Constants.PRODUCT_DESCRIPTIONS == supplierProductAttach.getType()){
            		fileurl = supplierProductAttach.getFileurl();
            		prodAttachId = supplierProductAttach.getProductattachid();
            		attch = UploadFileUtil.DownloadFile(fileurl);
            	}
            	
            	if(supplierProductAttach.getType() == Constants.PRODUCT_QUALIFICATION){
            		qualification.add(Constants.IMAGES_VIEW1+supplierProductAttach.getFileurl());
            	}
			}
            
            JSONArray qualificationUrl = JSONArray.fromObject(qualification);
            

            
            //将默认日期设置为null
            Date receiveDate = proObjVo.getSupplierProductDetail().getReceiveDate();
            Date deliverDate = proObjVo.getSupplierProductDetail().getDeliverDate();
            if(DateUtil.getDateYear(receiveDate)==1999){
            	proObjVo.getSupplierProductDetail().setReceiveDate(null);
            }
            if(DateUtil.getDateYear(deliverDate)==1999){
            	proObjVo.getSupplierProductDetail().setDeliverDate(null);
            }

            

            JSONArray skusCode = JSONArray.fromObject(serviceController.showSkuCode(proObjVo));
            String salesCalls = proObjVo.getSupplierProductDetail().getSalesCalls();
            String[] areaAndNum = salesCalls.split("-");
            
            
            
            
            Set<TdCatePubAttr> keySet = categoryAttrAndValList.keySet();
            List<String> buyAttrName = new ArrayList<String>();
    		List<String> saleAttrName = new ArrayList<String>();
    		
    		for (TdCatePubAttr tdCatePubAttr : keySet) {
    			if(tdCatePubAttr.getBuyAttr()==1){
    				String buyAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
    				String buyAttrNameEn = tdCatePubAttr.getLineAttrName();
    				buyAttrName.add(0, buyAttrNameCn);
    				buyAttrName.add(1, buyAttrNameEn);
    			}
    			if(tdCatePubAttr.getSaleAttr()==1){
    				String saleAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
    				String saleAttrNameEn = tdCatePubAttr.getLineAttrName();
    				saleAttrName.add(0, saleAttrNameCn);
    				saleAttrName.add(1, saleAttrNameEn);
    				
    			}
    			
    		}

            List<SupplierProductAudit> auditList = RemoteServiceSingleton
                    .getInstance()
                    .getSupplierProductAuditService()
                    .findProductAuditByProductId(productId);
            if(null != auditList && !auditList.isEmpty()){
                model.addAttribute("rejectReason",auditList.get(auditList.size()-1).getDescription());
            }
    		

    		model.addAttribute("supplierType", getSupplierType());
			model.addAttribute("price", momeyUnits);
    		model.addAttribute("prodAttachId", prodAttachId);
    		model.addAttribute("buyAttrName", buyAttrName);
    		model.addAttribute("saleAttrName", saleAttrName);
            model.addAttribute("qualificationUrl", qualificationUrl);
            model.addAttribute("cateNames", cateNames);
            model.addAttribute("phoneNumber", areaAndNum);
            model.addAttribute("skusCode", skusCode);
            model.addAttribute("language", getLanguage().substring(1));
            model.addAttribute("measure", allMeasure);
            model.addAttribute("countries", countries);
            model.addAttribute("attch", attch);
            model.addAttribute("proObj", proObjVo);
            model.addAttribute("jsonImg", returnImgUrlAndName);
            model.addAttribute("skuPriceAndCount", jsonProductPic);
            //model.addAttribute("type", type);
            
            
            
            return getLanguage() + "/product/editProductUI";
        } else {
            return "/error/notFind";
        }
    }


    /**
     * 转向修改商品页.
     *
     * @param model
     *            model
     * @param productId
     *            productid
     * @return StringUrl
     */
    @RequestMapping("/product/toEditPOPUI")
    public String updataPOPProduct(Model model, Long productId, @RequestParam(required = false) String page, @RequestParam(required = false)  String dpro) {

        logger.info("toEditProductUI!!!productId："+productId+";supplierId:"+getCurrentSupplierId());

//        Map<TdCatePubAttr, List<TdCatePubAttrval>> categoryAttrAndValList = new LinkedHashMap<TdCatePubAttr, List<TdCatePubAttrval>>();


        SupplierProductObjectDTO proObjVo = new SupplierProductObjectDTO();
        
        

        ProductCostPriceSetting pcp = null;
        List<ProductCostPriceSetting>  findProductCostPriceSettingAll=null;
        List<ProductCostPriceSetting>  findProductCostPriceSettingxf=null;
        List<TcMeasure> allMeasure = new ArrayList<TcMeasure>();
        List<TcCountry> countries = new ArrayList<TcCountry>();
        List<TdCatePub> cateNames = new ArrayList<TdCatePub>();
        List<MoneyUnit> momeyUnits = new ArrayList<MoneyUnit>();

        try {
        	List<LimitNum> selectNum = RemoteServiceSingleton.getInstance().getDealerProductService().selectNum();
        	LimitNum limitNum = selectNum.get(0);
        	if(limitNum!=null)
        	{
        		model.addAttribute("limitNum", limitNum.getMaxNum());
        	}
        	findProductCostPriceSettingxf=RemoteServiceSingleton.getInstance().getProductCostPriceSettingService().findProductCostPriceSettingAll3();
        	 findProductCostPriceSettingAll = RemoteServiceSingleton.getInstance().getProductCostPriceSettingService().findProductCostPriceSettingAll2();
            pcp = RemoteServiceSingleton.getInstance().getProductCostPriceSettingService().findProductCostPriceSetting();

            allMeasure = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().findAllMeasure();

            proObjVo = RemoteServiceSingleton.getInstance().getSupplierProductService()
                    .findProductObjectById(productId, "");

            String categoryId = proObjVo.getSupplierProduct().getCatePubId();

//            categoryAttrAndValList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc()
//                    .getCategoryAttrAndValList(categoryId);

            countries = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getTcCountries();

            cateNames = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCategoryNameByDigui(categoryId);

            momeyUnits = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getMomeyUnits();


        } catch (Exception e) {

            LOGGER.error("获取商品信息失败productId"+productId+";supplierId:"+getCurrentSupplierId() + e.getMessage(),e);
            return "/error/notFind";
        }

        Long supplierid = proObjVo.getSupplierProduct().getSupplierid();

        Long currentSupplierId = getCurrentSupplierId();

        if (currentSupplierId.equals(supplierid)) {

            ProductService serviceController = new ProductService();


            // 属性和属性值回显
            List<SupplierProductAttrDTO> pageAttrs = proObjVo
                    .getSupplierProductAttrDTOs();
//            List<SupplierProductAttrDTO> pageAttrs = serviceController.showAttrAndAttrVal(
//                    categoryAttrAndValList, productAttrVOs);

            // 图片回显
            List<LinkedHashMap<String, Object>> imgUrl = imgShow(pageAttrs);

            JSONArray returnImgUrlAndName = JSONArray.fromObject(imgUrl);

            // 价格或者sku回显
            List<SupplierProductWholesaleRange> supplierProductWholesaleRanges =
                    proObjVo.getSupplierProductWholesaleRanges();

            Map<String, Object> productPic = new LinkedHashMap<String, Object>();
            List<Long> countList = new ArrayList<Long>();
            List<BigDecimal> picList = new ArrayList<BigDecimal>();

            if (supplierProductWholesaleRanges != null && supplierProductWholesaleRanges.size() > 0) {
                for (SupplierProductWholesaleRange supplierProductWholesaleRange : supplierProductWholesaleRanges) {
                    Long startQty = supplierProductWholesaleRange.getStartQty();
                    countList.add(startQty);
                    BigDecimal discountPic = supplierProductWholesaleRange
                            .getDiscount();
                    picList.add(discountPic);
                }

                productPic.put("type", 0);
                productPic.put("start", countList);
                productPic.put("pic", picList);
            } else {
                // 按照sku的价格回显
                List<Object> skusPic = serviceController.showSkuPic(proObjVo);
                productPic.put("type", 1);
                productPic.put("start", 0);
                productPic.put("pic", skusPic);
            }
            JSONArray jsonProductPic = JSONArray.fromObject(productPic);

            proObjVo.setSupplierProductAttrDTOs(pageAttrs);

            // 图文详情和资质图片

            String fileurl = "";
            List<SupplierProductAttach> productAttachs = proObjVo.getSupplierProductAttachs();
            String attch = "";
            Long prodAttachId = 0L;
            List<String> qualification = new ArrayList<String>();
            for (SupplierProductAttach supplierProductAttach : productAttachs) {
                if(Constants.PRODUCT_DESCRIPTIONS == supplierProductAttach.getType()){
                    fileurl = supplierProductAttach.getFileurl();
                    prodAttachId = supplierProductAttach.getProductattachid();
                    attch = UploadFileUtil.DownloadFile(fileurl);
                    if(null != attch && attch.indexOf("detail_inner.css")!=-1){
                    	String startStr="<link rel=\"stylesheet\" href=\"http://static.3qianwan.com/commons/css/detail_inner.css\" type=\"text/css\"><div class='detail_inner' >";
                    	String endStr="</div>";
                    	attch=attch.replaceAll(startStr, "").replaceAll(endStr, "");
                    }
                }

                if(supplierProductAttach.getType() == Constants.PRODUCT_QUALIFICATION){
                    qualification.add(Constants.IMAGES_VIEW1+supplierProductAttach.getFileurl());
                }
            }

            JSONArray qualificationUrl = JSONArray.fromObject(qualification);



            //将默认日期设置为null
            Date receiveDate = proObjVo.getSupplierProductDetail().getReceiveDate();
            Date deliverDate = proObjVo.getSupplierProductDetail().getDeliverDate();
            if(DateUtil.getDateYear(receiveDate)==1999){
                proObjVo.getSupplierProductDetail().setReceiveDate(null);
            }
            if(DateUtil.getDateYear(deliverDate)==1999){
                proObjVo.getSupplierProductDetail().setDeliverDate(null);
            }



            JSONArray skusCode = JSONArray.fromObject(serviceController.showSkuCode(proObjVo));
            String salesCalls = proObjVo.getSupplierProductDetail().getSalesCalls();
            String[] areaAndNum = salesCalls.split("-");

            List<SupplierProductAttrDTO> dtOs = new ArrayList<SupplierProductAttrDTO>();
    		for (SupplierProductAttrDTO supplierProductAttrDTO : proObjVo.getSupplierProductAttrDTOs()) {
    			if(supplierProductAttrDTO.getSupplierProductAttr().getBuyAttr()!=1 && supplierProductAttrDTO.getSupplierProductAttr().getSaleAttr()!=1){
    				dtOs.add(supplierProductAttrDTO);
    			}
    		}
    		for (int x = proObjVo.getSupplierProductAttrDTOs().size(); x > 0; x--) {
    			if (proObjVo.getSupplierProductAttrDTOs().get(x-1).getSupplierProductAttr().getBuyAttr()==(short) 0 &&
    					proObjVo.getSupplierProductAttrDTOs().get(x-1).getSupplierProductAttr().getSaleAttr()==(short) 0) {
    				proObjVo.getSupplierProductAttrDTOs().remove(x-1);
    			}
    		}
            // 初始化修改时，查询b2cdetail数据

            List<SupplierProductAudit> auditList = RemoteServiceSingleton
                    .getInstance()
                    .getSupplierProductAuditService()
                    .findProductAuditByProductId(productId);
            if(null != auditList && !auditList.isEmpty()){
                model.addAttribute("rejectReason",auditList.get(auditList.size()-1).getDescription());
            }
            
            if((proObjVo.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().getCashHqj())!=null)
            {
            	model.addAttribute("cash", proObjVo.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().getCashHqj());
            }
            if((proObjVo.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().getDomesticPrice())!=null)
            {
            	model.addAttribute("domestic", proObjVo.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().getDomesticPrice());
            }
            if((proObjVo.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().getUnitPrice())!=null)
            {
            	model.addAttribute("unit", proObjVo.getSupplierProductSkuDTOs().get(0).getSupplierProductPriceMap().getUnitPrice());
            }
            
          
            
            //现金比例
            
            ProductTags tags = RemoteServiceSingleton
            .getInstance()
            .getProductTagsService().LimitContentOrNull(productId, "xjzfbl", 5);
           
            model.addAttribute("tags", tags);
     
           

            model.addAttribute("supplierType", getSupplierType());
            model.addAttribute("price", momeyUnits);
            model.addAttribute("prodAttachId", prodAttachId);
            model.addAttribute("qualificationUrl", qualificationUrl);
            model.addAttribute("cateNames", cateNames);
            model.addAttribute("phoneNumber", areaAndNum);
            model.addAttribute("skusCode", skusCode);
            model.addAttribute("language", getLanguage().substring(1));
            model.addAttribute("measure", allMeasure);
            model.addAttribute("countries", countries);
            model.addAttribute("attch", attch);
            model.addAttribute("proObj", proObjVo);
            model.addAttribute("jsonImg", returnImgUrlAndName);
            model.addAttribute("skuPriceAndCount", jsonProductPic);
    		model.addAttribute("simpleAttrs", dtOs);
    		Supplier supplier = getSupplier();
    		if(supplier.getOrganizationType()==null ){
    			model.addAttribute("costPriceMultiple", pcp.getCostPriceMultiple());
    		}
    		if(supplier.getOrganizationType()!=null && supplier.getOrganizationType()==6 ){
    			model.addAttribute("costPriceMultiple", pcp.getCostPriceMultiple());
    		}

            model.addAttribute("page",page);
            model.addAttribute("dpro",dpro);
            Short type = proObjVo.getSupplierProduct().getProdType();
            if(type!=null&&type==5){
            	model.addAttribute("costPriceMultiple", findProductCostPriceSettingAll.get(0).getCostPriceMultiple());
            	 return getLanguage() + "/product/editPOPProductUI3";
            }
            if(type!=null&&type==6 && tags==null){
            	model.addAttribute("costPriceMultiple", findProductCostPriceSettingxf.get(0).getCostPriceMultiple());
            	return getLanguage() + "/product/editPOPProductUI4";
            }
           if(tags==null){
        	   return getLanguage() + "/product/editPOPProductUI2";
           }
         
          
            	
            	return getLanguage() + "/product/editPOPProductUI";
            

            
        } else {
            return "/error/notFind";
        }
    }



    /**
     * 转向商品查看
     *
     * @param model
     *            model
     * @param productId
     *            productid
     * @return StringUrl
     */
    @RequestMapping("/product/toShowPOPUI")
    public String showPOPProduct(Model model, Long productId, @RequestParam(required = false) String page, @RequestParam(required = false)  String dpro) {

        logger.info("toShowPOPUI!!!productId："+productId+";supplierId:"+getCurrentSupplierId());

//        Map<TdCatePubAttr, List<TdCatePubAttrval>> categoryAttrAndValList = new LinkedHashMap<TdCatePubAttr, List<TdCatePubAttrval>>();


        SupplierProductObjectDTO proObjVo = new SupplierProductObjectDTO();

        List<TcMeasure> allMeasure =  new ArrayList<TcMeasure>();
        List<TcCountry> countries = new ArrayList<TcCountry>();
        List<TdCatePub> cateNames = new ArrayList<TdCatePub>();
        List<MoneyUnit> momeyUnits = new ArrayList<MoneyUnit>();

        try {


            allMeasure = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().findAllMeasure();

            proObjVo = RemoteServiceSingleton.getInstance().getSupplierProductService()
                    .findProductObjectById(productId, "");

            String categoryId = proObjVo.getSupplierProduct().getCatePubId();

//            categoryAttrAndValList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc()
//                    .getCategoryAttrAndValList(categoryId);

            countries = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getTcCountries();

            cateNames = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCategoryNameByDigui(categoryId);

            momeyUnits = RemoteServiceSingleton.getInstance().getBaseDataServiceRpc().getMomeyUnits();


        } catch (Exception e) {

            LOGGER.error("获取商品信息失败,请求toShowPOPUI    商品productId"+productId+";supplierId:"+getCurrentSupplierId() + e.getMessage(),e);
            return "/error/notFind";
        }
        try {
            Long supplierid = proObjVo.getSupplierProduct().getSupplierid();

            Long currentSupplierId = getCurrentSupplierId();

            System.out.println("pop审核列表查看:currentSupplierId="+currentSupplierId + " supplierid=" +supplierid);
            if (currentSupplierId.equals(supplierid)) {

                ProductService serviceController = new ProductService();


                // 属性和属性值回显
                List<SupplierProductAttrDTO> pageAttrs = proObjVo
                        .getSupplierProductAttrDTOs();
//                List<SupplierProductAttrDTO> pageAttrs = serviceController.showAttrAndAttrVal(
//                        categoryAttrAndValList, productAttrVOs);

                // 图片回显
                List<LinkedHashMap<String, Object>> imgUrl = imgShow(pageAttrs);

                JSONArray returnImgUrlAndName = JSONArray.fromObject(imgUrl);

                // 价格或者sku回显
                List<SupplierProductWholesaleRange> supplierProductWholesaleRanges =
                        proObjVo.getSupplierProductWholesaleRanges();

                Map<String, Object> productPic = new LinkedHashMap<String, Object>();
                List<Long> countList = new ArrayList<Long>();
                List<BigDecimal> picList = new ArrayList<BigDecimal>();

                if (supplierProductWholesaleRanges != null && supplierProductWholesaleRanges.size() > 0) {
                    for (SupplierProductWholesaleRange supplierProductWholesaleRange : supplierProductWholesaleRanges) {
                        Long startQty = supplierProductWholesaleRange.getStartQty();
                        countList.add(startQty);
                        BigDecimal discountPic = supplierProductWholesaleRange
                                .getDiscount();
                        picList.add(discountPic);
                    }

                    productPic.put("type", 0);
                    productPic.put("start", countList);
                    productPic.put("pic", picList);
                } else {
                    // 按照sku的价格回显
                    List<Object> skusPic = serviceController.showSkuPic(proObjVo);
                    productPic.put("type", 1);
                    productPic.put("start", 0);
                    productPic.put("pic", skusPic);
                }
                JSONArray jsonProductPic = JSONArray.fromObject(productPic);

                proObjVo.setSupplierProductAttrDTOs(pageAttrs);

                // 图文详情和资质图片

                String fileurl = "";
                List<SupplierProductAttach> productAttachs = proObjVo.getSupplierProductAttachs();
                String attch = "";
                Long prodAttachId = 0L;
                List<String> qualification = new ArrayList<String>();
                for (SupplierProductAttach supplierProductAttach : productAttachs) {
                    if(Constants.PRODUCT_DESCRIPTIONS == supplierProductAttach.getType()){
                        fileurl = supplierProductAttach.getFileurl();
                        prodAttachId = supplierProductAttach.getProductattachid();
                        attch = UploadFileUtil.DownloadFile(fileurl);
                    }

                    if(supplierProductAttach.getType() == Constants.PRODUCT_QUALIFICATION){
                        qualification.add(Constants.IMAGES_VIEW1+supplierProductAttach.getFileurl());
                    }
                }

                JSONArray qualificationUrl = JSONArray.fromObject(qualification);



                //将默认日期设置为null
                Date receiveDate = proObjVo.getSupplierProductDetail().getReceiveDate();
                Date deliverDate = proObjVo.getSupplierProductDetail().getDeliverDate();
                if(DateUtil.getDateYear(receiveDate)==1999){
                    proObjVo.getSupplierProductDetail().setReceiveDate(null);
                }
                if(DateUtil.getDateYear(deliverDate)==1999){
                    proObjVo.getSupplierProductDetail().setDeliverDate(null);
                }



                JSONArray skusCode = JSONArray.fromObject(serviceController.showSkuCode(proObjVo));
                String salesCalls = proObjVo.getSupplierProductDetail().getSalesCalls();
                String[] areaAndNum = salesCalls.split("-");

                List<SupplierProductAudit> auditList = RemoteServiceSingleton
                        .getInstance()
                        .getSupplierProductAuditService()
                        .findProductAuditByProductId(productId);
                if(null != auditList && !auditList.isEmpty()){
                    model.addAttribute("rejectReason",auditList.get(auditList.size()-1).getDescription());
                }

                model.addAttribute("supplierType", getSupplierType());
                model.addAttribute("price", momeyUnits);
                model.addAttribute("prodAttachId", prodAttachId);
                model.addAttribute("qualificationUrl", qualificationUrl);
                model.addAttribute("cateNames", cateNames);
                model.addAttribute("phoneNumber", areaAndNum);
                model.addAttribute("skusCode", skusCode);
                model.addAttribute("language", getLanguage().substring(1));
                model.addAttribute("measure", allMeasure);
                model.addAttribute("countries", countries);
                model.addAttribute("attch", attch);
                model.addAttribute("proObj", proObjVo);
                model.addAttribute("jsonImg", returnImgUrlAndName);
                model.addAttribute("skuPriceAndCount", jsonProductPic);
                model.addAttribute("page",page);
                model.addAttribute("dpro",dpro);

                
                Supplier supplier = getSupplier();
                if(supplier.getOrganizationType()!=null&& supplier.getOrganizationType()==5){
                	return getLanguage() + "/product/showPOPProductUI2";
                }
                ProductTags tags = RemoteServiceSingleton
                        .getInstance()
                        .getProductTagsService().LimitContentOrNull(productId, "xjzfbl", 5);
                if(proObjVo.getSupplierProduct().getProdType()==6 && tags==null){
                	  return getLanguage() + "/product/showPOPProductUI3";
                }
                
                return getLanguage() + "/product/showPOPProductUI";
            } else {
                return "/error/notFind";
            }
        }catch(Exception e){
            LOGGER.error("pop审核列表查看,请求toShowPOPUI    商品productId"+productId+";supplierId:"+getCurrentSupplierId() + e.getMessage(),e);
            return "/error/notFind";
        }

    }


    /**
     * 修改商品.
     *
     * @param objectVO
     *            商品对象
     * @param cost
     *            1 梯度价 2按sku报价
     * @param start
     *            按梯度价其实数量
     * @param pic
     *            梯度价价格
     * @param buyIndex
     *            展示属性下标
     * @param saleIndex
     *            规格属性下标
     * @param productPic
     *            商品价格
     * @param saleVal
     *            规格属性值
     * @param buyVal
     *            展示属性值
     * @param pname
     *            商品名称
     * @param brandId
     *            主品牌id
     * @param subBrandId
     *            子品牌id
     * @param imgUrl
     *            图片url数组
     * @param buyName
     *            展示属性值name
     * @param saleName
     *            规格属性值name
     * @param editorValue
     *            图文详情
     * @return
     */
    @RequestMapping("/product/editProduct")
    @ResponseBody
    public String editProduct(SupplierProductObjectDTO objectVO, Integer cost,
            Long[] start, String fristPhone, String subPhone, BigDecimal[] pic,
            Long buyIndex, Long saleIndex, BigDecimal[] productPic,
            Long minNum, Long[] saleVal, Long[] buyVal, String pname,
            String brandId, String subBrandId, String[] skuCode,String[] barCodeImg,
            String[] imgUrl, String[] buyName, String[] saleName,String[]productCode,Integer auto,Integer priceType,String fobPort,String cifPort,
            String editorValue) {

    	LOGGER.info("enter_editProduct_Mothod=supplierId:"+getCurrentSupplierId()+";productId:"+objectVO.getProductId());
        String issavestatuinfo = "1";
        
        List<SupplierProductAttach> attachs = objectVO.getSupplierProductAttachs();
    	
    	/**
    	 * 设置商品资质
    	 */
    	List<String> buyAttrValUrl = new ArrayList<String>();
    	
    	 for (int x = 0; x < imgUrl.length; x++) {

    		 String[] prodImg = imgUrl[x].split("_");
             StringBuffer sb = new StringBuffer();
             for (int i = 1; i < prodImg.length; i++) {
                 if (i > 1) {
                     sb.append("_");
                 }
                 sb.append(prodImg[i]);
             }
             
             
             
             if("00".equals(prodImg[0])){
            	 
            	 SupplierProductAttach prodQualification = new SupplierProductAttach();
            	 String qualification = sb.toString();
            	 qualification = qualification.substring(qualification.indexOf("group"));
            	 prodQualification.setFileurl(qualification);
            	 prodQualification.setType(Constants.PRODUCT_QUALIFICATION);
            	 attachs.add(prodQualification);
            	 
             } else {
            	 buyAttrValUrl.add(imgUrl[x]);
             }
             
    	 }
        
        /**
         * 设置展示属性的图片url
         */
        List<Integer> buyMap = new ArrayList<Integer>();
        Map<Integer, List<SupplierProductBuyAttrval>> map = 
                new LinkedHashMap<Integer, List<SupplierProductBuyAttrval>>();
        
        if (buyAttrValUrl.size() > 0) {
            
            for (int x = 0; x < buyAttrValUrl.size(); x++) {
                String[] split = buyAttrValUrl.get(x).split("_");
                Integer index = Integer.parseInt(split[0]);
                buyMap.add(index);
                List<SupplierProductBuyAttrval> list = map.get(index);
                
                if (list != null && list.size() > 0) {
                    SupplierProductBuyAttrval buyAttrval = new SupplierProductBuyAttrval();
                    StringBuffer sb = new StringBuffer();
                    
                    for (int i = 1; i < split.length; i++) {
                        if (i > 1) {
                            sb.append("_");
                        }
                        sb.append(split[i]);
                    }
                    String imgurl = sb.toString();
                    imgurl = imgurl.substring(imgurl.indexOf("group"));
                    buyAttrval.setIstate((short) 1);
                    buyAttrval.setImgurl(imgurl);
                    list.add(buyAttrval);
                    
                } else {
                    list = new ArrayList<SupplierProductBuyAttrval>();
                    SupplierProductBuyAttrval buyAttrval = new SupplierProductBuyAttrval();
                    StringBuffer sb = new StringBuffer();
                    
                    for (int i = 1; i < split.length; i++) {
                        
                        if (i > 1) {
                            sb.append("_");
                        }
                        sb.append(split[i]);
                    }
                    String imgurl = sb.toString();
                    imgurl = imgurl.substring(imgurl.indexOf("group"));
                    buyAttrval.setIstate((short) 1);
                    buyAttrval.setImgurl(imgurl);
                    list.add(buyAttrval);
                    map.put(index, list);
                }
            }
        }

        /**
         * 商品基本信息
         */
        objectVO.getSupplierProductBase().setProductname(pname);
        objectVO.getSupplierProductBaseEn().setProductname(pname);

        /**
         * sku信息
         */
        List<SupplierProductSkuDTO> supplierProductSkuVOs = objectVO.getSupplierProductSkuDTOs();

        List<SupplierProductSkuDTO> productSkuVOs = new ArrayList<SupplierProductSkuDTO>();
        SupplierProductSaleSetting productSaleSetting = objectVO.getSupplierProductSaleSetting();
        List<SupplierProductWholesaleRange> wholesaleRanges = new ArrayList<SupplierProductWholesaleRange>();

        if(!Constants.DOMESTIC_DEALER.equals(getSupplierType())){
	        if (null!=cost&&cost == 2) {
	
	            productSaleSetting.setMaxSellerPrice(Common.getMax2(productPic));
	            productSaleSetting.setMinSellerPrice(Common.getMin2(productPic));
	            productSaleSetting.setMinWholesaleQty(minNum);
	
	            for (int i = 0; i < buyVal.length; i++) {
	
	                SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
	                SupplierProductSku productSku = new SupplierProductSku();
	                
	                //TODO
	                String skuCodeNum = "";
	                String barCodeImage = "";
	                if(null!=auto&&1==auto){
	                	skuCodeNum = JBarCodeUtil.getCreateRandom();
	                	barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
	                	LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
	                } else {
	                	skuCodeNum = skuCode[i];
	                	barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
	                }
	               
	                productSku.setSkuCode(skuCodeNum);
	                productSku.setBarCodeImage(barCodeImage); 
	                
	                productSku.setCreateDate(new Date());
	                productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
	                productSku.setSkuNameCn(buyName[i] + saleName[i]);
	                productSku.setSkuNameEn(buyName[i] + saleName[i]);
	                //商品货号
					if(productCode[i]!=null){	
						productSku.setProductCode(productCode[i]);
					}
	                skuVO.setSupplierProductSku(productSku);
	
	                List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();
	                SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
	                buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
	                buyAttrval.setAttrValId(buyVal[i]);
	                buyAttrval.setSupplierid(getCurrentSupplierId());
	                buyAttrval.setAttrvalNameCn(buyName[i]);
	                buyAttrval.setAttrvalNameEn(buyName[i]);
	                supplierProductSkuAttrvals.add(buyAttrval);
	
	                if (saleVal != null && saleVal.length > 0) {
	
	                    SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                    saleAttrval.setAttrId(Long.parseLong("" + saleIndex));
	                    saleAttrval.setAttrValId(saleVal[i]);
	                    saleAttrval.setSubsupplierid("");
	                    saleAttrval.setAttrvalNameCn(saleName[i]);
	                    saleAttrval.setAttrvalNameEn(saleName[i]);
	                    supplierProductSkuAttrvals.add(saleAttrval);
	                }
	
	                // 设置skuid及价格
	                for (SupplierProductSkuDTO skuAttr : supplierProductSkuVOs) {
	
	                    if (productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameCn())
	                            || productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameEn())) {
	                        productSku.setProductSkuId(skuAttr
	                                .getSupplierProductSku().getProductSkuId());
	                        productSku.setSkuId(skuAttr.getSupplierProductSku()
	                                .getSkuId());
	                        logger.info("skuId==="+skuAttr.getSupplierProductSku().getSkuId());
	                        skuVO.setSupplierProductPriceMap(skuAttr.getSupplierProductPriceMap());
	                    }
	
	                }
	
	                skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
	                SupplierProductPrice price = null;
	
	                if (skuVO.getSupplierProductPriceMap() != null) {
	
	                    price = skuVO.getSupplierProductPriceMap();
	                    price.setSupplierprice(productPic[i]);
	
	                } else {
	
	                    price = new SupplierProductPrice();
	                    price.setSupplierprice(productPic[i]);
	                }
	
	                skuVO.setSupplierProductPriceMap(price);
	
	                productSkuVOs.add(skuVO);
	            }
	        }
	
	        if (null!=cost&&cost == 1) {
	
	            productSaleSetting.setMaxSellerPrice(Common.getMax2(pic));
	            productSaleSetting.setMinSellerPrice(Common.getMin2(pic));
	            productSaleSetting.setMinWholesaleQty(start[0]);
	
	            for (int i = 0; i < buyVal.length; i++) {
	
	                SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
	                SupplierProductSku productSku = new SupplierProductSku();
	                
	                //TODO
	                String skuCodeNum = "";
	                String barCodeImage = "";
	                if(null!=auto&&1==auto){
	                	skuCodeNum = JBarCodeUtil.getCreateRandom();
	                	barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
	                	LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
	                } else {
	                	skuCodeNum = skuCode[i];
	                	barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
	                }
	                
	                
	                productSku.setSkuCode(skuCodeNum);
	                productSku.setBarCodeImage(barCodeImage); 
	                
	                productSku.setCreateDate(new Date());
	                productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
	                productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
	                productSku.setSkuNameCn(buyName[i] + saleName[i]);
	                productSku.setSkuNameEn(buyName[i] + saleName[i]);
	                //商品货号
					if(productCode[i]!=null){	
						productSku.setProductCode(productCode[i]);
					}
	                skuVO.setSupplierProductSku(productSku);
	
	                List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();
	                SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
	                buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
	                buyAttrval.setAttrValId(buyVal[i]);
	                buyAttrval.setSupplierid(getCurrentSupplierId());
	                buyAttrval.setAttrvalNameCn(buyName[i]);
	                buyAttrval.setAttrvalNameEn(buyName[i]);
	                supplierProductSkuAttrvals.add(buyAttrval);
	
	                if (saleVal != null && saleVal.length > 0) {
	                    SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
	                    saleAttrval.setAttrId(Long.parseLong("" + saleIndex));
	                    saleAttrval.setAttrValId(saleVal[i]);
	                    saleAttrval.setSubsupplierid("");
	                    saleAttrval.setAttrvalNameCn(saleName[i]);
	                    saleAttrval.setAttrvalNameEn(saleName[i]);
	                    supplierProductSkuAttrvals.add(saleAttrval);
	                }
	
	                skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
	
	                // 设置skuid及价格
	                for (SupplierProductSkuDTO skuAttr : supplierProductSkuVOs) {
	                    if (productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameCn())
	                            || productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameEn())) {
	                        productSku.setProductSkuId(skuAttr
	                                .getSupplierProductSku().getProductSkuId());
	                        productSku.setSkuId(skuAttr.getSupplierProductSku()
	                                .getSkuId());
	                        logger.info("skuID==="+skuAttr.getSupplierProductSku().getSkuId());
	                        skuVO.setSupplierProductPriceMap(skuAttr
	                                .getSupplierProductPriceMap());
	                    }
	                }
	
	                SupplierProductPrice price = null;
	
	                if (skuVO.getSupplierProductPriceMap() != null) {
	
	                    price = skuVO.getSupplierProductPriceMap();
	                    price.setSupplierprice(Common.getMax2(pic));
	
	                } else {
	
	                    price = new SupplierProductPrice();
	                    price.setSupplierprice(Common.getMax2(pic));
	
	                }
	
	                skuVO.setSupplierProductPriceMap(price);
	                productSkuVOs.add(skuVO);
	            }
	
	            for (int i = 0; i < pic.length; i++) {
	                SupplierProductWholesaleRange range = new SupplierProductWholesaleRange();
	                range.setStartQty(start[i]);
	                Long endQty = 0L;
	                if (i + 1 < pic.length) {
	                    endQty = start[i + 1] - 1;
	                }
	
	                if (i == pic.length - 1) {
	                    endQty = 0L;
	                }
	                range.setEndQty(endQty);
	                range.setDiscountType("0");
	                range.setDiscount(pic[i]);
	                wholesaleRanges.add(range);
	            }
	
	        }
        }
        
        
        //TODO 国内经销商不设置价格信息
        if(Constants.DOMESTIC_DEALER.equals(getSupplierType())){
        	
        	objectVO.getSupplierProduct().setProdType(Constants.PRODUCT_TYPE);
        	objectVO.getSupplierProductDetail().setPriceType(Constants.PRODUCT_PRICE_TYPE_DEALER);
        	objectVO.getSupplierProductDetail().setOrderType(Constants.PRODUCT_STATUS_SUCCESS);
        	
        	
        	for (int i = 0; i < buyVal.length; i++) {

                SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
                SupplierProductSku productSku = new SupplierProductSku();
                
                String skuCodeNum = "";
                String barCodeImage = "";
                if(null!=auto&&1==auto){
                	skuCodeNum = JBarCodeUtil.getCreateRandom();
                	barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
                	LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
                } else {
                	skuCodeNum = skuCode[i];
                	barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
                }
                
                
                
                productSku.setSkuCode(skuCodeNum);
                productSku.setBarCodeImage(barCodeImage); 
                
                productSku.setCreateDate(new Date());
                productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
                productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
                productSku.setSkuNameCn(buyName[i] + saleName[i]);
                productSku.setSkuNameEn(buyName[i] + saleName[i]);
                //商品货号
				if(productCode[i]!=null){	
					productSku.setProductCode(productCode[i]);
				}
                skuVO.setSupplierProductSku(productSku);

                List<SupplierProductSkuAttrval> supplierProductSkuAttrvals =
                        new ArrayList<SupplierProductSkuAttrval>();

                SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
                buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
                buyAttrval.setAttrValId(buyVal[i]);
                buyAttrval.setSupplierid(getCurrentSupplierId());
                buyAttrval.setAttrvalNameCn(buyName[i]);
                supplierProductSkuAttrvals.add(buyAttrval);

                if (saleVal != null && saleVal.length > 0) {
                    SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
                    saleAttrval.setAttrId(saleIndex);
                    saleAttrval.setAttrValId(saleVal[i]);
                    saleAttrval.setSubsupplierid("");
                    saleAttrval.setAttrvalNameCn(saleName[i]);
                    supplierProductSkuAttrvals.add(saleAttrval);
                }

                skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
                SupplierProductPrice price = new SupplierProductPrice();
                skuVO.setSupplierProductPriceMap(price);
                productSkuVOs.add(skuVO);
                
                
                // 设置skuid及价格
                for (SupplierProductSkuDTO skuAttr : supplierProductSkuVOs) {
                    if (productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameCn())
                            || productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameEn())) {
                        productSku.setProductSkuId(skuAttr
                                .getSupplierProductSku().getProductSkuId());
                        productSku.setSkuId(skuAttr.getSupplierProductSku()
                                .getSkuId());
                        logger.info("skuId==="+skuAttr.getSupplierProductSku().getSkuId());
                        skuVO.setSupplierProductPriceMap(skuAttr
                                .getSupplierProductPriceMap());
                    }
                }
            }
        	
        }
        
        

        for (int x = 0; x < objectVO.getSupplierProductAttrDTOs().size(); x++) {
            if (objectVO.getSupplierProductAttrDTOs().get(x)
                    .getSupplierProductAttr().getBuyAttr() == 1) {
                objectVO.getSupplierProductAttrDTOs().get(x).setMap(map);
            }
        }

        objectVO.setSupplierProductSkuDTOs(productSkuVOs);
        objectVO.setSupplierProductSaleSetting(productSaleSetting);
        objectVO.setSupplierProductWholesaleRanges(wholesaleRanges);

        /**
         * 商品核心信息
         */
        objectVO.getSupplierProduct().setAuditReason(Constants.PRODUCT_STATUS_SUCCESS);
        objectVO.getSupplierProduct().setSuppliername(getSupplier().getName());
        if (subBrandId != null && !"".equals(subBrandId)) {
            objectVO.getSupplierProduct().setBrandId(subBrandId);
        } else {
            objectVO.getSupplierProduct().setBrandId(brandId);
        }

        objectVO.getSupplierProduct().setSupplierid(getCurrentSupplierId());
        objectVO.getSupplierProduct().setSourcetype("1");
        objectVO.getSupplierProduct().setNamemd5(MD5.encrypt(pname));

        // 设置主图
        String[] strArr = buyAttrValUrl.get(0).split("_");
        StringBuffer buffer = new StringBuffer();

        for (int i = 1; i < strArr.length; i++) {
            if (i > 1) {
                buffer.append("_");
            }
            buffer.append(strArr[i]);
        }
        String imageUrl = buffer.toString();
        imageUrl = imageUrl.substring(imageUrl.indexOf("group"));
        objectVO.getSupplierProduct().setImageurl(imageUrl);

        SupplierProductDetail productDetail = objectVO.getSupplierProductDetail();
        
        if(!Constants.DOMESTIC_DEALER.equals(getSupplierType())&&null!=priceType){
	        if(null!=priceType){
	        	if(0==priceType){
	        		productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_FOB);
	        		productDetail.setPortName(fobPort);
	        	} else if(1==priceType) {
	        		productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_CIF);
	        		productDetail.setPortName(cifPort);
	        	} else if(2==priceType){
	        		productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_EXW);
	        	}
	        }
        }
        
        /**
         * 图文详情
         */
        SupplierProductAttach attach = attachs.get(0);
        
        String fileUrl = "";
        if (null != editorValue) {
          if(editorValue.indexOf("detail_inner.css")==-1){
        	String startStr="<link rel=\"stylesheet\" href=\"http://static.3qianwan.com/commons/css/detail_inner.css\" type=\"text/css\"><div class='detail_inner' >";
        	String endStr="</div>";
        	editorValue=startStr+editorValue+endStr;
          }
          byte[] picByte = editorValue.getBytes();
          try {
              ByteArrayInputStream stream = new ByteArrayInputStream(picByte);
              fileUrl = UploadFileUtil.uploadFile(stream, null, null);
	      } catch (Exception e) {
	          LOGGER.error("设置图文详情失败！！！supplierId:"+getCurrentSupplierId()+e.getMessage(),e);
          }
        }

        attach.setFileurl(fileUrl);
        attach.setType(Constants.PRODUCT_DESCRIPTIONS);
        attach.setOperatetime(new Date());
        objectVO.setSupplierProductAttachs(attachs);

        SupplierProductObjectDTO productObjectVO = CopyBeanUtil.copy(objectVO,buyMap);

        // 标识是中文还是英文
        if ("/en".equals(getLanguage()) || "/en" == getLanguage()) {
            productObjectVO.getSupplierProduct().setMnemonicCode("2");
        } else {
            productObjectVO.getSupplierProduct().setMnemonicCode("1");
        }

        productObjectVO.setSupplierid(getCurrentSupplierId());
        productObjectVO.setSubsupplierid("");
        productObjectVO.setProductId(objectVO.getProductId());

        productObjectVO.getSupplierProduct().setOperator(getCurrentUserId()+"");
        
        String servicePhone = "";
        if (!Common.isEmpty(fristPhone)) {
            servicePhone = "39-" + fristPhone + "-" + subPhone;
            productObjectVO.getSupplierProductDetail().setSalesCalls(servicePhone);
        }
        try {
        	LOGGER.info("修改商品supplierId:"+getCurrentSupplierId()+";productId:"+objectVO.getProductId());
            RemoteServiceSingleton.getInstance().getSupplierProductService()
                    .updateProductObject(productObjectVO);
            issavestatuinfo = "1";
            LOGGER.info("修改商品信息成功！！！");
        } catch (SupplierProException e) {
            LOGGER.error("修改商品失败！！！supplierId:"+getCurrentSupplierId()+";productId:"+objectVO.getProductId()+e.getMessage(),e);
            issavestatuinfo = "0";
        }

        return issavestatuinfo;
    }




    /**
     * 修改商品.
     *
     * @param objectVO
     *            商品对象
     * @param cost
     *            1 梯度价 2按sku报价
     * @param start
     *            按梯度价其实数量
     * @param pic
     *            梯度价价格
     * @param buyIndex
     *            展示属性下标
     * @param saleIndex
     *            规格属性下标
     * @param productPic
     *            商品价格
     * @param saleVal
     *            规格属性值
     * @param buyVal
     *            展示属性值
     * @param pname
     *            商品名称
     * @param brandId
     *            主品牌id
     * @param subBrandId
     *            子品牌id
     * @param imgUrl
     *            图片url数组
     * @param buyName
     *            展示属性值name
     * @param saleName
     *            规格属性值name
     * @param editorValue
     *            图文详情
     * @return
     */
    @RequestMapping("/product/editPOPProduct")
    @ResponseBody
    public String editPOPProduct(HttpServletRequest request,
    		String[] attrRows,String[] saleAttrRows,String[] attrOrd,String[] attrName,
			SupplierProductObjectDTO objectVO, Integer cost,
			Long buyIndex, Long[] saleIndex,Long[] saleVal, Long[] saleVal2, Long[] saleVal3, Long[] saleVal4, Long[] buyVal,
			String[] imgUrl,String[] buyName,String[] saleName,String[] saleName2,String[] saleName3,String[] saleName4,
			Long[] start, String fristPhone, String subPhone, BigDecimal[] pic,BigDecimal[] productPic,Long minNum, String pname,
            String brandId, String subBrandId, String[] skuCode,String[] barCodeImg,
            String[]unitPrice,String[]domesticPrice,String[]bestoayPrice,String[]productCode,String[]priceId,Integer auto,Integer priceType,String fobPort,String cifPort,
            String[] hqj,String[] fhed,String editorValue,String[] skuId) {

    	/**
    	 * 设置属性和属性值
    	 */
    	List<SupplierProductAttrDTO> attrDTOs = new ArrayList<SupplierProductAttrDTO>();
    
    	//普通属性
    	
    	if (null!=attrRows){
	    	for(int i=0;i<attrRows.length;i++){
	    		SupplierProductAttrDTO attrDto = new SupplierProductAttrDTO();
	    		SupplierProductAttr attr = new SupplierProductAttr();
	    		List<SupplierProductAttrval> listAttrval = new ArrayList<SupplierProductAttrval>();
	    		String type = request.getParameter("type"+attrRows[i]);
	    		attr.setType(Short.valueOf(type));
	    		attr.setAttrNameCn(attrName[i]);
	    		attr.setAttrName(attrName[i]);
	    		attr.setBuyAttr(Short.valueOf("0"));
	    		attr.setSaleAttr(Short.valueOf("0"));
	    		attr.setIsneed(Short.valueOf("-1"));
	    		boolean b = isInteger(attrOrd[i]);
	    		if(b){
	        		attr.setSortval(Integer.parseInt(attrOrd[i]));
	    		}
	    		String[] attrvals = request.getParameterValues("attrval"+attrRows[i]);
	    		if(attrvals!=null&&attrvals.length>0){
	    			for (String val : attrvals) {
	    				SupplierProductAttrval attrval = new SupplierProductAttrval();
	            		attrval.setAttrNameCn(attrName[i]);
	        			attrval.setAttrName(attrName[i]);
	        			attrval.setLineAttrvalName(val);
	        			attrval.setLineAttrvalNameCn(val);
	        			attrval.setIstate(Short.valueOf("1"));
	        			listAttrval.add(attrval);
	    			}
	    		}
	    		
	    		attrDto.setSupplierProductAttr(attr);
	    		attrDto.setSupplierProductAttrvals(listAttrval);
	    		attrDTOs.add(attrDto);
	    	}   
    	}
        String issavestatuinfo = "1";

        List<SupplierProductAttach> attachs = objectVO.getSupplierProductAttachs();

        /**
         * 设置商品资质
         */
        List<String> buyAttrValUrl = new ArrayList<String>();

        for (int x = 0; x < imgUrl.length; x++) {

            String[] prodImg = imgUrl[x].split("_");
            StringBuffer sb = new StringBuffer();
            for (int i = 1; i < prodImg.length; i++) {
                if (i > 1) {
                    sb.append("_");
                }
                sb.append(prodImg[i]);
            }



            if("00".equals(prodImg[0])){

                SupplierProductAttach prodQualification = new SupplierProductAttach();
                String qualification = sb.toString();
                qualification = qualification.substring(qualification.indexOf("group"));
                prodQualification.setFileurl(qualification);
                prodQualification.setType(Constants.PRODUCT_QUALIFICATION);
                attachs.add(prodQualification);

            } else {
                buyAttrValUrl.add(imgUrl[x]);
            }

        }

        /**
         * 设置展示属性的图片url
         */
        List<Integer> buyMap = new ArrayList<Integer>();
        Map<Integer, List<SupplierProductBuyAttrval>> map =
                new LinkedHashMap<Integer, List<SupplierProductBuyAttrval>>();

        if (buyAttrValUrl.size() > 0) {

            for (int x = 0; x < buyAttrValUrl.size(); x++) {
                String[] split = buyAttrValUrl.get(x).split("_");
                Integer index = Integer.parseInt(split[0]);
                buyMap.add(index);
                List<SupplierProductBuyAttrval> list = map.get(index);

                if (list != null && list.size() > 0) {
                    SupplierProductBuyAttrval buyAttrval = new SupplierProductBuyAttrval();
                    StringBuffer sb = new StringBuffer();

                    for (int i = 1; i < split.length; i++) {
                        if (i > 1) {
                            sb.append("_");
                        }
                        sb.append(split[i]);
                    }
                    String imgurl = sb.toString();
                    imgurl = imgurl.substring(imgurl.indexOf("group"));
                    buyAttrval.setIstate((short) 1);
                    buyAttrval.setImgurl(imgurl);
                    list.add(buyAttrval);

                } else {
                    list = new ArrayList<SupplierProductBuyAttrval>();
                    SupplierProductBuyAttrval buyAttrval = new SupplierProductBuyAttrval();
                    StringBuffer sb = new StringBuffer();

                    for (int i = 1; i < split.length; i++) {

                        if (i > 1) {
                            sb.append("_");
                        }
                        sb.append(split[i]);
                    }
                    String imgurl = sb.toString();
                    imgurl = imgurl.substring(imgurl.indexOf("group"));
                    buyAttrval.setIstate((short) 1);
                    buyAttrval.setImgurl(imgurl);
                    list.add(buyAttrval);
                    map.put(index, list);
                }
            }
        }

        /**
         * 商品基本信息
         */
        objectVO.getSupplierProductBase().setProductname(pname);
        objectVO.getSupplierProductBaseEn().setProductname(pname);

        /**
         * sku信息
         */
        List<SupplierProductSkuDTO> supplierProductSkuVOs = objectVO.getSupplierProductSkuDTOs();

        List<SupplierProductSkuDTO> productSkuVOs = new ArrayList<SupplierProductSkuDTO>();
        SupplierProductSaleSetting productSaleSetting = objectVO.getSupplierProductSaleSetting();
        List<SupplierProductWholesaleRange> wholesaleRanges = new ArrayList<SupplierProductWholesaleRange>();

        if(!Constants.DOMESTIC_DEALER.equals(getSupplierType())){
            if (null!=cost&&cost == 2) {

                productSaleSetting.setMaxSellerPrice(Common.getMax2(productPic));
                productSaleSetting.setMinSellerPrice(Common.getMin2(productPic));
                productSaleSetting.setMinWholesaleQty(minNum);

                for (int i = 0; i < buyVal.length; i++) {

                    SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
                    SupplierProductSku productSku = new SupplierProductSku();

                    //TODO
                    String skuCodeNum = "";
                    String barCodeImage = "";
                    if(null!=auto&&1==auto){
                        skuCodeNum = JBarCodeUtil.getCreateRandom();
                        barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
                        LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
                    } else {
                        skuCodeNum = skuCode[i];
                        barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
                    }
                    productSku.setSkuId(Long.parseLong(skuId[i]));
                    productSku.setSkuCode(skuCodeNum);
                    productSku.setBarCodeImage(barCodeImage);

                    productSku.setCreateDate(new Date());
                    productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
                    String saleNm2 = "";
					String saleNm3 = "";
					String saleNm4 = "";
					if(saleName2 != null&&saleName2.length>0){
						saleNm2=saleName2[i];
					}
					if(saleName3 != null&&saleName3.length>0){
						saleNm3=saleName3[i];
					}
					if(saleName4 != null&&saleName4.length>0){
						saleNm4=saleName4[i];
					}
					productSku.setSkuNameCn(buyName[i]+saleName[i]+saleNm2+saleNm3+saleNm4);
					productSku.setSkuNameEn(buyName[i]+saleName[i]+saleNm2+saleNm3+saleNm4);
					//商品货号
					if(productCode[i]!=null){	
						productSku.setProductCode(productCode[i]);
					}
                    skuVO.setSupplierProductSku(productSku);

                    List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();
                    SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
                    buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
                    buyAttrval.setAttrValId(buyVal[i]);
                    buyAttrval.setSupplierid(getCurrentSupplierId());
                    buyAttrval.setAttrvalNameCn(buyName[i]);
                    buyAttrval.setAttrvalNameEn(buyName[i]);
                    supplierProductSkuAttrvals.add(buyAttrval);

                    for(int j = 0; j < saleIndex.length; j++){
						if (saleVal!=null&&saleVal.length > 0) {
							SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
							saleAttrval.setAttrId(Long.parseLong("" + saleIndex[j]));

							if(j==0){
								saleAttrval.setAttrValId(saleVal[i]);
								saleAttrval.setAttrvalNameCn(saleName[i]);
							}
							if(j==1){
								saleAttrval.setAttrValId(saleVal2[i]);
								saleAttrval.setAttrvalNameCn(saleName2[i]);
							}
							if(j==2){
								saleAttrval.setAttrValId(saleVal3[i]);
								saleAttrval.setAttrvalNameCn(saleName3[i]);
							}
							if(j==3){
								saleAttrval.setAttrValId(saleVal4[i]);
								saleAttrval.setAttrvalNameCn(saleName4[i]);
							}
							supplierProductSkuAttrvals.add(saleAttrval);
						}
					}

                    // 设置skuid及价格
                    for (SupplierProductSkuDTO skuAttr : supplierProductSkuVOs) {

                       /* if (productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameCn())
                                || productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameEn())) {*/
                    	 if (productSku.getSkuId().equals(skuAttr.getSupplierProductSku().getSkuId())) {
                            productSku.setProductSkuId(skuAttr
                                    .getSupplierProductSku().getProductSkuId());
                            productSku.setSkuId(skuAttr.getSupplierProductSku()
                                    .getSkuId());
                            logger.info("skuId==="+skuAttr.getSupplierProductSku().getSkuId());
                            skuVO.setSupplierProductPriceMap(skuAttr.getSupplierProductPriceMap());
                            List<SupplierProductSkuAttrval> list = skuVO.getSupplierProductSkuAttrvals();
                            for (int q = 0; q < list.size(); q++) {
                            	list.get(q).setTdProSkuAttrvalId(skuAttr.getSupplierProductSkuAttrvals().get(q).getTdProSkuAttrvalId());
    						}
                        }

                    }

                    skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
                    SupplierProductPrice price = null;

                    if (skuVO.getSupplierProductPriceMap() != null) {

                        price = skuVO.getSupplierProductPriceMap();
                        price.setSupplierprice(productPic[i]);

                    } else {

                        price = new SupplierProductPrice();
                        price.setSupplierprice(productPic[i]);
                    }

                    skuVO.setSupplierProductPriceMap(price);

                    productSkuVOs.add(skuVO);
                }
            }

            if (null!=cost&&cost == 1) {

                productSaleSetting.setMaxSellerPrice(Common.getMax2(pic));
                productSaleSetting.setMinSellerPrice(Common.getMin2(pic));
                productSaleSetting.setMinWholesaleQty(start[0]);

                for (int i = 0; i < buyVal.length; i++) {

                    SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
                    SupplierProductSku productSku = new SupplierProductSku();

                    //TODO
                    String skuCodeNum = "";
                    String barCodeImage = "";
                    if(null!=auto&&1==auto){
                        skuCodeNum = JBarCodeUtil.getCreateRandom();
                        barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
                        LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
                    } else {
                        skuCodeNum = skuCode[i];
                        barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
                    }

                    productSku.setSkuId(Long.parseLong(skuId[i]));
                    productSku.setSkuCode(skuCodeNum);
                    productSku.setBarCodeImage(barCodeImage);

                    productSku.setCreateDate(new Date());
                    productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
                    productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
                    String saleNm2 = "";
					String saleNm3 = "";
					String saleNm4 = "";
					if(saleName2 != null&&saleName2.length>0){
						saleNm2=saleName2[i];
					}
					if(saleName3 != null&&saleName3.length>0){
						saleNm3=saleName3[i];
					}
					if(saleName4 != null&&saleName4.length>0){
						saleNm4=saleName4[i];
					}
					productSku.setSkuNameCn(buyName[i]+saleName[i]+saleNm2+saleNm3+saleNm4);
					productSku.setSkuNameEn(buyName[i]+saleName[i]+saleNm2+saleNm3+saleNm4);
					
                    //商品货号
					if(productCode[i]!=null){	
						productSku.setProductCode(productCode[i]);
					}
                    skuVO.setSupplierProductSku(productSku);

                    List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = new ArrayList<SupplierProductSkuAttrval>();
                    SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
                    buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
                    buyAttrval.setAttrValId(buyVal[i]);
                    buyAttrval.setSupplierid(getCurrentSupplierId());
                    buyAttrval.setAttrvalNameCn(buyName[i]);
                    buyAttrval.setAttrvalNameEn(buyName[i]);
                    supplierProductSkuAttrvals.add(buyAttrval);

                    for(int j = 0; j < saleIndex.length; j++){
						if (saleVal!=null&&saleVal.length > 0) {
							SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
							saleAttrval.setAttrId(Long.parseLong("" + saleIndex[j]));

							if(j==0){
								saleAttrval.setAttrValId(saleVal[i]);
								saleAttrval.setAttrvalNameCn(saleName[i]);
							}
							if(j==1){
								saleAttrval.setAttrValId(saleVal2[i]);
								saleAttrval.setAttrvalNameCn(saleName2[i]);
							}
							if(j==2){
								saleAttrval.setAttrValId(saleVal3[i]);
								saleAttrval.setAttrvalNameCn(saleName3[i]);
							}
							if(j==3){
								saleAttrval.setAttrValId(saleVal4[i]);
								saleAttrval.setAttrvalNameCn(saleName4[i]);
							}
							supplierProductSkuAttrvals.add(saleAttrval);
						}
					}

                    skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);

                    // 设置skuid及价格
                    for (SupplierProductSkuDTO skuAttr : supplierProductSkuVOs) {
                        /*if (productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameCn())
                                || productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameEn())) {*/
                    	 if (productSku.getSkuId().equals(skuAttr.getSupplierProductSku().getSkuId())) {
                            productSku.setProductSkuId(skuAttr
                                    .getSupplierProductSku().getProductSkuId());
                            productSku.setSkuId(skuAttr.getSupplierProductSku()
                                    .getSkuId());
                            logger.info("skuID==="+skuAttr.getSupplierProductSku().getSkuId());
                            skuVO.setSupplierProductPriceMap(skuAttr
                                    .getSupplierProductPriceMap());
                            List<SupplierProductSkuAttrval> list = skuVO.getSupplierProductSkuAttrvals();
                            for (int q = 0; q < list.size(); q++) {
                            	list.get(q).setTdProSkuAttrvalId(skuAttr.getSupplierProductSkuAttrvals().get(q).getTdProSkuAttrvalId());
    						}
                        }
                    }

                    SupplierProductPrice price = null;

                    if (skuVO.getSupplierProductPriceMap() != null) {

                        price = skuVO.getSupplierProductPriceMap();
                        price.setSupplierprice(Common.getMax2(pic));

                    } else {

                        price = new SupplierProductPrice();
                        price.setSupplierprice(Common.getMax2(pic));

                    }

                    skuVO.setSupplierProductPriceMap(price);
                    productSkuVOs.add(skuVO);
                }

                for (int i = 0; i < pic.length; i++) {
                    SupplierProductWholesaleRange range = new SupplierProductWholesaleRange();
                    range.setStartQty(start[i]);
                    Long endQty = 0L;
                    if (i + 1 < pic.length) {
                        endQty = start[i + 1] - 1;
                    }

                    if (i == pic.length - 1) {
                        endQty = 0L;
                    }
                    range.setEndQty(endQty);
                    range.setDiscountType("0");
                    range.setDiscount(pic[i]);
                    wholesaleRanges.add(range);
                }

            }
        }


        //TODO 国内经销商不设置价格信息
        if(Constants.DOMESTIC_DEALER.equals(getSupplierType())){

            objectVO.getSupplierProduct().setProdType(Constants.PRODUCT_TYPE);
            objectVO.getSupplierProductDetail().setPriceType(Constants.PRODUCT_PRICE_TYPE_DEALER);
            objectVO.getSupplierProductDetail().setOrderType(Constants.PRODUCT_STATUS_SUCCESS);


            for (int i = 0; i < buyVal.length; i++) {

                SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
                SupplierProductSku productSku = new SupplierProductSku();

                String skuCodeNum = "";
                String barCodeImage = "";
                if(null!=auto&&1==auto){
                    skuCodeNum = JBarCodeUtil.getCreateRandom();
                    barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
                    LOGGER.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
                } else {
                    skuCodeNum = skuCode[i];
                    barCodeImage = barCodeImg[i].substring(barCodeImg[i].indexOf("group"));
                }


                productSku.setSkuId(Long.parseLong(skuId[i]));
                productSku.setSkuCode(skuCodeNum);
                productSku.setBarCodeImage(barCodeImage);

                productSku.setCreateDate(new Date());
                productSku.setSaleStatus(Constants.PRODUCT_STATUS_SUCCESS);
                productSku.setIstate(Constants.PRODUCT_STATUS_SUCCESS);
                String saleNm2 = "";
				String saleNm3 = "";
				String saleNm4 = "";
				if(saleName2 != null&&saleName2.length>0){
					saleNm2=saleName2[i];
				}
				if(saleName3 != null&&saleName3.length>0){
					saleNm3=saleName3[i];
				}
				if(saleName4 != null&&saleName4.length>0){
					saleNm4=saleName4[i];
				}
				productSku.setSkuNameCn(buyName[i]+saleName[i]+saleNm2+saleNm3+saleNm4);
				productSku.setSkuNameEn(buyName[i]+saleName[i]+saleNm2+saleNm3+saleNm4);
				//商品货号
				if(productCode[i]!=null){	
					productSku.setProductCode(productCode[i]);
				}
                skuVO.setSupplierProductSku(productSku);

                List<SupplierProductSkuAttrval> supplierProductSkuAttrvals =
                        new ArrayList<SupplierProductSkuAttrval>();

                SupplierProductSkuAttrval buyAttrval = new SupplierProductSkuAttrval();
                buyAttrval.setAttrId(Long.parseLong("" + buyIndex));
                buyAttrval.setAttrValId(buyVal[i]);
                buyAttrval.setSupplierid(getCurrentSupplierId());
                buyAttrval.setAttrvalNameCn(buyName[i]);
                supplierProductSkuAttrvals.add(buyAttrval);

                for(int j = 0; j < saleIndex.length; j++){
					if (saleVal!=null&&saleVal.length > 0) {
						SupplierProductSkuAttrval saleAttrval = new SupplierProductSkuAttrval();
						saleAttrval.setAttrId(Long.parseLong("" + saleIndex[j]));

						if(j==0){
							saleAttrval.setAttrValId(saleVal[i]);
							saleAttrval.setAttrvalNameCn(saleName[i]);
						}
						if(j==1){
							saleAttrval.setAttrValId(saleVal2[i]);
							saleAttrval.setAttrvalNameCn(saleName2[i]);
						}
						if(j==2){
							saleAttrval.setAttrValId(saleVal3[i]);
							saleAttrval.setAttrvalNameCn(saleName3[i]);
						}
						if(j==3){
							saleAttrval.setAttrValId(saleVal4[i]);
							saleAttrval.setAttrvalNameCn(saleName4[i]);
						}
						supplierProductSkuAttrvals.add(saleAttrval);
					}
				}

                skuVO.setSupplierProductSkuAttrvals(supplierProductSkuAttrvals);
                SupplierProductPrice price = new SupplierProductPrice();
                skuVO.setSupplierProductPriceMap(price);
                productSkuVOs.add(skuVO);


                // 设置skuid及价格
                for (SupplierProductSkuDTO skuAttr : supplierProductSkuVOs) {
                    /*if (productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameCn())
                            || productSku.getSkuNameCn().equals(skuAttr.getSupplierProductSku().getSkuNameEn())) {*/
                	 if (productSku.getSkuId().equals(skuAttr.getSupplierProductSku().getSkuId())) {
                        productSku.setProductSkuId(skuAttr
                                .getSupplierProductSku().getProductSkuId());
                        productSku.setSkuId(skuAttr.getSupplierProductSku()
                                .getSkuId());
                        logger.info("skuId==="+skuAttr.getSupplierProductSku().getSkuId());
                        skuVO.setSupplierProductPriceMap(skuAttr
                                .getSupplierProductPriceMap());
                        List<SupplierProductSkuAttrval> list = skuVO.getSupplierProductSkuAttrvals();
                        for (int q = 0; q < list.size(); q++) {
                        	list.get(q).setTdProSkuAttrvalId(skuAttr.getSupplierProductSkuAttrvals().get(q).getTdProSkuAttrvalId());
						}
                    }
                }
            }

        }

        for (int x = 0; x < objectVO.getSupplierProductAttrDTOs().size(); x++) {
            if (objectVO.getSupplierProductAttrDTOs().get(x)
                    .getSupplierProductAttr().getBuyAttr() == 1) {
                objectVO.getSupplierProductAttrDTOs().get(x).setMap(map);
            }
        }
        for (int x = objectVO.getSupplierProductAttrDTOs().size(); x > 0; x--) {
			if (objectVO.getSupplierProductAttrDTOs().get(x-1).getSupplierProductAttr()==null) {
				objectVO.getSupplierProductAttrDTOs().remove(x-1);
			}
		}
		Long[] attrIndex = new Long[productSkuVOs.get(0).getSupplierProductSkuAttrvals().size()];
		for(int x = 0; x < attrIndex.length; x++){
			if(x < saleIndex.length){
				attrIndex[x]=saleIndex[x];
			}else{
				attrIndex[x]=buyIndex;
			}
		}
		Arrays.sort(attrIndex);
		for (SupplierProductSkuDTO skuDto1 : productSkuVOs) {
			List<SupplierProductSkuAttrval> skuAttrvals = skuDto1.getSupplierProductSkuAttrvals();
			for (SupplierProductSkuAttrval supplierProductSkuAttrval : skuAttrvals) {
				for(int x = 0; x < attrIndex.length; x++){
					if(supplierProductSkuAttrval.getAttrId().equals(attrIndex[x])){
						supplierProductSkuAttrval.setAttrId(Long.parseLong("" + x));
					}
				}
			}
		}
		objectVO.setSupplierProductSkuDTOs(productSkuVOs);
		for (SupplierProductAttrDTO attrDto1 : attrDTOs) {
			objectVO.getSupplierProductAttrDTOs().add(attrDto1);
		}
        objectVO.setSupplierProductSkuDTOs(productSkuVOs);
        objectVO.setSupplierProductSaleSetting(productSaleSetting);
        objectVO.setSupplierProductWholesaleRanges(wholesaleRanges);

        /**
         * 商品核心信息
         */
        objectVO.getSupplierProduct().setAuditReason(Constants.PRODUCT_STATUS_SUCCESS);
        objectVO.getSupplierProduct().setSuppliername(getSupplier().getName());
        if (subBrandId != null && !"".equals(subBrandId)) {
            objectVO.getSupplierProduct().setBrandId(subBrandId);
        } else {
            objectVO.getSupplierProduct().setBrandId(brandId);
        }

        objectVO.getSupplierProduct().setSupplierid(getCurrentSupplierId());
        objectVO.getSupplierProduct().setSourcetype("1");
        objectVO.getSupplierProduct().setNamemd5(MD5.encrypt(pname));

        // 设置主图
        String[] strArr = buyAttrValUrl.get(0).split("_");
        StringBuffer buffer = new StringBuffer();

        for (int i = 1; i < strArr.length; i++) {
            if (i > 1) {
                buffer.append("_");
            }
            buffer.append(strArr[i]);
        }
        String imageUrl = buffer.toString();
        imageUrl = imageUrl.substring(imageUrl.indexOf("group"));
        objectVO.getSupplierProduct().setImageurl(imageUrl);

        SupplierProductDetail productDetail = objectVO.getSupplierProductDetail();

        if(!Constants.DOMESTIC_DEALER.equals(getSupplierType())&&null!=priceType){
            if(null!=priceType){
                if(0==priceType){
                    productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_FOB);
                    productDetail.setPortName(fobPort);
                } else if(1==priceType) {
                    productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_CIF);
                    productDetail.setPortName(cifPort);
                } else if(2==priceType){
                    productDetail.setPriceType(Constants.PRODUCT_PRICE_TYPE_EXW);
                }
            }
        }

        /**
         * 图文详情
         */
        SupplierProductAttach attach = attachs.get(0);

        String fileUrl = "";
        if (null != editorValue) {
        	if(editorValue.indexOf("detail_inner.css")==-1){
            	String startStr="<link rel=\"stylesheet\" href=\"http://static.3qianwan.com/commons/css/detail_inner.css\" type=\"text/css\"><div class='detail_inner' >";
            	String endStr="</div>";
            	editorValue=startStr+editorValue+endStr;
            }
            byte[] picByte = editorValue.getBytes();
            try {
                ByteArrayInputStream stream = new ByteArrayInputStream(picByte);
                fileUrl = UploadFileUtil.uploadFile(stream, null, null);
            } catch (Exception e) {
                LOGGER.error("设置图文详情失败！！！supplierId:"+getCurrentSupplierId()+e.getMessage(),e);
            }
        }

        attach.setFileurl(fileUrl);
        attach.setType(Constants.PRODUCT_DESCRIPTIONS);
        attach.setOperatetime(new Date());
        objectVO.setSupplierProductAttachs(attachs);

        // 去除属性值为空的属性
        objectVO.getB2cProductDetail().setB2cProductName(pname);//B2C商品名称
        objectVO.getB2cProductDetail().setB2cDescription(fileUrl);//图文详情
        SupplierProductObjectDTO productObjectVO = CopyBeanUtil.copy(objectVO,buyMap);

        // 标识是中文还是英文
        if ("/en".equals(getLanguage()) || "/en" == getLanguage()) {
            productObjectVO.getSupplierProduct().setMnemonicCode("2");
        } else {
            productObjectVO.getSupplierProduct().setMnemonicCode("1");
        }

        productObjectVO.setSupplierid(getCurrentSupplierId());
        productObjectVO.setSubsupplierid("");
        productObjectVO.setProductId(objectVO.getProductId());

        productObjectVO.getSupplierProduct().setOperator(getCurrentUserId()+"");


        // 设置b2c的商品价格
        List<SupplierProductSkuDTO> skuProductList = productObjectVO.getSupplierProductSkuDTOs();
        if(CollectionUtils.isNotEmpty(skuProductList) && (unitPrice.length > 0) && (domesticPrice.length > 0) && (bestoayPrice.length > 0)){
            for(int i=0;i<skuProductList.size();i++){
                skuProductList.get(i).getSupplierProductPriceMap().setUnitPrice(new BigDecimal(unitPrice[i]));
                skuProductList.get(i).getSupplierProductPriceMap().setDomesticPrice(new BigDecimal(domesticPrice[i]));
                skuProductList.get(i).getSupplierProductPriceMap().setBestoayPrice(new BigDecimal(bestoayPrice[i]));
               
                if(hqj!=null && hqj[i]!=""){
                	 skuProductList.get(i).getSupplierProductPriceMap().setCashHqj(new BigDecimal(hqj[i]));
                }
               
                
				skuProductList.get(i).getSupplierProductPriceMap().setFhed(new BigDecimal(fhed[i]));
                //修改的规格没有priceid
                if(!"".equals(priceId[i])){
                	skuProductList.get(i).getSupplierProductPriceMap().setPriceId(new Long(priceId[i]));
                }else{
                	skuProductList.get(i).getSupplierProductPriceMap().setPriceId(new Long(0));
                }
            }
        }


        String servicePhone = "";
        if (!Common.isEmpty(fristPhone)) {
            servicePhone = "39-" + fristPhone + "-" + subPhone;
            productObjectVO.getSupplierProductDetail().setSalesCalls(servicePhone);
        }
        try {
            LOGGER.info("修改商品supplierId:"+getCurrentSupplierId()+";productId:"+objectVO.getProductId());
            RemoteServiceSingleton.getInstance().getSupplierProductService().updatePOPProductObject(productObjectVO);
            issavestatuinfo = "1";
            LOGGER.info("修改商品信息成功！！！");
        } catch (SupplierProException e) {
            LOGGER.error("修改商品失败！！！supplierId:"+getCurrentSupplierId()+";productId:"+objectVO.getProductId()+e.getMessage(),e);
            issavestatuinfo = "0";
        }

        return issavestatuinfo;
    }



    /**
     * pop商品查看.
     * DealerProduct
     * @param model
     *            model
     * @param productId
     *            productid
     * @return String
     */
    @RequestMapping("/initPOPShowDealerProduct")
    public String initPOPShowDealerProduct(Model model, Long productId, @RequestParam(required = false) String page, @RequestParam(required = false)  String dpro) {
    	
    	//TODO
        DealerProductObjectDTO proObjVo = new DealerProductObjectDTO();

//        Map<TdCatePubAttr, List<TdCatePubAttrval>> categoryAttrAndValList = new LinkedHashMap<TdCatePubAttr, List<TdCatePubAttrval>>();

        List<TdCatePub> cateNames = new ArrayList<TdCatePub>();

        try {
            proObjVo = RemoteServiceSingleton.getInstance().getDealerProductService().findProductObjectById(productId, "");
            if((proObjVo.getDealerProductSkuDTOs().get(0).getDealerProductPriceMap().getCashHqj())!=null)
            {
            	model.addAttribute("cash", proObjVo.getDealerProductSkuDTOs().get(0).getDealerProductPriceMap().getCashHqj());
            }
            String categoryId = proObjVo.getDealerProduct().getCatePubId();

//            categoryAttrAndValList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc()
//                    .getCategoryAttrAndValList(categoryId);

            cateNames = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCategoryNameByDigui(categoryId);

        } catch (Exception e) {
            LOGGER.error("获取商品信息失败：" + e.getMessage(),e);
        }

        ProductService serviceController = new ProductService();

        // //属性和属性值回显
//		List<DealerProductAttrDTO> productAttrVOs = proObjVo.getDealerProductAttrDTOs();
        List<DealerProductAttrDTO> pageAttrs = proObjVo.getDealerProductAttrDTOs();
        // 图片回显
        List<LinkedHashMap<String, Object>> imgUrl = imgShowDealer(pageAttrs);

        JSONArray returnImgUrlAndName = JSONArray.fromObject(imgUrl);

        // 价格或者sku回显
        List<DealerProductWholesaleRange> dealerProductWholesaleRanges = proObjVo
                .getDealerProductWholesaleRanges();
        Map<String, Object> productPic = new LinkedHashMap<String, Object>();
        List<Long> countList = new ArrayList<Long>();
        List<BigDecimal> picList = new ArrayList<BigDecimal>();

        if (dealerProductWholesaleRanges != null && dealerProductWholesaleRanges.size() > 0) {

            for (DealerProductWholesaleRange supplierProductWholesaleRange : dealerProductWholesaleRanges) {
                Long startQty = supplierProductWholesaleRange.getStartQty();
                countList.add(startQty);
                BigDecimal discountPic = supplierProductWholesaleRange.getDiscount();
                picList.add(discountPic);
            }

            productPic.put("type", 0);
            productPic.put("start", countList);
            productPic.put("pic", picList);
        } else {
            // 按照sku的价格回显
            List<Object> skusPic = serviceController.showSkuPicDealer(proObjVo);
            productPic.put("type", 1);
            productPic.put("start", 0);
            productPic.put("pic", skusPic);
        }
        JSONArray jsonProductPic = JSONArray.fromObject(productPic);

        proObjVo.setDealerProductAttrDTOs(pageAttrs);


        //将默认日期设置为null
        Date receiveDate = proObjVo.getDealerProductDetail().getReceiveDate();
        Date deliverDate = proObjVo.getDealerProductDetail().getDeliverDate();

        if(DateUtil.getDateYear(receiveDate)==1999){
            proObjVo.getDealerProductDetail().setReceiveDate(null);
        }
        if(DateUtil.getDateYear(deliverDate)==1999){
            proObjVo.getDealerProductDetail().setDeliverDate(null);
        }


        // 图文详情和资质图片
        String fileurl = "";
        List<DealerProductAttach> productAttachs = proObjVo.getDealerProductAttachs();
        String attch = "";
        List<String> qualification = new ArrayList<String>();
        for (DealerProductAttach supplierProductAttach : productAttachs) {
            /*if(Constants.PRODUCT_DESCRIPTIONS == supplierProductAttach.getType()){
                fileurl = Constants.IMAGES_VIEW2 + supplierProductAttach.getFileurl();
            }*/

            if(supplierProductAttach.getType() == Constants.PRODUCT_QUALIFICATION){
                qualification.add(Constants.M1+supplierProductAttach.getFileurl());
            }
        }

        // pop取b2c的图文详情
        fileurl = Constants.IMAGES_VIEW2 + proObjVo.getB2cProductDetail().getB2cDescription();

//		JSONArray qualificationUrl = JSONArray.fromObject(qualification);


        JSONArray skusCode = JSONArray.fromObject(serviceController.showSkuCodeDealer(proObjVo));

        
        // pop商家默认2，贸易商
        model.addAttribute("supplierType", 2);
        model.addAttribute("fileurl", fileurl);
        model.addAttribute("qualificationUrl", qualification);
        model.addAttribute("skusCode", skusCode);
        model.addAttribute("cateNames", cateNames);
        model.addAttribute("attch", attch);
        model.addAttribute("proObj", proObjVo);
        model.addAttribute("jsonImg", returnImgUrlAndName);
        model.addAttribute("skuPriceAndCount", jsonProductPic);
        model.addAttribute("page",page);
        model.addAttribute("dpro",dpro);
        Supplier supplier = getSupplier();
        model.addAttribute("type", supplier.getOrganizationType());
        
        /*Supplier supplier = getSupplier();
        if(supplier.getOrganizationType()!=null&&supplier.getOrganizationType()==5){
        	return getLanguage() + "/product/showPOPDealerProductUI2";
        }*/
        ProductTags tags = RemoteServiceSingleton
                .getInstance()
                .getProductTagsService().LimitContentOrNull(productId, "xjzfbl", 5);
        if(proObjVo.getDealerProduct().getProdType()==6 && tags==null ){
        	 return getLanguage() + "/product/showPOPDealerProductUI2";
        }
        return getLanguage() + "/product/showPOPDealerProductUI";
    }



    /**.
     * 拼装 图片Json 前台使用
     * @param pageAttrs List<DealerProductAttrDTO>
     * @author zhouzb
     * @return String List<LinkedHashMap<String,Object>>
     */
    public List<LinkedHashMap<String,Object>> imgShowDealer(List<DealerProductAttrDTO> pageAttrs) {
        List<LinkedHashMap<String,Object>> imgUrl = new ArrayList<LinkedHashMap<String,Object>>();
        LinkedHashMap<String,Object> imglist = null;
        List<String> urllist =  null;
        for(int i = 0 ; i< pageAttrs.size() ; i++){
            List<DealerProductAttrval> getSupplierProductAttrvals = pageAttrs.get(i).getDealerProductAttrvals();
            for(int j = 0 ; j < getSupplierProductAttrvals.size() ;  j++  ){
                String lineAttrvalNameCn = getSupplierProductAttrvals.get(j).getLineAttrvalNameCn();
                Map<Integer, List<DealerProductBuyAttrval>> map2 = pageAttrs.get(i).getMap();
                List<DealerProductBuyAttrval> list  = new ArrayList<DealerProductBuyAttrval>();
                if(map2!=null){
                    list = map2.get(j);
                    if(list!=null&&list.size()>0){
                        urllist =  new ArrayList<String>();
                        imglist = new LinkedHashMap<String, Object>();
                        for(DealerProductBuyAttrval supplierProductBuyAttrval:list){

                            String imgurl	= Constants.P2+supplierProductBuyAttrval.getImgurl();
                            urllist.add(imgurl);
                        }
                        imglist.put("1", lineAttrvalNameCn);
                        imglist.put("2", j+"");
                        imglist.put("3", urllist);
                        imgUrl.add(imglist);
                    }

                }
            }
        }
        return imgUrl;
    }


    /**
     * 图片回显.
     * 
     * @param pageAttrs
     *            页面显示属性属性值
     * @return 图片list
     */
    public List<LinkedHashMap<String, Object>> imgShow(
            List<SupplierProductAttrDTO> pageAttrs) {

        List<LinkedHashMap<String, Object>> imgUrl = new ArrayList<LinkedHashMap<String, Object>>();
        LinkedHashMap<String, Object> imgList = null;
        List<String> urlList = null;

        for (int i = 0; i < pageAttrs.size(); i++) {

            List<SupplierProductAttrval> getSupplierProductAttrvals = pageAttrs
                    .get(i).getSupplierProductAttrvals();
            if (null != getSupplierProductAttrvals) {
                for (int j = 0; j < getSupplierProductAttrvals.size(); j++) {
                    String lineAttrvalNameCn = "";
                    if ("/en".equals(getLanguage())) {
                        lineAttrvalNameCn = getSupplierProductAttrvals.get(j)
                                .getLineAttrvalName();
                    } else {
                        lineAttrvalNameCn = getSupplierProductAttrvals.get(j)
                                .getLineAttrvalNameCn();
                    }
                    Map<Integer, List<SupplierProductBuyAttrval>> map2 = pageAttrs
                            .get(i).getMap();
                    List<SupplierProductBuyAttrval> list = new ArrayList<SupplierProductBuyAttrval>();

                    if (map2 != null) {
                        list = map2.get(j);

                        if (list != null && list.size() > 0) {
                            urlList = new ArrayList<String>();
                            imgList = new LinkedHashMap<String, Object>();

                            for (SupplierProductBuyAttrval supplierProductBuyAttrval : list) {
                                String imgurl = Constants.IMAGES_VIEW1
                                        + supplierProductBuyAttrval.getImgurl();

                                urlList.add(imgurl);
                            }

                            imgList.put("1", lineAttrvalNameCn);
                            imgList.put("2", j + "");
                            imgList.put("3", urlList);
                            imgUrl.add(imgList);
                        }

                    }
                }
            }
        }
        return imgUrl;
    }
    public static boolean isInteger(String value) {
		try {
			Integer.parseInt(value);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}
}
