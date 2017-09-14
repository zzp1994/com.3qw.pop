package com.mall.controller.product;

import com.mall.controller.base.BaseController;
import com.mall.merchant.proxy.RemoteServiceSingleton;
import com.mall.stock.dto.StockQtyVO;
import com.mall.supplier.model.Supplier;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Lyj on 2016/1/28.
 */
@Controller
public class InventoryController extends BaseController {
    /**
     * .
     */
    private static final Logger LOGGER = Logger.getLogger(InventoryController.class);

    @RequestMapping(value = "/inventory/editInventory", method = RequestMethod.GET)
    public String editInventory(Model model, StockQtyVO stockVo,Long pId) {
        LOGGER.info("查询商品所有规格库存信息");

        Supplier supplier = null;
        List<Map<String,Object>> skuList = new ArrayList<Map<String, Object>>();

        if(stockVo.getSupplierId() != null) {//查找供应商
            try {
                supplier = RemoteServiceSingleton.getInstance().getSupplierManagerService().findSupplier(stockVo.getSupplierId());

            } catch (Exception e) {
                LOGGER.error("查询供应商信息失败！！！supplier id: "+stockVo.getSupplierId()+e.getMessage(), e);
            }

            if(supplier != null) {
                if(stockVo.getpId() != null) {//查找SKU 列表
                    try {
                        skuList = RemoteServiceSingleton.getInstance().getDealerProductSkuService().getProductSkuByPidForPopStock(pId);
                    } catch (Exception e) {
                        LOGGER.error("查询SKU 列表信息失败！！！product id: "+stockVo.getpId()+e.getMessage(), e);
                    }

                    if(skuList == null || skuList.size() == 0) {
                        model.addAttribute("error", "未找到商品的SKU信息");
                    } else {
                        stockVo.setWarehouseCode(supplier.getSupplierId().intValue());
                        //stockVo.setWarehouseCode(671);
                        StockQtyVO skuVo = new StockQtyVO();
                        for(Map<String,Object> skuMap: skuList) {
                            if(stockVo.getpId() != null) {
                                try {
                                    skuVo = RemoteServiceSingleton.getInstance().getStockService().getProductQty(Long.valueOf(skuMap.get("sku_id").toString()), supplier.getSupplierId().intValue());
                                    skuMap.put("qty", skuVo==null?0:skuVo.getQty());
                                    skuMap.put("lockQty", skuVo==null?0:skuVo.getLockQty());
                                    skuMap.put("preSubQty", skuVo==null?0:skuVo.getPreSubQty());
                                    skuMap.put("warehouseCode", stockVo.getWarehouseCode());
                                    skuMap.put("version", skuVo==null?0:skuVo.getVersion());
                                } catch (Exception e) {
                                    LOGGER.error("查询商品所有规格库存信息失败！！！pid: "+stockVo.getpId()+e.getMessage(), e);
                                }
                            }
                        }
                    }
                    model.addAttribute("pId", stockVo.getpId());
                } else {
                    throw new RuntimeException("查询SKU 列表信息失败，未找到相应的商品ID");
                }
                model.addAttribute("warehouseCode", stockVo.getWarehouseCode());
            } else {
                throw new RuntimeException("获取商品仓库信息失败,未找到相应的供应商");
            }
        } else {
            throw new RuntimeException("获取供应商ID失败");
        }

        model.addAttribute("invList", skuList);

        return getLanguage() + "/product/modelPage/skuInventoryModel";
    }


    @RequestMapping(value = "/inventory/saveEditInventory", method = RequestMethod.POST)
    @ResponseBody
    public String saveEditInventory(Model model, HttpServletRequest request) {
        LOGGER.info("修改商品规格库存信息");

        Boolean flag = false;

        String pId = request.getParameter("pId");
        if(StringUtils.isEmpty(pId)) {
            throw new RuntimeException("修改商品规格库存信息失败！！！");
        }

        String params = request.getParameter("data");
        String warehouseCode = request.getParameter("warehouseCode");
        if(StringUtils.isNotEmpty(params) && StringUtils.isNotEmpty(warehouseCode)) {
            String [] list = StringUtils.split(params, "^");
            try {
                StockQtyVO stockVo = null;
                Long skuId;
                String skuName;
                Integer lockQty, preSubQty, qty, warehouse=Integer.valueOf(warehouseCode);
                for(String skus: list) {
                    String [] ids = StringUtils.split(skus, ";");
                    if(ids.length<4) {
                        throw new RuntimeException("更新数据有误！！！");
                    }
                    skuId = Long.valueOf(ids[0]);
                    skuName = ids[1];
                    lockQty = Integer.valueOf(ids[2]);
                    preSubQty = Integer.valueOf(ids[3]);
                    qty = Integer.valueOf(ids[4]);
                    try{
                        RemoteServiceSingleton.getInstance().getStockService().saveOrUpdatePOPStock(
                                Long.valueOf(pId), skuId, skuName, lockQty, preSubQty, qty, warehouse);
                    } catch (Exception e) {
                        LOGGER.error("修改商品规格库存信息失败！！！skuId: "+skuId+" warehouseCode: " + warehouse + e.getMessage(), e);
                        throw new RuntimeException("修改商品规格库存信息失败！！！skuId: "+skuId+" warehouseCode: " + warehouse + e.getMessage(), e);
                    }
                }

                flag = true;
            } catch (Exception e) {
                LOGGER.error("修改商品规格库存信息失败！！！pid: "+pId+e.getMessage(), e);
            }
        }

        return flag.toString();
    }
}
