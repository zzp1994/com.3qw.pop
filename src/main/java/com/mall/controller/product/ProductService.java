package com.mall.controller.product;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.mall.category.po.TdCatePubAttr;
import com.mall.category.po.TdCatePubAttrval;
import com.mall.dealer.product.dto.DealerProductAttrDTO;
import com.mall.dealer.product.dto.DealerProductObjectDTO;
import com.mall.dealer.product.dto.DealerProductSkuDTO;
import com.mall.dealer.product.po.DealerProductAttr;
import com.mall.dealer.product.po.DealerProductAttrval;
import com.mall.dealer.product.po.DealerProductBuyAttrval;
import com.mall.dealer.product.po.DealerProductSkuAttrval;
import com.mall.supplier.product.dto.SupplierProductAttrDTO;
import com.mall.supplier.product.dto.SupplierProductObjectDTO;
import com.mall.supplier.product.dto.SupplierProductSkuDTO;
import com.mall.supplier.product.po.SupplierProductAttr;
import com.mall.supplier.product.po.SupplierProductAttrval;
import com.mall.supplier.product.po.SupplierProductBuyAttrval;
import com.mall.supplier.product.po.SupplierProductSkuAttrval;
import com.mall.utils.Constants;

public class ProductService {

	
	  /**
   	 * sku条形码数据回显.
   	 * @param proObjVo 商品对象
   	 * @return SupplierProductObjectDTO
   	 */
   	List<Object> showSkuCode(SupplierProductObjectDTO proObjVo) {
   		
   		List<Object> saveforsku  = null;
   		List<String> barCodeImgs = new ArrayList<String>();
   		List<Integer> buyIndex = new ArrayList<Integer>();
   		List<List<Integer>> saleIndex = new ArrayList<List<Integer>>();
   		List<String> skuBarCode = new ArrayList<String>();
   		List<String> skuId = new ArrayList<String>();//20161209增加skuid
		List<String> domesticPriceIndex = new ArrayList<String>();
		List<String> unitPriceIndex = new ArrayList<String>();
		List<String> hqjIndex = new ArrayList<String>();
		
		List<String> fhedIndex = new ArrayList<String>();
		List<String> bestoayPriceIndex = new ArrayList<String>();
		List<String> priceIdIndex = new ArrayList<String>();
		List<String> productCodeIndex = new ArrayList<String>();
   		
   		Map<Long,Boolean> saleIdMap = this.getSaleIdMap(proObjVo);
   		
   		List<SupplierProductSkuDTO> supplierProSkuVOs = proObjVo.getSupplierProductSkuDTOs();
   		
   		if(null != supplierProSkuVOs && supplierProSkuVOs.size() > 0 ){
	   		
	   		for ( int i = 0 ; i< supplierProSkuVOs.size() ; i++ ){
	
	   		   
	   			String supplierSkuCode = supplierProSkuVOs.get(i).getSupplierProductSku().getSkuCode();
	   			String supplierSkuId = supplierProSkuVOs.get(i).getSupplierProductSku().getSkuId()+"";
	   	        String barCodeImgUrl = supplierProSkuVOs.get(i).getSupplierProductSku().getBarCodeImage();

				// 封装价格属性
				String domesticPrice = supplierProSkuVOs.get(i).getSupplierProductPriceMap().getDomesticPrice().setScale(2,BigDecimal.ROUND_UP) + "";
				String unitPrice = supplierProSkuVOs.get(i).getSupplierProductPriceMap().getUnitPrice().setScale(2,BigDecimal.ROUND_UP) + "";
				String bestoayPrice = supplierProSkuVOs.get(i).getSupplierProductPriceMap().getBestoayPrice().setScale(2,BigDecimal.ROUND_UP) + "";
				String priceId = supplierProSkuVOs.get(i).getSupplierProductPriceMap().getPriceId() + "";
				String productCode = supplierProSkuVOs.get(i).getSupplierProductSku().getProductCode();
				
				
			
				String hqj="";
				if((supplierProSkuVOs.get(i).getSupplierProductPriceMap().getCashHqj())!=null){
					 hqj = supplierProSkuVOs.get(i).getSupplierProductPriceMap().getCashHqj().setScale(2,BigDecimal.ROUND_UP) + "";
				}
				
				String fhed = supplierProSkuVOs.get(i).getSupplierProductPriceMap().getFhed().setScale(2,BigDecimal.ROUND_UP) + "";

				domesticPriceIndex.add(domesticPrice);
				unitPriceIndex.add(unitPrice);
				bestoayPriceIndex.add(bestoayPrice);
				priceIdIndex.add(priceId);
				productCodeIndex.add(productCode);
				
				
				hqjIndex.add(hqj);
				fhedIndex.add(fhed);
	   	            String showBarCode = "";
	   	            
	   	            if(!"".equals(barCodeImgUrl)){
	   	            	showBarCode = "<img imgtype='temp' width='120px' height='30px' class='preview'" 
	   	    							+ "src='" + Constants.FILESERVER1+barCodeImgUrl + "'/>"
	   	    									+ "<input type='hidden' name='barCodeImg' value='" + Constants.FILESERVER1+barCodeImgUrl+ "'>";
	   	            }
	   				List<SupplierProductSkuAttrval> productSkuAttrvals = supplierProSkuVOs.get(i).getSupplierProductSkuAttrvals();
	   				
	   				String buyAttrValName = "";
	   				
	   				List<String> saleAttrValNames = new ArrayList<String>();
	   				
	   				for(SupplierProductSkuAttrval prodSkuAttrval :productSkuAttrvals){
	   					Long attrId = prodSkuAttrval.getAttrId();
	   					Boolean isName = saleIdMap.get(attrId);
	   					
	   					if(null != isName){
	   						if(isName){
		   						saleAttrValNames.add(prodSkuAttrval.getAttrvalNameCn());
	   						}else if(!isName){
	   							buyAttrValName = prodSkuAttrval.getAttrvalNameCn();
	   						}
	   					}
	   				}
	   				
	   				
	   				List<SupplierProductAttrDTO> skuAttrs = proObjVo.getSupplierProductAttrDTOs();
   					List<Integer> saleIndexx = new ArrayList<Integer>();
	   				for(int j=0;j<skuAttrs.size();j++){
	   					//展示属性
	   					if(skuAttrs.get(j).getSupplierProductAttr().getBuyAttr()==1){
	   						
	   						List<SupplierProductAttrval> productBuyAttrs = skuAttrs.get(j).getSupplierProductAttrvals();
	   						
	   						if(null != productBuyAttrs && productBuyAttrs.size() > 0 ){
	   							
	   							for (int k = 0; k < productBuyAttrs.size(); k++) {
	   								
	   								if(buyAttrValName.equals(productBuyAttrs.get(k).getLineAttrvalNameCn())){
	   									
	   									buyIndex.add(k);
	   								}
	   							}
	   						}
	   					} else {
	   						//规格属性
	   						if(skuAttrs.get(j).getSupplierProductAttr().getSaleAttr()==1){
	   							
	   							
	   							List<SupplierProductAttrval> productSaleAttrs = skuAttrs.get(j).getSupplierProductAttrvals();
	   							
	   							if(null != productSaleAttrs && productSaleAttrs.size() > 0 ){
	   								
	   								for (int  x= 0; x < productSaleAttrs.size(); x++) {
	   									
	   									for (String saleAttrValName : saleAttrValNames) {
	   										if(saleAttrValName.equals(productSaleAttrs.get(x).getLineAttrvalNameCn())){
		   										saleIndexx.add(x);
		   									}
										}
	   								}
	   							}
   								
   							}
   							
	   					}
	   				}
	   				skuBarCode.add(supplierSkuCode);
	   				skuId.add(supplierSkuId);
	   				barCodeImgs.add(showBarCode);
	   				saleIndex.add(saleIndexx);
	   		}
	   		
	   		
   		}


   		List<Object> skusBarCode = new ArrayList<Object>();
   		for (int i = 0; i < buyIndex.size(); i++) {
   			saveforsku = new ArrayList<Object>();
   			saveforsku.add(buyIndex.get(i));
   			saveforsku.add(saleIndex.get(i));
   			saveforsku.add(skuBarCode.get(i));
   			saveforsku.add(barCodeImgs.get(i));

			// 封装价格数组
			saveforsku.add(priceIdIndex.get(i));
			saveforsku.add(domesticPriceIndex.get(i));
			saveforsku.add(unitPriceIndex.get(i));
			saveforsku.add(bestoayPriceIndex.get(i));
			saveforsku.add(productCodeIndex.get(i));//商品货号
			
			
			saveforsku.add(hqjIndex.get(i));
			saveforsku.add(fhedIndex.get(i));
			
			saveforsku.add(skuId.get(i));
			
   			skusBarCode.add(saveforsku);
   		}
   		return skusBarCode;
   	}


   	
    /**
   	 * 根据sku报价是的数据回显.
   	 * @param proObjVo 商品对象
   	 * @return SupplierProductObjectDTO
   	 */
   	List<Object> showSkuPic(SupplierProductObjectDTO proObjVo) {
   		List<Object> saveforsku  = null;
   		
   		List<Integer> buyIndex = new ArrayList<Integer>();
   		List<List<Integer>> saleIndex = new ArrayList<List<Integer>>();
   		List<BigDecimal> skuPic = new ArrayList<BigDecimal>();
   		Map<Long,Boolean> saleIdMap = this.getSaleIdMap(proObjVo);
   		List<SupplierProductSkuDTO> supplierProSkuVOs = proObjVo.getSupplierProductSkuDTOs();
   		
   		if(null != supplierProSkuVOs && supplierProSkuVOs.size() > 0 ){
   			
	   		for ( int i = 0 ; i< supplierProSkuVOs.size() ; i++ ){
	
	    			BigDecimal supplierprice = supplierProSkuVOs.get(i).getSupplierProductPriceMap().getSupplierprice();
	   				List<SupplierProductSkuAttrval> supplierProductSkuAttrvals = supplierProSkuVOs.get(i).getSupplierProductSkuAttrvals();
	   				
	   				String buyAttrValName = "";
	   				
	   				List<String> saleAttrValNames = new ArrayList<String>();
	   				
	   				
	   				if(null != supplierProductSkuAttrvals && supplierProductSkuAttrvals.size() > 0){
	   				
	   				
		   				for(SupplierProductSkuAttrval supplierProdSkuAttrval :supplierProductSkuAttrvals){
		   					Long attrId = supplierProdSkuAttrval.getAttrId();
		   					Boolean isName = saleIdMap.get(attrId);
		   					
		   					if(null != isName){
		   						if(isName){
			   						saleAttrValNames.add(supplierProdSkuAttrval.getAttrvalNameCn());
		   						}else if(!isName){
		   							buyAttrValName = supplierProdSkuAttrval.getAttrvalNameCn();
		   						}
		   					}
		   				}
		   				
	   				}
	   				
	   				
	   				List<SupplierProductAttrDTO> skuAttrs = proObjVo.getSupplierProductAttrDTOs();
   					List<Integer> saleIndexx = new ArrayList<Integer>();
	   				for(int j=0;j<skuAttrs.size();j++){
	   					//展示属性
	   					if(skuAttrs.get(j).getSupplierProductAttr().getBuyAttr()==1){
	   						
	   						List<SupplierProductAttrval> productBuyAttrs = skuAttrs.get(j).getSupplierProductAttrvals();
	   						
	   						if(null != productBuyAttrs && productBuyAttrs.size() > 0){
	   							
	   							for (int k = 0; k < productBuyAttrs.size(); k++) {
	   	   							
	   	   							if(buyAttrValName == productBuyAttrs.get(k).getLineAttrvalNameCn()||
	   	   									buyAttrValName.equals(productBuyAttrs.get(k).getLineAttrvalNameCn())){
	   	   								buyIndex.add(k);
	   	   							}
	   	   						}
	   						}
	   						
	   					} else {
	   						//规格属性
	   						if(skuAttrs.get(j).getSupplierProductAttr().getSaleAttr()==1){
	   							
	   							List<SupplierProductAttrval> productSaleAttrs = 
	   									skuAttrs.get(j).getSupplierProductAttrvals();
	   							if(null != productSaleAttrs && productSaleAttrs.size() > 0){
	   								
	   								for (int  x= 0; x < productSaleAttrs.size(); x++) {
	   									
	   									for (String saleAttrValName : saleAttrValNames) {
	   										if(saleAttrValName.equals(productSaleAttrs.get(x).getLineAttrvalNameCn())){
		   										saleIndexx.add(x);
		   									}
										}
	   								}
	   							}
	   							
	   						}
	   					}
	   				}
	   				skuPic.add(supplierprice);
	   				saleIndex.add(saleIndexx);

	   		}
   		}
   		
   	
   		
   		List<Object> skusPic = new ArrayList<Object>();
   		for (int i = 0; i < buyIndex.size(); i++) {
   			saveforsku = new ArrayList<Object>();
   			saveforsku.add(buyIndex.get(i));
   			saveforsku.add(saleIndex.get(i));
   			saveforsku.add(skuPic.get(i));
   			skusPic.add(saveforsku);
   		}
   		
   		return skusPic;
   	}
       
       
   	/**
   	 * saleAttrId is true
   	 * buyAttrId is false
   	 * @param proObjVo
   	 * @return
   	 */
   	private Map<Long,Boolean> getSaleIdMap(SupplierProductObjectDTO proObjVo){
   		Map<Long, Boolean> saleMap = new LinkedHashMap<Long,Boolean>();
   		List<SupplierProductAttrDTO> supplierProductAttrDTOs = proObjVo.getSupplierProductAttrDTOs();
   		for(SupplierProductAttrDTO attrDto : supplierProductAttrDTOs){
   			SupplierProductAttr supplierProductAttr = attrDto.getSupplierProductAttr();
   			if(supplierProductAttr.getSaleAttr().equals((short)1)){
   				saleMap.put(supplierProductAttr.getAttrId(), true);
   			}else if(supplierProductAttr.getBuyAttr().equals((short)1)){
   				saleMap.put(supplierProductAttr.getAttrId(), false);
   			}
   		}
   		
   		return saleMap;
   	}
   	
   	
   	
   

   

    /**
     * 回显属性和属性名.
     * 
     * @param categoryAttrAndValList
     *            类目属性属性值
     * @param productAttrVOs
     *            商品属性属性值
     * @return List<SupplierProductAttrDTO>
     */
    public List<SupplierProductAttrDTO> showAttrAndAttrVal(
            Map<TdCatePubAttr, List<TdCatePubAttrval>> categoryAttrAndValList,
            List<SupplierProductAttrDTO> productAttrVOs) {

        List<String> prodAttrNames = new ArrayList<String>();

        // 获取所有的属性名集合
        if (productAttrVOs != null && productAttrVOs.size() > 0) {
            for (int i = 0; i < productAttrVOs.size(); i++) {
                String attrNameCn = productAttrVOs.get(i)
                        .getSupplierProductAttr().getAttrNameCn();
                prodAttrNames.add(attrNameCn);
            }
        }

        // 迭代类目中的属性名
        List<SupplierProductAttrDTO> pageAttrs = new ArrayList<SupplierProductAttrDTO>();
        Set<TdCatePubAttr> cateAttrs = categoryAttrAndValList.keySet();
        Iterator<TdCatePubAttr> iterator = cateAttrs.iterator();
        while (iterator.hasNext()) {

            TdCatePubAttr tdCatePubAttr = iterator.next();

            String lineAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
            String lineAttrNameEn = tdCatePubAttr.getLineAttrName();
            String attrDescribe = tdCatePubAttr.getAttrDescribe();

            SupplierProductAttrDTO productAttrVO = new SupplierProductAttrDTO();
            SupplierProductAttr productAttr = new SupplierProductAttr();

            // 判断商品中是否有对应的属性名
            if (prodAttrNames.contains(lineAttrNameCn)) {

                for (int i = 0; i < productAttrVOs.size(); i++) {

                    String productAttrNameCn = productAttrVOs.get(i)
                            .getSupplierProductAttr().getAttrNameCn();
                    if (lineAttrNameCn.equals(productAttrNameCn)) {

                        SupplierProductAttrval sProdAttrAddAttrVal = null;
                        productAttr = productAttrVOs.get(i)
                                .getSupplierProductAttr();

                        List<SupplierProductAttrval> productAttrvals =
                                productAttrVOs.get(i).getSupplierProductAttrvals();

                        List<String> newListAttrval = new ArrayList<String>();
                        
                        if(null != productAttrvals) {
	                        // 获取所有的属性值集合
	                        for (SupplierProductAttrval newProductAttrval : productAttrvals) {
	                            String lineAttrvalNameCn = newProductAttrval
	                                    .getLineAttrvalNameCn();
	                            newListAttrval.add(lineAttrvalNameCn);
	                        }

	                        List<TdCatePubAttrval> cateAttrValList =
	                                categoryAttrAndValList.get(tdCatePubAttr);
	
	                        for (int j = 0; j < cateAttrValList.size(); j++) {
	                            String lineAttrvalNameCn = cateAttrValList.get(j)
	                                    .getLineAttrvalNameCn();
	                            String lineAttrvalNameEn = cateAttrValList.get(j)
	                                    .getLineAttrvalName();
	
	                            for (int k = 0; k < productAttrvals.size(); k++) {
	
	                                if (lineAttrvalNameCn.equals(productAttrvals
	                                        .get(k).getLineAttrvalNameCn())) {
	                                    productAttrvals.get(k).setLineAttrvalName(
	                                            lineAttrvalNameEn);
	                                    productAttrvals.get(k)
	                                            .setLineAttrvalNameCn(
	                                                    lineAttrvalNameCn);
	                                }
	                            }
	
	                            if ((!newListAttrval.contains(lineAttrvalNameCn))
	                                    && (!newListAttrval
	                                            .contains(lineAttrvalNameEn))) {
	                                sProdAttrAddAttrVal = new SupplierProductAttrval();
	                                sProdAttrAddAttrVal.setLineAttrvalName(lineAttrvalNameEn);
	                                sProdAttrAddAttrVal.setLineAttrvalNameCn(lineAttrvalNameCn);
	                                sProdAttrAddAttrVal.setIsProdAttr(false);
	
	                                if (productAttrVOs.get(i).getSupplierProductAttr().getType() != 3) {
	                                    productAttrvals.add(sProdAttrAddAttrVal);
	                                }
	                            }
	                        }
                        }

                        if (null != sProdAttrAddAttrVal) {
                            if (productAttrVOs.get(i).getSupplierProductAttr().getType() != 3) {
                                productAttrvals.add(sProdAttrAddAttrVal);
                            }
                        }

                        Map<Integer, List<SupplierProductBuyAttrval>> map = productAttrVOs.get(i).getMap();
                        productAttr.setAttrNameCn(lineAttrNameCn);
                        productAttr.setAttrName(lineAttrNameEn);
                        //TODO
                        productAttr.setIsmeasure(attrDescribe);

                        productAttrVO.setSupplierProductAttr(productAttr);
                        productAttrVO.setSupplierProductAttrvals(productAttrvals);
                        productAttrVO.setMap(map);

                    }

                    if (!pageAttrs.contains(productAttrVO)) {
                        pageAttrs.add(productAttrVO);
                    }

                }

            } else if (prodAttrNames.contains(lineAttrNameEn)) {

                for (int i = 0; i < productAttrVOs.size(); i++) {

                    String productAttrNameCn = productAttrVOs.get(i)
                            .getSupplierProductAttr().getAttrNameCn();

                    if (lineAttrNameEn.equals(productAttrNameCn)) {

                        SupplierProductAttrval sProdAttrAddAttrVal = null;
                        productAttr = productAttrVOs.get(i)
                                .getSupplierProductAttr();

                        List<SupplierProductAttrval> productAttrvals =
                                productAttrVOs.get(i).getSupplierProductAttrvals();

                        List<String> newListAttrval = new ArrayList<String>();
                        
                        if(null != productAttrvals){
                        	
	                        
	                        // 获取所有的属性值集合
	                        for (SupplierProductAttrval newProductAttrval : productAttrvals) {
	                            String lineAttrvalNameCn = newProductAttrval
	                                    .getLineAttrvalNameCn();
	                            newListAttrval.add(lineAttrvalNameCn);
	                        }
	
	                        List<TdCatePubAttrval> cateAttrValList = categoryAttrAndValList.get(tdCatePubAttr);
	
	                        for (int j = 0; j < cateAttrValList.size(); j++) {
	
	                            String lineAttrvalNameCn = cateAttrValList.get(j)
	                                    .getLineAttrvalNameCn();
	                            String lineAttrvalNameEn = cateAttrValList.get(j)
	                                    .getLineAttrvalName();
	
	                            for (int k = 0; k < productAttrvals.size(); k++) {
	
	                                if (lineAttrvalNameEn.equals(productAttrvals.get(k).getLineAttrvalNameCn())) {
	                                    productAttrvals.get(k).setLineAttrvalName(lineAttrvalNameEn);
	                                    productAttrvals.get(k).setLineAttrvalNameCn(lineAttrvalNameCn);
	                                }
	                            }
	
	                            if ((!newListAttrval.contains(lineAttrvalNameCn))
	                                    && (!newListAttrval.contains(lineAttrvalNameEn))) {
	                                sProdAttrAddAttrVal = new SupplierProductAttrval();
	
	                                sProdAttrAddAttrVal.setLineAttrvalName(lineAttrvalNameEn);
	                                sProdAttrAddAttrVal.setLineAttrvalNameCn(lineAttrvalNameCn);
	                                sProdAttrAddAttrVal.setIsProdAttr(false);
	
	                                if (sProdAttrAddAttrVal != null) {
	                                    if (productAttrVOs.get(i).getSupplierProductAttr().getType() != 3) {
	                                        productAttrvals.add(sProdAttrAddAttrVal);
	                                    }
	                                }
	                            }
	                        }
	
	                        if (sProdAttrAddAttrVal != null) {
	                            if (productAttrVOs.get(i).getSupplierProductAttr().getType() != 3) {
	                                productAttrvals.add(sProdAttrAddAttrVal);
	                            }
	                        }
                        }

                        Map<Integer, List<SupplierProductBuyAttrval>> map = productAttrVOs.get(i).getMap();

                        productAttr.setAttrNameCn(lineAttrNameCn);
                        productAttr.setAttrName(lineAttrNameEn);
                        productAttr.setIsmeasure(attrDescribe);

                        
                        
                        productAttrVO.setSupplierProductAttr(productAttr);
                        productAttrVO
                                .setSupplierProductAttrvals(productAttrvals);
                        productAttrVO.setMap(map);

                    }
                    if (!pageAttrs.contains(productAttrVO)) {
                        pageAttrs.add(productAttrVO);
                    }
                }

            } else {

                List<TdCatePubAttrval> list = categoryAttrAndValList
                        .get(tdCatePubAttr);
                SupplierProductAttrval supplierProductAttrval = null;
                List<SupplierProductAttrval> productAttrvals = new ArrayList<SupplierProductAttrval>();

                for (int j = 0; j < list.size(); j++) {
                    supplierProductAttrval = new SupplierProductAttrval();
                    supplierProductAttrval.setLineAttrvalName(list.get(j)
                            .getLineAttrvalName());
                    supplierProductAttrval.setLineAttrvalNameCn(list.get(j)
                            .getLineAttrvalNameCn());
                    supplierProductAttrval.setIsProdAttr(false);
                    productAttrvals.add(supplierProductAttrval);
                }

                productAttr.setAttrNameCn(lineAttrNameCn);
                productAttr.setAttrName(lineAttrNameEn);
                productAttr.setIsneed(tdCatePubAttr.getRequired());
                productAttr.setType(tdCatePubAttr.getType());
                productAttr.setStyle(tdCatePubAttr.getStyle());
                productAttr.setBuyAttr(tdCatePubAttr.getBuyAttr());
                productAttr.setSaleAttr(tdCatePubAttr.getSaleAttr());
                productAttr.setIsbrand(tdCatePubAttr.getIsbrand());
                productAttr.setIsneed(tdCatePubAttr.getRequired());
                productAttr.setIsalter(tdCatePubAttr.getIsmodify());
                productAttr.setIsmeasure(attrDescribe);

                
                
                productAttrVO.setSupplierProductAttr(productAttr);
                productAttrVO.setSupplierProductAttrvals(productAttrvals);

                pageAttrs.add(productAttrVO);

            }
        }
        if (productAttrVOs != null && productAttrVOs.size() > 0) {
            for (int i = 0; i < productAttrVOs.size(); i++) {
                List<SupplierProductAttrval> getProductAttrvals =
                        productAttrVOs.get(i).getSupplierProductAttrvals();
                
                if(null != getProductAttrvals){
                	
                	LinkedHashSet<SupplierProductAttrval> onlyVals = 
                			new LinkedHashSet<SupplierProductAttrval>(getProductAttrvals);
                	getProductAttrvals.clear();
                	getProductAttrvals.addAll(onlyVals);
                }
                
            }
        }
        return pageAttrs;
    }


	/**.
	 * 组合类目模板和商品属性 对象  前台遍历使用
	 * @param categoryAttrAndValList Map<TdCatePubAttr, List<TdCatePubAttrval>>
	 * @param proObjVo DealerProductObjectDTO
	 * @return List List<DealerProductAttrDTO>
	 */
	public List<DealerProductAttrDTO> showAttrAndAttrValDealer(
			Map<TdCatePubAttr, List<TdCatePubAttrval>> categoryAttrAndValList,
			DealerProductObjectDTO proObjVo) {
		List<DealerProductAttrDTO> productAttrVOs =
				proObjVo.getDealerProductAttrDTOs();
		List<String> prodAttrNames = new ArrayList<String>();

		//获取所有的属性名集合
		if(productAttrVOs!=null&&productAttrVOs.size()>0){
			for (int i = 0; i < productAttrVOs.size(); i++) {
				String attrNameCn =
						productAttrVOs.get(i).getDealerProductAttr().getAttrNameCn();
				prodAttrNames.add(attrNameCn);
			}
		}

		//迭代类目中的属性名
		List<DealerProductAttrDTO> pageAttrs = new ArrayList<DealerProductAttrDTO>();
		Set<TdCatePubAttr> cateAttrs = categoryAttrAndValList.keySet();
		Iterator<TdCatePubAttr> iterator = cateAttrs.iterator();
		while (iterator.hasNext()) {

			TdCatePubAttr tdCatePubAttr = iterator.next();

			String lineAttrNameCn = tdCatePubAttr.getLineAttrNameCn();
			String lineAttrNameEn = tdCatePubAttr.getLineAttrName();


			DealerProductAttrDTO productAttrVO = new DealerProductAttrDTO();
			DealerProductAttr productAttr = new DealerProductAttr();

			// 判断商品中是否有对应的属性名
			// 判断商品中是否有对应的属性名
			if (prodAttrNames.contains(lineAttrNameCn)) {

				for (int i = 0; i < productAttrVOs.size(); i++) {

					String productAttrNameCn = productAttrVOs.get(i).getDealerProductAttr().getAttrNameCn();
					if (lineAttrNameCn.equals(productAttrNameCn)) {




						DealerProductAttrval sProdAttrAddAttrVal = null;
						productAttr = productAttrVOs.get(i).getDealerProductAttr();

						List<DealerProductAttrval> productAttrvals =
								productAttrVOs.get(i).getDealerProductAttrvals();


						List<String> newListAttrval = new ArrayList<String>();
						//获取所有的属性值集合
						for (DealerProductAttrval newProductAttrval : productAttrvals) {
							String lineAttrvalNameCn = newProductAttrval.getLineAttrvalNameCn();
							newListAttrval.add(lineAttrvalNameCn);
						}

						List<TdCatePubAttrval> cateAttrValList = categoryAttrAndValList.get(tdCatePubAttr);

						for (int j = 0; j < cateAttrValList.size(); j++) {
							String lineAttrvalNameCn = cateAttrValList.get(j).getLineAttrvalNameCn();
							String lineAttrvalNameEn = cateAttrValList.get(j).getLineAttrvalName();

							for(int k =0;k  < productAttrvals.size();k++){

								if(lineAttrvalNameCn.equals(
										productAttrvals.get(k).getLineAttrvalNameCn())){
									productAttrvals.get(k).setLineAttrvalName(lineAttrvalNameEn);
									productAttrvals.get(k).setLineAttrvalNameCn(lineAttrvalNameCn);
								}
							}


							if ((!newListAttrval.contains(lineAttrvalNameCn))
									&&(!newListAttrval.contains(lineAttrvalNameEn))) {
								sProdAttrAddAttrVal = new DealerProductAttrval();
								sProdAttrAddAttrVal.setLineAttrvalName(lineAttrvalNameEn);
								sProdAttrAddAttrVal.setLineAttrvalNameCn(lineAttrvalNameCn);
								sProdAttrAddAttrVal.setIsProdAttr(false);

								if(productAttrVOs.get(i).getDealerProductAttr().getType()
										!= Constants.SHORT3) {
									productAttrvals.add(sProdAttrAddAttrVal);
								}
							}
						}

						if (sProdAttrAddAttrVal != null) {
							if(productAttrVOs.get(i).getDealerProductAttr().getType()
									!= Constants.SHORT3) {
								productAttrvals.add(sProdAttrAddAttrVal);
							}
						}


						Map<Integer, List<DealerProductBuyAttrval>> map = productAttrVOs.get(i).getMap();
						productAttr.setAttrNameCn(lineAttrNameCn);
						productAttr.setAttrName(lineAttrNameEn);

						productAttrVO.setDealerProductAttr(productAttr);
						productAttrVO.setDealerProductAttrvals(productAttrvals);
						productAttrVO.setMap(map);

					}

					if(!pageAttrs.contains(productAttrVO))
						pageAttrs.add(productAttrVO);


				}


			} else if (prodAttrNames.contains(lineAttrNameEn)) {

				for (int i = 0; i < productAttrVOs.size(); i++) {

					String productAttrNameCn = productAttrVOs.get(i).getDealerProductAttr().getAttrNameCn();

					if (lineAttrNameEn.equals(productAttrNameCn)) {


						DealerProductAttrval sProdAttrAddAttrVal = null;
						productAttr = productAttrVOs.get(i).getDealerProductAttr();

						List<DealerProductAttrval> productAttrvals =
								productAttrVOs.get(i).getDealerProductAttrvals();


						List<String> newListAttrval = new ArrayList<String>();
						//获取所有的属性值集合
						for (DealerProductAttrval newProductAttrval : productAttrvals) {
							String lineAttrvalNameCn = newProductAttrval.getLineAttrvalNameCn();
							newListAttrval.add(lineAttrvalNameCn);
						}

						List<TdCatePubAttrval> cateAttrValList = categoryAttrAndValList.get(tdCatePubAttr);

						for (int j = 0; j < cateAttrValList.size(); j++) {

							String lineAttrvalNameCn = cateAttrValList.get(j).getLineAttrvalNameCn();
							String lineAttrvalNameEn = cateAttrValList.get(j).getLineAttrvalName();

							for(int k =0;k  < productAttrvals.size();k++){

								if(lineAttrvalNameEn.equals(productAttrvals.get(k).getLineAttrvalNameCn())){

									productAttrvals.get(k).setLineAttrvalName(lineAttrvalNameEn);
									productAttrvals.get(k).setLineAttrvalNameCn(lineAttrvalNameCn);

								}
							}


							if ((!newListAttrval.contains(lineAttrvalNameCn))&&(!newListAttrval.contains(lineAttrvalNameEn))) {

								sProdAttrAddAttrVal = new DealerProductAttrval();

								sProdAttrAddAttrVal.setLineAttrvalName(lineAttrvalNameEn);
								sProdAttrAddAttrVal.setLineAttrvalNameCn(lineAttrvalNameCn);
								sProdAttrAddAttrVal.setIsProdAttr(false);

								if (sProdAttrAddAttrVal != null) {

									if(productAttrVOs.get(i).getDealerProductAttr().getType() != Constants.SHORT3){

										productAttrvals.add(sProdAttrAddAttrVal);

									}
								}
							}
						}

						if (sProdAttrAddAttrVal != null) {

							if(productAttrVOs.get(i).getDealerProductAttr().getType() != Constants.SHORT3) {
								productAttrvals.add(sProdAttrAddAttrVal);
							}

						}

						Map<Integer, List<DealerProductBuyAttrval>> map = productAttrVOs.get(i).getMap();


						productAttr.setAttrNameCn(lineAttrNameCn);
						productAttr.setAttrName(lineAttrNameEn);

						productAttrVO.setDealerProductAttr(productAttr);
						productAttrVO.setDealerProductAttrvals(productAttrvals);
						productAttrVO.setMap(map);

					}
					if(!pageAttrs.contains(productAttrVO))
						pageAttrs.add(productAttrVO);
				}

			}else {

				List<TdCatePubAttrval> list = categoryAttrAndValList.get(tdCatePubAttr);
				DealerProductAttrval supplierProductAttrval = null;
				List<DealerProductAttrval> productAttrvals = new ArrayList<DealerProductAttrval>();

				for(int j=0;j<list.size();j++){
					supplierProductAttrval = new DealerProductAttrval();
					supplierProductAttrval.setLineAttrvalName(list.get(j).getLineAttrvalName());
					supplierProductAttrval.setLineAttrvalNameCn(list.get(j).getLineAttrvalNameCn());
					supplierProductAttrval.setIsProdAttr(false);
					productAttrvals.add(supplierProductAttrval);
				}

				productAttr.setAttrNameCn(lineAttrNameCn);
				productAttr.setAttrName(lineAttrNameEn);
				productAttr.setIsneed(tdCatePubAttr.getRequired());
				productAttr.setType(tdCatePubAttr.getType());
				productAttr.setStyle(tdCatePubAttr.getStyle());
				productAttr.setBuyAttr(tdCatePubAttr.getBuyAttr());
				productAttr.setSaleAttr( tdCatePubAttr.getSaleAttr());
				productAttr.setIsbrand(tdCatePubAttr.getIsbrand());
				productAttr.setIsneed(tdCatePubAttr.getRequired());
				productAttr.setIsalter( tdCatePubAttr.getIsmodify());

				productAttrVO.setDealerProductAttr(productAttr);
				productAttrVO.setDealerProductAttrvals(productAttrvals);

				pageAttrs.add(productAttrVO);

			}
		}
		if(productAttrVOs!=null&&productAttrVOs.size()>0){
			for(int i = 0 ; i< productAttrVOs.size() ; i++){
				List<DealerProductAttrval> getProductAttrvals =
						productAttrVOs.get(i).getDealerProductAttrvals();
				LinkedHashSet<DealerProductAttrval> onlyVals  =
						new LinkedHashSet<DealerProductAttrval>(getProductAttrvals);
				getProductAttrvals.clear();
				getProductAttrvals.addAll(onlyVals);
			}
		}
		return pageAttrs;
	}


	/**
	 * sku条形码数据回显.
	 * @param proObjVo 商品对象
	 * @return SupplierProductObjectDTO
	 */
	List<Object> showSkuCodeDealer(DealerProductObjectDTO proObjVo) {

		List<Object> saveforsku  = null;
		List<String> barCodeImgs = new ArrayList<String>();
		List<Integer> buyIndex = new ArrayList<Integer>();
   		List<List<Integer>> saleIndex = new ArrayList<List<Integer>>();
		List<String> skuBarCode = new ArrayList<String>();
		List<String> domesticPriceIndex = new ArrayList<String>();
		List<String> unitPriceIndex = new ArrayList<String>();
		List<String> hqjIndex = new ArrayList<String>();
		List<String> fhedIndex = new ArrayList<String>();
		List<String> bestoayPriceIndex = new ArrayList<String>();
		List<String> priceIdIndex = new ArrayList<String>();
		List<String> productCodeIndex = new ArrayList<String>();
		Map<Long,Boolean> saleIdMap = this.getSaleIdMapDealer(proObjVo);

		List<DealerProductSkuDTO> supplierProSkuVOs = proObjVo.getDealerProductSkuDTOs();

		if(null != supplierProSkuVOs && supplierProSkuVOs.size() > 0 ){

			for ( int i = 0 ; i< supplierProSkuVOs.size() ; i++ ){


				String supplierSkuCode = supplierProSkuVOs.get(i).getDealerProductSku().getSkuCode();
				String barCodeImgUrl = supplierProSkuVOs.get(i).getDealerProductSku().getBarCodeImage();

				// 封装价格属性
				String domesticPrice = supplierProSkuVOs.get(i).getDealerProductPriceMap().getDomesticPrice().setScale(2) + "";
				String unitPrice = supplierProSkuVOs.get(i).getDealerProductPriceMap().getUnitPrice().setScale(2) + "";
				String bestoayPrice = supplierProSkuVOs.get(i).getDealerProductPriceMap().getBestoayPrice().setScale(2) + "";
				String priceId = supplierProSkuVOs.get(i).getDealerProductPriceMap().getPriceId() + "";
				String productCode = supplierProSkuVOs.get(i).getDealerProductSku().getProductCode();
				String hqj="";
				if((supplierProSkuVOs.get(i).getDealerProductPriceMap().getCashHqj())!=null){
				hqj = supplierProSkuVOs.get(i).getDealerProductPriceMap().getCashHqj().setScale(2) + "";
				}
				
				String fhed = supplierProSkuVOs.get(i).getDealerProductPriceMap().getFhed().setScale(2) + "";
				
				domesticPriceIndex.add(domesticPrice);
				unitPriceIndex.add(unitPrice);
				bestoayPriceIndex.add(bestoayPrice);
				priceIdIndex.add(priceId);
				productCodeIndex.add(productCode);
				hqjIndex.add(hqj);
				fhedIndex.add(fhed);

				String showBarCode = "";

				if(!"".equals(barCodeImgUrl)){
					showBarCode = "<img imgtype='temp' width='120px' height='30px' class='preview'"
							+ "src='" + Constants.FILESERVER1+barCodeImgUrl + "'/>"
							+ "<input type='hidden' name='barCodeImg' value='" + Constants.FILESERVER1+barCodeImgUrl+ "'>";
				}
				List<DealerProductSkuAttrval> productSkuAttrvals = supplierProSkuVOs.get(i).getDealerProductSkuAttrvals();

				String buyAttrValName = "";

   				List<String> saleAttrValNames = new ArrayList<String>();

				for(DealerProductSkuAttrval prodSkuAttrval :productSkuAttrvals){
					Long attrId = prodSkuAttrval.getAttrId();
					Boolean isName = saleIdMap.get(attrId);

					if(null != isName){
						if(isName){
	   						saleAttrValNames.add(prodSkuAttrval.getAttrvalNameCn());
						}else if(!isName){
							buyAttrValName = prodSkuAttrval.getAttrvalNameCn();
						}
					}
				}


				List<DealerProductAttrDTO> skuAttrs = proObjVo.getDealerProductAttrDTOs();
				List<Integer> saleIndexx = new ArrayList<Integer>();
				for(int j=0;j<skuAttrs.size();j++){
					//展示属性
					if(skuAttrs.get(j).getDealerProductAttr().getBuyAttr()==1){

						List<DealerProductAttrval> productBuyAttrs = skuAttrs.get(j).getDealerProductAttrvals();

						if(null != productBuyAttrs && productBuyAttrs.size() > 0 ){

							for (int k = 0; k < productBuyAttrs.size(); k++) {

								if(buyAttrValName.equals(productBuyAttrs.get(k).getLineAttrvalNameCn())){

									buyIndex.add(k);
								}
							}
						}
					} else {
						//规格属性
						if(skuAttrs.get(j).getDealerProductAttr().getSaleAttr()==1){


							List<DealerProductAttrval> productSaleAttrs = skuAttrs.get(j).getDealerProductAttrvals();

							if(null != productSaleAttrs && productSaleAttrs.size() > 0 ){

								for (int  x= 0; x < productSaleAttrs.size(); x++) {
									for (String saleAttrValName : saleAttrValNames) {
   										if(saleAttrValName.equals(productSaleAttrs.get(x).getLineAttrvalNameCn())){
	   										saleIndexx.add(x);
	   									}
									}
								}
							}

						}

					}
				}
				skuBarCode.add(supplierSkuCode);
				barCodeImgs.add(showBarCode);
   				saleIndex.add(saleIndexx);
			}


		}


		List<Object> skusBarCode = new ArrayList<Object>();
		for (int i = 0; i < buyIndex.size(); i++) {
			saveforsku = new ArrayList<Object>();
			saveforsku.add(buyIndex.get(i));
			saveforsku.add(saleIndex.get(i));
			saveforsku.add(skuBarCode.get(i));
			saveforsku.add(barCodeImgs.get(i));

			// 封装价格数组
			saveforsku.add(priceIdIndex.get(i));
			saveforsku.add(domesticPriceIndex.get(i));
			saveforsku.add(unitPriceIndex.get(i));
			saveforsku.add(bestoayPriceIndex.get(i));
			saveforsku.add(productCodeIndex.get(i));
			saveforsku.add(hqjIndex.get(i));
			saveforsku.add(fhedIndex.get(i));
			skusBarCode.add(saveforsku);
		}
		return skusBarCode;
	}


	/**
	 * saleAttrId is true
	 * buyAttrId is false
	 * @param proObjVo
	 * @return
	 */
	private Map<Long,Boolean> getSaleIdMapDealer(DealerProductObjectDTO proObjVo){
		Map<Long, Boolean> saleMap = new LinkedHashMap<Long,Boolean>();
		List<DealerProductAttrDTO> supplierProductAttrDTOs = proObjVo.getDealerProductAttrDTOs();
		if(null!=supplierProductAttrDTOs) {
			for (DealerProductAttrDTO attrDto : supplierProductAttrDTOs) {
				DealerProductAttr supplierProductAttr = attrDto.getDealerProductAttr();
				if (supplierProductAttr.getSaleAttr().equals((short) 1)) {
					saleMap.put(supplierProductAttr.getAttrId(), true);
				} else if (supplierProductAttr.getBuyAttr().equals((short) 1)) {
					saleMap.put(supplierProductAttr.getAttrId(), false);
				}
			}
		}

		return saleMap;
	}


	/**
	 * 根据sku报价是的数据回显.
	 * @param proObjVo 商品对象
	 * @return SupplierProductObjectDTO
	 */
	List<Object> showSkuPicDealer(DealerProductObjectDTO proObjVo) {
		List<Object> saveforsku  = null;

		List<Integer> buyIndex = new ArrayList<Integer>();
   		List<List<Integer>> saleIndex = new ArrayList<List<Integer>>();
		List<BigDecimal> skuPic = new ArrayList<BigDecimal>();
		Map<Long,Boolean> saleIdMap = this.getSaleIdMapDealer(proObjVo);
		List<DealerProductSkuDTO> supplierProSkuVOs = proObjVo.getDealerProductSkuDTOs();

		if(null != supplierProSkuVOs && supplierProSkuVOs.size() > 0 ){

			for ( int i = 0 ; i< supplierProSkuVOs.size() ; i++ ){

				BigDecimal supplierprice = supplierProSkuVOs.get(i).getDealerProductPriceMap().getSupplierprice();
				List<DealerProductSkuAttrval> supplierProductSkuAttrvals = supplierProSkuVOs.get(i).getDealerProductSkuAttrvals();

				String buyAttrValName = "";

   				List<String> saleAttrValNames = new ArrayList<String>();


				if(null != supplierProductSkuAttrvals && supplierProductSkuAttrvals.size() > 0){


					for(DealerProductSkuAttrval supplierProdSkuAttrval :supplierProductSkuAttrvals){
						Long attrId = supplierProdSkuAttrval.getAttrId();
						Boolean isName = saleIdMap.get(attrId);

						if(null != isName){
							if(isName){
		   						saleAttrValNames.add(supplierProdSkuAttrval.getAttrvalNameCn());
							}else if(!isName){
								buyAttrValName = supplierProdSkuAttrval.getAttrvalNameCn();
							}
						}
					}

				}


				List<DealerProductAttrDTO> skuAttrs = proObjVo.getDealerProductAttrDTOs();
				List<Integer> saleIndexx = new ArrayList<Integer>();
				for(int j=0;j<skuAttrs.size();j++){
					//展示属性
					if(skuAttrs.get(j).getDealerProductAttr().getBuyAttr()==1){

						List<DealerProductAttrval> productBuyAttrs = skuAttrs.get(j).getDealerProductAttrvals();

						if(null != productBuyAttrs && productBuyAttrs.size() > 0){

							for (int k = 0; k < productBuyAttrs.size(); k++) {

								if(buyAttrValName == productBuyAttrs.get(k).getLineAttrvalNameCn()||
										buyAttrValName.equals(productBuyAttrs.get(k).getLineAttrvalNameCn())){
									buyIndex.add(k);
								}
							}
						}

					} else {
						//规格属性
						if(skuAttrs.get(j).getDealerProductAttr().getSaleAttr()==1){

							List<DealerProductAttrval> productSaleAttrs =
									skuAttrs.get(j).getDealerProductAttrvals();
							if(null != productSaleAttrs && productSaleAttrs.size() > 0){

								for (int  x= 0; x < productSaleAttrs.size(); x++) {
									for (String saleAttrValName : saleAttrValNames) {
   										if(saleAttrValName.equals(productSaleAttrs.get(x).getLineAttrvalNameCn())){
	   										saleIndexx.add(x);
	   									}
									}
								}
							}

						}
					}
				}
				skuPic.add(supplierprice);
   				saleIndex.add(saleIndexx);

			}
		}



		List<Object> skusPic = new ArrayList<Object>();
		for (int i = 0; i < buyIndex.size(); i++) {
			saveforsku = new ArrayList<Object>();
			saveforsku.add(buyIndex.get(i));
			saveforsku.add(saleIndex.get(i));
			saveforsku.add(skuPic.get(i));
			skusPic.add(saveforsku);
		}

		return skusPic;
	}

}
