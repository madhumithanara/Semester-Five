/*
** ----------------------------------------------------------------------------
** script to drop all objects in the database
** --------------------------------------------------------------------------*/

-- Tables
/**/
DROP TABLE worksOn purge;
DROP TABLE dependent purge;
DROP TABLE deptLocation purge;
DROP TABLE project purge;
DROP TABLE employee CASCADE CONSTRAINTS purge;
DROP TABLE department purge;
DROP TABLE consultant purge;

-- Views for query
DROP VIEW projectHours;
DROP VIEW projectExEmp;
DROP VIEW empDependentCount;


