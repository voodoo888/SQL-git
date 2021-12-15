-- HOMEWORK FROM LESSON 6
USE vk;
/*
 * ������� 1.  ����� ����� ��������� ������������. �� ���� ������������� ���. ���� 
 * ������� ��������, ������� ������ ���� ������� � ��������� ������������� (������� ��� ���������).
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
to_user_id = 3  -- ���������� ����� ���� id ������������
GROUP BY from_user_id
ORDER by count_messages DESC
LIMIT 1;

/*
 * ������� 2. ���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���
*/

-- ���������� �������������, ������� ������ 10 ���
SELECT 
user_id 
FROM profiles
WHERE 
TIMESTAMPDIFF(YEAR, birthday, Now()) < 10;

-- ���������� ����� ���������� ��������������, ������� ������ 10 ���
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


-- ������������ ����� � ������� 
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


-- ��������� ���������� �������
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
								TIMESTAMPDIFF(YEAR, birthday, Now()) < 35)  -- ���� ����� ������� ������� ������ 10 ���
			)
GROUP BY post_id, like_type) AS x;


/*
 * ������ 3. ���������� ��� ������ �������� ������ �����. ������� ��� �������.
 */

-- ���������� ������������� ������
SELECT
	user_id
FROM profiles
WHERE gender = 'm';

-- ���������� ������������� ������
SELECT
	user_id
FROM profiles
WHERE gender = 'f';


-- ��������� ���������� �� ���������� ������ ������
SET @female := (SELECT 
	count(user_id) AS female
	FROM posts_likes
	WHERE like_type = 1
	AND user_id IN (SELECT
		user_id
	FROM profiles
	WHERE gender = 'f'));

-- ��������� ���������� �� ���������� ������ ������
SET @male := (SELECT 
	count(user_id) AS male
	FROM posts_likes
	WHERE like_type = 1
	AND user_id IN (SELECT
		user_id
	FROM profiles
	WHERE gender = 'm'));

-- ���������� � ������� ���������
SELECT IF (@female > @male, '������� ������', '������� ������') AS who_more_likes;




