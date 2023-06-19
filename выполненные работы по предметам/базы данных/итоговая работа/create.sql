--create database Lib;
--go

use Lib;

create table book (
	id int identity(1, 1) not null primary key,
	name varchar(100) not null,
	pub_year int not null check(pub_year > 1900 and pub_year < 2100),
	price int not null check(price > 0)
);
go

create table client_card (
	series_number varchar(40) not null check(series_number like '[0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9][0-9][0-9]') primary key,
	surname varchar(40) not null,
	name varchar(40) not null,
	midname varchar(40) not null,
	b_date date not null,
	date_format as (convert(varchar(255), b_date, 104)),
	address_reg varchar(100) not null
);
go

create table supplier (
	id int identity(1, 1) not null primary key,
	name varchar(100) not null,
	[address] varchar(200) not null
);
go

create table supply (
	id int identity(1, 1) not null primary key,

	supplier_id int not null
	foreign key references supplier(id)
	on delete cascade
	on update cascade,

	book_id int not null 
	foreign key references book(id)
	on delete cascade
	on update cascade,

	sup_date date not null,
	date_format as (convert(varchar(255), sup_date, 104)),

	book_count int not null
);
go

create table [order] (
	id int identity(1, 1) not null primary key,

	book_id int not null 
	foreign key references book(id)
	on delete cascade
	on update cascade,

	client_card_id varchar(40) not null 
	foreign key references client_card(series_number)
	on delete cascade
	on update cascade,

	book_count_taken int not null,
	book_count_returned int not null,

	order_date date not null,
	date_format as (convert(varchar(255), order_date, 104))
);
go

create table publisher (
	id int identity(1, 1) not null primary key,
	name varchar(100) not null 
);
go

create table book_publisher (
	id int identity(1, 1) not null primary key,

	book_id int not null 
	foreign key references book(id)
	on delete cascade
	on update cascade,

	publisher_id int not null 
	foreign key references publisher(id)
	on delete cascade
	on update cascade
);
go

create table author (
	id int identity(1, 1) not null primary key,
	surname varchar(40) not null,
	name varchar(40) not null,
	midname varchar(40) not null
);
go

create table book_author (
	id int identity(1, 1) not null primary key,

	book_id int not null 
	foreign key references book(id)
	on delete cascade
	on update cascade,

	author_id int not null 
	foreign key references author(id)
	on delete cascade
	on update cascade
);
go