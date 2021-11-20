# (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.


# Тут я воспользуюсь процедурой с циклом for
# Мне не понравилась реализация for в mysql, буду использовать while

DROP PROCEDURE IF EXISTS one_million_rows_into_users;
DELIMITER //

CREATE PROCEDURE one_million_rows_into_users()
BEGIN
	DECLARE mx int UNSIGNED DEFAULT 1000000;
	DECLARE counter int UNSIGNED DEFAULT 1;
	DECLARE name_ VARCHAR(255);
	DECLARE birthday datetime;
	START TRANSACTION;
	WHILE mx>=counter DO
		SET name_ = 
			(SELECT name FROM users as t,
			(SELECT ROUND((SELECT MAX(id) FROM users) *rand()) as rnd 
			FROM users LIMIT 1) tmp
			WHERE id in (rnd)
			ORDER BY id);
		SET birthday = 
			(SELECT birthday_at FROM users as t,
			(SELECT ROUND((SELECT MAX(id) FROM users) *rand()) as rnd 
			FROM users LIMIT 1) tmp
			WHERE id in (rnd)
			ORDER BY id);
		INSERT INTO users (name, birthday_at) VALUES(name_,birthday);
		SET counter = counter + 1;
	END WHILE;
COMMIT;
END//

# Данное задание можно было сделать без выбора данных из таблицы, но тогда бы не было задачи по оптимизации запросов выбора.
# В выборе запроса для определения вставляемых переменных я основывался на https://habr.com/ru/post/154905/ и пробовал разные 
# варианты сам. Генераторами заморачиваться не стал, потребовалось бы написать не мало доп. функций для выбора случайной даты 
# Чтобы она была не больше сегодняшней, а так же для назначения правдоподобных имен.


# Проверим работу процедуры:

CALL one_million_rows_into_users;

# Процедура работала долго, возможно ее можно оптимизировать

SELECT * FROM users LIMIT 100;


# По какой-то причине в результате есть пропуски в выборе даты, появились строки с значениям NULL
# Буду двигаться дальше.
