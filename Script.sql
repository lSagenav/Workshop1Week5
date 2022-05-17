-- -----------------------------------------
-- creacion de las tablas y la base de datos 
-- -----------------------------------------

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

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



-- --------------------------------------------------------------------
-- INSERCIÓN DE LOS DATOS EN LAS RESPECTIVAS TABLAS 
-- --------------------------------------------------------------------

insert into product(Sale_id_produ,name_product,ordered_product,category_product,name_Supplier,price_product, creat_at_product)
values
  ("11","Maiz Pira",7,"Grano", "MacDonal",2500,"2020-09-5"),
  ("12","Galletas",78,"Galletas next","MacDonal",3500,"2006-01-27"),
  ("12","Galletas Ducales",7,"Galletas","MacDonal",3500,"2006-01-27"),
  ("12","Panela x6",9,"Energeticos","MacDonal",4200,"2019-06-1"),
  ("15","Salchichón de Pollo",15,"Embutido","MacDonal",6500,"2001-08-2"),
  ("16","Arroz",45,"Grano","MacDonal",2400,"2001-02-5"),
  ("17","Lentejas",41,"Grano","MacDonal",1800,"2003-11-8"),
  ("18","Garbanzos",12,"Grano","MacDonal",1600,"2003-06-17"),
  ("19","Frijol",23,"Grano","MacDonal",7000,"2015-04-12"),
  ("20","Coca Cola",7,"Gaseosa","MacDonal",6000,"2004-02-17");
  
  

 
insert into supplier( type_document_sup, name_sup, number_document_sup,number_phone,E_mail, create_at_sup)
 values
 ("CC" , "Felipe" , "2347625","3132584759","felipe@gmail.com", "2015-05-15"),
 ("CC" , "Pedro" ,"2458625","31125897456","pedro@gmail.com", "2015-05-15"),
 ("CC" , "Jose" ,"23694125","3201589634","jose@gmail.com", "2015-05-15"),
 ("CC" , "Andres" ,"248526625","3215896547","andres@gmail.com", "2015-05-15"),
 ("CC" , "Camilo" ,"23942345","3221589874","camilo@gmail.com", "2015-05-15"),
 ("CC" , "Zack" ,"23287852","3114589632","zack@gmail.com", "2015-05-15"),
 ("CC" , "Camila" ,"23478235","3131478526","camila@gmail.com", "2015-05-15"),
 ("CC" , "Katerine" ,"2554225","3114587596","katerine@gmail.com", "2015-05-15"),
 ("CC" , "Alejandro" ,"92532625","3234589746","alejandro@gmail.com", "2015-05-15"),
 ("CC" , "Sazuke" ,"2452698","3214589746","sazuke@gmail.com", "2015-05-15"),
 ("CC" , "Itachi" ,"45295225","3221597463","itachi@gmail.com", "2015-05-15"),
 ("CC" , "Sunade" ,"124596358","3201478239","sunade@gmail.com", "2015-05-15"),
 ("CC" , "Kakashi" ,"7845292","3217458960","kakashi@gmail.com", "2015-05-15"),
 ("CC" , "Shikamaru" ,"237859625","3214569870","shikamaru@gmail.com", "2015-05-15");
 
 insert into custumer(Sale_id_cus, type_document_cus, number_document_cus, create_at_cus)
 values  
 ("11","CC" , "234765" , "2016-11-20"),
 ("12","CE" , "MX65347" , "2036-10-30"),
 ("13","CC" , "2847625" , "2016-11-29"),
 ("14","CC" , "235347" , "2006-05-28"),
 ("15","CC" , "2346253" , "2016-01-24"),
 ("16","CC" , "8678463" , "2046-11-21"),
 ("17","CE" , "FR764325" , "2006-08-10"),
 ("18","CC" , "934347" , "2036-09-04"),
 ("19","CC" , "9756486" , "2026-10-15"),
 ("20","CE" , "P754547" , "2016-12-21");


insert into sale (Saller_id_Saller,type_product_sale,  create_sale )
values
(  1 , "Arina"," 2016-11-20"),
(  2 , "Pan"," 2036-10-30"),
(  3 , "Platano"," 2016-11-29"),
(  4 , "Galletas"," 2006-05-28"),
(  5 , "Papa"," 2016-01-24"),
(  6 , "Limpido"," 2046-11-21"),
(  7 , "Vive100"," 2006-08-10"),
(  8 , "Fab"," 2036-09-04"),
(  9 , "Panela"," 2026-10-15"),
(  10 , "Limones"," 2016-12-21");

insert into saller (Saller_id_Saller, type_document_sell, number_document_sell,name_sell , creat_at_sell )
values 
(11,"CC" , "12485269" ,"Felipe", "2016-11-20" ),
(12,"CC" , "12448529" , "Pedro","2036-10-30" ),
(13,"CC" ,  "124485269" , "Juan","2016-11-29" ),
(14,"CC" ,  "14485269" , "Camila","2006-05-28" ),
(15,"CC" ,  "12485269" , "Jose","2016-01-24" ),
(16,"CC" ,  "12448526" , "Andres","2046-11-21" ),
(17,"CC" ,  "1244869" , "Kakashi","2006-08-10" ),
(18,"CC" ,  "12445269" , "Sasuke","2036-09-04" ),
(19,"CC" ,  "1241485269" , "Sunade","2026-10-15" ),
(20,"CC" ,  "12441269" , "Inoji","2016-12-21" );



