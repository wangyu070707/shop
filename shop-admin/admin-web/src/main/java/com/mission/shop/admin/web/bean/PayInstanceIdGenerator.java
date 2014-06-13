package com.mission.shop.admin.web.bean;

import java.net.InetAddress;

import org.quartz.SchedulerException;
import org.quartz.spi.InstanceIdGenerator;

import com.mission.shop.admin.utils.log.JscnLogger;

public class PayInstanceIdGenerator implements InstanceIdGenerator {

	@Override
	public String generateInstanceId() throws SchedulerException {
		try {
			return InetAddress.getLocalHost().getHostAddress() + "_"
					+ System.currentTimeMillis();
		} catch (Exception e) {
			JscnLogger.error("Couldn't get host name!", this.getClass());
			return "JSCNPAY_" + System.currentTimeMillis();
		}
	}

}
