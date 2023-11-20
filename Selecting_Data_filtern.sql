-- seleciona la tabla de la db
SELECT *
FROM studiantes;

-- selecciona studiantes con el last name Williams
SELECT 
	last_name,
    first_name	
FROM studiantes
WHERE last_name = 'Williams';

-- selecciona studiantes que tienen solo la palabra Test en su last name
SELECT 
	last_name,
    first_name	
FROM studiantes
WHERE last_name LIKE '%Test%';

-- Selecciona solo nombres completos de los estudiantes y la fecha de enrollment
SELECT 
	concat(last_name, ' ', first_name) 'Full Name', 
    enrollment_date
FROM studiantes
WHERE enrollment_date IS NOT NULL;

-- Selecciona coursos con el numero de creditos mayor que 2
SELECT 
	title, 
    number_of_credits
FROM courses
WHERE number_of_credits > 2;

-- Selecciona coursos con 3 creditos o menos 
SELECT 
	title, 
    number_of_credits
FROM courses
WHERE number_of_credits <=3;