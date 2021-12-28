-- мнлеп 1

START TRANSACTION;
INSERT INTO sample.users (id,name) VALUES 
((SELECT id FROM shop.users WHERE id = 1), (SELECT name FROM shop.users WHERE id =1));
DELETE FROM shop.users WHERE id = 1 LIMIT 1;
COMMIT;

-- мнлеп 2
USE shop;
CREATE VIEW cat_name AS 
SELECT p.name, a.name AS cat_name FROM products AS p
join 
catalogs AS a ON a.id = p.catalog_id;

SELECT * FROM cat_name;

-- мнлеп 3
CREATE TABLE tbl1 (
id SERIAL PRIMARY KEY,
name VARCHAR(255),
created_at DATE NOT NULL);

INSERT INTO tbl1 (name, created_at) VALUES 
('Anna', '2018-08-01'),
('Bob', '2018-08-04'),
('Victory', '2018-08-16'),
('Svetlana', '2018-08-17');

DROP TABLE days;
CREATE TEMPORARY TABLE days (
days_num date);

INSERT INTO days VALUES
('2018-08-01'),
('2018-08-02'),
('2018-08-03'),
('2018-08-04'),
('2018-08-05'),
('2018-08-06'),
('2018-08-07'),
('2018-08-08'),
('2018-08-09'),
('2018-08-10'),
('2018-08-11'),
('2018-08-12'),
('2018-08-13'),
('2018-08-14'),
('2018-08-15'),
('2018-08-16'),
('2018-08-17'),
('2018-08-18'),
('2018-08-19'),
('2018-08-20'),
('2018-08-21'),
('2018-08-22'),
('2018-08-23'),
('2018-08-24'),
('2018-08-25'),
('2018-08-26'),
('2018-08-27'),
('2018-08-28'),
('2018-08-29'),
('2018-08-30'),
('2018-08-31')
;

SELECT d.days_num, NOT ISNULL(tbl_d.created_at) AS one_or_zero FROM days AS d
LEFT JOIN tbl1 AS tbl_d
ON tbl_d.created_at = d.days_num;

-- мнлеп 4
SELECT * FROM shop.tbl1;

INSERT INTO tbl1 (name, created_at) VALUES 
('Stas', '2018-08-02'),
('Bred', '2018-08-09'),
('Kiota', '2018-08-15'),
('Funtex', '2018-08-13');

SELECT * FROM shop.tbl1 ORDER BY created_at;

START TRANSACTION;
PREPARE prd FROM 'DELETE FROM shop.tbl1 ORDER BY created_at LIMIT ?';
SET @lim = (SELECT count(*) - 5 FROM shop.tbl1) ;
EXECUTE prd USING @lim;
COMMIT;

SELECT * FROM shop.tbl1 t ;

