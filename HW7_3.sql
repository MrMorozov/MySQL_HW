
#3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите # список рейсов flights с русскими названиями городов.


# Создадим таблицы:

DROP TABLE IF EXISTS flyghts;
CREATE TABLE flyghts (
  id SERIAL PRIMARY KEY,
  from_ VARCHAR(255) COMMENT 'Departure',
  to_ VARCHAR(255) COMMENT 'Destination') COMMENT = 'Вылеты';

INSERT INTO flyghts (from_, to_) VALUES
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  lable VARCHAR(255) PRIMARY KEY COMMENT 'lable',
  name VARCHAR(255) COMMENT 'Russian name') COMMENT = 'cities';

INSERT INTO cities (lable, name) VALUES
("moscow","Москва"),
("irkutsk","Иркутск"),
("novgorod","Новгород"),
("kazan","Казань"),
("omsk","Омск");

# Просмотрим таблицы:
SELECT * FROM flyghts;
SELECT * FROM cities;


# Подставим русские значения в "from"
SELECT f.id, c.name AS from_
FROM flyghts AS f JOIN cities AS c
ON c.lable = f.from_;
# Подставим русские значения в "to"
SELECT f.id, c.name AS to_
FROM flyghts AS f JOIN cities AS c
ON c.lable = f.to_;

# Объединим запросы по ID:
SELECT fl.id, fl.from_, fl2.to_
FROM
(
	SELECT f.id, c.name AS from_
	FROM flyghts AS f JOIN cities AS c
	ON c.lable = f.from_
) as fl,
(
	SELECT f.id, c.name AS to_
	FROM flyghts AS f JOIN cities AS c
	ON c.lable = f.to_
) as fl2
WHERE fl.id = fl2.id;


