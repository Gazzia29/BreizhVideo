-- MySQL Script generated by MySQL Workbench
-- Tue Nov 10 16:23:15 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema breizhvideo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema breizhvideo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `breizhvideo` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `breizhvideo` ;

-- -----------------------------------------------------
-- Table `breizhvideo`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `breizhvideo`.`actor` (
  `actor_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`actor_id`),
  INDEX `idx_actor_last_name` (`last_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 201
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `breizhvideo`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `breizhvideo`.`category` (
  `category_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `breizhvideo`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `breizhvideo`.`film` (
  `film_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `release_year` YEAR NULL DEFAULT NULL,
  `length` SMALLINT UNSIGNED NULL DEFAULT NULL,
  `replacement_cost` DECIMAL(5,2) NOT NULL DEFAULT '19.99',
  `rating` ENUM('G', 'PG', 'PG-13', 'R', 'NC-17') NULL DEFAULT 'G',
  `special_features` SET('Trailers', 'Commentaries', 'Deleted Scenes', 'Behind the Scenes') NULL DEFAULT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`film_id`),
  INDEX `idx_title` (`title` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1001
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `breizhvideo`.`film_actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `breizhvideo`.`film_actor` (
  `actor_id` SMALLINT UNSIGNED NOT NULL,
  `film_id` SMALLINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`actor_id`, `film_id`),
  INDEX `idx_fk_film_id` (`film_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_actor_actor`
    FOREIGN KEY (`actor_id`)
    REFERENCES `breizhvideo`.`actor` (`actor_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_film_actor_film`
    FOREIGN KEY (`film_id`)
    REFERENCES `breizhvideo`.`film` (`film_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `breizhvideo`.`film_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `breizhvideo`.`film_category` (
  `film_id` SMALLINT UNSIGNED NOT NULL,
  `category_id` TINYINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`film_id`, `category_id`),
  INDEX `fk_film_category_category` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_category_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `breizhvideo`.`category` (`category_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_film_category_film`
    FOREIGN KEY (`film_id`)
    REFERENCES `breizhvideo`.`film` (`film_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `breizhvideo`.`preference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `breizhvideo`.`preference` (
  `idpreference` INT NOT NULL,
  PRIMARY KEY (`idpreference`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `breizhvideo`.`village`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `breizhvideo`.`village` (
  `idvillage` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `preference_idpreference` INT NOT NULL,
  PRIMARY KEY (`idvillage`),
  INDEX `fk_village_preference1_idx` (`preference_idpreference` ASC) VISIBLE,
  CONSTRAINT `fk_village_preference1`
    FOREIGN KEY (`preference_idpreference`)
    REFERENCES `breizhvideo`.`preference` (`idpreference`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `breizhvideo`.`show`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `breizhvideo`.`show` (
  `idshow` INT NOT NULL,
  `film_film_id` SMALLINT UNSIGNED NOT NULL,
  `village_idvillage` INT NOT NULL,
  `date` DATETIME NULL,
  `heure` INT NULL,
  PRIMARY KEY (`idshow`),
  INDEX `fk_show_film1_idx` (`film_film_id` ASC) VISIBLE,
  INDEX `fk_show_village1_idx` (`village_idvillage` ASC) VISIBLE,
  CONSTRAINT `fk_show_film1`
    FOREIGN KEY (`film_film_id`)
    REFERENCES `breizhvideo`.`film` (`film_id`),
  CONSTRAINT `fk_show_village1`
    FOREIGN KEY (`village_idvillage`)
    REFERENCES `breizhvideo`.`village` (`idvillage`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `breizhvideo`;

DELIMITER $$
USE `breizhvideo`$$
CREATE
DEFINER=`admin`@`%`
TRIGGER `breizhvideo`.`del_film`
AFTER DELETE ON `breizhvideo`.`film`
FOR EACH ROW
BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END$$

USE `breizhvideo`$$
CREATE
DEFINER=`admin`@`%`
TRIGGER `breizhvideo`.`ins_film`
AFTER INSERT ON `breizhvideo`.`film`
FOR EACH ROW
BEGIN
  END$$

USE `breizhvideo`$$
CREATE
DEFINER=`admin`@`%`
TRIGGER `breizhvideo`.`upd_film`
AFTER UPDATE ON `breizhvideo`.`film`
FOR EACH ROW
BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
