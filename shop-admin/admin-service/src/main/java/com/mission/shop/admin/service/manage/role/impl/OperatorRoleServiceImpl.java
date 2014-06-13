package com.mission.shop.admin.service.manage.role.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mission.shop.admin.dao.entity.manage.role.OperatorEntity;
import com.mission.shop.admin.dao.entity.manage.role.OperatorRoleEntity;
import com.mission.shop.admin.dao.mapper.manage.role.IOperatorRoleMapper;
import com.mission.shop.admin.exception.ServiceException;
import com.mission.shop.admin.service.manage.role.IOperatorRoleService;
import com.mission.shop.admin.utils.log.JscnLogger;

@Service(value = IOperatorRoleService.SERVICE_NAME)

public class OperatorRoleServiceImpl implements IOperatorRoleService {
	
	@Autowired
	private IOperatorRoleMapper operatorRoleMapper;
	
	
	@Override
	@Transactional(readOnly=true)
	public List<OperatorEntity> searchOperatorRoles(String roleCode)
			throws ServiceException {
		List<OperatorEntity> operatorRoles=null;
		try {
			operatorRoles = operatorRoleMapper.searchOperatorRoles(roleCode);
		} catch (SQLException e) {
			JscnLogger.error("查询该角色的操作员信息失败", e,this.getClass());
			throw new ServiceException("查询该角色的操作员信息失败",e);
		}
		return operatorRoles;
	}
	@Override
	@Transactional
	public void addOperatorRole(OperatorRoleEntity operatorRole)
			throws ServiceException {
		try {
			operatorRoleMapper.insertOperatorRole(new OperatorRoleEntity[]{operatorRole});
		} catch (SQLException e) {
			JscnLogger.error("添加该角色的操作员信息失败", e,this.getClass());
			throw new ServiceException("添加该角色的操作员信息失败",e);
		}
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<OperatorEntity> searchOperators(String roleCode)
			throws ServiceException {
		List<OperatorEntity> operatorRoles=null;
		try {
			operatorRoles = operatorRoleMapper.searchOperators(roleCode);
		} catch (SQLException e) {
			JscnLogger.error("查询该角色的操作员信息失败", e,this.getClass());
			throw new ServiceException("查询该角色的操作员信息失败",e);
		}
		return operatorRoles;
	}

}
