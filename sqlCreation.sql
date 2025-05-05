-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SpaceAgency
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `SpaceAgency` ;

-- -----------------------------------------------------
-- Schema SpaceAgency
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SpaceAgency` DEFAULT CHARACTER SET utf8 ;
USE `SpaceAgency` ;

-- -----------------------------------------------------
-- Table `SpaceAgency`.`STAFF`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`STAFF` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`STAFF` (
  `CIN` CHAR(10) NOT NULL,
  `fname` VARCHAR(15) NOT NULL,
  `mname` VARCHAR(15) NULL,
  `lname` VARCHAR(15) NULL,
  `Job_type` VARCHAR(50) NOT NULL,
  `salary` FLOAT NULL,
  `build_no` VARCHAR(5) NULL,
  `street_name` VARCHAR(20) NULL,
  `postal_code` VARCHAR(10) NULL,
  `city` VARCHAR(20) NULL,
  `state` VARCHAR(20) NULL,
  `country` VARCHAR(20) NULL,
  `gender` ENUM('M', 'F') NULL,
  `birth_date` DATE NULL,
  PRIMARY KEY (`CIN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`PARTNER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`PARTNER` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`PARTNER` (
  `org_code` CHAR(3) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `address` VARCHAR(40) NULL,
  `email` VARCHAR(40) NOT NULL,
  `phone_no` CHAR(12) NULL,
  PRIMARY KEY (`org_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`EQUIPMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`EQUIPMENT` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`EQUIPMENT` (
  `equip_ID` CHAR(7) NOT NULL,
  `name` VARCHAR(30) NULL,
  `status` VARCHAR(30) NULL,
  `type` VARCHAR(15) NULL,
  `origin_country` VARCHAR(20) NULL,
  `kind` VARCHAR(40) NULL,
  `partner_org_code` CHAR(3) NULL,
  PRIMARY KEY (`equip_ID`),
  CONSTRAINT `fk_EQUIPMENT_partner1`
    FOREIGN KEY (`partner_org_code`)
    REFERENCES `SpaceAgency`.`PARTNER` (`org_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_EQUIPMENT_partner1_idx` ON `SpaceAgency`.`EQUIPMENT` (`partner_org_code` ASC) ;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`PLANET`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`PLANET` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`PLANET` (
  `planet_ID` VARCHAR(15) NOT NULL,
  `name` VARCHAR(20) NULL,
  `type` VARCHAR(20) NULL,
  `diameter` FLOAT NULL,
  `mass` FLOAT NULL,
  `orbit_radius` FLOAT NULL,
  `has_rings` TINYINT(1) NULL,
  `orbit_period` FLOAT NULL,
  `number_of_moons` INT NULL,
  `rotation_period` FLOAT NULL,
  PRIMARY KEY (`planet_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`MISSION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`MISSION` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`MISSION` (
  `mission_ID` CHAR(7) NOT NULL,
  `name` VARCHAR(20) NULL,
  `type` VARCHAR(20) NULL,
  `status` VARCHAR(15) NULL,
  `objective` VARCHAR(50) NULL,
  `planet_ID` VARCHAR(15) NULL,
  PRIMARY KEY (`mission_ID`),
  CONSTRAINT `fk_MISSION_PLANET1`
    FOREIGN KEY (`planet_ID`)
    REFERENCES `SpaceAgency`.`PLANET` (`planet_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_MISSION_PLANET1_idx` ON `SpaceAgency`.`MISSION` (`planet_ID` ASC) ;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`SPACECRAFT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`SPACECRAFT` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`SPACECRAFT` (
  `spacecraft_ID` VARCHAR(15) NOT NULL,
  `name` VARCHAR(20) NULL,
  `type` VARCHAR(20) NULL,
  `launch_pad` VARCHAR(15) NULL,
  `size` VARCHAR(15) NULL,
  `weight` VARCHAR(10) NULL,
  `status` VARCHAR(15) NULL,
  `power_source` VARCHAR(20) NULL,
  `c_people` INT NULL,
  `c_load` VARCHAR(10) NULL,
  PRIMARY KEY (`spacecraft_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`RESEARCH`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`RESEARCH` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`RESEARCH` (
  `research_ID` CHAR(9) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `type` VARCHAR(25) NOT NULL,
  `findings` VARCHAR(55) NULL,
  `publications_no` INT NULL,
  PRIMARY KEY (`research_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`ASSIGNED_TO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`ASSIGNED_TO` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`ASSIGNED_TO` (
  `mission_ID` CHAR(7) NOT NULL,
  `research_ID` CHAR(9) NOT NULL,
  PRIMARY KEY (`mission_ID`, `research_ID`),
  CONSTRAINT `fk_RESEARCH_has_MISSION_RESEARCH1`
    FOREIGN KEY (`research_ID`)
    REFERENCES `SpaceAgency`.`RESEARCH` (`research_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_RESEARCH_has_MISSION_MISSION1`
    FOREIGN KEY (`mission_ID`)
    REFERENCES `SpaceAgency`.`MISSION` (`mission_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_RESEARCH_has_MISSION_MISSION1_idx` ON `SpaceAgency`.`ASSIGNED_TO` (`mission_ID` ASC) ;

CREATE INDEX `fk_RESEARCH_has_MISSION_RESEARCH1_idx` ON `SpaceAgency`.`ASSIGNED_TO` (`research_ID` ASC) ;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`PARTICIPATE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`PARTICIPATE` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`PARTICIPATE` (
  `partner_org_code` CHAR(3) NOT NULL,
  `research_ID` CHAR(9) NOT NULL,
  `category` VARCHAR(20) NULL,
  PRIMARY KEY (`partner_org_code`, `research_ID`),
  CONSTRAINT `fk_partner_has_RESEARCH_partner1`
    FOREIGN KEY (`partner_org_code`)
    REFERENCES `SpaceAgency`.`PARTNER` (`org_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_partner_has_RESEARCH_RESEARCH1`
    FOREIGN KEY (`research_ID`)
    REFERENCES `SpaceAgency`.`RESEARCH` (`research_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_partner_has_RESEARCH_RESEARCH1_idx` ON `SpaceAgency`.`PARTICIPATE` (`research_ID` ASC) ;

CREATE INDEX `fk_partner_has_RESEARCH_partner1_idx` ON `SpaceAgency`.`PARTICIPATE` (`partner_org_code` ASC) ;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`TAKES_OFF`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`TAKES_OFF` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`TAKES_OFF` (
  `mission_ID` CHAR(7) NOT NULL,
  `spacecraft_ID` VARCHAR(15) NOT NULL,
  `launch_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`mission_ID`),
  CONSTRAINT `fk_TAKES_OFF_MISSION1`
    FOREIGN KEY (`mission_ID`)
    REFERENCES `SpaceAgency`.`MISSION` (`mission_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TAKES_OFF_SPACECRAFT1`
    FOREIGN KEY (`spacecraft_ID`)
    REFERENCES `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_TAKES_OFF_MISSION1_idx` ON `SpaceAgency`.`TAKES_OFF` (`mission_ID` ASC) ;

CREATE INDEX `fk_TAKES_OFF_SPACECRAFT1_idx` ON `SpaceAgency`.`TAKES_OFF` (`spacecraft_ID` ASC) ;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`CONDUCT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`CONDUCT` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`CONDUCT` (
  `equip_ID` CHAR(7) NULL,
  `research_ID` CHAR(9) NOT NULL,
  `staff_CIN` CHAR(10) NOT NULL,
  PRIMARY KEY (`staff_CIN`, `research_ID`),
  CONSTRAINT `fk_CONDUCT_EQUIPMENT1`
    FOREIGN KEY (`equip_ID`)
    REFERENCES `SpaceAgency`.`EQUIPMENT` (`equip_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CONDUCT_RESEARCH1`
    FOREIGN KEY (`research_ID`)
    REFERENCES `SpaceAgency`.`RESEARCH` (`research_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CONDUCT_STAFF1`
    FOREIGN KEY (`staff_CIN`)
    REFERENCES `SpaceAgency`.`STAFF` (`CIN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_CONDUCT_EQUIPMENT1_idx` ON `SpaceAgency`.`CONDUCT` (`equip_ID` ASC) ;

CREATE INDEX `fk_CONDUCT_RESEARCH1_idx` ON `SpaceAgency`.`CONDUCT` (`research_ID` ASC) ;

CREATE INDEX `fk_CONDUCT_STAFF1_idx` ON `SpaceAgency`.`CONDUCT` (`staff_CIN` ASC) ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`STAFF`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('64-9007802', 'Allyson', 'Leonid', 'Messenger', 'astronaut', 160403.67, '61', 'Chestnutwood Avenue', '28289', 'Charlotte', 'North Carolina', 'United States', 'F', '1979-10-03');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('67-7623129', 'Flynn', 'Quintin', 'Ballam', 'astronaut', 184421.68, '10', 'Firwood Lane', '43615', 'Toledo', 'Ohio', 'United States', 'M', '1967-10-08');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('27-3694387', 'Cathlene', 'Ibrahim', 'Allport', 'astronaut', 193121.41, '87', 'Hickorywood Court', '31296', 'Macon', 'Georgia', 'United States', 'F', '1995-04-03');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('85-0162062', 'Kliment', 'Thaddeus', 'Cosgriff', 'astronaut', 145432.7, '63', 'Birch Street', '88589', 'El Paso', 'Texas', 'United States', 'M', '1970-08-23');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('83-8514227', 'Arie', 'Haily', 'Edgworth', 'astronaut', 192860.33, '89', 'Magnolia Road', '19897', 'Wilmington', 'Delaware', 'United States', 'M', '1991-07-05');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('73-8388298', 'Even', 'Shem', 'Littlewood', 'astronaut', 95154.14, '83', 'Pine Road', '91328', 'Northridge', 'California', 'United States', 'M', '1997-11-28');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('61-3810579', 'Vincenz', 'Yorke', 'Robilart', 'astronaut', 169814.21, '33', 'Pine Road', '27615', 'Raleigh', 'North Carolina', 'United States', 'M', '1990-01-12');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('81-2202220', 'Ruperto', 'Torrance', 'Ratchford', 'astronaut', 191666.84, '57', 'Maplewood Street', '87105', 'Albuquerque', 'New Mexico', 'United States', 'M', '1991-06-26');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('80-1242102', 'Lane', 'Deane', 'Valiant', 'astronaut', 146088.32, '51', 'Sprucewood Avenue', '46862', 'Fort Wayne', 'Indiana', 'United States', 'M', '1984-11-24');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('54-7621370', 'Celeste', 'Huntlee', 'Ciccottini', 'astronaut', 188962.67, '53', 'Cherrywood Court', '90847', 'Long Beach', 'California', 'United States', 'F', '1987-11-01');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('30-1489321', 'Allister', 'Nicol', 'Reisen', 'astronaut', 48032.84, '34', 'Willow Court', '92725', 'Santa Ana', 'California', 'United States', 'M', '1995-11-21');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('65-2734289', 'Filippa', 'Ferdy', 'Bazeley', 'astronaut', 44823.34, '35', 'Bamboowood Lane', '60158', 'Carol Stream', 'Illinois', 'United States', 'F', '1976-10-12');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('52-9321681', 'Karon', 'Gunter', 'Petrusch', 'astronaut', 84851.1, '57', 'Banyan Lane', '18706', 'Wilkes Barre', 'Pennsylvania', 'United States', 'F', '1998-09-23');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('64-0634566', 'Nil', 'Zack', 'Starrs', 'astronaut', 167679.29, '14', 'Chestnutwood Avenue', '06145', 'Hartford', 'Connecticut', 'United States', 'M', '1996-02-22');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('57-1031173', 'Roby', 'Dillon', 'Woolfenden', 'astronaut', 45777.32, '8', 'Juniper Lane', '28305', 'Fayetteville', 'North Carolina', 'United States', 'F', '1973-08-29');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('30-0941335', 'Gwynne', 'Elia', 'Dorwood', 'astronaut', 145644.32, '65', 'Redwood Avenue', '40505', 'Lexington', 'Kentucky', 'United States', 'F', '1983-05-16');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('55-1454415', 'Andrey', 'Tad', 'Endrighi', 'astronaut', 165124.29, '85', 'Elm Court', '05609', 'Montpelier', 'Vermont', 'United States', 'M', '1978-09-29');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('02-7755209', 'Gare', 'Tanney', 'Letessier', 'astronaut', 43105.45, '64', 'Holly Court', '60663', 'Chicago', 'Illinois', 'United States', 'M', '1964-12-26');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('13-7647914', 'Gustave', 'Boris', 'Lodford', 'astronaut', 42267.29, '30', 'Cherrywood Court', '81005', 'Pueblo', 'Colorado', 'United States', 'M', '1966-08-18');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('24-9165353', 'Deedee', 'Alley', 'Graysmark', 'astronaut', 72981.33, '15', 'Mulberry Avenue', '10249', 'New York City', 'New York', 'United States', 'F', '1997-02-26');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('10-0450169', 'Cinnamon', 'Lyn', 'Swyre', 'astronaut', 130962, '67', 'Hollywood Avenue', '32304', 'Tallahassee', 'Florida', 'United States', 'F', '1973-06-10');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('01-2017908', 'Lay', 'Karney', 'Elliss', 'astronaut', 186205.15, '79', 'Cedar Court', '92822', 'Brea', 'California', 'United States', 'M', '1968-10-06');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('80-8982872', 'Blaine', 'Lancelot', 'Gabbott', 'astronaut', 177331.9, '33', 'Cypresswood Avenue', '55188', 'Saint Paul', 'Minnesota', 'United States', 'M', '1972-01-15');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('04-6762602', 'Novelia', 'Erhart', 'Armitt', 'astronaut', 43571.77, '25', 'Aspenwood Street', '97229', 'Portland', 'Oregon', 'United States', 'F', '1971-05-27');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('49-4767868', 'Benjie', 'Paul', 'Queyos', 'astronaut', 184546.67, '71', 'Holly Court', '30092', 'Norcross', 'Georgia', 'United States', 'M', '1966-09-20');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('02-4978077', 'Adaline', 'Knox', 'Camilli', 'astronaut', 113189.34, '59', 'Cedar Court', '19146', 'Philadelphia', 'Pennsylvania', 'United States', 'F', '1988-07-02');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('38-9099651', 'Suzie', 'Tremain', 'Thorndale', 'astronaut', 146502.12, '4', 'Fir Street', '80235', 'Denver', 'Colorado', 'United States', 'F', '1972-05-13');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('88-9216104', 'Selma', 'Dorie', 'Rothchild', 'astronaut', 124948.78, '55', 'Pine Road', '84605', 'Provo', 'Utah', 'United States', 'F', '1971-10-17');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('24-8971641', 'Faustina', 'Rutherford', 'Burgum', 'astronaut', 116862.09, '99', 'Juniper Lane', '94159', 'San Francisco', 'California', 'United States', 'F', '1981-06-17');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('22-0134416', 'Riccardo', 'Seward', 'Dovington', 'astronaut', 160200.11, '6', 'Mulberry Avenue', '64153', 'Kansas City', 'Missouri', 'United States', 'M', '1981-01-06');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('55-4318601', 'Raquela', 'Robers', 'Olliffe', 'astronaut', 96770.93, '8', 'Hollywood Avenue', '08619', 'Trenton', 'New Jersey', 'United States', 'F', '1979-02-14');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('88-6881200', 'Persis', 'Herbie', 'Geale', 'astronaut', 71062.32, '79', 'Cherrywood Court', '92153', 'San Diego', 'California', 'United States', 'F', '1970-05-24');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('35-7806470', 'Alie', 'Alonso', 'Wistance', 'astronaut', 86199.17, '78', 'Willow Court', '60630', 'Chicago', 'Illinois', 'United States', 'F', '1986-05-07');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('81-0631231', 'Truda', 'Orlando', 'Branche', 'astronaut', 82619.18, '15', 'Cedar Court', '20436', 'Washington', 'District of Columbia', 'United States', 'F', '1995-03-21');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('52-5452049', 'Malchy', 'Wallas', 'Lys', 'astronaut', 56181.97, '48', 'Willowwood Street', '33605', 'Tampa', 'Florida', 'United States', 'M', '1986-04-11');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('29-3898225', 'Marvin', 'Broderic', 'Abramowitch', 'astronaut', 194462.91, '71', 'Palmwood Street', '53285', 'Milwaukee', 'Wisconsin', 'United States', 'M', '1984-03-01');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('99-4413006', 'Beulah', 'Tomkin', 'Vaugham', 'astronaut', 110869.02, '35', 'Willow Court', '93762', 'Fresno', 'California', 'United States', 'F', '1972-10-26');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('46-8786546', 'Lilia', 'Flem', 'Lamping', 'astronaut', 109723.05, '14', 'Oakwood Avenue', '78250', 'San Antonio', 'Texas', 'United States', 'F', '1976-02-07');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('35-7240210', 'Janetta', 'Justis', 'Demko', 'attorney', 135018.98, '45', 'Mulberrywood Road', '12232', 'Albany', 'New York', 'United States', 'F', '1981-04-08');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('06-3939460', 'Damiano', 'Edik', 'Velde', 'attorney', 114043.38, '85', 'Willowwood Street', '55166', 'Saint Paul', 'Minnesota', 'United States', 'M', '1996-02-04');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('18-1154969', 'Lancelot', 'Mathew', 'Jerratsch', 'attorney', 63543.63, '87', 'Mulberry Avenue', '74184', 'Tulsa', 'Oklahoma', 'United States', 'M', '1976-08-13');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('32-9258513', 'Reagen', 'Beck', 'Pagden', 'attorney', 148260.77, '8', 'Chestnut Court', '79188', 'Amarillo', 'Texas', 'United States', 'M', '1976-02-04');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('19-0876311', 'Addie', 'Syd', 'Hasselby', 'attorney', 81446.06, '90', 'Cedar Lane', '70505', 'Lafayette', 'Louisiana', 'United States', 'M', '1986-08-07');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('86-6559540', 'Lisetta', 'Theo', 'Trenholm', 'attorney', 178856.74, '63', 'Sycamorewood Lane', '35810', 'Huntsville', 'Alabama', 'United States', 'F', '1962-01-09');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('21-6695943', 'Fernande', 'Gene', 'Hainey`', 'engineer', 114480.09, '21', 'Dogwood Road', '94237', 'Sacramento', 'California', 'United States', 'F', '1992-12-28');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('64-5009876', 'Oliy', 'Worthington', 'Norgate', 'engineer', 88772.71, '33', 'Bamboowood Lane', '92555', 'Moreno Valley', 'California', 'United States', 'F', '1976-06-10');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('55-4386644', 'Lyndel', 'Emmery', 'Tolhurst', 'engineer', 132588.98, '63', 'Cypress Court', '68517', 'Lincoln', 'Nebraska', 'United States', 'F', '1964-09-16');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('98-0932387', 'Malina', 'Sigfrid', 'Ellcome', 'engineer', 96175.27, '12', 'Poplarwood Road', '44485', 'Warren', 'Ohio', 'United States', 'F', '1967-09-18');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('27-4931367', 'Dennet', 'Talbot', 'Mongenot', 'engineer', 59394.81, '13', 'Holly Court', '30089', 'Decatur', 'Georgia', 'United States', 'M', '1991-08-07');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('58-9180119', 'Yul', 'Homerus', 'Mumbeson', 'engineer', 119442.51, '71', 'Chestnut Court', '45218', 'Cincinnati', 'Ohio', 'United States', 'M', '1963-11-20');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('39-6007322', 'Dulcia', 'Friedrich', 'Rosle', 'engineer', 52421.32, '92', 'Maple Street', '56372', 'Saint Cloud', 'Minnesota', 'United States', 'F', '1962-02-14');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('09-0656085', 'Clari', 'Wallas', 'St. Aubyn', 'engineer', 175301.24, '25', 'Maplewood Street', '46207', 'Indianapolis', 'Indiana', 'United States', 'F', '1984-01-18');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('74-4266414', 'Mace', 'Bertie', 'Eggleton', 'engineer', 82735.24, '80', 'Cedar Court', '44105', 'Cleveland', 'Ohio', 'United States', 'M', '1987-04-01');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('73-7409855', 'Melisande', 'Jaime', 'Pinnijar', 'engineer', 93822.61, '49', 'Beechwood Lane', '92640', 'Fullerton', 'California', 'United States', 'F', '1960-11-13');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('04-1985331', 'Barris', 'Rochester', 'Itscowics', 'engineer', 187520.74, '13', 'Juniperwood Court', '24024', 'Roanoke', 'Virginia', 'United States', 'M', '1985-12-25');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('69-7131770', 'Murielle', 'Wolfie', 'Joppich', 'inspector', 64773.34, '51', 'Maplewood Street', '18514', 'Scranton', 'Pennsylvania', 'United States', 'F', '1972-08-15');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('74-2586602', 'Rice', 'Joshua', 'Grealey', 'inspector', 146171.28, '100', 'Redwoodwood Road', '44191', 'Cleveland', 'Ohio', 'United States', 'M', '1971-05-05');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('64-3715292', 'Constantine', 'Aymer', 'Clacson', 'inspector', 185009.99, '52', 'Sycamore Avenue', '23277', 'Richmond', 'Virginia', 'United States', 'M', '1964-03-11');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('62-6558885', 'Adriaens', 'Troy', 'Race', 'inspector', 50535.99, '5', 'Spruce Court', '83716', 'Boise', 'Idaho', 'United States', 'F', '1975-10-17');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('01-8223240', 'Hanni', 'Reagen', 'Osgood', 'inspector', 92738.63, '51', 'Palmwood Street', '10150', 'New York City', 'New York', 'United States', 'F', '1971-06-08');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('66-9702024', 'Vail', 'Vincent', 'Brocklebank', 'inspector', 89660.28, '61', 'Mulberrywood Road', '31196', 'Atlanta', 'Georgia', 'United States', 'M', '1967-02-12');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('38-7726916', 'Camala', 'Isidor', 'Sturgeon', 'inspector', 162725.86, '33', 'Birch Street', '06510', 'New Haven', 'Connecticut', 'United States', 'F', '1962-05-04');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('70-1541734', 'Udale', 'Marcellus', 'Chicchetto', 'inspector', 69941.86, '11', 'Cherry Lane', '88574', 'El Paso', 'Texas', 'United States', 'M', '1984-11-11');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('04-4951183', 'Berkie', 'Alvy', 'Squeers', 'inspector', 71061.57, '90', 'Spruce Court', '19805', 'Wilmington', 'Delaware', 'United States', 'M', '1996-11-08');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('53-1327041', 'Arny', 'Mendy', 'Keeltagh', 'inspector', 128910.78, '35', 'Oak Avenue', '61605', 'Peoria', 'Illinois', 'United States', 'M', '1977-01-18');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('25-2274441', 'Anna', 'Giordano', 'Kelby', 'inspector', 158343.23, '29', 'Fir Street', '28278', 'Charlotte', 'North Carolina', 'United States', 'F', '1993-07-04');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('70-8215677', 'Mohammed', 'Bear', 'Gardener', 'inspector', 116984.66, '63', 'Willow Lane', '29225', 'Columbia', 'South Carolina', 'United States', 'M', '1978-05-02');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('58-9025839', 'Renae', 'Lucais', 'Da Costa', 'inspector', 116223.03, '70', 'Bamboowood Lane', '43610', 'Toledo', 'Ohio', 'United States', 'F', '1972-04-20');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('56-6820365', 'Chris', 'Lenci', 'Aitkenhead', 'inspector', 137990.56, '22', 'Spruce Court', '92105', 'San Diego', 'California', 'United States', 'F', '1994-11-15');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('09-0412327', 'Jarid', 'Brenden', 'Lanchester', 'inspector', 55309.54, '18', 'Banyan Lane', '77806', 'Bryan', 'Texas', 'United States', 'M', '1983-06-20');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('09-2059601', 'Dari', 'Barrett', 'Cruikshanks', 'inspector', 125474.85, '22', 'Firwood Lane', '78296', 'San Antonio', 'Texas', 'United States', 'F', '1987-09-01');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('53-1390712', 'Nester', 'Theodor', 'Cleare', 'scientist', 132673.21, '25', 'Beech Street', '90405', 'Santa Monica', 'California', 'United States', 'M', '1964-08-30');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('81-5042308', 'Eliza', 'Bret', 'O\'Quin', 'scientist', 60450.34, '7', 'Magnoliawood Street', '95823', 'Sacramento', 'California', 'United States', 'F', '1970-12-18');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('60-1726821', 'Genvieve', 'Findlay', 'McMearty', 'scientist', 49866.67, '54', 'Linden Street', '36628', 'Mobile', 'Alabama', 'United States', 'F', '1974-02-12');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('59-9735698', 'Dante', 'Averil', 'Mateo', 'scientist', 170632.66, '40', 'Pinewood Road', '72118', 'North Little Rock', 'Arkansas', 'United States', 'M', '1976-10-16');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('93-0617695', 'Bette', 'Erhart', 'Jewise', 'scientist', 63681.96, '19', 'Cypresswood Avenue', '15255', 'Pittsburgh', 'Pennsylvania', 'United States', 'F', '1998-04-12');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('25-5219638', 'Sid', 'Humphrey', 'Ferriby', 'scientist', 65413.66, '85', 'Lindenwood Lane', '98481', 'Tacoma', 'Washington', 'United States', 'M', '1991-11-15');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('76-5613174', 'Rollie', 'Matthus', 'Dowsey', 'scientist', 189301.25, '12', 'Willow Court', '95210', 'Stockton', 'California', 'United States', 'M', '1962-06-21');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('95-9095646', 'Floyd', 'Whit', 'Verissimo', 'scientist', 82134.19, '78', 'Chestnutwood Avenue', '63169', 'Saint Louis', 'Missouri', 'United States', 'M', '1961-07-06');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('42-2966590', 'Caria', 'Rube', 'Burgne', 'scientist', 183805.36, '49', 'Maple Street', '94121', 'San Francisco', 'California', 'United States', 'F', '1995-07-25');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('20-4628825', 'Clerissa', 'Hercule', 'Volk', 'scientist', 99023.95, '82', 'Cedar Court', '20508', 'Washington', 'District of Columbia', 'United States', 'F', '1967-12-01');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('17-5569241', 'Winthrop', 'Cole', 'McQuilty', 'scientist', 191395.3, '6', 'Mulberry Avenue', '29416', 'Charleston', 'South Carolina', 'United States', 'M', '1961-12-02');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('89-7594565', 'Margie', 'Obidiah', 'Alfonso', 'scientist', 76356.32, '17', 'Juniperwood Court', '55551', 'Young America', 'Minnesota', 'United States', 'F', '1961-03-10');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('15-3216599', 'Gerome', 'Price', 'Renzo', 'scientist', 102755.77, '44', 'Pinewood Road', '33245', 'Miami', 'Florida', 'United States', 'M', '1985-06-22');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('21-7823598', 'Phillie', 'Pietrek', 'Nornasell', 'scientist', 128894.62, '49', 'Fir Street', '66276', 'Shawnee Mission', 'Kansas', 'United States', 'F', '1963-04-12');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('31-9141984', 'Osmond', 'Lief', 'Boner', 'scientist', 47871.88, '92', 'Fir Street', '14276', 'Buffalo', 'New York', 'United States', 'M', '1975-11-25');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('83-0348398', 'Massimo', 'Nevin', 'Soutar', 'scientist', 85367.99, '75', 'Maplewood Street', '59806', 'Missoula', 'Montana', 'United States', 'M', '1969-03-20');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('46-0620883', 'Reade', 'Mano', 'Cullington', 'scientist', 138363.05, '82', 'Pine Road', '10464', 'Bronx', 'New York', 'United States', 'M', '1960-03-07');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('21-3933120', 'Harris', 'Paco', 'Dibling', 'scientist', 40303.43, '87', 'Beechwood Lane', '06120', 'Hartford', 'Connecticut', 'United States', 'M', '1983-02-26');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('84-1393635', 'Traver', 'Thorstein', 'Haylett', 'scientist', 86670.7, '95', 'Chestnutwood Avenue', '76096', 'Arlington', 'Texas', 'United States', 'M', '1971-01-24');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('63-3763851', 'Kelly', 'Pate', 'Hallex', 'scientist', 53197.61, '42', 'Palm Road', '85005', 'Phoenix', 'Arizona', 'United States', 'M', '1962-05-03');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('48-8062241', 'Roosevelt', 'Steve', 'Krzysztof', 'scientist', 69787.71, '68', 'Redwood Avenue', '20319', 'Washington', 'District of Columbia', 'United States', 'M', '1996-01-10');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('49-6487525', 'Elihu', 'Roberto', 'Dibbs', 'scientist', 151103.81, '6', 'Cypresswood Avenue', '44505', 'Youngstown', 'Ohio', 'United States', 'M', '1992-07-06');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('79-9284024', 'Dell', 'Alistair', 'Vials', 'scientist', 113129.71, '51', 'Pine Road', '10019', 'New York City', 'New York', 'United States', 'F', '1984-10-04');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('47-3890669', 'Elysee', 'Cleavland', 'Pozzi', 'technician', 166372.89, '4', 'Hollywood Avenue', '67205', 'Wichita', 'Kansas', 'United States', 'F', '1986-01-18');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('61-4123142', 'Brendin', 'Abdul', 'Abramamovh', 'technician', 197928.37, '15', 'Redwood Avenue', '65110', 'Jefferson City', 'Missouri', 'United States', 'M', '1969-11-03');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('94-1095370', 'Greta', 'Waylen', 'Chaize', 'technician', 161438.21, '98', 'Willow Court', '55407', 'Minneapolis', 'Minnesota', 'United States', 'F', '1961-12-15');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('46-2170683', 'Odey', 'Reinold', 'Faley', 'technician', 177936.61, '5', 'Birch Street', '12222', 'Albany', 'New York', 'United States', 'M', '1998-07-05');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('13-5368447', 'Jean', 'Otes', 'Lucchi', 'technician', 142214.79, '31', 'Willow Court', '46406', 'Gary', 'Indiana', 'United States', 'F', '1971-12-29');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`, `birth_date`) VALUES ('92-7891063', 'Luci', 'Verney', 'Chaim', 'technician', 148301.03, '29', 'Willow Lane', '80127', 'Littleton', 'Colorado', 'United States', 'F', '1996-10-08');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`PARTNER`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('1', 'Trilith', '787 Norway Maple Parkway', 'rvardie0@miitbeian.gov.cn', '826-141-8448');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('2', 'Riffpedia', '601 Lotheville Center', 'lkentwell1@icq.com', '489-821-3773');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('3', 'Brainverse', '832 David Avenue', 'ytague2@goodreads.com', '288-229-1619');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('4', 'Trilith', '558 Carey Park', 'rvandermerwe3@mac.com', '853-911-8471');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('5', 'Topiclounge', '80 Kipling Way', 'uhedau4@washingtonpost.com', '967-144-9434');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('6', 'Chatterbridge', '62 Sugar Trail', 'ltolussi5@foxnews.com', '269-982-5853');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('7', 'Brainverse', '51597 Sutherland Circle', 'atreadaway6@list-manage.com', '753-358-1388');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('8', 'Zoomcast', '33 Dahle Place', 'rcrosseland7@ihg.com', '699-452-8285');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('9', 'Roodel', '1 Golf View Hill', 'tdeneve8@harvard.edu', '149-773-2655');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('10', 'Skipfire', '01 2nd Street', 'npllu9@amazon.com', '603-546-8265');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('11', 'Meeveo', '61989 Nelson Center', 'ckoppa@technorati.com', '808-993-0818');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('12', 'Skippad', '4 Harbort Pass', 'bfincib@epa.gov', '776-614-9981');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('13', 'Avamm', '51 Vernon Crossing', 'jpotellc@wufoo.com', '715-994-2599');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('14', 'InnoZ', '08341 Gerald Circle', 'celmhirstd@noaa.gov', '609-721-6987');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('15', 'Voonder', '49 Muir Street', 'tlockhurste@t-online.de', '923-241-8921');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('16', 'Quimm', '39 Summer Ridge Street', 'jraistonf@51.la', '527-902-1596');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('17', 'Skyvu', '53 Pleasure Park', 'wcapelg@posterous.com', '330-682-2106');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('18', 'Oba', '25 Ryan Road', 'iainsworthh@odnoklassniki.ru', '923-573-7878');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('19', 'Brainverse', '690 Moland Crossing', 'posbandi@china.com.cn', '840-292-5481');
INSERT INTO `SpaceAgency`.`PARTNER` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('20', 'Wikibox', '69516 Vahlen Circle', 'ldimblebeej@engadget.com', '228-712-5189');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`EQUIPMENT`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('b15acs2', 'Vanguard 1', 'decommissioned', 'communication', 'USA', 'satellite', '11');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('9PS22A7', 'Hubble Space satallite', 'active', 'analysis', 'Brazil', 'satellite', '12');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('8b0NgsO', 'International Space', 'active', 'analysis', 'Japan', 'satellite', '13');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('0lb70fe', 'GOES-16', 'active', 'analysis', 'Mexico', 'satellite', '14');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('543uD8T', 'TerraSAR-X', 'active', 'analysis', 'Canada', 'satellite', '15');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('YwG5t5S', 'Aqua', 'decommissioned', 'analysis', 'Mexico', 'satellite', '16');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('dG3Ka8e', 'Chandrayaan-2', 'decommissioned', 'analysis', 'Brazil', 'satellite', '17');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('Njy0K0w', 'Fengyun-4A', 'decommissioned', 'analysis', 'Japan', 'satellite', '18');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('jBEhJP3', 'TESS', 'decommissioned', 'analysis', 'Mexico', 'satellite', '19');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('t6b1WCX', 'RADARSAT-2', 'active', 'communication', 'Mexico', 'satellite', '20');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('Ui37A19', 'Amos-17', 'decommissioned', 'communication', 'Mexico', 'satellite', '11');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('H89GC23', 'Kepler Space', 'active', 'communication', 'Japan', 'satellite', '12');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('tm1929c', 'GPS IIR-20', 'active', 'communication', 'Mexico', 'satellite', '13');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('tFP4rx7', 'Swift', 'active', 'communication', 'Germany', 'satellite', '14');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('qsM2oMU', 'Landsat 8', 'active', 'communication', 'Japan', 'satellite', '15');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('KyfWK86', 'Gaia', 'decommissioned', 'communication', 'Brazil', 'satellite', '16');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('491bEHu', 'Electron Microscope', 'active', 'compound', 'Mexico', 'microscope', '17');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('LUP1f90', 'Transmission', 'active', 'compound', 'Germany', 'microscope', '18');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('23A5T8H', 'Atomic Force', 'active', 'compound', 'USA', 'microscope', '19');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('7kcYTzM', 'Scanning Tunneling', 'decommissioned', 'compound', 'Mexico', 'microscope', '20');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('6h7246F', 'Phase-Contrast', 'decommissioned', 'compound', 'Mexico', 'microscope', '11');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('Lb6j7BC', 'Hubble Space', 'active', 'cosmic', 'Mexico', 'spectrograph', '12');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('yAM7LV3', 'Keck Observatory', 'active', 'cosmic', 'USA', 'spectrograph', '13');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('e7QuS70', 'Gemini Observatory', 'decommissioned', 'cosmic', 'USA', 'spectrograph', '14');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('T074Lyu', 'Subaru Telescope', 'decommissioned', 'cosmic', 'Germany', 'spectrograph', '15');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('2L9CEm6', 'Chandra X-ray', 'decommissioned', 'cosmic', 'Germany', 'spectrograph', '16');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('p894cbv', 'European Southern', 'decommissioned', 'cosmic', 'Japan', 'spectrograph', '17');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('2iE8BvN', 'Magellan Telescopes', 'decommissioned', 'cosmic', 'Brazil', 'spectrograph', '18');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('8tZqz3q', 'Apache Point', 'decommissioned', 'cosmic', 'Canada', 'spectrograph', '19');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('s554crG', 'Hubble Space Telescope', 'active', 'Earth_Based', 'Germany', 'telescope', '20');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('jU5OTKZ', 'Proton-4', 'decommissioned', 'Earth_Based', 'Canada', 'telescope', '11');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('8XUm7jG', 'Cos-B', 'decommissioned', 'Earth_Based', 'USA', 'telescope', '12');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('A28P3f1', 'Granat', 'decommissioned', 'Earth_Based', 'USA', 'telescope', '13');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('ABN6bLW', 'LEGRI', 'decommissioned', 'Earth_Based', 'Japan', 'telescope', '14');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('ny3ZGoT', 'INTEGRAL', 'decommissioned', 'Earth_Based', 'Germany', 'telescope', '15');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('11540t6', 'Swift Gamma Ray Explorer', 'active', 'Earth_Based', 'Mexico', 'telescope', '16');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('f09aZ5B', 'AGILE', 'active', 'Earth_Based', 'Canada', 'telescope', '17');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('Bavk053', 'Scanning Electron', 'decommissioned', 'light', 'Germany', 'microscope', '18');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('I0K2r5s', 'Fluorescence', 'decommissioned', 'light', 'Mexico', 'microscope', '19');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('k86354G', 'Confocal', 'active', 'light', 'Brazil', 'microscope', '20');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('28324H7', 'Dark-Field', 'active', 'light', 'USA', 'microscope', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('7FTYDL5', 'Super-Resolution', 'active', 'light', 'Canada', 'microscope', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('8Y3d29H', 'Light Microscope', 'active', 'simple', 'Canada', 'microscope', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('LtbAY6n', 'Proton-1', 'active', 'Space_Based', 'Canada', 'telescope', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('F3wSNz9', 'Proton-2', 'decommissioned', 'Space_Based', 'Germany', 'telescope', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('0B3N2ml', 'SAS-B', 'decommissioned', 'Space_Based', 'USA', 'telescope', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('lJizTZe', 'HEAO 3', 'active', 'Space_Based', 'USA', 'telescope', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('ngXl473', 'Gamma', 'active', 'Space_Based', 'USA', 'telescope', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('5bEjLbH', 'CGRO', 'decommissioned', 'Space_Based', 'USA', 'telescope', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('bKli3B9', 'HETE 2', 'decommissioned', 'Space_Based', 'Mexico', 'telescope', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('5P8hrtM', 'Fermi Gamma-ray Telescope', 'decommissioned', 'Space_Based', 'Canada', 'telescope', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('rwhD3bC', 'SOHO', 'active', 'Survey', 'Brazil', 'camera', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('06yKN2E', 'New Horizons', 'decommissioned', 'Survey', 'Brazil', 'camera', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('Uf316p9', 'Lunar Reconnaissance', 'decommissioned', 'Survey', 'USA', 'camera', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('MJ5dTD5', 'Kepler Space', 'decommissioned', 'Survey', 'Japan', 'camera', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('oSt1ncS', 'Gaia spacecraft', 'decommissioned', 'Survey', 'Canada', 'camera', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('ntJ57V9', 'Kepler Space', 'active', 'Survey', 'Mexico', 'camera', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `kind`, `partner_org_code`) VALUES ('VF0roU2', 'Cassini spacecraft', 'decommissioned', 'Wide field', 'Brazil', 'camera', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`PLANET`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID1098', 'Mercury', 'terrestrial', 17111.79, 477802690197.62, 877866.0, false, 56861.06, 41, 19.82);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID9876', 'Venus', 'terrestrial', 41923.54, 176615018347.31, 964734.12, true, 89321.86, 46, 10.61);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID3210', 'Earth', 'terrestrial', 17867.51, 651914057793.64, 216948.31, true, 36772.74, 34, 11.3);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID6789', 'Jupiter', 'terrestrial', 46616.38, 966870912485.7, 950215.82, false, 4700.38, 1, 5.61);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID7890', 'Uranus', 'gas giant', 8560.72, 440110935277.72, 193715.53, false, 40193.49, 17, 16.8);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID3456', 'Neptune', 'terrestrial', 25989.25, 515982942264.91, 677801.12, false, 51416.51, 4, 22.27);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID7654', 'Pluto', 'terrestrial', 34198.19, 80550302965.44, 292911.2, true, 45023.65, 42, 11.06);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID8901', 'Haumea', 'gas giant', 46411.94, 133488813133.44, 532490.91, false, 9127.77, 9, 12.59);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID0123', 'Makemake', 'terrestrial', 40556.08, 227518086760.37, 548849.32, true, 30532.89, 12, 11.7);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID0987', 'Kepler-452b', 'gas giant', 35445.74, 975027055724.57, 699117.98, false, 61610.68, 14, 6.29);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID4321', 'HD 209458 b', 'terrestrial', 32645.22, 183994481624.76, 617766.5, true, 40774.22, 4, 16.93);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID6543', 'WASP-12b', 'gas giant', 37772.23, 455866997707.53, 486338.15, true, 17642.36, 23, 2.36);
INSERT INTO `SpaceAgency`.`PLANET` (`planet_ID`, `name`, `type`, `diameter`, `mass`, `orbit_radius`, `has_rings`, `orbit_period`, `number_of_moons`, `rotation_period`) VALUES ('ID8765', 'K2-18b', 'gas giant', 17538.98, 971952459284.97, 155255.84, true, 42782.35, 2, 11.21);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`MISSION`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('XQY-234', 'Pathfinder', 'Asteroid Deflection', 'past', 'Data Collection', 'ID0123');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('IYS-055', 'InSight', 'Analog Field Testing', 'active', 'Exploration', 'ID0123');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('BQI-280', 'Opportunity', 'Atmospheric Probe', 'past', 'Experimentation', 'ID0987');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('RAD-468', 'Kepler', 'Analog Field Testing', 'future', 'Exploration', 'ID0987');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('QDP-979', 'Apollo 11', 'Balloon', 'future', 'Exploration', 'ID1098');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('VMZ-422', 'Pioneer 10', 'Analog Field Testing', 'active', 'Experimentation', 'ID1098');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('YUG-796', 'Curiosity', 'Analog Field Testing', 'past', 'Exploration', 'ID3210');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('LPE-268', 'Galileo', 'Commercial Resupply', 'active', 'Communication', 'ID3456');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('JOM-249', 'Mars Surveyor', 'Airborne Science', 'future', 'Data Collection', 'ID3456');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('SDL-405', 'Mariner 4', 'Balloon', 'active', 'Research', 'ID4321');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('NWZ-562', 'Juno', 'Commercial Crew', 'past', 'Experimentation', 'ID4321');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('HUK-516', 'Venera 7', 'Commercial Crew', 'future', 'Communication', 'ID6543');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('MUI-743', 'Challenger', 'Commercial Crew', 'active', 'Exploration', 'ID6789');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('GHW-858', 'Rosetta', 'Commercial Crew', 'active', 'Communication', 'ID6789');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('TJU-911', 'Spirit', 'Asteroid Deflection', 'active', 'Communication', 'ID7654');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('BMA-097', 'Mars Orbiter', 'Analog Field Testing', 'active', 'Communication', 'ID7890');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('TSU-734', 'Pioneer Venus ', 'Commercial Resupply', 'future', 'Communication', 'ID7890');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('QMP-518', 'Voyager 2', 'Analog Field Testing', 'past', 'Exploration', 'ID8765');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('NQS-894', 'Chang\'e 3', 'Airborne Science', 'future', 'Communication', 'ID8901');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('DYB-158', 'Voyager 1', 'Analog Field Testing', 'past', 'Exploration', 'ID9876');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('ATV-529', 'Viking 1', 'Analog Field Testing', 'future', 'Data Collection', NULL);
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('RHP-391', 'Cassini', 'Atmospheric Probe', 'future', 'Research', NULL);
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('GQC-927', 'Hubble', 'Asteroid Deflection', 'past', 'Research', NULL);
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('OEC-003', 'New Horizons', 'Commercial Resupply', 'active', 'Research', NULL);
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('ANN-576', 'Messenger', 'Atmospheric Probe', 'future', 'Experimentation', NULL);
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('BBX-908', 'Sputnik 1', 'Commercial Resupply', 'future', 'Research', NULL);
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('YHH-824', 'Dawn', 'Balloon', 'past', 'Communication', NULL);
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('QGO-610', 'Mars Express', 'Commercial Crew', 'active', 'Research', NULL);
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('BVI-182', 'Hayabusa', 'Commercial Resupply', 'future', 'Research', NULL);
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('ETJ-154', 'Clementine', 'Asteroid Deflection', 'past', 'Research', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`SPACECRAFT`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('EYW-126-AX', 'Apollo 11', 'rover', 'LC-39A', 'small', '1000 kg', 'active', 'solar', 0, '313');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('VHB-453-FG', 'Voyager 1', 'space probe', 'LC-40', 'medium', '1500 kg', 'lost', 'nuclear', 0, '90');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('BPA-988-TY', 'Curiosity', 'crewedspacecraft', 'SLC-40', 'large', '2000 kg', 'active', 'solar', 7, '396');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('VMN-354-NB', 'Hubble', 'auto', 'SLC-41', 'extra small', '2500 kg', 'active', 'nuclear', 0, '86');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('HWU-880-IR', 'Challenger', 'rover', 'LC-11', 'extra large', '3000 kg', 'lost', 'solar', 0, '580');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('PTY-185-RY', 'Columbia', 'space probe', 'LC-22', 'tiny', '3500 kg', 'retired', 'nuclear', 0, '358');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('YXJ-464-RU', 'Discovery', 'crewedspacecraft', 'SLC-9', 'gigantic', '4000 kg', 'active', 'solar', 7, '2');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('GNP-234-YZ', 'Endeavour', 'auto', 'LC-17', 'compact', '4500 kg', 'lost', 'nuclear', 0, '59');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('BAY-529-YE', 'Atlantis', 'rover', 'SLC-6', 'oversized', '5000 kg', 'retired', 'solar', 0, '302');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('PMV-163-DP', 'Gemini 7', 'space probe', 'LC-31', 'miniature', '5500 kg', 'active', 'nuclear', 0, '775');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('ZZQ-767-NO', 'Mercury-Redstone 3', 'crewedspacecraft', 'LC-55', 'massive', '6000 kg', 'lost', 'solar', 4, '740');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('OUZ-894-VM', 'Gemini 12', 'auto', 'SLC-2', 'petite', '6500 kg', 'retired', 'nuclear', 0, '551');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('GHG-890-RJ', 'Apollo 13', 'rover', 'LC-77', 'jumbo', '7000 kg', 'active', 'solar', 0, '271');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('VXD-817-GU', 'Skylab', 'space probe', 'LC-88', 'colossal', '7500 kg', 'lost', 'nuclear', 0, '693');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('MRX-617-ER', 'Pioneer 10', 'crewedspacecraft', 'SLC-13', 'microscopic', '8000 kg', 'active', 'solar', 7, '360');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('AUJ-238-WG', 'Viking 1', 'auto', 'LC-66', 'enormous', '8500 kg', 'active', 'nuclear', 0, '811');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('IKA-796-QD', 'Voyager 2', 'rover', 'LC-44', 'dainty', '9000 kg', 'lost', 'solar', 0, '1000');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('VUM-715-UY', 'Galileo', 'space probe', 'SLC-19', 'huge', '9500 kg', 'retired', 'nuclear', 0, '877');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('WSJ-228-AN', 'Cassini', 'crewedspacecraft', 'LC-25', 'minuscule', '10000 kg', 'active', 'solar', 7, '740');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('PQN-008-YO', 'New Horizons', 'auto', 'LC-33', 'giant', '10500 kg', 'lost', 'nuclear', 0, '548');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('PAU-404-JY', 'Juno', 'rover', 'SLC-8', 'titanic', '11000 kg', 'retired', 'solar', 0, '977');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('RDM-561-KT', 'Mars Express', 'space probe', 'LC-99', 'diminutive', '11500 kg', 'active', 'nuclear', 0, '186');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('ZXB-309-LF', 'Spitzer', 'crewedspacecraft', 'LC-12', 'immense', '12000 kg', 'lost', 'solar', 5, '555');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('NZU-400-CZ', 'Kepler', 'auto', 'SLC-16', 'puny', '12500 kg', 'retired', 'nuclear', 0, '988');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('NQP-956-XV', 'Chandra', 'rover', 'LC-71', 'monumental', '13000 kg', 'active', 'solar', 0, '597');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('CSE-773-JU', 'Rosetta', 'space probe', 'LC-49', 'wee', '13500 kg', 'lost', 'nuclear', 0, '994');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('SSU-171-LL', 'Dawn', 'crewedspacecraft', 'SLC-27', 'vast', '14000 kg', 'retired', 'solar', 4, '96');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('IUC-144-SX', 'Messenger', 'auto', 'LC-62', 'mammoth', '14500 kg', 'active', 'nuclear', 0, '998');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('CUW-635-BC', 'Hayabusa', 'rover', 'LC-14', 'dwarf', '15000 kg', 'lost', 'solar', 0, '871');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`) VALUES ('QLK-027-SF', 'Parker Solar Probe', 'space probe', 'SLC-36', 'mighty', '15500 kg', 'retired', 'nuclear', 0, '480');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`RESEARCH`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('FZGCL-837', 'Astrobiology and Planetary Habitability', 'Astroentomology', 'Exploration of Saturn\'s rings', 15);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('LADLZ-358', 'Planetary Magnetospheres', 'Astrophysics', 'Investigation of the Martian moons', 22);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('QTBBK-631', 'Extraterrestrial Life Search', 'Astrozoology', 'Analysis of the geology of Jupiter\'s moon Io', 38);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('RKFNN-331', 'Spacecraft Propulsion Systems', 'Astrochemistry', 'Analysis of the geology of Saturn\'s moon Titan', 74);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('EZQRY-934', 'Astrodynamics and Orbital Mechanics', 'Astroengineering', 'Detection of gravitational waves', 62);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('NRALG-556', 'Spacecraft Thermal Control', 'Astroglaciology', 'Study of the formation of pulsars', 27);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('FYOIB-446', 'Spacecraft Guidance and Control', 'Exoplanet Research', 'Study of the effects of microgravity on plant growth', 65);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('YAJLM-820', 'Space Situational Awareness', 'Astroanthropology', 'Analysis of the composition of meteorites', 92);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('LUHVA-053', 'Space Weather Forecasting', 'Astrovolcanology', 'Investigation of the history of Mars\' magnetic field', 89);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('SIPQR-830', 'Astrophotography and Image Processing', 'Astrohistory', 'Understanding the process of star formation', 14);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('TPFPG-603', 'Spacecraft Instrumentation Development', 'Astroethics', 'Research on the formation of lunar craters', 78);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('FICMA-763', 'Spaceborne Spectroscopy', 'Astrobiology', 'Identification of potential asteroid threats to Earth', 14);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('BZGEZ-117', 'Earth Observation and Remote Sensing', 'Planetary Science', 'Research on the formation of supermassive black holes', 65);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('CPDSW-020', 'Astrobiology and Planetary Astrobiology', 'Astrovolcanology', 'Understanding the process of star formation', 37);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('KBDYQ-361', 'Astrogeology and Planetary Mapping', 'Astrojournalism', 'Observation of the Great Red Spot on Jupiter', 48);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('NXWOM-125', 'Exoplanet Discovery', 'Astrocinematography', 'Investigation of the possibility of life on Europa', 2);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('FPGTV-201', 'Astrogeology and Planetary Mapping', 'Astrovolcanology', 'Investigation of the history of water on Europa', 100);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('YBNCZ-526', 'Astrobiology and Prebiotic Chemistry', 'Astrocinematography', 'Research on the formation of supermassive black holes', 21);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('RMPJT-291', 'Space Weather Monitoring', 'Astrozoology', 'Identification of water on Mars', 96);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('NMTDX-474', 'Planetary Radar Imaging', 'Astroglaciology', 'Investigation of the Martian tectonic activity', 68);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('FECEY-255', 'Astronomy and Astrophysics Research', 'Astrophysics', 'Understanding the process of planetary migration', 76);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('MPMUA-611', 'Astrobiology and Prebiotic Chemistry', 'Astroglaciology', 'Investigation of the history of water on Europa', 75);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('PTCMJ-513', 'Space Debris Mitigation', 'Astrophysics', 'Analysis of cosmic rays', 63);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('BXFAI-894', 'Spacecraft Thermal Control', 'Astroinformatics', 'Research on the formation of lunar craters', 91);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('NKUOD-777', 'Spaceborne Spectroscopy', 'Astrogeology', 'Study of the Sun\'s magnetic field', 85);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('KTRYX-765', 'Astrobiology and Planetary Astrobiology', 'Astroart', 'Identification of potential asteroid threats to Earth', 65);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('HJVBJ-972', 'Astroengineering and Space Architecture', 'Astrogeography', 'Evidence of past microbial life on Mars', 12);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('IKEAA-464', 'Study of Lunar Surface', 'Astrostatistics', 'Study of the formation of pulsars', 98);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('KCKPR-539', 'Spacecraft Attitude Determination and Control', 'Astrostatistics', 'Investigation of the Martian tectonic activity', 64);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('OOUAS-048', 'Astrobiology and Astroecology', 'Astrovolcanology', 'Study of the atmospheres of gas giants', 50);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('WQTWO-629', 'Extraterrestrial Life Search', 'Astrobotany', 'Exploration of the Kuiper Belt', 19);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('PWCPK-273', 'Planetary Magnetospheres', 'Astroarchaeology', 'Study of the effects of microgravity on plant growth', 57);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('EKLKK-154', 'Astronomy and Astrophysics Research', 'Astroarchaeology', 'Exploration of the magnetospheres of gas giants', 74);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('JUTIO-667', 'Planetary Ices and Volatiles', 'Astrobiology', 'Investigation of the origins of the universe', 67);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('HTFSX-858', 'Astrobiology and Planetary Astrobiology', 'Astronomy', 'Understanding the process of star formation', 51);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('LUAZU-502', 'Study of Lunar Surface', 'Astrocinematography', 'Understanding the solar wind', 32);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('OFQQR-778', 'Spacecraft Telecommunications', 'Astrooceanography', 'Study of the atmospheres of icy moons', 42);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('VMMOT-286', 'Astrodynamics and Orbital Mechanics', 'Astroanthropology', 'Research on the formation of lunar craters', 69);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('GGQIH-713', 'Planetary Rings and Dust', 'Astroinformatics', 'Analysis of the composition of interstellar dust', 100);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('NOGXO-892', 'Extraterrestrial Life Search', 'Astrogeography', 'Investigation of the Martian dust storms', 50);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('MKXMV-148', 'Astrobiology and Planetary Evolution', 'Astroinformatics', 'Study of the effects of microgravity on plant growth', 21);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('ZLSCR-009', 'Climate Change Studies', 'Astrobiology', 'Study of the interstellar medium', 40);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('QLJJW-200', 'Planetary Atmospheres and Climate', 'Astroanthropology', 'Exploration of the interstellar magnetic field', 73);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('BKTRA-001', 'Solar System Exploration', 'Planetary Science', 'Exploration of the asteroid belt', 94);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('OZGFD-178', 'Interstellar Medium Studies', 'Astroinformatics', 'Understanding the process of galactic collisions', 31);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('QBDFO-917', 'Astrobiology and Astroecology', 'Astroecology', 'Analysis of the geology of Saturn\'s moon Titan', 58);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('AQNDR-334', 'Earth Observation and Remote Sensing', 'Astroengineering', 'Research on the effects of space debris on satellites', 26);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('LGTCW-484', 'Spacecraft Power Systems', 'Astrogeography', 'Research on the formation of stars and galaxies', 39);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('NFTVD-129', 'Spacecraft Guidance and Control', 'Astrobotany', 'Research on the formation of lunar craters', 11);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('HGIWJ-587', 'Planetary Protection Research', 'Exoplanet Research', 'Study of the atmospheres of terrestrial planets', 44);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('VNCVZ-052', 'Spacecraft Data Handling and Storage', 'Astroarchaeology', 'Study of the effects of microgravity on plant growth', 55);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('LJGHA-810', 'Planetary Radar Imaging', 'Astrohistory', 'Investigation of the Martian moons', 37);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('OCYWA-974', 'Spacecraft Instrumentation Development', 'Astrophysics', 'Study of the Sun\'s magnetic field', 8);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('IXDEL-779', 'Astrochemistry Investigations', 'Astrooceanography', 'Analysis of the composition of comets', 33);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('MJSAD-727', 'Space Situational Awareness', 'Astrovolcanology', 'Exploration of the interstellar magnetic field', 58);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('PDGNN-003', 'Space Weather Monitoring', 'Astroeducation', 'Investigation of the possibility of life on Europa', 50);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('WXLTQ-093', 'Planetary Cratering and Impact Processes', 'Astrobiology', 'Analysis of the composition of interstellar dust', 10);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('KBTUW-621', 'Spacecraft Avionics Systems', 'Astrostatistics', 'Analysis of the composition of interplanetary dust', 32);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('RVPAU-960', 'Planetary Volcanology', 'Astrovolcanology', 'Investigation of the possibility of life on Europa', 63);
INSERT INTO `SpaceAgency`.`RESEARCH` (`research_ID`, `name`, `type`, `findings`, `publications_no`) VALUES ('IQFJW-738', 'Space Telescopes and Observatories', 'Space Weather', 'Investigation of the Van Allen radiation belts', 79);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`ASSIGNED_TO`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('XQY-234', 'RMPJT-291');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('IYS-055', 'NMTDX-474');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('BQI-280', 'FECEY-255');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('RAD-468', 'MPMUA-611');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('QDP-979', 'PTCMJ-513');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('VMZ-422', 'BXFAI-894');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('YUG-796', 'NKUOD-777');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('LPE-268', 'KTRYX-765');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('JOM-249', 'HJVBJ-972');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('SDL-405', 'IKEAA-464');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('NWZ-562', 'KCKPR-539');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('HUK-516', 'OOUAS-048');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('MUI-743', 'WQTWO-629');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('GHW-858', 'PWCPK-273');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('TJU-911', 'EKLKK-154');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('BMA-097', 'JUTIO-667');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('TSU-734', 'HTFSX-858');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('QMP-518', 'LUAZU-502');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('NQS-894', 'OFQQR-778');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('DYB-158', 'VMMOT-286');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('ATV-529', 'GGQIH-713');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('RHP-391', 'NOGXO-892');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('GQC-927', 'MKXMV-148');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('OEC-003', 'ZLSCR-009');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('ANN-576', 'QLJJW-200');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('BBX-908', 'BKTRA-001');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('YHH-824', 'OZGFD-178');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('QGO-610', 'QBDFO-917');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('BVI-182', 'QBDFO-917');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('ETJ-154', 'QBDFO-917');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('GQC-927', 'FZGCL-837');
INSERT INTO `SpaceAgency`.`ASSIGNED_TO` (`mission_ID`, `research_ID`) VALUES ('GQC-927', 'LADLZ-358');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`PARTICIPATE`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('1', 'FZGCL-837', 'Observer');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('1', 'LADLZ-358', 'Data collector');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('1', 'QTBBK-631', 'Case study subject');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('2', 'RKFNN-331', 'Experimental member');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('2', 'EZQRY-934', 'Survey respondent');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('2', 'NRALG-556', 'Observer');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('3', 'FYOIB-446', 'financial care');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('3', 'YAJLM-820', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('3', 'LUHVA-053', 'Experimental member');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('4', 'SIPQR-830', 'Case study subject');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('4', 'TPFPG-603', 'Experimental member');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('4', 'FICMA-763', 'Observer');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('5', 'BZGEZ-117', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('5', 'CPDSW-020', 'financial care');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('5', 'KBDYQ-361', 'financial care');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('6', 'NXWOM-125', 'Data collector');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('6', 'FPGTV-201', 'financial care');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('6', 'YBNCZ-526', 'Survey respondent');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('7', 'RMPJT-291', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('7', 'NMTDX-474', 'Case study subject');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('7', 'FECEY-255', 'Case study subject');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('8', 'MPMUA-611', 'financial care');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('8', 'PTCMJ-513', 'Research assistant');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('8', 'BXFAI-894', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('9', 'NKUOD-777', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('9', 'KTRYX-765', 'Observer');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('9', 'HJVBJ-972', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('10', 'IKEAA-464', 'financial care');
INSERT INTO `SpaceAgency`.`PARTICIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('10', 'KCKPR-539', 'Participant observer');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`TAKES_OFF`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('XQY-234', 'EYW-126-AX', '2019-07-20', '2024-07-20');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('IYS-055', 'BPA-988-TY', '2014-09-26', '2024-02-25');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('BQI-280', 'YXJ-464-RU', '2005-08-02', '2024-11-18');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('RAD-468', 'BPA-988-TY', '2006-11-03', '2025-02-22');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('QDP-979', 'YXJ-464-RU', '2015-05-23', '2024-12-17');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('VMZ-422', 'BPA-988-TY', '2014-06-18', '2021-12-17');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('YUG-796', 'YXJ-464-RU', '2009-01-28', '2022-04-01');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('LPE-268', 'YXJ-464-RU', '2006-03-17', '2025-09-08');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('JOM-249', 'BAY-529-YE', '2005-07-25', '2022-05-03');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('SDL-405', 'BPA-988-TY', '2011-09-17', '2024-05-20');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('NWZ-562', 'ZZQ-767-NO', '2008-04-26', '2024-02-28');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('HUK-516', 'OUZ-894-VM', '2015-05-28', '2025-06-01');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('MUI-743', 'BPA-988-TY', '2013-12-22', '2021-12-20');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('GHW-858', 'YXJ-464-RU', '2010-08-22', '2025-10-29');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('TJU-911', 'BPA-988-TY', '2009-06-10', '2025-02-07');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('BMA-097', 'YXJ-464-RU', '2008-07-05', '2023-06-12');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('TSU-734', 'MRX-617-ER', '2018-06-18', '2021-01-21');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('QMP-518', 'WSJ-228-AN', '2010-12-11', '2022-02-16');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('NQS-894', 'MRX-617-ER', '2017-12-31', '2024-02-01');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('DYB-158', 'WSJ-228-AN', '2010-03-02', '2024-11-08');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('ATV-529', 'MRX-617-ER', '2019-04-02', '2022-06-29');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('RHP-391', 'WSJ-228-AN', '2010-06-27', '2024-03-27');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('GQC-927', 'WSJ-228-AN', '2013-02-01', '2025-01-16');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('OEC-003', 'NZU-400-CZ', '2007-08-09', '2023-11-24');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('ANN-576', 'NQP-956-XV', '2008-01-25', '2021-02-20');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('BBX-908', 'MRX-617-ER', '2008-10-10', '2023-01-06');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('YHH-824', 'SSU-171-LL', '2006-03-04', '2024-08-23');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('QGO-610', 'MRX-617-ER', '2009-01-18', '2024-09-20');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('BVI-182', 'CUW-635-BC', '2006-07-03', '2023-11-07');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('ETJ-154', 'MRX-617-ER', '2008-03-27', '2023-06-05');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`CONDUCT`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('9PS22A7', 'FZGCL-837', '53-1390712');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('8b0NgsO', 'LADLZ-358', '81-5042308');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('0lb70fe', 'QTBBK-631', '60-1726821');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('543uD8T', 'RKFNN-331', '59-9735698');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('491bEHu', 'EZQRY-934', '93-0617695');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('LUP1f90', 'NRALG-556', '25-5219638');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('23A5T8H', 'FYOIB-446', '76-5613174');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('491bEHu', 'YAJLM-820', '95-9095646');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('LUP1f90', 'LUHVA-053', '42-2966590');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('23A5T8H', 'SIPQR-830', '20-4628825');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('k86354G', 'TPFPG-603', '17-5569241');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('28324H7', 'FICMA-763', '89-7594565');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('7FTYDL5', 'BZGEZ-117', '15-3216599');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('8Y3d29H', 'CPDSW-020', '21-7823598');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('LtbAY6n', 'KBDYQ-361', '31-9141984');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('k86354G', 'NXWOM-125', '83-0348398');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('28324H7', 'FPGTV-201', '46-0620883');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('7FTYDL5', 'YBNCZ-526', '21-3933120');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('8Y3d29H', 'RMPJT-291', '84-1393635');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('LtbAY6n', 'NMTDX-474', '63-3763851');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('H89GC23', 'FECEY-255', '48-8062241');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('tm1929c', 'MPMUA-611', '49-6487525');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('tFP4rx7', 'PTCMJ-513', '79-9284024');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('qsM2oMU', 'BXFAI-894', '53-1390712');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('k86354G', 'NKUOD-777', '81-5042308');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('28324H7', 'KTRYX-765', '60-1726821');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('7FTYDL5', 'HJVBJ-972', '59-9735698');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('8Y3d29H', 'IKEAA-464', '93-0617695');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES ('LtbAY6n', 'KCKPR-539', '25-5219638');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'OOUAS-048', '76-5613174');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'WQTWO-629', '95-9095646');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'PWCPK-273', '42-2966590');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'EKLKK-154', '20-4628825');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'JUTIO-667', '17-5569241');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'HTFSX-858', '89-7594565');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'LUAZU-502', '15-3216599');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'OFQQR-778', '21-7823598');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'VMMOT-286', '31-9141984');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'GGQIH-713', '83-0348398');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'NOGXO-892', '46-0620883');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'MKXMV-148', '21-3933120');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'ZLSCR-009', '84-1393635');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'QLJJW-200', '63-3763851');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'BKTRA-001', '48-8062241');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'OZGFD-178', '49-6487525');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'QBDFO-917', '79-9284024');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'AQNDR-334', '17-5569241');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'LGTCW-484', '89-7594565');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'NFTVD-129', '15-3216599');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'HGIWJ-587', '21-7823598');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'VNCVZ-052', '31-9141984');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'LJGHA-810', '83-0348398');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'OCYWA-974', '46-0620883');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'IXDEL-779', '21-3933120');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'MJSAD-727', '84-1393635');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'PDGNN-003', '63-3763851');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'WXLTQ-093', '48-8062241');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'KBTUW-621', '49-6487525');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'RVPAU-960', '79-9284024');
INSERT INTO `SpaceAgency`.`CONDUCT` (`equip_ID`, `research_ID`, `staff_CIN`) VALUES (NULL, 'IQFJW-738', '60-1726821');

COMMIT;

