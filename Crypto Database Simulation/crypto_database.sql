-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2022 at 05:41 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `crypto_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `assetID` int(11) NOT NULL,
  `UserID` varchar(10) DEFAULT NULL,
  `CoinID` varchar(5) DEFAULT NULL,
  `sum_of_assets` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cryptocurrency`
--

CREATE TABLE `cryptocurrency` (
  `CoinID` varchar(5) NOT NULL,
  `coin_name` varchar(11) NOT NULL,
  `rp_exchange_rate` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cryptocurrency`
--

INSERT INTO `cryptocurrency` (`CoinID`, `coin_name`, `rp_exchange_rate`) VALUES
('BTC', 'Bitcoin', 443132052.6),
('ETH', 'Ethereum', 26421617.09),
('LTC', 'Litecoin', 904285.2);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transactionID` int(11) NOT NULL,
  `UserID` varchar(10) NOT NULL,
  `CoinID` varchar(5) NOT NULL,
  `transaction` varchar(10) NOT NULL,
  `num_of_coins` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transactionID`, `UserID`, `CoinID`, `transaction`, `num_of_coins`) VALUES
(1, 'A1', 'BTC', 'buy', 0.005),
(2, 'A1', 'BTC', 'sell', 0.01),
(3, 'E2', 'ETH', 'buy', 1.6),
(4, 'E2', 'ETH', 'sell', 0.8),
(5, 'P0', 'LTC', 'buy', 40),
(6, 'P0', 'LTC', 'buy', 0.18);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `UserID` varchar(10) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `rupiah_balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`UserID`, `user_name`, `rupiah_balance`) VALUES
('A1', 'Andy', 10000000),
('E2', 'Egi', 50000000),
('P0', 'Pilo', 40000000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`assetID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `CoinID` (`CoinID`);

--
-- Indexes for table `cryptocurrency`
--
ALTER TABLE `cryptocurrency`
  ADD PRIMARY KEY (`CoinID`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transactionID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `CoinID` (`CoinID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `assetID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transactionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assets`
--
ALTER TABLE `assets`
  ADD CONSTRAINT `assets_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `assets_ibfk_2` FOREIGN KEY (`CoinID`) REFERENCES `cryptocurrency` (`CoinID`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `CoinID` FOREIGN KEY (`CoinID`) REFERENCES `cryptocurrency` (`CoinID`),
  ADD CONSTRAINT `UserID` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
