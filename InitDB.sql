CREATE SCHEMA `progettodb` ;

CREATE TABLE `progettodb`.`campo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sport` VARCHAR(45) NOT NULL,
  `tipologia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `progettodb`.`centrosportivo` (
  `nome` VARCHAR(45) NOT NULL,
  `indirizzo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nome`));

CREATE TABLE `progettodb`.`prenotazione` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `ora` TIME NOT NULL,
  `prezzo` DOUBLE NOT NULL,
  `disponibile` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `progettodb`.`ticket` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `ora` TIME NOT NULL,
  `valore` DOUBLE NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `progettodb`.`utente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


ALTER TABLE `progettodb`.`prenotazione` 
ADD COLUMN `id_campo` INT NULL AFTER `disponibile`,
ADD COLUMN `id_utente` INT NULL AFTER `id_campo`,
ADD INDEX `id_campo_idx` (`id_campo` ASC) VISIBLE,
ADD INDEX `id_utente_idx` (`id_utente` ASC) VISIBLE;
;
ALTER TABLE `progettodb`.`prenotazione` 
ADD CONSTRAINT `id_campo`
  FOREIGN KEY (`id_campo`)
  REFERENCES `progettodb`.`campo` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `id_utente`
  FOREIGN KEY (`id_utente`)
  REFERENCES `progettodb`.`utente` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `progettodb`.`ticket` 
ADD COLUMN `id_utente` INT NULL AFTER `valore`,
ADD INDEX `id_utente2_idx` (`id_utente` ASC) VISIBLE;
;
ALTER TABLE `progettodb`.`ticket` 
ADD CONSTRAINT `id_utente2`
  FOREIGN KEY (`id_utente`)
  REFERENCES `progettodb`.`utente` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `progettodb`.`campo` 
ADD COLUMN `nome_centro` VARCHAR(45) NULL AFTER `tipologia`,
ADD INDEX `nome_centro_idx` (`nome_centro` ASC) VISIBLE;
;
ALTER TABLE `progettodb`.`campo` 
ADD CONSTRAINT `nome_centro`
  FOREIGN KEY (`nome_centro`)
  REFERENCES `progettodb`.`centrosportivo` (`nome`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `progettodb`.`prenotazione` 
DROP COLUMN `prezzo`;

ALTER TABLE `progettodb`.`campo` 
ADD COLUMN `prezzo` DOUBLE NOT NULL AFTER `tipologia`;

ALTER TABLE `progettodb`.`prenotazione` 
ADD COLUMN `pagata` TINYINT(1) NOT NULL AFTER `id_utente`;

ALTER TABLE `progettodb`.`prenotazione` 
CHANGE COLUMN `pagata` `pagata` TINYINT(1) NOT NULL AFTER `disponibile`;

ALTER TABLE `progettodb`.`utente` 
ADD COLUMN `puntipremium` INT NOT NULL AFTER `email`;

INSERT INTO `progettodb`.`utente` (`id`, `username`, `password`, `email`, `puntipremium`) VALUES ('5', 'admin', 'admin', 'admin@gmail.com', '0');

INSERT INTO `progettodb`.`centrosportivo` (`nome`, `indirizzo`) VALUES ('centro', 'via de gasperi');

INSERT INTO `progettodb`.`campo` (`sport`, `tipologia`, `prezzo`, `nome_centro`) VALUES ('calcio', 'sintetico', '50', 'centro');
INSERT INTO `progettodb`.`campo` (`sport`, `tipologia`, `prezzo`, `nome_centro`) VALUES ('calcio', 'naturale', '40', 'centro');
INSERT INTO `progettodb`.`campo` (`sport`, `tipologia`, `prezzo`, `nome_centro`) VALUES ('basket', 'asfalto', '35', 'centro');
INSERT INTO `progettodb`.`campo` (`sport`, `tipologia`, `prezzo`, `nome_centro`) VALUES ('tennis', 'terrarossa', '60', 'centro');