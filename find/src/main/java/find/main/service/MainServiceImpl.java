package find.main.service;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import find.common.utils.FileUtils;

@Service("mainService")
public class MainServiceImpl implements MainService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
    private FileUtils fileUtils;

	@Override
	public Object insertFileData(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
	    Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
	    MultipartFile multipartFile = null;
	    while(iterator.hasNext()){
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        if(multipartFile.isEmpty() == false){
	            log.debug("------------- file start -------------");
	            log.debug("name : "+multipartFile.getName());
	            log.debug("filename : "+multipartFile.getOriginalFilename());
	            //log.debug("size : "+multipartFile.getSize());
	            log.debug("-------------- file end --------------\n");
	        }
	    }
	    if(multipartFile.isEmpty() == false){
		    List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
		    map.put("img_org", list.get(0).get("IMG_ORG"));
		    map.put("img_std", list.get(0).get("IMG_STD"));
		    //map.put("fileFileSize", list.get(0).get("FILE_SIZE"));
	    }
		
		return map;
	}
}
