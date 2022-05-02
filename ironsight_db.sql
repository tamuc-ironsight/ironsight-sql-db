-- MySQL Script generated by MySQL Workbench
-- Sun 01 May 2022 07:38:04 PM CDT
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
-- Table `ironsight`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`courses` (
  `course_id` VARCHAR(256) NOT NULL,
  `course_name` VARCHAR(256) NULL DEFAULT NULL,
  `course_thumbnail` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE INDEX `course_id_UNIQUE` (`course_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`labs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`labs` (
  `lab_num` INT NOT NULL,
  `lab_name` VARCHAR(45) NULL DEFAULT NULL,
  `lab_description` LONGTEXT NULL DEFAULT NULL,
  `date_start` DATETIME NULL DEFAULT NULL,
  `date_end` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`lab_num`),
  UNIQUE INDEX `lab_num_UNIQUE` (`lab_num` ASC) VISIBLE,
  UNIQUE INDEX `lab_name_UNIQUE` (`lab_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`courses_has_labs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`courses_has_labs` (
  `course_id` VARCHAR(256) NOT NULL,
  `lab_num` INT NOT NULL,
  PRIMARY KEY (`course_id`, `lab_num`),
  INDEX `fk_courses_has_labs_labs1_idx` (`lab_num` ASC) VISIBLE,
  INDEX `fk_courses_has_labs_courses1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_courses_has_labs_courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `ironsight`.`courses` (`course_id`),
  CONSTRAINT `fk_courses_has_labs_labs1`
    FOREIGN KEY (`lab_num`)
    REFERENCES `ironsight`.`labs` (`lab_num`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`tags` (
  `tag` VARCHAR(256) NOT NULL,
  `sub_tag` VARCHAR(256) NULL DEFAULT NULL,
  `type` VARCHAR(45) NOT NULL DEFAULT 'none',
  PRIMARY KEY (`tag`),
  UNIQUE INDEX `tag_UNIQUE` (`tag` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`courses_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`courses_has_tags` (
  `course_id` VARCHAR(256) NOT NULL,
  `tag` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`course_id`, `tag`),
  INDEX `fk_courses_has_tags_tags1_idx` (`tag` ASC) VISIBLE,
  INDEX `fk_courses_has_tags_courses1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_courses_has_tags_courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `ironsight`.`courses` (`course_id`),
  CONSTRAINT `fk_courses_has_tags_tags1`
    FOREIGN KEY (`tag`)
    REFERENCES `ironsight`.`tags` (`tag`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`users` (
  `user_name` VARCHAR(256) NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `password` LONGTEXT NULL DEFAULT NULL,
  `profile_pic_data` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`user_name`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`courses_has_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`courses_has_users` (
  `course_id` VARCHAR(256) NOT NULL,
  `user_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`course_id`, `user_name`),
  INDEX `fk_courses_has_users_users1_idx` (`user_name` ASC) VISIBLE,
  INDEX `fk_courses_has_users_courses1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_courses_has_users_courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `ironsight`.`courses` (`course_id`),
  CONSTRAINT `fk_courses_has_users_users1`
    FOREIGN KEY (`user_name`)
    REFERENCES `ironsight`.`users` (`user_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`vm_templates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`vm_templates` (
  `template_name` VARCHAR(256) NOT NULL,
  `elastic_enrolled` TINYINT NOT NULL DEFAULT '1',
  `description` MEDIUMTEXT NOT NULL,
  `template_data` JSON NULL DEFAULT NULL,
  `template_image` VARCHAR(256) NOT NULL,
  `template_volume_size` INT NOT NULL,
  PRIMARY KEY (`template_name`),
  UNIQUE INDEX `template_name_UNIQUE` (`template_name` ASC) VISIBLE)
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
  `template_name` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`vm_name`),
  UNIQUE INDEX `vm_name_UNIQUE` (`vm_name` ASC) VISIBLE,
  UNIQUE INDEX `elastic_agent_id_UNIQUE` (`elastic_agent_id` ASC) VISIBLE,
  UNIQUE INDEX `harvester_vm_name_UNIQUE` (`harvester_vm_name` ASC) VISIBLE,
  INDEX `template_name_idx` (`template_name` ASC) VISIBLE,
  CONSTRAINT `fk_vm_template_name`
    FOREIGN KEY (`template_name`)
    REFERENCES `ironsight`.`vm_templates` (`template_name`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`courses_has_virtual_machines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`courses_has_virtual_machines` (
  `course_id` VARCHAR(256) NOT NULL,
  `vm_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`course_id`, `vm_name`),
  INDEX `fk_courses_has_virtual_machines_virtual_machines1_idx` (`vm_name` ASC) VISIBLE,
  INDEX `fk_courses_has_virtual_machines_courses1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_courses_has_virtual_machines_courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `ironsight`.`courses` (`course_id`),
  CONSTRAINT `fk_courses_has_virtual_machines_virtual_machines1`
    FOREIGN KEY (`vm_name`)
    REFERENCES `ironsight`.`virtual_machines` (`vm_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`labs_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`labs_has_tags` (
  `lab_num` INT NOT NULL,
  `tag` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`lab_num`, `tag`),
  INDEX `fk_labs_has_tags_tags1_idx` (`tag` ASC) VISIBLE,
  INDEX `fk_labs_has_tags_labs1_idx` (`lab_num` ASC) VISIBLE,
  CONSTRAINT `fk_labs_has_tags_labs1`
    FOREIGN KEY (`lab_num`)
    REFERENCES `ironsight`.`labs` (`lab_num`),
  CONSTRAINT `fk_labs_has_tags_tags1`
    FOREIGN KEY (`tag`)
    REFERENCES `ironsight`.`tags` (`tag`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`labs_has_vm_templates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`labs_has_vm_templates` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lab_num` INT NOT NULL,
  `template_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id`, `lab_num`, `template_name`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_labs_has_vm_templates_vm_templates1_idx` (`template_name` ASC) VISIBLE,
  INDEX `fk_labs_has_vm_templates_labs1_idx` (`lab_num` ASC) VISIBLE,
  CONSTRAINT `fk_labs_has_vm_templates_labs1`
    FOREIGN KEY (`lab_num`)
    REFERENCES `ironsight`.`labs` (`lab_num`),
  CONSTRAINT `fk_labs_has_vm_templates_vm_templates1`
    FOREIGN KEY (`template_name`)
    REFERENCES `ironsight`.`vm_templates` (`template_name`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`log_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`log_data` (
  `log_id` INT NOT NULL AUTO_INCREMENT,
  `log_timestamp` DATETIME NOT NULL,
  `log_username` VARCHAR(256) NOT NULL,
  `log_activity` LONGTEXT NOT NULL,
  PRIMARY KEY (`log_id`),
  UNIQUE INDEX `log_id_UNIQUE` (`log_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 36
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`permissions` (
  `permission_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`permission_name`),
  UNIQUE INDEX `permission_UNIQUE` (`permission_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`roles` (
  `role` VARCHAR(45) NOT NULL,
  `description` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`role`),
  UNIQUE INDEX `role_UNIQUE` (`role` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`roles_has_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`roles_has_permissions` (
  `role` VARCHAR(45) NOT NULL,
  `permission_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role`, `permission_name`),
  INDEX `fk_roles_has_permissions_permissions1_idx` (`permission_name` ASC) VISIBLE,
  INDEX `fk_roles_has_permissions_roles1_idx` (`role` ASC) VISIBLE,
  CONSTRAINT `fk_roles_has_permissions_permissions1`
    FOREIGN KEY (`permission_name`)
    REFERENCES `ironsight`.`permissions` (`permission_name`),
  CONSTRAINT `fk_roles_has_permissions_roles1`
    FOREIGN KEY (`role`)
    REFERENCES `ironsight`.`roles` (`role`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`users_has_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`users_has_roles` (
  `user_name` VARCHAR(256) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_name`, `role`),
  INDEX `fk_users_has_roles_roles1_idx` (`role` ASC) VISIBLE,
  INDEX `fk_users_has_roles_users1_idx` (`user_name` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_roles_roles1`
    FOREIGN KEY (`role`)
    REFERENCES `ironsight`.`roles` (`role`),
  CONSTRAINT `fk_users_has_roles_users1`
    FOREIGN KEY (`user_name`)
    REFERENCES `ironsight`.`users` (`user_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`users_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`users_has_tags` (
  `user_name` VARCHAR(256) NOT NULL,
  `tag` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`user_name`, `tag`),
  INDEX `fk_users_has_tags_tags1_idx` (`tag` ASC) VISIBLE,
  INDEX `fk_users_has_tags_users1_idx` (`user_name` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_tags_tags1`
    FOREIGN KEY (`tag`)
    REFERENCES `ironsight`.`tags` (`tag`),
  CONSTRAINT `fk_users_has_tags_users1`
    FOREIGN KEY (`user_name`)
    REFERENCES `ironsight`.`users` (`user_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`virtual_machine_has_labs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`virtual_machine_has_labs` (
  `vm_name` VARCHAR(256) NOT NULL,
  `lab_num` INT NOT NULL,
  PRIMARY KEY (`vm_name`, `lab_num`),
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
  `user_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`vm_name`, `user_name`),
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


-- -----------------------------------------------------
-- Table `ironsight`.`virtual_machines_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`virtual_machines_has_tags` (
  `vm_name` VARCHAR(256) NOT NULL,
  `tag` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`vm_name`, `tag`),
  INDEX `fk_virtual_machines_has_tags_tags1_idx` (`tag` ASC) VISIBLE,
  INDEX `fk_virtual_machines_has_tags_virtual_machines1_idx` (`vm_name` ASC) VISIBLE,
  CONSTRAINT `fk_virtual_machines_has_tags_tags1`
    FOREIGN KEY (`tag`)
    REFERENCES `ironsight`.`tags` (`tag`),
  CONSTRAINT `fk_virtual_machines_has_tags_virtual_machines1`
    FOREIGN KEY (`vm_name`)
    REFERENCES `ironsight`.`virtual_machines` (`vm_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ironsight`.`vm_templates_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ironsight`.`vm_templates_has_tags` (
  `template_name` VARCHAR(256) NOT NULL,
  `tag` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`template_name`, `tag`),
  INDEX `fk_vm_templates_has_tags_tags1_idx` (`tag` ASC) VISIBLE,
  INDEX `fk_vm_templates_has_tags_vm_templates1_idx` (`template_name` ASC) VISIBLE,
  CONSTRAINT `fk_vm_templates_has_tags_tags1`
    FOREIGN KEY (`tag`)
    REFERENCES `ironsight`.`tags` (`tag`),
  CONSTRAINT `fk_vm_templates_has_tags_vm_templates1`
    FOREIGN KEY (`template_name`)
    REFERENCES `ironsight`.`vm_templates` (`template_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
