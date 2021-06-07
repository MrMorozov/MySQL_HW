«Операторы, фильтрация, сортировка и ограничение»

5.
--Если ID int or bigint:
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
