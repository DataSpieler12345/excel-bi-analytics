SELECT p.Personal_Nr, p.Personal_Name, a.Abteilung_Nr, a.Abteilung_Name, pr.Project_Nr, pr.Project_Name, s.Stunden
FROM Personal_Table p
JOIN Abteilung_Table a ON p.Abteilung_Nr = a.Abteilung_Nr
JOIN PersonalProject_Table pp ON p.Personal_Nr = pp.Personal_Nr
JOIN Project_Table pr ON pp.Project_Nr = pr.Project_Nr
JOIN Stunden_Table s ON pp.Personal_Nr = s.Personal_Nr AND pp.Project_Nr = s.Project_Nr
WHERE p.Personal_Nr = 2;