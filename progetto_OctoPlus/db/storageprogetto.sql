-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema storageprogetto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema storageprogetto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `storageprogetto` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `storageprogetto` ;

-- -----------------------------------------------------
-- Table `storageprogetto`.`prodotto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `storageprogetto`.`prodotto` (
  `idProdotto` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(45) NULL DEFAULT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `price` FLOAT NULL DEFAULT NULL,
  `descrizione` TEXT NULL DEFAULT NULL,
  `photo` LONGBLOB NULL DEFAULT NULL,
  `stats` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idProdotto`))
ENGINE = InnoDB
AUTO_INCREMENT = 68
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `storageprogetto`.`articoloordinato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `storageprogetto`.`articoloordinato` (
  `idOrdine` INT NOT NULL,
  `idProdotto` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idOrdine`),
  INDEX `idProdotto_idx` (`idProdotto` ASC) VISIBLE,
  CONSTRAINT `idProdottoO`
    FOREIGN KEY (`idProdotto`)
    REFERENCES `storageprogetto`.`prodotto` (`idProdotto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `storageprogetto`.`utente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `storageprogetto`.`utente` (
  `idutente` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(130) NULL DEFAULT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `cognome` VARCHAR(45) NULL DEFAULT NULL,
  `indirizzo` VARCHAR(45) NULL DEFAULT NULL,
  `cap` VARCHAR(45) NULL DEFAULT NULL,
  `metodo_pagamento` VARCHAR(45) NULL DEFAULT NULL,
  `admin` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`idutente`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `storageprogetto`.`ordine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `storageprogetto`.`ordine` (
  `idOrdine` INT NOT NULL AUTO_INCREMENT,
  `idUtente` INT NULL DEFAULT NULL,
  `data` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idOrdine`),
  INDEX `idUtente_idx` (`idUtente` ASC) VISIBLE,
  CONSTRAINT `idUtente`
    FOREIGN KEY (`idUtente`)
    REFERENCES `storageprogetto`.`utente` (`idutente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `storageprogetto`.`taglie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `storageprogetto`.`taglie` (
  `idProdotto` INT NOT NULL,
  `tagliaM` INT NULL DEFAULT NULL,
  `tagliaL` INT NULL DEFAULT NULL,
  `tagliaXL` INT NULL DEFAULT NULL,
  `tagliaXXL` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idProdotto`),
  CONSTRAINT `idProdotto`
    FOREIGN KEY (`idProdotto`)
    REFERENCES `storageprogetto`.`prodotto` (`idProdotto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
