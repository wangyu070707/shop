package com.mission.shop.product.service.base;

import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * User: hexizheng
 * Date: 13-9-15
 * Time: 
 */


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:trans-service-test.xml"})
public abstract class ProductServiceTestBase extends AbstractTransactionalJUnit4SpringContextTests{
    private String sqlFile;
    
    protected final String CONTEXT = "sql/";

    public abstract String getSqlFilePath();
    @Before
    public void init() {
        sqlFile = getSqlFilePath();
        if (sqlFile != null) {
            executeSqlScript(sqlFile, false);
        }
    }

}