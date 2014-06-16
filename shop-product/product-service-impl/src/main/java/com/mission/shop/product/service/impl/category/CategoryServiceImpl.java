package com.mission.shop.product.service.impl.category;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mission.shop.base.common.exception.BusinessException;
import com.mission.shop.product.dao.mapper.CategoryMapper;
import com.mission.shop.product.dao.model.Category;
import com.mission.shop.product.dao.model.CategoryExample;
import com.mission.shop.product.service.category.CategoryService;

/**
 * 
 * @author hexizheng@163.com
 * 
 */
@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryMapper categoryMapper;

	@Override
	public Category queryTopCategory() throws BusinessException {
		CategoryExample example = new CategoryExample();
		example.createCriteria().andLevelEqualTo(0).andStatusEqualTo(1000);
		example.setOrderByClause(" order by sort_order ");
		List<Category> list = categoryMapper.selectByExample(example);
		if(list.isEmpty()){
			throw new BusinessException("顶层商品分类为空");
		}else if(list.size()>1){
			throw new BusinessException("数据逻辑出错同时存在多个顶层分类");
		}else{
			return list.get(0);
		}
	}

	@Override
	public List<Category> queryCategoryByParent(Long parentId) {
		CategoryExample example = new CategoryExample();
		example.createCriteria().andParentIdEqualTo(parentId)
		.andStatusEqualTo(1000);
		example.setOrderByClause(" order by sort_order ");
		return categoryMapper.selectByExample(example);
	}

	@Override
	public void addCatetories(List<Category> list) throws BusinessException {
		// TODO Auto-generated method stub

	}

}
