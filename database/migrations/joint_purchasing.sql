﻿--
-- Скрипт сгенерирован Devart dbForge Studio for MySQL, Версия 6.3.341.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 06.03.2015 0:01:11
-- Версия сервера: 5.5.41-0ubuntu0.14.04.1
-- Версия клиента: 4.1
--


--
-- Описание для базы данных joint_purchasing
--
DROP DATABASE IF EXISTS joint_purchasing;
CREATE DATABASE joint_purchasing
	CHARACTER SET utf8
	COLLATE utf8_general_ci;

-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установить режим SQL (SQL mode)
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8';

-- 
-- Установка базы данных по умолчанию
--
USE joint_purchasing;

--
-- Описание для таблицы attribute_values
--
CREATE TABLE attribute_values (
  id INT(11) NOT NULL AUTO_INCREMENT,
  product_id INT(11) NOT NULL,
  attribute_id INT(11) NOT NULL,
  value VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  UNIQUE INDEX UK_attribute_values (product_id, attribute_id)
)
ENGINE = INNODB
AUTO_INCREMENT = 6
AVG_ROW_LENGTH = 1024
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы attributes
--
CREATE TABLE attributes (
  id INT(11) NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  name VARCHAR(50) NOT NULL,
  attribute_group_id INT(11) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id),
  UNIQUE INDEX name (name)
)
ENGINE = INNODB
AUTO_INCREMENT = 6
AVG_ROW_LENGTH = 4096
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы attributes_groups
--
CREATE TABLE attributes_groups (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  user_id INT(11) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы categories
--
CREATE TABLE categories (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  parent_id INT(11) NOT NULL,
  project_id INT(11) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 6
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы category_product
--
CREATE TABLE category_product (
  category_id INT(11) DEFAULT NULL,
  product_id INT(11) DEFAULT NULL
)
ENGINE = INNODB
AVG_ROW_LENGTH = 2340
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы media
--
CREATE TABLE media (
  id INT(11) NOT NULL AUTO_INCREMENT,
  product_id INT(11) NOT NULL,
  type VARCHAR(10) NOT NULL DEFAULT 'image',
  file_name VARCHAR(255) NOT NULL DEFAULT '',
  `position` INT(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы migrations
--
CREATE TABLE migrations (
  migration VARCHAR(255) NOT NULL,
  batch INT(11) NOT NULL
)
ENGINE = INNODB
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_unicode_ci;

--
-- Описание для таблицы password_resets
--
CREATE TABLE password_resets (
  email VARCHAR(255) NOT NULL,
  token VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  INDEX password_resets_email_index (email),
  INDEX password_resets_token_index (token)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_unicode_ci;

--
-- Описание для таблицы prices
--
CREATE TABLE prices (
  product_id INT(11) NOT NULL,
  column_id INT(11) NOT NULL,
  price DECIMAL(19, 2) NOT NULL DEFAULT 0.00,
  UNIQUE INDEX product_id_column_id (product_id, column_id)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 2340
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы pricing_grids
--
CREATE TABLE pricing_grids (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(500) NOT NULL DEFAULT '',
  user_id INT(11) NOT NULL,
  project_id INT(11) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Ценовые сетки';

--
-- Описание для таблицы pricing_grids_columns
--
CREATE TABLE pricing_grids_columns (
  id INT(11) NOT NULL AUTO_INCREMENT,
  pricing_grid_id INT(11) NOT NULL,
  column_number INT(11) NOT NULL,
  column_title VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 18
AVG_ROW_LENGTH = 2340
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Колонки ценовых сеток';

--
-- Описание для таблицы product_purchase
--
CREATE TABLE product_purchase (
  purchase_id INT(11) NOT NULL,
  product_id INT(11) NOT NULL
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Промежуточная таблица "Закупки - продукты"';

--
-- Описание для таблицы products
--
CREATE TABLE products (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(5000) NOT NULL DEFAULT '',
  user_id INT(11) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 2730
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Продукты';

--
-- Описание для таблицы projects
--
CREATE TABLE projects (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  user_id INT(11) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы projects_pricing_grids
--
CREATE TABLE projects_pricing_grids (
  project_id INT(11) NOT NULL,
  pricing_grid_id INT(11) NOT NULL
)
ENGINE = INNODB
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы purchases
--
CREATE TABLE purchases (
  id INT(11) NOT NULL AUTO_INCREMENT,
  user_id INT(11) NOT NULL,
  pricing_grid_id INT(11) NOT NULL,
  pricing_grid_column INT(11) NOT NULL DEFAULT 1,
  expiration_time TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  description VARCHAR(255) NOT NULL DEFAULT '',
  created_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 5
AVG_ROW_LENGTH = 4096
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Закупки';

--
-- Описание для таблицы users
--
CREATE TABLE users (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(60) NOT NULL,
  remember_token VARCHAR(100) DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id),
  UNIQUE INDEX users_email_unique (email)
)
ENGINE = INNODB
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_unicode_ci;

--
-- Описание для таблицы widgets
--
CREATE TABLE widgets (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  handler VARCHAR(255) DEFAULT NULL,
  layouts VARCHAR(20) DEFAULT NULL,
  region VARCHAR(50) DEFAULT NULL,
  `position` INT(11) NOT NULL DEFAULT 0,
  status TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Виджеты';

-- 
-- Вывод данных для таблицы attribute_values
--
INSERT INTO attribute_values VALUES
(1, 2, 1, '100 мл'),
(2, 2, 2, 'Германия'),
(3, 2, 3, 'Weleda'),
(4, 2, 4, '9511'),
(5, 2, 5, 'http://www.citynature.ru/catalog/product/view/258/22882');

-- 
-- Вывод данных для таблицы attributes
--
INSERT INTO attributes VALUES
(1, 'Вес', 'weight', 1, '2015-03-03 09:55:29', '2015-03-03 09:55:29'),
(2, 'Страна производителя', 'country', 1, '2015-03-03 10:24:50', '2015-03-03 10:24:50'),
(3, 'Бренд', 'brand', 1, '2015-03-03 10:25:24', '2015-03-03 10:25:24'),
(4, 'Артикул', 'article', 1, '2015-03-03 10:34:45', '2015-03-03 10:34:45'),
(5, 'Ссылка на товар', 'cn_link', 1, '2015-03-05 18:31:52', '2015-03-05 18:31:52');

-- 
-- Вывод данных для таблицы attributes_groups
--
INSERT INTO attributes_groups VALUES
(1, 'Атрибуты товаров citynature.ru', 1, '2015-03-03 09:12:06', '2015-03-03 09:12:06');

-- 
-- Вывод данных для таблицы categories
--
INSERT INTO categories VALUES
(1, 'Косметика', 0, 1, '2015-03-03 03:29:35', '2015-03-03 03:29:35'),
(2, 'Для волос', 1, 1, '2015-03-03 04:26:28', '2015-03-03 04:26:28'),
(3, 'Для лица', 1, 1, '2015-03-03 04:27:30', '2015-03-03 04:27:30'),
(4, 'Мама и малыш', 0, 1, '2015-03-05 18:10:46', '2015-03-05 18:10:46'),
(5, 'Для мамы', 4, 1, '2015-03-05 18:11:06', '2015-03-05 18:11:06');

-- 
-- Вывод данных для таблицы category_product
--
INSERT INTO category_product VALUES
(5, 2),
(5, 2),
(5, 2),
(5, 2),
(5, 2),
(5, 2),
(5, 2),
(5, 2),
(5, 2),
(5, 2),
(5, 2);

-- 
-- Вывод данных для таблицы media
--
INSERT INTO media VALUES
(1, 2, 'image', '164bec15453aa6896bdab66bce2f9845.jpg', 1),
(2, 2, 'image', 'c0ead06d49b69b8282ab2f5cc7b72a42.jpg', 1);

-- 
-- Вывод данных для таблицы migrations
--
INSERT INTO migrations VALUES
('2014_10_12_000000_create_users_table', 1),
('2014_10_12_100000_create_password_resets_table', 1);

-- 
-- Вывод данных для таблицы password_resets
--

-- Таблица joint_purchasing.password_resets не содержит данных

-- 
-- Вывод данных для таблицы prices
--
INSERT INTO prices VALUES
(2, 11, 1005.09),
(2, 12, 968.76),
(2, 13, 958.23),
(2, 14, 947.70),
(2, 15, 937.17),
(2, 16, 926.64),
(2, 17, 916.11);

-- 
-- Вывод данных для таблицы pricing_grids
--
INSERT INTO pricing_grids VALUES
(1, 'Основная колонка', '', 1, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'weight', '', 0, 0, '2015-03-03 09:54:15', '2015-03-03 09:54:15');

-- 
-- Вывод данных для таблицы pricing_grids_columns
--
INSERT INTO pricing_grids_columns VALUES
(11, 1, 1, 'до 15 т.р.'),
(12, 1, 2, '15 т.р - 30 т.р'),
(13, 1, 3, '30 т.р - 50 т.р'),
(14, 1, 4, '50 т.р - 70 т.р'),
(15, 1, 5, '70 т.р - 100 т.р'),
(16, 1, 6, '100 т.р - 300 т.р'),
(17, 1, 7, 'от 300 т.р.');

-- 
-- Вывод данных для таблицы product_purchase
--

-- Таблица joint_purchasing.product_purchase не содержит данных

-- 
-- Вывод данных для таблицы products
--
INSERT INTO products VALUES
(2, 'Масло для профилактики растяжек', 'Растяжки - это поражение кожи, которое появляется в период повышенной гормональной активности (во время беременности, в период полового созревания, резкого увеличения или снижения веса, эндокринных заболеваний).\nГормональные изменения в организме приводят к нарушению синтеза двух важнейших составляющих кожи — белков-полимеров коллагена и эластина.\nПри заживлении растяжек на коже образуются фиброзные тяжи, которые не содержат пигмента и при загаре не изменяет свой цвет, так что на пляже растяжки становятся особенно заметными, создавая косметическую проблему.\nМасло от растяжек Weleda - натуральный, высококачественный продукт по уходу за кожей тела во время беременности. Предохраняет кожу от сухости и при регулярном применении препятствует появлению растяжек на животе, бедрах, ягодицах и груди.', 1, '2015-03-05 18:09:43', '2015-03-05 18:09:43');

-- 
-- Вывод данных для таблицы projects
--
INSERT INTO projects VALUES
(1, 'Проект citynature.ru', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- 
-- Вывод данных для таблицы projects_pricing_grids
--
INSERT INTO projects_pricing_grids VALUES
(1, 1);

-- 
-- Вывод данных для таблицы purchases
--
INSERT INTO purchases VALUES
(1, 1, 1, 1, '2015-03-05 04:29:39', 'первая закупка', '2015-02-26 04:30:03', '2015-02-26 04:30:03'),
(2, 1, 2, 1, '2015-03-05 04:30:03', 'новая закупка', '2015-02-26 04:33:41', '2015-02-26 04:33:41'),
(3, 1, 2, 1, '2015-03-05 04:33:58', 'уфа', '2015-02-26 04:34:02', '2015-02-26 04:34:02'),
(4, 1, 1, 1, '2015-03-05 04:34:03', 'вамви', '2015-02-26 04:34:22', '2015-02-26 04:34:22');

-- 
-- Вывод данных для таблицы users
--
INSERT INTO users VALUES
(1, 'Виталий Серов', 'serovvitaly@gmail.com', '$2y$10$B9utwkSzweDFIzTsSJa3oOq5slqDE85Ow1KK8n2tzoTb69PFbKQ9W', 'bexQ97ucY6jVk64elmhCtWIzVlFbxvtWg0gng3Nf3vGFMRGfDCIPIvsV3NOR', '2015-02-24 13:20:58', '2015-02-25 10:35:35');

-- 
-- Вывод данных для таблицы widgets
--
INSERT INTO widgets VALUES
(1, 'Каталог товаров', 'Основной блок каталога товаров на главной', '\\App\\Widgets\\BaseCatalog', NULL, 'center_1', 2, 1, '2015-02-24 16:50:50', '2015-02-24 16:50:50'),
(2, 'Навигационное меню "Seller"', 'Верхнее навигационное меню для раздела "Продавцы"', '\\App\\Widgets\\SellerBaseNav', 'seller', 'top', 0, 1, '2015-02-25 11:45:15', '2015-02-25 11:45:15'),
(3, 'Навигационное меню "Admin"', 'Верхнее навигационное меню Админки', '\\App\\Widgets\\AdminBaseNav', 'admin', 'top', 0, 1, '2015-02-25 20:21:00', '2015-02-25 20:21:00');

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;