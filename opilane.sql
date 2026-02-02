create database berezevskiSQL;
use berezevskiSQL;

-- Tabeli loomine
create table opilane
(
	opilaneID int primary key identity(1, 1),
	eesnimi varchar(25),
	perekonnanimi varchar(30) not null unique,
	synniaeg date,
	aadress text,
	kas_opib bit
);
-- kuvab tabeli, * - kõik väljad
select * from opilane;

--Tabeli kustutamine
drop table opilane;

--Andmete lisamine tabelisse opilane
insert into opilane(eesnimi, perekonnanimi, synniaeg, kas_opib)
values ('Yarik', 'Berezevski', '2025-12-12', 1)
select * from opilane

--Lisamine 3. kirjet korraga
insert into opilane(eesnimi, perekonnanimi, synniaeg, kas_opib)
values ('Yarik', 'Berezevski', '2025-12-12', 1),
('Yarik', 'Berezevs', '2025-12-12', 1),
('Yarik', 'Berezevsi', '2025-12-12', 1),
('Yarik', 'Berezev', '2025-12-12', 1);
select * from opilane
