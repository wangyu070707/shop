package com.mission.shop.product.controller.category;

import java.util.List;

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
	
    private  final Logger     logger = LoggerFactory.getLogger(getClass());

    
    
	@RequestMapping("index")
	public String index(Model model){
		
		try{
			Category catetory = categoryService.queryTopCategory();
			List<Category> list = categoryService.queryCategoryByParent(catetory.getCatId());
		}catch(BusinessException e){
			
			return "common/error";
		}
		
		model.addAttribute("test","test11");
		model.addAttribute("catetory",catetory);
		model.addAttribute("test","test11");
		return "category/index";
	}
}
