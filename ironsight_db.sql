-- MySQL Script generated by MySQL Workbench
-- Sun 27 Mar 2022 08:27:23 PM CDT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ironsight
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ironsight
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ironsight` DEFAULT CHARACTER SET utf8 ;
USE `ironsight` ;

-- -----------------------------------------------------
-- Table `ironsight`.`templates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`templates` (
  `template_name` VARCHAR(45) NOT NULL,
  `operating_system` VARCHAR(45) NOT NULL DEFAULT 'Generic',
  `elastic_enrolled` TINYINT NOT NULL DEFAULT '0',
  `description` MEDIUMTEXT NOT NULL,
  `template_data` JSON NOT NULL,
  `template_image` VARCHAR(45) NOT NULL,
  `template_volume_size` INT NOT NULL,
  PRIMARY KEY (`template_name`),
  UNIQUE INDEX `template_name_UNIQUE` (`template_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`labs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`labs` (
  `lab_num` INT NOT NULL,
  `lab_name` VARCHAR(45) NULL DEFAULT NULL,
  `lab_description` LONGTEXT NULL DEFAULT NULL,
  `template_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`lab_num`),
  UNIQUE INDEX `lab_num_UNIQUE` (`lab_num` ASC) VISIBLE,
  INDEX `fk_template_name_idx` (`template_name` ASC) VISIBLE,
  CONSTRAINT `fk_template_name`
    FOREIGN KEY (`template_name`)
    REFERENCES `ironsight`.`templates` (`template_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`users` (
  `user_name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `role` VARCHAR(45) NOT NULL DEFAULT 'user',
  `password` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`user_name`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`virtual_machines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`virtual_machines` (
  `vm_name` VARCHAR(256) NOT NULL,
  `harvester_vm_name` VARCHAR(256) NULL DEFAULT NULL,
  `port_number` INT NOT NULL,
  `elastic_agent_id` VARCHAR(256) NULL DEFAULT NULL,
  `template_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`vm_name`),
  UNIQUE INDEX `elastic_agent_id_UNIQUE` (`elastic_agent_id` ASC) VISIBLE,
  UNIQUE INDEX `harvester_vm_name_UNIQUE` (`harvester_vm_name` ASC) VISIBLE,
  INDEX `template_name_idx` (`template_name` ASC) VISIBLE,
  CONSTRAINT `fk_vm_template_name`
    FOREIGN KEY (`template_name`)
    REFERENCES `ironsight`.`templates` (`template_name`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`virtual_machine_has_labs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`virtual_machine_has_labs` (
  `vm_name` VARCHAR(256) NOT NULL,
  `lab_num` INT NOT NULL,
  PRIMARY KEY (`vm_name`, `lab_num`),
  UNIQUE INDEX `vm_name_UNIQUE` (`vm_name` ASC) VISIBLE,
  INDEX `fk_virtual_machines_has_labs_labs1_idx` (`lab_num` ASC) VISIBLE,
  INDEX `fk_virtual_machines_has_labs_virtual_machines1_idx` (`vm_name` ASC) VISIBLE,
  CONSTRAINT `fk_virtual_machines_has_labs_labs1`
    FOREIGN KEY (`lab_num`)
    REFERENCES `ironsight`.`labs` (`lab_num`),
  CONSTRAINT `fk_virtual_machines_has_labs_virtual_machines1`
    FOREIGN KEY (`vm_name`)
    REFERENCES `ironsight`.`virtual_machines` (`vm_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`virtual_machine_has_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`virtual_machine_has_users` (
  `vm_name` VARCHAR(256) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`vm_name`, `user_name`),
  UNIQUE INDEX `vm_name_UNIQUE` (`vm_name` ASC) VISIBLE,
  INDEX `fk_virtual_machines_has_users_users1_idx` (`user_name` ASC) VISIBLE,
  INDEX `fk_virtual_machines_has_users_virtual_machines1_idx` (`vm_name` ASC) VISIBLE,
  CONSTRAINT `fk_virtual_machines_has_users_users1`
    FOREIGN KEY (`user_name`)
    REFERENCES `ironsight`.`users` (`user_name`),
  CONSTRAINT `fk_virtual_machines_has_users_virtual_machines1`
    FOREIGN KEY (`vm_name`)
    REFERENCES `ironsight`.`virtual_machines` (`vm_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
