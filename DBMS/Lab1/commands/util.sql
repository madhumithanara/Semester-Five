-- Before create schema objects, run util.sql to see if there is any extra schema objects
-- After drop schema objects, run util.sql to make sure all the schema objects are correctly droped.  

COLUMN object_name FORMAT A20;
COLUMN object_type FORMAT A15;

SELECT object_name, object_type from user_objects 
where object_name not like 'BIN%'
order by object_type;