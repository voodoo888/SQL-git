DROP DATABASE IF EXISTS vk;

CREATE DATABASE vk;

-- используем базу данных VK
USE vk;

/*
 * Это многострочный комментарий.
 * 
 * 1) По mail усть индекс, значит поиск произойдет быстрее.
 * 
 * 2) Уникальный индекс - тот же самый индекс, который дополнительно гарантирует, что все значения в колонке уникальны.
 *  
 */
-- DROP TABLE IF EXISTS users;

-- ТАБЛИЦА ЮЗЕРОВ

CREATE TABLE users(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(55) NOT NULL,
	lastname VARCHAR(50) NOT NULL,
	phone CHAR(11) NOT NULL,
	email VARCHAR(120) UNIQUE,
	password_hash CHAR(65),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE  CURRENT_TIMESTAMP,
	INDEX(lastname),
	INDEX(phone)
);

-- показываем все таблицы 
INSERT INTO users
VALUES (1, 'Petya', 'Petukhov','99999999929', 'petya@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', DEFAULT, DEFAULT);

INSERT INTO users (firstname, lastname, email, password_hash, phone)
VALUES ('Vasya', 'Vasilkov', 'vasya@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', '99999999919');

SELECT * FROM users;

SHOW TABLES;

-- ТАБЛИЦА ПРОФАЙЛОВ ЮЗЕРОВ

CREATE TABLE profiles(
	user_id SERIAL PRIMARY KEY, -- (SERIAL)BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	gender ENUM('f','m','x'),
	birthday DATE NOT NULL,
	photo_id BIGINT UNSIGNED NOT NULL,
	city VARCHAR(130),
	country VARCHAR(130),
	FOREIGN KEY (user_id) REFERENCES users (id)
	
);


INSERT INTO profiles VALUES (1, 'm', '1997-12-01', 1, 'Moscow', 'Russia'); -- профиль Пети
INSERT INTO profiles VALUES (2, 'm', '1988-11-02', 5, 'Moscow', 'Russia'); -- профиль Васи

-- ТАБЛИЦА СООБЩЕНИЙ

CREATE TABLE messages(
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL, -- то от кого пришло сообщение
	to_user_id BIGINT UNSIGNED NOT NULL, -- то, к кому сообщение
	body TEXT, -- текс сообщения
	create_at DATETIME DEFAULT NOW(), -- отправлено
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- прочитано, изменено
	is_delivered BOOLEAN DEFAULT FALSE, --  доставлено/не доставлено
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Hi!', DEFAULT, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 1
INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Vasya!', DEFAULT, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 2
INSERT INTO messages VALUES (DEFAULT, 2, 1, 'Hi, Petya', DEFAULT, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 2

SELECT * FROM messages;

-- ТАБЛИЦА ЗАПРОСОВ В ДРУЗЬЯ

CREATE TABLE friend_requests(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	accepted BOOL DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_user_id),
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

INSERT INTO friend_requests VALUES (1, 2, DEFAULT); -- запрос в дпузья


-- ТАБЛИЦА СООБЩЕСТВО

CREATE TABLE communities(
	id SERIAL,
	name VARCHAR(145) NOT NULL, -- название сообщества
	description VARCHAR(255), -- описание сообщества
	admin_id BIGINT UNSIGNED NOT NULL, -- админ сообщества
	INDEX communities_name_idx (name), -- индекс который позволяет очень быстро искать по столбцу нэйм 
	CONSTRAINT fk_communities_admin_id FOREIGN KEY (admin_id) REFERENCES users (id)
);

INSERT INTO communities VALUES (DEFAULT, 'Number1', 'I am number one', 1);

-- ТАБЛИЦА УЧАСТНИКОВ СООБЩЕСТВА

CREATE TABLE communities_users(
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(community_id, user_id),
	FOREIGN KEY (community_id) REFERENCES communities (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO communities_users VALUES (1, 2);

-- ТАБЛИЦА ДЛЯ ТИПОВ ФАЙЛОВ

CREATE TABLE media_types(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(45) NOT NULL UNIQUE
);

INSERT INTO media_types VALUES (DEFAULT, 'изображение');
INSERT INTO media_types VALUES (DEFAULT, 'музыка');
INSERT INTO media_types VALUES (DEFAULT, 'документ');

-- ТАБЛИЦА В КОТОРОЙ БУДУТ ХРАНИТЬСЯ ПУТИ К НАШИМ ФАЙЛАМ

CREATE TABLE media(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_types_id INT UNSIGNED NOT NULL,
	file_name VARCHAR(255),
	file_size BIGINT UNSIGNED,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (media_types_id) REFERENCES media_types (id)
);

-- Документы которые добавил Петя

INSERT INTO media VALUES (DEFAULT, 1, 1, 'im.jpeg', 100, DEFAULT);
INSERT INTO media VALUES (DEFAULT, 1, 2, 'im.txt', 200, DEFAULT);

-- Документы которые добавил Вася

INSERT INTO media VALUES (DEFAULT, 2, 3, '4m.mp3', 480, DEFAULT);
INSERT INTO media VALUES (DEFAULT, 2, 2, 'im.mp4', 10, DEFAULT);

/*

ДОМАШНЯЯ РАБОТА

*/

-- ТАБЛИЦА ТИПОВ НОВОСТНЫХ ЛЕНТ

CREATE TABLE type_of_news(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(120) NOT NULL UNIQUE
);

INSERT INTO type_of_news VALUES (DEFAULT, 'Пользовательская');
INSERT INTO type_of_news VALUES (DEFAULT, 'Сообщества');
INSERT INTO type_of_news VALUES (DEFAULT, 'Общая');

-- ТАБЛИЦА ПРИВАТНОСТИ ПУБЛИКАЦИЙ

CREATE TABLE privacy_rank(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO privacy_rank VALUES (DEFAULT, 'Только чтение');
INSERT INTO privacy_rank VALUES (DEFAULT, 'Чтение и запись, без возможности удаления');
INSERT INTO privacy_rank VALUES (DEFAULT, 'Разрешено все');

-- ТАБЛИЦА ПУБЛИКАЦИЙ В ЛЕНТЕ НОВОСТЕЙ

CREATE TABLE publications(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	type_of_news_id INT UNSIGNED NOT NULL,
	media_types_id INT UNSIGNED NOT NULL,
	privacy_rank_id INT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (type_of_news_id) REFERENCES type_of_news(id),
	FOREIGN KEY (media_types_id) REFERENCES media_types(id),
	FOREIGN KEY (privacy_rank_id) REFERENCES privacy_rank(id)

);

INSERT INTO publications VALUES (DEFAULT, 1, 2, 2, 2, DEFAULT);
INSERT INTO publications VALUES (DEFAULT, 2, 3, 1, 1, DEFAULT);




