--Week 7 Assignment

--1.--
--Create a new database in PostgreSQL. You may use a graphical tool to populate the database.

CREATE DATABASE assignment7;

--2.--
--Populate your newly created database with two tables that have a one-to-many relationship. 
--You should create the two tables using the CREATE TABLE command. There should be at least one 
--example each of integer, numeric, character, and a date data type in at least one of the two tables. 
--There should be at least one character column that allows NULLs. 
--Deliverable: Your two CREATE TABLE statements.

--table 1
CREATE TABLE inventory (
	itemId integer NOT NULL,
	itemCategory VARCHAR(50) NOT NULL,
	itemName VARCHAR(255) NOT NULL,
	price NUMERIC(10,2) NOT NULL,
	numInStock INTEGER NOT NULL,
	PRIMARY KEY (itemId)
); 

--table 2
CREATE TABLE orders (
	orderId SERIAL,
	title VARCHAR(10),
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	purchaseDate Date NOT NULL,
	itemId INTEGER NOT NULL REFERENCES inventory(itemId),
	itemName VARCHAR(255) NOT NULL,
	PRIMARY KEY (orderId)
); 

--3.--
--Populate the two tables with some sample data, using INSERT statements. Each table should contain 
--at least three records, and the data should accurately reflect the one-to-many relationship. 
--There should also be at least one row where the character column that allows NULL values has a value of NULL. 
--Deliverable: your set of INSERT statements.

INSERT INTO inventory (itemId,itemCategory, itemName,price,numInStock)
VALUES
    (1,'household','toothpaste',2.50,10),
    (2,'household','tissues',3.10,30),
    (3,'office','pencils',3.25,50),
    (4,'office','notepads',4.35,6),
    (5,'office','pens',2.54,100)
    ;

INSERT INTO orders (title, firstName,lastName,purchaseDate,itemID,itemName)
VALUES
    ('Mr.','John','Smith','2014-02-01',1,'toothpaste'),
    (NULL,'Jane','Doe','2014-03-10',2,'tissues'),
    ('Mrs.','Ann','Smith','2014-04-10',3,'pencils'),
    (NULL,'Jane','Doe','2014-03-25',4,'notepads')
    ;

--4. --
--Provide samples of the different kinds of joins across the two tables. You should include one join that 
--performs a WHERE on the COLUMN that allows a NULL value. Deliverable: Your SELECT statements.

--inner join
SELECT
	orders.orderId,
	orders.title,
	orders.firstName,
	orders.lastName,
	orders.purchaseDate,
	inventory.itemCategory,
	orders.itemId,
	orders.itemName,
	inventory.price
FROM
	orders
INNER JOIN inventory ON orders.itemId = inventory.itemId
WHERE
	title LIKE 'Mr%';

--left join
SELECT
	inventory.itemCategory,
	inventory.itemId,
	inventory.itemName,
	inventory.price,
	inventory.numInStock,
	orders.orderId,
	orders.title,
	orders.firstName,
	orders.lastName
	
FROM
	inventory
LEFT JOIN orders ON inventory.itemId = orders.itemId;


--5.--
--Create an Entity-Relationship (ER) diagramthat shows the two tables that you created. 
--An example of an ER diagram can be found here: 
--http://www.postgresqltutorial.com/wp-content/uploads/2013/05/PostgreSQL-Sample-Database.png
--You can generate the ER diagram with a tool, or hand-sketch, then photograph or scan. 
--Deliverable: a .PNG or .PDF of your ER diagram.

--SEE ATTACHED FILE (created with Visio and printed to pdf)
