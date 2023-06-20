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
  `LINK` varchar(60) NOT NULL,
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`NOMBRE`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  UNIQUE KEY `NOMBRE_UNIQUE` (`NOMBRE`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campania`
--

LOCK TABLES `campania` WRITE;
/*!40000 ALTER TABLE `campania` DISABLE KEYS */;
INSERT INTO `campania` VALUES (10,'prueba','ada','ada',1),(11,'afaf','afaf','afaf',0),(12,'fafw','fwfwafwafw','wfwafwaf',1);
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
INSERT INTO `cliente` VALUES (1,'Julia Saenz','julia@gmail.com','2215621322','2023-05-08','5 n719','julia',0,0),(2,'Renzo Gigena','renzogigena1@gmail.com','2213176664','2023-05-08','5 y 80','123',0,0),(12511514,'Kakaka','214@aa.com','12414141','2023-06-07','41414','cxq6Qmv4Xi',0,1),(43178686,'Joaquin Diez','JoaquinDiez3977@gmail.com','2352463977','2023-04-21','56 586 3ero 5to','cisco',0,0),(44522333,'Mauricio','mauricocella@gmail.com','5656546','2023-05-10','Dkfjsj','KvlKAyVu9R',0,0);
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
-- Table structure for table `historial`
--

DROP TABLE IF EXISTS `historial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial` (
  `ID` int NOT NULL,
  `IDPERRO` int NOT NULL,
  `DNICLIENTE` int NOT NULL,
  `NOMBRE` varchar(45) NOT NULL,
  `FECHA` date NOT NULL,
  `DESCRIPCION` varchar(240) NOT NULL,
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial`
--

LOCK TABLES `historial` WRITE;
/*!40000 ALTER TABLE `historial` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historialperro`
--

LOCK TABLES `historialperro` WRITE;
/*!40000 ALTER TABLE `historialperro` DISABLE KEYS */;
/*!40000 ALTER TABLE `historialperro` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (105,'2023-06-08','[VETERINARIO 43178686 Joaquin Diez] -- edito al CLIENTE Mauricio con DNI: 44523451'),(106,'2023-06-08','[VETERINARIO 43178686 Joaquin Diez] -- agrego la campaña afaf con link: afaf'),(107,'2023-06-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego la campaña fafw con link: wfwafwaf'),(108,'2023-06-12','[VETERINARIO 43178686 Joaquin Diez] -- elimino la campaña fafw'),(109,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PASEADOR undefined'),(110,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521521'),(111,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521521'),(112,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521521'),(113,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- edito al PASEADOR 51521511'),(114,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521511'),(115,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521511'),(116,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521511'),(117,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521511'),(118,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521111'),(119,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- edito al PASEADOR 51521511'),(120,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521511'),(121,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- edito al PASEADOR 51521511'),(122,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 51521521'),(123,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- edito al PASEADOR 51521511'),(124,'2023-06-20','[VETERINARIO 43178686 Joaquin Diez] -- edito al PASEADOR 51521511'),(125,'2023-06-20','[VETERINARIO 43178686 ] -- agrego al PASEADOR undefined'),(126,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 24444222'),(127,'2023-06-20','[VETERINARIO 43178686 ] -- edito al PASEADOR 24411111'),(128,'2023-06-20','[VETERINARIO 43178686 ] -- elimino al PASEADOR 24411111'),(129,'2023-06-20','[VETERINARIO 43178686 ] -- elimino al PASEADOR 51521511');
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
INSERT INTO `paseador` VALUES (2,'ju','j@adada','mi casita',NULL,'[[false, false, false], [false, false, false], [false, false, false], [false, false, false], [false, false, false], [false, false, false], [true, false, false]]',0,''),(2424332,'ju','dsa@gmail.com','darear','ewqewqaddads addasd adajdasd alndal fr','[[true, false, false], [false, false, false], [false, false, false], [false, false, false], [false, false, false], [false, true, true], [false, false, false]]',0,''),(42042669,'Julia Saenz','julia@gmail.com','Plaza Paso',NULL,'[[true, false, false], [false, true, false], [false, false, true], [true, false, false], [false, true, false], [false, false, true], [false, false, false]]',0,''),(42119021,'Renzo Gigena','renzogigena1@gmail.com','La Plata','','[[false, false, false], [true, false, false], [false, true, false], [false, true, true], [false, false, false], [false, true, true], [false, true, false]]',0,'');
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
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perro`
--

LOCK TABLES `perro` WRITE;
/*!40000 ALTER TABLE `perro` DISABLE KEYS */;
INSERT INTO `perro` VALUES (1,'Donna','Mediano','Marron y Negro','2019-12-21','Hembra','Mestizo',43178686,27.4,0,0),(2,'Princesa','Mediano','Gris','2020-06-17','Hembra','Pitbull',2,35.7,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perroadopcion`
--

LOCK TABLES `perroadopcion` WRITE;
/*!40000 ALTER TABLE `perroadopcion` DISABLE KEYS */;
INSERT INTO `perroadopcion` VALUES (2,'Macho','Grande','23','1212315352','Rocco','julio24@gmail.com','Me mude y no tengo espacio! Es un excelente perro',30987560,0,0),(3,'Macho','Pequeño','2','3242321313','Capitan','renzo@gmail.com','Cachorro muy jugueton',32678901,0,0),(4,'Hembra','Mediano','96','324234123','Luz','renzo@gmail.com','Gordita hermosa',42190651,0,0),(230,'Macho','Grande','36','2215622333','Juani','julia@gmail.com','habla un montón, se porta mal, saquenlo',1,1,0),(233,'Macho','Grande','24','0','Rufo','Aafwf@afafw.com','',43178686,0,1);
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
  `IDPERROPERDIDO` int NOT NULL,
  `FOTO` blob,
  `TAMANIO` varchar(45) DEFAULT NULL,
  `EDAD` varchar(45) DEFAULT NULL,
  `TELEFONO` varchar(25) NOT NULL,
  `NOMBRE` varchar(45) DEFAULT NULL,
  `MAIL` varchar(45) DEFAULT NULL,
  `COMENTARIO` varchar(300) NOT NULL,
  `DNICLIENTE` varchar(45) NOT NULL,
  `ELIMINADO` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`IDPERROPERDIDO`),
  UNIQUE KEY `IDPERROPERDIDO_UNIQUE` (`IDPERROPERDIDO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perroperdido`
--

LOCK TABLES `perroperdido` WRITE;
/*!40000 ALTER TABLE `perroperdido` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno`
--

LOCK TABLES `turno` WRITE;
/*!40000 ALTER TABLE `turno` DISABLE KEYS */;
INSERT INTO `turno` VALUES (16,1,43178686,43178686,'2023-08-24','Cancelado',NULL,'Donna','Consulta','Joaquin Diez','Joaquin Diez','Tarde',0),(17,1,NULL,43178686,'2024-06-13','Cancelado',NULL,'Donna','Desparacitación',NULL,'Joaquin Diez',NULL,0),(18,1,43178686,43178686,'2023-07-13','Cancelado',NULL,'Donna','Desparacitación','Joaquin Diez','Joaquin Diez','Mañana',0),(19,1,NULL,43178686,'2023-07-20','Cancelado','Moquillo','Donna','Vacunación',NULL,'Joaquin Diez',NULL,0),(20,1,43178686,43178686,'2023-06-22','Cancelado',NULL,'Donna','Desparacitación','Joaquin Diez','Joaquin Diez','Tarde',0),(21,1,43178686,43178686,'2023-06-15','Cancelado',NULL,'Donna','Desparacitación','Joaquin Diez','Joaquin Diez','Noche',0),(22,1,43178686,43178686,'2023-06-23','Cancelado',NULL,'Donna','Castración','Joaquin Diez','Joaquin Diez','Noche',0),(23,1,43178686,43178686,'2023-06-21','Cancelado',NULL,'Donna','Castración','Joaquin Diez','Joaquin Diez','Noche',0),(24,1,43178686,43178686,'2023-06-23','Cancelado','Hepatitis canina','Donna','Vacunación','Joaquin Diez','Joaquin Diez','Noche',0),(25,1,43178686,43178686,'2023-06-22','Cancelado',NULL,'Donna','Desparacitación','Joaquin Diez','Joaquin Diez','Noche',0),(26,1,43178686,43178686,'2023-06-23','Confirmado','Moquillo','Donna','Vacunación','Joaquin Diez','Joaquin Diez','Tarde',0),(27,1,43178686,43178686,'2023-06-21','Confirmado','Moquillo','Donna','Vacunación','Joaquin Diez','Joaquin Diez','Noche',0),(28,1,NULL,43178686,'2023-06-30','Cancelado',NULL,'Donna','Consulta',NULL,'Joaquin Diez',NULL,0),(29,1,NULL,43178686,'2023-06-27','Cancelado',NULL,'Donna','Consulta',NULL,'Joaquin Diez',NULL,0),(30,1,NULL,43178686,'2023-06-22','Cancelado',NULL,'Donna','Desparacitación',NULL,'Joaquin Diez',NULL,0);
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
  `ID` int NOT NULL,
  `NOMBRE` varchar(45) NOT NULL,
  `DIRECCION` varchar(60) NOT NULL,
  `COMENTARIO` varchar(200) DEFAULT NULL,
  `ELIMINADO` varchar(45) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`NOMBRE`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  UNIQUE KEY `NOMBRE_UNIQUE` (`NOMBRE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinaria`
--

LOCK TABLES `veterinaria` WRITE;
/*!40000 ALTER TABLE `veterinaria` DISABLE KEYS */;
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

-- Dump completed on 2023-06-20 18:26:08
