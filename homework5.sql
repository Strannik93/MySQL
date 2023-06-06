/*
Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов.
Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW).
Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”.
*/
USE seminar5;
CREATE TABLE Cars
(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    namecar VARCHAR(25) NOT NULL,
    cost INT NOT NULL
);
INSERT INTO Cars (namecar, cost) VALUES
('Audi', 52642), ('Mercedes', 57127), ('Skoda', 9000),
('Volvo', 29000), ('Bentley', 350000), ('Citroen', 21000),
('Hummer', 41400), ('Volkswagen', 21600);

CREATE VIEW CheapCars AS SELECT namecar FROM Cars WHERE Cost<25000;
ALTER VIEW CheapCars AS SELECT namecar FROM Cars WHERE Cost<30000;
CREATE VIEW CheapCars AS SELECT * FROM Cars WHERE namecar IN ( 'Skoda','Audi' );

DROP VIEW CheapCars;
DROP TABLE Cars;

/*
Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.
Есть таблица анализов Analysis: an_id — ID анализа; an_name — название анализа; an_cost — себестоимость анализа;
an_price — розничная цена анализа; an_group — группа анализов.
Есть таблица групп анализов Groups: gr_id — ID группы; gr_name — название группы;
gr_temp — температурный режим хранения. Есть таблица заказов Orders: ord_id — ID заказа;
ord_datetime — дата и время заказа; ord_an — ID анализа.
*/
-- с выводом розничной цены анализа 1 раз (при повторении анализа в интервале)
SELECT DISTINCT an_name, an_price FROM Analysis a
RIGHT JOIN (SELECT an_datetime, ord_an FROM Orders) AS t ON a.an_id = t.ord_an
WHERE an_datetime >= '2020-02-05' and an_datetime <= '2020-02-12';

-- с выводом розничной цены анализа в виде суммы всех повторении анализа
SELECT an_name, sum(an_price) AS sum_price FROM
(SELECT an_name, an_price FROM Analysis a
RIGHT JOIN (SELECT an_datetime, ord_an FROM Orders) AS t ON a.an_id = t.ord_an
WHERE an_datetime >= '2020-02-05' and an_datetime <= '2020-02-12') AS t1
GROUP BY an_name;

/*
Добавьте новый столбец под названием «время до следующей станции».
Чтобы получить это значение, мы вычитаем время станций для пар смежных станций.
Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно.
Проще это сделать с помощью оконной функции LEAD .
Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат.
В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
*/
CREATE TABLE stations
(
    train_id INT NOT NULL,
    station VARCHAR(20) NOT NULL,
    station_time TIME NOT NULL
);
INSERT INTO stations (train_id, station, station_time) VALUES
	(110, 'San Francisco', '10:00:00'),
    (110, 'Redwood City', '10:54:00'),
    (110, 'Palo Alto', '10:00:00'),
    (110, 'San Jose', '12:35:00'),
    (120, 'San Francisco', '11:00:00'),
    (120, 'Palo Alto', '12:49:00'),
    (120, 'San Jose', '13:30:00');

SELECT train_id, station, station_time, 
TIMEDIFF(LEAD(station_time) OVER(partition by train_id), station_time) AS time_to_next_station FROM stations;

DROP TABLE stations;