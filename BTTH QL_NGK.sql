﻿CREATE database QL_NGK
use QL_NGK
set dateformat dmy
-- Key char(5), chuỗi nvarchar(40), thời gian date, giá trị bigint
create table NGK(
	MaNGK char(5) not null primary key,
	TenNGK nvarchar(40) not null,
	Quycach nvarchar,
	MaLoaiNGK char(5));
create table LOAINGK(
	MaLoaiNGK char(5) not null primary key, 
	TenLoaiNGK nvarchar(40) not null, 
	MaNCC char(5) not null);
alter table NGK add constraint FK_Loai foreign key(MaLoaiNGK)
references LOAINGK(MaLoaiNGK);
create table NHACC(
	MaNCC char(5) not null primary key, 
	TenNCC nvarchar(40) not null, 
	DiaChiNCC nvarchar(40), 
	DTNCC char(12));
alter table NHACC add constraint FK_NCC foreign key(MaNCC)
references LOAINGK(MaNCC);
create table KH(
	MaKH char(5) not null primary key, 
	TenKH nvarchar(40), 
	DCKH nvarchar(40), 
	DTKH char(12));
create table DDH(
	SoDDH char(5) not null primary key, 
	NgayDH date, 
	MaNCC char(5) not null);
alter table DDH add constraint FK_NCC_DDH foreign key(MaNCC)
references NHACC(MaNCC);
create table CT_DDH(
	SoDDH char(5) not null, 
	MaNGK char(5) not null, 
	SLDat bigint);
alter table CT_DDH add constraint PK_CT_DDH primary key(SoDDH, MaNGK);
alter table CT_DDH add constraint FK_SoDDH foreign key (SoDDH)
references DDH(SoDDH)
alter TABLE CT_DDH add constraint FK_MaNGK foreign key (MaNGK)
references NGK(MaNGK);
create table PHIEUGH(
	SoPGH char (5) not null primary key,
	NgayGH date,
	SoDDH char (5) not null);
alter table PHIEUGH add constraint FK_SoDDH_PH foreign key (SoDDH)
references DDH(SoDDH);
create table CT_PGH(
	SoPGH char (5) not null,
	MaNGK char (5) not null,
	SLGiao bigint,
	DGGiao bigint);
alter table CT_PGH add constraint PK_CT_PGH PRIMARY KEY (SoPGH,MaNGK);
alter table CT_PGH add constraint FK_CT_PGH foreign key (SoPGH)
references PHIEUGH(SoPGH);
alter table CT_PGH add constraint FK_CT_PGH_NGK foreign key (MaNGK)
references NGK (MaNGK);
create table HOADON(
	SoHD char (5) not null primary key,
	NgaylapHD date,
	MaKH char (5) not null);
alter table HOADON add constraint FK_KH foreign key (MaKH)
references KH(MaKH);
create table CT_HOADON(
	SoHD char (5) not null,
	MaNGK char (5) not null,
	SLKHMua Bigint,
	DGBan Bigint);
alter table CT_HOADON add constraint PK_CT_HD primary key (SoHD,MaNGK);
alter table CT_HOADON add constraint FK_SoHD foreign key (SoHD)
references HOADON (SoHD);
alter table CT_HOADON add constraint FK_NGK foreign key (MaNGK)
references NGK(MaNGK);
create table PHIEUHEN(
	SoPH char (5) not null primary key,
	NgayLapPH date,
	NgayHenGiao date,
	MaKH char (5) not null);
alter table PHIEUHEN add constraint FK_KH_PH foreign key (MaKH)
references KH(MaKH);
create table CT_PH(
	SoPH char (5) not null,
	MaNGK char (5) not null,
	SLHen int);
alter table CT_PH add constraint PK_CT_PH primary key (SoPH,MaNGK);
alter table CT_PH add constraint FK_SoPH foreign key (SoPH)
references PHIEUHEN(SoPH);
alter table CT_PH add constraint FK_MaNGK foreign key (MaNGK)
references NGK(MaNGK);
create table PHIEUTRANNO(
	SoPTN char (5) not null primary key,
	NgayTra DATE,
	SoTienTra bigint,
	SoHD char (5) not null);
alter table PHIEUTRANNO add constraint FK_PTN_HD foreign key (SoHD)
references HOADON(SoHD);
---------------------------------------cac ren buoc toan ven-------------------
-----------yeu cau cai dat cac ren buoc toan ven 
--DG ban > 0
--sl ban > 0 
-------------------nhap du lieu -----------------
------------------1 trc nh sau ----------------------
------------->ve luot do quan he----------------------- 1KH,NCC,LOAINGK,NGK  2 DDH,CT_DDH, PGH ,CT_PGH 3 HD,PHIEUTANO CT_HD ,PHIEUHEN ,CT_PPH
1)	Liệt kê các NGK và loại NGK tương ứng.
select N.MaNGK , N.TenNGK,L.TenloaiNGK from NGK N, LOAINGK L
2)	Cho biết thông tin về nhà cung cấp ở Thành phố HCM.
select* from NHACC where Diachincc like '%TP.HCM%'
3)	Liệt kê các hóa đơn mua hàng trong tháng 5/2010.
select *
from DDH
where MONTH(NgayDH) = 5 and year(NgayDH) = 2010 
4)	Cho biết tên các nhà cung cấp có cung cấp NGK ‘Coca Cola’.

select a.tenNCC  from NHACC a, LOAINGK b, NGK c  where a.MaNCC = b.MaNCC and b.MaLoaiNGK = c.MaLoaiNGK and c.TenNGK = 'Coca Cola'  

5)	Cho biết tên các nhà cung cấp có thể cung cấp nhiều loại NGK nhất.

select top 1 a.tenNCC  from NHACC a, LOAINGK b, NGK c  where a.MaNCC = b.MaNCC and b.MaLoaiNGK = c.MaLoaiNGK 
group by a.tenNCC 

6)	Cho biết tên nhà cung cấp không có khả năng cung cấp NGK có tên ‘Pepsi’. 

select a.tenNCC  from NHACC a, LOAINGK b,NGK c 
where a.MaNCC=b.MaNCC and b.MaLoaiNGK = c.MaLoaiNGK and c.TenNGK  NOT IN ('Pepsi')

(Hướng dẫn: Cách 1: Sử dụng NOT EXISTS. Cách 2: Sử dụng NOT IN) 7)	Hiển thị thông tin của NGK chưa bán được.
8)	Hiển thị tên và tổng số lượng bán của NGK bán chạy nhất.



9)	Hiển thị tên và tổng số lượng của NGK nhập về ít nhất.

10)	Hiển thị ĐĐH đặt nhiều NGK nhất.
select TOP 1 sldat
from CT_DDH
group by  sldat

11)	Hiển thị các NGK không được nhập trong tháng 1/2010.

12)	Hiển thị tên các NGK không bán được trong tháng 6/2010.

13)	Cho biết cửa hàng bán bao nhiêu NGK.
select a.TenNGK , b.DGGiao
from NGK a,CT_PGH b
group by a.TenNGK , b.DGGiao

14)	Cho biết cửa hàng bán bao nhiêu loại NGK.
select count(MaLoaiNGK)
from NGK
15)	Hiển thị thông tin cua khách hàng có giao dịch với cửa hàng nhiều nhất.
select top 1 a.makh ,a.tenkh,a.dckh,a.dtkh, count(b.SoHD) SHD
from kh a, hoadon b , ct_hoadon c
where a.makh = b.makh and b.sohd = c.sohd 
group by a.makh ,a.tenkh,a.dckh,a.dtkh
order by SHD desc

16)	Tính tổng doanh thu năm 2010 của cửa hàng.
select sum(SLGiao * DGGiao) danhthu
from CT_PGH a, PHIEUGH b
where year(NgayGH) = 2010

17)	Liệt kê 5 loại NGK bán chạy nhất trong tháng 5/2010.
18)	Liệt kê thông tin bán NGK của tháng 5/2010
19)	Liệt kê thông tin của NGK có nhiều người mua nhất.
20)	Hiển thị ngày nhập hàng gần nhất của cửa hàng.
21)	Cho biết số lần mua hàng của khách có mã là ‘KH001’.
select count( a.sohd) slmua
from hoadon a ,ct_hoadon b
where a.sohd = b.sohd and a.makh = 'KH01'
22)	Cho biết tổng tiền của từng hóa đơn.
select  sohd,sum(slkhmua *dgban) tt
from ct_hoadon
group by sohd
23)	Cho biết danh sách các hóa đơn gồm SoHD, NgaylapHD, MaKH, TenKH và tổng trị giá của từng HoaDon. Danh sách sắp xếp tăng dần theo ngày và giảm dầntheo tổng trị giá của hóa đơn.
select b.sohd , b.ngaylaphd ,sum(slkhmua*dgban) as tongtien 
from ct_hoadon a , hoadon b, kh k
where b.sohd = a.sohd and k.makh = b.makh
group by b.sohd ,b.ngaylaphd

24)	Cho biết các hóa đơn có tổng trị giá lớn hơn tổng trị giá trung bình của các hóa đơn trong ngày 18/06/2010.
25)	Cho biết số lượng NGK tiêu thụ của từng loại theo tháng.
26)	Đưa ra danh sách NGK chưa được bán trong tháng 9 năm 2010.
27)	Đưa ra danh sách khách hàng có địa chỉ ở TP.HCM và từng mua NGK trong tháng 9 năm 2010.
28)	Đưa ra số lượng đã bán tương ứng của từng NGK trong tháng 10 năm 2010.
29)	Hiển  thị thông tin khách hàng đã từng mua NGK tại cửa hàng.
30)	Cho biết trong năm 2010, khách hàng nào đã mua nợ nhiều nhất.
31)	Có bao nhiêu hóa đơn chưa thanh toán hết số tiền?
32)	Liệt kê các hóa đơn cùng tên của khách hàng tương ứng đã mua NGK và thanh toán tiền đầy đủ 1 lần. (Không có phiếu trả nợ)
33)	Cho biết, trong năm 2010, cửa hàng đã đặt NGK của NCC nào nhiều nhất.
34)	Để thuận tiện trong việc tặng quà Tết cho khách hàng, hãy liệt kê danh sách khách hàng đã mua NGK với tổng số tiền tương ứng trong năm 2010 (hiển thị giảm dần theo số tiền đã mua).
35)	* Tạo View để tổng hợp dữ liệu về từng NGK đã được bán (Cấu trúc View gồm các thuộc tính: MaNGK, TenNGK, DVT, SoLuongBan)
create View P1 as
select * from NGK

select * from P1


36)	* Tạo View để tổng hợp dữ liệu về các mặt hàng đã được bán với số lượng lớn nhất.
create View P2 as
select top 1 with ties b.TenNGK ,a.SLKHMua from CT_HOADON a, NGK b
where a.MaNGK = b.MaNGK
order by SLKHMua desc


select * from P2


37)	* Tạo View để tổng hợp dữ liệu về các khách hàng đã mua hàng trong ngày 20/10/2005.

create View P3 as
select a.tenkh , a.dckh,a.dtkh
from kh a, hoadon b
where a.makh = b.makh and month(NgaylapHD) = 10 and year(NgaylapHD)= 2005

select * from P3

