
# 3. Определить, кто больше поставил лайков (всего) - мужчины или женщины?

# Запрос для вычисления количества лайков соответствующих женщинам:
SELECT COUNT(post_id) as f_count FROM posts_likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender='f');
# Запрос для вычисления количества лайков соответствующих мужчинам:
SELECT COUNT(post_id) as f_count FROM posts_likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender='m');
# Запрос для выбора пола оставившего больше лайков:
SELECT IF((SELECT COUNT(post_id) as f_count FROM posts_likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender='f'))>
(SELECT COUNT(post_id) as m_count FROM posts_likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender='m')),"Females","Males") as more_likes_from;
