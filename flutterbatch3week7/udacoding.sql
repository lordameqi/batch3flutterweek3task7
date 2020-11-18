-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2020 at 03:48 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `udacoding`
--

-- --------------------------------------------------------

--
-- Table structure for table `kamus`
--

CREATE TABLE `kamus` (
  `id_kamus` int(11) NOT NULL,
  `singkatan` varchar(99) NOT NULL,
  `penjelasan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kamus`
--

INSERT INTO `kamus` (`id_kamus`, `singkatan`, `penjelasan`) VALUES
(1, 'Abate', 'Sejenis obat bubuk untuk membunuh jentik nyamuk. Adapun takaran penggunaannya: 10 liter air cukup dengan 1 gram bubuk Abate atau 100 liter air untuk 10 gram Abate (1 sendok makan peres diratakan atasnya = 10 gram Abate).'),
(2, 'Adenoma', 'Tumor jinak yang dimulai dalam sel-sel mirip kelenjar dari jaringan epitel, yakni lapisan tipis dari jaringan yang meliputi kulit, organ-organ, kelenjar, dan struktur lainnya dalam tubuh.'),
(3, 'Adiksi', 'Adiksi atau kecanduan adalah sebuah pola maladaptif dari penggunaan narkoba yang mengarah ke gangguan klinis signifikan'),
(4, 'Adrenalin', 'Zat yang dilepaskan ke dalam aliran darah oleh kelenjar adrenal. Hormon ini dikenal sebagai hormon \"stres\", karena sekresinya meningkat selama stres dan ketegangan. Adrenalin menyebabkan perubahan dalam tubuh, seperti denyut nadi dipercepat, dilatasi pupil, dan aliran darah meningkat ke otot-otot ekstremitas bawah.'),
(5, 'Aferesis', 'Suatu prosedur pengeluaran komponen darah. Jika yang dikeluarkan adalah leukosit, maka disebut leukoferesis. Bila trombosit yang dikeluarkan, maka disebut tromboferesis. Komponen-komponen selain leukosit atau trombosit akan dimasukkan kembali ke dalam tubuh pendonor.');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(99) NOT NULL,
  `password` varchar(99) NOT NULL,
  `email` varchar(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `email`) VALUES
(1, 'admin	', '21232f297a57a5a743894a0e4a801fc3', 'admin@gmail.com'),
(2, 'admin	', '21232f297a57a5a743894a0e4a801fc3', 'admin@gmail.com'),
(3, 'admin	', '21232f297a57a5a743894a0e4a801fc3', 'admin@gmail.com'),
(4, 'admin	', '21232f297a57a5a743894a0e4a801fc3', 'admin@gmail.com'),
(32, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin@gmail.com'),
(33, 'admina', 'e10adc3949ba59abbe56e057f20f883e', 'admin@gmail.com'),
(34, 'adminaq', 'e10adc3949ba59abbe56e057f20f883e', 'admin@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kamus`
--
ALTER TABLE `kamus`
  ADD PRIMARY KEY (`id_kamus`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kamus`
--
ALTER TABLE `kamus`
  MODIFY `id_kamus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
