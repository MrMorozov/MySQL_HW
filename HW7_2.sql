2. Выведите список товаров products и разделов catalogs, который соответствует товару.

# Запрос для необходимых данных из products:
SELECT catalog_id, name FROM products;

# Запрос для необходимых данных из каталогов:
SELECT * FROM catalogs;


# Совместить эти таблицы можно по products.catalog_id и catalogs.id.
# Поскольку нужно отобразить вид продукта по каталогу для каждого
# агрегация данных не понадобится, достаточно только добавить условие сравнения:

SELECT p.name, c.name
FROM products AS p JOIN catalogs AS c
ON p.catalog_id = c.id;
