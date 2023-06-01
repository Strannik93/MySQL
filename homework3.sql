/*
Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: city, sname, snum, comm.
(к первой или второй таблице, используя SELECT)
*/
use seminar3;
create table salespeople (
	snum INT PRIMARY KEY NOT NULL,
    sname VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    comm VARCHAR(5) NOT NULL
);
INSERT salespeople (snum, sname, city, comm) VALUES
(1001, "Peel", "London", ".12"),
(1002, "Serres", "San Jose", ".13"),
(1004, "Motika", "London", ".11"),
(1007, "Rifkin", "Barcelona", ".15"),
(1003, "Alexrod", "New York", ".10");

SELECT city, sname, snum, comm FROM salespeople;

DROP TABLE salespeople;

/*
Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем каждого заказчика в городе San Jose. (“заказчики”)
*/
create table customers (
	cnum INT PRIMARY KEY NOT NULL,
    cname VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    rating INT NOT NULL,
    snum INT NOT NULL
);
INSERT customers (cnum, cname, city, rating, snum) VALUES
(2001, "Hoffman", "London", 100, 1001),
(2002, "Giovanni", "Rome", 200, 1003),
(2003, "Liu", "San Jose", 200, 1002),
(2004, "Grass", "Berlin", 300, 1002),
(2005, "Clemens", "London", 100, 1001),
(2006, "Cisneros", "San Jose", 300, 1007),
(2007, "Pereira", "Rome", 100, 1004);

SELECT rating, cname FROM customers WHERE city = "San Jose";

DROP TABLE customers;

/*
Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов без каких бы то ни было повторений. (уникальные значения в “snum“ “Продавцы”)
*/
create table orders (
	onum INT PRIMARY KEY NOT NULL,
    amt FLOAT NOT NULL,
    odate VARCHAR(10) NOT NULL,
    cnum INT NOT NULL,
    snum INT NOT NULL
);
INSERT orders (onum, amt, odate, cnum, snum) VALUES
(3001, 18.69, "10/03/1990", 2008, 1007),
(3003, 767.19, "10/03/1990", 2001, 1001),
(3002, 1900.10, "10/03/1990", 2007, 1004),
(3005, 5160.45, "10/03/1990", 2003, 1002),
(3006, 1098.16, "10/03/1990", 2008, 1007),
(3009, 1713.23, "10/04/1990", 2002, 1003),
(3007, 75.75, "10/04/1990", 2004, 1002),
(3008, 4723.00, "10/05/1990", 2006, 1001),
(3010, 1309.95, "10/06/1990", 2004, 1002),
(3011, 9891.88, "10/06/1990", 2006, 1001);

SELECT DISTINCT snum FROM orders;

DROP TABLE orders;

/*
Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G. Используется оператор "LIKE": (“заказчики”) https://dev.mysql.com/doc/refman/8.0/en/string-comparison-functions.html
*/
SELECT * FROM customers WHERE cname  LIKE "G%";

/*
Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000. (“Заказы”, “amt” - сумма)
*/
SELECT * FROM orders WHERE amt > 1000;

/*
Напишите запрос который выбрал бы наименьшую сумму заказа.
(Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)
*/
SELECT min(amt) minamt FROM orders;

/*
Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков, у которых рейтинг больше 100 и они находятся не в Риме.
*/
SELECT * FROM customers WHERE rating > 100 AND NOT city = "Rome";

/*
Отсортируйте поле “зарплата” в порядке убывания и возрастания
*/
create table employees (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    ename VARCHAR(20) NOT NULL,
    surname VARCHAR(20) NOT NULL,
    specialty VARCHAR(15) NOT NULL,
    seniority INT NOT NULL,
    salary INT NOT NULL,
    age INT NOT NULL
);
INSERT employees (ename, surname, specialty, seniority, salary, age) VALUES
("Вася", "Васькин", "начальник", 40, 100000, 60),
("Петя", "Петькин", "начальник", 8, 70000, 30),
("Катя", "Каткина", "инженер", 2, 70000, 25),
("Саша", "Сашкин", "инженер", 12, 50000, 35),
("Иван", "Иванов", "рабочий", 40, 30000, 59),
("Петр", "Петров", "рабочий", 20, 25000, 40),
("Сидор", "Сидоров", "рабочий", 10, 20000, 35),
("Антон", "Антонов", "рабочий", 8, 19000, 28),
("Юра", "Юркин", "рабочий", 5, 15000, 25),
("Максим", "Воронин", "рабочий", 2, 11000, 22),
("Юра", "Галкин", "рабочий", 3, 12000, 24),
("Люся", "Люскина", "уборщик", 10, 10000, 49);

-- по убыванию
SELECT * FROM employees
ORDER BY salary DESC;
-- по возрастанию
SELECT * FROM employees
ORDER BY salary;

DROP TABLE employees;

/*
Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой (возможен подзапрос)
*/
SELECT * FROM
(SELECT * FROM employees
ORDER BY salary DESC
LIMIT 5) s
ORDER BY salary;

/*
Выполните группировку всех сотрудников по специальности , суммарная зарплата которых превышает 100000
*/
SELECT specialty, sum(salary) sumsalary FROM employees GROUP BY specialty HAVING sumsalary > 100000;