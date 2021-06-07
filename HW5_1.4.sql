«Операторы, фильтрация, сортировка и ограничение»

4.
SELECT * FROM users
	WHERE date_of_birth LIKE '%may%'
	OR date_of_birth LIKE '%august%'
;
