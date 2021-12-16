USE shop;

/*
 * Задание 1.Составьте список пользователей users,
 *  которые осуществили хотя бы один заказ orders в интернет магазине. 
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
 * Задание 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
 */


SELECT 
	products.name,
	catalogs.name 
FROM 
	products JOIN catalogs
	ON products.catalog_id = catalogs.id 


/*
 * Задание 3. Пусть имеется таблица рейсов flights (id, from, to)
 *  и таблица городов cities (label, name). Поля from, to и label
 *  содержат английские названия городов, поле name — русское. Выведите 
 * список рейсов flights с русскими названиями городов.
 */
	
-- Создаем таблицу flights
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

-- Создаем таблицу ситис
CREATE TABLE cities (
	lable VARCHAR (255),
	name VARCHAR (255)
);
	
INSERT INTO cities VALUES
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'),
('kazan', 'Казань'),
('omsk', 'Омск');
	
	
-- переводим на русский столбец from
SELECT flights.id, cities.name FROM 
flights JOIN cities
ON flights.`from` = cities.lable
ORDER BY flights.id;

-- переводим на русский столбец to
SELECT flights.id, cities.name FROM 
flights JOIN cities
ON flights.`to` = cities.lable
ORDER BY flights.id;

-- Выводим новую таблицу flight c русскими названиями городов
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





