USE VK;

-- 1) Добавление данных в таблицы по 10+ позиций в каждую 

INSERT INTO communities (name, description, admin_id)
VALUES 
	('number2', 'iam a number 2', 2),
	('number3', 'iam a number 3', 25),
	('number4', 'iam a number 4', 12),
	('number5', 'iam a number 5',2),
	('number6', 'iam a number 6', 2),
	('number7', 'iam a number 7', 25),
	('number8', 'iam a number 8', 9),
	('number9', 'iam a number 9', 10),
	('number10', 'iam a number 10', 32);

INSERT INTO communities_users VALUES (1,33);
INSERT INTO communities_users VALUES (33,33);
INSERT INTO communities_users VALUES (34,34);
INSERT INTO communities_users VALUES (35,35);
INSERT INTO communities_users VALUES (36,65);
INSERT INTO communities_users VALUES (37,85);
INSERT INTO communities_users VALUES (33,86);
INSERT INTO communities_users VALUES (33,103);
INSERT INTO communities_users VALUES (1,133);

INSERT INTO friend_requests (from_user_id, to_user_id)
VALUES 
	(18, 19),
	(18, 29),
	(18, 39),
	(18, 49),
	(18, 59),
	(18, 69),
	(18, 79),
	(18, 89),
	(18, 99);
	
INSERT INTO media_types SET name = 'текстовое сообщение';
INSERT INTO media_types SET name = 'цитата';
INSERT INTO media_types SET name = 'мем';
INSERT INTO media_types SET name = 'Смайл';
INSERT INTO media_types SET name = 'коллаж';
INSERT INTO media_types SET name = 'Фильм';
INSERT INTO media_types SET name = 'деньги';

INSERT INTO profiles (user_id, gender, birthday, photo_id, city, country)
VALUES 
	(4, 'f', '1987-12-01', 5, 'Moscow', 'Russia'),
	(8,'f', '1977-12-01', 1, 'New York', 'USA'),
	(9, 'm', '1977-12-01', 6, 'London', 'England'),
	(10, 'f', '1987-12-01', 8, 'Moscow', 'Russia'),
	(11, 'm', '1987-12-01', 1, 'Moscow', 'Russia'),
	(12, 'f', '1987-12-01', 1, 'London', 'England'),
	(13, 'm', '2007-12-01', 1, 'Moscow', 'Russia'),
	(14, 'm', '2007-12-01', 1, 'London', 'England'),
	(15, 'f', '2007-12-01', 1, 'Moscow', 'Russia');

-- 2) скрипт, возвращающий список имен (только firstname)
--  пользователей без повторений в алфавитном порядке
SELECT DISTINCT firstname FROM users ORDER BY firstname ASC;

/* 3) скрипт, отмечающий несовершеннолетних пользователей как 
	неактивных (поле is_active = false).
	Предварительно добавить такое поле в таблицу profiles
	со значением по умолчанию = true (или 1)
*/
ALTER TABLE profiles ADD is_activ BOOL DEFAULT TRUE;
UPDATE profiles 
SET is_activ = FALSE 
WHERE birthday >= '2003-01-12';

-- 4) удаляет сообщения у которых дата больше сегодняшней
DELETE FROM messages WHERE create_at > NOW();


