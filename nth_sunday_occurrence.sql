create database if not exists complex_sql;
use complex_sql;
-- The WEEKDAY() function returns the weekday number for a given date.
--  Note: 0 = Monday, 1 = Tuesday, 2 = Wednesday, 3 = Thursday, 4 = Friday, 5 = Saturday, 6 = Sunday.
SET @n := 3;
SET @enter_date :='2022-01-03';
select date_add((date_add(@enter_date,INTERVAL (6-WEEKDAY(@enter_date)) DAY)),INTERVAL (@n-1)*7 DAY) as nth_SUnday;
