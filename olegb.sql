-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Märts 26, 2026 kell 08:56 EL
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
-- Andmebaas: `olegb`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `firma`
--

CREATE TABLE `firma` (
  `firmaID` int(11) NOT NULL,
  `firmanimi` varchar(20) DEFAULT NULL,
  `aadress` varchar(20) DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `firma`
--

INSERT INTO `firma` (`firmaID`, `firmanimi`, `aadress`, `telefon`) VALUES
(1, 'LeEco', '409 SOUTH ELLIS', '712 521 8655'),
(2, 'Allview', 'BOX 847', '190 300 8391'),
(3, 'BenQ-Siemens', 'Sand 2', '658 992 6548'),
(4, 'Sony', '7 PROMENADE GERMAINE', '203 956 7128'),
(5, 'verykool', 'Konsul-Uebele-Straße', '905 338 0902');

-- --------------------------------------------------------

--
-- Sise-vaate struktuur `kessyndinudsygisel`
-- (Tegelik vaade on allpool)
--
CREATE TABLE `kessyndinudsygisel` (
`praktikajuhendajaID` int(11)
,`eesnimi` varchar(20)
,`synniaeg` date
,`telefon` varchar(13)
,`palk` int(11)
);

-- --------------------------------------------------------

--
-- Sise-vaate struktuur `mitufirmabaasis`
-- (Tegelik vaade on allpool)
--
CREATE TABLE `mitufirmabaasis` (
`firmanimi` varchar(20)
,`kogus` bigint(21)
);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `praktikabaas`
--

CREATE TABLE `praktikabaas` (
  `praktikabaasID` int(11) NOT NULL,
  `firmaID` int(11) DEFAULT NULL,
  `praktikatingimused` varchar(20) DEFAULT NULL,
  `arvutiprogramm` varchar(20) DEFAULT NULL,
  `juhendajaID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `praktikabaas`
--

INSERT INTO `praktikabaas` (`praktikabaasID`, `firmaID`, `praktikatingimused`, `arvutiprogramm`, `juhendajaID`) VALUES
(1, 1, 'kontoritöö', 'Excel', 1),
(2, 2, 'kaugpraktika', 'Python', 2),
(3, 3, 'hübriid', 'SQL', 3),
(4, 1, 'täiskoormus', 'Java', 1),
(5, 4, 'osalise ajaga', 'Photoshop', 4);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `praktikajuhendaja`
--

CREATE TABLE `praktikajuhendaja` (
  `praktikajuhendajaID` int(11) NOT NULL,
  `eesnimi` varchar(20) DEFAULT NULL,
  `synniaeg` date DEFAULT NULL,
  `telefon` varchar(13) DEFAULT NULL,
  `palk` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `praktikajuhendaja`
--

INSERT INTO `praktikajuhendaja` (`praktikajuhendajaID`, `eesnimi`, `synniaeg`, `telefon`, `palk`) VALUES
(1, 'Tynan', '2025-08-19', '132 751 1321', 1922),
(2, 'Ivan', '2025-03-27', '883 802 2734', 1618),
(3, 'Malachi', '2025-04-24', '163 663 2225', 1680),
(4, 'Richy', '2025-07-14', '400 855 6957', 1574),
(5, 'Christoforo', '2025-04-23', '810 374 8481', 1898);

-- --------------------------------------------------------

--
-- Vaate struktuur `kessyndinudsygisel`
--
DROP TABLE IF EXISTS `kessyndinudsygisel`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `kessyndinudsygisel`  AS SELECT `praktikajuhendaja`.`praktikajuhendajaID` AS `praktikajuhendajaID`, `praktikajuhendaja`.`eesnimi` AS `eesnimi`, `praktikajuhendaja`.`synniaeg` AS `synniaeg`, `praktikajuhendaja`.`telefon` AS `telefon`, `praktikajuhendaja`.`palk` AS `palk` FROM `praktikajuhendaja` WHERE month(`praktikajuhendaja`.`synniaeg`) in (9,10,11) ;

-- --------------------------------------------------------

--
-- Vaate struktuur `mitufirmabaasis`
--
DROP TABLE IF EXISTS `mitufirmabaasis`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mitufirmabaasis`  AS SELECT `firma`.`firmanimi` AS `firmanimi`, count(`praktikabaas`.`praktikabaasID`) AS `kogus` FROM (`praktikabaas` join `firma`) WHERE `firma`.`firmaID` = `praktikabaas`.`firmaID` GROUP BY `firma`.`firmanimi` ;

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `firma`
--
ALTER TABLE `firma`
  ADD PRIMARY KEY (`firmaID`);

--
-- Indeksid tabelile `praktikabaas`
--
ALTER TABLE `praktikabaas`
  ADD PRIMARY KEY (`praktikabaasID`),
  ADD KEY `firmaID` (`firmaID`),
  ADD KEY `juhendajaID` (`juhendajaID`);

--
-- Indeksid tabelile `praktikajuhendaja`
--
ALTER TABLE `praktikajuhendaja`
  ADD PRIMARY KEY (`praktikajuhendajaID`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `firma`
--
ALTER TABLE `firma`
  MODIFY `firmaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `praktikabaas`
--
ALTER TABLE `praktikabaas`
  MODIFY `praktikabaasID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `praktikajuhendaja`
--
ALTER TABLE `praktikajuhendaja`
  MODIFY `praktikajuhendajaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `praktikabaas`
--
ALTER TABLE `praktikabaas`
  ADD CONSTRAINT `praktikabaas_ibfk_1` FOREIGN KEY (`firmaID`) REFERENCES `firma` (`firmaID`),
  ADD CONSTRAINT `praktikabaas_ibfk_2` FOREIGN KEY (`juhendajaID`) REFERENCES `praktikajuhendaja` (`praktikajuhendajaID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
