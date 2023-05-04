-- create database test_student_management_ex6;
use test_student_management_ex6;
create table Student (
RN int primary key,
sName varchar(20),
sAge tinyint
);
create table Test (
testID int primary key,
tName varchar(20)
);
create table StudentTest (
RN int,
testID int,
date datetime,
mark float
);
alter table StudentTest add foreign key (RN) references Student(RN);
alter table StudentTest add foreign key (testID) references Test(testID);

insert into Student values
(1,"Nguyen Hong Ha", 20),
(2, "Truong Ngocj Anh", 30),
(3, "Tuan Minh", 25),
(4, "Dan Truong", 22);

update Student set sName = "Truong Ngoc Anh" where RN=2;
update Student set sName = "Nguyen Hong Ha" where RN=1;
update Student set sName = "Tuan Minh" where RN=3;
update Student set sName = "Dan Truong" where RN=4;

insert into Test values
(1, "EPC"),
(2, "DWMX"),
(3, "SQL1"),
(4, "SQL2");

insert into StudentTest values
(1,1,"2006-07-17",8),
(1,2,"2006-7-18",5),
(1,3,"2006-07-19",7),
(2,1,"2006-07-17",7),
(2,2,"2006-07-18",4),
(2,3,"2006-07-19",2),
(3,1,"2006-07-17",10),
(3,3,"2006-07-18",1);

-- Bai 2
alter table Student modify column sAge int check (sAge>15 and sAge<55);
alter table StudentTest alter mark set default 0;
alter table StudentTest add primary key (RN, testID);
alter table Test add unique(tName);
alter table Test drop index tName;

-- Bai 3
select student.sName, test.tName, StudentTest.mark, StudentTest.date from StudentTest
join test on test.testID = StudentTest.testID
join student on student.RN = StudentTest.RN;

-- Bai 4
select s.RN, s.sName, s.sAge from student s
where not exists (select s.RN from student join StudentTest where s.RN = StudentTest.RN);

-- Bai 5
select student.sName, test.tName, StudentTest.mark, StudentTest.date from StudentTest
join test on test.testID = StudentTest.testID
join student on student.RN = StudentTest.RN where StudentTest.mark<5;

-- Bai 6
select student.sName, avg(StudentTest.mark) as Average from StudentTest
join student on student.RN = StudentTest.RN 
group by student.sName 
order by avg(StudentTest.mark) desc;

-- Bai 7
select student.sName, avg(StudentTest.mark) as Average from StudentTest
join student on student.RN = StudentTest.RN 
group by student.sName 
order by avg(StudentTest.mark) desc limit 1;

-- Bai 8
select test.tName, max(StudentTest.mark) as "Max Mark" from StudentTest
join test on test.testID = StudentTest.testID 
group by test.tName
order by test.tName;

-- Bai 9
select s.sName, test.tName 
from student s
left join StudentTest on s.RN = StudentTest.RN
left join test on test.testID = StudentTest.testID 
;

-- Bai 10
update Student set sAge = sAge + 1;

-- Bai 11
alter table Student add sStatus varchar(10);

-- Bai 12
update Student set sStatus = 
case 
when sAge>30 then"Old"
else"Young"
end;

-- Bai 13
select student.sName, test.tName, StudentTest.mark, StudentTest.date from StudentTest
join test on test.testID = StudentTest.testID
join student on student.RN = StudentTest.RN 
order by StudentTest.date;

-- Bai 14


-- Bai 15
select student.RN, student.sName, student.sAge, avg(StudentTest.mark), row_number() over (order by avg(StudentTest.mark) desc) as 'Rank' from student
join StudentTest on student.RN = StudentTest.RN 
join test on test.testID = StudentTest.testID
group by student.sName;

-- Bai 16
alter table Student  modify column sName varchar (255);

-- Bai 17
update Student set sName = 
case 
when sAge>20 then CONCAT("Old ", sName)
when sAge<=20 then CONCAT("Young ", sName)
end;

-- Bai 18
delete  FROM test t1
  WHERE NOT EXISTS (SELECT 1 FROM studenttest t2 WHERE t1.TestID = t2.TestID);
SET SQL_SAFE_UPDATES = 0;

-- Bai 19	
delete from StudentTest 
where mark<5;





