--普通用户表
create table zusers(
    uuid int primary key,--用户编号
	upwd varchar2(40) not null,--密码
    uname varchar2(30) not null,--昵称
    uphone varchar2(40) unique not null,--电话
    uemail varchar2(50) not null,--邮箱
    usex varchar2(4) check(usex in('男','女')) ,--性别
    upicture varchar2(200)，-- 用户头像
	uaddr varchar2(40) not null, --用户地理位置 (学校)
	utype int check (utype in(0,1)) not null,--是否成为代递员  0否  1是
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)
drop table zusers;
drop sequence seq_zusers;
create sequence seq_zusers start with 1000;
insert into zusers  values(seq_zusers.nextval,'aa','花生',15115115151,'382418631@qq.com','女',null,'皇家工学院',1,null,null);
insert into zusers  values(seq_zusers.nextval,'aa','生',15115115152,'382418632@qq.com','女',null,'皇家工学院',1,null,null);
insert into zusers  values(seq_zusers.nextval,'aa','花',15115115153,'382418633@qq.com','女',null,'皇家工学院',1,null,null);
insert into zusers  values(seq_zusers.nextval,'aa','g花生',15115115154,'382418634@qq.com','女',null,'皇家工学院',1,null,null);
insert into zusers  values(seq_zusers.nextval,'aa','略略',15115105154,'382618634@qq.com','女',null,'皇家工学院',1,null,null);



select * from zusers;
select * from zusers where uphone=15115115151 and  upwd = 'aa';
--管理员表
create table admin(
	adid int primary key,--管理员编号
	adpwd varchar2(30) not null,--管理员密码
	adname varchar2(30) not null,--管理员姓名
	adsex varchar2(4) check(adsex in('男','女')),--性别
	adphone varchar2(30) not null,--管理员电话
	adrank varchar2(20) not null,--管理员等级（普通管理员，超级管理员）
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)

--被删除的用户表
create table delusers(
	delid int primary key,--删除用户编号
	uuid int references zusers(uuid) on delete cascade,--用户编号
	deldesc varchar2(50),--删除原因描述
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)

--代递员表
create table dusers(
    did varchar2(20) primary key,--代递员编号
	uuid int references zusers(uuid) on delete cascade,--普通用户编号
    dsid varchar2(30) not null,--认证学号
    dspic varchar2(30) not null,--学生证图片
	dscore  varchar2(30) not null, --信誉度评分累计
	dnum  varchar2(30) not null,--接单次数
	uremain1 varchar2(50),
	uremain2 varchar2(50)
	 
)
drop table dusers;
drop sequence seq_dusers;
create sequence seq_dusers start with 200;

--收货地址表
create table zaddr(
	zid int primary key,--地址编号
    uuid int references zusers(uuid) on delete cascade,--引用用户编号
	zaddr varchar2(200) not null,--地址
	uremain1 varchar2(50),
	uremain2 varchar2(50)
);
drop sequence seq_zaddr;
create sequence seq_zaddr start with 100;
insert into zaddr values(seq_zaddr.nextval,1001,'湖南工学院润泽公寓D4-222',null,null);
insert into zaddr values(seq_zaddr.nextval,1002,'湖南工学院润泽公寓D5-222',null,null);
insert into zaddr values(seq_zaddr.nextval,1003,'湖南工学院润泽公寓D2-222',null,null);
insert into zaddr values(seq_zaddr.nextval,1004,'湖南工学院润泽公寓D1-222',null,null);
insert into zaddr values(seq_zaddr.nextval,1020,'湖南工学院润泽公寓D6-222',null,null);
select * from zaddr;


--投单表
create table zorders(
	oid int primary key,   --投单编号，一般可以考虑引用物流单号，
    uuid int references zusers(uuid) on delete cascade,--投单人用户编号
    otime date not null,--投单时间
	orelname varchar2(30) not null,--投单人真实姓名
	ocode varchar2(30) not null,--取货码
	osize varchar2(40) check(osize in ('大包裹','小包裹')) not null,--包裹大小
    odesc varchar2(100) not null,--投单描述（期望送达时间）
	zid int references zaddr(zid) on delete cascade,--投单人地址编号
    oprice varchar2(30) not null,--代递金额
	otype varchar2(30) not null,--快递类型
	uremain1 varchar2(50),
	uremain2 varchar2(50)
         
)
select distinct otype,count(otype) num from zorders group by otype order by count(otype) desc;

drop table zorders;
drop sequence seq_zorders;

create sequence seq_zorders start with 10000;
insert into zorders values (seq_zorders.nextval,1001,sysdate,'小花花','6789','小包裹','尽量中午',101,'5','圆通快递',null,null);
insert into zorders values (seq_zorders.nextval,1001,sysdate,'小花花','679','小包裹','尽量中午',101,'5','圆通快递',null,null);
insert into zorders values (seq_zorders.nextval,1002,sysdate,'小花','6799','小包裹','尽量中午',102,'5','圆通快递',null,null);
insert into zorders values (seq_zorders.nextval,1003,sysdate,'花小花','0789','小包裹','尽量中午',103,'5','圆通快递',null,null);
insert into zorders values (seq_zorders.nextval,1004,sysdate,'花花','6689','小包裹','尽量中午',104,'5','圆通快递',null,null);
insert into zorders values (seq_zorders.nextval,1002,sysdate,'小花','6799','小包裹','尽量中午',102,'5','圆通快递',null,null);
insert into zorders values (seq_zorders.nextval,1004,sysdate,'花花','6689','小包裹','尽量中午',104,'5','圆通快递',null,null);
insert into zorders values (seq_zorders.nextval,1003,sysdate,'花小花','0789','小包裹','尽量中午',103,'5','圆通快递',null,null);

insert into zorders values (seq_zorders.nextval,1001,sysdate,'小花花','6789','小包裹','尽量中午',101,'5','申通快递',null,null);
insert into zorders values (seq_zorders.nextval,1001,sysdate,'小花花','679','小包裹','尽量中午',101,'5','汇通快递',null,null);
insert into zorders values (seq_zorders.nextval,1002,sysdate,'小花','6799','小包裹','尽量中午',102,'5','韵达快递',null,null);
insert into zorders values (seq_zorders.nextval,1003,sysdate,'花小花','0789','小包裹','尽量中午',103,'5','全峰快递',null,null);
insert into zorders values (seq_zorders.nextval,1004,sysdate,'花花','6689','小包裹','尽量中午',104,'5','中通快递',null,null);
insert into zorders values (seq_zorders.nextval,1002,sysdate,'小花','6799','小包裹','尽量中午',102,'5','国通快递',null,null);
insert into zorders values (seq_zorders.nextval,1004,sysdate,'花花','6689','小包裹','尽量中午',104,'5','中通快递',null,null);
insert into zorders values (seq_zorders.nextval,1003,sysdate,'花小花','0789','小包裹','尽量中午',103,'5','中通快递',null,null);

delete from zorders;
select * from zorders;

select * from
(select zd.* ,rownum rn from 
(select oid,uname,otime,orelname,ocode,osize,odesc,zaddr,oprice,otype 
from ZORDERS o,ZUSERS u,ZADDR a where o.uuid=u.uuid and o.zid=a.zid )zd where rownum>=1)where rn<5;




--接单表(多人抢单)
create table zaccept(
	aid int primary key,--接单编号
	oid int references zorder(oid) on delete cascade,--投单编号
	adesc varchar2(30) not null,--接单描述（预计到达时间）
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)

--订单表
create table order(
	ooid int primary key,--订单编号
	aid int references zaccept(aid) on delete cascade,--接单编号
	oscore varchar2(20) not null, --评分
	ostatus int check (ostatus in(0,1,2)),--1接单，0订单取消
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)


