package com.mission.shop.view.user.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.mission.shop.base.common.threadlocal.CurrentUser;
import com.mission.shop.base.common.threadlocal.ThreadLocalUtils;
import com.mission.shop.user.dao.model.User;

/**
 * @title 自动设置threadlocal中的变量过滤器
 * @description

 */

public class AutoSetThreadLocalVariableFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;

        // 获取当前登录用户
        User user = (User) req.getSession().getAttribute("SESSION_USER");

        CurrentUser currentUser = new CurrentUser();
        currentUser.setIp(getIp(req));
        if (user != null) {
            currentUser.setUserId(user.getUserId());
            currentUser.setUserName(user.getUserName());
        } 
        ThreadLocalUtils.setCurrentUser(currentUser);
        ThreadLocalUtils.setUser(user);
        chain.doFilter(request, response);
    }

    private String getIp(HttpServletRequest httpRequest) {
        // 获取用户登录IP
        String ip = httpRequest.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = httpRequest.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = httpRequest.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = httpRequest.getRemoteAddr();
        }
        return ip;
    }

    @Override
    public void destroy() {

    }

}
