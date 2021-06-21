create database quanlybanhang;
use quanlybanhang;
create table customer(
cid int not null primary key auto_increment,
name varchar(25) not null,
cage tinyint not null
);
create table orders(
oid int primary key,
cid int not null,
odate datetime not null ,
ototalprice int null,
foreign key(cid) references customer(cid)
);
create table product(
pid int primary key auto_increment,
pname varchar(25) not null,
pprice int not null
);
create table orderdetail(
oid int not null,
pid int not null,
odqty int not null,
foreign key(oid) references orders(oid),
foreign key(pid) references product(pid)
);

insert into customer(name,cage)
value('minh quan',10),
	('ngoc oanh',20),
    ('hong ha',50);
insert into orders (oid,cid,odate,ototalprice)  
value(1,1,'2006-3-21',null),
	(2,2,'2006-3-23',null),
    (3,1,'2006-3-16',null);
insert into product(pname,pprice) 
value('May giat',3),
	('Tu lanh',5),
	('Dieu hoa',7),
	('Quat',1),
	('Bep dien',2);
insert into orderdetail(oid,pid,odqty)
value(1,1,3),
	(1,3,7),
	(1,4,2),
	(2,1,1),
	(3,1,8),
	(2,5,4),
	(2,3,3);

/*Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order*/
select od.oid,o.odate,p.pprice
from quanlybanhang.orderdetail od ,quanlybanhang.orders o,quanlybanhang.product p
where od.oid=o.oid and od.pid = p.pid;

/*Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách*/    
select customer.name,product.pname
from orders,customer,product,orderdetail
where customer.cid = orders.cid and orderdetail.pid = product.pid and orders.oid = orderdetail.oid ;

/*Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách*/
select customer.name ,customer.cid
from customer
where customer.cid not in (select orders.cid from orders);

/*Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)*/
select orders.oid,orders.odate, odQTY*pPrice as total
from orders,orderdetail,product
where orderdetail.oid = orders.oid and product.pid=orderdetail.pid;