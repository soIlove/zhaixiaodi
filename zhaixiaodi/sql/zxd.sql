select *from ZUSERS

--普通用户表
create table zusers(
    uuid int primary key,--用户编号
	upwd varchar2(40) not null,--密码
    uname varchar2(30) not null,--昵称
    uphone number unique not null,--电话
    uemail varchar2(50) not null,--邮箱
    usex varchar2(4) check(usex in('男','女')),--性别
    upicture varchar2(200),-- 用户头像
	uaddr varchar2(40) not null, --用户地理位置 (学校)
	utype int check (utype in(0,1)) not null,--是否成为代递员  0否  1是
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)
create SEQUENCE seq_zusersId
insert into ZUSERS values(seq_zusersId.nextval,
	'a','xkj',13237343452,'xkj_0204@foxmail.com','男',null,'湖南工学院',0,null,null)
	
 update ZUSERS set upwd='a' where uphone='13237343452' 
 
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
	uuid int references zusers(uuid) on delete  cascade,--用户编号
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

--收货地址表
create table zaddr(
	zid int primary key,--地址编号
    uuid int references zusers(uphone) on delete  cascade,--引用用户编号
	zaddr varchar2(200) not null,--地址
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)
select * from zaddr;
create SEQUENCE seq_zaddrId;
insert into zaddr values(seq_zaddrId.nextval,'1','湖南工学院D6-318',null,null);

--投单表
create table zorders(
	oid int primary key,   --投单编号，一般可以考虑引用物流单号，
    uuid int references zusers(uuid) on delete cascade,--投单人用户编号
    otime date not null,--投单时间
	orelname varchar2(30) not null,--投单人真实姓名
	ocode varchar2(30) not null,--取货码
	osize varchar2(40) check(osize in ('大包裹','小包裹')) not null,--包裹大小
    odesc varchar2(100) not null,--投单描述（期望送达时间）
	zid int references zaddr(zid)   on delete cascade,  --投单人地址编号
    oprice varchar2(30) not null,--代递金额
	otype varchar2(30) not null,--快递类型
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)
drop table zorders
select * from zorders;
create SEQUENCE seq_zordersId;
insert into zorders values(seq_zordersId.currval,1,sysdate,'肖坤跻','3452','大包裹','我想尽快送到,是个小包裹',1,10,'申通',null,null)

--接单表(多人抢单)
create table zaccept(
	aid int primary key,--接单编号
	oid int references zorder(oid) on delete  cascade,--投单编号
	did int references dusers(did) on delete  cascade,--接单人(待递员)编号
	adesc varchar2(30) not null,--接单描述（预计到达时间）
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)

--订单表
create table order(
	ooid int primary key,--订单编号
	aid int references zaccept(aid) on delete  cascade,--接单编号
	oscore varchar2(20) not null, --评分
	ostatus int check (ostatus in(0,1,2)),--1接单，0订单取消
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)


