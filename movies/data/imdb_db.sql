-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Format`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Format` (
  `formatId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`formatId`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Title`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Title` (
  `tconst` VARCHAR(50) NOT NULL,
  `formatId` INT NOT NULL,
  `primaryTitle` VARCHAR(500) NULL DEFAULT NULL,
  `originalTitle` VARCHAR(500) NULL DEFAULT NULL,
  `isAdult` TINYINT NULL DEFAULT NULL,
  `startYear` INT NULL DEFAULT NULL,
  `endYear` INT NULL DEFAULT NULL,
  `runtimeMinutes` INT NULL DEFAULT NULL,
  PRIMARY KEY (`tconst`),
  UNIQUE INDEX `tconst_UNIQUE` (`tconst` ASC) VISIBLE,
  INDEX `fk_Title_Format_idx` (`formatId` ASC) VISIBLE,
  CONSTRAINT `fk_Title_Format`
    FOREIGN KEY (`formatId`)
    REFERENCES `mydb`.`Format` (`formatId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`AliasTitle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AliasTitle` (
  `aliasId` INT NOT NULL AUTO_INCREMENT,
  `titleId` VARCHAR(50) NOT NULL,
  `title` VARCHAR(850) NULL DEFAULT NULL,
  `region` VARCHAR(50) NULL DEFAULT NULL,
  `language` VARCHAR(50) NULL DEFAULT NULL,
  `isOriginalTitle` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`aliasId`, `titleId`),
  UNIQUE INDEX `titleId_UNIQUE` (`aliasId` ASC) VISIBLE,
  INDEX `fk_AliasTitle_Title_idx` (`titleId` ASC) VISIBLE,
  CONSTRAINT `fk_AliasTitle_Title`
    FOREIGN KEY (`titleId`)
    REFERENCES `mydb`.`Title` (`tconst`))
ENGINE = InnoDB
AUTO_INCREMENT = 21960927
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Attribute`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Attribute` (
  `attributeId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`attributeId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`AliasTitleAttribute`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AliasTitleAttribute` (
  `aliasTitleAttributeId` INT NOT NULL AUTO_INCREMENT,
  `attributeId` INT NOT NULL,
  `aliasId` INT NOT NULL,
  PRIMARY KEY (`aliasTitleAttributeId`),
  INDEX `fk_AliasTitleAttribute_Attribute_idx` (`attributeId` ASC) VISIBLE,
  INDEX `fk_AliasTitleAttribute_AliasTitle_idx` (`aliasId` ASC) VISIBLE,
  CONSTRAINT `fk_AliasTitleAttribute_AliasTitle`
    FOREIGN KEY (`aliasId`)
    REFERENCES `mydb`.`AliasTitle` (`aliasId`),
  CONSTRAINT `fk_AliasTitleAttribute_Attribute`
    FOREIGN KEY (`attributeId`)
    REFERENCES `mydb`.`Attribute` (`attributeId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Type` (
  `typeId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`typeId`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`AliasTitleType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AliasTitleType` (
  `aliasTitleTypeId` INT NOT NULL AUTO_INCREMENT,
  `typeId` INT NOT NULL,
  `aliasId` INT NOT NULL,
  PRIMARY KEY (`aliasTitleTypeId`),
  INDEX `fk_AliasTitleType_AliasTitle_idx` (`aliasId` ASC) VISIBLE,
  INDEX `fk_AliasTitleType_Type_idx` (`typeId` ASC) VISIBLE,
  CONSTRAINT `fk_AliasTitleType_AliasTitle`
    FOREIGN KEY (`aliasId`)
    REFERENCES `mydb`.`AliasTitle` (`aliasId`),
  CONSTRAINT `fk_AliasTitleType_Type`
    FOREIGN KEY (`typeId`)
    REFERENCES `mydb`.`Type` (`typeId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Name`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Name` (
  `nconst` VARCHAR(50) NOT NULL,
  `primaryName` VARCHAR(200) NOT NULL,
  `birthYear` INT NULL DEFAULT NULL,
  `deathYear` INT NULL DEFAULT NULL,
  `age` INT NULL DEFAULT NULL,
  `numTitles` INT NULL DEFAULT NULL,
  PRIMARY KEY (`nconst`),
  UNIQUE INDEX `nconst_UNIQUE` (`nconst` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`CrewMember`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CrewMember` (
  `crewMemberId` INT NOT NULL AUTO_INCREMENT,
  `tconst` VARCHAR(50) NOT NULL,
  `nconst` VARCHAR(50) NOT NULL,
  `role` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`crewMemberId`),
  INDEX `fk_CrewMember_Title_idx` (`tconst` ASC) VISIBLE,
  INDEX `fk_CrewMember_Name_idx` (`nconst` ASC) VISIBLE,
  CONSTRAINT `fk_CrewMember_Name`
    FOREIGN KEY (`nconst`)
    REFERENCES `mydb`.`Name` (`nconst`),
  CONSTRAINT `fk_CrewMember_Title`
    FOREIGN KEY (`tconst`)
    REFERENCES `mydb`.`Title` (`tconst`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Episode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Episode` (
  `tconst` VARCHAR(50) NOT NULL,
  `parentTconst` VARCHAR(50) NOT NULL,
  `seasonNumber` INT NULL DEFAULT NULL,
  `episodeNumber` INT NULL DEFAULT NULL,
  PRIMARY KEY (`tconst`, `parentTconst`),
  INDEX `fk_Episode_Title_idx` (`parentTconst` ASC) VISIBLE,
  CONSTRAINT `fk_Episode_Title`
    FOREIGN KEY (`parentTconst`)
    REFERENCES `mydb`.`Title` (`tconst`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Genre` (
  `genreId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`genreId`))
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`KnownFor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`KnownFor` (
  `knownForId` INT NOT NULL AUTO_INCREMENT,
  `nconst` VARCHAR(50) NOT NULL,
  `tconst` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`knownForId`),
  INDEX `fk_NameTitle_Title_idx` (`tconst` ASC) VISIBLE,
  INDEX `fk_NameTitle_Name_idx` (`nconst` ASC) VISIBLE,
  CONSTRAINT `fk_NameTitle_Name`
    FOREIGN KEY (`nconst`)
    REFERENCES `mydb`.`Name` (`nconst`),
  CONSTRAINT `fk_NameTitle_Title`
    FOREIGN KEY (`tconst`)
    REFERENCES `mydb`.`Title` (`tconst`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Profession`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Profession` (
  `professionId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`professionId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`NameProfession`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`NameProfession` (
  `nameProfId` INT NOT NULL AUTO_INCREMENT,
  `nconst` VARCHAR(50) NOT NULL,
  `professionId` INT NOT NULL,
  PRIMARY KEY (`nameProfId`),
  INDEX `fk_ProfessionName_Name_idx` (`nconst` ASC) VISIBLE,
  INDEX `fk_ProfessionName_Profession_idx` (`professionId` ASC) VISIBLE,
  CONSTRAINT `fk_ProfessionName_Name`
    FOREIGN KEY (`nconst`)
    REFERENCES `mydb`.`Name` (`nconst`),
  CONSTRAINT `fk_ProfessionName_Profession`
    FOREIGN KEY (`professionId`)
    REFERENCES `mydb`.`Profession` (`professionId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Principal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Principal` (
  `principalId` INT NOT NULL AUTO_INCREMENT,
  `tconst` VARCHAR(50) NOT NULL,
  `nconst` VARCHAR(50) NOT NULL,
  `category` VARCHAR(50) NULL DEFAULT NULL,
  `job` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`principalId`),
  INDEX `fk_Principal_Name_idx` (`nconst` ASC) VISIBLE,
  INDEX `fk_Principal_Title_idx` (`tconst` ASC) VISIBLE,
  CONSTRAINT `fk_Principal_Name`
    FOREIGN KEY (`nconst`)
    REFERENCES `mydb`.`Name` (`nconst`),
  CONSTRAINT `fk_Principal_Title`
    FOREIGN KEY (`tconst`)
    REFERENCES `mydb`.`Title` (`tconst`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`PrincipalCharacter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PrincipalCharacter` (
  `principalCharacterId` INT NOT NULL AUTO_INCREMENT,
  `principalId` INT NOT NULL,
  `character` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`principalCharacterId`),
  INDEX `fk_PrincipalCharacter_Principal_idx` (`principalId` ASC) VISIBLE,
  CONSTRAINT `fk_PrincipalCharacter_Principal`
    FOREIGN KEY (`principalId`)
    REFERENCES `mydb`.`Principal` (`principalId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rating` (
  `tconst` VARCHAR(50) NOT NULL,
  `averageRating` FLOAT NOT NULL,
  `numVotes` INT NOT NULL,
  PRIMARY KEY (`tconst`),
  UNIQUE INDEX `tconst_UNIQUE` (`tconst` ASC) VISIBLE,
  INDEX `fk_Rating_Title_idx` (`tconst` ASC) VISIBLE,
  CONSTRAINT `fk_Rating_Title`
    FOREIGN KEY (`tconst`)
    REFERENCES `mydb`.`Title` (`tconst`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`TitleGenre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TitleGenre` (
  `titleGenreId` INT NOT NULL AUTO_INCREMENT,
  `tconst` VARCHAR(50) NOT NULL,
  `genreId` INT NOT NULL,
  PRIMARY KEY (`titleGenreId`),
  INDEX `fk_TitleGenre_Genre_idx` (`genreId` ASC) VISIBLE,
  INDEX `fk_TitleGenre_Title_idx` (`tconst` ASC) VISIBLE,
  CONSTRAINT `fk_TitleGenre_Genre`
    FOREIGN KEY (`genreId`)
    REFERENCES `mydb`.`Genre` (`genreId`),
  CONSTRAINT `fk_TitleGenre_Title`
    FOREIGN KEY (`tconst`)
    REFERENCES `mydb`.`Title` (`tconst`))
ENGINE = InnoDB
AUTO_INCREMENT = 11087533
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
