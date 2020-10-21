-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              10.4.10-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win64
-- HeidiSQL Versione:            10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dump della struttura del database vorp
CREATE DATABASE IF NOT EXISTS `vorp` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `vorp`;

-- Dump della struttura di tabella vorp.dogs
CREATE TABLE IF NOT EXISTS `dogs` (
  `identifier` varchar(40) NOT NULL,
  `dog` varchar(255) NOT NULL,
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella vorp.dogs: ~1 rows (circa)
/*!40000 ALTER TABLE `dogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `dogs` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
