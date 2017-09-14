package com.mall.controller.product;

import java.io.ByteArrayInputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONArray;

import org.csource.upload.UploadFileUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mall.architect.logging.Log;
import com.mall.architect.logging.LogFactory;
import com.mall.category.po.MoneyUnit;
import com.mall.category.po.TcCountry;
import com.mall.category.po.TcMeasure;
import com.mall.category.po.TdCatePub;
import com.mall.category.po.TdCatePubAttr;
import com.mall.category.po.TdCatePubAttrval;
import com.mall.controller.base.BaseController;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.supplier.product.dto.SupplierProductAttrDTO;
import com.mall.supplier.product.dto.SupplierProductObjectDTO;
import com.mall.supplier.product.dto.SupplierProductSkuDTO;
import com.mall.supplier.product.exception.SupplierProException;
import com.mall.supplier.product.po.SupplierProductAttach;
import com.mall.supplier.product.po.SupplierProductAttrval;
import com.mall.supplier.product.po.SupplierProductBuyAttrval;
import com.mall.supplier.product.po.SupplierProductDetail;
import com.mall.supplier.product.po.SupplierProductPrice;
import com.mall.supplier.product.po.SupplierProductSaleSetting;
import com.mall.supplier.product.po.SupplierProductSku;
import com.mall.supplier.product.po.SupplierProductSkuAttrval;
import com.mall.supplier.product.po.SupplierProductWholesaleRange;
import com.mall.utils.Common;
import com.mall.utils.Constants;
import com.mall.utils.CopyBeanUtil;
import com.mall.utils.DateUtil;
import com.mall.utils.JBarCodeUtil;
import com.mall.utils.MD5;


/**
 * 供应商修改更新
 * 一般属性和价格信息分别修改   
 * @author xusq
 *
 */
@Controller
public class ProductEditController extends BaseController {

	private static final Log logger = LogFactory.getLogger(ProductEditController.class);
	
	@RequestMapping("/product/toEditAttribute")
	public String toEditAttribute(Long productId,Model model){
		

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
        	
            logger.error("获取商品信息失败productId"+productId+";supplierId:"+getCurrentSupplierId() + e.getMessage(),e);
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
            
            return getLanguage()+"/product/editAttribute";
        } else {
            return "/error/notFind";
        }
		
		
		
	}
	
	/**
	 * 供应商商品修改一般属性
	 * @return
	 */
	
	@RequestMapping("/product/updateAttribute")
	@ResponseBody
	public String updateAttribute(SupplierProductObjectDTO objectVO,String fristPhone, String subPhone, 
            Long buyIndex, Long saleIndex, Long minNum, Long[] saleVal, Long[] buyVal, String pname,
            String brandId, String subBrandId, String[] skuCode,String[] barCodeImg,
            String[] imgUrl, String[] buyName, String[] saleName,Integer auto,Integer priceType,String fobPort,String cifPort,
            String editorValue) {

		logger.info("修改商品属性=supplierId:"+getCurrentSupplierId()+";productId:"+objectVO.getProductId());
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

        
        	for (int i = 0; i < buyVal.length; i++) {

                SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
                SupplierProductSku productSku = new SupplierProductSku();
                
                String skuCodeNum = "";
                String barCodeImage = "";
                if(null!=auto&&1==auto){
                	skuCodeNum = JBarCodeUtil.getCreateRandom();
                	barCodeImage = JBarCodeUtil.getBarCodeUrl(skuCodeNum);
                	logger.info("系统自动生成验证码："+skuCodeNum+";BarCodeUrl："+barCodeImage);
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
        	
        //国内经销商
        if(Constants.DOMESTIC_DEALER.equals(getSupplierType())){
        	
        	objectVO.getSupplierProduct().setProdType(Constants.PRODUCT_TYPE);
        	objectVO.getSupplierProductDetail().setPriceType(Constants.PRODUCT_PRICE_TYPE_DEALER);
        	objectVO.getSupplierProductDetail().setOrderType(Constants.PRODUCT_STATUS_SUCCESS);
    	
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
        	
            byte[] picByte = editorValue.getBytes();
            try {
                ByteArrayInputStream stream = new ByteArrayInputStream(picByte);
                fileUrl = UploadFileUtil.uploadFile(stream, null, null);
            } catch (Exception e) {
            	logger.error("设置图文详情失败！！！supplierId:"+getCurrentSupplierId()+e.getMessage(),e);
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
        	logger.info("修改商品supplierId:"+getCurrentSupplierId()+";productId:"+objectVO.getProductId());
            RemoteServiceSingleton.getInstance().getSupplierProductService()
                    .updateProductObject(productObjectVO);
            issavestatuinfo = "1";
            logger.info("修改商品信息成功！！！");
        } catch (SupplierProException e) {
        	logger.error("修改商品失败！！！supplierId:"+getCurrentSupplierId()+";productId:"+objectVO.getProductId()+e.getMessage(),e);
            issavestatuinfo = "0";
        }

        return issavestatuinfo;
    }
	
	
	
	
	
	
	@RequestMapping("/product/toEditPrice")
	public String toEditPrice(Long productId,Model model){
		
		logger.info("toEditPrice!!!productId："+productId+";supplierId:"+getCurrentSupplierId());
    	
        Map<TdCatePubAttr, List<TdCatePubAttrval>> categoryAttrAndValList = new LinkedHashMap<TdCatePubAttr, List<TdCatePubAttrval>>();
        
        
        SupplierProductObjectDTO proObjVo = new SupplierProductObjectDTO();
        
        List<TdCatePub> cateNames = new ArrayList<TdCatePub>();
        
        try {
        	
        	
            
            
            proObjVo = RemoteServiceSingleton.getInstance().getSupplierProductService()
                    .findProductObjectById(productId, "");
            
            String categoryId = proObjVo.getSupplierProduct().getCatePubId();
            
            categoryAttrAndValList = RemoteServiceSingleton.getInstance().getCategoryServiceRpc()
                    .getCategoryAttrAndValList(categoryId);
            
            cateNames = RemoteServiceSingleton.getInstance().getCategoryServiceRpc().getCategoryNameByDigui(categoryId);
            
        } catch (Exception e) {
        	
            logger.error("获取商品信息失败productId"+productId+";supplierId:"+getCurrentSupplierId() + e.getMessage(),e);
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
    		
    		//计量单位
    		List<String> measure = new ArrayList<String>();
     		
    		String measureCname = proObjVo.getSupplierProductPackage().getMeasureCname();
    		String measureEname = proObjVo.getSupplierProductPackage().getMeasureEname();
    		
    		measure.add(0,measureCname);
    		measure.add(1,measureEname);
    		
    		
    		//计价单位
    		List<String> moneyUnit = new ArrayList<String>();
    		
    		String moneyUnitNameCn = proObjVo.getSupplierProductSaleSetting().getMoneyUnitNameCn();
    		String moneyUnitNameEn = proObjVo.getSupplierProductSaleSetting().getMoneyUnitNameEn();
    		
    		moneyUnit.add(0, moneyUnitNameCn);
    		moneyUnit.add(1, moneyUnitNameEn);
    		
    		
    		
    		
    		model.addAttribute("buyAttrName", buyAttrName);
    		model.addAttribute("saleAttrName", saleAttrName);
    		model.addAttribute("measure", measure);
    		model.addAttribute("moneyUnit", moneyUnit);
            model.addAttribute("cateNames", cateNames);
            model.addAttribute("language", getLanguage().substring(1));
            model.addAttribute("proObj", proObjVo);
            model.addAttribute("skuPriceAndCount", jsonProductPic);
            
            return getLanguage() + "/product/editPrice";
        } else {
            return "/error/notFind";
        }
		
	}
	
	
	/**
	 * 供应商商品修改价格信息
	 * @return
	 */
	@RequestMapping("/product/updateProdPrice")
	@ResponseBody
	public String updatePrice(SupplierProductObjectDTO objectVO, Integer cost,
            Long[] start,BigDecimal[] pic,Long buyIndex, Long saleIndex, BigDecimal[] productPic,
            Long minNum, Long[] saleVal, Long[] buyVal,String[] buyName, String[] saleName) {

		logger.info("enter_editProductPrice_Mothod=supplierId:"+getCurrentSupplierId()+";productId:"+objectVO.getProductId());
        String issavestatuinfo = "1";
        
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
	                
	                productSku.setSkuNameCn(buyName[i] + saleName[i]);
	                productSku.setSkuNameEn(buyName[i] + saleName[i]);
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
	                
	                productSku.setSkuNameCn(buyName[i] + saleName[i]);
	                productSku.setSkuNameEn(buyName[i] + saleName[i]);
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
        
        
        // 国内经销商不设置价格信息
        if(Constants.DOMESTIC_DEALER.equals(getSupplierType())){
        	
        	
        	for (int i = 0; i < buyVal.length; i++) {

                SupplierProductSkuDTO skuVO = new SupplierProductSkuDTO();
                SupplierProductSku productSku = new SupplierProductSku();
               
                productSku.setSkuNameCn(buyName[i] + saleName[i]);
                productSku.setSkuNameEn(buyName[i] + saleName[i]);
                
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
                        skuVO.setSupplierProductPriceMap(skuAttr.getSupplierProductPriceMap());
                    }
                }
            }
        	
        }
        
        

    

        objectVO.setSupplierProductSkuDTOs(productSkuVOs);
        objectVO.setSupplierProductSaleSetting(productSaleSetting);
        objectVO.setSupplierProductWholesaleRanges(wholesaleRanges);


        // 标识是中文还是英文
        if ("/en".equals(getLanguage()) || "/en" == getLanguage()) {
        	objectVO.getSupplierProduct().setMnemonicCode("2");
        } else {
        	objectVO.getSupplierProduct().setMnemonicCode("1");
        }

        objectVO.setSupplierid(getCurrentSupplierId());
        objectVO.setSubsupplierid("");
        objectVO.setProductId(objectVO.getProductId());

        objectVO.getSupplierProduct().setOperator(getCurrentUserId()+"");
        
        try {
        	logger.info("修改商品价格supplierId:"+getCurrentSupplierId()+";productId:"+objectVO.getProductId());
            RemoteServiceSingleton.getInstance().getSupplierProductService()
                    .updateProductObject(objectVO);
            issavestatuinfo = "1";
            logger.info("修改商品价格信息成功！！！");
        } catch (SupplierProException e) {
        	logger.error("修改商品价格失败！！！supplierId:"+getCurrentSupplierId()+";productId:"+objectVO.getProductId()+e.getMessage(),e);
            issavestatuinfo = "0";
        }

        return issavestatuinfo;
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
}
