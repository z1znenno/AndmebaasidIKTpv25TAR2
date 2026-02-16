-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 16, 2026 kell 03:46 PL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `veebipood`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaBrands` (IN `ID` INT)   BEGIN
    SELECT * FROM brands;
    DELETE FROM brands WHERE brand_id = ID;
    SELECT * FROM brands;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaCustomer` (IN `id` INT)   BEGIN
SELECT * FROM customers;
delete FROM customers where customer_id = id;
SELECT * FROM customers;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaBrand` (IN `brand_nimi` VARCHAR(30))   begin
insert into brands(brand_name)
values (brand_nimi);
select * from brands;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `otsing1tahte` (IN `taht` VARCHAR(2))   begin
declare today Timestamp DEFAULT CURRENT_TIME;
select brand_name, today from Brands
where brand_name like CONCAT(taht + "%");
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `suurendaStocks` (IN `a` INT)   BEGIN
SELECT * FROM stocks;
UPDATE stocks SET quanity = quanity * 1.10;
SELECT * from stocks;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uletatudOrders` (IN `current_date` DATE)   BEGIN
select * FROM orders where shipped_date < current_date;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uuendaBrands` (IN `id` INT, IN `uus_brand` VARCHAR(30))   begin
select * from brands;
update brands set brand_name=uus_brand where brand_id = id;
select * from brands;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `brands`
--

CREATE TABLE `brands` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `brands`
--

INSERT INTO `brands` (`brand_id`, `brand_name`) VALUES
(2, 'Apple'),
(1, 'Dell'),
(4, 'HP'),
(5, 'Playstation'),
(3, 'Samsung'),
(7, 'Westrom');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Arvutid'),
(5, 'Konsoolid'),
(4, 'Kõrvaklapid'),
(2, 'Telefonid'),
(3, 'Telerit');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(10) DEFAULT NULL,
  `last_name` varchar(15) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `street` varchar(20) DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL,
  `zip_code` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `phone`, `email`, `street`, `city`, `zip_code`) VALUES
(1, 'Oleg', 'Berez', '+37258354312', 'olegb@gmail.com', 'Linnamae tee 13', 'Tallinn', '13998'),
(2, 'Artemii', 'Moroz', '+37258353132', 'artemiim@gmail.com', 'Narva mnt. 89', 'Tallinn', '13945'),
(3, 'Samuil', 'Yakov', '+37258654312', 'samuily@gmail.com', 'Oismae tee 23', 'Tallinn', '13976'),
(5, 'Dmitri', 'Yeszhe', '+37258589302', 'dmitriy@gmail.com', 'Haabersti 6', 'Tallinn', '13980');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_status` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `required_date` date DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  `store_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `order_status`, `order_date`, `required_date`, `shipped_date`, `store_id`, `staff_id`) VALUES
(1, 1, 1, '2025-02-01', '2025-02-05', '2025-02-03', 1, 3),
(2, 2, 2, '2025-02-02', '2025-02-06', NULL, 1, 3),
(3, 3, 1, '2025-02-03', '2025-02-07', '2025-02-05', 2, 4);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `products`
--

CREATE TABLE `products` (
  `products_id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `model_year` int(11) DEFAULT NULL,
  `list_price` decimal(7,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `products`
--

INSERT INTO `products` (`products_id`, `product_name`, `brand_id`, `category_id`, `model_year`, `list_price`) VALUES
(1, 'Apple TV', 2, 3, 2021, 1299.99),
(2, 'Notebook', 1, 1, 2018, 499.99),
(3, 'Phone Z flip 4', 3, 2, 2021, 2000.00),
(4, 'HP Kõrvaklapid', 4, 4, 2006, 109.00),
(5, 'Playstation 4', 5, 5, 2018, 399.99);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `staffs`
--

CREATE TABLE `staffs` (
  `staff_id` int(11) NOT NULL,
  `first_name` varchar(10) DEFAULT NULL,
  `last_name` varchar(10) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `staffs`
--

INSERT INTO `staffs` (`staff_id`, `first_name`, `last_name`, `email`, `phone`, `active`, `store_id`, `manager_id`) VALUES
(1, 'Slava', 'Maksimov', 'slavam@gmail.com', '+37252319381', b'1', 1, NULL),
(2, 'Arseni', 'Moroz', 'arsenim@gmail.com', '+37252329381', b'0', 5, NULL),
(3, 'Vlada', 'Baka', 'vladab@gmail.com', '+37253439381', b'1', 3, NULL),
(4, 'Artem', 'Sartin', 'artems@gmail.com', '+37252319865', b'1', 2, NULL),
(5, 'Sasha', 'Martin', 'sasham@gmail.com', '+37252321381', b'0', 4, NULL);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `stocks`
--

CREATE TABLE `stocks` (
  `store_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quanity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `stocks`
--

INSERT INTO `stocks` (`store_id`, `product_id`, `quanity`) VALUES
(1, 1, 1100),
(2, 3, 1573),
(3, 5, 2181),
(4, 4, 1320),
(5, 2, 2211);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `stores`
--

CREATE TABLE `stores` (
  `store_id` int(11) NOT NULL,
  `store_name` varchar(30) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(20) NOT NULL,
  `street` varchar(30) NOT NULL,
  `city` varchar(20) DEFAULT NULL,
  `zip_code` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `stores`
--

INSERT INTO `stores` (`store_id`, `store_name`, `phone`, `email`, `street`, `city`, `zip_code`) VALUES
(1, 'Euroniks', '+37255865245', 'euroniks@gmail.com', 'Linnamae 12', 'Tallinn', '13943'),
(2, 'Click', '+37255863245', 'click@gmail.com', 'Narva mnt. 19', 'Tallinn', '13916'),
(3, 'Upgrade', '+37255655095', 'upgrade@gmail.com', 'Mustamae 16', 'Tallinn', '13987'),
(4, 'ArvutiTark', '+37255874675', 'arvutiTark@gmail.com', 'K.Karberi 24', 'Tallinn', '13952'),
(5, 'Rimi', '+37257600245', 'rimi@gmail.com', 'Oismae tee 87', 'Tallinn', '13990');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brand_id`),
  ADD UNIQUE KEY `brand_name` (`brand_name`);

--
-- Indeksid tabelile `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indeksid tabelile `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indeksid tabelile `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_orders_customer` (`customer_id`),
  ADD KEY `fk_orders_store` (`store_id`),
  ADD KEY `fk_orders_staff` (`staff_id`);

--
-- Indeksid tabelile `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`products_id`),
  ADD KEY `brand_id` (`brand_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indeksid tabelile `staffs`
--
ALTER TABLE `staffs`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `last_name` (`last_name`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `store_id` (`store_id`);

--
-- Indeksid tabelile `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`store_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indeksid tabelile `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`store_id`),
  ADD UNIQUE KEY `store_name` (`store_name`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT tabelile `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `products`
--
ALTER TABLE `products`
  MODIFY `products_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `staffs`
--
ALTER TABLE `staffs`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `stores`
--
ALTER TABLE `stores`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_orders_staff` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`staff_id`),
  ADD CONSTRAINT `fk_orders_store` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`);

--
-- Piirangud tabelile `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`brand_id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Piirangud tabelile `staffs`
--
ALTER TABLE `staffs`
  ADD CONSTRAINT `staffs_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`);

--
-- Piirangud tabelile `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `stocks_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`),
  ADD CONSTRAINT `stocks_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`products_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
