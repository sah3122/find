package find.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.commons.vfs2.FileObject;
import org.apache.commons.vfs2.FileSystemException;
import org.apache.commons.vfs2.FileSystemOptions;
import org.apache.commons.vfs2.Selectors;
import org.apache.commons.vfs2.impl.StandardFileSystemManager;
import org.apache.commons.vfs2.provider.sftp.SftpFileSystemConfigBuilder;
import org.codehaus.plexus.util.StringUtils;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

public class SftpClient {

	public void upload(String host, String userName, String password, String port, String remoteFilePath, String strFileName, File file) {
	        if (!file.exists()){
	            System.out.println("파일이 존재하지 않습니다.");
	        }
	        StandardFileSystemManager manager = new StandardFileSystemManager();
	 
	        try {
	            manager.init();
	            // 내 pc 파일 설정
	            FileObject localFile = manager.resolveFile(file.getAbsolutePath());    
	            // SFTP 접속 설정 
	            FileObject remoteFile = manager.resolveFile(createConnectionString(host, port, userName, password, remoteFilePath, strFileName), createDefaultOptions());
	            
	            remoteFile.copyFrom(localFile, Selectors.SELECT_SELF); // 파일 복사
	        } catch (Exception e) {
	        	e.printStackTrace();
	            System.out.println("서버연결에 실패하였습니다.");
	        } finally {
	            manager.close();
	        }
	 
	    }
	 
	    // Establishing connection
	    public static String createConnectionString(String hostName, String hostPort, String username, String password, String remoteFilePath, String strFileName) {
	        if (StringUtils.isNumeric(hostPort)) {
	            hostPort = ":" + hostPort;
	        }
	        String str = String.format("sftp://%s:%s@%s%s/%s/%s", username, password, hostName, hostPort, remoteFilePath, strFileName);
	        System.out.println(str);
	        return str;
	    }
	 
	    // Method to setup default SFTP config:
	    public static FileSystemOptions createDefaultOptions() throws FileSystemException {
	        // Create SFTP options
	        FileSystemOptions opts = new FileSystemOptions();
	        // SSH Key checking
	        SftpFileSystemConfigBuilder.getInstance().setStrictHostKeyChecking(opts, "no");
	        // Root directory set to user home
	        SftpFileSystemConfigBuilder.getInstance().setUserDirIsRoot(opts, true);
	        // Timeout is count by Milliseconds
	        SftpFileSystemConfigBuilder.getInstance().setTimeout(opts, 10000);
	        return opts;
	    }
}
