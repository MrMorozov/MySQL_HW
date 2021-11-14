(По желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
Вызов функции FIBONACCI(10) должен возвращать число 55.


# Очевидно необходимо делать через цикл. Я обчно предпочитаю всегда использовать for, но в методичке был описан цыкл while для процедур. Сделал по анологии.

DROP FUNCTION IF EXISTS FIBONACCI;
DELIMITER //
CREATE FUNCTION FIBONACCI (val INT)
RETURNS BIGINT DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT val;
	DECLARE sum_ BIGINT DEFAULT 0;
	WHILE i >= 0 DO
		SET sum_ = i + sum_;
		SET i = i - 1;
	END WHILE;
	RETURN sum_;
END;
DELIMITER ;

SELECT FIBONACCI(10);

# Возвращает:
55
