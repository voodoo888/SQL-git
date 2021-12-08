USE shop;
DROP TABLE users_new;
CREATE TABLE users_new (
id SERIAL PRIMARY KEY,
created_at VARCHAR(255),
name_id VARCHAR(255)
);

INSERT INTO users_new (created_at, name_id) VALUES
('20.10.2017 8:10', 'vas'),
('29.01.2017 8:11', 'uas');

-- брнпне гюдюмхе 

-- SELECT created_at FROM users_new;
-- SELECT str_to_date(created_at, '%d.%m.%Y %h:%m') AS date_norm FROM users_new;
 UPDATE users_new SET 
 created_at = str_to_date(created_at, '%d.%m.%Y %h:%m');
 ALTER TABLE users_new MODIFY created_at DATETIME;


-- оепбне гюдюмхе 
INSERT INTO users_new (name_id, created_at) VALUES ('fuc', null);
UPDATE users_new SET
created_at = now()
WHERE created_at IS NULL;

-- рперэе гюдюмхе

INSERT INTO storehouses_products (storehouses_id, product_id, value) VALUES
(1,2,0),
(2,2,2500),
(4,2,0),
(1,2,30),
(1,5,500),
(1,3,1);

SELECT value, IF (value>0,1,2) AS not_zero FROM storehouses_products ORDER BY not_zero, value;

SELECT date_format(birthday_at, '%M') FROM users;

-- вербепрне гюдюмхе

SELECT name, date_format(birthday_at, '%M') AS birthday 
FROM users 
where 
date_format(birthday_at, '%M') LIKE 'May' 
OR
date_format(birthday_at, '%M') LIKE 'August'; 

-- оърне гюдюмхе

SELECT * FROM catalogs WHERE id IN (5,1,2) ORDER BY field(id, 5, 1, 2);
		

-- юцпецюжхъ дюммшу --


-- оепбне гюдюмхе

SELECT name, timestampdiff(YEAR, birthday_at, now()) AS age FROM users;
SELECT avg(timestampdiff(YEAR, birthday_at, now())) AS srednii_vozrast FROM users;

-- брнпне гюдюмхе

SELECT 
count(*),
dayofweek(str_to_date((concat(date_format(birthday_at, '%m,%d'), ',2021')),'%m,%d,%Y')) AS day_week
FROM users
GROUP BY day_week;

						
-- рперэе гюдюмхе

CREATE TABLE tbl_hw(
id SERIAL PRIMARY KEY,
value int);
						
INSERT INTO tbl_hw (value) VALUES 
(1), (2), (3), (4), (5);


SELECT exp(sum(ln(value))) as product FROM tbl_hw;




						