2.

Запрос для выбора пользователей младше 18-ти лет:
SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, profiles.birthday, CURDATE()) <18;

Запрос для выбора идентификаторов постов соответствующих пользователям младше 18-ти лет:
SELECT id FROM posts WHERE user_id IN (SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, profiles.birthday, CURDATE()) <18)


Теперь добавим функцию аггрегации выбрав из таблицы лайков все лайки соответствующие идентификаторам постов пользователей младше 18-ти лет
SELECT COUNT(*)
FROM posts_likes
WHERE post_id IN (SELECT id FROM posts WHERE user_id IN (SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, profiles.birthday, CURDATE()) <18));


