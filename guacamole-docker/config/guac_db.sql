-- MySQL dump 10.13  Distrib 8.0.15, for Linux (x86_64)
--
-- Host: localhost    Database: guacamole_db
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `guacamole_connection`
--

DROP TABLE IF EXISTS `guacamole_connection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_connection` (
  `connection_id` int(11) NOT NULL AUTO_INCREMENT,
  `connection_name` varchar(128) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `protocol` varchar(32) NOT NULL,
  `proxy_port` int(11) DEFAULT NULL,
  `proxy_hostname` varchar(512) DEFAULT NULL,
  `proxy_encryption_method` enum('NONE','SSL') DEFAULT NULL,
  `max_connections` int(11) DEFAULT NULL,
  `max_connections_per_user` int(11) DEFAULT NULL,
  `connection_weight` int(11) DEFAULT NULL,
  `failover_only` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`connection_id`),
  UNIQUE KEY `connection_name_parent` (`connection_name`,`parent_id`),
  KEY `guacamole_connection_ibfk_1` (`parent_id`),
  CONSTRAINT `guacamole_connection_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection`
--

LOCK TABLES `guacamole_connection` WRITE;
/*!40000 ALTER TABLE `guacamole_connection` DISABLE KEYS */;
INSERT INTO `guacamole_connection` VALUES (2,'student02-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(3,'student03-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(4,'student04-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(5,'student05-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(7,'student07-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(8,'student08-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(9,'student09-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(10,'student10-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(11,'student11-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(12,'student12-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(13,'student13-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(14,'student14-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(15,'student15-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(16,'student16-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(17,'student17-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(18,'student18-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(19,'student19-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(20,'student20-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(21,'student01-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(22,'student06-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(24,'student21-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(26,'student22-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(27,'student23-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(29,'student24-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0),(30,'student25-lab',NULL,'vnc',NULL,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `guacamole_connection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_attribute`
--

DROP TABLE IF EXISTS `guacamole_connection_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_connection_attribute` (
  `connection_id` int(11) NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`connection_id`,`attribute_name`),
  KEY `connection_id` (`connection_id`),
  CONSTRAINT `guacamole_connection_attribute_ibfk_1` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_attribute`
--

LOCK TABLES `guacamole_connection_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_connection_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_group`
--

DROP TABLE IF EXISTS `guacamole_connection_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_connection_group` (
  `connection_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `connection_group_name` varchar(128) NOT NULL,
  `type` enum('ORGANIZATIONAL','BALANCING') NOT NULL DEFAULT 'ORGANIZATIONAL',
  `max_connections` int(11) DEFAULT NULL,
  `max_connections_per_user` int(11) DEFAULT NULL,
  `enable_session_affinity` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`connection_group_id`),
  UNIQUE KEY `connection_group_name_parent` (`connection_group_name`,`parent_id`),
  KEY `guacamole_connection_group_ibfk_1` (`parent_id`),
  CONSTRAINT `guacamole_connection_group_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_group`
--

LOCK TABLES `guacamole_connection_group` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_connection_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_group_attribute`
--

DROP TABLE IF EXISTS `guacamole_connection_group_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_connection_group_attribute` (
  `connection_group_id` int(11) NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`connection_group_id`,`attribute_name`),
  KEY `connection_group_id` (`connection_group_id`),
  CONSTRAINT `guacamole_connection_group_attribute_ibfk_1` FOREIGN KEY (`connection_group_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_group_attribute`
--

LOCK TABLES `guacamole_connection_group_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_group_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_connection_group_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_group_permission`
--

DROP TABLE IF EXISTS `guacamole_connection_group_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_connection_group_permission` (
  `entity_id` int(11) NOT NULL,
  `connection_group_id` int(11) NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`connection_group_id`,`permission`),
  KEY `guacamole_connection_group_permission_ibfk_1` (`connection_group_id`),
  CONSTRAINT `guacamole_connection_group_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_connection_group_permission_ibfk_1` FOREIGN KEY (`connection_group_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_group_permission`
--

LOCK TABLES `guacamole_connection_group_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_group_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_connection_group_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_history`
--

DROP TABLE IF EXISTS `guacamole_connection_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_connection_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(128) NOT NULL,
  `remote_host` varchar(256) DEFAULT NULL,
  `connection_id` int(11) DEFAULT NULL,
  `connection_name` varchar(128) NOT NULL,
  `sharing_profile_id` int(11) DEFAULT NULL,
  `sharing_profile_name` varchar(128) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `user_id` (`user_id`),
  KEY `connection_id` (`connection_id`),
  KEY `sharing_profile_id` (`sharing_profile_id`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`),
  KEY `connection_start_date` (`connection_id`,`start_date`),
  CONSTRAINT `guacamole_connection_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `guacamole_connection_history_ibfk_2` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE SET NULL,
  CONSTRAINT `guacamole_connection_history_ibfk_3` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=351 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_history`
--

LOCK TABLES `guacamole_connection_history` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_history` DISABLE KEYS */;
INSERT INTO `guacamole_connection_history` VALUES (9,14,'student01','73.70.201.210',NULL,'lab',NULL,NULL,'2019-02-19 08:12:19','2019-02-19 08:13:18'),(10,15,'student02','73.70.201.210',2,'student02-lab',NULL,NULL,'2019-02-19 08:14:36','2019-02-19 08:15:11'),(11,16,'student03','73.70.201.210',3,'student03-lab',NULL,NULL,'2019-02-19 08:16:49','2019-02-19 08:17:09'),(12,14,'student01','73.70.201.210',NULL,'student01-lab',NULL,NULL,'2019-02-19 08:17:21','2019-02-19 08:17:33'),(13,15,'student02','73.70.201.210',2,'student02-lab',NULL,NULL,'2019-02-19 08:17:43','2019-02-19 08:17:53'),(14,17,'student04','73.70.201.210',4,'student04-lab',NULL,NULL,'2019-02-19 08:18:40','2019-02-19 08:18:53'),(15,18,'student05','73.70.201.210',5,'student05-lab',NULL,NULL,'2019-02-19 08:20:16','2019-02-19 08:20:29'),(16,19,'student06','73.70.201.210',NULL,'student06-lab',NULL,NULL,'2019-02-19 08:21:32','2019-02-19 08:21:48'),(17,20,'student07','73.70.201.210',7,'student07-lab',NULL,NULL,'2019-02-19 08:22:46','2019-02-19 08:22:58'),(18,21,'student08','73.70.201.210',8,'student08-lab',NULL,NULL,'2019-02-19 08:23:45','2019-02-19 08:24:08'),(19,22,'student09','73.70.201.210',9,'student09-lab',NULL,NULL,'2019-02-19 08:25:03','2019-02-19 08:25:16'),(20,23,'student10','73.70.201.210',10,'student10-lab',NULL,NULL,'2019-02-19 08:26:04','2019-02-19 08:26:17'),(21,24,'student11','73.70.201.210',11,'student11-lab',NULL,NULL,'2019-02-19 08:27:04','2019-02-19 08:27:17'),(22,25,'student12','73.70.201.210',12,'student12-lab',NULL,NULL,'2019-02-19 08:27:58','2019-02-19 08:28:18'),(23,26,'student13','73.70.201.210',13,'student13-lab',NULL,NULL,'2019-02-19 08:29:09','2019-02-19 08:29:25'),(24,27,'student14','73.70.201.210',14,'student14-lab',NULL,NULL,'2019-02-19 08:30:07','2019-02-19 08:30:45'),(25,28,'student15','73.70.201.210',15,'student15-lab',NULL,NULL,'2019-02-19 08:31:36','2019-02-19 08:31:54'),(26,29,'student16','73.70.201.210',16,'student16-lab',NULL,NULL,'2019-02-19 08:33:05','2019-02-19 08:33:19'),(27,30,'student17','73.70.201.210',17,'student17-lab',NULL,NULL,'2019-02-19 08:34:10','2019-02-19 08:34:26'),(28,31,'student18','73.70.201.210',18,'student18-lab',NULL,NULL,'2019-02-19 08:35:11','2019-02-19 08:35:23'),(29,32,'student19','73.70.201.210',19,'student19-lab',NULL,NULL,'2019-02-19 08:36:16','2019-02-19 08:36:30'),(30,33,'student20','73.70.201.210',20,'student20-lab',NULL,NULL,'2019-02-19 08:37:20','2019-02-19 08:37:33'),(31,14,'student01','104.36.222.19',NULL,'student01-lab',NULL,NULL,'2019-02-19 13:01:26','2019-02-19 13:02:31'),(32,19,'student06','171.159.64.10',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:36:10','2019-02-19 17:36:10'),(33,14,'student01','171.159.64.10',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:37:13','2019-02-19 17:37:13'),(34,19,'student06','171.159.64.10',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:37:14','2019-02-19 17:37:14'),(35,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:37:21','2019-02-19 17:37:21'),(36,14,'student01','171.159.64.10',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:37:26','2019-02-19 17:37:26'),(37,14,'student01','171.159.64.10',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:37:29','2019-02-19 17:37:29'),(38,19,'student06','171.159.64.10',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:37:29','2019-02-19 17:37:29'),(39,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:37:30','2019-02-19 17:37:30'),(40,14,'student01','171.159.64.10',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:37:30','2019-02-19 17:37:30'),(41,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:37:31','2019-02-19 17:37:32'),(42,14,'student01','171.159.64.10',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:37:33','2019-02-19 17:37:33'),(43,19,'student06','171.159.64.10',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:37:44','2019-02-19 17:37:45'),(44,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:37:45','2019-02-19 17:37:45'),(45,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:37:47','2019-02-19 17:37:47'),(46,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:37:49','2019-02-19 17:37:49'),(47,19,'student06','171.159.64.10',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:37:56','2019-02-19 17:37:56'),(48,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:37:56','2019-02-19 17:37:56'),(49,32,'student19','171.161.189.133',19,'student19-lab',NULL,NULL,'2019-02-19 17:36:49','2019-02-19 17:37:56'),(50,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:38:00','2019-02-19 17:38:00'),(51,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:38:00','2019-02-19 17:38:01'),(52,19,'student06','171.159.64.10',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:38:01','2019-02-19 17:38:01'),(53,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:38:02','2019-02-19 17:38:03'),(54,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:38:05','2019-02-19 17:38:05'),(55,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:38:12','2019-02-19 17:38:13'),(56,19,'student06','171.159.64.10',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:38:13','2019-02-19 17:38:13'),(57,14,'student01','171.161.189.133',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:38:18','2019-02-19 17:38:18'),(58,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:38:28','2019-02-19 17:38:28'),(59,14,'student01','171.161.189.133',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:38:33','2019-02-19 17:38:34'),(60,14,'student01','171.161.189.133',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:38:36','2019-02-19 17:38:36'),(61,14,'student01','171.161.189.133',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:38:37','2019-02-19 17:38:37'),(62,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:38:43','2019-02-19 17:38:43'),(63,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:38:44','2019-02-19 17:38:45'),(64,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:38:45','2019-02-19 17:38:45'),(65,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:38:46','2019-02-19 17:38:46'),(66,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:39:01','2019-02-19 17:39:01'),(67,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:39:16','2019-02-19 17:39:17'),(68,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:39:32','2019-02-19 17:39:32'),(69,14,'student01','171.161.189.133',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:39:42','2019-02-19 17:39:42'),(70,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:39:47','2019-02-19 17:39:47'),(71,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:39:52','2019-02-19 17:39:52'),(72,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:39:55','2019-02-19 17:39:55'),(73,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:39:55','2019-02-19 17:39:55'),(74,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:39:56','2019-02-19 17:39:56'),(75,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:39:57','2019-02-19 17:39:57'),(76,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:39:57','2019-02-19 17:39:57'),(77,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:39:58','2019-02-19 17:39:58'),(78,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:40:02','2019-02-19 17:40:02'),(79,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:40:10','2019-02-19 17:40:11'),(80,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:40:14','2019-02-19 17:40:14'),(81,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:40:15','2019-02-19 17:40:15'),(82,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:40:26','2019-02-19 17:40:26'),(83,14,'student01','171.161.189.133',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:40:40','2019-02-19 17:40:40'),(84,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:40:42','2019-02-19 17:40:42'),(85,14,'student01','171.161.189.133',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:40:55','2019-02-19 17:40:55'),(86,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:40:57','2019-02-19 17:40:57'),(87,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:41:12','2019-02-19 17:41:13'),(88,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:41:21','2019-02-19 17:41:21'),(89,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:41:23','2019-02-19 17:41:23'),(90,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:41:28','2019-02-19 17:41:28'),(91,14,'student01','171.161.189.133',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:41:37','2019-02-19 17:41:37'),(92,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:41:43','2019-02-19 17:41:44'),(93,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:41:56','2019-02-19 17:41:56'),(94,19,'student06','171.159.64.10',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:43:23','2019-02-19 17:43:23'),(95,19,'student06','171.159.64.10',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:43:38','2019-02-19 17:43:38'),(96,19,'student06','171.159.64.10',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:43:42','2019-02-19 17:43:42'),(97,14,'student01','172.56.7.242',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:41:59','2019-02-19 17:45:13'),(98,28,'student15','171.159.64.10',15,'student15-lab',NULL,NULL,'2019-02-19 17:37:33','2019-02-19 17:53:36'),(99,33,'student20','171.161.189.133',20,'student20-lab',NULL,NULL,'2019-02-19 17:37:32','2019-02-19 17:53:58'),(100,14,'student01','171.161.189.133',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:53:45','2019-02-19 17:53:59'),(101,30,'student17','171.159.64.10',17,'student17-lab',NULL,NULL,'2019-02-19 17:37:31','2019-02-19 17:54:01'),(102,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 17:42:12','2019-02-19 17:54:07'),(103,14,'student01','171.161.189.133',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:54:02','2019-02-19 17:54:27'),(104,19,'student06','172.56.7.102',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:55:17','2019-02-19 17:55:17'),(105,19,'student06','172.56.7.102',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:55:19','2019-02-19 17:55:19'),(106,26,'student13','171.159.64.10',13,'student13-lab',NULL,NULL,'2019-02-19 17:37:32','2019-02-19 17:55:29'),(107,23,'student10','171.159.64.10',10,'student10-lab',NULL,NULL,'2019-02-19 17:36:27','2019-02-19 17:56:12'),(108,14,'student01','171.161.189.133',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:54:33','2019-02-19 17:57:38'),(109,19,'student06','172.56.7.242',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:59:17','2019-02-19 17:59:18'),(110,19,'student06','172.56.7.242',NULL,'student06-lab',NULL,NULL,'2019-02-19 17:59:21','2019-02-19 17:59:21'),(111,1,'guacadmin','73.70.201.210',NULL,'student01-lab',NULL,NULL,'2019-02-19 17:56:22','2019-02-19 18:00:37'),(112,14,'student01','73.70.201.210',21,'student01-lab-new',NULL,NULL,'2019-02-19 18:01:36','2019-02-19 18:02:00'),(113,19,'student06','73.70.201.210',22,'student05-lab-new',NULL,NULL,'2019-02-19 18:04:48','2019-02-19 18:10:36'),(115,19,'student06','172.56.7.242',22,'student06-lab-new',NULL,NULL,'2019-02-19 18:10:55','2019-02-19 18:11:21'),(116,32,'student19','171.161.189.133',19,'student19-lab',NULL,NULL,'2019-02-19 17:37:57','2019-02-19 18:14:41'),(118,34,'student21','73.70.201.210',24,'student21-lab',NULL,NULL,'2019-02-19 18:19:40','2019-02-19 18:19:45'),(119,25,'student12','171.159.64.10',12,'student12-lab',NULL,NULL,'2019-02-19 17:36:34','2019-02-19 18:41:48'),(120,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:44:42','2019-02-19 18:44:42'),(121,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:45:02','2019-02-19 18:45:03'),(122,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:45:08','2019-02-19 18:45:08'),(123,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:45:18','2019-02-19 18:45:18'),(124,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:45:19','2019-02-19 18:45:19'),(125,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:45:20','2019-02-19 18:45:20'),(126,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:45:20','2019-02-19 18:45:20'),(127,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:45:20','2019-02-19 18:45:20'),(128,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:45:35','2019-02-19 18:45:36'),(129,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:45:51','2019-02-19 18:45:51'),(130,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:45:54','2019-02-19 18:45:54'),(131,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:45:57','2019-02-19 18:45:58'),(132,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:00','2019-02-19 18:46:00'),(133,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:02','2019-02-19 18:46:02'),(134,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:02','2019-02-19 18:46:02'),(135,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:08','2019-02-19 18:46:08'),(136,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:09','2019-02-19 18:46:09'),(137,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:10','2019-02-19 18:46:10'),(138,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:10','2019-02-19 18:46:11'),(139,30,'student17','171.159.64.10',17,'student17-lab',NULL,NULL,'2019-02-19 18:22:29','2019-02-19 18:46:18'),(140,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:30','2019-02-19 18:46:30'),(141,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:32','2019-02-19 18:46:32'),(142,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:32','2019-02-19 18:46:32'),(143,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:33','2019-02-19 18:46:33'),(144,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:34','2019-02-19 18:46:34'),(145,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:49','2019-02-19 18:46:49'),(146,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:55','2019-02-19 18:46:55'),(147,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:57','2019-02-19 18:46:57'),(148,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:58','2019-02-19 18:46:58'),(149,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:58','2019-02-19 18:46:59'),(150,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:46:59','2019-02-19 18:46:59'),(151,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:47:26','2019-02-19 18:47:26'),(152,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:47:59','2019-02-19 18:47:59'),(153,25,'student12','171.159.64.10',12,'student12-lab',NULL,NULL,'2019-02-19 18:41:57','2019-02-19 18:58:00'),(154,23,'student10','171.159.64.10',10,'student10-lab',NULL,NULL,'2019-02-19 17:56:19','2019-02-19 18:58:22'),(155,25,'student12','171.159.64.10',12,'student12-lab',NULL,NULL,'2019-02-19 19:00:27','2019-02-19 19:00:30'),(156,1,'guacadmin','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-19 18:31:31','2019-02-19 19:01:30'),(157,14,'student01','171.161.189.133',21,'student01-lab-new',NULL,NULL,'2019-02-19 19:10:05','2019-02-19 19:17:22'),(158,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:17:56','2019-02-19 19:17:58'),(159,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:18:06','2019-02-19 19:18:07'),(160,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:18:09','2019-02-19 19:18:09'),(161,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:18:11','2019-02-19 19:18:11'),(162,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:18:26','2019-02-19 19:18:26'),(163,32,'student19','171.161.189.133',19,'student19-lab',NULL,NULL,'2019-02-19 18:52:07','2019-02-19 19:18:29'),(164,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:18:59','2019-02-19 19:18:59'),(165,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:19:15','2019-02-19 19:19:16'),(166,35,'student22','73.70.201.210',26,'student22',NULL,NULL,'2019-02-19 19:11:23','2019-02-19 19:19:23'),(167,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:19:31','2019-02-19 19:19:31'),(168,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:19:46','2019-02-19 19:19:46'),(169,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:20:01','2019-02-19 19:20:01'),(170,32,'student19','171.161.189.133',19,'student19-lab',NULL,NULL,'2019-02-19 19:18:29','2019-02-19 19:20:09'),(171,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:20:16','2019-02-19 19:20:17'),(172,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:20:32','2019-02-19 19:20:32'),(173,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:20:47','2019-02-19 19:20:47'),(174,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:21:02','2019-02-19 19:21:02'),(175,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:21:17','2019-02-19 19:21:18'),(176,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:21:33','2019-02-19 19:21:33'),(177,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:21:48','2019-02-19 19:21:48'),(178,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:22:03','2019-02-19 19:22:03'),(179,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:22:18','2019-02-19 19:22:18'),(180,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:22:34','2019-02-19 19:22:34'),(181,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:22:49','2019-02-19 19:22:49'),(182,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:23:04','2019-02-19 19:23:04'),(183,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:23:19','2019-02-19 19:23:19'),(184,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:23:35','2019-02-19 19:23:35'),(185,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:23:50','2019-02-19 19:23:50'),(186,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:24:05','2019-02-19 19:24:05'),(187,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:24:20','2019-02-19 19:24:20'),(188,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:24:35','2019-02-19 19:24:36'),(189,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:24:51','2019-02-19 19:24:51'),(190,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:25:06','2019-02-19 19:25:06'),(191,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:25:21','2019-02-19 19:25:21'),(192,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:25:36','2019-02-19 19:25:37'),(193,34,'student21','171.161.189.133',24,'student21-lab',NULL,NULL,'2019-02-19 18:26:09','2019-02-19 19:25:41'),(194,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:25:52','2019-02-19 19:25:52'),(195,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:26:07','2019-02-19 19:26:07'),(196,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:26:22','2019-02-19 19:26:22'),(197,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:26:37','2019-02-19 19:26:38'),(198,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:26:54','2019-02-19 19:26:54'),(199,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:27:04','2019-02-19 19:27:20'),(200,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:27:38','2019-02-19 19:27:38'),(201,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:27:56','2019-02-19 19:27:56'),(202,26,'student13','171.159.64.10',13,'student13-lab',NULL,NULL,'2019-02-19 19:12:34','2019-02-19 19:28:07'),(203,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:28:11','2019-02-19 19:28:12'),(204,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:28:27','2019-02-19 19:28:27'),(205,14,'student01','171.161.189.133',21,'student01-lab-new',NULL,NULL,'2019-02-19 19:17:35','2019-02-19 19:39:58'),(206,36,'student23','73.70.201.210',27,'student23-lab',NULL,NULL,'2019-02-19 19:21:53','2019-02-19 19:41:57'),(207,30,'student17','171.159.64.10',17,'student17-lab',NULL,NULL,'2019-02-19 18:54:03','2019-02-19 19:52:23'),(208,24,'student11','171.161.160.10',11,'student11-lab',NULL,NULL,'2019-02-19 17:36:12','2019-02-19 19:52:41'),(209,23,'student10','171.161.160.10',10,'student10-lab',NULL,NULL,'2019-02-19 18:59:10','2019-02-19 19:52:44'),(210,30,'student17','171.159.64.10',17,'student17-lab',NULL,NULL,'2019-02-19 19:52:30','2019-02-19 19:53:12'),(211,30,'student17','171.159.64.10',17,'student17-lab',NULL,NULL,'2019-02-19 19:53:24','2019-02-19 19:53:53'),(212,23,'student10','171.161.160.10',10,'student10-lab',NULL,NULL,'2019-02-19 19:52:50','2019-02-19 19:54:04'),(213,30,'student17','171.159.64.10',17,'student17-lab',NULL,NULL,'2019-02-19 19:54:13','2019-02-19 19:54:49'),(214,14,'student01','171.161.189.133',21,'student01-lab-new',NULL,NULL,'2019-02-19 19:41:00','2019-02-19 20:13:06'),(215,14,'student01','171.161.189.133',21,'student01-lab-new',NULL,NULL,'2019-02-19 20:13:24','2019-02-19 20:14:00'),(216,14,'student01','171.161.189.133',21,'student01-lab-new',NULL,NULL,'2019-02-19 20:14:01','2019-02-19 20:30:32'),(217,32,'student19','171.161.189.133',19,'student19-lab',NULL,NULL,'2019-02-19 19:20:21','2019-02-19 20:50:58'),(218,14,'student01','171.161.189.133',21,'student01-lab-new',NULL,NULL,'2019-02-19 20:31:03','2019-02-19 21:49:54'),(219,33,'student20','171.161.189.133',20,'student20-lab',NULL,NULL,'2019-02-19 19:09:11','2019-02-19 21:56:01'),(220,23,'student10','171.161.160.10',10,'student10-lab',NULL,NULL,'2019-02-19 19:54:15','2019-02-19 22:01:58'),(221,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 19:30:13','2019-02-19 22:06:31'),(222,17,'student04','171.159.64.10',4,'student04-lab',NULL,NULL,'2019-02-19 22:07:23','2019-02-19 22:18:50'),(223,32,'student19','171.161.189.133',19,'student19-lab',NULL,NULL,'2019-02-19 20:51:49','2019-02-19 22:18:55'),(224,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 22:19:11','2019-02-19 22:19:22'),(225,21,'student08','171.159.64.10',8,'student08-lab',NULL,NULL,'2019-02-19 17:37:31','2019-02-19 22:28:29'),(226,19,'student06','171.161.160.10',22,'student06-lab-new',NULL,NULL,'2019-02-19 19:13:17','2019-02-19 22:31:01'),(227,30,'student17','171.159.64.10',17,'student17-lab',NULL,NULL,'2019-02-19 19:54:55','2019-02-19 22:31:18'),(228,22,'student09','171.159.64.10',9,'student09-lab',NULL,NULL,'2019-02-19 17:37:33','2019-02-19 22:41:13'),(229,32,'student19','171.161.189.133',19,'student19-lab',NULL,NULL,'2019-02-19 22:19:09','2019-02-19 22:42:24'),(230,25,'student12','171.159.64.10',12,'student12-lab',NULL,NULL,'2019-02-19 19:00:35','2019-02-19 22:45:46'),(231,28,'student15','171.159.192.10',15,'student15-lab',NULL,NULL,'2019-02-19 18:44:13','2019-02-19 22:46:59'),(232,26,'student13','171.159.64.10',13,'student13-lab',NULL,NULL,'2019-02-19 19:28:23','2019-02-19 22:52:20'),(233,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 18:49:16','2019-02-19 22:57:54'),(234,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 22:58:03','2019-02-19 23:00:11'),(235,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 23:00:15','2019-02-19 23:00:15'),(236,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 23:00:16','2019-02-19 23:00:17'),(237,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 23:00:18','2019-02-19 23:00:18'),(238,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 23:00:24','2019-02-19 23:00:24'),(239,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 23:00:25','2019-02-19 23:00:26'),(240,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 23:00:27','2019-02-19 23:00:27'),(241,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 23:00:28','2019-02-19 23:00:28'),(242,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 23:00:34','2019-02-19 23:00:34'),(243,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 23:00:36','2019-02-19 23:00:36'),(244,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 23:00:37','2019-02-19 23:00:37'),(245,16,'student03','171.161.189.133',3,'student03-lab',NULL,NULL,'2019-02-19 23:01:44','2019-02-19 23:08:05'),(246,35,'student22','171.161.189.133',26,'student22',NULL,NULL,'2019-02-19 23:08:16','2019-02-19 23:17:40'),(247,23,'student10','171.159.64.10',10,'student10-lab',NULL,NULL,'2019-02-19 22:02:11','2019-02-19 23:18:58'),(248,18,'student05','171.159.64.10',5,'student05-lab',NULL,NULL,'2019-02-19 17:37:55','2019-02-19 23:22:51'),(249,15,'student02','171.159.64.10',2,'student02-lab',NULL,NULL,'2019-02-19 17:37:59','2019-02-19 23:24:43'),(250,1,'guacadmin','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-19 22:16:31','2019-02-19 23:28:38'),(251,14,'student01','171.161.189.133',21,'student01-lab-new',NULL,NULL,'2019-02-19 21:58:29','2019-02-19 23:33:13'),(252,31,'student18','171.159.64.10',18,'student18-lab',NULL,NULL,'2019-02-19 17:37:34','2019-02-19 23:58:20'),(253,31,'student18','171.159.64.10',18,'student18-lab',NULL,NULL,'2019-02-19 23:58:28','2019-02-19 23:58:39'),(254,1,'guacadmin','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-19 23:56:38','2019-02-20 00:00:30'),(255,34,'student21','171.161.189.133',24,'student21-lab',NULL,NULL,'2019-02-19 19:26:01','2019-02-20 00:13:49'),(256,NULL,'test-user','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-20 00:00:42','2019-02-20 00:38:19'),(257,26,'student13','171.161.160.10',13,'student13-lab',NULL,NULL,'2019-02-20 00:23:54','2019-02-20 01:13:15'),(258,17,'student04','171.161.160.10',4,'student04-lab',NULL,NULL,'2019-02-19 22:19:26','2019-02-20 02:06:34'),(259,19,'student06','171.161.160.10',22,'student06-lab-new',NULL,NULL,'2019-02-19 22:32:54','2019-02-20 02:41:22'),(260,25,'student12','72.176.250.86',12,'student12-lab',NULL,NULL,'2019-02-20 02:18:49','2019-02-20 02:48:18'),(261,1,'guacadmin','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-20 01:08:41','2019-02-20 05:20:06'),(262,18,'student05','171.161.160.10',5,'student05-lab',NULL,NULL,'2019-02-20 04:56:05','2019-02-20 05:24:14'),(263,NULL,'test-user','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-20 06:28:16','2019-02-20 06:28:31'),(264,NULL,'test-user','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-20 06:29:27','2019-02-20 06:29:27'),(265,NULL,'test-user','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-20 06:29:43','2019-02-20 06:29:43'),(266,NULL,'test-user','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-20 06:29:58','2019-02-20 06:29:58'),(267,35,'student22','47.186.0.157',26,'student22',NULL,NULL,'2019-02-20 05:23:45','2019-02-20 06:43:26'),(268,16,'student03','47.186.0.157',3,'student03-lab',NULL,NULL,'2019-02-20 06:08:08','2019-02-20 06:43:38'),(269,35,'student22','47.186.0.157',26,'student22',NULL,NULL,'2019-02-20 06:43:45','2019-02-20 06:43:52'),(270,23,'student10','171.161.160.10',10,'student10-lab',NULL,NULL,'2019-02-20 14:05:26','2019-02-20 14:14:48'),(271,1,'guacadmin','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-20 14:20:21','2019-02-20 14:20:21'),(272,1,'guacadmin','73.70.201.210',21,'student01-lab-new',NULL,NULL,'2019-02-20 14:26:58','2019-02-20 14:27:21'),(273,1,'guacadmin','73.70.201.210',2,'student02-lab',NULL,NULL,'2019-02-20 14:27:29','2019-02-20 14:27:34'),(274,1,'guacadmin','73.70.201.210',3,'student03-lab',NULL,NULL,'2019-02-20 14:27:40','2019-02-20 14:27:54'),(275,1,'guacadmin','73.70.201.210',4,'student04-lab',NULL,NULL,'2019-02-20 14:27:58','2019-02-20 14:28:10'),(276,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 14:36:39','2019-02-20 14:40:30'),(277,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 14:40:36','2019-02-20 14:41:06'),(278,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 14:41:19','2019-02-20 14:42:55'),(279,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 14:42:56','2019-02-20 14:43:04'),(280,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 14:43:18','2019-02-20 14:45:20'),(281,35,'student22','171.161.189.133',26,'student22',NULL,NULL,'2019-02-20 14:37:58','2019-02-20 14:46:11'),(282,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 14:45:21','2019-02-20 14:47:05'),(283,28,'student15','171.159.192.10',15,'student15-lab',NULL,NULL,'2019-02-20 14:46:02','2019-02-20 15:15:50'),(284,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 14:47:49','2019-02-20 16:50:57'),(285,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 16:51:02','2019-02-20 16:51:22'),(286,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 16:51:28','2019-02-20 16:52:27'),(287,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 16:52:31','2019-02-20 16:52:53'),(288,28,'student15','171.159.192.10',15,'student15-lab',NULL,NULL,'2019-02-20 15:16:49','2019-02-20 16:56:25'),(289,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 16:52:54','2019-02-20 16:56:50'),(290,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 16:56:51','2019-02-20 16:57:04'),(291,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 16:57:08','2019-02-20 16:57:08'),(292,33,'student20','171.161.189.133',20,'student20-lab',NULL,NULL,'2019-02-20 16:59:23','2019-02-20 17:04:53'),(293,1,'guacadmin','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-20 17:15:34','2019-02-20 17:15:34'),(294,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 16:57:14','2019-02-20 17:22:44'),(295,1,'guacadmin','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-20 17:16:19','2019-02-20 17:24:59'),(296,1,'guacadmin','73.70.201.210',NULL,'test-vm',NULL,NULL,'2019-02-20 17:25:14','2019-02-20 17:25:14'),(297,36,'student23','171.161.160.10',27,'student23-lab',NULL,NULL,'2019-02-20 17:23:00','2019-02-20 17:46:04'),(298,25,'student12','171.161.160.10',12,'student12-lab',NULL,NULL,'2019-02-20 17:46:14','2019-02-20 17:47:14'),(299,1,'guacadmin','73.70.201.210',NULL,'security-group-test-vm',NULL,NULL,'2019-02-20 17:49:51','2019-02-20 17:54:25'),(300,23,'student10','171.161.160.10',10,'student10-lab',NULL,NULL,'2019-02-20 14:14:50','2019-02-20 17:57:57'),(301,22,'student09','171.159.194.11',9,'student09-lab',NULL,NULL,'2019-02-20 14:26:30','2019-02-20 17:59:04'),(302,28,'student15','171.159.192.10',15,'student15-lab',NULL,NULL,'2019-02-20 16:56:41','2019-02-20 18:03:31'),(303,32,'student19','171.161.189.133',19,'student19-lab',NULL,NULL,'2019-02-20 14:34:21','2019-02-20 18:20:46'),(304,14,'student01','171.161.189.133',21,'student01-lab-new',NULL,NULL,'2019-02-20 17:05:20','2019-02-20 18:27:12'),(305,33,'student20','171.161.189.133',20,'student20-lab',NULL,NULL,'2019-02-20 17:13:34','2019-02-20 18:38:02'),(306,23,'student10','171.161.160.10',10,'student10-lab',NULL,NULL,'2019-02-20 17:58:00','2019-02-20 18:58:12'),(307,1,'guacadmin','73.70.201.210',NULL,'security-group-test-vm',NULL,NULL,'2019-02-20 17:55:03','2019-02-20 19:34:49'),(308,1,'guacadmin','73.70.201.210',NULL,'security-group-test-vm',NULL,NULL,'2019-02-20 19:35:06','2019-02-20 19:41:54'),(309,1,'guacadmin','73.70.201.210',NULL,'security-group-test-vm',NULL,NULL,'2019-02-20 19:42:09','2019-02-20 19:42:10'),(310,1,'guacadmin','73.70.201.210',24,'student21-lab',NULL,NULL,'2019-02-20 14:25:09','2019-02-20 19:54:24'),(311,1,'guacadmin','73.70.201.210',26,'student22',NULL,NULL,'2019-02-20 14:24:25','2019-02-20 19:54:25'),(312,1,'guacadmin','73.70.201.210',27,'student23-lab',NULL,NULL,'2019-02-20 14:24:34','2019-02-20 19:54:32'),(313,1,'guacadmin','73.70.201.210',NULL,'security-group-test-vm',NULL,NULL,'2019-02-20 19:53:21','2019-02-20 19:54:35'),(314,1,'guacadmin','73.70.201.210',NULL,'security-group-test-vm',NULL,NULL,'2019-02-20 19:55:44','2019-02-20 19:55:52'),(315,33,'student20','171.161.189.133',20,'student20-lab',NULL,NULL,'2019-02-20 19:30:04','2019-02-20 19:57:11'),(316,1,'guacadmin','73.70.201.210',NULL,'security-group-test-vm',NULL,NULL,'2019-02-20 19:59:39','2019-02-20 20:02:39'),(317,14,'student01','108.119.96.29',21,'student01-lab-new',NULL,NULL,'2019-02-20 20:22:00','2019-02-20 20:27:38'),(318,33,'student20','171.161.189.133',20,'student20-lab',NULL,NULL,'2019-02-20 20:02:19','2019-02-20 20:29:45'),(319,36,'student23','171.161.160.10',27,'student23-lab',NULL,NULL,'2019-02-20 17:47:32','2019-02-20 20:30:10'),(320,28,'student15','171.159.64.10',15,'student15-lab',NULL,NULL,'2019-02-20 20:18:58','2019-02-20 20:49:03'),(321,32,'student19','171.161.189.133',19,'student19-lab',NULL,NULL,'2019-02-20 19:08:06','2019-02-20 21:15:43'),(322,14,'student01','108.119.96.29',21,'student01-lab-new',NULL,NULL,'2019-02-20 20:27:41','2019-02-20 21:30:14'),(323,14,'student01','108.119.96.29',21,'student01-lab-new',NULL,NULL,'2019-02-20 21:38:11','2019-02-20 21:48:14'),(324,14,'student01','108.119.96.29',21,'student01-lab-new',NULL,NULL,'2019-02-20 21:58:00','2019-02-20 21:58:16'),(325,30,'student17','171.159.64.10',17,'student17-lab',NULL,NULL,'2019-02-20 14:39:30','2019-02-20 22:07:34'),(326,14,'student01','108.119.96.29',21,'student01-lab-new',NULL,NULL,'2019-02-20 22:08:01','2019-02-20 22:08:17'),(327,14,'student01','108.119.96.29',21,'student01-lab-new',NULL,NULL,'2019-02-20 22:19:00','2019-02-20 22:19:17'),(328,23,'student10','171.161.160.10',10,'student10-lab',NULL,NULL,'2019-02-20 19:07:21','2019-02-20 22:21:10'),(329,31,'student18','171.161.160.10',18,'student18-lab',NULL,NULL,'2019-02-20 14:47:25','2019-02-20 22:28:04'),(330,14,'student01','108.119.96.29',21,'student01-lab-new',NULL,NULL,'2019-02-20 22:30:01','2019-02-20 22:30:17'),(331,20,'student07','171.159.64.10',7,'student07-lab',NULL,NULL,'2019-02-19 17:36:33','2019-02-20 22:31:28'),(332,21,'student08','171.161.160.10',8,'student08-lab',NULL,NULL,'2019-02-20 14:09:46','2019-02-20 22:33:16'),(333,36,'student23','171.161.160.10',27,'student23-lab',NULL,NULL,'2019-02-20 20:30:11','2019-02-20 22:34:04'),(334,32,'student19','171.161.189.133',19,'student19-lab',NULL,NULL,'2019-02-20 21:16:06','2019-02-20 22:34:13'),(335,28,'student15','171.159.64.10',15,'student15-lab',NULL,NULL,'2019-02-20 21:01:41','2019-02-20 22:34:24'),(336,22,'student09','171.161.160.10',9,'student09-lab',NULL,NULL,'2019-02-20 18:48:03','2019-02-20 22:37:51'),(337,35,'student22','171.161.189.133',26,'student22',NULL,NULL,'2019-02-20 14:46:16','2019-02-20 22:39:59'),(338,15,'student02','171.159.64.10',2,'student02-lab',NULL,NULL,'2019-02-20 16:56:35','2019-02-20 22:43:45'),(339,33,'student20','171.161.189.133',20,'student20-lab',NULL,NULL,'2019-02-20 20:42:21','2019-02-20 22:48:13'),(340,26,'student13','171.161.160.10',13,'student13-lab',NULL,NULL,'2019-02-20 14:31:57','2019-02-20 23:03:10'),(341,14,'student01','108.119.96.29',21,'student01-lab-new',NULL,NULL,'2019-02-20 22:33:16','2019-02-20 23:06:22'),(342,18,'student05','171.159.64.10',5,'student05-lab',NULL,NULL,'2019-02-20 17:05:15','2019-02-20 23:09:56'),(343,34,'student21','171.161.189.133',24,'student21-lab',NULL,NULL,'2019-02-20 17:02:30','2019-02-20 23:43:21'),(344,1,'guacadmin','73.70.201.210',NULL,'re-baked-lab-vm-test',NULL,NULL,'2019-02-20 23:56:39','2019-02-20 23:56:50'),(345,27,'student14','171.161.160.10',14,'student14-lab',NULL,NULL,'2019-02-19 17:37:31','2019-02-21 01:34:03'),(346,26,'student13','171.161.160.10',13,'student13-lab',NULL,NULL,'2019-02-21 00:34:51','2019-02-21 01:39:22'),(347,19,'student06','171.161.160.10',22,'student06-lab-new',NULL,NULL,'2019-02-20 15:02:55','2019-02-21 09:59:12'),(348,24,'student11','171.161.160.10',11,'student11-lab',NULL,NULL,'2019-02-19 19:52:42','2019-02-21 09:59:13'),(349,29,'student16','171.159.64.10',16,'student16-lab',NULL,NULL,'2019-02-19 17:37:32','2019-02-21 09:59:13'),(350,1,'guacadmin','73.70.201.210',21,'student01-lab-new',NULL,NULL,'2019-02-27 21:27:54','2019-02-27 21:32:08');
/*!40000 ALTER TABLE `guacamole_connection_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_parameter`
--

DROP TABLE IF EXISTS `guacamole_connection_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_connection_parameter` (
  `connection_id` int(11) NOT NULL,
  `parameter_name` varchar(128) NOT NULL,
  `parameter_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`connection_id`,`parameter_name`),
  CONSTRAINT `guacamole_connection_parameter_ibfk_1` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_parameter`
--

LOCK TABLES `guacamole_connection_parameter` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_parameter` DISABLE KEYS */;
INSERT INTO `guacamole_connection_parameter` VALUES (2,'hostname','ec2-3-16-67-239.us-east-2.compute.amazonaws.com'),(2,'password','ubuntu'),(2,'port','5900'),(3,'hostname','ec2-3-16-82-153.us-east-2.compute.amazonaws.com'),(3,'password','ubuntu'),(3,'port','5900'),(4,'hostname','ec2-3-16-218-246.us-east-2.compute.amazonaws.com'),(4,'password','ubuntu'),(4,'port','5900'),(5,'hostname','ec2-3-17-164-89.us-east-2.compute.amazonaws.com'),(5,'password','ubuntu'),(5,'port','5900'),(7,'hostname','ec2-13-59-139-4.us-east-2.compute.amazonaws.com'),(7,'password','ubuntu'),(7,'port','5900'),(8,'hostname','ec2-18-188-24-175.us-east-2.compute.amazonaws.com'),(8,'password','ubuntu'),(8,'port','5900'),(9,'hostname','ec2-18-188-104-183.us-east-2.compute.amazonaws.com'),(9,'password','ubuntu'),(9,'port','5900'),(10,'hostname','ec2-18-188-188-159.us-east-2.compute.amazonaws.com'),(10,'password','ubuntu'),(10,'port','5900'),(11,'hostname','ec2-18-217-198-77.us-east-2.compute.amazonaws.com'),(11,'password','ubuntu'),(11,'port','5900'),(12,'hostname','ec2-3-16-79-116.us-east-2.compute.amazonaws.com'),(12,'password','ubuntu'),(12,'port','5900'),(13,'hostname','ec2-18-222-92-106.us-east-2.compute.amazonaws.com'),(13,'password','ubuntu'),(13,'port','5900'),(14,'hostname','ec2-18-222-107-54.us-east-2.compute.amazonaws.com'),(14,'password','ubuntu'),(14,'port','5900'),(15,'hostname','ec2-18-222-182-166.us-east-2.compute.amazonaws.com'),(15,'password','ubuntu'),(15,'port','5900'),(16,'hostname','ec2-18-223-211-74.us-east-2.compute.amazonaws.com'),(16,'password','ubuntu'),(16,'port','5900'),(17,'hostname','ec2-18-224-33-14.us-east-2.compute.amazonaws.com'),(17,'password','ubuntu'),(17,'port','5900'),(18,'hostname','ec2-52-14-110-72.us-east-2.compute.amazonaws.com'),(18,'password','ubuntu'),(18,'port','5900'),(19,'hostname','ec2-52-15-107-39.us-east-2.compute.amazonaws.com'),(19,'password','ubuntu'),(19,'port','5900'),(20,'hostname','ec2-52-15-197-81.us-east-2.compute.amazonaws.com'),(20,'password','ubuntu'),(20,'port','5900'),(21,'hostname','ec2-18-191-22-216.us-east-2.compute.amazonaws.com'),(21,'password','ubuntu'),(21,'port','5900'),(22,'hostname','ec2-18-221-25-20.us-east-2.compute.amazonaws.com'),(22,'password','ubuntu'),(22,'port','5900'),(24,'hostname','ec2-18-221-169-9.us-east-2.compute.amazonaws.com'),(24,'password','ubuntu'),(24,'port','5900'),(26,'hostname','ec2-18-219-134-159.us-east-2.compute.amazonaws.com'),(26,'password','ubuntu'),(26,'port','5900'),(27,'hostname','ec2-13-58-77-212.us-east-2.compute.amazonaws.com'),(27,'password','ubuntu'),(27,'port','5900'),(29,'hostname','ec2-13-58-77-212.us-east-2.compute.amazonaws.com'),(29,'password','ubuntu'),(29,'port','5900'),(30,'hostname','ec2-13-58-77-212.us-east-2.compute.amazonaws.com'),(30,'password','ubuntu'),(30,'port','5900');
/*!40000 ALTER TABLE `guacamole_connection_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_connection_permission`
--

DROP TABLE IF EXISTS `guacamole_connection_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_connection_permission` (
  `entity_id` int(11) NOT NULL,
  `connection_id` int(11) NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`connection_id`,`permission`),
  KEY `guacamole_connection_permission_ibfk_1` (`connection_id`),
  CONSTRAINT `guacamole_connection_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_connection_permission_ibfk_1` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_permission`
--

LOCK TABLES `guacamole_connection_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_permission` DISABLE KEYS */;
INSERT INTO `guacamole_connection_permission` VALUES (15,2,'READ'),(15,2,'UPDATE'),(15,2,'DELETE'),(15,2,'ADMINISTER'),(16,3,'READ'),(16,3,'UPDATE'),(16,3,'DELETE'),(16,3,'ADMINISTER'),(17,4,'READ'),(17,4,'UPDATE'),(17,4,'DELETE'),(17,4,'ADMINISTER'),(18,5,'READ'),(18,5,'UPDATE'),(18,5,'DELETE'),(18,5,'ADMINISTER'),(20,7,'READ'),(20,7,'UPDATE'),(20,7,'DELETE'),(20,7,'ADMINISTER'),(21,8,'READ'),(21,8,'UPDATE'),(21,8,'DELETE'),(21,8,'ADMINISTER'),(22,9,'READ'),(22,9,'UPDATE'),(22,9,'DELETE'),(22,9,'ADMINISTER'),(23,10,'READ'),(23,10,'UPDATE'),(23,10,'DELETE'),(23,10,'ADMINISTER'),(24,11,'READ'),(24,11,'UPDATE'),(24,11,'DELETE'),(24,11,'ADMINISTER'),(25,12,'READ'),(25,12,'UPDATE'),(25,12,'DELETE'),(25,12,'ADMINISTER'),(26,13,'READ'),(26,13,'UPDATE'),(26,13,'DELETE'),(26,13,'ADMINISTER'),(27,14,'READ'),(27,14,'UPDATE'),(27,14,'DELETE'),(27,14,'ADMINISTER'),(28,15,'READ'),(28,15,'UPDATE'),(28,15,'DELETE'),(28,15,'ADMINISTER'),(29,16,'READ'),(29,16,'UPDATE'),(29,16,'DELETE'),(29,16,'ADMINISTER'),(30,17,'READ'),(30,17,'UPDATE'),(30,17,'DELETE'),(30,17,'ADMINISTER'),(31,18,'READ'),(31,18,'UPDATE'),(31,18,'DELETE'),(31,18,'ADMINISTER'),(32,19,'READ'),(32,19,'UPDATE'),(32,19,'DELETE'),(32,19,'ADMINISTER'),(33,20,'READ'),(33,20,'UPDATE'),(33,20,'DELETE'),(33,20,'ADMINISTER'),(14,21,'READ'),(14,21,'UPDATE'),(14,21,'DELETE'),(14,21,'ADMINISTER'),(19,22,'READ'),(19,22,'UPDATE'),(19,22,'DELETE'),(19,22,'ADMINISTER'),(34,24,'READ'),(34,24,'UPDATE'),(34,24,'DELETE'),(34,24,'ADMINISTER'),(35,26,'READ'),(35,26,'UPDATE'),(35,26,'DELETE'),(35,26,'ADMINISTER'),(36,27,'READ'),(36,27,'UPDATE'),(36,27,'DELETE'),(36,27,'ADMINISTER'),(1,29,'READ'),(1,29,'UPDATE'),(1,29,'DELETE'),(1,29,'ADMINISTER'),(1,30,'READ'),(1,30,'UPDATE'),(1,30,'DELETE'),(1,30,'ADMINISTER');
/*!40000 ALTER TABLE `guacamole_connection_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_entity`
--

DROP TABLE IF EXISTS `guacamole_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_entity` (
  `entity_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `type` enum('USER','USER_GROUP') NOT NULL,
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `guacamole_entity_name_scope` (`type`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_entity`
--

LOCK TABLES `guacamole_entity` WRITE;
/*!40000 ALTER TABLE `guacamole_entity` DISABLE KEYS */;
INSERT INTO `guacamole_entity` VALUES (1,'guacadmin','USER'),(14,'student01','USER'),(15,'student02','USER'),(16,'student03','USER'),(17,'student04','USER'),(18,'student05','USER'),(19,'student06','USER'),(20,'student07','USER'),(21,'student08','USER'),(22,'student09','USER'),(23,'student10','USER'),(24,'student11','USER'),(25,'student12','USER'),(26,'student13','USER'),(27,'student14','USER'),(28,'student15','USER'),(29,'student16','USER'),(30,'student17','USER'),(31,'student18','USER'),(32,'student19','USER'),(33,'student20','USER'),(34,'student21','USER'),(35,'student22','USER'),(36,'student23','USER'),(38,'student24','USER'),(39,'student25','USER');
/*!40000 ALTER TABLE `guacamole_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_sharing_profile`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_sharing_profile` (
  `sharing_profile_id` int(11) NOT NULL AUTO_INCREMENT,
  `sharing_profile_name` varchar(128) NOT NULL,
  `primary_connection_id` int(11) NOT NULL,
  PRIMARY KEY (`sharing_profile_id`),
  UNIQUE KEY `sharing_profile_name_primary` (`sharing_profile_name`,`primary_connection_id`),
  KEY `guacamole_sharing_profile_ibfk_1` (`primary_connection_id`),
  CONSTRAINT `guacamole_sharing_profile_ibfk_1` FOREIGN KEY (`primary_connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile`
--

LOCK TABLES `guacamole_sharing_profile` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_sharing_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_sharing_profile_attribute`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_sharing_profile_attribute` (
  `sharing_profile_id` int(11) NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`sharing_profile_id`,`attribute_name`),
  KEY `sharing_profile_id` (`sharing_profile_id`),
  CONSTRAINT `guacamole_sharing_profile_attribute_ibfk_1` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile_attribute`
--

LOCK TABLES `guacamole_sharing_profile_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_sharing_profile_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_sharing_profile_parameter`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_sharing_profile_parameter` (
  `sharing_profile_id` int(11) NOT NULL,
  `parameter_name` varchar(128) NOT NULL,
  `parameter_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`sharing_profile_id`,`parameter_name`),
  CONSTRAINT `guacamole_sharing_profile_parameter_ibfk_1` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile_parameter`
--

LOCK TABLES `guacamole_sharing_profile_parameter` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_sharing_profile_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_sharing_profile_permission`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_sharing_profile_permission` (
  `entity_id` int(11) NOT NULL,
  `sharing_profile_id` int(11) NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`sharing_profile_id`,`permission`),
  KEY `guacamole_sharing_profile_permission_ibfk_1` (`sharing_profile_id`),
  CONSTRAINT `guacamole_sharing_profile_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_sharing_profile_permission_ibfk_1` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile_permission`
--

LOCK TABLES `guacamole_sharing_profile_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_sharing_profile_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_system_permission`
--

DROP TABLE IF EXISTS `guacamole_system_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_system_permission` (
  `entity_id` int(11) NOT NULL,
  `permission` enum('CREATE_CONNECTION','CREATE_CONNECTION_GROUP','CREATE_SHARING_PROFILE','CREATE_USER','CREATE_USER_GROUP','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`permission`),
  CONSTRAINT `guacamole_system_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_system_permission`
--

LOCK TABLES `guacamole_system_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_system_permission` DISABLE KEYS */;
INSERT INTO `guacamole_system_permission` VALUES (1,'CREATE_CONNECTION'),(1,'CREATE_CONNECTION_GROUP'),(1,'CREATE_SHARING_PROFILE'),(1,'CREATE_USER'),(1,'CREATE_USER_GROUP'),(1,'ADMINISTER');
/*!40000 ALTER TABLE `guacamole_system_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user`
--

DROP TABLE IF EXISTS `guacamole_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL,
  `password_hash` binary(32) NOT NULL,
  `password_salt` binary(32) DEFAULT NULL,
  `password_date` datetime NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `expired` tinyint(1) NOT NULL DEFAULT '0',
  `access_window_start` time DEFAULT NULL,
  `access_window_end` time DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `timezone` varchar(64) DEFAULT NULL,
  `full_name` varchar(256) DEFAULT NULL,
  `email_address` varchar(256) DEFAULT NULL,
  `organization` varchar(256) DEFAULT NULL,
  `organizational_role` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `guacamole_user_single_entity` (`entity_id`),
  CONSTRAINT `guacamole_user_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user`
--

LOCK TABLES `guacamole_user` WRITE;
/*!40000 ALTER TABLE `guacamole_user` DISABLE KEYS */;
INSERT INTO `guacamole_user` VALUES (1,1,_binary '0\»\ÓWA\ıyy\ÁsÜäcÉáö†\Ÿ\Í˛\\\‡¸51®ç\ÏNeöY',_binary '≥G´/∂\n¿\Ú£v9¿	\“EàJ¿2ì\ﬁÈàó\ﬁ|T≠','2019-02-19 07:08:40',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,14,_binary '_\·ßLOrô\Ëw\\'\ı\‚j\ﬁ˛+~KX-\ıøw};Púæ',_binary 'ô\Õ\ÿ\'\ÀXT\Ï\'IH\∆\„I)•+\Á#uøn∞≤~\À\Â','2019-02-19 06:47:56',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,15,_binary '?î∫xa\‚ùQπµ/b∞Ç\…&\Ù\Ïl\À\˜8à-\‘VtFâ*',_binary 'Å¥o¢poÖq\ƒEq\\\Á.:G\Œ\Ò6\rp®QåX◊±@','2019-02-19 06:48:19',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,16,_binary '¥4\∆Ãï[P˝W®\Â&®∑z\ÏIõ∏∫{cˇ<\\\√k¡ï',_binary 'L¢3¢=C˝@\ıaW÷®_Ö$ï˘o\ﬂ\Ó\Ì\ÚRö\ÃY\'çD','2019-02-19 06:48:53',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,17,_binary '/7\Ò¡›óª\Á\‘<’ó\‰\«\ra.ÅÀÆk\„í}´\Ì',_binary 'ã\Õkº`Æ2=\ÎN›ê¨?ñD°\‘5\„R∑\…Ω¸','2019-02-19 06:49:08',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(18,18,_binary '\ﬁ´\Ú>lcãºÑ&W\Ù=G\∆\√|ù2™H?>¡Ω\ˆ',_binary '5YU\ n:\«]´`\0=\√¯2¢êZ[\‹\…cÑiôs2\“)','2019-02-19 06:49:26',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,19,_binary '\ﬁ7b∏q^A\ˆ\”)\‚ˇ(A\È4∏q2krü[\ı-ÆV',_binary '^\‚?Tv_]≠\Ô\œ^E/?\Ÿ\»\†øL!Ω∑ˇ\Ùè∂K£','2019-02-19 06:49:40',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,20,_binary 'û\÷Kg\ﬁ%\„&\Ó¶Sa\ˆ\«3±5)œà\Á\«~´5ó+B',_binary 'Í¨æ\—%\˜fª≥Y	ºM;(\”˙\À\Œ¡∂Ñ˚ïœüT\Ò','2019-02-19 06:49:56',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,21,_binary '}\–&´2Uï\r\◊\Ó1.\œ\ƒ\‚y2`˛-¥ü2\≈\Ïj\ˆ\⁄&\',_binary '^îç0\ +˚Åç\Íg¸\n\Œ|àr\ÎÆ1!ù•mzÆÅ+','2019-02-19 06:50:08',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,22,_binary '≤™\…Hπ)J¥\'\Ô(WÜ?ój\Ôâ\Ô\Œ\rΩyP`∞$¿',_binary '˚wPsI\ÀFÇèaZ\ˆò\\'!\ÓD\ÕS\Î\√\‹\r\\\Ú\Z\Ò\¬˛','2019-02-19 06:50:21',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,23,_binary '\‰$\Ÿv˚V\rB\∆\ \Ã\‰rï§\'A-vzCÆ=û\Ë\Ó§˛(J',_binary '‹§#\ZÉà\Ÿ\»&E3éè—±°≠Cs*A\€\Â\˜ÑŸÅ\ﬁ≈±','2019-02-19 07:04:51',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,24,_binary 'lWOá3;q®qI\€Gqù\Ë^W-ho@	\Ô≤\Ìá!\Ì\—',_binary '.˛vlÖz\Ô∞Xz\ˆ.Zù¸bZkü>´`O\÷\◊\":\“\‹g¶','2019-02-19 07:05:12',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,25,_binary 'oîa¸ã\ÙNô\—\œ\‡(füÄDgÖTR&èƒÄªí&˛~\‘',_binary '\…wW≈∏›¥®ˇ4Éõ\÷\\‘}FÄü©Hü∫rØ\0\Ùà≠','2019-02-19 07:05:26',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,26,_binary 'pÉæã∏é\ÂUÄ\Zu\r\◊\ƒœâƒâ\„}è#\Œ\≈ˇâù',_binary 'köø\Ô,≤$\‰âiô\ÒO\ÿ\–t\Â&|\„\‚$\Ù¡≤b¢XH~','2019-02-19 07:05:46',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,27,_binary ':ÇN•ò\‡\‘CO4¡uñ`˝\Û\r≥®\ˆq8\Ò~\Œ0Æt',_binary '\ÿ2\œ\‘\"@‹é|?–¥\¬p¯0xÄ9\À¸Ü1=∑Aˇ¿','2019-02-19 07:06:08',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,28,_binary 'BE\À\ﬂ˝\◊{e\Â%\’/r\nï¶s\»\r—¨b\\qΩ6~¢è\»',_binary '\\jQ\ÿV>ó\–töI\“J\’\˜\Ô\Ã\…\≈/xúT≤>?¥\Î','2019-02-19 07:06:21',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,29,_binary 'NF\Ós3/v4X\Óù\Û\Ù,’Ö@¡\ÔS\”JŸ±$»Ä',_binary '%<±nê9á_\Ï~±gò.G\Úè1ußF~ƒíX\…\Z','2019-02-19 07:06:34',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,30,_binary 'ªA.>∂¡\–RŒù∏^%≤ú¢ò[S∫ãå\ÃzáwI≤∑)',_binary 'dõ\\ZS\Ú=†µH\"ïG•	ôöú\Ìy9üNN\Ì≤ô\€\¬{\‚','2019-02-19 07:06:48',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,31,_binary '(îYrè†≠å•¯¸d]M\Œ\ÃW^?∫]å˛ó¡\Ú6°',_binary '∞64\‚Ø\»\ﬁ\€;∂3\Ô v\ÂGõ\œ?dI`w5R©Äi','2019-02-19 07:07:01',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,32,_binary '\◊u’ãJ1<\\\„<3g\Ú∞Ö\Ò1\„ˇ\Z(ã\„*os/	',_binary 'z!£Ω <\\∆Å`,\ÌÇ{3Zê¿\Ù)n\ı\Õ\◊','2019-02-19 07:07:15',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,33,_binary '\“)πK%\·\"´\‹y6¯ßYFn\ l\0\“\ˆò\€∆è\\±é.¶',_binary '\ƒ\˜puû\‰\‘¨L£\núuYé\Â∏\∆p\Õ\‡\Z\·¢»é','2019-02-19 07:07:28',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(34,34,_binary 'Zç´ê}ÑPÆ\Ã\ÿ6\Õ˙-H\€\∆⁄åX\ AJz\÷/\«\∆',_binary 'h\’0¢*8aN%C˙[©ΩfD$CvX?^ø:\È\„<Ω','2019-02-19 18:18:57',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,35,_binary ')\Z›®Êà≠ ;\ƒ¸ö\ﬂs-≠%\r_	t±L\0\»m.=s8l',_binary 'cüm\ÌUº°†˘øâó\0Ø˙ß¨_é˙¸|\Í','2019-02-19 19:04:16',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(36,36,_binary '≥?)úõMZ\·Ωgºás\◊v√™ã4yôõﬂò¨',_binary '™çDº$qPQfæ\"Åz\È	õh\"πHª\“w\‘e]G¨','2019-02-19 19:04:34',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,38,_binary '˘7\ı∑\‹w¯}@ç?h\ﬁÇ∏ºJv≤@Å!ÃÅ√™ªª',_binary '≤Kå)ºÅ°∂X∂b}zí^‹ê\Û®∂\"\Îôpv[\\O','2019-02-27 21:31:07',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(39,39,_binary 'ú$ßÜ§l´\÷™X\»húwh˘<|∫m˚F& D+\⁄°',_binary '4Fë\ \Òç<◊ô]\ËN:Å´≥p){∂\ƒ\Ï±sßD','2019-02-27 21:31:23',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `guacamole_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_attribute`
--

DROP TABLE IF EXISTS `guacamole_user_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_user_attribute` (
  `user_id` int(11) NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`user_id`,`attribute_name`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `guacamole_user_attribute_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_attribute`
--

LOCK TABLES `guacamole_user_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_user_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_group`
--

DROP TABLE IF EXISTS `guacamole_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_user_group` (
  `user_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_group_id`),
  UNIQUE KEY `guacamole_user_group_single_entity` (`entity_id`),
  CONSTRAINT `guacamole_user_group_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group`
--

LOCK TABLES `guacamole_user_group` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_group_attribute`
--

DROP TABLE IF EXISTS `guacamole_user_group_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_user_group_attribute` (
  `user_group_id` int(11) NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`user_group_id`,`attribute_name`),
  KEY `user_group_id` (`user_group_id`),
  CONSTRAINT `guacamole_user_group_attribute_ibfk_1` FOREIGN KEY (`user_group_id`) REFERENCES `guacamole_user_group` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group_attribute`
--

LOCK TABLES `guacamole_user_group_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_group_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_group_member`
--

DROP TABLE IF EXISTS `guacamole_user_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_user_group_member` (
  `user_group_id` int(11) NOT NULL,
  `member_entity_id` int(11) NOT NULL,
  PRIMARY KEY (`user_group_id`,`member_entity_id`),
  KEY `guacamole_user_group_member_entity_id` (`member_entity_id`),
  CONSTRAINT `guacamole_user_group_member_entity_id` FOREIGN KEY (`member_entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_user_group_member_parent_id` FOREIGN KEY (`user_group_id`) REFERENCES `guacamole_user_group` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group_member`
--

LOCK TABLES `guacamole_user_group_member` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_group_permission`
--

DROP TABLE IF EXISTS `guacamole_user_group_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_user_group_permission` (
  `entity_id` int(11) NOT NULL,
  `affected_user_group_id` int(11) NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`affected_user_group_id`,`permission`),
  KEY `guacamole_user_group_permission_affected_user_group` (`affected_user_group_id`),
  CONSTRAINT `guacamole_user_group_permission_affected_user_group` FOREIGN KEY (`affected_user_group_id`) REFERENCES `guacamole_user_group` (`user_group_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_user_group_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group_permission`
--

LOCK TABLES `guacamole_user_group_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_group_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_history`
--

DROP TABLE IF EXISTS `guacamole_user_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_user_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(128) NOT NULL,
  `remote_host` varchar(256) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `user_id` (`user_id`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`),
  KEY `user_start_date` (`user_id`,`start_date`),
  CONSTRAINT `guacamole_user_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_history`
--

LOCK TABLES `guacamole_user_history` WRITE;
/*!40000 ALTER TABLE `guacamole_user_history` DISABLE KEYS */;
INSERT INTO `guacamole_user_history` VALUES (1,1,'guacadmin','73.70.201.210','2019-02-19 05:23:38','2019-02-19 07:08:44'),(2,1,'guacadmin','73.70.201.210','2019-02-19 07:08:50','2019-02-19 07:45:03'),(3,14,'student01','73.70.201.210','2019-02-19 07:45:11','2019-02-19 07:53:41'),(4,14,'student01','73.70.201.210','2019-02-19 08:01:28','2019-02-19 08:13:18'),(5,15,'student02','73.70.201.210','2019-02-19 08:13:46','2019-02-19 08:15:11'),(6,14,'student01','73.70.201.210','2019-02-19 08:15:18','2019-02-19 08:15:37'),(7,15,'student02','73.70.201.210','2019-02-19 08:15:42','2019-02-19 08:15:45'),(8,16,'student03','73.70.201.210','2019-02-19 08:16:01','2019-02-19 08:17:09'),(9,14,'student01','73.70.201.210','2019-02-19 08:17:19','2019-02-19 08:17:33'),(10,15,'student02','73.70.201.210','2019-02-19 08:17:42','2019-02-19 08:17:53'),(11,16,'student03','73.70.201.210','2019-02-19 08:17:59','2019-02-19 08:18:02'),(12,17,'student04','73.70.201.210','2019-02-19 08:18:07','2019-02-19 08:18:53'),(13,18,'student05','73.70.201.210','2019-02-19 08:18:58','2019-02-19 08:20:29'),(14,19,'student06','73.70.201.210','2019-02-19 08:20:38','2019-02-19 08:21:48'),(15,20,'student07','73.70.201.210','2019-02-19 08:21:55','2019-02-19 08:22:58'),(16,21,'student08','73.70.201.210','2019-02-19 08:23:05','2019-02-19 08:24:08'),(17,22,'student09','73.70.201.210','2019-02-19 08:24:15','2019-02-19 08:25:16'),(18,23,'student10','73.70.201.210','2019-02-19 08:25:21','2019-02-19 08:26:18'),(19,24,'student11','73.70.201.210','2019-02-19 08:26:23','2019-02-19 08:27:17'),(20,25,'student12','73.70.201.210','2019-02-19 08:27:23','2019-02-19 08:28:18'),(21,26,'student13','73.70.201.210','2019-02-19 08:28:26','2019-02-19 08:29:25'),(22,27,'student14','73.70.201.210','2019-02-19 08:29:32','2019-02-19 08:30:45'),(23,28,'student15','73.70.201.210','2019-02-19 08:30:54','2019-02-19 08:31:54'),(24,29,'student16','73.70.201.210','2019-02-19 08:32:06','2019-02-19 08:33:19'),(25,30,'student17','73.70.201.210','2019-02-19 08:33:38','2019-02-19 08:34:26'),(26,31,'student18','73.70.201.210','2019-02-19 08:34:32','2019-02-19 08:35:23'),(27,32,'student19','73.70.201.210','2019-02-19 08:35:31','2019-02-19 08:36:30'),(28,33,'student20','73.70.201.210','2019-02-19 08:36:53','2019-02-19 08:37:33'),(29,1,'guacadmin','73.70.201.210','2019-02-19 08:37:40','2019-02-19 09:38:34'),(30,14,'student01','104.36.222.19','2019-02-19 13:01:21','2019-02-19 14:01:34'),(31,19,'student06','171.159.64.10','2019-02-19 17:36:02','2019-02-19 17:42:59'),(32,24,'student11','171.161.160.10','2019-02-19 17:36:08','2019-02-21 09:59:34'),(33,21,'student08','171.159.64.10','2019-02-19 17:36:13','2019-02-19 22:28:34'),(34,25,'student12','171.159.64.10','2019-02-19 17:36:19','2019-02-19 18:41:48'),(35,20,'student07','171.159.64.10','2019-02-19 17:36:22','2019-02-20 22:31:34'),(36,23,'student10','171.159.64.10','2019-02-19 17:36:23','2019-02-19 18:58:27'),(37,33,'student20','171.161.189.133','2019-02-19 17:36:41','2019-02-19 18:37:34'),(38,27,'student14','171.161.160.10','2019-02-19 17:36:41','2019-02-21 01:34:34'),(39,15,'student02','171.159.64.10','2019-02-19 17:36:41','2019-02-19 23:25:34'),(40,32,'student19','171.161.189.133','2019-02-19 17:36:42','2019-02-19 18:38:34'),(41,31,'student18','171.159.64.10','2019-02-19 17:36:45','2019-02-20 00:58:34'),(42,29,'student16','171.159.64.10','2019-02-19 17:36:51','2019-02-21 09:59:34'),(43,26,'student13','171.159.64.10','2019-02-19 17:36:52','2019-02-19 18:37:34'),(44,14,'student01','172.56.7.242','2019-02-19 17:36:54','2019-02-19 17:55:06'),(45,30,'student17','171.159.64.10','2019-02-19 17:36:54','2019-02-19 22:31:34'),(46,22,'student09','171.159.64.10','2019-02-19 17:36:59','2019-02-19 23:41:34'),(47,28,'student15','171.159.64.10','2019-02-19 17:37:05','2019-02-19 18:37:34'),(48,16,'student03','171.161.189.133','2019-02-19 17:37:07','2019-02-19 18:42:34'),(49,14,'student01','171.159.64.10','2019-02-19 17:37:07','2019-02-19 17:37:42'),(50,18,'student05','171.159.64.10','2019-02-19 17:37:52','2019-02-19 23:44:34'),(51,14,'student01','171.161.189.133','2019-02-19 17:38:15','2019-02-19 17:40:25'),(52,16,'student03','171.161.189.133','2019-02-19 17:39:50','2019-02-19 18:40:34'),(53,14,'student01','171.161.189.133','2019-02-19 17:40:37','2019-02-19 17:43:03'),(54,14,'student01','171.161.189.133','2019-02-19 17:43:07','2019-02-19 17:54:27'),(55,19,'student06','171.159.64.10','2019-02-19 17:43:20','2019-02-19 18:44:34'),(56,14,'student01','171.161.189.133','2019-02-19 17:54:30','2019-02-19 18:55:34'),(57,19,'student06','172.56.7.102','2019-02-19 17:55:13','2019-02-19 17:55:22'),(58,1,'guacadmin','73.70.201.210','2019-02-19 17:56:22','2019-02-19 18:00:59'),(59,19,'student06','172.56.7.242','2019-02-19 17:59:09','2019-02-19 17:59:32'),(60,14,'student01','172.56.7.242','2019-02-19 18:00:23','2019-02-19 18:10:44'),(61,14,'student01','73.70.201.210','2019-02-19 18:01:07','2019-02-19 18:02:00'),(62,19,'student06','73.70.201.210','2019-02-19 18:02:38','2019-02-19 18:10:36'),(63,1,'guacadmin','73.70.201.210','2019-02-19 18:10:42','2019-02-19 18:18:24'),(64,19,'student06','172.56.7.242','2019-02-19 18:10:53','2019-02-19 18:11:26'),(65,1,'guacadmin','73.70.201.210','2019-02-19 18:18:31','2019-02-19 18:19:00'),(66,34,'student21','73.70.201.210','2019-02-19 18:19:07','2019-02-19 18:19:45'),(67,1,'guacadmin','73.70.201.210','2019-02-19 18:20:17','2019-02-19 19:01:30'),(68,34,'student21','171.161.189.133','2019-02-19 18:26:06','2019-02-20 00:14:34'),(69,25,'student12','171.159.64.10','2019-02-19 18:41:55','2019-02-19 18:58:00'),(70,28,'student15','171.159.192.10','2019-02-19 18:44:12','2019-02-19 22:47:34'),(71,16,'student03','171.161.189.133','2019-02-19 18:44:42','2019-02-19 18:45:10'),(72,16,'student03','171.161.189.133','2019-02-19 18:45:14','2019-02-19 18:46:05'),(73,16,'student03','171.161.189.133','2019-02-19 18:46:06','2019-02-19 18:47:48'),(74,16,'student03','171.161.189.133','2019-02-19 18:47:57','2019-02-19 23:00:29'),(75,32,'student19','171.161.189.133','2019-02-19 18:52:07','2019-02-19 19:20:09'),(76,23,'student10','171.161.160.10','2019-02-19 18:59:08','2019-02-19 22:01:58'),(77,25,'student12','171.159.64.10','2019-02-19 19:00:24','2019-02-19 22:46:34'),(78,25,'student12','73.70.201.210','2019-02-19 19:01:39','2019-02-19 19:02:28'),(79,1,'guacadmin','73.70.201.210','2019-02-19 19:02:34','2019-02-19 19:03:41'),(80,1,'guacadmin','73.70.201.210','2019-02-19 19:03:48','2019-02-19 19:10:19'),(81,33,'student20','171.161.189.133','2019-02-19 19:09:11','2019-02-19 21:56:34'),(82,14,'student01','171.161.189.133','2019-02-19 19:09:26','2019-02-19 19:40:53'),(83,35,'student22','73.70.201.210','2019-02-19 19:10:27','2019-02-19 19:19:23'),(84,26,'student13','171.159.64.10','2019-02-19 19:12:30','2019-02-19 22:52:34'),(85,19,'student06','171.161.160.10','2019-02-19 19:13:15','2019-02-19 22:31:34'),(86,17,'student04','171.161.160.10','2019-02-19 19:17:53','2019-02-19 19:18:36'),(87,17,'student04','171.161.160.10','2019-02-19 19:18:54','2019-02-19 19:27:42'),(88,36,'student23','73.70.201.210','2019-02-19 19:19:31','2019-02-19 19:19:46'),(89,1,'guacadmin','73.70.201.210','2019-02-19 19:19:52','2019-02-19 19:20:18'),(90,32,'student19','171.161.189.133','2019-02-19 19:20:19','2019-02-19 20:51:34'),(91,36,'student23','73.70.201.210','2019-02-19 19:20:23','2019-02-19 19:41:57'),(92,17,'student04','171.161.160.10','2019-02-19 19:27:53','2019-02-19 19:28:39'),(93,17,'student04','171.161.160.10','2019-02-19 19:30:13','2019-02-19 22:06:34'),(94,14,'student01','171.161.189.133','2019-02-19 19:40:58','2019-02-19 23:33:34'),(95,32,'student19','171.161.189.133','2019-02-19 20:51:46','2019-02-19 23:19:34'),(96,23,'student10','171.159.64.10','2019-02-19 22:02:07','2019-02-19 23:19:34'),(97,17,'student04','171.159.64.10','2019-02-19 22:07:19','2019-02-19 22:18:50'),(98,1,'guacadmin','73.70.201.210','2019-02-19 22:16:27','2019-02-20 00:00:30'),(99,17,'student04','171.161.160.10','2019-02-19 22:19:08','2019-02-20 02:07:34'),(100,19,'student06','171.161.160.10','2019-02-19 22:32:51','2019-02-20 02:41:34'),(101,16,'student03','171.161.189.133','2019-02-19 23:00:32','2019-02-19 23:08:06'),(102,35,'student22','171.161.189.133','2019-02-19 23:08:14','2019-02-20 00:08:34'),(103,NULL,'test-user','73.70.201.210','2019-02-20 00:00:35','2019-02-20 01:04:34'),(104,26,'student13','171.161.160.10','2019-02-20 00:23:51','2019-02-20 01:24:34'),(105,1,'guacadmin','73.70.201.210','2019-02-20 01:08:41','2019-02-20 06:20:34'),(106,25,'student12','72.176.250.86','2019-02-20 02:18:44','2019-02-20 03:19:34'),(107,18,'student05','171.161.160.10','2019-02-20 04:56:04','2019-02-20 05:56:34'),(108,35,'student22','47.186.0.157','2019-02-20 05:23:42','2019-02-20 07:44:34'),(109,16,'student03','47.186.0.157','2019-02-20 06:08:04','2019-02-20 07:08:34'),(110,NULL,'test-user','73.70.201.210','2019-02-20 06:28:15','2019-02-20 07:30:34'),(111,23,'student10','171.161.160.10','2019-02-20 14:05:24','2019-02-20 18:58:34'),(112,21,'student08','171.161.160.10','2019-02-20 14:09:46','2019-02-20 22:33:34'),(113,1,'guacadmin','73.70.201.210','2019-02-20 14:20:20','2019-02-20 21:03:34'),(114,22,'student09','171.159.194.11','2019-02-20 14:26:26','2019-02-20 17:59:34'),(115,26,'student13','171.161.160.10','2019-02-20 14:31:46','2019-02-20 23:03:34'),(116,32,'student19','171.161.189.133','2019-02-20 14:34:14','2019-02-20 18:21:34'),(117,25,'student12','171.161.160.10','2019-02-20 14:36:33','2019-02-20 14:43:04'),(118,35,'student22','171.161.189.133','2019-02-20 14:37:56','2019-02-20 22:40:34'),(119,30,'student17','171.159.64.10','2019-02-20 14:39:26','2019-02-20 22:08:34'),(120,25,'student12','171.161.160.10','2019-02-20 14:40:11','2019-02-20 17:51:34'),(121,25,'student12','171.161.160.10','2019-02-20 14:43:12','2019-02-20 14:47:05'),(122,28,'student15','171.159.192.10','2019-02-20 14:46:00','2019-02-20 18:03:34'),(123,31,'student18','171.161.160.10','2019-02-20 14:47:21','2019-02-20 22:28:34'),(124,19,'student06','171.161.160.10','2019-02-20 15:02:55','2019-02-21 09:59:34'),(125,25,'student12','171.161.160.10','2019-02-20 16:52:17','2019-02-20 17:22:44'),(126,15,'student02','171.159.64.10','2019-02-20 16:56:35','2019-02-20 22:44:34'),(127,33,'student20','171.161.189.133','2019-02-20 16:59:22','2019-02-20 18:38:34'),(128,34,'student21','171.161.189.133','2019-02-20 17:02:26','2019-02-21 00:43:34'),(129,14,'student01','171.161.189.133','2019-02-20 17:05:08','2019-02-20 17:05:14'),(130,18,'student05','171.159.64.10','2019-02-20 17:05:14','2019-02-21 00:02:34'),(131,14,'student01','171.161.189.133','2019-02-20 17:05:18','2019-02-20 18:27:34'),(132,36,'student23','171.161.160.10','2019-02-20 17:22:57','2019-02-20 17:46:04'),(133,25,'student12','171.161.160.10','2019-02-20 17:46:11','2019-02-20 17:47:14'),(134,36,'student23','171.161.160.10','2019-02-20 17:47:29','2019-02-20 22:34:04'),(135,22,'student09','171.161.160.10','2019-02-20 18:48:02','2019-02-20 22:38:34'),(136,23,'student10','171.161.160.10','2019-02-20 19:07:21','2019-02-20 22:21:34'),(137,32,'student19','171.161.189.133','2019-02-20 19:08:06','2019-02-20 22:34:34'),(138,33,'student20','171.161.189.133','2019-02-20 19:30:04','2019-02-20 22:48:34'),(139,28,'student15','171.159.64.10','2019-02-20 20:18:57','2019-02-20 22:34:34'),(140,14,'student01','108.119.96.29','2019-02-20 20:21:59','2019-02-21 00:13:34'),(141,1,'guacadmin','73.70.201.210','2019-02-20 23:26:19','2019-02-21 00:59:34'),(142,26,'student13','171.161.160.10','2019-02-21 00:34:48','2019-02-21 01:39:34'),(143,1,'guacadmin','73.70.201.210','2019-02-27 21:27:47','2019-02-27 21:38:17');
/*!40000 ALTER TABLE `guacamole_user_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_password_history`
--

DROP TABLE IF EXISTS `guacamole_user_password_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_user_password_history` (
  `password_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `password_hash` binary(32) NOT NULL,
  `password_salt` binary(32) DEFAULT NULL,
  `password_date` datetime NOT NULL,
  PRIMARY KEY (`password_history_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `guacamole_user_password_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_password_history`
--

LOCK TABLES `guacamole_user_password_history` WRITE;
/*!40000 ALTER TABLE `guacamole_user_password_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `guacamole_user_password_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guacamole_user_permission`
--

DROP TABLE IF EXISTS `guacamole_user_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `guacamole_user_permission` (
  `entity_id` int(11) NOT NULL,
  `affected_user_id` int(11) NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`affected_user_id`,`permission`),
  KEY `guacamole_user_permission_ibfk_1` (`affected_user_id`),
  CONSTRAINT `guacamole_user_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_user_permission_ibfk_1` FOREIGN KEY (`affected_user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_permission`
--

LOCK TABLES `guacamole_user_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_user_permission` DISABLE KEYS */;
INSERT INTO `guacamole_user_permission` VALUES (1,1,'READ'),(1,1,'UPDATE'),(1,1,'ADMINISTER'),(1,14,'READ'),(1,14,'UPDATE'),(1,14,'DELETE'),(1,14,'ADMINISTER'),(14,14,'READ'),(1,15,'READ'),(1,15,'UPDATE'),(1,15,'DELETE'),(1,15,'ADMINISTER'),(15,15,'READ'),(1,16,'READ'),(1,16,'UPDATE'),(1,16,'DELETE'),(1,16,'ADMINISTER'),(16,16,'READ'),(1,17,'READ'),(1,17,'UPDATE'),(1,17,'DELETE'),(1,17,'ADMINISTER'),(17,17,'READ'),(1,18,'READ'),(1,18,'UPDATE'),(1,18,'DELETE'),(1,18,'ADMINISTER'),(18,18,'READ'),(1,19,'READ'),(1,19,'UPDATE'),(1,19,'DELETE'),(1,19,'ADMINISTER'),(19,19,'READ'),(1,20,'READ'),(1,20,'UPDATE'),(1,20,'DELETE'),(1,20,'ADMINISTER'),(20,20,'READ'),(1,21,'READ'),(1,21,'UPDATE'),(1,21,'DELETE'),(1,21,'ADMINISTER'),(21,21,'READ'),(1,22,'READ'),(1,22,'UPDATE'),(1,22,'DELETE'),(1,22,'ADMINISTER'),(22,22,'READ'),(1,23,'READ'),(1,23,'UPDATE'),(1,23,'DELETE'),(1,23,'ADMINISTER'),(23,23,'READ'),(1,24,'READ'),(1,24,'UPDATE'),(1,24,'DELETE'),(1,24,'ADMINISTER'),(24,24,'READ'),(1,25,'READ'),(1,25,'UPDATE'),(1,25,'DELETE'),(1,25,'ADMINISTER'),(25,25,'READ'),(1,26,'READ'),(1,26,'UPDATE'),(1,26,'DELETE'),(1,26,'ADMINISTER'),(26,26,'READ'),(1,27,'READ'),(1,27,'UPDATE'),(1,27,'DELETE'),(1,27,'ADMINISTER'),(27,27,'READ'),(1,28,'READ'),(1,28,'UPDATE'),(1,28,'DELETE'),(1,28,'ADMINISTER'),(28,28,'READ'),(1,29,'READ'),(1,29,'UPDATE'),(1,29,'DELETE'),(1,29,'ADMINISTER'),(29,29,'READ'),(1,30,'READ'),(1,30,'UPDATE'),(1,30,'DELETE'),(1,30,'ADMINISTER'),(30,30,'READ'),(1,31,'READ'),(1,31,'UPDATE'),(1,31,'DELETE'),(1,31,'ADMINISTER'),(31,31,'READ'),(1,32,'READ'),(1,32,'UPDATE'),(1,32,'DELETE'),(1,32,'ADMINISTER'),(32,32,'READ'),(1,33,'READ'),(1,33,'UPDATE'),(1,33,'DELETE'),(1,33,'ADMINISTER'),(33,33,'READ'),(1,34,'READ'),(1,34,'UPDATE'),(1,34,'DELETE'),(1,34,'ADMINISTER'),(34,34,'READ'),(1,35,'READ'),(1,35,'UPDATE'),(1,35,'DELETE'),(1,35,'ADMINISTER'),(35,35,'READ'),(1,36,'READ'),(1,36,'UPDATE'),(1,36,'DELETE'),(1,36,'ADMINISTER'),(36,36,'READ'),(1,38,'READ'),(1,38,'UPDATE'),(1,38,'DELETE'),(1,38,'ADMINISTER'),(38,38,'READ'),(1,39,'READ'),(1,39,'UPDATE'),(1,39,'DELETE'),(1,39,'ADMINISTER'),(39,39,'READ');
/*!40000 ALTER TABLE `guacamole_user_permission` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-27 21:56:31
