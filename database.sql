-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: SOG
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `Nagrazhdenie`
--

DROP TABLE IF EXISTS `Nagrazhdenie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Nagrazhdenie` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_rezultata` int DEFAULT NULL,
  `Nazvanie_nagrady` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_rezultata` (`ID_rezultata`),
  CONSTRAINT `nagrazhdenie_ibfk_1` FOREIGN KEY (`ID_rezultata`) REFERENCES `Rezultaty_uchastiya` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Nagrazhdenie`
--

LOCK TABLES `Nagrazhdenie` WRITE;
/*!40000 ALTER TABLE `Nagrazhdenie` DISABLE KEYS */;
INSERT INTO `Nagrazhdenie` VALUES (1,1,'Золотая медаль'),(2,3,'Золотая медаль'),(3,6,'Золотая медаль'),(4,7,'Золотая медаль'),(5,9,'Золотая медаль');
/*!40000 ALTER TABLE `Nagrazhdenie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Organizatory_sorevnovaniy`
--

DROP TABLE IF EXISTS `Organizatory_sorevnovaniy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Organizatory_sorevnovaniy` (
  `ID_organizatora_sorevnovaniy` int NOT NULL AUTO_INCREMENT,
  `FIO` varchar(100) NOT NULL,
  PRIMARY KEY (`ID_organizatora_sorevnovaniy`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Organizatory_sorevnovaniy`
--

LOCK TABLES `Organizatory_sorevnovaniy` WRITE;
/*!40000 ALTER TABLE `Organizatory_sorevnovaniy` DISABLE KEYS */;
INSERT INTO `Organizatory_sorevnovaniy` VALUES (1,'Иванова Наталья'),(2,'Громов Алексей');
/*!40000 ALTER TABLE `Organizatory_sorevnovaniy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rezultaty_uchastiya`
--

DROP TABLE IF EXISTS `Rezultaty_uchastiya`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rezultaty_uchastiya` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_sostyazaniya` int DEFAULT NULL,
  `ID_sportsmena` int DEFAULT NULL,
  `Mesto` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_sostyazaniya` (`ID_sostyazaniya`),
  KEY `ID_sportsmena` (`ID_sportsmena`),
  CONSTRAINT `rezultaty_uchastiya_ibfk_1` FOREIGN KEY (`ID_sostyazaniya`) REFERENCES `Sostyazaniya` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `rezultaty_uchastiya_ibfk_2` FOREIGN KEY (`ID_sportsmena`) REFERENCES `Sportsmeny` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rezultaty_uchastiya`
--

LOCK TABLES `Rezultaty_uchastiya` WRITE;
/*!40000 ALTER TABLE `Rezultaty_uchastiya` DISABLE KEYS */;
INSERT INTO `Rezultaty_uchastiya` VALUES (1,1,1,1),(2,1,2,2),(3,2,6,1),(4,2,7,3),(5,3,3,2),(6,3,9,1),(7,4,4,1),(8,4,10,2),(9,5,8,1),(10,5,5,3);
/*!40000 ALTER TABLE `Rezultaty_uchastiya` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_auto_nagrada` AFTER INSERT ON `rezultaty_uchastiya` FOR EACH ROW BEGIN
    IF NEW.Mesto=1 THEN
        INSERT INTO Nagrazhdenie(ID_rezultata,Nazvanie_nagrady)
        VALUES(NEW.ID,'Золотая медаль');
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
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_upgrade_razryad` AFTER INSERT ON `rezultaty_uchastiya` FOR EACH ROW BEGIN
    IF NEW.Mesto=1 THEN
        UPDATE Sportsmeny SET Razryad='МС'
        WHERE ID=NEW.ID_sportsmena;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Sostyazaniya`
--

DROP TABLE IF EXISTS `Sostyazaniya`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sostyazaniya` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nazvanie` varchar(100) NOT NULL,
  `Vid_sporta_ID` int DEFAULT NULL,
  `Sportivnoe_sooruzhenie_ID` int DEFAULT NULL,
  `ID_Organizatory_sorevnovaniy` int DEFAULT NULL,
  `Data_provedeniya` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Vid_sporta_ID` (`Vid_sporta_ID`),
  KEY `Sportivnoe_sooruzhenie_ID` (`Sportivnoe_sooruzhenie_ID`),
  KEY `ID_Organizatory_sorevnovaniy` (`ID_Organizatory_sorevnovaniy`),
  CONSTRAINT `sostyazaniya_ibfk_1` FOREIGN KEY (`Vid_sporta_ID`) REFERENCES `Vidy_sporta` (`ID`),
  CONSTRAINT `sostyazaniya_ibfk_2` FOREIGN KEY (`Sportivnoe_sooruzhenie_ID`) REFERENCES `Sportivnoe_sooruzhenie` (`ID`),
  CONSTRAINT `sostyazaniya_ibfk_3` FOREIGN KEY (`ID_Organizatory_sorevnovaniy`) REFERENCES `Organizatory_sorevnovaniy` (`ID_organizatora_sorevnovaniy`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sostyazaniya`
--

LOCK TABLES `Sostyazaniya` WRITE;
/*!40000 ALTER TABLE `Sostyazaniya` DISABLE KEYS */;
INSERT INTO `Sostyazaniya` VALUES (1,'Кубок города по футболу',1,1,1,'2025-04-01'),(2,'Открытый турнир по теннису',2,2,2,'2025-04-10'),(3,'Чемпионат по легкой атлетике',3,3,1,'2025-04-15'),(4,'Баскетбольная лига',4,4,2,'2025-04-20'),(5,'Первенство по плаванию',5,5,1,'2025-04-25');
/*!40000 ALTER TABLE `Sostyazaniya` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_backup_sostyazanie` BEFORE DELETE ON `sostyazaniya` FOR EACH ROW BEGIN
    INSERT INTO Sostyazaniya_backup
    SELECT * FROM Sostyazaniya WHERE ID=OLD.ID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Sostyazaniya_backup`
--

DROP TABLE IF EXISTS `Sostyazaniya_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sostyazaniya_backup` (
  `ID` int NOT NULL DEFAULT '0',
  `Nazvanie` varchar(100) NOT NULL,
  `Vid_sporta_ID` int DEFAULT NULL,
  `Sportivnoe_sooruzhenie_ID` int DEFAULT NULL,
  `ID_Organizatory_sorevnovaniy` int DEFAULT NULL,
  `Data_provedeniya` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sostyazaniya_backup`
--

LOCK TABLES `Sostyazaniya_backup` WRITE;
/*!40000 ALTER TABLE `Sostyazaniya_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `Sostyazaniya_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sportivnoe_sooruzhenie`
--

DROP TABLE IF EXISTS `Sportivnoe_sooruzhenie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sportivnoe_sooruzhenie` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nazvanie` varchar(100) NOT NULL,
  `Tip_ID` int DEFAULT NULL,
  `Vmestimost` int DEFAULT NULL,
  `Tip_pokrytiya` varchar(50) DEFAULT NULL,
  `Ploshad` float DEFAULT NULL,
  `Adres` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Tip_ID` (`Tip_ID`),
  CONSTRAINT `sportivnoe_sooruzhenie_ibfk_1` FOREIGN KEY (`Tip_ID`) REFERENCES `Tip_sooruzheniya` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sportivnoe_sooruzhenie`
--

LOCK TABLES `Sportivnoe_sooruzhenie` WRITE;
/*!40000 ALTER TABLE `Sportivnoe_sooruzhenie` DISABLE KEYS */;
INSERT INTO `Sportivnoe_sooruzhenie` VALUES (1,'Центральный стадион',1,20000,NULL,15000,'ул. Ленина 1'),(2,'Теннисный корт №1',2,NULL,'Грунт',500,'ул. Спортивная 5'),(3,'Легкоатлетический манеж',3,1000,NULL,3000,'пр. Мира 10'),(4,'Баскетбольный зал',4,800,NULL,1200,'ул. Гагарина 12'),(5,'Городской бассейн',5,600,NULL,2000,'ул. Победы 7');
/*!40000 ALTER TABLE `Sportivnoe_sooruzhenie` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_check_sooruzhenie` BEFORE INSERT ON `sportivnoe_sooruzhenie` FOR EACH ROW BEGIN
    IF NEW.Vmestimost IS NULL AND NEW.Tip_ID = 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Для стадиона обязательна вместимость';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Sportivnye_kluby`
--

DROP TABLE IF EXISTS `Sportivnye_kluby`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sportivnye_kluby` (
  `ID_sportivnogo_kluba` int NOT NULL AUTO_INCREMENT,
  `Nazvanie` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_sportivnogo_kluba`),
  UNIQUE KEY `Nazvanie` (`Nazvanie`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sportivnye_kluby`
--

LOCK TABLES `Sportivnye_kluby` WRITE;
/*!40000 ALTER TABLE `Sportivnye_kluby` DISABLE KEYS */;
INSERT INTO `Sportivnye_kluby` VALUES (1,'Динамо'),(3,'Олимп'),(2,'Спартак'),(4,'Юность');
/*!40000 ALTER TABLE `Sportivnye_kluby` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sportsmeny`
--

DROP TABLE IF EXISTS `Sportsmeny`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sportsmeny` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `FIO` varchar(100) NOT NULL,
  `Razryad` varchar(50) DEFAULT NULL,
  `Pol` enum('muzhskoy','zhenskiy') DEFAULT NULL,
  `ID_sportivnogo_kluba` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_sportivnogo_kluba` (`ID_sportivnogo_kluba`),
  CONSTRAINT `sportsmeny_ibfk_1` FOREIGN KEY (`ID_sportivnogo_kluba`) REFERENCES `Sportivnye_kluby` (`ID_sportivnogo_kluba`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sportsmeny`
--

LOCK TABLES `Sportsmeny` WRITE;
/*!40000 ALTER TABLE `Sportsmeny` DISABLE KEYS */;
INSERT INTO `Sportsmeny` VALUES (1,'Иванов Иван','МС','muzhskoy',1),(2,'Петров Петр','1 разряд','muzhskoy',2),(3,'Сидоров Алексей','2 разряд','muzhskoy',3),(4,'Кузнецов Дмитрий','МС','muzhskoy',1),(5,'Смирнов Андрей','3 разряд','muzhskoy',4),(6,'Попова Анна','МС','zhenskiy',2),(7,'Козлова Мария','КМС','zhenskiy',3),(8,'Морозова Елена','МС','zhenskiy',1),(9,'Волков Сергей','МС','muzhskoy',4),(10,'Соколова Дарья','3 разряд','zhenskiy',2);
/*!40000 ALTER TABLE `Sportsmeny` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_log_razryad` AFTER UPDATE ON `sportsmeny` FOR EACH ROW BEGIN
    IF OLD.Razryad<>NEW.Razryad THEN
        INSERT INTO Sportsmeny_log(ID_sportsmena,Old_Razryad,New_Razryad,Action_type)
        VALUES(OLD.ID,OLD.Razryad,NEW.Razryad,'UPDATE');
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Sportsmeny_log`
--

DROP TABLE IF EXISTS `Sportsmeny_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sportsmeny_log` (
  `ID_log` int NOT NULL AUTO_INCREMENT,
  `ID_sportsmena` int DEFAULT NULL,
  `Old_Razryad` varchar(50) DEFAULT NULL,
  `New_Razryad` varchar(50) DEFAULT NULL,
  `Action_type` varchar(20) DEFAULT NULL,
  `Log_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_log`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sportsmeny_log`
--

LOCK TABLES `Sportsmeny_log` WRITE;
/*!40000 ALTER TABLE `Sportsmeny_log` DISABLE KEYS */;
INSERT INTO `Sportsmeny_log` VALUES (1,1,'КМС','МС','UPDATE','2026-02-11 11:54:28'),(2,6,'1 разряд','МС','UPDATE','2026-02-11 11:54:28'),(3,9,'1 разряд','МС','UPDATE','2026-02-11 11:54:28'),(4,4,'КМС','МС','UPDATE','2026-02-11 11:54:28'),(5,8,'2 разряд','МС','UPDATE','2026-02-11 11:54:28');
/*!40000 ALTER TABLE `Sportsmeny_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tip_sooruzheniya`
--

DROP TABLE IF EXISTS `Tip_sooruzheniya`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tip_sooruzheniya` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nazvanie` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Nazvanie` (`Nazvanie`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tip_sooruzheniya`
--

LOCK TABLES `Tip_sooruzheniya` WRITE;
/*!40000 ALTER TABLE `Tip_sooruzheniya` DISABLE KEYS */;
INSERT INTO `Tip_sooruzheniya` VALUES (5,'Бассейн'),(2,'Корт'),(3,'Манеж'),(4,'Спортивный зал'),(1,'Стадион');
/*!40000 ALTER TABLE `Tip_sooruzheniya` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Trenery`
--

DROP TABLE IF EXISTS `Trenery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Trenery` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `FIO` varchar(100) NOT NULL,
  `Vid_sporta_ID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Vid_sporta_ID` (`Vid_sporta_ID`),
  CONSTRAINT `trenery_ibfk_1` FOREIGN KEY (`Vid_sporta_ID`) REFERENCES `Vidy_sporta` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Trenery`
--

LOCK TABLES `Trenery` WRITE;
/*!40000 ALTER TABLE `Trenery` DISABLE KEYS */;
INSERT INTO `Trenery` VALUES (1,'Орлов Сергей',1),(2,'Тихонов Павел',2),(3,'Зайцев Игорь',3),(4,'Лебедев Максим',4),(5,'Крылова Ольга',5);
/*!40000 ALTER TABLE `Trenery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Trenirovki`
--

DROP TABLE IF EXISTS `Trenirovki`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Trenirovki` (
  `ID_trenirovki` int NOT NULL AUTO_INCREMENT,
  `ID_trenera` int DEFAULT NULL,
  `ID_sportsmena` int DEFAULT NULL,
  `ID_vida_sporta` int DEFAULT NULL,
  `Data_nachala` date DEFAULT NULL,
  PRIMARY KEY (`ID_trenirovki`),
  KEY `ID_trenera` (`ID_trenera`),
  KEY `ID_sportsmena` (`ID_sportsmena`),
  KEY `ID_vida_sporta` (`ID_vida_sporta`),
  CONSTRAINT `trenirovki_ibfk_1` FOREIGN KEY (`ID_trenera`) REFERENCES `Trenery` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `trenirovki_ibfk_2` FOREIGN KEY (`ID_sportsmena`) REFERENCES `Sportsmeny` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `trenirovki_ibfk_3` FOREIGN KEY (`ID_vida_sporta`) REFERENCES `Vidy_sporta` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Trenirovki`
--

LOCK TABLES `Trenirovki` WRITE;
/*!40000 ALTER TABLE `Trenirovki` DISABLE KEYS */;
INSERT INTO `Trenirovki` VALUES (1,1,1,1,'2025-01-10'),(2,1,2,1,'2025-01-12'),(3,2,6,2,'2025-02-01'),(4,2,7,2,'2025-02-03'),(5,3,3,3,'2025-03-01'),(6,4,4,4,'2025-03-05'),(7,5,8,5,'2025-03-10'),(8,3,9,3,'2025-03-12'),(9,4,10,4,'2025-03-15'),(10,5,5,5,'2025-03-20');
/*!40000 ALTER TABLE `Trenirovki` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_check_trener` BEFORE INSERT ON `trenirovki` FOR EACH ROW BEGIN
    DECLARE v INT;
    SELECT Vid_sporta_ID INTO v FROM Trenery WHERE ID=NEW.ID_trenera;
    IF v <> NEW.ID_vida_sporta THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Тренер не ведет этот вид спорта';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Vidy_sporta`
--

DROP TABLE IF EXISTS `Vidy_sporta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vidy_sporta` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nazvanie` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Nazvanie` (`Nazvanie`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vidy_sporta`
--

LOCK TABLES `Vidy_sporta` WRITE;
/*!40000 ALTER TABLE `Vidy_sporta` DISABLE KEYS */;
INSERT INTO `Vidy_sporta` VALUES (4,'Баскетбол'),(3,'Легкая атлетика'),(5,'Плавание'),(2,'Теннис'),(1,'Футбол');
/*!40000 ALTER TABLE `Vidy_sporta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_prizery`
--

DROP TABLE IF EXISTS `view_prizery`;
/*!50001 DROP VIEW IF EXISTS `view_prizery`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_prizery` AS SELECT 
 1 AS `FIO`,
 1 AS `Mesto`,
 1 AS `Nazvanie_nagrady`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_sooruzheniya`
--

DROP TABLE IF EXISTS `view_sooruzheniya`;
/*!50001 DROP VIEW IF EXISTS `view_sooruzheniya`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_sooruzheniya` AS SELECT 
 1 AS `Nazvanie`,
 1 AS `Tip`,
 1 AS `Vmestimost`,
 1 AS `Tip_pokrytiya`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_sorevnovaniya_period`
--

DROP TABLE IF EXISTS `view_sorevnovaniya_period`;
/*!50001 DROP VIEW IF EXISTS `view_sorevnovaniya_period`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_sorevnovaniya_period` AS SELECT 
 1 AS `Nazvanie`,
 1 AS `Data_provedeniya`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_sportsmeny_vid`
--

DROP TABLE IF EXISTS `view_sportsmeny_vid`;
/*!50001 DROP VIEW IF EXISTS `view_sportsmeny_vid`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_sportsmeny_vid` AS SELECT 
 1 AS `FIO`,
 1 AS `Razryad`,
 1 AS `Vid_sporta`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_trenery_po_vidu`
--

DROP TABLE IF EXISTS `view_trenery_po_vidu`;
/*!50001 DROP VIEW IF EXISTS `view_trenery_po_vidu`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_trenery_po_vidu` AS SELECT 
 1 AS `FIO`,
 1 AS `Nazvanie`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view_prizery`
--

/*!50001 DROP VIEW IF EXISTS `view_prizery`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_prizery` AS select `s`.`FIO` AS `FIO`,`r`.`Mesto` AS `Mesto`,`n`.`Nazvanie_nagrady` AS `Nazvanie_nagrady` from ((`rezultaty_uchastiya` `r` join `sportsmeny` `s` on((`r`.`ID_sportsmena` = `s`.`ID`))) left join `nagrazhdenie` `n` on((`r`.`ID` = `n`.`ID_rezultata`))) where (`r`.`Mesto` <= 3) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_sooruzheniya`
--

/*!50001 DROP VIEW IF EXISTS `view_sooruzheniya`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_sooruzheniya` AS select `ss`.`Nazvanie` AS `Nazvanie`,`ts`.`Nazvanie` AS `Tip`,`ss`.`Vmestimost` AS `Vmestimost`,`ss`.`Tip_pokrytiya` AS `Tip_pokrytiya` from (`sportivnoe_sooruzhenie` `ss` join `tip_sooruzheniya` `ts` on((`ss`.`Tip_ID` = `ts`.`ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_sorevnovaniya_period`
--

/*!50001 DROP VIEW IF EXISTS `view_sorevnovaniya_period`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_sorevnovaniya_period` AS select `sostyazaniya`.`Nazvanie` AS `Nazvanie`,`sostyazaniya`.`Data_provedeniya` AS `Data_provedeniya` from `sostyazaniya` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_sportsmeny_vid`
--

/*!50001 DROP VIEW IF EXISTS `view_sportsmeny_vid`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_sportsmeny_vid` AS select `s`.`FIO` AS `FIO`,`s`.`Razryad` AS `Razryad`,`v`.`Nazvanie` AS `Vid_sporta` from ((`sportsmeny` `s` join `trenirovki` `t` on((`s`.`ID` = `t`.`ID_sportsmena`))) join `vidy_sporta` `v` on((`t`.`ID_vida_sporta` = `v`.`ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_trenery_po_vidu`
--

/*!50001 DROP VIEW IF EXISTS `view_trenery_po_vidu`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_trenery_po_vidu` AS select `tr`.`FIO` AS `FIO`,`v`.`Nazvanie` AS `Nazvanie` from (`trenery` `tr` join `vidy_sporta` `v` on((`tr`.`Vid_sporta_ID` = `v`.`ID`))) */;
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

-- Dump completed on 2026-02-12 10:57:27
