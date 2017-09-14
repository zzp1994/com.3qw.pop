package com.mall.utils;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.mall.stock.dto.StockSupplyVO;

public class MD5 {
	public final static String encrypt(String s) {
        char hexDigits[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};       

        try {
            byte[] btInput = s.getBytes();
            // 获得MD5摘要算法的 MessageDigest 对象
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            // 使用指定的字节更新摘要
            mdInst.update(btInput);
            // 获得密文
            byte[] md = mdInst.digest();
            // 把密文转换成十六进制的字符串形式
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
                // str[k++] = hexDigits[byte0 << 4 & 0xf];
            }
            return new String(str);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
	public static void main(String[] args) {
		
		System.out.println(MD5.encrypt("aaa123"));
		
		
		Map<String, List<StockSupplyVO>> itemInStock = new LinkedHashMap<String, List<StockSupplyVO>>();
		
		List<StockSupplyVO> result = new  ArrayList<StockSupplyVO>();
		
		StockSupplyVO v1=new StockSupplyVO();
		v1.setpName("aaa");
		v1.setPid(1L);
		StockSupplyVO v2=new StockSupplyVO();
		v2.setpName("aaa");
		v2.setPid(2L);
		StockSupplyVO v3=new StockSupplyVO();
		v3.setpName("aaa");
		v3.setPid(3L);
		StockSupplyVO v4=new StockSupplyVO();
		v4.setpName("bbb");
		v4.setPid(4L);
		result.add(v1);
		result.add(v2);
		result.add(v3);
		result.add(v4);
		
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
		
		System.out.println(JSON.toJSONString(itemInStock));
		
	}

}
