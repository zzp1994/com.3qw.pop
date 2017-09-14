package com.mall.controller.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.controller.base.BaseController;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.mybatis.utility.PageBean;
import com.mall.stock.dto.StockSupplyVO;
import com.mall.stock.po.StockSupply;
import com.mall.supplier.model.SupplierUser;
import com.mall.utils.Constants;


/**
 * 库存信息.
 * @author xusq
 */

@Controller
public class RepertoryConreoller extends BaseController{
	
	/**.
	 * 
	 */
	private static final Logger LOGGER = Logger.getLogger(RepertoryConreoller.class);
	
	
	/**
	 * @return String 转向库存页面.
	 */
	@RequestMapping("/inventory/getInventory")
	public String getInventory(){
		return getLanguage()+"/product/repertoryList" ;
	}
	

	/**
	 * 查询库存信息.
	 * @param stockSup 库存搜索条件
	 * @param model model
	 * @param status 状态吗
	 * @return String 库存页面
	 */
	@RequestMapping(value="/inventory/getInventory",method=RequestMethod.POST)
	public String getInventoryData(Model model,Integer page,StockSupplyVO stockSupplyVO,PageBean<StockSupplyVO> stockSupplierVo){
		
		stockSupplyVO.setSupplierIdList(getSupplierIds());
		
		//stockSupplierVo.setPage(page);  
		stockSupplierVo.setPageSize(Constants.PAGE_NUM_TEN);
		
		
		if("/zh".equals(getLanguage())){
			stockSupplyVO.setLanguageType(Constants.PUBLIC_STATIC_NUM_1);
		} else {
			stockSupplyVO.setLanguageType(Constants.PUBLIC_STATIC_NUM_0);
		}
		
		stockSupplierVo.setParameter(stockSupplyVO);
		if(RemoteServiceSingleton.getInstance().getStockSupplyService()!=null){
			try {
				stockSupplierVo = RemoteServiceSingleton.getInstance().getStockSupplyService()
						.findItemInStockListPage(stockSupplierVo);
				
			} catch (Exception e) { 
				LOGGER.error("查询库存信息失败！！！"+e.getMessage(),e);
			}
			

			Map<String, List<StockSupplyVO>> itemInStock = new LinkedHashMap<String, List<StockSupplyVO>>();
			
			List<StockSupplyVO> result = stockSupplierVo.getResult();
			
			
			for (StockSupplyVO stockSupplyVO2 : result) {
				List<StockSupplyVO> list=new  ArrayList<StockSupplyVO>();
				if(!itemInStock.containsKey(stockSupplyVO2.getpName())){
					list.add(stockSupplyVO2);
					itemInStock.put(stockSupplyVO2.getpName(), list);
				}else{
					list=itemInStock.get(stockSupplyVO2.getpName());
					list.add(stockSupplyVO2);
					itemInStock.remove(stockSupplyVO2.getpName());
					itemInStock.put(stockSupplyVO2.getpName(), list);
				}
					
			}
			
			
			model.addAttribute("data",itemInStock);
			model.addAttribute("pb",stockSupplierVo);
			model.addAttribute("isItemInStock",true);
		}
		
		return getLanguage()+"/product/modelPage/inventoryModel";
	}
	
	
	
	@RequestMapping("/inventory/collection")
	public String getCollection(Model model,PageBean<StockSupplyVO> stockSupplierVo,StockSupplyVO stockSupplyVO){
		
		stockSupplyVO.setSupplierIdList(getSupplierIds());
		
		//stockSupplierVo.setPage(page);  
		stockSupplierVo.setPageSize(Constants.PAGE_NUM_TEN);
		

		if("/zh".equals(getLanguage())){
			stockSupplyVO.setLanguageType(Constants.PUBLIC_STATIC_NUM_1);
		} else {
			stockSupplyVO.setLanguageType(Constants.PUBLIC_STATIC_NUM_0);
		}
		
		stockSupplierVo.setParameter(stockSupplyVO);
		
		if(RemoteServiceSingleton.getInstance().getStockSupplyService()!=null){
			try {
				stockSupplierVo = RemoteServiceSingleton.getInstance().getStockSupplyService().findCollectionQtyListPage(stockSupplierVo);
				
			} catch (Exception e) { 
				LOGGER.error("查询库存信息失败！！！"+e.getMessage(),e);
			}
			

			Map<String, List<StockSupplyVO>> itemInStock = new LinkedHashMap<String, List<StockSupplyVO>>();
			
			List<StockSupplyVO> result = stockSupplierVo.getResult();
			
			
			for (StockSupplyVO stockSupplyVO2 : result) {
				List<StockSupplyVO> list=new  ArrayList<StockSupplyVO>();
				if(!itemInStock.containsKey(stockSupplyVO2.getpName())){
					list.add(stockSupplyVO2);
					itemInStock.put(stockSupplyVO2.getpName(), list);
				}else{
					list=itemInStock.get(stockSupplyVO2.getpName());
					list.add(stockSupplyVO2);
					itemInStock.remove(stockSupplyVO2.getpName());
					itemInStock.put(stockSupplyVO2.getpName(), list);
				}
					
			}
			

			LOGGER.info(JSON.toJSONString(itemInStock));
			model.addAttribute("data",itemInStock);
			model.addAttribute("pb",stockSupplierVo);
			model.addAttribute("isItemInStock",false);
		
		
		}
		return getLanguage()+"/product/modelPage/collectionModel";
	}
	
	
	@RequestMapping("/inventory/getSkuQty")
	@ResponseBody
	public String getSkuQty(Long skuId){

		System.out.println(skuId);
		StockSupply findStockById = new StockSupply();
		if(null != RemoteServiceSingleton.getInstance().getStockSupplyService()){
			findStockById = RemoteServiceSingleton.getInstance().getStockSupplyService().findStockById(skuId);
		}
    	
    	Map<String, String> stock = new HashMap<String, String>();
    	if(null != findStockById){
    		stock.put("id", ""+findStockById.getId());
    		stock.put("qty",""+findStockById.getQty());
    		stock.put("presubQty", ""+findStockById.getPresubQty());
    	}
    	
    	
		String json = JSONArray.fromObject(stock).toString();
		
		return json;
	}
	
	
	/**
	 * 无批次的库存跟新.
	 * @param upAmount 跟新数量.
	 * @param repertoryId 库存id
	 * @return 是否成功
	 */
	@RequestMapping(value="/inventory/upAmount",method=RequestMethod.POST)
	@ResponseBody
	public String upAmount(Long editId,Integer supplyQty){
		try{

			SupplierUser supplierUser = getCurrentUser();
			String createBy = supplierUser.getLoginName() + "("
					+ supplierUser.getSupplierId() + ")";
			
	    	if(RemoteServiceSingleton.getInstance().getStockSupplyService()!=null){
	    		
	    		RemoteServiceSingleton.getInstance().getStockSupplyService().updateStockQtyForSupplier(editId, supplyQty, createBy);
	    		
	    		logger.info("修改成功qty="+supplyQty+";editId="+editId);
	    		
	    	}
	    	
			return "1";
		}
		catch (Exception e) {
			LOGGER.error("修改库存失败！"+supplyQty+";editId="+editId+e.getMessage(),e);
			return "0";
		}
		
	}
	
}
