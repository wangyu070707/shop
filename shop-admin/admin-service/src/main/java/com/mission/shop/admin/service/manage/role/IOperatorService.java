package com.mission.shop.admin.service.manage.role;

import com.mission.shop.admin.dao.entity.manage.role.OperatorEntity;
import com.mission.shop.admin.exception.ServiceException;
import com.mission.shop.admin.utils.page.Pagination;
import com.mission.shop.admin.utils.persistent.ResultList;
import com.mission.shop.base.common.exception.SystemException;

public interface IOperatorService {

	public static final String SERVICE_NAME = "com/jscn/pay/service/manage/role/IOperatorService";
	
	/**
	 *添加操作员信息 
	 * **/
	public void addOperator(OperatorEntity operator,String[] roleCode) throws ServiceException;

	/**
	 *根据条件查询操作员信息
	 * **/
	public ResultList<OperatorEntity> queryOperators(String operatorId,
			String name,String status, Pagination page) throws ServiceException;
	
	/**
	 * 根据账号名查询操作员信息
	 * */
	public OperatorEntity getOperatorById(String operatorId) throws ServiceException;


	/**
	 * 修改操作员信息
	 * */
	
	public void modifyOperator(OperatorEntity operator)throws ServiceException;
	

	/**
	 * 修改操作员密码
	 * */
	
	public void modifyOperatorPwd(String operatorId, String password,
			String oldPassword)throws ServiceException, SystemException;

	/**
	 * 根据ID删除操作员信息
	 * */
	public void deleteOperator(String operatorId)throws ServiceException;
	

	/**
	 * 删除已选的操作员信息
	 * */
	public void deleteOperators(String[] ids)throws ServiceException;
	
}
