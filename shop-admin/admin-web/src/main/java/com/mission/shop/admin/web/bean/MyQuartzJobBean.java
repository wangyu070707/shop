package com.mission.shop.admin.web.bean;

import java.lang.reflect.Method;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class MyQuartzJobBean extends QuartzJobBean
		implements
			ApplicationContextAware {

	private String quartzJob;

	private String targetMethod;

	private ApplicationContext ctx;

	public ApplicationContext getCtx() {
		return ctx;
	}

	public void setCtx(ApplicationContext ctx) {
		this.ctx = ctx;
	}

	public String getQuartzJob() {
		return quartzJob;
	}

	public void setQuartzJob(String quartzJob) {
		this.quartzJob = quartzJob;
	}

	public String getTargetMethod() {
		return targetMethod;
	}

	public void setTargetMethod(String targetMethod) {
		this.targetMethod = targetMethod;
	}

	@Override
	protected void executeInternal(JobExecutionContext jobexecutioncontext)
			throws JobExecutionException {
		try {
			Object otargetObject = ctx.getBean(quartzJob);
			Method m = null;
			try {
				m = otargetObject.getClass().getMethod(targetMethod,
						new Class[]{});
				m.invoke(otargetObject, new Object[]{});
			} catch (SecurityException e) {
			} catch (NoSuchMethodException e) {
			}
		} catch (Exception e) {
			throw new JobExecutionException(e);
		}
	}

	@Override
	public void setApplicationContext(ApplicationContext ctx)
			throws BeansException {
		this.ctx = ctx;
	}

}
