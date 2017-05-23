package find.main.controller;

import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import find.common.common.CommandMap;
import find.main.service.MainService;
import find.test.service.TestService;

@Controller
public class MainController {
	Logger log = Logger.getLogger(this.getClass());
	@Value("#{props['common.serverIp']}")
	private String svrIp;
	@Resource(name="mainService")
	private MainService mainService;
	
	@RequestMapping(value="/find/findMain.do")
	public ModelAndView openFindMain(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/system/find/find_main");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        
        RestTemplate restTemplate = new RestTemplate();
        String result = restTemplate.getForObject("http://localhost:3000/rest/loss/list", String.class);
        JSONArray jsonArray = new JSONArray(result);
        mv.addObject("lossData", jsonArray.toString());
        
        result = restTemplate.getForObject("http://localhost:3000/rest/dog/list", String.class);
        jsonArray = new JSONArray(result);

        mv.addObject("dogData", jsonArray);
        
        result = restTemplate.getForObject("http://localhost:3000/rest/cat/list", String.class);
        jsonArray = new JSONArray(result);

        mv.addObject("catData", jsonArray);

        return mv;
	}
	
	@RequestMapping(value="/find/findMap.do")
	public ModelAndView openFindMap(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/system/find/find_map");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        
        RestTemplate restTemplate = new RestTemplate();
        String result = restTemplate.getForObject("http://localhost:3000/rest/loss/list", String.class);
        JSONArray jsonArray = new JSONArray(result);
        
        mv.addObject("lossData", jsonArray.toString());
        return mv;
	}
	
	@RequestMapping(value="/find/findInsert.do")
	public ModelAndView openFindInsert(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        Map<String, Object> fileMap = (Map<String, Object>) mainService.insertFileData(commandMap.getMap(), request);
        String result = "";
        String findList = "";
        String pushTo = "";
        double lossLat, lossLng, lat, lng, absLat, absLng;
        double cprLat = 0.04003746243;
        double cprLng = 0.02243791391;
        
        
        commandMap.put("img_org", fileMap.get("img_org"));
        commandMap.put("img_std", fileMap.get("img_std"));
        //헤더에 데이터를 실어 보내기위해 json객체로 만듬
        JSONObject jsonObject = new JSONObject(commandMap.getMap());
        //헤더에 데이터를 실는 작업
        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("utf-8");
        headers.setContentType(new MediaType("application", "json", utf8));
        HttpEntity param= new HttpEntity(jsonObject.toString(), headers);
        
        RestTemplate restTemplate = new RestTemplate();
        
        if(commandMap.getMap().get("find_type").equals("loss")){
        	result = restTemplate.postForObject("http://localhost:3000/rest/loss/insert", param, String.class);
        	findList = restTemplate.getForObject("http://localhost:3000/rest/loss/list", String.class);
        } else {
        	findList = restTemplate.getForObject("http://localhost:3000/rest/loss/list", String.class);
        	JSONArray findArray = new JSONArray(findList);
        	
        	for(int i = 0; i < findArray.length(); i++){
        		JSONObject findObject = findArray.getJSONObject(i);
        		lossLat = Double.parseDouble((String)findObject.get("lat"));
        		lossLng = Double.parseDouble((String)findObject.get("lng"));
        		lat = Double.parseDouble((String)commandMap.getMap().get("lat"));
        		lng = Double.parseDouble((String)commandMap.getMap().get("lng"));
        		
        		absLat = Math.abs(lossLat - lat);
        		absLng = Math.abs(lossLng - lng);
        		
        		if(absLat < cprLat && absLng < cprLng){
        			if(findObject.get("user_id") != null && !findObject.get("user_id").equals("")){
	        			pushTo = restTemplate.getForObject("http://localhost:3000/rest/users/id/"+findObject.get("user_id").toString(), String.class);
	        			JSONObject pushObject = new JSONObject(pushTo);
	        			
	        			if(pushObject.has("user_token") && !pushObject.get("user_token").equals("")){
		        	        HttpHeaders pushHeaders = new HttpHeaders();
		        			pushHeaders.setContentType(new MediaType("application", "json", utf8));
		        			pushHeaders.add("Authorization", "Key=AAAAYCWhH6U:APA91bEOOlnc1ngqIS3xkaaYwnmtSTccA-rzw4i4xP7eZpAgVVhEQjC4MO-5GwvDAbSzxAEb3a92NBs7rmfo6k0N_dusc1ps22VmhexzxU-kwrf5UM6XSYjGRfW8W3CEGovLtMfh5kX2");
		        	        
		        	        JSONObject body = new JSONObject();
		        	        JSONObject data = new JSONObject();
		        	        JSONObject notidata = new JSONObject();
		        	        notidata.put("body","FindPet");
		        	        notidata.put("title","5km 근방에 습득 동물이 접수되었습니다.");
		        	        data.put("score","5x1");
		        	        data.put("time","15:10");
		        	        data.put("message","FindPet");
		        	        body.put("notification", notidata);
		        	        body.put("data", data);
		        	        body.put("to", pushObject.get("user_token"));
		        	        
		        	        HttpEntity pushParam= new HttpEntity(body.toString(), pushHeaders);
		        	        
		        	        restTemplate.postForObject("https://fcm.googleapis.com/fcm/send", pushParam, String.class);
	        			}
        			}
        		}
        	}
        	
        	result = restTemplate.postForObject("http://localhost:3000/rest/find/insert", param, String.class);
        	findList = restTemplate.getForObject("http://localhost:3000/rest/find/list", String.class);
        }
        
        JSONArray jsonArray = new JSONArray(findList);
        
        mv.addObject("result", result);
        mv.addObject("lossData", jsonArray.toString());
        
        return mv;
	}
	
	
	@RequestMapping(value="/find/findDetail.do")
	public ModelAndView openFindDetail(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        String result = "fail";
        String lossList = "";
        RestTemplate restTemplate = new RestTemplate();
        if(commandMap.getMap().get("map_type").equals("loss")){
        	lossList = restTemplate.getForObject("http://localhost:3000/rest/loss/list/id/"+commandMap.getMap().get("id"), String.class);
        } else {
        	lossList = restTemplate.getForObject("http://localhost:3000/rest/find/list/id/"+commandMap.getMap().get("id"), String.class);
        }
        if(lossList != null){
        	result = "success";
        }
        JSONObject jsonObject = new JSONObject(lossList);
        mv.addObject("result", result);
        mv.addObject("lossData", jsonObject.toString());
        
        return mv;
	}
	
	@RequestMapping(value="/find/findLossList.do")
	public ModelAndView openFindLossList(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        String map_type = (String)commandMap.getMap().get("map_type");
        
        String result = "fail";
        RestTemplate restTemplate = new RestTemplate();
        String lossList = "";
        if(map_type.equals("loss")){
        	lossList = restTemplate.getForObject("http://localhost:3000/rest/loss/list", String.class);
        } else {
        	lossList = restTemplate.getForObject("http://localhost:3000/rest/find/list", String.class);
        }
        if(lossList != null){
        	result = "success";
        }
        JSONArray jsonArray = new JSONArray(lossList);
        mv.addObject("result", result);
        mv.addObject("lossData", jsonArray.toString());
        
        return mv;
	}
	
	@RequestMapping(value="/find/findFindList.do")
	public ModelAndView openFindList(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        String result = "fail";
        RestTemplate restTemplate = new RestTemplate();
        String findList = restTemplate.getForObject("http://localhost:3000/rest/find/list", String.class);
        if(findList != null){
        	result = "success";
        }
        JSONArray jsonArray = new JSONArray(findList);
        mv.addObject("result", result);
        mv.addObject("findData", jsonArray.toString());
        
        return mv;
	}
	
	@RequestMapping(value="/find/findKindAjax.do")
	public ModelAndView openKindAjax(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        String result = "";
        RestTemplate restTemplate = new RestTemplate();
        if(commandMap.getMap().get("kind").equals("dog")){
        	result = restTemplate.getForObject("http://localhost:3000/rest/dog/list", String.class);
        } else {
        	result = restTemplate.getForObject("http://localhost:3000/rest/cat/list", String.class);
        }
        
        if(result != null){
        	mv.addObject("result", "success");
        }
        JSONArray jsonArray = new JSONArray(result);
        
        mv.addObject("kindData", jsonArray.toString());
        return mv;
	}
	
	@RequestMapping(value="/find/findSearchAjax.do")
	public ModelAndView openSearchAjax(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        String result = "";
        String url = "";
        if(commandMap.getMap().get("map_type").equals("loss")){
        	url = "http://localhost:3000/rest/loss/list/kind/"+commandMap.getMap().get("kind")+"/detail/"+commandMap.getMap().get("kind_detail")+"/sex/"+commandMap.getMap().get("sex");
        } else {
        	url = "http://localhost:3000/rest/find/list/kind/"+commandMap.getMap().get("kind")+"/detail/"+commandMap.getMap().get("kind_detail")+"/sex/"+commandMap.getMap().get("sex");
        }
        RestTemplate restTemplate = new RestTemplate();
        result = restTemplate.getForObject(url, String.class);        
        if(result != null){
        	mv.addObject("result", "success");
        	JSONArray jsonArray = new JSONArray(result);
            mv.addObject("jsonData", jsonArray.toString());
        }
        
        return mv;
	}
	
	@RequestMapping(value="/find/findChatInsert.do")
	public ModelAndView openChatInsert(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        
        //헤더에 데이터를 실어 보내기위해 json객체로 만듬
        JSONObject jsonObject = new JSONObject(commandMap.getMap());
        //헤더에 데이터를 실는 작업
        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("utf-8");
        headers.setContentType(new MediaType("application", "json", utf8));
        HttpEntity param= new HttpEntity(jsonObject.toString(), headers);
        
        RestTemplate restTemplate = new RestTemplate();
        String result = restTemplate.getForObject("http://localhost:3000/rest/chat/list/user1/"+commandMap.getMap().get("user1_id")+"/user2/"+commandMap.getMap().get("user2_id"), String.class);
        if(result.equals("null")){
        	result = restTemplate.postForObject("http://localhost:3000/rest/chat/insert", param, String.class);
        	mv.addObject("result", result);
        }
        
        return mv;
	}
	
	@RequestMapping(value="/find/findChatList.do")
	public ModelAndView openChatList(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        
        RestTemplate restTemplate = new RestTemplate();
        String result = restTemplate.getForObject("http://localhost:3000/rest/chat/list/user/"+commandMap.getMap().get("user_id"), String.class);
    	JSONArray jsonArray = new JSONArray(result);
    	if(jsonArray.length() >= 1){
    		mv.addObject("result", "success");
    	} else {
    		mv.addObject("result", "fail");
    	}
        mv.addObject("jsonData", jsonArray.toString());
        return mv;
	}
	
	
	@RequestMapping(value="/find/insertUser.do")
	public ModelAndView insertUser(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        String text = "exist";
        
        commandMap.getMap().put("user_token", "");
        //헤더에 데이터를 실어 보내기위해 json객체로 만듬
        JSONObject jsonObject = new JSONObject(commandMap.getMap());
        //헤더에 데이터를 실는 작업
        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("utf-8");
        headers.setContentType(new MediaType("application", "json", utf8));
        HttpEntity param= new HttpEntity(jsonObject.toString(), headers);
        
        RestTemplate restTemplate = new RestTemplate();
        String result = restTemplate.getForObject("http://localhost:3000/rest/users/id/"+commandMap.getMap().get("user_id"), String.class);
        if(result.equals("null")){
        	result = restTemplate.postForObject("http://localhost:3000/rest/users/insert", param, String.class);
        	text = "insert";
        }
        mv.addObject("result", text);
        return mv;
	}
}
