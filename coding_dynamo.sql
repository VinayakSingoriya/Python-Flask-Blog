-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 30, 2020 at 01:46 PM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 5.6.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(30) NOT NULL,
  `phone_num` varchar(15) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'shyam', 'firstpost@gmail.com', '1234567890', 'this is first post', '2020-07-14 15:28:55'),
(2, 'vinayak singoriya', 'vinayaksingoriya@gmail.com', '7909813636', 'Hello brother', '2020-07-14 15:36:18'),
(3, 'sudhanshu singoriya', 'sudhanshusingoriya@gmail.com', '76483674298', 'Hello bhai', '2020-07-14 15:40:02'),
(4, 'suddhu', 'sudhanshusingoriya@gmail.com', '57389578973', 'ha bhiya , hal chal', '2020-07-14 15:54:58'),
(5, 'sudhanshu singoriya', 'sudhanshusingoriya@gmail.com', '76483674298', 'ghhbgyu', '2020-07-14 15:56:42'),
(6, 'sudhanshu singoriya', 'sudhanshusingoriya@gmail.com', '76483674298', 'ghhbgyu', '2020-07-14 15:59:11'),
(7, 'sudhanshu singoriya', 'sudhanshusingoriya@gmail.com', '76483674298', 'jai shree shyam', '2020-07-14 15:59:48'),
(8, 'vinayak singoriya', 'sudhanshusingoriya@gmail.com', '76483674298', 'hfe', '2020-07-26 22:10:17'),
(9, 'vinayak singoriya', 'sudhanshusingoriya@gmail.com', '76483674298', 'hfe', '2020-07-26 22:12:05'),
(10, 'vinayak singoriya', 'sudhanshusingoriya@gmail.com', '76483674298', 'hfe', '2020-07-26 22:14:35'),
(11, 'vinayak singoriya', 'sudhanshusingoriya@gmail.com', '76483674298', 'hfe', '2020-07-26 22:15:16'),
(12, 'vinayak singoriya', 'sudhanshusingoriya@gmail.com', '76483674298', 'hfe', '2020-07-26 22:17:28'),
(13, 'vinayak singoriya', 'sudhanshusingoriya@gmail.com', '76483674298', 'hfe', '2020-07-26 22:18:51'),
(14, 'vinayak singoriya', 'sudhanshusingoriya@gmail.com', '76483674298', 'hfe', '2020-07-26 22:19:56'),
(15, 'vinayak singoriya', 'vinayaksingoriya@gmail.com', '7909813636', 'This is just a demo for flash messages', '2020-07-26 22:22:48'),
(16, 'vinayak singoriya', 'vinayaksingoriya@gmail.com', '7909813636', 'This is just a demo for flash messages', '2020-07-26 22:31:28'),
(17, 'vinayak singoriya', 'vinayaksingoriya@gmail.com', '7909813636', 'bhbhh', '2020-07-26 22:32:11'),
(18, 'vinayak singoriya', 'vinayaksingoriya@gmail.com', '7909813636', 'bhbhh', '2020-07-26 22:33:33'),
(19, 'Hello mr', '', '', '', '2020-07-27 16:15:45'),
(20, 'hhhh', 'sudhanshusingoriya@gmail.com', '7909813636', 'Hello this is just dummy', '2020-07-27 16:16:40');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `subtitle` text NOT NULL,
  `content` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `date` datetime NOT NULL,
  `img_file` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `subtitle`, `content`, `slug`, `date`, `img_file`) VALUES
(1, 'This is my first post\'s title', 'Hello first post', 'Jai shree shyam', 'first-post', '2020-07-21 17:57:57', 'home-bg.jpg'),
(2, 'This is second post', 'Hello second post', 'Hello Mr. vinayak Singoriya. A python programming language is a formal language comprising a set of instructions that produce various kinds of output. Programming languages are used in computer programming to implement algorithms.Most programming languages consist of instructions for computers. There are programmable machines that use a set of specific instructions, rather than general programming languages. Early ones preceded the invention of the digital computer, the first probably being the automatic flute player described in the 9th century by the brothers Musa in Baghdad, during the Islamic Golden Age.[1] Since the early 1800s, programs have been used to direct the behavior of machines such as Jacquard looms, music boxes and player pianos.[2] The programs for these machines (such as a player piano\'s scrolls) did not produce different behavior in response to different inputs or conditions.Thousands of different programming languages have been created, and more are being created every year. Many programming languages are written in an imperative form (i.e., as a sequence of operations to perform) while other languages use the declarative form (i.e. the desired result is specified, not how to achieve it).', 'second-post', '2020-07-22 13:22:10', 'about-bg.jpg'),
(3, 'This is my third post', 'Hello third post', 'Many languages do not use articles (\"a,\" \"an,\" and \"the\"), or if they do exist, the way they are used may be different than in English. Multilingual writers often find article usage to be one of the most difficult concepts to learn. Although there are some rules about article usage to help, there are also quite a few exceptions. Therefore, learning to use articles accurately takes a long time. To master article usage, it is necessary to do a great deal of reading, notice how articles are used in published texts, and take notes that can apply back to your own writing.', 'third-post', '2020-07-19 13:06:52', 'about-bg.jpg'),
(4, 'This is my Fourth post', 'Hello Fourth post', 'The Big Bang is a theory that describes the beginnings of our universe. It contends that the universe began with a primordial explosion that occurred about 13 billion years ago. The original core of the explosion was very small and tremendously hot, composed entirely of high-energy radiation. As the universe expanded and cooled over the first three minutes, protons and neutrons were created out of that energy. These formed the nuclei of hydrogen and its isotopes. After a million years or so, the universe cooled enough to permit electrons to bind with protons to form neutral hydrogen atoms, along with traces of helium and other light elements. Unlike free electrons, bound electrons in atoms can interact with radiation', 'fourth-post', '2020-07-19 13:09:09', 'about-bg.jpg'),
(5, 'This is fifth post', 'Hello fifth posts', 'bad me discuss krege', 'fifth-post', '2020-07-21 17:33:58', 'about-bg.jpg'),
(6, 'This is sixth post', 'Hello sixth posts', 'Hello Mr. vinayak Singoriya. A programming language is a formal language comprising a set of instructions that produce various kinds of output. Programming languages are used in computer programming to implement algorithms.Most programming languages consist of instructions for computers. There are programmable machines that use a set of specific instructions, rather than general programming languages. Early ones preceded the invention of the digital computer, the first probably being the automatic flute player described in the 9th century by the brothers Musa in Baghdad, during the Islamic Golden Age.[1] Since the early 1800s, programs have been used to direct the behavior of machines such as Jacquard looms, music boxes and player pianos.[2] The programs for these machines (such as a player piano\'s scrolls) did not produce different behavior in response to different inputs or conditions.Thousands of different programming languages have been created, and more are being created every year. Many programming lang', 'sixth-post', '2020-07-22 13:43:02', 'about-bg.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
