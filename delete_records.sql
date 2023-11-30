use school_db;

-- Remove one row by ID
delete from students 
where id = 9;

-- Remove multiple rows using a list of potential values
delete from students 
where id in (3,4,5,6);

-- Delete student named Tajee McDermott
delete from Students 
where first_name = 'Tajee' and last_name = 'McDermott';

-- Delete all students with names containing the word 'student'
delete from Students 
where first_name like '%student%' or last_name like '%student%';

