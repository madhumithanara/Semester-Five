
/*
** ----------------------------------------------------------------------------
** script to create the employee table 
** --------------------------------------------------------------------------*/

CREATE TABLE employee (
	fName			VARCHAR2(20)NOT NULL,
	mInit			CHAR(1),
  	lName     		VARCHAR2(20)  NOT NULL,
	ssn			VARCHAR2(9)PRIMARY KEY,
	bDate			DATE NOT NULL,
	address 		VARCHAR(50) NOT NULL,
	sex			CHAR(1)	NOT NULL CHECK (sex = 'F' OR sex = 'M'),
	salary			FLOAT NOT NULL CHECK (salary > 0),
	superSSN		VARCHAR2(9),
	dNo			INTEGER,
	hireDate 		DATE NOT NULL,
	terminateDate 		DATE
);

SHOW ERRORS;

/*
** ----------------------------------------------------------------------------
** add foreign key for the employee table 
** --------------------------------------------------------------------------*/
ALTER TABLE employee
	ADD (FOREIGN KEY (superSSN) REFERENCES employee(ssn) ON DELETE SET NULL);

SHOW ERRORS;

/*
** ----------------------------------------------------------------------------
** script to create the department table 
** --------------------------------------------------------------------------*/

CREATE TABLE department (
	dName			VARCHAR2(20) NOT NULL,
	dNumber			INTEGER		PRIMARY KEY,
	mgrSSN			VARCHAR2(9),
	mgrStartDate		Date NOT NULL,
	FOREIGN KEY (mgrSSN) REFERENCES employee(ssn) ON DELETE SET NULL
);

SHOW ERRORS;

/*
** ----------------------------------------------------------------------------
** script to create the dept_location table 
** --------------------------------------------------------------------------*/
CREATE TABLE deptLocation (
	dNumber		INTEGER,
	dLocation	VARCHAR2(20),
	PRIMARY KEY (dNumber,dLocation),
	FOREIGN KEY(dNumber) REFERENCES department(dNumber)
);
SHOW ERRORS;

/*
** ----------------------------------------------------------------------------
** add foreign key for the employee table 
** --------------------------------------------------------------------------*/
ALTER TABLE employee
	ADD (FOREIGN KEY (dNo) REFERENCES department(dNumber) ON DELETE SET NULL);
	
SHOW ERRORS;

/*
** ----------------------------------------------------------------------------
** script to create the project table 
** --------------------------------------------------------------------------*/

CREATE TABLE project (
	pName			VARCHAR(20)	NOT NULL,
	pNumber			INTEGER  	PRIMARY KEY,
	pLocation		VARCHAR(50)	NOT NULL,
	dNum			INTEGER	,
	budgetedHours  		FLOAT NOT NULL CHECK(budgetedHours > 0),
	FOREIGN KEY(dNum) REFERENCES department(dNumber) ON DELETE SET NULL
);

SHOW ERRORS;

/*
** ----------------------------------------------------------------------------
** script to create the worksOn table 
** --------------------------------------------------------------------------*/

CREATE TABLE worksOn (
	eSSN			VARCHAR2(9),
	pNo			INTEGER	,
	hoursSpent  		FLOAT NOT NULL CHECK(hoursSpent >= 0),
	PRIMARY KEY (eSSN,pNo),
	FOREIGN KEY(eSSN) REFERENCES employee(ssn) ON DELETE CASCADE,
	FOREIGN KEY(pNo) REFERENCES project(pNumber) ON DELETE CASCADE
);
SHOW ERRORS;

/*
** ----------------------------------------------------------------------------
** script to create the dependent table 
** --------------------------------------------------------------------------*/

CREATE TABLE dependent (
	eSSN			VARCHAR2(9),
	dependentName 		VARCHAR2(20),
	sex			CHAR(1)	NOT NULL CHECK (sex = 'F' OR sex = 'M'),
	bDate			DATE	NOT NULL,
	relationship		VARCHAR2(20) NOT NULL,
	PRIMARY KEY(eSSN,dependentName),
	FOREIGN KEY(eSSN) REFERENCES employee(ssn) ON DELETE CASCADE
);

SHOW ERRORS;

/*
** ----------------------------------------------------------------------------
** script to create the consultant table 
** --------------------------------------------------------------------------*/

CREATE TABLE consultant (
 eSSN       		VARCHAR2(9),
 consultantCompan	VARCHAR2(20),
 contractCost 		FLOAT NOT NULL CHECK(contractCost >=0),
 PRIMARY KEY(eSSN, consultantCompany),
 FOREIGN KEY(eSSN) REFERENCES employee(ssn) ON DELETE CASCADE
 );
 
 SHOW ERRORS;
 