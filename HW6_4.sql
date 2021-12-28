
# 4. (по желанию) Найти пользователя, который проявляет наименьшую активность в использовании социальной сети (тот, кто написал меньше всего сообщений, 
отправил меньше всего заявок в друзья, ...).

# Определим критерии:количество лайков, постов, сообщений, запросов в друзья исходящих от пользователя, количество групп и медиа файлов
# Нет возможности выделить веса для каждого из параметров, поэтому оцениваемой величиной будет сумма всех этих параметров
# Однако стоит учесть, что пользователи находятся на ресурсе разное количество времени, поэтому, на мой взгляд, стоит нормировать вычисленную сумму по времени пребывания на ресурсе.




# Запрос для аггрегации количества ПОСТОВ по пользователям:
SELECT user_id, COUNT(*) as cnt FROM posts GROUP BY user_id;

# Запрос для аггрегации количества ЛАЙКОВ по пользователям:
SELECT user_id, COUNT(*) as cnt FROM posts_likes GROUP BY user_id;

# Запрос для аггрегации количества СООБЩЕНИЙ по пользователям:
SELECT from_user_id as user_id, COUNT(*) as cnt FROM messages GROUP BY user_id;

# Запрос для аггрегации количества ЗАПРОСОВ В ДРУЗЬЯ от пользователей:
SELECT from_user_id as user_id, COUNT(*) as cnt FROM friend_requests GROUP BY user_id;

# Запрос для аггрегации количества ГРУПП по пользователям:
SELECT user_id, COUNT(*) as cnt FROM communities_users GROUP BY user_id;

# Запрос для аггрегации количества МЕДИА ФАЙЛОВ по пользователям:
SELECT user_id, COUNT(*) as cnt FROM media GROUP BY user_id;



# Объединим все эти запросы как сумму

SELECT user_id, sum(cnt) as summ
FROM 
(
(SELECT user_id, COUNT(*) as cnt FROM posts GROUP BY user_id)
UNION ALL 
(SELECT user_id, COUNT(*) as cnt FROM posts_likes GROUP BY user_id)
UNION ALL
(SELECT from_user_id as user_id, COUNT(*) as cnt FROM messages GROUP BY user_id)
UNION ALL
(SELECT from_user_id as user_id, COUNT(*) as cnt FROM friend_requests GROUP BY user_id)
UNION ALL
(SELECT user_id, COUNT(*) as cnt FROM communities_users GROUP BY user_id)
UNION ALL
(SELECT user_id, COUNT(*) as cnt FROM media GROUP BY user_id)
) AS summ
GROUP BY user_id;

# Если отсортировать этот запрос, то будет виден пользователь, проявляющий максимальную активность без нормирования по времени с момента регистрации

# Запрос для вывода ид пользователей и временем прошедшего с момента их регистрации в днях:

SELECT id as user_id, TIMESTAMPDIFF(DAY, users.created_at , CURDATE()) AS td FROM users;

# Объединим запросы так чтобы вычислить нормированную активность, как частное суммарной активности пользователя и количества дней со дня регистрации 
# Т. е. количественно выразим среднюю активность пользователя в день
SELECT
  one.user_id,
  summ/td AS norm_sum
FROM
(SELECT user_id, sum(cnt) as summ
FROM 
(
(SELECT user_id, COUNT(*) as cnt FROM posts GROUP BY user_id)
UNION ALL 
(SELECT user_id, COUNT(*) as cnt FROM posts_likes GROUP BY user_id)
UNION ALL
(SELECT from_user_id as user_id, COUNT(*) as cnt FROM messages GROUP BY user_id)
UNION ALL
(SELECT from_user_id as user_id, COUNT(*) as cnt FROM friend_requests GROUP BY user_id)
UNION ALL
(SELECT user_id, COUNT(*) as cnt FROM communities_users GROUP BY user_id)
UNION ALL
(SELECT user_id, COUNT(*) as cnt FROM media GROUP BY user_id)
) AS summ
GROUP BY user_id) as one
,
(SELECT id as user_id, TIMESTAMPDIFF(DAY, users.created_at , CURDATE()) AS td FROM users) as two
WHERE one.user_id = two.user_id
;

# Далее можно вычислить максимальное значение "norm_sum" и выбрать ID пользователя соответствующего ему.
# Но поскольку я уже делал это в первом задании, я отсортирую по убыванию вывод последнего запроса по "norm_sum" и оставлю
# Только первый результат. Потенциально этот способ будет быстрей. А вероятность что у двух пользователей может быть одинаковая
# нормированная сумма очень мала.

SELECT
  one.user_id,
  summ/td AS norm_sum,
  summ
FROM
(SELECT user_id, sum(cnt) as summ
FROM 
(
(SELECT user_id, COUNT(*) as cnt FROM posts GROUP BY user_id)
UNION ALL 
(SELECT user_id, COUNT(*) as cnt FROM posts_likes GROUP BY user_id)
UNION ALL
(SELECT from_user_id as user_id, COUNT(*) as cnt FROM messages GROUP BY user_id)
UNION ALL
(SELECT from_user_id as user_id, COUNT(*) as cnt FROM friend_requests GROUP BY user_id)
UNION ALL
(SELECT user_id, COUNT(*) as cnt FROM communities_users GROUP BY user_id)
UNION ALL
(SELECT user_id, COUNT(*) as cnt FROM media GROUP BY user_id)
) AS summ
GROUP BY user_id) as one
,
(SELECT id as user_id, TIMESTAMPDIFF(DAY, users.created_at , CURDATE()) AS td FROM users) as two
WHERE one.user_id = two.user_id
ORDER BY norm_sum DESC
LIMIT 1
;

# В данном случае результат одинаковый, как по нормированной так и по обычной суммам - максимальная активность соответствует пользователю 1, если конечно я не допустил ошибок.
# Но при сортировке всех пользоветелей видна разница:

# Сортировка по нормированной активности:
1	0.0086	31
11	0.0042	24
6	0.0029	25
3	0.0028	28
8	0.0026	17
5	0.0025	26
2	0.0023	27
9	0.0018	15
4	0.0013	16
10	0.0013	22
7	0.0008	12

# Сортировка по асолютной активности:
1	0.0086	31
3	0.0028	28
2	0.0023	27
5	0.0025	26
6	0.0029	25
11	0.0042	24
10	0.0013	22
8	0.0026	17
4	0.0013	16
9	0.0018	15
7	0.0008	12



