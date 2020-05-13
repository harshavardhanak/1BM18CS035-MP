/* Airline Flight database */
/* program 5  */
use airline;
create table flights(
flno int primary key  ,
boarding varchar(255) ,
destination varchar(255),
distance varchar(255) ,
departs time ,
arrive time ,
price int );

create table aircraft(
aid int primary key ,
aname varchar(255),
cruisingrange int );

create table employee(
eid int primary key ,
ename varchar(255) ,
salary int );

create table certified(
eid int ,
aid int ,
foreign key(eid) references employee(eid ) ,
foreign key(aid) references aircraft(aid ) ) ;

insert into aircraft values(101,'747',3000),
(102,'Boeing',900),
(103,'647',800),
(104,'Dreamliner',10000),
(105,'Boeing',3500),
(106,'707',1500),
(107,'Dream', 120000);

insert into employee values(701,'A',50000),
(702,'B',100000),
(703,'C',150000),
(704,'D',90000),
(705,'E',40000),
(706,'F',60000),
(707,'G',90000);

insert into certified values(701,101),
(701,102),
(701,106),
(701,105),
(702,104),
(703,104),
(704,104),
(702,107),
(703,107),
(704,107),
(702,101),
(703,105),
(704,105),
(705,103);

insert into flights values(101,'Bangalore','Delhi',2500,' 07:15:31','17:15:31',5000),
(102,'Bangalore','Lucknow',3000,'07:15:31','11:15:31',6000),
(103,'Lucknow','Delhi',500,'12:15:31',' 17:15:31',3000),
(107,'Bangalore','Frankfurt',8000,'07:15:31','22:15:31',60000),
(104,'Bangalore','Frankfurt',8500,' 07:15:31','23:15:31',75000),
(105,'Kolkata','Delhi',3400,' 07:15:31','09:15:31',7000);

/* query 1 */ 
select aname from aircraft 
where aid in 
(select distinct aid from certified 
where eid in 
(select eid 
from employee 
where salary > 80000));

/* query 2*/
select c.eid ,max(a.cruisingrange) 
from certified c,aircraft a 
where c.aid = a.aid 
group by c.eid 
having count(*)>3 ;

select c.eid ,max(a.cruisingrange) from certified c, aircraft a  
where c.aid = a.aid 
group by c.eid 
having count(c.eid) >= 3 ;

/* query 3 */
select ename from employee 
where salary < 
(select min(price) from flights
where boarding = 'Bangalore' and destination = 'Frankfurt');

/* query 4 */
SELECT Temp.name, Temp.AvgSalary
FROM ( SELECT A.aid, A.aname AS name, AVG (E.salary) AS AvgSalary
 FROM aircraft A, certified C, employee E
 WHERE A.aid = C.aid AND C.eid = E.eid AND A.cruisingrange > 1000
 GROUP BY A.aid, A.aname )  Temp;

/* query 5 */
select ename from employee where eid in 
(select distinct eid from certified where aid in 
(select aid from aircraft
where aname = 'Boeing ')) ;

/* query 6 */
select aname from aircraft where cruisingrange > 
(select min(distance) from flights 
where boarding = 'Bangalore ' and destination = 'Delhi');

/* query 7 */ 

