package find.test.controller;

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
import find.test.service.TestService;

@Controller
public class TestController {
	Logger log = Logger.getLogger(this.getClass());
	@Value("#{props['common.serverIp']}")
	private String svrIp;
	@Resource(name="testService")
	TestService testService;
	
	@RequestMapping(value="/test/testMain.do")
	public ModelAndView openTestMain(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/system/test/test_main");
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
	
	@RequestMapping(value="/test/testMap.do")
	public ModelAndView openTestMap(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/system/test/test_map");
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
        System.out.println(result);
        JSONArray jsonArray = new JSONArray(result);
        System.out.println(jsonArray);
        
        mv.addObject("lossData", jsonArray.toString());
        return mv;
	}
	
	@RequestMapping(value="/test/testPop.do")
	public ModelAndView openTestPop(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/system/test/test_pop");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        return mv;
	}
	
	@RequestMapping(value="/test/testInsert.do")
	public ModelAndView openTestInsert(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
                
            }
        }
        Map<String, Object> fileMap = (Map<String, Object>) testService.insertFileData(commandMap.getMap(), request);
        
        commandMap.put("loss_img_org", fileMap.get("loss_img_org"));
        commandMap.put("loss_img_std", fileMap.get("loss_img_std"));
        System.out.println(commandMap.getMap().toString());
        //헤더에 데이터를 실어 보내기위해 json객체로 만듬
        JSONObject jsonObject = new JSONObject(commandMap.getMap());
        //헤더에 데이터를 실는 작업
        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("utf-8");
        headers.setContentType(new MediaType("application", "json", utf8));
        HttpEntity param= new HttpEntity(jsonObject.toString(), headers);
        
        RestTemplate restTemplate = new RestTemplate();
        String result = restTemplate.postForObject("http://localhost:3000/rest/loss/insert", param, String.class);
        
        String lossList = restTemplate.getForObject("http://localhost:3000/rest/loss/list", String.class);
        JSONArray jsonArray = new JSONArray(lossList);
        
        mv.addObject("result", result);
        mv.addObject("lossData", jsonArray.toString());
        
        return mv;
	}
	
	
	@RequestMapping(value="/test/testDetail.do")
	public ModelAndView openTestDetail(CommandMap commandMap, HttpServletRequest request) throws Exception{
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
        String lossList = restTemplate.getForObject("http://localhost:3000/rest/loss/list/"+commandMap.getMap().get("loss_title"), String.class);
        if(lossList != null){
        	result = "success";
        }
        System.out.println(lossList);
        JSONObject jsonObject = new JSONObject(lossList);
        mv.addObject("result", result);
        mv.addObject("lossData", jsonObject.toString());
        
        return mv;
	}
	
	@RequestMapping(value="/test/testLossList.do")
	public ModelAndView openTestLossList(CommandMap commandMap, HttpServletRequest request) throws Exception{
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
        String lossList = restTemplate.getForObject("http://localhost:3000/rest/loss/list", String.class);
        if(lossList != null){
        	result = "success";
        }
        System.out.println(lossList);
        JSONArray jsonArray = new JSONArray(lossList);
        mv.addObject("result", result);
        mv.addObject("lossData", jsonArray.toString());
        
        return mv;
	}
	
	@RequestMapping(value="/test/testFindList.do")
	public ModelAndView openTestFindList(CommandMap commandMap, HttpServletRequest request) throws Exception{
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
        System.out.println(findList);
        JSONArray jsonArray = new JSONArray(findList);
        mv.addObject("result", result);
        mv.addObject("findData", jsonArray.toString());
        
        return mv;
	}
}
