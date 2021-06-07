1.

ALTER TABLE friend_requests 
ADD CONSTRAINT sender_not_reciever_check
CHECK (from_user_id != to_user_id);

- Вызывает ошибку:
Column '%s' cannot be used in a check constraint '%is': needed in a foreign key constraint '%s' referential action
Поскольку как я понял из документации MYSQL нельзя использовать огранечения на колоки проверяемые по внешнему ключи.
Это можно реализовать через триггер.


ALTER TABLE profiles 
ADD CONSTRAINT fk_profiles_media 
FOREIGN KEY (photo_id) REFERENCES media (id);

 - Так же вызывает ошибку, необходимо было сперва поменять свойства photo_id:
  
 ALTER TABLE vk.profiles MODIFY COLUMN photo_id BIGINT UNSIGNED NULL;

2. Большую часть данных сгенерировал в FILLNB сервисе кроме запросов в друзья, после загрузки "дампа" таблица соответственно пропала.
Создал заново и импортнул .csv из MORCABO.

3.
3.1	Пробовал так, но почему то не обновило.
	INSERT INTO media_types (id, name)
	VALUES 
	(1, 'image'),
	(2, 'audio'),
	(3, 'video'),
	(4, 'document')
	ON DUPLICATE KEY UPDATE
	id=VALUES(id), name=VALUES(name);
Разбирусь попозже.
3.2	DELETE FROM friend_requests  WHERE from_user_id=to_user_id;

mysql> SELECT * FROM friend_requests  WHERE from_user_id=to_user_id;

	+--------------+------------+----------+
	| from_user_id | to_user_id | accepted |
	+--------------+------------+----------+
	|           83 |         83 |        0 |
	+--------------+------------+----------+

mysql> DELETE FROM friend_requests  WHERE from_user_id=to_user_id;
	Query OK, 1 row affected (0,00 sec)
	
4. 
Я буду делать базу данных продуктов питания, трав и специй с позиции аюрведы.


