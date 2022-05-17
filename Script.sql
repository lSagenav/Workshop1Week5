-- creacion de las tablas y la base de datos 

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydbb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydbb
-- -----------------------------------------------------

-- ----------------------------------------------------
-- CREACIION DE LA BASE DE DATOS MYDBB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS mydbb DEFAULT CHARACTER SET utf8 ;
USE mydbb ;



-- ----------------------------------------------------------
-- CREACIÓN DE TODAS LAS TABLAS DE LA BASE DE DATOS CON SUS 
-- RESPECTIVAS VARIABLES Y DATOS REQUERIDOS
-------------------------------------------------------------

-- -----------------------------------------------------
-- Table `mydbb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydbb.Product (
  id_Product INT NOT NULL AUTO_INCREMENT,
  name_product VARCHAR(45) NOT NULL,
  name_Supplier VARCHAR(45) NOT NULL,
  Sale_id_produ INT,
  category_product VARCHAR(45) NOT NULL,
  ordered_product INT NOT NULL,
  price_product DOUBLE NOT NULL,
  creat_at_product DATE NOT NULL,
  anullation_date VARCHAR(45),
  update_product DATE ,
  delete_id_product DATE ,
  PRIMARY KEY (id_Product))
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `mydbb`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydbb.Supplier (
  id_Supplier INT NOT NULL auto_increment,
  name_sup VARCHAR(45) NOT NULL,
  number_phone VARCHAR(45) NOT NULL,
  E_mail VARCHAR(50) NOT NULL,
  number_document_sup INT NOT NULL,
  type_document_sup VARCHAR(45) NOT NULL,
  product_sup VARCHAR(45),
  create_at_sup DATE NOT NULL,
  anullation_date DATE NULL,
  update_sup DATE ,
  delete_sup DATE ,
  PRIMARY KEY (id_Supplier),
  UNIQUE INDEX idSupplier_UNIQUE (id_Supplier ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydbbb`.`Sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydbb.Sale (
  id_Sale INT NOT NULL auto_increment,
  seller_sale INT,
  custumer_sale INT NULL,
  type_product_sale VARCHAR(45) ,
  create_sale DATE NOT NULL,
  anullation_date DATE NULL,
  Saller_id_Saller INT,
  update_sale DATE ,
  delete_sale DATE ,
  PRIMARY KEY (id_Sale, Saller_id_Saller),
  INDEX fk_Sale_Saller1_idx (Saller_id_Saller ASC) VISIBLE,
  CONSTRAINT fk_Sale_Saller1
    FOREIGN KEY (Saller_id_Saller)
    REFERENCES mydb.Saller (id_Saller)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydbb`.`Custumer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydbb.Custumer (
  id_Custumer INT NOT NULL auto_increment,
  Sale_id_cus INT NOT NULL,
  type_document_cus VARCHAR(45) NOT NULL,
  number_document_cus VARCHAR(45) NOT NULL,
  create_at_cus DATE NOT NULL,
  anullation_date DATE NULL,
  update_cus DATE ,
  delete_cus DATE ,
  PRIMARY KEY (id_Custumer))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydbb`.`Saller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydbb.Saller (
  id_Saller INT NOT NULL auto_increment,
  name_sell VARCHAR(45)NOT NULL,
  type_document_sell VARCHAR(45) NOT NULL,
  number_document_sell VARCHAR(45) NOT NULL,
  creat_at_sell DATE NOT NULL,
  anullation_date DATE NULL,
  update_sell DATE,
  delete_sell DATE,
  Saller_id_Saller INT NOT NULL,
  PRIMARY KEY (id_Saller, Saller_id_Saller),
  INDEX fk_Saller_Sale1_idx (Saller_id_Saller ASC) VISIBLE,
  CONSTRAINT fk_Saller_Sale1
    FOREIGN KEY (Saller_id_Saller)
    REFERENCES mydbb.Sale (id_Sale)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydbb`.`Product_has_Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydbb.Product_has_Supplier (
  Product_id_Product INT NOT NULL,
  Supplier_idSupplier INT NOT NULL,
  PRIMARY KEY (Product_id_Product, Supplier_idSupplier),
  INDEX fk_Product_has_Supplier_Supplier1_idx (Supplier_idSupplier ASC) VISIBLE,
  INDEX fk_Product_has_Supplier_Product_idx (Product_id_Product ASC) VISIBLE,
  CONSTRAINT fk_Product_has_Supplier_Product
    FOREIGN KEY (Product_id_Product)
    REFERENCES mydb.Product (id_Product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Product_has_Supplier_Supplier1
    FOREIGN KEY (Supplier_idSupplier)
    REFERENCES mydb.Supplier (id_Supplier)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_has_Saller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydbb.Product_has_Saller (
  Product_id_Product INT NOT NULL,
  Sale_id_Sale INT NOT NULL,
  PRIMARY KEY (Product_id_Product, Sale_id_Sale),
  INDEX fk_Product_has_Saller_Saller1_idx (Sale_id_Sale ASC) VISIBLE,
  INDEX fk_Product_has_Saller_Product1_idx (Product_id_Product ASC) VISIBLE,
  CONSTRAINT fk_Product_has_Saller_Product1
    FOREIGN KEY (Product_id_Product)
    REFERENCES mydbb.Product (id_Product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Product_has_Saller_Saller1
    FOREIGN KEY (Sale_id_Sale)
    REFERENCES mydbb.Saller (id_Saller)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_has_Custumer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydbb.Product_has_Custumer (
  Product_id_Product INT NOT NULL,
  Product_Sale_idSale INT NOT NULL,
  Custumer_idCustumer INT NOT NULL,
  PRIMARY KEY (Product_id_Product, Product_Sale_idSale, Custumer_idCustumer),
  INDEX fk_Product_has_Custumer_Custumer1_idx (Custumer_idCustumer ASC) VISIBLE,
  INDEX fk_Product_has_Custumer_Product1_idx (Product_id_Product ASC, Product_Sale_idSale ASC) VISIBLE,
  CONSTRAINT fk_Product_has_Custumer_Product1
    FOREIGN KEY (Product_id_Product , Product_Sale_idSale)
    REFERENCES mydb.Product (id_Product , Sale_idSale)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Product_has_Custumer_Custumer1
    FOREIGN KEY (Custumer_idCustumer)
    REFERENCES mydb.Custumer (id_Custumer)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_has_Sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydbb.Product_has_Sale (
  Product_id_Product INT NOT NULL,
  Product_Sale_idSale INT NOT NULL,
  Sale_id_Sale INT NOT NULL,
  PRIMARY KEY (Product_id_Product, Product_Sale_idSale, Sale_id_Sale),
  INDEX fk_Product_has_Sale_Sale1_idx (Sale_id_Sale ASC) VISIBLE,
  INDEX fk_Product_has_Sale_Product1_idx (Product_id_Product ASC, Product_Sale_idSale ASC) VISIBLE,
  CONSTRAINT fk_Product_has_Sale_Product1
    FOREIGN KEY (Product_id_Product , Product_Sale_idSale)
    REFERENCES mydb.Product (id_Product , Sale_idSale)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Product_has_Sale_Sale1
    FOREIGN KEY (Sale_id_Sale)
    REFERENCES mydb.Sale (id_Sale)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


#SET SQL_MODE=@OLD_SQL_MODE;
#SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
#SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;