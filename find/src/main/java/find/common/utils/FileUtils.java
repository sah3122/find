package find.common.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component("fileUtils")
public class FileUtils {
	private static final String imgFilePath = "C:\\Users\\Administrator\\git\\find\\find\\src\\main\\webapp\\images\\find\\";
	private static final String filePath = "C:\\dev\\find\\file\\";
	@Value("#{props['common.serverIp']}")
	private String svrIp;
	@Value("#{props['common.serverUser']}")
    private String user;
	@Value("#{props['common.serverPasswd']}")
    private String passwd;
	@Value("#{props['common.strPath']}")
    private String strPath;
    
    public List<Map<String,Object>> parseInsertFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;
         
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
         
        File file = new File(imgFilePath);
        if(file.exists() == false){
            file.mkdirs();
        }
         
        while(iterator.hasNext()){
            multipartFile = multipartHttpServletRequest.getFile(iterator.next());
                            
            if(multipartFile.isEmpty() == false){
                originalFileName = multipartFile.getOriginalFilename();
                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                storedFileName = CommonUtils.getRandomString() + originalFileExtension;
                
                file = new File(imgFilePath + storedFileName);
                multipartFile.transferTo(file);
                
                //#####
                //저장할 파일을 target에 넣은 부분은 생략(각자 환경에 맞게 파일을 읽어서 넣어주시면 됩니다.)
    			/*FtpClient ftp_ivr = new FtpClient(svrIp, user, passwd,strPath);
    			
                file = new File(imgFilePath + storedFileName);
                multipartFile.transferTo(file);
                
                boolean result = ftp_ivr.upload(file);
                System.out.println("FTP result : " + result);
              //#####
                SftpClient sftpClient = new SftpClient();
                
                sftpClient.init(svrIp, user, passwd, 22);
                sftpClient.upload(strPath, file);
                
                sftpClient.disconnection();*/
                //#####
                System.out.println("serverip : " + svrIp + " username : " + user + " userpass : " + passwd + " strPath : " + strPath);
                SftpClient sftpClient = new SftpClient();
                sftpClient.upload(svrIp, user, passwd, "22", strPath, storedFileName, file);
                //#####
                
                listMap = new HashMap<String,Object>();
                listMap.put("LOSS_IMG_ORG", originalFileName);
                listMap.put("LOSS_IMG_STD", storedFileName);
                //listMap.put("FILE_SIZE", multipartFile.getSize());
                list.add(listMap);
            }
        }
        return list;
    }
}
