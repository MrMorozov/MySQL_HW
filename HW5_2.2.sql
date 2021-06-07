2.2
--  У меня в базе дата рождения находится в "profiles":
SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))), '%W') AS day,
	COUNT(*) AS total
FROM
	profiles
GROUP BY
	day
ORDER BY
	FIELD(day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
