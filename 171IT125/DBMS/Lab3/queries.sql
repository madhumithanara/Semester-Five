USE COMPANY;

-- 1) Retrieve the name, birthdate and address of every employee who works for the ‘administration’ department.
SELECT Fname, Address, Bdate from EMPLOYEE, DEPARTMENT WHERE EMPLOYEE.Dno = DEPARTMENT.Dnumber and DEPARTMENT.Dname = 'Administration';

-- 2) Find the sum of the salaries of all employees of the ‘Research’
-- department, as well as the maximum salary, the minimum salary, and the average salary in this department.

SELECT SUM(Salary),AVG(Salary),MAX(Salary),MIN(Salary) from EMPLOYEE, DEPARTMENT WHERE EMPLOYEE.Dno = DEPARTMENT.Dnumber and DEPARTMENT.Dname = 'Research';
-- Different Approach (BETTER FOR MULTIPLE DEPARTMENTS)
-- SELECT SUM(Salary),AVG(Salary),MAX(Salary),MIN(Salary) from EMPLOYEE, DEPARTMENT WHERE EMPLOYEE.Dno = DEPARTMENT.Dnumber GROUP BY DEPARTMENT.DNAME HAVING DEPARTMENT.Dname = 'Research';

-- 3) Retrieve the number of employees in the ‘administration’ department
SELECT COUNT(*) FROM EMPLOYEE, DEPARTMENT WHERE EMPLOYEE.Dno = DEPARTMENT.Dnumber and DEPARTMENT.Dname = 'Administration';

-- 4) For each project, retrieve the project number, the project name, and the number of employees who work on that project.
-- SELECT Pnumber, Pname, COUNT(*) from PROJECT, WORKS_ON WHERE PR0JECT.Pnumber = WORKS_ON.Pno GROUP BY Pno; Does not work for some reason
SELECT Pnumber, Pname, COUNT(*) from PROJECT, WORKS_ON WHERE WORKS_ON.Pno=PROJECT.PNUMBER GROUP BY PNo;

-- 5) For each project, retrieve the project number, the project name, project location and the number of employees from department 5 who work on the project.
SELECT Pnumber, Pname, COUNT(*) from PROJECT, WORKS_ON WHERE WORKS_ON.Pno=PROJECT.PNUMBER AND  PROJECT.Dnum = 5 GROUP BY PNo ;

-- 6) For every project located in ‘Houston’, list the project number, the controlling department number, and the department manager’s last name, address.
-- SELECT Pnumber, Dnum, Lname, Address from PR0JECT, DEPARTMENT, EMPLOYEE WHERE PROJECT.Dnum = DEPARTMENT.Dnumber AND DEPARTMENT.Mgr_ssn = EMPLOYEE.Ssn AND PROJECT.Plocation = 'Houston'; 
SELECT Pnumber, Dnum, Lname, Address from DEPARTMENT, PROJECT, EMPLOYEE WHERE PROJECT.Dnum = DEPARTMENT.Dnumber AND DEPARTMENT.Mgr_ssn = EMPLOYEE.Ssn AND PROJECT.Plocation = 'Houston';

-- 7) Retrieve a list of employees and the projects they are working on, ordered by department and, within each department, ordered alphabetically by the first name then by last name.
-- SELECT Fname, Lname, Pname, Dname from DEPARTMENT, PROJECT, EMPLOYEE, WORKS_ON WHERE DEPARTMENT.Dnumber = PROJECT.Dnum AND WORKS_ON.Essn = EMPLOYEE.Ssn AND WORKS_ON.Pno = PR0JECT.Pnumber ORDER BY DEPARTMENT.Dname;
select Fname,Lname,Pname,Dname from DEPARTMENT,PROJECT,EMPLOYEE,WORKS_ON WHERE DEPARTMENT.DNUMBER=PROJECT.DNUM AND WORKS_ON.ESSN=EMPLOYEE.SSN AND WORKS_ON.PNO=PROJECT.PNUMBER ORDER BY DEPARTMENT.DNAME, FNAME, LNAME;

-- 8) Retrieve the names of all employees who do not have supervisors.
SELECT FNAME,LNAME FROM EMPLOYEE WHERE EMPLOYEE.Super_ssn IS NULL;

-- 9) Retrieve the names of all employees whose supervisor’s supervisor has ‘987654321’ for Ssn.

SELECT FNAME,LNAME FROM EMPLOYEE WHERE EMPLOYEE.Super_ssn IN (SELECT Ssn FROM EMPLOYEE WHERE EMPLOYEE.Super_ssn = "987654321");

-- 10) Retrieve  the department name, manager name, and manager salary for every department.

SELECT DName,Fname,Lname,Salary FROM DEPARTMENT,EMPLOYEE WHERE DEPARTMENT.Mgr_ssn = EMPLOYEE.Ssn;  

-- 11)  Retrieve the employee name, supervisor name, and employee salary for each employee who works in the ‘Research’ department.

SELECT E.Fname,E.Lname,E.Salary,S.Fname,S.Lname FROM EMPLOYEE AS E, EMPLOYEE AS S WHERE E.Super_ssn = S.ssn; 

-- 12) Retrieve the project name, controlling department name, number of employees, and total hours worked per week on the project for each project.

SELECT p.Pname, d.Dname, COUNT(*) as employees, sum(w.Hours) FROM PROJECT p, DEPARTMENT d, EMPLOYEE e, WORKS_ON w WHERE p.Dnum = d.Dnumber AND e.Ssn = w.Essn AND p.Pnumber = w.Pno AND p.Pnumber = w.Pno GROUP BY p.Pnumber;

-- 13) Retrieve the project name, controlling department name, number of employees, and total hours worked per week on the project for each project with more than one employee working on it.

SELECT p.Pname, d.Dname, COUNT(*) as employees, sum(w.Hours) FROM PROJECT p, DEPARTMENT d, EMPLOYEE e, WORKS_ON w WHERE p.Dnum = d.Dnumber AND e.Ssn = w.Essn AND p.Pnumber = w.Pno AND p.Pnumber = w.Pno GROUP BY p.Pnumber HAVING COUNT(*) > 1;
-- 14) Find the names of employees who work on all the projects controlled by department number 5.

SELECT e.Fname,e.Minit,e.Lname FROM EMPLOYEE e, PROJECT p, WORKS_ON w WHERE e.Ssn = w.Essn AND w.Pno = p.Pnumber AND p.Dnum = 5;

-- 15) Retrieve the names of all employees in department 5 who work more than 10 hours per week on the ProductX project.

SELECT e.Fname,e.Minit,e.Lname FROM EMPLOYEE e, PROJECT p, WORKS_ON w WHERE w.Essn = e.Ssn AND w.Pno = p.Pnumber and p.Pname = 'ProductX' AND w.Hours > 10;

-- 16) List the names of all employees who have a dependent with the same first name as themselves.

SELECT e.Fname,e.Minit,e.Lname FROM EMPLOYEE e, DEPENDENT d WHERE e.Fname = d.Dependent_name;

-- 17) Find the names of all employees who are directly supervised by ‘Franklin Wong’.

SELECT e.Fname,e.Minit,e.Lname FROM EMPLOYEE e, EMPLOYEE f WHERE e.Super_ssn = f.Ssn and f.Fname = 'Franklin' and f.Lname = 'Wong';

-- 18) For each project, list the project name and the total hours per week (by all employees) spent on that project.

SELECT p.Pname, SUM(w.Hours) FROM WORKS_ON w, PROJECT p WHERE w.Pno = p.Pnumber GROUP BY p.Pnumber;

-- 19) Retrieve the average salary of all female employees.

SELECT AVG(Salary) FROM EMPLOYEE WHERE Sex = 'F';
