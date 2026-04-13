create database OlegBerez;
use OlegBerez;

--tabel Linnad
create table Linnad
(
	linnID int primary key identity(1,1),
	linnaNimi varchar(50) unique,
	rahvaarv int not null
);

--tabel Logi
create table Logi
(
	logID int primary key identity(1,1),
	kuupaev datetime,
	andmed text,
	kasutaja varchar(40)
);

--insert triger
create trigger linnaLisamine
ON Linnad
FOR insert
as 
insert into Logi(kuupaev, andmed)
select getdate(), inserted.linnaNimi from inserted;
--kontrollimiseks tuleb lisada uus linn tabelisse linnad
insert into Linnad(linnaNimi, rahvaarv)
values('Tallinn', 600000);
select * from Linnad;
select * from Logi;

--Kutsutamine triger
drop trigger linnaLisamine;

create trigger linnaLisamine
ON Linnad
FOR insert
as 
insert into Logi(kuupaev, andmed)
select 
getdate(), 
CONCAT
(
	' | Lisatud linn: ', inserted.linnaNimi,
	' | rahvaarv: ', inserted.rahvaarv, 
	' | Id: ', inserted.linnID
)
from inserted;

--Kontrollime
insert into Linnad(linnaNimi, rahvaarv)
values ('Tapa', 68732);
select * from Linnad;
select * from Logi;

-- DELETE triger
create trigger linnaKustutamine
on Linnad
for delete
as 
insert into Logi(kuupaev, andmed)
select 
getdate(), 
CONCAT
(
	' | Kustutatud linn: ', deleted.linnaNimi,
	' | rahvaarv: ', deleted.rahvaarv, 
	' | Id: ', deleted.linnID
)
from deleted;

delete from Linnad where linnID=2;
select * from Linnad;
select * from Logi;

-- UPDATE triger
create trigger linnaUuendamine
on Linnad
for update
as 
insert into Logi(kuupaev, andmed, kasutaja)
select 
getdate(), 
CONCAT
(
	' | Vana linna andmed: ', d.linnaNimi,
	' | rahvaarv: ', d.rahvaarv, 
	' | Id: ', d.linnID,
	
	' | Uued linna andmed: ', i.linnaNimi,
	' | rahvaarv: ', i.rahvaarv, 
	' | Id: ', i.linnID
),
SYSTEM_USER
from deleted as d inner join inserted as i
on d.linnID=i.linnID;

--Kontrollime
select * from Linnad;
update Linnad set linnaNimi = 'Valga' where linnID = 4;
select * from Linnad;
select * from Logi;

--lisame kasutajaNimi logi tabelisse

alter table Logi add kasutaja varchar(40);

update Logi set kasutaja = SYSTEM_USER;

create trigger linnaLisKus
on Linnad
for insert, delete
as 
begin
	set nocount on;
	insert into Logi(kuupaev, andmed, kasutaja)
	select 
	getdate(), 
	CONCAT
	(
		' | Vana linna andmed: ', inserted.linnaNimi,
		' | rahvaarv: ', inserted.rahvaarv, 
		' | Id: ', inserted.linnID
	),
	SYSTEM_USER
	from inserted

	union all

	select
	getdate(), 
	CONCAT
	(
		' | kustutatud linn: ', deleted.linnaNimi,
		' | rahvaarv: ', deleted.rahvaarv, 
		' | Id: ', deleted.linnID
	),
	SYSTEM_USER
	from deleted

end;

disable trigger linnaLisamine on linnad;
disable trigger linnaKustutamine on linnad;

select * from Linnad;

insert into Linnad(linnaNimi, rahvaarv)
values('test', 587329);

delete from Linnad where linnID = 6;

select * from linnad
select * from Logi;

create table auto
(
	autoID int primary key identity(1,1),
	autoNr varchar(6),
	omanik varchar(50),
	mark varchar(30),
	aasta int
);

create trigger autoLisamine
ON auto
FOR insert
as 
insert into Logi(kuupaev, andmed, kasutaja)
select 
getdate(), 
CONCAT
(
	' | Lisatud auto: ', inserted.autoNr,
	' | Auto omanik: ', inserted.omanik, 
	' | Auto mark: ', inserted.mark,
	' | Auto aasta: ', inserted.aasta,
	' | Id: ', inserted.autoID
),
system_user
from inserted;

insert into auto (autoNr, omanik, mark, aasta)
values ('123ABC', 'Yarik Baka', 'Toyota', 2018);
select * from auto;
select * from Logi;

create trigger autoKutsutamine
ON auto
FOR delete
as 
insert into Logi(kuupaev, andmed, kasutaja)
select 
getdate(), 
CONCAT
(
	' | Kustutatud auto: ', deleted.autoNr,
	' | Auto omanik: ', deleted.omanik, 
	' | Auto mark: ', deleted.mark,
	' | Auto aasta: ', deleted.aasta,
	' | Id: ', deleted.autoID
),
system_user
from deleted;


delete from auto where autoID = 1;
select * from auto;
select * from Logi;

create trigger autoUuedamine
ON auto
FOR update
as 
insert into Logi(kuupaev, andmed, kasutaja)
select 
getdate(), 
CONCAT
(
	' | Vana auto: ', d.autoNr,
	' | Auto omanik: ', d.omanik, 
	' | Auto mark: ', d.mark,
	' | Auto aasta: ', d.aasta,
	' | Id: ', d.autoID,

	' | Uus auto: ', i.autoNr,
	' | Auto omanik: ', i.omanik, 
	' | Auto mark: ', i.mark,
	' | Auto aasta: ', i.aasta,
	' | Id: ', i.autoID
),
system_user
from deleted as d inner join inserted as i
on d.autoID = i.autoID;

select * from auto;
update auto set autoNr = '321ABC', omanik = 'Vitali Abdulov' where autoID = 2;
select * from auto;
select * from Logi;

