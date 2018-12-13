-- MySQL Script generated by MySQL Workbench
-- Mon Dec 10 10:30:15 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema oc_pizza
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS `oc_pizza` ;

-- -----------------------------------------------------
-- Schema oc_pizza
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oc_pizza` DEFAULT CHARACTER SET utf8mb4 ;
USE `oc_pizza` ;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Client` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Client` (
  `id` INT NOT NULL auto_increment,
  `civilite` VARCHAR(4) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `e_mail` VARCHAR(45) NOT NULL,
  `password` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`id`)
  )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Adresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Adresses` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Adresses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom_adresse` VARCHAR(40) NOT NULL,
  `adresse` VARCHAR(45) NOT NULL,
  `complement_adresse` VARCHAR(45) NULL,
  `code_postal` INT NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  `Client_id` INT,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_Adresses_Client_idx` USING BTREE (`Client_id`) VISIBLE,
  CONSTRAINT `fk_Adresses_Client`
    FOREIGN KEY (`Client_id`)
    REFERENCES `oc_pizza`.`Client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Mode_Paiement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Mode_Paiement` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Mode_Paiement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `carte_bancaire` TINYINT NULL,
  `especes` TINYINT NULL,
  `cheque` TINYINT NULL,
  `Commande_id` INT NOT NULL DEFAULT FALSE,
  `Commande_Client_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Commande_id`, `Commande_Client_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Mode_Paiement_Commande_idx` (`Commande_id` ASC, `Commande_Client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Mode_Paiement_Commande1`
    FOREIGN KEY (`Commande_id` , `Commande_Client_id`)
    REFERENCES `oc_pizza`.`Commande` (`id` , `Client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Ligne_Commande`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ligne_Commande` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ligne_Commande` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `prix` FLOAT NOT NULL,
  `quantite` INT NOT NULL,
  `Commande_id` INT NOT NULL DEFAULT FALSE,
  `Commande_Client_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Commande_id`, `Commande_Client_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Ligne_Commande_Commande_idx` (`Commande_id` ASC, `Commande_Client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ligne_Commande_Commande1`
    FOREIGN KEY (`Commande_id` , `Commande_Client_id`)
    REFERENCES `oc_pizza`.`Commande` (`id` , `Client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Commande`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Commande` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Commande` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NOT NULL,
  `complement_adresse` VARCHAR(45) NULL,
  `code_postal` INT NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  `prix_total` FLOAT NOT NULL,
  `Client_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Client_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Commande_Client_idx` (`Client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Commande_Client1`
    FOREIGN KEY (`Client_id`)
    REFERENCES `oc_pizza`.`Client` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Menu` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Menu` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pizza` INT NOT NULL,
  `boisson` INT NULL,
  `dessert` INT NULL,
  `prix` FLOAT NOT NULL,
  `Ligne_Commande_id` INT NOT NULL DEFAULT FALSE,
  `Ligne_Commande_Commande_id` INT NOT NULL DEFAULT FALSE,
  `Ligne_Commande_Commande_Client_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Ligne_Commande_id`, `Ligne_Commande_Commande_id`, `Ligne_Commande_Commande_Client_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Menu_Ligne_Commande_idx` (`Ligne_Commande_id` ASC, `Ligne_Commande_Commande_id` ASC, `Ligne_Commande_Commande_Client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_Ligne_Commande`
    FOREIGN KEY (`Ligne_Commande_id` , `Ligne_Commande_Commande_id` , `Ligne_Commande_Commande_Client_id`)
    REFERENCES `oc_pizza`.`Ligne_Commande` (`id` , `Commande_id` , `Commande_Client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Ligne_Pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ligne_Pizza` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ligne_Pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantite` INT NOT NULL,
  `Menu_id` INT NOT NULL DEFAULT FALSE,
  `Menu_Ligne_Commande_id` INT NOT NULL DEFAULT FALSE,
  `Menu_Ligne_Commande_Commande_id` INT NOT NULL DEFAULT FALSE,
  `Menu_Ligne_Commande_Commande_Client_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Menu_id`, `Menu_Ligne_Commande_id`, `Menu_Ligne_Commande_Commande_id`, `Menu_Ligne_Commande_Commande_Client_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Ligne_Pizza_Menu_idx` (`Menu_id` ASC, `Menu_Ligne_Commande_id` ASC, `Menu_Ligne_Commande_Commande_id` ASC, `Menu_Ligne_Commande_Commande_Client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ligne_Pizza_Menu`
    FOREIGN KEY (`Menu_id` , `Menu_Ligne_Commande_id` , `Menu_Ligne_Commande_Commande_id` , `Menu_Ligne_Commande_Commande_Client_id`)
    REFERENCES `oc_pizza`.`Menu` (`id` , `Ligne_Commande_id` , `Ligne_Commande_Commande_id` , `Ligne_Commande_Commande_Client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Pizza` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `taille` VARCHAR(2) NOT NULL,
  `prix` FLOAT NOT NULL,
  `Ligne_Pizza_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Ligne_Pizza_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Pizza_Ligne_Pizza_idx` (`Ligne_Pizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pizza_Ligne_Pizza1`
    FOREIGN KEY (`Ligne_Pizza_id`)
    REFERENCES `oc_pizza`.`Ligne_Pizza` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Quantite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Quantite` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Quantite` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantite_Ingredient` INT NOT NULL  DEFAULT 1,
  `Ingredients_id` INT NOT NULL  DEFAULT 1,
  PRIMARY KEY (`id`, `Ingredients_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Quantite_Ingredients_idx` (`Ingredients_id` ASC) VISIBLE,
  CONSTRAINT `fk_Quantite_Ingredients1`
    FOREIGN KEY (`Ingredients_id`)
    REFERENCES `oc_pizza`.`Ingredients` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Quantite_has_Pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Quantite_has_Pizza` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Quantite_has_Pizza` (
  `Quantite_id` INT NOT NULL  DEFAULT 1,
  `Pizza_id` INT NOT NULL  DEFAULT 1,
  `Pizza_Ligne_Pizza_id` INT NOT NULL  DEFAULT 1,
  PRIMARY KEY (`Quantite_id`, `Pizza_id`, `Pizza_Ligne_Pizza_id`),
  INDEX `fk_Quantite_has_Pizza_Pizza_idx` (`Pizza_id` ASC, `Pizza_Ligne_Pizza_id` ASC) VISIBLE,
  INDEX `fk_Quantite_has_Pizza_Quantite_idx` (`Quantite_id` ASC) VISIBLE,
  CONSTRAINT `fk_Quantite_has_Pizza_Quantite1`
    FOREIGN KEY (`Quantite_id`)
    REFERENCES `oc_pizza`.`Quantite` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Quantite_has_Pizza_Pizza1`
    FOREIGN KEY (`Pizza_id` , `Pizza_Ligne_Pizza_id`)
    REFERENCES `oc_pizza`.`Pizza` (`id` , `Ligne_Pizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Ligne_Dessert`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ligne_Dessert` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ligne_Dessert` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantite` INT NULL,
  `Menu_id` INT NOT NULL DEFAULT FALSE,
  `Menu_Ligne_Commande_id` INT NOT NULL DEFAULT FALSE,
  `Menu_Ligne_Commande_Commande_id` INT NOT NULL DEFAULT FALSE,
  `Menu_Ligne_Commande_Commande_Client_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Menu_id`, `Menu_Ligne_Commande_id`, `Menu_Ligne_Commande_Commande_id`, `Menu_Ligne_Commande_Commande_Client_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Ligne_Dessert_Menu_idx` (`Menu_id` ASC, `Menu_Ligne_Commande_id` ASC, `Menu_Ligne_Commande_Commande_id` ASC, `Menu_Ligne_Commande_Commande_Client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ligne_Dessert_Menu`
    FOREIGN KEY (`Menu_id` , `Menu_Ligne_Commande_id` , `Menu_Ligne_Commande_Commande_id` , `Menu_Ligne_Commande_Commande_Client_id`)
    REFERENCES `oc_pizza`.`Menu` (`id` , `Ligne_Commande_id` , `Ligne_Commande_Commande_id` , `Ligne_Commande_Commande_Client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Dessert`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Dessert` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Dessert` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `prix` FLOAT NULL,
  `Ligne_Dessert_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Ligne_Dessert_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Dessert_Ligne_Dessert_idx` (`Ligne_Dessert_id` ASC) VISIBLE,
  CONSTRAINT `fk_Dessert_Ligne_Dessert`
    FOREIGN KEY (`Ligne_Dessert_id`)
    REFERENCES `oc_pizza`.`Ligne_Dessert` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Ligne_Boisson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ligne_Boisson` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ligne_Boisson` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantite` INT NOT NULL,
  `Menu_id` INT NOT NULL DEFAULT FALSE,
  `Menu_Ligne_Commande_id` INT NOT NULL DEFAULT FALSE,
  `Menu_Ligne_Commande_Commande_id` INT NOT NULL DEFAULT FALSE,
  `Menu_Ligne_Commande_Commande_Client_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Menu_id`, `Menu_Ligne_Commande_id`, `Menu_Ligne_Commande_Commande_id`, `Menu_Ligne_Commande_Commande_Client_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Ligne_Boisson_Menu_idx` (`Menu_id` ASC, `Menu_Ligne_Commande_id` ASC, `Menu_Ligne_Commande_Commande_id` ASC, `Menu_Ligne_Commande_Commande_Client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ligne_Boisson_Menu`
    FOREIGN KEY (`Menu_id` , `Menu_Ligne_Commande_id` , `Menu_Ligne_Commande_Commande_id` , `Menu_Ligne_Commande_Commande_Client_id`)
    REFERENCES `oc_pizza`.`Menu` (`id` , `Ligne_Commande_id` , `Ligne_Commande_Commande_id` , `Ligne_Commande_Commande_Client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Boisson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Boisson` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Boisson` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prix` FLOAT NOT NULL,
  `Ligne_Boisson_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Ligne_Boisson_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Boisson_Ligne_Boisson_idx` (`Ligne_Boisson_id` ASC) VISIBLE,
  CONSTRAINT `fk_Boisson_Ligne_Boisson1`
    FOREIGN KEY (`Ligne_Boisson_id`)
    REFERENCES `oc_pizza`.`Ligne_Boisson` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Pizzaiolo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Pizzaiolo` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Pizzaiolo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `n_Securite_Sociale` VARCHAR(14) NOT NULL,
  `Ligne_Commande_id` INT NOT NULL DEFAULT FALSE,
  `Ligne_Commande_Commande_id` INT NOT NULL DEFAULT FALSE,
  `Ligne_Commande_Commande_Client_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Ligne_Commande_id`, `Ligne_Commande_Commande_id`, `Ligne_Commande_Commande_Client_id`),
  UNIQUE INDEX `n_Securite_Sociale_UNIQUE` (`n_Securite_Sociale` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Pizzaiolo_Ligne_Commande_idx` (`Ligne_Commande_id` ASC, `Ligne_Commande_Commande_id` ASC, `Ligne_Commande_Commande_Client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pizzaiolo_Ligne_Commande1`
    FOREIGN KEY (`Ligne_Commande_id` , `Ligne_Commande_Commande_id` , `Ligne_Commande_Commande_Client_id`)
    REFERENCES `oc_pizza`.`Ligne_Commande` (`id` , `Commande_id` , `Commande_Client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Facture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Facture` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Facture` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `montant` FLOAT NOT NULL,
  `Commande_id` INT NOT NULL DEFAULT FALSE,
  `Commande_Client_id` INT NOT NULL DEFAULT FALSE,
  `Pizzeria_numero_Siret` VARCHAR(14) NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`, `Commande_id`, `Commande_Client_id`, `Pizzeria_numero_Siret`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Facture_Commande_idx` (`Commande_id` ASC, `Commande_Client_id` ASC) VISIBLE,
  INDEX `fk_Facture_Pizzeria_idx` (`Pizzeria_numero_Siret` ASC) VISIBLE,
  CONSTRAINT `fk_Facture_Commande1`
    FOREIGN KEY (`Commande_id` , `Commande_Client_id`)
    REFERENCES `oc_pizza`.`Commande` (`id` , `Client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Facture_Pizzeria1`
    FOREIGN KEY (`Pizzeria_numero_Siret`)
    REFERENCES `oc_pizza`.`Pizzeria` (`numero_Siret`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Pizzeria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Pizzeria` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Pizzeria` (
  `numero_Siret` VARCHAR(14) NOT NULL,
  `nom_gerant` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NOT NULL,
  `complement_adresse` VARCHAR(45) NULL,
  `code_postal` INT NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`numero_Siret`),
  UNIQUE INDEX `numero_Siret_UNIQUE` (`numero_Siret` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Stocks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Stocks` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Stocks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantite` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Stocks_has_Pizzeria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Stocks_has_Pizzeria` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Stocks_has_Pizzeria` (
  `Stocks_id` INT NOT NULL DEFAULT FALSE,
  `Pizzeria_numero_Siret` VARCHAR(14) NOT NULL DEFAULT 1,
  PRIMARY KEY (`Stocks_id`, `Pizzeria_numero_Siret`),
  INDEX `fk_Stocks_has_Pizzeria_Pizzeria_idx` (`Pizzeria_numero_Siret` ASC) VISIBLE,
  INDEX `fk_Stocks_has_Pizzeria_Stocks_idx` (`Stocks_id` ASC) VISIBLE,
  CONSTRAINT `fk_Stocks_has_Pizzeria_Stocks1`
    FOREIGN KEY (`Stocks_id`)
    REFERENCES `oc_pizza`.`Stocks` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Stocks_has_Pizzeria_Pizzeria1`
    FOREIGN KEY (`Pizzeria_numero_Siret`)
    REFERENCES `oc_pizza`.`Pizzeria` (`numero_Siret`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ingredients` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ingredients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Stocks_has_Ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Stocks_has_Ingredients` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Stocks_has_Ingredients` (
  `Stocks_id` INT NOT NULL DEFAULT FALSE,
  `Ingredients_id` INT NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`Stocks_id`, `Ingredients_id`),
  INDEX `fk_Stocks_has_Ingredients_Ingredients_idx` (`Ingredients_id` ASC) VISIBLE,
  INDEX `fk_Stocks_has_Ingredients_Stocks_idx` (`Stocks_id` ASC) VISIBLE,
  CONSTRAINT `fk_Stocks_has_Ingredients_Stocks1`
    FOREIGN KEY (`Stocks_id`)
    REFERENCES `oc_pizza`.`Stocks` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Stocks_has_Ingredients_Ingredients1`
    FOREIGN KEY (`Ingredients_id`)
    REFERENCES `oc_pizza`.`Ingredients` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
