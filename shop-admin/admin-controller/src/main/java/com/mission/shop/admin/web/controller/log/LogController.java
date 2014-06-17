package com.mission.shop.admin.web.controller.log;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mission.shop.admin.dao.entity.manage.log.LogEntity;
import com.mission.shop.admin.exception.ServiceException;
import com.mission.shop.admin.service.manage.log.ILogService;
import com.mission.shop.admin.utils.exception.WebException;
import com.mission.shop.admin.utils.log.JscnLogger;
import com.mission.shop.admin.utils.page.Pagination;
import com.mission.shop.admin.utils.persistent.ResultList;
import com.mission.shop.admin.web.controller.BaseController;
import com.mission.shop.base.common.utils.StringUtils;

@Controller
@RequestMapping("/log")
public class LogController extends BaseController {

	@Autowired
	private ILogService logService;

	/***
	 * 根据ID查详细
	 * 
	 * @param id ID
	 * @param model 模型
	 * @return 返回
	 * @throws WebException 异常
	 */
	@RequestMapping("getlogbyid")
	public String getLogById(String id, ModelMap model) throws WebException {
		try {
			LogEntity log = logService.getLogById(id);
			if (log != null) {
				model.addAttribute("log", log);
			}
		} catch (ServiceException e) {
			throw new ServiceException(e);
		}
		return "page/main/log/loginfo";
	}

	/***
	 * 添加日志
	 * 
	 * @return 返回
	 * @throws WebException 异常
	 */
	@RequestMapping("addlogs")
	public String getLogById() throws WebException {
		try {
			for (int i = 0; i < 5000; i++) {
				LogEntity log = new LogEntity();
				log.setId(StringUtils.getUUID());
				log.setOperatorId("admin");
				log.setOperatorName("管理员");
				log.setTime(new java.util.Date());
				log.setContent("测试500000");
				log.setIp("192.168.18.119");
				logService.addLog(log);
			}
		} catch (ServiceException e) {
			throw new ServiceException(e);
		}
		return "page/main/log/logList";
	}

	/**
	 * 列表查找
	 * 
	 * @param operatorId 操作ID
	 * @param operatorName 操作姓名
	 * @param beginTime 开始时间
	 * @param endTime 结束时间
	 * @param request 请求
	 * @param response 回应
	 * @param model 模型
	 * @param page 分页
	 * @return 返回
	 * @throws WebException Web异常
	 */
	@RequestMapping("querylogs")
	public String queryLogs(String operatorId, String operatorName,
			String beginTime, String endTime, HttpServletRequest request,
			HttpServletResponse response, ModelMap model, Pagination page)
			throws WebException {
		try {
			ResultList<LogEntity> log = logService.getLogs(operatorId,
					operatorName, beginTime, endTime, page);
			model.addAttribute("log", log);
			model.addAttribute("operatorId", operatorId);
			model.addAttribute("operatorName", operatorName);
			model.addAttribute("beginTime", beginTime);
			model.addAttribute("endTime", endTime);
		} catch (ServiceException e) {
			JscnLogger.error("查询日志信息失败！异常：" + e.getMessage(), this.getClass());
			throw new WebException("查询日志信息失败！异常：" + e);
		}
		return "page/main/log/logList";
	}
}
