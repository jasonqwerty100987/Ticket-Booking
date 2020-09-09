CREATE DATABASE  IF NOT EXISTS `project_336_aws` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `project_336_aws`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: project-336.csarcurbaxov.us-east-2.rds.amazonaws.com    Database: project_336_aws
-- ------------------------------------------------------
-- Server version	5.7.22-log

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
-- Table structure for table `Arrange`
--

DROP TABLE IF EXISTS `Arrange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Arrange` (
  `StationID` int(11) NOT NULL,
  `TransitLineName` varchar(30) NOT NULL,
  `Departure Time` datetime DEFAULT NULL,
  `Arrival Time` datetime DEFAULT NULL,
  `Departure Time Back` datetime DEFAULT NULL,
  `Arrival Time Back` datetime DEFAULT NULL,
  PRIMARY KEY (`TransitLineName`,`StationID`),
  KEY `Stations_idx` (`StationID`),
  CONSTRAINT `TransitLine` FOREIGN KEY (`TransitLineName`) REFERENCES `Train_Schedule` (`TransitLineName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Arrange`
--

LOCK TABLES `Arrange` WRITE;
/*!40000 ALTER TABLE `Arrange` DISABLE KEYS */;
INSERT INTO `Arrange` VALUES (0,'Route 1','2020-04-30 08:30:00','2020-04-30 10:30:00','2020-04-30 11:30:00','0000-00-00 00:00:00'),(1,'Route 1','2020-04-30 08:45:00','2020-04-30 08:40:00','2020-04-30 12:50:00','2020-04-30 12:30:00'),(2,'Route 1','2020-04-30 08:55:00','2020-04-30 08:52:00','2020-04-30 14:53:00','2020-04-30 14:50:00'),(3,'Route 1','0000-00-00 00:00:00','2020-04-30 10:30:00','0000-00-00 00:00:00','2020-04-30 16:00:00'),(4,'Route 2','2020-04-30 17:30:00','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'Route 2','2020-04-30 18:40:00','2020-04-30 18:30:00','0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'Route 2','2020-04-30 19:10:00','2020-04-30 18:55:00','0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'Route 2','0000-00-00 00:00:00','2020-04-30 20:10:00','0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'Route NY','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'Route NY','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'Route NY','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `Arrange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `Username` varchar(20) NOT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `Telephone` varchar(15) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `State` varchar(20) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `ZipCode` int(11) DEFAULT NULL,
  `Password` varchar(20) NOT NULL,
  PRIMARY KEY (`Username`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `Telephone_UNIQUE` (`Telephone`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES ('jtc','jiang','tingcong','8888888888','Edison','jtc@gmail.com','NJ','116',8817,'123123'),('qwe','Test','User','87090','0','69385','0','0',0,'qwe'),('qwer','sb','dasabi','72331','0','42613','0','0',0,'123456789'),('valia','Valia','K','1234567890','aaa','v@v.com','NJ','asf',8854,'valia'),('xsj','shijie1','xu','7324024051','Edison','jack@gmail.com','NJ','602',8817,'123123123'),('zhuohuanli','zhuohuan','li','7329832926','Edison','123@qq.com','NJ','116',8854,'123');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustormerRepresentative`
--

DROP TABLE IF EXISTS `CustormerRepresentative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CustormerRepresentative` (
  `SSN` char(9) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `FirstName` varchar(20) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(20) NOT NULL,
  PRIMARY KEY (`SSN`),
  CONSTRAINT `SSN` FOREIGN KEY (`SSN`) REFERENCES `Employee` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustormerRepresentative`
--

LOCK TABLES `CustormerRepresentative` WRITE;
/*!40000 ALTER TABLE `CustormerRepresentative` DISABLE KEYS */;
INSERT INTO `CustormerRepresentative` VALUES ('123456789','Li','Zhuohuan','nibaba','123'),('567891234','jiang','tingcong','jtc','123123'),('987654321','xu','shijie','xsj','123456');
/*!40000 ALTER TABLE `CustormerRepresentative` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `SSN` char(9) NOT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `Username` varchar(20) DEFAULT NULL,
  `Password` varchar(20) NOT NULL,
  `admin` int(11) DEFAULT '0',
  PRIMARY KEY (`SSN`),
  UNIQUE KEY `username_UNIQUE` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES ('123456789','Li','Zhuohuan','lzh_work','123123',1),('567891234','jiang','tingcong','jtc_work','qwerty',0),('987654321','xu','shijie','xsj_work','123456',1);
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fare`
--

DROP TABLE IF EXISTS `Fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fare` (
  `Begin` int(11) NOT NULL,
  `End` int(11) NOT NULL,
  `OneWay` double DEFAULT NULL,
  `RoundTrip` double DEFAULT NULL,
  `Senior_Discount` double DEFAULT NULL,
  `Children_Discount` double DEFAULT NULL,
  `Disabled_Discount` double DEFAULT NULL,
  `MonthlyFare` double DEFAULT NULL,
  `WeeklyFare` double DEFAULT NULL,
  `TransitLineName` varchar(30) NOT NULL,
  PRIMARY KEY (`Begin`,`End`,`TransitLineName`),
  KEY `TransitName_idx` (`TransitLineName`),
  KEY `EndID_idx` (`End`),
  CONSTRAINT `BeginID` FOREIGN KEY (`Begin`) REFERENCES `Stations` (`StationID`) ON UPDATE CASCADE,
  CONSTRAINT `EndID` FOREIGN KEY (`End`) REFERENCES `Stations` (`StationID`) ON UPDATE CASCADE,
  CONSTRAINT `TransitName` FOREIGN KEY (`TransitLineName`) REFERENCES `Train_Schedule` (`TransitLineName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fare`
--

LOCK TABLES `Fare` WRITE;
/*!40000 ALTER TABLE `Fare` DISABLE KEYS */;
INSERT INTO `Fare` VALUES (0,3,5,8,0.85,0.5,0.5,75,20,'Route 1'),(4,7,40,75,0.85,0.5,0.5,500,150,'Route 2'),(8,10,15,25,0.85,0.5,0.5,180,50,'Route NY');
/*!40000 ALTER TABLE `Fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QA`
--

DROP TABLE IF EXISTS `QA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `QA` (
  `QAID` int(11) NOT NULL,
  `Question` varchar(100) DEFAULT NULL,
  `Answer` varchar(100) DEFAULT NULL,
  `Username` varchar(20) NOT NULL,
  PRIMARY KEY (`QAID`),
  KEY `a_idx` (`Username`),
  CONSTRAINT `jj` FOREIGN KEY (`Username`) REFERENCES `Customer` (`Username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QA`
--

LOCK TABLES `QA` WRITE;
/*!40000 ALTER TABLE `QA` DISABLE KEYS */;
INSERT INTO `QA` VALUES (129771262,'',NULL,'zhuohuanli'),(783057493,'123',NULL,'zhuohuanli'),(852649065,'How can I get my refund?',NULL,'zhuohuanli');
/*!40000 ALTER TABLE `QA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservation`
--

DROP TABLE IF EXISTS `Reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservation` (
  `ReservationNumber` bigint(20) NOT NULL,
  `ReservationDate` datetime NOT NULL,
  `BookingFee` double NOT NULL,
  `Fare` double DEFAULT NULL,
  `Seat_Class` varchar(10) NOT NULL,
  `Seat_Number` varchar(10) NOT NULL,
  `SSN` char(9) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `StationID` int(11) NOT NULL,
  `StationID2` int(11) NOT NULL,
  `TransitLineName` varchar(30) NOT NULL,
  PRIMARY KEY (`ReservationNumber`),
  KEY `a_idx` (`Username`),
  KEY `b_idx` (`SSN`),
  KEY `c_idx` (`StationID`),
  KEY `e_idx` (`TransitLineName`),
  KEY `f_idx` (`StationID2`),
  CONSTRAINT `a` FOREIGN KEY (`Username`) REFERENCES `Customer` (`Username`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `b` FOREIGN KEY (`SSN`) REFERENCES `CustormerRepresentative` (`SSN`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `c` FOREIGN KEY (`StationID`) REFERENCES `Stations` (`StationID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `d` FOREIGN KEY (`StationID`) REFERENCES `Stations` (`StationID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `e` FOREIGN KEY (`TransitLineName`) REFERENCES `Train_Schedule` (`TransitLineName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `f` FOREIGN KEY (`StationID2`) REFERENCES `Stations` (`StationID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservation`
--

LOCK TABLES `Reservation` WRITE;
/*!40000 ALTER TABLE `Reservation` DISABLE KEYS */;
INSERT INTO `Reservation` VALUES (1234567890,'2020-03-01 11:11:11',5.25,30,'first','36D','987654321','xsj',4,0,'Route 2'),(33824011884,'2020-04-30 08:30:00',10.25,100,'economy','1A','123456789','valia',0,2,'Route 1'),(47751009027,'2020-04-30 08:30:00',10.25,6.8,'first','10D','567891234','xsj',0,3,'Route 1'),(52793966626,'2020-04-30 08:30:00',10.25,0,'first','1C','123456789','zhuohuanli',0,3,'Route 1'),(53815840508,'2020-04-30 08:30:00',10.25,200,'economy','10A','123456789','zhuohuanli',0,3,'Route 1'),(63833099622,'2020-04-30 08:30:00',10.25,0,'first','10B','123456789','xsj',0,2,'Route 1'),(66881470396,'2020-04-30 08:30:00',10.25,20,'economy','5C','567891234','xsj',0,3,'Route 1'),(96903646871,'2020-04-30 08:30:00',10.25,50,'economy','10C','567891234','zhuohuanli',0,3,'Route 1'),(96918643278,'2020-04-30 08:30:00',10.25,50,'economy','10E','567891234','qwer',0,2,'Route 1');
/*!40000 ALTER TABLE `Reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Runs`
--

DROP TABLE IF EXISTS `Runs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Runs` (
  `TransitName` varchar(30) NOT NULL,
  `TrainID` char(4) NOT NULL,
  PRIMARY KEY (`TransitName`,`TrainID`),
  KEY `TrainID_idx` (`TrainID`),
  CONSTRAINT `TrainID123` FOREIGN KEY (`TrainID`) REFERENCES `Trains` (`TrainID`) ON UPDATE CASCADE,
  CONSTRAINT `TransitName123` FOREIGN KEY (`TransitName`) REFERENCES `Train_Schedule` (`TransitLineName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Runs`
--

LOCK TABLES `Runs` WRITE;
/*!40000 ALTER TABLE `Runs` DISABLE KEYS */;
INSERT INTO `Runs` VALUES ('Route 1','1234'),('Route 2','4321'),('Route NY','5678');
/*!40000 ALTER TABLE `Runs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Seat_Number_Template`
--

DROP TABLE IF EXISTS `Seat_Number_Template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Seat_Number_Template` (
  `Seat_Number` varchar(4) NOT NULL,
  PRIMARY KEY (`Seat_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Seat_Number_Template`
--

LOCK TABLES `Seat_Number_Template` WRITE;
/*!40000 ALTER TABLE `Seat_Number_Template` DISABLE KEYS */;
INSERT INTO `Seat_Number_Template` VALUES ('10A'),('10B'),('10C'),('10D'),('10E'),('1A'),('1B'),('1C'),('1D'),('1E'),('2A'),('2B'),('2C'),('2D'),('2E'),('3A'),('3B'),('3C'),('3D'),('3E'),('4A'),('4B'),('4C'),('4D'),('4E'),('5A'),('5B'),('5C'),('5D'),('5E'),('6A'),('6B'),('6C'),('6D'),('6E'),('7A'),('7B'),('7C'),('7D'),('7E'),('8A'),('8B'),('8C'),('8D'),('8E'),('9A'),('9B'),('9C'),('9D'),('9E');
/*!40000 ALTER TABLE `Seat_Number_Template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stations`
--

DROP TABLE IF EXISTS `Stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Stations` (
  `StationID` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `State` varchar(20) NOT NULL,
  `City` varchar(20) NOT NULL,
  PRIMARY KEY (`StationID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stations`
--

LOCK TABLES `Stations` WRITE;
/*!40000 ALTER TABLE `Stations` DISABLE KEYS */;
INSERT INTO `Stations` VALUES (0,'New Brunswick','NJ','New Brunswick'),(1,'Metchuchen','NJ','Metchuchen'),(2,'Highland Park','NJ','Highland Park'),(3,'EWR','NJ','Newark'),(4,'Edison','NJ','Edison'),(5,'Princeton','NJ','Princeton'),(6,'New Port','NJ','New Port'),(7,'Queen','NY','Queen'),(8,'Manhattan','NY','Manhattan'),(9,'chinatown','NY','chinatown'),(10,'brooklyn','NY','brooklyn');
/*!40000 ALTER TABLE `Stations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Train_Schedule`
--

DROP TABLE IF EXISTS `Train_Schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Train_Schedule` (
  `TransitLineName` varchar(30) NOT NULL,
  `Stops` int(11) NOT NULL,
  `AvailableSeats` int(11) NOT NULL,
  `ArrivalDate` date NOT NULL,
  `ArrivalTime` time NOT NULL,
  `DepartureDate` date NOT NULL,
  `DepartureTime` time NOT NULL,
  `TravelTime` time NOT NULL,
  `StartAt` int(11) NOT NULL,
  `EndAt` int(11) NOT NULL,
  PRIMARY KEY (`TransitLineName`),
  KEY `StartAt_idx` (`StartAt`,`EndAt`),
  KEY `End_idx` (`EndAt`),
  CONSTRAINT `End` FOREIGN KEY (`EndAt`) REFERENCES `Stations` (`StationID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Start` FOREIGN KEY (`StartAt`) REFERENCES `Stations` (`StationID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Train_Schedule`
--

LOCK TABLES `Train_Schedule` WRITE;
/*!40000 ALTER TABLE `Train_Schedule` DISABLE KEYS */;
INSERT INTO `Train_Schedule` VALUES ('Route 1',4,50,'2020-04-30','10:30:00','2020-04-30','08:30:00','02:00:00',0,3),('Route 2',4,30,'2020-04-30','20:00:00','2020-04-30','17:30:00','02:30:00',4,7),('Route NY',3,30,'2019-04-30','20:00:00','2019-04-30','17:30:00','02:30:00',8,10);
/*!40000 ALTER TABLE `Train_Schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Trains`
--

DROP TABLE IF EXISTS `Trains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Trains` (
  `TrainID` char(4) NOT NULL,
  `Cars` int(11) DEFAULT NULL,
  `Business_Seats` int(11) DEFAULT NULL,
  `First_Seats` int(11) DEFAULT NULL,
  `Eco_Seats` int(11) DEFAULT NULL,
  `Runs` varchar(30) NOT NULL,
  PRIMARY KEY (`TrainID`),
  KEY `Runs_idx` (`Runs`),
  CONSTRAINT `Runs` FOREIGN KEY (`Runs`) REFERENCES `Train_Schedule` (`TransitLineName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Trains`
--

LOCK TABLES `Trains` WRITE;
/*!40000 ALTER TABLE `Trains` DISABLE KEYS */;
INSERT INTO `Trains` VALUES ('1234',5,30,40,80,'Route 1'),('4321',7,30,40,80,'Route 2'),('5678',6,30,40,80,'Route NY');
/*!40000 ALTER TABLE `Trains` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-01 21:33:29
