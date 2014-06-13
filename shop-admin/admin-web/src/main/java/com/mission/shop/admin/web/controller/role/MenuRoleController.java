package com.mission.shop.admin.web.controller.role;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mission.shop.admin.dao.entity.manage.role.MenuEntity;
import com.mission.shop.admin.dao.manage.model.role.MenuRoleModel;
import com.mission.shop.admin.service.manage.role.IMenuRoleService;
import com.mission.shop.admin.utils.exception.WebException;
import com.mission.shop.admin.utils.log.JscnLogger;
import com.mission.shop.admin.utils.persistent.ResultList;
import com.mission.shop.admin.web.controller.BaseController;
import com.mission.shop.admin.web.security.MyInvocationSecurityMetadataSource;
import com.mission.shop.admin.web.security.UserInfo;

@Controller
@RequestMapping("/role")
public class MenuRoleController extends BaseController {

	@Autowired
	private IMenuRoleService menuRoleService;
	
	@Autowired
	private MyInvocationSecurityMetadataSource source;

	@RequestMapping("getUserMenus")
	public String getUserMenus(String parentCode, HttpServletRequest request,
			ModelMap model) throws WebException {
		try {
			UserInfo userinfo = getUserInfo(request);
			if (userinfo == null) {
				return LOGIN;
			}
			String operatorId = userinfo.getOperator().getOperatorId();
			ResultList<MenuEntity> result = menuRoleService.queryUserMenus(
					operatorId, parentCode);
			model.addAttribute("menus", result.getResults());
			if (parentCode.equals("0")) {
				return "page/main/menu1";
			} else {
				return "page/main/childrenmenu";
			}
		} catch (Exception e) {
			JscnLogger.error("获取用户菜单错误", e, this.getClass());
			throw new WebException("获取用户菜单错误");
		}

	}

	@RequestMapping("getcheckmenus")
	public String getCheckMenus(String roleCode, String parentCode,
			ModelMap model) throws WebException {
		try {
			ResultList<MenuRoleModel> result = menuRoleService.queryCheckMenus(
					roleCode, parentCode);
			model.addAttribute("menus", result.getResults());
			model.addAttribute("roleCode", roleCode);
			if ("0".equals(parentCode)) {
				return "page/main/role/checkmenus";
			} else {
				return "page/main/role/checkchildrenmenus";
			}

		} catch (Exception e) {
			JscnLogger.error("获取用户菜单错误", e, this.getClass());
			throw new WebException("获取用户菜单错误");
		}

	}

	@RequestMapping("addrolemenus")
	public String addRoleMenus(String roleCode, String[] menuIds,
			HttpServletResponse response) throws WebException {
		try {
			menuRoleService.addMenuToRole(roleCode, menuIds);
			source.loadResourceDefine();
			response.sendRedirect("../rolegl/queryroles.htm");
			return null;
		} catch (Exception e) {
			JscnLogger.error("添加用户菜单错误", e, this.getClass());
			throw new WebException("添加用户菜单错误");
		}

	}
}
