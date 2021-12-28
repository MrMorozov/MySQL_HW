HW_8_1_2

Создайте представление, которое выводит название name товарной позиции из таблицы products и 
соответствующее название каталога name из таблицы catalogs.

# Объединенный запрос:
SELECT p.name, c.name
FROM products AS p JOIN catalogs AS c
ON p.catalog_id = c.id;

# Представление:

CREATE VIEW prod_cat_names AS SELECT p.name AS p_name, c.name AS cat_name
FROM products AS p JOIN catalogs AS c
ON p.catalog_id = c.id;

# Проверяем:
SELECT * FROM prod_cat_names;
