«Операторы, фильтрация, сортировка и ограничение»

2.
	-- Для начала переведем колонки данных в VARCHAR:
ALTER TABLE users MODIFY COLUMN updated_at VARCHAR(25);
ALTER TABLE users MODIFY COLUMN created_at VARCHAR(25);
	-- Добавим значения в указанном формате "20.10.2017 8:10":
UPDATE users SET created_at = DATE_FORMAT(NOW(), '%d.%m.%Y %H:%i');
UPDATE users SET updated_at = DATE_FORMAT(NOW(), '%d.%m.%Y %H:%i');
	-- Теперь Переведем в DateTime в несколько шагов
	-- Добавим вспомогательные колонки:
ALTER TABLE users ADD COLUMN created_at_dt DATETIME NOT NULL DEFAULT NOW();
ALTER TABLE users ADD COLUMN updated_at_dt DATETIME NOT NULL DEFAULT NOW();
	-- Перепишем данные исходных колонок в новые в нужном формате: 
UPDATE users
SET created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
	updated_at_dt = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
	-- Удалим исходные колонки и переименуем новые:
ALTER TABLE users 
    DROP created_at, DROP updated_at, 
    RENAME COLUMN created_at_dt TO created_at, RENAME COLUMN updated_at_dt TO updated_at;
