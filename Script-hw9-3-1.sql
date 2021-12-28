-- ЗАДАНИЕ 1
DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS char(50) DETERMINISTIC
BEGIN 
	IF 
		time_format(now(), '%H') < 12 AND time_format(now(), '%H')>6 THEN 
		RETURN 'Dobroe utro';
	ELSEIF
		time_format(now(), '%H') < 18 AND time_format(now(), '%H')>12 THEN 
		RETURN 'Добрый день';
	ELSEIF
		time_format(now(), '%H') > 18 THEN
		RETURN 'Добрый вечер!';
	ELSE 
		RETURN 'Доброй ночи!';
	END IF; 
END// 
DELIMITER ;

SELECT hello();

