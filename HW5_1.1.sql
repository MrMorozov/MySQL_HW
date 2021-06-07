«Операторы, фильтрация, сортировка и ограничение»

1.
	-- У меня не было колонки с датой обновления, поэтому я ее создал:
	ALTER TABLE users ADD COLUMN updated_at DATETIME NOT NULL DEFAULT NOW();
	-- Обновляем обе колонки метками времени:
	UPDATE users SET created_at = NOW();
	UPDATE users SET updated_at = NOW();
