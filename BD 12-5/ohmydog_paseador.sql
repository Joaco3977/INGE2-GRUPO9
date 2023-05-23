-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ohmydog
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `paseador`
--

DROP TABLE IF EXISTS `paseador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paseador` (
  `DNI` int NOT NULL,
  `NOMBREAPELLIDO` varchar(45) NOT NULL,
  `MAIL` varchar(60) NOT NULL,
  `ZONA` varchar(45) DEFAULT NULL,
  `COMENTARIO` varchar(200) DEFAULT NULL,
  `DISPONIBILIDAD` json DEFAULT NULL,
  PRIMARY KEY (`DNI`,`MAIL`),
  UNIQUE KEY `DNI_UNIQUE` (`DNI`),
  UNIQUE KEY `MAIL_UNIQUE` (`MAIL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paseador`
--

LOCK TABLES `paseador` WRITE;
/*!40000 ALTER TABLE `paseador` DISABLE KEYS */;
INSERT INTO `paseador` VALUES (34031120,'Camila Ramirez','CamiRamirez98@gmail.com','Catedral','Hola soy Camila',NULL),(37890167,'Juan Martin Gutierrez','JuanMa18@yahoo.com','Plaza Yrigoyen','Buenas soy Juanma!',NULL),(37890876,'Damian Flores','DamianSape@yahoo.com','Plaza Italia','Hola soy Damian',NULL);
/*!40000 ALTER TABLE `paseador` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-12 12:58:54