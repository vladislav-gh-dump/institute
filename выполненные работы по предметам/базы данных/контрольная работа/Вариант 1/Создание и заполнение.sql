create database Employees

use Employees


create table position (
	id int identity(1, 1) not null primary key, 
	name varchar(50) not null,
	salary int not null 
)
go

create table employee (
	id int identity(1, 1) not null primary key,
	surname varchar(30) not null,
	name varchar(30) not null,
	mid_name varchar(30) not null,
	position_id int not null foreign key references position(id)
	on update cascade
	on delete cascade,
	bdate date,
	date_format as (convert(varchar(255), bdate, 104))
)
go

create table work (
	id int identity(1, 1) not null primary key,
	employee_id int not null foreign key references position(id)
	on update cascade
	on delete cascade,
	[month] varchar(40) not null,
	[year] int not null,
	prize_pers int not null 
)
go


insert position 
values 
('��������', 17000),
('��������', 29000),
('��������', 10000),
('�������������', 15000)


insert employee 
values 
('������', '����', '��������', 1, '10.11.1983'),
('������', '����', '��������', 2, '04.04.1987'),
('��������', '����', '�����������', 3, '17.05.1978'),
('�����', '�����', '����������', 4, '13.07.1989')


insert work 
values 
(1, '��������', 2011, 50),
(2, '��������', 2011, 75),
(3, '��������', 2011, 50),
(4, '��������', 2011, 50),
(1, '�������', 2011, 100),
(2, '�������', 2011, 200),
(3, '�������', 2011, 100),
(4, '�������', 2011, 100)