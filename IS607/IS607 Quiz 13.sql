--create table with employee ID, name, and department
CREATE TABLE employees (
	Id SERIAL,
	fullName VARCHAR(50) NOT NULL,
	departmentName VARCHAR(255),
	PRIMARY KEY (Id)
);  

--populate table with insert function
INSERT INTO employees (fullName,departmentName)
VALUES
    ('John Smith','Accounting'),
    ('Bob White','Finance'),
    ('Tim Jones','HR')
    ;

--resulting table
--1;"John Smith";"Accounting"
--2;"Bob White";"Finance"
--3;"Tim Jones";"HR"

--stored procedure to insert or update a row depending on whether the employee already exists in the employees table
CREATE OR REPLACE FUNCTION DeptUpdate(fName TEXT,dName TEXT)
RETURNS void AS $$
BEGIN
	UPDATE employees
	SET departmentName = dName
	WHERE fullName LIKE fName;
	INSERT INTO employees (fullName, departmentName)
	SELECT
	      fname,dname
	WHERE NOT EXISTS
	(SELECT fullName 
	FROM employees 
	WHERE fullName LIKE fname);
 
END; 
$$ LANGUAGE PLPGSQL;

--call the function to add new employees or update the department for existing employees

SELECT DeptUpdate('David Thompson','IT') --function will insert this into the new table

--resulting table
--1;"John Smith";"Accounting"
--2;"Bob White";"Finance"
--3;"Tim Jones";"HR"
--4;"David Thompson";"IT"

SELECT DeptUpdate('David Thompson','HR')
--resulting table
--1;"John Smith";"Accounting"
--2;"Bob White";"Finance"
--3;"Tim Jones";"HR"
--4;"David Thompson";"HR"
