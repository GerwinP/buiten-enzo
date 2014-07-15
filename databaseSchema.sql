SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `buiten_enzo` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `buiten_enzo` ;

-- -----------------------------------------------------
-- Table `buiten_enzo`.`Klant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buiten_enzo`.`klant` (
  `idKlant` INT NOT NULL AUTO_INCREMENT,
  `Voornaam` VARCHAR(100) NULL,
  `Achternaam` VARCHAR(100) NULL,
  `Telefoonnummer` VARCHAR(100) NULL,
  `Mobielnummer` VARCHAR(100) NULL,
  `Rank` VARCHAR(100) NULL,
  `Wachtwoord` VARCHAR(100) NULL,
  `Emailadres` VARCHAR(100) NULL,
  PRIMARY KEY (`idKlant`),
  UNIQUE KEY (`Emailadres`)
);

-- -----------------------------------------------------
-- Table `buiten_enzo`.`Categorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buiten_enzo`.`Categorie` (
  `idCategorie` INT NOT NULL AUTO_INCREMENT,
  `naam` VARCHAR(100) NULL,
  PRIMARY KEY (`idCategorie`)
);

-- -----------------------------------------------------
-- Table `buiten_enzo`.`Leverancier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buiten_enzo`.`Leverancier` (
  `idLeverancier` INT NOT NULL AUTO_INCREMENT,
  `Naam` VARCHAR(100) NULL,
  `Contactpersoon` VARCHAR(100) NULL,
  `BTWnummer` VARCHAR(100) NULL,
  `KVKnummer` VARCHAR(100) NULL,
  `Telefoonnummer` VARCHAR(100) NULL,
  `Emailadres` VARCHAR(100) NULL,
  `Straat` VARCHAR(100) NULL,
  `Huisnummer` INT NULL,
  `Postcode` VARCHAR(6) NULL,
  `Plaats` VARCHAR(100) NULL,
  `Land` VARCHAR(100) NULL,
  PRIMARY KEY (`idLeverancier`)
);

-- -----------------------------------------------------
-- Table `buiten_enzo`.`Adres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buiten_enzo`.`Adres` (
  `idAdres` INT NOT NULL AUTO_INCREMENT,
  `idKlant` INT NOT NULL,
  `Straat` VARCHAR(120) NULL,
  `Huisnummer` INT NULL,
  `Postcode` VARCHAR(6) NULL,
  `Plaats` VARCHAR(100) NULL,
  `Land` VARCHAR(100) NULL,
  PRIMARY KEY (`idEigenaar`),
  CONSTRAINT `fk_Adres_Klant`
   FOREIGN KEY (`idKlant`)
   REFERENCES `buiten_enzo`.`Klant` (`idKlant`)
   ON DELETE CASCADE
   ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table `buiten_enzo`.`Artikel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buiten_enzo`.`Artikel` (
  `idArtikel` INT NOT NULL AUTO_INCREMENT,
  `Kleur` VARCHAR(100) NULL,
  `Naam` VARCHAR(100) NULL,
  `Beschrijving` TEXT NULL,
  `Prijs` DECIMAL(2,2) NULL,
  `Formaat_breedte` INT NULL,
  `Formaat_hoogte` INT NULL,
  `Formaat_lengte` INT NULL,
  `Leverbaar` TINYINT(1) NULL,
  `Levertijd` VARCHAR(100) NULL,
  `Leeftijd` VARCHAR(100) NULL,
  `Zichtbaar` TINYINT(1) NULL,
  `ArtikelNrLeverancier` VARCHAR(100) NULL,
  `Materiaal` VARCHAR(100) NULL,
  `idLeverancier` INT NULL,
  `idCategorie` INT NULL,
  `InkoopPrijsMet DECIMAL(2,2) NULL,
  `InkoopPrijsZonder` DECIMAL(2,2) NULL,
  `ExtraLevertijd` VARCHAR(100) NULL,
  PRIMARY KEY (`idArtikel`),
  CONSTRAINT `fk_Artikel_Leverancier`
    FOREIGN KEY (`idLeverancier``)
    REFERENCES `buiten_enzo`.`Leverancier` (`idLeverancier``)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Artikel_Categorie`
    FOREIGN KEY (`idCategorie`)
	REFERENCES `buiten_enzo`.`Categorie` (`idCategorie`)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table `buiten_enzo`.`Winkelwagen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buiten_enzo`.`Winkelwagen` (
  `idKlant` INT NOT NULL,
  `idArtikel` INT NOT NULL,
  `Aantal` INT NULL,
  PRIMARY KEY (`idKlant`,`idArtikel`),
  CONSTRAINT `fk_Winkelwagen_Klant`
    FOREIGN KEY (`idKlant`)
    REFERENCES `buiten_enzo`.`Klant` (`idKlant`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Winkelwagen_Artikel`
    FOREIGN KEY (`idArtikel`)
    REFERENCES `buiten_enzo`.`Artikel` (`idArtikel`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table `buiten_enzo`.`Bestelling`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buiten_enzo`.`Bestelling` (
  `idBestelling` INT NOT NULL AUTO_INCREMENT,
  `idKlant` INT NOT NULL,
  `idArtikel` INT NOT NULL,
  `Aantal` INT NULL,
  `idFactuurAdres` INT NOT NULL,
  `idAfleverAdres` INT NOT NULL,
  `Verwerkt` TINYINT(1) NULL,
  `Betaald` TINYINT(1) NULL,
  `Ophalen` TINYINT(1) NULL,
  PRIMARY KEY (`idBestelling`),
  CONSTRAINT `fk_Bestelling_Klant`
    FOREIGN KEY (`idKlant`)
    REFERENCES `buiten_enzo`.`Klant` (`idKlant`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Bestelling_Artikel`
    FOREIGN KEY (`idArtikel`)
    REFERENCES `buiten_enzo`.`Artikel` (`idArtikel`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Bestelling_Adres1`
    FOREIGN KEY (`idFactuurAdres`)
    REFERENCES `buiten_enzo`.`Adres` (`idAdres`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Bestelling_Adres2`
    FOREIGN KEY (`idAfleverAdres`)
    REFERENCES `buiten_enzo`.`Adres` (`idAdres`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
