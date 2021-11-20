При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, 
поиск электронного адреса пользователя по его имени.


# Зададим пользователя с e-mail:
SET 'Silvia Stove' 's.stove@gardens@gmail.com'
SET 's.stove@gardens@gmail.com' 'Silvia Stove'
# Запрос имени пользователя по значению e-mail:
GET 's.stove@gardens@gmail.com'
# Запрос почты пользователя по имени:
GET 'Silvia Stove'

# Листинг из терминала redis-

127.0.0.1:6379> SET 'Silvia Stove' 's.stove@gardens@gmail.com'
OK
127.0.0.1:6379> SET 's.stove@gardens@gmail.com' 'Silvia Stove'
OK
127.0.0.1:6379> GET 's.stove@gardens@gmail.com'
"Silvia Stove"
127.0.0.1:6379> GET 'Silvia Stove'
"s.stove@gardens@gmail.com"
127.0.0.1:6379> 

