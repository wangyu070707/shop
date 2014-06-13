1:执行create_table.sql建表，执行init_data.sql初始化数据

2.修改tomcat的server.xml文件，加上字符集URIEncoding="UTF-8"

3：将jscnpay-web.war，jscnpay-web-sysadmin.war，jscnpay-web-merchant.war
这三个war包中的WEB-INF/classes/config/database.properties文件的数据库配置改成相应的数据库

4：将jscnpay-web.war包里的WEB-INF/classes/config/tvpay.properties文件中的payReturnHost字段的值
如果是集群部署改成部署jscnpay-web工程nginx的ip和端口号
如果是单机部署改成部署jscnpay-web工程tomcat的ip和端口号

###########以下是上线快钱支付需要修改的配置
5：将jscnpay-web.war包里的WEB-INF/classes/config/bill99.properties文件中的payReturnHost字段的值
改成部署jscnpay-web工程tomcat的ip和端口号

6：将deploy下的pay文件夹拷贝的系统的根目录
