1.

	Для проверки выберем пользователя 1
	
	# Выберем количество сообщений пришедших заданному пользователю от пользователей, присылавших ему сообщения
	SELECT from_user_id,COUNT(from_user_id) as cnt FROM messages WHERE to_user_id=1 GROUP BY from_user_id;
	# Найдем максимальное число сообщений пришедшее заданному пользователю от одного из пользователей;
	SELECT MAX(cnt) FROM (SELECT from_user_id, COUNT(from_user_id) as cnt FROM messages WHERE to_user_id=1 GROUP BY from_user_id) as MAX_Count;
	
	Совместим запросы, выбрав ид пользователя отправившего максимальное кол-во сообщений из первой выборки
	SELECT from_user_id
	FROM (SELECT from_user_id,COUNT(*) as cnt 
		FROM messages 
		WHERE to_user_id=1 
		GROUP BY from_user_id) as gr1
	WHERE cnt = (select MAX(cnt) 
		FROM (SELECT from_user_id, COUNT(*) as cnt 
		FROM messages 
		WHERE to_user_id=1 
		GROUP BY from_user_id) as MAX_Count);


