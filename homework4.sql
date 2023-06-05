/*
Вывести на экран сколько машин каждого цвета для машин марок BMW и LADA
*/
USE seminar4;
CREATE TABLE  AUTO 
(       
	REGNUM VARCHAR(10) PRIMARY KEY, 
	MARK VARCHAR(10), 
	COLOR VARCHAR(15),
	RELEASEDT DATE, 
	PHONENUM VARCHAR(15)
);
INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM ) VALUES
(111114,'LADA', 'КРАСНЫЙ', '2008-01-01', '9152222221'),
(111115,'VOLVO', 'КРАСНЫЙ', '2013-01-01', '9173333334'),
(111116,'BMW', 'СИНИЙ', '2015-01-01', '9173333334'),
(111121,'AUDI', 'СИНИЙ', '2009-01-01', '9173333332'),
(111122,'AUDI', 'СИНИЙ', '2011-01-01', '9213333336'),
(111113,'BMW', 'ЗЕЛЕНЫЙ', '2007-01-01', '9214444444'),
(111126,'LADA', 'ЗЕЛЕНЫЙ', '2005-01-01', null),
(111117,'BMW', 'СИНИЙ', '2005-01-01', null),
(111119,'LADA', 'СИНИЙ', '2017-01-01', '9213333331');

SELECT COLOR, MARK, count(*) AS COUNT FROM AUTO WHERE MARK = 'BMW' OR MARK = 'LADA' GROUP BY COLOR, MARK;

DROP TABLE AUTO;

/*
Вывести на экран марку авто и количество AUTO не этой марки
*/
SELECT MARK, temp.s - count(MARK) COUNT FROM (SELECT MARK, count(MARK) OVER() s FROM AUTO) temp GROUP BY MARK;

/*
Даны 2 таблицы.
Напишите запрос, который вернет строки из таблицы test_a, id которых нет в таблице test_b, НЕ используя ключевого слова NOT.
*/
CREATE TABLE test_a (id INT, data VARCHAR(1));
CREATE TABLE test_b (id INT);
INSERT INTO test_a(id, data) VALUES
(10, 'A'), (20, 'A'), (30, 'F'), (40, 'D'), (50, 'C');
INSERT INTO test_b(id) VALUES
(10), (30), (50);

SELECT test_a.* FROM test_a
LEFT JOIN test_b on test_b.id = test_a.id
WHERE test_b.id is null;

DROP TABLE test_a;
DROP TABLE test_b;