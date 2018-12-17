-- MySQL Script generated by MySQL Workbench
-- Fri Dec 14 16:51:49 2018
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
CREATE SCHEMA IF NOT EXISTS `oc_pizza` DEFAULT CHARACTER SET utf8 ;
USE `oc_pizza` ;

-- -----------------------------------------------------
-- Table `oc_pizza`.`Client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Client` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `civilite` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `e_mail` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
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
  `client_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Adresses_client_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Adresses_Client`
    FOREIGN KEY (`client_id`)
    REFERENCES `oc_pizza`.`Client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Mode_Paiement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Mode_Paiement` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Mode_Paiement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `carte_bancaire` tinyint NULL,
  `especes` INT NULL,
  `cheque` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
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
  `client_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Commande_Client1_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Commande_Client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `oc_pizza`.`Client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Pizza` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `taille` VARCHAR(3) NOT NULL,
  `prix` FLOAT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Ligne_Pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ligne_Pizza` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ligne_Pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantite` INT NULL,
  `pizza_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Ligne_Pizza_Pizza1_idx` (`pizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ligne_Pizza_Pizza1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `oc_pizza`.`Pizza` (`id`)
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
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Ligne_Dessert`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ligne_Dessert` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ligne_Dessert` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantite` INT NULL,
  `dessert_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Ligne_Dessert_Dessert1_idx` (`dessert_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ligne_Dessert_Dessert1`
    FOREIGN KEY (`dessert_id`)
    REFERENCES `oc_pizza`.`Dessert` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Boisson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Boisson` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Boisson` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `prix` FLOAT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Ligne_Boisson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ligne_Boisson` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ligne_Boisson` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantite` INT NULL,
  `boisson_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Ligne_Boisson_Boisson1_idx` (`boisson_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ligne_Boisson_Boisson1`
    FOREIGN KEY (`boisson_id`)
    REFERENCES `oc_pizza`.`Boisson` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Menu` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Menu` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Ligne_Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ligne_Menu` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ligne_Menu` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ligne_pizza_id` INT NOT NULL,
  `ligne_dessert_id` INT NULL,
  `ligne_boisson_id` INT NULL,
  `menu_id` INT NOT NULL,
  `prix` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Ligne_Menu_Ligne_Pizza1_idx` (`ligne_pizza_id` ASC) VISIBLE,
  INDEX `fk_Ligne_Menu_Ligne_Dessert1_idx` (`ligne_dessert_id` ASC) VISIBLE,
  INDEX `fk_Ligne_Menu_Ligne_Boisson1_idx` (`ligne_boisson_id` ASC) VISIBLE,
  INDEX `fk_Ligne_Menu_Menu1_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ligne_Menu_Ligne_Pizza1`
    FOREIGN KEY (`ligne_pizza_id`)
    REFERENCES `oc_pizza`.`Ligne_Pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ligne_Menu_Ligne_Dessert1`
    FOREIGN KEY (`ligne_dessert_id`)
    REFERENCES `oc_pizza`.`Ligne_Dessert` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ligne_Menu_Ligne_Boisson1`
    FOREIGN KEY (`ligne_boisson_id`)
    REFERENCES `oc_pizza`.`Ligne_Boisson` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ligne_Menu_Menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `oc_pizza`.`Menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Ligne_Commande`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ligne_Commande` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ligne_Commande` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `prix` FLOAT NULL,
  `quantite` INT NULL,
  `commande_id` INT NOT NULL,
  `ligne_menu_id` INT NOT NULL,
  `ligne_pizza_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Ligne_Commande_Commande1_idx` (`commande_id` ASC) VISIBLE,
  INDEX `fk_Ligne_Commande_Ligne_Menu1_idx` (`ligne_menu_id` ASC) VISIBLE,
  INDEX `fk_Ligne_Commande_Ligne_Pizza1_idx` (`ligne_pizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ligne_Commande_Commande1`
    FOREIGN KEY (`commande_id`)
    REFERENCES `oc_pizza`.`Commande` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ligne_Commande_Ligne_Menu1`
    FOREIGN KEY (`ligne_menu_id`)
    REFERENCES `oc_pizza`.`Ligne_Menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ligne_Commande_Ligne_Pizza1`
    FOREIGN KEY (`ligne_pizza_id`)
    REFERENCES `oc_pizza`.`Ligne_Pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
-- Table `oc_pizza`.`Facture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Facture` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Facture` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `montant` FLOAT NOT NULL,
  `pizzeria_numero_Siret` VARCHAR(14) NOT NULL,
  `commande_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Facture_Pizzeria1_idx` (`pizzeria_numero_Siret` ASC) VISIBLE,
  INDEX `fk_Facture_Commande1_idx` (`commande_id` ASC) VISIBLE,
  CONSTRAINT `fk_Facture_Pizzeria1`
    FOREIGN KEY (`pizzeria_numero_Siret`)
    REFERENCES `oc_pizza`.`Pizzeria` (`numero_Siret`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Facture_Commande1`
    FOREIGN KEY (`commande_id`)
    REFERENCES `oc_pizza`.`Commande` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Stocks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Stocks` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Stocks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantite` INT NULL,
  `pizzeria_numero_Siret` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Stocks_Pizzeria1_idx` (`pizzeria_numero_Siret` ASC) VISIBLE,
  CONSTRAINT `fk_Stocks_Pizzeria1`
    FOREIGN KEY (`pizzeria_numero_Siret`)
    REFERENCES `oc_pizza`.`Pizzeria` (`numero_Siret`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
-- Table `oc_pizza`.`Quantite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Quantite` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Quantite` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantite_Ingredient` INT NOT NULL,
  `ingredients_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Quantite_Ingredients1_idx` (`ingredients_id` ASC) VISIBLE,
  CONSTRAINT `fk_Quantite_Ingredients1`
    FOREIGN KEY (`ingredients_id`)
    REFERENCES `oc_pizza`.`Ingredients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Pizzaiolo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Pizzaiolo` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Pizzaiolo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `n_Securite_Sociale` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `n_Securite_Sociale_UNIQUE` (`n_Securite_Sociale` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Ligne_Commande_has_Pizzaiolo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ligne_Commande_has_Pizzaiolo` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ligne_Commande_has_Pizzaiolo` (
  `ligne_commande_id` INT NOT NULL,
  `pizzaiolo_id` INT NOT NULL,
  PRIMARY KEY (`ligne_commande_id`, `pizzaiolo_id`),
  INDEX `fk_Ligne_Commande_has_Pizzaiolo_Pizzaiolo1_idx` (`pizzaiolo_id` ASC) VISIBLE,
  INDEX `fk_Ligne_Commande_has_Pizzaiolo_Ligne_Commande1_idx` (`ligne_commande_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ligne_Commande_has_Pizzaiolo_Ligne_Commande1`
    FOREIGN KEY (`ligne_commande_id`)
    REFERENCES `oc_pizza`.`Ligne_Commande` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ligne_Commande_has_Pizzaiolo_Pizzaiolo1`
    FOREIGN KEY (`pizzaiolo_id`)
    REFERENCES `oc_pizza`.`Pizzaiolo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Ingredients_has_Stocks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Ingredients_has_Stocks` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Ingredients_has_Stocks` (
  `ingredients_id` INT NOT NULL,
  `stocks_id` INT NOT NULL,
  PRIMARY KEY (`ingredients_id`, `stocks_id`),
  INDEX `fk_Ingredients_has_Stocks_Stocks1_idx` (`stocks_id` ASC) VISIBLE,
  INDEX `fk_Ingredients_has_Stocks_Ingredients1_idx` (`ingredients_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ingredients_has_Stocks_Ingredients1`
    FOREIGN KEY (`ingredients_id`)
    REFERENCES `oc_pizza`.`Ingredients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ingredients_has_Stocks_Stocks1`
    FOREIGN KEY (`stocks_id`)
    REFERENCES `oc_pizza`.`Stocks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza`.`Pizza_has_Quantite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oc_pizza`.`Pizza_has_Quantite` ;

CREATE TABLE IF NOT EXISTS `oc_pizza`.`Pizza_has_Quantite` (
  `pizza_id` INT NOT NULL,
  `quantite_id` INT NOT NULL,
  PRIMARY KEY (`pizza_id`, `quantite_id`),
  INDEX `fk_Pizza_has_Quantite_Quantite1_idx` (`quantite_id` ASC) VISIBLE,
  INDEX `fk_Pizza_has_Quantite_Pizza1_idx` (`pizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pizza_has_Quantite_Pizza1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `oc_pizza`.`Pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizza_has_Quantite_Quantite1`
    FOREIGN KEY (`quantite_id`)
    REFERENCES `oc_pizza`.`Quantite` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
