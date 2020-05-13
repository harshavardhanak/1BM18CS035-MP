/* banking */

create database banking ;
use banking ;
CREATE TABLE branch(
	branchname VARCHAR(20) NOT NULL,
	branchcity VARCHAR(20) NOT NULL,
	assets real NOT NULL,
	PRIMARY KEY(branchname));

CREATE TABLE bankaccount(
	accno int(13) NOT NULL UNIQUE,
	branchname VARCHAR(20) NOT NULL,
	balance REAL NOT NULL,
	PRIMARY KEY(accno),
	FOREIGN KEY(branchname) REFERENCES branch(branchname));

CREATE TABLE bankcustomer(
	customername VARCHAR(40) NOT NULL UNIQUE,
	customerstreet VARCHAR(30) NOT NULL,
	customercity VARCHAR(20) NOT NULL,
	PRIMARY KEY(customername));

CREATE TABLE depositer(
	customername VARCHAR(40) NOT NULL,
	accno int(13) NOT NULL UNIQUE,
	PRIMARY KEY(customername, accno),
	FOREIGN KEY(customername) REFERENCES bankcustomer(customername),
	FOREIGN KEY(accno) REFERENCES bankaccount(accno));
    
CREATE TABLE loan(
	loannumber int(14) NOT NULL UNIQUE,
	branchname VARCHAR(20) NOT NULL,
	amount REAL NOT NULL,
	PRIMARY KEY(loannumber));

create table borrower(
customername VARCHAR(40) NOT NULL,
loannumber int(14) NOT NULL UNIQUE,
FOREIGN KEY(customername) REFERENCES bankcustomer(customername),
FOREIGN KEY(loannumber) REFERENCES loan(loannumber));

INSERT INTO branch VALUES ("SBI_Chamarajpet", "Bangalore", 50000);
INSERT INTO branch VALUES ("SBI_ResidencyRoad", "Bangalore", 10000), ("SBI_ShivajiRoad", "Bombay", 20000), ("SBI_ParliamentRoad", "Delhi", 10000), ("SBI_JantarMantar", "Delhi", 20000);
INSERT INTO bankaccount VALUES (1, "SBI_Chamarajpet", 2000), (2, "SBI_ResidencyRoad", 5000), (3, "SBI_ShivajiRoad", 6000), (4, "SBI_ParliamentRoad", 9000), (5, "SBI_JantarMantar", 8000), (6, "SBI_ShivajiRoad", 4000), (8, "SBI_ResidencyRoad", 4000), (9, "SBI_ParliamentRoad", 3000), (10, "SBI_ResidencyRoad", 5000), (11, "SBI_JantarMantar", 2000);
INSERT INTO bankcustomer VALUES ("Avinash", "Bull_Temple_Road", "Bangalore"), ("Dinesh", "Bannergatta_Road", "Bangalore"), ("Mohan", "NationalCollege_Road", "Bangalore"), ("Nikil", "Akbar_Road", "Delhi"), ("Ravi", "Prithviraj_Road", "Delhi");

INSERT INTO depositer VALUES ("Avinash", 1), ("Dinesh", 2), ("Nikil", 4), ("Ravi", 5);
INSERT INTO loan VALUES (1, "SBI_Chamarajpet", 1000), (2, "SBI_ResidencyRoad", 2000), (3, "SBI_ShivajiRoad", 3000), (4, "SBI_ParliamentRoad", 4000), (5, "SBI_JantarMantar", 5000);	
INSERT INTO borrower VALUES("Avinash",1),("Dinesh",2),("Mohan",3),("Nikil", 4),("Ravi", 5);

/* query 1 */
select customername from depositer 
where accno in 
(select accno from bankaccount
where branchname = "SBI_Chamarajpet");

/* query 2 */

select customername from depositer 
where accno in 
(select accno from bankaccount 
where branchname in 
(select branchname from branch 
where branchcity = "Bangalore"));





  


