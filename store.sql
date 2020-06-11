 create database MStore;
 use MStore;

CREATE TABLE items(
    item_ID             int,
    item_Name           varchar(255),
    item_price          int,
	PRIMARY KEY (item_ID)
);
CREATE TABLE orders(
    order_ID               int,
    order_date             date,
    item_ID            int,
	PRIMARY KEY (order_ID),
	foreign key (item_ID) references items(item_ID)
);
create table Payment(payment_ID  int auto_increment ,
payment_date date,
type_of_payment  varchar(50),
payment_cost float(50),
primary key (payment_ID)
);
CREATE TABLE cashier(
    cashier_ID               int,
    payment_ID             int,
    order_ID             int,
	PRIMARY KEY (cashier_ID),
	foreign key (payment_ID) references payment (payment_ID),
	foreign key (order_ID) references orders (order_ID)
);
CREATE TABLE customer(
    customer_ID            int,
    customer_Name          varchar(255),
    cashier_ID         int,
	PRIMARY KEY (customer_ID),
	foreign key (cashier_ID) references cashier(cashier_ID)
);
 CREATE TABLE Store (
    Store_ID           int,
    Store_Name         varchar(255),
    Store_Location         varchar(255),
    cashier_ID           int,
	PRIMARY KEY (Store_ID),
	foreign key (cashier_ID) references cashier(cashier_ID)
);
insert into Payment( payment_ID, payment_date, type_of_payment, payment_cost) values( 36 , '2020/05/01' , 'Credit ' , 50 ) ;
insert into Payment( payment_ID, payment_date, type_of_payment, payment_cost) values( 25 , '2020/04/01' , 'Cash' , 60 ) ;
insert into Payment( payment_ID, payment_date, type_of_payment, payment_cost) values( 40 , '2020/04/15' , 'Credit' , 30 ) ;
insert into Payment( payment_ID, payment_date, type_of_payment, payment_cost) values( 45 , '2020/05/05' , 'Cash' , 20 ) ;
insert into Payment( payment_ID, payment_date, type_of_payment, payment_cost) values( 30 , '2020/04/20' , 'Cash' , 40 ) ;

insert into items( item_ID, item_Name, item_price) values( 75 , 'cheese' , 20 ) ;
insert into items( item_ID, item_Name, item_price) values( 79 , 'crisps', 10 ) ;
insert into items( item_ID, item_Name, item_price) values( 80 , 'candy' , 13 ) ;
insert into items( item_ID, item_Name, item_price) values( 84 , 'pickles' , 7 ) ;
insert into items( item_ID, item_Name, item_price) values( 88 , 'canned food', 25 ) ;

insert into orders ( order_ID, order_date, item_ID) values ( 64 , '2020/04/12', 84 ) ;
insert into orders ( order_ID, order_date, item_ID) values ( 54 , '2020/04/10', 80 ) ;
insert into orders ( order_ID, order_date, item_ID) values ( 60 , '2020/04/15', 88 ) ;
insert into orders ( order_ID, order_date, item_ID) values ( 62 , '2020/05/29', 75 ) ;
insert into orders ( order_ID, order_date, item_ID) values ( 66 , '2020/05/06', 79 ) ;

insert into cashier ( cashier_ID, payment_ID, order_ID) values( 100, 40 , 60 ) ;
insert into cashier ( cashier_ID, payment_ID, order_ID) values( 103, 25 , 66 ) ;
insert into cashier ( cashier_ID, payment_ID, order_ID) values( 109, 30 , 54 ) ;
insert into cashier ( cashier_ID, payment_ID, order_ID) values( 105, 36 , 62 ) ;
insert into cashier ( cashier_ID, payment_ID, order_ID) values( 111, 45 , 64 ) ;
 
insert into store ( Store_ID, Store_Name, Store_Location, cashier_ID) values ( 15, 'Batoot' , 'Sidi gaber' , 105 ) ;
insert into store ( Store_ID, Store_Name, Store_Location, cashier_ID) values ( 17, 'Batoot' , 'France street' , 103 ) ;
insert into store ( Store_ID, Store_Name, Store_Location, cashier_ID) values ( 19, 'Batoot' , 'Sidi bishrItems ' , 111 ) ;
insert into store ( Store_ID, Store_Name, Store_Location, cashier_ID) values ( 21, 'Batoot' , 'Abo air street' , 100 ) ;
insert into store ( Store_ID, Store_Name, Store_Location, cashier_ID) values ( 23, 'Batoot' , 'Sidi gaber' , 109 ) ;

insert into customer ( customer_ID, customer_Name, cashier_ID) values ( 95, 'Ali', 109 ) ;
insert into customer ( customer_ID, customer_Name, cashier_ID) values ( 97, 'Kareem', 103 ) ;
insert into customer ( customer_ID, customer_Name, cashier_ID) values ( 99, 'Hany', 111 ) ;
insert into customer ( customer_ID, customer_Name, cashier_ID) values ( 101, 'Anas', 105 ) ;
insert into customer ( customer_ID, customer_Name, cashier_ID) values ( 103, 'Omar', 100 ) ;

-- Select Statements 
select * from items ;
select * from items where item_price > 15;
select * from items where item_Name LIKE '%p%';
select * from items where item_ID > 80;
select Store_Location from store where Store_Name= 'Batoot';
select * from store where Store_Location NOT IN ('Sidi gaber', 'Abo air street ');
SELECT Store_Name, Store_Location FROM store ORDER BY Store_ID;
select * from Payment WHERE payment_date > '2020/04/15' ;
select * from Payment ORDER BY payment_ID;
select * from Payment WHERE payment_cost > 35 ;
select * from Payment WHERE type_of_payment = 'Cash' ;
select max(payment_cost) from Payment;
select min(payment_cost) from Payment;
select avg(payment_cost) from Payment;
select sum(payment_cost) from Payment where type_of_payment='Credit';
select count(item_ID) from items ;
select * from orders LIMIT 2;
select * from orders ;
select * from customer where customer_Name LIKE '%n%';
select * from customer where customer_ID > 100;

-- Select using Sub Query
SELECT customer_ID, customer_Name FROM customer WHERE cashier_ID=(select cashier_ID from cashier  where cashier_ID = 109) ;
SELECT Store_Name, Store_Location FROM store WHERE cashier_ID=(select cashier_ID from cashier where cashier_ID = 103) ;
SELECT order_ID, order_date FROM orders WHERE item_ID=(select item_ID from items where item_ID = 88) ;

-- Select using Count and Group 
 SELECT item_Name, count(*) FROM items GROUP BY item_Name ;
 SELECT Store_Name, Store_Location,count(Store_ID) FROM store GROUP BY Store_Location ;
 SELECT count(customer_ID), customer_Name, cashier_ID FROM customer GROUP BY customer_Name ;
 
-- Select using Different Joins 
SELECT store.Store_Name, store.Store_Location FROM store INNER JOIN cashier ON store.cashier_ID = cashier.cashier_ID ;
SELECT customer.customer_Name, customer.cashier_ID FROM customer INNER JOIN cashier ON customer.cashier_ID = cashier.cashier_ID ;
SELECT Payment.payment_date, Payment.type_of_payment FROM Payment right JOIN cashier ON Payment.payment_ID = cashier.payment_ID ;
SELECT orders.order_ID, orders.order_date FROM orders left JOIN cashier ON orders.order_ID = cashier.order_ID ;
SELECT orders.order_ID, orders.order_date FROM orders INNER JOIN items ON items.item_ID = items.item_ID ;

-- Insert Statement 
insert into Payment( payment_ID, payment_date, type_of_payment, payment_cost) values( 36 , '2020/05/01' , 'Credit ' , 50 ) ;
insert into items( item_ID, item_Name, item_price) values( 75 , 'cheese' , 20 ) ;
insert into orders ( order_ID, order_date, item_ID) values ( 60 , '2020/04/15', 88 ) ;
insert into cashier ( cashier_ID, payment_ID, order_ID) values( 105, 36 , 62 ) ;
insert into customer ( customer_ID, customer_Name, cashier_ID) values ( 99, 'Hany', 111 ) ;

-- Update Statement 
UPDATE customer SET customer_Name = 'Ahmed' WHERE customer_ID = 99;
UPDATE store SET Store_Name = 'Kitty' WHERE Store_ID = 19;
UPDATE orders SET order_date = '2020/04/17' WHERE order_ID = 60;
UPDATE items SET item_price = 15 WHERE item_ID = 80;
UPDATE Payment SET payment_date = '2020/04/25' WHERE payment_ID = 40;

-- Delete Statement 
DELETE FROM customer WHERE customer_ID = 101;
DELETE FROM store WHERE Store_ID= 21;
DELETE FROM items WHERE item_ID= 88;
DELETE FROM Payment WHERE payment_ID= 40;
DELETE FROM orders WHERE order_date= '2020/05/06';
