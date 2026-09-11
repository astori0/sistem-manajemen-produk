-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 11, 2026 at 05:51 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_busana_muslim`
--
CREATE DATABASE IF NOT EXISTS `db_busana_muslim` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `db_busana_muslim`;

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int NOT NULL,
  `kode_produk` varchar(30) NOT NULL,
  `nama_produk` varchar(150) NOT NULL,
  `kategori_produk` varchar(50) NOT NULL,
  `harga_produk` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status_produk` enum('Aktif','Tidak Aktif') NOT NULL DEFAULT 'Aktif',
  `tanggal_dibuat` datetime DEFAULT CURRENT_TIMESTAMP,
  `tanggal_diubah` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `kode_produk`, `nama_produk`, `kategori_produk`, `harga_produk`, `status_produk`, `tanggal_dibuat`, `tanggal_diubah`) VALUES
(1, 'GMS-001', 'Gamis Abaya Silk Premium', 'Gamis', 350000.00, 'Aktif', '2026-09-11 19:45:09', '2026-09-11 19:45:09'),
(2, 'KKO-001', 'Baju Koko Executive Lengan Panjang', 'Baju Koko', 225000.00, 'Aktif', '2026-09-11 19:45:09', '2026-09-11 19:45:09');

-- --------------------------------------------------------

--
-- Table structure for table `variasi_ukuran`
--

CREATE TABLE `variasi_ukuran` (
  `id_ukuran` int NOT NULL,
  `id_warna` int NOT NULL,
  `nama_ukuran` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `variasi_ukuran`
--

INSERT INTO `variasi_ukuran` (`id_ukuran`, `id_warna`, `nama_ukuran`) VALUES
(1, 1, 'S'),
(2, 1, 'M'),
(3, 1, 'L'),
(4, 1, 'XL'),
(5, 2, 'M'),
(6, 2, 'L'),
(7, 3, 'M'),
(8, 3, 'L'),
(9, 3, 'XXL');

-- --------------------------------------------------------

--
-- Table structure for table `variasi_warna`
--

CREATE TABLE `variasi_warna` (
  `id_warna` int NOT NULL,
  `id_produk` int NOT NULL,
  `nama_warna` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `variasi_warna`
--

INSERT INTO `variasi_warna` (`id_warna`, `id_produk`, `nama_warna`) VALUES
(1, 1, 'Hitam Emerald'),
(2, 1, 'Dusty Pink'),
(3, 2, 'Putih Bersih');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`),
  ADD UNIQUE KEY `kode_produk` (`kode_produk`);

--
-- Indexes for table `variasi_ukuran`
--
ALTER TABLE `variasi_ukuran`
  ADD PRIMARY KEY (`id_ukuran`),
  ADD KEY `fk_ukuran_warna` (`id_warna`);

--
-- Indexes for table `variasi_warna`
--
ALTER TABLE `variasi_warna`
  ADD PRIMARY KEY (`id_warna`),
  ADD KEY `fk_warna_produk` (`id_produk`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `variasi_ukuran`
--
ALTER TABLE `variasi_ukuran`
  MODIFY `id_ukuran` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `variasi_warna`
--
ALTER TABLE `variasi_warna`
  MODIFY `id_warna` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `variasi_ukuran`
--
ALTER TABLE `variasi_ukuran`
  ADD CONSTRAINT `fk_ukuran_warna` FOREIGN KEY (`id_warna`) REFERENCES `variasi_warna` (`id_warna`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `variasi_warna`
--
ALTER TABLE `variasi_warna`
  ADD CONSTRAINT `fk_warna_produk` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Database: `db_sistem_produk`
--
CREATE DATABASE IF NOT EXISTS `db_sistem_produk` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `db_sistem_produk`;

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int NOT NULL,
  `kode_produk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_produk` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kategori_produk` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `harga_produk` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status_produk` enum('Aktif','Tidak Aktif') NOT NULL DEFAULT 'Aktif',
  `tanggal_dibuat` datetime DEFAULT CURRENT_TIMESTAMP,
  `tanggal_diubah` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `kode_produk`, `nama_produk`, `kategori_produk`, `harga_produk`, `status_produk`, `tanggal_dibuat`, `tanggal_diubah`) VALUES
(5, 'HJB-0001', 'Hijab Putihh', 'Hijab', 20000.00, 'Aktif', '2026-09-11 23:39:41', '2026-09-11 23:39:41'),
(6, 'MKN-0001', 'Mukena Anak', 'Mukena', 26500.00, 'Aktif', '2026-09-11 23:57:26', '2026-09-11 23:57:26'),
(7, 'MKN-0002', 'Mukena Gaul', 'Mukena', 34000.00, 'Aktif', '2026-09-12 00:00:12', '2026-09-12 00:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `variasi_ukuran`
--

CREATE TABLE `variasi_ukuran` (
  `id_ukuran` int NOT NULL,
  `id_warna` int NOT NULL,
  `nama_ukuran` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `variasi_ukuran`
--

INSERT INTO `variasi_ukuran` (`id_ukuran`, `id_warna`, `nama_ukuran`) VALUES
(38, 13, 'M'),
(39, 13, 'S'),
(40, 14, 'M'),
(41, 15, 'S'),
(42, 16, 'S'),
(43, 17, 'S'),
(44, 18, 'M'),
(45, 19, 'M'),
(46, 19, 'L');

-- --------------------------------------------------------

--
-- Table structure for table `variasi_warna`
--

CREATE TABLE `variasi_warna` (
  `id_warna` int NOT NULL,
  `id_produk` int NOT NULL,
  `nama_warna` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `variasi_warna`
--

INSERT INTO `variasi_warna` (`id_warna`, `id_produk`, `nama_warna`) VALUES
(13, 5, 'Hitam'),
(14, 5, 'Putih'),
(15, 6, 'Hitam'),
(16, 6, 'Putih'),
(17, 6, 'Ungu'),
(18, 7, 'Hitam'),
(19, 7, 'Coklat');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`),
  ADD UNIQUE KEY `kode_produk` (`kode_produk`);

--
-- Indexes for table `variasi_ukuran`
--
ALTER TABLE `variasi_ukuran`
  ADD PRIMARY KEY (`id_ukuran`),
  ADD KEY `fk_ukuran_warna` (`id_warna`);

--
-- Indexes for table `variasi_warna`
--
ALTER TABLE `variasi_warna`
  ADD PRIMARY KEY (`id_warna`),
  ADD KEY `fk_warna_produk` (`id_produk`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `variasi_ukuran`
--
ALTER TABLE `variasi_ukuran`
  MODIFY `id_ukuran` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `variasi_warna`
--
ALTER TABLE `variasi_warna`
  MODIFY `id_warna` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `variasi_ukuran`
--
ALTER TABLE `variasi_ukuran`
  ADD CONSTRAINT `fk_ukuran_warna` FOREIGN KEY (`id_warna`) REFERENCES `variasi_warna` (`id_warna`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `variasi_warna`
--
ALTER TABLE `variasi_warna`
  ADD CONSTRAINT `fk_warna_produk` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Database: `kms_kominfo_ngawi`
--
CREATE DATABASE IF NOT EXISTS `kms_kominfo_ngawi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `kms_kominfo_ngawi`;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(2, 'ADMIN_UNIT'),
(5, 'APPROVER'),
(3, 'AUTHOR'),
(4, 'REVIEWER'),
(1, 'SUPER_ADMIN'),
(6, 'VIEWER');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add tag', 7, 'add_tag'),
(26, 'Can change tag', 7, 'change_tag'),
(27, 'Can delete tag', 7, 'delete_tag'),
(28, 'Can view tag', 7, 'view_tag'),
(29, 'Can add category', 8, 'add_category'),
(30, 'Can change category', 8, 'change_category'),
(31, 'Can delete category', 8, 'delete_category'),
(32, 'Can view category', 8, 'view_category'),
(33, 'Can add knowledge item', 9, 'add_knowledgeitem'),
(34, 'Can change knowledge item', 9, 'change_knowledgeitem'),
(35, 'Can delete knowledge item', 9, 'delete_knowledgeitem'),
(36, 'Can view knowledge item', 9, 'view_knowledgeitem'),
(37, 'Can add attachment', 10, 'add_attachment'),
(38, 'Can change attachment', 10, 'change_attachment'),
(39, 'Can delete attachment', 10, 'delete_attachment'),
(40, 'Can view attachment', 10, 'view_attachment'),
(41, 'Can add workflow request', 11, 'add_workflowrequest'),
(42, 'Can change workflow request', 11, 'change_workflowrequest'),
(43, 'Can delete workflow request', 11, 'delete_workflowrequest'),
(44, 'Can view workflow request', 11, 'view_workflowrequest'),
(45, 'Can add workflow action', 12, 'add_workflowaction'),
(46, 'Can change workflow action', 12, 'change_workflowaction'),
(47, 'Can delete workflow action', 12, 'delete_workflowaction'),
(48, 'Can view workflow action', 12, 'view_workflowaction');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$720000$9nqKjhWbrNwPScqxN9HGpm$uVhEYWAL21HY2msXNkDFvyhsadezh8TOAVkqFQT/lwQ=', '2026-01-20 18:13:33.585251', 1, 'superadmin', '', '', 'iwancokicoki13@gmail.com', 1, 1, '2026-01-15 17:32:04.194408'),
(2, 'pbkdf2_sha256$720000$NaJeeWx1J8G27wacn00r9N$jfizDL3UnPoVXo2k5v+HdsX6MH9Oe7WyjrNKrr6yEZ4=', '2026-01-20 18:27:40.372419', 0, 'author123', '', '', '', 0, 1, '2026-01-20 02:13:04.000000'),
(3, 'pbkdf2_sha256$720000$DSfkxWaqwyq9qjSxY65N3D$Bm92J98HCR6F4U3kZJ9Zv1VFhRcxbAOHsnptbU9tZrw=', '2026-01-20 18:12:23.717446', 0, 'reviewer123', 'Hanya', 'Awkwkw', '', 0, 1, '2026-01-20 02:15:54.000000'),
(4, 'pbkdf2_sha256$720000$I9ouTvlR9kds2ViyMc8Wor$Cr2+Z0mUAa9MYRxMudl9ufXUg6T66ByZ0k9/lWffBwE=', '2026-01-20 18:14:22.036071', 0, 'approver123', '', '', '', 0, 1, '2026-01-20 02:16:30.000000');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 2, 3),
(2, 3, 4),
(3, 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL
) ;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2026-01-20 01:56:43.693545', '1', 'SUPER_ADMIN', 1, '[{\"added\": {}}]', 3, 1),
(2, '2026-01-20 01:57:03.024988', '2', 'ADMIN_UNIT', 1, '[{\"added\": {}}]', 3, 1),
(3, '2026-01-20 01:57:17.264672', '3', 'AUTHOR', 1, '[{\"added\": {}}]', 3, 1),
(4, '2026-01-20 01:57:30.313432', '4', 'REVIEWER', 1, '[{\"added\": {}}]', 3, 1),
(5, '2026-01-20 01:57:41.765512', '5', 'APPROVER', 1, '[{\"added\": {}}]', 3, 1),
(6, '2026-01-20 01:57:57.974563', '6', 'VIEWER', 1, '[{\"added\": {}}]', 3, 1),
(7, '2026-01-20 02:13:05.860059', '2', 'author123@gmail.com', 1, '[{\"added\": {}}]', 4, 1),
(8, '2026-01-20 02:13:35.282513', '2', 'author123@gmail.com', 2, '[]', 4, 1),
(9, '2026-01-20 02:14:14.004137', '2', 'author123@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(10, '2026-01-20 02:15:55.231664', '3', 'reviewer123', 1, '[{\"added\": {}}]', 4, 1),
(11, '2026-01-20 02:16:30.874779', '4', 'approver123', 1, '[{\"added\": {}}]', 4, 1),
(12, '2026-01-20 02:17:21.148794', '3', 'reviewer123', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Groups\"]}}]', 4, 1),
(13, '2026-01-20 02:17:39.583162', '4', 'approver123', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(14, '2026-01-20 02:19:30.917617', '2', 'author123', 2, '[{\"changed\": {\"fields\": [\"Username\"]}}]', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(10, 'knowledge', 'attachment'),
(9, 'knowledge', 'knowledgeitem'),
(6, 'sessions', 'session'),
(8, 'taxonomy', 'category'),
(7, 'taxonomy', 'tag'),
(12, 'workflow', 'workflowaction'),
(11, 'workflow', 'workflowrequest');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-01-15 17:27:20.048365'),
(2, 'auth', '0001_initial', '2026-01-15 17:27:20.933908'),
(3, 'admin', '0001_initial', '2026-01-15 17:27:21.159579'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-01-15 17:27:21.176334'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-01-15 17:27:21.188215'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-01-15 17:27:21.326752'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-01-15 17:27:21.457496'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-01-15 17:27:21.497259'),
(9, 'auth', '0004_alter_user_username_opts', '2026-01-15 17:27:21.507008'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-01-15 17:27:21.599916'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-01-15 17:27:21.603561'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-01-15 17:27:21.614794'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-01-15 17:27:21.723437'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-01-15 17:27:21.834804'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-01-15 17:27:21.867789'),
(16, 'auth', '0011_update_proxy_permissions', '2026-01-15 17:27:21.884103'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-01-15 17:27:21.986612'),
(18, 'sessions', '0001_initial', '2026-01-15 17:27:22.041810'),
(19, 'taxonomy', '0001_initial', '2026-01-17 09:07:29.702890'),
(20, 'knowledge', '0001_initial', '2026-01-18 17:40:39.304628'),
(21, 'workflow', '0001_initial', '2026-01-19 17:28:10.712789');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('aem0g04tng1hqoc75ui3fcujkpru61w4', '.eJxVjMsOwiAQRf-FtSEjj2Fw6b7fQIABqZo2Ke3K-O_apAvd3nPOfYkQt7WFrZcljCwuQonT75ZifpRpB3yP022WeZ7WZUxyV-RBuxxmLs_r4f4dtNjbt_aabCWbnCFTPAEQKMfoaqps0OMZuIJG0sYD2pIVIBZFOptowbMT7w-vOjZ2:1viGS4:2qqnYGWD1qSvsBCwPJhZVOHbFkkO-hKYv995Gh1_HGE', '2026-02-03 18:27:40.387110');

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_attachment`
--

CREATE TABLE `knowledge_attachment` (
  `id` bigint NOT NULL,
  `file` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `uploaded_by_id` int NOT NULL,
  `knowledge_item_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `knowledge_attachment`
--

INSERT INTO `knowledge_attachment` (`id`, `file`, `original_name`, `uploaded_at`, `uploaded_by_id`, `knowledge_item_id`) VALUES
(1, 'knowledge_files/SOP-Jaringan.pdf', 'SOP-Jaringan.pdf', '2026-01-19 17:19:49.328196', 1, 1),
(2, 'knowledge_files/MO-ASTORISM.pdf', 'MO-ASTORISM.pdf', '2026-01-22 19:07:57.861449', 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_knowledgeitem`
--

CREATE TABLE `knowledge_knowledgeitem` (
  `id` bigint NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` longtext COLLATE utf8mb4_unicode_ci,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `classification` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `author_id` int NOT NULL,
  `category_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `knowledge_knowledgeitem`
--

INSERT INTO `knowledge_knowledgeitem` (`id`, `type`, `title`, `summary`, `content`, `status`, `classification`, `created_at`, `updated_at`, `published_at`, `author_id`, `category_id`) VALUES
(1, 'DOCUMENT', 'SOP Pengelolaan Jaringan Kominfo', 'SOP dasar untuk troubleshooting jaringan', 'Langkah-langkah pengecekan kabel, switch, router...', 'IN_REVIEW', 'INTERNAL', '2026-01-18 18:15:30.010369', '2026-01-19 17:25:46.400400', NULL, 1, 1),
(2, 'DOCUMENT', 'SOP Pengelolaan Website Kominfo', 'SOP dasar untuk Website', 'Langkah-langkah pengecekan database', 'PUBLISHED', 'INTERNAL', '2026-01-19 18:38:47.813864', '2026-01-20 18:24:55.581775', '2026-01-19 18:42:41.907099', 1, 1),
(3, 'LESSON_LEARNED', 'testing 1', 'testing 1', 'testingggggggggggggggggggggggggggggggggggggggggg', 'IN_REVIEW', 'INTERNAL', '2026-01-22 19:07:57.776513', '2026-01-22 19:07:57.928955', NULL, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_knowledgeitem_tags`
--

CREATE TABLE `knowledge_knowledgeitem_tags` (
  `id` bigint NOT NULL,
  `knowledgeitem_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `knowledge_knowledgeitem_tags`
--

INSERT INTO `knowledge_knowledgeitem_tags` (`id`, `knowledgeitem_id`, `tag_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `taxonomy_category`
--

CREATE TABLE `taxonomy_category` (
  `id` bigint NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxonomy_category`
--

INSERT INTO `taxonomy_category` (`id`, `name`, `parent_id`) VALUES
(1, 'SOP', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `taxonomy_tag`
--

CREATE TABLE `taxonomy_tag` (
  `id` bigint NOT NULL,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxonomy_tag`
--

INSERT INTO `taxonomy_tag` (`id`, `name`) VALUES
(2, 'Jaringan'),
(1, 'SPBE');

-- --------------------------------------------------------

--
-- Table structure for table `workflow_workflowaction`
--

CREATE TABLE `workflow_workflowaction` (
  `id` bigint NOT NULL,
  `action` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` datetime(6) NOT NULL,
  `actor_id` int NOT NULL,
  `workflow_request_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `workflow_workflowaction`
--

INSERT INTO `workflow_workflowaction` (`id`, `action`, `note`, `created_at`, `actor_id`, `workflow_request_id`) VALUES
(1, 'SUBMIT', 'Item disubmit untuk review', '2026-01-19 18:39:16.338512', 1, 1),
(2, 'REVIEW_RETURN', 'Mohon lengkapi lampiran SOP dan revisi struktur penomoran.', '2026-01-19 18:42:03.889478', 1, 1),
(3, 'SUBMIT', 'Item disubmit untuk review', '2026-01-19 18:42:41.924066', 1, 1),
(4, 'REVIEW_RECOMMEND', 'Sudah sesuai, direkomendasikan publish.', '2026-01-19 18:44:54.931515', 1, 1),
(5, 'APPROVE', '', '2026-01-19 18:46:29.625649', 1, 1),
(6, 'APPROVE', 'test', '2026-01-20 18:24:55.588368', 4, 1),
(7, 'SUBMIT', 'Item disubmit untuk review', '2026-01-22 19:07:57.944622', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `workflow_workflowrequest`
--

CREATE TABLE `workflow_workflowrequest` (
  `id` bigint NOT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `current_reviewer_id` int DEFAULT NULL,
  `knowledge_item_id` bigint NOT NULL,
  `requested_by_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `workflow_workflowrequest`
--

INSERT INTO `workflow_workflowrequest` (`id`, `status`, `created_at`, `updated_at`, `current_reviewer_id`, `knowledge_item_id`, `requested_by_id`) VALUES
(1, 'APPROVED', '2026-01-19 18:39:16.334333', '2026-01-20 18:24:55.566851', 1, 2, 1),
(2, 'PENDING_REVIEW', '2026-01-22 19:07:57.938309', '2026-01-22 19:07:57.938309', NULL, 3, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `knowledge_attachment`
--
ALTER TABLE `knowledge_attachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `knowledge_attachment_uploaded_by_id_1b92645f_fk_auth_user_id` (`uploaded_by_id`),
  ADD KEY `knowledge_attachment_knowledge_item_id_b005c81a_fk_knowledge` (`knowledge_item_id`);

--
-- Indexes for table `knowledge_knowledgeitem`
--
ALTER TABLE `knowledge_knowledgeitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `knowledge_knowledgeitem_author_id_7b23fed4_fk_auth_user_id` (`author_id`),
  ADD KEY `knowledge_knowledgei_category_id_7e911282_fk_taxonomy_` (`category_id`);

--
-- Indexes for table `knowledge_knowledgeitem_tags`
--
ALTER TABLE `knowledge_knowledgeitem_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `knowledge_knowledgeitem__knowledgeitem_id_tag_id_762355a4_uniq` (`knowledgeitem_id`,`tag_id`),
  ADD KEY `knowledge_knowledgeitem_tags_tag_id_34d7e69d_fk_taxonomy_tag_id` (`tag_id`);

--
-- Indexes for table `taxonomy_category`
--
ALTER TABLE `taxonomy_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `taxonomy_category_parent_id_e569c8a8_fk_taxonomy_category_id` (`parent_id`);

--
-- Indexes for table `taxonomy_tag`
--
ALTER TABLE `taxonomy_tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `workflow_workflowaction`
--
ALTER TABLE `workflow_workflowaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workflow_workflowaction_actor_id_6c4f30e1_fk_auth_user_id` (`actor_id`),
  ADD KEY `workflow_workflowact_workflow_request_id_5b59d945_fk_workflow_` (`workflow_request_id`);

--
-- Indexes for table `workflow_workflowrequest`
--
ALTER TABLE `workflow_workflowrequest`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `knowledge_item_id` (`knowledge_item_id`),
  ADD KEY `workflow_workflowreq_current_reviewer_id_6e052df2_fk_auth_user` (`current_reviewer_id`),
  ADD KEY `workflow_workflowreq_requested_by_id_32f49090_fk_auth_user` (`requested_by_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `knowledge_attachment`
--
ALTER TABLE `knowledge_attachment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `knowledge_knowledgeitem`
--
ALTER TABLE `knowledge_knowledgeitem`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `knowledge_knowledgeitem_tags`
--
ALTER TABLE `knowledge_knowledgeitem_tags`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `taxonomy_category`
--
ALTER TABLE `taxonomy_category`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `taxonomy_tag`
--
ALTER TABLE `taxonomy_tag`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `workflow_workflowaction`
--
ALTER TABLE `workflow_workflowaction`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `workflow_workflowrequest`
--
ALTER TABLE `workflow_workflowrequest`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `knowledge_attachment`
--
ALTER TABLE `knowledge_attachment`
  ADD CONSTRAINT `knowledge_attachment_knowledge_item_id_b005c81a_fk_knowledge` FOREIGN KEY (`knowledge_item_id`) REFERENCES `knowledge_knowledgeitem` (`id`),
  ADD CONSTRAINT `knowledge_attachment_uploaded_by_id_1b92645f_fk_auth_user_id` FOREIGN KEY (`uploaded_by_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `knowledge_knowledgeitem`
--
ALTER TABLE `knowledge_knowledgeitem`
  ADD CONSTRAINT `knowledge_knowledgei_category_id_7e911282_fk_taxonomy_` FOREIGN KEY (`category_id`) REFERENCES `taxonomy_category` (`id`),
  ADD CONSTRAINT `knowledge_knowledgeitem_author_id_7b23fed4_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `knowledge_knowledgeitem_tags`
--
ALTER TABLE `knowledge_knowledgeitem_tags`
  ADD CONSTRAINT `knowledge_knowledgei_knowledgeitem_id_ddd73f18_fk_knowledge` FOREIGN KEY (`knowledgeitem_id`) REFERENCES `knowledge_knowledgeitem` (`id`),
  ADD CONSTRAINT `knowledge_knowledgeitem_tags_tag_id_34d7e69d_fk_taxonomy_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `taxonomy_tag` (`id`);

--
-- Constraints for table `taxonomy_category`
--
ALTER TABLE `taxonomy_category`
  ADD CONSTRAINT `taxonomy_category_parent_id_e569c8a8_fk_taxonomy_category_id` FOREIGN KEY (`parent_id`) REFERENCES `taxonomy_category` (`id`);

--
-- Constraints for table `workflow_workflowaction`
--
ALTER TABLE `workflow_workflowaction`
  ADD CONSTRAINT `workflow_workflowact_workflow_request_id_5b59d945_fk_workflow_` FOREIGN KEY (`workflow_request_id`) REFERENCES `workflow_workflowrequest` (`id`),
  ADD CONSTRAINT `workflow_workflowaction_actor_id_6c4f30e1_fk_auth_user_id` FOREIGN KEY (`actor_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `workflow_workflowrequest`
--
ALTER TABLE `workflow_workflowrequest`
  ADD CONSTRAINT `workflow_workflowreq_current_reviewer_id_6e052df2_fk_auth_user` FOREIGN KEY (`current_reviewer_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `workflow_workflowreq_knowledge_item_id_356910f7_fk_knowledge` FOREIGN KEY (`knowledge_item_id`) REFERENCES `knowledge_knowledgeitem` (`id`),
  ADD CONSTRAINT `workflow_workflowreq_requested_by_id_32f49090_fk_auth_user` FOREIGN KEY (`requested_by_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
