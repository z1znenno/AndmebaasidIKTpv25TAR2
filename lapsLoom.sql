--Select kahe tabeli põhjal
create database select2tabeli;
use select2tabeli;

--Laps/loom tabelid

CREATE TABLE laps(

lapsID int not null PRIMARY KEY identity(1, 1),

nimi varchar(40) not null,

pikkus smallint,

synniaasta int null,

synnilinn varchar(15)

)
insert into laps(nimi, pikkus, synniaasta, synnilinn)
values
('Kirill', 156, 2005, 'Tallinn'),
('Andrey', 128, 2012, 'Pärnu'),
('Sasha', 146, 2007, 'Jõhvi'),
('Artem', 173, 2011, 'Võru'),
('Yarik', 164, 2009, 'Tartu');
select * from laps;

CREATE TABLE loom(

loomID int not null PRIMARY KEY identity(1,1),

nimi varchar(40) not null,

kaal smallint,

lapsID int,

FOREIGN KEY (lapsID) REFERENCES laps(lapsID)  --вставляем название таблицы и на что ссылается

)

insert into loom(nimi, kaal, lapsID)
values
('kass Sherry', 6, 2),
('koer Mihail', 2, 4),
('kilpkonn Vasili', 8, 4),
('kass Mir', 4, 5),
('Ämblik Goša', 6, 2);

update loom set lapsID = 1 where loomID = 5
select * from loom;

--Alias-nimede kasutamine
SELECT l.nimi, l.kaal, la.nimi FROM loom as l;

--Sisemine ühendamine
SELECT * FROM laps, loom; --Nii ei tohi kirjutada, sest 1.tabeli kirjed korrutakse 2. tabeli kirjaga

SELECT * FROM laps, loom
WHERE loom.lapsID = laps.lapsID; --Õige päring

SELECT * FROM laps as lp, loom as l
WHERE l.lapsID = lp.lapsID; --Õige päring, Alias-nimedega

--kitsendame päringu
SELECT lp.nimi as 'Lapse nimi', l.nimi as 'Looma nimi', l.kaal, lp.synnilinn FROM laps as lp, loom as l
WHERE l.lapsID = lp.lapsID;

--INNER JOIN ühendamine
SELECT * FROM laps as lp INNER JOIN loom as l
ON l.lapsID = lp.lapsID;

SELECT lp.nimi as 'Lapse nimi', l.nimi as 'Looma nimi', l.kaal, lp.synnilinn 
FROM laps as lp INNER JOIN loom as l
ON l.lapsID = lp.lapsID;
update loom set kaal = 10 where loomID = 2;

--LEFT JOIN — näitab kõik lapsed isegi kui puudub loom
SELECT lp.nimi as 'Lapse nimi', l.nimi as 'Looma nimi', l.kaal, lp.synnilinn 
FROM laps as lp LEFT JOIN loom as l
ON l.lapsID = lp.lapsID;

--RIGHT JOIN
SELECT lp.nimi as 'Lapse nimi', l.nimi as 'Looma nimi', l.kaal, lp.synnilinn 
FROM laps as lp RIGHT JOIN loom as l
ON l.lapsID = lp.lapsID;

--CROSS JOIN korrutatud tabelid
SELECT lp.nimi as 'Lapse nimi', l.nimi as 'Looma nimi', l.kaal, lp.synnilinn 
FROM laps as lp CROSS JOIN loom as l

--Create tabel varjupaik
CREATE TABLE varjuPaik(

varjupaikID int not null PRIMARY KEY identity(1, 1),

koht varchar(50) not null,

firma varchar(30)

)

alter table loom add varjupaikID int;
alter table loom add constraint fk_varjupaik
foreign key(varjupaikID) references varjupaik(varjupaikID);

insert into varjuPaik(koht, firma)
values
('Pljassaare', 'Varjupaikade MTÜ');
select * from varjuPaik;
update loom set varjupaikID = 1;
select * from loom

--Kolme tabeli põhjal
SELECT lp.nimi as 'Lapse nimi', l.nimi as 'Looma nimi', l.kaal, lp.synnilinn, v.koht, v.firma 
FROM laps as lp, loom as l, varjuPaik as v
WHERE l.lapsID = lp.lapsID and l.varjupaikID = v.varjupaikID;

--sama inner joiniga
SELECT lp.nimi as 'Lapse nimi', l.nimi as 'Looma nimi', l.kaal, lp.synnilinn, v.koht, v.firma 
FROM (laps as lp INNER JOIN loom as l
ON l.lapsID = lp.lapsID) INNER JOIN varjuPaik as v
ON l.lapsID = lp.lapsID and l.varjupaikID = v.varjupaikID;
