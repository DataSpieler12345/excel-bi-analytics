--Create the "ProjekPersonal" table:
CREATE TABLE ProjekPersonal (
    Personal_No INTEGER,
    Personal_Name VARCHAR(50),
    Dept_No VARCHAR(50),
    Dept_Name VARCHAR(50),
    Project_No VARCHAR(50),
    Project_Name VARCHAR(50),
    Project_Hours VARCHAR(50),
    PRIMARY KEY (Personal_No)
);

--Insert sample data into the "ProjekPersonal" table:
INSERT INTO ProjekPersonal (Personal_No, Personal_Name, Dept_No, Dept_Name, Project_No, Project_Name, Project_Hours)
VALUES 
    (1, 'Müller', '1', 'Motoren', '11,12', 'A,B', '60,40'),
    (2, 'Meier', '2', 'Karosserie', '13', 'C', '100'),
    (3, 'Krause', '2', 'Karosserie', '11,12,13', 'A,B,C', '20,50,30'),
    (4, 'Schmidt', '1', 'Motoren', '11,13', 'A,C', '80,20');

--Create the "Personal" table:
CREATE TABLE Personal (
    Personal_No INTEGER PRIMARY KEY,
    Personal_Name VARCHAR(50),
    Dept_No VARCHAR(50)
);

--Insert data in the "Personal" table:
INSERT INTO Personal (Personal_No, Personal_Name, Dept_No)
SELECT DISTINCT Personal_No, Personal_Name, CAST(Dept_No AS VARCHAR(50)) FROM ProjekPersonal;

--Create the Department table
CREATE TABLE Department (
    Dept_No VARCHAR(50) PRIMARY KEY,
    Dept_Name VARCHAR(50)
);

--Insert data in the department table
INSERT INTO Department (Dept_No, Dept_Name)
SELECT DISTINCT CAST(Dept_No AS VARCHAR(50)), Dept_Name FROM ProjekPersonal;

--Create the "Project" table:
CREATE TABLE Project (
    Project_No VARCHAR(50) PRIMARY KEY,
    Project_Name VARCHAR(50)
);

--Insert data in the "Project" table:
INSERT INTO Project (Project_No, Project_Name)
SELECT DISTINCT CAST(Project_No AS VARCHAR(50)), Project_Name FROM ProjekPersonal;

--Create the "HoursWorked" table:
CREATE TABLE HoursWorked (
    Personal_No INTEGER,
    Project_No VARCHAR(50),
    Project_Hours VARCHAR(50),
    PRIMARY KEY (Personal_No, Project_No),
    FOREIGN KEY (Personal_No) REFERENCES Personal(Personal_No),
    FOREIGN KEY (Project_No) REFERENCES Project(Project_No)
);

--Insert data in the "HoursWorked" table:
INSERT INTO HoursWorked (Personal_No, Project_No, Project_Hours)
SELECT 
    Personal.Personal_No, 
    ProjekPersonal.Project_No, 
    SUBSTRING(ProjekPersonal.Project_Hours, 1, CHARINDEX(',', ProjekPersonal.Project_Hours)-1) AS Project_Hours
FROM ProjekPersonal
JOIN Personal ON ProjekPersonal.Personal_No = Personal.Personal_No
WHERE CHARINDEX(',', ProjekPersonal.Project_No) = 0

UNION

SELECT 
    Personal.Personal_No, 
    SUBSTRING(ProjekPersonal.Project_No, 1, CHARINDEX(',', ProjekPersonal.Project_No)-1) AS Project_No, 
    SUBSTRING(ProjekPersonal.Project_Hours, 1, CHARINDEX(',', ProjekPersonal.Project_Hours)-1) AS Project_Hours
FROM ProjekPersonal
JOIN Personal ON ProjekPersonal.Personal_No = Personal.Personal_No
WHERE CHARINDEX(',', ProjekPersonal.Project_No) > 0

UNION

SELECT 
    Personal.Personal_No, 
    SUBSTRING(ProjekPersonal.Project_No, CHARINDEX(',', ProjekPersonal.Project_No)+1, LEN(ProjekPersonal.Project_No)) AS Project_No, 
    SUBSTRING(ProjekPersonal.Project_Hours, CHARINDEX(',', ProjekPersonal.Project_Hours)+1, LEN(ProjekPersonal.Project_Hours)) AS Project_Hours
FROM ProjekPersonal
JOIN Personal ON ProjekPersonal.Personal_No = Personal.Personal_No
WHERE CHARINDEX(',', ProjekPersonal.Project_No) > 0;