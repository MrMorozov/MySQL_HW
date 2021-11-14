В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное 
значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба 
поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

# Конечный рабочий результат для вставки:

DROP TRIGGER IF EXISTS check_prod_desc_name_insert;
DELIMITER //

CREATE TRIGGER check_prod_desc_name_insert BEFORE INSERT ON products
FOR EACH ROW
	BEGIN
		IF NEW.name IS NULL and NEW.description IS NULL THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Хотябы одно из полей name, description должно быть заполнено!";
		END IF;
	END//
DELIMITER ;

# Конечный рабочий результат для изменения:

DROP TRIGGER IF EXISTS check_prod_desc_name_update;
DELIMITER //

CREATE TRIGGER check_prod_desc_name_update BEFORE UPDATE ON products
FOR EACH ROW
	BEGIN
		IF NEW.name IS NULL and NEW.description IS NULL THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Хотябы одно из полей name, description должно быть заполнено!";
		END IF;
	END//
DELIMITER ;



# Попытка использовать IF "NOT NEW.name and NOT NEW.description THEN" не сработала.
# Еще была сложность с правами: почему-то пользователю со всеми привелегиями не давалась позможность создать триггер, изменение параметов и перезапуск сервера не давал результата,
# В итоге дошло до полной переустановки mysql, восстановления базы из дампа и работы из под рута. Видимо несколько месяцев назад я криво поставил и настроил, помню, было что-то такое.

