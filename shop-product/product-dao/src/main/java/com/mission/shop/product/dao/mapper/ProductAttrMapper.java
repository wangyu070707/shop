package com.mission.shop.product.dao.mapper;

import com.mission.shop.product.dao.model.ProductAttr;
import com.mission.shop.product.dao.model.ProductAttrExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ProductAttrMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product_attr
	 * @mbggenerated  Mon Jun 16 13:18:26 CST 2014
	 */
	int countByExample(ProductAttrExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product_attr
	 * @mbggenerated  Mon Jun 16 13:18:26 CST 2014
	 */
	int deleteByExample(ProductAttrExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product_attr
	 * @mbggenerated  Mon Jun 16 13:18:26 CST 2014
	 */
	int deleteByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product_attr
	 * @mbggenerated  Mon Jun 16 13:18:26 CST 2014
	 */
	int insert(ProductAttr record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product_attr
	 * @mbggenerated  Mon Jun 16 13:18:26 CST 2014
	 */
	int insertSelective(ProductAttr record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product_attr
	 * @mbggenerated  Mon Jun 16 13:18:26 CST 2014
	 */
	List<ProductAttr> selectByExample(ProductAttrExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product_attr
	 * @mbggenerated  Mon Jun 16 13:18:26 CST 2014
	 */
	ProductAttr selectByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product_attr
	 * @mbggenerated  Mon Jun 16 13:18:26 CST 2014
	 */
	int updateByExampleSelective(@Param("record") ProductAttr record,
			@Param("example") ProductAttrExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product_attr
	 * @mbggenerated  Mon Jun 16 13:18:26 CST 2014
	 */
	int updateByExample(@Param("record") ProductAttr record,
			@Param("example") ProductAttrExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product_attr
	 * @mbggenerated  Mon Jun 16 13:18:26 CST 2014
	 */
	int updateByPrimaryKeySelective(ProductAttr record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table product_attr
	 * @mbggenerated  Mon Jun 16 13:18:26 CST 2014
	 */
	int updateByPrimaryKey(ProductAttr record);
}