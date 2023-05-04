create database mysql_ex3;
use mysql_ex3;
-- drop database mysql_ex3;
create table class (
classID int				primary key auto_increment,
className varchar(255)  not null,
startDate datetime		not null,
status bit
);

create table student(
studentID int			primary key,
studentName varchar(30)	not null,
address varchar(50)	,
phone varchar(20),
status bit,
classID int				not null
);

create table subjects(
subID int				primary key auto_increment,
subName varchar(30)		not null,
credit tinyint			not null default(1) check(credit>=1),
status bit				default(1)
);
-- drop table subject;

create table mark (
markID int 				primary key auto_increment,
subID int				not null,
studentID int			not null,
mark float				default(1) check(mark>0 and mark<100),
examTimes tinyint		default(1)
);

alter table student add foreign key (classID) references class(classID);
alter table class modify startDate datetime default(curdate());
alter table mark add foreign key (studentID) references student(studentID);
alter table mark add foreign key (subID) references subjects(subID);

insert into class (className, startDate, status) values
("A1","2008-12-20",1),
("A2","2008-12-22",1),
("B3",curdate(),0);
insert into student values
(1,"Hung","Ha noi","0912113113",1,1),
(2,"Hoa","Hai phong",null,1,1),
(3,"Manh","HCM", "0123123123",0,2);
insert into subjects (subName,credit,status) values
("CF",5,1),
("C",6,1),
("HDJ",5,1),
("RDBMS",10,1);
insert into mark (subID,studentID,mark,examTimes) values
(1,1,8,1),
(1,2,10,2),
(3,1,12,1);
update student set classID = 2 where studentName = "Hung";
update student set phone = "No Phone" where phone is null;
update class set className = concat("New ", className) where status = 0;
update class set className = replace(className, "New", "Old") where status = 1 and className like "New%";
update class set status = 1 where classID = 3;
update class set status = 0 where not exists (select 1 from student s where s.classID = class.classID);
update subjects set status = 0 where not exists (select 1 from mark m where m.subID = subjects.subID);

-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’.
select student.studentName from student where student.studentName like "h%";
-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select * from class where startDate like "%-12-%";
-- Hiển thị giá trị lớn nhất của credit trong bảng subject.
select max(subjects.credit) as MAX from subjects;
-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất
select * from subjects s where credit = (select max(credit) from subjects);
-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select * from subjects s where (credit >3 and credit <=5);
-- Hiển thị các thông tin bao gồm: classid, className, studentname, Address từ hai bảng Class, student
select s.classid, c.classname,s.studentname,s.address from student s
join class c on c.classid = s.classid order by s.classid;
-- Hiển thị các thông tin môn học chưa có sinh viên dự thi.
select * from subjects where not exists (select 1 from mark m where m.subID = subjects.subID);
-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select s.subID, s.subName, s.credit, s.status, m.mark from subjects s
join mark m on m.subID = s.subID where mark = (select max(mark) from mark);
-- Hiển thị các thông tin sinh viên và điểm trung bình tương ứng.
select st.studentId, st.studentname, avg(m.mark) as "average mark" from student st
join mark m on m.studentid = st.studentid group by st.studentId;
-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần (gợi ý: sử dụng hàm rank)
select st.studentId, st.studentname, avg(m.mark) as "average mark" ,
rank() over(order by avg(m.mark) desc) average_mark
from student st
join mark m on m.studentid = st.studentid group by st.studentId;
-- Hiển thị các thông tin sinh viên và điểm trung bình, chỉ đưa ra các sinh viên có điểm trung bình lớn hơn 10.
select st.studentId, st.studentname, avg(m.mark) as "average mark"
from student st
join mark m on m.studentid = st.studentid  where (select avg(m.mark) from mark m) > 9 group by st.studentId;
-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select st.studentName, s.subname, m.mark 
from student st
join mark m on st.studentid = m.studentid
join subjects s on s.subid = m.subid order by m.mark desc, st.studentname asc;
-- Xóa tất cả các lớp có trạng thái là 0.
delete from class where status = 0;
-- Xóa tất cả các môn học chưa có sinh viên dự thi.
delete from subjects where not exists (select 1 from mark m where m.subid = subjects.subid);
-- Xóa bỏ cột ExamTimes trên bảng Mark.
alter table mark drop column ExamTimes;
-- Sửa đổi cột status trên bảng class thành tên ClassStatus.
alter table class rename column status to classStatus;
-- Đổi tên bảng Mark thành SubjectTest.
alter table mark rename to subjectTest;



