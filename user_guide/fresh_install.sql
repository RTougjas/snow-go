# Table for storing session data. 
CREATE TABLE IF NOT EXISTS `ci_sessions` (
`id` varchar(40) NOT NULL,
`ip_address` varchar(45) NOT NULL,
`timestamp` int(10) unsigned DEFAULT 0 NOT NULL,
`data` blob NOT NULL,
KEY `ci_sessions_timestamp` (`timestamp`)
);

CREATE TABLE menuItem (
    ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(5,2) NOT NULL,
    category INTEGER NOT NULL,
	location INTEGER NOT NULL,
	CONSTRAINT uc_item UNIQUE(name, price, location));
	
CREATE TABLE category (
	ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(25) NOT NULL,
	location INTEGER NOT NULL,
	general INTEGER NOT NULL);
	
CREATE TABLE location (
	ID INTEGER NOT NULL PRIMARY KEY,
	name VARCHAR(10) NOT NULL,
	aadress VARCHAR(100));

CREATE TABLE reservation (
	ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100), 
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    due TIMESTAMP NOT NULL,
	cancelled TINYINT(1) DEFAULT 0,
	completed TINYINT(1) DEFAULT 0,
	location INTEGER NOT NULL);

CREATE TABLE reservationItems (
	ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	reservation INTEGER NOT NULL,
	menuItem INTEGER NOT NULL,
	amount INTEGER DEFAULT 1);
	
CREATE TABLE employee (
	ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstName VARCHAR(15),
    lastName VARCHAR(25),
    title VARCHAR(25),
    phone VARCHAR(15),
    email VARCHAR(100),
	location INTEGER NOT NULL);
	
CREATE TABLE generalCategory (
	ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(15) NOT NULL);
	
CREATE TABLE feedback(
    ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
   	firstName VARCHAR(15) NOT NULL, 
    lastName VARCHAR(30),
    phone VARCHAR(15),
    email VARCHAR(50), 
    notes VARCHAR(150) NOT NULL,
	location INTEGER NOT NULL);
	
CREATE TABLE PinCode (
	code VARCHAR(12) PRIMARY KEY);
	
CREATE TABLE observation (
	ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	correctCode VARCHAR(12) NOT NULL,
	time VARCHAR(10) NOT NULL);
	
CREATE TABLE wrongCode (
	observation INTEGER NOT NULL,
	w_code VARCHAR(12) NOT NULL);
	
ALTER TABLE observation ADD CONSTRAINT fk_correct_code_in_observation
	FOREIGN KEY (correctCode) REFERENCES PinCode(code)
	ON UPDATE CASCADE ON DELETE RESTRICT;
	
ALTER TABLE observation ADD COLUMN type VARCHAR(2);
	
ALTER TABLE wrongCode ADD CONSTRAINT fk_observation_wrong_code
	FOREIGN KEY (observation) REFERENCES observation(ID)
	ON UPDATE CASCADE ON DELETE RESTRICT;
	
alter table feedback add CONSTRAINT uc_feedback UNIQUE (firstName, notes, location);

alter table category add CONSTRAINT uc_category UNIQUE(name, location);

ALTER TABLE category add constraint fk_category_has_location
	FOREIGN KEY (location) REFERENCES location(ID)
	ON UPDATE CASCADE ON DELETE RESTRICT;
		
ALTER TABLE menuItem ADD CONSTRAINT fk_menuitem_has_category
	FOREIGN KEY (category) REFERENCES category(ID) 
	ON UPDATE CASCADE ON DELETE CASCADE; 
	
	
ALTER TABLE reservationItems ADD CONSTRAINT fk_reservationItems_have_reservation
	FOREIGN KEY (reservation) REFERENCES reservation(ID)
	ON UPDATE CASCADE ON DELETE CASCADE;
	
ALTER TABLE reservationItems ADD CONSTRAINT fk_reservationItems_have_menuItems
	FOREIGN KEY (menuItem) REFERENCES menuItem(ID) 
	ON UPDATE CASCADE ON DELETE RESTRICT;
	
ALTER TABLE employee ADD CONSTRAINT fk_employee_has_location
	FOREIGN KEY (location) REFERENCES location(ID) ON UPDATE CASCADE ON DELETE RESTRICT;
			
ALTER TABLE menuItem ADD CONSTRAINT fk_menuitem_has_location
	FOREIGN KEY (location) REFERENCES location(ID) ON UPDATE CASCADE ON DELETE RESTRICT;
	
ALTER TABLE reservation ADD CONSTRAINT fk_reservation_has_location
	FOREIGN KEY (location) REFERENCES location(ID) ON UPDATE CASCADE ON DELETE RESTRICT;
		
ALTER TABLE category ADD CONSTRAINT fk_category_has_general
	FOREIGN KEY (general) REFERENCES generalCategory(ID) ON UPDATE CASCADE ON DELETE RESTRICT;
	
alter table reservation add column notes VARCHAR(150);

ALTER TABLE reservation ADD COLUMN people INTEGER NOT NULL;