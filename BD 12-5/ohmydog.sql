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
  `ID` int NOT NULL,
  `NOMBRE` varchar(45) NOT NULL,
  `DESCRIPCION` varchar(240) DEFAULT NULL,
  `LINK` varchar(60) NOT NULL,
  PRIMARY KEY (`ID`,`NOMBRE`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  UNIQUE KEY `NOMBRE_UNIQUE` (`NOMBRE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campania`
--

LOCK TABLES `campania` WRITE;
/*!40000 ALTER TABLE `campania` DISABLE KEYS */;
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
INSERT INTO `cliente` VALUES (1,'Julia Saenz','julia@gmail.com','2215621322','2023-05-08','5 n719','julia',0),(2,'Renzo Gigena','renzogigena1@gmail.com','2213176664','2023-05-08','5 y 80','123',0),(4458888,'Mauricio','mauricocella@gmail.com','5656546','2023-05-10','Dkfjsj','KvlKAyVu9R',0),(43178686,'Joaquin Diez','JoaquinDiez3977@gmail.com','2352463977','2023-04-21','56 586 3ero 5to','cisco',0),(44130440,'Manuel Rubiano','manurubiano@hotmail.com','(221) 608 - 2268','2023-05-11','82 n363','ehRkiNpnUX',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'2023-05-12','VETERINARIO 43178686 -- SOLICITO CLIENTES'),(2,'2023-05-12','[VETERINARIO 43178686] -- SOLICITO CLIENTES'),(3,'2023-05-12','[VETERINARIO 43178686] -- SOLICITO CLIENTES'),(4,'2023-05-12','[VETERINARIO 43178686] -- agrego al PASEADOR 12414'),(5,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION adad del cliente 1241'),(6,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION eliminar'),(7,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION eliminar del cliente 43178686'),(8,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION daelaead'),(9,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION daelaead del cliente 43178686'),(10,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION 14124sdad'),(11,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION 14124sdad del cliente 43178686'),(12,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION add'),(13,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION add del cliente 43178686'),(14,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION eliminar'),(15,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION daelaead'),(16,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION eliminar'),(17,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION 14124sdad'),(18,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION eliminar'),(19,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION add'),(20,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION daelaead del cliente 43178686'),(21,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION eliminar del cliente 43178686'),(22,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION add del cliente 43178686'),(23,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION 14124sdad del cliente 43178686'),(24,'2023-05-12','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION eliminar'),(25,'2023-05-12','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION eliminar del cliente 43178686'),(26,'2023-05-12','[VETERINARIO 43178686] -- agrego al PASEADOR undefined'),(27,'2023-05-12','[VETERINARIO 43178686] -- elimino al PASEADOR 45241414'),(28,'2023-05-12','[VETERINARIO 43178686] -- agrego al PASEADOR undefined'),(29,'2023-05-12','[VETERINARIO 43178686] -- elimino al PASEADOR 2144141'),(30,'2023-05-12','[VETERINARIO 43178686] -- agrego al PASEADOR undefined'),(31,'2023-05-12','[VETERINARIO 43178686] -- elimino al PASEADOR 124441'),(32,'2023-05-16','[CLIENTE 1] -- agrego al PERRO EN ADOPCION Rocco'),(33,'2023-05-16','[CLIENTE 1] -- elimino al PERRO EN ADOPCION Rocco del cliente 1'),(34,'2023-05-16','[CLIENTE 1] -- agrego al PERRO EN ADOPCION Rocco'),(35,'2023-05-17','[CLIENTE 1] -- elimino al PERRO EN ADOPCION Rocco del cliente 1'),(36,'2023-05-17','[CLIENTE 1] -- agrego al PERRO EN ADOPCION Rocco'),(37,'2023-05-17','[CLIENTE 1] -- elimino al PERRO EN ADOPCION Rocco del cliente 1'),(38,'2023-05-17','[CLIENTE 1] -- agrego al PERRO EN ADOPCION fsd43'),(39,'2023-05-17','[CLIENTE 1] -- agrego al PERRO EN ADOPCION julia'),(40,'2023-05-17','[CLIENTE 1] -- agrego al PERRO EN ADOPCION julis'),(41,'2023-05-17','[CLIENTE 1] -- elimino al PERRO EN ADOPCION fsd43 del cliente 1'),(42,'2023-05-17','[CLIENTE 1] -- elimino al PERRO EN ADOPCION julia del cliente 1'),(43,'2023-05-17','[CLIENTE 1] -- elimino al PERRO EN ADOPCION julis del cliente 1'),(44,'2023-05-17','[CLIENTE 1] -- agrego al PERRO EN ADOPCION Julia'),(45,'2023-05-17','[CLIENTE 1] -- elimino al PERRO EN ADOPCION Julia del cliente 1'),(46,'2023-05-17','[VETERINARIO 6] -- agrego al PASEADOR undefined'),(47,'2023-05-17','[VETERINARIO 6] -- elimino al PASEADOR 34031120'),(48,'2023-05-17','[VETERINARIO 6] -- elimino al PASEADOR 37890167'),(49,'2023-05-17','[VETERINARIO 6] -- elimino al PASEADOR 37890876'),(50,'2023-05-17','[VETERINARIO 6] -- elimino al PASEADOR 42042669'),(51,'2023-05-17','[VETERINARIO 6] -- agrego al PASEADOR undefined'),(52,'2023-05-17','[VETERINARIO 6] -- agrego al PASEADOR undefined'),(53,'2023-05-17','[VETERINARIO 6] -- agrego al PASEADOR undefined'),(54,'2023-05-17','[CLIENTE 1] -- agrego al PERRO EN ADOPCION Juani'),(55,'2023-05-18','[VETERINARIO 43178686] -- agrego al PERRO EN ADOPCION Quien'),(56,'2023-05-18','[VETERINARIO 43178686] -- elimino al PERRO EN ADOPCION Quien del cliente 43178686'),(57,'2023-05-18','[VETERINARIO 43178686] -- elimino al cliente 1234567'),(58,'2023-05-18','[VETERINARIO 5] -- elimino al cliente 546546');
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
INSERT INTO `paseador` VALUES (2,'ju','j@adada','mi casita',NULL,'[[false, false, false], [false, false, false], [false, false, false], [false, false, false], [false, false, false], [false, false, false], [true, false, false]]'),(2424332,'ju','dsa@gmail.com','darear','ewqewqaddads addasd adajdasd alndal fr','[[true, false, false], [false, false, false], [false, false, false], [false, false, false], [false, false, false], [false, true, true], [false, false, false]]'),(42042669,'Julia Saenz','julia@gmail.com','Plaza Paso',NULL,'[[true, false, false], [false, true, false], [false, false, true], [true, false, false], [false, true, false], [false, false, true], [false, false, false]]');
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
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perro`
--

LOCK TABLES `perro` WRITE;
/*!40000 ALTER TABLE `perro` DISABLE KEYS */;
INSERT INTO `perro` VALUES (1,'Donna','Mediano','Marron y Negro','2019-12-21','Hembra','Mestizo',43178686,27.4,0);
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
  PRIMARY KEY (`IDPERROADOPCION`),
  UNIQUE KEY `IDPERROADOPCION_UNIQUE` (`IDPERROADOPCION`)
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perroadopcion`
--

LOCK TABLES `perroadopcion` WRITE;
/*!40000 ALTER TABLE `perroadopcion` DISABLE KEYS */;
INSERT INTO `perroadopcion` VALUES (2,'Macho','Grande','7 meses','1212315352','Rocco','julio24@gmail.com','Me mude y no tengo espacio! Es un excelente perro',30987560,0),(3,'Macho','Pequeño','2 meses','3242321313','Capitan','renzo@gmail.com','Cachorro muy jugueton',32678901,0),(4,'Hembra','Mediano','8 años','324234123','Luz','renzo@gmail.com','Gordita hermosa',42190651,0),(230,'Macho','Grande','36','2215622333','Juani','julia@gmail.com','habla un montón, se porta mal, saquenlo',1,0);
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
  `ID` int NOT NULL,
  `IDPERRO` int NOT NULL,
  `DNIVETERINARIO` int DEFAULT NULL,
  `DNICLIENTE` int NOT NULL,
  `FECHA` date NOT NULL,
  `ESTADO` varchar(20) NOT NULL,
  `IDSERVICIO` int NOT NULL,
  `IDVACUNA` int DEFAULT NULL,
  `NOMBRESERVICIO` varchar(200) NOT NULL,
  `NOMBREVETERINARIO` varchar(60) DEFAULT NULL,
  `NOMBRECLIENTE` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno`
--

LOCK TABLES `turno` WRITE;
/*!40000 ALTER TABLE `turno` DISABLE KEYS */;
INSERT INTO `turno` VALUES (1,1,213,23,'2023-05-17','Confirmado',2,NULL,'Chequeo','Joaco','Pedro'),(2,2,213,23,'2023-09-18','Pendiente',3,NULL,'Peluqueria','Renzo','Camila'),(3,5,213,43178686,'2023-05-18','Solicitado',5,NULL,'Desparacitacion','Juan','Joaquin Diez'),(4,124,213,43178686,'2023-05-18','Confirmado',1,2,'Vacunacion','Lucia','Joaquin Diez'),(5,142,213,124,'2023-05-18','Confirmado',7,1,'Vacunacion','Federico','Hernan');
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
INSERT INTO `veterinario` VALUES (5,'Renzo Vet','renzovet@gmail.com','123','221786767','2023-05-08'),(6,'Pedro Pulgas','pedro@gmail.com','pulgas','221147687','2023-05-08'),(43178686,'Joaquin Diez','JoaVet@gmail.com','cisco','2352463977','2023-04-28'),(44456456,'Mauricio Cella','ren.sabee@gmail.com','5pDUFmX8sC','(547) 656 - 4734','2023-05-11');
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

-- Dump completed on 2023-05-23  9:52:41
