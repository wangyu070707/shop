package com.mission.shop.admin.service.manage.role;

import java.util.List;

import com.mission.shop.admin.dao.entity.manage.role.MenuEntity;
import com.mission.shop.admin.dao.manage.model.role.MenuRoleModel;
import com.mission.shop.admin.exception.ServiceException;
import com.mission.shop.admin.utils.persistent.ResultList;

public interface IMenuRoleService {

	public static final String SERVICE_NAME = "com/jscn/pay/service/manage/role/IMenuRoleService";

	public ResultList<MenuEntity> queryUserMenus(String operatorId,
			String parentCode) throws ServiceException;

	public ResultList<MenuRoleModel> queryCheckMenus(String roleId,
			String parentCode) throws ServiceException;

	public void addMenuToRole(String roleCode, String[] menuIds)
			throws ServiceException;

	public List<MenuEntity> queryMenuRoles(String roleCode) throws ServiceException;

}
