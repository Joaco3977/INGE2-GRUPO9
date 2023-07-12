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
-- Table structure for table `campania`
--

DROP TABLE IF EXISTS `campania`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campania` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(45) NOT NULL,
  `DESCRIPCION` varchar(240) DEFAULT NULL,
  `MONTOESPERADO` int DEFAULT NULL,
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`NOMBRE`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  UNIQUE KEY `NOMBRE_UNIQUE` (`NOMBRE`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campania`
--

LOCK TABLES `campania` WRITE;
/*!40000 ALTER TABLE `campania` DISABLE KEYS */;
INSERT INTO `campania` VALUES (17,'Canes contentos','Comedor para perros en situacion de calle',800000,0),(18,'Proyecto 4 patas','ONG de rescate de perros callejeros',675000,0);
/*!40000 ALTER TABLE `campania` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `DNI` int NOT NULL,
  `NOMBREAPELLIDO` varchar(60) DEFAULT NULL,
  `MAIL` varchar(40) NOT NULL,
  `TELEFONO` varchar(20) DEFAULT NULL,
  `FECHAREGISTRO` date NOT NULL,
  `DIRECCION` varchar(70) DEFAULT NULL,
  `PASSWORD` varchar(30) NOT NULL,
  `MONTODESCUENTO` double DEFAULT '0',
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`DNI`,`MAIL`),
  UNIQUE KEY `DNI_UNIQUE` (`DNI`),
  UNIQUE KEY `MAIL_UNIQUE` (`MAIL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (31616621,'Raul Fernandez','cruza@gmail.com','2211567261','2023-07-12','51 789','cruza',0,0),(41987561,'Julia Saenz','julia@gmail.com','2215621322','2023-05-08','5 n719','julia',0,0),(43178686,'Joaquin Diez','JoaquinDiez3977@gmail.com','2352463977','2023-04-21','56 586 3ero 5to','cisco',0,0),(44522333,'Mauricio','mauricocella@gmail.com','2211413123','2023-05-10','58 235','abc123',0,0),(44893430,'Renzo Gigena','renzogigena1@gmail.com','2213176664','2023-05-08','5 y 80','123',0,0);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulta`
--

DROP TABLE IF EXISTS `consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulta` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PREGUNTA` varchar(255) NOT NULL,
  `RESPUESTA` varchar(255) DEFAULT NULL,
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulta`
--

LOCK TABLES `consulta` WRITE;
/*!40000 ALTER TABLE `consulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donaciones`
--

DROP TABLE IF EXISTS `donaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donaciones` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDCAMPANIA` int NOT NULL,
  `NOMBRECAMPANIA` varchar(100) NOT NULL,
  `FECHA` date DEFAULT NULL,
  `DNICLIENTE` int DEFAULT NULL,
  `CANTIDAD` int NOT NULL DEFAULT '0',
  `ESTADO` varchar(20) NOT NULL DEFAULT 'PENDIENTE',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donaciones`
--

LOCK TABLES `donaciones` WRITE;
/*!40000 ALTER TABLE `donaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `donaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historialperro`
--

DROP TABLE IF EXISTS `historialperro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historialperro` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDPERRO` int NOT NULL,
  `DNIVET` int NOT NULL,
  `FECHA` date NOT NULL,
  `NOMBRESERVICIO` varchar(60) NOT NULL,
  `COMENTARIO` varchar(400) DEFAULT NULL,
  `NOMBREVACUNA` varchar(60) DEFAULT NULL,
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historialperro`
--

LOCK TABLES `historialperro` WRITE;
/*!40000 ALTER TABLE `historialperro` DISABLE KEYS */;
INSERT INTO `historialperro` VALUES (8,35,43178686,'2023-06-12','Vacunación','Volver el 22/8/23 para control','Hepatitis canina',0);
/*!40000 ALTER TABLE `historialperro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listadovetsturno`
--

DROP TABLE IF EXISTS `listadovetsturno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `listadovetsturno` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(80) NOT NULL,
  `DIRECCION` varchar(80) NOT NULL,
  `FECHA` date NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listadovetsturno`
--

LOCK TABLES `listadovetsturno` WRITE;
/*!40000 ALTER TABLE `listadovetsturno` DISABLE KEYS */;
INSERT INTO `listadovetsturno` VALUES (13,'El Gran Danes','Calle 2 1650','2023-07-13'),(14,'OSPPA','Diagonal 78 791','2023-07-13'),(15,'Dejando Huellas','Calle 8 1470','2023-07-14'),(16,'Idiazur','Calle 12 1463','2023-07-14');
/*!40000 ALTER TABLE `listadovetsturno` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (105,'2023-06-08','[VETERINARIO 43178686 Joaquin Diez] -- edito al CLIENTE Mauricio con DNI: 44523451'),(106,'2023-06-08','[VETERINARIO 43178686 Joaquin Diez] -- agrego la campaña afaf con link: afaf'),(107,'2023-06-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego la campaña fafw con link: wfwafwaf'),(108,'2023-06-12','[VETERINARIO 43178686 Joaquin Diez] -- elimino la campaña fafw'),(109,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PASEADOR undefined'),(110,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521521'),(111,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521521'),(112,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521521'),(113,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- edito al PASEADOR 51521511'),(114,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521511'),(115,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521511'),(116,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521511'),(117,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521511'),(118,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521111'),(119,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- edito al PASEADOR 51521511'),(120,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521511'),(121,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- edito al PASEADOR 51521511'),(122,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521521'),(123,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- edito al PASEADOR 51521511'),(124,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- edito al PASEADOR 51521511'),(125,'2023-06-20','[VETERINARIO 43178686 ] -- agrego al PASEADOR undefined'),(126,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 24444222'),(127,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 24411111'),(128,'2023-06-20','[VETERINARIO 43178686 ] -- elimino al PASEADOR 24411111'),(129,'2023-06-20','[VETERINARIO 43178686 ] -- elimino al PASEADOR 51521511'),(130,'2023-06-20','[CLIENTE 43178686 Joaquin Diez] -- elimino a su propio PERRO Donna'),(131,'2023-06-20','[CLIENTE 43178686 Joaquin Diez] -- elimino a su propio PERRO Donna'),(132,'2023-06-20','[CLIENTE 43178686 Joaquin Diez] -- elimino a su propio PERRO Donna'),(133,'2023-06-21','[VETERINARIO 43178686 Joaquin Diez] -- edito al CLIENTE Joaquin Diez con DNI: 43178686'),(134,'2023-06-21','[VETERINARIO 43178686 Joaquin Diez] -- edito al CLIENTE Joaquin Diez con DNI: 43178686'),(135,'2023-06-21','[VETERINARIO 43178686 Joaquin Diez] -- edito al CLIENTE Joaquin Diez con DNI: 11111111'),(136,'2023-06-22','[VETERINARIO 43178686 Joaquin Diez] -- agrego la campaña PRUEBA con link: undefined'),(137,'2023-06-22','[VETERINARIO 43178686 ] -- edito la Donacion PRUEBA '),(138,'2023-06-22','[VETERINARIO 43178686 ] -- edito la Donacion PRUEBA '),(139,'2023-06-28','[VETERINARIO agrego al PERRO PERDIDO ADAD 43178686] -- undefined'),(140,'2023-06-28','[VETERINARIO agrego al PERRO PERDIDO prueba 43178686] -- undefined'),(141,'2023-06-28','[VETERINARIO 43178686 ADAD] -- elimino al PERRO PERDIDO ADAD del cliente 43178686'),(142,'2023-06-28','[VETERINARIO 43178686 prueba] -- elimino al PERRO PERDIDO prueba del cliente 43178686'),(143,'2023-06-28','[CLIENTE agrego al PERRO PERDIDO Fiona 43178686] -- undefined'),(144,'2023-06-28','[CLIENTE agrego al PERRO PERDIDO AD 43178686] -- undefined'),(145,'2023-06-28','[CLIENTE 43178686 AD] -- elimino al PERRO PERDIDO AD del cliente 43178686'),(146,'2023-07-06','[VETERINARIO 43178686 Joaquin Diez] -- agrego la campaña Canes contentos'),(147,'2023-07-06','[VETERINARIO agrego al PERRO PERDIDO ada 43178686] -- undefined'),(148,'2023-07-06','[VETERINARIO 43178686 ada] -- elimino al PERRO PERDIDO ada del cliente 43178686'),(149,'2023-07-06','[VETERINARIO agrego al PERRO PERDIDO ADAD 43178686] -- undefined'),(150,'2023-07-06','[VETERINARIO agrego al PERRO PERDIDO Jose 43178686] -- undefined'),(151,'2023-07-06','[VETERINARIO agrego al PERRO PERDIDO adawd 43178686] -- undefined'),(152,'2023-07-06','[VETERINARIO agrego al PERRO PERDIDO Manu 43178686] -- undefined'),(153,'2023-07-06','[VETERINARIO undefined undefined] -- undefined'),(154,'2023-07-06','[VETERINARIO undefined undefined] -- undefined'),(155,'2023-07-06','[CLIENTE undefined undefined] -- undefined'),(156,'2023-07-06','[VETERINARIO undefined undefined] -- undefined'),(157,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO Renzo 43178686] -- undefined'),(158,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO Radad 43178686] -- undefined'),(159,'2023-07-11','[CLIENTE 43178686 Radad] -- elimino al PERRO PERDIDO Radad del cliente 43178686'),(160,'2023-07-11','[CLIENTE 43178686 Renzo] -- elimino al PERRO PERDIDO Renzo del cliente 43178686'),(161,'2023-07-11','[CLIENTE 43178686 Manu] -- elimino al PERRO PERDIDO Manu del cliente 43178686'),(162,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO fa 43178686] -- undefined'),(163,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO ada 43178686] -- undefined'),(164,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO adad 43178686] -- undefined'),(165,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO adda 43178686] -- undefined'),(166,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO adad 43178686] -- undefined'),(167,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO gfasg 43178686] -- undefined'),(168,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO agagag 43178686] -- undefined'),(169,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO affaf 43178686] -- undefined'),(170,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO afaf 43178686] -- undefined'),(171,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO ahhahaha 43178686] -- undefined'),(172,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO hhjhhh 43178686] -- undefined'),(173,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO sadafaaf 43178686] -- undefined'),(174,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO ahhaah 43178686] -- undefined'),(175,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO LLLLLLLLLL 43178686] -- undefined'),(176,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO affafagagag 43178686] -- undefined'),(177,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO hhhhhh 43178686] -- undefined'),(178,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO hhhhhhjjsafafasffa 43178686] -- undefined'),(179,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO aaaaaaaaaaaa 43178686] -- undefined'),(180,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO zzzzzzzzzzzzz 43178686] -- undefined'),(181,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO kkkkk 43178686] -- undefined'),(182,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO aaaaaaaaaaaaaaa 43178686] -- undefined'),(183,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO ahhhhhh 43178686] -- undefined'),(184,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO lllllllllllllllllllllllllll 43178686] -- undefined'),(185,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO llllllllllllllllooooooo 43178686] -- undefined'),(186,'2023-07-11','[VETERINARIO agrego al PERRO PERDIDO Fido 43178686] -- undefined'),(187,'2023-07-11','[VETERINARIO agrego al PERRO PERDIDO Firulais 43178686] -- undefined'),(188,'2023-07-11','[VETERINARIO agrego al PERRO PERDIDO kkkdkakafkaf 43178686] -- undefined'),(189,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO aha 43178686] -- undefined'),(190,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO Firulais 43178686] -- undefined'),(191,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO hahhhhahhha 43178686] -- undefined'),(192,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO Fido 43178686] -- undefined'),(193,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO Firulais 43178686] -- undefined'),(194,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO AparezcoONo 43178686] -- undefined'),(195,'2023-07-11','[CLIENTE 43178686 AparezcoONo] -- elimino al PERRO PERDIDO AparezcoONo del cliente 43178686'),(196,'2023-07-11','[CLIENTE 43178686 Firulais] -- elimino al PERRO PERDIDO Firulais del cliente 43178686'),(197,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO ahhhahah 43178686] -- undefined'),(198,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO aggaggag 43178686] -- undefined'),(199,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO Fido 43178686] -- undefined'),(200,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO gag 43178686] -- undefined'),(201,'2023-07-11','[CLIENTE agrego al PERRO PERDIDO Facu 43178686] -- undefined'),(202,'2023-07-11','[CLIENTE 43178686 Facu] -- elimino al PERRO PERDIDO Facu del cliente 43178686'),(203,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Romualdo del cliente con DNI:43178686'),(204,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Romualdo del cliente con DNI:43178686'),(205,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Romualdo del cliente con DNI:44522333'),(206,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Romualdo del cliente con DNI:44522333'),(207,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Romualdo del cliente con DNI:44522333'),(208,'2023-07-12','[VETERINARIO 43178686 ] -- agrego al PERRO firulais del cliente con DNI:44522333'),(209,'2023-07-12','[VETERINARIO 43178686 ] -- agrego al PERRO Fido del cliente con DNI:44522333'),(210,'2023-07-12','[VETERINARIO 43178686 ] -- agrego al PERRO afafafff del cliente con DNI:44522333'),(211,'2023-07-12','[VETERINARIO 43178686 ] -- agrego al PERRO hhahaha del cliente con DNI:44522333'),(212,'2023-07-12','[VETERINARIO agrego al PERRO PERDIDO gagag 43178686] -- undefined'),(213,'2023-07-12','[VETERINARIO 43178686 gagag] -- elimino al PERRO PERDIDO gagag del cliente 43178686'),(214,'2023-07-12','[VETERINARIO 43178686 ] -- agrego al PERRO agagaga del cliente con DNI:44522333'),(215,'2023-07-12','[VETERINARIO 43178686 ] -- agrego al PERRO gagg del cliente con DNI:43178686'),(216,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO afgaafa del cliente con DNI:44522333'),(217,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO afafaf del cliente con DNI:44522333'),(218,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO afaaa del cliente con DNI:44522333'),(219,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Romualdo del cliente con DNI:44522333'),(220,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Romualdo del cliente con DNI:44522333'),(221,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Romualdo del cliente con DNI:44522333'),(222,'2023-07-12','[VETERINARIO agrego al PERRO PERDIDO gagagag 43178686] -- undefined'),(223,'2023-07-12','[VETERINARIO 43178686 gagagag] -- elimino al PERRO PERDIDO gagagag del cliente 43178686'),(224,'2023-07-12','[VETERINARIO agrego al PERRO PERDIDO Oso 43178686] -- undefined'),(225,'2023-07-12','[VETERINARIO 43178686 ] -- agrego al CLIENTE afag agag con DNI:55125115'),(226,'2023-07-12','[VETERINARIO 43178686 ] -- edito al CLIENTE editadoaga gagagg con DNI: 55125115'),(227,'2023-07-12','[VETERINARIO 43178686 ] -- edito al CLIENTE roberto afaf con DNI: 55125555'),(228,'2023-07-12','[VETERINARIO 43178686 ] -- elimino al CLIENTE 44522331'),(229,'2023-07-12','[VETERINARIO 43178686 ] -- edito al PASEADOR 32444731'),(230,'2023-07-12','[VETERINARIO 43178686 ] -- edito al PASEADOR 42042669'),(231,'2023-07-12','[VETERINARIO 43178686 ] -- edito al PASEADOR 42119021'),(232,'2023-07-12','[VETERINARIO 43178686 ] -- elimino al PASEADOR 2424332'),(233,'2023-07-12','[VETERINARIO 43178686 Juani] -- elimino al PERRO EN ADOPCION Juani del cliente 1'),(234,'2023-07-12','[VETERINARIO 43178686 ] -- agrego al PERRO EN ADOPCION '),(235,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Luz del cliente con DNI:44893430'),(236,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Princesa del cliente con DNI:44522333'),(237,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Rufo del cliente con DNI:41987561'),(238,'2023-07-12','[CLIENTE 43178686 Joaquin Diez] -- elimino a su propio PERRO Renzo'),(239,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Cleo del cliente con DNI:43178686'),(240,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Titi del cliente con DNI:43178686'),(241,'2023-07-12','[VETERINARIO agrego al PERRO PERDIDO Beto 43178686] -- undefined'),(242,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al CLIENTE Raul Fernandez con DNI:31616621'),(243,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Rocky del cliente con DNI:31616621'),(244,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Nemo del cliente con DNI:31616621'),(245,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Fideo del cliente con DNI:31616621'),(246,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Dumbo del cliente con DNI:31616621');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

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
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  `TELEFONO` varchar(45) NOT NULL,
  PRIMARY KEY (`DNI`),
  UNIQUE KEY `DNI_UNIQUE` (`DNI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paseador`
--

LOCK TABLES `paseador` WRITE;
/*!40000 ALTER TABLE `paseador` DISABLE KEYS */;
INSERT INTO `paseador` VALUES (32444731,'Roberto Tejas','RobertoTejas12771@gmail.com','Plaza Italia',NULL,'[[true, true, false], [false, false, false], [false, true, true], [true, true, false], [false, false, false], [false, true, true], [false, false, false]]',0,'221351526'),(42042669,'Julia Saenz','julia@gmail.com','Plaza Paso',NULL,'[[true, false, false], [false, true, false], [false, false, true], [true, false, false], [false, true, false], [false, false, true], [false, false, false]]',0,'221156224'),(42119021,'Renzo Gigena','renzogigena1@gmail.com','La Plata','Estaré contento de pasear a tus peluditos!','[[false, false, false], [false, false, false], [true, true, false], [true, true, false], [false, false, false], [true, true, false], [false, false, false]]',0,'2216789567');
/*!40000 ALTER TABLE `paseador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perro`
--

DROP TABLE IF EXISTS `perro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perro` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(30) NOT NULL,
  `TAMANIO` varchar(12) DEFAULT NULL,
  `COLOR` varchar(45) DEFAULT NULL,
  `NACIMIENTO` date DEFAULT NULL,
  `SEXO` varchar(10) DEFAULT NULL,
  `RAZA` varchar(45) DEFAULT NULL,
  `DNICLIENTE` int NOT NULL,
  `PESO` float DEFAULT NULL,
  `FOTO` tinyint NOT NULL DEFAULT '0',
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  `CRUZA` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perro`
--

LOCK TABLES `perro` WRITE;
/*!40000 ALTER TABLE `perro` DISABLE KEYS */;
INSERT INTO `perro` VALUES (1,'Donna','Mediano','Marron y Negro','2019-12-21','Hembra','Mestizo',43178686,27.4,1,0,0),(35,'Luz','Mediano','Negro y marron','2014-06-04','Hembra','Mestizo',44893430,35.2,1,0,1),(36,'Princesa','Grande','Marron y Blanco','2021-05-19','Hembra','Pitbull',44522333,54.7,1,0,1),(37,'Rufo','Grande','Negro y Marron','2020-10-22','Macho','Pastor Aleman',41987561,43.7,1,0,0),(38,'Cleo','Mediano','Negro','2009-09-04','Hembra','Mestizo',43178686,24.8,1,0,1),(39,'Titi','Pequeño','Blanco','2008-05-22','Hembra','Mestizo',43178686,14.7,1,0,1),(40,'Rocky','Mediano','Marron claro y Blanco','2021-03-18','Macho','Pitbull',31616621,35.2,1,0,1),(41,'Nemo','Grande','Blanco y Marron','2019-07-17','Macho','Pitbull',31616621,39.2,1,0,1),(42,'Fideo','Mediano','Negro y Blanco','2017-08-18','Macho','Mestizo',31616621,19.6,1,0,1),(43,'Dumbo','Pequeño','Marron claro','2020-02-12','Macho','Mestizo',31616621,13.9,1,0,1);
/*!40000 ALTER TABLE `perro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perroadopcion`
--

DROP TABLE IF EXISTS `perroadopcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perroadopcion` (
  `IDPERROADOPCION` int NOT NULL AUTO_INCREMENT,
  `SEXO` varchar(6) NOT NULL,
  `TAMANIO` varchar(45) DEFAULT NULL,
  `EDAD` varchar(45) DEFAULT NULL,
  `TELEFONO` varchar(25) NOT NULL,
  `NOMBRE` varchar(45) DEFAULT NULL,
  `MAIL` varchar(45) DEFAULT NULL,
  `COMENTARIO` varchar(200) DEFAULT NULL,
  `DNICLIENTE` int NOT NULL,
  `ADOPTADO` tinyint NOT NULL DEFAULT '0',
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`IDPERROADOPCION`),
  UNIQUE KEY `IDPERROADOPCION_UNIQUE` (`IDPERROADOPCION`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perroadopcion`
--

LOCK TABLES `perroadopcion` WRITE;
/*!40000 ALTER TABLE `perroadopcion` DISABLE KEYS */;
INSERT INTO `perroadopcion` VALUES (2,'Macho','Grande','23','1212315352','Rocco','julio24@gmail.com','Me mude y no tengo espacio! Es un excelente perro',30987560,0,0),(3,'Macho','Pequeño','2','3242321313','Capitan','renzo@gmail.com','Cachorro muy jugueton',32678901,0,0),(4,'Hembra','Mediano','96','324234123','Luz','renzo@gmail.com','Gordita hermosa',42190651,0,0),(234,'Macho','Mediano','24','0','','JoaquinDiez3977@gmail.com','Callejero rescatado',43178686,0,0);
/*!40000 ALTER TABLE `perroadopcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perrocruza`
--

DROP TABLE IF EXISTS `perrocruza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perrocruza` (
  `ID` int NOT NULL,
  `NOMBRE` varchar(45) NOT NULL,
  `FOTO` blob,
  `RAZA` varchar(45) DEFAULT NULL,
  `COLOR` varchar(45) DEFAULT NULL,
  `NACIMIENTO` date DEFAULT NULL,
  `SEXO` varchar(10) DEFAULT NULL,
  `FECHACELO` date DEFAULT NULL,
  `TAMANIO` varchar(10) DEFAULT NULL,
  `COMENTARIO` varchar(200) DEFAULT NULL,
  `DNICLIENTE` int NOT NULL,
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perrocruza`
--

LOCK TABLES `perrocruza` WRITE;
/*!40000 ALTER TABLE `perrocruza` DISABLE KEYS */;
/*!40000 ALTER TABLE `perrocruza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perroperdido`
--

DROP TABLE IF EXISTS `perroperdido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perroperdido` (
  `IDPERROPERDIDO` int NOT NULL AUTO_INCREMENT,
  `TELEFONO` varchar(25) NOT NULL,
  `NOMBRE` varchar(45) DEFAULT NULL,
  `MAIL` varchar(45) DEFAULT NULL,
  `COMENTARIO` varchar(300) NOT NULL,
  `DNICLIENTE` varchar(45) NOT NULL,
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  `SEXO` varchar(6) NOT NULL,
  `ENCONTRADO` tinyint NOT NULL DEFAULT '0',
  `ZONA` varchar(60) NOT NULL,
  `FECHAPERDIDA` date NOT NULL,
  PRIMARY KEY (`IDPERROPERDIDO`),
  UNIQUE KEY `IDPERROPERDIDO_UNIQUE` (`IDPERROPERDIDO`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perroperdido`
--

LOCK TABLES `perroperdido` WRITE;
/*!40000 ALTER TABLE `perroperdido` DISABLE KEYS */;
INSERT INTO `perroperdido` VALUES (52,'2214521261','Oso','JoaVet@gmail.com','Se ofrece recompensa','43178686',0,'Macho',0,'Plaza Italia','2023-06-22'),(53,'2215678989','Beto','JoaVet@gmail.com','','43178686',0,'Macho',0,'Catedral','2022-07-31');
/*!40000 ALTER TABLE `perroperdido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sesion`
--

DROP TABLE IF EXISTS `sesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sesion` (
  `TOKEN` varchar(45) NOT NULL,
  `MAIL` varchar(45) NOT NULL,
  `DNI` int NOT NULL,
  `ROL` int DEFAULT NULL,
  PRIMARY KEY (`TOKEN`,`MAIL`,`DNI`),
  UNIQUE KEY `TOKEN_UNIQUE` (`TOKEN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesion`
--

LOCK TABLES `sesion` WRITE;
/*!40000 ALTER TABLE `sesion` DISABLE KEYS */;
INSERT INTO `sesion` VALUES ('f9e74f6e-3097-4ac8-9ec6-3ec6c098efec','JoaquinDiez3977@gmail.com',43178686,1);
/*!40000 ALTER TABLE `sesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turno`
--

DROP TABLE IF EXISTS `turno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turno` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDPERRO` int NOT NULL,
  `DNIVETERINARIO` int DEFAULT NULL,
  `DNICLIENTE` int NOT NULL,
  `FECHA` date NOT NULL,
  `ESTADO` varchar(20) NOT NULL,
  `NOMBREVACUNA` varchar(45) DEFAULT NULL,
  `NOMBREPERRO` varchar(45) NOT NULL,
  `NOMBRESERVICIO` varchar(200) NOT NULL,
  `NOMBREVETERINARIO` varchar(60) DEFAULT NULL,
  `NOMBRECLIENTE` varchar(60) DEFAULT NULL,
  `FRANJAHORARIA` varchar(10) DEFAULT NULL,
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno`
--

LOCK TABLES `turno` WRITE;
/*!40000 ALTER TABLE `turno` DISABLE KEYS */;
INSERT INTO `turno` VALUES (33,35,43178686,44893430,'2023-07-19','Confirmado',NULL,'Luz','Consulta','Joaquin Diez','','Tarde',0),(34,35,NULL,44893430,'2023-07-30','Pendiente',NULL,'Luz','Desparacitación',NULL,'',NULL,0);
/*!40000 ALTER TABLE `turno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vacuna`
--

DROP TABLE IF EXISTS `vacuna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vacuna` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(45) NOT NULL,
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`NOMBRE`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  UNIQUE KEY `NOMBRE_UNIQUE` (`NOMBRE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacuna`
--

LOCK TABLES `vacuna` WRITE;
/*!40000 ALTER TABLE `vacuna` DISABLE KEYS */;
/*!40000 ALTER TABLE `vacuna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veterinaria`
--

DROP TABLE IF EXISTS `veterinaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veterinaria` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(45) NOT NULL,
  `DIRECCION` varchar(60) NOT NULL,
  PRIMARY KEY (`ID`,`NOMBRE`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  UNIQUE KEY `NOMBRE_UNIQUE` (`NOMBRE`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinaria`
--

LOCK TABLES `veterinaria` WRITE;
/*!40000 ALTER TABLE `veterinaria` DISABLE KEYS */;
INSERT INTO `veterinaria` VALUES (11,'Katua','Diagonal 79 1049'),(12,'Idiazur','Calle 12 1463'),(13,'Nutrivet','Calle 5 1450'),(14,'Dejando Huellas','Calle 8 1470'),(15,'Fuco\'s','Calle 3 esquina 63'),(16,'OSPPA','Diagonal 78 791'),(17,'El Gran Danes','Calle 2 1650');
/*!40000 ALTER TABLE `veterinaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veterinario`
--

DROP TABLE IF EXISTS `veterinario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veterinario` (
  `DNI` int NOT NULL,
  `NOMBREAPELLIDO` varchar(45) DEFAULT NULL,
  `MAIL` varchar(45) NOT NULL,
  `PASSWORD` varchar(45) DEFAULT NULL,
  `TELEFONO` varchar(20) DEFAULT NULL,
  `FECHAREGISTRO` date DEFAULT NULL,
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`DNI`,`MAIL`),
  UNIQUE KEY `DNI_UNIQUE` (`DNI`),
  UNIQUE KEY `MAIL_UNIQUE` (`MAIL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinario`
--

LOCK TABLES `veterinario` WRITE;
/*!40000 ALTER TABLE `veterinario` DISABLE KEYS */;
INSERT INTO `veterinario` VALUES (5,'Renzo Vet','renzovet@gmail.com','123','221786767','2023-05-08',0),(6,'Pedro Pulgas','pedro@gmail.com','pulgas','221147687','2023-05-08',0),(43178686,'Joaquin Diez','JoaVet@gmail.com','cisco','2352463977','2023-04-28',0),(44456456,'Mauricio Cella','ren.sabee@gmail.com','5pDUFmX8sC','(547) 656 - 4734','2023-05-11',0);
/*!40000 ALTER TABLE `veterinario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-12 16:27:14
