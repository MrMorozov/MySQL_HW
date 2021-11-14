Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени 
суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна 
возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".


DROP PROCEDURE IF EXISTS time_of_day;
DELIMITER //

CREATE PROCEDURE time_of_day()
BEGIN
  SELECT CURTIME() INTO @ctime;
  IF @ctime>=TIME("6:00") AND @ctime<TIME("12:00") THEN
  	SELECT "Доброе утро";
  ELSEIF @ctime>=TIME("12:00") AND @ctime<TIME("18:00") THEN
  	SELECT "Добрый день";
  ELSEIF @ctime>=TIME("18:00") AND @ctime<=TIME("23:59:59") THEN
  	SELECT "Добрый вечер";
  ELSE
  	SELECT "Доброй ночи";
  END IF;
END//

CALL time_of_day//


