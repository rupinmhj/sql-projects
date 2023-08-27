-- shows all the column of the table
SELECT * FROM sdl.aven_organization;

desc sdl.aven_organization;

-- shows specific column of the table
SELECT product FROM sdl.aven_organization;

-- Add new column to table
alter table sdl.aven_organization add customerid int;

SELECT customerid FROM sdl.aven_organization;

-- drop the column
alter table sdl.aven_organization drop column customer;

alter table sdl.aven_organization add guidid int;

alter table sdl.aven_organization drop column guidno;

ALTER TABLE sdl.aven_organization 
ADD COLUMN guidno INT AUTO_INCREMENT PRIMARY KEY;

alter table sdl.aven_organization 
modify column guidno int after guid;

SELECT guidno FROM sdl.aven_organization;


alter table sdl.aven_organization
add column  phoneno int;

-- add the values to newly added column table
update sdl.aven_organization set phoneno=5571090
where guidno=4;

update sdl.aven_organization set phoneno=5553324
where guidno=6;


-- update sdl.aven_organization set customerid=145 where 
SELECT * FROM sdl.aven_organization;

-- Delete record from table
update sdl.aven_organization set phoneno=null
where guidno=4;

-- change the datatype of the column
alter table sdl.aven_organization
modify column phoneno varchar(10);

-- view specific columns
-- sort result (by default is ascending)
select guidno, guid from sdl.aven_organization
order by guidno desc;

-- View specific row
-- top: show only the first two
SELECT * FROM sdl.aven_organization LIMIT 2;

-- show only the last two row
SELECT * FROM sdl.aven_organization order by guidno desc LIMIT 2;



-- Save table to another table 
use sdl;
create table sdl.temp3(id int);
CREATE TEMPORARY TABLE temp3 SELECT DISTINCT guid FROM sdl.aven_organization;

-- select distinct guid into temp from sdl.aven_organization;
select * from temp;

-- like search something
select * from sdl.aven_organization where product like 'M%';
-- regex
SELECT * FROM sdl.aven_organization WHERE product REGEXP '^M';

SELECT * FROM sdl.aven_organization WHERE latest_fico_date REGEXP '20220?' ;

select latest_fico_date,product, avg(latest_fico) from sdl.aven_organization where status='active' group by latest_fico_date having avg(latest_fico)>700;


-- in search something
select * from sdl.aven_organization where product in ('M1Finance');

-- counting 
select count(*) from sdl.aven_organization where product like 'M%';

-- >(search something) 
select * from sdl.aven_organization where product >'Deserve BlockFi' order by product;
-- it checks if the value in the "product" column is alphabetically greater than 'Deserve BlockFi'. The ">" operator is used for the comparison, meaning it will return true if the value in the "product" column is greater in alphabetical order than 'Deserve BlockFi'.

-- <>(not equal)
select * from sdl.aven_organization where product <>'Deserve BlockFi';

-- check null values
select * from sdl.aven_organization where margin IS NULL;

-- check not null values
select * from sdl.aven_organization where margin IS NOT NULL;

-- MAX 
SELECT MAX(monthly_income) FROM sdl.aven_organization;

-- MIN
SELECT MIN(monthly_income)  FROM sdl.aven_organization;

-- AVERAGE
SELECT avg(monthly_income)  FROM sdl.aven_organization;
-- SELECT avg(monthly_income),status  FROM sdl.aven_organization group by status,monthly_income;

-- having
select latest_fico, count(latest_fico) from sdl.aven_organization  group by latest_fico,latest_fico_date having count(latest_fico)>400;
select status, count(latest_fico) from sdl.aven_organization  group by latest_fico,status having count(latest_fico)>400;

-- change data type type temporary for use
-- SELECT cast(date,data_tape_date) as new_date from sdl.aven_organization;
-- date should be the form YYYY-MM-DD 
ALTER TABLE sdl.aven_organization
ADD COLUMN new_date DATE;
UPDATE sdl.aven_organization
SET new_date = STR_TO_DATE(data_tape_date, '%m/%d/%Y');
-- SELECT CAST(data_tape_date AS date) as new_date from sdl.aven_organization;
alter table sdl.aven_organization
drop data_tape_date;
desc sdl.aven_organization;

alter table sdl.aven_organization add column dateex date;
update sdl.aven_organization set dateex=str_to_date(account_open_date,'%m/%d/%Y');
-- case statement 
SELECT product, latest_fico,
CASE
	WHEN latest_fico <580 THEN 'Poor credit'
	WHEN latest_fico BETWEEN 580 AND 669 THEN 'Fair credit'
	WHEN latest_fico BETWEEN 670 AND 739 THEN 'Good credit'
	WHEN latest_fico BETWEEN 740 AND 799 THEN 'Fair credit'
	ELSE 'Excellent Credit'
end as result_fico
FROM sdl.aven_organization
WHERE latest_fico IS NOT NULL
ORDER BY latest_fico;

use sdl;
create table sdl.new_table(sn int, phone_no int,address varchar(20));
insert into sdl.new_table values (1,5571090,'Thecho'),(2,5571080,'Chapagaun');

-- partition by -->returns a single value for each row
select guidno,address_state,status, monthly_income,
sum(monthly_income) over (partition by address_state) as sum_monthly_income
from sdl.aven_organization order by status, monthly_income desc;

-- string function
-- Remove space
Select product, TRIM(' ' from product) AS productTRIM FROM sdl.aven_organization; 
Select address, TRIM(' ' from address) AS addressTRIM FROM sdl.new_table; 
SELECT product, REPLACE(product, ' ', '') AS productTRIM FROM sdl.aven_organization;

-- UPPER and LOWER CASE
Select product, LOWER(product) from sdl.aven_organization;
Select product, replace(product,' ', '') as new_product, lower(product) from sdl.aven_organization;

-- substring
SELECT product,SUBSTRING(product, 1, 5) AS ExtractString FROM sdl.aven_organization;
SELECT product,SUBSTRING(product, 3, 8) AS ExtractString FROM sdl.aven_organization order by product desc;

-- stored procedure
--  create procedure TEST as begin select guid, guidno from sdl.aven_organization;

-- Subquery in Select
use sdl;
SELECT guidno, monthly_income, (select avg(monthly_income) from sdl.aven_organization) 
as allavgincome from sdl.aven_organization order by monthly_income desc;

-- with Partition By
SELECT  monthly_income, AVG(monthly_income) OVER () AS allavgincome
FROM sdl.aven_organization;

-- subquery in where
select guidno,latest_fico, monthly_income from sdl.aven_organization
where guidno in (select guidno from sdl.aven_organization where latest_fico<500);

-- group by
SELECT COUNT(status), status
FROM sdl.aven_organization
GROUP BY status order by count(status);

SELECT COUNT(status), dateex
FROM sdl.aven_organization
GROUP BY dateex
 order by count(status);

-- inner join 
SELECT sdl.aven_organization.guidno,guid, sdl.new_table.address
FROM sdl.aven_organization
INNER JOIN sdl.new_table ON sdl.aven_organization.guidno =sdl.new_table.guidno;

-- fullouter join  -> not working
select sdl.aven_organization.guidno,sdl.new_table.address from sdl.aven_organization
left outer join sdl.new_table ON sdl.aven_organization.guidno =sdl.new_table.guidno 
union
select sdl.aven_organization.guidno,sdl.new_table.address from sdl.aven_organization
right outer join sdl.new_table ON sdl.aven_organization.guidno =sdl.new_table.guidno;

select sdl.aven_organization.guidno,sdl.new_table.address from sdl.aven_organization
left outer join sdl.new_table ON sdl.aven_organization.guidno =sdl.new_table.guidno  ;

-- self join
select sdl.aven_organization.guidno as guidno1, sdl.new_table.guidno as guidno2,address
from sdl.aven_organization,sdl.new_table 
where sdl.aven_organization.guidno = sdl.new_table.guidno;

-- cross join
select * from sdl.aven_organization
cross join sdl.new_table;

-- union
select guidno,phone_no from sdl.aven_organization
union 
select guidno,address from sdl.new_table;

-- intersection
-- select guidno,phone_no from sdl.aven_organization
-- intersect
-- select guidno,address from sdl.new_table;   replaced by inner join

-- except
select guidno,phone_no from sdl.aven_organization except 
select phone_no,address from sdl.new_table;


-- sql rank
-- row_number() 
select *, row_number() over (order by monthly_income desc) income_rank from sdl.aven_organization;

-- rank()
select *, rank() over (partition by status order by monthly_income desc) income_rank from sdl.aven_organization order by income_rank;
select *, rank() over (order by monthly_income desc) income_rank from sdl.aven_organization;

-- dense_rank()
select *, dense_rank() over (order by monthly_income desc) income_rank from sdl.aven_organization;

-- RANK(): This function assigns a unique rank to each distinct value in the result set.
--  If there are ties (i.e., multiple rows with the same values), the ranks will have gaps. 
--  For example, if two rows have the same value and are ranked 1st, the next row will be ranked 3rd (skipping rank 2). 
--  The following row will be ranked 4th, and so on.

-- DENSE_RANK(): This function also assigns a unique rank to each distinct value in the result set. 
-- However, it does not leave gaps in the ranking sequence for tied values. If there are ties, 
-- the ranks will be assigned consecutively. For example, if two rows have the same value and are ranked 1st,
--  the next row will be ranked 2nd (without skipping any ranks). The following row will be ranked 3rd, and so on

-- ntile()
select guid,monthly_income, ntile(3) over (order by monthly_income desc) as income_rank from sdl.aven_organization;

-- using partition
select status,monthly_income, ntile(3) over (partition by status order by monthly_income desc) as income_rank from sdl.aven_organization;

-- view table (view will be updated when update base)
-- view is a result set of SQL statements, exists only for a single query
use sdl;
create view info as select guid, address_state, status from sdl.aven_organization;
select * from info;

-- split by delimeter
SELECT guidno,
  SUBSTRING_INDEX(guid, '-', -3) 
    AS address_one,
  SUBSTRING_INDEX(product, ' ', -1) 
    AS address_two from sdl.aven_organization;














































