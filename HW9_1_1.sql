

В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
Мои базы данных называются иначе, после проверки я поменял названия на те, что упомянуты в задании.

START TRANSACTION;
# Определим и запишем в переменную значение максимального ID пользователя в целевой таблице:
SELECT @mx := MAX(id) FROM sample.users;
# Увеличим значение на 1:
SELECT @mx := @mx+1;
# Запишем в заданную таблицу 
INSERT INTO sample.users
SELECT @mx, name, birthday_at , created_at, updated_at FROM shop.users WHERE users.id = 1;
COMMIT;

