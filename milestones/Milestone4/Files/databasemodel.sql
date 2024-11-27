-- MySQL Script generated by MySQL Workbench
-- Wed Nov 27 01:27:39 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema librarydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `addresses` ;

CREATE TABLE IF NOT EXISTS `addresses` (
  `addressID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `street_number` INT UNSIGNED NOT NULL,
  `street_name` VARCHAR(16) NOT NULL,
  `city` VARCHAR(16) NOT NULL,
  `state` VARCHAR(16) NOT NULL,
  `zipcode` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`addressID`),
  UNIQUE INDEX `addressID_UNIQUE` (`addressID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `apartments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apartments` ;

CREATE TABLE IF NOT EXISTS `apartments` (
  `apartmentID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aptAddressID` INT UNSIGNED NOT NULL,
  `building_number` INT UNSIGNED NOT NULL,
  `apartment_number` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`apartmentID`, `aptAddressID`),
  UNIQUE INDEX `apartmentID_UNIQUE` (`apartmentID` ASC) INVISIBLE,
  INDEX `apartmentAddressID` (`aptAddressID` ASC) VISIBLE,
  CONSTRAINT `apartmentAddressID`
    FOREIGN KEY (`aptAddressID`)
    REFERENCES `addresses` (`addressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `public libraries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `public libraries` ;

CREATE TABLE IF NOT EXISTS `public libraries` (
  `libraryID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `county_name` VARCHAR(16) NOT NULL,
  `address` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`libraryID`),
  UNIQUE INDEX `county_name_UNIQUE` (`county_name` ASC) VISIBLE,
  UNIQUE INDEX `libraryID_UNIQUE` (`libraryID` ASC) VISIBLE,
  INDEX `libraryAddress_idx` (`address` ASC) VISIBLE,
  CONSTRAINT `libraryAddress`
    FOREIGN KEY (`address`)
    REFERENCES `addresses` (`addressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `library branches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `library branches` ;

CREATE TABLE IF NOT EXISTS `library branches` (
  `branchID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `is_virtual` TINYINT NOT NULL,
  `libraryID` INT UNSIGNED NOT NULL,
  `address` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`branchID`),
  UNIQUE INDEX `branchID_UNIQUE` (`branchID` ASC) VISIBLE,
  INDEX `countyLibraryID_idx` (`libraryID` ASC) VISIBLE,
  INDEX `branchAddressID_idx` (`address` ASC) VISIBLE,
  CONSTRAINT `branchAddressID`
    FOREIGN KEY (`address`)
    REFERENCES `addresses` (`addressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `countyLibraryID`
    FOREIGN KEY (`libraryID`)
    REFERENCES `public libraries` (`libraryID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `items` ;

CREATE TABLE IF NOT EXISTS `items` (
  `item_barcode_number` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `call_number` VARCHAR(32) NOT NULL,
  `title` VARCHAR(32) NOT NULL,
  `owningBranch` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`item_barcode_number`),
  UNIQUE INDEX `itemBarcodeNumber_UNIQUE` (`item_barcode_number` ASC) VISIBLE,
  INDEX `owningBranchID_idx` (`owningBranch` ASC) VISIBLE,
  CONSTRAINT `owningBranchID`
    FOREIGN KEY (`owningBranch`)
    REFERENCES `library branches` (`branchID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `archival`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `archival` ;

CREATE TABLE IF NOT EXISTS `archival` (
  `archivalID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemRecNo` INT UNSIGNED NOT NULL,
  `deweyDecimal` DECIMAL(27,24) NOT NULL,
  `library_of_congress_classification` VARCHAR(32) NOT NULL,
  `item_count` INT UNSIGNED NOT NULL,
  `description` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`archivalID`, `itemRecNo`),
  UNIQUE INDEX `archivalID_UNIQUE` (`archivalID` ASC) VISIBLE,
  INDEX `archivalBarcodeNumber` (`itemRecNo` ASC) VISIBLE,
  CONSTRAINT `archivalBarcodeNumber`
    FOREIGN KEY (`itemRecNo`)
    REFERENCES `items` (`item_barcode_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `av`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `av` ;

CREATE TABLE IF NOT EXISTS `av` (
  `avID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemRecNo` INT UNSIGNED NOT NULL,
  `content_length` TIME NOT NULL,
  `age_rating` VARCHAR(8) NOT NULL,
  `item_count` INT UNSIGNED NOT NULL,
  `description` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`avID`, `itemRecNo`),
  UNIQUE INDEX `avID_UNIQUE` (`avID` ASC) VISIBLE,
  INDEX `avBarcodeNumber` (`itemRecNo` ASC) VISIBLE,
  CONSTRAINT `avBarcodeNumber`
    FOREIGN KEY (`itemRecNo`)
    REFERENCES `items` (`item_barcode_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `patrons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patrons` ;

CREATE TABLE IF NOT EXISTS `patrons` (
  `libraryCardNumber` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(64) NOT NULL,
  `first_name` VARCHAR(32) NOT NULL,
  `middle_name` VARCHAR(32) NULL DEFAULT NULL,
  `last_name` VARCHAR(32) NOT NULL,
  `is_delinquent` TINYINT NOT NULL,
  PRIMARY KEY (`libraryCardNumber`),
  UNIQUE INDEX `libraryCardNumber_UNIQUE` (`libraryCardNumber` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transactions` ;

CREATE TABLE IF NOT EXISTS `transactions` (
  `transactionID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `patronCardNumber` INT UNSIGNED NOT NULL,
  `transactionBranch` INT UNSIGNED NULL DEFAULT NULL,
  `transactionItem` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`transactionID`),
  UNIQUE INDEX `transactionID_UNIQUE` (`transactionID` ASC) VISIBLE,
  INDEX `patronCardNumber_idx` (`patronCardNumber` ASC) VISIBLE,
  INDEX `transactionBranchID_idx` (`transactionBranch` ASC) VISIBLE,
  INDEX `transactionItemBarcodeNumber_idx` (`transactionItem` ASC) VISIBLE,
  CONSTRAINT `patronCardNumber`
    FOREIGN KEY (`patronCardNumber`)
    REFERENCES `patrons` (`libraryCardNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `transactionBranchID`
    FOREIGN KEY (`transactionBranch`)
    REFERENCES `library branches` (`branchID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `transactionItemBarcodeNumber`
    FOREIGN KEY (`transactionItem`)
    REFERENCES `items` (`item_barcode_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `checkouts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `checkouts` ;

CREATE TABLE IF NOT EXISTS `checkouts` (
  `checkoutID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `transRecNo` INT UNSIGNED NOT NULL,
  `checkoutBranch` INT UNSIGNED NOT NULL,
  `checkout_date` DATE NOT NULL,
  PRIMARY KEY (`checkoutID`, `transRecNo`),
  UNIQUE INDEX `checkoutID_UNIQUE` (`checkoutID` ASC) VISIBLE,
  INDEX `checkoutBranchID_idx` (`checkoutBranch` ASC) VISIBLE,
  INDEX `checkoutTransactionID` (`transRecNo` ASC) VISIBLE,
  CONSTRAINT `checkoutTransactionID`
    FOREIGN KEY (`transRecNo`)
    REFERENCES `transactions` (`transactionID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `full-service cards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `full-service cards` ;

CREATE TABLE IF NOT EXISTS `full-service cards` (
  `patronID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `libraryCardNo` INT UNSIGNED NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `phone_number` VARCHAR(16) NOT NULL,
  `address` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`patronID`, `libraryCardNo`),
  UNIQUE INDEX `fullServiceCardID_UNIQUE` (`libraryCardNo` ASC) VISIBLE,
  INDEX `patronAddress_idx` (`address` ASC) VISIBLE,
  CONSTRAINT `patronAddress`
    FOREIGN KEY (`address`)
    REFERENCES `addresses` (`addressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `patronCard`
    FOREIGN KEY (`libraryCardNo`)
    REFERENCES `patrons` (`libraryCardNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `child cards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `child cards` ;

CREATE TABLE IF NOT EXISTS `child cards` (
  `childID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `parentCardNum` INT UNSIGNED NOT NULL,
  `child_first_name` VARCHAR(32) NOT NULL,
  `child_middle_name` VARCHAR(32) NULL DEFAULT NULL,
  `child_last_name` VARCHAR(32) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  PRIMARY KEY (`childID`),
  INDEX `parentLibraryCard` (`parentCardNum` ASC) VISIBLE,
  CONSTRAINT `parentLibraryCard`
    FOREIGN KEY (`parentCardNum`)
    REFERENCES `full-service cards` (`libraryCardNo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `computers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `computers` ;

CREATE TABLE IF NOT EXISTS `computers` (
  `computerID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemRecNo` INT UNSIGNED NOT NULL,
  `computer_number` INT UNSIGNED NOT NULL,
  `is_express` TINYINT NOT NULL,
  `is_laptop` TINYINT NOT NULL,
  `area` VARCHAR(32) NOT NULL,
  `descrption` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`computerID`, `itemRecNo`),
  UNIQUE INDEX `computerID_UNIQUE` (`computerID` ASC) VISIBLE,
  INDEX `copmuterBarcodeNumber` (`itemRecNo` ASC) VISIBLE,
  CONSTRAINT `copmuterBarcodeNumber`
    FOREIGN KEY (`itemRecNo`)
    REFERENCES `items` (`item_barcode_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `digital`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital` ;

CREATE TABLE IF NOT EXISTS `digital` (
  `digitalID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemRecNo` INT UNSIGNED NOT NULL,
  `content_length` VARCHAR(32) NOT NULL,
  `description` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`digitalID`, `itemRecNo`),
  UNIQUE INDEX `digitalID_UNIQUE` (`digitalID` ASC) VISIBLE,
  INDEX `digitalBarcodeNumber` (`itemRecNo` ASC) VISIBLE,
  CONSTRAINT `digitalBarcodeNumber`
    FOREIGN KEY (`itemRecNo`)
    REFERENCES `items` (`item_barcode_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `e-cards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-cards` ;

CREATE TABLE IF NOT EXISTS `e-cards` (
  `ecardID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `libraryCardNo` INT UNSIGNED NOT NULL,
  `date_of_birth` DATE NOT NULL,
  PRIMARY KEY (`ecardID`, `libraryCardNo`),
  UNIQUE INDEX `ecardID_UNIQUE` (`libraryCardNo` ASC) VISIBLE,
  CONSTRAINT `ecardNumber`
    FOREIGN KEY (`libraryCardNo`)
    REFERENCES `patrons` (`libraryCardNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `fiction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fiction` ;

CREATE TABLE IF NOT EXISTS `fiction` (
  `fictionID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemRecNo` INT UNSIGNED NOT NULL,
  `genre` VARCHAR(16) NOT NULL,
  `author_first_name` VARCHAR(32) NOT NULL,
  `author_last_name` VARCHAR(32) NOT NULL,
  `age_rating` VARCHAR(8) NOT NULL,
  `description` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`fictionID`, `itemRecNo`),
  UNIQUE INDEX `fictionID_UNIQUE` (`fictionID` ASC) VISIBLE,
  INDEX `fictionBarcodeNumber` (`itemRecNo` ASC) VISIBLE,
  CONSTRAINT `fictionBarcodeNumber`
    FOREIGN KEY (`itemRecNo`)
    REFERENCES `items` (`item_barcode_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `holds`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `holds` ;

CREATE TABLE IF NOT EXISTS `holds` (
  `holdID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `transRecNo` INT UNSIGNED NOT NULL,
  `owningBranch` INT UNSIGNED NOT NULL,
  `holdingBranch` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`holdID`, `transRecNo`),
  UNIQUE INDEX `holdID_UNIQUE` (`holdID` ASC) VISIBLE,
  INDEX `owningBranchID_idx` (`owningBranch` ASC) VISIBLE,
  INDEX `holdingBranchID_idx` (`holdingBranch` ASC) VISIBLE,
  INDEX `holdTransactionID` (`transRecNo` ASC) VISIBLE,
  CONSTRAINT `holdTransactionID`
    FOREIGN KEY (`transRecNo`)
    REFERENCES `transactions` (`transactionID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `institutional cards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `institutional cards` ;

CREATE TABLE IF NOT EXISTS `institutional cards` (
  `institutionalID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `libraryCardNo` INT UNSIGNED NOT NULL,
  `phone_number` VARCHAR(16) NOT NULL,
  `address` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`institutionalID`, `libraryCardNo`),
  UNIQUE INDEX `institutionalCardID_UNIQUE` (`libraryCardNo` ASC) VISIBLE,
  INDEX `instituionalAddressID_idx` (`address` ASC) VISIBLE,
  CONSTRAINT `instituionalAddressID`
    FOREIGN KEY (`address`)
    REFERENCES `addresses` (`addressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `institutionalCard`
    FOREIGN KEY (`libraryCardNo`)
    REFERENCES `patrons` (`libraryCardNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `institutions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `institutions` ;

CREATE TABLE IF NOT EXISTS `institutions` (
  `institutionID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `instAddressID` INT UNSIGNED NOT NULL,
  `school_district` VARCHAR(16) NOT NULL,
  `school_name` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`institutionID`, `instAddressID`),
  UNIQUE INDEX `institutionID_UNIQUE` (`institutionID` ASC) VISIBLE,
  INDEX `institutionalAddressID` (`instAddressID` ASC) VISIBLE,
  CONSTRAINT `institutionalAddressID`
    FOREIGN KEY (`instAddressID`)
    REFERENCES `addresses` (`addressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `kit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kit` ;

CREATE TABLE IF NOT EXISTS `kit` (
  `kitId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemRecNo` INT UNSIGNED NOT NULL,
  `age_rating` VARCHAR(8) NOT NULL,
  `item_count` INT UNSIGNED NOT NULL,
  `description` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`kitId`, `itemRecNo`),
  UNIQUE INDEX `kitId_UNIQUE` (`kitId` ASC) VISIBLE,
  INDEX `kitBarcodeNumber` (`itemRecNo` ASC) VISIBLE,
  CONSTRAINT `kitBarcodeNumber`
    FOREIGN KEY (`itemRecNo`)
    REFERENCES `items` (`item_barcode_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `libraries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraries` ;

CREATE TABLE IF NOT EXISTS `libraries` (
  `libraryAddressID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `biblioAddressID` INT UNSIGNED NOT NULL,
  `county_region` VARCHAR(16) NOT NULL,
  `branch` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`libraryAddressID`, `biblioAddressID`),
  UNIQUE INDEX `libraryAddressID_UNIQUE` (`libraryAddressID` ASC) VISIBLE,
  UNIQUE INDEX `branch_UNIQUE` (`branch` ASC) VISIBLE,
  INDEX `libraryBranchID_idx` (`branch` ASC) VISIBLE,
  INDEX `libraryAddressID` (`biblioAddressID` ASC) VISIBLE,
  CONSTRAINT `libraryAddressID`
    FOREIGN KEY (`biblioAddressID`)
    REFERENCES `addresses` (`addressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `libraryBranchID`
    FOREIGN KEY (`branch`)
    REFERENCES `library branches` (`branchID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `nonfiction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nonfiction` ;

CREATE TABLE IF NOT EXISTS `nonfiction` (
  `nonFictionID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemRecNo` INT UNSIGNED NOT NULL,
  `deweydecimal` DECIMAL(27,24) NOT NULL,
  `library_of_congress_classification` VARCHAR(32) NOT NULL,
  `topic` VARCHAR(16) NOT NULL,
  `author_first_name` VARCHAR(32) NOT NULL,
  `author_last_name` VARCHAR(32) NOT NULL,
  `age_rating` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`nonFictionID`, `itemRecNo`),
  UNIQUE INDEX `nonFictionID_UNIQUE` (`nonFictionID` ASC) VISIBLE,
  INDEX `nonFictionBarcodeNumber` (`itemRecNo` ASC) VISIBLE,
  CONSTRAINT `nonFictionBarcodeNumber`
    FOREIGN KEY (`itemRecNo`)
    REFERENCES `items` (`item_barcode_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `p.o. boxes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `p.o. boxes` ;

CREATE TABLE IF NOT EXISTS `p.o. boxes` (
  `po_boxID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `poAddressID` INT UNSIGNED NOT NULL,
  `po_box_number` INT UNSIGNED NOT NULL,
  `service_name` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`po_boxID`, `poAddressID`),
  UNIQUE INDEX `po_boxID_UNIQUE` (`po_boxID` ASC) VISIBLE,
  INDEX `poBoxAddressID` (`poAddressID` ASC) VISIBLE,
  CONSTRAINT `poBoxAddressID`
    FOREIGN KEY (`poAddressID`)
    REFERENCES `addresses` (`addressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pass` ;

CREATE TABLE IF NOT EXISTS `pass` (
  `passID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemRecNo` INT UNSIGNED NOT NULL,
  `item_count` INT UNSIGNED NOT NULL,
  `description` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`passID`, `itemRecNo`),
  UNIQUE INDEX `passID_UNIQUE` (`passID` ASC) VISIBLE,
  INDEX `passBarcodeNumber` (`itemRecNo` ASC) VISIBLE,
  CONSTRAINT `passBarcodeNumber`
    FOREIGN KEY (`itemRecNo`)
    REFERENCES `items` (`item_barcode_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `payments` ;

CREATE TABLE IF NOT EXISTS `payments` (
  `paymentID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `transRecNo` INT UNSIGNED NOT NULL,
  `total_paid` DECIMAL(6,2) NOT NULL,
  `total_owed` DECIMAL(6,2) NOT NULL,
  `date_of_payment` DATE NOT NULL,
  PRIMARY KEY (`paymentID`, `transRecNo`),
  UNIQUE INDEX `paymentID_UNIQUE` (`paymentID` ASC) VISIBLE,
  INDEX `paymentTransactionID` (`transRecNo` ASC) VISIBLE,
  CONSTRAINT `paymentTransactionID`
    FOREIGN KEY (`transRecNo`)
    REFERENCES `transactions` (`transactionID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `periodical`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `periodical` ;

CREATE TABLE IF NOT EXISTS `periodical` (
  `periodicalID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemRecNo` INT UNSIGNED NOT NULL,
  `publisher` VARCHAR(32) NOT NULL,
  `age_rating` VARCHAR(8) NOT NULL,
  `issue_date` DATE NOT NULL,
  `volume` INT UNSIGNED NULL DEFAULT NULL,
  `issue` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`periodicalID`, `itemRecNo`),
  UNIQUE INDEX `periodicalID_UNIQUE` (`periodicalID` ASC) VISIBLE,
  INDEX `periodicalBarcodeNumber` (`itemRecNo` ASC) VISIBLE,
  CONSTRAINT `periodicalBarcodeNumber`
    FOREIGN KEY (`itemRecNo`)
    REFERENCES `items` (`item_barcode_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `returns`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `returns` ;

CREATE TABLE IF NOT EXISTS `returns` (
  `returnID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `transRecNo` INT UNSIGNED NOT NULL,
  `returnBranch` INT UNSIGNED NOT NULL,
  `return_date` DATE NOT NULL,
  PRIMARY KEY (`returnID`, `transRecNo`),
  UNIQUE INDEX `returnID_UNIQUE` (`returnID` ASC) VISIBLE,
  INDEX `returnBranchID_idx` (`returnBranch` ASC) VISIBLE,
  INDEX `returnTransactionID` (`transRecNo` ASC) VISIBLE,
  CONSTRAINT `returnTransactionID`
    FOREIGN KEY (`transRecNo`)
    REFERENCES `transactions` (`transactionID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `staff cards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `staff cards` ;

CREATE TABLE IF NOT EXISTS `staff cards` (
  `staffID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `libraryCardNo` INT UNSIGNED NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `phone_number` VARCHAR(16) NOT NULL,
  `address` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`staffID`, `libraryCardNo`),
  UNIQUE INDEX `staffCardID_UNIQUE` (`libraryCardNo` ASC) VISIBLE,
  INDEX `staffAddressID_idx` (`address` ASC) VISIBLE,
  CONSTRAINT `staffAddressID`
    FOREIGN KEY (`address`)
    REFERENCES `addresses` (`addressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `staffCard`
    FOREIGN KEY (`libraryCardNo`)
    REFERENCES `patrons` (`libraryCardNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
