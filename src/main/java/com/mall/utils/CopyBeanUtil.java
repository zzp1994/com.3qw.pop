package com.mall.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;

import com.mall.supplier.product.dto.SupplierProductAttrDTO;
import com.mall.supplier.product.dto.SupplierProductObjectDTO;
import com.mall.supplier.product.dto.SupplierProductSkuDTO;
import com.mall.supplier.product.po.B2cProductDetail;
import com.mall.supplier.product.po.SupplierProduct;
import com.mall.supplier.product.po.SupplierProductAttach;
import com.mall.supplier.product.po.SupplierProductAttr;
import com.mall.supplier.product.po.SupplierProductAttrval;
import com.mall.supplier.product.po.SupplierProductAudit;
import com.mall.supplier.product.po.SupplierProductBase;
import com.mall.supplier.product.po.SupplierProductBaseEn;
import com.mall.supplier.product.po.SupplierProductBuyAttrval;
import com.mall.supplier.product.po.SupplierProductDetail;
import com.mall.supplier.product.po.SupplierProductInventory;
import com.mall.supplier.product.po.SupplierProductPackage;
import com.mall.supplier.product.po.SupplierProductPrice;
import com.mall.supplier.product.po.SupplierProductSaleSetting;
import com.mall.supplier.product.po.SupplierProductSku;
import com.mall.supplier.product.po.SupplierProductSkuAttrval;
import com.mall.supplier.product.po.SupplierProductWeightRange;
import com.mall.supplier.product.po.SupplierProductWholesaleRange;

public class CopyBeanUtil {

	/***
	 * 
	 * @param oldProductVO 商品基本数据 页面获取到数据的完整数据包括无效数据
	 * @param buyMap 	页面传入原始图片的indexMap
	 * @return
	 */
	public static SupplierProductObjectDTO copy(SupplierProductObjectDTO oldProductVO,List<Integer> buyMap){
		SupplierProductObjectDTO productVO = new SupplierProductObjectDTO();
		productVO.setSupplierid(oldProductVO.getSupplierid());
		//商品核心信息
		SupplierProduct product = new SupplierProduct();
		BeanUtils.copyProperties(oldProductVO.getSupplierProduct(), product);
		productVO.setSupplierProduct(product);
		
		//附件信息
		List<SupplierProductAttach> attachs = new ArrayList<SupplierProductAttach>();
		for (SupplierProductAttach productAttach : oldProductVO.getSupplierProductAttachs()) {
			SupplierProductAttach attach = new SupplierProductAttach();
			BeanUtils.copyProperties(productAttach, attach);
			attachs.add(attach);
		}
		if(attachs!=null&& attachs.size()>0){
			productVO.setSupplierProductAttachs(attachs);
		}
		//商品审核信息
		List<SupplierProductAudit> audits = new ArrayList<SupplierProductAudit>();
		for(SupplierProductAudit productAudit:audits){
			SupplierProductAudit audit = new SupplierProductAudit();
			BeanUtils.copyProperties(productAudit, audit);
			audits.add(audit);
		}
		if (audits != null && audits.size() > 0) {
			productVO.setSupplierProductAudits(audits);
		}
		
		// 产品 基本&国际化信息
		SupplierProductBase base = new SupplierProductBase();
		BeanUtils.copyProperties(oldProductVO.getSupplierProductBase(), base);
		productVO.setSupplierProductBase(base);
		SupplierProductBaseEn baseEn = new SupplierProductBaseEn();
		BeanUtils.copyProperties(oldProductVO.getSupplierProductBaseEn(), baseEn);
		productVO.setSupplierProductBaseEn(baseEn);
		
		// 商品备货信息
		SupplierProductInventory inventory = new SupplierProductInventory();
		BeanUtils.copyProperties(oldProductVO.getSupplierProductInventorie(), inventory);
		productVO.setSupplierProductInventorie(inventory);
		
		// 商品包装信息
		SupplierProductPackage productPackage = new SupplierProductPackage();
		BeanUtils.copyProperties(oldProductVO.getSupplierProductPackage(), productPackage);
		productVO.setSupplierProductPackage(productPackage);
		
		// 商品销售信息表
		SupplierProductSaleSetting saleSetting = new SupplierProductSaleSetting();
		BeanUtils.copyProperties(oldProductVO.getSupplierProductSaleSetting(), saleSetting);
		productVO.setSupplierProductSaleSetting(saleSetting);

		//B2C商品信息
		B2cProductDetail b2cProductDetail=new B2cProductDetail();
		BeanUtils.copyProperties(oldProductVO.getB2cProductDetail(), b2cProductDetail);
		productVO.setB2cProductDetail(b2cProductDetail);

		// 商品阶梯重量表
		SupplierProductWeightRange weightRange = new SupplierProductWeightRange();
		BeanUtils.copyProperties(oldProductVO.getSupplierProductWeightRange(), weightRange);
		productVO.setSupplierProductWeightRange(weightRange);
		
		// 商品批发折扣表-阶梯价格
		List<SupplierProductWholesaleRange> ranges = new ArrayList<SupplierProductWholesaleRange>();
		for(SupplierProductWholesaleRange range : oldProductVO.getSupplierProductWholesaleRanges()){
			SupplierProductWholesaleRange wholesaleRange = new SupplierProductWholesaleRange();
			BeanUtils.copyProperties(range, wholesaleRange);
			ranges.add(wholesaleRange);
		}
		if (ranges.size() > 0 && ranges != null) {
			productVO.setSupplierProductWholesaleRanges(ranges);
		}
		
		// 商品明细表
		SupplierProductDetail detail = new SupplierProductDetail();
		BeanUtils.copyProperties(oldProductVO.getSupplierProductDetail(), detail);
		productVO.setSupplierProductDetail(detail);
		
		
		// key为旧的AttrValIndex value为去除无效数据后的attrValIndex
		Map<Integer,Integer> butValueAttrIndex = new HashMap<Integer, Integer>();
		Integer newAttrIndex = null;
		
		//商品属性属性值信息
		List<SupplierProductAttrDTO> attrVOs = new ArrayList<SupplierProductAttrDTO>();
		for(int i = 0;i < oldProductVO.getSupplierProductAttrDTOs().size();i++){
			
			SupplierProductAttrDTO supplierProductAttrVO = new SupplierProductAttrDTO(); 
			SupplierProductAttrDTO supplierProductAttrDTO = oldProductVO.getSupplierProductAttrDTOs().get(i);
			
			SupplierProductAttr attr = new SupplierProductAttr();
			BeanUtils.copyProperties(oldProductVO.getSupplierProductAttrDTOs().get(i).getSupplierProductAttr(), attr);
			
			List<SupplierProductAttrval> supplierProductAttrvals = new ArrayList<SupplierProductAttrval>();
			
			//循环所有Attr 对应全部的AttrVal
			for(int x =0;supplierProductAttrDTO.getSupplierProductAttrvals()!=null&&x<supplierProductAttrDTO.getSupplierProductAttrvals().size();x++){
				//获取单个AttrVal 复制
				SupplierProductAttrval attrval=oldProductVO.getSupplierProductAttrDTOs().get(i).getSupplierProductAttrvals().get(x);
				SupplierProductAttrval supplierProductAttrval = new SupplierProductAttrval();
				BeanUtils.copyProperties(attrval, supplierProductAttrval);
				
				//判断名字不为空 剔除无效数据
				if (supplierProductAttrval.getLineAttrvalNameCn() != null &&
				        !"".equals(supplierProductAttrval.getLineAttrvalNameCn())) {
					
					//设置newAttrVal的name
					supplierProductAttrval.setAttrNameCn(attr.getAttrNameCn());
					supplierProductAttrvals.add(supplierProductAttrval);
					//判断是否展示属性 
					if(supplierProductAttrDTO.getSupplierProductAttr().getBuyAttr()==1)
						// 设置新旧关系  x当前原始attrValIndex  
						//supplierProductAttrvals为新的attrVlas的集合 经过去除无效数据 设置新的index
						butValueAttrIndex.put(x, supplierProductAttrvals.size()-1);
					
					// 规格属性或者展示属性时候调用
					if(attr.getSaleAttr() == 1 || attr.getBuyAttr() == 1)
						//简历新旧数据的关联关系
						for(SupplierProductSkuDTO skuVo : oldProductVO.getSupplierProductSkuDTOs()){
							//循环所有skuVal信息
							for(SupplierProductSkuAttrval skuVal: skuVo.getSupplierProductSkuAttrvals()){
								//判断当前attrIndex是否等于当前循环的Index 
								if(skuVal.getAttrId() == i){
									//属性值值相同时一样修改
									if(skuVal.getAttrValId() == x){
										//如果是则更新旧的inex更新为最新的index
										//这一步执行时商品对象中attrVOs并未实际存入新的有效attr 所以不需要size-1
										skuVal.setAttrId(Long.parseLong(attrVOs.size()+""));
										//因为新集合已经实际存入新的对象 并且都是有效数据
										skuVal.setAttrValId(supplierProductAttrvals.size()-1l);
									}
								}
							}
						}
				}
				
			}
			
			//判断是否有有效的属性值
			if(supplierProductAttrvals.size()>0){
				//如果有则设置新的集合 并且保存到商品对象中
				supplierProductAttrVO.setSupplierProductAttr(attr);
				supplierProductAttrVO.setSupplierProductAttrvals(supplierProductAttrvals);
				attrVOs.add(supplierProductAttrVO);
				//或者展示属性新的index
				if(supplierProductAttrVO.getSupplierProductAttr().getBuyAttr()==1)
					newAttrIndex = attrVOs.size()-1;
			}
			
			//图片封装 判断是否有图片
			if(oldProductVO.getSupplierProductAttrDTOs().get(i).getMap()!=null&&oldProductVO.getSupplierProductAttrDTOs().get(i).getMap().size()>0){
				//新旧图片属性
				Map<Integer, List<SupplierProductBuyAttrval>> map = oldProductVO.getSupplierProductAttrDTOs().get(i).getMap();
				Map<Integer, List<SupplierProductBuyAttrval>> map2 = new LinkedHashMap<Integer, List<SupplierProductBuyAttrval>>();
				//循环遍历判断属性值  到这一步可以确定肯定是展示属性 
				//业务规定 每个展示属性的值必须有一组图片 最少1张最多6张
				if(supplierProductAttrvals.size()>0){
					for(int x = 0;x<buyMap.size();x++){
						//获取原始图片对象集合
						List<SupplierProductBuyAttrval> list = map.get(buyMap.get(x));
						List<SupplierProductBuyAttrval> buyVals = new ArrayList<SupplierProductBuyAttrval>();
						Integer integer  = 0;
						if(list != null && list.size() > 0){
							//循环设置新旧index
							for(SupplierProductBuyAttrval buyattr : list){
								SupplierProductBuyAttrval buyattrval = new SupplierProductBuyAttrval();
								BeanUtils.copyProperties(buyattr, buyattrval);
								//设置图片对象中展示属性的index  一个商品只能有一个展示属性
								buyattrval.setAttrId(newAttrIndex+0l);
								//根据旧的index获取到相对应新的index 并且赋值
								integer = butValueAttrIndex.get(buyMap.get(x));
								buyattrval.setAttrValId(integer.longValue());
								buyVals.add(buyattrval);
							}
						}
						if(buyVals.size()>0){
							map2.put(integer, buyVals);
						}
					}
					supplierProductAttrVO.setMap(map2);
				}
			}
			
			
			
		}
		
		productVO.setSupplierProductAttrDTOs(attrVOs);
		
		//商品sku信息
		List<SupplierProductSkuDTO> skuVOs = new ArrayList<SupplierProductSkuDTO>();
		
		for (int i = 0; i < oldProductVO.getSupplierProductSkuDTOs().size(); i++) {
			SupplierProductSkuDTO productSkuVO = new SupplierProductSkuDTO();
			SupplierProductSku sku = new SupplierProductSku();
			SupplierProductPrice price = new SupplierProductPrice();
			
			BeanUtils.copyProperties(oldProductVO.getSupplierProductSkuDTOs().get(i).getSupplierProductSku(), sku);
			productSkuVO.setSupplierProductSku(sku);
			BeanUtils.copyProperties(oldProductVO.getSupplierProductSkuDTOs().get(i).getSupplierProductPriceMap(), price);
			productSkuVO.setSupplierProductPriceMap(price);
			
			List<SupplierProductSkuAttrval> attrvals = new ArrayList<SupplierProductSkuAttrval>();
			
			for(SupplierProductSkuAttrval attrval : oldProductVO.getSupplierProductSkuDTOs().get(i).getSupplierProductSkuAttrvals()){
				SupplierProductSkuAttrval skuAttrval = new SupplierProductSkuAttrval();
				BeanUtils.copyProperties(attrval, skuAttrval);
				attrvals.add(skuAttrval);
			}
			
			if(attrvals.size()>0){
				productSkuVO.setSupplierProductSkuAttrvals(attrvals);
				skuVOs.add(productSkuVO);
			}
			
		}
		productVO.setSupplierProductSkuDTOs(skuVOs);
		
		return productVO; 
	}
}
