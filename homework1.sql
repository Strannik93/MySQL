/*
Создайте таблицу с мобильными телефонами, используя графический интерфейс.
Id, ProductName, Manufacturer, ProductCount, Price
Заполните БД данными.
*/
CREATE TABLE `seminar1`.`phones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ProductName` VARCHAR(20) NOT NULL,
  `Manufacturer` VARCHAR(20) NOT NULL,
  `ProductCount` INT NOT NULL DEFAULT 0,
  `Price` INT NOT NULL,
  PRIMARY KEY (`id`));

INSERT INTO `seminar1`.`phones` (`id`, `ProductName`, `Manufacturer`, `ProductCount`, `Price`) VALUES ('1', 'iPhone X', 'Apple', '3', '76000');
INSERT INTO `seminar1`.`phones` (`ProductName`, `Manufacturer`, `ProductCount`, `Price`) VALUES ('iPhone 8', 'Apple', '2', '51000');
INSERT INTO `seminar1`.`phones` (`ProductName`, `Manufacturer`, `ProductCount`, `Price`) VALUES ('Galaxy S9', 'Samsung', '2', '56000');
INSERT INTO `seminar1`.`phones` (`ProductName`, `Manufacturer`, `ProductCount`, `Price`) VALUES ('Galaxy S8', 'Samsung', '1', '41000');
INSERT INTO `seminar1`.`phones` (`ProductName`, `Manufacturer`, `ProductCount`, `Price`) VALUES ('P20 Pro', 'Huawei', '5', '36000');

/*
Выведите название, производителя и цену для товаров, количество которых превышает 2
*/
SELECT ProductName, Manufacturer, Price FROM seminar1.phones WHERE ProductCount > 2;

/*
Выведите весь ассортимент товаров марки “Samsung”
*/
SELECT * FROM seminar1.phones WHERE Manufacturer = "Samsung";

/*
*** С помощью регулярных выражений найти:
Товары, в наименовании которых есть упоминание "Iphone"
Товары, в наименовании которых есть упоминание "Samsung"
Товары, в наименовании которых есть ЦИФРЫ
Товары, в наименовании которых есть ЦИФРА "8"
*/
SELECT * FROM seminar1.phones WHERE ProductName LIKE "%Iphone%";
SELECT * FROM seminar1.phones WHERE ProductName LIKE "%Samsung%";
SELECT * FROM seminar1.phones WHERE ProductName RLIKE "[0-9]";
SELECT * FROM seminar1.phones WHERE ProductName LIKE "%8%";