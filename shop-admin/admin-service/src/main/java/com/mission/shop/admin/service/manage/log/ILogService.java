package com.mission.shop.admin.service.manage.log;

import com.mission.shop.admin.dao.entity.manage.log.LogEntity;
import com.mission.shop.admin.exception.ServiceException;
import com.mission.shop.admin.utils.page.Pagination;
import com.mission.shop.admin.utils.persistent.ResultList;

public interface ILogService {

	public static final String SERVICE_NAME = "com/mission/shop/admin/service/manage/log/ILogService";

	public void addLog(LogEntity log) throws ServiceException;

	public LogEntity getLogById(String id) throws ServiceException;

	public ResultList<LogEntity> getLogs(String operatorId,
			String operatorName, String beginTime, String endTime,
			Pagination page) throws ServiceException;

}
