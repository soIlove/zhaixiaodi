--普通用户表
create table zusers(
    uuid int primary key,--用户编号
	upwd varchar2(40) not null,--密码
    uname varchar2(30) not null,--昵称
    uphone varchar2(40) unique not null,--电话
    uemail varchar2(50) not null,--邮箱
    usex varchar2(4) check(usex in('男','女')) ,--性别
    upicture varchar2(200),-- 用户头像
	uaddr varchar2(40) not null, --用户地理位置 (学校)
	utype int default 0 check (utype in(0,1) ) ,--是否成为代递员  0否  1是
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)
update zusers set utype=0   where uuid=1
select * from zusers where uphone ='13237343452'
drop table zusers;
drop sequence seq_zusers;
create sequence seq_zusers start with 1000;

insert into zusers  values(seq_zusers.nextval,'a','黄小州','18188970547','382418631@qq.com','女','3.jpg','皇家工学院',1,null,null);

insert into zusers  values(seq_zusers.nextval,'a','蒋小掉','110','110@qq.com','女','6.jpg' ,'gongxeuyua',0,null,null);
insert into zusers  values(seq_zusers.nextval,'a','xkj','111','223311','男','6.jpg' ,'gongxeuyua',0,null,null);

select * from zusers;
update zusers set uname='莫甘娜' , upicture='3.jpg' ,uaddr='日俄大学',uemail='19145888314@qq.com',usex='男' where uphone='18188970546'

select * from(
select ad.*,rownum rn from
(select * from ZUSERS) ad
where  4> rownum
)where rn >1

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
create sequence seq_adminId
select * from admin
insert into admin values(seq_adminId.nextval,'a','zhangsan','男','13237343452','普通管理员',null,null);
insert into admin values(seq_adminId.nextval,'a','lisi','女','110','普通管理员',null,null);
insert into admin values(seq_adminId.nextval,'a','wangwu','女','110','普通管理员',null,null);
insert into admin values(seq_adminId.nextval,'a','zhaoliu','女','110','普通管理员',null,null);



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
    did int primary key,--代递员编号201
	uuid int unique references zusers(uuid) on delete cascade,--普通用户编号1001
    dsid varchar2(30) not null,--认证学号
    dspic varchar2(30) not null,--学生证图片
	dscore  varchar2(30) not null, --信誉度评分累计
	dnum  varchar2(30) not null,--接单次数
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)

select * from dusers
drop table dusers;
drop sequence seq_dusers;
create sequence seq_dusers start with 200;

insert into dusers values(seq_dusers.nextval,1001,'1440340410','图片','100','10',null,null);
insert into dusers values(seq_dusers.nextval,1002,'1430340410','图片','100','10',null,null);
insert into dusers values(seq_dusers.nextval,1003,'1420340410','图片','100','10',null,null);
insert into dusers values(seq_dusers.nextval,1020,'1440340420','图片','100','10',null,null);
select * from dusers;

--收货地址表
create table zaddr(
	zid int primary key,--地址编号
    uuid int references zusers(uuid) on delete cascade,--引用用户编号
	zaddr varchar2(200) not null,--地址
	uremain1 varchar2(50),
	uremain2 varchar2(50)

)
drop table zaddr;
create sequence seq_zid start with 100001;
insert into zaddr values(seq_zid.nextval,1004,'RZ-17 312寝室',null,null);
insert into zaddr values(seq_zid.nextval,1004,'2栋教学楼2514教室',null,null);
insert into zaddr values(seq_zid.nextval,1004,'RZ-17 312寝室',null,null);
select * from zaddr;

);
drop sequence seq_zaddr;
create sequence seq_zaddr start with 100;
insert into zaddr values(seq_zaddr.nextval,1001,'湖南工学院润泽公寓D4-222',null,null);
insert into zaddr values(seq_zaddr.nextval,1002,'湖南工学院润泽公寓D5-222',null,null);
insert into zaddr values(seq_zaddr.nextval,1003,'湖南工学院润泽公寓D2-222',null,null);
insert into zaddr values(seq_zaddr.nextval,1004,'湖南工学院润泽公寓D1-222',null,null);
insert into zaddr values(seq_zaddr.nextval,1020,'湖南工学院润泽公寓D6-222',null,null);
select * from zaddr;



--投单表（寄件记录）
create table zorders(
	oid int primary key,   --投单编号，一般可以考虑引用物流单号，10011
    uuid int references zusers(uuid) on delete cascade,--投单人用户编号1002
    otime date not null,--投单时间
	orelname varchar2(30) not null,--投单人真实姓名
	ocode varchar2(30) not null,--取货码
	osize varchar2(40) check(osize in ('大包裹','小包裹')) not null,--包裹大小
    odesc varchar2(100) not null,--投单描述（期望送达时间）
	zid int references zaddr(zid) on delete cascade,--投单人地址编号
    oprice varchar2(30) not null,--代递金额
	otype varchar2(30) not null,--快递类型
	uremain1 varchar2(50),--接单状态
	uremain2 varchar2(50)--接单数目
)
select * from zorders
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
(select oid,uname,upicture,otime,orelname,ocode,osize,odesc,zaddr,oprice,otype 
from ZORDERS o,ZUSERS u,ZADDR a where o.uuid=u.uuid and o.zid=a.zid and o.otype='圆通快递')zd where rownum>=1)where rn<5;


--接单表(多人抢单)
create table zaccept(
	aid int primary key,--接单编号20001
	oid int references zorders(oid) on delete cascade,--投单编号10011
	did int references dusers(did) on delete cascade,--接单人编号201--》即1001
	adesc varchar2(30) not null,--接单描述（预计到达时间）
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)
create sequence seq_zaccept start with 20000;
insert into zaccept values(seq_zaccept.nextval,10011,201,'保证晚上5点之前送达',null,null);
insert into zaccept values(seq_zaccept.nextval,10012,220,'保证晚上5点之前送达',null,null);
insert into zaccept values(seq_zaccept.nextval,10013,221,'保证晚上5点之前送达',null,null);
insert into zaccept values(seq_zaccept.nextval,10014,222,'保证晚上5点之前送达',null,null);
insert into zaccept values(seq_zaccept.nextval,10025,222,'保证晚上5点之前送达',null,null);--20040 1002 1020
select * from zaccept;

--订单表()
create table orders(
	ooid int primary key,--订单编号
	aid int references zaccept(aid) on delete cascade,--接单编号20001
	oscore varchar2(20) , --评分
	ostatus varchar2(40) check (ostatus in('等待评价','订单完成','订单取消','等待收货')),
	uremain1 varchar2(50),
	uremain2 varchar2(50)
)
drop table orders;
drop sequence seq_orders;
create sequence seq_orders start with 100000; 
insert into orders values(seq_orders.nextval,20001,null,'等待评价',null,null);--1002,1001 投单号10011
insert into orders values(seq_orders.nextval,20020,null,'订单取消',null,null);--1003投,1002接
insert into orders values(seq_orders.nextval,20021,null,'订单完成',null,null);--1004,1003
insert into orders values(seq_orders.nextval,20022,null,'等待收货',null,null);--1002,1020  10014
insert into orders values(seq_orders.nextval,20040,null,'订单取消',null,null);--1002,1020  10014
select * from orders;

select * from orders;
--创建投单和地址的视图
create OR REPLACE  view zorders_addr
as
select 
zorders.oid,zorders.uuid,zorders.otime,zorders.orelname,zorders.ocode,zorders.osize,zorders.odesc,zorders.oprice,zorders.otype,zaddr.zaddr
from zorders
join zaddr
on zorders.zid=zaddr.zid;
 
select * from zorders_addr

select distinct du.did,os.ooid,otime,osize,odesc,zaddr,oprice,otype,upicture,ostatus
from zorders zo,zaccept za,orders os, dusers du,zaddr ad, zusers zu  where os.aid=za.aid and 
za.oid=zo.oid and za.did=du.did  and  zo.zid=ad.zid and zo.uuid=1002 ;

select d.uuid,uname from zusers z,dusers d where z.uuid=d.uuid and d.did=201;

select a.did,otime,ooid,osize,odesc,zaddr,oprice,otype,upicture,ostatus from 
(select distinct du.did 
from zorders zo,zaccept za,orders os, dusers du,zaddr ad, zusers zu  where os.aid=za.aid and 
za.oid=zo.oid and za.did=du.did  and  zo.zid=ad.zid and zo.uuid=1002 )a right join 
(select distinct du.did,otime,os.ooid,osize,odesc,zaddr,oprice,otype,upicture,ostatus
from zorders zo,zaccept za,orders os, dusers du,zaddr ad, zusers zu  where za.aid=os.aid and 
za.oid=zo.oid and za.did=du.did and zo.zid=ad.zid and zo.uuid=1002 and ostatus='订单取消' )b on a.did=b.did order by otime;
--订单id,投单人姓名,接单人昵称       

