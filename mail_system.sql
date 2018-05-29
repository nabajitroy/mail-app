-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2018 at 09:14 PM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 5.6.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mail_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `description` text NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `created`, `modified`) VALUES
(1, 'Fashion', 'Category for anything related to fashion.', '2014-06-01 00:35:07', '2014-05-30 12:04:33'),
(2, 'Electronics', 'Gadgets, drones and more.', '2014-06-01 00:35:07', '2014-05-30 12:04:33'),
(3, 'Motors', 'Motor sports and more', '2014-06-01 00:35:07', '2014-05-30 12:04:54'),
(5, 'Movies', 'Movie products.', '0000-00-00 00:00:00', '2016-01-08 07:57:26'),
(6, 'Books', 'Kindle books, audio books and more.', '0000-00-00 00:00:00', '2016-01-08 07:57:47'),
(13, 'Sports', 'Drop into new winter gear.', '2016-01-09 02:24:24', '2016-01-08 19:54:24');

-- --------------------------------------------------------

--
-- Table structure for table `emails`
--

CREATE TABLE `emails` (
  `id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mail_from` varchar(200) NOT NULL,
  `mail_to` varchar(200) NOT NULL,
  `mail_subject` varchar(200) NOT NULL,
  `mail_body` text NOT NULL,
  `read_status` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` varchar(200) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `spam` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emails`
--

INSERT INTO `emails` (`id`, `created`, `updated`, `mail_from`, `mail_to`, `mail_subject`, `mail_body`, `read_status`, `parent_id`, `deleted`, `spam`) VALUES
(1, '2018-05-20 15:53:16', '2018-05-20 15:53:16', 'admin', 'user2@testmail.com', 'Main mail to user 2', 'Main mail to user 2', 1, 'NULL', 0, NULL),
(2, '2018-05-20 15:53:41', '2018-05-20 15:53:41', 'user2@testmail.com', 'admin', 'Main mail to user 2', 'first replay to admin from user 2', 0, '1', 1, NULL),
(3, '2018-05-20 15:54:07', '2018-05-20 15:54:07', 'admin', 'user2@testmail.com', 'Main mail to user 2', 'replay second from admin', 0, '1', 0, NULL),
(4, '2018-05-20 15:54:34', '2018-05-20 15:54:34', 'user2@testmail.com', 'admin', 'Main mail to user 2', 'third replay from user 2', 0, '1', 1, NULL),
(5, '2018-05-20 15:55:09', '2018-05-20 15:55:09', 'user2@testmail.com', 'admin', 'Main mail to user 2', 'user 2 again replays', 1, '1', 1, 1),
(6, '2018-05-21 06:43:22', '2018-05-21 06:43:22', 'admin', 'user5@testmail.com', 'This is a new mail - main', 'This is the main email chain', 1, 'NULL', 0, 1),
(7, '2018-05-21 06:44:40', '2018-05-21 06:44:40', 'user5@testmail.com', 'admin', 'This is a new mail - main', 'this is my first replay', 1, '6', 1, 1),
(8, '2018-05-21 06:45:09', '2018-05-21 06:45:09', 'admin', 'user5@testmail.com', 'This is a new mail - main', 'Ok got your replay', 1, '6', 0, NULL),
(9, '2018-05-21 10:02:37', '2018-05-21 10:02:37', 'admin', 'admin', 'Hello Admin', 'This is mail body', 1, 'NULL', 1, NULL),
(10, '2018-05-21 10:04:22', '2018-05-21 10:04:22', 'user2@testmail.com', 'admin', 'Hello Admin', 'This is body', 1, 'NULL', 1, 1),
(11, '2018-05-21 10:07:15', '2018-05-21 10:07:15', 'admin', 'user2@testmail.com', 'Hello user 2', 'This is body', 1, 'NULL', 0, NULL),
(12, '2018-05-21 10:08:05', '2018-05-21 10:08:05', 'user2@testmail.com', 'admin', 'Hello again', 'hello', 1, 'NULL', 0, 1),
(13, '2018-05-21 10:15:43', '2018-05-21 10:15:43', 'admin', 'user2@testmail.com', 'Hello again', 'hi how are you boss', 0, '12', 0, NULL),
(14, '2018-05-21 10:16:26', '2018-05-21 10:16:26', 'user2@testmail.com', 'admin', 'Hello again', 'I am fine what about you boss', 1, '12', 1, 1),
(15, '2018-05-21 12:25:26', '2018-05-21 12:25:26', 'user5@testmail.com', 'admin', 'This is a new mail - main', 'hello boss', 1, '6', 1, 1),
(16, '2018-05-21 12:38:43', '2018-05-21 12:38:43', 'admin', 'user2@testmail.com', 'Hello again', 'fsdfsf', 0, '12', 0, NULL),
(17, '2018-05-21 12:39:02', '2018-05-21 12:39:02', 'user5@testmail.com', 'admin', 'This is a new mail - main', 'cool', 1, '6', 0, NULL),
(18, '2018-05-21 17:43:18', '2018-05-21 17:43:18', 'user5@testmail.com', 'admin', 'Hello', 'test', 1, 'NULL', 0, 1),
(19, '2018-05-21 17:44:11', '2018-05-21 17:44:11', 'admin', 'user2@testmail.com', 'Hello again', 'Hi', 1, '12', 1, 0),
(20, '2018-05-21 17:45:10', '2018-05-21 17:45:10', 'user5@testmail.com', 'admin', 'Test', 'Test', 0, 'NULL', 0, 1),
(21, '2018-05-21 17:46:21', '2018-05-21 17:46:21', 'user5@testmail.com', 'admin', 'Test 1', 'test', 0, 'NULL', 0, 1),
(22, '2018-05-21 17:47:41', '2018-05-21 17:47:41', 'user5@testmail.com', 'admin', 'hello', 'hello', 0, 'NULL', 0, 1),
(23, '2018-05-21 18:01:19', '2018-05-21 18:01:19', 'user5@testmail.com', 'admin', 'Hello Admin', 'Hi', 0, 'NULL', 0, 1),
(24, '2018-05-21 18:14:09', '2018-05-21 18:14:09', 'user5@testmail.com', 'admin', 'Hello admin', 'Hello How are you', 0, 'NULL', 0, 0),
(25, '2018-05-21 18:15:53', '2018-05-21 18:15:53', 'user5@testmail.com', 'admin', 'Hello', 'Did you got my mail?', 1, 'NULL', 0, 0),
(26, '2018-05-21 18:16:22', '2018-05-21 18:16:22', 'admin', 'user5@testmail.com', 'Hello', 'Yes Got it - Thank you', 1, '25', 0, 0),
(27, '2018-05-21 18:16:56', '2018-05-21 18:16:56', 'user5@testmail.com', 'admin', 'Hello', 'Ok How was it. What you think ?', 1, '25', 0, 0),
(28, '2018-05-21 18:17:33', '2018-05-21 18:17:33', 'admin', 'user5@testmail.com', 'Hello', 'Yes its good. I just love it- Thank you very much.', 1, '25', 0, 0),
(29, '2018-05-21 18:18:22', '2018-05-21 18:18:22', 'user5@testmail.com', 'admin', 'Hello', 'Cool- Thanks that you like it', 1, '25', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `category_id`, `created`, `modified`) VALUES
(1, 'LG P880 4X HD', 'My first awesome phone!', '336', 3, '2014-06-01 01:12:26', '2014-05-31 11:42:26'),
(2, 'Google Nexus 4', 'The most awesome phone of 2013!', '299', 2, '2014-06-01 01:12:26', '2014-05-31 11:42:26'),
(3, 'Samsung Galaxy S4', 'How about no?', '600', 3, '2014-06-01 01:12:26', '2014-05-31 11:42:26'),
(6, 'Bench Shirt', 'The best shirt!', '29', 1, '2014-06-01 01:12:26', '2014-05-30 20:42:21'),
(7, 'Lenovo Laptop', 'My business partner.', '399', 2, '2014-06-01 01:13:45', '2014-05-30 20:43:39'),
(8, 'Samsung Galaxy Tab 10.1', 'Good tablet.', '259', 2, '2014-06-01 01:14:13', '2014-05-30 20:44:08'),
(9, 'Spalding Watch', 'My sports watch.', '199', 1, '2014-06-01 01:18:36', '2014-05-30 20:48:31'),
(10, 'Sony Smart Watch', 'The coolest smart watch!', '300', 2, '2014-06-06 17:10:01', '2014-06-05 12:39:51'),
(11, 'Huawei Y300', 'For testing purposes.', '100', 2, '2014-06-06 17:11:04', '2014-06-05 12:40:54'),
(12, 'Abercrombie Lake Arnold Shirt', 'Perfect as gift!', '60', 1, '2014-06-06 17:12:21', '2014-06-05 12:42:11'),
(13, 'Abercrombie Allen Brook Shirt', 'Cool red shirt!', '70', 1, '2014-06-06 17:12:59', '2014-06-05 12:42:49'),
(26, 'Another product', 'Awesome product!', '555', 2, '2014-11-22 19:07:34', '2014-11-21 14:37:34'),
(28, 'Wallet', 'You can absolutely use this one!', '799', 6, '2014-12-04 21:12:03', '2014-12-03 16:42:03'),
(31, 'Amanda Waller Shirt', 'New awesome shirt!', '333', 1, '2014-12-13 00:52:54', '2014-12-11 20:22:54'),
(42, 'Nike Shoes for Men', 'Nike Shoes', '12999', 3, '2015-12-12 06:47:08', '2015-12-12 00:17:08'),
(48, 'Bristol Shoes', 'Awesome shoes.', '999', 5, '2016-01-08 06:36:37', '2016-01-08 00:06:37'),
(60, 'Rolex Watch', 'Luxury watch.', '25000', 1, '2016-01-11 15:46:02', '2016-01-11 09:16:02');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password`) VALUES
(1, 'user one', 'admin', 'admin'),
(2, 'user two', 'user2@testmail.com', '12345'),
(3, 'user three', 'user3@testmail.com', '12345'),
(4, 'user four', 'user4@testmail.com', '12345'),
(5, 'user five', 'user5@testmail.com', '12345');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `emails`
--
ALTER TABLE `emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
