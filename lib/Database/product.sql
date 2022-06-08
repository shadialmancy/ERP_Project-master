-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 12, 2021 at 07:17 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `erp`
--

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `Name` varchar(255) NOT NULL,
  `SKU` varchar(255) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Cost price` int(11) NOT NULL,
  `Variant` varchar(255) NOT NULL,
  `Selling price` int(11) NOT NULL,
  `Compared at price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Name`, `SKU`, `Quantity`, `Cost price`, `Variant`, `Selling price`, `Compared at price`) VALUES
('qweqwe', '123123qawqweqsds', 0, 0, '', 0, 0),
('adsdasd', '1231aeqew', 0, 0, '', 0, 0),
('qwe', '123qwe', 0, 0, '', 0, 0),
('edfgdfg', '234235werterty', 0, 0, '', 0, 0),
('sdfsdf', '314wer2qwer', 0, 0, '', 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`SKU`),
  ADD UNIQUE KEY `SKU` (`SKU`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
