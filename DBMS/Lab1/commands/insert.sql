
/*
** ----------------------------------------------------------------------------
** script to insert data into the employee table 
** --------------------------------------------------------------------------*/
INSERT INTO employee VALUES('John','B','Smith','123456789','09-JAN-75','731 Fondren, New York City, NY','M',30000,NULL,NULL, '20-JAN-10',NULL);
INSERT INTO employee VALUES('Ben','T','Franklin','333445555','08-DEC-85','638 Voss, Houston, TX','M',40000,NULL,NULL, '21-May-10',NULL);
INSERT INTO employee VALUES('Alicia','J','Olivas','999887777','19-JUN-85','3321 Castle, Fontana, CA','F',25000,NULL,NULL, '20-JAN-10',NULL);
INSERT INTO employee VALUES('Brittany','S','Wallace','987654321','20-JUN-81','291 Berry, Dallas, TX','F',43000,NULL,NULL, '20-JAN-11',NULL);
INSERT INTO employee VALUES('Ramesh','K','Long','666884444','15-SEP-92','975 Fire Oak, San Antonio, TX','M',38000,NULL,NULL, '20-JAN-11',NULL);
INSERT INTO employee VALUES('Sergio','J','Lopez','112233445','25-FEB-89','102347 E Pantera, Mesa, AZ','M',65000, NULL,NULL, '05-MAR-14',NULL);
INSERT INTO employee VALUES('Joyce','A','Orozco','453453453','31-JUL-82','5631 Rice, Newark, NJ','F',25000,NULL,NULL, '20-JAN-11',NULL);
INSERT INTO employee VALUES('Ahmad','V','Akkad','987987987','29-MAR-89','980 Dallas, LA, CA','M',25000,NULL,NULL, '20-JAN-12',NULL);
INSERT INTO employee VALUES('James','E','Adams','888665555','10-NOV-87','450 Stone, Hollywood, CA','M',55000, NULL,NULL, '20-JAN-12',NULL);
INSERT INTO employee VALUES('Miguel','A','Lopez','000079288','05-FEB-94','102347 E Pantera, Mesa, AZ','M',75000, NULL,NULL, '05-JAN-14',NULL);

/*
** ----------------------------------------------------------------------------
** update superSSN in the employee table 
** --------------------------------------------------------------------------*/
UPDATE employee SET superSSN = '333445555' WHERE ssn='123456789';
UPDATE employee SET superSSN = '888665555' WHERE ssn='333445555';
UPDATE employee SET superSSN = '987654321' WHERE ssn='999887777';
UPDATE employee SET superSSN = '888665555' WHERE ssn='987654321';
UPDATE employee SET superSSN = '333445555' WHERE ssn='666884444';
UPDATE employee SET superSSN = '000079288' WHERE ssn='112233445';
UPDATE employee SET superSSN = '333445555' WHERE ssn='453453453';
UPDATE employee SET superSSN = '987654321' WHERE ssn='987987987';



/*
** ----------------------------------------------------------------------------
** script to insert data into the department table 
** --------------------------------------------------------------------------*/
INSERT INTO department VALUES('Research',5,'333445555','22-MAY-78');
INSERT INTO department VALUES('Administration',4,'987654321','01-JAN-85');
INSERT INTO department VALUES('Headquarters',1,'888665555','19-JUN-71');
INSERT INTO department VALUES('Software Development',2,'000079288','05-JAN-14');


/*
** ----------------------------------------------------------------------------
** update dNo in the employee table 
** --------------------------------------------------------------------------*/
UPDATE employee SET dNo = 5 WHERE ssn='123456789';
UPDATE employee SET dNo = 5 WHERE ssn='333445555';
UPDATE employee SET dNo = 4 WHERE ssn='999887777';
UPDATE employee SET dNo = 4 WHERE ssn='987654321';
UPDATE employee SET dNo = 5 WHERE ssn='666884444';
UPDATE employee SET dNo = 2 WHERE ssn='112233445';
UPDATE employee SET dNo = 5 WHERE ssn='453453453';
UPDATE employee SET dNo = 4 WHERE ssn='987987987';
UPDATE employee SET dNo = 1 WHERE ssn='888665555';
UPDATE employee SET dNo = 2 WHERE ssn='000079288';



/*
** ----------------------------------------------------------------------------
** script to insert data into the dept_location table 
** --------------------------------------------------------------------------*/
INSERT INTO deptLocation VALUES(1,'Houston');
INSERT INTO deptLocation VALUES(4,'Scottsdale');
INSERT INTO deptLocation VALUES(5,'New York');
INSERT INTO deptLocation VALUES(5,'San Francisco');
INSERT INTO deptLocation VALUES(5,'LA');
INSERT INTO deptLocation VALUES(2,'Phoenix');

/*
** ----------------------------------------------------------------------------
** script to insert data into the project table 
** --------------------------------------------------------------------------*/
INSERT INTO project VALUES('Automation',1,'LA',5,20);
INSERT INTO project VALUES('Search Engine',2,'San Francisco',5,30);
INSERT INTO project VALUES('Framework Update',3,'Houston',5,40);
INSERT INTO project VALUES('Computerization',10,'Scottsdale',4,120);
INSERT INTO project VALUES('Resturcture',20,'Houston',1,130);
INSERT INTO project VALUES('Global Views',30,'New York',4,140);
INSERT INTO project VALUES('Mobile Enhancement',15,'Phoenix',2,500);


/*
** ----------------------------------------------------------------------------
** script to insert data into the worksOn table 
** --------------------------------------------------------------------------*/

INSERT INTO worksOn VALUES('123456789',1,32.50);
INSERT INTO worksOn VALUES('123456789',2,7.50);
INSERT INTO worksOn VALUES('666884444',3,40.0);
INSERT INTO worksOn VALUES('112233445',15,300.0);
INSERT INTO worksOn VALUES('453453453',1,20.0);
INSERT INTO worksOn VALUES('453453453',2,20.0);
INSERT INTO worksOn VALUES('333445555',2,10.0);
INSERT INTO worksOn VALUES('333445555',3,10.0);
INSERT INTO worksOn VALUES('333445555',10,10.0);
INSERT INTO worksOn VALUES('333445555',20,10.0);
INSERT INTO worksOn VALUES('999887777',30,30.0);
INSERT INTO worksOn VALUES('999887777',10,10.0);
INSERT INTO worksOn VALUES('987987987',10,35.0);
INSERT INTO worksOn VALUES('987987987',30,5.0);
INSERT INTO worksOn VALUES('987654321',30,20.0);
INSERT INTO worksOn VALUES('987654321',20,15.0);
INSERT INTO worksOn VALUES('888665555',20,12.0);
INSERT INTO worksOn VALUES('123456789',3,0);
INSERT INTO worksOn VALUES('000079288',15,150);

/*
** ----------------------------------------------------------------------------
** script to insert data into the dependent table 
** --------------------------------------------------------------------------*/

INSERT INTO dependent VALUES('333445555','Caitlin','F','05-APR-86','DAUGHTER');
INSERT INTO dependent VALUES('333445555','Zoe','M','25-OCT-99','SON');
INSERT INTO dependent VALUES('333445555','Joy','F','03-MAY-88','SPOUSE');
INSERT INTO dependent VALUES('112233445','Alicia','F','21-AUG-94','SPOUSE');
INSERT INTO dependent VALUES('987654321','Rob','M','21-AUG-84','SPOUSE');
INSERT INTO dependent VALUES('123456789','Michael','M','01-JAN-99','SON');
INSERT INTO dependent VALUES('123456789','Katherine','F','31-DEC-98','DAUGHTER');
INSERT INTO dependent VALUES('123456789','Elizabeth','F','05-MAY-87','SPOUSE');
INSERT INTO dependent VALUES('000079288','Victoria','F','13-DEC-12','DAUGHTER');
INSERT INTO dependent VALUES('000079288','Josie','F','05-MAY-95','SPOUSE');

/*
** ----------------------------------------------------------------------------
** script to insert data into the consultant table 
** --------------------------------------------------------------------------*/

INSERT INTO consultant VALUES('123456789','Sogeti','30000.00');
INSERT INTO consultant VALUES('112233445','Sogeti','50000.00');
INSERT INTO consultant VALUES('666884444','Consultants R Us','15000.00');
INSERT INTO consultant VALUES('888665555','IT Partners','5000.00');