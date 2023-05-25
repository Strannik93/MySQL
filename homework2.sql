/*
Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
*/
use seminar2;
create table sales (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    order_date VARCHAR(10) NOT NULL,
    bucket VARCHAR(30) NOT NULL
);
INSERT sales (order_date, bucket) VALUES
("2021-01-01", "101 to 300"),
("2021-01-02", "101 to 300"),
("2021-01-03", "less then equal to 100"),
("2021-01-04", "101 to 300"),
("2021-01-05", "greater than 300");
DROP TABLE sales;

/*
Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
*/
alter table sales add column order_volume VARCHAR(30);
update sales set order_volume=
	CASE WHEN sales.bucket = "less then equal to 100" THEN "Маленький заказ"
    WHEN sales.bucket = "101 to 300" THEN "Средний заказ"
    WHEN sales.bucket = "greater than 300" THEN "Большой заказ"
    ELSE "Неверный диапозон"
	END
    WHERE sales.id > 0;

/*
Создайте таблицу “orders”, заполните ее значениями.
Покажите “полный” статус заказа, используя оператор CASE
*/
use seminar2;
create table orders (
	orderid INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    employeeid VARCHAR(10) NOT NULL,
    amount FLOAT NOT NULL,
    orderstatus VARCHAR(10) NOT NULL
);
INSERT orders (employeeid, amount, orderstatus) VALUES
("e03", 15, "OPEN"),
("e01", 25.5, "OPEN"),
("e05", 100.7, "CLOSED"),
("e02", 22.18, "OPEN"),
("e04", 9.5, "CANCELLED"),
("e04", 99.99, "OPEN");
SELECT * FROM orders;
CREATE TABLE statuses AS
SELECT orderid, orderstatus FROM orders;
alter table statuses add PRIMARY KEY (orderid);
alter table statuses add column order_summary VARCHAR(40);
update statuses set order_summary=
	CASE WHEN statuses.orderstatus = "OPEN" THEN "Order is in open state."
    WHEN statuses.orderstatus = "CLOSED" THEN "Order is closed."
    WHEN statuses.orderstatus = "CANCELLED" THEN "Order is cancelled."
	END
    WHERE statuses.orderid > 0;
SELECT * FROM statuses;
DROP TABLE orders;
DROP TABLE statuses;