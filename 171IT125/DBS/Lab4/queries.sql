-- 5) Write a SQL query to obtain the names of all the physicians performed a medical procedure but they are not certified to
-- perform.
SELECT Name, Treatment, t.Physician from PhysicianE p, Undergoes u, Trained_In t WHERE t.Physician = p.EmployeeId and 

    (u.Physician = p.EmployeeId 
and p.EmployeeId = t.Physician 
and t.Treatment = u.Procedures 
and (u.DateUndergoes < t.CertificationDate 
or u.DateUndergoes > t.CertificationExpires))

or 

(u.Physician = p.EmployeeId 
and 
(p.EmployeeId not in (SELECT Physician from Trained_In t1)))

or

(u.Physician = p.EmployeeId and u.Procedures not in 
(SELECT Treatment from Trained_In t1 where p.EmployeeId = t1.Physician))
;

