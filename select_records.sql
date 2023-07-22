use school_db;

-- SELECT * FROM TableName selects all of the records and all columns 
-- * means all 
select * from students;

-- You may specify the columns you would like to see
-- you may also add an alias and represent the output column name as you wish
select 
last_name as `Last Name`, 
first_name `First Name`, 
date_of_birth `Date of Birth`
from students;