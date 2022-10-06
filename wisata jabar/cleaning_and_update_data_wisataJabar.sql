create database data; -- make a database
use data; -- use a database 

select*from wisatajabar;-- run a 'wisatajabar' table

desc wisatajabar;-- describe table of 'wisatajabar'

-- in field 'Wisatawan Mancanegara (KA)' and 'Wisatawan Nusantara (KA)' bust be in integer, remove '-' to 0 value, and change data type to integer

start transaction; -- to avoid a mistake when update a table

SET SQL_SAFE_UPDATES = 1; -- to turn off safe mode when update a table (change to 0 to turn the mode) ~don't forget change to 1 again

update wisatajabar
set `Wisatawan Mancanegara (KA)`= replace(`Wisatawan Mancanegara (KA)`,',','') 
where `Wisatawan Mancanegara (KA)` like '%,%'; -- replace ',' to '' in 'Wisatawan Mancanegara (KA)' coloumn

update wisatajabar
set `Wisatawan Nusantara (KA)`= replace(`Wisatawan Nusantara (KA)`,',','') 
where `Wisatawan Nusantara (KA)` like '%,%';  -- replace ',' to '' in 'Wisatawan Nusantara (KA)' coloumn

update wisatajabar
set `Wisatawan Mancanegara (KA)`= replace(`Wisatawan Mancanegara (KA)`,'-',0) 
where `Wisatawan Mancanegara (KA)` like '%-%'; -- replace '-' to 0 in 'Wisatawan Mancanegara (KA)' coloumn to avoid an error when modify datatype to integer

delete
from wisatajabar
where `Kabupaten/Kota` ='';-- delete a row in kabupaten/kota when the row is empty

commit;-- if the result, work as you want you can run the commit and if not run 'rollback'

alter table wisatajabar
modify `Wisatawan Mancanegara (KA)` int;-- change datatype of 'Wisatawan Mancanegara (KA)'

alter table wisatajabar
modify `Wisatawan Nusantara (KA)` int;-- change datatype of 'Wisatawan Nusantara (KA)'

select*from wisatajabar;

create view wisata_jabar_update as
select 
ltrim(`Kabupaten/Kota`) as 'Kabupaten/Kota', 
ltrim(`Rumah Makan`) as 'Rumah Makan', 
ltrim(Restoran) as Restoran, 
ltrim(`Wisatawan Mancanegara (OW)`) as 'Wisatawan Mancanegara(Object Wisata)',
ltrim(`Wisatawan Nusantara (OW)`) as 'Wisatawan Nusantara(Object Wisata)', 
ltrim(`Wisatawan Mancanegara (KA)`) as 'Wisatawan Mancanegara(Akomodasi)',
ltrim(`Wisatawan Nusantara (KA)`) as 'Wisatawan Nusantara(Akomodasi)'
from wisatajabar; -- make a spesific table view


select*from wisata_jabar_update; -- run a view

