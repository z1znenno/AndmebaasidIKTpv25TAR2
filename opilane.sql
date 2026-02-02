create database berezevskiSQL;
use berezevskiSQL;

-- Tabeli loomine
create table opilane
(
	opilaneID int primary key identity(1, 1),
	eesnimi varchar(25),
	perekonnanimi varchar(30) not null,
	synniaeg date,
	aadress text,
	kas_opib bit
);
select * from opilane;
