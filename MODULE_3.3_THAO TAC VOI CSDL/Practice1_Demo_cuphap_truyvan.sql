create DATABASE DEMO1;
USE DEMO1;
create table CUSTOMER(
ID int primary key NOT NULL,
NAME varchar(20) NOT NULL,
AGE int NOT NULL
);
insert into CUSTOMER (ID,NAME,AGE)
value(2,'Canh',18),
	 (3,'Long',25),
	 (4,'Bao',23),
	 (5,'Binh',15);
select demo1.customer.ID,demo1.customer.NAME,demo1.customer.AGE
from customer
order by ID DESC;
select sum(demo1.customer.AGE)
from customer
group by name;