Show databases;
Create database Active_Case1;
Use Active_Case1;
Create Table Employees
(
emp_id int primary key not null,
emp_name text not null,
gender text not null,
birthday Date,
salary int not null,
branch_id int not null,
supervisor_id  int
);
show columns from Employees;
Create table Branch
(
branch_id int primary key not null,
branch_name varchar(20) not null,
mgr_id int
);
desc Branch;
alter table Branch
add foreign key(mgr_id)
references Branch(branch_id);
desc Branch;
alter table Employees 
add foreign key(supervisor_id)
references Employees(emp_id);

alter table Employees 
add foreign key(branch_id)
references Branch(branch_id);
show columns from Employees;



insert into Branch(branch_id,branch_name,mgr_id)
values
(1,'Mumbai',101),
(2,'Delhi',104),
(3,'Bangalore',102);
select * from Branch;

Insert into Employees(emp_id,emp_name,gender,birthday,salary,branch_id,supervisor_id)
values
(101,'Anand','M','1990/06/02',5000000,1,null),
(102,'Brijesh','M','1990/07/28',2500000,3,101),
(103,'Chandani','F','1992/09/03',1500000,1,102),
(104,'Dia','F','1992/09/27',1500000,2,102),
(105,'Faraz','M','1996/12/30',1000000,3,103);
select* from Employees;

Create table Branch_Supplier
(
branch_id int not null,
sup_name varchar(10) not null,
supply_type varchar(25) not null,
primary key(branch_id, sup_name)
);
desc Branch_Supplier;
drop table Branch_Supplier;
insert into Branch_Supplier(branch_id,sup_name,supply_type)
values
(1,'ABC','Stationary'),
(1,'PQR','Files'),
(2,'ABC','Stationary'),
(3,'ABC','Stationary'),
(3,'XYZ','Others');
select * from Branch_Supplier;

Create table Client
(
client_id int primary key not null,
client_name text not null,
branch_id int not null,
foreign key(branch_id)
references Branch(branch_id)
);
desc Client;
insert into Client(client_id,client_name,branch_id)
values
(401,'P',2),
(402,'Q',2),
(403,'R',3),
(404,'S',3);
select * from Client;

Create table Works_with
(
emp_id int not null,
client_id int not null,
total_sales int not null,
primary key(emp_id, client_id)
);
desc Works_with;
insert into Works_with(emp_id,client_id,total_sales)
Values
(104,401,5000000),
(104,402,7500000),
(102,403,2500000),
(105,404,1000000);
select * from Works_with;


desc Employees;
drop table Employees;
drop table Branch;
drop database Active_Case1;

