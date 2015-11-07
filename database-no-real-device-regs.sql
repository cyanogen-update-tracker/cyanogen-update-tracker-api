-- MySQL dump 10.13  Distrib 5.5.46, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: cyanogen_update_tracker
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2

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
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `enabled_no_data` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Used in app version 1.3.1 and higher',
  PRIMARY KEY (`id`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (1,'OnePlus One',1,0),(2,'YU Yureka',1,0),(3,'Oppo N1 CyanogenMod Edition',1,0),(4,'YU Yureka Plus',1,0),(5,'YU Yuphoria',1,0),(6,'Alcatel Onetouch Hero 2+',0,0),(7,'Smartfren Andromax Q',1,0),(8,'YU Yunique',0,0),(9,'ZUK Z1',1,0),(10,'Wileyfox Swift',1,0),(11,'Wileyfox Storm',0,0);
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `t_insert_device` BEFORE INSERT ON `device` FOR EACH ROW BEGIN
DECLARE new_enabled boolean;
DECLARE count_update_links integer;
DECLARE new_id bigint;
SET new_enabled = NEW.enabled;
SET new_id = NEW.id;
SET count_update_links = (SELECT COUNT(*) FROM update_data_link WHERE device_id = new_id);

IF new_enabled = 1 THEN
    IF count_update_links = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A device must have at least one or more update data links before it can be enabled';
    END IF;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `t_update_device` BEFORE UPDATE ON `device` FOR EACH ROW BEGIN
DECLARE new_enabled boolean;
DECLARE count_update_links integer;
DECLARE new_id bigint;
SET new_enabled = NEW.enabled;
SET new_id = NEW.id;
SET count_update_links = (SELECT COUNT(*) FROM update_data_link WHERE device_id = new_id);

IF new_enabled = 1 THEN
    IF count_update_links = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A device must have at least one or more update data links before it can be enabled';
    END IF;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=106288 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_registration`
--

LOCK TABLES `device_registration` WRITE;
/*!40000 ALTER TABLE `device_registration` DISABLE KEYS */;
INSERT INTO `device_registration` VALUES (62,'dtiKckH61Ek:APA91bEVfLao-xg8b4QYKQP7fGC2vCIJAtwYSKks2jT3V1tua8RkTzJKz6XeVQOkAMmzbHt9Imm6NDmfKalTmVygtXpfZPj0GXgfQtWhCT8hbBElOSdbjStmXbxNdAvTnGpP7MU8TjL5',1,1,'2015-08-04 00:08:58','1.2.2');

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
  `priority` enum('LOW','MEDIUM','HIGH') NOT NULL,
  `marquee` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_server_message_device` (`device_id`),
  CONSTRAINT `fk_server_message_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_message`
--

LOCK TABLES `server_message` WRITE;
/*!40000 ALTER TABLE `server_message` DISABLE KEYS */;
INSERT INTO `server_message` VALUES (1,'Cyanogen OS 12.1 is coming soon!','Cyanogen OS 12.1 komt er bijna aan!',2,'LOW',0,0),(2,'OnePlus One users updated to version 12.1-YOG4PAS1N0 before it was taken down should not update to this version again!','OnePlus One-gebruikers die versie 12.1-YOG4PAS1N0 hebben geinstalleerd voordat deze offline werd gehaald moeten niet nogmaals naar dezelfde versie updaten!',1,'HIGH',1,0),(6,'Cyanogen OS 12.1 is coming soon!','Cyanogen OS 12.1 komt er bijna aan!',5,'LOW',0,0),(7,'This is an older version! Download this only if you know what you are doing!','Dit is een oudere versie! Download deze versie alleen als je weet wat je doet!',2,'HIGH',1,0),(9,'This is an older version! Download this only if you know what you are doing!','Dit is een oudere versie! Download deze versie alleen als je weet wat je doet!',4,'HIGH',1,0),(11,'The full update can\'t be downloaded. Please use the incremental update (Cyanogen Server Error)','De volledige update kan niet worden gedownload. Gebruik a.u.b. de incrementele update (Cyanogen-serverfout)',1,'HIGH',1,0),(12,'If YNG1TAS1K0 is displayed, please go to Menu -> Settings and re-select your device.','Als YNG1TAS1K0 wordt weergegeven, ga dan naar Menu -> Instellingen en kies je apparaat opnieuw.',2,'MEDIUM',1,0),(13,'If YNG1TAS1K0 is displayed, please go to Menu -> Settings and re-select your device.','Als YNG1TAS1K0 wordt weergegeven, ga dan naar Menu -> Instellingen en kies je apparaat opnieuw.',4,'MEDIUM',1,0),(14,'Cyanogen Server: access for app denied.','Cyanogen Server: app heeft geen toegang.',NULL,'HIGH',1,0);
/*!40000 ALTER TABLE `server_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_status`
--

DROP TABLE IF EXISTS `server_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_status` (
  `status` enum('OK','WARNING','ERROR','TAKEN_DOWN','MAINTENANCE') NOT NULL,
  `latest_app_version` varchar(5) NOT NULL,
  UNIQUE KEY `unq_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_status`
--

LOCK TABLES `server_status` WRITE;
/*!40000 ALTER TABLE `server_status` DISABLE KEYS */;
INSERT INTO `server_status` VALUES ('OK','1.4.1');
/*!40000 ALTER TABLE `server_status` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `update_data_link`
--

LOCK TABLES `update_data_link` WRITE;
/*!40000 ALTER TABLE `update_data_link` DISABLE KEYS */;
INSERT INTO `update_data_link` VALUES (1,1,2,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/OnePlusOneFull.json'),(2,1,1,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/OnePlusOneIncremental.json'),(3,2,2,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/YuYurekaFull.json'),(4,2,1,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/YuYurekaIncremental.json'),(5,3,2,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/OppoN1Full.json'),(6,3,1,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/OppoN1Incremental.json'),(7,4,2,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/YuYurekaPlusFull.json'),(8,4,1,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/YuYurekaPlusIncremental.json'),(9,5,2,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/YuYuphoriaFull.json'),(10,5,1,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/YuYuphoriaIncremental.json'),(11,7,2,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/SmartfrenAndromaxQFull.json'),(12,7,1,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/SmartfrenAndromaxQIncremental.json'),(13,8,2,'https://fota.cyngn.com/api/v1/update/get_latest?model=jalebi&type=STABLE'),(14,8,1,'https://fota.cyngn.com/api/v1/update/get_latest?model=jalebi&type=INCREMENTAL'),(15,9,2,'https://fota.cyngn.com/api/v1/update/get_latest?model=ham&type=STABLE'),(16,9,1,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/ZukZ1Incremental.json'),(17,10,2,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/WileyfoxSwiftFull.json'),(18,10,1,'http://cyanogenupdatetracker.com/api/v1.1/UpdateData/WileyfoxSwiftIncremental.json');
/*!40000 ALTER TABLE `update_data_link` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `update_method`
--

LOCK TABLES `update_method` WRITE;
/*!40000 ALTER TABLE `update_method` DISABLE KEYS */;
INSERT INTO `update_method` VALUES (1,'Incremental update','Incrementele update'),(2,'Full update','Volledige update');
/*!40000 ALTER TABLE `update_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version_data`
--

DROP TABLE IF EXISTS `version_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) NOT NULL,
  `update_method_id` bigint(20) NOT NULL,
  `version_number` varchar(255) DEFAULT NULL,
  `date_created` varchar(255) DEFAULT NULL COMMENT 'No date functions needed. Only for comparing if version is new. Therefore stored as varchar.',
  `date_fetched` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`),
  KEY `update_method_id` (`update_method_id`),
  CONSTRAINT `fk_version_data_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_version_data_update_method` FOREIGN KEY (`update_method_id`) REFERENCES `update_method` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=466862 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version_data`
--

LOCK TABLES `version_data` WRITE;
/*!40000 ALTER TABLE `version_data` DISABLE KEYS */;
INSERT INTO `version_data` VALUES (466782,1,1,'12.1-YOG4PAS3JL Incremental','2015-10-13T02:14:51.000000Z','2015-11-05 23:40:01'),(466783,1,2,'12.1-YOG4PAS3JL','2015-09-24T21:42:39.000000Z','2015-11-05 23:40:01'),(466784,2,1,'12.1-YOG4PAS3JM Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:40:01'),(466785,2,2,'12.1-YOG4PAS3JM','2015-10-31T15:24:06.000000Z','2015-11-05 23:40:01'),(466786,3,1,'XNPH40P Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:40:01'),(466787,3,2,'XNPH40P','2015-09-24T21:42:39.000000Z','2015-11-05 23:40:01'),(466788,4,1,'12.1-YOG4PAS3JM Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:40:01'),(466789,4,2,'12.1-YOG4PAS3JM','2015-10-31T15:24:06.000000Z','2015-11-05 23:40:01'),(466790,5,1,'12.0 YNG1TBS2P2 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:40:01'),(466791,5,2,'YNG1TBS2P2','2015-09-24T21:42:39.000000Z','2015-11-05 23:40:01'),(466792,7,1,'12.1-YOG4PAS2H2 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:40:01'),(466793,7,2,'12.1-YOG4PAS2H2','2015-09-24T21:42:39.000000Z','2015-11-05 23:40:01'),(466794,9,1,'12.1-YOG4PAS38J Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:40:01'),(466795,9,2,'','','2015-11-05 23:40:02'),(466796,10,1,'12.1-YOG4PAS1T1 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:40:02'),(466797,10,2,'12.1-YOG4PAS1T1','2015-09-24T21:42:39.000000Z','2015-11-05 23:40:02'),(466798,1,1,'12.1-YOG4PAS3JL Incremental','2015-10-13T02:14:51.000000Z','2015-11-05 23:45:01'),(466799,1,2,'12.1-YOG4PAS3JL','2015-09-24T21:42:39.000000Z','2015-11-05 23:45:01'),(466800,2,1,'12.1-YOG4PAS3JM Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:45:01'),(466801,2,2,'12.1-YOG4PAS3JM','2015-10-31T15:24:06.000000Z','2015-11-05 23:45:01'),(466802,3,1,'XNPH40P Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:45:01'),(466803,3,2,'XNPH40P','2015-09-24T21:42:39.000000Z','2015-11-05 23:45:01'),(466804,4,1,'12.1-YOG4PAS3JM Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:45:01'),(466805,4,2,'12.1-YOG4PAS3JM','2015-10-31T15:24:06.000000Z','2015-11-05 23:45:01'),(466806,5,1,'12.0 YNG1TBS2P2 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:45:01'),(466807,5,2,'YNG1TBS2P2','2015-09-24T21:42:39.000000Z','2015-11-05 23:45:01'),(466808,7,1,'12.1-YOG4PAS2H2 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:45:01'),(466809,7,2,'12.1-YOG4PAS2H2','2015-09-24T21:42:39.000000Z','2015-11-05 23:45:01'),(466810,9,1,'12.1-YOG4PAS38J Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:45:01'),(466811,9,2,'','','2015-11-05 23:45:02'),(466812,10,1,'12.1-YOG4PAS1T1 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:45:02'),(466813,10,2,'12.1-YOG4PAS1T1','2015-09-24T21:42:39.000000Z','2015-11-05 23:45:02'),(466814,1,1,'12.1-YOG4PAS3JL Incremental','2015-10-13T02:14:51.000000Z','2015-11-05 23:50:01'),(466815,1,2,'12.1-YOG4PAS3JL','2015-09-24T21:42:39.000000Z','2015-11-05 23:50:01'),(466816,2,1,'12.1-YOG4PAS3JM Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:50:01'),(466817,2,2,'12.1-YOG4PAS3JM','2015-10-31T15:24:06.000000Z','2015-11-05 23:50:01'),(466818,3,1,'XNPH40P Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:50:01'),(466819,3,2,'XNPH40P','2015-09-24T21:42:39.000000Z','2015-11-05 23:50:01'),(466820,4,1,'12.1-YOG4PAS3JM Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:50:01'),(466821,4,2,'12.1-YOG4PAS3JM','2015-10-31T15:24:06.000000Z','2015-11-05 23:50:01'),(466822,5,1,'12.0 YNG1TBS2P2 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:50:01'),(466823,5,2,'YNG1TBS2P2','2015-09-24T21:42:39.000000Z','2015-11-05 23:50:01'),(466824,7,1,'12.1-YOG4PAS2H2 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:50:01'),(466825,7,2,'12.1-YOG4PAS2H2','2015-09-24T21:42:39.000000Z','2015-11-05 23:50:01'),(466826,9,1,'12.1-YOG4PAS38J Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:50:01'),(466827,9,2,'','','2015-11-05 23:50:02'),(466828,10,1,'12.1-YOG4PAS1T1 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:50:02'),(466829,10,2,'12.1-YOG4PAS1T1','2015-09-24T21:42:39.000000Z','2015-11-05 23:50:02'),(466830,1,1,'12.1-YOG4PAS3JL Incremental','2015-10-13T02:14:51.000000Z','2015-11-05 23:55:01'),(466831,1,2,'12.1-YOG4PAS3JL','2015-09-24T21:42:39.000000Z','2015-11-05 23:55:01'),(466832,2,1,'12.1-YOG4PAS3JM Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:55:01'),(466833,2,2,'12.1-YOG4PAS3JM','2015-10-31T15:24:06.000000Z','2015-11-05 23:55:01'),(466834,3,1,'XNPH40P Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:55:01'),(466835,3,2,'XNPH40P','2015-09-24T21:42:39.000000Z','2015-11-05 23:55:01'),(466836,4,1,'12.1-YOG4PAS3JM Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:55:01'),(466837,4,2,'12.1-YOG4PAS3JM','2015-10-31T15:24:06.000000Z','2015-11-05 23:55:01'),(466838,5,1,'12.0 YNG1TBS2P2 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:55:01'),(466839,5,2,'YNG1TBS2P2','2015-09-24T21:42:39.000000Z','2015-11-05 23:55:01'),(466840,7,1,'12.1-YOG4PAS2H2 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:55:01'),(466841,7,2,'12.1-YOG4PAS2H2','2015-09-24T21:42:39.000000Z','2015-11-05 23:55:01'),(466842,9,1,'12.1-YOG4PAS38J Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:55:01'),(466843,9,2,'','','2015-11-05 23:55:01'),(466844,10,1,'12.1-YOG4PAS1T1 Incremental','2015-10-21T21:12:07.000000Z','2015-11-05 23:55:01'),(466845,10,2,'12.1-YOG4PAS1T1','2015-09-24T21:42:39.000000Z','2015-11-05 23:55:01'),(466846,1,1,'12.1-YOG4PAS3JL Incremental','2015-10-13T02:14:51.000000Z','2015-11-06 00:00:02'),(466847,1,2,'12.1-YOG4PAS3JL','2015-09-24T21:42:39.000000Z','2015-11-06 00:00:02'),(466848,2,1,'12.1-YOG4PAS3JM Incremental','2015-10-21T21:12:07.000000Z','2015-11-06 00:00:02'),(466849,2,2,'12.1-YOG4PAS3JM','2015-10-31T15:24:06.000000Z','2015-11-06 00:00:02'),(466850,3,1,'XNPH40P Incremental','2015-10-21T21:12:07.000000Z','2015-11-06 00:00:02'),(466851,3,2,'XNPH40P','2015-09-24T21:42:39.000000Z','2015-11-06 00:00:02'),(466852,4,1,'12.1-YOG4PAS3JM Incremental','2015-10-21T21:12:07.000000Z','2015-11-06 00:00:02'),(466853,4,2,'12.1-YOG4PAS3JM','2015-10-31T15:24:06.000000Z','2015-11-06 00:00:02'),(466854,5,1,'12.0 YNG1TBS2P2 Incremental','2015-10-21T21:12:07.000000Z','2015-11-06 00:00:02'),(466855,5,2,'YNG1TBS2P2','2015-09-24T21:42:39.000000Z','2015-11-06 00:00:02'),(466856,7,1,'12.1-YOG4PAS2H2 Incremental','2015-10-21T21:12:07.000000Z','2015-11-06 00:00:02'),(466857,7,2,'12.1-YOG4PAS2H2','2015-09-24T21:42:39.000000Z','2015-11-06 00:00:02'),(466858,9,1,'12.1-YOG4PAS38J Incremental','2015-10-21T21:12:07.000000Z','2015-11-06 00:00:02'),(466859,9,2,'','','2015-11-06 00:00:05'),(466860,10,1,'12.1-YOG4PAS1T1 Incremental','2015-10-21T21:12:07.000000Z','2015-11-06 00:00:05'),(466861,10,2,'12.1-YOG4PAS1T1','2015-09-24T21:42:39.000000Z','2015-11-06 00:00:05');
/*!40000 ALTER TABLE `version_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-07 18:50:17
