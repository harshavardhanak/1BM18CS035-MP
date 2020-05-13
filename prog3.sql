/* supplier */

create database supplier ;
use supplier ;
create table supplier(
sid int primary key ,
sname varchar(255) ,
address varchar(255));

create table parts(
pid int primary key ,
pname varchar(255) ,
color varchar(255) );

create table catalog( 
sid int ,
pid int ,
cost int ,
foreign key(sid) references supplier(sid)  ,
foreign key(pid) references parts(pid) );

insert into supplier
values(10001,"Acme Widget","Banglore"),
        (10002,"Johns","Kolkata"),
        (10003,"Vimal","Mumbai"),
        (10004,"Reliance","Delhi");
        
 insert into parts
 values(20001,"Book","Red"),
       (20002,"Pen","Red"),
       (20003,"Pencil","Green"),
       (20004,"Mobile","Green"),
       (20005,"Charger","Black") ;
       
insert into catalog
values(10001,20001,10),
      (10001,20002,10),
      (10001,20003,30),
      (10001,20004,10),
      (10001,20005,10),
      (10002,20001,10),
      (10002,20002,20),
      (10003,20003,30),
      (10004,20003,40);
/* query 1 */      
select pname
from parts 
where pid in (
select pid from catalog ); 

/* query 2 */
select sname from supplier where sid =
(select sid from catalog 
group by sid 
having count(*) = (
select count(pid) from parts ));

/* query 3*/
select sname from supplier where sid in 
(select distinct sid from catalog where pid in 
(select pid from parts where color="red"));

/* query 4 */
select pname from parts where pid in 
( select c1.pid from catalog c1 where c1.pid not in 
(select distinct c.pid from catalog c where not c.sid = 10001));

/* query 4 */
select sid from catalog c 
where c.cost >
(select avg(cost) from catalog c1
where c1.pid = c.pid); 

/* query 5 */
select s.sname ,c.pid
from catalog c ,supplier s ,parts p 
where s.sid = c.sid and c.pid = p.pid and c.cost = 
(select max(c1.cost) from catalog c1  
 where c1.pid = c.pid );
 
 
 

