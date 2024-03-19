1.	Xuat ra tên tinh, TP cùng v?i dân s? c?a t?nh,TP:
a) Có di?n tích >= 5000 Km2
b) Có di?n tích >= [input] (SV nh?p m?t s? b?t k?)
select * from TINH_TP
select TEN_T_TP, DS from TINH_TP where DT >= 500

declare @d_t float;
set @d_t = 200;
select TEN_T_TP, DS from TINH_TP where DT >= @d_t
2.	Xu?t ra tên t?nh, TP cùng v?i di?n tích c?a t?nh,TP:
a) Thu?c mi?n B?c
b) Thu?c mi?n [input] (SV nh?p m?t mi?n b?t k?)
select TEN_T_TP, DT from TINH_TP where Mien = N'Bắc'
4. Cho bi?t di?n tích trung b?nh c?a các t?nh, TP trong c? nı?c (T?ng DT/T?ng s? t?nh_TP).
select sum(DT)/count(MA_T_TP) as DT_TRUNG_BINH from TINH_TP
select avg(DT) as DT_TRUNG_BINH from TINH_TP

Cho bi?t m?t ğ? dân s? (DS/DT) cùng v?i tên t?nh, TP c?a t?t c? các t?nh, TP.
create view cau8 as 
select TEN_T_TP, (DS/DT) as MĞ_DS from TINH_TP
select * from cau8
9.	Cho bi?t tên các t?nh,TP láng gi?ng c?a t?nh ‘Long An’.
--t?m các láng gi?ng c?a "Long An'
--Save l?i KQ ğ? s? d?ng sau: 
create view LG_LongAn as
select L.LG from TINH_TP T, LANGGIENG L
where T.MA_T_TP = L.MA_T_TP and T.TEN_T_TP = 'Long An'
--l?ng SQL
create view TinhLG_LongAn as
select MA_T_TP,TEN_T_TP from TINH_TP T1, ( select L.LG from TINH_TP T, LANGGIENG L
where T.MA_T_TP = L.MA_T_TP and T.TEN_T_TP = 'Long An') T2
where T1.MA_T_TP = T2.LG
select * from TinhLG_LongAn
select top 3 TEN_T_TP, (DS/DT) as MĞ_DS from TINH_TP
order by MĞ_DS DESC
10.	Cho bi?t s? lı?ng các t?nh, TP giáp v?i ‘CPC’.
count (MA_T_TP) ğ?m s? l?n, s? lı?t xu?t hi?n trong CSDL
MAX(DT) di?n tích l?n nh?t
MIN()
14.	Cho bi?t danh sách các mi?n cùng v?i các t?nh, TP trong các mi?n ğó.
13.	Cho bi?t tên nh?ng t?nh, TP giáp v?i hai nı?c biên gi?i khác nhau.
select T.TEN_T_TP from TINH_TP T, BIENGIOI B
where T.MA_T_TP = B.MA_T_TP 
GROUP BY TEN_T_TP
HAVING COUNT(B.MA_T_TP) >=2 

