/* insurance */
create database insurance ;
use insurance ;
create table person(
driverid varchar(255) primary key ,
dname varchar(255),
address varchar(255));

create table car(
regno varchar(255) primary key  ,
model varchar(255),
cyear int );

create table accident(
reportnumber int ,
adate date ,
location varchar(255) );

create table owns(
driverid varchar(255) ,
regno varchar(255) ,
foreign key(driverid) references person(driverid) ,
foreign key(regno) references car(regno) );

create table participated(
driverid varchar(255) ,
regno varchar(255) ,
reportnumber int ,
damageamount int ,
foreign key(driverid) references owns(driverid)); 

insert into person values('a01','richard','srinivas nagar'),
                         ('a02','pradeep','rajaji nagar'),
                         ('a03','smith','ashok nagar'),
                         ('a04','venu','n r colony'),
                         ('a05','jhon','hanumanth nagar');
                         
insert into car values('ka052250','indica',1990),
                      ('ka031181','lancer',1957),
                      ('ka095477','toyota',1998),
                      ('ka053408','honda',2008),
                      ('ka041702','audi',2005);
                      
insert into owns values('a01','ka052250'),
                       ('a02','ka053408'),
                       ('a03','ka031181'),
                       ('a04','ka095477'),
                       ('a05','ka041702');
                       
insert into accident values(11,'2003-01-01','mysore road'),
						(12,'2004-02-02','south end circle'),
                        (13,'2003-01-21','bull temple road'),
                        (14,'2008-02-17','mysore road'),
                        (15,'2005-03-04','kanakapura road');
                        
insert into participated values('a01','ka052250',11,10000),
                               ('a02','ka053408',12,50000),
                               ('a03','ka095477',13,25000),
                               ('a04','ka031181',14,3000),
                               ('a05','ka041702',15,5000);
                               
update participated 
set damageamount = 25000 
where reportnumber = 12 ;

select count(c.regno) as total  
from car c , participated p 
where c.regno = p.regno and c.cyear = 2008 ;

select count(c.regno) , model 
from car c , participated p
where c.regno = p.regno  
group by model ;