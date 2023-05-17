SELECT
    p.Personal_Nr,
    p.Personal_Name,
    a.Abteilung_Nr,
    a.Abteilung_Name,
    pr.Project_Nr,
    pr.Project_Name,
    pr.Project_Stunden
FROM
    Personal p
    JOIN Abteilung a ON p.Abteilung_Nr = a.Abteilung_Nr
    JOIN Projekt pr ON p.Project_Nr = pr.Project_Nr;
