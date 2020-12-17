
-- Client: name, address, ID
-- Workout: schedule of exercises
-- Exercise: physical activities
-- Goal: desired outcome
-- Login: credentials for application, nullable
-- Exercisecategory: group of exercises, parent cats too
-- invoice: bils
-- invoiceLineItem: charges on invoice


use personaltrainer;

select *
from exercise;

select *
from Client;

select *
from Client
where city='Metairie';

select *
from client
where clientid = '818u7faf-7b4b-48a2-bf12-7a26c92de20c';

select *
from goal;

select 
name, levelid
from workout;

select 
name, levelid, notes
from Workout
where levelid = 2;

select 
firstname, lastname, city
from client
where city = 'Metairie'
and city = 'Kenner' or city = 'Gretna';

select
firstname, lastname, birthdate
from client
where birthdate between '1980-01-01' and '1990-01-01';

select *
from login
where emailaddress like '%.gov';

select *
from login
where emailaddress not like '%.com';

select firstname, lastname from client where birthdate is null;

select name from exercisecategory where parentcategoryid is not null;

select name, notes, levelid from workout where levelid = 3 and notes like '%you%';

select firstname, lastname, city from client where city = 'LaPlace' and lastname like 'L%' or 'M%' or 'N%';

-- select * from invoicelineitem;
select invoiceid, description, price, quantity, servicedate, (price*quantity) from invoicelineitem where (price*quantity) between 15 and 25;

select * from client where lastname = 'Bazely';

select * from workout where name like 'This Is Parkour';

select goalid from workoutgoal where workoutid = 12;

select name from goal where goalid=15;
