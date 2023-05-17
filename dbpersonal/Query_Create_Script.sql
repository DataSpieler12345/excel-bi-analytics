-- Create Abteilung Table
CREATE TABLE Abteilung (
    Abteilung_Nr INT PRIMARY KEY,
    Abteilung_Name VARCHAR(50) NOT NULL
);

-- Create Project Table
CREATE TABLE Projekt (
    Project_Nr INT PRIMARY KEY,
    Project_Name VARCHAR(50) NOT NULL,
    Project_Stunden INT NOT NULL
);

-- Create Personal Project Table
CREATE TABLE Personal (
    Personal_Nr INT PRIMARY KEY,
    Personal_Name VARCHAR(50) NOT NULL,
    Project_Nr INT NOT NULL,
    Abteilung_Nr INT NOT NULL,
    FOREIGN KEY (Abteilung_Nr) REFERENCES Abteilung (Abteilung_Nr),
    FOREIGN KEY (Project_Nr) REFERENCES Projekt (Project_Nr)
);

-- Insert sample data into Abteilung Table
INSERT INTO Abteilung (Abteilung_Nr, Abteilung_Name)
VALUES 
    (1, 'Motoren'),
    (2, 'Karosserie');

-- Insert sample data into Project Table
INSERT INTO Projekt (Project_Nr, Project_Name, Project_Stunden)
VALUES 
    (11, 'A', 60),
    (12, 'B', 40),
    (13, 'C', 100),
    (14, 'D', 20),
    (15, 'E', 50),
    (16, 'F', 30),
    (17, 'G', 80),
    (18, 'H', 20);

-- Insert sample data into Personal Table
INSERT INTO Personal (Personal_Nr, Personal_Name, Project_Nr, Abteilung_Nr)
VALUES 
    (1, 'Müller', 11, 1),
    (2, 'Müller', 12, 1),
    (3, 'Meier', 13, 2),
    (4, 'Krause', 14, 2),
    (5, 'Krause', 15, 2),
    (6, 'Krause', 16, 2),
    (7, 'Schmidt', 17, 1),
    (8, 'Schmidt', 18, 1);
