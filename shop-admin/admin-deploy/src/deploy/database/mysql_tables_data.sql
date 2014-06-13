
DROP TABLE coupon;
DROP TABLE merchant;
DROP TABLE merchant_type;
DROP TABLE news;
DROP TABLE sys_log;
DROP TABLE sys_menu;
DROP TABLE sys_menu_role;
DROP TABLE sys_operator;
DROP TABLE sys_role;
DROP TABLE user_web;
DROP TABLE website_list;
DROP TABLE sys_operator_role;

create table SYS_MENU
(
  code           VARCHAR(15) not null,
  title          VARCHAR(30) not null,
  url            VARCHAR(200),
  parent_code    VARCHAR(15) not null,
  menu_level     int not null,
  children_count int not null,
  display_num    int not null
)
;
alter table SYS_MENU
  add constraint PK_SYS_MENU primary key (CODE);

create table SYS_MENU_ROLE
(
  id        VARCHAR(32) not null,
  menu_code VARCHAR(15) not null,
  role_code VARCHAR(20) not null
)
;
alter table SYS_MENU_ROLE
  add constraint PK_SYS_MENU_ROLE primary key (ID);

create table SYS_OPERATOR
(
  operator_id VARCHAR(20) not null,
  password    VARCHAR(50) not null,
  name        VARCHAR(50) not null,
  mobile_num  VARCHAR(15),
  tele_num    VARCHAR(15),
  email       VARCHAR(30),
  status      VARCHAR(20),
  job_name    VARCHAR(40),
  remark      VARCHAR(100),
  last_time   VARCHAR(20),
  last_ip     VARCHAR(20)
)
;
alter table SYS_OPERATOR
  add constraint PK_SYS_OPERATOR primary key (OPERATOR_ID);

create table SYS_OPERATOR_ROLE
(
  id          VARCHAR(32) not null,
  operator_id VARCHAR(20) not null,
  role_code   VARCHAR(20) not null
)
;
create unique index PK_OPERATOR_ROLE on SYS_OPERATOR_ROLE (ID);
alter table SYS_OPERATOR_ROLE
  add constraint PK_SYS_OPERATOR_ROLE primary key (ID);

create table SYS_ROLE
(
  code   VARCHAR(20) not null,
  title  VARCHAR(50) not null,
  remark VARCHAR(100)
)
;
alter table SYS_ROLE
  add constraint PK_SYS_ROLE primary key (CODE);

create table SYS_LOG
(
  id   VARCHAR(32) not null,
  operator_id  VARCHAR(20) not null,
  operator_name VARCHAR(50) not null,
  time VARCHAR(20)  not null,
  content VARCHAR(2000) not null,
  ip VARCHAR(20) not null
)
;
alter table SYS_LOG
  add constraint PK_SYS_LOG primary key (ID);
##新闻中心
create table NEWS(
	id   VARCHAR(32) primary key not null ,
	createTime VARCHAR(20) NOT NULL,#创建时间
	happenTime varchar(20) not null,#发生时间
	title varchar(100) not null,#新闻标题
	fromWhere varchar(50),#新闻来源
	newsType varchar(2) not null,#新闻类型 新沂要闻 | 区县\部门动态 | 国内要闻 | 国际要闻
	reporter varchar(20),#报道者
	isactive int,
	content blob #内容
);

#商家分类
create table merchant_type(
	id varchar(32) not null primary key,
	name varchar(50) not null,
	is_active int default 1,#是否激活 默认是激活的
	show_pic varchar(50)
);
#商家
create table merchant (
	id varchar(32) not null primary key,
	merchant_type_id varchar(32),
	merchant_type_name varchar(50),
	name varchar(50) not null,
	address varchar(100) not null,
	logo varchar(50) not null,
	is_lock int default 0,#是否锁定 默认不锁定
	feature varchar(100),#特色
	per_fee varchar(6),#人均消费
	open_time varchar(20),#营业时间
	create_time varchar(20),#创建时间
	is_join int default 1,#是否加盟 默认已加盟
	service varchar(50),#服务配套 有停车场
	order_phone varchar(20),#预定热线
	introduce varchar(200),#商家介绍
	pop_pic1 varchar(50),#展示图片
	pop_pic2 varchar(50),
	pop_pic3 varchar(50),
	pop_pic4 varchar(50),
	FOREIGN key (merchant_type_id) REFERENCES merchant_type(id)
);
#优惠券http://nanjing.checkoo.com/
create table coupon(
	id varchar(32) not null primary key,
	merchant_id varchar(32),
	merchant_name varchar(50),
	is_recommend int default 0,#是否是推荐的 默认不是
	name varchar(50) not null,
	end_time varchar(20),#优惠截止
	use_address varchar(100) not null,#使用地址
	introduce varchar(200),#商介绍
	show_pic varchar(50),
	FOREIGN key (merchant_id) REFERENCES merchant(id) on delete CASCADE
);


#圈子
create table groups(
 id varchar(32) not null primary key,
 
);

#Web 用户
create table user_web(
	id varchar(32) not null primary key,
	email varchar(32) not null,
	password varchar(32) not null,
	show_name varchar(15),#系统显示名称
	sex int default 2,#默认是2:保密 0表示女 1：标识男
	head_photo  varchar(32),
	status int default 1,#0:正常用户，1：锁定用户(未激活)， 2：封号，3：锁三天
	mobile  varchar(20),
	regest_time varchar(20),#注册时间
	prelogin_time varchar(20),#上次登录时间
	id_card varchar(20),#身份证
	birthday varchar(15),#生日自动带出来 年龄 星座 生肖
	age int default 0,
	zodiac varchar(15),#生肖
	constellation varchar(15),#星座
	signature varchar(30),#个性签名
	address varchar(30),# 新沂->棋盘->西夏村—————— 类型的 
	answer_id varchar(2),#密码提示 密码找回对应的题目ID
	answer_result varchar(30)#对应的答案
);


#网站维护表
create table website_list(
	id varchar(32) not null primary key,
	name varchar(32) not null,#网站名称
	address varchar(100) not null,#网站网址
	logo varchar(50) not null#网站logo
);
#网站参数配置表
create table website_param(
	id varchar(32) not null primary key,
	website_id varchar(32) not null,
	url varchar(300) not null,#网站视频的url
	title_sign varchar(10) ,#截取获得视频title的字符
	pic_id varchar(50),#获取缩略图的ID
	pic_id_value varchar(300),#根据缩略图的ID 取其属性 如：value
	pic_id_value_sign varchar(50),#根据缩略图ID获取的属性值 里面的键
	pic_class varchar(50),#获得缩略图的Class
	pic_class_value varchar(300),#根据缩略图的Class取其属性 如：value
	pic_class_value_sign varchar(50),#根据缩略图Class获取的属性值 里面的键
	video_id varchar(50),#获取视频的ID
	video_id_value varchar(300),#根据视频的ID 取其属性 如：value
	video_class varchar(50),#获得视频的Class
	video_class_value varchar(300),#根据视频的Class取其属性 如：value
	video_form varchar(20) ,#视频格式
	video_code_id varchar(50),#获得视频的HTML代码
	video_code_value varchar(300),#根据视频的HTML代码取其属性 如：value
	video_time_id varchar(50),#获得视频的时长ID
	video_time_value varchar(300),#根据视频的时长取其属性 如：value
	video_desc varchar(500) ,#视频介绍
	flag int default 1;# 0:禁用 1：启用
	FOREIGN key (website_id) REFERENCES website_list(id) on delete CASCADE
);




##初始化数据
insert into SYS_MENU (code, title, url, parent_code, menu_level, children_count, display_num)
values ('ZFJL', '交易记录', '/record/search.htm', 'ZFPTGL', 2, 0, 2);
insert into SYS_MENU (code, title, url, parent_code, menu_level, children_count, display_num)
values ('ZFYHGL', '支付银行管理', '/bank/search.htm', 'XTGL', 2, 0, 6);
insert into SYS_MENU (code, title, url, parent_code, menu_level, children_count, display_num)
values ('ZFPTGL', '支付平台管理', null, '0', 1, 4, 1);
insert into SYS_MENU (code, title, url, parent_code, menu_level, children_count, display_num)
values ('THGL', '退货管理', '/refund/search.htm', 'ZFPTGL', 2, 0, 4);
insert into SYS_MENU (code, title, url, parent_code, menu_level, children_count, display_num)
values ('XTGL', '系统管理', null, '0', 1, 7, 5);
insert into SYS_MENU (code, title, url, parent_code, menu_level, children_count, display_num)
values ('SZMX', '收支明细', '/item/search.htm', 'ZFPTGL', 2, 0, 3);
insert into SYS_MENU (code, title, url, parent_code, menu_level, children_count, display_num)
values ('SHGL', '商户管理', '/merchant/search.htm', 'XTGL', 2, 0, 7);
insert into SYS_MENU (code, title, url, parent_code, menu_level, children_count, display_num)
values ('XTRZ', '系统操作日志', '/log/querylogs.htm', 'XTGL', 2, 0, 9);
insert into SYS_MENU (code, title, url, parent_code, menu_level, children_count, display_num)
values ('GNCDGL', '功能菜单管理', '/menu/querymenus.htm', 'XTGL', 2, 0, 3);
insert into SYS_MENU (code, title, url, parent_code, menu_level, children_count, display_num)
values ('QXZGL', '权限组管理', '/rolegl/queryroles.htm', 'XTGL', 2, 0, 5);
insert into SYS_MENU (code, title, url, parent_code, menu_level, children_count, display_num)
values ('CZYGL', '操作员管理', '/operator/searchoperators.htm', 'XTGL', 2, 0, 1);
INSERT INTO sys_menu (code,title,url,parent_code,menu_level,children_count,display_num) 
VALUES ('YHJGL','优惠劵管理','/coupon/search.htm','XTGL',2,0,9);
INSERT INTO sys_menu (code,title,url,parent_code,menu_level,children_count,display_num) 
VALUES ('SHLXGL','商户类型管理','/type/search.htm','XTGL',2,0,8);
INSERT INTO sys_menu (code,title,url,parent_code,menu_level,children_count,display_num) 
VALUES ('WZGL','网站管理','','WZPCGL',2,0,1);
INSERT INTO sys_menu (code,title,url,parent_code,menu_level,children_count,display_num) 
VALUES ('WZPCGL','网站爬虫管理','','0',1,2,1);
INSERT INTO sys_menu (code,title,url,parent_code,menu_level,children_count,display_num) 
VALUES ('CSPZGL','参数配置管理','','WZPCGL',2,0,2);

commit;

insert into SYS_ROLE (code, title, remark)
values ('ROLE_ADMIN', '系统管理员组', '系统管理员组');
commit;

insert into SYS_OPERATOR (operator_id, password, name, mobile_num, tele_num, email, status, job_name, remark, last_time, last_ip)
values ('admin', '21232f297a57a5a743894a0e4a801fc3', '管理员', '133258711111', '025-582144212', null, '1', null, null, '2012-06-03 14:38:18', '127.0.0.1');
commit;

insert into SYS_OPERATOR_ROLE (id, operator_id, role_code)
values ('f9edd715d7b54020bd53fe3a7a30694a', 'admin', 'ROLE_ADMIN');
commit;

insert into SYS_MENU_ROLE (id, menu_code, role_code)
values ('5cc1e7dfb16847ebacaf5e1fdb9d97d2', 'XTGL', 'ROLE_ADMIN');
insert into SYS_MENU_ROLE (id, menu_code, role_code)
values ('25acbb56a06445dfa8be8e402806a39d', 'SHGL', 'ROLE_ADMIN');
insert into SYS_MENU_ROLE (id, menu_code, role_code)
values ('b0045ffa58cc4c45b8144f08b3e230ac', 'ZFYHGL', 'ROLE_ADMIN');
insert into SYS_MENU_ROLE (id, menu_code, role_code)
values ('123385b0d6c441ccbad260db6d5fd33c', 'CZYGL', 'ROLE_ADMIN');
insert into SYS_MENU_ROLE (id, menu_code, role_code)
values ('aa7b518f995e47a5a774a3cb63d543a4', 'XTRZ', 'ROLE_ADMIN');
insert into SYS_MENU_ROLE (id, menu_code, role_code)
values ('0a074274109543f9968bfd5ceb1384ea', 'GNCDGL', 'ROLE_ADMIN');
insert into SYS_MENU_ROLE (id, menu_code, role_code)
values ('0b14caabd19b409fb7da61d90740f2ca', 'QXZGL', 'ROLE_ADMIN');
insert into SYS_MENU_ROLE (id, menu_code, role_code)
values ('db8d73234c904925908be21f263df8a1', 'ZFPTGL', 'ROLE_ADMIN');
insert into SYS_MENU_ROLE (id, menu_code, role_code)
values ('d0b680d37118462e8eef9f2b27b46354', 'THGL', 'ROLE_ADMIN');
insert into SYS_MENU_ROLE (id, menu_code, role_code)
values ('beb0c823c8184b9abf12b193cf27a4ee', 'SZMX', 'ROLE_ADMIN');
insert into SYS_MENU_ROLE (id, menu_code, role_code)
values ('053fa39d74bc405aa9bd083d99ea17d9', 'ZFJL', 'ROLE_ADMIN');
commit;

## 前端http://localhost:8081/fuwu58-web/
## 后台http://localhost:8081/fuwu58-web-sysadmin/