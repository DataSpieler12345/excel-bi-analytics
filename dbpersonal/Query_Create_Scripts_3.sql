-- Create Abteilung Table
CREATE TABLE Abteilung (
    Abteilung_Nr INT PRIMARY KEY,
    Abteilung_Name VARCHAR(50) NOT NULL
);

-- Create Project Table
CREATE TABLE Projekt (
    Project_Nr INT PRIMARY KEY,
    Project_Name VARCHAR(50) NOT NULL,
    Project_Stunden INT NOT NULL,
    CONSTRAINT chk_project_nr CHECK (Project_Nr IN (11, 12, 13))
);

-- Create Personal Project Table
CREATE TABLE Personal (
    Personal_Nr INT NOT NULL,
    Personal_Name VARCHAR(50) NOT NULL,
    Project_Nr INT NOT NULL,
    Abteilung_Nr INT NOT NULL,
    PRIMARY KEY (Personal_Nr, Project_Nr),
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
    (11, 'A', 20),
    (12, 'B', 50),
    (13, 'C', 30),
    (11, 'A', 80),
    (13, 'C', 20);

-- Insert sample data into Personal Table
INSERT INTO Personal (Personal_Nr, Personal_Name, Project_Nr, Abteilung_Nr)
VALUES 
    (1, 'Müller', 11, 1),
    (1, 'Müller', 12, 1),
    (2, 'Meier', 13, 2),
    (3, 'Krause', 11, 2),
    (3, 'Krause', 12, 2),
    (3, 'Krause', 13, 2),
    (4, 'Schmidt', 11, 1),
    (4, 'Schmidt', 13, 1);