-- databasename.tablename
SELECT * FROM school_db.students ;

-- Retrieve only students with the last name 'Williams'
select last_name, first_name from school_db.students
where last_name = 'Williams';

-- Retrieve only students with the word 'Test' in their last name
select last_name, first_name from school_db.students
where last_name like '%test%';


-- Retrieve only Full Names of Students and their enrollment dates
select concat(first_name, ' ', last_name) `Full Name`, enrollment_date `Enrollment Date`  from school_db.students;

-- Select Courses with the number of credits greater than 2
select * from school_db.courses
where NumberOfCredits > 2;

-- Select Courses with the number of credits 3 and less
select * from school_db.courses
where NumberOfCredits <= 3;