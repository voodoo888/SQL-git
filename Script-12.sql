-- HOMEWORK FROM LESSON 6
USE vk;
/*
 * Задание 1.  Пусть задан некоторый пользователь. Из всех пользователей соц. сети 
 * найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
*/

SELECT
(SELECT
group_concat(firstname, lastname SEPARATOR '=')
FROM
users
WHERE
id = messages.to_user_id) AS name,
count(*) AS count_messages,
(SELECT
group_concat(firstname, lastname SEPARATOR '=')
FROM
users
WHERE
id = messages.from_user_id) AS from_user_id 
FROM messages
WHERE 
to_user_id = 3  -- НЕОБХОДИМО ВБИТЬ СЮДА id ПОЛЬЗОВАТЕЛЯ
GROUP BY from_user_id
ORDER by count_messages DESC
LIMIT 1;

/*
 * Задание 2. Подсчитать общее количество лайков, Которые получили пользователи младше 10 лет
*/

-- определяем пользователей, которые младше 10 лет
SELECT 
user_id 
FROM profiles
WHERE 
TIMESTAMPDIFF(YEAR, birthday, Now()) < 10;

-- определяем посты написанные пользователями, которые младше 10 лет
SELECT 
id 
FROM posts
WHERE 
user_id IN (SELECT 
user_id 
FROM profiles
WHERE 
TIMESTAMPDIFF(YEAR, birthday, Now()) < 10)
;


-- подсчитываем посты с лайками 
SELECT
count(*)
-- post_id,
-- like_type
FROM posts_likes
WHere 
like_type = 1
AND 
post_id IN (SELECT 
				id 
			FROM posts
			WHERE 
				user_id IN (SELECT 
								user_id 
							FROM profiles
							WHERE 
								TIMESTAMPDIFF(YEAR, birthday, Now()) < 35)
			)
GROUP BY post_id, like_type;


-- суммируем полученный столбец
SELECT 
sum(cnt) AS SUM_TOTAL_LIKES FROM (SELECT
count(*) AS cnt
-- post_id,
-- like_type
FROM posts_likes
WHere 
like_type = 1
AND 
post_id IN (SELECT 
				id 
			FROM posts
			WHERE 
				user_id IN (SELECT 
								user_id 
							FROM profiles
							WHERE 
								TIMESTAMPDIFF(YEAR, birthday, Now()) < 35)  -- СЮДА НУЖНО ВВОДИТЬ ВОЗРАСТ ВМЕСТО 10 ЛЕТ
			)
GROUP BY post_id, like_type) AS x;


/*
 * Задача 3. Определить кто больше поставил лайков всего. Мужчины или женщины.
 */

-- определяем пользователей мужчин
SELECT
	user_id
FROM profiles
WHERE gender = 'm';

-- определяем пользователей женщин
SELECT
	user_id
FROM profiles
WHERE gender = 'f';


-- Объявляем переменную по количеству лайков женщин
SET @female := (SELECT 
	count(user_id) AS female
	FROM posts_likes
	WHERE like_type = 1
	AND user_id IN (SELECT
		user_id
	FROM profiles
	WHERE gender = 'f'));

-- Объявляем переменную по количеству лайков женщин
SET @male := (SELECT 
	count(user_id) AS male
	FROM posts_likes
	WHERE like_type = 1
	AND user_id IN (SELECT
		user_id
	FROM profiles
	WHERE gender = 'm'));

-- Сравниваем и выводим результат
SELECT IF (@female > @male, 'Женщины больше', 'Мужчины больше') AS who_more_likes;




