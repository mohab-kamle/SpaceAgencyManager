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
  `Job_type` VARCHAR(30) NOT NULL,
  `salary` FLOAT NULL,
  `build_no` VARCHAR(5) NULL,
  `street_name` VARCHAR(20) NULL,
  `postal_code` INT NULL,
  `city` VARCHAR(20) NULL,
  `state` VARCHAR(20) NULL,
  `country` VARCHAR(20) NULL,
  `gender` ENUM('M', 'F') NULL,
  PRIMARY KEY (`CIN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`phone_number`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`phone_number` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`phone_number` (
  `STAFF_CIN` CHAR(10) NOT NULL,
  `phone_no` CHAR(12) NOT NULL,
  PRIMARY KEY (`STAFF_CIN`, `phone_no`),
  INDEX `fk_phone_number_staff_idx` (`STAFF_CIN` ASC),
  CONSTRAINT `fk_phone_number_staff`
    FOREIGN KEY (`STAFF_CIN`)
    REFERENCES `SpaceAgency`.`STAFF` (`CIN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`MACHINERY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`MACHINERY` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`MACHINERY` (
  `machinery_ID` CHAR(15) NOT NULL,
  PRIMARY KEY (`machinery_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`partner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`partner` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`partner` (
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
  `equip_type` VARCHAR(40) NULL,
  `machinery_ID` CHAR(15) NOT NULL,
  `partner_org_code` CHAR(3) NULL,
  PRIMARY KEY (`equip_ID`),
  INDEX `fk_EQUIPMENT_MACHINERY1_idx` (`machinery_ID` ASC),
  INDEX `fk_EQUIPMENT_partner1_idx` (`partner_org_code` ASC),
  CONSTRAINT `fk_EQUIPMENT_MACHINERY1`
    FOREIGN KEY (`machinery_ID`)
    REFERENCES `SpaceAgency`.`MACHINERY` (`machinery_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EQUIPMENT_partner1`
    FOREIGN KEY (`partner_org_code`)
    REFERENCES `SpaceAgency`.`partner` (`org_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`COMMUNICATION_Satellite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`COMMUNICATION_Satellite` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`COMMUNICATION_Satellite` (
  `orbit_type` VARCHAR(25) NULL,
  `purpose` VARCHAR(35) NULL,
  `equip_ID` CHAR(7) NOT NULL,
  PRIMARY KEY (`equip_ID`),
  INDEX `fk_COMMUNICATION_Satellite_EQUIPMENT1_idx` (`equip_ID` ASC),
  CONSTRAINT `fk_COMMUNICATION_Satellite_EQUIPMENT1`
    FOREIGN KEY (`equip_ID`)
    REFERENCES `SpaceAgency`.`EQUIPMENT` (`equip_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`INSPECTOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`INSPECTOR` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`INSPECTOR` (
  `STAFF_CIN` CHAR(10) NOT NULL,
  `C_Sat_ID` CHAR(7) NOT NULL,
  INDEX `fk_INSPECTOR_STAFF1_idx` (`STAFF_CIN` ASC),
  PRIMARY KEY (`STAFF_CIN`),
  INDEX `fk_INSPECTOR_COMMUNICATION_Satellite1_idx` (`C_Sat_ID` ASC),
  CONSTRAINT `fk_INSPECTOR_STAFF1`
    FOREIGN KEY (`STAFF_CIN`)
    REFERENCES `SpaceAgency`.`STAFF` (`CIN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_INSPECTOR_COMMUNICATION_Satellite1`
    FOREIGN KEY (`C_Sat_ID`)
    REFERENCES `SpaceAgency`.`COMMUNICATION_Satellite` (`equip_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`CREW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`CREW` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`CREW` (
  `crew_ID` CHAR(17) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `start_date` DATE NULL,
  `status` VARCHAR(15) NULL,
  PRIMARY KEY (`crew_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`ASTRONAUT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`ASTRONAUT` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`ASTRONAUT` (
  `STAFF_CIN` CHAR(10) NOT NULL,
  `physical_fitness` INT NULL,
  `education` VARCHAR(50) NULL,
  `experience` INT NULL,
  `crew_ID` CHAR(17) NULL,
  INDEX `fk_ASTRONAUT_STAFF1_idx` (`STAFF_CIN` ASC),
  PRIMARY KEY (`STAFF_CIN`),
  INDEX `fk_ASTRONAUT_CREW1_idx` (`crew_ID` ASC),
  CONSTRAINT `fk_ASTRONAUT_STAFF1`
    FOREIGN KEY (`STAFF_CIN`)
    REFERENCES `SpaceAgency`.`STAFF` (`CIN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ASTRONAUT_CREW1`
    FOREIGN KEY (`crew_ID`)
    REFERENCES `SpaceAgency`.`CREW` (`crew_ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`SCIENTISTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`SCIENTISTS` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`SCIENTISTS` (
  `STAFF_CIN` CHAR(10) NOT NULL,
  `specialty` VARCHAR(30) NULL,
  INDEX `fk_SCIENTISTS_STAFF1_idx` (`STAFF_CIN` ASC),
  PRIMARY KEY (`STAFF_CIN`),
  CONSTRAINT `fk_SCIENTISTS_STAFF1`
    FOREIGN KEY (`STAFF_CIN`)
    REFERENCES `SpaceAgency`.`STAFF` (`CIN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`EARTH_Telescope`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`EARTH_Telescope` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`EARTH_Telescope` (
  `diameter` FLOAT NULL,
  `focal_length` FLOAT NULL,
  `mount_type` VARCHAR(30) NULL,
  `location` VARCHAR(30) NULL,
  `equip_ID` CHAR(7) NOT NULL,
  INDEX `fk_EARTH_Telescope_EQUIPMENT1_idx` (`equip_ID` ASC),
  PRIMARY KEY (`equip_ID`),
  CONSTRAINT `fk_EARTH_Telescope_EQUIPMENT1`
    FOREIGN KEY (`equip_ID`)
    REFERENCES `SpaceAgency`.`EQUIPMENT` (`equip_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


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
  `machinery_ID` CHAR(15) NOT NULL,
  `C_Sat_ID` CHAR(7) NOT NULL,
  PRIMARY KEY (`spacecraft_ID`),
  INDEX `fk_SPACECRAFT_MACHINERY1_idx` (`machinery_ID` ASC),
  INDEX `fk_SPACECRAFT_COMMUNICATION_Satellite1_idx` (`C_Sat_ID` ASC),
  CONSTRAINT `fk_SPACECRAFT_MACHINERY1`
    FOREIGN KEY (`machinery_ID`)
    REFERENCES `SpaceAgency`.`MACHINERY` (`machinery_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SPACECRAFT_COMMUNICATION_Satellite1`
    FOREIGN KEY (`C_Sat_ID`)
    REFERENCES `SpaceAgency`.`COMMUNICATION_Satellite` (`equip_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`SPACE_Telescope`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`SPACE_Telescope` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`SPACE_Telescope` (
  `diameter` FLOAT NULL,
  `focal_length` FLOAT NULL,
  `launch_date` DATE NULL,
  `equip_ID` CHAR(7) NOT NULL,
  `spacecraft_ID` VARCHAR(15) NOT NULL,
  INDEX `fk_SPACE_Telescope_EQUIPMENT1_idx` (`equip_ID` ASC),
  PRIMARY KEY (`equip_ID`),
  INDEX `fk_SPACE_Telescope_SPACECRAFT1_idx` (`spacecraft_ID` ASC),
  CONSTRAINT `fk_SPACE_Telescope_EQUIPMENT1`
    FOREIGN KEY (`equip_ID`)
    REFERENCES `SpaceAgency`.`EQUIPMENT` (`equip_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SPACE_Telescope_SPACECRAFT1`
    FOREIGN KEY (`spacecraft_ID`)
    REFERENCES `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`MATERIAL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`MATERIAL` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`MATERIAL` (
  `material_ID` VARCHAR(15) NOT NULL,
  `name` VARCHAR(15) NOT NULL,
  `hardness` VARCHAR(8) NULL,
  `heat_conduction` FLOAT NULL,
  `flexibility` VARCHAR(8) NULL,
  `thermal_conductivity` FLOAT NULL,
  `transparency` FLOAT NULL,
  `impermeability` VARCHAR(12) NULL,
  `britleness` VARCHAR(15) NULL,
  PRIMARY KEY (`material_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`ANALYSIS_Satellite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`ANALYSIS_Satellite` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`ANALYSIS_Satellite` (
  `orbit_type` VARCHAR(25) NULL,
  `purpose` VARCHAR(35) NULL,
  `sensor_type` VARCHAR(25) NULL,
  `resolution` VARCHAR(35) NULL,
  `equip_ID` CHAR(7) NOT NULL,
  INDEX `fk_ANALYSIS_Satellite_EQUIPMENT1_idx` (`equip_ID` ASC),
  PRIMARY KEY (`equip_ID`),
  CONSTRAINT `fk_ANALYSIS_Satellite_EQUIPMENT1`
    FOREIGN KEY (`equip_ID`)
    REFERENCES `SpaceAgency`.`EQUIPMENT` (`equip_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


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
-- Table `SpaceAgency`.`CONTAINS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`CONTAINS` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`CONTAINS` (
  `planet_ID` VARCHAR(15) NOT NULL,
  `material_ID` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`planet_ID`, `material_ID`),
  INDEX `fk_PLANET_has_MATERIAL_MATERIAL1_idx` (`material_ID` ASC),
  INDEX `fk_PLANET_has_MATERIAL_PLANET1_idx` (`planet_ID` ASC),
  CONSTRAINT `fk_PLANET_has_MATERIAL_PLANET1`
    FOREIGN KEY (`planet_ID`)
    REFERENCES `SpaceAgency`.`PLANET` (`planet_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PLANET_has_MATERIAL_MATERIAL1`
    FOREIGN KEY (`material_ID`)
    REFERENCES `SpaceAgency`.`MATERIAL` (`material_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `planet_ID` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`mission_ID`),
  INDEX `fk_MISSION_PLANET1_idx` (`planet_ID` ASC),
  CONSTRAINT `fk_MISSION_PLANET1`
    FOREIGN KEY (`planet_ID`)
    REFERENCES `SpaceAgency`.`PLANET` (`planet_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
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
  INDEX `fk_RESEARCH_has_MISSION_MISSION1_idx` (`mission_ID` ASC),
  INDEX `fk_RESEARCH_has_MISSION_RESEARCH1_idx` (`research_ID` ASC),
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


-- -----------------------------------------------------
-- Table `SpaceAgency`.`SUPPLIES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`SUPPLIES` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`SUPPLIES` (
  `machinery_ID` CHAR(15) NOT NULL,
  `partner_org_code` CHAR(3) NOT NULL,
  PRIMARY KEY (`machinery_ID`, `partner_org_code`),
  INDEX `fk_MACHINERY_has_partner_partner1_idx` (`partner_org_code` ASC),
  INDEX `fk_MACHINERY_has_partner_MACHINERY1_idx` (`machinery_ID` ASC),
  CONSTRAINT `fk_MACHINERY_has_partner_MACHINERY1`
    FOREIGN KEY (`machinery_ID`)
    REFERENCES `SpaceAgency`.`MACHINERY` (`machinery_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_MACHINERY_has_partner_partner1`
    FOREIGN KEY (`partner_org_code`)
    REFERENCES `SpaceAgency`.`partner` (`org_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`PARTCIPATE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`PARTCIPATE` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`PARTCIPATE` (
  `partner_org_code` CHAR(3) NOT NULL,
  `research_ID` CHAR(9) NOT NULL,
  `category` VARCHAR(20) NULL,
  PRIMARY KEY (`partner_org_code`, `research_ID`),
  INDEX `fk_partner_has_RESEARCH_RESEARCH1_idx` (`research_ID` ASC),
  INDEX `fk_partner_has_RESEARCH_partner1_idx` (`partner_org_code` ASC),
  CONSTRAINT `fk_partner_has_RESEARCH_partner1`
    FOREIGN KEY (`partner_org_code`)
    REFERENCES `SpaceAgency`.`partner` (`org_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_partner_has_RESEARCH_RESEARCH1`
    FOREIGN KEY (`research_ID`)
    REFERENCES `SpaceAgency`.`RESEARCH` (`research_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`TAKES_OFF`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`TAKES_OFF` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`TAKES_OFF` (
  `mission_ID` CHAR(7) NOT NULL,
  `crew_ID` CHAR(17) NULL,
  `spacecraft_ID` VARCHAR(15) NOT NULL,
  `launch_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  INDEX `fk_TAKES_OFF_MISSION1_idx` (`mission_ID` ASC),
  PRIMARY KEY (`mission_ID`),
  INDEX `fk_TAKES_OFF_CREW1_idx` (`crew_ID` ASC),
  INDEX `fk_TAKES_OFF_SPACECRAFT1_idx` (`spacecraft_ID` ASC),
  CONSTRAINT `fk_TAKES_OFF_MISSION1`
    FOREIGN KEY (`mission_ID`)
    REFERENCES `SpaceAgency`.`MISSION` (`mission_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TAKES_OFF_CREW1`
    FOREIGN KEY (`crew_ID`)
    REFERENCES `SpaceAgency`.`CREW` (`crew_ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TAKES_OFF_SPACECRAFT1`
    FOREIGN KEY (`spacecraft_ID`)
    REFERENCES `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceAgency`.`CONDUCT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceAgency`.`CONDUCT` ;

CREATE TABLE IF NOT EXISTS `SpaceAgency`.`CONDUCT` (
  `scientist_STAFF_CIN` CHAR(10) NOT NULL,
  `equip_ID` CHAR(7) NULL,
  `research_ID` CHAR(9) NOT NULL,
  INDEX `fk_CONDUCT_SCIENTISTS1_idx` (`scientist_STAFF_CIN` ASC),
  INDEX `fk_CONDUCT_EQUIPMENT1_idx` (`equip_ID` ASC),
  INDEX `fk_CONDUCT_RESEARCH1_idx` (`research_ID` ASC),
  PRIMARY KEY (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`),
  CONSTRAINT `fk_CONDUCT_SCIENTISTS1`
    FOREIGN KEY (`scientist_STAFF_CIN`)
    REFERENCES `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CONDUCT_EQUIPMENT1`
    FOREIGN KEY (`equip_ID`)
    REFERENCES `SpaceAgency`.`EQUIPMENT` (`equip_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CONDUCT_RESEARCH1`
    FOREIGN KEY (`research_ID`)
    REFERENCES `SpaceAgency`.`RESEARCH` (`research_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`STAFF`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('64-9007802', 'Allyson', 'Leonid', 'Messenger', 'astronaut', 160403.67, '61', 'Chestnutwood Avenue', 28289, 'Charlotte', 'North Carolina', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('67-7623129', 'Flynn', 'Quintin', 'Ballam', 'astronaut', 184421.68, '10', 'Firwood Lane', 43615, 'Toledo', 'Ohio', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('27-3694387', 'Cathlene', 'Ibrahim', 'Allport', 'astronaut', 193121.41, '87', 'Hickorywood Court', 31296, 'Macon', 'Georgia', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('85-0162062', 'Kliment', 'Thaddeus', 'Cosgriff', 'astronaut', 145432.7, '63', 'Birch Street', 88589, 'El Paso', 'Texas', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('83-8514227', 'Arie', 'Haily', 'Edgworth', 'astronaut', 192860.33, '89', 'Magnolia Road', 19897, 'Wilmington', 'Delaware', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('73-8388298', 'Even', 'Shem', 'Littlewood', 'astronaut', 95154.14, '83', 'Pine Road', 91328, 'Northridge', 'California', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('61-3810579', 'Vincenz', 'Yorke', 'Robilart', 'astronaut', 169814.21, '33', 'Pine Road', 27615, 'Raleigh', 'North Carolina', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('81-2202220', 'Ruperto', 'Torrance', 'Ratchford', 'astronaut', 191666.84, '57', 'Maplewood Street', 87105, 'Albuquerque', 'New Mexico', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('80-1242102', 'Lane', 'Deane', 'Valiant', 'astronaut', 146088.32, '51', 'Sprucewood Avenue', 46862, 'Fort Wayne', 'Indiana', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('54-7621370', 'Celeste', 'Huntlee', 'Ciccottini', 'astronaut', 188962.67, '53', 'Cherrywood Court', 90847, 'Long Beach', 'California', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('30-1489321', 'Allister', 'Nicol', 'Reisen', 'astronaut', 48032.84, '34', 'Willow Court', 92725, 'Santa Ana', 'California', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('65-2734289', 'Filippa', 'Ferdy', 'Bazeley', 'astronaut', 44823.34, '35', 'Bamboowood Lane', 60158, 'Carol Stream', 'Illinois', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('52-9321681', 'Karon', 'Gunter', 'Petrusch', 'astronaut', 84851.1, '57', 'Banyan Lane', 18706, 'Wilkes Barre', 'Pennsylvania', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('64-0634566', 'Nil', 'Zack', 'Starrs', 'astronaut', 167679.29, '14', 'Chestnutwood Avenue', 06145, 'Hartford', 'Connecticut', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('57-1031173', 'Roby', 'Dillon', 'Woolfenden', 'astronaut', 45777.32, '8', 'Juniper Lane', 28305, 'Fayetteville', 'North Carolina', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('30-0941335', 'Gwynne', 'Elia', 'Dorwood', 'astronaut', 145644.32, '65', 'Redwood Avenue', 40505, 'Lexington', 'Kentucky', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('55-1454415', 'Andrey', 'Tad', 'Endrighi', 'astronaut', 165124.29, '85', 'Elm Court', 05609, 'Montpelier', 'Vermont', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('02-7755209', 'Gare', 'Tanney', 'Letessier', 'astronaut', 43105.45, '64', 'Holly Court', 60663, 'Chicago', 'Illinois', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('13-7647914', 'Gustave', 'Boris', 'Lodford', 'astronaut', 42267.29, '30', 'Cherrywood Court', 81005, 'Pueblo', 'Colorado', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('24-9165353', 'Deedee', 'Alley', 'Graysmark', 'astronaut', 72981.33, '15', 'Mulberry Avenue', 10249, 'New York City', 'New York', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('10-0450169', 'Cinnamon', 'Lyn', 'Swyre', 'astronaut', 130962, '67', 'Hollywood Avenue', 32304, 'Tallahassee', 'Florida', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('01-2017908', 'Lay', 'Karney', 'Elliss', 'astronaut', 186205.15, '79', 'Cedar Court', 92822, 'Brea', 'California', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('80-8982872', 'Blaine', 'Lancelot', 'Gabbott', 'astronaut', 177331.9, '33', 'Cypresswood Avenue', 55188, 'Saint Paul', 'Minnesota', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('04-6762602', 'Novelia', 'Erhart', 'Armitt', 'astronaut', 43571.77, '25', 'Aspenwood Street', 97229, 'Portland', 'Oregon', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('49-4767868', 'Benjie', 'Paul', 'Queyos', 'astronaut', 184546.67, '71', 'Holly Court', 30092, 'Norcross', 'Georgia', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('02-4978077', 'Adaline', 'Knox', 'Camilli', 'astronaut', 113189.34, '59', 'Cedar Court', 19146, 'Philadelphia', 'Pennsylvania', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('38-9099651', 'Suzie', 'Tremain', 'Thorndale', 'astronaut', 146502.12, '4', 'Fir Street', 80235, 'Denver', 'Colorado', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('88-9216104', 'Selma', 'Dorie', 'Rothchild', 'astronaut', 124948.78, '55', 'Pine Road', 84605, 'Provo', 'Utah', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('24-8971641', 'Faustina', 'Rutherford', 'Burgum', 'astronaut', 116862.09, '99', 'Juniper Lane', 94159, 'San Francisco', 'California', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('22-0134416', 'Riccardo', 'Seward', 'Dovington', 'astronaut', 160200.11, '6', 'Mulberry Avenue', 64153, 'Kansas City', 'Missouri', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('55-4318601', 'Raquela', 'Robers', 'Olliffe', 'astronaut', 96770.93, '8', 'Hollywood Avenue', 08619, 'Trenton', 'New Jersey', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('88-6881200', 'Persis', 'Herbie', 'Geale', 'astronaut', 71062.32, '79', 'Cherrywood Court', 92153, 'San Diego', 'California', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('35-7806470', 'Alie', 'Alonso', 'Wistance', 'astronaut', 86199.17, '78', 'Willow Court', 60630, 'Chicago', 'Illinois', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('81-0631231', 'Truda', 'Orlando', 'Branche', 'astronaut', 82619.18, '15', 'Cedar Court', 20436, 'Washington', 'District of Columbia', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('52-5452049', 'Malchy', 'Wallas', 'Lys', 'astronaut', 56181.97, '48', 'Willowwood Street', 33605, 'Tampa', 'Florida', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('29-3898225', 'Marvin', 'Broderic', 'Abramowitch', 'astronaut', 194462.91, '71', 'Palmwood Street', 53285, 'Milwaukee', 'Wisconsin', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('99-4413006', 'Beulah', 'Tomkin', 'Vaugham', 'astronaut', 110869.02, '35', 'Willow Court', 93762, 'Fresno', 'California', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('46-8786546', 'Lilia', 'Flem', 'Lamping', 'astronaut', 109723.05, '14', 'Oakwood Avenue', 78250, 'San Antonio', 'Texas', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('35-7240210', 'Janetta', 'Justis', 'Demko', 'attorney', 135018.98, '45', 'Mulberrywood Road', 12232, 'Albany', 'New York', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('06-3939460', 'Damiano', 'Edik', 'Velde', 'attorney', 114043.38, '85', 'Willowwood Street', 55166, 'Saint Paul', 'Minnesota', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('18-1154969', 'Lancelot', 'Mathew', 'Jerratsch', 'attorney', 63543.63, '87', 'Mulberry Avenue', 74184, 'Tulsa', 'Oklahoma', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('32-9258513', 'Reagen', 'Beck', 'Pagden', 'attorney', 148260.77, '8', 'Chestnut Court', 79188, 'Amarillo', 'Texas', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('19-0876311', 'Addie', 'Syd', 'Hasselby', 'attorney', 81446.06, '90', 'Cedar Lane', 70505, 'Lafayette', 'Louisiana', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('86-6559540', 'Lisetta', 'Theo', 'Trenholm', 'attorney', 178856.74, '63', 'Sycamorewood Lane', 35810, 'Huntsville', 'Alabama', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('21-6695943', 'Fernande', 'Gene', 'Hainey`', 'engineer', 114480.09, '21', 'Dogwood Road', 94237, 'Sacramento', 'California', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('64-5009876', 'Oliy', 'Worthington', 'Norgate', 'engineer', 88772.71, '33', 'Bamboowood Lane', 92555, 'Moreno Valley', 'California', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('55-4386644', 'Lyndel', 'Emmery', 'Tolhurst', 'engineer', 132588.98, '63', 'Cypress Court', 68517, 'Lincoln', 'Nebraska', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('98-0932387', 'Malina', 'Sigfrid', 'Ellcome', 'engineer', 96175.27, '12', 'Poplarwood Road', 44485, 'Warren', 'Ohio', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('27-4931367', 'Dennet', 'Talbot', 'Mongenot', 'engineer', 59394.81, '13', 'Holly Court', 30089, 'Decatur', 'Georgia', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('58-9180119', 'Yul', 'Homerus', 'Mumbeson', 'engineer', 119442.51, '71', 'Chestnut Court', 45218, 'Cincinnati', 'Ohio', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('39-6007322', 'Dulcia', 'Friedrich', 'Rosle', 'engineer', 52421.32, '92', 'Maple Street', 56372, 'Saint Cloud', 'Minnesota', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('09-0656085', 'Clari', 'Wallas', 'St. Aubyn', 'engineer', 175301.24, '25', 'Maplewood Street', 46207, 'Indianapolis', 'Indiana', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('74-4266414', 'Mace', 'Bertie', 'Eggleton', 'engineer', 82735.24, '80', 'Cedar Court', 44105, 'Cleveland', 'Ohio', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('73-7409855', 'Melisande', 'Jaime', 'Pinnijar', 'engineer', 93822.61, '49', 'Beechwood Lane', 92640, 'Fullerton', 'California', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('04-1985331', 'Barris', 'Rochester', 'Itscowics', 'engineer', 187520.74, '13', 'Juniperwood Court', 24024, 'Roanoke', 'Virginia', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('69-7131770', 'Murielle', 'Wolfie', 'Joppich', 'inspector', 64773.34, '51', 'Maplewood Street', 18514, 'Scranton', 'Pennsylvania', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('74-2586602', 'Rice', 'Joshua', 'Grealey', 'inspector', 146171.28, '100', 'Redwoodwood Road', 44191, 'Cleveland', 'Ohio', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('64-3715292', 'Constantine', 'Aymer', 'Clacson', 'inspector', 185009.99, '52', 'Sycamore Avenue', 23277, 'Richmond', 'Virginia', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('62-6558885', 'Adriaens', 'Troy', 'Race', 'inspector', 50535.99, '5', 'Spruce Court', 83716, 'Boise', 'Idaho', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('01-8223240', 'Hanni', 'Reagen', 'Osgood', 'inspector', 92738.63, '51', 'Palmwood Street', 10150, 'New York City', 'New York', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('66-9702024', 'Vail', 'Vincent', 'Brocklebank', 'inspector', 89660.28, '61', 'Mulberrywood Road', 31196, 'Atlanta', 'Georgia', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('38-7726916', 'Camala', 'Isidor', 'Sturgeon', 'inspector', 162725.86, '33', 'Birch Street', 06510, 'New Haven', 'Connecticut', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('70-1541734', 'Udale', 'Marcellus', 'Chicchetto', 'inspector', 69941.86, '11', 'Cherry Lane', 88574, 'El Paso', 'Texas', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('04-4951183', 'Berkie', 'Alvy', 'Squeers', 'inspector', 71061.57, '90', 'Spruce Court', 19805, 'Wilmington', 'Delaware', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('53-1327041', 'Arny', 'Mendy', 'Keeltagh', 'inspector', 128910.78, '35', 'Oak Avenue', 61605, 'Peoria', 'Illinois', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('25-2274441', 'Anna', 'Giordano', 'Kelby', 'inspector', 158343.23, '29', 'Fir Street', 28278, 'Charlotte', 'North Carolina', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('70-8215677', 'Mohammed', 'Bear', 'Gardener', 'inspector', 116984.66, '63', 'Willow Lane', 29225, 'Columbia', 'South Carolina', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('58-9025839', 'Renae', 'Lucais', 'Da Costa', 'inspector', 116223.03, '70', 'Bamboowood Lane', 43610, 'Toledo', 'Ohio', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('56-6820365', 'Chris', 'Lenci', 'Aitkenhead', 'inspector', 137990.56, '22', 'Spruce Court', 92105, 'San Diego', 'California', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('09-0412327', 'Jarid', 'Brenden', 'Lanchester', 'inspector', 55309.54, '18', 'Banyan Lane', 77806, 'Bryan', 'Texas', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('09-2059601', 'Dari', 'Barrett', 'Cruikshanks', 'inspector', 125474.85, '22', 'Firwood Lane', 78296, 'San Antonio', 'Texas', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('53-1390712', 'Nester', 'Theodor', 'Cleare', 'scientist', 132673.21, '25', 'Beech Street', 90405, 'Santa Monica', 'California', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('81-5042308', 'Eliza', 'Bret', 'O\'Quin', 'scientist', 60450.34, '7', 'Magnoliawood Street', 95823, 'Sacramento', 'California', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('60-1726821', 'Genvieve', 'Findlay', 'McMearty', 'scientist', 49866.67, '54', 'Linden Street', 36628, 'Mobile', 'Alabama', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('59-9735698', 'Dante', 'Averil', 'Mateo', 'scientist', 170632.66, '40', 'Pinewood Road', 72118, 'North Little Rock', 'Arkansas', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('93-0617695', 'Bette', 'Erhart', 'Jewise', 'scientist', 63681.96, '19', 'Cypresswood Avenue', 15255, 'Pittsburgh', 'Pennsylvania', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('25-5219638', 'Sid', 'Humphrey', 'Ferriby', 'scientist', 65413.66, '85', 'Lindenwood Lane', 98481, 'Tacoma', 'Washington', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('76-5613174', 'Rollie', 'Matthus', 'Dowsey', 'scientist', 189301.25, '12', 'Willow Court', 95210, 'Stockton', 'California', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('95-9095646', 'Floyd', 'Whit', 'Verissimo', 'scientist', 82134.19, '78', 'Chestnutwood Avenue', 63169, 'Saint Louis', 'Missouri', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('42-2966590', 'Caria', 'Rube', 'Burgne', 'scientist', 183805.36, '49', 'Maple Street', 94121, 'San Francisco', 'California', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('20-4628825', 'Clerissa', 'Hercule', 'Volk', 'scientist', 99023.95, '82', 'Cedar Court', 20508, 'Washington', 'District of Columbia', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('17-5569241', 'Winthrop', 'Cole', 'McQuilty', 'scientist', 191395.3, '6', 'Mulberry Avenue', 29416, 'Charleston', 'South Carolina', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('89-7594565', 'Margie', 'Obidiah', 'Alfonso', 'scientist', 76356.32, '17', 'Juniperwood Court', 55551, 'Young America', 'Minnesota', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('15-3216599', 'Gerome', 'Price', 'Renzo', 'scientist', 102755.77, '44', 'Pinewood Road', 33245, 'Miami', 'Florida', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('21-7823598', 'Phillie', 'Pietrek', 'Nornasell', 'scientist', 128894.62, '49', 'Fir Street', 66276, 'Shawnee Mission', 'Kansas', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('31-9141984', 'Osmond', 'Lief', 'Boner', 'scientist', 47871.88, '92', 'Fir Street', 14276, 'Buffalo', 'New York', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('83-0348398', 'Massimo', 'Nevin', 'Soutar', 'scientist', 85367.99, '75', 'Maplewood Street', 59806, 'Missoula', 'Montana', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('46-0620883', 'Reade', 'Mano', 'Cullington', 'scientist', 138363.05, '82', 'Pine Road', 10464, 'Bronx', 'New York', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('21-3933120', 'Harris', 'Paco', 'Dibling', 'scientist', 40303.43, '87', 'Beechwood Lane', 06120, 'Hartford', 'Connecticut', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('84-1393635', 'Traver', 'Thorstein', 'Haylett', 'scientist', 86670.7, '95', 'Chestnutwood Avenue', 76096, 'Arlington', 'Texas', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('63-3763851', 'Kelly', 'Pate', 'Hallex', 'scientist', 53197.61, '42', 'Palm Road', 85005, 'Phoenix', 'Arizona', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('48-8062241', 'Roosevelt', 'Steve', 'Krzysztof', 'scientist', 69787.71, '68', 'Redwood Avenue', 20319, 'Washington', 'District of Columbia', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('49-6487525', 'Elihu', 'Roberto', 'Dibbs', 'scientist', 151103.81, '6', 'Cypresswood Avenue', 44505, 'Youngstown', 'Ohio', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('79-9284024', 'Dell', 'Alistair', 'Vials', 'scientist', 113129.71, '51', 'Pine Road', 10019, 'New York City', 'New York', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('47-3890669', 'Elysee', 'Cleavland', 'Pozzi', 'technician', 166372.89, '4', 'Hollywood Avenue', 67205, 'Wichita', 'Kansas', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('61-4123142', 'Brendin', 'Abdul', 'Abramamovh', 'technician', 197928.37, '15', 'Redwood Avenue', 65110, 'Jefferson City', 'Missouri', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('94-1095370', 'Greta', 'Waylen', 'Chaize', 'technician', 161438.21, '98', 'Willow Court', 55407, 'Minneapolis', 'Minnesota', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('46-2170683', 'Odey', 'Reinold', 'Faley', 'technician', 177936.61, '5', 'Birch Street', 12222, 'Albany', 'New York', 'United States', 'M');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('13-5368447', 'Jean', 'Otes', 'Lucchi', 'technician', 142214.79, '31', 'Willow Court', 46406, 'Gary', 'Indiana', 'United States', 'F');
INSERT INTO `SpaceAgency`.`STAFF` (`CIN`, `fname`, `mname`, `lname`, `Job_type`, `salary`, `build_no`, `street_name`, `postal_code`, `city`, `state`, `country`, `gender`) VALUES ('92-7891063', 'Luci', 'Verney', 'Chaim', 'technician', 148301.03, '29', 'Willow Lane', 80127, 'Littleton', 'Colorado', 'United States', 'F');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`phone_number`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('53-1390712', '727-743-5710');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('69-7131770', '335-744-6847');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('81-5042308', '943-473-3450');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('49-4767868', '483-233-0124');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('60-1726821', '544-421-5764');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('47-3890669', '214-988-6167');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('13-7647914', '954-407-0850');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('02-4978077', '483-861-7464');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('59-9735698', '176-508-2716');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('74-2586602', '553-350-8968');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('93-0617695', '760-659-8098');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('38-9099651', '240-849-2055');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('25-5219638', '687-276-5204');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('64-9007802', '197-215-0517');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('67-7623129', '299-765-9144');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('64-3715292', '940-936-4930');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('27-3694387', '330-646-8928');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('76-5613174', '386-380-7248');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('95-9095646', '527-543-3463');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('42-2966590', '373-645-5235');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('85-0162062', '117-165-7816');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('20-4628825', '949-527-7578');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('24-9165353', '807-731-1993');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('88-9216104', '246-481-2761');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('21-6695943', '890-647-8305');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('17-5569241', '317-574-7681');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('89-7594565', '361-843-1821');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('62-6558885', '654-804-6171');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('83-8514227', '630-795-2897');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('15-3216599', '369-563-7634');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('01-2017908', '889-908-9920');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('61-4123142', '392-723-7362');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('10-0450169', '147-651-8309');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('24-8971641', '451-272-2670');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('80-8982872', '652-181-7573');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('22-0134416', '142-960-8045');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('35-7240210', '797-433-2669');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('01-8223240', '184-532-3581');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('21-7823598', '933-156-8531');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('04-6762602', '557-148-9016');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('73-8388298', '604-406-1776');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('55-4318601', '181-593-5539');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('64-5009876', '913-786-7974');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('94-1095370', '900-747-1873');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('55-4386644', '608-405-1154');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('06-3939460', '957-301-5305');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('18-1154969', '167-726-4837');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('31-9141984', '310-412-6291');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('66-9702024', '455-926-9008');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('61-3810579', '412-605-6889');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('32-9258513', '260-877-9081');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('38-7726916', '570-872-0503');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('81-2202220', '734-745-5133');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('70-1541734', '549-658-9879');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('83-0348398', '372-159-3680');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('80-1242102', '287-609-1709');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('54-7621370', '441-799-1361');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('46-2170683', '602-836-7233');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('46-0620883', '105-864-6915');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('04-4951183', '725-509-8060');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('19-0876311', '852-159-3856');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('86-6559540', '379-204-9793');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('53-1327041', '182-608-6496');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('88-6881200', '450-860-1892');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('25-2274441', '826-773-4789');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('98-0932387', '789-780-1691');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('27-4931367', '682-872-8347');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('21-3933120', '143-662-3593');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('84-1393635', '124-807-7728');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('30-1489321', '966-597-7654');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('65-2734289', '248-955-0524');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('52-9321681', '336-497-8816');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('64-0634566', '787-497-4740');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('58-9180119', '334-274-0878');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('63-3763851', '593-966-1271');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('48-8062241', '953-782-7799');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('70-8215677', '309-252-2125');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('39-6007322', '402-489-1575');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('58-9025839', '662-142-9745');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('56-6820365', '955-842-9595');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('09-0656085', '882-542-6167');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('49-6487525', '926-311-2471');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('35-7806470', '850-630-8878');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('79-9284024', '581-524-8981');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('09-0412327', '153-664-2082');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('52-5452049', '641-117-8260');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('09-2059601', '472-949-9230');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('74-4266414', '983-439-2845');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('29-3898225', '131-655-4771');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('57-1031173', '200-489-6166');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('99-4413006', '337-562-8434');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('46-8786546', '117-599-6661');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('13-5368447', '277-475-8728');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('73-7409855', '382-401-9275');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('30-0941335', '219-606-0592');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('55-1454415', '425-571-0508');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('92-7891063', '140-165-9705');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('04-1985331', '190-998-0033');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('81-0631231', '223-599-2308');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('02-7755209', '114-120-1600');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('13-5368447', '618-241-3096');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('13-5368447', '184-738-5349');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('73-7409855', '724-909-3582');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('73-7409855', '576-826-4135');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('88-6881200', '347-240-0046');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('88-6881200', '727-611-0655');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('30-1489321', '331-555-1799');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('30-1489321', '282-982-4711');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('53-1390712', '874-235-8124');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('53-1390712', '292-552-1484');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('60-1726821', '513-445-2199');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('60-1726821', '191-762-7750');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('69-7131770', '621-546-4235');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('69-7131770', '931-147-3742');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('81-5042308', '288-972-7751');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('81-5042308', '368-356-9691');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('81-2202220', '594-697-9082');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('81-2202220', '209-274-2012');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('93-0617695', '228-561-1334');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('93-0617695', '880-831-2344');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('64-0634566', '769-251-5464');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('64-0634566', '666-300-9477');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('79-9284024', '213-659-3336');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('79-9284024', '709-327-7125');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('25-5219638', '450-251-2880');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('25-5219638', '363-375-4846');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('81-5042308', '267-788-5076');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('81-5042308', '381-732-4784');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('49-4767868', '176-112-8485');
INSERT INTO `SpaceAgency`.`phone_number` (`STAFF_CIN`, `phone_no`) VALUES ('49-4767868', '851-493-5557');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`MACHINERY`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('21Nxb6A83C0rZ72');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('m78TRSyzqv83UtZ');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('keI214YHbCywTT0');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('k3XUVI335r5s9N5');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('gx58TOZ6cxUiro5');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('b4598tq6mv23wcu');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('tHY1P9dNCf7MK33');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('ukbl9KHcn632l15');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('dfMx20vorOJjQew');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('7z5zZYvUU3jBBHu');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('zIo1w55kOU3xj80');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('Jua19a9zayqRsWJ');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('7akAXwtd9tF6PMc');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('4g5j2V3Ncadvu9V');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('F3QxbgdDY9C03IV');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('7LZYX35v9339rB3');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('hdNm6315c8IAEYw');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('qA3O46f3e42817o');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('9978qqCr2OV02Ej');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('s13uGf19rt3Rkkh');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('Qz6fohXkwc6syrd');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('Sg4POIY29zoXQ1Q');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('nju94Wark61pVcg');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('NaJig5xlQI9imIx');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('cSY9skbpwgMYqdc');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('CtNls67c5o4J32h');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('EY56Jv6p1t83ty2');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('1G1yfQvPSmyU9NK');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('2jDW5A4zZxxYSq1');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('4YWUj7IlMzzfTh9');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('185hVYxH8ffe6Mh');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('1vr21hI3wAUsN9P');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('2387I58vp4iX2nh');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('CEK2XiiFucC9wu8');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('Uj51ev84mu89Fln');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('5cgf62ZAlJY33VD');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('9AV9HCkwS79I05o');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('in4icJCV24CtX7V');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('GWYZB514dxZPwnK');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('Q0kLEfolPtbwUQz');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('pcjyFC2auID0bB0');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('1663A9ul58qHpPC');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('w74Z3p014H9ldNL');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('1RJTtcvzLvVVc3g');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('EkXqT69J9c6TO4Z');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('2Mgcc2DENWb8CYv');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('h8eSu5o90Y5uWyJ');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('n1nwbE1UGJejQmK');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('NuF7K38abRBXJo0');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('EcDJi2H3k0av0H2');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('Je3jYo4X6ey7H96');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('fi46QMnBR1fs5sc');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('epEg50S2Q1G4y3J');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('CD18IrdXG9b9a40');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('XVa4Q3tqv8D5d4c');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('gF56Zis1LpCSatI');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('SRP40caz29535DI');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('sM80JgTfEPM2BLs');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('Ug1BPfbZ2JETum4');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('KVkck5yg15N4sxQ');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('3d1thfyIY97sqUa');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('uZA50p689X11u7z');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('8Wm7L8hit84Egp1');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('902ODfE4Y3m5sbc');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('BrY9vNOttZ1J46I');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('53TyXIau15V2NB0');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('LZrV6ZJ6JiJ53Qy');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('QinbRG1yj3P6YJ2');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('925s822LAcnw3np');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('lAVj7bcfNL68YQe');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('eUs318js9386y9p');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('144HNo0wnJDuHO1');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('ycwVsLmnznKbxqS');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('L54Jna0EIcKmS71');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('8ncJlWEtgGgk6cX');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('s27rNptX3gS62T2');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('y66l8QI0z3U61t1');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('Dt434gFe2k98Vzf');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('YE3F39rCA5y8xk0');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('kioUkIsp0ORraAl');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('ks6DQ0oiF9E4rb8');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('9hpEBiW7ayyH0ZO');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('w974eL2F0bXNmOe');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('3Xo3D5Z8wfN9Uhz');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('44mh9EN4YI8ZLd4');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('3BOPmNjfuRaUf8N');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('3lzgpkj8qi0HJC6');
INSERT INTO `SpaceAgency`.`MACHINERY` (`machinery_ID`) VALUES ('0CqGiwJoA8rCM0M');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`partner`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('1', 'Trilith', '787 Norway Maple Parkway', 'rvardie0@miitbeian.gov.cn', '826-141-8448');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('2', 'Riffpedia', '601 Lotheville Center', 'lkentwell1@icq.com', '489-821-3773');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('3', 'Brainverse', '832 David Avenue', 'ytague2@goodreads.com', '288-229-1619');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('4', 'Trilith', '558 Carey Park', 'rvandermerwe3@mac.com', '853-911-8471');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('5', 'Topiclounge', '80 Kipling Way', 'uhedau4@washingtonpost.com', '967-144-9434');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('6', 'Chatterbridge', '62 Sugar Trail', 'ltolussi5@foxnews.com', '269-982-5853');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('7', 'Brainverse', '51597 Sutherland Circle', 'atreadaway6@list-manage.com', '753-358-1388');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('8', 'Zoomcast', '33 Dahle Place', 'rcrosseland7@ihg.com', '699-452-8285');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('9', 'Roodel', '1 Golf View Hill', 'tdeneve8@harvard.edu', '149-773-2655');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('10', 'Skipfire', '01 2nd Street', 'npllu9@amazon.com', '603-546-8265');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('11', 'Meeveo', '61989 Nelson Center', 'ckoppa@technorati.com', '808-993-0818');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('12', 'Skippad', '4 Harbort Pass', 'bfincib@epa.gov', '776-614-9981');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('13', 'Avamm', '51 Vernon Crossing', 'jpotellc@wufoo.com', '715-994-2599');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('14', 'InnoZ', '08341 Gerald Circle', 'celmhirstd@noaa.gov', '609-721-6987');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('15', 'Voonder', '49 Muir Street', 'tlockhurste@t-online.de', '923-241-8921');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('16', 'Quimm', '39 Summer Ridge Street', 'jraistonf@51.la', '527-902-1596');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('17', 'Skyvu', '53 Pleasure Park', 'wcapelg@posterous.com', '330-682-2106');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('18', 'Oba', '25 Ryan Road', 'iainsworthh@odnoklassniki.ru', '923-573-7878');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('19', 'Brainverse', '690 Moland Crossing', 'posbandi@china.com.cn', '840-292-5481');
INSERT INTO `SpaceAgency`.`partner` (`org_code`, `name`, `address`, `email`, `phone_no`) VALUES ('20', 'Wikibox', '69516 Vahlen Circle', 'ldimblebeej@engadget.com', '228-712-5189');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`EQUIPMENT`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('b15acs2', 'Vanguard 1', 'decommissioned', 'communication', 'USA', 'satellite', '21Nxb6A83C0rZ72', '11');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('9PS22A7', 'Hubble Space satallite', 'active', 'analysis', 'Brazil', 'satellite', 'm78TRSyzqv83UtZ', '12');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('8b0NgsO', 'International Space', 'active', 'analysis', 'Japan', 'satellite', 'keI214YHbCywTT0', '13');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('0lb70fe', 'GOES-16', 'active', 'analysis', 'Mexico', 'satellite', 'k3XUVI335r5s9N5', '14');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('543uD8T', 'TerraSAR-X', 'active', 'analysis', 'Canada', 'satellite', 'gx58TOZ6cxUiro5', '15');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('YwG5t5S', 'Aqua', 'decommissioned', 'analysis', 'Mexico', 'satellite', 'b4598tq6mv23wcu', '16');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('dG3Ka8e', 'Chandrayaan-2', 'decommissioned', 'analysis', 'Brazil', 'satellite', 'tHY1P9dNCf7MK33', '17');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('Njy0K0w', 'Fengyun-4A', 'decommissioned', 'analysis', 'Japan', 'satellite', 'ukbl9KHcn632l15', '18');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('jBEhJP3', 'TESS', 'decommissioned', 'analysis', 'Mexico', 'satellite', 'dfMx20vorOJjQew', '19');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('t6b1WCX', 'RADARSAT-2', 'active', 'communication', 'Mexico', 'satellite', '7z5zZYvUU3jBBHu', '20');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('Ui37A19', 'Amos-17', 'decommissioned', 'communication', 'Mexico', 'satellite', 'zIo1w55kOU3xj80', '11');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('H89GC23', 'Kepler Space', 'active', 'communication', 'Japan', 'satellite', 'Jua19a9zayqRsWJ', '12');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('tm1929c', 'GPS IIR-20', 'active', 'communication', 'Mexico', 'satellite', '7akAXwtd9tF6PMc', '13');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('tFP4rx7', 'Swift', 'active', 'communication', 'Germany', 'satellite', '4g5j2V3Ncadvu9V', '14');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('qsM2oMU', 'Landsat 8', 'active', 'communication', 'Japan', 'satellite', 'F3QxbgdDY9C03IV', '15');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('KyfWK86', 'Gaia', 'decommissioned', 'communication', 'Brazil', 'satellite', '7LZYX35v9339rB3', '16');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('491bEHu', 'Electron Microscope', 'active', 'compound', 'Mexico', 'microscope', 'hdNm6315c8IAEYw', '17');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('LUP1f90', 'Transmission', 'active', 'compound', 'Germany', 'microscope', 'qA3O46f3e42817o', '18');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('23A5T8H', 'Atomic Force', 'active', 'compound', 'USA', 'microscope', '9978qqCr2OV02Ej', '19');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('7kcYTzM', 'Scanning Tunneling', 'decommissioned', 'compound', 'Mexico', 'microscope', 's13uGf19rt3Rkkh', '20');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('6h7246F', 'Phase-Contrast', 'decommissioned', 'compound', 'Mexico', 'microscope', 'Qz6fohXkwc6syrd', '11');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('Lb6j7BC', 'Hubble Space', 'active', 'cosmic', 'Mexico', 'spectrograph', 'Sg4POIY29zoXQ1Q', '12');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('yAM7LV3', 'Keck Observatory', 'active', 'cosmic', 'USA', 'spectrograph', 'nju94Wark61pVcg', '13');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('e7QuS70', 'Gemini Observatory', 'decommissioned', 'cosmic', 'USA', 'spectrograph', 'NaJig5xlQI9imIx', '14');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('T074Lyu', 'Subaru Telescope', 'decommissioned', 'cosmic', 'Germany', 'spectrograph', 'cSY9skbpwgMYqdc', '15');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('2L9CEm6', 'Chandra X-ray', 'decommissioned', 'cosmic', 'Germany', 'spectrograph', 'CtNls67c5o4J32h', '16');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('p894cbv', 'European Southern', 'decommissioned', 'cosmic', 'Japan', 'spectrograph', 'EY56Jv6p1t83ty2', '17');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('2iE8BvN', 'Magellan Telescopes', 'decommissioned', 'cosmic', 'Brazil', 'spectrograph', '1G1yfQvPSmyU9NK', '18');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('8tZqz3q', 'Apache Point', 'decommissioned', 'cosmic', 'Canada', 'spectrograph', '2jDW5A4zZxxYSq1', '19');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('s554crG', 'Hubble Space Telescope', 'active', 'Earth_Based', 'Germany', 'telescope', '4YWUj7IlMzzfTh9', '20');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('jU5OTKZ', 'Proton-4', 'decommissioned', 'Earth_Based', 'Canada', 'telescope', '185hVYxH8ffe6Mh', '11');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('8XUm7jG', 'Cos-B', 'decommissioned', 'Earth_Based', 'USA', 'telescope', '1vr21hI3wAUsN9P', '12');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('A28P3f1', 'Granat', 'decommissioned', 'Earth_Based', 'USA', 'telescope', '2387I58vp4iX2nh', '13');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('ABN6bLW', 'LEGRI', 'decommissioned', 'Earth_Based', 'Japan', 'telescope', 'CEK2XiiFucC9wu8', '14');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('ny3ZGoT', 'INTEGRAL', 'decommissioned', 'Earth_Based', 'Germany', 'telescope', 'Uj51ev84mu89Fln', '15');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('11540t6', 'Swift Gamma Ray Explorer', 'active', 'Earth_Based', 'Mexico', 'telescope', '5cgf62ZAlJY33VD', '16');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('f09aZ5B', 'AGILE', 'active', 'Earth_Based', 'Canada', 'telescope', '9AV9HCkwS79I05o', '17');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('Bavk053', 'Scanning Electron', 'decommissioned', 'light', 'Germany', 'microscope', 'in4icJCV24CtX7V', '18');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('I0K2r5s', 'Fluorescence', 'decommissioned', 'light', 'Mexico', 'microscope', 'GWYZB514dxZPwnK', '19');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('k86354G', 'Confocal', 'active', 'light', 'Brazil', 'microscope', 'Q0kLEfolPtbwUQz', '20');
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('28324H7', 'Dark-Field', 'active', 'light', 'USA', 'microscope', 'pcjyFC2auID0bB0', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('7FTYDL5', 'Super-Resolution', 'active', 'light', 'Canada', 'microscope', '1663A9ul58qHpPC', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('8Y3d29H', 'Light Microscope', 'active', 'simple', 'Canada', 'microscope', 'w74Z3p014H9ldNL', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('LtbAY6n', 'Proton-1', 'active', 'Space_Based', 'Canada', 'telescope', '1RJTtcvzLvVVc3g', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('F3wSNz9', 'Proton-2', 'decommissioned', 'Space_Based', 'Germany', 'telescope', 'EkXqT69J9c6TO4Z', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('0B3N2ml', 'SAS-B', 'decommissioned', 'Space_Based', 'USA', 'telescope', '2Mgcc2DENWb8CYv', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('lJizTZe', 'HEAO 3', 'active', 'Space_Based', 'USA', 'telescope', 'h8eSu5o90Y5uWyJ', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('ngXl473', 'Gamma', 'active', 'Space_Based', 'USA', 'telescope', 'n1nwbE1UGJejQmK', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('5bEjLbH', 'CGRO', 'decommissioned', 'Space_Based', 'USA', 'telescope', 'NuF7K38abRBXJo0', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('bKli3B9', 'HETE 2', 'decommissioned', 'Space_Based', 'Mexico', 'telescope', 'EcDJi2H3k0av0H2', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('5P8hrtM', 'Fermi Gamma-ray Telescope', 'decommissioned', 'Space_Based', 'Canada', 'telescope', 'Je3jYo4X6ey7H96', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('rwhD3bC', 'SOHO', 'active', 'Survey', 'Brazil', 'camera', 'fi46QMnBR1fs5sc', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('06yKN2E', 'New Horizons', 'decommissioned', 'Survey', 'Brazil', 'camera', 'epEg50S2Q1G4y3J', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('Uf316p9', 'Lunar Reconnaissance', 'decommissioned', 'Survey', 'USA', 'camera', 'CD18IrdXG9b9a40', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('MJ5dTD5', 'Kepler Space', 'decommissioned', 'Survey', 'Japan', 'camera', 'XVa4Q3tqv8D5d4c', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('oSt1ncS', 'Gaia spacecraft', 'decommissioned', 'Survey', 'Canada', 'camera', 'gF56Zis1LpCSatI', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('ntJ57V9', 'Kepler Space', 'active', 'Survey', 'Mexico', 'camera', 'SRP40caz29535DI', NULL);
INSERT INTO `SpaceAgency`.`EQUIPMENT` (`equip_ID`, `name`, `status`, `type`, `origin_country`, `equip_type`, `machinery_ID`, `partner_org_code`) VALUES ('VF0roU2', 'Cassini spacecraft', 'decommissioned', 'Wide field', 'Brazil', 'camera', 'sM80JgTfEPM2BLs', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`COMMUNICATION_Satellite`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`COMMUNICATION_Satellite` (`orbit_type`, `purpose`, `equip_ID`) VALUES ('polar', 'Earth observation', 't6b1WCX');
INSERT INTO `SpaceAgency`.`COMMUNICATION_Satellite` (`orbit_type`, `purpose`, `equip_ID`) VALUES ('polar', 'GPS', 'Ui37A19');
INSERT INTO `SpaceAgency`.`COMMUNICATION_Satellite` (`orbit_type`, `purpose`, `equip_ID`) VALUES ('geostationary', 'GPS', 'H89GC23');
INSERT INTO `SpaceAgency`.`COMMUNICATION_Satellite` (`orbit_type`, `purpose`, `equip_ID`) VALUES ('low Earth', 'GPS', 'tm1929c');
INSERT INTO `SpaceAgency`.`COMMUNICATION_Satellite` (`orbit_type`, `purpose`, `equip_ID`) VALUES ('polar', 'Earth observation', 'tFP4rx7');
INSERT INTO `SpaceAgency`.`COMMUNICATION_Satellite` (`orbit_type`, `purpose`, `equip_ID`) VALUES ('geostationary', 'scientific research', 'qsM2oMU');
INSERT INTO `SpaceAgency`.`COMMUNICATION_Satellite` (`orbit_type`, `purpose`, `equip_ID`) VALUES ('polar', 'Earth observation', 'KyfWK86');
INSERT INTO `SpaceAgency`.`COMMUNICATION_Satellite` (`orbit_type`, `purpose`, `equip_ID`) VALUES ('geostationary', 'GPS', 'b15acs2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`INSPECTOR`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('69-7131770', 'H89GC23');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('74-2586602', 'tm1929c');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('64-3715292', 'tFP4rx7');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('62-6558885', 'qsM2oMU');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('01-8223240', 'H89GC23');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('66-9702024', 'tm1929c');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('38-7726916', 'tFP4rx7');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('70-1541734', 'qsM2oMU');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('04-4951183', 't6b1WCX');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('53-1327041', 't6b1WCX');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('25-2274441', 't6b1WCX');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('70-8215677', 't6b1WCX');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('58-9025839', 'H89GC23');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('56-6820365', 'tm1929c');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('09-0412327', 'tFP4rx7');
INSERT INTO `SpaceAgency`.`INSPECTOR` (`STAFF_CIN`, `C_Sat_ID`) VALUES ('09-2059601', 'qsM2oMU');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`CREW`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`CREW` (`crew_ID`, `name`, `start_date`, `status`) VALUES ('D0-9B-7B-6D-F8-AE', 'Otcom', '2016-12-12', 'active');
INSERT INTO `SpaceAgency`.`CREW` (`crew_ID`, `name`, `start_date`, `status`) VALUES ('6F-96-07-30-85-B7', 'Viva', '2018-10-3', 'active');
INSERT INTO `SpaceAgency`.`CREW` (`crew_ID`, `name`, `start_date`, `status`) VALUES ('CD-F2-E3-5A-42-C9', 'Voltsillam', '2018-5-16', 'decomissioned');
INSERT INTO `SpaceAgency`.`CREW` (`crew_ID`, `name`, `start_date`, `status`) VALUES ('31-22-D6-30-5F-45', 'Matsoft', '2019-9-26', 'active');
INSERT INTO `SpaceAgency`.`CREW` (`crew_ID`, `name`, `start_date`, `status`) VALUES ('30-85-D2-09-62-64', 'Hatity', '2021-8-23', 'decomissioned');
INSERT INTO `SpaceAgency`.`CREW` (`crew_ID`, `name`, `start_date`, `status`) VALUES ('1E-B4-AF-18-3D-4B', 'Stronghold', '2022-4-20', 'active');
INSERT INTO `SpaceAgency`.`CREW` (`crew_ID`, `name`, `start_date`, `status`) VALUES ('BF-6E-5B-7F-A0-D0', 'Biodex', '2017-5-4', 'active');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`ASTRONAUT`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007802', 8, 'harvard university', 8, 'D0-9B-7B-6D-F8-AE');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007803', 5, 'Harvard University', 13, 'D0-9B-7B-6D-F8-AE');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007804', 6, 'Stanford University', 15, 'D0-9B-7B-6D-F8-AE');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007805', 5, 'Massachusetts Institute of Technology', 7, 'D0-9B-7B-6D-F8-AE');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007806', 5, 'University of Cambridge', 15, '6F-96-07-30-85-B7');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007807', 9, 'California Institute of Technology', 1, '6F-96-07-30-85-B7');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007808', 10, 'Princeton University', 6, '6F-96-07-30-85-B7');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007809', 5, 'University of Oxford', 2, '6F-96-07-30-85-B7');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007810', 10, 'University of Chicago', 11, 'CD-F2-E3-5A-42-C9');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007811', 8, 'Yale University', 6, 'CD-F2-E3-5A-42-C9');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007812', 7, 'Columbia University', 4, 'CD-F2-E3-5A-42-C9');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007813', 5, 'University of Pennsylvania', 7, 'CD-F2-E3-5A-42-C9');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007814', 7, 'University of California', 6, '31-22-D6-30-5F-45');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007815', 9, 'Berkeley', 1, '31-22-D6-30-5F-45');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007816', 6, 'University of Michigan', 13, '31-22-D6-30-5F-45');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007817', 8, 'University of Toronto', 13, '31-22-D6-30-5F-45');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007818', 7, 'University of Tokyo', 1, '31-22-D6-30-5F-45');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007819', 9, 'University of Melbourne', 12, '31-22-D6-30-5F-45');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007820', 4, 'University of Sydney', 10, '31-22-D6-30-5F-45');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007821', 7, 'University of Auckland', 5, '1E-B4-AF-18-3D-4B');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007822', 8, 'University of Cape Town', 4, '1E-B4-AF-18-3D-4B');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007823', 9, 'University of Sao Paulo', 6, '1E-B4-AF-18-3D-4B');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007824', 6, 'University of Buenos Aires', 7, '1E-B4-AF-18-3D-4B');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007825', 5, 'University of Paris', 8, '1E-B4-AF-18-3D-4B');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007826', 7, 'University of Rome', 5, '1E-B4-AF-18-3D-4B');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007827', 6, 'University of Moscow', 9, '1E-B4-AF-18-3D-4B');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007828', 8, 'University of Beijing', 4, '30-85-D2-09-62-64');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007829', 10, 'University of Delhi', 2, '30-85-D2-09-62-64');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007830', 10, 'University of Johannesburg', 11, '30-85-D2-09-62-64');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007831', 7, 'University of Cairo', 14, '30-85-D2-09-62-64');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007832', 8, 'University of Nairobi', 5, '30-85-D2-09-62-64');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007833', 9, 'University of Mexico City', 9, 'BF-6E-5B-7F-A0-D0');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007834', 5, 'University of Buenos Aires', 8, 'BF-6E-5B-7F-A0-D0');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007835', 6, 'University of Rio de Janeiro', 9, 'BF-6E-5B-7F-A0-D0');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007836', 8, 'University of Sydney', 5, 'BF-6E-5B-7F-A0-D0');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007837', 7, 'University of Melbourne', 7, 'BF-6E-5B-7F-A0-D0');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007838', 9, 'University of Auckland', 14, 'BF-6E-5B-7F-A0-D0');
INSERT INTO `SpaceAgency`.`ASTRONAUT` (`STAFF_CIN`, `physical_fitness`, `education`, `experience`, `crew_ID`) VALUES ('64-9007839', 5, 'University of Cape Town', 22, 'BF-6E-5B-7F-A0-D0');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`SCIENTISTS`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('53-1390712', 'psychology');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('81-5042308', 'astronomy');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('60-1726821', 'biology');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('59-9735698', 'biology');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('93-0617695', 'environmental science');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('25-5219638', 'physics');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('76-5613174', 'environmental science');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('95-9095646', 'physics');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('42-2966590', 'psychology');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('20-4628825', 'psychology');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('17-5569241', 'mathematics');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('89-7594565', 'biology');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('15-3216599', 'computer science');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('21-7823598', 'neuroscience');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('31-9141984', 'environmental science');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('83-0348398', 'physics');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('46-0620883', 'neuroscience');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('21-3933120', 'psychology');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('84-1393635', 'mathematics');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('63-3763851', 'chemistry');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('48-8062241', 'biology');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('49-6487525', 'computer science');
INSERT INTO `SpaceAgency`.`SCIENTISTS` (`STAFF_CIN`, `specialty`) VALUES ('79-9284024', 'physics');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`EARTH_Telescope`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`EARTH_Telescope` (`diameter`, `focal_length`, `mount_type`, `location`, `equip_ID`) VALUES (227.19, 1102, 'altazimuth', 'France_Paris_Champs', 's554crG');
INSERT INTO `SpaceAgency`.`EARTH_Telescope` (`diameter`, `focal_length`, `mount_type`, `location`, `equip_ID`) VALUES (113.31, 1293, 'altazimuth', 'Canada_Toronto_Maple Avenue', 'jU5OTKZ');
INSERT INTO `SpaceAgency`.`EARTH_Telescope` (`diameter`, `focal_length`, `mount_type`, `location`, `equip_ID`) VALUES (133.76, 1646, 'equatorial', 'UK_London_Oxford Street', '8XUm7jG');
INSERT INTO `SpaceAgency`.`EARTH_Telescope` (`diameter`, `focal_length`, `mount_type`, `location`, `equip_ID`) VALUES (121.84, 533, 'altazimuth', 'USA_New York_Main Street', 'A28P3f1');
INSERT INTO `SpaceAgency`.`EARTH_Telescope` (`diameter`, `focal_length`, `mount_type`, `location`, `equip_ID`) VALUES (171.07, 1337, 'equatorial', 'France_Paris_Champs', 'ABN6bLW');
INSERT INTO `SpaceAgency`.`EARTH_Telescope` (`diameter`, `focal_length`, `mount_type`, `location`, `equip_ID`) VALUES (241, 830, 'equatorial', 'Canada_Toronto_Maple Avenue', 'ny3ZGoT');
INSERT INTO `SpaceAgency`.`EARTH_Telescope` (`diameter`, `focal_length`, `mount_type`, `location`, `equip_ID`) VALUES (156.7, 1298, 'altazimuth', 'France_Paris_Champs', '11540t6');
INSERT INTO `SpaceAgency`.`EARTH_Telescope` (`diameter`, `focal_length`, `mount_type`, `location`, `equip_ID`) VALUES (231.68, 1960, 'altazimuth', 'UK_London_Oxford Street', 'f09aZ5B');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`SPACECRAFT`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('EYW-126-AX', 'Apollo 11', 'rover', 'LC-39A', 'small', '1000 kg', 'active', 'solar', 19988, '313', 'Ug1BPfbZ2JETum4', 'H89GC23');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('VHB-453-FG', 'Voyager 1', 'space probe', 'LC-40', 'medium', '1500 kg', 'lost', 'nuclear', 15317, '90', 'KVkck5yg15N4sxQ', 'tm1929c');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('BPA-988-TY', 'Curiosity', 'crewedspacecraft', 'SLC-40', 'large', '2000 kg', 'retired', 'solar', 1242, '396', '3d1thfyIY97sqUa', 'tFP4rx7');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('VMN-354-NB', 'Hubble', 'auto', 'SLC-41', 'extra small', '2500 kg', 'active', 'nuclear', 83132, '86', 'uZA50p689X11u7z', 'qsM2oMU');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('HWU-880-IR', 'Challenger', 'rover', 'LC-11', 'extra large', '3000 kg', 'lost', 'solar', 29820, '580', '8Wm7L8hit84Egp1', 'H89GC23');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('PTY-185-RY', 'Columbia', 'space probe', 'LC-22', 'tiny', '3500 kg', 'retired', 'nuclear', 92885, '358', '902ODfE4Y3m5sbc', 'tm1929c');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('YXJ-464-RU', 'Discovery', 'crewedspacecraft', 'SLC-9', 'gigantic', '4000 kg', 'active', 'solar', 69749, '2', 'BrY9vNOttZ1J46I', 'tFP4rx7');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('GNP-234-YZ', 'Endeavour', 'auto', 'LC-17', 'compact', '4500 kg', 'lost', 'nuclear', 98624, '59', '53TyXIau15V2NB0', 'qsM2oMU');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('BAY-529-YE', 'Atlantis', 'rover', 'SLC-6', 'oversized', '5000 kg', 'retired', 'solar', 81579, '302', 'LZrV6ZJ6JiJ53Qy', 'H89GC23');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('PMV-163-DP', 'Gemini 7', 'space probe', 'LC-31', 'miniature', '5500 kg', 'active', 'nuclear', 72387, '775', 'QinbRG1yj3P6YJ2', 'tm1929c');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('ZZQ-767-NO', 'Mercury-Redstone 3', 'crewedspacecraft', 'LC-55', 'massive', '6000 kg', 'lost', 'solar', 87718, '740', '925s822LAcnw3np', 'tFP4rx7');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('OUZ-894-VM', 'Gemini 12', 'auto', 'SLC-2', 'petite', '6500 kg', 'retired', 'nuclear', 9526, '551', 'lAVj7bcfNL68YQe', 'qsM2oMU');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('GHG-890-RJ', 'Apollo 13', 'rover', 'LC-77', 'jumbo', '7000 kg', 'active', 'solar', 63684, '271', 'eUs318js9386y9p', 'H89GC23');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('VXD-817-GU', 'Skylab', 'space probe', 'LC-88', 'colossal', '7500 kg', 'lost', 'nuclear', 80100, '693', '144HNo0wnJDuHO1', 'tm1929c');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('MRX-617-ER', 'Pioneer 10', 'crewedspacecraft', 'SLC-13', 'microscopic', '8000 kg', 'retired', 'solar', 91029, '360', 'ycwVsLmnznKbxqS', 'tFP4rx7');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('AUJ-238-WG', 'Viking 1', 'auto', 'LC-66', 'enormous', '8500 kg', 'active', 'nuclear', 19622, '811', 'L54Jna0EIcKmS71', 'qsM2oMU');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('IKA-796-QD', 'Voyager 2', 'rover', 'LC-44', 'dainty', '9000 kg', 'lost', 'solar', 97053, '1000', '8ncJlWEtgGgk6cX', 'H89GC23');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('VUM-715-UY', 'Galileo', 'space probe', 'SLC-19', 'huge', '9500 kg', 'retired', 'nuclear', 96506, '877', 's27rNptX3gS62T2', 'tm1929c');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('WSJ-228-AN', 'Cassini', 'crewedspacecraft', 'LC-25', 'minuscule', '10000 kg', 'active', 'solar', 27747, '740', 'y66l8QI0z3U61t1', 'tFP4rx7');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('PQN-008-YO', 'New Horizons', 'auto', 'LC-33', 'giant', '10500 kg', 'lost', 'nuclear', 21982, '548', 'Dt434gFe2k98Vzf', 'qsM2oMU');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('PAU-404-JY', 'Juno', 'rover', 'SLC-8', 'titanic', '11000 kg', 'retired', 'solar', 80775, '977', 'YE3F39rCA5y8xk0', 'H89GC23');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('RDM-561-KT', 'Mars Express', 'space probe', 'LC-99', 'diminutive', '11500 kg', 'active', 'nuclear', 44076, '186', 'kioUkIsp0ORraAl', 'tm1929c');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('ZXB-309-LF', 'Spitzer', 'crewedspacecraft', 'LC-12', 'immense', '12000 kg', 'lost', 'solar', 83164, '555', 'ks6DQ0oiF9E4rb8', 'tFP4rx7');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('NZU-400-CZ', 'Kepler', 'auto', 'SLC-16', 'puny', '12500 kg', 'retired', 'nuclear', 87564, '988', '9hpEBiW7ayyH0ZO', 'qsM2oMU');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('NQP-956-XV', 'Chandra', 'rover', 'LC-71', 'monumental', '13000 kg', 'active', 'solar', 19395, '597', 'w974eL2F0bXNmOe', 't6b1WCX');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('CSE-773-JU', 'Rosetta', 'space probe', 'LC-49', 'wee', '13500 kg', 'lost', 'nuclear', 75839, '994', '3Xo3D5Z8wfN9Uhz', 't6b1WCX');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('SSU-171-LL', 'Dawn', 'crewedspacecraft', 'SLC-27', 'vast', '14000 kg', 'retired', 'solar', 48517, '96', '44mh9EN4YI8ZLd4', 't6b1WCX');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('IUC-144-SX', 'Messenger', 'auto', 'LC-62', 'mammoth', '14500 kg', 'active', 'nuclear', 92411, '998', '3BOPmNjfuRaUf8N', 't6b1WCX');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('CUW-635-BC', 'Hayabusa', 'rover', 'LC-14', 'dwarf', '15000 kg', 'lost', 'solar', 74852, '871', '3lzgpkj8qi0HJC6', 't6b1WCX');
INSERT INTO `SpaceAgency`.`SPACECRAFT` (`spacecraft_ID`, `name`, `type`, `launch_pad`, `size`, `weight`, `status`, `power_source`, `c_people`, `c_load`, `machinery_ID`, `C_Sat_ID`) VALUES ('QLK-027-SF', 'Parker Solar Probe', 'space probe', 'SLC-36', 'mighty', '15500 kg', 'retired', 'nuclear', 73644, '480', '0CqGiwJoA8rCM0M', 't6b1WCX');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`SPACE_Telescope`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`SPACE_Telescope` (`diameter`, `focal_length`, `launch_date`, `equip_ID`, `spacecraft_ID`) VALUES (232.36, 442, '2015-1-17', 'LtbAY6n', 'EYW-126-AX');
INSERT INTO `SpaceAgency`.`SPACE_Telescope` (`diameter`, `focal_length`, `launch_date`, `equip_ID`, `spacecraft_ID`) VALUES (204.55, 226, '2015-11-25', 'F3wSNz9', 'VMN-354-NB');
INSERT INTO `SpaceAgency`.`SPACE_Telescope` (`diameter`, `focal_length`, `launch_date`, `equip_ID`, `spacecraft_ID`) VALUES (126.89, 518, '2019-9-8', '0B3N2ml', 'YXJ-464-RU');
INSERT INTO `SpaceAgency`.`SPACE_Telescope` (`diameter`, `focal_length`, `launch_date`, `equip_ID`, `spacecraft_ID`) VALUES (196.54, 146, '2014-2-3', 'lJizTZe', 'PMV-163-DP');
INSERT INTO `SpaceAgency`.`SPACE_Telescope` (`diameter`, `focal_length`, `launch_date`, `equip_ID`, `spacecraft_ID`) VALUES (122.1, 1683, '2020-3-20', 'ngXl473', 'GHG-890-RJ');
INSERT INTO `SpaceAgency`.`SPACE_Telescope` (`diameter`, `focal_length`, `launch_date`, `equip_ID`, `spacecraft_ID`) VALUES (157.73, 1162, '2022-1-22', '5bEjLbH', 'AUJ-238-WG');
INSERT INTO `SpaceAgency`.`SPACE_Telescope` (`diameter`, `focal_length`, `launch_date`, `equip_ID`, `spacecraft_ID`) VALUES (115.63, 330, '2017-12-12', 'bKli3B9', 'WSJ-228-AN');
INSERT INTO `SpaceAgency`.`SPACE_Telescope` (`diameter`, `focal_length`, `launch_date`, `equip_ID`, `spacecraft_ID`) VALUES (203.39, 1508, '2016-8-25', '5P8hrtM', 'RDM-561-KT');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`MATERIAL`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('HYU-931-WI', 'Iron', 'medium', 982.03, 'low', 481.0374, 20.55, 'impermeable', 'delicate');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('NJF-101-ZP', 'Titanium', 'soft', 49.42, 'medium', 652.2115, 721.87, 'impermeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('VLQ-196-DS', 'Gold', 'soft', 228.92, 'low', 68.0898, 934.37, 'permeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('AER-611-UJ', 'Silver', 'hard', 797.13, 'high', 855.0301, 76.4, 'permeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('KEU-196-VK', 'Copper', 'soft', 867.91, 'low', 798.1565, 268.66, 'impermeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('ISE-104-CG', 'Platinum', 'hard', 930.52, 'low', 107.5638, 70.62, 'permeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('MMY-169-MI', 'Diamond', 'medium', 613.75, 'high', 554.1897, 871.09, 'impermeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('VNA-314-IQ', 'Emerald', 'hard', 955.95, 'medium', 700.7257, 921.24, 'permeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('HGS-762-TG', 'Ruby', 'soft', 174.64, 'medium', 1.185, 952.65, 'impermeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('TKW-916-BX', 'Sapphire', 'soft', 130.85, 'medium', 384.8, 512.1, 'impermeable', 'sturdy');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('LZC-723-RC', 'Amethyst', 'soft', 497.8, 'low', 811.6767, 930.07, 'impermeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('ROS-333-NQ', 'Topaz', 'medium', 470.64, 'low', 227.3489, 526.44, 'impermeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('BTL-208-VW', 'Quartz', 'hard', 265.68, 'high', 42.5552, 159.09, 'impermeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('ZAH-876-CH', 'Obsidian', 'medium', 731.29, 'high', 963.7487, 808.25, 'impermeable', 'delicate');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('ECM-037-SK', 'Opal', 'medium', 856.67, 'high', 872.2495, 538.81, 'permeable', 'sturdy');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('DAK-342-JG', 'Jade', 'soft', 967, 'high', 996.3054, 906.32, 'impermeable', 'delicate');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('MGZ-539-CT', 'Pearl', 'hard', 981.32, 'medium', 284.8212, 60.1, 'impermeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('ZUA-249-TZ', 'Garnet', 'medium', 966.19, 'medium', 416.2144, 922.13, 'impermeable', 'delicate');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('SMV-760-QB', 'Peridot', 'medium', 523.95, 'high', 308.6247, 515.41, 'impermeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('ISL-117-PW', 'Moonstone', 'hard', 169.77, 'high', 292.0092, 697.72, 'impermeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('VFD-529-RJ', 'Lapis Lazuli', 'medium', 562.07, 'high', 283.0798, 770.94, 'impermeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('MLJ-483-GR', 'Malachite', 'soft', 198.91, 'high', 230.5811, 948.76, 'permeable', 'sturdy');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('NQW-948-TG', 'Onyx', 'soft', 920.08, 'medium', 466.8837, 617.19, 'impermeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('ESN-037-AD', 'Agate', 'soft', 816.16, 'low', 341.5814, 410.33, 'permeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('KNS-405-KN', 'Alexandrite', 'medium', 517.36, 'high', 463.7503, 575.12, 'impermeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('YPJ-318-AQ', 'Citrine', 'soft', 330.18, 'high', 494.4461, 140.12, 'permeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('AOO-439-MM', 'Turquoise', 'hard', 709.66, 'high', 521.0206, 341.1, 'permeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('NBX-996-YU', 'Hematite', 'hard', 394.9, 'medium', 145.5951, 840.29, 'impermeable', 'sturdy');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('NTE-916-JT', 'Pyrite', 'hard', 358.88, 'medium', 100.346, 652.72, 'impermeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('ECG-254-PA', 'Beryl', 'medium', 401.48, 'low', 16.6074, 111.72, 'impermeable', 'delicate');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('VYF-518-MM', 'Zircon', 'medium', 265.01, 'high', 123.1274, 184.17, 'permeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('YWY-594-CH', 'Apatite', 'soft', 410.8, 'medium', 219.9792, 65.32, 'impermeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('KLG-861-EA', 'Spinel', 'medium', 632.52, 'low', 780.9494, 685.53, 'permeable', 'sturdy');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('LOU-268-ME', 'Tanzanite', 'hard', 115.87, 'high', 559.6702, 838.49, 'impermeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('HYH-844-GP', 'Aquamarine', 'hard', 173.03, 'medium', 957.1067, 171.54, 'impermeable', 'delicate');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('ULT-045-GH', 'Tourmaline', 'hard', 417.2, 'high', 457.0399, 972.75, 'permeable', 'delicate');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('OZE-815-VI', 'Rhodonite', 'medium', 581.2, 'low', 374.3475, 488.49, 'impermeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('QHO-723-KP', 'Fluorite', 'medium', 474.44, 'medium', 189.6193, 278.27, 'permeable', 'sturdy');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('TFW-208-BD', 'Amber', 'medium', 841.21, 'high', 586.7756, 76.95, 'impermeable', 'sturdy');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('YES-822-NC', 'Coral', 'hard', 412.68, 'high', 354.3079, 771.09, 'impermeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('VKB-634-YI', 'Jet', 'medium', 517.95, 'low', 999.4271, 339.46, 'permeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('MRI-479-LE', 'Iolite', 'soft', 42.79, 'low', 776.8568, 487.95, 'impermeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('WVK-903-FT', 'Kunzite', 'soft', 410.41, 'medium', 894.2445, 63.21, 'permeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('JVE-303-HF', 'Labradorite', 'soft', 629.65, 'medium', 722.292, 322.8, 'impermeable', 'delicate');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('HAF-257-EQ', 'Morganite', 'soft', 62.9, 'high', 75.6008, 449.61, 'impermeable', 'sturdy');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('QGV-932-FS', 'Nephrite', 'hard', 777.04, 'low', 278.273, 651.78, 'impermeable', 'delicate');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('EEN-586-WF', 'Orthoclase', 'soft', 741.38, 'medium', 306.9084, 765.84, 'impermeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('RGI-416-AX', 'Petrified Wood', 'medium', 489.75, 'medium', 38.9288, 338.47, 'impermeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('JRX-885-CD', 'Rhodochrosite', 'soft', 437.45, 'high', 48.89, 176.1, 'impermeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('TCU-372-AC', 'Sunstone', 'soft', 90.9, 'high', 838.9282, 449.11, 'impermeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('OAY-793-EG', 'Tiger Eye', 'medium', 61.68, 'high', 592.6191, 334.93, 'permeable', 'breakable');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('SEN-318-RU', 'Uvarovite', 'soft', 50.85, 'high', 269.359, 746.3, 'permeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('CPK-581-IJ', 'Variscite', 'medium', 944.33, 'high', 119.4368, 260.97, 'permeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('BCM-811-KR', 'Wulfenite', 'medium', 926.36, 'high', 250.5823, 477.68, 'impermeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('PEA-266-KI', 'Xenotime', 'soft', 887.13, 'medium', 905.0781, 233.02, 'permeable', 'delicate');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('POA-847-TT', 'Yttrium', 'medium', 769.42, 'medium', 536.5694, 43.81, 'permeable', 'fragile');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('MUA-560-LD', 'Zoisite', 'hard', 24.09, 'low', 725.667, 438.01, 'impermeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('NAO-396-BC', 'Almandine', 'soft', 0.19, 'low', 799.1431, 312.67, 'permeable', 'delicate');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('JTA-775-XF', 'Bastnäsite', 'soft', 658.54, 'medium', 509.3777, 99.9, 'impermeable', 'brittle');
INSERT INTO `SpaceAgency`.`MATERIAL` (`material_ID`, `name`, `hardness`, `heat_conduction`, `flexibility`, `thermal_conductivity`, `transparency`, `impermeability`, `britleness`) VALUES ('URJ-984-GI', 'Cassiterite', 'soft', 969.8, 'high', 925.3397, 74.76, 'permeable', 'delicate');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`ANALYSIS_Satellite`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`ANALYSIS_Satellite` (`orbit_type`, `purpose`, `sensor_type`, `resolution`, `equip_ID`) VALUES ('geostationary', 'scientific research', 'GPS Receivers', 'Very High Resolution', '9PS22A7');
INSERT INTO `SpaceAgency`.`ANALYSIS_Satellite` (`orbit_type`, `purpose`, `sensor_type`, `resolution`, `equip_ID`) VALUES ('polar', 'Earth observation', 'Magnetometers', 'Medium Resolution', '8b0NgsO');
INSERT INTO `SpaceAgency`.`ANALYSIS_Satellite` (`orbit_type`, `purpose`, `sensor_type`, `resolution`, `equip_ID`) VALUES ('low Earth', 'scientific research', 'Hyperspectral Sensors', 'Very High Resolution', '0lb70fe');
INSERT INTO `SpaceAgency`.`ANALYSIS_Satellite` (`orbit_type`, `purpose`, `sensor_type`, `resolution`, `equip_ID`) VALUES ('geostationary', 'Earth observation', 'Multispectral Sensors', 'Low Resolution', '543uD8T');
INSERT INTO `SpaceAgency`.`ANALYSIS_Satellite` (`orbit_type`, `purpose`, `sensor_type`, `resolution`, `equip_ID`) VALUES ('polar', 'Earth observation', 'Thermal Infrared', 'High Resolution', 'YwG5t5S');
INSERT INTO `SpaceAgency`.`ANALYSIS_Satellite` (`orbit_type`, `purpose`, `sensor_type`, `resolution`, `equip_ID`) VALUES ('polar', 'Earth observation', 'Lidar', 'Medium Resolution', 'dG3Ka8e');
INSERT INTO `SpaceAgency`.`ANALYSIS_Satellite` (`orbit_type`, `purpose`, `sensor_type`, `resolution`, `equip_ID`) VALUES ('polar', 'GPS', 'Radar', 'Very High Resolution', 'Njy0K0w');
INSERT INTO `SpaceAgency`.`ANALYSIS_Satellite` (`orbit_type`, `purpose`, `sensor_type`, `resolution`, `equip_ID`) VALUES ('geostationary', 'Earth observation', 'Radar', 'Very High Resolution', 'jBEhJP3');

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
-- Data for table `SpaceAgency`.`CONTAINS`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID1098', 'HYU-931-WI');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID9876', 'NJF-101-ZP');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID3210', 'VLQ-196-DS');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID6789', 'AER-611-UJ');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID6789', 'KEU-196-VK');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID1098', 'ISE-104-CG');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID7890', 'MMY-169-MI');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID3456', 'VNA-314-IQ');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID7654', 'HGS-762-TG');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0987', 'TKW-916-BX');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID8901', 'LZC-723-RC');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0123', 'ROS-333-NQ');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID3456', 'BTL-208-VW');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0987', 'ZAH-876-CH');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID4321', 'ECM-037-SK');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID4321', 'DAK-342-JG');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID7890', 'MGZ-539-CT');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0123', 'ZUA-249-TZ');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID6543', 'SMV-760-QB');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID8765', 'ISL-117-PW');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID1098', 'VFD-529-RJ');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID9876', 'MLJ-483-GR');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID3210', 'NQW-948-TG');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID6789', 'ESN-037-AD');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID6789', 'KNS-405-KN');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID1098', 'YPJ-318-AQ');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID7890', 'AOO-439-MM');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID3456', 'NBX-996-YU');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID7654', 'NTE-916-JT');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0987', 'ECG-254-PA');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID8901', 'VYF-518-MM');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0123', 'YWY-594-CH');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID3456', 'KLG-861-EA');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0987', 'LOU-268-ME');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID4321', 'HYH-844-GP');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID4321', 'ULT-045-GH');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID7890', 'OZE-815-VI');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0123', 'QHO-723-KP');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID6543', 'TFW-208-BD');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID8765', 'YES-822-NC');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID1098', 'VKB-634-YI');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID9876', 'MRI-479-LE');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID3210', 'WVK-903-FT');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID6789', 'JVE-303-HF');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID6789', 'HAF-257-EQ');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID1098', 'QGV-932-FS');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID7890', 'EEN-586-WF');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID3456', 'RGI-416-AX');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID7654', 'JRX-885-CD');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0987', 'TCU-372-AC');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID8901', 'OAY-793-EG');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0123', 'SEN-318-RU');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID3456', 'CPK-581-IJ');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0987', 'BCM-811-KR');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID4321', 'PEA-266-KI');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID4321', 'POA-847-TT');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID7890', 'MUA-560-LD');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID0123', 'NAO-396-BC');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID6543', 'JTA-775-XF');
INSERT INTO `SpaceAgency`.`CONTAINS` (`planet_ID`, `material_ID`) VALUES ('ID8765', 'URJ-984-GI');

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
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('ATV-529', 'Viking 1', 'Analog Field Testing', 'future', 'Data Collection', '');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('RHP-391', 'Cassini', 'Atmospheric Probe', 'future', 'Research', '');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('GQC-927', 'Hubble', 'Asteroid Deflection', 'past', 'Research', '');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('OEC-003', 'New Horizons', 'Commercial Resupply', 'active', 'Research', '');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('ANN-576', 'Messenger', 'Atmospheric Probe', 'future', 'Experimentation', '');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('BBX-908', 'Sputnik 1', 'Commercial Resupply', 'future', 'Research', '');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('YHH-824', 'Dawn', 'Balloon', 'past', 'Communication', '');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('QGO-610', 'Mars Express', 'Commercial Crew', 'active', 'Research', '');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('BVI-182', 'Hayabusa', 'Commercial Resupply', 'future', 'Research', '');
INSERT INTO `SpaceAgency`.`MISSION` (`mission_ID`, `name`, `type`, `status`, `objective`, `planet_ID`) VALUES ('ETJ-154', 'Clementine', 'Asteroid Deflection', 'past', 'Research', '');

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
-- Data for table `SpaceAgency`.`SUPPLIES`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('21Nxb6A83C0rZ72', '11');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('m78TRSyzqv83UtZ', '11');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('keI214YHbCywTT0', '11');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('k3XUVI335r5s9N5', '12');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('gx58TOZ6cxUiro5', '12');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('b4598tq6mv23wcu', '12');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('tHY1P9dNCf7MK33', '13');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('ukbl9KHcn632l15', '13');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('dfMx20vorOJjQew', '13');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('7z5zZYvUU3jBBHu', '14');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('zIo1w55kOU3xj80', '14');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('Jua19a9zayqRsWJ', '14');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('7akAXwtd9tF6PMc', '15');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('4g5j2V3Ncadvu9V', '15');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('F3QxbgdDY9C03IV', '15');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('Ug1BPfbZ2JETum4', '16');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('KVkck5yg15N4sxQ', '16');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('3d1thfyIY97sqUa', '16');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('uZA50p689X11u7z', '17');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('8Wm7L8hit84Egp1', '17');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('902ODfE4Y3m5sbc', '17');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('BrY9vNOttZ1J46I', '18');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('53TyXIau15V2NB0', '18');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('LZrV6ZJ6JiJ53Qy', '18');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('QinbRG1yj3P6YJ2', '19');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('925s822LAcnw3np', '19');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('lAVj7bcfNL68YQe', '19');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('eUs318js9386y9p', '20');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('144HNo0wnJDuHO1', '20');
INSERT INTO `SpaceAgency`.`SUPPLIES` (`machinery_ID`, `partner_org_code`) VALUES ('ycwVsLmnznKbxqS', '20');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`PARTCIPATE`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('1', 'FZGCL-837', 'Observer');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('1', 'LADLZ-358', 'Data collector');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('1', 'QTBBK-631', 'Case study subject');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('2', 'RKFNN-331', 'Experimental group member');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('2', 'EZQRY-934', 'Survey respondent');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('2', 'NRALG-556', 'Observer');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('3', 'FYOIB-446', 'financial care');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('3', 'YAJLM-820', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('3', 'LUHVA-053', 'Experimental group member');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('4', 'SIPQR-830', 'Case study subject');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('4', 'TPFPG-603', 'Experimental group member');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('4', 'FICMA-763', 'Observer');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('5', 'BZGEZ-117', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('5', 'CPDSW-020', 'financial care');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('5', 'KBDYQ-361', 'financial care');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('6', 'NXWOM-125', 'Data collector');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('6', 'FPGTV-201', 'financial care');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('6', 'YBNCZ-526', 'Survey respondent');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('7', 'RMPJT-291', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('7', 'NMTDX-474', 'Case study subject');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('7', 'FECEY-255', 'Case study subject');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('8', 'MPMUA-611', 'financial care');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('8', 'PTCMJ-513', 'Research assistant');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('8', 'BXFAI-894', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('9', 'NKUOD-777', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('9', 'KTRYX-765', 'Observer');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('9', 'HJVBJ-972', 'Participant observer');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('10', 'IKEAA-464', 'financial care');
INSERT INTO `SpaceAgency`.`PARTCIPATE` (`partner_org_code`, `research_ID`, `category`) VALUES ('10', 'KCKPR-539', 'Participant observer');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`TAKES_OFF`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('XQY-234', '', 'EYW-126-AX', '2019-07-20', '2024-07-20');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('IYS-055', 'D0-9B-7B-6D-F8-AE', 'VHB-453-FG', '2014-09-26', '2024-02-25');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('BQI-280', '6F-96-07-30-85-B7', 'BPA-988-TY', '2005-08-02', '2024-11-18');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('RAD-468', 'CD-F2-E3-5A-42-C9', 'VMN-354-NB', '2006-11-03', '2025-02-22');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('QDP-979', '31-22-D6-30-5F-45', 'HWU-880-IR', '2015-05-23', '2024-12-17');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('VMZ-422', '30-85-D2-09-62-64', 'PTY-185-RY', '2014-06-18', '2021-12-17');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('YUG-796', '1E-B4-AF-18-3D-4B', 'YXJ-464-RU', '2009-01-28', '2022-04-01');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('LPE-268', 'BF-6E-5B-7F-A0-D0', 'GNP-234-YZ', '2006-03-17', '2025-09-08');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('JOM-249', '', 'BAY-529-YE', '2005-07-25', '2022-05-03');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('SDL-405', 'BF-6E-5B-7F-A0-D0', 'PMV-163-DP', '2011-09-17', '2024-05-20');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('NWZ-562', '', 'ZZQ-767-NO', '2008-04-26', '2024-02-28');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('HUK-516', '', 'OUZ-894-VM', '2015-05-28', '2025-06-01');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('MUI-743', '6F-96-07-30-85-B7', 'GHG-890-RJ', '2013-12-22', '2021-12-20');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('GHW-858', 'CD-F2-E3-5A-42-C9', 'VXD-817-GU', '2010-08-22', '2025-10-29');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('TJU-911', '31-22-D6-30-5F-45', 'MRX-617-ER', '2009-06-10', '2025-02-07');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('BMA-097', '30-85-D2-09-62-64', 'AUJ-238-WG', '2008-07-05', '2023-06-12');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('TSU-734', '1E-B4-AF-18-3D-4B', 'IKA-796-QD', '2018-06-18', '2021-01-21');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('QMP-518', 'BF-6E-5B-7F-A0-D0', 'VUM-715-UY', '2010-12-11', '2022-02-16');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('NQS-894', 'CD-F2-E3-5A-42-C9', 'WSJ-228-AN', '2017-12-31', '2024-02-01');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('DYB-158', '31-22-D6-30-5F-45', 'PQN-008-YO', '2010-03-02', '2024-11-08');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('ATV-529', '30-85-D2-09-62-64', 'PAU-404-JY', '2019-04-02', '2022-06-29');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('RHP-391', '1E-B4-AF-18-3D-4B', 'RDM-561-KT', '2010-06-27', '2024-03-27');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('GQC-927', 'BF-6E-5B-7F-A0-D0', 'ZXB-309-LF', '2013-02-01', '2025-01-16');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('OEC-003', '', 'NZU-400-CZ', '2007-08-09', '2023-11-24');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('ANN-576', '', 'NQP-956-XV', '2008-01-25', '2021-02-20');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('BBX-908', '30-85-D2-09-62-64', 'CSE-773-JU', '2008-10-10', '2023-01-06');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('YHH-824', '', 'SSU-171-LL', '2006-03-04', '2024-08-23');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('QGO-610', 'CD-F2-E3-5A-42-C9', 'IUC-144-SX', '2009-01-18', '2024-09-20');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('BVI-182', '', 'CUW-635-BC', '2006-07-03', '2023-11-07');
INSERT INTO `SpaceAgency`.`TAKES_OFF` (`mission_ID`, `crew_ID`, `spacecraft_ID`, `launch_date`, `end_date`) VALUES ('ETJ-154', '1E-B4-AF-18-3D-4B', 'QLK-027-SF', '2008-03-27', '2023-06-05');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceAgency`.`CONDUCT`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceAgency`;
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('53-1390712', '9PS22A7', 'FZGCL-837');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('81-5042308', '8b0NgsO', 'LADLZ-358');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('60-1726821', '0lb70fe', 'QTBBK-631');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('59-9735698', '543uD8T', 'RKFNN-331');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('93-0617695', '491bEHu', 'EZQRY-934');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('25-5219638', 'LUP1f90', 'NRALG-556');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('76-5613174', '23A5T8H', 'FYOIB-446');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('95-9095646', '491bEHu', 'YAJLM-820');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('42-2966590', 'LUP1f90', 'LUHVA-053');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('20-4628825', '23A5T8H', 'SIPQR-830');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('17-5569241', 'k86354G', 'TPFPG-603');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('89-7594565', '28324H7', 'FICMA-763');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('15-3216599', '7FTYDL5', 'BZGEZ-117');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('21-7823598', '8Y3d29H', 'CPDSW-020');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('31-9141984', 'LtbAY6n', 'KBDYQ-361');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('83-0348398', 'k86354G', 'NXWOM-125');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('46-0620883', '28324H7', 'FPGTV-201');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('21-3933120', '7FTYDL5', 'YBNCZ-526');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('84-1393635', '8Y3d29H', 'RMPJT-291');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('63-3763851', 'LtbAY6n', 'NMTDX-474');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('48-8062241', 'H89GC23', 'FECEY-255');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('49-6487525', 'tm1929c', 'MPMUA-611');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('79-9284024', 'tFP4rx7', 'PTCMJ-513');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('53-1390712', 'qsM2oMU', 'BXFAI-894');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('81-5042308', 'k86354G', 'NKUOD-777');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('60-1726821', '28324H7', 'KTRYX-765');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('59-9735698', '7FTYDL5', 'HJVBJ-972');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('93-0617695', '8Y3d29H', 'IKEAA-464');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('25-5219638', 'LtbAY6n', 'KCKPR-539');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('76-5613174', '', 'OOUAS-048');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('95-9095646', '', 'WQTWO-629');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('42-2966590', '', 'PWCPK-273');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('20-4628825', '', 'EKLKK-154');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('17-5569241', '', 'JUTIO-667');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('89-7594565', '', 'HTFSX-858');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('15-3216599', '', 'LUAZU-502');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('21-7823598', '', 'OFQQR-778');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('31-9141984', '', 'VMMOT-286');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('83-0348398', '', 'GGQIH-713');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('46-0620883', '', 'NOGXO-892');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('21-3933120', '', 'MKXMV-148');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('84-1393635', '', 'ZLSCR-009');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('63-3763851', '', 'QLJJW-200');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('48-8062241', '', 'BKTRA-001');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('49-6487525', '', 'OZGFD-178');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('79-9284024', '', 'QBDFO-917');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('17-5569241', '', 'AQNDR-334');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('89-7594565', '', 'LGTCW-484');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('15-3216599', '', 'NFTVD-129');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('21-7823598', '', 'HGIWJ-587');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('31-9141984', '', 'VNCVZ-052');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('83-0348398', '', 'LJGHA-810');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('46-0620883', '', 'OCYWA-974');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('21-3933120', '', 'IXDEL-779');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('84-1393635', '', 'MJSAD-727');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('63-3763851', '', 'PDGNN-003');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('48-8062241', '', 'WXLTQ-093');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('49-6487525', '', 'KBTUW-621');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('79-9284024', '', 'RVPAU-960');
INSERT INTO `SpaceAgency`.`CONDUCT` (`scientist_STAFF_CIN`, `equip_ID`, `research_ID`) VALUES ('60-1726821', '', 'IQFJW-738');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
