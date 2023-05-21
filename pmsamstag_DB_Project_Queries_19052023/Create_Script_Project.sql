--Tabla de Abteilung
CREATE TABLE Abteilung_Table (
    Abteilung_Nr INT PRIMARY KEY,
    Abteilung_Name VARCHAR(50)
);

--Tabla de Personal
CREATE TABLE Personal_Table (
    Personal_Nr INT PRIMARY KEY,
    Personal_Name VARCHAR(50),
    Abteilung_Nr INT REFERENCES Abteilung_Table(Abteilung_Nr)
);

--Tabla de Project
CREATE TABLE Project_Table (
    Project_Nr INT PRIMARY KEY,
    Project_Name VARCHAR(50)
);

--Tabla de PersonalProject
CREATE TABLE PersonalProject_Table (
    Personal_Nr INT REFERENCES Personal_Table(Personal_Nr),
    Project_Nr INT REFERENCES Project_Table(Project_Nr),
    PRIMARY KEY (Personal_Nr, Project_Nr)
);

--Tabla de Stunden
CREATE TABLE Stunden_Table (
    Personal_Nr INT REFERENCES Personal_Table(Personal_Nr),
    Project_Nr INT REFERENCES Project_Table(Project_Nr),
    Stunden INT,
    PRIMARY KEY (Personal_Nr, Project_Nr)
);

-- Insertar datos de ejemplo en Abteilung_Table
INSERT INTO Abteilung_Table (Abteilung_Nr, Abteilung_Name)
VALUES 
    (1, 'Motoren'),
    (2, 'Karosserie');

-- Insertar datos de ejemplo en Personal_Table
INSERT INTO Personal_Table (Personal_Nr, Personal_Name, Abteilung_Nr)
VALUES 
    (1, 'M�ller', 1),
    (2, 'Meier', 2),
    (3, 'Krause', 2),
    (4, 'Schmidt', 1);

-- Insertar datos de ejemplo en Project_Table
INSERT INTO Project_Table (Project_Nr, Project_Name)
VALUES 
    (11, 'A'),
    (12, 'B'),
    (13, 'C');

	
-- Insertar datos de ejemplo en PersonalProject_Table
INSERT INTO PersonalProject_Table (Personal_Nr, Project_Nr)
VALUES 
    (1, 11),
    (1, 12),
    (2, 13),
    (3, 11),
    (3, 12),
    (3, 13),
    (4, 11),
    (4, 13);

-- Insertar datos de ejemplo en Stunden_Table
INSERT INTO Stunden_Table (Personal_Nr, Project_Nr, Stunden)
VALUES 
    (1, 11, 60),
    (1, 12, 40),
    (2, 13, 100),
    (3, 11, 20),
    (3, 12, 50),
    (3, 13, 30),
    (4, 13, 80),
	(4, 13, 20);