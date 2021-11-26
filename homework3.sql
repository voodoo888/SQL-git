DROP DATABASE IF EXISTS vk;

CREATE DATABASE vk;

-- ���������� ���� ������ VK
USE vk;

/*
 * ��� ������������� �����������.
 * 
 * 1) �� mail ���� ������, ������ ����� ���������� �������.
 * 
 * 2) ���������� ������ - ��� �� ����� ������, ������� ������������� �����������, ��� ��� �������� � ������� ���������.
 *  
 */
-- DROP TABLE IF EXISTS users;

-- ������� ������

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

-- ���������� ��� ������� 
INSERT INTO users
VALUES (1, 'Petya', 'Petukhov','99999999929', 'petya@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', DEFAULT, DEFAULT);

INSERT INTO users (firstname, lastname, email, password_hash, phone)
VALUES ('Vasya', 'Vasilkov', 'vasya@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', '99999999919');

SELECT * FROM users;

SHOW TABLES;

-- ������� ��������� ������

CREATE TABLE profiles(
	user_id SERIAL PRIMARY KEY, -- (SERIAL)BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	gender ENUM('f','m','x'),
	birthday DATE NOT NULL,
	photo_id BIGINT UNSIGNED NOT NULL,
	city VARCHAR(130),
	country VARCHAR(130),
	FOREIGN KEY (user_id) REFERENCES users (id)
	
);


INSERT INTO profiles VALUES (1, 'm', '1997-12-01', 1, 'Moscow', 'Russia'); -- ������� ����
INSERT INTO profiles VALUES (2, 'm', '1988-11-02', 5, 'Moscow', 'Russia'); -- ������� ����

-- ������� ���������

CREATE TABLE messages(
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL, -- �� �� ���� ������ ���������
	to_user_id BIGINT UNSIGNED NOT NULL, -- ��, � ���� ���������
	body TEXT, -- ���� ���������
	create_at DATETIME DEFAULT NOW(), -- ����������
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- ���������, ��������
	is_delivered BOOLEAN DEFAULT FALSE, --  ����������/�� ����������
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Hi!', DEFAULT, DEFAULT, DEFAULT); -- ��������� �� ���� � ���� ����� 1
INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Vasya!', DEFAULT, DEFAULT, DEFAULT); -- ��������� �� ���� � ���� ����� 2
INSERT INTO messages VALUES (DEFAULT, 2, 1, 'Hi, Petya', DEFAULT, DEFAULT, DEFAULT); -- ��������� �� ���� � ���� ����� 2

SELECT * FROM messages;

-- ������� �������� � ������

CREATE TABLE friend_requests(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	accepted BOOL DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_user_id),
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

INSERT INTO friend_requests VALUES (1, 2, DEFAULT); -- ������ � ������


-- ������� ����������

CREATE TABLE communities(
	id SERIAL,
	name VARCHAR(145) NOT NULL, -- �������� ����������
	description VARCHAR(255), -- �������� ����������
	admin_id BIGINT UNSIGNED NOT NULL, -- ����� ����������
	INDEX communities_name_idx (name), -- ������ ������� ��������� ����� ������ ������ �� ������� ���� 
	CONSTRAINT fk_communities_admin_id FOREIGN KEY (admin_id) REFERENCES users (id)
);

INSERT INTO communities VALUES (DEFAULT, 'Number1', 'I am number one', 1);

-- ������� ���������� ����������

CREATE TABLE communities_users(
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(community_id, user_id),
	FOREIGN KEY (community_id) REFERENCES communities (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO communities_users VALUES (1, 2);

-- ������� ��� ����� ������

CREATE TABLE media_types(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(45) NOT NULL UNIQUE
);

INSERT INTO media_types VALUES (DEFAULT, '�����������');
INSERT INTO media_types VALUES (DEFAULT, '������');
INSERT INTO media_types VALUES (DEFAULT, '��������');

-- ������� � ������� ����� ��������� ���� � ����� ������

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

-- ��������� ������� ������� ����

INSERT INTO media VALUES (DEFAULT, 1, 1, 'im.jpeg', 100, DEFAULT);
INSERT INTO media VALUES (DEFAULT, 1, 2, 'im.txt', 200, DEFAULT);

-- ��������� ������� ������� ����

INSERT INTO media VALUES (DEFAULT, 2, 3, '4m.mp3', 480, DEFAULT);
INSERT INTO media VALUES (DEFAULT, 2, 2, 'im.mp4', 10, DEFAULT);

/*

�������� ������

*/

-- ������� ����� ��������� ����

CREATE TABLE type_of_news(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(120) NOT NULL UNIQUE
);

INSERT INTO type_of_news VALUES (DEFAULT, '����������������');
INSERT INTO type_of_news VALUES (DEFAULT, '����������');
INSERT INTO type_of_news VALUES (DEFAULT, '�����');

-- ������� ����������� ����������

CREATE TABLE privacy_rank(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO privacy_rank VALUES (DEFAULT, '������ ������');
INSERT INTO privacy_rank VALUES (DEFAULT, '������ � ������, ��� ����������� ��������');
INSERT INTO privacy_rank VALUES (DEFAULT, '��������� ���');

-- ������� ���������� � ����� ��������

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




