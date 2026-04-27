create database OlegDb;
use OlegDb;

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

create table maakonnad(
maakondId int primary key identity(1,1),
maakondNimi varchar(25) UNIQUe
);

alter table linnad add maakondId int;
select * from Linnad;
alter table linnad add constraint fk_maakond
foreign key (maakondId) references maakonnad(maakondId);

insert into maakonnad
values('Harjumaa'), ('Pärnumaa'), ('Virumaa');

select * from maakonnad;
insert into linnad(linnaNimi, rahvaarv, maakondId)
values('Tallinn', 600000, 1),
('Rakvere', 150000, 3);

select * from Linnad inner join maakonnad 
on Linnad.maakondId = maakonnad.maakondId;


--Triger mis jälgib kak seostatud tabelit
create trigger linnaLisamine
ON Linnad
FOR insert
as 
insert into Logi(kuupaev, andmed, kasutaja)
select 
getdate(), 
CONCAT
(
	' | Lisatud linn: ', inserted.linnaNimi,
	' | rahvaarv: ', inserted.rahvaarv, 
	' | maakond: ', m.maakondNimi
),
SYSTEM_USER
from inserted inner join maakonnad m
on inserted.maakondId=m.maakondId;

insert into linnad(linnaNimi, rahvaarv, maakondId)
values('Pärnu', 1000000, 2);

delete from Linnad where linnID = 3;

select * from Logi;

create trigger linnaKustutamine
on Linnad
for delete
as 
insert into Logi(kuupaev, andmed, kasutaja)
select 
getdate(), 
CONCAT
(
	' | Kustutatud linn: ', deleted.linnaNimi,
	' | rahvaarv: ', deleted.rahvaarv, 
	' | maakond: ', m.maakondNimi
),
SYSTEM_USER
from deleted inner join maakonnad m
on deleted.maakondId = m.maakondId;

delete from Linnad where linnID = 1;

drop trigger linnaKustutamine;

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
	' | maakond: ', m1.maakondNimi,
	
	' | Uued linna andmed: ', i.linnaNimi,
	' | rahvaarv: ', i.rahvaarv, 
	' | maakond: ', m2.maakondNimi
),
SYSTEM_USER
from deleted d
inner join inserted i on d.linnID = i.linnID
inner join maakonnad m1 on d.maakondId = m1.maakondId
inner join maakonnad m2 on i.maakondId = m2.maakondId;

select * from Linnad;
select * from maakonnad;

update Linnad set maakondId = 1 where linnID = 4;

select * from Logi;
