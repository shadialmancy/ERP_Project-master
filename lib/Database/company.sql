-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 12, 2021 at 11:54 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.6

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
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(11) NOT NULL,
  `month` varchar(10) DEFAULT NULL,
  `year` varchar(10) DEFAULT NULL,
  `Balance` double DEFAULT NULL,
  `expenses` double DEFAULT NULL,
  `salary` double DEFAULT NULL,
  `income` double DEFAULT NULL,
  `tax` double DEFAULT NULL,
  `newBalance` double DEFAULT NULL,
  `profit` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`id`, `month`, `year`, `Balance`, `expenses`, `salary`, `income`, `tax`, `newBalance`, `profit`) VALUES
(1, 'January', '2021', 500000, 2000, 57000, 130000, 26180, 544820, 44820),
(2, 'February', '2021', 544820, 1000, 57000, 35000, 12880, 508940, -35880),
(3, 'March', '2021', 508940, 12000, 57000, 350000, 56980, 732960, 224020),
(4, 'April', '2021', 732960, 35000, 57000, 100000, 21980, 718980, -13980),
(5, 'May', '2021', 718980, 20000, 57000, 165000, 31080, 775900, 56920),
(6, 'June', '2021', 775900, 362000, 57000, 452000, 71260, 737640, -38260);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
