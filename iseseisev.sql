--Tabel Categories
create table Categories
(
	category_id int primary key identity (1, 1),
	category_name varchar(30) unique
);

insert into Categories(category_name)
values('Arvutid'),('Telefonid'),('Telerit'),('Kõrvaklapid'),('Konsoolid');
select * from Categories;


-- lisan category_name
create procedure lisadaCategories
@category_name varchar (30)
as
begin
insert into Categories(category_name)
values (@category_name);
select * from Categories;
end;

--kutse
exec lisadaCategories 'Pesemasinad';


--uuenda category
create procedure uuendataCategories
@id int,
@uus_category varchar (30)
as 
begin
select * from Categories;
update Categories set category_name=@uus_category where category_id = @id;
select * from Categories;
end

--kutse
exec uuendataCategories 6, 'Klaviatuur';


--Kutsuda Category
create procedure kutsudaCategory
@id int
as
begin
select * from Categories;
delete Categories where category_id = @id;
select * from Categories;
end;

--kutse
exec kutsudaCategory 6;
