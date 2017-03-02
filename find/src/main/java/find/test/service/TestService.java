package find.test.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface TestService {
	public Object insertFileData(Map<String, Object> map, HttpServletRequest request) throws Exception;
}
