«Операторы, фильтрация, сортировка и ограничение»

3.
(SELECT * FROM storehouses_products WHERE value > 0 ORDER BY id)
UNION ALL 
(SELECT * from storehouses_products WHERE value = 0);

storehouses_products
