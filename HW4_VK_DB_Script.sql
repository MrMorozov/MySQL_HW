

CREATE TABLE users(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY, 
	firstname VARCHAR(50) NOT NULL,
	lastname VARCHAR(50) NOT NULL COMMENT 'ФАМИЛИЯ',
	email VARCHAR(120) UNIQUE NOT NULL,
	phone CHAR(11) NOT NULL,
	password_hash CHAR(65),
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOW()
	INDEX users_email_idx (email),
	INDEX users_phone_idx (phone)
);


CREATE TABLE profiles (
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	gender ENUM('f', 'm', 'x'), -- CHAR(1)
	birthday DATE NOT NULL,
	photo_id INT UNSIGNED,
	city VARCHAR(130),
	country VARCHAR(130),
	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE media_types (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name varchar(45) NOT NULL UNIQUE -- изображение, музыка, документ
);


CREATE TABLE media(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_types_id INT UNSIGNED NOT NULL,
	file_name VARCHAR(245)	COMMENT '/files/folder/img.png',
	file_size BIGINT UNSIGNED,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX media_users_idx (user_id),
	INDEX media_media_types_idx (media_types_id),
	CONSTRAINT fk_media_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_media_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE communities (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	name VARCHAR(145) NOT NULL,
  	description VARCHAR(245) DEFAULT NULL,
  	INDEX communities_name_idx (name)
);


CREATE TABLE communities_users (
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(community_id, user_id),
	INDEX communities_users_comm_idx (community_id),
	INDEX communities_users_users_idx (user_id),
	FOREIGN KEY (community_id) REFERENCES communities (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE friend_requests (
	
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	accepted BOOLEAN DEFAULT False,
	PRIMARY KEY(from_user_id, to_user_id),
	CHECK (from_user_id != to_user_id),
	INDEX fk_friend_requests_from_user_idx (from_user_id),
  	INDEX fk_friend_requests_to_user_idx (to_user_id),
  	CONSTRAINT fk_friend_requests_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
  	CONSTRAINT fk_friend_requests_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE messages (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
  	to_user_id BIGINT UNSIGNED NOT NULL,
  	txt TEXT NOT NULL, -- txt = ПРИВЕТ,
  	is_delivered BOOLEAN DEFAULT False,
  	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
  	INDEX fk_messages_from_user_idx (from_user_id),
  	INDEX fk_messages_to_user_idx (to_user_id),
  	CONSTRAINT fk_messages_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
  	CONSTRAINT fk_messages_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE posts(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	text VARCHAR(5000) NOT NULL,
	date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX posts_user_idx (user_id) ,
	INDEX posts_date_created_idx (date_created) ,
	CONSTRAINT fk_posts_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE media_likes(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	liked_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	liked_media_id BIGINT UNSIGNED,
	INDEX media_likes_user_idx (user_id) ,
	INDEX media_likes_media_id_idx (liked_media_id) ,
	INDEX media_liked_at_idx (liked_at) ,
	CONSTRAINT fk_media_likes_media FOREIGN KEY (liked_media_id) REFERENCES media (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_media_likes_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE user_likes(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	liked_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	liked_user_id BIGINT UNSIGNED,
	INDEX user_likes_user_idx (user_id) ,
	INDEX user_likes_media_id_idx (liked_user_id) ,
	INDEX user_liked_at_idx (liked_at) ,
	CONSTRAINT fk_user_liked_users FOREIGN KEY (liked_user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_user_likes_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE post_likes(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	liked_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	liked_post_id BIGINT UNSIGNED,
	INDEX post_likes_user_idx (user_id) ,
	INDEX post_likes_media_id_idx (liked_post_id) ,
	INDEX post_liked_at_idx (liked_at) ,
	CONSTRAINT fk_post_liked_users FOREIGN KEY (liked_post_id) REFERENCES posts (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_post_likes_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);
