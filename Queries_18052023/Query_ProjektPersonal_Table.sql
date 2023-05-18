--Create the "ProjekPersonal" table:		
		
CREATE TABLE ProjekPersonal (		
    Personal_No INTEGER,		
    Personal_Name TEXT,		
    Dept_No TEXT,		
    Dept_Name TEXT,		
    Project_No TEXT,		
    Project_Name TEXT,		
    Project_hours TEXT,		
    PRIMARY KEY (Personal_No)		
);

--Insert sample data into the "ProjekPersonal" table:				
				
INSERT INTO ProjekPersonal (Personal_No, Personal_Name, Dept_No, Dept_Name, Project_No, Project_Name, Project_hours)				
VALUES 				
    (1, 'Müller', '1', 'Motoren', '11,12', 'A,B', '60,40'),				
    (2, 'Meier', '2', 'Karosserie', '13', 'C', '100'),				
    (3, 'Krause', '2', 'Karosserie', '11,12,13', 'A,B,C', '20,50,30'),				
    (4, 'Schmidt', '1', 'Motoren', '11,13', 'A,C', '80,20');				
