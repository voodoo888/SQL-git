USE shop;

/*
 * ������� 1.��������� ������ ������������� users,
 *  ������� ����������� ���� �� ���� ����� orders � �������� ��������. 
 */


INSERT  INTO orders (user_id) VALUES 
(2),
(2),
(3),
(4),
(1);

SELECT 
	users.name,
	orders.id AS orders_id,
	orders.user_id 
FROM 
	users JOIN orders
	ON users.id = orders.user_id
GROUP BY user_id;


/*
 * ������� 2. �������� ������ ������� products � �������� catalogs, ������� ������������� ������.
 */


SELECT 
	products.name,
	catalogs.name 
FROM 
	products JOIN catalogs
	ON products.catalog_id = catalogs.id 


/*
 * ������� 3. ����� ������� ������� ������ flights (id, from, to)
 *  � ������� ������� cities (label, name). ���� from, to � label
 *  �������� ���������� �������� �������, ���� name � �������. �������� 
 * ������ ������ flights � �������� ���������� �������.
 */
	
-- ������� ������� flights
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	`from` VARCHAR (255),
	`to` VARCHAR (255)
);
	
INSERT INTO flights VALUES
(DEFAULT, 'moscow', 'omsk'),
(DEFAULT, 'novgorod', 'kazan'),
(DEFAULT, 'irkutsk', 'moscow'),
(DEFAULT, 'omsk', 'irkutsk'),
(DEFAULT, 'moscow', 'kazan');

-- ������� ������� �����
CREATE TABLE cities (
	lable VARCHAR (255),
	name VARCHAR (255)
);
	
INSERT INTO cities VALUES
('moscow', '������'),
('irkutsk', '�������'),
('novgorod', '��������'),
('kazan', '������'),
('omsk', '����');
	
	
-- ��������� �� ������� ������� from
SELECT flights.id, cities.name FROM 
flights JOIN cities
ON flights.`from` = cities.lable
ORDER BY flights.id;

-- ��������� �� ������� ������� to
SELECT flights.id, cities.name FROM 
flights JOIN cities
ON flights.`to` = cities.lable
ORDER BY flights.id;

-- ������� ����� ������� flight c �������� ���������� �������
SELECT * from
(SELECT flights.id, cities.name AS `from` FROM 
flights JOIN cities
ON flights.`from` = cities.lable) AS a 
JOIN 
(SELECT flights.id, cities.name AS `to` FROM 
flights JOIN cities
ON flights.`to` = cities.lable) AS b
ON a.id = b.id
ORDER BY a.id;





