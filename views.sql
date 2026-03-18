create database IKT_PV25;
use IKT_PV25;

CREATE TABLE uudised(
uudisID int primary key identity(1,1),
uudisPealkiri varchar(50),
kuupaev date,
kirjeldus TEXT,
ajakirjanikID int)

CREATE TABLE ajakirjanik(
ajakirjanikID int primary key identity(1,1),
nimi varchar(50),
telefon varchar(13));

ALTER TABLE uudised ADD CONSTRAINT fk_ajakirjanik
FOREIGN KEY (ajakirjanikID)
REFERENCES ajakirjanik(ajakirjanikID);

INSERT INTO ajakirjanik(nimi,telefon)
values ('Lev','5757755874'),('Anton','57357597')

SELECT * FROM ajakirjanik;


INSERT into uudised(uudisPealkiri,kuupaev,ajakirjanikID)
values ('Homme on ises töö päev','2025-03-12',1),
('Täna on andmebaaside tund','2025-03-12',1),
('Täna on vihane ilm','2025-03-12',2)

select * from ajakirjanik;
Select * from uudised;

--õige päring
SELECT * FROM uudised,ajakirjanik
WHERE uudised.ajakirjanikID=ajakirjanik.ajakirjanikID;
--sama päring alias-nimedega
SELECT u.uudisPealkiri, a.nimi FROM uudised as u,ajakirjanik as a
WHERE u.ajakirjanikID=a.ajakirjanikID;

--salvestame vaade
create view loodudUudised as 
SELECT u.uudisPealkiri, a.nimi 
FROM uudised as u,ajakirjanik as a
WHERE u.ajakirjanikID=a.ajakirjanikID;

--kutsume salvestatud vaade
select * from loodudUudised
where nimi like 'Lev';

--INNER JOIN - sisemine ühendamine
create view kuuPaevaUudised as
SELECT u.uudisPealkiri,a.nimi as autor, kuupaev
FROM uudised as u INNER JOIN ajakirjanik as a
ON u.ajakirjanikID=a.ajakirjanikID;	

--kuvame salvesttud view päring
select * from kuuPaevaUudised;

select uudisPealkiri, YEAR(kuupaev) as aasta 
from kuuPaevaUudised;

CREATE TABLE ajaleht(
ajalehtID int primary key identity(1,1),
ajalehtNimetus varchar(50));
INSERT ajaleht(ajalehtNimetus)
values ('Postimees'),('Delfi');

ALTER TABLE uudised ADD ajalehtID int;
ALTER TABLE uudised ADD constraint fk_ajaleht
FOREIGN KEY (ajalehtID) References ajaleht(ajalehtID);

update uudised set ajalehtID = 2;

select * from uudised;

--loome vaade
create view AutoriUudisedAjalehes as
SELECT u.uudisPealkiri,a.nimi as autor,aj.ajalehtNimetus, u.kuupaev
FROM (uudised as u INNER JOIN ajakirjanik as a
ON u.ajakirjanikID=a.ajakirjanikID)
INNER JOIN ajaleht as aj
ON u.ajalehtID=aj.ajalehtID;

drop view AutoriUudisedAjalehes;

select * from AutoriUudisedAjalehes;

update AutoriUudisedAjalehes set kuupaev = '2026-03-18'
