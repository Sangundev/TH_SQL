create database QL_AMNHAC
use QL_AMNHAC
set dateformat dmy

create table NHACSI(
MANS varchar(6) not null  primary key, 
TENNS nvarchar(100)) 

create table  BAIHAT(
MABH varchar(6) not null  primary key, 
TENBH nvarchar(100), 
NAMST date, 
MANS varchar(6) default  null) 

alter table BAIHAT add constraint FK_NSbh foreign key (MANS)
references NHACSI(MANS)

create table CASI(
MACS varchar(6) not null  primary key, 
TENCS nvarchar(100)
)

create table THONGTINBIEUDIEN(
MABD varchar(6) not null  primary key,
MABH varchar(6) default  null, 
MACS varchar(6) default  null,
NGAYBD date )

alter table THONGTINBIEUDIEN add constraint FK_BH foreign key (MABH)
references BAIHAT(MABH)

alter table THONGTINBIEUDIEN add constraint FK_MACS foreign key (MACS)
references CASI(MACS)

insert into TINH_TP values ('AG',N'An Giang', '3406','2142709','Nam')