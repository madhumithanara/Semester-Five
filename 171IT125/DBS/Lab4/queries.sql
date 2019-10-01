SELECT pt.name AS "Patient",
       p.name AS "Primary care Physician"
FROM patient pt
JOIN physiciane p ON pt.pcp=p.employeeid
WHERE pt.pcp NOT IN
    (SELECT head
     FROM department);




SELECT pt.name AS "Patient",
       p.name AS "Primary Physician",
       n.name AS "Nurse"
FROM appointment a
JOIN patient pt ON a.patient=pt.ssn
JOIN nurse n ON a.prepnurse=n.employeeid
JOIN physiciane p ON pt.pcp=p.employeeid
WHERE a.patient IN
    (SELECT patient
     FROM appointment a
     GROUP BY a.patient
     HAVING count(*)>=2)
  AND n.registered='true'
ORDER BY pt.name;





SELECT pt.name AS "Patient",
       p.name AS "Primary Physician",
       pd.cost AS "Procedure Cost"
FROM patient pt
JOIN undergoes u ON u.patient=pt.ssn
JOIN physiciane p ON pt.pcp=p.employeeid
JOIN procedures pd ON u.Procedures=pd.code
WHERE pd.cost>5000;






SELECT p.name AS "Physician",
       p.position AS "Position",
       pr.name AS "Procedure",
       u.DateUndergoes AS "Date of Procedure",
       pt.name AS "Patient",
       t.certificationexpires AS "Expiry Date of Certificate"
FROM physiciane p,
     undergoes u,
     patient pt,
     procedures pr,
     trained_in t
WHERE u.patient = pt.ssn
  AND u.procedures = pr.code
  AND u.physician = p.employeeid
  AND Pr.code = t.treatment
  AND P.employeeid = t.physician
  AND u.DateUndergoes > t.certificationexpires;\





SELECT p.name AS "Physician",
       pr.name AS "Procedure",
       u.dateUndergoes,
       pt.name AS "Patient"
FROM physiciane p,
     undergoes u,
     patient pt,
     procedures pr
WHERE u.patient = pt.SSN
  AND u.procedures = pr.Code
  AND u.physician = p.EmployeeID
  AND NOT EXISTS
    ( SELECT *
     FROM trained_in t
     WHERE t.treatment = u.procedures
       AND t.physician = u.physician );
