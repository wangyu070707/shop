package com.mission.shop.admin.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mission.shop.admin.dao.entity.news.NewsEntity;
import com.mission.shop.admin.dao.mapper.news.INewsMapper;
import com.mission.shop.admin.exception.ServiceException;
import com.mission.shop.admin.service.INewsService;
import com.mission.shop.admin.utils.log.JscnLogger;
import com.mission.shop.admin.utils.page.Pagination;
import com.mission.shop.admin.utils.persistent.QueryCondition;
import com.mission.shop.admin.utils.persistent.ResultList;
import com.mission.shop.admin.utils.persistent.ResultListImpl;
import com.mission.shop.base.common.utils.StringUtils;

@Service(value = INewsService.SERVICE_NAME)
public class NewsServiceImpl implements INewsService {

	@Autowired
	private INewsMapper newsMapper;

	@Override
	public NewsEntity getNews(String id) throws ServiceException {
		try {
			QueryCondition condition = new QueryCondition();
			condition.addAllColumn(NewsEntity.class);
			condition.addCondition("id", id);
			return newsMapper.getNews(condition);
		} catch (Exception e) {
			JscnLogger.error("获得新闻列表信息错误", e, this.getClass());
			throw new ServiceException("获得新闻列表信息错误", e);
		}
	}

	@Override
	public void addNews(NewsEntity entity) throws ServiceException {
		try {
			newsMapper.insertNews(entity);
		} catch (Exception e) {
			JscnLogger.error("新增新闻列表信息错误", e, this.getClass());
			throw new ServiceException("新增新闻列表信息错误", e);
		}
	}

	@Override
	public void updateNews(NewsEntity entity) throws ServiceException {
		try {
			newsMapper.updateNews(entity);
		} catch (Exception e) {
			JscnLogger.error("更新新闻列表信息错误", e, this.getClass());
			throw new ServiceException("更新新闻列表信息错误", e);
		}
	}

	@Override
	public void deleteNews(String id) throws ServiceException {
		try {
			newsMapper.deleteNews(id);
		} catch (Exception e) {
			JscnLogger.error("删除新闻列表信息错误", e, this.getClass());
			throw new ServiceException("删除新闻列表信息错误", e);
		}
	}

	@Override
	public ResultList<NewsEntity> queryNews(String title, String newsType, Pagination page, Set<String> columns)
			throws ServiceException {
		try {
			QueryCondition condition = new QueryCondition();
			if (columns != null && columns.size() > 0) {
				condition.setColumns(columns);
			} else {
				condition.addAllColumn(NewsEntity.class);
			}
			if (StringUtils.isNotEmpty(title)) {
				condition.addCondition("title", title);
			}
			if (StringUtils.isNotEmpty(newsType)) {
				condition.addCondition("newsType", newsType);
			}
			if (page != null) {
				Long totalCount = newsMapper.countNews(condition);
				page.setTotalCount(totalCount.intValue());
				condition.addCondition("minnum", page.getStartNo());
				condition.addCondition("maxnum", page.getEndNo());
			}
			List<NewsEntity> list = newsMapper.queryNews(condition);
			ResultList<NewsEntity> res = new ResultListImpl<NewsEntity>();
			res.setResults(list);
			res.setPage(page);
			return res;
		} catch (Exception e) {
			JscnLogger.error("查询新闻列表信息错误", e, this.getClass());
			throw new ServiceException("查询新闻列表信息错误", e);
		}
	}
}
