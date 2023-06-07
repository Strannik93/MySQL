/*
Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/
DROP FUNCTION IF EXISTS time_сonvector;
DELIMITER //
CREATE FUNCTION time_сonvector(time_seconds int)
returns varchar(100)
deterministic
BEGIN
	declare temp varchar(100) default '';
    declare i int default 0;
    set i = FLOOR(time_seconds/31536000);
    IF i >= 1 THEN set temp = concat(temp, i, ' years, ');
    set time_seconds = time_seconds - 31536000*i; END IF;
    set i = FLOOR(time_seconds/2592000);
    IF i >= 1 THEN set temp = concat(temp, i, ' months, ');
    set time_seconds = time_seconds - 2592000*i; END IF;
    set i = FLOOR(time_seconds/86400);
    IF i >= 1 THEN set temp = concat(temp, i, ' days, ');
    set time_seconds = time_seconds - 86400*i; END IF;
    set i = FLOOR(time_seconds/3600);
    IF i >= 1 THEN set temp = concat(temp, i, ' hours, ');
    set time_seconds = time_seconds - 3600*i; END IF;
    set i = FLOOR(time_seconds/60);
    IF i >= 1 THEN set temp = concat(temp, i, ' minutes, ');
    set time_seconds = time_seconds - 60*i; END IF;
	set temp = concat(temp, time_seconds, ' seconds');
    return temp;
END//
DELIMITER ;

SELECT time_сonvector(123456);

/*
Выведите только четные числа от 1 до 10. Пример: 2,4,6,8,10
*/
DROP PROCEDURE IF EXISTS evenNumbers;
DELIMITER //
CREATE PROCEDURE evenNumbers(in max_number int)
BEGIN
	declare i int default 2;
    declare temp varchar(100) default '';
    while i <= max_number do
		set temp = concat(temp, ' ', i);
        set i = i + 2;
	END while;
    SELECT temp AS Numbers;
END//
DELIMITER ;

call evenNumbers(10);