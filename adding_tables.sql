-- connectate a la db school 
use school_db

create table  Studenten
(
	id int auto_increment primary key,
	last_name nvarchar(50) not null,
	first_name nvarchar(50) not null,
	date_oft_birth date not null,
	enrollment_date date 
);


create table Course 
(
	courseid int auto_increment primary key,
	title nvarchar(100) not null,
    number_of_credits int, 
    course_code nvarchar(5) not null -- Excample CS201
);


