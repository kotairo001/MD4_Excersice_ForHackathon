CREATE DATABASE TicketFilm;
USE TicketFilm;

-- Tạo bảng
CREATE TABLE tblPhim (
PhimID int primary key,
ten_phim varchar(30),
loai_phim varchar(25),
thoi_gian int
);

CREATE TABLE tblPhong (
PhongID int primary key,
ten_phong varchar(20),
trang_thai tinyint
);

CREATE TABLE tblGhe (
GheID int primary key,
PhongID int,
So_ghe varchar(10),
foreign key (PhongID) references tblPhong(PhongID)
);

CREATE TABLE tblVe (
PhimID int,
GheID int,
Ngay_chieu datetime,
trang_thai varchar(20),
foreign key (PhimID) references tblPhim(PhimID),
foreign key (GheID) references tblGhe(GheID)
);

-- Thêm dữ liệu
insert into tblPhim values 
(1, "Em bé Hà Nội", "Psychology",90),
(2, "Nhiệm vụ bất khả thi", "Action",100),
(3, "Dị Nhân", "Fiction",90),
(4, "Cuốn theo chiều gió", "Romance",120);

insert into tblPhong values 
(1, "Rom 1", 1),
(2, "Rom 2", 1),
(3, "Rom 3", 0);

insert into tblGhe values
(1,1,"A3"),
(2,1,"B5"),
(3,2,"A7"),
(4,2,"D1"),
(5,3,"T2");

insert into tblVe values
(1,1,"2008-10-20", "Sold"),
(1,3,"2008-11-20", "Sold"),
(1,4,"2008-12-23", "Sold"),
(2,1,"2009-02-14", "Sold"),
(3,1,"2009-02-14", "Sold"),
(2,5,"2009-03-08", "Not Sold"),
(2,3,"2009-03-08", "Not Sold");

-- Bai 6
alter table tblPhong modify trang_thai varchar(255);
-- Bai 7
Delimiter //
create procedure update_status ()
begin
update tblPhong set trang_thai = "Đang sửa" where trang_thai = "0";
update tblPhong set trang_thai = "Đang sử dụng" where trang_thai = "1";
update tblPhong set trang_thai = "Unknow" where trang_thai = null;
select * from tblPhong;
end
// Delimiter 
drop procedure update_status;
call update_status();

-- Bai 8
select tblPhim.ten_phim from tblPhim where length(ten_phim)>15 and length(ten_phim)<25;
-- Bai 9
select concat(tblPhong.ten_phong, " ", tblPhong.trang_thai) as "Trạng thái phòng chiếu" from tblPhong;
-- Bai 10
create view tblRank as 
select row_number() over (order by tblPhim.ten_phim) as STT, tblPhim.ten_phim, tblPhim.thoi_gian from tblPhim;
-- drop view tblRank;

-- Bai 11
-- a.
alter table tblPhim add Mo_ta nvarchar(255);
-- b.
update tblPhim set Mo_ta = concat("This film is a ", loai_phim, " film");
-- c
select * from tblPhim;
-- d
update tblPhim set Mo_ta = replace(Mo_ta, "phim", "film");
-- e
select * from tblPhim;



