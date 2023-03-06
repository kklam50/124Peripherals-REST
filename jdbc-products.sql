-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: jdbc_products
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderNumber` int NOT NULL AUTO_INCREMENT,
  `orderItems` varchar(255) DEFAULT NULL,
  `orderTotal` decimal(7,2) DEFAULT NULL,
  `orderShippingMethod` varchar(45) DEFAULT NULL,
  `customerName` varchar(100) DEFAULT NULL,
  `customerAddress` varchar(100) DEFAULT NULL,
  `customerEmail` varchar(50) DEFAULT NULL,
  `customerPhoneNumber` varchar(12) DEFAULT NULL,
  `customerCardholderName` varchar(100) DEFAULT NULL,
  `customerCardNumber` varchar(20) DEFAULT NULL,
  `customerCardExpDate` varchar(5) DEFAULT NULL,
  `customerCardCVC` varchar(4) DEFAULT NULL,
  `orderMessage` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`orderNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'1:1 2:1 ',180.00,'2 Day Expedited','Test User','111 Mouse St. Irvine, CA 12345 United States','124Peripherals@gmail.com','000-000-0000','Test User','0000 0000 0000 0000','12/34','222','testMessage'),(4,'9:4 ',600.00,'2 Day Expedited','a a b','1234 Test Lane a, ba 12345 United States','1234@gmail.com','123-123-1234','a','1234 1234 1234 1234','11/11','123',''),(5,'8:3 ',195.00,'4 Day Economy','a a b','1234 Test Lane a, ba 12345 United States','1234@gmail.com','123-123-1234','a','1234 1234 1234 1234','11/11','123','');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `productID` int NOT NULL,
  `productName` varchar(45) DEFAULT NULL,
  `productBrand` varchar(45) DEFAULT NULL,
  `productPrice` decimal(5,2) DEFAULT NULL,
  `productRating` int DEFAULT NULL,
  `productReviewNum` int DEFAULT NULL,
  `productImgName` varchar(100) DEFAULT NULL,
  `productDescription` varchar(1000) DEFAULT NULL,
  `productSensor` varchar(45) DEFAULT NULL,
  `productWeight` varchar(45) DEFAULT NULL,
  `productColor` varchar(45) DEFAULT NULL,
  `productMaterial` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (0,'Razer Viper Mini','Razer',29.99,4,20,'vipermini.png','Born to push the very limits of ultra-lightweight gaming, the Razer Viper Mini takes up a smaller form that remains just as big in performance. Shortening its length and grip width, we\'ve worked with enthusiasts and esports athletes to hone its design even further, ensuring that absolute control now belongs in the hands of more gamers-so take hold of our leanest and lightest gaming mouse yet.','Pixart PMW 3359','61g','Black','Plastic'),(1,'Logitech G Pro X Superlight','Logitech',149.99,5,140,'logitech-gpx.webp','Less than 63 grams. Advanced low-latency LIGHTSPEED wireless. Sub-micron precision with HERO 25K sensor. Remove all obstacles with our lightest and fastest PRO mouse ever.','HERO 25K','63g','Black','Plastic'),(2,'Zowie Divina S2','Zowie',69.99,5,300,'01-s2-divina-blue-top.png','Symmetrical gaming mouse for esports. Shorter overall design. Driverless; plug and play. 3360 sensor.','Pixart PMW 3360','82g','Blue','Plastic'),(3,'Lamzu Atlantis','Lamzu',97.99,5,10,'lamzu_atlantis.webp','Lamzu Atlantis was built for demanding gamers who want full control. A heart of the mouse is its sensor - it determines its accuracy which is key during the game. The atlantis boasts a high-quality PAW3395 optical sensor which allows you to freely choose the DPI scale between 200 to 26000 DPI.','Pixart PMW 3395','55g','White','Plastic'),(4,'Pulsar XLite v2','Pulsar',79.99,4,130,'pulsar-xlite-v2.jpg','Simple but not simpler. We kept this in mind all the time when we designed Xlite structure. We designed a structure as simple as possible but maintained its durability. In the result, you are getting high performance gaming mouse that is lighter than the egg in your hand.','Pixart PAW 3370','59g','White','Plastic'),(5,'Finalmouse Starlight-12','Finalmouse',189.99,3,50,'pegasus_starlight-12.webp','The Magnesium Chassis can slightly vary in thickness due to the manufacturing processes & complexities involved. Therefore the weight of each individual mouse may vary by +- 2 grams. <br> Final assembled weight including battery/feet/screws/paint/coating is ~42 grams for Small and ~47 grams for medium. <br> The bottom of the mouse is made of Ultem NOT magnesium for the purposes of allowing the wireless signal to escape. <br> It is therefore not as strong as magnesium and should not be squeezed or strength tested as one could with the sides or top of the mouse.','Finalsensor','47g','White','Magnesium'),(6,'Pulsar X2','Pulsar',94.95,4,350,'pulsar_x2.webp','Ultralight weight below 60grams without the perforation. Equipped with the latest flagship 26K sensor. Lag-free 2.4Hz wireless technology. Shape that is delightfully comfortable.','Pixart PMW 3395','52g','White','Plastic'),(7,'Razer Deathadder v3','Razer',149.99,5,200,'razer_deathadder_v3.jpg','Victory takes on a new shape with the Razer DeathAdder V3 Pro. Refined and reforged with the aid of top esports pros, its iconic ergonomic form is now more than 25% lighter than its predecessor, backed by a set of cutting-edge upgrades to push the limits of competitive play.','Razer Focus Pro (Pixart PMW 3950DM)','63g','White','Plastic'),(8,'Vaxee Zygen NP-01s','Vaxee',64.99,4,100,'vaxee_zygen_np-01s.png','Light, stable and clear click feel. Adjustable click response time helps you find your preferred click rhythm. Minimal gap in shell design. Enhanced comfort. Durable and stable feet design. Raised front-end design.','Pixart PMW 3389','71g','Black','Plastic'),(9,'Zowie EC2-CW','Zowie',149.99,4,1,'zowie_ec2-cw.webp','Wireless design with enhanced receiver. Asymmetrical ergonomic design. Reduced weight. 24-step scroll wheel. Driverless, plug and play. 3370 sensor.','Pixart PMW 3370','77g','Black','Plastic');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-02 21:42:07