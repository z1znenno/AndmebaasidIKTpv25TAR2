-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 26, 2026 kell 09:53 EL
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
-- Andmebaas: `iktpv25_1b`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `alterTable` (IN `valik` VARCHAR(20), IN `tabeliNimi` VARCHAR(25), IN `veeruNimi` VARCHAR(25), IN `tyyp` VARCHAR(20))   begin
	set @sql = case
	when valik LIKE 'add' then
	concat('ALTER TABLE ', tabeliNimi, ' ADD ', veeruNimi, ' ', tyyp)
	when valik LIKE 'drop' then
	concat('ALTER TABLE ', tabeliNimi, ' DROP COLUMN ', veeruNimi)
	when valik LIKE 'alter' then
	concat('ALTER TABLE ', tabeliNimi, ' MODIFY ', veeruNimi, ' ', tyyp)
	END;
PREPARE paring FROM @sql;
EXECUTE paring;
DEALLOCATE PREPARE paring;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `category`
--

CREATE TABLE `category` (
  `idCategory` int(11) NOT NULL,
  `CategoryName` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `category`
--

INSERT INTO `category` (`idCategory`, `CategoryName`) VALUES
(1, 'Autod'),
(2, 'Arvutid'),
(3, 'Riided'),
(4, 'Töit');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kasutaja`
--

CREATE TABLE `kasutaja` (
  `kasutaja_id` int(11) NOT NULL,
  `kasutaja_nimi` varchar(25) NOT NULL,
  `parool` char(10) NOT NULL,
  `koht` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `kasutaja`
--

INSERT INTO `kasutaja` (`kasutaja_id`, `kasutaja_nimi`, `parool`, `koht`) VALUES
(1, 'Oleg', 'testik', NULL);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `product`
--

CREATE TABLE `product` (
  `idProduct` int(11) NOT NULL,
  `ProductName` varchar(70) DEFAULT NULL,
  `idCategory` int(11) DEFAULT NULL,
  `Price` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `product`
--

INSERT INTO `product` (`idProduct`, `ProductName`, `idCategory`, `Price`) VALUES
(1, 'Mazda', 1, 345.99),
(2, 'Macbook', 2, 999.99),
(3, 'Nike AirForce', 3, 59.67),
(4, 'Vene Juust', 4, 3.99);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `sale`
--

CREATE TABLE `sale` (
  `idSale` int(11) NOT NULL,
  `idProduct` int(11) DEFAULT NULL,
  `idCustomer` int(11) DEFAULT NULL,
  `Count_pr` int(11) DEFAULT NULL,
  `Date_of_sale` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `sale`
--

INSERT INTO `sale` (`idSale`, `idProduct`, `idCustomer`, `Count_pr`, `Date_of_sale`) VALUES
(1, 1, 4, 100, '2010-02-09'),
(2, 2, 3, 300, '2001-06-28'),
(3, 3, 1, 200, '2013-05-10');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`idCategory`);

--
-- Indeksid tabelile `kasutaja`
--
ALTER TABLE `kasutaja`
  ADD PRIMARY KEY (`kasutaja_id`);

--
-- Indeksid tabelile `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`idProduct`),
  ADD KEY `fk_Category` (`idCategory`);

--
-- Indeksid tabelile `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`idSale`),
  ADD KEY `idProduct` (`idProduct`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `category`
--
ALTER TABLE `category`
  MODIFY `idCategory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `kasutaja`
--
ALTER TABLE `kasutaja`
  MODIFY `kasutaja_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT tabelile `product`
--
ALTER TABLE `product`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `sale`
--
ALTER TABLE `sale`
  MODIFY `idSale` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_Category` FOREIGN KEY (`idCategory`) REFERENCES `category` (`idCategory`);

--
-- Piirangud tabelile `sale`
--
ALTER TABLE `sale`
  ADD CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`idProduct`) REFERENCES `product` (`idProduct`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
