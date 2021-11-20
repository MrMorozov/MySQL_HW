# Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
# catalogs и products в таблицу logs помещается время и дата создания записи, 
# название таблицы, идентификатор первичного ключа и содержимое поля name.

# Как я понял из оптимизации тут только ENGINE таблицы, можно добавить индексы, 
# реализовать внешний ключ будет очень сложно, 
# но он был бы полезен для удаления записей каскадом, чего похоже не нужно
# В остальном задача больше для закрепления триггеров, их похоже понадобится три (только для добавления).

USE HW8_1;

# Создадим таблицу:

DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255),
  `table_name` varchar(10),
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)) 
 ENGINE=Archive;


# Один триггер для нескольких таблиц в mysqlсудя по информации из сети создать невозможно
# Триггер для catalogs:

DROP TRIGGER IF EXISTS catalogs_log;
DELIMITER //

CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs
FOR EACH ROW
	BEGIN
		INSERT INTO logs (name, table_name)
		VALUES (NEW.name, "catalogs");
	END//
	
# Триггер для products:

DROP TRIGGER IF EXISTS products_log;
DELIMITER //

CREATE TRIGGER products_log AFTER INSERT ON products
FOR EACH ROW
	BEGIN
		INSERT INTO logs (name, table_name)
		VALUES (NEW.name, "products");
	END//	

# Триггер для users:

DROP TRIGGER IF EXISTS users_log;
DELIMITER //

CREATE TRIGGER users_log AFTER INSERT ON users
FOR EACH ROW
	BEGIN
		INSERT INTO logs (name, table_name)
		VALUES (NEW.name, "users");
	END//	
	

DELIMITER ;

# Протестируем работу триггеров:

# Проверим лог до добавления данных в соответствующие таблицы:
SELECT * FROM logs;

# Пусто

INSERT INTO catalogs VALUES
  (NULL, 'Подставки для кофе'),
  (NULL, 'Ванны'),
  (NULL, 'Ананасы'),
  (NULL, 'Поливитамины'),
  (NULL, 'Тетради в клеточку');
 
 INSERT INTO users (name, birthday_at) VALUES
  ('Кондратий', '1990-10-06'),
  ('Парфирий', '1990-10-07'),
  ('Лилия', '1990-10-08'),
  ('Говинда', '1990-10-09'),
  ('Серафим', '1990-10-10'),
  ('Клавдия', '1992-08-11');
 SELECT id FROM catalogs WHERE name = "Поливитамины";
 INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Мультитаб', 'Поливитамины.', 760, 9);
 
 # Проверим лог после добавления данных:
SELECT * FROM logs;

ID	name	table_name	created_at
1	Подставки для кофе	catalogs	2021-11-17 08:07:50
2	Ванны	catalogs	2021-11-17 08:07:50
3	Ананасы	catalogs	2021-11-17 08:07:50
4	Поливитамины	catalogs	2021-11-17 08:07:50
5	Тетради в клеточку	catalogs	2021-11-17 08:07:50
6	Кондратий	users	2021-11-17 08:07:50
7	Парфирий	users	2021-11-17 08:07:50
8	Лилия	users	2021-11-17 08:07:50
9	Говинда	users	2021-11-17 08:07:50
10	Серафим	users	2021-11-17 08:07:50
11	Клавдия	users	2021-11-17 08:07:50
12	Мультитаб	products	2021-11-17 08:09:34
