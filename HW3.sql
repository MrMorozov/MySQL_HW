1.

Структура и связи понятны. Можно добавить места работы, учебы, события и много всего, но поскольку принцип понятен и так не вижу в этом необходимости. Основные связи итак присутствуют. А вот индексы как я понимаю было бы неплохо добавить для имени, фамилии в таблице "users" поскольку запросы такого рода происходят часто.
Я бы добавил во все условия с CONSTRAIN запись "ON DELETE CASCADE", поскольку иначе не получится удалить пользователя не удалив все остальное поочереди. Как я понимаю это не очень удобно.


2.
#Я не сообразил как реализовать лайки одной таблицей не теряя надежности БД, поэтому отдельно сделал лайки для каждого вида.
-- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE

CREATE TABLE posts(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	text VARCHAR(5000) NOT NULL,
	date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX posts_user_idx (user_id) ,
	INDEX posts_date_created_idx (date_created) ,
	CONSTRAINT fk_posts_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
	);

INSERT INTO posts VALUES (DEFAULT, 2, 'Hi Petro!', DEFAULT); -- Пост Васи

CREATE TABLE media_likes(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	liked_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	liked_media_id BIGINT UNSIGNED,
	INDEX media_likes_user_idx (user_id) ,
	INDEX media_likes_media_id_idx (liked_media_id) ,
	INDEX media_liked_at_idx (liked_at) ,
	CONSTRAINT fk_media_likes_media FOREIGN KEY (liked_media_id) REFERENCES media (id) ON DELETE CASCADE,
	CONSTRAINT fk_media_likes_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE user_likes(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	liked_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	liked_user_id BIGINT UNSIGNED,
	INDEX user_likes_user_idx (user_id) ,
	INDEX user_likes_media_id_idx (liked_user_id) ,
	INDEX user_liked_at_idx (liked_at) ,
	CONSTRAINT fk_user_liked_users FOREIGN KEY (liked_user_id) REFERENCES users (id) ON DELETE CASCADE,
	CONSTRAINT fk_user_likes_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE post_likes(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	liked_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	liked_post_id BIGINT UNSIGNED,
	INDEX post_likes_user_idx (user_id) ,
	INDEX post_likes_media_id_idx (liked_post_id) ,
	INDEX post_liked_at_idx (liked_at) ,
	CONSTRAINT fk_post_liked_users FOREIGN KEY (liked_post_id) REFERENCES posts (id) ON DELETE CASCADE,
	CONSTRAINT fk_post_likes_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

INSERT INTO post_likes VALUES (DEFAULT, 1, DEFAULT, 1); -- Лайк Пети поста Васи
INSERT INTO media_likes VALUES (DEFAULT, 2, DEFAULT, 1); -- Лайк Васи медиа номер 1
INSERT INTO user_likes VALUES (DEFAULT, 2, DEFAULT, 1); -- Лайк Пети от Васи
