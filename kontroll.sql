create database veebipoodBerezevski;
USE veebipoodBerezevski;

--Tabel Categories
create table Categories
(
	category_id int primary key identity (1, 1),
	category_name varchar(30) unique
);

insert into Categories(category_name)
values('Arvutid'),('Telefonid'),('Telerit'),('Kõrvaklapid'),('Konsoolid');
select * from Categories;

--Tabel Brands
create table Brands
(
	brand_id int primary key identity (1, 1),
	brand_name varchar(30) unique
);

insert into Brands(brand_name)
values('Dell'),('Apple'),('Samsung'),('HP'),('Playstation');
select * from Brands;

--Tabel Products
create table Products
(
	products_id int primary key identity (1, 1),
	product_name varchar(50) not null,
	brand_id int,
	foreign key (brand_id) references Brands(brand_id),
	category_id int,
	foreign key (category_id) references categories(category_id),
	model_year int,
	list_price decimal(7,2)
);
select * from Products;

insert into Products(product_name, brand_id, category_id, model_year, list_price)
values('Apple TV', 2, 3, 2021, 1299.99),
('Notebook', 1, 1, 2018, 499.99),
('Phone Z flip 4', 3, 2, 2021, 2000.00),
('HP Kõrvaklapid', 4, 4, 2006, 109.00),
('Playstation 4', 5, 5, 2018, 399.99);
select * from Products;

-- Tabel stocks — kaks PK
create table Stocks
(
	store_id int,
	product_id int,
	quanity int
	primary key (store_id, product_id),
	foreign key (store_id) references Stores(store_id),
	foreign key (product_id) references Products(products_id),
);

insert into Stocks(store_id, product_id, quanity)
values(1, 1, 1000),
(2, 3, 1430),
(3, 5, 1983),
(4, 4, 1200),
(5, 2, 2010);
select * from Stocks;


--Tabel Stores
create table Stores
(
	store_id int primary key identity(1,1),
	store_name varchar (30) unique not null,
	phone varchar (15),
	email varchar(20) not null,
	street varchar (30) not null,
	city varchar(20),
	zip_code varchar(6) not null
);
select * from Stores;

insert into Stores(store_name, phone, email, street, city, zip_code)
values('Euroniks', '+37255865245', 'euroniks@gmail.com', 'Linnamae 12', 'Tallinn', '13943'),
('Click', '+37255863245', 'click@gmail.com', 'Narva mnt. 19', 'Tallinn', '13916'),
('Upgrade', '+37255655095', 'upgrade@gmail.com', 'Mustamae 16', 'Tallinn', '13987'),
('ArvutiTark', '+37255874675', 'arvutiTark@gmail.com', 'K.Karberi 24', 'Tallinn', '13952'),
('Rimi', '+37257600245', 'rimi@gmail.com', 'Oismae tee 87', 'Tallinn', '13990');
select * from Stores;

--Tabel Staffs

create table Staffs
(
	staff_id int primary key identity(1,1),
	first_name varchar(10),
	last_name varchar(10) unique,
	email varchar(25),
	phone varchar(15) unique,
	active bit,
	store_id int,
	foreign key(store_id) references Stores(store_id),
	manager_id int
);
select * from Staffs;
drop table Staffs;

insert into Staffs(first_name, last_name, email, phone, active, store_id)
values('Slava', 'Maksimov', 'slavam@gmail.com', '+37252319381', 1, 1),
('Arseni', 'Moroz', 'arsenim@gmail.com', '+37252329381', 0, 5),
('Vlada', 'Baka', 'vladab@gmail.com', '+37253439381', 1, 3),
('Artem', 'Sartin', 'artems@gmail.com', '+37252319865', 1, 2),
('Sasha', 'Martin', 'sasham@gmail.com', '+37252321381', 0, 4);
select * from Staffs;


--Tabel Customers
create table Customers
(
	customer_id int primary key identity (1,1),
	first_name varchar(10),
	last_name varchar(15),
	phone varchar(15),
	email varchar(40),
	street varchar(20),
	city varchar(15),
	zip_code varchar(5),
);

select * from Customers;

insert into Customers(first_name, last_name, phone, email, street, city, zip_code)
values('Oleg', 'Berez', '+37258354312', 'olegb@gmail.com', 'Linnamae tee 13' , 'Tallinn' , '13998'),
('Artemii', 'Moroz', '+37258353132', 'artemiim@gmail.com', 'Narva mnt. 89' , 'Tallinn' , '13945'),
('Samuil', 'Yakov', '+37258654312', 'samuily@gmail.com', 'Oismae tee 23' , 'Tallinn' , '13976'),
('Samar', 'Volkov', '+37258320312', 'samarv@gmail.com', 'Tallinn mnt. 112' , 'Tallinn' , '13967'),
('Dmitri', 'Yeszhe', '+37258589302', 'dmitriy@gmail.com', 'Haabersti 6' , 'Tallinn' , '13980');
select * from Customers;


--Tabel Orders
