SELECT pt.name AS "Patient",
       p.name AS "Primary care Physician"
FROM Patient pt
JOIN PhysicianE p ON pt.pcp=p.employeeid
WHERE pt.pcp NOT IN
    (SELECT head
     FROM Department);




SELECT pt.name AS "Patient",
       p.name AS "Primary Physician",
       n.name AS "Nurse"
FROM Appointment a
JOIN Patient pt ON a.patient=pt.ssn
JOIN Nurse n ON a.prepnurse=n.employeeid
JOIN PhysicianE p ON pt.pcp=p.employeeid
WHERE a.patient IN
    (SELECT patient
     FROM Appointment a
     GROUP BY a.patient
     HAVING count(*)>=2)
  AND n.registered='true'
ORDER BY pt.name;





SELECT pt.name AS "Patient",
       p.name AS "Primary Physician",
       pd.cost AS "Procedure Cost"
FROM Patient pt
JOIN Undergoes u ON u.patient=pt.ssn
JOIN PhysicianE p ON pt.pcp=p.employeeid
JOIN Procedures pd ON u.Procedures=pd.code
WHERE pd.cost>5000;






SELECT p.name AS "Physician",
       p.position AS "Position",
       pr.name AS "Procedure",
       u.DateUndergoes AS "Date of Procedure",
       pt.name AS "Patient",
       t.certificationexpires AS "Expiry Date of Certificate"
FROM PhysicianE p,
     Undergoes u,
     Patient pt,
     Procedures pr,
     Trained_In t
WHERE u.patient = pt.ssn
  AND u.procedures = pr.code
  AND u.physician = p.employeeid
  AND pr.Code = t.treatment
  AND p.EmployeeId = t.physician
  AND u.DateUndergoes > t.certificationexpires;





SELECT p.name AS "Physician",
       pr.name AS "Procedure",
       u.dateUndergoes,
       pt.name AS "Patient"
FROM PhysicianE p,
     Undergoes u,
     Patient pt,
     Procedures pr
WHERE u.patient = pt.SSN
  AND u.procedures = pr.Code
  AND u.physician = p.EmployeeID
  AND NOT EXISTS
    ( SELECT *
     FROM Trained_In t
     WHERE t.treatment = u.procedures
       AND t.physician = u.physician );
