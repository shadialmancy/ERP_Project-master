-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 12, 2021 at 11:53 PM
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
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `ssin` varchar(14) DEFAULT NULL,
  `socialNumber` varchar(14) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `userType` varchar(50) DEFAULT NULL,
  `salary` double DEFAULT NULL,
  `insurance` double DEFAULT NULL,
  `tax` double DEFAULT NULL,
  `deduction` double DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  `netSalary` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `ssin`, `socialNumber`, `phone`, `email`, `password`, `address`, `userType`, `salary`, `insurance`, `tax`, `deduction`, `note`, `netSalary`) VALUES
(1, 'Ahmed Shawky', '29912100400276', '32514847', '01154338430', 'ahmedshawky22001@gmail.com', '2018320', '11 st Fayad, Suez, Suez Governorate, Egypt', 'Admin', 21000, 200, 2940, 75, '1 day late', 17785),
(2, 'Mohammed Ali', '28812100600312', '56594213', '01023545851', 'mohammed@gmail.com', '8520', '22st elnozha, Cairo, Cairo Governorate, Egypt', 'Seller', 10000, 110, 1400, 0, 'no deduction ', 8490),
(3, 'Tarek', '156165165165', '1651651', '02125455484', 'tarek@gmail.com', '74120', '34st mohammed ali, Dikirnis, Dakahlia Governorate, Egypt', 'Accountant', 10000, 120, 1400, 75, 'late 1 day ', 8405),
(4, 'Osama Khaled', '23154875695631', '23514587', '01235468547', 'osama@gmail.com', '333333', '21st elmohammady, Luxor, Luxor Governorate, Egypt', 'Accountant', 16000, 140, 2240, 300, 'late 4 days ', 13320),
(5, 'samy Mostafa', '23154847562146', '22325145', '01215478546', 'samy@gmail.com', '888888', '36st abo fasel, Al Badārī, Asyut Governorate, Egypt', 'Online Sale', 0, 0, 0, 0, ' ', 0),
(6, 'Marian', '23654875495954', '22664854', '01225459856', 'marian@gmail.com', 'mm0000', '21st elwaraq, Cairo, Cairo Governorate, Egypt', 'Inventory', 0, 0, 0, 0, ' ', 0),
(7, 'Zeyad', '33254544561651', '32548569', '01123548569', 'zee@gmail.com', 'zee0000', '21st embaba, Giza, Giza Governorate, Egypt', 'Online Sale', 0, 0, 0, 0, ' ', 0),
(8, '', '', '', '', NULL, '', '', 'Not Defined', 0, 0, 0, 0, ' ', 0),
(9, '', '', '', '', NULL, '', '', 'Not Defined', 0, 0, 0, 0, ' ', 0),
(10, '', '', '', '', NULL, '', '', 'Not Defined', 0, 0, 0, 0, ' ', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
