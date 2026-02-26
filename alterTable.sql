create database iktpv25_1B;

use iktpv25_1B;

create table kasutaja
(
	kasutaja_id int primary key identity(1,1),
	kasutaja_nimi varchar(25) not null,
	parool char(10) not null
);
select * from kasutaja;

insert into kasutaja(kasutaja_nimi, parool)
values('Oleg', 'testik');

--uue veeru lisamine
ALTER TABLE kasutaja ADD epost varchar(20);

update kasutaja set epost='test@test.ee' where kasutaja_id=1;

--Veeru kustutamine
ALTER TABLE kasutaja DROP COLUMN epost;
--Veeru andmetüübi muutmine
alter table kasutaja alter column parool varchar(25);

--Protseduuri tabeli muutmiseks loomine
create procedure alterTable
@valik varchar(20),
@tabeliNimi varchar(25),
@veeruNimi varchar(25),
@tyyp varchar(20)=null
as
begin
	declare @sql as varchar(max)
	set @sql = case
	when @valik = 'add' then
	concat('ALTER TABLE ', @tabeliNimi, ' ADD ', @veeruNimi, ' ', @tyyp)
	when @valik = 'drop' then
	concat('ALTER TABLE ', @tabeliNimi, ' DROP COLUMN ', @veeruNimi)
	END;
	print @sql;
	Begin
	exec (@sql)
	end;
end;

--kutse
exec alterTable @valik = 'add', @tabeliNimi = 'kasutaja', @veeruNimi = 'mobiil', @tyyp = 'char(13)';
exec alterTable @valik = 'drop', @tabeliNimi = 'kasutaja', @veeruNimi = 'mobiil';
