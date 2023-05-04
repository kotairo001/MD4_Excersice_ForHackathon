-- create database product_management;
use product_management;
create table customer (
cID int 				primary key auto_increment,
cName varchar (25),
cAge tinyint
);

create table orders (
oID int 				primary key auto_increment,
cID int,
oDate datetime,
oTotalPrice int,
foreign key (cID) references customer(cID)
);

create table product (
pID int 				primary key auto_increment,
pName varchar (25),
pPrice int
);

create table OrderDetail (
oID int,
pID int,
odQty int,
primary key (pID, oID),
foreign key (pID) references product(pID),	
foreign key (oID) references orders(oID)
);
drop table OrderDetail;

insert into customer values 
(1, "Minh Quan", 10),
(2, "Ngoc Oanh", 20),
(3, "Hong Ha", 50);

insert into orders values 
(1,1,"2016-03-21",null),
(2,2,"2016-03-23",null),
(3,1,"2016-03-16",null);
insert into orders values (4,3,"2017-04-01",null);
update orders set cID = 1 where oID = 1;
update orders set cID = 2 where oID = 2;
update orders set cID = 1 where oID = 3;

insert into product values 
(1,"May Giat",3),
(2,"Tu Lanh",5),
(3,"Dieu Hoa",7),
(4,"Quat",1),
(5,"Bep Dien",2);
insert into product values (5,"Bep Dien",2);

insert into OrderDetail values 
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

-- Bai 2
select orders.oID, orders.cID, orders.oDate, orders.oTotalPrice from orders order by orders.oDate desc;

-- Bai 3
select product.pName, max(product.pPrice) from product group by product.pName order by product.pPrice desc limit 1;

-- Bai 4
select c.cName, p.pName from OrderDetail
join product p on p.pID = OrderDetail.pID
join orders o on o.oID = OrderDetail.oID
join customer c on c.cID = o.cID;

-- Bai 5
select c.cName from customer c where not exists (select c.cID from customer join orders o on c.cID= o.cID);

-- Bai 6
select od.oID, o.oDate, od.odQty, p.pName, p.pPrice from OrderDetail od
join orders o on o.oID = od.oID
join product p on p.pID = od.pID order by od.oID;

-- Bai 7
select o.oID, o.oDate, sum(od.odQty*p.pPrice) as Total from orders o
join OrderDetail od on o.oID = od.oID
join product p on p.pID = od.pID group by od.oID;

-- Bai 8
CREATE VIEW SALES_VIEW AS
SELECT sum(od.odQTY * p.pPrice) as Sales
FROM OrderDetail od
join product p on p.pID = od.pID;
select * from SALES_VIEW;



-- Bai 10

DELIMITER //
 create trigger cusUpdate 
 after update on customer 
 for each row
begin
 set foreign_key_checks = 0;
 update orders 
set 
 cID = new.cID where cID = old.cID;
 set foreign_key_checks = 1;
end //
DELIMITER ;
DROP TRIGGER cusUpdate;

update customer set cID = "0" where cID = 2;
select * from orders;

DELIMITER //
create trigger BEFORE_INSERT_CUSTOMER
before insert on customer
for each row
if new.cAge<18 then signal sqlstate "50001" set message_text = "Have to bigger than 18";
end if;
// DELIMITER ;
insert into customer values (5,"Nguyen Vuong",10);


-- Bai 11
DELIMITER //
create procedure delProduct
(in pName varchar(25))
begin 
    delete from orderdetail where (select p.pID from product p where p.pName = pName) = pID;
	delete from product where product.pName = pName;
end;
drop procedure delProduct;

call delProduct("Bep Dien");
