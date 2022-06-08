-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2021 at 08:40 PM
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
  `Variant` varchar(255) NOT NULL DEFAULT 'None',
  `Selling price` int(11) NOT NULL,
  `Compared at price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Name`, `SKU`, `Quantity`, `Cost price`, `Variant`, `Selling price`, `Compared at price`) VALUES
('Cisco Router', 'Cisco Router- 10X', 9, 31, '', 12, 19),
('Test1', 'test-1', 33, 0, '', 0, 0),
('test 2', 'test-2', 8, 34, '', 50, 16),
('test 3', 'test-3', 5, 12, '', 11, -1),
('test 4', 'test-4', 3, 0, '', 0, 0),
('test 5', 'test-5', 6, 0, '', 0, 0),
('test 6', 'test-6', 7, 0, '', 0, 0),
('test 7', 'test-7', -1, 0, '', 0, 0),
('Dell Server', 'XP 2000', 12, 4, '', 8, 4);

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
