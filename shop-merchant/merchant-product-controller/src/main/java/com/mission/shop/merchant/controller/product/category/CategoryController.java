package com.mission.shop.merchant.controller.product.category;

import java.util.List;

import com.mission.shop.base.common.exception.BusinessException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mission.shop.product.dao.model.Category;
import com.mission.shop.product.service.category.CategoryService;

@Controller
@RequestMapping("category")
public class CategoryController {
	
	@Autowired
	private CategoryService categoryService;
	
    private  final Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping("index")
	public String index(Model model){
		
		try{
			Category catetory = categoryService.queryTopCategory();
			List<Category> list = categoryService.queryCategoryByParent(catetory.getCatId());
            model.addAttribute("catetory",catetory);
            model.addAttribute("list",list);
		}catch(BusinessException e){
			logger.error("商品分类列表失败",e);
			return "common/error";
		}
		return "page/category/index";
	}
}
