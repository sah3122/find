package find.main.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface MainService {
	public Object insertFileData(Map<String, Object> map, HttpServletRequest request) throws Exception;
}
