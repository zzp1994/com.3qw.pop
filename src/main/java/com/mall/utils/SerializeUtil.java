package com.mall.utils;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
/**
 * 序列化和反序列化 java对象序列化，主要是一种针对需要I/O操作的，
 * 此时写入磁盘恰巧需要I/O。 让类实现serializable接口，此类的对象
 * 就可以被序列化了。针对对象的对象流：ObjectOutputStream，
 * 调用writeObject()/readObject()可以实现序列化、反序列化。
 * @author wangdj
 */
public class SerializeUtil {
	
	public static byte[] serialize(Object object) {
		ObjectOutputStream oos = null;
		ByteArrayOutputStream baos = null;
		try {
			//序列化
			baos = new ByteArrayOutputStream();
			oos = new ObjectOutputStream(baos);
			oos.writeObject(object);
			byte[] bytes = baos.toByteArray();
		    return bytes;
		} catch (Exception e) {
		   e.printStackTrace();
		}
		return null;
	}
	 
	public static Object unserialize(Object object) {
		ByteArrayInputStream bais = null;
		try {
			//反序列化
			bais = new ByteArrayInputStream((byte[])object);
			ObjectInputStream ois = new ObjectInputStream(bais);
			return ois.readObject();
		} catch (Exception e) {
		 
		}
		return null;
	}
/*	
	public static void main(String[] args) throws Exception {
		
		 Supplier  r=new Supplier();
		 r.setName("sss");
		 List<Map<String ,Object>> list=new ArrayList<Map<String ,Object>>();
		   
		  Map<String ,Object> map0=new LinkedHashMap<String, Object>();
		  map0.put("key:0", new Integer(0));
		  map0.put("key:1", new Long(0));
		  map0.put("key:2", "String2");
		  
          Map<String ,Object> map1=new LinkedHashMap<String, Object>();     
		  map1.put("key:4", "sss");
		  map1.put("key:5", r);
		  map1.put("key:6", "aaaaa" );
		  list.add(map0);
		  list.add(map1);
	
		  MemcachedUtil.client.set("s000001", 30*60,SerializeUtil.serialize(list));
		  System.out.println("ss"+SerializeUtil.unserialize(MemcachedUtil.client.get("s000001")));
		
		  List<Map<String ,Object>> list1=new ArrayList<Map<String ,Object>>();
		  list1=(List<Map<String, Object>>) SerializeUtil.unserialize(MemcachedUtil.client.get("s000001"));
		  for (int i = 0; i < list1.size(); i++) {
			  Map<String ,Object> map3=list1.get(i);
			  Set<Map.Entry<String, Object>> set = map3.entrySet();
		        for (Iterator<Map.Entry<String, Object>> it = set.iterator(); it.hasNext();) {
		            Map.Entry<String, Object> entry = (Map.Entry<String, Object>) it.next();
		            System.out.println(entry.getKey() + "--->" + entry.getValue());
		            if("key:5".equals(entry.getKey())){
		            	  Supplier  r1=(Supplier)entry.getValue();
		            	  System.out.println(r1.getSupplierId()+"sss"+r1.getName());
		            }    
		        }
		 }
		结果    ss[{key:0=0, key:1=0, key:2=String2}, {key:4=sss, key:5=com.ccig.supplier.model.Supplier@79de256f, key:6=aaaaa}]

				  key:0--->0
				  key:1--->0
				  key:2--->String2
				  key:4--->sss
				  key:5--->com.ccig.supplier.model.Supplier@676bd8ea
				  1ssssss
				  key:6--->aaaaa
	}*/
}
	