-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema app_flutterDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema app_flutterDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `app_flutterDB` DEFAULT CHARACTER SET utf8 ;
USE `app_flutterDB` ;

-- -----------------------------------------------------
-- Table `app_flutterDB`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `app_flutterDB`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `email` VARCHAR(50) NULL,
  `senha` VARCHAR(8) NULL,
  `orcamento` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app_flutterDB`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `app_flutterDB`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `app_flutterDB`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `app_flutterDB`.`produto` (
  `idproduto` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `valor_unitario` DECIMAL(10,2) NULL,
  `tipo_unidade` ENUM('KG', 'UN', 'L') NULL,
  `categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`idproduto`),
  INDEX `fk_produto_categoria_idx` (`categoria_idcategoria` ASC) VISIBLE,
  CONSTRAINT `fk_produto_categoria`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `app_flutterDB`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
