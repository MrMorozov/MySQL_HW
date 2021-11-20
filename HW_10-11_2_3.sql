# Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

# Установил mongodb без визуальной оболочки
# Создал базу данных shop:

> use shop
switched to db shop
> 



# Создадим коллекции товаров и каталога, для этого воспользуемся функцией формата даных mysql запроса в json:

SELECT JSON_ARRAYAGG(JSON_OBJECT('_id', id, 'name', name, 'description', description, 
'price', price,'catalog_id', catalog_id,'created_at', created_at)) from products;	# (запрос в dbeaver)

# Вывод:

[{"_id": 1, "name": "Intel Core i3-8100", "price": 7890.00, "catalog_id": 1, "created_at": "2021-11-19 14:42:07.000000", "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel."}, {"_id": 2, "name": "Intel Core i5-7400", "price": 12700.00, "catalog_id": 1, "created_at": "2021-11-19 14:42:07.000000", "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel."}, {"_id": 3, "name": "AMD FX-8320E", "price": 4780.00, "catalog_id": 1, "created_at": "2021-11-19 14:42:07.000000", "description": "Процессор для настольных персональных компьютеров, основанных на платформе AMD."}, {"_id": 4, "name": "AMD FX-8320", "price": 7120.00, "catalog_id": 1, "created_at": "2021-11-19 14:42:07.000000", "description": "Процессор для настольных персональных компьютеров, основанных на платформе AMD."}, {"_id": 5, "name": "ASUS ROG MAXIMUS X HERO", "price": 19310.00, "catalog_id": 2, "created_at": "2021-11-19 14:42:07.000000", "description": "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX"}, {"_id": 6, "name": "Gigabyte H310M S2H", "price": 4790.00, "catalog_id": 2, "created_at": "2021-11-19 14:42:07.000000", "description": "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX"}, {"_id": 7, "name": "MSI B250M GAMING PRO", "price": 5060.00, "catalog_id": 2, "created_at": "2021-11-19 14:42:07.000000", "description": "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX"}]

# Осталось добавить его в запрос создания коллекции для products:


> db.products.insertMany([{"_id": 1, "name": "Intel Core i3-8100", "price": 7890.00, "catalog_id": 1, "created_at": "2021-11-19 14:42:07.000000", "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel."}, {"_id": 2, "name": "Intel Core i5-7400", "price": 12700.00, "catalog_id": 1, "created_at": "2021-11-19 14:42:07.000000", "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel."}, {"_id": 3, "name": "AMD FX-8320E", "price": 4780.00, "catalog_id": 1, "created_at": "2021-11-19 14:42:07.000000", "description": "Процессор для настольных персональных компьютеров, основанных на платформе AMD."}, {"_id": 4, "name": "AMD FX-8320", "price": 7120.00, "catalog_id": 1, "created_at": "2021-11-19 14:42:07.000000", "description": "Процессор для настольных персональных компьютеров, основанных на платформе AMD."}, {"_id": 5, "name": "ASUS ROG MAXIMUS X HERO", "price": 19310.00, "catalog_id": 2, "created_at": "2021-11-19 14:42:07.000000", "description": "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX"}, {"_id": 6, "name": "Gigabyte H310M S2H", "price": 4790.00, "catalog_id": 2, "created_at": "2021-11-19 14:42:07.000000", "description": "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX"}, {"_id": 7, "name": "MSI B250M GAMING PRO", "price": 5060.00, "catalog_id": 2, "created_at": "2021-11-19 14:42:07.000000", "description": "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX"}])
{
	"acknowledged" : true,
	"insertedIds" : [
		1,
		2,
		3,
		4,
		5,
		6,
		7
	]
}
> 

> show collections
products

# Появилась коллекция продуктс, данные записаны
# Те же операции делаем для catalogs:

SELECT JSON_ARRAYAGG(JSON_OBJECT('_id', id, 'name', name)) from products; # (запрос в dbeaver)


# Вывод:
[{"_id": 1, "name": "Intel Core i3-8100"}, {"_id": 2, "name": "Intel Core i5-7400"}, {"_id": 3, "name": "AMD FX-8320E"}, {"_id": 4, "name": "AMD FX-8320"}, {"_id": 5, "name": "ASUS ROG MAXIMUS X HERO"}, {"_id": 6, "name": "Gigabyte H310M S2H"}, {"_id": 7, "name": "MSI B250M GAMING PRO"}]


# Создаем коллекцию catalogs:

> db.catalogs.insertMany([{"_id": 1, "name": "Intel Core i3-8100"}, {"_id": 2, "name": "Intel Core i5-7400"}, {"_id": 3, "name": "AMD FX-8320E"}, {"_id": 4, "name": "AMD FX-8320"}, {"_id": 5, "name": "ASUS ROG MAXIMUS X HERO"}, {"_id": 6, "name": "Gigabyte H310M S2H"}, {"_id": 7, "name": "MSI B250M GAMING PRO"}])
{
	"acknowledged" : true,
	"insertedIds" : [
		1,
		2,
		3,
		4,
		5,
		6,
		7
	]
}


# Проверяем:

> show collections
catalogs
products
> 

# Можно было сделать еще практичней: экспортировать всю базу данных или ее часть из MySQL клиента 
# в файл json формата, а потом загрузить в mongo db, но я не стал заморачиваться.
 





