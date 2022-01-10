USE kinopoisk;

-- 1) Выбрать все фильмы комедии

SELECT * FROM films WHERE film_type = (SELECT id FROM film_type WHERE name = 'Комедии');

-- 2) Выбрать названия фильмов жанра "Триллеры" которые уже кто либо смотрел
SELECT DISTINCT name FROM films AS f
JOIN user_library ul ON f.id = ul.film_id
WHERE f.film_type = (SELECT id FROM film_type WHERE name = 'Триллеры');

-- 3) Вывести 5 фильмов которые пользователи просмотрели  и отсортировать их по рейтингу
SELECT count(*) AS counts, f.name, fr.raiting FROM films AS f
JOIN user_library AS ul ON f.id = ul.film_id
JOIN film_rating AS fr ON f.id = fr.film_id
GROUP BY f.id 
ORDER BY fr.raiting DESC, counts DESC 
LIMIT 5;

-- 4) Представление: лучшие  фильмы для детей до 6 лет 
CREATE OR REPLACE VIEW favorit_films AS 
SELECT f.name FROM films AS f 
JOIN user_collection uc ON f.id = uc.film_id AND f.age_limit = 1
JOIN film_rating AS fr ON fr.film_id = f.id 
GROUP BY uc.film_id 
ORDER BY uc.film_id DESC;

-- 5) Представление: фильмы которые еще никто не смотрел.
CREATE OR REPLACE VIEW new_film AS SELECT films.id, films.name FROM films, user_library WHERE films.id NOT IN (SELECT ul2.film_id FROM user_library ul2)
GROUP BY id
ORDER BY films.id;

/*
 *   6) Создать триггер добавляющий после просмотра фильма 
 * его в статистическую таблицу для дальнейшей обработки 
 * (процентное соотношение длительности просмотра для примера взято NULL)
 */

delimiter //
CREATE TRIGGER viewed_time_adder AFTER INSERT ON user_library
FOR EACH ROW 
BEGIN 
	INSERT INTO viewed_time_type (user_id, film_id, viewed_time) VALUES (NEW.user_id, NEW.film_id, NULL);
END//
delimiter ;

INSERT INTO user_library (user_id, film_id) VALUES (20,23);


