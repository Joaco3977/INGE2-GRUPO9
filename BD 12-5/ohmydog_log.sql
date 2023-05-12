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
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `FECHA` date NOT NULL,
  `DESCRIPCION` varchar(120) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'2023-05-12','VETERINARIO 43178686 -- SOLICITO CLIENTES'),(2,'2023-05-12','[VETERINARIO 43178686] -- SOLICITO CLIENTES'),(3,'2023-05-12','[VETERINARIO 43178686] -- SOLICITO CLIENTES'),(4,'2023-05-12','[VETERINARIO 43178686] -- agrego al PASEADOR 12414'),(5,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION adad del cliente 1241'),(6,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION eliminar'),(7,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION eliminar del cliente 43178686'),(8,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION daelaead'),(9,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION daelaead del cliente 43178686'),(10,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION 14124sdad'),(11,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION 14124sdad del cliente 43178686'),(12,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION add'),(13,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION add del cliente 43178686'),(14,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION eliminar'),(15,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION daelaead'),(16,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION eliminar'),(17,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION 14124sdad'),(18,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION eliminar'),(19,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION add'),(20,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION daelaead del cliente 43178686'),(21,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION eliminar del cliente 43178686'),(22,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION add del cliente 43178686'),(23,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION 14124sdad del cliente 43178686'),(24,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION eliminar'),(25,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION eliminar del cliente 43178686'),(26,'2023-05-12','[VETERINARIO 43178686] -- agrego al PASEADOR undefined'),(27,'2023-05-12','[VETERINARIO 43178686] -- elimino al PASEADOR 45241414'),(28,'2023-05-12','[VETERINARIO 43178686] -- agrego al PASEADOR undefined'),(29,'2023-05-12','[VETERINARIO 43178686] -- elimino al PASEADOR 2144141'),(30,'2023-05-12','[VETERINARIO 43178686] -- agrego al PASEADOR undefined'),(31,'2023-05-12','[VETERINARIO 43178686] -- elimino al PASEADOR 124441');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
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
