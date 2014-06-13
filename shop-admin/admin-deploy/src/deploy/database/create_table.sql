CREATE TABLE qrtz_job_details
  (
    JOB_NAME  VARCHAR2(200) NOT NULL,
    JOB_GROUP VARCHAR2(200) NOT NULL,
    DESCRIPTION VARCHAR2(250) NULL,
    JOB_CLASS_NAME   VARCHAR2(250) NOT NULL, 
    IS_DURABLE VARCHAR2(1) NOT NULL,
    IS_VOLATILE VARCHAR2(1) NOT NULL,
    IS_STATEFUL VARCHAR2(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR2(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (JOB_NAME,JOB_GROUP)
);
CREATE TABLE qrtz_job_listeners
  (
    JOB_NAME  VARCHAR2(200) NOT NULL, 
    JOB_GROUP VARCHAR2(200) NOT NULL,
    JOB_LISTENER VARCHAR2(200) NOT NULL,
    PRIMARY KEY (JOB_NAME,JOB_GROUP,JOB_LISTENER),
    FOREIGN KEY (JOB_NAME,JOB_GROUP) 
	REFERENCES QRTZ_JOB_DETAILS(JOB_NAME,JOB_GROUP)
);
CREATE TABLE qrtz_triggers
  (
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    JOB_NAME  VARCHAR2(200) NOT NULL, 
    JOB_GROUP VARCHAR2(200) NOT NULL,
    IS_VOLATILE VARCHAR2(1) NOT NULL,
    DESCRIPTION VARCHAR2(250) NULL,
    NEXT_FIRE_TIME NUMBER(13) NULL,
    PREV_FIRE_TIME NUMBER(13) NULL,
    PRIORITY NUMBER(13) NULL,
    TRIGGER_STATE VARCHAR2(16) NOT NULL,
    TRIGGER_TYPE VARCHAR2(8) NOT NULL,
    START_TIME NUMBER(13) NOT NULL,
    END_TIME NUMBER(13) NULL,
    CALENDAR_NAME VARCHAR2(200) NULL,
    MISFIRE_INSTR NUMBER(2) NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (JOB_NAME,JOB_GROUP) 
	REFERENCES QRTZ_JOB_DETAILS(JOB_NAME,JOB_GROUP) 
);
CREATE TABLE qrtz_simple_triggers
  (
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    REPEAT_COUNT NUMBER(7) NOT NULL,
    REPEAT_INTERVAL NUMBER(12) NOT NULL,
    TIMES_TRIGGERED NUMBER(10) NOT NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP) 
	REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_cron_triggers
  (
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    CRON_EXPRESSION VARCHAR2(120) NOT NULL,
    TIME_ZONE_ID VARCHAR2(80),
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP) 
	REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_blob_triggers
  (
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    BLOB_DATA BLOB NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP) 
        REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_trigger_listeners
  (
    TRIGGER_NAME  VARCHAR2(200) NOT NULL, 
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    TRIGGER_LISTENER VARCHAR2(200) NOT NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_LISTENER),
    FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP) 
	REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_calendars
  (
    CALENDAR_NAME  VARCHAR2(200) NOT NULL, 
    CALENDAR BLOB NOT NULL,
    PRIMARY KEY (CALENDAR_NAME)
);
CREATE TABLE qrtz_paused_trigger_grps
  (
    TRIGGER_GROUP  VARCHAR2(200) NOT NULL, 
    PRIMARY KEY (TRIGGER_GROUP)
);
CREATE TABLE qrtz_fired_triggers 
  (
    ENTRY_ID VARCHAR2(95) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    IS_VOLATILE VARCHAR2(1) NOT NULL,
    INSTANCE_NAME VARCHAR2(200) NOT NULL,
    FIRED_TIME NUMBER(13) NOT NULL,
    PRIORITY NUMBER(13) NOT NULL,
    STATE VARCHAR2(16) NOT NULL,
    JOB_NAME VARCHAR2(200) NULL,
    JOB_GROUP VARCHAR2(200) NULL,
    IS_STATEFUL VARCHAR2(1) NULL,
    REQUESTS_RECOVERY VARCHAR2(1) NULL,
    PRIMARY KEY (ENTRY_ID)
);
CREATE TABLE qrtz_scheduler_state 
  (
    INSTANCE_NAME VARCHAR2(200) NOT NULL,
    LAST_CHECKIN_TIME NUMBER(13) NOT NULL,
    CHECKIN_INTERVAL NUMBER(13) NOT NULL,
    PRIMARY KEY (INSTANCE_NAME)
);
CREATE TABLE qrtz_locks
  (
    LOCK_NAME  VARCHAR2(40) NOT NULL, 
    PRIMARY KEY (LOCK_NAME)
);
INSERT INTO qrtz_locks values('TRIGGER_ACCESS');
INSERT INTO qrtz_locks values('JOB_ACCESS');
INSERT INTO qrtz_locks values('CALENDAR_ACCESS');
INSERT INTO qrtz_locks values('STATE_ACCESS');
INSERT INTO qrtz_locks values('MISFIRE_ACCESS');
create index idx_qrtz_j_req_recovery on qrtz_job_details(REQUESTS_RECOVERY);
create index idx_qrtz_t_next_fire_time on qrtz_triggers(NEXT_FIRE_TIME);
create index idx_qrtz_t_state on qrtz_triggers(TRIGGER_STATE);
create index idx_qrtz_t_nft_st on qrtz_triggers(NEXT_FIRE_TIME,TRIGGER_STATE);
create index idx_qrtz_t_volatile on qrtz_triggers(IS_VOLATILE);
create index idx_qrtz_ft_trig_name on qrtz_fired_triggers(TRIGGER_NAME);
create index idx_qrtz_ft_trig_group on qrtz_fired_triggers(TRIGGER_GROUP);
create index idx_qrtz_ft_trig_nm_gp on qrtz_fired_triggers(TRIGGER_NAME,TRIGGER_GROUP);
create index idx_qrtz_ft_trig_volatile on qrtz_fired_triggers(IS_VOLATILE);
create index idx_qrtz_ft_trig_inst_name on qrtz_fired_triggers(INSTANCE_NAME);
create index idx_qrtz_ft_job_name on qrtz_fired_triggers(JOB_NAME);
create index idx_qrtz_ft_job_group on qrtz_fired_triggers(JOB_GROUP);
create index idx_qrtz_ft_job_stateful on qrtz_fired_triggers(IS_STATEFUL);
create index idx_qrtz_ft_job_req_recovery on qrtz_fired_triggers(REQUESTS_RECOVERY);
commit;

create table PAY_BANK
(
  id            VARCHAR2(32) not null,
  code          VARCHAR2(10) not null,
  name          VARCHAR2(20) not null,
  pay_type      NUMBER(2) not null,
  rate          NUMBER(6,2),
  is_debit      NUMBER(1) not null,
  is_credit     NUMBER(1) not null,
  is_enterpise  NUMBER(1) not null,
  logo_path     VARCHAR2(200),
  web_site      VARCHAR2(200) not null,
  remark        VARCHAR2(500),
  dispaly_order NUMBER(2),
  is_active     NUMBER(1) default 1 not null
)
;

alter table PAY_BANK
  add constraint PK_PAY_BANK primary key (ID);

create table PAY_BUSINESS
(
  id       VARCHAR2(20) not null,
  password VARCHAR2(50),
  name     VARCHAR2(100) not null,
  site     VARCHAR2(100),
  remark   VARCHAR2(200),
  key      VARCHAR2(20),
  scale    NUMBER(6,6)
)
;
alter table PAY_BUSINESS
  add constraint PK_PAY_BUSINESS primary key (ID);


create table PAY_MESSAGE
(
  id            VARCHAR2(32) not null,
  flow          NUMBER(1) not null,
  content	CLOB,  
  message_time  DATE not null,
  pay_type      NUMBER(2) not null
)
;
alter table PAY_MESSAGE
  add constraint PK_PAY_MESSAGE primary key (ID);

create table PAY_HISTORY
(
  id       VARCHAR2(32) not null,
  order_id VARCHAR2(30) not null,
  be_state NUMBER(2) not null,
  af_state NUMBER(2) not null,
  m_time   DATE not null,
  pay_id   VARCHAR2(30)
)
;
alter table PAY_HISTORY
  add constraint PK_PAY_HISTORY primary key (ID);

create table PAY_IDSEQ
(
  business_id VARCHAR2(30) not null,
  pay_id      NUMBER(9) not null,
  day		  VARCHAR2(30) not null
)
;

create table PAY_NOTIFY
(
  id          VARCHAR2(32) not null,
  business_id VARCHAR2(20),
  pay_id      VARCHAR2(30),
  failed      NUMBER(10),
  type        NUMBER(1),
  create_time DATE,
  pay_state   NUMBER(1),
  amount      NUMBER(10),
  order_id    VARCHAR2(30),
  notify_url  VARCHAR2(300),
  refund_id	  VARCHAR2(32),
  apply_id	  VARCHAR2(32)
)
;

create table PAY_RECORD
(
  business_id    VARCHAR2(20) not null,
  customer_id    VARCHAR2(20),
  business_name  VARCHAR2(100),
  order_id       VARCHAR2(30) not null,
  amount         NUMBER(10) not null,
  pay_type       NUMBER(2),
  state          NUMBER(2) not null,
  tran_time      DATE not null,
  notify_url     VARCHAR2(300),
  page_url       VARCHAR2(300) not null,
  card_num       VARCHAR2(20),
  card_org       VARCHAR2(10),
  bank_name      VARCHAR2(50),
  remark         VARCHAR2(1000),
  pay_id         VARCHAR2(30) not null,
  ref_number     VARCHAR2(30),
  bank_code      VARCHAR2(20),
  update_time    DATE,
  sett_amount    NUMBER(10),
  bussett_amount NUMBER(10),
  org_commis     NUMBER(10),
  org_scale      NUMBER(6,3),
  jscn_commis    NUMBER(10),
  jscn_scale     NUMBER(6,3),
  type           NUMBER(2) default 1,
  sett_state     NUMBER(2),
  sett_time      DATE,
  old_pay_id     VARCHAR2(30),
  old_amount     NUMBER(10),
  refund_amount  NUMBER(10),
  is_refund      NUMBER(1),
  apply_id		 VARCHAR2(50)
)
;
alter table PAY_RECORD
  add constraint PK_PAYRECORD primary key (PAY_ID);

create table SYS_MENU
(
  code           VARCHAR2(15) not null,
  title          VARCHAR2(30) not null,
  url            VARCHAR2(200),
  parent_code    VARCHAR2(15) not null,
  menu_level     NUMBER(3) not null,
  children_count NUMBER(3) not null,
  display_num    NUMBER(3) not null
)
;
alter table SYS_MENU
  add constraint PK_SYS_MENU primary key (CODE);

create table SYS_MENU_ROLE
(
  id        VARCHAR2(32) not null,
  menu_code VARCHAR2(15) not null,
  role_code VARCHAR2(20) not null
)
;
alter table SYS_MENU_ROLE
  add constraint PK_SYS_MENU_ROLE primary key (ID);

create table SYS_OPERATOR
(
  operator_id VARCHAR2(20) not null,
  password    VARCHAR2(50) not null,
  name        VARCHAR2(50) not null,
  mobile_num  VARCHAR2(15),
  tele_num    VARCHAR2(15),
  email       VARCHAR2(30),
  status      VARCHAR2(20),
  job_name    VARCHAR2(40),
  remark      VARCHAR2(100),
  last_time   DATE,
  last_ip     VARCHAR2(20)
)
;
alter table SYS_OPERATOR
  add constraint PK_SYS_OPERATOR primary key (OPERATOR_ID);

create table SYS_OPERATOR_ROLE
(
  id          VARCHAR2(32) not null,
  operator_id VARCHAR2(20) not null,
  role_code   VARCHAR2(20) not null
)
;
create unique index PK_OPERATOR_ROLE on SYS_OPERATOR_ROLE (ID);
alter table SYS_OPERATOR_ROLE
  add constraint PK_SYS_OPERATOR_ROLE primary key (ID);

create table SYS_ROLE
(
  code   VARCHAR2(20) not null,
  title  VARCHAR2(50) not null,
  remark VARCHAR2(100)
)
;
alter table SYS_ROLE
  add constraint PK_SYS_ROLE primary key (CODE);

create table SYS_LOG
(
  id   VARCHAR2(32) not null,
  operator_id  VARCHAR2(20) not null,
  operator_name VARCHAR2(50) not null,
  time DATE  not null,
  content CLOB not null,
  ip VARCHAR2(20) not null
)
;
alter table SYS_LOG
  add constraint PK_SYS_LOG primary key (ID);
  
  
create sequence S_BUSINESS minvalue 1 maxvalue 99999999 start with 1 increment by 1 NOCYCLE cache 20;

