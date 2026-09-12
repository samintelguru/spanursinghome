/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.18-MariaDB, for linux-systemd (x86_64)
--
-- Host: localhost    Database: spanursi_eco
-- ------------------------------------------------------
-- Server version	10.11.18-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activations`
--

DROP TABLE IF EXISTS `activations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `activations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `code` varchar(120) NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activations_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activations`
--

LOCK TABLES `activations` WRITE;
/*!40000 ALTER TABLE `activations` DISABLE KEYS */;
INSERT INTO `activations` VALUES
(1,1,'XYw9GdotoAsMDd8Kbs0EzIAaibg3FsXd',1,'2024-02-24 01:36:32','2024-02-24 01:36:32','2024-02-24 01:36:32'),
(2,2,'WaNKivUChtZLyspqc1hy2Aux9vnKCpmb',1,'2024-02-24 01:36:32','2024-02-24 01:36:32','2024-02-24 01:36:32');
/*!40000 ALTER TABLE `activations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_notifications`
--

DROP TABLE IF EXISTS `admin_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `action_label` varchar(255) DEFAULT NULL,
  `action_url` varchar(255) DEFAULT NULL,
  `description` varchar(400) NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `permission` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_notifications`
--

LOCK TABLES `admin_notifications` WRITE;
/*!40000 ALTER TABLE `admin_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ads`
--

DROP TABLE IF EXISTS `ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `expired_at` datetime DEFAULT NULL,
  `location` varchar(120) DEFAULT NULL,
  `key` varchar(120) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `clicked` bigint(20) NOT NULL DEFAULT 0,
  `order` int(11) DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `open_in_new_tab` tinyint(1) NOT NULL DEFAULT 1,
  `tablet_image` varchar(255) DEFAULT NULL,
  `mobile_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ads_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads`
--

LOCK TABLES `ads` WRITE;
/*!40000 ALTER TABLE `ads` DISABLE KEYS */;
INSERT INTO `ads` VALUES
(2,'Homepage middle 1','2029-02-24 00:00:00','not_set','IZ6WU8KUALYD','61lvsjrnful.png','/products',99,2,'published','2024-02-24 01:37:29','2024-06-06 15:10:33',1,NULL,NULL),
(3,'Homepage middle 2','2029-02-24 00:00:00','not_set','ILSFJVYFGCPZ','whatsapp-image-2022-08-20-at-82016-pm.jpeg','/products',104,3,'published','2024-02-24 01:37:29','2024-06-06 15:08:39',1,NULL,NULL),
(4,'Homepage middle 3','2029-02-24 00:00:00','not_set','ZDOZUZZIU7FT','istockphoto-182226541-612x612.jpg','/products',106,4,'published','2024-02-24 01:37:29','2024-06-06 04:20:33',1,NULL,NULL),
(5,'Products list 1','2029-02-24 00:00:00','not_set','ZDOZUZZIU7FZ','61lvsjrnful.png','/products/beat-headphone',133,5,'published','2024-02-24 01:37:29','2024-06-06 16:48:07',1,NULL,NULL);
/*!40000 ALTER TABLE `ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ads_translations`
--

DROP TABLE IF EXISTS `ads_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ads_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ads_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads_translations`
--

LOCK TABLES `ads_translations` WRITE;
/*!40000 ALTER TABLE `ads_translations` DISABLE KEYS */;
INSERT INTO `ads_translations` VALUES
('en_US',6,'Blood Pressure Machine','istockphoto-182226541-612x612.jpg',NULL),
('en_US',7,'sliders',NULL,NULL),
('en_US',8,'Homeslider','61lvsjrnful.png',NULL),
('en_US',9,'sliders','whatsapp-image-2022-08-20-at-82016-pm.jpeg',NULL);
/*!40000 ALTER TABLE `ads_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_histories`
--

DROP TABLE IF EXISTS `audit_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `module` varchar(60) NOT NULL,
  `request` longtext DEFAULT NULL,
  `action` varchar(120) NOT NULL,
  `user_agent` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `reference_user` bigint(20) unsigned NOT NULL,
  `reference_id` bigint(20) unsigned NOT NULL,
  `reference_name` varchar(255) NOT NULL,
  `type` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audit_histories_user_id_index` (`user_id`),
  KEY `audit_histories_module_index` (`module`)
) ENGINE=InnoDB AUTO_INCREMENT=507 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_histories`
--

LOCK TABLES `audit_histories` WRITE;
/*!40000 ALTER TABLE `audit_histories` DISABLE KEYS */;
INSERT INTO `audit_histories` VALUES
(222,1,'to the system',NULL,'logged in','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.26 Mobile Safari/537.36','185.240.174.34',0,1,'Antonio Mwangi','info','2026-07-15 00:34:42','2026-07-15 00:34:42'),
(223,1,'to the system',NULL,'logged in','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:135.0) Gecko/20100101 Firefox/135.0','66.175.200.23',0,1,'Antonio Mwangi','info','2026-07-16 05:11:50','2026-07-16 05:11:50'),
(224,1,'to the system',NULL,'logged in','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36','61.85.7.252',0,1,'Antonio Mwangi','info','2026-07-25 23:47:38','2026-07-25 23:47:38'),
(225,1,'to the system',NULL,'logged in','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',0,1,'Antonio Mwangi','info','2026-08-03 15:17:28','2026-08-03 15:17:28'),
(226,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,230,'Province Piece Glass Drinking Glass','danger','2026-08-03 15:23:51','2026-08-03 15:23:51'),
(227,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,231,'Province Piece Glass Drinking Glass','danger','2026-08-03 15:23:51','2026-08-03 15:23:51'),
(228,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,232,'Province Piece Glass Drinking Glass','danger','2026-08-03 15:23:51','2026-08-03 15:23:51'),
(229,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,65,'Province Piece Glass Drinking Glass','danger','2026-08-03 15:23:51','2026-08-03 15:23:51'),
(230,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,212,'Iceland Soft Scoop Vanilla','danger','2026-08-03 15:24:00','2026-08-03 15:24:00'),
(231,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,213,'Iceland Soft Scoop Vanilla','danger','2026-08-03 15:24:00','2026-08-03 15:24:00'),
(232,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,214,'Iceland Soft Scoop Vanilla','danger','2026-08-03 15:24:00','2026-08-03 15:24:00'),
(233,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,59,'Iceland Soft Scoop Vanilla','danger','2026-08-03 15:24:00','2026-08-03 15:24:00'),
(234,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,215,'Iceland Spaghetti Bolognese (Digital)','danger','2026-08-03 15:24:04','2026-08-03 15:24:04'),
(235,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,216,'Iceland Spaghetti Bolognese (Digital)','danger','2026-08-03 15:24:05','2026-08-03 15:24:05'),
(236,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,217,'Iceland Spaghetti Bolognese (Digital)','danger','2026-08-03 15:24:05','2026-08-03 15:24:05'),
(237,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,218,'Iceland Spaghetti Bolognese (Digital)','danger','2026-08-03 15:24:05','2026-08-03 15:24:05'),
(238,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,60,'Iceland Spaghetti Bolognese (Digital)','danger','2026-08-03 15:24:05','2026-08-03 15:24:05'),
(239,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,219,'Kellogg’s Coco Pops Cereal','danger','2026-08-03 15:24:10','2026-08-03 15:24:10'),
(240,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,61,'Kellogg’s Coco Pops Cereal','danger','2026-08-03 15:24:10','2026-08-03 15:24:10'),
(241,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,207,'Iceland 6 Hot Cross Buns','danger','2026-08-03 15:24:15','2026-08-03 15:24:15'),
(242,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,208,'Iceland 6 Hot Cross Buns','danger','2026-08-03 15:24:15','2026-08-03 15:24:15'),
(243,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,209,'Iceland 6 Hot Cross Buns','danger','2026-08-03 15:24:15','2026-08-03 15:24:15'),
(244,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,57,'Iceland 6 Hot Cross Buns','danger','2026-08-03 15:24:15','2026-08-03 15:24:15'),
(245,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,220,'Kit Kat Chunky Milk Chocolate','danger','2026-08-03 15:24:19','2026-08-03 15:24:19'),
(246,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,221,'Kit Kat Chunky Milk Chocolate','danger','2026-08-03 15:24:20','2026-08-03 15:24:20'),
(247,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,222,'Kit Kat Chunky Milk Chocolate','danger','2026-08-03 15:24:20','2026-08-03 15:24:20'),
(248,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,223,'Kit Kat Chunky Milk Chocolate','danger','2026-08-03 15:24:20','2026-08-03 15:24:20'),
(249,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,62,'Kit Kat Chunky Milk Chocolate','danger','2026-08-03 15:24:20','2026-08-03 15:24:20'),
(250,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,205,'Ice Beck’s Beer 350ml x 24 Pieces (Digital)','danger','2026-08-03 15:24:24','2026-08-03 15:24:24'),
(251,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,206,'Ice Beck’s Beer 350ml x 24 Pieces (Digital)','danger','2026-08-03 15:24:24','2026-08-03 15:24:24'),
(252,1,'product','{\"_method\":\"delete\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,56,'Ice Beck’s Beer 350ml x 24 Pieces (Digital)','danger','2026-08-03 15:24:24','2026-08-03 15:24:24'),
(253,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,198,'Corn, Yellow Sweet','danger','2026-08-03 15:24:48','2026-08-03 15:24:48'),
(254,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,199,'Corn, Yellow Sweet','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(255,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,53,'Corn, Yellow Sweet','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(256,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,200,'Hobnobs The Nobbly Biscuit','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(257,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,201,'Hobnobs The Nobbly Biscuit','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(258,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,202,'Hobnobs The Nobbly Biscuit','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(259,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,54,'Hobnobs The Nobbly Biscuit','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(260,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,203,'Honest Organic Still Lemonade','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(261,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,204,'Honest Organic Still Lemonade','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(262,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,55,'Honest Organic Still Lemonade','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(263,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,210,'Iceland Luxury 4 Panini Rolls','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(264,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,211,'Iceland Luxury 4 Panini Rolls','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(265,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,58,'Iceland Luxury 4 Panini Rolls','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(266,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,224,'Large Green Bell Pepper','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(267,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,225,'Large Green Bell Pepper','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(268,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,226,'Large Green Bell Pepper','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(269,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,227,'Large Green Bell Pepper','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(270,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,63,'Large Green Bell Pepper','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(271,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,228,'Pice 94w Beasley Journal (Digital)','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(272,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,229,'Pice 94w Beasley Journal (Digital)','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(273,1,'product','{\"ids\":[\"64\",\"63\",\"58\",\"55\",\"54\",\"53\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,64,'Pice 94w Beasley Journal (Digital)','danger','2026-08-03 15:24:49','2026-08-03 15:24:49'),
(274,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,66,'Dual Camera 20MP','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(275,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,67,'Dual Camera 20MP','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(276,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,68,'Dual Camera 20MP','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(277,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,69,'Dual Camera 20MP','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(278,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,1,'Dual Camera 20MP','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(279,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,70,'Smart Watches','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(280,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,71,'Smart Watches','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(281,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,72,'Smart Watches','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(282,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,2,'Smart Watches','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(283,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,73,'Beat Headphone','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(284,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,74,'Beat Headphone','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(285,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,3,'Beat Headphone','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(286,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,75,'Red & Black Headphone (Digital)','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(287,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,76,'Red & Black Headphone (Digital)','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(288,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,77,'Red & Black Headphone (Digital)','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(289,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,4,'Red & Black Headphone (Digital)','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(290,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,78,'Smart Watch External','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(291,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,79,'Smart Watch External','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(292,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,80,'Smart Watch External','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(293,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,5,'Smart Watch External','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(294,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,81,'Nikon HD camera','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(295,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,6,'Nikon HD camera','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(296,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,82,'Audio Equipment','danger','2026-08-03 15:25:52','2026-08-03 15:25:52'),
(297,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,83,'Audio Equipment','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(298,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,7,'Audio Equipment','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(299,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,84,'Smart Televisions (Digital)','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(300,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,85,'Smart Televisions (Digital)','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(301,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,86,'Smart Televisions (Digital)','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(302,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,87,'Smart Televisions (Digital)','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(303,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,8,'Smart Televisions (Digital)','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(304,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,88,'Samsung Smart Phone','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(305,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,89,'Samsung Smart Phone','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(306,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,9,'Samsung Smart Phone','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(307,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,90,'Herschel Leather Duffle Bag In Brown Color','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(308,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,91,'Herschel Leather Duffle Bag In Brown Color','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(309,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,92,'Herschel Leather Duffle Bag In Brown Color','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(310,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,10,'Herschel Leather Duffle Bag In Brown Color','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(311,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,93,'Xbox One Wireless Controller Black Color','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(312,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,94,'Xbox One Wireless Controller Black Color','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(313,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,95,'Xbox One Wireless Controller Black Color','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(314,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,96,'Xbox One Wireless Controller Black Color','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(315,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,11,'Xbox One Wireless Controller Black Color','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(316,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,97,'EPSION Plaster Printer (Digital)','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(317,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,98,'EPSION Plaster Printer (Digital)','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(318,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,12,'EPSION Plaster Printer (Digital)','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(319,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,99,'Sound Intone I65 Earphone White Version','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(320,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,100,'Sound Intone I65 Earphone White Version','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(321,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,13,'Sound Intone I65 Earphone White Version','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(322,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,101,'B&O Play Mini Bluetooth Speaker','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(323,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,102,'B&O Play Mini Bluetooth Speaker','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(324,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,14,'B&O Play Mini Bluetooth Speaker','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(325,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,103,'Apple MacBook Air Retina 13.3-Inch Laptop','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(326,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,104,'Apple MacBook Air Retina 13.3-Inch Laptop','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(327,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,105,'Apple MacBook Air Retina 13.3-Inch Laptop','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(328,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,106,'Apple MacBook Air Retina 13.3-Inch Laptop','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(329,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,15,'Apple MacBook Air Retina 13.3-Inch Laptop','danger','2026-08-03 15:25:53','2026-08-03 15:25:53'),
(330,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,107,'Apple MacBook Air Retina 12-Inch Laptop (Digital)','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(331,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,108,'Apple MacBook Air Retina 12-Inch Laptop (Digital)','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(332,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,16,'Apple MacBook Air Retina 12-Inch Laptop (Digital)','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(333,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,109,'Samsung Gear VR Virtual Reality Headset','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(334,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,17,'Samsung Gear VR Virtual Reality Headset','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(335,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,110,'Aveeno Moisturizing Body Shower 450ml','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(336,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,111,'Aveeno Moisturizing Body Shower 450ml','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(337,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,112,'Aveeno Moisturizing Body Shower 450ml','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(338,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,113,'Aveeno Moisturizing Body Shower 450ml','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(339,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,18,'Aveeno Moisturizing Body Shower 450ml','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(340,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,114,'NYX Beauty Couton Pallete Makeup 12','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(341,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,115,'NYX Beauty Couton Pallete Makeup 12','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(342,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,116,'NYX Beauty Couton Pallete Makeup 12','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(343,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,19,'NYX Beauty Couton Pallete Makeup 12','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(344,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,117,'NYX Beauty Couton Pallete Makeup 12 (Digital)','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(345,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,20,'NYX Beauty Couton Pallete Makeup 12 (Digital)','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(346,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,118,'MVMTH Classical Leather Watch In Black','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(347,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,21,'MVMTH Classical Leather Watch In Black','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(348,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,119,'Baxter Care Hair Kit For Bearded Mens','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(349,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,120,'Baxter Care Hair Kit For Bearded Mens','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(350,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,22,'Baxter Care Hair Kit For Bearded Mens','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(351,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,121,'Ciate Palemore Lipstick Bold Red Color','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(352,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,122,'Ciate Palemore Lipstick Bold Red Color','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(353,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,123,'Ciate Palemore Lipstick Bold Red Color','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(354,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,124,'Ciate Palemore Lipstick Bold Red Color','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(355,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,23,'Ciate Palemore Lipstick Bold Red Color','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(356,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,125,'Vimto Squash Remix Apple 1.5 Litres (Digital)','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(357,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,126,'Vimto Squash Remix Apple 1.5 Litres (Digital)','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(358,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,24,'Vimto Squash Remix Apple 1.5 Litres (Digital)','danger','2026-08-03 15:25:54','2026-08-03 15:25:54'),
(359,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,127,'Crock Pot Slow Cooker','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(360,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,128,'Crock Pot Slow Cooker','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(361,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,129,'Crock Pot Slow Cooker','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(362,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,130,'Crock Pot Slow Cooker','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(363,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,25,'Crock Pot Slow Cooker','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(364,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,131,'Taylors of Harrogate Yorkshire Coffee','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(365,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,132,'Taylors of Harrogate Yorkshire Coffee','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(366,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,133,'Taylors of Harrogate Yorkshire Coffee','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(367,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,134,'Taylors of Harrogate Yorkshire Coffee','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(368,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,26,'Taylors of Harrogate Yorkshire Coffee','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(369,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,135,'Soft Mochi & Galeto Ice Cream','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(370,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,136,'Soft Mochi & Galeto Ice Cream','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(371,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,137,'Soft Mochi & Galeto Ice Cream','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(372,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,27,'Soft Mochi & Galeto Ice Cream','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(373,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,138,'Naked Noodle Egg Noodles Singapore (Digital)','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(374,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,139,'Naked Noodle Egg Noodles Singapore (Digital)','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(375,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,140,'Naked Noodle Egg Noodles Singapore (Digital)','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(376,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,141,'Naked Noodle Egg Noodles Singapore (Digital)','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(377,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,28,'Naked Noodle Egg Noodles Singapore (Digital)','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(378,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,142,'Saute Pan Silver','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(379,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,143,'Saute Pan Silver','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(380,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,144,'Saute Pan Silver','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(381,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,29,'Saute Pan Silver','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(382,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,145,'Bar S – Classic Bun Length Franks','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(383,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,146,'Bar S – Classic Bun Length Franks','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(384,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,147,'Bar S – Classic Bun Length Franks','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(385,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,30,'Bar S – Classic Bun Length Franks','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(386,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,148,'Broccoli Crowns','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(387,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,149,'Broccoli Crowns','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(388,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,150,'Broccoli Crowns','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(389,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,31,'Broccoli Crowns','danger','2026-08-03 15:25:55','2026-08-03 15:25:55'),
(390,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,151,'Slimming World Vegan Mac Greens (Digital)','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(391,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,32,'Slimming World Vegan Mac Greens (Digital)','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(392,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,152,'Häagen-Dazs Salted Caramel','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(393,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,153,'Häagen-Dazs Salted Caramel','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(394,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,33,'Häagen-Dazs Salted Caramel','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(395,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,154,'Iceland 3 Solo Exotic Burst','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(396,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,155,'Iceland 3 Solo Exotic Burst','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(397,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,156,'Iceland 3 Solo Exotic Burst','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(398,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,157,'Iceland 3 Solo Exotic Burst','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(399,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,34,'Iceland 3 Solo Exotic Burst','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(400,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,158,'Extreme Budweiser Light Can','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(401,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,35,'Extreme Budweiser Light Can','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(402,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,159,'Iceland Macaroni Cheese Traybake (Digital)','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(403,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,160,'Iceland Macaroni Cheese Traybake (Digital)','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(404,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,161,'Iceland Macaroni Cheese Traybake (Digital)','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(405,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,162,'Iceland Macaroni Cheese Traybake (Digital)','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(406,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,36,'Iceland Macaroni Cheese Traybake (Digital)','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(407,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,163,'Dolmio Bolognese Pasta Sauce','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(408,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,37,'Dolmio Bolognese Pasta Sauce','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(409,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,164,'Sitema BakeIT Plastic Box','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(410,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,165,'Sitema BakeIT Plastic Box','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(411,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,38,'Sitema BakeIT Plastic Box','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(412,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,166,'Wayfair Basics Dinner Plate Storage','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(413,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,39,'Wayfair Basics Dinner Plate Storage','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(414,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,167,'Miko The Panda Water Bottle (Digital)','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(415,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,168,'Miko The Panda Water Bottle (Digital)','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(416,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,169,'Miko The Panda Water Bottle (Digital)','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(417,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,40,'Miko The Panda Water Bottle (Digital)','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(418,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,170,'Sesame Seed Bread','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(419,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,41,'Sesame Seed Bread','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(420,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,171,'Morrisons The Best Beef','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(421,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,172,'Morrisons The Best Beef','danger','2026-08-03 15:25:56','2026-08-03 15:25:56'),
(422,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,42,'Morrisons The Best Beef','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(423,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,173,'Avocado, Hass Large','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(424,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,174,'Avocado, Hass Large','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(425,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,175,'Avocado, Hass Large','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(426,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,43,'Avocado, Hass Large','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(427,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,176,'Italia Beef Lasagne (Digital)','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(428,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,177,'Italia Beef Lasagne (Digital)','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(429,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,44,'Italia Beef Lasagne (Digital)','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(430,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,178,'Maxwell House Classic Roast Mocha','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(431,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,179,'Maxwell House Classic Roast Mocha','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(432,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,180,'Maxwell House Classic Roast Mocha','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(433,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,45,'Maxwell House Classic Roast Mocha','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(434,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,181,'Bottled Pure Water 500ml','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(435,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,46,'Bottled Pure Water 500ml','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(436,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,182,'Famart Farmhouse Soft White','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(437,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,183,'Famart Farmhouse Soft White','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(438,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,184,'Famart Farmhouse Soft White','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(439,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,47,'Famart Farmhouse Soft White','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(440,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,185,'Coca-Cola Original Taste (Digital)','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(441,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,186,'Coca-Cola Original Taste (Digital)','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(442,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,48,'Coca-Cola Original Taste (Digital)','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(443,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,187,'Casillero Diablo Cabernet Sauvignon','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(444,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,188,'Casillero Diablo Cabernet Sauvignon','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(445,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,189,'Casillero Diablo Cabernet Sauvignon','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(446,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,49,'Casillero Diablo Cabernet Sauvignon','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(447,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,190,'Arla Organic Free Range Milk','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(448,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,191,'Arla Organic Free Range Milk','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(449,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,192,'Arla Organic Free Range Milk','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(450,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,193,'Arla Organic Free Range Milk','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(451,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,50,'Arla Organic Free Range Milk','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(452,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,194,'Aptamil Follow On Baby Milk','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(453,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,195,'Aptamil Follow On Baby Milk','danger','2026-08-03 15:25:57','2026-08-03 15:25:57'),
(454,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,51,'Aptamil Follow On Baby Milk','danger','2026-08-03 15:25:58','2026-08-03 15:25:58'),
(455,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,196,'Cuisinart Chef’S Classic Hard-Anodized (Digital)','danger','2026-08-03 15:25:58','2026-08-03 15:25:58'),
(456,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,197,'Cuisinart Chef’S Classic Hard-Anodized (Digital)','danger','2026-08-03 15:25:58','2026-08-03 15:25:58'),
(457,1,'product','{\"ids\":[\"52\",\"51\",\"50\",\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\",\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\ProductTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,52,'Cuisinart Chef’S Classic Hard-Anodized (Digital)','danger','2026-08-03 15:25:58','2026-08-03 15:25:58'),
(458,1,'order','{\"ids\":[\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,40,'ID: 40','danger','2026-08-03 15:29:48','2026-08-03 15:29:48'),
(459,1,'order','{\"ids\":[\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,41,'ID: 41','danger','2026-08-03 15:29:48','2026-08-03 15:29:48'),
(460,1,'order','{\"ids\":[\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,42,'ID: 42','danger','2026-08-03 15:29:48','2026-08-03 15:29:48'),
(461,1,'order','{\"ids\":[\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,43,'ID: 43','danger','2026-08-03 15:29:48','2026-08-03 15:29:48'),
(462,1,'order','{\"ids\":[\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,44,'ID: 44','danger','2026-08-03 15:29:48','2026-08-03 15:29:48'),
(463,1,'order','{\"ids\":[\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,45,'ID: 45','danger','2026-08-03 15:29:48','2026-08-03 15:29:48'),
(464,1,'order','{\"ids\":[\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,46,'ID: 46','danger','2026-08-03 15:29:48','2026-08-03 15:29:48'),
(465,1,'order','{\"ids\":[\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,47,'ID: 47','danger','2026-08-03 15:29:48','2026-08-03 15:29:48'),
(466,1,'order','{\"ids\":[\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,48,'ID: 48','danger','2026-08-03 15:29:48','2026-08-03 15:29:48'),
(467,1,'order','{\"ids\":[\"49\",\"48\",\"47\",\"46\",\"45\",\"44\",\"43\",\"42\",\"41\",\"40\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,49,'ID: 49','danger','2026-08-03 15:29:48','2026-08-03 15:29:48'),
(468,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,1,'ID: 1','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(469,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,2,'ID: 2','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(470,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,3,'ID: 3','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(471,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,4,'ID: 4','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(472,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,5,'ID: 5','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(473,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,6,'ID: 6','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(474,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,7,'ID: 7','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(475,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,8,'ID: 8','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(476,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,9,'ID: 9','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(477,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,10,'ID: 10','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(478,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,11,'ID: 11','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(479,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,12,'ID: 12','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(480,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,13,'ID: 13','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(481,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,14,'ID: 14','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(482,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,15,'ID: 15','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(483,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,16,'ID: 16','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(484,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,17,'ID: 17','danger','2026-08-03 15:30:04','2026-08-03 15:30:04'),
(485,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,18,'ID: 18','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(486,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,19,'ID: 19','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(487,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,20,'ID: 20','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(488,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,21,'ID: 21','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(489,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,22,'ID: 22','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(490,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,23,'ID: 23','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(491,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,24,'ID: 24','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(492,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,25,'ID: 25','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(493,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,26,'ID: 26','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(494,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,27,'ID: 27','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(495,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,28,'ID: 28','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(496,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,29,'ID: 29','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(497,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,30,'ID: 30','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(498,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,31,'ID: 31','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(499,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,32,'ID: 32','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(500,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,33,'ID: 33','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(501,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,34,'ID: 34','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(502,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,35,'ID: 35','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(503,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,36,'ID: 36','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(504,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,37,'ID: 37','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(505,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,38,'ID: 38','danger','2026-08-03 15:30:05','2026-08-03 15:30:05'),
(506,1,'order','{\"ids\":[\"39\",\"38\",\"37\",\"36\",\"35\",\"34\",\"33\",\"32\",\"31\",\"30\",\"29\",\"28\",\"27\",\"26\",\"25\",\"24\",\"23\",\"22\",\"21\",\"20\",\"19\",\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\",\"3\",\"2\",\"1\"],\"bulk_action\":1,\"bulk_action_table\":\"Botble\\\\Ecommerce\\\\Tables\\\\OrderTable\",\"bulk_action_target\":\"Botble\\\\Table\\\\BulkActions\\\\DeleteBulkAction\"}','deleted','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36','102.220.12.94',1,39,'ID: 39','danger','2026-08-03 15:30:05','2026-08-03 15:30:05');
/*!40000 ALTER TABLE `audit_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `description` varchar(400) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `author_id` bigint(20) unsigned DEFAULT NULL,
  `author_type` varchar(255) NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  `icon` varchar(60) DEFAULT NULL,
  `order` tinyint(4) NOT NULL DEFAULT 0,
  `is_featured` tinyint(4) NOT NULL DEFAULT 0,
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_parent_id_index` (`parent_id`),
  KEY `categories_status_index` (`status`),
  KEY `categories_created_at_index` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES
(1,'Ecommerce',0,'Qui illum veritatis delectus eaque veniam et. Provident laudantium ea ut eaque eius rerum sequi. Qui provident aut esse repellendus.','published',2,'Botble\\ACL\\Models\\User',NULL,0,0,1,'2024-02-24 01:37:28','2024-06-06 15:40:30'),
(2,'Fashion',0,'Libero in libero modi impedit non. Nihil exercitationem voluptas ex. Est magnam impedit laboriosam consequuntur delectus voluptatem quia.','published',2,'Botble\\ACL\\Models\\User',NULL,1,1,0,'2024-02-24 01:37:28','2024-06-06 15:40:30'),
(3,'Electronic',0,'Sequi similique tenetur alias. A officiis aliquam sed sunt consequatur omnis voluptas. Possimus qui eum est maiores.','published',2,'Botble\\ACL\\Models\\User',NULL,2,1,0,'2024-02-24 01:37:28','2024-06-06 15:40:30'),
(4,'Commercial',0,'Et rerum exercitationem veniam aut et voluptas. Quo labore est consequatur temporibus mollitia harum ut.','published',2,'Botble\\ACL\\Models\\User',NULL,3,1,0,'2024-02-24 01:37:28','2024-06-06 15:40:30');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_translations`
--

DROP TABLE IF EXISTS `categories_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories_translations` (
  `lang_code` varchar(20) NOT NULL,
  `categories_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`categories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_translations`
--

LOCK TABLES `categories_translations` WRITE;
/*!40000 ALTER TABLE `categories_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `state_id` bigint(20) unsigned DEFAULT NULL,
  `country_id` bigint(20) unsigned DEFAULT NULL,
  `record_id` varchar(40) DEFAULT NULL,
  `order` tinyint(4) NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cities_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities_translations`
--

DROP TABLE IF EXISTS `cities_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities_translations` (
  `lang_code` varchar(20) NOT NULL,
  `cities_id` bigint(20) unsigned NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  `slug` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`cities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities_translations`
--

LOCK TABLES `cities_translations` WRITE;
/*!40000 ALTER TABLE `cities_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_replies`
--

DROP TABLE IF EXISTS `contact_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_replies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `contact_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_replies`
--

LOCK TABLES `contact_replies` WRITE;
/*!40000 ALTER TABLE `contact_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `phone` varchar(60) DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `subject` varchar(120) DEFAULT NULL,
  `content` longtext NOT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'unread',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES
(1,'Lavina Skiles','anderson.alexzander@example.com','463.990.2782','57469 Ortiz Loop Suite 270\nWest Willland, WY 77070-4676','Est et aut asperiores voluptates et quae.','Et autem quasi commodi dolorem cupiditate quia. Ipsum officiis excepturi velit quaerat. Incidunt accusantium aut fugit dolorem dolores reiciendis dicta dolor. Autem in excepturi quos sint. Natus fuga occaecati necessitatibus voluptates provident quis fugit. Doloremque accusamus est libero temporibus aut debitis eveniet. Est excepturi optio velit nostrum itaque consectetur. Ut similique quam in.','unread','2024-02-24 01:37:27','2024-02-24 01:37:27'),
(2,'Russel Wehner','nitzsche.travis@example.com','+1.386.762.1514','901 Rowan Island Suite 209\nNorth Haileefort, MO 12639','Est laudantium aspernatur quia totam sit natus.','Doloribus nobis ratione cupiditate eum quas ut. Ipsum et libero numquam optio et doloremque. Aperiam consectetur optio dolorem et ipsam at tempore. Ipsum dolores qui non sunt pariatur et voluptas. Impedit recusandae incidunt alias consequatur recusandae non mollitia. Error eum ut nulla iste omnis et. Illo quia et suscipit accusamus omnis velit. At fuga quasi voluptatibus totam eos nostrum id. Modi ab in natus laudantium deleniti nulla. Eveniet autem esse qui quae.','read','2024-02-24 01:37:27','2024-02-24 01:37:27'),
(3,'Beaulah Reichel','giles.stoltenberg@example.com','+1-239-764-5501','4541 Kshlerin Ville\nSouth Vanbury, IA 33578-5542','Et perspiciatis nesciunt vel cupiditate.','Totam et porro quia rerum. Corporis iure sint qui molestiae aut. Soluta nobis quo veritatis natus saepe et blanditiis. Consequatur sunt occaecati similique et. Veniam eos ea nesciunt qui error dolore. Dolores deserunt iusto natus ut labore. Aut animi et sit quas ex quibusdam repudiandae. Rerum tempora nesciunt ad expedita id. Voluptas ut voluptatem sed voluptatum et dolores. Totam autem molestiae sapiente praesentium atque. Corrupti eaque unde non eos. Architecto enim officiis quibusdam quas.','read','2024-02-24 01:37:27','2024-02-24 01:37:27'),
(4,'Judge Erdman','ihudson@example.com','541-772-1733','92539 Brannon Ferry\nLake Chanelle, AR 60349','Ut earum sit velit dolorem sunt sequi quia.','Et vel ut ut quae animi. Fuga eveniet dignissimos dolorem ea quam non. Labore quia temporibus corrupti ipsa hic. Nostrum nulla inventore voluptas ipsa nesciunt ut. Ab expedita minima et. Et enim aut maxime expedita. Minima consequatur voluptatem eaque officia enim vel. Officia voluptatibus occaecati perferendis molestiae. Nihil in accusantium autem ducimus consequuntur cupiditate.','unread','2024-02-24 01:37:27','2024-02-24 01:37:27'),
(5,'Ms. Florida Will DDS','maxie.dicki@example.net','(812) 315-8381','659 Cyrus Ports\nPort Jaybury, NV 56208','Sit qui ex sed.','Tenetur ut distinctio excepturi voluptatem. Aut nesciunt est quia nobis consequuntur. Provident architecto consequatur et. Rerum quaerat voluptatem ut harum magnam. Voluptates sed ex quae est cum consequuntur et. Numquam laboriosam reprehenderit quasi voluptas. Veritatis qui quis quae illum ea enim commodi. Adipisci autem maxime nemo explicabo vero. Eveniet reiciendis autem ut eaque. Laboriosam soluta similique quia eligendi rem consequatur deleniti. Natus nisi pariatur mollitia quia.','read','2024-02-24 01:37:27','2024-02-24 01:37:27'),
(6,'Miss Cecile Smith','gillian22@example.net','727.462.8693','634 Helga Flat\nJoyceton, CT 09988-8814','Alias tenetur placeat autem fugiat enim saepe.','Sed voluptatem tenetur laborum consequatur. Ducimus blanditiis molestiae consequatur temporibus sit laborum. Repellendus at culpa id accusantium reiciendis eius et earum. Magni et quos porro iusto officiis cumque ea numquam. Dignissimos commodi fugiat est optio. Vel eos harum nobis corrupti. Est enim et natus rerum totam. Autem nostrum similique odit pariatur. Et quidem aut eaque aperiam.','unread','2024-02-24 01:37:27','2024-02-24 01:37:27'),
(7,'Mr. Sid Metz','ceasar03@example.com','+1.484.789.4698','5382 Botsford Street\nJillianmouth, UT 80908-0534','Dolorem quod repellat aut est.','Sit modi quaerat asperiores quidem ut vitae. Reiciendis aut enim laborum. Non magni necessitatibus et tempora assumenda est aut. Eligendi repudiandae vel rem cum at qui. Id molestiae rerum magni adipisci. Fugiat asperiores error consequatur accusamus sunt error aut. Occaecati et itaque numquam quo natus rerum. Dolores excepturi sit totam quia laborum. Sequi deserunt quod vitae similique dolorum.','read','2024-02-24 01:37:27','2024-02-24 01:37:27'),
(8,'Britney Lemke DVM','wolff.ricky@example.com','(212) 532-0123','3838 Strosin Mount\nReecehaven, MO 55174-8983','Dolores est pariatur incidunt magni labore autem.','Ut magnam non distinctio quae eaque. Quia numquam veritatis rerum pariatur deserunt. Ea facilis rem et possimus molestiae quo. Enim adipisci sint necessitatibus iure et mollitia. Soluta soluta qui pariatur voluptates totam. Sit et sunt error molestiae quo error doloribus aliquam. Occaecati veniam ducimus est exercitationem sunt officiis voluptatem. Porro est eius doloribus praesentium nostrum provident. Nobis ea consequatur rem eveniet. Et aliquam quam est commodi dolor enim molestias magnam.','read','2024-02-24 01:37:27','2024-02-24 01:37:27'),
(9,'Cydney Kshlerin III','dkihn@example.org','+1-754-250-1995','772 Wyman Roads Suite 242\nLake Baileechester, NV 53637','Et sit pariatur aut vitae quia hic magni.','Tenetur possimus cupiditate asperiores facilis deleniti nihil. Nesciunt reprehenderit nisi molestiae voluptates. Sit quaerat enim quam sed in. Saepe vitae aut perspiciatis numquam. Accusamus dignissimos ipsam doloribus et consequatur. Incidunt occaecati quisquam non soluta non eligendi fuga. Veniam ab dignissimos et ea quisquam. Debitis numquam nesciunt omnis. Minus praesentium voluptate alias eos quia.','read','2024-02-24 01:37:27','2024-02-24 01:37:27'),
(10,'Eryn Kutch','delta.walter@example.org','+1 (785) 665-2651','5942 Cartwright Estate Suite 882\nWest Arnoldtown, RI 73251-3433','Doloribus quidem itaque alias.','Est voluptas architecto iste nemo. Iusto quis ut et. Illum dolores tempore rerum velit et qui doloribus. Eum laborum itaque perferendis incidunt voluptates voluptates illo. Esse neque omnis libero consequatur accusantium dolor. Architecto ea aut sunt tempora. Veritatis aliquam dignissimos dicta maiores. Saepe eius aperiam possimus iure mollitia. Autem dolor eum qui enim doloribus ex ut. Molestias fuga debitis quidem cum et delectus non molestiae. Sint ut laboriosam pariatur voluptate.','read','2024-02-24 01:37:27','2024-02-24 01:37:27'),
(11,'Zenaida','info@camp.medicopostura.com','44841074',NULL,'Home','Hi there \n\nLooking to improve your posture and live a healthier life? Our Medico Postura™ Body Posture Corrector is here to help!\n\nExperience instant posture improvement with Medico Postura™. This easy-to-use device can be worn anywhere, anytime – at home, work, or even while you sleep.\n\nMade from lightweight, breathable fabric, it ensures comfort all day long.\n\nGrab it today at a fantastic 60% OFF: https://medicopostura.com\n\nPlus, enjoy FREE shipping for today only!\n\nDon\'t miss out on this amazing deal. Get yours now and start transforming your posture!\n\nThanks and Best Regards, \n\nZenaida','unread','2025-01-23 02:50:40','2025-01-23 02:50:40'),
(12,'Jonah','info@jonah.caredogbest.com','890630962',NULL,'Jonah Whitta','Morning \n\nI wanted to reach out and let you know about our new dog harness. It\'s really easy to put on and take off - in just 2 seconds - and it\'s personalized for each dog. \nPlus, we offer a lifetime warranty so you can be sure your pet is always safe and stylish.\n\nWe\'ve had a lot of success with it so far and I think your dog would love it. \n\nGet yours today with 50% OFF: https://caredogbest.com\n\nFREE Shipping - TODAY ONLY! \n\nCheers, \n\nJonah','unread','2025-02-05 14:39:26','2025-02-05 14:39:26'),
(13,'Charla','info@maynard.bangeshop.com','623188962',NULL,'Charla Maynard','Hey, \n\nI hope you\'re doing well. I wanted to let you know about our new BANGE backpacks and sling bags that just released.\n\nThe bags are waterproof and anti-theft, and have a built-in USB cable that can recharge your phone while you\'re on the go.\n\nBoth bags are made of durable and high-quality materials, and are perfect for everyday use or travel.\n\nOrder yours now at 50% OFF with FREE Shipping: http://bangeshop.com\n\nThe Best,\n\nCharla','unread','2025-02-10 12:35:35','2025-02-10 12:35:35');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `nationality` varchar(120) DEFAULT NULL,
  `order` tinyint(4) NOT NULL DEFAULT 0,
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries_translations`
--

DROP TABLE IF EXISTS `countries_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries_translations` (
  `lang_code` varchar(20) NOT NULL,
  `countries_id` bigint(20) unsigned NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  `nationality` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`countries_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries_translations`
--

LOCK TABLES `countries_translations` WRITE;
/*!40000 ALTER TABLE `countries_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `countries_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_widget_settings`
--

DROP TABLE IF EXISTS `dashboard_widget_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_widget_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `settings` text DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `widget_id` bigint(20) unsigned NOT NULL,
  `order` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_widget_settings_user_id_index` (`user_id`),
  KEY `dashboard_widget_settings_widget_id_index` (`widget_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_widget_settings`
--

LOCK TABLES `dashboard_widget_settings` WRITE;
/*!40000 ALTER TABLE `dashboard_widget_settings` DISABLE KEYS */;
INSERT INTO `dashboard_widget_settings` VALUES
(1,NULL,1,1,0,1,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(2,NULL,1,2,0,1,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(3,NULL,1,3,0,1,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(4,NULL,1,4,0,1,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(5,NULL,1,5,104,0,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(6,NULL,1,6,105,0,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(7,NULL,1,7,106,0,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(8,NULL,1,8,107,0,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(9,NULL,1,9,0,1,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(10,NULL,1,10,0,1,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(11,NULL,1,11,0,1,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(12,NULL,1,12,0,1,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(13,NULL,1,13,0,1,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(14,NULL,1,14,0,1,'2024-05-29 04:21:37','2024-05-29 04:21:37'),
(15,NULL,1,15,0,1,'2024-05-29 04:21:37','2024-05-29 04:21:37');
/*!40000 ALTER TABLE `dashboard_widget_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_widgets`
--

DROP TABLE IF EXISTS `dashboard_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_widgets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_widgets`
--

LOCK TABLES `dashboard_widgets` WRITE;
/*!40000 ALTER TABLE `dashboard_widgets` DISABLE KEYS */;
INSERT INTO `dashboard_widgets` VALUES
(1,'widget_total_1','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(2,'widget_total_2','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(3,'widget_total_3','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(4,'widget_total_4','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(5,'widget_total_themes','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(6,'widget_total_users','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(7,'widget_total_plugins','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(8,'widget_total_pages','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(9,'widget_analytics_general','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(10,'widget_analytics_page','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(11,'widget_analytics_browser','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(12,'widget_analytics_referrer','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(13,'widget_posts_recent','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(14,'widget_audit_logs','2024-05-15 13:46:04','2024-05-15 13:46:04'),
(15,'widget_ecommerce_report_general','2024-05-15 13:46:04','2024-05-15 13:46:04');
/*!40000 ALTER TABLE `dashboard_widgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_brands`
--

DROP TABLE IF EXISTS `ec_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_brands` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `order` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_featured` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_brands`
--

LOCK TABLES `ec_brands` WRITE;
/*!40000 ALTER TABLE `ec_brands` DISABLE KEYS */;
INSERT INTO `ec_brands` VALUES
(1,'FoodPound','New Snacks Release',NULL,'brands/1.png','published',0,1,'2024-02-24 01:36:33','2024-02-24 01:36:33'),
(2,'iTea JSC','Happy Tea 100% Organic. From $29.9',NULL,'brands/2.png','published',1,1,'2024-02-24 01:36:33','2024-02-24 01:36:33'),
(3,'Soda Brand','Fresh Meat Sausage. BUY 2 GET 1!',NULL,'brands/3.png','published',2,1,'2024-02-24 01:36:33','2024-02-24 01:36:33'),
(4,'Farmart','Fresh Meat Sausage. BUY 2 GET 1!',NULL,'brands/4.png','published',3,1,'2024-02-24 01:36:33','2024-02-24 01:36:33'),
(5,'Soda Brand','Fresh Meat Sausage. BUY 2 GET 1!',NULL,'brands/3.png','published',4,1,'2024-02-24 01:36:33','2024-02-24 01:36:33');
/*!40000 ALTER TABLE `ec_brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_brands_translations`
--

DROP TABLE IF EXISTS `ec_brands_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_brands_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_brands_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_brands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_brands_translations`
--

LOCK TABLES `ec_brands_translations` WRITE;
/*!40000 ALTER TABLE `ec_brands_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_brands_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_cart`
--

DROP TABLE IF EXISTS `ec_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_cart` (
  `identifier` varchar(60) NOT NULL,
  `instance` varchar(60) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`identifier`,`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_cart`
--

LOCK TABLES `ec_cart` WRITE;
/*!40000 ALTER TABLE `ec_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_currencies`
--

DROP TABLE IF EXISTS `ec_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_currencies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `is_prefix_symbol` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `decimals` tinyint(3) unsigned DEFAULT 0,
  `order` int(10) unsigned DEFAULT 0,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  `exchange_rate` double NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_currencies`
--

LOCK TABLES `ec_currencies` WRITE;
/*!40000 ALTER TABLE `ec_currencies` DISABLE KEYS */;
INSERT INTO `ec_currencies` VALUES
(1,'KES','KSH',1,2,1,1,1,'2024-02-24 01:36:33','2025-07-16 12:06:00');
/*!40000 ALTER TABLE `ec_currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_customer_addresses`
--

DROP TABLE IF EXISTS `ec_customer_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_customer_addresses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) unsigned NOT NULL,
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_customer_addresses`
--

LOCK TABLES `ec_customer_addresses` WRITE;
/*!40000 ALTER TABLE `ec_customer_addresses` DISABLE KEYS */;
INSERT INTO `ec_customer_addresses` VALUES
(1,'Mrs. Kathlyn Anderson IV','customer@botble.com','+19033193352','ME','Kansas','Bednarchester','876 Mayert Ports Apt. 087',1,1,'2024-02-24 01:36:35','2024-02-24 01:36:35','44374'),
(2,'Mrs. Kathlyn Anderson IV','customer@botble.com','+18015311368','ZA','Arkansas','Raymondmouth','82849 Elsie Stravenue',1,0,'2024-02-24 01:36:35','2024-02-24 01:36:35','50140-8736'),
(3,'Dr. Barney Deckow','vendor@botble.com','+15203372167','BF','West Virginia','East Violette','4621 Mazie Wells Suite 239',2,1,'2024-02-24 01:36:35','2024-02-24 01:36:35','82921'),
(4,'Dr. Barney Deckow','vendor@botble.com','+12014891485','PR','Mississippi','Lake Madge','91220 Susan Turnpike Suite 005',2,0,'2024-02-24 01:36:35','2024-02-24 01:36:35','49837'),
(5,'Eliane Nikolaus','jmoen@example.net','+18204558727','TJ','Montana','Port Dylan','67216 Keely Passage Suite 877',3,1,'2024-02-24 01:36:36','2024-02-24 01:36:36','61682-7031'),
(6,'Mr. Gillian Lesch','zhuel@example.net','+12567597895','NE','Wisconsin','Labadiemouth','29667 Greenfelder Station',4,1,'2024-02-24 01:36:36','2024-02-24 01:36:36','29283-2007'),
(7,'Prof. Dawn White Jr.','hprosacco@example.net','+15344190934','IR','District of Columbia','Kuphalport','198 Marlon Streets Suite 506',5,1,'2024-02-24 01:36:36','2024-02-24 01:36:36','42197'),
(8,'Mason Haag','marjory22@example.net','+16059728566','BT','Washington','Schmelerburgh','373 Chanel Spurs',6,1,'2024-02-24 01:36:36','2024-02-24 01:36:36','56625'),
(9,'Dr. Willard Greenfelder II','margarete19@example.com','+16617598429','SG','West Virginia','Olefurt','770 Carmine Road Suite 452',7,1,'2024-02-24 01:36:37','2024-02-24 01:36:37','69323-8747'),
(10,'Brisa Ziemann','fprice@example.com','+19146003569','JE','Indiana','New Paulineside','398 Shaun Extensions Suite 857',8,1,'2024-02-24 01:36:37','2024-02-24 01:36:37','27402-6485'),
(11,'Lauren Hegmann','hamill.fritz@example.com','+14437800175','QA','Oklahoma','Durganport','104 Armstrong Union',9,1,'2024-02-24 01:36:37','2024-02-24 01:36:37','70851-3955'),
(12,'Miss Katarina Stehr Sr.','koch.alana@example.com','+14342505276','EE','Minnesota','Kaitlinborough','899 Cordelia Passage',10,1,'2024-02-24 01:36:38','2024-02-24 01:36:38','71418-3744');
/*!40000 ALTER TABLE `ec_customer_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_customer_password_resets`
--

DROP TABLE IF EXISTS `ec_customer_password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_customer_password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `ec_customer_password_resets_email_index` (`email`),
  KEY `ec_customer_password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_customer_password_resets`
--

LOCK TABLES `ec_customer_password_resets` WRITE;
/*!40000 ALTER TABLE `ec_customer_password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_customer_password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_customer_recently_viewed_products`
--

DROP TABLE IF EXISTS `ec_customer_recently_viewed_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_customer_recently_viewed_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_customer_recently_viewed_products`
--

LOCK TABLES `ec_customer_recently_viewed_products` WRITE;
/*!40000 ALTER TABLE `ec_customer_recently_viewed_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_customer_recently_viewed_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_customer_used_coupons`
--

DROP TABLE IF EXISTS `ec_customer_used_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_customer_used_coupons` (
  `discount_id` bigint(20) unsigned NOT NULL,
  `customer_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`discount_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_customer_used_coupons`
--

LOCK TABLES `ec_customer_used_coupons` WRITE;
/*!40000 ALTER TABLE `ec_customer_used_coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_customer_used_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_customers`
--

DROP TABLE IF EXISTS `ec_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_customers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `email_verify_token` varchar(120) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'activated',
  `private_notes` text DEFAULT NULL,
  `is_vendor` tinyint(1) NOT NULL DEFAULT 0,
  `vendor_verified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_customers_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_customers`
--

LOCK TABLES `ec_customers` WRITE;
/*!40000 ALTER TABLE `ec_customers` DISABLE KEYS */;
INSERT INTO `ec_customers` VALUES
(1,'Mrs. Kathlyn Anderson IV','customer@botble.com','$2y$12$4dhXNkL36jG6j.biwFU6b.cSpae49MKq6BRP5xizu7md1HcsGsHvq','customers/7.jpg','2001-01-29','+17477535472',NULL,'2024-02-24 01:36:35','2024-02-24 01:36:52','2024-02-24 08:36:34',NULL,'activated',NULL,1,'2024-02-24 08:36:52'),
(2,'Dr. Barney Deckow','vendor@botble.com','$2y$12$ueithxwYRG1YV6YQYh8IjeGOukTLZp0wut8.unAkswRQN0Gb.PJfi','customers/2.jpg','1992-02-18','+17344884660',NULL,'2024-02-24 01:36:35','2024-02-24 01:36:52','2024-02-24 08:36:34',NULL,'activated',NULL,1,'2024-02-24 08:36:52'),
(3,'Eliane Nikolaus','jmoen@example.net','$2y$12$faK/e2E3Vw/dgN..iJeKj.Jihv37cSwJI3QfgtTS6w1.t6uJ/UtO6','customers/1.jpg','1990-02-11','+17545414720',NULL,'2024-02-24 01:36:36','2024-02-24 01:36:53','2024-02-24 08:36:34',NULL,'activated',NULL,1,'2024-02-24 08:36:52'),
(4,'Mr. Gillian Lesch','zhuel@example.net','$2y$12$FDCqcVGOircfatbAHXQnM.gbNqPuWbteaUphL5aeaxLqcQFyhJzKy','customers/2.jpg','1992-02-18','+18325599109',NULL,'2024-02-24 01:36:36','2024-02-24 01:36:53','2024-02-24 08:36:34',NULL,'activated',NULL,1,'2024-02-24 08:36:52'),
(5,'Prof. Dawn White Jr.','hprosacco@example.net','$2y$12$TZgYKEgambTKYdzkda9TSuwFcEbjyxap013R6TjaL9ZCUS29mtYoy','customers/3.jpg','1995-02-04','+17744479231',NULL,'2024-02-24 01:36:36','2024-02-24 01:36:53','2024-02-24 08:36:34',NULL,'activated',NULL,1,'2024-02-24 08:36:52'),
(6,'Mason Haag','marjory22@example.net','$2y$12$feSPzQfXT4VUxlUc29/PUuDJKVNZe3u//ciVrTZNf0u2LSk6KRBP2','customers/4.jpg','2004-02-03','+16409446849',NULL,'2024-02-24 01:36:36','2024-02-24 01:36:54','2024-02-24 08:36:34',NULL,'activated',NULL,1,'2024-02-24 08:36:52'),
(7,'Dr. Willard Greenfelder II','margarete19@example.com','$2y$12$f.czw60PwV9wlSfkaQK/c.ckxJKnItlgdg79MqoRACyNTxi4uQN82','customers/5.jpg','1978-02-10','+13024171836',NULL,'2024-02-24 01:36:37','2024-02-24 01:36:54','2024-02-24 08:36:34',NULL,'activated',NULL,1,'2024-02-24 08:36:52'),
(8,'Brisa Ziemann','fprice@example.com','$2y$12$j9T2wWsmip2kzO3DC5F4meqoWXsUHXa3rxIzJfXpFRHCucjALabDK','customers/6.jpg','1974-02-15','+14844479707',NULL,'2024-02-24 01:36:37','2024-02-24 01:36:54','2024-02-24 08:36:34',NULL,'activated',NULL,1,'2024-02-24 08:36:52'),
(9,'Lauren Hegmann','hamill.fritz@example.com','$2y$12$PibtOFbepaHmctemV7iw8uAtHZ775XnDNw9VkfGKSM3qsvYBlwkLq','customers/7.jpg','1999-01-27','+12298134480',NULL,'2024-02-24 01:36:37','2024-02-24 01:36:55','2024-02-24 08:36:34',NULL,'activated',NULL,0,NULL),
(10,'Miss Katarina Stehr Sr.','koch.alana@example.com','$2y$12$E2Mign/fwvc5YemvKEDTp.DMndhw0eUWth2b21gWtwfbxZtlAVR7.','customers/8.jpg','1991-02-14','+16697551665',NULL,'2024-02-24 01:36:38','2024-02-24 01:36:55','2024-02-24 08:36:34',NULL,'activated',NULL,0,NULL),
(11,'Antonio Mwangi','antonionencheye@yahoo.com','$2y$12$PRCccq4RglNiKWA9WtreuewjuxGGLBjxL4.Oa/EH6IH2EXQAMxz2i',NULL,'2024-05-29','0719863747',NULL,'2024-05-29 10:37:31','2024-05-29 10:40:00','2024-05-29 13:37:31',NULL,'activated',NULL,1,'2024-05-29 13:40:00'),
(12,'TolgaBlulk','tolgacan@em2.thematinggrounds.com','$2y$12$r2CMZeAU4LFAFr4/dM5mo.hYImzhZKxfyUCjC/nOKdvkVdeqb5nDe',NULL,NULL,'85388277692',NULL,'2026-03-04 08:54:36','2026-03-04 08:54:36','2026-03-04 11:54:36',NULL,'activated',NULL,0,NULL);
/*!40000 ALTER TABLE `ec_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_discount_customers`
--

DROP TABLE IF EXISTS `ec_discount_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_discount_customers` (
  `discount_id` bigint(20) unsigned NOT NULL,
  `customer_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`discount_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_discount_customers`
--

LOCK TABLES `ec_discount_customers` WRITE;
/*!40000 ALTER TABLE `ec_discount_customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_discount_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_discount_product_categories`
--

DROP TABLE IF EXISTS `ec_discount_product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_discount_product_categories` (
  `discount_id` bigint(20) unsigned NOT NULL,
  `product_category_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`discount_id`,`product_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_discount_product_categories`
--

LOCK TABLES `ec_discount_product_categories` WRITE;
/*!40000 ALTER TABLE `ec_discount_product_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_discount_product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_discount_product_collections`
--

DROP TABLE IF EXISTS `ec_discount_product_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_discount_product_collections` (
  `discount_id` bigint(20) unsigned NOT NULL,
  `product_collection_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`discount_id`,`product_collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_discount_product_collections`
--

LOCK TABLES `ec_discount_product_collections` WRITE;
/*!40000 ALTER TABLE `ec_discount_product_collections` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_discount_product_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_discount_products`
--

DROP TABLE IF EXISTS `ec_discount_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_discount_products` (
  `discount_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`discount_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_discount_products`
--

LOCK TABLES `ec_discount_products` WRITE;
/*!40000 ALTER TABLE `ec_discount_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_discount_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_discounts`
--

DROP TABLE IF EXISTS `ec_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_discounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(120) DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `total_used` int(10) unsigned NOT NULL DEFAULT 0,
  `value` double DEFAULT NULL,
  `type` varchar(60) DEFAULT 'coupon',
  `can_use_with_promotion` tinyint(1) NOT NULL DEFAULT 0,
  `discount_on` varchar(20) DEFAULT NULL,
  `product_quantity` int(10) unsigned DEFAULT NULL,
  `type_option` varchar(100) NOT NULL DEFAULT 'amount',
  `target` varchar(100) NOT NULL DEFAULT 'all-orders',
  `min_order_price` decimal(15,2) DEFAULT NULL,
  `apply_via_url` tinyint(1) NOT NULL DEFAULT 0,
  `display_at_checkout` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `store_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_discounts_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_discounts`
--

LOCK TABLES `ec_discounts` WRITE;
/*!40000 ALTER TABLE `ec_discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_flash_sale_products`
--

DROP TABLE IF EXISTS `ec_flash_sale_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_flash_sale_products` (
  `flash_sale_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `price` double unsigned DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT NULL,
  `sold` int(10) unsigned NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_flash_sale_products`
--

LOCK TABLES `ec_flash_sale_products` WRITE;
/*!40000 ALTER TABLE `ec_flash_sale_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_flash_sale_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_flash_sales`
--

DROP TABLE IF EXISTS `ec_flash_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_flash_sales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `end_date` datetime NOT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_flash_sales`
--

LOCK TABLES `ec_flash_sales` WRITE;
/*!40000 ALTER TABLE `ec_flash_sales` DISABLE KEYS */;
INSERT INTO `ec_flash_sales` VALUES
(1,'Winter Sale','2024-03-25 00:00:00','published','2024-02-24 01:36:51','2024-02-24 01:36:51');
/*!40000 ALTER TABLE `ec_flash_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_flash_sales_translations`
--

DROP TABLE IF EXISTS `ec_flash_sales_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_flash_sales_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_flash_sales_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_flash_sales_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_flash_sales_translations`
--

LOCK TABLES `ec_flash_sales_translations` WRITE;
/*!40000 ALTER TABLE `ec_flash_sales_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_flash_sales_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_global_option_value`
--

DROP TABLE IF EXISTS `ec_global_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_global_option_value` (
  `option_id` bigint(20) unsigned NOT NULL COMMENT 'option id',
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_value` tinytext DEFAULT NULL COMMENT 'option value',
  `affect_price` double DEFAULT NULL COMMENT 'value of price of this option affect',
  `order` int(11) NOT NULL DEFAULT 9999,
  `affect_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0. fixed 1. percent',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_global_option_value`
--

LOCK TABLES `ec_global_option_value` WRITE;
/*!40000 ALTER TABLE `ec_global_option_value` DISABLE KEYS */;
INSERT INTO `ec_global_option_value` VALUES
(1,1,'1 Year',0,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(1,2,'2 Year',10,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(1,3,'3 Year',20,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(2,4,'4GB',0,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(2,5,'8GB',10,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(2,6,'16GB',20,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(3,7,'Core i5',0,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(3,8,'Core i7',10,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(3,9,'Core i9',20,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(4,10,'128GB',0,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(4,11,'256GB',10,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(4,12,'512GB',20,9999,0,'2024-02-24 01:36:34','2024-02-24 01:36:34');
/*!40000 ALTER TABLE `ec_global_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_global_option_value_translations`
--

DROP TABLE IF EXISTS `ec_global_option_value_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_global_option_value_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_global_option_value_id` bigint(20) unsigned NOT NULL,
  `option_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_global_option_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_global_option_value_translations`
--

LOCK TABLES `ec_global_option_value_translations` WRITE;
/*!40000 ALTER TABLE `ec_global_option_value_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_global_option_value_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_global_options`
--

DROP TABLE IF EXISTS `ec_global_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_global_options` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL COMMENT 'Name of options',
  `option_type` varchar(191) NOT NULL COMMENT 'option type',
  `required` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Checked if this option is required',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_global_options`
--

LOCK TABLES `ec_global_options` WRITE;
/*!40000 ALTER TABLE `ec_global_options` DISABLE KEYS */;
INSERT INTO `ec_global_options` VALUES
(1,'Warranty','Botble\\Ecommerce\\Option\\OptionType\\RadioButton',1,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(2,'RAM','Botble\\Ecommerce\\Option\\OptionType\\RadioButton',1,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(3,'CPU','Botble\\Ecommerce\\Option\\OptionType\\RadioButton',1,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(4,'HDD','Botble\\Ecommerce\\Option\\OptionType\\Dropdown',0,'2024-02-24 01:36:34','2024-02-24 01:36:34');
/*!40000 ALTER TABLE `ec_global_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_global_options_translations`
--

DROP TABLE IF EXISTS `ec_global_options_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_global_options_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_global_options_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_global_options_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_global_options_translations`
--

LOCK TABLES `ec_global_options_translations` WRITE;
/*!40000 ALTER TABLE `ec_global_options_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_global_options_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_grouped_products`
--

DROP TABLE IF EXISTS `ec_grouped_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_grouped_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_product_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `fixed_qty` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_grouped_products`
--

LOCK TABLES `ec_grouped_products` WRITE;
/*!40000 ALTER TABLE `ec_grouped_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_grouped_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_invoice_items`
--

DROP TABLE IF EXISTS `ec_invoice_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_invoice_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint(20) unsigned NOT NULL,
  `reference_type` varchar(191) NOT NULL,
  `reference_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `qty` int(10) unsigned NOT NULL,
  `price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `sub_total` decimal(15,2) unsigned NOT NULL,
  `tax_amount` decimal(15,2) unsigned NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(15,2) unsigned NOT NULL DEFAULT 0.00,
  `amount` decimal(15,2) unsigned NOT NULL,
  `options` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_invoice_items_reference_type_reference_id_index` (`reference_type`,`reference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_invoice_items`
--

LOCK TABLES `ec_invoice_items` WRITE;
/*!40000 ALTER TABLE `ec_invoice_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_invoice_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_invoices`
--

DROP TABLE IF EXISTS `ec_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_invoices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reference_type` varchar(191) NOT NULL,
  `reference_id` bigint(20) unsigned NOT NULL,
  `code` varchar(191) NOT NULL,
  `customer_name` varchar(191) DEFAULT NULL,
  `company_name` varchar(191) DEFAULT NULL,
  `company_logo` varchar(191) DEFAULT NULL,
  `customer_email` varchar(191) DEFAULT NULL,
  `customer_phone` varchar(191) DEFAULT NULL,
  `customer_address` varchar(191) DEFAULT NULL,
  `customer_tax_id` varchar(191) DEFAULT NULL,
  `sub_total` decimal(15,2) unsigned NOT NULL,
  `tax_amount` decimal(15,2) unsigned NOT NULL DEFAULT 0.00,
  `shipping_amount` decimal(15,2) unsigned NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(15,2) unsigned NOT NULL DEFAULT 0.00,
  `shipping_option` varchar(60) DEFAULT NULL,
  `shipping_method` varchar(60) NOT NULL DEFAULT 'default',
  `coupon_code` varchar(120) DEFAULT NULL,
  `discount_description` varchar(255) DEFAULT NULL,
  `amount` decimal(15,2) unsigned NOT NULL,
  `description` text DEFAULT NULL,
  `payment_id` bigint(20) unsigned DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_invoices_code_unique` (`code`),
  KEY `ec_invoices_reference_type_reference_id_index` (`reference_type`,`reference_id`),
  KEY `ec_invoices_payment_id_index` (`payment_id`),
  KEY `ec_invoices_status_index` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_invoices`
--

LOCK TABLES `ec_invoices` WRITE;
/*!40000 ALTER TABLE `ec_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_option_value`
--

DROP TABLE IF EXISTS `ec_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_option_value` (
  `option_id` bigint(20) unsigned NOT NULL COMMENT 'option id',
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_value` tinytext DEFAULT NULL COMMENT 'option value',
  `affect_price` double DEFAULT NULL COMMENT 'value of price of this option affect',
  `order` int(11) NOT NULL DEFAULT 9999,
  `affect_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0. fixed 1. percent',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_option_value`
--

LOCK TABLES `ec_option_value` WRITE;
/*!40000 ALTER TABLE `ec_option_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_option_value_translations`
--

DROP TABLE IF EXISTS `ec_option_value_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_option_value_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_option_value_id` bigint(20) unsigned NOT NULL,
  `option_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_option_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_option_value_translations`
--

LOCK TABLES `ec_option_value_translations` WRITE;
/*!40000 ALTER TABLE `ec_option_value_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_option_value_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_options`
--

DROP TABLE IF EXISTS `ec_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_options` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL COMMENT 'Name of options',
  `option_type` varchar(191) DEFAULT NULL COMMENT 'option type',
  `product_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL DEFAULT 9999,
  `required` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Checked if this option is required',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_options`
--

LOCK TABLES `ec_options` WRITE;
/*!40000 ALTER TABLE `ec_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_options_translations`
--

DROP TABLE IF EXISTS `ec_options_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_options_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_options_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_options_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_options_translations`
--

LOCK TABLES `ec_options_translations` WRITE;
/*!40000 ALTER TABLE `ec_options_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_options_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_addresses`
--

DROP TABLE IF EXISTS `ec_order_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_addresses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `order_id` bigint(20) unsigned NOT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `type` varchar(60) NOT NULL DEFAULT 'shipping_address',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_addresses`
--

LOCK TABLES `ec_order_addresses` WRITE;
/*!40000 ALTER TABLE `ec_order_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_histories`
--

DROP TABLE IF EXISTS `ec_order_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(120) NOT NULL,
  `description` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `order_id` bigint(20) unsigned NOT NULL,
  `extras` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=230 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_histories`
--

LOCK TABLES `ec_order_histories` WRITE;
/*!40000 ALTER TABLE `ec_order_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_product`
--

DROP TABLE IF EXISTS `ec_order_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `tax_amount` decimal(15,2) NOT NULL,
  `options` text DEFAULT NULL,
  `product_options` text DEFAULT NULL COMMENT 'product option data',
  `product_id` bigint(20) unsigned DEFAULT NULL,
  `product_name` varchar(191) NOT NULL,
  `product_image` varchar(191) DEFAULT NULL,
  `weight` double(8,2) DEFAULT 0.00,
  `restock_quantity` int(10) unsigned DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_type` varchar(60) NOT NULL DEFAULT 'physical',
  `times_downloaded` int(11) NOT NULL DEFAULT 0,
  `license_code` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_product`
--

LOCK TABLES `ec_order_product` WRITE;
/*!40000 ALTER TABLE `ec_order_product` DISABLE KEYS */;
INSERT INTO `ec_order_product` VALUES
(59,50,1,2500.00,0.00,'{\"image\":\"images.jpeg\",\"attributes\":\"\",\"taxRate\":0,\"taxClasses\":[],\"options\":[],\"extras\":[],\"sku\":\"FM-2443-ENER\",\"weight\":0}','[]',234,'Glucometer','images.jpeg',0.00,0,'2024-06-22 10:22:55','2024-06-22 10:48:51','physical',0,NULL),
(60,51,1,1164.00,116.40,'{\"image\":\"products\\/11.jpg\",\"attributes\":\"(Color: Blue, Size: XXL)\",\"taxRate\":10,\"taxClasses\":{\"VAT\":10},\"options\":[],\"extras\":[],\"sku\":\"I7-176-A0\",\"weight\":856}','[]',93,'Xbox One Wireless Controller Black Color','products/11.jpg',856.00,0,'2026-02-27 21:43:34','2026-02-27 21:45:45','physical',0,NULL);
/*!40000 ALTER TABLE `ec_order_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_referrals`
--

DROP TABLE IF EXISTS `ec_order_referrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_referrals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(39) DEFAULT NULL,
  `landing_domain` varchar(255) DEFAULT NULL,
  `landing_page` varchar(255) DEFAULT NULL,
  `landing_params` varchar(255) DEFAULT NULL,
  `referral` varchar(255) DEFAULT NULL,
  `gclid` varchar(255) DEFAULT NULL,
  `fclid` varchar(255) DEFAULT NULL,
  `utm_source` varchar(255) DEFAULT NULL,
  `utm_campaign` varchar(255) DEFAULT NULL,
  `utm_medium` varchar(255) DEFAULT NULL,
  `utm_term` varchar(255) DEFAULT NULL,
  `utm_content` varchar(255) DEFAULT NULL,
  `referrer_url` text DEFAULT NULL,
  `referrer_domain` varchar(255) DEFAULT NULL,
  `order_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_order_referrals_order_id_index` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_referrals`
--

LOCK TABLES `ec_order_referrals` WRITE;
/*!40000 ALTER TABLE `ec_order_referrals` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_referrals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_return_items`
--

DROP TABLE IF EXISTS `ec_order_return_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_return_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_return_id` bigint(20) unsigned NOT NULL COMMENT 'Order return id',
  `order_product_id` bigint(20) unsigned NOT NULL COMMENT 'Order product id',
  `product_id` bigint(20) unsigned NOT NULL COMMENT 'Product id',
  `product_name` varchar(191) NOT NULL,
  `product_image` varchar(191) DEFAULT NULL,
  `qty` int(11) NOT NULL COMMENT 'Quantity return',
  `price` decimal(15,2) NOT NULL COMMENT 'Price Product',
  `reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `refund_amount` decimal(12,2) DEFAULT 0.00,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_return_items`
--

LOCK TABLES `ec_order_return_items` WRITE;
/*!40000 ALTER TABLE `ec_order_return_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_return_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_returns`
--

DROP TABLE IF EXISTS `ec_order_returns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_returns` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) DEFAULT NULL,
  `order_id` bigint(20) unsigned NOT NULL COMMENT 'Order ID',
  `store_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Store ID',
  `user_id` bigint(20) unsigned NOT NULL COMMENT 'Customer ID',
  `reason` text DEFAULT NULL COMMENT 'Reason return order',
  `order_status` varchar(191) DEFAULT NULL COMMENT 'Order current status',
  `return_status` varchar(191) NOT NULL COMMENT 'Return status',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_order_returns_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_returns`
--

LOCK TABLES `ec_order_returns` WRITE;
/*!40000 ALTER TABLE `ec_order_returns` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_returns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_order_tax_information`
--

DROP TABLE IF EXISTS `ec_order_tax_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_order_tax_information` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `company_name` varchar(120) NOT NULL,
  `company_address` varchar(191) NOT NULL,
  `company_tax_code` varchar(20) NOT NULL,
  `company_email` varchar(60) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_order_tax_information_order_id_index` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_order_tax_information`
--

LOCK TABLES `ec_order_tax_information` WRITE;
/*!40000 ALTER TABLE `ec_order_tax_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_order_tax_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_orders`
--

DROP TABLE IF EXISTS `ec_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `shipping_option` varchar(60) DEFAULT NULL,
  `shipping_method` varchar(60) NOT NULL DEFAULT 'default',
  `status` varchar(120) NOT NULL DEFAULT 'pending',
  `amount` decimal(15,2) NOT NULL,
  `tax_amount` decimal(15,2) DEFAULT NULL,
  `shipping_amount` decimal(15,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `coupon_code` varchar(120) DEFAULT NULL,
  `discount_amount` decimal(15,2) DEFAULT NULL,
  `sub_total` decimal(15,2) NOT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `discount_description` varchar(255) DEFAULT NULL,
  `is_finished` tinyint(1) DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL,
  `token` varchar(120) DEFAULT NULL,
  `payment_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `proof_file` varchar(191) DEFAULT NULL,
  `store_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_orders_code_unique` (`code`),
  KEY `ec_orders_user_id_status_created_at_index` (`user_id`,`status`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_orders`
--

LOCK TABLES `ec_orders` WRITE;
/*!40000 ALTER TABLE `ec_orders` DISABLE KEYS */;
INSERT INTO `ec_orders` VALUES
(50,'#10000050',0,'1','default','pending',2500.00,0.00,0.00,NULL,NULL,0.00,2500.00,0,NULL,0,NULL,'01538a564ae1c158cd319d2378ead155',NULL,'2024-06-22 10:22:55','2024-06-22 10:48:51',NULL,10),
(51,'#10000051',0,NULL,'default','pending',1280.40,116.40,0.00,NULL,NULL,0.00,1164.00,0,NULL,0,NULL,'ff95b34bc25b42af53350472f7e44f30',NULL,'2026-02-27 21:43:34','2026-02-27 21:45:45',NULL,8);
/*!40000 ALTER TABLE `ec_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_attribute_sets`
--

DROP TABLE IF EXISTS `ec_product_attribute_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_attribute_sets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(120) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `display_layout` varchar(191) NOT NULL DEFAULT 'swatch_dropdown',
  `is_searchable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_comparable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_use_in_product_listing` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `order` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `use_image_from_product_variation` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_attribute_sets`
--

LOCK TABLES `ec_product_attribute_sets` WRITE;
/*!40000 ALTER TABLE `ec_product_attribute_sets` DISABLE KEYS */;
INSERT INTO `ec_product_attribute_sets` VALUES
(1,'Color','color','visual',1,1,1,'published',0,'2024-02-24 01:36:34','2024-02-24 01:36:34',0),
(2,'Size','size','text',1,1,1,'published',1,'2024-02-24 01:36:34','2024-02-24 01:36:34',0),
(3,'Weight','weight','text',1,1,1,'published',0,'2024-02-24 01:36:34','2024-02-24 01:36:34',0),
(4,'Boxes','boxes','text',1,1,1,'published',1,'2024-02-24 01:36:34','2024-02-24 01:36:34',0);
/*!40000 ALTER TABLE `ec_product_attribute_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_attribute_sets_translations`
--

DROP TABLE IF EXISTS `ec_product_attribute_sets_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_attribute_sets_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_attribute_sets_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_product_attribute_sets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_attribute_sets_translations`
--

LOCK TABLES `ec_product_attribute_sets_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_attribute_sets_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_attribute_sets_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_attributes`
--

DROP TABLE IF EXISTS `ec_product_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_attributes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_set_id` bigint(20) unsigned NOT NULL,
  `title` varchar(120) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `order` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attribute_set_status_index` (`attribute_set_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_attributes`
--

LOCK TABLES `ec_product_attributes` WRITE;
/*!40000 ALTER TABLE `ec_product_attributes` DISABLE KEYS */;
INSERT INTO `ec_product_attributes` VALUES
(1,1,'Green','green','#5FB7D4',NULL,1,1,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(2,1,'Blue','blue','#333333',NULL,0,2,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(3,1,'Red','red','#DA323F',NULL,0,3,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(4,1,'Black','black','#2F366C',NULL,0,4,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(5,1,'Brown','brown','#87554B',NULL,0,5,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(6,2,'S','s',NULL,NULL,1,1,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(7,2,'M','m',NULL,NULL,0,2,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(8,2,'L','l',NULL,NULL,0,3,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(9,2,'XL','xl',NULL,NULL,0,4,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(10,2,'XXL','xxl',NULL,NULL,0,5,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(11,3,'1KG','1kg',NULL,NULL,1,1,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(12,3,'2KG','2kg',NULL,NULL,0,2,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(13,3,'3KG','3kg',NULL,NULL,0,3,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(14,3,'4KG','4kg',NULL,NULL,0,4,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(15,3,'5KG','5kg',NULL,NULL,0,5,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(16,4,'1 Box','1-box',NULL,NULL,1,1,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(17,4,'2 Boxes','2-boxes',NULL,NULL,0,2,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(18,4,'3 Boxes','3-boxes',NULL,NULL,0,3,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(19,4,'4 Boxes','4-boxes',NULL,NULL,0,4,'2024-02-24 01:36:34','2024-02-24 01:36:34'),
(20,4,'5 Boxes','5-boxes',NULL,NULL,0,5,'2024-02-24 01:36:34','2024-02-24 01:36:34');
/*!40000 ALTER TABLE `ec_product_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_attributes_translations`
--

DROP TABLE IF EXISTS `ec_product_attributes_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_attributes_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_attributes_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_product_attributes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_attributes_translations`
--

LOCK TABLES `ec_product_attributes_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_attributes_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_attributes_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_categories`
--

DROP TABLE IF EXISTS `ec_product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `description` mediumtext DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `order` int(10) unsigned NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `is_featured` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `icon_image` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_product_categories_parent_id_status_created_at_index` (`parent_id`,`status`,`created_at`),
  KEY `ec_product_categories_parent_id_status_index` (`parent_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_categories`
--

LOCK TABLES `ec_product_categories` WRITE;
/*!40000 ALTER TABLE `ec_product_categories` DISABLE KEYS */;
INSERT INTO `ec_product_categories` VALUES
(1,'Health & Wellness Books/Resources',0,NULL,'published',5,NULL,1,'2024-02-24 01:36:33','2025-07-15 12:58:12','icon-star',NULL),
(24,'Monitoring Devices',0,NULL,'published',1,'product-categories/2.png',1,'2024-02-24 01:36:33','2025-07-15 12:58:12','icon-bread',NULL),
(25,'Stethoscopes',24,NULL,'published',0,'stethoscope.jpeg',0,'2024-02-24 01:36:33','2025-07-15 12:58:12','0',NULL),
(27,'Maternity & Baby Care',0,NULL,'published',4,NULL,0,'2024-02-24 01:36:33','2025-07-15 12:58:12','0',NULL),
(28,'Rehabilitation & Therapy Aids',0,NULL,'published',3,NULL,0,'2024-02-24 01:36:33','2025-07-15 12:58:12','0',NULL),
(38,'Vitamins & Supplements',0,NULL,'published',2,NULL,0,'2024-02-24 01:36:33','2025-07-15 12:58:12','0',NULL),
(52,'Hospital and Laboratory Equipment',0,NULL,'published',6,'product-categories/3.png',1,'2024-02-24 01:36:33','2025-07-15 12:58:12','icon-hamburger',NULL),
(85,'Over-the-Counter (OTC) Medications & First Aid',0,'<p><img src=\"https://emart.spanursinghome.org/storage/over-the-counter-meds.jpg\" alt=\"Over The counter meds\" loading=\"lazy\"><br>&nbsp;</p>','published',0,NULL,0,'2024-05-29 12:57:22','2025-07-15 12:58:12','0','over-the-counter-meds.jpg');
/*!40000 ALTER TABLE `ec_product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_categories_translations`
--

DROP TABLE IF EXISTS `ec_product_categories_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_categories_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_categories_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_product_categories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_categories_translations`
--

LOCK TABLES `ec_product_categories_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_categories_translations` DISABLE KEYS */;
INSERT INTO `ec_product_categories_translations` VALUES
('en_US',84,'Hospital Products',NULL),
('en_US',85,'Medical Electronics',NULL);
/*!40000 ALTER TABLE `ec_product_categories_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_categorizables`
--

DROP TABLE IF EXISTS `ec_product_categorizables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_categorizables` (
  `category_id` bigint(20) unsigned NOT NULL,
  `reference_id` bigint(20) unsigned NOT NULL,
  `reference_type` varchar(120) NOT NULL,
  PRIMARY KEY (`category_id`,`reference_id`,`reference_type`),
  KEY `ec_product_categorizables_category_id_index` (`category_id`),
  KEY `ec_product_categorizables_reference_id_index` (`reference_id`),
  KEY `ec_product_categorizables_reference_type_index` (`reference_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_categorizables`
--

LOCK TABLES `ec_product_categorizables` WRITE;
/*!40000 ALTER TABLE `ec_product_categorizables` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_categorizables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_category_product`
--

DROP TABLE IF EXISTS `ec_product_category_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_category_product` (
  `category_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `ec_product_category_product_category_id_index` (`category_id`),
  KEY `ec_product_category_product_product_id_index` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_category_product`
--

LOCK TABLES `ec_product_category_product` WRITE;
/*!40000 ALTER TABLE `ec_product_category_product` DISABLE KEYS */;
INSERT INTO `ec_product_category_product` VALUES
(85,234),
(24,236),
(25,236);
/*!40000 ALTER TABLE `ec_product_category_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_collection_products`
--

DROP TABLE IF EXISTS `ec_product_collection_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_collection_products` (
  `product_collection_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`product_collection_id`),
  KEY `ec_product_collection_products_product_collection_id_index` (`product_collection_id`),
  KEY `ec_product_collection_products_product_id_index` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_collection_products`
--

LOCK TABLES `ec_product_collection_products` WRITE;
/*!40000 ALTER TABLE `ec_product_collection_products` DISABLE KEYS */;
INSERT INTO `ec_product_collection_products` VALUES
(1,233),
(3,233),
(3,234),
(2,235),
(1,236);
/*!40000 ALTER TABLE `ec_product_collection_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_collections`
--

DROP TABLE IF EXISTS `ec_product_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_collections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_featured` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_collections`
--

LOCK TABLES `ec_product_collections` WRITE;
/*!40000 ALTER TABLE `ec_product_collections` DISABLE KEYS */;
INSERT INTO `ec_product_collections` VALUES
(1,'New Arrival','new-arrival',NULL,NULL,'published','2024-02-24 01:36:34','2024-02-24 01:36:34',0),
(2,'Best Sellers','best-sellers',NULL,NULL,'published','2024-02-24 01:36:34','2024-02-24 01:36:34',0),
(3,'Special Offer','special-offer',NULL,NULL,'published','2024-02-24 01:36:34','2024-02-24 01:36:34',0);
/*!40000 ALTER TABLE `ec_product_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_collections_translations`
--

DROP TABLE IF EXISTS `ec_product_collections_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_collections_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_collections_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_product_collections_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_collections_translations`
--

LOCK TABLES `ec_product_collections_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_collections_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_collections_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_cross_sale_relations`
--

DROP TABLE IF EXISTS `ec_product_cross_sale_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_cross_sale_relations` (
  `from_product_id` bigint(20) unsigned NOT NULL,
  `to_product_id` bigint(20) unsigned NOT NULL,
  `is_variant` tinyint(1) NOT NULL DEFAULT 0,
  `price` decimal(15,2) DEFAULT 0.00,
  `price_type` varchar(191) NOT NULL DEFAULT 'fixed',
  `apply_to_all_variations` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`from_product_id`,`to_product_id`),
  KEY `ec_product_cross_sale_relations_from_product_id_index` (`from_product_id`),
  KEY `ec_product_cross_sale_relations_to_product_id_index` (`to_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_cross_sale_relations`
--

LOCK TABLES `ec_product_cross_sale_relations` WRITE;
/*!40000 ALTER TABLE `ec_product_cross_sale_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_cross_sale_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_files`
--

DROP TABLE IF EXISTS `ec_product_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) unsigned DEFAULT NULL,
  `url` varchar(400) DEFAULT NULL,
  `extras` mediumtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ec_product_files_product_id_index` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_files`
--

LOCK TABLES `ec_product_files` WRITE;
/*!40000 ALTER TABLE `ec_product_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_label_products`
--

DROP TABLE IF EXISTS `ec_product_label_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_label_products` (
  `product_label_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`product_label_id`,`product_id`),
  KEY `ec_product_label_products_product_label_id_index` (`product_label_id`),
  KEY `ec_product_label_products_product_id_index` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_label_products`
--

LOCK TABLES `ec_product_label_products` WRITE;
/*!40000 ALTER TABLE `ec_product_label_products` DISABLE KEYS */;
INSERT INTO `ec_product_label_products` VALUES
(1,234),
(1,236),
(2,233),
(3,235);
/*!40000 ALTER TABLE `ec_product_label_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_labels`
--

DROP TABLE IF EXISTS `ec_product_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_labels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `color` varchar(120) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_labels`
--

LOCK TABLES `ec_product_labels` WRITE;
/*!40000 ALTER TABLE `ec_product_labels` DISABLE KEYS */;
INSERT INTO `ec_product_labels` VALUES
(1,'Hot','#d71e2d','published','2024-02-24 01:36:34','2024-02-24 01:36:34'),
(2,'New','#02856e','published','2024-02-24 01:36:34','2024-02-24 01:36:34'),
(3,'Sale','#fe9931','published','2024-02-24 01:36:34','2024-02-24 01:36:34');
/*!40000 ALTER TABLE `ec_product_labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_labels_translations`
--

DROP TABLE IF EXISTS `ec_product_labels_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_labels_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_labels_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_product_labels_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_labels_translations`
--

LOCK TABLES `ec_product_labels_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_labels_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_labels_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_related_relations`
--

DROP TABLE IF EXISTS `ec_product_related_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_related_relations` (
  `from_product_id` bigint(20) unsigned NOT NULL,
  `to_product_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`from_product_id`,`to_product_id`),
  KEY `ec_product_related_relations_from_product_id_index` (`from_product_id`),
  KEY `ec_product_related_relations_to_product_id_index` (`to_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_related_relations`
--

LOCK TABLES `ec_product_related_relations` WRITE;
/*!40000 ALTER TABLE `ec_product_related_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_related_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_tag_product`
--

DROP TABLE IF EXISTS `ec_product_tag_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_tag_product` (
  `product_id` bigint(20) unsigned NOT NULL,
  `tag_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`tag_id`),
  KEY `ec_product_tag_product_product_id_index` (`product_id`),
  KEY `ec_product_tag_product_tag_id_index` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_tag_product`
--

LOCK TABLES `ec_product_tag_product` WRITE;
/*!40000 ALTER TABLE `ec_product_tag_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_tag_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_tags`
--

DROP TABLE IF EXISTS `ec_product_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_tags`
--

LOCK TABLES `ec_product_tags` WRITE;
/*!40000 ALTER TABLE `ec_product_tags` DISABLE KEYS */;
INSERT INTO `ec_product_tags` VALUES
(1,'Electronic',NULL,'published','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(2,'Mobile',NULL,'published','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(3,'Iphone',NULL,'published','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(4,'Printer',NULL,'published','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(5,'Office',NULL,'published','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(6,'IT',NULL,'published','2024-02-24 01:36:38','2024-02-24 01:36:38');
/*!40000 ALTER TABLE `ec_product_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_tags_translations`
--

DROP TABLE IF EXISTS `ec_product_tags_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_tags_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_product_tags_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_product_tags_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_tags_translations`
--

LOCK TABLES `ec_product_tags_translations` WRITE;
/*!40000 ALTER TABLE `ec_product_tags_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_tags_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_up_sale_relations`
--

DROP TABLE IF EXISTS `ec_product_up_sale_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_up_sale_relations` (
  `from_product_id` bigint(20) unsigned NOT NULL,
  `to_product_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`from_product_id`,`to_product_id`),
  KEY `ec_product_up_sale_relations_from_product_id_index` (`from_product_id`),
  KEY `ec_product_up_sale_relations_to_product_id_index` (`to_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_up_sale_relations`
--

LOCK TABLES `ec_product_up_sale_relations` WRITE;
/*!40000 ALTER TABLE `ec_product_up_sale_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_product_up_sale_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_variation_items`
--

DROP TABLE IF EXISTS `ec_product_variation_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_variation_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` bigint(20) unsigned NOT NULL,
  `variation_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `attribute_variation_index` (`attribute_id`,`variation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=336 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_variation_items`
--

LOCK TABLES `ec_product_variation_items` WRITE;
/*!40000 ALTER TABLE `ec_product_variation_items` DISABLE KEYS */;
INSERT INTO `ec_product_variation_items` VALUES
(335,4,168);
/*!40000 ALTER TABLE `ec_product_variation_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_variations`
--

DROP TABLE IF EXISTS `ec_product_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_variations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) unsigned DEFAULT NULL,
  `configurable_product_id` bigint(20) unsigned NOT NULL,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_product_variations_product_id_configurable_product_id_unique` (`product_id`,`configurable_product_id`),
  KEY `configurable_product_index` (`product_id`,`configurable_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_variations`
--

LOCK TABLES `ec_product_variations` WRITE;
/*!40000 ALTER TABLE `ec_product_variations` DISABLE KEYS */;
INSERT INTO `ec_product_variations` VALUES
(168,237,236,1);
/*!40000 ALTER TABLE `ec_product_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_views`
--

DROP TABLE IF EXISTS `ec_product_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_views` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) unsigned NOT NULL,
  `views` int(11) NOT NULL DEFAULT 1,
  `date` date NOT NULL DEFAULT '2024-02-24',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_product_views_product_id_date_unique` (`product_id`,`date`),
  KEY `ec_product_views_product_id_index` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14169 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_views`
--

LOCK TABLES `ec_product_views` WRITE;
/*!40000 ALTER TABLE `ec_product_views` DISABLE KEYS */;
INSERT INTO `ec_product_views` VALUES
(276,233,3,'2024-05-29'),
(282,234,1,'2024-05-29'),
(311,234,1,'2024-06-02'),
(322,235,1,'2024-06-03'),
(332,233,1,'2024-06-03'),
(351,233,1,'2024-06-06'),
(352,236,1,'2024-06-06'),
(354,234,2,'2024-06-06'),
(356,235,2,'2024-06-07'),
(358,233,2,'2024-06-07'),
(360,236,2,'2024-06-07'),
(366,235,1,'2024-06-10'),
(387,236,1,'2024-06-11'),
(398,234,1,'2024-06-14'),
(406,235,1,'2024-06-14'),
(418,233,1,'2024-06-16'),
(499,236,1,'2024-06-23'),
(502,235,2,'2024-06-26'),
(503,234,2,'2024-06-26'),
(505,236,1,'2024-06-26'),
(507,233,1,'2024-06-26'),
(532,233,1,'2024-06-29'),
(581,236,1,'2024-07-07'),
(647,236,1,'2024-07-14'),
(648,235,1,'2024-07-14'),
(649,234,2,'2024-07-15'),
(651,235,1,'2024-07-15'),
(652,233,1,'2024-07-15'),
(653,233,1,'2024-07-17'),
(702,236,1,'2024-07-25'),
(759,236,1,'2024-08-02'),
(782,235,1,'2024-08-03'),
(783,234,1,'2024-08-03'),
(784,233,1,'2024-08-03'),
(785,234,1,'2024-08-05'),
(787,235,1,'2024-08-05'),
(788,233,1,'2024-08-07'),
(797,236,1,'2024-08-15'),
(799,235,1,'2024-08-16'),
(805,233,1,'2024-08-16'),
(810,234,1,'2024-08-16'),
(813,236,1,'2024-08-17'),
(867,236,1,'2024-08-21'),
(942,235,1,'2024-08-23'),
(949,234,1,'2024-08-23'),
(952,233,1,'2024-08-23'),
(992,234,1,'2024-08-31'),
(993,235,1,'2024-08-31'),
(994,233,1,'2024-09-03'),
(999,236,1,'2024-09-09'),
(1001,235,1,'2024-09-09'),
(1002,234,1,'2024-09-09'),
(1003,233,1,'2024-09-09'),
(1064,236,1,'2024-09-11'),
(1080,236,1,'2024-09-13'),
(1081,235,1,'2024-09-13'),
(1082,234,1,'2024-09-13'),
(1083,233,1,'2024-09-13'),
(1191,236,1,'2024-09-18'),
(1193,235,1,'2024-09-18'),
(1194,234,1,'2024-09-18'),
(1195,233,1,'2024-09-18'),
(1259,236,1,'2024-09-22'),
(1262,235,1,'2024-09-22'),
(1263,234,1,'2024-09-22'),
(1264,233,1,'2024-09-23'),
(1373,236,1,'2024-09-27'),
(1378,235,1,'2024-09-27'),
(1379,233,1,'2024-09-27'),
(1380,234,1,'2024-09-27'),
(1381,235,1,'2024-09-28'),
(1404,233,1,'2024-09-30'),
(1420,236,1,'2024-10-01'),
(1436,235,1,'2024-10-02'),
(1442,233,1,'2024-10-02'),
(1476,236,2,'2024-10-06'),
(1493,235,2,'2024-10-06'),
(1497,233,2,'2024-10-07'),
(1550,236,1,'2024-10-09'),
(1554,236,1,'2024-10-11'),
(1567,235,1,'2024-10-11'),
(1572,233,1,'2024-10-11'),
(1667,234,2,'2024-10-15'),
(1669,236,1,'2024-10-15'),
(1672,235,1,'2024-10-16'),
(1674,233,1,'2024-10-16'),
(1725,234,1,'2024-10-19'),
(1732,236,1,'2024-10-20'),
(1740,235,1,'2024-10-20'),
(1743,233,1,'2024-10-20'),
(1781,234,1,'2024-10-23'),
(1787,236,1,'2024-10-24'),
(1797,235,1,'2024-10-24'),
(1802,233,1,'2024-10-24'),
(1807,235,1,'2024-10-25'),
(1811,234,1,'2024-10-25'),
(1834,234,1,'2024-10-28'),
(1850,236,1,'2024-10-28'),
(1855,233,1,'2024-10-28'),
(1861,235,1,'2024-10-29'),
(1864,233,1,'2024-10-29'),
(1906,234,1,'2024-11-01'),
(1907,236,1,'2024-11-01'),
(1924,235,1,'2024-11-02'),
(1927,233,1,'2024-11-02'),
(1973,234,1,'2024-11-06'),
(1974,236,2,'2024-11-06'),
(2018,235,1,'2024-11-07'),
(2019,233,1,'2024-11-07'),
(2083,234,1,'2024-11-10'),
(2084,236,1,'2024-11-10'),
(2109,235,1,'2024-11-11'),
(2111,233,1,'2024-11-11'),
(2138,234,1,'2024-11-15'),
(2142,236,1,'2024-11-15'),
(2168,235,1,'2024-11-16'),
(2170,233,1,'2024-11-16'),
(2171,236,1,'2024-11-16'),
(2186,235,1,'2024-11-18'),
(2189,233,1,'2024-11-19'),
(2190,234,2,'2024-11-19'),
(2199,236,1,'2024-11-19'),
(2234,235,1,'2024-11-20'),
(2235,233,1,'2024-11-20'),
(2260,235,1,'2024-11-22'),
(2270,234,1,'2024-11-22'),
(2295,233,1,'2024-11-24'),
(2311,234,1,'2024-11-25'),
(2312,236,1,'2024-11-25'),
(2332,235,1,'2024-11-25'),
(2336,233,1,'2024-11-25'),
(2388,234,1,'2024-11-29'),
(2389,236,1,'2024-11-29'),
(2392,235,1,'2024-11-29'),
(2393,233,1,'2024-11-29'),
(2469,234,1,'2024-12-03'),
(2470,236,1,'2024-12-03'),
(2474,235,1,'2024-12-03'),
(2476,233,1,'2024-12-03'),
(2484,236,1,'2024-12-04'),
(2596,234,1,'2024-12-07'),
(2597,236,1,'2024-12-07'),
(2600,235,1,'2024-12-07'),
(2601,233,1,'2024-12-08'),
(2659,234,1,'2024-12-11'),
(2662,236,1,'2024-12-12'),
(2664,235,1,'2024-12-12'),
(2668,233,1,'2024-12-12'),
(2690,234,1,'2024-12-15'),
(2701,236,1,'2024-12-16'),
(2712,235,1,'2024-12-16'),
(2715,233,1,'2024-12-16'),
(2737,235,1,'2024-12-17'),
(2739,234,1,'2024-12-17'),
(2746,233,1,'2024-12-18'),
(2760,234,1,'2024-12-20'),
(2763,236,1,'2024-12-20'),
(2766,235,1,'2024-12-20'),
(2767,233,1,'2024-12-20'),
(2831,236,1,'2024-12-24'),
(2887,234,1,'2025-01-05'),
(2889,236,1,'2025-01-05'),
(2891,235,1,'2025-01-05'),
(2892,233,1,'2025-01-05'),
(2956,234,1,'2025-01-07'),
(2957,233,1,'2025-01-08'),
(2958,234,1,'2025-01-10'),
(2959,236,1,'2025-01-10'),
(2963,235,1,'2025-01-10'),
(2964,233,1,'2025-01-10'),
(3030,235,1,'2025-01-11'),
(3034,236,1,'2025-01-13'),
(3050,236,2,'2025-01-14'),
(3051,235,1,'2025-01-14'),
(3052,234,2,'2025-01-14'),
(3053,233,1,'2025-01-14'),
(3073,235,1,'2025-01-15'),
(3074,233,1,'2025-01-15'),
(3168,234,1,'2025-01-21'),
(3169,236,1,'2025-01-21'),
(3172,235,1,'2025-01-21'),
(3173,233,1,'2025-01-21'),
(3252,234,1,'2025-01-27'),
(3253,233,2,'2025-01-28'),
(3255,234,1,'2025-01-28'),
(3256,236,1,'2025-01-28'),
(3259,235,1,'2025-01-28'),
(3326,235,1,'2025-02-01'),
(3330,236,1,'2025-02-03'),
(3344,235,1,'2025-02-04'),
(3347,234,1,'2025-02-05'),
(3349,236,1,'2025-02-05'),
(3364,235,1,'2025-02-06'),
(3365,233,1,'2025-02-06'),
(3435,234,1,'2025-02-16'),
(3436,236,1,'2025-02-17'),
(3437,233,1,'2025-02-17'),
(3438,235,1,'2025-02-19'),
(3452,235,1,'2025-02-22'),
(3465,233,1,'2025-02-23'),
(3466,234,1,'2025-02-23'),
(3472,236,1,'2025-02-23'),
(3574,236,1,'2025-03-11'),
(3592,235,1,'2025-03-11'),
(3596,233,1,'2025-03-11'),
(3606,234,1,'2025-03-14'),
(3642,236,1,'2025-03-18'),
(3645,235,1,'2025-03-18'),
(3646,233,1,'2025-03-18'),
(3675,234,1,'2025-03-19'),
(3711,236,1,'2025-03-21'),
(3718,234,1,'2025-03-21'),
(3720,233,1,'2025-03-21'),
(3722,235,1,'2025-03-21'),
(3780,236,1,'2025-03-25'),
(3783,235,1,'2025-03-25'),
(3784,233,1,'2025-03-25'),
(3789,234,1,'2025-03-26'),
(3853,236,1,'2025-03-29'),
(3856,235,1,'2025-03-30'),
(3857,233,1,'2025-03-30'),
(3860,234,1,'2025-03-30'),
(3936,236,1,'2025-04-04'),
(3942,235,1,'2025-04-04'),
(3943,233,1,'2025-04-04'),
(3944,234,1,'2025-04-04'),
(3974,233,1,'2025-04-08'),
(3976,234,1,'2025-04-08'),
(3979,236,1,'2025-04-08'),
(3987,235,1,'2025-04-08'),
(4049,235,1,'2025-04-14'),
(4065,233,1,'2025-04-14'),
(4067,236,1,'2025-04-14'),
(4095,234,1,'2025-04-15'),
(4144,233,1,'2025-04-17'),
(4168,234,1,'2025-04-26'),
(4182,236,1,'2025-04-26'),
(4211,235,1,'2025-04-26'),
(4214,233,1,'2025-04-26'),
(4232,236,1,'2025-04-29'),
(4235,234,1,'2025-04-30'),
(4238,235,1,'2025-04-30'),
(4239,233,1,'2025-04-30'),
(4316,236,2,'2025-05-04'),
(4332,236,1,'2025-05-05'),
(4333,235,2,'2025-05-05'),
(4339,233,2,'2025-05-05'),
(4354,234,2,'2025-05-05'),
(4464,236,1,'2025-05-09'),
(4467,234,1,'2025-05-09'),
(4469,235,1,'2025-05-09'),
(4537,236,1,'2025-05-13'),
(4540,234,1,'2025-05-14'),
(4542,235,1,'2025-05-14'),
(4610,236,1,'2025-05-18'),
(4615,234,1,'2025-05-18'),
(4617,235,1,'2025-05-19'),
(4624,236,1,'2025-05-21'),
(4674,236,1,'2025-05-23'),
(4690,235,2,'2025-05-24'),
(4691,234,1,'2025-05-24'),
(4703,236,1,'2025-05-25'),
(4706,235,1,'2025-05-25'),
(4725,233,1,'2025-05-25'),
(4749,234,1,'2025-05-25'),
(4799,236,1,'2025-05-27'),
(4801,233,1,'2025-05-27'),
(4803,234,1,'2025-05-27'),
(4819,233,1,'2025-05-28'),
(4821,234,1,'2025-05-28'),
(4854,235,1,'2025-05-29'),
(4889,236,1,'2025-06-01'),
(4890,235,1,'2025-06-01'),
(4891,234,1,'2025-06-01'),
(4892,233,1,'2025-06-01'),
(4929,233,1,'2025-06-07'),
(4951,234,1,'2025-06-10'),
(4956,236,1,'2025-06-11'),
(4963,233,1,'2025-06-11'),
(4990,235,1,'2025-06-11'),
(5022,236,1,'2025-06-14'),
(5029,235,1,'2025-06-14'),
(5045,233,1,'2025-06-14'),
(5094,234,1,'2025-06-14'),
(5135,233,1,'2025-06-16'),
(5136,234,1,'2025-06-16'),
(5137,235,1,'2025-06-16'),
(5147,236,1,'2025-06-16'),
(5210,234,2,'2025-06-22'),
(5232,236,1,'2025-06-24'),
(5238,236,1,'2025-06-25'),
(5239,233,1,'2025-06-26'),
(5240,235,1,'2025-06-26'),
(5304,235,1,'2025-07-04'),
(5308,233,1,'2025-07-04'),
(5309,236,1,'2025-07-04'),
(5356,233,1,'2025-07-05'),
(5389,234,1,'2025-07-05'),
(5406,234,1,'2025-07-08'),
(5420,235,2,'2025-07-12'),
(5434,236,1,'2025-07-12'),
(5435,233,1,'2025-07-12'),
(5510,233,1,'2025-07-15'),
(5511,235,1,'2025-07-15'),
(5516,234,1,'2025-07-16'),
(5524,236,2,'2025-07-17'),
(5525,234,1,'2025-07-17'),
(5532,233,1,'2025-07-17'),
(5586,236,1,'2025-07-22'),
(5587,233,2,'2025-07-22'),
(5589,235,2,'2025-07-22'),
(5632,235,1,'2025-07-24'),
(5634,236,1,'2025-07-24'),
(5636,233,1,'2025-07-24'),
(5699,235,1,'2025-07-25'),
(5700,234,2,'2025-07-25'),
(5733,236,1,'2025-07-25'),
(5739,233,1,'2025-07-25'),
(5779,234,2,'2025-07-26'),
(5821,234,1,'2025-07-29'),
(5827,235,1,'2025-07-29'),
(5833,236,1,'2025-07-29'),
(5842,233,1,'2025-07-29'),
(5891,236,1,'2025-07-31'),
(5892,235,1,'2025-07-31'),
(5897,233,1,'2025-08-01'),
(5902,234,1,'2025-08-03'),
(5968,236,1,'2025-08-07'),
(5971,235,1,'2025-08-07'),
(5977,233,1,'2025-08-08'),
(5979,234,1,'2025-08-08'),
(6018,236,1,'2025-08-14'),
(6020,233,1,'2025-08-14'),
(6025,235,1,'2025-08-14'),
(6054,234,1,'2025-08-14'),
(6136,234,1,'2025-08-16'),
(6139,236,1,'2025-08-18'),
(6142,235,1,'2025-08-19'),
(6156,233,1,'2025-08-19'),
(6199,234,1,'2025-08-22'),
(6217,235,1,'2025-08-25'),
(6218,234,1,'2025-08-25'),
(6222,236,1,'2025-08-28'),
(6224,235,1,'2025-08-28'),
(6230,233,1,'2025-08-30'),
(6338,233,1,'2025-09-03'),
(6340,236,1,'2025-09-03'),
(6358,235,1,'2025-09-03'),
(6361,234,1,'2025-09-03'),
(6416,236,1,'2025-09-04'),
(6418,235,1,'2025-09-04'),
(6425,234,1,'2025-09-04'),
(6430,233,1,'2025-09-10'),
(6447,234,2,'2025-09-12'),
(6468,236,1,'2025-09-15'),
(6472,235,1,'2025-09-15'),
(6519,233,1,'2025-09-19'),
(6521,234,1,'2025-09-19'),
(6526,235,2,'2025-09-21'),
(6528,236,1,'2025-09-21'),
(6531,233,1,'2025-09-21'),
(6540,233,1,'2025-09-22'),
(6559,233,1,'2025-09-23'),
(6560,236,1,'2025-09-23'),
(6579,235,1,'2025-09-23'),
(6594,236,1,'2025-09-24'),
(6599,235,1,'2025-09-24'),
(6636,233,1,'2025-09-24'),
(6638,234,1,'2025-09-24'),
(6675,234,1,'2025-09-25'),
(6701,236,1,'2025-09-26'),
(6702,233,1,'2025-09-26'),
(6747,234,1,'2025-09-28'),
(6751,233,1,'2025-09-28'),
(6753,236,1,'2025-09-28'),
(6759,236,1,'2025-09-29'),
(6760,235,1,'2025-09-29'),
(6763,234,1,'2025-09-29'),
(6766,236,1,'2025-09-30'),
(6784,233,1,'2025-10-01'),
(6812,233,4,'2025-10-02'),
(6813,235,2,'2025-10-02'),
(6815,234,4,'2025-10-02'),
(6821,236,2,'2025-10-02'),
(6888,234,1,'2025-10-03'),
(6898,233,1,'2025-10-03'),
(6899,236,1,'2025-10-03'),
(6900,234,1,'2025-10-04'),
(6903,233,1,'2025-10-04'),
(6906,236,1,'2025-10-04'),
(6907,235,1,'2025-10-04'),
(6914,233,4,'2025-10-05'),
(6928,233,2,'2025-10-06'),
(7006,233,1,'2025-10-07'),
(7026,234,1,'2025-10-08'),
(7034,233,3,'2025-10-08'),
(7060,233,2,'2025-10-09'),
(7067,236,2,'2025-10-09'),
(7070,235,1,'2025-10-09'),
(7072,233,1,'2025-10-10'),
(7081,233,4,'2025-10-11'),
(7098,233,4,'2025-10-12'),
(7114,233,3,'2025-10-13'),
(7122,234,2,'2025-10-13'),
(7125,235,1,'2025-10-13'),
(7128,236,1,'2025-10-13'),
(7165,235,1,'2025-10-14'),
(7190,233,2,'2025-10-14'),
(7216,236,2,'2025-10-14'),
(7223,235,1,'2025-10-15'),
(7224,233,4,'2025-10-15'),
(7261,233,3,'2025-10-16'),
(7278,233,4,'2025-10-17'),
(7295,233,2,'2025-10-18'),
(7299,234,1,'2025-10-18'),
(7304,233,4,'2025-10-19'),
(7306,236,2,'2025-10-19'),
(7384,235,2,'2025-10-20'),
(7414,236,1,'2025-10-20'),
(7429,233,1,'2025-10-20'),
(7434,234,1,'2025-10-20'),
(7480,233,3,'2025-10-21'),
(7503,233,2,'2025-10-22'),
(7530,234,2,'2025-10-23'),
(7531,233,4,'2025-10-23'),
(7547,233,2,'2025-10-24'),
(7558,236,1,'2025-10-24'),
(7572,235,1,'2025-10-24'),
(7576,233,3,'2025-10-25'),
(7595,233,6,'2025-10-26'),
(7661,233,4,'2025-10-27'),
(7717,233,2,'2025-10-28'),
(7742,234,1,'2025-10-29'),
(7763,233,2,'2025-10-29'),
(7788,236,2,'2025-10-30'),
(7790,235,2,'2025-10-30'),
(7795,233,2,'2025-10-30'),
(7801,234,1,'2025-10-30'),
(7863,233,2,'2025-10-31'),
(7895,233,2,'2025-11-01'),
(7911,233,4,'2025-11-02'),
(7924,236,1,'2025-11-02'),
(7942,233,1,'2025-11-03'),
(7950,235,1,'2025-11-03'),
(7954,234,2,'2025-11-03'),
(7965,236,2,'2025-11-03'),
(8005,233,3,'2025-11-04'),
(8081,233,1,'2025-11-05'),
(8082,234,1,'2025-11-05'),
(8088,236,1,'2025-11-06'),
(8094,234,1,'2025-11-06'),
(8099,233,2,'2025-11-06'),
(8102,235,1,'2025-11-06'),
(8180,233,3,'2025-11-07'),
(8202,233,3,'2025-11-08'),
(8205,234,1,'2025-11-08'),
(8206,236,2,'2025-11-08'),
(8216,235,1,'2025-11-08'),
(8227,233,4,'2025-11-09'),
(8250,233,1,'2025-11-10'),
(8259,236,1,'2025-11-11'),
(8260,234,1,'2025-11-11'),
(8262,233,4,'2025-11-11'),
(8311,233,2,'2025-11-12'),
(8324,234,1,'2025-11-12'),
(8344,235,1,'2025-11-13'),
(8347,233,3,'2025-11-13'),
(8351,236,1,'2025-11-13'),
(8416,233,2,'2025-11-14'),
(8451,233,3,'2025-11-15'),
(8478,233,3,'2025-11-16'),
(8484,234,1,'2025-11-16'),
(8500,235,1,'2025-11-16'),
(8504,236,1,'2025-11-16'),
(8538,235,2,'2025-11-17'),
(8553,236,2,'2025-11-17'),
(8564,234,2,'2025-11-17'),
(8581,233,4,'2025-11-17'),
(8618,233,2,'2025-11-18'),
(8631,233,2,'2025-11-19'),
(8644,233,5,'2025-11-20'),
(8665,233,2,'2025-11-21'),
(8680,233,1,'2025-11-22'),
(8687,236,1,'2025-11-22'),
(8691,236,1,'2025-11-23'),
(8695,235,2,'2025-11-23'),
(8741,233,2,'2025-11-23'),
(8769,234,1,'2025-11-23'),
(8785,233,1,'2025-11-24'),
(8796,234,2,'2025-11-27'),
(8805,236,1,'2025-11-27'),
(8808,235,2,'2025-11-28'),
(8866,233,5,'2025-11-29'),
(8872,233,9,'2025-11-30'),
(8910,234,1,'2025-12-02'),
(8912,234,1,'2025-12-04'),
(8914,236,1,'2025-12-04'),
(8915,235,1,'2025-12-04'),
(8921,233,2,'2025-12-04'),
(8923,236,1,'2025-12-05'),
(8924,235,1,'2025-12-05'),
(8953,233,3,'2025-12-05'),
(9004,233,2,'2025-12-06'),
(9021,236,1,'2025-12-07'),
(9031,234,1,'2025-12-08'),
(9033,233,2,'2025-12-08'),
(9046,233,2,'2025-12-09'),
(9048,234,1,'2025-12-09'),
(9052,236,1,'2025-12-09'),
(9054,233,2,'2025-12-10'),
(9055,235,1,'2025-12-10'),
(9074,233,2,'2025-12-12'),
(9122,236,1,'2025-12-13'),
(9129,233,3,'2025-12-13'),
(9153,235,1,'2025-12-13'),
(9185,233,1,'2025-12-15'),
(9188,234,2,'2025-12-15'),
(9194,236,1,'2025-12-15'),
(9204,235,1,'2025-12-16'),
(9206,235,1,'2025-12-18'),
(9211,234,1,'2025-12-19'),
(9225,233,1,'2025-12-20'),
(9263,235,1,'2025-12-22'),
(9265,234,2,'2025-12-23'),
(9291,236,1,'2025-12-23'),
(9294,235,1,'2025-12-24'),
(9303,235,1,'2025-12-25'),
(9336,233,1,'2025-12-25'),
(9350,233,1,'2025-12-26'),
(9351,234,1,'2025-12-26'),
(9393,233,1,'2025-12-28'),
(9404,234,1,'2025-12-28'),
(9407,236,1,'2025-12-28'),
(9415,235,1,'2025-12-28'),
(9423,233,2,'2025-12-29'),
(9454,233,4,'2025-12-30'),
(9485,233,4,'2025-12-31'),
(9511,233,2,'2026-01-01'),
(9525,236,1,'2026-01-01'),
(9529,233,4,'2026-01-02'),
(9535,234,1,'2026-01-02'),
(9537,236,1,'2026-01-02'),
(9561,235,1,'2026-01-02'),
(9580,233,2,'2026-01-03'),
(9587,236,2,'2026-01-03'),
(9590,235,1,'2026-01-03'),
(9621,233,5,'2026-01-04'),
(9645,233,4,'2026-01-05'),
(9648,234,1,'2026-01-05'),
(9684,233,1,'2026-01-06'),
(9692,233,4,'2026-01-07'),
(9697,236,1,'2026-01-07'),
(9698,234,2,'2026-01-07'),
(9707,235,1,'2026-01-07'),
(9710,233,3,'2026-01-08'),
(9742,233,1,'2026-01-09'),
(9746,234,1,'2026-01-09'),
(9751,234,2,'2026-01-10'),
(9769,233,2,'2026-01-10'),
(9781,233,4,'2026-01-11'),
(9808,234,2,'2026-01-12'),
(9812,236,1,'2026-01-12'),
(9821,235,1,'2026-01-12'),
(9831,233,1,'2026-01-13'),
(9838,233,5,'2026-01-14'),
(9871,233,2,'2026-01-15'),
(9879,233,5,'2026-01-16'),
(9954,233,2,'2026-01-17'),
(9961,236,1,'2026-01-17'),
(9966,234,1,'2026-01-17'),
(9973,235,1,'2026-01-17'),
(9978,233,1,'2026-01-18'),
(10009,233,1,'2026-01-19'),
(10040,233,3,'2026-01-21'),
(10051,234,1,'2026-01-22'),
(10052,233,2,'2026-01-22'),
(10054,235,1,'2026-01-22'),
(10072,236,1,'2026-01-22'),
(10092,233,1,'2026-01-23'),
(10108,234,1,'2026-01-23'),
(10111,235,2,'2026-01-23'),
(10130,236,1,'2026-01-24'),
(10132,233,3,'2026-01-24'),
(10162,233,2,'2026-01-25'),
(10207,234,1,'2026-01-28'),
(10208,235,1,'2026-01-28'),
(10210,235,1,'2026-01-29'),
(10219,234,1,'2026-01-29'),
(10240,236,1,'2026-01-29'),
(10267,233,1,'2026-01-29'),
(10293,233,4,'2026-01-30'),
(10305,235,1,'2026-01-30'),
(10312,234,1,'2026-01-30'),
(10316,236,1,'2026-01-30'),
(10372,233,4,'2026-01-31'),
(10402,234,2,'2026-02-01'),
(10404,235,1,'2026-02-01'),
(10405,236,1,'2026-02-01'),
(10449,233,1,'2026-02-02'),
(10481,234,1,'2026-02-04'),
(10482,235,1,'2026-02-04'),
(10484,233,2,'2026-02-04'),
(10485,236,1,'2026-02-04'),
(10509,233,4,'2026-02-10'),
(10535,234,1,'2026-02-11'),
(10538,233,5,'2026-02-11'),
(10541,235,1,'2026-02-11'),
(10565,233,5,'2026-02-12'),
(10571,236,1,'2026-02-12'),
(10607,234,1,'2026-02-12'),
(10621,235,1,'2026-02-12'),
(10628,234,1,'2026-02-13'),
(10629,233,4,'2026-02-13'),
(10649,236,1,'2026-02-13'),
(10660,234,2,'2026-02-14'),
(10662,235,1,'2026-02-14'),
(10675,233,2,'2026-02-14'),
(10697,233,3,'2026-02-15'),
(10712,233,5,'2026-02-16'),
(10720,236,1,'2026-02-16'),
(10737,233,3,'2026-02-17'),
(10746,233,3,'2026-02-18'),
(10753,234,1,'2026-02-18'),
(10755,233,4,'2026-02-19'),
(10773,233,4,'2026-02-20'),
(10775,236,1,'2026-02-20'),
(10795,233,5,'2026-02-21'),
(10811,234,1,'2026-02-21'),
(10816,233,4,'2026-02-22'),
(10836,233,2,'2026-02-23'),
(10849,234,2,'2026-02-24'),
(10850,233,4,'2026-02-24'),
(10858,236,1,'2026-02-24'),
(10861,235,1,'2026-02-24'),
(10879,233,2,'2026-02-25'),
(10898,235,1,'2026-02-25'),
(10923,233,3,'2026-02-27'),
(10928,236,1,'2026-02-27'),
(10938,233,4,'2026-02-28'),
(10951,233,3,'2026-03-01'),
(10965,233,4,'2026-03-02'),
(10989,233,3,'2026-03-03'),
(11026,233,2,'2026-03-04'),
(11042,234,1,'2026-03-04'),
(11056,235,1,'2026-03-04'),
(11058,233,5,'2026-03-05'),
(11089,235,2,'2026-03-05'),
(11095,234,1,'2026-03-05'),
(11097,236,2,'2026-03-05'),
(11165,233,3,'2026-03-06'),
(11179,233,3,'2026-03-07'),
(11199,236,1,'2026-03-08'),
(11209,233,2,'2026-03-14'),
(11220,233,4,'2026-03-15'),
(11226,236,1,'2026-03-15'),
(11248,233,3,'2026-03-16'),
(11255,233,5,'2026-03-17'),
(11272,233,3,'2026-03-18'),
(11280,234,1,'2026-03-18'),
(11283,233,5,'2026-03-19'),
(11293,234,1,'2026-03-19'),
(11310,233,4,'2026-03-20'),
(11337,233,4,'2026-03-21'),
(11355,236,1,'2026-03-21'),
(11367,233,4,'2026-03-22'),
(11384,233,4,'2026-03-23'),
(11389,236,1,'2026-03-23'),
(11397,233,4,'2026-03-24'),
(11434,236,2,'2026-03-25'),
(11442,233,5,'2026-03-25'),
(11444,235,2,'2026-03-25'),
(11445,234,1,'2026-03-25'),
(11512,235,1,'2026-03-26'),
(11532,234,1,'2026-03-26'),
(11537,236,2,'2026-03-26'),
(11538,233,2,'2026-03-26'),
(11565,233,2,'2026-03-27'),
(11596,233,2,'2026-03-28'),
(11611,233,7,'2026-03-29'),
(11616,236,1,'2026-03-29'),
(11619,235,1,'2026-03-29'),
(11626,234,2,'2026-03-29'),
(11658,233,2,'2026-03-30'),
(11672,233,5,'2026-03-31'),
(11701,233,5,'2026-04-01'),
(11708,236,1,'2026-04-01'),
(11710,234,2,'2026-04-01'),
(11711,235,2,'2026-04-01'),
(11818,233,2,'2026-04-02'),
(11827,236,2,'2026-04-02'),
(11840,233,4,'2026-04-03'),
(11865,233,3,'2026-04-04'),
(11875,233,3,'2026-04-05'),
(11894,234,1,'2026-04-06'),
(11899,233,3,'2026-04-06'),
(11904,236,1,'2026-04-06'),
(11914,233,1,'2026-04-07'),
(11918,233,5,'2026-04-08'),
(11926,234,1,'2026-04-08'),
(11934,233,5,'2026-04-09'),
(11935,236,3,'2026-04-09'),
(11938,235,2,'2026-04-09'),
(11949,234,2,'2026-04-09'),
(12032,233,4,'2026-04-10'),
(12044,233,3,'2026-04-11'),
(12051,235,1,'2026-04-11'),
(12060,236,1,'2026-04-11'),
(12062,233,5,'2026-04-12'),
(12078,233,6,'2026-04-13'),
(12092,236,1,'2026-04-13'),
(12115,233,4,'2026-04-14'),
(12135,235,1,'2026-04-14'),
(12143,233,6,'2026-04-15'),
(12155,236,1,'2026-04-15'),
(12174,233,4,'2026-04-16'),
(12178,234,1,'2026-04-16'),
(12179,236,1,'2026-04-16'),
(12193,235,1,'2026-04-16'),
(12214,233,2,'2026-04-17'),
(12223,233,4,'2026-04-18'),
(12240,233,3,'2026-04-19'),
(12245,234,2,'2026-04-19'),
(12246,236,1,'2026-04-19'),
(12247,235,2,'2026-04-19'),
(12351,233,2,'2026-04-20'),
(12360,233,3,'2026-04-21'),
(12362,234,1,'2026-04-21'),
(12373,233,3,'2026-04-22'),
(12383,235,1,'2026-04-22'),
(12386,234,1,'2026-04-22'),
(12392,236,1,'2026-04-22'),
(12396,233,1,'2026-04-23'),
(12401,236,1,'2026-04-23'),
(12412,233,1,'2026-04-24'),
(12417,233,2,'2026-04-25'),
(12420,236,1,'2026-04-25'),
(12421,234,1,'2026-04-25'),
(12440,233,3,'2026-04-26'),
(12448,233,2,'2026-04-27'),
(12455,234,1,'2026-04-28'),
(12460,233,2,'2026-04-28'),
(12468,236,1,'2026-04-29'),
(12469,233,1,'2026-04-29'),
(12474,233,2,'2026-04-30'),
(12486,233,2,'2026-05-01'),
(12500,233,3,'2026-05-02'),
(12520,235,1,'2026-05-03'),
(12528,234,2,'2026-05-03'),
(12532,236,1,'2026-05-03'),
(12535,233,1,'2026-05-03'),
(12541,233,2,'2026-05-04'),
(12568,233,3,'2026-05-05'),
(12569,235,1,'2026-05-05'),
(12588,236,1,'2026-05-05'),
(12611,233,2,'2026-05-07'),
(12617,236,1,'2026-05-07'),
(12620,233,4,'2026-05-08'),
(12640,233,4,'2026-05-09'),
(12650,233,3,'2026-05-10'),
(12670,233,2,'2026-05-11'),
(12675,233,1,'2026-05-12'),
(12680,233,2,'2026-05-13'),
(12685,235,1,'2026-05-13'),
(12688,236,1,'2026-05-13'),
(12691,233,4,'2026-05-14'),
(12705,233,4,'2026-05-15'),
(12709,236,1,'2026-05-15'),
(12729,233,3,'2026-05-16'),
(12737,233,1,'2026-05-17'),
(12745,233,2,'2026-05-18'),
(12755,233,1,'2026-05-19'),
(12757,234,1,'2026-05-19'),
(12758,235,1,'2026-05-19'),
(12761,233,2,'2026-05-20'),
(12764,236,1,'2026-05-20'),
(12765,234,1,'2026-05-20'),
(12769,234,1,'2026-05-21'),
(12772,233,1,'2026-05-21'),
(12780,233,2,'2026-05-22'),
(12804,233,1,'2026-05-24'),
(12823,235,1,'2026-05-25'),
(12844,233,1,'2026-05-26'),
(12867,236,2,'2026-05-26'),
(12868,235,1,'2026-05-26'),
(12879,234,1,'2026-05-26'),
(12924,233,3,'2026-05-29'),
(12925,234,1,'2026-05-29'),
(12928,236,1,'2026-05-29'),
(12930,236,1,'2026-05-30'),
(12940,236,1,'2026-05-31'),
(12941,235,1,'2026-05-31'),
(12942,233,1,'2026-05-31'),
(12944,236,1,'2026-06-01'),
(12953,235,1,'2026-06-01'),
(12958,234,1,'2026-06-01'),
(12970,233,2,'2026-06-01'),
(13015,233,1,'2026-06-02'),
(13017,235,1,'2026-06-03'),
(13020,234,1,'2026-06-03'),
(13023,234,3,'2026-06-04'),
(13036,233,1,'2026-06-04'),
(13098,235,1,'2026-06-04'),
(13106,234,4,'2026-06-05'),
(13114,233,1,'2026-06-05'),
(13151,234,1,'2026-06-06'),
(13157,235,1,'2026-06-06'),
(13175,233,1,'2026-06-06'),
(13194,236,1,'2026-06-08'),
(13195,233,1,'2026-06-08'),
(13208,234,2,'2026-06-11'),
(13218,235,1,'2026-06-12'),
(13220,233,3,'2026-06-12'),
(13227,233,1,'2026-06-13'),
(13248,233,4,'2026-06-14'),
(13258,236,1,'2026-06-14'),
(13278,235,1,'2026-06-14'),
(13284,236,1,'2026-06-15'),
(13290,234,2,'2026-06-15'),
(13298,233,4,'2026-06-16'),
(13305,236,1,'2026-06-16'),
(13323,233,3,'2026-06-17'),
(13337,236,1,'2026-06-17'),
(13343,233,1,'2026-06-18'),
(13346,234,1,'2026-06-19'),
(13351,235,1,'2026-06-19'),
(13352,233,1,'2026-06-19'),
(13354,236,1,'2026-06-20'),
(13362,233,2,'2026-06-21'),
(13371,236,2,'2026-06-21'),
(13379,235,1,'2026-06-21'),
(13382,234,2,'2026-06-21'),
(13386,234,1,'2026-06-22'),
(13389,233,1,'2026-06-22'),
(13390,234,2,'2026-06-23'),
(13400,235,2,'2026-06-26'),
(13401,234,2,'2026-06-26'),
(13409,234,2,'2026-06-28'),
(13412,236,1,'2026-06-28'),
(13414,233,1,'2026-06-28'),
(13422,236,1,'2026-06-29'),
(13424,234,3,'2026-06-29'),
(13431,233,1,'2026-06-29'),
(13448,233,2,'2026-06-30'),
(13469,233,2,'2026-07-01'),
(13498,235,1,'2026-07-02'),
(13499,234,2,'2026-07-02'),
(13506,233,3,'2026-07-03'),
(13540,233,2,'2026-07-04'),
(13564,235,1,'2026-07-05'),
(13568,234,1,'2026-07-05'),
(13575,236,1,'2026-07-05'),
(13584,234,1,'2026-07-06'),
(13616,235,1,'2026-07-06'),
(13623,236,1,'2026-07-06'),
(13624,233,1,'2026-07-06'),
(13686,233,1,'2026-07-08'),
(13696,234,1,'2026-07-10'),
(13698,236,1,'2026-07-10'),
(13702,233,2,'2026-07-11'),
(13718,234,1,'2026-07-11'),
(13725,235,2,'2026-07-11'),
(13759,236,1,'2026-07-11'),
(13782,236,2,'2026-07-12'),
(13785,233,1,'2026-07-12'),
(13803,235,1,'2026-07-12'),
(13811,234,2,'2026-07-12'),
(13861,235,1,'2026-07-16'),
(13863,234,1,'2026-07-17'),
(13864,236,1,'2026-07-17'),
(13867,233,1,'2026-07-18'),
(13882,233,2,'2026-07-22'),
(13884,236,1,'2026-07-22'),
(13886,235,1,'2026-07-22'),
(13888,234,1,'2026-07-22'),
(13901,236,1,'2026-07-23'),
(13904,235,1,'2026-07-23'),
(13924,234,1,'2026-07-24'),
(13933,233,1,'2026-07-24'),
(13951,235,2,'2026-07-25'),
(13953,236,2,'2026-07-25'),
(13971,234,1,'2026-07-26'),
(13972,236,1,'2026-07-26'),
(13973,235,2,'2026-07-26'),
(13974,233,1,'2026-07-26'),
(14049,236,1,'2026-07-27'),
(14057,233,2,'2026-07-27'),
(14091,236,1,'2026-07-29'),
(14099,235,1,'2026-07-30'),
(14100,236,1,'2026-07-30'),
(14104,234,1,'2026-07-30'),
(14113,234,1,'2026-07-31'),
(14114,236,1,'2026-08-01'),
(14117,234,1,'2026-08-01'),
(14120,235,1,'2026-08-01'),
(14131,234,1,'2026-08-03'),
(14132,233,1,'2026-08-04'),
(14133,234,1,'2026-08-04'),
(14134,233,1,'2026-08-05'),
(14135,234,2,'2026-08-05'),
(14137,233,3,'2026-08-07'),
(14138,236,1,'2026-08-07'),
(14141,235,1,'2026-08-08'),
(14142,234,1,'2026-08-08'),
(14143,233,1,'2026-08-12'),
(14144,234,1,'2026-08-12'),
(14145,235,1,'2026-08-12'),
(14146,236,1,'2026-08-12'),
(14147,233,2,'2026-08-14'),
(14149,236,1,'2026-08-14'),
(14150,235,1,'2026-08-14'),
(14151,236,1,'2026-08-15'),
(14152,234,1,'2026-08-15'),
(14153,234,1,'2026-08-16'),
(14154,235,1,'2026-08-16'),
(14155,233,2,'2026-08-16'),
(14157,233,2,'2026-08-17'),
(14158,235,1,'2026-08-17'),
(14160,236,1,'2026-08-17'),
(14161,235,1,'2026-08-19'),
(14162,234,1,'2026-08-19'),
(14163,234,1,'2026-08-20'),
(14164,233,1,'2026-08-21'),
(14165,236,1,'2026-08-22'),
(14166,234,1,'2026-08-22'),
(14167,235,1,'2026-08-23'),
(14168,233,1,'2026-08-23');
/*!40000 ALTER TABLE `ec_product_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_product_with_attribute_set`
--

DROP TABLE IF EXISTS `ec_product_with_attribute_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_product_with_attribute_set` (
  `attribute_set_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `order` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`product_id`,`attribute_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_product_with_attribute_set`
--

LOCK TABLES `ec_product_with_attribute_set` WRITE;
/*!40000 ALTER TABLE `ec_product_with_attribute_set` DISABLE KEYS */;
INSERT INTO `ec_product_with_attribute_set` VALUES
(1,236,0);
/*!40000 ALTER TABLE `ec_product_with_attribute_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_products`
--

DROP TABLE IF EXISTS `ec_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `images` text DEFAULT NULL,
  `sku` varchar(191) DEFAULT NULL,
  `order` int(10) unsigned NOT NULL DEFAULT 0,
  `quantity` int(10) unsigned DEFAULT NULL,
  `allow_checkout_when_out_of_stock` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `with_storehouse_management` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_featured` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `brand_id` bigint(20) unsigned DEFAULT NULL,
  `is_variation` tinyint(4) NOT NULL DEFAULT 0,
  `sale_type` tinyint(4) NOT NULL DEFAULT 0,
  `price` double unsigned DEFAULT NULL,
  `sale_price` double unsigned DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `length` double(8,2) DEFAULT NULL,
  `wide` double(8,2) DEFAULT NULL,
  `height` double(8,2) DEFAULT NULL,
  `weight` double(8,2) DEFAULT NULL,
  `tax_id` bigint(20) unsigned DEFAULT NULL,
  `views` bigint(20) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stock_status` varchar(191) DEFAULT 'in_stock',
  `created_by_id` bigint(20) unsigned DEFAULT 0,
  `created_by_type` varchar(255) NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  `image` varchar(255) DEFAULT NULL,
  `product_type` varchar(60) DEFAULT 'physical',
  `barcode` varchar(50) DEFAULT NULL,
  `cost_per_item` double DEFAULT NULL,
  `generate_license_code` tinyint(1) NOT NULL DEFAULT 0,
  `store_id` bigint(20) unsigned DEFAULT NULL,
  `approved_by` bigint(20) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ec_products_brand_id_status_is_variation_created_at_index` (`brand_id`,`status`,`is_variation`,`created_at`),
  KEY `sale_type_index` (`sale_type`),
  KEY `start_date_index` (`start_date`),
  KEY `end_date_index` (`end_date`),
  KEY `sale_price_index` (`sale_price`),
  KEY `is_variation_index` (`is_variation`),
  KEY `ec_products_sku_index` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=238 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_products`
--

LOCK TABLES `ec_products` WRITE;
/*!40000 ALTER TABLE `ec_products` DISABLE KEYS */;
INSERT INTO `ec_products` VALUES
(233,'Blood Pressure Machine','<p>Sample product</p>','<p>II mashini ni genje deadly </p>','published','[\"istockphoto-182226541-612x612.jpg\"]','FM-2443-VKWX',0,0,0,0,1,NULL,0,0,3000,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL,735,'2024-05-29 03:53:38','2024-05-29 14:20:59','in_stock',1,'Botble\\ACL\\Models\\User','istockphoto-182226541-612x612.jpg','physical',NULL,3000,0,10,0),
(234,'Glucometer','<p>Another one </p>','<p>Ata ii ni deadly </p>','published','[\"images.jpeg\"]','FM-2443-ENER',0,0,0,0,1,NULL,0,0,2500,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL,247,'2024-05-29 14:15:57','2024-05-29 14:44:19','in_stock',1,'Botble\\ACL\\Models\\User','images.jpeg','physical',NULL,0,0,10,0),
(235,'Glucometer','<p>deadly deadly</p>','<p>Very nice </p>','published','[\"download.jpg\"]','FM-2443-QZYM',0,7,0,1,1,NULL,0,0,2000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,211,'2024-05-29 14:43:51','2024-05-29 14:44:53','in_stock',1,'Botble\\ACL\\Models\\User','download.jpg','digital',NULL,0,0,NULL,0),
(236,'Stethoscope','<p>Auscultation on point. </p>','<p>You can auscultate feelings with this baiby, hehe!!</p>','published','[\"littmann-classic-iii-chocolate-600x600.png\"]','FM-2443-LI8O',0,0,0,0,1,NULL,0,0,6000,NULL,NULL,NULL,0.00,0.00,0.00,180.00,NULL,232,'2024-06-03 19:52:15','2024-06-03 20:11:52','in_stock',1,'Botble\\ACL\\Models\\User','littmann-classic-iii-chocolate-600x600.png','physical',NULL,6000,0,10,0),
(237,'Stethoscope','',NULL,'published','[\"littmann-classic-iii-chocolate-600x600.png\"]','FM-2443-LI8O',0,NULL,0,0,0,NULL,1,0,6000,NULL,NULL,NULL,0.00,0.00,0.00,180.00,NULL,0,'2024-06-03 19:52:15','2024-06-03 20:11:52','in_stock',1,'Botble\\ACL\\Models\\User',NULL,'physical',NULL,4500,0,NULL,0);
/*!40000 ALTER TABLE `ec_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_products_translations`
--

DROP TABLE IF EXISTS `ec_products_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_products_translations` (
  `lang_code` varchar(191) NOT NULL,
  `ec_products_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`ec_products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_products_translations`
--

LOCK TABLES `ec_products_translations` WRITE;
/*!40000 ALTER TABLE `ec_products_translations` DISABLE KEYS */;
INSERT INTO `ec_products_translations` VALUES
('en_US',233,'Blood Pressure Machine','<p>Sample product</p>','<p>II mashini ni genje deadly&nbsp;</p>'),
('en_US',234,'Glucometer','<p>Another one </p>','<p>Ata ii ni deadly </p>'),
('en_US',235,'Glucometer','<p>deadly deadly</p>','<p>Very nice </p>'),
('en_US',236,'Stethoscope','<p>Auscultation on point. </p>','<p>You can auscultate feelings with this baiby, hehe!!</p>'),
('en_US',237,'Stethoscope','<p>Auscultation on point. </p>','<p>You can auscultate feelings with this baiby, hehe!!</p>');
/*!40000 ALTER TABLE `ec_products_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_review_replies`
--

DROP TABLE IF EXISTS `ec_review_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_review_replies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `review_id` bigint(20) unsigned NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_review_replies_review_id_user_id_unique` (`review_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_review_replies`
--

LOCK TABLES `ec_review_replies` WRITE;
/*!40000 ALTER TABLE `ec_review_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_review_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_reviews`
--

DROP TABLE IF EXISTS `ec_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `star` double(8,2) NOT NULL,
  `comment` text NOT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `images` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_reviews_product_id_customer_id_unique` (`product_id`,`customer_id`),
  KEY `ec_reviews_product_id_customer_id_status_created_at_index` (`product_id`,`customer_id`,`status`,`created_at`),
  KEY `review_relation_index` (`product_id`,`customer_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_reviews`
--

LOCK TABLES `ec_reviews` WRITE;
/*!40000 ALTER TABLE `ec_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_shipment_histories`
--

DROP TABLE IF EXISTS `ec_shipment_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_shipment_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(120) NOT NULL,
  `description` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `shipment_id` bigint(20) unsigned NOT NULL,
  `order_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_type` varchar(255) NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_shipment_histories`
--

LOCK TABLES `ec_shipment_histories` WRITE;
/*!40000 ALTER TABLE `ec_shipment_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_shipment_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_shipments`
--

DROP TABLE IF EXISTS `ec_shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_shipments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `weight` double(8,2) DEFAULT 0.00,
  `shipment_id` varchar(120) DEFAULT NULL,
  `rate_id` varchar(120) DEFAULT NULL,
  `note` varchar(120) DEFAULT NULL,
  `status` varchar(120) NOT NULL DEFAULT 'pending',
  `cod_amount` decimal(15,2) DEFAULT 0.00,
  `cod_status` varchar(60) NOT NULL DEFAULT 'pending',
  `cross_checking_status` varchar(60) NOT NULL DEFAULT 'pending',
  `price` decimal(15,2) DEFAULT 0.00,
  `store_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tracking_id` varchar(191) DEFAULT NULL,
  `shipping_company_name` varchar(191) DEFAULT NULL,
  `tracking_link` varchar(191) DEFAULT NULL,
  `estimate_date_shipped` datetime DEFAULT NULL,
  `date_shipped` datetime DEFAULT NULL,
  `label_url` text DEFAULT NULL,
  `metadata` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_shipments`
--

LOCK TABLES `ec_shipments` WRITE;
/*!40000 ALTER TABLE `ec_shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_shipping`
--

DROP TABLE IF EXISTS `ec_shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_shipping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) DEFAULT NULL,
  `country` varchar(120) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_shipping`
--

LOCK TABLES `ec_shipping` WRITE;
/*!40000 ALTER TABLE `ec_shipping` DISABLE KEYS */;
INSERT INTO `ec_shipping` VALUES
(1,'All',NULL,'2024-02-24 01:36:38','2024-02-24 01:36:38');
/*!40000 ALTER TABLE `ec_shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_shipping_rule_items`
--

DROP TABLE IF EXISTS `ec_shipping_rule_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_shipping_rule_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `shipping_rule_id` bigint(20) unsigned NOT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `adjustment_price` decimal(15,2) DEFAULT 0.00,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_shipping_rule_items`
--

LOCK TABLES `ec_shipping_rule_items` WRITE;
/*!40000 ALTER TABLE `ec_shipping_rule_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_shipping_rule_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_shipping_rules`
--

DROP TABLE IF EXISTS `ec_shipping_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_shipping_rules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `shipping_id` bigint(20) unsigned NOT NULL,
  `type` varchar(24) DEFAULT 'based_on_price',
  `from` decimal(15,2) DEFAULT 0.00,
  `to` decimal(15,2) DEFAULT 0.00,
  `price` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_shipping_rules`
--

LOCK TABLES `ec_shipping_rules` WRITE;
/*!40000 ALTER TABLE `ec_shipping_rules` DISABLE KEYS */;
INSERT INTO `ec_shipping_rules` VALUES
(1,'Free delivery',1,'based_on_price',0.00,NULL,0.00,'2024-02-24 01:36:38','2024-02-24 01:36:38');
/*!40000 ALTER TABLE `ec_shipping_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_store_locators`
--

DROP TABLE IF EXISTS `ec_store_locators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_store_locators` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `is_shipping_location` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_store_locators`
--

LOCK TABLES `ec_store_locators` WRITE;
/*!40000 ALTER TABLE `ec_store_locators` DISABLE KEYS */;
INSERT INTO `ec_store_locators` VALUES
(1,'Farmart','sales@botble.com','1800979769','502 New Street','AU','Brighton VIC','Brighton VIC',1,1,'2024-02-24 01:36:52','2024-02-24 01:36:52');
/*!40000 ALTER TABLE `ec_store_locators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_tax_products`
--

DROP TABLE IF EXISTS `ec_tax_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_tax_products` (
  `tax_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`tax_id`),
  KEY `ec_tax_products_tax_id_index` (`tax_id`),
  KEY `ec_tax_products_product_id_index` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_tax_products`
--

LOCK TABLES `ec_tax_products` WRITE;
/*!40000 ALTER TABLE `ec_tax_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_tax_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_tax_rules`
--

DROP TABLE IF EXISTS `ec_tax_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_tax_rules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tax_id` bigint(20) unsigned NOT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_tax_rules`
--

LOCK TABLES `ec_tax_rules` WRITE;
/*!40000 ALTER TABLE `ec_tax_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_tax_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_taxes`
--

DROP TABLE IF EXISTS `ec_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_taxes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) DEFAULT NULL,
  `percentage` double(8,6) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_taxes`
--

LOCK TABLES `ec_taxes` WRITE;
/*!40000 ALTER TABLE `ec_taxes` DISABLE KEYS */;
INSERT INTO `ec_taxes` VALUES
(1,'VAT',10.000000,1,'published','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(2,'None',0.000000,2,'published','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(3,'Import Tax',15.000000,3,'published','2024-02-24 01:36:38','2024-02-24 01:36:38');
/*!40000 ALTER TABLE `ec_taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ec_wish_lists`
--

DROP TABLE IF EXISTS `ec_wish_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ec_wish_lists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wishlist_relation_index` (`product_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ec_wish_lists`
--

LOCK TABLES `ec_wish_lists` WRITE;
/*!40000 ALTER TABLE `ec_wish_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `ec_wish_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq_categories`
--

DROP TABLE IF EXISTS `faq_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `order` tinyint(4) NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq_categories`
--

LOCK TABLES `faq_categories` WRITE;
/*!40000 ALTER TABLE `faq_categories` DISABLE KEYS */;
INSERT INTO `faq_categories` VALUES
(1,'SHIPPING',0,'published','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(2,'PAYMENT',1,'published','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(3,'ORDER &amp; RETURNS',2,'published','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL);
/*!40000 ALTER TABLE `faq_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq_categories_translations`
--

DROP TABLE IF EXISTS `faq_categories_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_categories_translations` (
  `lang_code` varchar(20) NOT NULL,
  `faq_categories_id` bigint(20) unsigned NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`faq_categories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq_categories_translations`
--

LOCK TABLES `faq_categories_translations` WRITE;
/*!40000 ALTER TABLE `faq_categories_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `faq_categories_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `category_id` bigint(20) unsigned NOT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs`
--

LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
INSERT INTO `faqs` VALUES
(1,'What Shipping Methods Are Available?','Ex Portland Pitchfork irure mustache. Eutra fap before they sold out literally. Aliquip ugh bicycle rights actually mlkshk, seitan squid craft beer tempor.',1,'published','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(2,'Do You Ship Internationally?','Hoodie tote bag mixtape tofu. Typewriter jean shorts wolf quinoa, messenger bag organic freegan cray.',1,'published','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(3,'How Long Will It Take To Get My Package?','Swag slow-carb quinoa VHS typewriter pork belly brunch, paleo single-origin coffee Wes Anderson. Flexitarian Pitchfork forage, literally paleo fap pour-over. Wes Anderson Pinterest YOLO fanny pack meggings, deep v XOXO chambray sustainable slow-carb raw denim church-key fap chillwave Etsy. +1 typewriter kitsch, American Apparel tofu Banksy Vice.',1,'published','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(4,'What Payment Methods Are Accepted?','Fashion axe DIY jean shorts, swag kale chips meh polaroid kogi butcher Wes Anderson chambray next level semiotics gentrify yr. Voluptate photo booth fugiat Vice. Austin sed Williamsburg, ea labore raw denim voluptate cred proident mixtape excepteur mustache. Twee chia photo booth readymade food truck, hoodie roof party swag keytar PBR DIY.',2,'published','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(5,'Is Buying On-Line Safe?','Art party authentic freegan semiotics jean shorts chia cred. Neutra Austin roof party Brooklyn, synth Thundercats swag 8-bit photo booth. Plaid letterpress leggings craft beer meh ethical Pinterest.',2,'published','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(6,'How do I place an Order?','Keytar cray slow-carb, Godard banh mi salvia pour-over. Slow-carb Odd Future seitan normcore. Master cleanse American Apparel gentrify flexitarian beard slow-carb next level. Raw denim polaroid paleo farm-to-table, put a bird on it lo-fi tattooed Wes Anderson Pinterest letterpress. Fingerstache McSweeney’s pour-over, letterpress Schlitz photo booth master cleanse bespoke hashtag chillwave gentrify.',3,'published','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(7,'How Can I Cancel Or Change My Order?','Plaid letterpress leggings craft beer meh ethical Pinterest. Art party authentic freegan semiotics jean shorts chia cred. Neutra Austin roof party Brooklyn, synth Thundercats swag 8-bit photo booth.',3,'published','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(8,'Do I need an account to place an order?','Thundercats swag 8-bit photo booth. Plaid letterpress leggings craft beer meh ethical Pinterest. Twee chia photo booth readymade food truck, hoodie roof party swag keytar PBR DIY. Cray ugh 3 wolf moon fap, fashion axe irony butcher cornhole typewriter chambray VHS banjo street art.',3,'published','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(9,'How Do I Track My Order?','Keytar cray slow-carb, Godard banh mi salvia pour-over. Slow-carb @Odd Future seitan normcore. Master cleanse American Apparel gentrify flexitarian beard slow-carb next level.',3,'published','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(10,'How Can I Return a Product?','Kale chips Truffaut Williamsburg, hashtag fixie Pinterest raw denim c hambray drinking vinegar Carles street art Bushwick gastropub. Wolf Tumblr paleo church-key. Plaid food truck Echo Park YOLO bitters hella, direct trade Thundercats leggings quinoa before they sold out. You probably haven’t heard of them wayfarers authentic umami drinking vinegar Pinterest Cosby sweater, fingerstache fap High Life.',3,'published','2024-02-24 01:36:33','2024-02-24 01:36:33');
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs_translations`
--

DROP TABLE IF EXISTS `faqs_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs_translations` (
  `lang_code` varchar(20) NOT NULL,
  `faqs_id` bigint(20) unsigned NOT NULL,
  `question` text DEFAULT NULL,
  `answer` text DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`faqs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs_translations`
--

LOCK TABLES `faqs_translations` WRITE;
/*!40000 ALTER TABLE `faqs_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `faqs_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_meta`
--

DROP TABLE IF EXISTS `language_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `language_meta` (
  `lang_meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lang_meta_code` varchar(20) DEFAULT NULL,
  `lang_meta_origin` varchar(32) NOT NULL,
  `reference_id` bigint(20) unsigned NOT NULL,
  `reference_type` varchar(120) NOT NULL,
  PRIMARY KEY (`lang_meta_id`),
  KEY `language_meta_reference_id_index` (`reference_id`),
  KEY `meta_code_index` (`lang_meta_code`),
  KEY `meta_origin_index` (`lang_meta_origin`),
  KEY `meta_reference_type_index` (`reference_type`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_meta`
--

LOCK TABLES `language_meta` WRITE;
/*!40000 ALTER TABLE `language_meta` DISABLE KEYS */;
INSERT INTO `language_meta` VALUES
(1,'en_US','40d30f12e58e7d687ee6a2a360ccc0c1',1,'Botble\\SimpleSlider\\Models\\SimpleSlider'),
(2,'en_US','93a4c676953b49f802f33f2a25530c85',1,'Botble\\Menu\\Models\\MenuLocation'),
(3,'en_US','166636f4a90f8e2ae489156ed2403098',1,'Botble\\Menu\\Models\\Menu'),
(4,'en_US','707fdc06f55c28116a102e1c0207d7b2',2,'Botble\\Menu\\Models\\MenuLocation'),
(5,'en_US','064cea8fd0164e635973d39f98988c94',2,'Botble\\Menu\\Models\\Menu'),
(6,'en_US','d4e67489c01339b235130547dd2e6d2d',3,'Botble\\Menu\\Models\\Menu'),
(7,'en_US','74df330271101fec1f4738360f4d0abd',4,'Botble\\Menu\\Models\\Menu'),
(8,'en_US','b3036987bb2197faf30576c1654b84b2',5,'Botble\\Menu\\Models\\Menu'),
(12,'en_AU','a782aa6ba85b88ff28656b5da9b8daf2',4,'Botble\\SimpleSlider\\Models\\SimpleSlider'),
(14,'en_AU','9152fc22604eb18474ea263a7a33403f',6,'Botble\\SimpleSlider\\Models\\SimpleSlider');
/*!40000 ALTER TABLE `language_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `lang_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lang_name` varchar(120) NOT NULL,
  `lang_locale` varchar(20) NOT NULL,
  `lang_code` varchar(20) NOT NULL,
  `lang_flag` varchar(20) DEFAULT NULL,
  `lang_is_default` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `lang_order` int(11) NOT NULL DEFAULT 0,
  `lang_is_rtl` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`lang_id`),
  KEY `lang_locale_index` (`lang_locale`),
  KEY `lang_code_index` (`lang_code`),
  KEY `lang_is_default_index` (`lang_is_default`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES
(1,'English','en','en_US','us',0,0,0),
(2,'English','en','en_AU','au',1,0,0);
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_files`
--

DROP TABLE IF EXISTS `media_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `alt` varchar(255) DEFAULT NULL,
  `folder_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `mime_type` varchar(120) NOT NULL,
  `size` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `options` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_files_user_id_index` (`user_id`),
  KEY `media_files_index` (`folder_id`,`user_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_files`
--

LOCK TABLES `media_files` WRITE;
/*!40000 ALTER TABLE `media_files` DISABLE KEYS */;
INSERT INTO `media_files` VALUES
(1,0,'1','1',1,'image/png',5403,'brands/1.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(2,0,'2','2',1,'image/png',5403,'brands/2.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(3,0,'3','3',1,'image/png',5403,'brands/3.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(4,0,'4','4',1,'image/png',5403,'brands/4.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(5,0,'1','1',2,'image/png',5327,'product-categories/1.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(6,0,'2','2',2,'image/png',5327,'product-categories/2.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(7,0,'3','3',2,'image/png',5327,'product-categories/3.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(8,0,'4','4',2,'image/png',5327,'product-categories/4.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(9,0,'5','5',2,'image/png',5327,'product-categories/5.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(10,0,'6','6',2,'image/png',5327,'product-categories/6.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(11,0,'7','7',2,'image/png',5327,'product-categories/7.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(12,0,'8','8',2,'image/png',5327,'product-categories/8.png','[]','2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(13,0,'1','1',3,'image/jpeg',9803,'customers/1.jpg','[]','2024-02-24 01:36:34','2024-02-24 01:36:34',NULL),
(14,0,'10','10',3,'image/jpeg',9803,'customers/10.jpg','[]','2024-02-24 01:36:34','2024-02-24 01:36:34',NULL),
(15,0,'2','2',3,'image/jpeg',9803,'customers/2.jpg','[]','2024-02-24 01:36:34','2024-02-24 01:36:34',NULL),
(16,0,'3','3',3,'image/jpeg',9803,'customers/3.jpg','[]','2024-02-24 01:36:34','2024-02-24 01:36:34',NULL),
(17,0,'4','4',3,'image/jpeg',9803,'customers/4.jpg','[]','2024-02-24 01:36:34','2024-02-24 01:36:34',NULL),
(18,0,'5','5',3,'image/jpeg',9803,'customers/5.jpg','[]','2024-02-24 01:36:34','2024-02-24 01:36:34',NULL),
(19,0,'6','6',3,'image/jpeg',9803,'customers/6.jpg','[]','2024-02-24 01:36:34','2024-02-24 01:36:34',NULL),
(20,0,'7','7',3,'image/jpeg',9803,'customers/7.jpg','[]','2024-02-24 01:36:34','2024-02-24 01:36:34',NULL),
(21,0,'8','8',3,'image/jpeg',9803,'customers/8.jpg','[]','2024-02-24 01:36:34','2024-02-24 01:36:34',NULL),
(22,0,'9','9',3,'image/jpeg',9803,'customers/9.jpg','[]','2024-02-24 01:36:34','2024-02-24 01:36:34',NULL),
(23,0,'1','1',4,'image/jpeg',9803,'products/1.jpg','[]','2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(24,0,'10-1','10-1',4,'image/jpeg',9803,'products/10-1.jpg','[]','2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(25,0,'10-2','10-2',4,'image/jpeg',9803,'products/10-2.jpg','[]','2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(26,0,'10','10',4,'image/jpeg',9803,'products/10.jpg','[]','2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(27,0,'11-1','11-1',4,'image/jpeg',9803,'products/11-1.jpg','[]','2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(28,0,'11-2','11-2',4,'image/jpeg',9803,'products/11-2.jpg','[]','2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(29,0,'11-3','11-3',4,'image/jpeg',9803,'products/11-3.jpg','[]','2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(30,0,'11','11',4,'image/jpeg',9803,'products/11.jpg','[]','2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(31,0,'12-1','12-1',4,'image/jpeg',9803,'products/12-1.jpg','[]','2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(32,0,'12-2','12-2',4,'image/jpeg',9803,'products/12-2.jpg','[]','2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(33,0,'12-3','12-3',4,'image/jpeg',9803,'products/12-3.jpg','[]','2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(34,0,'12','12',4,'image/jpeg',9803,'products/12.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(35,0,'13-1','13-1',4,'image/jpeg',9803,'products/13-1.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(36,0,'13','13',4,'image/jpeg',9803,'products/13.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(37,0,'14','14',4,'image/jpeg',9803,'products/14.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(38,0,'15-1','15-1',4,'image/jpeg',9803,'products/15-1.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(39,0,'15','15',4,'image/jpeg',9803,'products/15.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(40,0,'16','16',4,'image/jpeg',9803,'products/16.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(41,0,'17-1','17-1',4,'image/jpeg',9803,'products/17-1.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(42,0,'17-2','17-2',4,'image/jpeg',9803,'products/17-2.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(43,0,'17-3','17-3',4,'image/jpeg',9803,'products/17-3.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(44,0,'17','17',4,'image/jpeg',9803,'products/17.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(45,0,'18-1','18-1',4,'image/jpeg',9803,'products/18-1.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(46,0,'18-2','18-2',4,'image/jpeg',9803,'products/18-2.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(47,0,'18-3','18-3',4,'image/jpeg',9803,'products/18-3.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(48,0,'18','18',4,'image/jpeg',9803,'products/18.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(49,0,'19-1','19-1',4,'image/jpeg',9803,'products/19-1.jpg','[]','2024-02-24 01:36:39','2024-02-24 01:36:39',NULL),
(50,0,'19-2','19-2',4,'image/jpeg',9803,'products/19-2.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(51,0,'19-3','19-3',4,'image/jpeg',9803,'products/19-3.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(52,0,'19','19',4,'image/jpeg',9803,'products/19.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(53,0,'2-1','2-1',4,'image/jpeg',9803,'products/2-1.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(54,0,'2-2','2-2',4,'image/jpeg',9803,'products/2-2.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(55,0,'2-3','2-3',4,'image/jpeg',9803,'products/2-3.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(56,0,'2','2',4,'image/jpeg',9803,'products/2.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(57,0,'20-1','20-1',4,'image/jpeg',9803,'products/20-1.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(58,0,'20-2','20-2',4,'image/jpeg',9803,'products/20-2.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(59,0,'20-3','20-3',4,'image/jpeg',9803,'products/20-3.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(60,0,'20','20',4,'image/jpeg',9803,'products/20.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(61,0,'21-1','21-1',4,'image/jpeg',9803,'products/21-1.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(62,0,'21-2','21-2',4,'image/jpeg',9803,'products/21-2.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(63,0,'21','21',4,'image/jpeg',9803,'products/21.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(64,0,'22-1','22-1',4,'image/jpeg',9803,'products/22-1.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(65,0,'22-2','22-2',4,'image/jpeg',9803,'products/22-2.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(66,0,'22-3','22-3',4,'image/jpeg',9803,'products/22-3.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(67,0,'22','22',4,'image/jpeg',9803,'products/22.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(68,0,'23-1','23-1',4,'image/jpeg',9803,'products/23-1.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(69,0,'23-2','23-2',4,'image/jpeg',9803,'products/23-2.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(70,0,'23-3','23-3',4,'image/jpeg',9803,'products/23-3.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(71,0,'23','23',4,'image/jpeg',9803,'products/23.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(72,0,'24-1','24-1',4,'image/jpeg',9803,'products/24-1.jpg','[]','2024-02-24 01:36:40','2024-02-24 01:36:40',NULL),
(73,0,'24-2','24-2',4,'image/jpeg',9803,'products/24-2.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(74,0,'24','24',4,'image/jpeg',9803,'products/24.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(75,0,'25-1','25-1',4,'image/jpeg',9803,'products/25-1.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(76,0,'25-2','25-2',4,'image/jpeg',9803,'products/25-2.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(77,0,'25','25',4,'image/jpeg',9803,'products/25.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(78,0,'26-1','26-1',4,'image/jpeg',9803,'products/26-1.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(79,0,'26','26',4,'image/jpeg',9803,'products/26.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(80,0,'27-1','27-1',4,'image/jpeg',9803,'products/27-1.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(81,0,'27','27',4,'image/jpeg',9803,'products/27.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(82,0,'28-1','28-1',4,'image/jpeg',9803,'products/28-1.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(83,0,'28-2','28-2',4,'image/jpeg',9803,'products/28-2.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(84,0,'28','28',4,'image/jpeg',9803,'products/28.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(85,0,'29-1','29-1',4,'image/jpeg',9803,'products/29-1.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(86,0,'29-2','29-2',4,'image/jpeg',9803,'products/29-2.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(87,0,'29','29',4,'image/jpeg',9803,'products/29.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(88,0,'3','3',4,'image/jpeg',9803,'products/3.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(89,0,'30-1','30-1',4,'image/jpeg',9803,'products/30-1.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(90,0,'30-2','30-2',4,'image/jpeg',9803,'products/30-2.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(91,0,'30','30',4,'image/jpeg',9803,'products/30.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(92,0,'31-1','31-1',4,'image/jpeg',9803,'products/31-1.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(93,0,'31','31',4,'image/jpeg',9803,'products/31.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(94,0,'32-1','32-1',4,'image/jpeg',9803,'products/32-1.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(95,0,'32-2','32-2',4,'image/jpeg',9803,'products/32-2.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(96,0,'32','32',4,'image/jpeg',9803,'products/32.jpg','[]','2024-02-24 01:36:41','2024-02-24 01:36:41',NULL),
(97,0,'33-1','33-1',4,'image/jpeg',9803,'products/33-1.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(98,0,'33-2','33-2',4,'image/jpeg',9803,'products/33-2.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(99,0,'33','33',4,'image/jpeg',9803,'products/33.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(100,0,'34-1','34-1',4,'image/jpeg',9803,'products/34-1.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(101,0,'34','34',4,'image/jpeg',9803,'products/34.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(102,0,'35-1','35-1',4,'image/jpeg',9803,'products/35-1.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(103,0,'35','35',4,'image/jpeg',9803,'products/35.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(104,0,'36-1','36-1',4,'image/jpeg',9803,'products/36-1.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(105,0,'36-2','36-2',4,'image/jpeg',9803,'products/36-2.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(106,0,'36','36',4,'image/jpeg',9803,'products/36.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(107,0,'37-1','37-1',4,'image/jpeg',9803,'products/37-1.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(108,0,'37-2','37-2',4,'image/jpeg',9803,'products/37-2.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(109,0,'37','37',4,'image/jpeg',9803,'products/37.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(110,0,'38-1','38-1',4,'image/jpeg',9803,'products/38-1.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(111,0,'38-2','38-2',4,'image/jpeg',9803,'products/38-2.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(112,0,'38-3','38-3',4,'image/jpeg',9803,'products/38-3.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(113,0,'38','38',4,'image/jpeg',9803,'products/38.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(114,0,'39-1','39-1',4,'image/jpeg',9803,'products/39-1.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(115,0,'39-2','39-2',4,'image/jpeg',9803,'products/39-2.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(116,0,'39','39',4,'image/jpeg',9803,'products/39.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(117,0,'4-1','4-1',4,'image/jpeg',9803,'products/4-1.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(118,0,'4-2','4-2',4,'image/jpeg',9803,'products/4-2.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(119,0,'4-3','4-3',4,'image/jpeg',9803,'products/4-3.jpg','[]','2024-02-24 01:36:42','2024-02-24 01:36:42',NULL),
(120,0,'4','4',4,'image/jpeg',9803,'products/4.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(121,0,'40-1','40-1',4,'image/jpeg',9803,'products/40-1.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(122,0,'40','40',4,'image/jpeg',9803,'products/40.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(123,0,'41-1','41-1',4,'image/jpeg',9803,'products/41-1.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(124,0,'41-2','41-2',4,'image/jpeg',9803,'products/41-2.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(125,0,'41','41',4,'image/jpeg',9803,'products/41.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(126,0,'42-1','42-1',4,'image/jpeg',9803,'products/42-1.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(127,0,'42-2','42-2',4,'image/jpeg',9803,'products/42-2.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(128,0,'42','42',4,'image/jpeg',9803,'products/42.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(129,0,'43-1','43-1',4,'image/jpeg',9803,'products/43-1.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(130,0,'43-2','43-2',4,'image/jpeg',9803,'products/43-2.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(131,0,'43','43',4,'image/jpeg',9803,'products/43.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(132,0,'44-1','44-1',4,'image/jpeg',9803,'products/44-1.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(133,0,'44-2','44-2',4,'image/jpeg',9803,'products/44-2.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(134,0,'44','44',4,'image/jpeg',9803,'products/44.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(135,0,'45-1','45-1',4,'image/jpeg',9803,'products/45-1.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(136,0,'45','45',4,'image/jpeg',9803,'products/45.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(137,0,'46-1','46-1',4,'image/jpeg',9803,'products/46-1.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(138,0,'46','46',4,'image/jpeg',9803,'products/46.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(139,0,'47-1','47-1',4,'image/jpeg',9803,'products/47-1.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(140,0,'47','47',4,'image/jpeg',9803,'products/47.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(141,0,'48-1','48-1',4,'image/jpeg',9803,'products/48-1.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(142,0,'48-2','48-2',4,'image/jpeg',9803,'products/48-2.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(143,0,'48','48',4,'image/jpeg',9803,'products/48.jpg','[]','2024-02-24 01:36:43','2024-02-24 01:36:43',NULL),
(144,0,'49-1','49-1',4,'image/jpeg',9803,'products/49-1.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(145,0,'49-2','49-2',4,'image/jpeg',9803,'products/49-2.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(146,0,'49','49',4,'image/jpeg',9803,'products/49.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(147,0,'5-1','5-1',4,'image/jpeg',9803,'products/5-1.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(148,0,'5-2','5-2',4,'image/jpeg',9803,'products/5-2.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(149,0,'5-3','5-3',4,'image/jpeg',9803,'products/5-3.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(150,0,'5','5',4,'image/jpeg',9803,'products/5.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(151,0,'50-1','50-1',4,'image/jpeg',9803,'products/50-1.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(152,0,'50','50',4,'image/jpeg',9803,'products/50.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(153,0,'51','51',4,'image/jpeg',9803,'products/51.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(154,0,'52-1','52-1',4,'image/jpeg',9803,'products/52-1.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(155,0,'52-2','52-2',4,'image/jpeg',9803,'products/52-2.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(156,0,'52','52',4,'image/jpeg',9803,'products/52.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(157,0,'53-1','53-1',4,'image/jpeg',9803,'products/53-1.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(158,0,'53','53',4,'image/jpeg',9803,'products/53.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(159,0,'54-1','54-1',4,'image/jpeg',9803,'products/54-1.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(160,0,'54','54',4,'image/jpeg',9803,'products/54.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(161,0,'55-1','55-1',4,'image/jpeg',9803,'products/55-1.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(162,0,'55-2','55-2',4,'image/jpeg',9803,'products/55-2.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(163,0,'55','55',4,'image/jpeg',9803,'products/55.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(164,0,'56-1','56-1',4,'image/jpeg',9803,'products/56-1.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(165,0,'56-2','56-2',4,'image/jpeg',9803,'products/56-2.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(166,0,'56','56',4,'image/jpeg',9803,'products/56.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(167,0,'57-1','57-1',4,'image/jpeg',9803,'products/57-1.jpg','[]','2024-02-24 01:36:44','2024-02-24 01:36:44',NULL),
(168,0,'57','57',4,'image/jpeg',9803,'products/57.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(169,0,'58-1','58-1',4,'image/jpeg',9803,'products/58-1.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(170,0,'58-2','58-2',4,'image/jpeg',9803,'products/58-2.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(171,0,'58','58',4,'image/jpeg',9803,'products/58.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(172,0,'59-1','59-1',4,'image/jpeg',9803,'products/59-1.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(173,0,'59-2','59-2',4,'image/jpeg',9803,'products/59-2.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(174,0,'59-3','59-3',4,'image/jpeg',9803,'products/59-3.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(175,0,'59','59',4,'image/jpeg',9803,'products/59.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(176,0,'6','6',4,'image/jpeg',9803,'products/6.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(177,0,'60-1','60-1',4,'image/jpeg',9803,'products/60-1.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(178,0,'60-2','60-2',4,'image/jpeg',9803,'products/60-2.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(179,0,'60','60',4,'image/jpeg',9803,'products/60.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(180,0,'61-1','61-1',4,'image/jpeg',9803,'products/61-1.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(181,0,'61','61',4,'image/jpeg',9803,'products/61.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(182,0,'62-1','62-1',4,'image/jpeg',9803,'products/62-1.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(183,0,'62','62',4,'image/jpeg',9803,'products/62.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(184,0,'63-1','63-1',4,'image/jpeg',9803,'products/63-1.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(185,0,'63','63',4,'image/jpeg',9803,'products/63.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(186,0,'64-1','64-1',4,'image/jpeg',9803,'products/64-1.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(187,0,'64','64',4,'image/jpeg',9803,'products/64.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(188,0,'65-1','65-1',4,'image/jpeg',9803,'products/65-1.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(189,0,'65-2','65-2',4,'image/jpeg',9803,'products/65-2.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(190,0,'65','65',4,'image/jpeg',9803,'products/65.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(191,0,'7','7',4,'image/jpeg',9803,'products/7.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(192,0,'8-1','8-1',4,'image/jpeg',9803,'products/8-1.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(193,0,'8-2','8-2',4,'image/jpeg',9803,'products/8-2.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(194,0,'8-3','8-3',4,'image/jpeg',9803,'products/8-3.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(195,0,'8','8',4,'image/jpeg',9803,'products/8.jpg','[]','2024-02-24 01:36:45','2024-02-24 01:36:45',NULL),
(196,0,'9-1','9-1',4,'image/jpeg',9803,'products/9-1.jpg','[]','2024-02-24 01:36:46','2024-02-24 01:36:46',NULL),
(197,0,'9-2','9-2',4,'image/jpeg',9803,'products/9-2.jpg','[]','2024-02-24 01:36:46','2024-02-24 01:36:46',NULL),
(198,0,'9','9',4,'image/jpeg',9803,'products/9.jpg','[]','2024-02-24 01:36:46','2024-02-24 01:36:46',NULL),
(199,0,'1','1',5,'image/png',2691,'stores/1.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(200,0,'10','10',5,'image/png',2691,'stores/10.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(201,0,'11','11',5,'image/png',2691,'stores/11.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(202,0,'12','12',5,'image/png',2691,'stores/12.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(203,0,'13','13',5,'image/png',2691,'stores/13.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(204,0,'14','14',5,'image/png',2691,'stores/14.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(205,0,'15','15',5,'image/png',2691,'stores/15.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(206,0,'16','16',5,'image/png',2732,'stores/16.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(207,0,'17','17',5,'image/png',2732,'stores/17.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(208,0,'2','2',5,'image/png',2691,'stores/2.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(209,0,'3','3',5,'image/png',2691,'stores/3.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(210,0,'4','4',5,'image/png',2691,'stores/4.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(211,0,'5','5',5,'image/png',2691,'stores/5.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(212,0,'6','6',5,'image/png',2691,'stores/6.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(213,0,'7','7',5,'image/png',2691,'stores/7.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(214,0,'8','8',5,'image/png',2691,'stores/8.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(215,0,'9','9',5,'image/png',2691,'stores/9.png','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(216,0,'background-1','background-1',5,'image/jpeg',5286,'stores/background-1.jpg','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(217,0,'background-2','background-2',5,'image/jpeg',5286,'stores/background-2.jpg','[]','2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(218,0,'1','1',6,'image/jpeg',9803,'news/1.jpg','[]','2024-02-24 01:37:27','2024-02-24 01:37:27',NULL),
(219,0,'10','10',6,'image/jpeg',9803,'news/10.jpg','[]','2024-02-24 01:37:27','2024-02-24 01:37:27',NULL),
(220,0,'11','11',6,'image/jpeg',9803,'news/11.jpg','[]','2024-02-24 01:37:27','2024-02-24 01:37:27',NULL),
(221,0,'2','2',6,'image/jpeg',9803,'news/2.jpg','[]','2024-02-24 01:37:27','2024-02-24 01:37:27',NULL),
(222,0,'3','3',6,'image/jpeg',9803,'news/3.jpg','[]','2024-02-24 01:37:27','2024-02-24 01:37:27',NULL),
(223,0,'4','4',6,'image/jpeg',9803,'news/4.jpg','[]','2024-02-24 01:37:27','2024-02-24 01:37:27',NULL),
(224,0,'5','5',6,'image/jpeg',9803,'news/5.jpg','[]','2024-02-24 01:37:27','2024-02-24 01:37:27',NULL),
(225,0,'6','6',6,'image/jpeg',9803,'news/6.jpg','[]','2024-02-24 01:37:28','2024-02-24 01:37:28',NULL),
(226,0,'7','7',6,'image/jpeg',9803,'news/7.jpg','[]','2024-02-24 01:37:28','2024-02-24 01:37:28',NULL),
(227,0,'8','8',6,'image/jpeg',9803,'news/8.jpg','[]','2024-02-24 01:37:28','2024-02-24 01:37:28',NULL),
(228,0,'9','9',6,'image/jpeg',9803,'news/9.jpg','[]','2024-02-24 01:37:28','2024-02-24 01:37:28',NULL),
(229,0,'01-sm','01-sm',7,'image/jpeg',10737,'sliders/01-sm.jpg','[]','2024-02-24 01:37:28','2024-02-24 01:37:28',NULL),
(230,0,'01','01',7,'image/jpeg',11704,'sliders/01.jpg','[]','2024-02-24 01:37:28','2024-02-24 01:37:28',NULL),
(231,0,'02-sm','02-sm',7,'image/jpeg',10737,'sliders/02-sm.jpg','[]','2024-02-24 01:37:28','2024-02-24 01:37:28',NULL),
(232,0,'02','02',7,'image/jpeg',11704,'sliders/02.jpg','[]','2024-02-24 01:37:28','2024-02-24 01:37:28',NULL),
(233,0,'1','1',8,'image/jpeg',7935,'promotion/1.jpg','[]','2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(234,0,'2','2',8,'image/png',14659,'promotion/2.png','[]','2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(235,0,'3','3',8,'image/png',10632,'promotion/3.png','[]','2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(236,0,'4','4',8,'image/png',10076,'promotion/4.png','[]','2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(237,0,'5','5',8,'image/png',12274,'promotion/5.png','[]','2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(238,0,'404','404',9,'image/png',31617,'general/404.png','[]','2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(239,0,'app-android','app-android',9,'image/png',630,'general/app-android.png','[]','2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(240,0,'app-bg','app-bg',9,'image/png',11530,'general/app-bg.png','[]','2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(241,0,'app-ios','app-ios',9,'image/png',630,'general/app-ios.png','[]','2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(242,0,'background','background',9,'image/jpeg',26676,'general/background.jpg','[]','2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(243,0,'blog-bg','blog-bg',9,'image/jpeg',81226,'general/blog-bg.jpg','[]','2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(244,0,'coming-soon','coming-soon',9,'image/jpeg',26506,'general/coming-soon.jpg','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(245,0,'facebook','facebook',9,'image/png',686,'general/facebook.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(246,0,'favicon','favicon',9,'image/png',6542,'general/favicon.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(247,0,'footer-payments','footer-payments',9,'image/png',439,'general/footer-payments.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(248,0,'icon-protect','icon-protect',9,'image/png',1665,'general/icon-protect.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(249,0,'icon-reload','icon-reload',9,'image/png',1442,'general/icon-reload.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(250,0,'icon-rocket','icon-rocket',9,'image/png',1541,'general/icon-rocket.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(251,0,'icon-support','icon-support',9,'image/png',1813,'general/icon-support.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(252,0,'icon-tag','icon-tag',9,'image/png',1127,'general/icon-tag.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(253,0,'instagram','instagram',9,'image/png',2355,'general/instagram.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(254,0,'logo-light','logo-light',9,'image/png',12700,'general/logo-light.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(255,0,'logo','logo',9,'image/png',18493,'general/logo.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(256,0,'open-graph-image','open-graph-image',9,'image/png',406719,'general/open-graph-image.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(257,0,'pinterest','pinterest',9,'image/png',1857,'general/pinterest.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(258,0,'placeholder','placeholder',9,'image/png',2543,'general/placeholder.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(259,0,'slider-bg','slider-bg',9,'image/jpeg',26676,'general/slider-bg.jpg','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(260,0,'twitter','twitter',9,'image/png',1587,'general/twitter.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(261,0,'youtube','youtube',9,'image/png',947,'general/youtube.png','[]','2024-02-24 01:37:30','2024-02-24 01:37:30',NULL),
(262,1,'front_logo-66277c475d32f1.22778910','front_logo-66277c475d32f1.22778910',0,'image/jpeg',5282,'front-logo-66277c475d32f122778910.jpg','[]','2024-05-15 13:46:32','2024-05-15 13:46:32',NULL),
(263,1,'istockphoto-182226541-612x612','istockphoto-182226541-612x612',0,'image/jpeg',21629,'istockphoto-182226541-612x612.jpg','[]','2024-05-29 03:51:54','2024-05-29 03:51:54',NULL),
(264,1,'images','images',0,'image/jpeg',7351,'images.jpeg','[]','2024-05-29 14:11:46','2024-05-29 14:11:46',NULL),
(265,1,'download','download',0,'image/jpeg',7201,'download.jpg','[]','2024-05-29 14:11:53','2024-05-29 14:11:53',NULL),
(266,1,'61LvSjrNfUL','61LvSjrNfUL',0,'image/png',79016,'61lvsjrnful.png','[]','2024-06-03 13:35:11','2024-06-03 13:35:11',NULL),
(267,1,'Stethoscope','Stethoscope',0,'image/jpeg',8572,'stethoscope.jpeg','[]','2024-06-03 19:44:27','2024-06-03 19:44:27',NULL),
(268,1,'LITTMANN-CLASSIC-III-CHOCOLATE-600x600','LITTMANN-CLASSIC-III-CHOCOLATE-600x600',0,'image/png',234151,'littmann-classic-iii-chocolate-600x600.png','[]','2024-06-03 19:46:31','2024-06-03 19:46:31',NULL),
(269,1,'download (3)','download (3)',0,'image/jpeg',8984,'download-3.jpg','[]','2024-06-06 14:29:19','2024-06-06 14:29:19',NULL),
(270,1,'download (2)','download (2)',0,'image/jpeg',10068,'download-2.jpg','[]','2024-06-06 14:29:19','2024-06-06 14:29:19',NULL),
(271,1,'download (1)','download (1)',0,'image/jpeg',8716,'download-1.jpg','[]','2024-06-06 14:29:20','2024-06-06 14:29:20',NULL),
(272,1,'WhatsApp-Image-2022-08-20-at-8.20.16-PM','WhatsApp-Image-2022-08-20-at-8.20.16-PM',0,'image/jpeg',27427,'whatsapp-image-2022-08-20-at-82016-pm.jpeg','[]','2024-06-06 14:58:47','2024-06-06 14:58:47',NULL),
(273,1,'Mobile-App-Development-in-Kenya','Mobile-App-Development-in-Kenya',0,'image/png',386792,'mobile-app-development-in-kenya.png','[]','2024-06-06 15:59:51','2024-06-06 15:59:51',NULL),
(274,1,'20190612193425-GettyImages-1066987316-crop','20190612193425-GettyImages-1066987316-crop',0,'image/jpeg',108353,'20190612193425-gettyimages-1066987316-crop.jpeg','[]','2024-06-06 16:00:12','2024-06-06 16:00:12',NULL),
(275,1,'0GyiWWq3Iwsylzc_i','0GyiWWq3Iwsylzc_i',0,'image/jpeg',61533,'0gyiwwq3iwsylzc-i.jpg','[]','2024-06-06 16:21:55','2024-06-06 16:21:55',NULL),
(276,1,'0GyiWWq3Iwsylzc_i-1','0GyiWWq3Iwsylzc_i-1',0,'image/jpeg',61533,'0gyiwwq3iwsylzc-i-1.jpg','[]','2024-06-06 16:22:23','2024-06-06 16:24:44','2024-06-06 16:24:44'),
(277,1,'360_F_232279556_S3mnv8sh2H7K5m3yawYRTMlEZwKgaGPt','360_F_232279556_S3mnv8sh2H7K5m3yawYRTMlEZwKgaGPt',0,'image/jpeg',19896,'360-f-232279556-s3mnv8sh2h7k5m3yawyrtmlezwkgagpt.jpg','[]','2024-06-06 16:29:46','2024-06-06 16:29:46',NULL),
(278,1,'LITTMANN','LITTMANN',0,'image/png',456790,'littmann.png','[]','2024-06-06 16:45:49','2024-06-06 16:45:49',NULL),
(279,1,'download-1','download-1',0,'image/jpeg',9901,'download-1.jpg','[]','2024-06-06 16:55:50','2024-06-06 16:55:50',NULL),
(280,1,'download-2','download-2',0,'image/jpeg',8243,'download-2.jpg','[]','2024-06-06 16:55:59','2024-06-06 16:55:59',NULL),
(281,1,'download-3','download-3',0,'image/jpeg',9512,'download-3.jpg','[]','2024-06-06 16:56:23','2024-06-06 16:56:23',NULL),
(282,1,'download-4','download-4',0,'image/jpeg',9274,'download-4.jpg','[]','2024-06-06 16:56:31','2024-06-06 16:56:31',NULL),
(283,1,'download-5','download-5',0,'image/jpeg',8212,'download-5.jpg','[]','2024-06-06 16:56:42','2024-06-06 16:56:42',NULL),
(284,1,'download-6','download-6',0,'image/jpeg',8744,'download-6.jpg','[]','2024-06-06 16:56:52','2024-06-06 16:56:52',NULL),
(285,1,'images-1','images-1',0,'image/jpeg',7825,'images-1.jpg','[]','2024-06-06 16:57:16','2024-06-06 16:57:16',NULL),
(286,1,'images-2','images-2',0,'image/jpeg',8341,'images-2.jpg','[]','2024-06-06 17:00:12','2024-06-06 17:00:12',NULL),
(287,1,'images-3','images-3',0,'image/jpeg',6956,'images-3.jpg','[]','2024-06-06 17:00:23','2024-06-06 17:00:23',NULL),
(288,1,'images-4','images-4',0,'image/jpeg',9586,'images-4.jpg','[]','2024-06-06 17:00:42','2024-06-06 17:00:42',NULL),
(289,1,'shopping-cart-products_102375-2953','shopping-cart-products_102375-2953',0,'image/jpeg',34183,'shopping-cart-products-102375-2953.jpg','[]','2024-06-06 17:29:11','2024-06-06 17:29:11',NULL),
(290,1,'Littmann sample edit','Littmann sample edit',0,'image/jpeg',34478,'littmann-sample-edit.jpg','[]','2024-06-06 18:41:55','2024-06-06 18:41:55',NULL),
(291,1,'product-jpeg-500x500','product-jpeg-500x500',0,'image/jpeg',32247,'product-jpeg-500x500.jpg','[]','2024-06-06 18:51:31','2024-06-06 18:51:31',NULL),
(292,1,'D','D',0,'image/jpeg',80642,'d.jpg','[]','2025-03-29 08:04:03','2025-03-29 08:04:03',NULL),
(293,1,'Over The counter meds','Over The counter meds',0,'image/jpeg',17031,'over-the-counter-meds.jpg','[]','2025-07-15 12:31:48','2025-07-15 12:31:48',NULL),
(294,1,'lah','lah',8,'application/zip',216321,'promotion/lah.zip','[]','2026-02-03 09:08:10','2026-02-03 09:08:10',NULL),
(295,1,'oceanwp-child','oceanwp-child',8,'application/zip',20610,'promotion/oceanwp-child.zip','[]','2026-02-03 09:08:19','2026-02-03 09:08:19',NULL),
(296,1,'putuscinta','putuscinta',8,'application/zip',20650,'promotion/putuscinta.zip','[]','2026-02-03 09:08:23','2026-02-03 09:08:23',NULL);
/*!40000 ALTER TABLE `media_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_folders`
--

DROP TABLE IF EXISTS `media_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_folders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `color` varchar(250) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_folders_user_id_index` (`user_id`),
  KEY `media_folders_index` (`parent_id`,`user_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_folders`
--

LOCK TABLES `media_folders` WRITE;
/*!40000 ALTER TABLE `media_folders` DISABLE KEYS */;
INSERT INTO `media_folders` VALUES
(1,0,'brands',NULL,'brands',0,'2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(2,0,'product-categories',NULL,'product-categories',0,'2024-02-24 01:36:33','2024-02-24 01:36:33',NULL),
(3,0,'customers',NULL,'customers',0,'2024-02-24 01:36:34','2024-02-24 01:36:34',NULL),
(4,0,'products',NULL,'products',0,'2024-02-24 01:36:38','2024-02-24 01:36:38',NULL),
(5,0,'stores',NULL,'stores',0,'2024-02-24 01:36:52','2024-02-24 01:36:52',NULL),
(6,0,'news',NULL,'news',0,'2024-02-24 01:37:27','2024-02-24 01:37:27',NULL),
(7,0,'sliders',NULL,'sliders',0,'2024-02-24 01:37:28','2024-02-24 01:37:28',NULL),
(8,0,'promotion',NULL,'promotion',0,'2024-02-24 01:37:29','2024-02-24 01:37:29',NULL),
(9,0,'general',NULL,'general',0,'2024-02-24 01:37:29','2024-02-24 01:37:29',NULL);
/*!40000 ALTER TABLE `media_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_settings`
--

DROP TABLE IF EXISTS `media_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(120) NOT NULL,
  `value` text DEFAULT NULL,
  `media_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_settings`
--

LOCK TABLES `media_settings` WRITE;
/*!40000 ALTER TABLE `media_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_locations`
--

DROP TABLE IF EXISTS `menu_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_locations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` bigint(20) unsigned NOT NULL,
  `location` varchar(120) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_locations_menu_id_created_at_index` (`menu_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_locations`
--

LOCK TABLES `menu_locations` WRITE;
/*!40000 ALTER TABLE `menu_locations` DISABLE KEYS */;
INSERT INTO `menu_locations` VALUES
(1,1,'main-menu','2024-02-24 01:37:29','2024-02-24 01:37:29'),
(2,2,'header-navigation','2024-02-24 01:37:29','2024-02-24 01:37:29');
/*!40000 ALTER TABLE `menu_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_nodes`
--

DROP TABLE IF EXISTS `menu_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_nodes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` bigint(20) unsigned NOT NULL,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `reference_id` bigint(20) unsigned DEFAULT NULL,
  `reference_type` varchar(255) DEFAULT NULL,
  `url` varchar(120) DEFAULT NULL,
  `icon_font` varchar(50) DEFAULT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `title` varchar(120) DEFAULT NULL,
  `css_class` varchar(120) DEFAULT NULL,
  `target` varchar(20) NOT NULL DEFAULT '_self',
  `has_child` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_nodes_menu_id_index` (`menu_id`),
  KEY `menu_nodes_parent_id_index` (`parent_id`),
  KEY `reference_id` (`reference_id`),
  KEY `reference_type` (`reference_type`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_nodes`
--

LOCK TABLES `menu_nodes` WRITE;
/*!40000 ALTER TABLE `menu_nodes` DISABLE KEYS */;
INSERT INTO `menu_nodes` VALUES
(1,1,0,NULL,NULL,'/products/smart-watches','icon icon-tag',0,'Special Prices',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(2,1,0,NULL,NULL,'#',NULL,0,'Pages',NULL,'_self',1,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(3,1,2,2,'Botble\\Page\\Models\\Page','/about-us',NULL,0,'About us',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(4,1,2,3,'Botble\\Page\\Models\\Page','/terms-of-use',NULL,0,'Terms Of Use',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(5,1,2,4,'Botble\\Page\\Models\\Page','/terms-conditions',NULL,0,'Terms & Conditions',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(6,1,2,5,'Botble\\Page\\Models\\Page','/refund-policy',NULL,0,'Refund Policy',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(7,1,2,12,'Botble\\Page\\Models\\Page','/coming-soon',NULL,0,'Coming soon',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(8,1,0,NULL,NULL,'/products',NULL,0,'Shop',NULL,'_self',1,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(9,1,8,NULL,NULL,'/products',NULL,0,'All products',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(10,1,8,15,'Botble\\Ecommerce\\Models\\ProductCategory','/product-categories/potatoes',NULL,0,'Products Of Category',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(11,1,8,NULL,NULL,'/products/beat-headphone',NULL,0,'Product Single',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(12,1,0,NULL,NULL,'/stores',NULL,0,'Stores',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(13,1,0,6,'Botble\\Page\\Models\\Page','/blog',NULL,0,'Blog',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(14,1,0,7,'Botble\\Page\\Models\\Page','/faqs',NULL,0,'FAQs',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(15,1,0,8,'Botble\\Page\\Models\\Page','/contact',NULL,0,'Contact',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(16,2,0,2,'Botble\\Page\\Models\\Page','/about-us',NULL,1,'About Us',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(17,2,0,NULL,NULL,'wishlist',NULL,1,'Wishlist',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(18,2,0,NULL,NULL,'orders/tracking',NULL,1,'Order Tracking',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(19,3,0,3,'Botble\\Page\\Models\\Page','/terms-of-use',NULL,2,'Terms Of Use',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(20,3,0,4,'Botble\\Page\\Models\\Page','/terms-conditions',NULL,2,'Terms & Conditions',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(21,3,0,5,'Botble\\Page\\Models\\Page','/refund-policy',NULL,2,'Refund Policy',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(22,3,0,7,'Botble\\Page\\Models\\Page','/faqs',NULL,2,'FAQs',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(23,3,0,NULL,NULL,'/nothing',NULL,2,'404 Page',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(24,4,0,2,'Botble\\Page\\Models\\Page','/about-us',NULL,3,'About us',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(25,4,0,10,'Botble\\Page\\Models\\Page','/affiliate',NULL,3,'Affiliate',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(26,4,0,11,'Botble\\Page\\Models\\Page','/career',NULL,3,'Career',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(27,4,0,8,'Botble\\Page\\Models\\Page','/contact',NULL,3,'Contact us',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(28,5,0,6,'Botble\\Page\\Models\\Page','/blog',NULL,4,'Our blog',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(29,5,0,NULL,NULL,'/cart',NULL,4,'Cart',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(30,5,0,NULL,NULL,'/customer/overview',NULL,4,'My account',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29'),
(31,5,0,NULL,NULL,'/products',NULL,4,'Shop',NULL,'_self',0,'2024-02-24 01:37:29','2024-02-24 01:37:29');
/*!40000 ALTER TABLE `menu_nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES
(1,'Main menu','main-menu','published','2024-02-24 01:37:29','2024-02-24 01:37:29'),
(2,'Header menu','header-menu','published','2024-02-24 01:37:29','2024-02-24 01:37:29'),
(3,'Useful Links','useful-links','published','2024-02-24 01:37:29','2024-02-24 01:37:29'),
(4,'Help Center','help-center','published','2024-02-24 01:37:29','2024-02-24 01:37:29'),
(5,'Business','business','published','2024-02-24 01:37:29','2024-02-24 01:37:29');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meta_boxes`
--

DROP TABLE IF EXISTS `meta_boxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `meta_boxes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `meta_key` varchar(255) NOT NULL,
  `meta_value` text DEFAULT NULL,
  `reference_id` bigint(20) unsigned NOT NULL,
  `reference_type` varchar(120) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `meta_boxes_reference_id_index` (`reference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meta_boxes`
--

LOCK TABLES `meta_boxes` WRITE;
/*!40000 ALTER TABLE `meta_boxes` DISABLE KEYS */;
INSERT INTO `meta_boxes` VALUES
(66,'background','[\"stores\\/background-1.jpg\"]',1,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(67,'socials','[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]',1,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(68,'background','[\"stores\\/background-2.jpg\"]',2,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(69,'socials','[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]',2,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(70,'background','[\"stores\\/background-1.jpg\"]',3,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(71,'socials','[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]',3,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(72,'background','[\"stores\\/background-1.jpg\"]',4,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(73,'socials','[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]',4,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(74,'background','[\"stores\\/background-1.jpg\"]',5,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(75,'socials','[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]',5,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(76,'background','[\"stores\\/background-1.jpg\"]',6,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(77,'socials','[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]',6,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(78,'background','[\"stores\\/background-2.jpg\"]',7,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(79,'socials','[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]',7,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(80,'background','[\"stores\\/background-1.jpg\"]',8,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(81,'socials','[{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/www.twitter.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\"}]',8,'Botble\\Marketplace\\Models\\Store','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(82,'tablet_image','[\"sliders\\/01.jpg\"]',1,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(83,'mobile_image','[\"sliders\\/01-sm.jpg\"]',1,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(84,'tablet_image','[\"sliders\\/02.jpg\"]',2,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(85,'mobile_image','[\"sliders\\/02-sm.jpg\"]',2,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(86,'seo_meta','[{\"index\":\"index\"}]',233,'Botble\\Ecommerce\\Models\\Product','2024-05-29 03:53:38','2024-05-29 03:53:38'),
(87,'faq_ids','[[]]',233,'Botble\\Ecommerce\\Models\\Product','2024-05-29 03:53:38','2024-05-29 03:53:38'),
(89,'seo_meta','[{\"index\":\"index\"}]',1,'Botble\\Ecommerce\\Models\\ProductCategory','2024-05-29 08:16:05','2024-05-29 08:16:05'),
(91,'background','[null]',10,'Botble\\Marketplace\\Models\\Store','2024-05-29 10:39:04','2024-05-29 10:39:04'),
(92,'en_US_seo_meta','[{\"index\":\"index\"}]',233,'Botble\\Ecommerce\\Models\\Product','2024-05-29 10:44:19','2024-05-29 10:44:19'),
(95,'seo_meta','[{\"index\":\"index\"}]',85,'Botble\\Ecommerce\\Models\\ProductCategory','2024-05-29 12:57:22','2024-05-29 12:57:22'),
(98,'seo_meta','[{\"index\":\"index\"}]',234,'Botble\\Ecommerce\\Models\\Product','2024-05-29 14:15:58','2024-05-29 14:15:58'),
(99,'faq_ids','[[]]',234,'Botble\\Ecommerce\\Models\\Product','2024-05-29 14:15:58','2024-05-29 14:15:58'),
(100,'seo_meta','[{\"index\":\"index\"}]',235,'Botble\\Ecommerce\\Models\\Product','2024-05-29 14:43:51','2024-05-29 14:43:51'),
(101,'faq_ids','[[]]',235,'Botble\\Ecommerce\\Models\\Product','2024-05-29 14:43:51','2024-05-29 14:43:51'),
(102,'seo_meta','[{\"index\":\"index\"}]',236,'Botble\\Ecommerce\\Models\\Product','2024-06-03 19:52:15','2024-06-03 19:52:15'),
(103,'faq_ids','[[]]',236,'Botble\\Ecommerce\\Models\\Product','2024-06-03 19:52:15','2024-06-03 19:52:15'),
(104,'seo_meta','[{\"index\":\"index\"}]',24,'Botble\\Ecommerce\\Models\\ProductCategory','2024-06-03 20:04:00','2024-06-03 20:04:00'),
(105,'seo_meta','[{\"index\":\"index\"}]',25,'Botble\\Ecommerce\\Models\\ProductCategory','2024-06-03 20:04:36','2024-06-03 20:04:36'),
(106,'tablet_image','[null]',5,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 03:40:29','2024-06-06 03:40:29'),
(107,'mobile_image','[null]',5,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 03:40:29','2024-06-06 03:40:29'),
(116,'seo_meta','[{\"index\":\"index\"}]',10,'Botble\\Blog\\Models\\Post','2024-06-06 16:22:31','2024-06-06 16:22:31'),
(117,'seo_meta','[{\"index\":\"index\"}]',9,'Botble\\Blog\\Models\\Post','2024-06-06 16:29:54','2024-06-06 16:29:54'),
(118,'tablet_image','[null]',10,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 16:46:01','2024-06-06 16:46:01'),
(119,'mobile_image','[null]',10,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 16:46:01','2024-06-06 16:46:01'),
(120,'tablet_image','[null]',11,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 16:50:14','2024-06-06 16:50:14'),
(121,'mobile_image','[null]',11,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 16:50:14','2024-06-06 16:50:14'),
(122,'tablet_image','[null]',12,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 16:57:27','2024-06-06 16:57:27'),
(123,'mobile_image','[null]',12,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 16:57:27','2024-06-06 16:57:27'),
(124,'tablet_image','[null]',13,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 16:57:37','2024-06-06 16:57:37'),
(125,'mobile_image','[null]',13,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 16:57:37','2024-06-06 16:57:37'),
(126,'tablet_image','[null]',14,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 16:58:58','2024-06-06 16:58:58'),
(127,'mobile_image','[null]',14,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 16:58:58','2024-06-06 16:58:58'),
(128,'tablet_image','[null]',15,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 17:02:21','2024-06-06 17:02:21'),
(129,'mobile_image','[null]',15,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 17:02:21','2024-06-06 17:02:21'),
(130,'tablet_image','[null]',16,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 17:02:56','2024-06-06 17:02:56'),
(131,'mobile_image','[null]',16,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 17:02:56','2024-06-06 17:02:56'),
(132,'tablet_image','[null]',17,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 17:03:09','2024-06-06 17:03:09'),
(133,'mobile_image','[null]',17,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 17:03:09','2024-06-06 17:03:09'),
(134,'tablet_image','[null]',18,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 18:42:21','2024-06-06 18:42:21'),
(135,'mobile_image','[null]',18,'Botble\\SimpleSlider\\Models\\SimpleSliderItem','2024-06-06 18:42:21','2024-06-06 18:42:21'),
(136,'seo_meta','[{\"index\":\"index\"}]',38,'Botble\\Ecommerce\\Models\\ProductCategory','2025-07-15 12:49:48','2025-07-15 12:49:48'),
(137,'seo_meta','[{\"index\":\"index\"}]',28,'Botble\\Ecommerce\\Models\\ProductCategory','2025-07-15 12:50:53','2025-07-15 12:50:53'),
(138,'seo_meta','[{\"index\":\"index\"}]',27,'Botble\\Ecommerce\\Models\\ProductCategory','2025-07-15 12:51:52','2025-07-15 12:51:52'),
(139,'seo_meta','[{\"index\":\"index\"}]',52,'Botble\\Ecommerce\\Models\\ProductCategory','2025-07-15 12:55:36','2025-07-15 12:55:36');
/*!40000 ALTER TABLE `meta_boxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'2013_04_09_032329_create_base_tables',1),
(2,'2013_04_09_062329_create_revisions_table',1),
(3,'2014_10_12_000000_create_users_table',1),
(4,'2014_10_12_100000_create_password_reset_tokens_table',1),
(5,'2016_06_10_230148_create_acl_tables',1),
(6,'2016_06_14_230857_create_menus_table',1),
(7,'2016_06_28_221418_create_pages_table',1),
(8,'2016_10_05_074239_create_setting_table',1),
(9,'2016_11_28_032840_create_dashboard_widget_tables',1),
(10,'2016_12_16_084601_create_widgets_table',1),
(11,'2017_05_09_070343_create_media_tables',1),
(12,'2017_11_03_070450_create_slug_table',1),
(13,'2019_01_05_053554_create_jobs_table',1),
(14,'2019_08_19_000000_create_failed_jobs_table',1),
(15,'2019_12_14_000001_create_personal_access_tokens_table',1),
(16,'2022_04_20_100851_add_index_to_media_table',1),
(17,'2022_04_20_101046_add_index_to_menu_table',1),
(18,'2022_07_10_034813_move_lang_folder_to_root',1),
(19,'2022_08_04_051940_add_missing_column_expires_at',1),
(20,'2022_09_01_000001_create_admin_notifications_tables',1),
(21,'2022_10_14_024629_drop_column_is_featured',1),
(22,'2022_11_18_063357_add_missing_timestamp_in_table_settings',1),
(23,'2022_12_02_093615_update_slug_index_columns',1),
(24,'2023_01_30_024431_add_alt_to_media_table',1),
(25,'2023_02_16_042611_drop_table_password_resets',1),
(26,'2023_04_23_005903_add_column_permissions_to_admin_notifications',1),
(27,'2023_05_10_075124_drop_column_id_in_role_users_table',1),
(28,'2023_08_21_090810_make_page_content_nullable',1),
(29,'2023_09_14_021936_update_index_for_slugs_table',1),
(30,'2023_12_06_100448_change_random_hash_for_media',1),
(31,'2023_12_07_095130_add_color_column_to_media_folders_table',1),
(32,'2023_12_17_162208_make_sure_column_color_in_media_folders_nullable',1),
(33,'2020_11_18_150916_ads_create_ads_table',2),
(34,'2021_12_02_035301_add_ads_translations_table',2),
(35,'2023_04_17_062645_add_open_in_new_tab',2),
(36,'2023_11_07_023805_add_tablet_mobile_image',2),
(37,'2015_06_29_025744_create_audit_history',3),
(38,'2023_11_14_033417_change_request_column_in_table_audit_histories',3),
(39,'2015_06_18_033822_create_blog_table',4),
(40,'2021_02_16_092633_remove_default_value_for_author_type',4),
(41,'2021_12_03_030600_create_blog_translations',4),
(42,'2022_04_19_113923_add_index_to_table_posts',4),
(43,'2023_08_29_074620_make_column_author_id_nullable',4),
(44,'2016_06_17_091537_create_contacts_table',5),
(45,'2023_11_10_080225_migrate_contact_blacklist_email_domains_to_core',5),
(46,'2020_03_05_041139_create_ecommerce_tables',6),
(47,'2021_01_01_044147_ecommerce_create_flash_sale_table',6),
(48,'2021_01_17_082713_add_column_is_featured_to_product_collections_table',6),
(49,'2021_01_18_024333_add_zip_code_into_table_customer_addresses',6),
(50,'2021_02_18_073505_update_table_ec_reviews',6),
(51,'2021_03_10_024419_add_column_confirmed_at_to_table_ec_customers',6),
(52,'2021_03_10_025153_change_column_tax_amount',6),
(53,'2021_03_20_033103_add_column_availability_to_table_ec_products',6),
(54,'2021_04_28_074008_ecommerce_create_product_label_table',6),
(55,'2021_05_31_173037_ecommerce_create_ec_products_translations',6),
(56,'2021_08_17_105016_remove_column_currency_id_in_some_tables',6),
(57,'2021_08_30_142128_add_images_column_to_ec_reviews_table',6),
(58,'2021_10_04_030050_add_column_created_by_to_table_ec_products',6),
(59,'2021_10_05_122616_add_status_column_to_ec_customers_table',6),
(60,'2021_11_03_025806_nullable_phone_number_in_ec_customer_addresses',6),
(61,'2021_11_23_071403_correct_languages_for_product_variations',6),
(62,'2021_11_28_031808_add_product_tags_translations',6),
(63,'2021_12_01_031123_add_featured_image_to_ec_products',6),
(64,'2022_01_01_033107_update_table_ec_shipments',6),
(65,'2022_02_16_042457_improve_product_attribute_sets',6),
(66,'2022_03_22_075758_correct_product_name',6),
(67,'2022_04_19_113334_add_index_to_ec_products',6),
(68,'2022_04_28_144405_remove_unused_table',6),
(69,'2022_05_05_115015_create_ec_customer_recently_viewed_products_table',6),
(70,'2022_05_18_143720_add_index_to_table_ec_product_categories',6),
(71,'2022_06_16_095633_add_index_to_some_tables',6),
(72,'2022_06_30_035148_create_order_referrals_table',6),
(73,'2022_07_24_153815_add_completed_at_to_ec_orders_table',6),
(74,'2022_08_14_032836_create_ec_order_returns_table',6),
(75,'2022_08_14_033554_create_ec_order_return_items_table',6),
(76,'2022_08_15_040324_add_billing_address',6),
(77,'2022_08_30_091114_support_digital_products_table',6),
(78,'2022_09_13_095744_create_options_table',6),
(79,'2022_09_13_104347_create_option_value_table',6),
(80,'2022_10_05_163518_alter_table_ec_order_product',6),
(81,'2022_10_12_041517_create_invoices_table',6),
(82,'2022_10_12_142226_update_orders_table',6),
(83,'2022_10_13_024916_update_table_order_returns',6),
(84,'2022_10_21_030830_update_columns_in_ec_shipments_table',6),
(85,'2022_10_28_021046_update_columns_in_ec_shipments_table',6),
(86,'2022_11_16_034522_update_type_column_in_ec_shipping_rules_table',6),
(87,'2022_11_19_041643_add_ec_tax_product_table',6),
(88,'2022_12_12_063830_update_tax_defadult_in_ec_tax_products_table',6),
(89,'2022_12_17_041532_fix_address_in_order_invoice',6),
(90,'2022_12_26_070329_create_ec_product_views_table',6),
(91,'2023_01_04_033051_fix_product_categories',6),
(92,'2023_01_09_050400_add_ec_global_options_translations_table',6),
(93,'2023_01_10_093754_add_missing_option_value_id',6),
(94,'2023_01_17_082713_add_column_barcode_and_cost_per_item_to_product_table',6),
(95,'2023_01_26_021854_add_ec_customer_used_coupons_table',6),
(96,'2023_02_08_015900_update_options_column_in_ec_order_product_table',6),
(97,'2023_02_27_095752_remove_duplicate_reviews',6),
(98,'2023_03_20_115757_add_user_type_column_to_ec_shipment_histories_table',6),
(99,'2023_04_21_082427_create_ec_product_categorizables_table',6),
(100,'2023_05_03_011331_add_missing_column_price_into_invoice_items_table',6),
(101,'2023_05_17_025812_fix_invoice_issue',6),
(102,'2023_05_26_073140_move_option_make_phone_field_optional_at_checkout_page_to_mandatory_fields',6),
(103,'2023_05_27_144611_fix_exchange_rate_setting',6),
(104,'2023_06_22_084331_add_generate_license_code_to_ec_products_table',6),
(105,'2023_06_30_042512_create_ec_order_tax_information_table',6),
(106,'2023_07_14_022724_remove_column_id_from_ec_product_collection_products',6),
(107,'2023_08_09_012940_remove_column_status_in_ec_product_attributes',6),
(108,'2023_08_15_064505_create_ec_tax_rules_table',6),
(109,'2023_08_21_021819_make_column_address_in_ec_customer_addresses_nullable',6),
(110,'2023_08_22_094114_drop_unique_for_barcode',6),
(111,'2023_08_30_031811_add_apply_via_url_column_to_ec_discounts_table',6),
(112,'2023_09_07_094312_add_index_to_product_sku_and_translations',6),
(113,'2023_09_19_024955_create_discount_product_categories_table',6),
(114,'2023_10_17_070728_add_icon_and_icon_image_to_product_categories_table',6),
(115,'2023_11_22_154643_add_unique_in_table_ec_products_variations',6),
(116,'2023_11_27_032313_add_price_columns_to_ec_product_cross_sale_relations_table',6),
(117,'2023_12_06_023945_add_display_on_checkout_column_to_ec_discounts_table',6),
(118,'2023_12_25_040604_ec_create_review_replies_table',6),
(119,'2023_12_26_090340_add_private_notes_column_to_ec_customers_table',6),
(120,'2024_01_16_070706_fix_translation_tables',6),
(121,'2024_01_23_075227_add_proof_file_to_ec_orders_table',6),
(122,'2018_07_09_221238_create_faq_table',7),
(123,'2021_12_03_082134_create_faq_translations',7),
(124,'2023_11_17_063408_add_description_column_to_faq_categories_table',7),
(125,'2016_10_03_032336_create_languages_table',8),
(126,'2023_09_14_022423_add_index_for_language_table',8),
(127,'2021_10_25_021023_fix-priority-load-for-language-advanced',9),
(128,'2021_12_03_075608_create_page_translations',9),
(129,'2023_07_06_011444_create_slug_translations_table',9),
(130,'2019_11_18_061011_create_country_table',10),
(131,'2021_12_03_084118_create_location_translations',10),
(132,'2021_12_03_094518_migrate_old_location_data',10),
(133,'2021_12_10_034440_switch_plugin_location_to_use_language_advanced',10),
(134,'2022_01_16_085908_improve_plugin_location',10),
(135,'2022_08_04_052122_delete_location_backup_tables',10),
(136,'2023_04_23_061847_increase_state_translations_abbreviation_column',10),
(137,'2023_07_26_041451_add_more_columns_to_location_table',10),
(138,'2023_07_27_041451_add_more_columns_to_location_translation_table',10),
(139,'2023_08_15_073307_drop_unique_in_states_cities_translations',10),
(140,'2023_10_21_065016_make_state_id_in_table_cities_nullable',10),
(141,'2021_07_06_030002_create_marketplace_table',11),
(142,'2021_09_04_150137_add_vendor_verified_at_to_ec_customers_table',11),
(143,'2021_10_04_033903_add_column_approved_by_into_table_ec_products',11),
(144,'2021_10_06_124943_add_transaction_id_column_to_mp_customer_withdrawals_table',11),
(145,'2021_10_10_054216_add_columns_to_mp_customer_revenues_table',11),
(146,'2021_12_06_031304_update_table_mp_customer_revenues',11),
(147,'2022_10_19_152916_add_columns_to_mp_stores_table',11),
(148,'2022_10_20_062849_create_mp_category_sale_commissions_table',11),
(149,'2022_11_02_071413_add_more_info_for_store',11),
(150,'2022_11_02_080444_add_tax_info',11),
(151,'2023_02_01_062030_add_store_translations',11),
(152,'2023_02_13_032133_update_fee_column_mp_customer_revenues_table',11),
(153,'2023_02_17_023648_fix_store_prefix',11),
(154,'2017_10_24_154832_create_newsletter_table',12),
(155,'2017_05_18_080441_create_payment_tables',13),
(156,'2021_03_27_144913_add_customer_type_into_table_payments',13),
(157,'2021_05_24_034720_make_column_currency_nullable',13),
(158,'2021_08_09_161302_add_metadata_column_to_payments_table',13),
(159,'2021_10_19_020859_update_metadata_field',13),
(160,'2022_06_28_151901_activate_paypal_stripe_plugin',13),
(161,'2022_07_07_153354_update_charge_id_in_table_payments',13),
(162,'2017_07_11_140018_create_simple_slider_table',14),
(163,'2016_10_07_193005_create_translations_table',15),
(164,'2023_12_12_105220_drop_translations_table',15);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_category_sale_commissions`
--

DROP TABLE IF EXISTS `mp_category_sale_commissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_category_sale_commissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_category_id` bigint(20) unsigned NOT NULL,
  `commission_percentage` decimal(8,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mp_category_sale_commissions_product_category_id_unique` (`product_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_category_sale_commissions`
--

LOCK TABLES `mp_category_sale_commissions` WRITE;
/*!40000 ALTER TABLE `mp_category_sale_commissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mp_category_sale_commissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_customer_revenues`
--

DROP TABLE IF EXISTS `mp_customer_revenues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_customer_revenues` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) unsigned DEFAULT NULL,
  `order_id` bigint(20) unsigned DEFAULT NULL,
  `sub_amount` decimal(15,2) DEFAULT 0.00,
  `fee` decimal(15,2) DEFAULT 0.00,
  `amount` decimal(15,2) DEFAULT 0.00,
  `current_balance` decimal(15,2) DEFAULT 0.00,
  `currency` varchar(120) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `type` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_customer_revenues`
--

LOCK TABLES `mp_customer_revenues` WRITE;
/*!40000 ALTER TABLE `mp_customer_revenues` DISABLE KEYS */;
INSERT INTO `mp_customer_revenues` VALUES
(1,8,1,2253.00,0.00,2253.00,0.00,'USD',NULL,'2024-02-23 17:37:07','2024-02-23 17:37:07',0,'add-amount'),
(2,6,3,2178.00,0.00,2178.00,0.00,'USD',NULL,'2024-02-21 01:37:08','2024-02-21 01:37:08',0,'add-amount'),
(3,3,11,1024.00,0.00,1024.00,0.00,'USD',NULL,'2024-02-23 01:37:08','2024-02-23 01:37:08',0,'add-amount'),
(4,3,12,781.00,0.00,781.00,1024.00,'USD',NULL,'2024-02-18 15:37:09','2024-02-18 15:37:09',0,'add-amount'),
(5,3,13,1004.00,0.00,1004.00,1805.00,'USD',NULL,'2024-02-14 17:37:10','2024-02-14 17:37:10',0,'add-amount'),
(6,3,18,2298.00,0.00,2298.00,2809.00,'USD',NULL,'2024-02-09 19:37:10','2024-02-09 19:37:10',0,'add-amount'),
(7,6,19,3315.00,0.00,3315.00,2178.00,'USD',NULL,'2024-02-20 17:37:11','2024-02-20 17:37:11',0,'add-amount'),
(8,8,20,1642.50,0.00,1642.50,2253.00,'USD',NULL,'2024-02-17 01:37:11','2024-02-17 01:37:11',0,'add-amount'),
(9,3,22,1506.00,0.00,1506.00,5107.00,'USD',NULL,'2024-02-12 13:37:12','2024-02-12 13:37:12',0,'add-amount'),
(10,1,29,1264.00,0.00,1264.00,0.00,'USD',NULL,'2024-02-16 13:37:12','2024-02-16 13:37:12',0,'add-amount'),
(11,5,30,2634.00,0.00,2634.00,0.00,'USD',NULL,'2024-02-16 07:37:13','2024-02-16 07:37:13',0,'add-amount'),
(12,3,34,1008.00,0.00,1008.00,6613.00,'USD',NULL,'2024-02-15 07:37:14','2024-02-15 07:37:14',0,'add-amount'),
(13,5,35,3420.00,0.00,3420.00,2634.00,'USD',NULL,'2024-02-03 01:37:14','2024-02-03 01:37:14',0,'add-amount'),
(14,5,37,1098.00,0.00,1098.00,6054.00,'USD',NULL,'2024-02-01 21:37:15','2024-02-01 21:37:15',0,'add-amount'),
(15,5,44,1756.00,0.00,1756.00,7152.00,'USD',NULL,'2024-01-17 13:37:15','2024-01-17 13:37:15',0,'add-amount'),
(16,6,45,846.00,0.00,846.00,5493.00,'USD',NULL,'2024-02-04 21:37:16','2024-02-04 21:37:16',0,'add-amount'),
(17,1,47,1962.00,0.00,1962.00,1264.00,'USD',NULL,'2024-02-08 01:37:17','2024-02-08 01:37:17',0,'add-amount'),
(18,5,48,3936.00,0.00,3936.00,8908.00,'USD',NULL,'2024-01-14 05:37:17','2024-01-14 05:37:17',0,'add-amount');
/*!40000 ALTER TABLE `mp_customer_revenues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_customer_withdrawals`
--

DROP TABLE IF EXISTS `mp_customer_withdrawals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_customer_withdrawals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) unsigned DEFAULT NULL,
  `fee` decimal(15,2) unsigned DEFAULT 0.00,
  `amount` decimal(15,2) unsigned DEFAULT 0.00,
  `current_balance` decimal(15,2) unsigned DEFAULT 0.00,
  `currency` varchar(120) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `bank_info` text DEFAULT NULL,
  `payment_channel` varchar(60) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'pending',
  `images` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `transaction_id` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_customer_withdrawals`
--

LOCK TABLES `mp_customer_withdrawals` WRITE;
/*!40000 ALTER TABLE `mp_customer_withdrawals` DISABLE KEYS */;
INSERT INTO `mp_customer_withdrawals` VALUES
(1,1,0.00,157.00,3226.00,'USD','','{\"name\":\"Bennie Gorczany PhD\",\"number\":\"+15207970666\",\"full_name\":\"Wiley Beatty\",\"description\":\"Sandra Kilback\"}',NULL,0,'completed',NULL,'2024-02-24 01:37:18','2024-02-24 01:37:18',NULL),
(2,1,0.00,461.00,3069.00,'USD','','{\"name\":\"Bennie Gorczany PhD\",\"number\":\"+15207970666\",\"full_name\":\"Wiley Beatty\",\"description\":\"Sandra Kilback\"}',NULL,0,'completed',NULL,'2024-02-24 01:37:18','2024-02-24 01:37:18',NULL),
(3,1,0.00,537.00,2608.00,'USD','','{\"name\":\"Bennie Gorczany PhD\",\"number\":\"+15207970666\",\"full_name\":\"Wiley Beatty\",\"description\":\"Sandra Kilback\"}',NULL,0,'processing',NULL,'2024-02-24 01:37:19','2024-02-24 01:37:19',NULL),
(4,1,0.00,53.00,2071.00,'USD','','{\"name\":\"Bennie Gorczany PhD\",\"number\":\"+15207970666\",\"full_name\":\"Wiley Beatty\",\"description\":\"Sandra Kilback\"}',NULL,0,'completed',NULL,'2024-02-24 01:37:19','2024-02-24 01:37:19',NULL),
(5,3,0.00,2171.00,7621.00,'USD','','{\"name\":\"Milo Marquardt\",\"number\":\"+17208396276\",\"full_name\":\"Noemi Johnson\",\"description\":\"Ms. Tabitha Morar Sr.\"}',NULL,0,'completed',NULL,'2024-02-24 01:37:20','2024-02-24 01:37:20',NULL),
(6,3,0.00,1072.00,5450.00,'USD','','{\"name\":\"Milo Marquardt\",\"number\":\"+17208396276\",\"full_name\":\"Noemi Johnson\",\"description\":\"Ms. Tabitha Morar Sr.\"}',NULL,0,'pending',NULL,'2024-02-24 01:37:20','2024-02-24 01:37:20',NULL),
(7,5,0.00,2544.00,12844.00,'USD','','{\"name\":\"Jacinto Ziemann\",\"number\":\"+17014861008\",\"full_name\":\"Rodolfo Mraz V\",\"description\":\"Alexis Harvey\"}',NULL,0,'completed',NULL,'2024-02-24 01:37:21','2024-02-24 01:37:21',NULL),
(8,5,0.00,1442.00,10300.00,'USD','','{\"name\":\"Jacinto Ziemann\",\"number\":\"+17014861008\",\"full_name\":\"Rodolfo Mraz V\",\"description\":\"Alexis Harvey\"}',NULL,0,'completed',NULL,'2024-02-24 01:37:22','2024-02-24 01:37:22',NULL),
(9,5,0.00,1172.00,8858.00,'USD','','{\"name\":\"Jacinto Ziemann\",\"number\":\"+17014861008\",\"full_name\":\"Rodolfo Mraz V\",\"description\":\"Alexis Harvey\"}',NULL,0,'pending',NULL,'2024-02-24 01:37:23','2024-02-24 01:37:23',NULL),
(10,6,0.00,524.00,6339.00,'USD','','{\"name\":\"Wava Turner\",\"number\":\"+16415878807\",\"full_name\":\"Mrs. Katarina Hills\",\"description\":\"Rhea Rutherford\"}',NULL,0,'completed',NULL,'2024-02-24 01:37:23','2024-02-24 01:37:23',NULL),
(11,6,0.00,251.00,5815.00,'USD','','{\"name\":\"Wava Turner\",\"number\":\"+16415878807\",\"full_name\":\"Mrs. Katarina Hills\",\"description\":\"Rhea Rutherford\"}',NULL,0,'completed',NULL,'2024-02-24 01:37:24','2024-02-24 01:37:24',NULL),
(12,6,0.00,1572.00,5564.00,'USD','','{\"name\":\"Wava Turner\",\"number\":\"+16415878807\",\"full_name\":\"Mrs. Katarina Hills\",\"description\":\"Rhea Rutherford\"}',NULL,0,'completed',NULL,'2024-02-24 01:37:25','2024-02-24 01:37:25',NULL),
(13,8,0.00,605.00,3895.50,'USD','','{\"name\":\"Weldon Dach\",\"number\":\"+13304709118\",\"full_name\":\"Mr. Garland D\'Amore I\",\"description\":\"Amanda O\'Conner IV\"}',NULL,0,'processing',NULL,'2024-02-24 01:37:25','2024-02-24 01:37:25',NULL),
(14,8,0.00,541.00,3290.50,'USD','','{\"name\":\"Weldon Dach\",\"number\":\"+13304709118\",\"full_name\":\"Mr. Garland D\'Amore I\",\"description\":\"Amanda O\'Conner IV\"}',NULL,0,'pending',NULL,'2024-02-24 01:37:26','2024-02-24 01:37:26',NULL);
/*!40000 ALTER TABLE `mp_customer_withdrawals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_stores`
--

DROP TABLE IF EXISTS `mp_stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_stores` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `customer_id` bigint(20) unsigned DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `vendor_verified_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_stores`
--

LOCK TABLES `mp_stores` WRITE;
/*!40000 ALTER TABLE `mp_stores` DISABLE KEYS */;
INSERT INTO `mp_stores` VALUES
(1,'GoPro','stracke.david@example.org','+14049075887','2165 Pfannerstill Skyway Apt. 445','ID','Delaware','Yazminfort',3,'stores/1.png','Expedita quibusdam omnis tempora ratione neque recusandae. Enim necessitatibus et vel hic quo quis debitis aut. Non officiis accusamus earum unde. Similique aperiam est et id. A labore aspernatur consequatur similique blanditiis. Maxime perferendis deserunt voluptatem debitis cupiditate est. Ab animi aut et enim sint facere sunt. Qui pariatur nemo commodi dolorem iste est.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n','published',NULL,'2024-02-24 01:36:55','2024-02-24 01:36:55',NULL,NULL),
(2,'Global Office','koch.imani@example.com','+13474262462','9103 Cleora Island','PL','Illinois','Kreigerchester',6,'stores/2.png','Voluptatibus porro non et dolorem dignissimos voluptatem. Reiciendis recusandae sed quam quae repellat ad. Veritatis consequatur voluptate ut ab cupiditate omnis. Excepturi qui aut qui dicta est. Officiis tempore fugit est velit eaque consectetur atque exercitationem. Non aut cumque rem est numquam minima quo.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n','published',NULL,'2024-02-24 01:36:55','2024-02-24 01:36:55',NULL,NULL),
(3,'Young Shop','udurgan@example.net','+19595797916','5257 Mitchell Tunnel Apt. 707','TC','Georgia','Janamouth',1,'stores/3.png','Et nam aliquid possimus qui sit vel expedita et. Neque voluptas placeat ducimus sed ut at. Nesciunt quis est fuga cumque sed maxime recusandae. Quaerat dolorem veniam nihil aspernatur non. Minima assumenda deserunt quos tempore non. Corrupti a corrupti animi voluptate. Ducimus aperiam omnis voluptatibus laboriosam. Nemo et facilis vitae ipsum suscipit voluptates impedit.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n','published',NULL,'2024-02-24 01:36:55','2024-02-24 01:36:55',NULL,NULL),
(4,'Global Store','coleman.ondricka@example.net','+13808867660','754 Gerhold Park Suite 638','ZW','District of Columbia','Howeside',8,'stores/4.png','Sequi minima non omnis labore amet ut. Nemo nobis nostrum sed earum earum id id. Necessitatibus in magni aliquid dolores. Earum beatae modi enim velit. Quis ut dolorem beatae magnam. Dicta sed eum esse maiores aut nihil iusto. At ullam consequatur ut pariatur. Quasi architecto quidem doloremque.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n','published',NULL,'2024-02-24 01:36:55','2024-02-24 01:36:55',NULL,NULL),
(5,'Robert’s Store','keven14@example.net','+19865797389','291 Juliet Via','BR','Massachusetts','Jeramyview',1,'stores/5.png','Deserunt aperiam dolorum perspiciatis repudiandae id autem soluta. Et non officia ullam natus. Dolores aut fugiat dolor sapiente. Officiis vitae nostrum labore doloremque labore commodi architecto. Ut incidunt iusto maiores ea sit. Enim sint error eius odit vero. Aut quis quibusdam optio quidem est reiciendis.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n','published',NULL,'2024-02-24 01:36:55','2024-02-24 01:36:55',NULL,NULL),
(6,'Stouffer','tatum.hartmann@example.com','+12012216265','821 Mueller Meadows Suite 026','SM','Massachusetts','South Rozella',5,'stores/6.png','Consectetur assumenda nam ut. Consequatur vero sequi sit qui laboriosam natus. Officiis aut dolor ut exercitationem repellat eos quas. Similique provident rerum rerum modi molestias. Fugit ut assumenda ut nihil voluptatem est culpa. Non nostrum quia debitis laudantium. Delectus qui commodi quas eos eum.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n','published',NULL,'2024-02-24 01:36:55','2024-02-24 01:36:55',NULL,NULL),
(7,'StarKist','mortiz@example.org','+17575738411','181 Bins Brook','WF','Rhode Island','West Osbaldo',3,'stores/7.png','Praesentium ex libero perspiciatis qui. Officia dolorem id quos voluptas iure. Optio ducimus officia dolorem laboriosam. Labore eaque dolores nostrum. Sed et voluptatem iste nihil. Consequatur cumque et distinctio molestiae qui. Minus ut eos sit aliquid quis. Et facilis quisquam ipsam nostrum quo impedit voluptas.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n','published',NULL,'2024-02-24 01:36:55','2024-02-24 01:36:55',NULL,NULL),
(8,'Old El Paso','camron.runolfsson@example.org','+13214766547','3932 Homenick Meadow Suite 706','HT','District of Columbia','Leilaview',3,'stores/8.png','Harum laudantium molestias dolores ab. Est ducimus enim facere est illum quos. Sint beatae fugiat veniam ad excepturi nobis laboriosam molestias. Voluptas consequuntur non architecto. Nihil temporibus modi voluptatem vero sit veniam nemo. Ea maxime distinctio dolorem nam consectetur. Sint sequi labore aut facilis ex vitae commodi. Atque praesentium magni et occaecati unde voluptatum porro.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f4\" src=\"/storage/news/1.jpg\"></p>\n\n<p><br>\n </p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even <strong>minimalist style</strong> is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f5\" src=\"/storage/news/2.jpg\"></p>\n\n<p><br>\n </p>\n<hr>\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f1\" src=\"/storage/news/3.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f6\" src=\"/storage/news/4.jpg\"></p>\n\n<p><br>\n </p>\n\n<hr>\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center;\"><img alt=\"f2\" src=\"/storage/news/5.jpg\"></p>\n\n<p> </p>\n','published',NULL,'2024-02-24 01:36:55','2024-02-24 01:36:55',NULL,NULL),
(10,'SPA NURSING HOME','antonionencheye@yahoo.com','0719863747','Spa Hospital','KE',NULL,'Nairobi',11,NULL,'','','published',NULL,'2024-05-29 10:37:31','2024-05-29 10:39:04',NULL,NULL);
/*!40000 ALTER TABLE `mp_stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_stores_translations`
--

DROP TABLE IF EXISTS `mp_stores_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_stores_translations` (
  `lang_code` varchar(191) NOT NULL,
  `mp_stores_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`mp_stores_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_stores_translations`
--

LOCK TABLES `mp_stores_translations` WRITE;
/*!40000 ALTER TABLE `mp_stores_translations` DISABLE KEYS */;
INSERT INTO `mp_stores_translations` VALUES
('en_US',9,'SPA NURSING HOME','','','Spa Hospital',NULL);
/*!40000 ALTER TABLE `mp_stores_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_vendor_info`
--

DROP TABLE IF EXISTS `mp_vendor_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mp_vendor_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total_fee` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total_revenue` decimal(15,2) NOT NULL DEFAULT 0.00,
  `signature` varchar(255) DEFAULT NULL,
  `bank_info` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payout_payment_method` varchar(120) DEFAULT 'bank_transfer',
  `tax_info` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_vendor_info`
--

LOCK TABLES `mp_vendor_info` WRITE;
/*!40000 ALTER TABLE `mp_vendor_info` DISABLE KEYS */;
INSERT INTO `mp_vendor_info` VALUES
(1,1,2018.00,0.00,3226.00,'$2y$12$Sm7ZzyjQ0cMcm4YagTgriuzls0r2QdYyqmvyFTDAeGCwub79wOqMO','{\"name\":\"Bennie Gorczany PhD\",\"number\":\"+15207970666\",\"full_name\":\"Wiley Beatty\",\"description\":\"Sandra Kilback\"}','2024-02-24 01:36:52','2024-02-24 01:37:20','bank_transfer',NULL),
(2,2,0.00,0.00,0.00,'$2y$12$.0pN95DhBG5I3HSiP5xdTuQ0ANnxqbfygBZUaoYjmT2Y36dn6VlVC','{\"name\":\"Suzanne Cummings\",\"number\":\"+18596583208\",\"full_name\":\"Kayley Bins\",\"description\":\"Dr. Cyril Bosco MD\"}','2024-02-24 01:36:53','2024-02-24 01:36:53','bank_transfer',NULL),
(3,3,4378.00,0.00,7621.00,'$2y$12$HuUOGzfj6NbQTm1M7Nl4zudhVjqObTcTs2HgUwoCX/wkLyD5TZoHm','{\"name\":\"Milo Marquardt\",\"number\":\"+17208396276\",\"full_name\":\"Noemi Johnson\",\"description\":\"Ms. Tabitha Morar Sr.\"}','2024-02-24 01:36:53','2024-02-24 01:37:21','bank_transfer',NULL),
(4,4,0.00,0.00,0.00,'$2y$12$iKnQzhkZf5Kb4m7/QQ08ge2ckyHWsuVYekcSXqV4L/XkozLbkxKG.','{\"name\":\"Veronica Lindgren\",\"number\":\"+18068052835\",\"full_name\":\"Nathanael Orn DVM\",\"description\":\"Mary Davis\"}','2024-02-24 01:36:53','2024-02-24 01:36:53','bank_transfer',NULL),
(5,5,7686.00,0.00,12844.00,'$2y$12$PE23h0SFeaoHrtuQpLO.FeDe0OTPlaGZVoXdJn1iPCTefBUlslXSC','{\"name\":\"Jacinto Ziemann\",\"number\":\"+17014861008\",\"full_name\":\"Rodolfo Mraz V\",\"description\":\"Alexis Harvey\"}','2024-02-24 01:36:54','2024-02-24 01:37:23','bank_transfer',NULL),
(6,6,3992.00,0.00,6339.00,'$2y$12$MmefcVioTGcI219Y0qM86OxgV8rL6wqdGmgnxMXuLuv6aK3IcDePu','{\"name\":\"Wava Turner\",\"number\":\"+16415878807\",\"full_name\":\"Mrs. Katarina Hills\",\"description\":\"Rhea Rutherford\"}','2024-02-24 01:36:54','2024-02-24 01:37:25','bank_transfer',NULL),
(7,7,0.00,0.00,0.00,'$2y$12$NblBTAumCJ4WvmUXInooS.rIHMKEmHrBa5F4f956F1pR1CUj5uXi2','{\"name\":\"Miss Ova Anderson Sr.\",\"number\":\"+15802415309\",\"full_name\":\"Kelsie Orn\",\"description\":\"Dereck Kertzmann IV\"}','2024-02-24 01:36:54','2024-02-24 01:36:54','bank_transfer',NULL),
(8,8,2749.50,0.00,3895.50,'$2y$12$AZXFfPOnfFmZi2H.k78fDOlweqgcOXcLGHmQmNU16nfBBjUczNDum','{\"name\":\"Weldon Dach\",\"number\":\"+13304709118\",\"full_name\":\"Mr. Garland D\'Amore I\",\"description\":\"Amanda O\'Conner IV\"}','2024-02-24 01:36:55','2024-02-24 01:37:27','bank_transfer',NULL),
(9,11,0.00,0.00,0.00,'$2y$12$K6fvf76idSixNSQdkgHgaOzTbNhCk6J0tgHKOrI.droXZglh9vO1e',NULL,'2024-05-29 10:37:31','2024-05-29 10:37:31','bank_transfer',NULL);
/*!40000 ALTER TABLE `mp_vendor_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletters`
--

DROP TABLE IF EXISTS `newsletters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `newsletters` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(120) NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'subscribed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletters`
--

LOCK TABLES `newsletters` WRITE;
/*!40000 ALTER TABLE `newsletters` DISABLE KEYS */;
INSERT INTO `newsletters` VALUES
(1,'victormarangu7@gmail.com',NULL,'subscribed','2024-05-29 14:46:18','2024-05-29 14:46:18'),
(2,'lpeyfynl@do-not-respond.me',NULL,'subscribed','2025-03-21 02:13:24','2025-03-21 02:13:24'),
(3,'dwimbuuo@do-not-respond.me',NULL,'subscribed','2025-03-21 02:13:24','2025-03-21 02:13:24'),
(4,'whitekate51518@yahoo.com',NULL,'subscribed','2026-08-09 03:04:14','2026-08-09 03:04:14'),
(5,'cotaylor37@icloud.com',NULL,'subscribed','2026-08-09 06:33:20','2026-08-09 06:33:20'),
(6,'alisakennedyshhco@educolbs.us',NULL,'subscribed','2026-08-09 07:31:09','2026-08-09 07:31:09'),
(7,'sofiatony5146@gmail.com',NULL,'subscribed','2026-08-09 12:11:31','2026-08-09 12:11:31'),
(8,'Kjmoran1@yahoo.com',NULL,'subscribed','2026-08-09 16:03:12','2026-08-09 16:03:12'),
(9,'alex1950pineda@gmail.com',NULL,'subscribed','2026-08-09 16:05:35','2026-08-09 16:05:35'),
(10,'wings_916@hotmail.com',NULL,'subscribed','2026-08-09 16:34:03','2026-08-09 16:34:03'),
(11,'la_space_police_fraternity@yahoo.co.jp',NULL,'subscribed','2026-08-09 18:09:45','2026-08-09 18:09:45'),
(12,'jessicamorris216@gmail.com',NULL,'subscribed','2026-08-09 18:24:58','2026-08-09 18:24:58'),
(13,'Kdowen67@gmail.com',NULL,'subscribed','2026-08-09 18:28:22','2026-08-09 18:28:22'),
(14,'Aliparadis@gmail.com',NULL,'subscribed','2026-08-09 19:45:08','2026-08-09 19:45:08'),
(15,'dezistevenson88@gmail.com',NULL,'subscribed','2026-08-09 23:34:59','2026-08-09 23:34:59'),
(16,'ughlexus@gmail.com',NULL,'subscribed','2026-08-10 04:52:13','2026-08-10 04:52:13'),
(17,'wfigueroa1105@gmail.com',NULL,'subscribed','2026-08-10 05:56:23','2026-08-10 05:56:23'),
(18,'kristanav13@gmail.com',NULL,'subscribed','2026-08-10 06:13:09','2026-08-10 06:13:09'),
(19,'venusdevelo@gmail.com',NULL,'subscribed','2026-08-10 06:21:52','2026-08-10 06:21:52'),
(20,'k497651509@gmail.com',NULL,'subscribed','2026-08-10 06:42:14','2026-08-10 06:42:14'),
(21,'sole.sambiasi@gmail.com',NULL,'subscribed','2026-08-10 07:17:02','2026-08-10 07:17:02'),
(22,'kaiozogul@gmail.com',NULL,'subscribed','2026-08-10 07:19:30','2026-08-10 07:19:30'),
(23,'janeencorrigan7h515@educolbs.us',NULL,'subscribed','2026-08-10 07:31:22','2026-08-10 07:31:22'),
(24,'laurascotttane9kvz@hotmail.com',NULL,'subscribed','2026-08-10 08:26:22','2026-08-10 08:26:22'),
(25,'labustinrobert431166@yahoo.com',NULL,'subscribed','2026-08-10 08:26:25','2026-08-10 08:26:25'),
(26,'d.probst@interroll.com',NULL,'subscribed','2026-08-10 11:49:31','2026-08-10 11:49:31'),
(27,'stephanie.mcneill@energyunited.com',NULL,'subscribed','2026-08-10 11:56:11','2026-08-10 11:56:11'),
(28,'brandie.laureano@goodnightmidstream.com',NULL,'subscribed','2026-08-10 12:06:54','2026-08-10 12:06:54'),
(29,'sabee@utili-serve.com',NULL,'subscribed','2026-08-10 12:11:36','2026-08-10 12:11:36'),
(30,'kris.letendre@connexusenergy.com',NULL,'subscribed','2026-08-10 12:21:07','2026-08-10 12:21:07'),
(31,'jsering@isgservice.com',NULL,'subscribed','2026-08-10 12:33:50','2026-08-10 12:33:50'),
(32,'cmurphy@theshawgrp.com',NULL,'subscribed','2026-08-10 12:35:38','2026-08-10 12:35:38'),
(33,'tguenther@polytainersinc.com',NULL,'subscribed','2026-08-10 12:47:42','2026-08-10 12:47:42'),
(34,'jennie.lim@onwardenergy.com',NULL,'subscribed','2026-08-10 14:00:12','2026-08-10 14:00:12'),
(35,'njamdar@saiconinc.com',NULL,'subscribed','2026-08-10 14:05:59','2026-08-10 14:05:59'),
(36,'brandy.pennington@advario.com',NULL,'subscribed','2026-08-10 15:42:49','2026-08-10 15:42:49'),
(37,'becki_bryant@hotmail.com',NULL,'subscribed','2026-08-10 15:48:48','2026-08-10 15:48:48'),
(38,'rdaley@bm.net',NULL,'subscribed','2026-08-10 15:53:40','2026-08-10 15:53:40'),
(39,'rsanchez@californiaboiler.com',NULL,'subscribed','2026-08-10 16:10:33','2026-08-10 16:10:33'),
(40,'eball@finoneinc.com',NULL,'subscribed','2026-08-10 16:30:25','2026-08-10 16:30:25'),
(41,'david.garay@wanco.com',NULL,'subscribed','2026-08-10 16:48:05','2026-08-10 16:48:05'),
(42,'jaimee.richardson@peigenesis.com',NULL,'subscribed','2026-08-10 16:48:17','2026-08-10 16:48:17'),
(43,'dhaynes@reverecontrol.com',NULL,'subscribed','2026-08-10 16:51:10','2026-08-10 16:51:10'),
(44,'d.moreau@syrahresources.com.au',NULL,'subscribed','2026-08-10 16:54:52','2026-08-10 16:54:52'),
(45,'Paul.porterd20@hotmail.com',NULL,'subscribed','2026-08-10 17:05:17','2026-08-10 17:05:17'),
(46,'ryan.becker@riveron.com',NULL,'subscribed','2026-08-10 17:36:35','2026-08-10 17:36:35'),
(47,'jordan.richmond2009@hotmail.com',NULL,'subscribed','2026-08-10 17:42:19','2026-08-10 17:42:19'),
(48,'polachina83@hotmail.com',NULL,'subscribed','2026-08-10 18:52:25','2026-08-10 18:52:25'),
(49,'akiyo.shimohashi@gmail.com',NULL,'subscribed','2026-08-10 19:23:13','2026-08-10 19:23:13'),
(50,'craigelliott0727@gmail.com',NULL,'subscribed','2026-08-10 23:41:13','2026-08-10 23:41:13'),
(51,'moorekimberly733885@yahoo.com',NULL,'subscribed','2026-08-11 08:37:48','2026-08-11 08:37:48'),
(52,'kcoons94@msn.com',NULL,'subscribed','2026-08-11 12:46:32','2026-08-11 12:46:32'),
(53,'priya95darsini@gmail.com',NULL,'subscribed','2026-08-11 16:06:46','2026-08-11 16:06:46'),
(54,'ann_m_tran@yahoo.com',NULL,'subscribed','2026-08-11 16:45:20','2026-08-11 16:45:20'),
(55,'RiceEx@aol.com',NULL,'subscribed','2026-08-11 17:17:00','2026-08-11 17:17:00'),
(56,'vocaloid16@ezweb.ne.jp',NULL,'subscribed','2026-08-11 21:04:54','2026-08-11 21:04:54'),
(57,'physharon@hotmail.com',NULL,'subscribed','2026-08-12 06:53:29','2026-08-12 06:53:29'),
(58,'sateraito0928@icloud.com',NULL,'subscribed','2026-08-12 07:17:25','2026-08-12 07:17:25'),
(59,'rorahaney8479a@educolbs.us',NULL,'subscribed','2026-08-12 07:31:43','2026-08-12 07:31:43'),
(60,'ogata@s4.dion.ne.jp',NULL,'subscribed','2026-08-12 08:38:36','2026-08-12 08:38:36'),
(61,'sibbyhornvfsdp@khalsh.us',NULL,'subscribed','2026-08-15 07:45:37','2026-08-15 07:45:37');
/*!40000 ALTER TABLE `newsletters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `content` longtext DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `template` varchar(60) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pages_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES
(1,'Home','<shortcode>[simple-slider key=\"FM-2443-VKWX\" is_autoplay=\"yes\" is_infinite=\"yes\" autoplay_speed=\"3000\" ads=\"ZDOZUZZIU7FZ\"][/simple-slider]</shortcode><shortcode>[featured-products title=\"Featured products\" is_autoplay=\"no\" is_infinite=\"yes\" autoplay_speed=\"2000\"][/featured-products]</shortcode><shortcode>[product-category-products category_id=\"24\" number_of_categories=\"3\" is_autoplay=\"no\" is_infinite=\"yes\" autoplay_speed=\"3000\"][/product-category-products]</shortcode><shortcode>[product-collections title=\"Essential Products\"][/product-collections]</shortcode><shortcode>[featured-brands title=\"Featured Brands\"][/featured-brands]</shortcode><shortcode>[flash-sale title=\"Top Saver Today\" flash_sale_id=\"1\"][/flash-sale]</shortcode><shortcode>[product-category-products category_id=\"85\" number_of_categories=\"3\" is_autoplay=\"no\" is_infinite=\"yes\" autoplay_speed=\"3000\"][/product-category-products]</shortcode><shortcode>[theme-ads key_1=\"IZ6WU8KUALYD\" key_2=\"ILSFJVYFGCPZ\" key_3=\"ZDOZUZZIU7FT\"][/theme-ads]</shortcode><shortcode>[featured-posts title=\"Health Daily\" app_enabled=\"1\" app_bg=\"mobile-app-development-in-kenya.png\" app_title=\"Shop faster with Farmart App\" app_description=\"Available on both iOS &amp; Android\" app_android_img=\"general/app-android.png\" app_android_link=\"#\" app_ios_img=\"general/app-ios.png\" app_ios_link=\"#\"][/featured-posts]</shortcode>',2,NULL,'homepage','','published','2024-02-24 01:37:28','2024-06-06 18:45:14'),
(2,'About us',NULL,2,NULL,NULL,NULL,'published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(3,'Terms Of Use',NULL,2,NULL,NULL,NULL,'published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(4,'Terms &amp; Conditions',NULL,2,NULL,NULL,NULL,'published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(5,'Refund Policy',NULL,2,NULL,NULL,NULL,'published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(6,'Blog','<p>---</p>',2,NULL,'full-width',NULL,'published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(7,'FAQs','<div>[faq title=\"Frequently Asked Questions\"][/faq]</div>',2,NULL,NULL,NULL,'published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(8,'Contact','<div>[google-map]502 New Street, Brighton VIC, Australia[/google-map]</div><div>[contact-info-boxes title=\"Contact Info\" subtitle=\"Location\" name_1=\"Store\" address_1=\"68 Atlantic Ave St, Brooklyn, NY 90002, USA\" phone_1=\"(+005) 5896 72 78 79\" email_1=\"support@farmart.com\" name_2=\"Warehouse\" address_2=\"172 Richmond Hill Ave St, Stamford, NY 90002, USA\" phone_2=\"(+005) 5896 03 04 05\" show_contact_form=\"1\" ][/contact-info-boxes]</div>',2,NULL,NULL,NULL,'published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(9,'Cookie Policy','<h3>EU Cookie Consent</h3><p>To use this Website we are using Cookies and collecting some Data. To be compliant with the EU GDPR we give you to choose if you allow us to use certain Cookies and to collect some Data.</p><h4>Essential Data</h4><p>The Essential Data is needed to run the Site you are visiting technically. You can not deactivate them.</p><p>- Session Cookie: PHP uses a Cookie to identify user sessions. Without this Cookie the Website is not working.</p><p>- XSRF-Token Cookie: Laravel automatically generates a CSRF \"token\" for each active user session managed by the application. This token is used to verify that the authenticated user is the one actually making the requests to the application.</p>',2,NULL,NULL,NULL,'published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(10,'Affiliate',NULL,2,NULL,NULL,NULL,'published','2024-02-24 01:37:29','2024-02-24 01:37:29'),
(11,'Career',NULL,2,NULL,NULL,NULL,'published','2024-02-24 01:37:29','2024-02-24 01:37:29'),
(12,'Coming soon','<div>[coming-soon time=\"2025-02-24 08:37:28\" title=\"We’re coming soon.\" subtitle=\"Currently we’re working on our brand new website and will be\nlaunching soon.\" social_title=\"Connect us on social networks\" image=\"general/coming-soon.jpg\"][/coming-soon]</div>',2,NULL,'coming-soon',NULL,'published','2024-02-24 01:37:29','2024-02-24 01:37:29');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages_translations`
--

DROP TABLE IF EXISTS `pages_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages_translations` (
  `lang_code` varchar(20) NOT NULL,
  `pages_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`pages_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages_translations`
--

LOCK TABLES `pages_translations` WRITE;
/*!40000 ALTER TABLE `pages_translations` DISABLE KEYS */;
INSERT INTO `pages_translations` VALUES
('en_US',1,'Home',NULL,'<shortcode>[simple-slider key=\"home-slider\" is_autoplay=\"yes\" is_infinite=\"yes\" autoplay_speed=\"5000\" background=\"general/slider-bg.jpg\" ads=\"ZDOZUZZIU7FZ\"][/simple-slider]</shortcode><shortcode>[featured-product-categories title=\"Browse by Category\"][/featured-product-categories]</shortcode><shortcode>[featured-brands title=\"Featured Brands\"][/featured-brands]</shortcode><shortcode>[flash-sale title=\"Top Saver Today\" flash_sale_id=\"1\"][/flash-sale]</shortcode><shortcode>[product-category-products title=\"Just Landing\" category_id=\"23\"][/product-category-products]</shortcode><shortcode>[theme-ads key_1=\"IZ6WU8KUALYD\" key_2=\"ILSFJVYFGCPZ\" key_3=\"ZDOZUZZIU7FT\"][/theme-ads]</shortcode><shortcode>[featured-products title=\"Featured products\"][/featured-products]</shortcode><shortcode>[product-collections title=\"Essential Products\"][/product-collections]</shortcode><shortcode>[product-category-products category_id=\"18\"][/product-category-products]</shortcode><shortcode>[featured-posts title=\"Health Daily\" background=\"general/blog-bg.jpg\" app_enabled=\"1\" app_title=\"Shop faster with Farmart App\" app_description=\"Available on both iOS &amp; Android\" app_bg=\"general/app-bg.png\" app_android_img=\"general/app-android.png\" app_android_link=\"#\" app_ios_img=\"general/app-ios.png\" app_ios_link=\"#\"][/featured-posts]</shortcode>');
/*!40000 ALTER TABLE `pages_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `currency` varchar(120) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `charge_id` varchar(255) DEFAULT NULL,
  `payment_channel` varchar(60) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` decimal(15,2) unsigned NOT NULL,
  `order_id` bigint(20) unsigned DEFAULT NULL,
  `status` varchar(60) DEFAULT 'pending',
  `payment_type` varchar(191) DEFAULT 'confirm',
  `customer_id` bigint(20) unsigned DEFAULT NULL,
  `refunded_amount` decimal(15,2) unsigned DEFAULT NULL,
  `refund_note` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_type` varchar(255) DEFAULT NULL,
  `metadata` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_categories`
--

DROP TABLE IF EXISTS `post_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_categories` (
  `category_id` bigint(20) unsigned NOT NULL,
  `post_id` bigint(20) unsigned NOT NULL,
  KEY `post_categories_category_id_index` (`category_id`),
  KEY `post_categories_post_id_index` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_categories`
--

LOCK TABLES `post_categories` WRITE;
/*!40000 ALTER TABLE `post_categories` DISABLE KEYS */;
INSERT INTO `post_categories` VALUES
(2,1),
(3,1),
(2,2),
(4,2),
(1,3),
(3,3),
(1,4),
(3,4),
(1,5),
(4,5),
(2,6),
(3,6),
(2,7),
(4,7),
(1,8),
(3,8),
(1,9),
(4,9),
(2,10),
(4,10),
(2,11),
(4,11);
/*!40000 ALTER TABLE `post_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_tags`
--

DROP TABLE IF EXISTS `post_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_tags` (
  `tag_id` bigint(20) unsigned NOT NULL,
  `post_id` bigint(20) unsigned NOT NULL,
  KEY `post_tags_tag_id_index` (`tag_id`),
  KEY `post_tags_post_id_index` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_tags`
--

LOCK TABLES `post_tags` WRITE;
/*!40000 ALTER TABLE `post_tags` DISABLE KEYS */;
INSERT INTO `post_tags` VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(1,2),
(2,2),
(3,2),
(4,2),
(5,2),
(1,3),
(2,3),
(3,3),
(4,3),
(5,3),
(1,4),
(2,4),
(3,4),
(4,4),
(5,4),
(1,5),
(2,5),
(3,5),
(4,5),
(5,5),
(1,6),
(2,6),
(3,6),
(4,6),
(5,6),
(1,7),
(2,7),
(3,7),
(4,7),
(5,7),
(1,8),
(2,8),
(3,8),
(4,8),
(5,8),
(1,9),
(2,9),
(3,9),
(4,9),
(5,9),
(1,10),
(2,10),
(3,10),
(4,10),
(5,10),
(1,11),
(2,11),
(3,11),
(4,11),
(5,11);
/*!40000 ALTER TABLE `post_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `author_id` bigint(20) unsigned DEFAULT NULL,
  `author_type` varchar(255) NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  `is_featured` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `views` int(10) unsigned NOT NULL DEFAULT 0,
  `format_type` varchar(30) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `posts_status_index` (`status`),
  KEY `posts_author_id_index` (`author_id`),
  KEY `posts_author_type_index` (`author_type`),
  KEY `posts_created_at_index` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES
(1,'4 Expert Tips On How To Choose The Right Men’s Wallet','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',2,'Botble\\ACL\\Models\\User',1,'news/1.jpg',2232,NULL,'2024-02-24 01:37:28','2024-02-24 01:37:28'),
(2,'Sexy Clutches: How to Buy &amp; Wear a Designer Clutch Bag','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',2,'Botble\\ACL\\Models\\User',1,'news/2.jpg',2426,NULL,'2024-02-24 01:37:28','2024-02-24 01:37:28'),
(3,'The Top 2020 Handbag Trends to Know','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',2,'Botble\\ACL\\Models\\User',1,'news/3.jpg',2237,NULL,'2024-02-24 01:37:28','2024-02-24 01:37:28'),
(4,'How to Match the Color of Your Handbag With an Outfit','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',2,'Botble\\ACL\\Models\\User',1,'news/4.jpg',940,NULL,'2024-02-24 01:37:28','2024-02-24 01:37:28'),
(5,'How to Care for Leather Bags','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',2,'Botble\\ACL\\Models\\User',1,'news/5.jpg',1739,NULL,'2024-02-24 01:37:28','2024-02-24 01:37:28'),
(6,'We\'re Crushing Hard on Summer\'s 10 Biggest Bag Trends','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',2,'Botble\\ACL\\Models\\User',1,'news/6.jpg',1672,NULL,'2024-02-24 01:37:28','2024-02-24 01:37:28'),
(7,'Essential Qualities of Highly Successful Music','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',2,'Botble\\ACL\\Models\\User',1,'news/7.jpg',1525,NULL,'2024-02-24 01:37:28','2024-02-24 01:37:28'),
(8,'9 Things I Love About Shaving My Head','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',2,'Botble\\ACL\\Models\\User',1,'news/8.jpg',1326,NULL,'2024-02-24 01:37:28','2024-02-24 01:37:28'),
(9,'Why Teamwork Really Makes The Dream Work','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p><p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p><p style=\"text-align:center;\"><img src=\"/storage/news/1.jpg\" alt=\"f4\"></p><p><br>&nbsp;</p><p><i><strong>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</strong></i></p><h4><strong>Number 1: Choose A Neat Wallet</strong></h4><p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p><p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p><p style=\"text-align:center;\"><img src=\"/storage/news/2.jpg\" alt=\"f5\"></p><p><br>&nbsp;</p><hr><h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4><p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p><p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p><p style=\"text-align:center;\"><img src=\"/storage/news/3.jpg\" alt=\"f1\"></p><p><br>&nbsp;</p><hr><h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4><p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p><p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p><p style=\"text-align:center;\"><img src=\"/storage/news/4.jpg\" alt=\"f6\"></p><p><br>&nbsp;</p><hr><h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4><p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p><p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p><p style=\"text-align:center;\"><img src=\"/storage/news/5.jpg\" alt=\"f2\"></p><p>&nbsp;</p>','published',2,'Botble\\ACL\\Models\\User',1,'360-f-232279556-s3mnv8sh2h7k5m3yawyrtmlezwkgagpt.jpg',2176,NULL,'2024-02-24 01:37:28','2025-03-29 08:04:33'),
(10,'The World Caters to Average People','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p><p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p><figure class=\"image\"><img style=\"aspect-ratio:700/463;\" src=\"https://emart.spanursinghome.org/storage/0gyiwwq3iwsylzc-i-1.jpg\" alt=\"0gyiwwq3iwsylzc-i-1.jpg\" width=\"700\" height=\"463\"></figure><p><br>&nbsp;</p><p><i><strong>For all the reason above, here are 7 expert tips to help you pick up the right men’s wallet for you:</strong></i></p><h4><strong>Number 1: Choose A Neat Wallet</strong></h4><p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p><p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don’t go cheesy on your wallet or else people will think that you have a funny and particular style.</p><p style=\"text-align:center;\"><img src=\"/storage/news/2.jpg\" alt=\"f5\"></p><p><br>&nbsp;</p><hr><h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4><p>You should avoid having an over-sized wallet. Don’t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers’ pocket. In addition, it will create a bulge and ruin your look.</p><p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don’t need anymore.</p><p style=\"text-align:center;\"><img src=\"/storage/news/3.jpg\" alt=\"f1\"></p><p><br>&nbsp;</p><hr><h4><strong>Number 3: Don’t Limit Your Options Of Materials</strong></h4><p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p><p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p><p style=\"text-align:center;\"><img src=\"/storage/news/4.jpg\" alt=\"f6\"></p><p><br>&nbsp;</p><hr><h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4><p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p><p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p><p style=\"text-align:center;\"><img src=\"/storage/news/5.jpg\" alt=\"f2\"></p><p>&nbsp;</p>','published',2,'Botble\\ACL\\Models\\User',1,'0gyiwwq3iwsylzc-i.jpg',1054,NULL,'2024-02-24 01:37:28','2024-06-06 16:24:30'),
(11,'The litigants on the screen are not actors','You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.','<p>I have seen many people underestimating the power of their wallets. To them, they are just a functional item they use to carry. As a result, they often end up with the wallets which are not really suitable for them.</p>\n\n<p>You should pay more attention when you choose your wallets. There are a lot of them on the market with the different designs and styles. When you choose carefully, you would be able to buy a wallet that is catered to your needs. Not to mention that it will help to enhance your style significantly.</p>\n\n<p style=\"text-align:center\"><img alt=\"f4\" src=\"/storage/news/1.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<p><strong><em>For all the reason above, here are 7 expert tips to help you pick up the right men&rsquo;s wallet for you:</em></strong></p>\n\n<h4><strong>Number 1: Choose A Neat Wallet</strong></h4>\n\n<p>The wallet is an essential accessory that you should go simple. Simplicity is the best in this case. A simple and neat wallet with the plain color and even&nbsp;<strong>minimalist style</strong>&nbsp;is versatile. It can be used for both formal and casual events. In addition, that wallet will go well with most of the clothes in your wardrobe.</p>\n\n<p>Keep in mind that a wallet will tell other people about your personality and your fashion sense as much as other clothes you put on. Hence, don&rsquo;t go cheesy on your wallet or else people will think that you have a funny and particular style.</p>\n\n<p style=\"text-align:center\"><img alt=\"f5\" src=\"/storage/news/2.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n<hr />\n<h4><strong>Number 2: Choose The Right Size For Your Wallet</strong></h4>\n\n<p>You should avoid having an over-sized wallet. Don&rsquo;t think that you need to buy a big wallet because you have a lot to carry with you. In addition, a fat wallet is very ugly. It will make it harder for you to slide the wallet into your trousers&rsquo; pocket. In addition, it will create a bulge and ruin your look.</p>\n\n<p>Before you go on to buy a new wallet, clean out your wallet and place all the items from your wallet on a table. Throw away things that you would never need any more such as the old bills or the expired gift cards. Remember to check your wallet on a frequent basis to get rid of all of the old stuff that you don&rsquo;t need anymore.</p>\n\n<p style=\"text-align:center\"><img alt=\"f1\" src=\"/storage/news/3.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 3: Don&rsquo;t Limit Your Options Of Materials</strong></h4>\n\n<p>The types and designs of wallets are not the only things that you should consider when you go out searching for your best wallet. You have more than 1 option of material rather than leather to choose from as well.</p>\n\n<p>You can experiment with other available options such as cotton, polyester and canvas. They all have their own pros and cons. As a result, they will be suitable for different needs and requirements. You should think about them all in order to choose the material which you would like the most.</p>\n\n<p style=\"text-align:center\"><img alt=\"f6\" src=\"/storage/news/4.jpg\" /></p>\n\n<p><br />\n&nbsp;</p>\n\n<hr />\n<h4><strong>Number 4: Consider A Wallet As A Long Term Investment</strong></h4>\n\n<p>Your wallet is indeed an investment that you should consider spending a decent amount of time and effort on it. Another factor that you need to consider is how much you want to spend on your wallet. The price ranges of wallets on the market vary a great deal. You can find a wallet which is as cheap as about 5 to 7 dollars. On the other hand, you should expect to pay around 250 to 300 dollars for a high-quality wallet.</p>\n\n<p>In case you need a wallet to use for a long time, it is a good idea that you should invest a decent amount of money on a wallet. A high quality wallet from a reputational brand with the premium quality such as cowhide leather will last for a long time. In addition, it is an accessory to show off your fashion sense and your social status.</p>\n\n<p style=\"text-align:center\"><img alt=\"f2\" src=\"/storage/news/5.jpg\" /></p>\n\n<p>&nbsp;</p>\n','published',2,'Botble\\ACL\\Models\\User',0,'news/11.jpg',1779,NULL,'2024-02-24 01:37:28','2024-02-24 01:37:28');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_translations`
--

DROP TABLE IF EXISTS `posts_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts_translations` (
  `lang_code` varchar(20) NOT NULL,
  `posts_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`posts_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_translations`
--

LOCK TABLES `posts_translations` WRITE;
/*!40000 ALTER TABLE `posts_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `revisions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `revisionable_type` varchar(191) NOT NULL,
  `revisionable_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `key` varchar(120) NOT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `revisions_revisionable_id_revisionable_type_index` (`revisionable_id`,`revisionable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
INSERT INTO `revisions` VALUES
(1,'Botble\\Page\\Models\\Page',1,1,'description',NULL,'','2024-05-29 11:31:10','2024-05-29 11:31:10'),
(2,'Botble\\Page\\Models\\Page',1,1,'template','homepage','default','2024-05-29 11:34:26','2024-05-29 11:34:26'),
(3,'Botble\\Page\\Models\\Page',1,1,'template','default','homepage','2024-05-29 11:35:19','2024-05-29 11:35:19'),
(4,'Botble\\Blog\\Models\\Post',10,1,'image','news/10.jpg','0gyiwwq3iwsylzc-i.jpg','2024-06-06 16:24:30','2024-06-06 16:24:30'),
(5,'Botble\\Blog\\Models\\Post',9,1,'image','news/9.jpg','360-f-232279556-s3mnv8sh2h7k5m3yawyrtmlezwkgagpt.jpg','2024-06-06 16:29:54','2024-06-06 16:29:54');
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_users`
--

DROP TABLE IF EXISTS `role_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_users` (
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_users_user_id_index` (`user_id`),
  KEY `role_users_role_id_index` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_users`
--

LOCK TABLES `role_users` WRITE;
/*!40000 ALTER TABLE `role_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(120) NOT NULL,
  `name` varchar(120) NOT NULL,
  `permissions` text DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_slug_unique` (`slug`),
  KEY `roles_created_by_index` (`created_by`),
  KEY `roles_updated_by_index` (`updated_by`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,'admin','Admin','{\"users.index\":true,\"users.create\":true,\"users.edit\":true,\"users.destroy\":true,\"roles.index\":true,\"roles.create\":true,\"roles.edit\":true,\"roles.destroy\":true,\"core.system\":true,\"core.manage.license\":true,\"extensions.index\":true,\"media.index\":true,\"files.index\":true,\"files.create\":true,\"files.edit\":true,\"files.trash\":true,\"files.destroy\":true,\"folders.index\":true,\"folders.create\":true,\"folders.edit\":true,\"folders.trash\":true,\"folders.destroy\":true,\"settings.index\":true,\"settings.options\":true,\"settings.email\":true,\"settings.media\":true,\"settings.cronjob\":true,\"settings.admin-appearance\":true,\"settings.cache\":true,\"settings.datatables\":true,\"settings.email.rules\":true,\"menus.index\":true,\"menus.create\":true,\"menus.edit\":true,\"menus.destroy\":true,\"optimize.settings\":true,\"pages.index\":true,\"pages.create\":true,\"pages.edit\":true,\"pages.destroy\":true,\"plugins.index\":true,\"plugins.edit\":true,\"plugins.remove\":true,\"plugins.marketplace\":true,\"core.appearance\":true,\"theme.index\":true,\"theme.activate\":true,\"theme.remove\":true,\"theme.options\":true,\"theme.custom-css\":true,\"theme.custom-js\":true,\"theme.custom-html\":true,\"widgets.index\":true,\"ads.index\":true,\"ads.create\":true,\"ads.edit\":true,\"ads.destroy\":true,\"analytics.general\":true,\"analytics.page\":true,\"analytics.browser\":true,\"analytics.referrer\":true,\"analytics.settings\":true,\"audit-log.index\":true,\"audit-log.destroy\":true,\"backups.index\":true,\"backups.create\":true,\"backups.restore\":true,\"backups.destroy\":true,\"plugins.blog\":true,\"posts.index\":true,\"posts.create\":true,\"posts.edit\":true,\"posts.destroy\":true,\"categories.index\":true,\"categories.create\":true,\"categories.edit\":true,\"categories.destroy\":true,\"tags.index\":true,\"tags.create\":true,\"tags.edit\":true,\"tags.destroy\":true,\"blog.settings\":true,\"plugins.captcha\":true,\"captcha.settings\":true,\"contacts.index\":true,\"contacts.edit\":true,\"contacts.destroy\":true,\"contact.settings\":true,\"plugins.ecommerce\":true,\"ecommerce.settings\":true,\"ecommerce.report.index\":true,\"products.index\":true,\"products.create\":true,\"products.edit\":true,\"products.destroy\":true,\"products.duplicate\":true,\"product-categories.index\":true,\"product-categories.create\":true,\"product-categories.edit\":true,\"product-categories.destroy\":true,\"product-tag.index\":true,\"product-tag.create\":true,\"product-tag.edit\":true,\"product-tag.destroy\":true,\"brands.index\":true,\"brands.create\":true,\"brands.edit\":true,\"brands.destroy\":true,\"product-collections.index\":true,\"product-collections.create\":true,\"product-collections.edit\":true,\"product-collections.destroy\":true,\"product-attribute-sets.index\":true,\"product-attribute-sets.create\":true,\"product-attribute-sets.edit\":true,\"product-attribute-sets.destroy\":true,\"product-attributes.index\":true,\"product-attributes.create\":true,\"product-attributes.edit\":true,\"product-attributes.destroy\":true,\"tax.index\":true,\"tax.create\":true,\"tax.edit\":true,\"tax.destroy\":true,\"reviews.index\":true,\"reviews.create\":true,\"reviews.destroy\":true,\"reviews.publish\":true,\"reviews.reply\":true,\"shipping_methods.index\":true,\"ecommerce.shipping-rule-items.index\":true,\"ecommerce.shipping-rule-items.create\":true,\"ecommerce.shipping-rule-items.edit\":true,\"ecommerce.shipping-rule-items.destroy\":true,\"ecommerce.shipping-rule-items.bulk-import\":true,\"ecommerce.shipments.index\":true,\"ecommerce.shipments.create\":true,\"ecommerce.shipments.edit\":true,\"ecommerce.shipments.destroy\":true,\"orders.index\":true,\"orders.create\":true,\"orders.edit\":true,\"orders.destroy\":true,\"discounts.index\":true,\"discounts.create\":true,\"discounts.edit\":true,\"discounts.destroy\":true,\"customers.index\":true,\"customers.create\":true,\"customers.edit\":true,\"customers.destroy\":true,\"flash-sale.index\":true,\"flash-sale.create\":true,\"flash-sale.edit\":true,\"flash-sale.destroy\":true,\"product-label.index\":true,\"product-label.create\":true,\"product-label.edit\":true,\"product-label.destroy\":true,\"ecommerce.import.products.index\":true,\"ecommerce.export.products.index\":true,\"order_returns.index\":true,\"order_returns.edit\":true,\"order_returns.destroy\":true,\"global-option.index\":true,\"global-option.create\":true,\"global-option.edit\":true,\"global-option.destroy\":true,\"ecommerce.invoice.index\":true,\"ecommerce.invoice.edit\":true,\"ecommerce.invoice.destroy\":true,\"ecommerce.invoice-template.index\":true,\"ecommerce.settings.general\":true,\"ecommerce.settings.currencies\":true,\"ecommerce.settings.products\":true,\"ecommerce.settings.product-search\":true,\"ecommerce.settings.digital-products\":true,\"ecommerce.settings.store-locators\":true,\"ecommerce.settings.invoices\":true,\"ecommerce.settings.product-reviews\":true,\"ecommerce.settings.customers\":true,\"ecommerce.settings.shopping\":true,\"ecommerce.settings.taxes\":true,\"ecommerce.settings.shipping\":true,\"ecommerce.settings.tracking\":true,\"ecommerce.settings.standard-and-format\":true,\"ecommerce.settings.checkout\":true,\"ecommerce.settings.return\":true,\"ecommerce.settings.flash-sale\":true,\"plugin.faq\":true,\"faq.index\":true,\"faq.create\":true,\"faq.edit\":true,\"faq.destroy\":true,\"faq_category.index\":true,\"faq_category.create\":true,\"faq_category.edit\":true,\"faq_category.destroy\":true,\"faqs.settings\":true,\"languages.index\":true,\"languages.create\":true,\"languages.edit\":true,\"languages.destroy\":true,\"plugin.location\":true,\"country.index\":true,\"country.create\":true,\"country.edit\":true,\"country.destroy\":true,\"state.index\":true,\"state.create\":true,\"state.edit\":true,\"state.destroy\":true,\"city.index\":true,\"city.create\":true,\"city.edit\":true,\"city.destroy\":true,\"location.bulk-import.index\":true,\"location.export.index\":true,\"marketplace.index\":true,\"marketplace.store.index\":true,\"marketplace.store.create\":true,\"marketplace.store.edit\":true,\"marketplace.store.destroy\":true,\"marketplace.store.view\":true,\"marketplace.store.revenue.create\":true,\"marketplace.withdrawal.index\":true,\"marketplace.withdrawal.edit\":true,\"marketplace.withdrawal.destroy\":true,\"marketplace.vendors.index\":true,\"marketplace.unverified-vendors.index\":true,\"marketplace.unverified-vendors.edit\":true,\"marketplace.settings\":true,\"marketplace.reports\":true,\"newsletter.index\":true,\"newsletter.destroy\":true,\"newsletter.settings\":true,\"payment.index\":true,\"payments.settings\":true,\"payment.destroy\":true,\"simple-slider.index\":true,\"simple-slider.create\":true,\"simple-slider.edit\":true,\"simple-slider.destroy\":true,\"simple-slider-item.index\":true,\"simple-slider-item.create\":true,\"simple-slider-item.edit\":true,\"simple-slider-item.destroy\":true,\"simple-slider.settings\":true,\"social-login.settings\":true,\"plugins.translation\":true,\"translations.locales\":true,\"translations.theme-translations\":true,\"translations.index\":true}','Admin users role',1,2,2,'2024-02-24 01:36:32','2024-02-24 01:36:32');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES
(2,'api_enabled','0',NULL,'2026-08-03 15:17:54'),
(3,'activated_plugins','[\"language\",\"language-advanced\",\"ads\",\"analytics\",\"audit-log\",\"backup\",\"blog\",\"captcha\",\"contact\",\"cookie-consent\",\"ecommerce\",\"faq\",\"location\",\"marketplace\",\"newsletter\",\"payment\",\"paypal\",\"paypal-payout\",\"paystack\",\"razorpay\",\"shippo\",\"simple-slider\",\"social-login\",\"sslcommerz\",\"stripe\",\"translation\"]',NULL,'2026-08-03 15:17:54'),
(8,'language_hide_default','1',NULL,'2026-08-03 15:17:54'),
(10,'language_display','all',NULL,'2026-08-03 15:17:54'),
(11,'language_hide_languages','[]',NULL,'2026-08-03 15:17:54'),
(12,'ecommerce_store_name','Farmart',NULL,'2026-08-03 15:17:54'),
(13,'ecommerce_store_phone','1800979769',NULL,'2026-08-03 15:17:54'),
(14,'ecommerce_store_address','502 New Street',NULL,'2026-08-03 15:17:54'),
(15,'ecommerce_store_state','Brighton VIC',NULL,'2026-08-03 15:17:54'),
(16,'ecommerce_store_city','Brighton VIC',NULL,'2026-08-03 15:17:54'),
(17,'ecommerce_store_country','AU',NULL,'2026-08-03 15:17:54'),
(18,'simple_slider_using_assets','1',NULL,'2026-08-03 15:17:54'),
(19,'media_random_hash','da7e1667eb6f9acc6c927841fd06e056',NULL,'2026-08-03 15:17:54'),
(20,'payment_cod_status','1',NULL,'2026-08-03 15:17:54'),
(21,'payment_bank_transfer_status','1',NULL,'2026-08-03 15:17:54'),
(22,'theme','farmart',NULL,'2026-08-03 15:17:54'),
(23,'show_admin_bar','1',NULL,'2026-08-03 15:17:54'),
(24,'language_switcher_display','dropdown',NULL,'2026-08-03 15:17:54'),
(25,'admin_favicon','front-logo-66277c475d32f122778910.jpg',NULL,'2026-08-03 15:17:54'),
(26,'admin_logo','front-logo-66277c475d32f122778910.jpg',NULL,'2026-08-03 15:17:54'),
(27,'permalink-botble-blog-models-post','blog',NULL,'2026-08-03 15:17:54'),
(28,'permalink-botble-blog-models-category','blog',NULL,'2026-08-03 15:17:54'),
(29,'payment_cod_description','Please pay money directly to the postman, if you choose cash on delivery method (COD).',NULL,'2026-08-03 15:17:54'),
(30,'payment_bank_transfer_description','Please send money to our bank account: ACB - 69270 213 19.',NULL,'2026-08-03 15:17:54'),
(31,'payment_stripe_payment_type','stripe_checkout',NULL,'2026-08-03 15:17:54'),
(32,'plugins_ecommerce_customer_new_order_status','0',NULL,'2026-08-03 15:17:54'),
(33,'plugins_ecommerce_admin_new_order_status','0',NULL,'2026-08-03 15:17:54'),
(34,'ecommerce_is_enabled_support_digital_products','1',NULL,'2026-08-03 15:17:54'),
(35,'ecommerce_load_countries_states_cities_from_location_plugin','0',NULL,'2026-08-03 15:17:54'),
(36,'payment_bank_transfer_display_bank_info_at_the_checkout_success_page','1',NULL,'2026-08-03 15:17:54'),
(37,'ecommerce_product_sku_format','FM-2443-%s%s%s%s',NULL,'2026-08-03 15:17:54'),
(38,'theme-farmart-site_title','',NULL,'2026-08-03 15:17:54'),
(39,'theme-farmart-seo_description','Farmart is a modern and flexible Multipurpose Marketplace Laravel script. This script is suited for electronic, organic and grocery store, furniture store, clothing store, hitech store and accessories store… With the theme, you can create your own marketplace and allow vendors to sell just like Amazon, Envato, eBay…',NULL,'2026-08-03 15:17:54'),
(40,'theme-farmart-copyright','2024 © SPA MEDICAL SHOP. All Rights Reserved.',NULL,'2026-08-03 15:17:54'),
(41,'theme-farmart-favicon','front-logo-66277c475d32f122778910.jpg',NULL,'2026-08-03 15:17:54'),
(42,'theme-farmart-logo','front-logo-66277c475d32f122778910.jpg',NULL,'2026-08-03 15:17:54'),
(43,'theme-farmart-seo_og_image','general/open-graph-image.png',NULL,'2026-08-03 15:17:54'),
(44,'theme-farmart-image-placeholder','general/placeholder.png',NULL,'2026-08-03 15:17:54'),
(45,'theme-farmart-address','',NULL,'2026-08-03 15:17:54'),
(46,'theme-farmart-hotline','0719863747',NULL,'2026-08-03 15:17:54'),
(47,'theme-farmart-email','contact@fartmart.co',NULL,'2026-08-03 15:17:54'),
(48,'theme-farmart-working_time','Mon - Fri: 07AM - 06PM',NULL,'2026-08-03 15:17:54'),
(49,'theme-farmart-payment_methods_image','general/footer-payments.png',NULL,'2026-08-03 15:17:54'),
(50,'theme-farmart-homepage_id','1',NULL,'2026-08-03 15:17:54'),
(51,'theme-farmart-blog_page_id','6',NULL,'2026-08-03 15:17:54'),
(52,'theme-farmart-cookie_consent_message','Your experience on this site will be improved by allowing cookies',NULL,'2026-08-03 15:17:54'),
(53,'theme-farmart-cookie_consent_learn_more_url','cookie-policy',NULL,'2026-08-03 15:17:54'),
(54,'theme-farmart-cookie_consent_learn_more_text','Cookie Policy',NULL,'2026-08-03 15:17:54'),
(55,'theme-farmart-number_of_products_per_page','20',NULL,'2026-08-03 15:17:54'),
(56,'theme-farmart-number_of_cross_sale_product','6',NULL,'2026-08-03 15:17:54'),
(57,'theme-farmart-logo_in_the_checkout_page','general/logo.png',NULL,'2026-08-03 15:17:54'),
(58,'theme-farmart-logo_in_invoices','general/logo.png',NULL,'2026-08-03 15:17:54'),
(59,'theme-farmart-logo_vendor_dashboard','general/logo.png',NULL,'2026-08-03 15:17:54'),
(60,'theme-farmart-404_page_image','general/404.png',NULL,'2026-08-03 15:17:54'),
(61,'theme-farmart-social_links','[[{\"key\":\"social-name\",\"value\":\"Facebook\"},{\"key\":\"social-icon\",\"value\":\"general\\/facebook.png\"},{\"key\":\"social-url\",\"value\":\"https:\\/\\/www.facebook.com\\/\"}],[{\"key\":\"social-name\",\"value\":\"Twitter\"},{\"key\":\"social-icon\",\"value\":\"general\\/twitter.png\"},{\"key\":\"social-url\",\"value\":\"https:\\/\\/www.twitter.com\\/\"}],[{\"key\":\"social-name\",\"value\":\"Instagram\"},{\"key\":\"social-icon\",\"value\":\"general\\/instagram.png\"},{\"key\":\"social-url\",\"value\":\"https:\\/\\/www.instagram.com\\/\"}],[{\"key\":\"social-name\",\"value\":\"Pinterest\"},{\"key\":\"social-icon\",\"value\":\"general\\/pinterest.png\"},{\"key\":\"social-url\",\"value\":\"https:\\/\\/www.pinterest.com\\/\"}],[{\"key\":\"social-name\",\"value\":\"Youtube\"},{\"key\":\"social-icon\",\"value\":\"general\\/youtube.png\"},{\"key\":\"social-url\",\"value\":\"https:\\/\\/www.youtube.com\\/\"}]]',NULL,'2026-08-03 15:17:54'),
(62,'licensed_to','bmawira',NULL,'2026-08-03 15:17:54'),
(63,'theme-farmart-admin_logo','front-logo-66277c475d32f122778910.jpg',NULL,'2026-08-03 15:17:54'),
(64,'theme-farmart-admin_favicon','front-logo-66277c475d32f122778910.jpg',NULL,'2026-08-03 15:17:54'),
(65,'ecommerce__method','PUT',NULL,'2026-08-03 15:17:54'),
(66,'ecommerce__token','d46gIRbah7TooGYAQHVlXlsaEHvl3EHtGhon3GuT',NULL,'2026-08-03 15:17:54'),
(67,'ecommerce_enable_auto_detect_visitor_currency','0',NULL,'2026-08-03 15:17:54'),
(68,'ecommerce_add_space_between_price_and_currency','0',NULL,'2026-08-03 15:17:54'),
(69,'ecommerce_thousands_separator',',',NULL,'2026-08-03 15:17:54'),
(70,'ecommerce_decimal_separator','.',NULL,'2026-08-03 15:17:54'),
(71,'ecommerce_exchange_rate_api_provider','none',NULL,'2026-08-03 15:17:54'),
(72,'ecommerce_api_layer_api_key','',NULL,'2026-08-03 15:17:54'),
(73,'ecommerce_open_exchange_app_id','',NULL,'2026-08-03 15:17:54'),
(74,'ecommerce_use_exchange_rate_from_api','0',NULL,'2026-08-03 15:17:54'),
(75,'ecommerce_currencies_is_default','1',NULL,'2026-08-03 15:17:54'),
(76,'login_screen_backgrounds','[]',NULL,'2026-08-03 15:17:54'),
(77,'admin_title','SPA MEDICAL SHOP',NULL,'2026-08-03 15:17:54'),
(78,'rich_editor','ckeditor',NULL,'2026-08-03 15:17:54'),
(79,'admin_appearance_layout','vertical',NULL,'2026-08-03 15:17:54'),
(80,'admin_appearance_show_menu_item_icon','1',NULL,'2026-08-03 15:17:54'),
(81,'admin_appearance_container_width','container-xl',NULL,'2026-08-03 15:17:54'),
(82,'show_theme_guideline_link','0',NULL,'2026-08-03 15:17:54'),
(83,'admin_primary_font','Istok Web',NULL,'2026-08-03 15:17:54'),
(84,'admin_primary_color','#206bc4',NULL,'2026-08-03 15:17:54'),
(85,'admin_secondary_color','#6c7a91',NULL,'2026-08-03 15:17:54'),
(86,'admin_heading_color','inherit',NULL,'2026-08-03 15:17:54'),
(87,'admin_text_color','#182433',NULL,'2026-08-03 15:17:54'),
(88,'admin_link_color','#206bc4',NULL,'2026-08-03 15:17:54'),
(89,'admin_link_hover_color','#1a569d',NULL,'2026-08-03 15:17:54'),
(90,'admin_appearance_custom_css','',NULL,'2026-08-03 15:17:54'),
(91,'admin_appearance_custom_header_js','',NULL,'2026-08-03 15:17:54'),
(92,'admin_appearance_custom_body_js','',NULL,'2026-08-03 15:17:54'),
(93,'admin_appearance_custom_footer_js','',NULL,'2026-08-03 15:17:54'),
(94,'admin_appearance_locale_direction','ltr',NULL,'2026-08-03 15:17:54'),
(95,'theme-farmart-sticky_header_enabled','yes',NULL,'2026-08-03 15:17:54'),
(96,'theme-farmart-sticky_header_mobile_enabled','yes',NULL,'2026-08-03 15:17:54'),
(97,'theme-farmart-sticky_header_content_position','middle',NULL,'2026-08-03 15:17:54'),
(98,'theme-farmart-preloader_enabled','yes',NULL,'2026-08-03 15:17:54'),
(99,'theme-farmart-lazy_load_image_enabled','yes',NULL,'2026-08-03 15:17:54'),
(100,'theme-farmart-use_source_assets_from','cdn',NULL,'2026-08-03 15:17:54'),
(101,'theme-farmart-social_share_enabled','yes',NULL,'2026-08-03 15:17:54'),
(102,'theme-farmart-payment_methods_link','',NULL,'2026-08-03 15:17:54'),
(103,'theme-farmart-show_site_name','0',NULL,'2026-08-03 15:17:54'),
(104,'theme-farmart-seo_title','',NULL,'2026-08-03 15:17:54'),
(105,'theme-farmart-theme_breadcrumb_enabled','1',NULL,'2026-08-03 15:17:54'),
(106,'theme-farmart-primary_font','Muli',NULL,'2026-08-03 15:17:54'),
(107,'theme-farmart-primary_color','#fab528',NULL,'2026-08-03 15:17:54'),
(108,'theme-farmart-heading_color','#000',NULL,'2026-08-03 15:17:54'),
(109,'theme-farmart-text_color','#000',NULL,'2026-08-03 15:17:54'),
(110,'theme-farmart-primary_button_color','#000',NULL,'2026-08-03 15:17:54'),
(111,'theme-farmart-primary_button_background_color','#fab528',NULL,'2026-08-03 15:17:54'),
(112,'theme-farmart-top_header_background_color','#f7f7f7',NULL,'2026-08-03 15:17:54'),
(113,'theme-farmart-top_header_text_color','#000',NULL,'2026-08-03 15:17:54'),
(114,'theme-farmart-middle_header_background_color','#fff',NULL,'2026-08-03 15:17:54'),
(115,'theme-farmart-middle_header_text_color','#000',NULL,'2026-08-03 15:17:54'),
(116,'theme-farmart-bottom_header_background_color','#fff',NULL,'2026-08-03 15:17:54'),
(117,'theme-farmart-bottom_header_text_color','#000',NULL,'2026-08-03 15:17:54'),
(118,'theme-farmart-header_deliver_color','#000',NULL,'2026-08-03 15:17:54'),
(119,'theme-farmart-footer_text_color','#555',NULL,'2026-08-03 15:17:54'),
(120,'theme-farmart-footer_heading_color','#555',NULL,'2026-08-03 15:17:54'),
(121,'theme-farmart-footer_hover_color','#fab528',NULL,'2026-08-03 15:17:54'),
(122,'theme-farmart-footer_border_color','#ccc',NULL,'2026-08-03 15:17:54'),
(123,'theme-farmart-facebook_comment_enabled_in_product','no',NULL,'2026-08-03 15:17:54'),
(124,'theme-farmart-facebook_chat_enabled','no',NULL,'2026-08-03 15:17:54'),
(125,'theme-farmart-facebook_page_id','',NULL,'2026-08-03 15:17:54'),
(126,'theme-farmart-facebook_comment_enabled_in_post','no',NULL,'2026-08-03 15:17:54'),
(127,'theme-farmart-facebook_app_id','',NULL,'2026-08-03 15:17:54'),
(128,'theme-farmart-facebook_admins','[]',NULL,'2026-08-03 15:17:54'),
(129,'theme-farmart-store_list_layout','grid',NULL,'2026-08-03 15:17:54'),
(130,'theme-farmart-number_of_posts_in_a_category','12',NULL,'2026-08-03 15:17:54'),
(131,'theme-farmart-number_of_posts_in_a_tag','12',NULL,'2026-08-03 15:17:54'),
(132,'theme-farmart-enabled_product_categories_on_header','yes',NULL,'2026-08-03 15:17:54'),
(133,'theme-farmart-ecommerce_product_listing_page_slug','products',NULL,'2026-08-03 15:17:54'),
(134,'theme-farmart-max_filter_price','1287',NULL,'2026-08-03 15:17:54'),
(135,'theme-farmart-login_background',NULL,NULL,'2026-08-03 15:17:54'),
(136,'theme-farmart-register_background',NULL,NULL,'2026-08-03 15:17:54'),
(137,'theme-farmart-ecommerce_term_and_privacy_policy_url',NULL,NULL,'2026-08-03 15:17:54'),
(138,'theme-farmart-cookie_consent_enable','yes',NULL,'2026-08-03 15:17:54'),
(139,'theme-farmart-cookie_consent_style','full-width',NULL,'2026-08-03 15:17:54'),
(140,'theme-farmart-cookie_consent_button_text','Allow cookies',NULL,'2026-08-03 15:17:54'),
(141,'theme-farmart-cookie_consent_background_color','#000',NULL,'2026-08-03 15:17:54'),
(142,'theme-farmart-cookie_consent_text_color','#fff',NULL,'2026-08-03 15:17:54'),
(143,'theme-farmart-cookie_consent_max_width','1170',NULL,'2026-08-03 15:17:54'),
(144,'is_completed_get_started','1',NULL,'2026-08-03 15:17:54'),
(145,'ecommerce_how_to_display_product_variation_images','only_variation_images',NULL,'2026-08-03 15:17:54'),
(146,'ecommerce_show_number_of_products','1',NULL,'2026-08-03 15:17:54'),
(147,'ecommerce_show_out_of_stock_products','1',NULL,'2026-08-03 15:17:54'),
(148,'ecommerce_is_enabled_product_options','1',NULL,'2026-08-03 15:17:54'),
(149,'ecommerce_auto_generate_product_sku','1',NULL,'2026-08-03 15:17:54'),
(150,'_method','PUT',NULL,'2026-08-03 15:17:54'),
(151,'_token','J1dcfR6tIBwGFc6z3xvVWgYnUZdBDbGfjbDiCFgr',NULL,'2026-08-03 15:17:54'),
(152,'admin_email','[\"spahospitalruiruke@gmail.com\"]',NULL,'2026-08-03 15:17:54'),
(153,'time_zone','UTC',NULL,'2026-08-03 15:17:54'),
(154,'enable_send_error_reporting_via_email','0',NULL,'2026-08-03 15:17:54'),
(155,'redirect_404_to_homepage','0',NULL,'2026-08-03 15:17:54'),
(156,'locale','',NULL,'2026-08-03 15:17:54'),
(157,'membership_authorization_at','2026-08-03 18:17:54',NULL,'2026-08-03 15:17:54');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simple_slider_items`
--

DROP TABLE IF EXISTS `simple_slider_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `simple_slider_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `simple_slider_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `order` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simple_slider_items`
--

LOCK TABLES `simple_slider_items` WRITE;
/*!40000 ALTER TABLE `simple_slider_items` DISABLE KEYS */;
INSERT INTO `simple_slider_items` VALUES
(1,1,'Slider 1','sliders/01.jpg','/products',NULL,1,'2024-02-24 01:37:28','2024-02-24 01:37:28'),
(2,1,'Slider 2','sliders/02.jpg','/products',NULL,2,'2024-02-24 01:37:28','2024-02-24 01:37:28'),
(5,4,'no.1','61lvsjrnful.png','','',0,'2024-06-06 03:40:29','2024-06-06 03:40:29'),
(10,4,'Littmann','littmann.png','','',0,'2024-06-06 16:46:01','2024-06-06 16:46:01'),
(11,6,'Blood Pressure Machine','istockphoto-182226541-612x612.jpg','','',0,'2024-06-06 16:50:14','2024-06-06 16:50:14'),
(12,6,'','images-1.jpg','','',0,'2024-06-06 16:57:27','2024-06-06 16:57:27'),
(13,6,'','download-5.jpg','','',0,'2024-06-06 16:57:37','2024-06-06 16:57:37'),
(14,6,'','download-6.jpg','','',0,'2024-06-06 16:58:58','2024-06-06 16:58:58'),
(15,4,'','images-2.jpg','','',0,'2024-06-06 17:02:21','2024-06-06 17:02:21'),
(16,4,'','images-3.jpg','','',0,'2024-06-06 17:02:56','2024-06-06 17:02:56'),
(17,4,'','images-4.jpg','','',0,'2024-06-06 17:03:09','2024-06-06 17:03:09'),
(18,4,'','littmann-sample-edit.jpg','','',0,'2024-06-06 18:42:21','2024-06-06 18:42:21');
/*!40000 ALTER TABLE `simple_slider_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simple_sliders`
--

DROP TABLE IF EXISTS `simple_sliders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `simple_sliders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `key` varchar(120) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simple_sliders`
--

LOCK TABLES `simple_sliders` WRITE;
/*!40000 ALTER TABLE `simple_sliders` DISABLE KEYS */;
INSERT INTO `simple_sliders` VALUES
(1,'Home slider','home-slider','The main slider on homepage','published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(4,'Stethoscopes','FM-2443-VKWX','','published','2024-05-29 13:55:18','2024-06-06 18:51:42'),
(6,'Blood Pressure Machine','ZDOZUZZIU7FZ','','published','2024-06-06 16:49:38','2024-06-06 16:59:03');
/*!40000 ALTER TABLE `simple_sliders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slugs`
--

DROP TABLE IF EXISTS `slugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `slugs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `reference_id` bigint(20) unsigned NOT NULL,
  `reference_type` varchar(255) NOT NULL,
  `prefix` varchar(120) DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `slugs_reference_id_index` (`reference_id`),
  KEY `slugs_key_index` (`key`),
  KEY `slugs_prefix_index` (`prefix`),
  KEY `slugs_reference_index` (`reference_id`,`reference_type`)
) ENGINE=InnoDB AUTO_INCREMENT=375 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slugs`
--

LOCK TABLES `slugs` WRITE;
/*!40000 ALTER TABLE `slugs` DISABLE KEYS */;
INSERT INTO `slugs` VALUES
(1,'foodpound',1,'Botble\\Ecommerce\\Models\\Brand','brands','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(2,'itea-jsc',2,'Botble\\Ecommerce\\Models\\Brand','brands','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(3,'soda-brand',3,'Botble\\Ecommerce\\Models\\Brand','brands','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(4,'farmart',4,'Botble\\Ecommerce\\Models\\Brand','brands','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(5,'soda-brand',5,'Botble\\Ecommerce\\Models\\Brand','brands','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(6,'health-wellness-booksresources',1,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2025-07-15 12:54:47'),
(8,'apples',3,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(9,'bananas',4,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(10,'berries',5,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(11,'oranges-easy-peelers',6,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(12,'grapes',7,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(13,'lemons-limes',8,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(14,'peaches-nectarines',9,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(15,'pears',10,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(16,'melon',11,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(17,'avocados',12,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(18,'plums-apricots',13,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(20,'potatoes',15,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(21,'carrots-root-vegetables',16,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(22,'broccoli-cauliflower',17,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(23,'cabbage-spinach-greens',18,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(24,'onions-leeks-garlic',19,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(25,'mushrooms',20,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(26,'tomatoes',21,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(27,'beans-peas-sweetcorn',22,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(28,'freshly-drink-orange-juice',23,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(29,'monitoring-devices',24,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2025-07-15 12:53:33'),
(30,'crisps-snacks-nuts',25,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(32,'maternity-baby-care',27,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2025-07-15 12:51:52'),
(33,'rehabilitation-therapy-aids',28,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2025-07-15 12:50:53'),
(43,'vitamins-supplements',38,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2025-07-15 12:49:48'),
(45,'tomatoes',40,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(46,'baked-beans-spaghetti',41,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(47,'fish',42,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(48,'beans-pulses',43,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(49,'fruit',44,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(50,'coconut-milk-cream',45,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(51,'lighter-options',46,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(52,'olives',47,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(53,'sweetcorn',48,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(54,'carrots',49,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(55,'peas',50,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(56,'mixed-vegetables',51,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(57,'hospital-and-laboratory-equipment',52,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2025-07-15 12:55:36'),
(60,'ready-meals',55,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(61,'meals-for-1',56,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(62,'meals-for-2',57,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(63,'indian',58,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(64,'italian',59,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(65,'chinese',60,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(66,'traditional-british',61,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(67,'thai-oriental',62,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(68,'mediterranean-moroccan',63,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(69,'mexican-caribbean',64,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(70,'lighter-meals',65,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(71,'lunch-veg-pots',66,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(73,'salad-bags',68,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(74,'cucumber',69,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(75,'tomatoes',70,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:33','2024-02-24 01:36:33'),
(76,'lettuce',71,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:34','2024-02-24 01:36:34'),
(77,'lunch-salad-bowls',72,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:34','2024-02-24 01:36:34'),
(78,'lunch-salad-bowls',73,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:34','2024-02-24 01:36:34'),
(79,'fresh-herbs',74,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:34','2024-02-24 01:36:34'),
(80,'avocados',75,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:34','2024-02-24 01:36:34'),
(81,'peppers',76,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:34','2024-02-24 01:36:34'),
(82,'coleslaw-potato-salad',77,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:34','2024-02-24 01:36:34'),
(83,'spring-onions',78,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:34','2024-02-24 01:36:34'),
(84,'chilli-ginger-garlic',79,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-02-24 01:36:34','2024-02-24 01:36:34'),
(89,'electronic',1,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(90,'mobile',2,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(91,'iphone',3,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(92,'printer',4,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(93,'office',5,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(94,'it',6,'Botble\\Ecommerce\\Models\\ProductTag','product-tags','2024-02-24 01:36:38','2024-02-24 01:36:38'),
(160,'gopro',1,'Botble\\Marketplace\\Models\\Store','stores','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(161,'global-office',2,'Botble\\Marketplace\\Models\\Store','stores','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(162,'young-shop',3,'Botble\\Marketplace\\Models\\Store','stores','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(163,'global-store',4,'Botble\\Marketplace\\Models\\Store','stores','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(164,'roberts-store',5,'Botble\\Marketplace\\Models\\Store','stores','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(165,'stouffer',6,'Botble\\Marketplace\\Models\\Store','stores','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(166,'starkist',7,'Botble\\Marketplace\\Models\\Store','stores','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(167,'old-el-paso',8,'Botble\\Marketplace\\Models\\Store','stores','2024-02-24 01:36:55','2024-02-24 01:36:55'),
(168,'ecommerce',1,'Botble\\Blog\\Models\\Category','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(169,'fashion',2,'Botble\\Blog\\Models\\Category','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(170,'electronic',3,'Botble\\Blog\\Models\\Category','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(171,'commercial',4,'Botble\\Blog\\Models\\Category','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(172,'general',1,'Botble\\Blog\\Models\\Tag','tag','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(173,'design',2,'Botble\\Blog\\Models\\Tag','tag','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(174,'fashion',3,'Botble\\Blog\\Models\\Tag','tag','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(175,'branding',4,'Botble\\Blog\\Models\\Tag','tag','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(176,'modern',5,'Botble\\Blog\\Models\\Tag','tag','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(177,'4-expert-tips-on-how-to-choose-the-right-mens-wallet',1,'Botble\\Blog\\Models\\Post','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(178,'sexy-clutches-how-to-buy-wear-a-designer-clutch-bag',2,'Botble\\Blog\\Models\\Post','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(179,'the-top-2020-handbag-trends-to-know',3,'Botble\\Blog\\Models\\Post','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(180,'how-to-match-the-color-of-your-handbag-with-an-outfit',4,'Botble\\Blog\\Models\\Post','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(181,'how-to-care-for-leather-bags',5,'Botble\\Blog\\Models\\Post','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(182,'were-crushing-hard-on-summers-10-biggest-bag-trends',6,'Botble\\Blog\\Models\\Post','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(183,'essential-qualities-of-highly-successful-music',7,'Botble\\Blog\\Models\\Post','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(184,'9-things-i-love-about-shaving-my-head',8,'Botble\\Blog\\Models\\Post','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(185,'why-teamwork-really-makes-the-dream-work',9,'Botble\\Blog\\Models\\Post','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(186,'the-world-caters-to-average-people',10,'Botble\\Blog\\Models\\Post','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(187,'the-litigants-on-the-screen-are-not-actors',11,'Botble\\Blog\\Models\\Post','blog','2024-02-24 01:37:28','2024-02-24 01:37:29'),
(188,'home',1,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(189,'about-us',2,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(190,'terms-of-use',3,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(191,'terms-conditions',4,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(192,'refund-policy',5,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(193,'blog',6,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(194,'faqs',7,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(195,'contact',8,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(196,'cookie-policy',9,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:29','2024-02-24 01:37:29'),
(197,'affiliate',10,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:29','2024-02-24 01:37:29'),
(198,'career',11,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:29','2024-02-24 01:37:29'),
(199,'coming-soon',12,'Botble\\Page\\Models\\Page','','2024-02-24 01:37:29','2024-02-24 01:37:29'),
(367,'blood-pressure-machine',233,'Botble\\Ecommerce\\Models\\Product','products','2024-05-29 03:53:38','2024-05-29 03:53:38'),
(370,'antonio-mwangi',10,'Botble\\Marketplace\\Models\\Store','stores','2024-05-29 10:37:31','2024-05-29 10:37:31'),
(371,'medical-electronics',85,'Botble\\Ecommerce\\Models\\ProductCategory','product-categories','2024-05-29 12:57:22','2024-05-29 12:57:22'),
(372,'glucometer',234,'Botble\\Ecommerce\\Models\\Product','products','2024-05-29 14:15:58','2024-05-29 14:15:58'),
(373,'glucometer-1',235,'Botble\\Ecommerce\\Models\\Product','products','2024-05-29 14:43:51','2024-05-29 14:43:51'),
(374,'stethoscope',236,'Botble\\Ecommerce\\Models\\Product','products','2024-06-03 19:52:15','2024-06-03 19:52:15');
/*!40000 ALTER TABLE `slugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slugs_translations`
--

DROP TABLE IF EXISTS `slugs_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `slugs_translations` (
  `lang_code` varchar(20) NOT NULL,
  `slugs_id` bigint(20) unsigned NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `prefix` varchar(120) DEFAULT '',
  PRIMARY KEY (`lang_code`,`slugs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slugs_translations`
--

LOCK TABLES `slugs_translations` WRITE;
/*!40000 ALTER TABLE `slugs_translations` DISABLE KEYS */;
INSERT INTO `slugs_translations` VALUES
('en_US',367,'blood-pressure-machine','products');
/*!40000 ALTER TABLE `slugs_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `abbreviation` varchar(10) DEFAULT NULL,
  `country_id` bigint(20) unsigned DEFAULT NULL,
  `order` tinyint(4) NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `states_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states_translations`
--

DROP TABLE IF EXISTS `states_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `states_translations` (
  `lang_code` varchar(20) NOT NULL,
  `states_id` bigint(20) unsigned NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `abbreviation` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`states_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states_translations`
--

LOCK TABLES `states_translations` WRITE;
/*!40000 ALTER TABLE `states_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `states_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `author_id` bigint(20) unsigned DEFAULT NULL,
  `author_type` varchar(255) NOT NULL DEFAULT 'Botble\\ACL\\Models\\User',
  `description` varchar(400) DEFAULT '',
  `status` varchar(60) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES
(1,'General',2,'Botble\\ACL\\Models\\User','','published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(2,'Design',2,'Botble\\ACL\\Models\\User','','published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(3,'Fashion',2,'Botble\\ACL\\Models\\User','','published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(4,'Branding',2,'Botble\\ACL\\Models\\User','','published','2024-02-24 01:37:28','2024-02-24 01:37:28'),
(5,'Modern',2,'Botble\\ACL\\Models\\User','','published','2024-02-24 01:37:28','2024-02-24 01:37:28');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_translations`
--

DROP TABLE IF EXISTS `tags_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags_translations` (
  `lang_code` varchar(20) NOT NULL,
  `tags_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`lang_code`,`tags_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_translations`
--

LOCK TABLES `tags_translations` WRITE;
/*!40000 ALTER TABLE `tags_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_meta`
--

DROP TABLE IF EXISTS `user_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_meta` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(120) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_meta_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_meta`
--

LOCK TABLES `user_meta` WRITE;
/*!40000 ALTER TABLE `user_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(191) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(120) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `first_name` varchar(120) DEFAULT NULL,
  `last_name` varchar(120) DEFAULT NULL,
  `username` varchar(60) DEFAULT NULL,
  `avatar_id` bigint(20) unsigned DEFAULT NULL,
  `super_user` tinyint(1) NOT NULL DEFAULT 0,
  `manage_supers` tinyint(1) NOT NULL DEFAULT 0,
  `permissions` text DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'admin@admin.com',NULL,'$2y$12$xOqAJCeBCKS./uALkglsE.T01e.7MfC4rI3UExFR185z82sg8i73O','dVasCtHumHP2syiOPykNDPA5Hm6Adb6j6RlFUkKP7cC5ZpFQQiILWYNsxpID','2024-05-15 13:45:22','2024-05-29 04:17:50','Antonio','Mwangi','admin',NULL,1,1,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `widgets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `widget_id` varchar(120) NOT NULL,
  `sidebar_id` varchar(120) NOT NULL,
  `theme` varchar(120) NOT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `data` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES
(6,'BlogSearchWidget','primary_sidebar','farmart',1,'{\"id\":\"BlogSearchWidget\",\"name\":\"Search\"}','2024-02-24 01:37:30','2024-02-24 01:37:30'),
(7,'BlogCategoriesWidget','primary_sidebar','farmart',2,'{\"id\":\"BlogCategoriesWidget\",\"name\":\"Categories\"}','2024-02-24 01:37:30','2024-02-24 01:37:30'),
(8,'RecentPostsWidget','primary_sidebar','farmart',3,'{\"id\":\"RecentPostsWidget\",\"name\":\"Recent Posts\"}','2024-02-24 01:37:30','2024-02-24 01:37:30'),
(9,'BlogTagsWidget','primary_sidebar','farmart',4,'{\"id\":\"BlogTagsWidget\",\"name\":\"Popular Tags\"}','2024-02-24 01:37:30','2024-02-24 01:37:30'),
(10,'SiteFeaturesWidget','pre_footer_sidebar','farmart',1,'{\"id\":\"SiteFeaturesWidget\",\"title\":\"Site Features\",\"data\":{\"1\":{\"icon\":\"general\\/icon-rocket.png\",\"title\":\"Free Shipping\",\"subtitle\":\"For all orders over $200\"},\"2\":{\"icon\":\"general\\/icon-reload.png\",\"title\":\"1 & 1 Returns\",\"subtitle\":\"Cancellation after 1 day\"},\"3\":{\"icon\":\"general\\/icon-protect.png\",\"title\":\"100% Secure Payment\",\"subtitle\":\"Guarantee secure payments\"},\"4\":{\"icon\":\"general\\/icon-support.png\",\"title\":\"24\\/7 Dedicated Support\",\"subtitle\":\"Anywhere & anytime\"},\"5\":{\"icon\":\"general\\/icon-tag.png\",\"title\":\"Daily Offers\",\"subtitle\":\"Discount up to 70% OFF\"}}}','2024-02-24 01:37:30','2024-02-24 01:37:30'),
(11,'AdsWidget','products_list_sidebar','farmart',1,'{\"id\":\"AdsWidget\",\"title\":\"Ads\",\"ads_key\":\"ZDOZUZZIU7FZ\",\"background\":\"general\\/background.jpg\",\"size\":\"full-width\"}','2024-02-24 01:37:30','2024-02-24 01:37:30'),
(23,'SiteFeaturesWidget','product_detail_sidebar','farmart',0,'{\"id\":\"SiteFeaturesWidget\",\"name\":\"Site features\",\"data\":{\"1\":{\"title\":\"Free Shipping\",\"subtitle\":\"For all orders over $200\",\"icon\":\"general\\/icon-rocket.png\"},\"2\":{\"title\":\"1 & 1 Returns\",\"subtitle\":\"Cancellation after 1 day\",\"icon\":\"general\\/icon-reload.png\"},\"3\":{\"title\":\"Secure Payment\",\"subtitle\":\"Guarantee secure payments\",\"icon\":\"general\\/icon-protect.png\"},\"4\":{\"title\":\"\",\"subtitle\":\"\",\"icon\":\"\"},\"5\":{\"title\":\"\",\"subtitle\":\"\",\"icon\":\"\"}}}','2024-05-29 11:07:38','2024-05-29 11:07:38'),
(24,'SiteInfoWidget','product_detail_sidebar','farmart',1,'{\"id\":\"SiteInfoWidget\",\"name\":\"Antonio Mwangi\",\"about\":\"\",\"address\":\"Spa Hospital\",\"phone\":\"(+254) 719-863-747\",\"email\":\"spahospitalruiruke@gmail.com\",\"working_time\":\"Mon - Fri: 07AM - 06PM\"}','2024-05-29 11:07:38','2024-05-29 11:07:38'),
(25,'BecomeVendorWidget','product_detail_sidebar','farmart',2,'{\"id\":\"BecomeVendorWidget\",\"name\":\"Become a Vendor?\"}','2024-05-29 11:07:38','2024-05-29 11:07:38'),
(86,'ProductCategoriesWidget','bottom_footer_sidebar','farmart',0,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Consumer Electric\",\"categories\":[\"85\"]}','2024-06-06 17:52:22','2024-06-06 17:52:22'),
(87,'ProductCategoriesWidget','bottom_footer_sidebar','farmart',1,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Clothing & Apparel\",\"categories\":[\"26\"]}','2024-06-06 17:52:22','2024-06-06 17:52:22'),
(88,'ProductCategoriesWidget','bottom_footer_sidebar','farmart',2,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Home, Garden & Kitchen\"}','2024-06-06 17:52:22','2024-06-06 17:52:22'),
(89,'ProductCategoriesWidget','bottom_footer_sidebar','farmart',3,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Health & Beauty\",\"categories\":[\"3\"]}','2024-06-06 17:52:22','2024-06-06 17:52:22'),
(90,'ProductCategoriesWidget','bottom_footer_sidebar','farmart',4,'{\"id\":\"ProductCategoriesWidget\",\"name\":\"Computer & Technologies\",\"categories\":[\"82\"]}','2024-06-06 17:52:22','2024-06-06 17:52:22'),
(91,'SiteInfoWidget','footer_sidebar','farmart',0,'{\"id\":\"SiteInfoWidget\",\"name\":\"Antonio Mwangi\",\"about\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed finibus viverra iaculis. Etiam vulputate et justo eget scelerisque.\",\"address\":\"Spa Hospital\",\"phone\":\"(+254) 719-863-747\",\"email\":\"spahospitalruiruke@gmail.com\",\"working_time\":\"Mon - Fri: 07AM - 06PM\"}','2024-06-06 17:56:44','2024-06-06 17:56:44'),
(92,'CustomMenuWidget','footer_sidebar','farmart',1,'{\"id\":\"CustomMenuWidget\",\"name\":\"Useful Links\",\"menu_id\":\"useful-links\"}','2024-06-06 17:56:44','2024-06-06 17:56:44'),
(93,'CustomMenuWidget','footer_sidebar','farmart',2,'{\"id\":\"CustomMenuWidget\",\"name\":\"Help Center\",\"menu_id\":\"help-center\"}','2024-06-06 17:56:44','2024-06-06 17:56:44'),
(94,'CustomMenuWidget','footer_sidebar','farmart',3,'{\"id\":\"CustomMenuWidget\",\"name\":\"Business\",\"menu_id\":\"business\"}','2024-06-06 17:56:44','2024-06-06 17:56:44'),
(95,'NewsletterWidget','footer_sidebar','farmart',4,'{\"id\":\"NewsletterWidget\",\"title\":\"Newsletter\",\"subtitle\":\"Register now to get updates on promotions and coupons.\"}','2024-06-06 17:56:44','2024-06-06 17:56:44');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'spanursi_eco'
--

--
-- Dumping routines for database 'spanursi_eco'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-10  4:27:53
