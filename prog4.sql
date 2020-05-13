/* student faculty */ 
/* program 4 */ 

create database faculty ;
use faculty ;
create table student(
snum int primary key ,
sname varchar(255),
major varchar(255),
lvl varchar(255),
age int );

create table faculty(
fid int primary key ,
fname varchar(255),
depid int );

create table class(
cname varchar(255),
meetsat time ,
room varchar(255),
fid int ,
foreign key(fid) references faculty(fid));

create table enrolled(
snum int ,
cname varchar(255) primary key );

alter table enrolled 
drop primary key ;

insert into Student values(1, 'jhon', 'CS', 'Sr', 19), (2, 'Smith', 'CS', 'Jr', 20), (3 , 'Jacob', 'CV', 'Sr', 20), (4, 'Tom ', 'CS', 'Jr', 20), (5, 'Rahul', 'CS', 'Jr', 20), (6, 'Rita', 'CS', 'Sr', 21);

insert into faculty values(11, 'Harish', 1000),(12, 'MV', 1000),(13 , 'Mira', 1001),(14, 'Shiva', 1002),(15, 'Nupur', 1000);

insert into Class values('class1', '10:15:16', 'R1', 14),('class10', '10:15:16', 'R128', 14),('class2', '10:15:20', 'R2', 12),('class3', '10:15:25', 'R3', 12),('class4', '20:15:20', 'R4', 14),('class5', '20:15:20', 'R3', 15),('class6', '13:20:20', 'R2', 14),('class7', '10:10:10', 'R3', 14);
insert into Enrolled values(1, 'class1'),(2, 'class1'),(3, 'class3'),(4, 'class3'),(5, 'class4'),(1, 'class5'),(2, 'class5'),(3, 'class5'),(4,'class5'),(5,'class5');

select distinct sname 
from Student,Faculty,Class,Enrolled
where fname='MV' AND Faculty.fid=Class.Fid and Student.snum=Enrolled.snum and Class.cname=Enrolled.cname and Student.lvl='Jr'; 

select cname
from Class
where room='R128' OR cname in ( select distinct cname 
                               from Enrolled
                               group by cname
                               having count(*)>=5);

select sname
from Student
where snum in (select e1.snum 
               from Enrolled e1,Enrolled e2,Class c1,Class c2
               where e1.snum=e2.snum and e1.cname=c1.cname and e2.cname=c2.cname and e1.cname<>e2.cname and c1.meetsat=c2.meetsat);

select fname
from Faculty
where not exists(select room from Class
                 except
                 select distinct c.room
                 from Class c
                 where c.fid=Faculty.fid);

select distinct fname
from Faculty
where 5>(select count(Enrolled.snum)
         from Enrolled,Class
         where Enrolled.cname=Class.cname and Class.fid=Faculty.fid);

select sname
from Student
where snum not in (select snum
                   from Enrolled);

select S.age, S.lvl
from Student S
group by S.age, S.lvl
having S.lvl in (select S1.lvl from Student S1
                 where S1.age = S.age
                 group by S1.lvl, S1.age
                 having count(*) >= all (select count(*)
                                         from Student S2
                                         where s1.age = S2.age
                                         group by S2.lvl, S2.age));


insert into enrolled values(1,'4B');
insert into enrolled values(2,'4B');
insert into enrolled values(3,'4C');
insert into enrolled values(4,'4B');
insert into enrolled values(5,'4A');
insert into enrolled values(6,'4B');
insert into enrolled values(7,'3B');
insert into enrolled values(8,'3B');
insert into enrolled values(9,'3B');
insert into enrolled values(10,'3A');

/* query 1*/
select  distinct s.sname 
from student s ,class c,enrolled e , faculty f 
where s.lvl ="jr" and s.snum = e.snum and e.cname = c.cname and c.fid = f.fid and f.fname = "prof. Sudha";

/*query 2 */
select distinct cname 
from class 
where room = "301" or cname = 
(select cname 
from enrolled 
group by cname 
having count(*) > 5) ;

/* query 3 */
select sname 
from student s, enrolled e , class c ,class c1
where e.cname = c.cname and c.meetsat = c1.meetsat and sname =
(select snum 
from enrolled 
group by snum 
having count(snum) = 2 );

/* query 4 */
select f.fname ,f.fid 
from class c, faculty f
group by c.fid 
having count(c.fid ) = 
(select count(*) 
from class );

/* query 5 */ 
select fid 
from class
where cname in 
(select cname 
from enrolled 
group by cname 
having count(*) < 5) ;

/* query 6*/ 
select sname 
from student 
where snum not in 
( select snum 
from enrolled );

/* query 7 */
create view extra 
as 
select age ,lvl, count(lvl) as lvlcount 
from student 
group by age ;
select age , lvl 
from extra 
where lvlcount in
(select max(lvlcount) 
from extra );





