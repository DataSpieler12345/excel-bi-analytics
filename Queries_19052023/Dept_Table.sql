-- Creación de la tabla "Departments"
CREATE TABLE Departments (
    departments_Id INT PRIMARY KEY,
    departments_Name VARCHAR(50)
);

-- Creación de la tabla "Personal"
CREATE TABLE Personal (
    personal_Id INT PRIMARY KEY,
	personal_Nr INT,
    personal_Name VARCHAR(50),
	projects_Id INT,
	departments_Id INT,
    FOREIGN KEY (departments_Id) REFERENCES Departments (departments_Id)
	FOREIGN KEY (projects_Id) REFERENCES Departments (projects_Id)
);

-- Creación de la tabla "Project"
CREATE TABLE Project (
	projects_Id INT PRIMARY KEY,
    Project_Nr INT,
    Project_Name VARCHAR(50)
);
