use school_db;

-- INSERT INTO TableName(Columns...) VALUES (values....)
-- Single Row Insert
insert into students 
(last_name, first_name,date_of_birth,enrollment_date) 
values 
('Test', 'Student','2001-09-01',null);

-- INSERT INTO TableName(Columns...) VALUES (values....), (values....), (values....)
-- Multiple Row Insert
insert into students 
(last_name, first_name,date_of_birth,enrollment_date) 
values 
('Test1', 'Student1','2001-01-01','2019-03-01'),
('Test2', 'Student2','2001-02-01',null),
('Test3', 'Student3','2001-03-01','2019-03-01'),
('Test4', 'Student4','2001-04-01',null),
('Test5', 'Student5','2001-05-01','2019-03-01'),
('Test6', 'Student6','2001-06-01',null),
('Test7', 'Student7','2001-07-01',null),
('Test8', 'Student8','2001-08-01',null);