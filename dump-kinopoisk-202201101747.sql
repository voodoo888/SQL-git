-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: kinopoisk
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `age_limit`
--

DROP TABLE IF EXISTS `age_limit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `age_limit` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `value` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `age_limit`
--

LOCK TABLES `age_limit` WRITE;
/*!40000 ALTER TABLE `age_limit` DISABLE KEYS */;
INSERT INTO `age_limit` VALUES (1,'первая',6),(2,'вторая',9),(3,'третья',12),(4,'четвертая',16),(5,'пятая',18),(6,'шестая',99);
/*!40000 ALTER TABLE `age_limit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint unsigned NOT NULL,
  `body` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `from_user_id` (`from_user_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,15,'eget massa. Suspendisse eleifend. Cras sed leo. Cras'),(2,5,'sem elit, pharetra ut, pharetra sed, hendrerit a, arcu. Sed et libero. Proin mi.'),(3,18,'ultrices sit amet, risus. Donec nibh enim, gravida sit amet, dapibus id, blandit at, nisi. Cum sociis natoque penatibus'),(4,16,'malesuada ut, sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit'),(5,16,'nec, malesuada ut, sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla tempor augue ac ipsum.'),(6,1,'ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi metus. Vivamus'),(7,11,'Duis mi enim, condimentum eget, volutpat ornare, facilisis eget, ipsum. Donec sollicitudin'),(8,10,'consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet posuere, enim nisl elementum purus, accumsan interdum'),(9,18,'Donec tempus, lorem fringilla ornare placerat, orci'),(10,18,'mattis. Integer eu lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit elit');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `favorit_films`
--

DROP TABLE IF EXISTS `favorit_films`;
/*!50001 DROP VIEW IF EXISTS `favorit_films`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `favorit_films` AS SELECT 
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `film_rating`
--

DROP TABLE IF EXISTS `film_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `film_rating` (
  `user_id` bigint unsigned NOT NULL,
  `film_id` bigint unsigned NOT NULL,
  `raiting` tinyint unsigned DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `film_id` (`film_id`),
  CONSTRAINT `film_rating_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `film_rating_ibfk_2` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `film_rating`
--

LOCK TABLES `film_rating` WRITE;
/*!40000 ALTER TABLE `film_rating` DISABLE KEYS */;
INSERT INTO `film_rating` VALUES (7,5,1),(19,19,7),(10,16,9),(10,14,6),(5,9,9),(15,16,7),(13,6,8),(8,9,0),(7,9,9),(5,17,1),(9,20,7),(4,13,8),(14,16,4),(8,17,7),(13,4,6);
/*!40000 ALTER TABLE `film_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `film_type`
--

DROP TABLE IF EXISTS `film_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `film_type` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `film_type`
--

LOCK TABLES `film_type` WRITE;
/*!40000 ALTER TABLE `film_type` DISABLE KEYS */;
INSERT INTO `film_type` VALUES (1,'Семейные'),(2,'Комедии'),(3,'Фэнтэзи'),(4,'Триллеры'),(5,'Драмы'),(6,'Приключения'),(7,'Документальные'),(8,'Ужасы'),(9,'Аниме'),(10,'Фантастика');
/*!40000 ALTER TABLE `film_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `films`
--

DROP TABLE IF EXISTS `films`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `films` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `film_type` bigint unsigned NOT NULL,
  `age_limit` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `film_type` (`film_type`),
  KEY `age_limit` (`age_limit`),
  KEY `film_name_idx` (`name`),
  CONSTRAINT `films_ibfk_1` FOREIGN KEY (`film_type`) REFERENCES `film_type` (`id`),
  CONSTRAINT `films_ibfk_2` FOREIGN KEY (`age_limit`) REFERENCES `age_limit` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `films`
--

LOCK TABLES `films` WRITE;
/*!40000 ALTER TABLE `films` DISABLE KEYS */;
INSERT INTO `films` VALUES (1,'Harlan Barr',6,2),(2,'Carissa Ashley',4,4),(3,'Deacon Bennett',5,1),(4,'Knox Knox',5,1),(5,'Louis Mcclure',4,1),(6,'Uta Gilliam',2,2),(7,'Phillip Snider',8,3),(8,'Hoyt Puckett',9,4),(9,'Francis Castaneda',5,6),(10,'Pearl Shields',10,6),(11,'Magna Sed Associates',2,6),(12,'Rhoncus Proin Nisl Corp.',8,3),(13,'Parturient Ltd',9,3),(14,'Pellentesque A Industries',5,4),(15,'Arcu Aliquam Foundation',10,5),(16,'Nascetur Ridiculus Mus Incorporated',4,1),(17,'Purus Associates',5,1),(18,'Dui Cum Sociis PC',4,1),(19,'Magna Praesent Incorporated',7,2),(20,'Donec Fringilla Inc.',6,2),(21,'Orci Phasellus LLC',5,6),(22,'Eget Odio Industries',4,2),(23,'Eleifend Cras Sed Limited',7,1);
/*!40000 ALTER TABLE `films` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `new_film`
--

DROP TABLE IF EXISTS `new_film`;
/*!50001 DROP VIEW IF EXISTS `new_film`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `new_film` AS SELECT 
 1 AS `id`,
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_collection`
--

DROP TABLE IF EXISTS `user_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_collection` (
  `user_id` bigint unsigned NOT NULL,
  `film_id` bigint unsigned NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `film_id` (`film_id`),
  CONSTRAINT `user_collection_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_collection_ibfk_2` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_collection`
--

LOCK TABLES `user_collection` WRITE;
/*!40000 ALTER TABLE `user_collection` DISABLE KEYS */;
INSERT INTO `user_collection` VALUES (1,10),(11,14),(10,17),(18,15),(18,6),(18,3),(9,12),(9,19),(5,18),(15,4);
/*!40000 ALTER TABLE `user_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_library`
--

DROP TABLE IF EXISTS `user_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_library` (
  `user_id` bigint unsigned NOT NULL,
  `film_id` bigint unsigned NOT NULL,
  KEY `film_id` (`film_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_library_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`),
  CONSTRAINT `user_library_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_library`
--

LOCK TABLES `user_library` WRITE;
/*!40000 ALTER TABLE `user_library` DISABLE KEYS */;
INSERT INTO `user_library` VALUES (8,22),(10,21),(7,20),(19,9),(3,9),(5,11),(12,20),(14,5),(20,16),(2,4),(15,20),(5,19),(18,20),(16,20),(16,5),(20,23),(20,23);
/*!40000 ALTER TABLE `user_library` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `viewed_time_adder` AFTER INSERT ON `user_library` FOR EACH ROW BEGIN 
	INSERT INTO viewed_time_type (user_id, film_id, viewed_time) VALUES (NEW.user_id, NEW.film_id, NULL);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Thor Mcgowan','in.consequat@aol.com','1988-10-09'),(2,'Alfonso Craft','eget@protonmail.org','1990-12-08'),(3,'Ivana Villarreal','facilisis.magna@hotmail.edu','1985-11-12'),(4,'Cameron Hopper','vestibulum.massa.rutrum@yahoo.ca','2020-09-10'),(5,'Caleb Dickerson','dui.cras@aol.com','2012-10-01'),(6,'Deanna Spencer','suspendisse.commodo@outlook.com','2021-10-02'),(7,'Melyssa Maddox','sed.est.nunc@icloud.ca','2022-05-21'),(8,'Steel Joyce','luctus@protonmail.edu','2022-10-27'),(9,'Abra Decker','faucibus@hotmail.ca','2021-02-04'),(10,'Bernard David','mauris.molestie.pharetra@google.com','2022-07-01'),(11,'Grace Sears','nam.ligula@outlook.net','2021-05-04'),(12,'Xandra Lewis','risus@aol.net','2021-11-30'),(13,'Abel Guy','mauris.sit@yahoo.ca','2022-03-14'),(14,'Remedios Levy','ante.ipsum.primis@hotmail.edu','2021-10-15'),(15,'Gail Tanner','diam@icloud.couk','2021-01-11'),(16,'Britanney Campbell','nunc.ac.mattis@google.com','2022-06-24'),(17,'Scarlett Jarvis','amet.ultricies.sem@hotmail.net','2022-09-08'),(18,'Akeem Hawkins','vitae.erat.vel@aol.couk','2022-07-21'),(19,'Myles Zimmerman','tortor.nunc.commodo@icloud.net','2022-09-18'),(20,'Price Woods','pede.cras@outlook.couk','2021-03-30');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viewed_time_type`
--

DROP TABLE IF EXISTS `viewed_time_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viewed_time_type` (
  `user_id` bigint unsigned NOT NULL,
  `film_id` bigint unsigned NOT NULL,
  `viewed_time` decimal(2,1) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `film_id` (`film_id`),
  CONSTRAINT `viewed_time_type_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `viewed_time_type_ibfk_2` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viewed_time_type`
--

LOCK TABLES `viewed_time_type` WRITE;
/*!40000 ALTER TABLE `viewed_time_type` DISABLE KEYS */;
INSERT INTO `viewed_time_type` VALUES (20,23,NULL),(20,23,NULL);
/*!40000 ALTER TABLE `viewed_time_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'kinopoisk'
--

--
-- Final view structure for view `favorit_films`
--

/*!50001 DROP VIEW IF EXISTS `favorit_films`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `favorit_films` AS select `f`.`name` AS `name` from ((`films` `f` join `user_collection` `uc` on(((`f`.`id` = `uc`.`film_id`) and (`f`.`age_limit` = 1)))) join `film_rating` `fr` on((`fr`.`film_id` = `f`.`id`))) group by `uc`.`film_id` order by `uc`.`film_id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `new_film`
--

/*!50001 DROP VIEW IF EXISTS `new_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `new_film` AS select `films`.`id` AS `id`,`films`.`name` AS `name` from (`films` join `user_library`) where `films`.`id` in (select `ul2`.`film_id` from `user_library` `ul2`) is false group by `films`.`id` order by `films`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-10 17:47:42
