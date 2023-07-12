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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campania`
--

LOCK TABLES `campania` WRITE;
/*!40000 ALTER TABLE `campania` DISABLE KEYS */;
INSERT INTO `campania` VALUES (17,'Canes contentos','Comedor para perros en situacion de calle',800000,0),(18,'Proyecto 4 patas','ONG de rescate de perros callejeros',675000,0),(19,'El Campito','Refugio para perros sin hogar',520000,0);
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
INSERT INTO `cliente` VALUES (31616621,'Raul Fernandez','cruza@gmail.com','2211567261','2023-07-12','51 789','cruza',0,0),(41987561,'Julia Saenz','julia@gmail.com','2215621322','2023-05-08','5 n719','julia',0,0),(42120860,'Micaela Gonzalez','MicaGonzalez16161616@gmail.com','2217789124564','2023-07-12','36 878','9R0ahRFFfn',0,0),(43178686,'Joaquin Diez','JoaquinDiez3977@gmail.com','2352463977','2023-04-21','56 586 3ero 5to','cisco',1820,0),(44522333,'Mauricio','mauricocella@gmail.com','2211413123','2023-05-10','58 235','abc123',0,0),(44893430,'Renzo Gigena','renzogigena1@gmail.com','2213176664','2023-05-08','5 y 80','123',0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donaciones`
--

LOCK TABLES `donaciones` WRITE;
/*!40000 ALTER TABLE `donaciones` DISABLE KEYS */;
INSERT INTO `donaciones` VALUES (7,17,'Canes contentos','2023-07-12',43178686,18200,'PENDIENTE'),(8,18,'Proyecto 4 patas','2023-07-12',NULL,7000,'PENDIENTE');
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
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (249,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al CLIENTE Micaela Gonzalez con DNI:42120847'),(250,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Hachicko del cliente con DNI:42120847'),(251,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- agrego al PERRO Golfo del cliente con DNI:42120847'),(252,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- edito al CLIENTE Micaela Gonzalez con DNI: 42120847'),(253,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- edito al PERRO Hachickod del CLIENTE con DNI: 42120860'),(254,'2023-07-12','[VETERINARIO 43178686 Joaquin Diez] -- edito al PERRO Hachicko del CLIENTE con DNI: 42120860'),(255,'2023-07-12','[VETERINARIO 43178686 ] -- agrego al PERRO Beethoven del cliente con DNI:44893430'),(256,'2023-07-12','[VETERINARIO 43178686 ] -- agrego al PERRO Welfo del cliente con DNI:44893430');
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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perro`
--

LOCK TABLES `perro` WRITE;
/*!40000 ALTER TABLE `perro` DISABLE KEYS */;
INSERT INTO `perro` VALUES (1,'Donna','Mediano','Marron y Negro','2019-12-21','Hembra','Mestizo',43178686,27.4,1,0,0),(35,'Luz','Mediano','Negro y marron','2014-06-04','Hembra','Mestizo',44893430,35.2,1,0,1),(36,'Princesa','Grande','Marron y Blanco','2021-05-19','Hembra','Pitbull',44522333,54.7,1,0,1),(37,'Rufo','Grande','Negro y Marron','2020-10-22','Macho','Pastor Aleman',41987561,43.7,1,0,0),(38,'Cleo','Mediano','Negro','2009-09-04','Hembra','Mestizo',43178686,24.8,1,0,1),(39,'Titi','Pequeño','Blanco','2008-05-22','Hembra','Mestizo',43178686,14.7,1,0,1),(40,'Rocky','Mediano','Marron claro y Blanco','2021-03-18','Macho','Pitbull',31616621,35.2,1,0,1),(41,'Nemo','Grande','Blanco y Marron','2019-07-17','Macho','Pitbull',31616621,39.2,1,0,1),(42,'Fideo','Mediano','Negro y Blanco','2017-08-18','Macho','Mestizo',31616621,19.6,1,0,1),(43,'Dumbo','Pequeño','Marron claro','2020-02-12','Macho','Mestizo',31616621,13.9,1,0,1),(44,'Hachicko','Mediano','Dorado claro','2019-12-18','Macho','Golden',42120860,31.3,0,0,0),(45,'Golfo','Mediano','Dorado claro','2020-12-17','Macho','Golden',42120860,34.5,1,0,0),(46,'Beethoven','Pequeño','Marron claro Blanco y Negro','2023-04-06','Macho','San Bernardo',44893430,12.7,1,0,0),(47,'Welfo','Mediano','Marron atigrado','2016-10-12','Macho','Mestizo',44893430,24.9,1,0,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perroperdido`
--

LOCK TABLES `perroperdido` WRITE;
/*!40000 ALTER TABLE `perroperdido` DISABLE KEYS */;
INSERT INTO `perroperdido` VALUES (52,'2214521261','Oso','JoaVet@gmail.com','Se ofrece recompensa','43178686',0,'Macho',0,'Plaza Italia','2023-06-22'),(53,'2215678989','Beto','JoaVet@gmail.com','','43178686',0,'Macho',0,'Catedral','2022-07-31'),(54,'2352463977','Odin','renzogigena1@gmail.com','Responde a su nombre','44893430',0,'Macho',0,'Parque Savedra','2023-07-12');
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
INSERT INTO `sesion` VALUES ('c90192b0-f03e-4171-8603-49120ba75f28','JoaquinDiez3977@gmail.com',43178686,1);
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

-- Dump completed on 2023-07-12 20:43:58
