/*
** ----------------------------------------------------------------------------
** Over-Budget
** Retrieve information for each project that consumes more work-hours 
** than budgeted hours.
** --------------------------------------------------------------------------*/
CREATE OR REPLACE VIEW projectHours AS
SELECT pNo, sum(hoursSpent) AS totalHours
FROM worksOn 
GROUP BY pNO
HAVING sum(hoursSpent) > (SELECT budgetedHours FROM project WHERE pNumber = pNo);

SELECT PH.pNo, P.pName, P.pLocation, D.dName, P.budgetedHours, PH.totalHours
FROM project P, department D, projectHours PH
WHERE PH.pNo = P.pNumber AND P.dNum = D.dNumber;


/*
** ----------------------------------------------------------------------------
** Projects with External Employees 
** 	Retrieve information on each project that has at least on employee 
** 	assigned to it who does not work in the project’s controlling department. 
** --------------------------------------------------------------------------*/
CREATE OR REPLACE VIEW projectExEmp AS
SELECT W.pNo, count(W.eSSN) AS empCount
FROM worksOn W, employee E
WHERE W.eSSN = E.ssn AND E.dNo <> (SELECT dNum FROM project WHERE pNumber = W.pNo)
GROUP BY W.pNO;

SELECT PE.pNo, P.pName, P.pLocation, D.dName, PE.empCount
FROM projectExEmp PE, project P, department D
WHERE PE.pNo = P.pNumber AND P.dNum = D.dNumber;

/*
** ----------------------------------------------------------------------------
** 	Immediate Supervisors 
** 	Retrieve information on each employee’s immediate supervisor.
** --------------------------------------------------------------------------*/
SELECT E.fName, E.lName, ECopy.fName, ECopy.lName
FROM employee E, employee ECopy
WHERE E.superSSN = ECopy.ssn;

/*
** ----------------------------------------------------------------------------
** 	Unsupervised Employees 
** 	Retrieve information for each employee who does not have a supervisor.
** --------------------------------------------------------------------------*/
SELECT E.fName, E.lName, E.ssn, D.dName
FROM employee E, department D
WHERE E.superSSN IS NULL AND E.dNo = D.dNumber;

/*
** ----------------------------------------------------------------------------
** 	Controlling Projects List 
**		Retrieve information for each project controlled by a department. 
**		List is sorted in ascending order of project number.
** --------------------------------------------------------------------------*/
SELECT P.pName, P.pNumber, D.dLocation
FROM project P, deptLocation D
WHERE p.dNum = d.dNumber
ORDER BY pNumber;

/*
** ----------------------------------------------------------------------------
** 	Research Department Employees
**	Retrieve information on employees working in the 'Research' department.
** --------------------------------------------------------------------------*/
SELECT E.fName, E.lName, E.mInit, E.address
FROM employee E, department D
WHERE E.dNo = d.dNumber AND D.dName = 'Research';

/*
** ----------------------------------------------------------------------------
** 	Projects at Scottsdale
**	Retrieve information for each project located at 'Scottsdale'.
** --------------------------------------------------------------------------*/
SELECT P.pNumber, D.dNumber, E.lName, E.address, E.bDate
FROM project P, department D, employee E, worksOn W
WHERE P.pLocation = 'Scottsdale' AND P.dNum = D.dNumber AND P.pNumber = W.pNo AND W.eSSN = e.ssn
ORDER BY pNumber,lName;

/*
** ----------------------------------------------------------------------------
** 	All Projects Done by Smith 
**	Retrieve all the projects that 'Smith' 
**	either as a worker or manager, has worked on.
** --------------------------------------------------------------------------*/

SELECT DISTINCT W.pNo
FROM worksOn W, employee E 
WHERE (W.eSSN = E.ssn AND E.lName = 'Smith') OR
	EXISTS (SELECT * FROM project P, department D 
	WHERE W.pNo = P.pNumber AND P.dNum = D.dNumber AND D.mgrSSN = E.ssn AND E.lName = 'Smith');

/*
** ----------------------------------------------------------------------------
** 	Employee with >=2 Dependents 
**	List names of all employees with two or more dependents
** --------------------------------------------------------------------------*/
CREATE OR REPLACE VIEW empDependentCount AS
SELECT eSSN, COUNT(dependentName) AS  dCount
FROM dependent 
GROUP BY eSSN
HAVING COUNT(dependentName) >=2;

SELECT fName, mInit, lName
FROM empDependentCount EC, employee E
WHERE EC.eSSN = E.ssn;

/*
** ----------------------------------------------------------------------------
** 	Employee with no Dependents
**	Retrieve the names of employees who have no dependents.
** --------------------------------------------------------------------------*/
SELECT fName, mInit, lName
FROM employee E
WHERE E.ssn NOT IN (SELECT eSSN FROM dependent);

/*
** ----------------------------------------------------------------------------
** 	Manager with at least one dependent
**	List name of all managers with at least one dependent
** --------------------------------------------------------------------------*/
SELECT fName, mInit, lName
FROM department D, employee E
WHERE D.mgrSSN = E.ssn AND D.mgrSSN IN (SELECT eSSN FROM dependent);

/*
** ----------------------------------------------------------------------------
** 	Employees on all projects controlled by department number 5 
**	Retrieve information on all employees working for department number 5.
** --------------------------------------------------------------------------*/
SELECT DISTINCT fName, mInit, lName
FROM employee E, worksOn W, project P
WHERE W.pNo = P.pNumber AND P.dNum = 5 AND W.eSSN = E.ssn;

/*
** ----------------------------------------------------------------------------
** 	Sums the total cost that the company is spending on contracts
** --------------------------------------------------------------------------*/

SELECT sum(contractCost)
FROM consultant C, employee E
WHERE E.ssn = C.eSSN;

/*
** ----------------------------------------------------------------------------
** 	Employees contracted from the company Sogeti
**	Retrieve information on all employees working for the company Sogeti
** --------------------------------------------------------------------------*/

SELECT E.fName, E.mInit, E.lName
FROM consultant C, employee E
WHERE E.ssn = C.eSSN AND C.consultantCompany = 'Sogeti';

/*
** ----------------------------------------------------------------------------
** 	Find the supervisor of the employee 'Sergio J Lopez'
**	Retrieve all information on supervisor
** --------------------------------------------------------------------------*/

SELECT *
FROM employee
WHERE ssn = (SELECT superSSN FROM employee WHERE ssn = '112233445' AND 
              fName = 'Sergio' AND lName = 'Lopez' AND mInit = 'J');
              
/*
** ----------------------------------------------------------------------------
** 	Find the employees who have dependents
**	Retrieve the number of dependents that each employee has
** --------------------------------------------------------------------------*/

SELECT E.fName, E.lName, count(D.eSSN)
FROM employee E
INNER JOIN dependent D
ON E.ssn = D.eSSN 
GROUP BY E.fName, E.lName 
ORDER BY E.lName;