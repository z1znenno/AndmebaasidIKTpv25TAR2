create database OlegBerez;
use OlegBerez;

create table auto (
	auto_id INT primary key,
	autoNumber CHAR(6) not null,
	mark VARCHAR(50) not null,
	mudel VARCHAR(50),
	varv VARCHAR(50),
	v_aasta int
);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (1, 'AV7819', 'Ford', 'Expedition', 'Indigo', 1999);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (2, 'QR3181', 'Cadillac', 'Eldorado', 'Puce', 1992);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (3, 'IB5919', 'Volvo', 'S60', 'Fuscia', 2006);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (4, 'NZ9250', 'Maybach', '62', 'Aquamarine', 2009);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (5, 'BA3590', 'Cadillac', 'DeVille', 'Green', 1996);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (6, 'ET4335', 'Toyota', '4Runner', 'Fuscia', 2009);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (7, 'AV6230', 'Holden', 'Monaro', 'Orange', 2004);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (8, 'AI4480', 'Mercedes-Benz', 'R-Class', 'Khaki', 2007);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (9, 'TG3356', 'GMC', 'Savana 1500', 'Violet', 2007);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (10, 'SQ4686', 'Hyundai', 'Sonata', 'Blue', 2003);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (11, 'AF8764', 'Mitsubishi', 'Lancer', 'Turquoise', 2010);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (12, 'QR3181', 'Mitsubishi', 'Mighty Max', 'Puce', 1986);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (13, 'QR1864', 'GMC', '3500', 'Teal', 1996);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (14, 'NH6128', 'Honda', 'Odyssey', 'Pink', 2004);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (15, 'QR6265', 'Ford', 'F-350 Super Duty', 'Goldenrod', 2006);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (16, 'SQ9811', 'Mercedes-Benz', 'M-Class', 'Khaki', 2003);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (17, 'NH2713', 'Acura', 'Legend', 'Purple', 1990);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (18, 'DL8985', 'Dodge', 'Ram Van B250', 'Mauv', 1993);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (19, 'DL7317', 'Dodge', 'Spirit', 'Blue', 1995);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (20, 'KE3467', 'Dodge', 'Stratus', 'Aquamarine', 2005);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (21, 'NH7338', 'Toyota', 'RAV4', 'Indigo', 2008);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (22, 'NZ8951', 'Chevrolet', 'Corvette', 'Goldenrod', 1966);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (23, 'UA5661', 'Infiniti', 'M', 'Khaki', 2009);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (24, 'AI1615', 'Chevrolet', 'Tracker', 'Puce', 2002);
insert into auto (auto_id, autoNumber, mark, mudel, varv, v_aasta) values (25, 'AI9907', 'Chevrolet', 'Camaro', 'Puce', 1970);

select * from auto;
--Andmete sorteerimine
--Kasvavas järjekorras
Select * from auto
order by v_aasta;
--Kahanevas järjekorras
Select * from auto
order by v_aasta desc;
--Kuvab ainult kaks veergu
SELECT mark, mudel FROM auto;
--kordavate väärtuse välistamine DISTINCT
SELECT DISTINCT mark FROM auto;
--võrdlemine
--1. suurem kui >, väiksem kui <, võrdub =
--leia kõik autod, kus on v_aasta 200 peale
select mark, mudel, v_aasta
from auto
where v_aasta >= 2000;
--leia kõik autod mis on v_aasta vahemikus 2000-2005
select mark, mudel, v_aasta
from auto
where v_aasta between 2000 and 2005;

select mark, mudel, v_aasta
from auto
where v_aasta >= 2000 and v_aasta <= 2005;

--2. võrdlemine tekst või sümbooliga
select mark, mudel, v_aasta
from auto
where mark like 'Ford';
--In lause kuvab vastavus loetelus -Соответствие перечислению
select mark, mudel, v_aasta
from auto
where mark in ('Ford', 'Nissan', 'Chevrolet');

--Ilma IN
select mark, mudel, v_aasta
from auto
where mark like 'Ford' or mark Like 'Nissan' or mark like 'Chevrolet';

--Vastavus mustrile - шаблон
--algab F tähega
select mark, mudel, v_aasta
from auto
where mark like 'F%';
--Lõpeb p -tähega
select mark, mudel, v_aasta
from auto
where mark like '%p';

--Sisaldab a-täht
select mark, mudel, v_aasta
from auto
where mark like '%a%';

--kuvada esimest 5 mudeli
select TOP 5 mudel, varv from auto
where varv like 'red'
order by varv;

--agregaat funktsioonid: SUM, MIN; MAX; AVG, COUNT
select COUNT(*) as autode_arv from auto;

select MAX(v_aasta) as Suurem_v_aasta from auto;
--Keerulisem variant
select mark, AVG(v_aasta) as keskmineAasta
from auto
group by mark;
