-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: cyanogen_update_tracker
-- ------------------------------------------------------
-- Server version	5.7.17-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_name` varchar(255) DEFAULT NULL,
  `model_number` varchar(30) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `enabled_no_data` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Used in app version 1.3.1 and higher',
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_name_UNIQUE` (`device_name`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_registration`
--

DROP TABLE IF EXISTS `device_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_registration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `registration_token` varchar(255) NOT NULL,
  `device_id` bigint(20) NOT NULL,
  `update_method_id` bigint(20) NOT NULL,
  `registration_date` datetime NOT NULL,
  `app_version` varchar(10) NOT NULL DEFAULT '< 1.3.0',
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`),
  KEY `update_method_id` (`update_method_id`),
  CONSTRAINT `fk_device_registration_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_device_registration_update_method` FOREIGN KEY (`update_method_id`) REFERENCES `update_method` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=825832 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_update_method`
--

DROP TABLE IF EXISTS `device_update_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_update_method` (
  `device_id` bigint(20) NOT NULL,
  `update_method_id` bigint(20) NOT NULL,
  PRIMARY KEY (`device_id`,`update_method_id`),
  KEY `fk_device_update_method_update_method_idx` (`update_method_id`),
  CONSTRAINT `fk_device_update_method_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_device_update_method_update_method` FOREIGN KEY (`update_method_id`) REFERENCES `update_method` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_category`
--

DROP TABLE IF EXISTS `faq_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faq_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_name_en` varchar(100) NOT NULL,
  `category_name_nl` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_item`
--

DROP TABLE IF EXISTS `faq_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faq_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) NOT NULL,
  `title_en` varchar(100) NOT NULL,
  `body_en` longtext NOT NULL,
  `title_nl` varchar(100) NOT NULL,
  `body_nl` longtext NOT NULL,
  `important` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_faq_item_1_idx` (`category_id`),
  CONSTRAINT `fk_faq_item_faq_category` FOREIGN KEY (`category_id`) REFERENCES `faq_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `install_guide`
--

DROP TABLE IF EXISTS `install_guide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `install_guide` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) NOT NULL,
  `update_method_id` bigint(20) NOT NULL,
  `page_number` enum('1','2','3','4','5') NOT NULL,
  `is_custom_page` tinyint(1) DEFAULT '0',
  `file_extension` varchar(5) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `use_custom_image` tinyint(1) DEFAULT '0',
  `title_en` varchar(150) DEFAULT NULL,
  `title_nl` varchar(150) DEFAULT NULL,
  `text_en` longtext,
  `text_nl` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_install_guide` (`device_id`,`update_method_id`,`page_number`),
  KEY `fk_install_guide_device_idx` (`device_id`),
  KEY `fk_install_guide_update_method_idx` (`update_method_id`),
  CONSTRAINT `fk_install_guide_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_install_guide_update_method` FOREIGN KEY (`update_method_id`) REFERENCES `update_method` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications_device`
--

DROP TABLE IF EXISTS `notifications_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications_device` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) NOT NULL,
  `device_name` varchar(150) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `in_notifications_device_to_device` (`device_id`),
  CONSTRAINT `fk_notifications_device_to_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications_update_data`
--

DROP TABLE IF EXISTS `notifications_update_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications_update_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) NOT NULL,
  `update_method_id` bigint(20) NOT NULL,
  `update_data_id` bigint(20) NOT NULL,
  `version_number` varchar(255) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`),
  KEY `update_method_id` (`update_method_id`),
  KEY `fk_notifications_update_data_update_data_new_idx` (`update_data_id`),
  CONSTRAINT `fk_notifications_update_data_update_data_new` FOREIGN KEY (`update_data_id`) REFERENCES `update_data_new` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_version_data_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_version_data_update_method` FOREIGN KEY (`update_method_id`) REFERENCES `update_method` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=468628 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_message`
--

DROP TABLE IF EXISTS `server_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL,
  `message_nl` varchar(255) NOT NULL,
  `device_id` bigint(20) DEFAULT NULL,
  `update_method_id` bigint(20) DEFAULT NULL,
  `priority` enum('LOW','MEDIUM','HIGH') NOT NULL,
  `marquee` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_server_message_device` (`device_id`),
  KEY `fk_server_message_update_method_idx` (`update_method_id`),
  CONSTRAINT `fk_server_message_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_server_message_update_method` FOREIGN KEY (`update_method_id`) REFERENCES `update_method` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_status`
--

DROP TABLE IF EXISTS `server_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_status` (
  `status` enum('OK','WARNING','ERROR','TAKEN_DOWN','MAINTENANCE') NOT NULL,
  `latest_app_version` varchar(5) NOT NULL,
  `app_download_size` double(3,2) NOT NULL,
  UNIQUE KEY `unq_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `update_data`
--

DROP TABLE IF EXISTS `update_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `update_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) NOT NULL,
  `update_method_id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` longtext,
  `rollout_percentage` tinyint(3) NOT NULL,
  `filename` varchar(150) NOT NULL,
  `download_url` varchar(255) NOT NULL,
  `size` int(10) NOT NULL,
  `md5sum` varchar(255) NOT NULL,
  `date_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_update_data_device` (`device_id`),
  KEY `fk_update_data_update_method` (`update_method_id`),
  CONSTRAINT `fk_update_data_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_update_data_update_method` FOREIGN KEY (`update_method_id`) REFERENCES `update_method` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `update_data_link`
--

DROP TABLE IF EXISTS `update_data_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `update_data_link` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) NOT NULL,
  `update_method_id` bigint(20) DEFAULT NULL,
  `update_data_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`),
  KEY `update_method_id` (`update_method_id`),
  CONSTRAINT `fk_update_data_link_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_update_data_link_update_method` FOREIGN KEY (`update_method_id`) REFERENCES `update_method` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `update_data_new`
--

DROP TABLE IF EXISTS `update_data_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `update_data_new` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) NOT NULL,
  `update_method_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext,
  `download_url` varchar(255) DEFAULT NULL,
  `size` int(10) NOT NULL DEFAULT '0',
  `incremental` varchar(255) DEFAULT NULL,
  `incremental_parent` varchar(255) DEFAULT NULL,
  `md5sum` varchar(255) NOT NULL,
  `is_latest_version` tinyint(1) DEFAULT '0',
  `update_number` int(4) DEFAULT '999',
  PRIMARY KEY (`id`),
  KEY `fk_update_data_new_device_idx` (`device_id`),
  KEY `fk_update_data_new_update_method_idx` (`update_method_id`),
  CONSTRAINT `fk_update_data_new_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_update_data_new_update_method` FOREIGN KEY (`update_method_id`) REFERENCES `update_method` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `update_method`
--

DROP TABLE IF EXISTS `update_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `update_method` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_method` varchar(255) DEFAULT NULL,
  `update_method_nl` varchar(255) DEFAULT NULL,
  `recommended` tinyint(1) DEFAULT '0',
  `requires_incremental_parent` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-04 15:11:18
