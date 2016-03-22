DROP TABLE IF EXISTS `groups`;

#
# Table structure for table 'groups'
#

CREATE TABLE `groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
#	Correct one.
#
CREATE TABLE groups (
  id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(20) NOT NULL,
  description varchar(100) NOT NULL);

#
# Dumping data for table 'groups'
#


## ATTENTION

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
     (1,'admin','Administrator'),
     (2,'members','General User');



DROP TABLE IF EXISTS `users`;

#
# Table structure for table 'users'
#

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `username` varchar(100) NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Correct one.
#

CREATE TABLE users (
  id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ip_address varchar(15) NOT NULL,
  username varchar(100) NULL,
  password varchar(255) NOT NULL,
  salt varchar(255) DEFAULT NULL,
  email varchar(100) NOT NULL,
  activation_code varchar(40) DEFAULT NULL,
  forgotten_password_code varchar(40) DEFAULT NULL,
  forgotten_password_time int(11) unsigned DEFAULT NULL,
  remember_code varchar(40) DEFAULT NULL,
  created_on int(11) unsigned NOT NULL,
  last_login int(11) unsigned DEFAULT NULL,
  active tinyint(1) unsigned DEFAULT NULL,
  first_name varchar(50) DEFAULT NULL,
  last_name varchar(50) DEFAULT NULL,
  company varchar(100) DEFAULT NULL,
  phone varchar(20) DEFAULT NULL) 


#
# Dumping data for table 'users'
#

INSERT INTO `users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`) VALUES
     ('1','127.0.0.1','administrator','$2a$07$SeBknntpZror9uyftVopmu61qg0ms8Qv1yV6FG.kQOSM.9QhmTo36','','admin@admin.com','',NULL,'1268889823','1268889823','1', 'Admin','istrator','ADMIN','0');
	 
#
#	Correct one.
#

INSERT INTO users (id, ip_address, username, password, salt, email, activation_code, forgotten_password_code, created_on, last_login, active, first_name, last_name, company, phone) VALUES
	 (1,'127.0.0.1','administrator','$2a$07$SeBknntpZror9uyftVopmu61qg0ms8Qv1yV6FG.kQOSM.9QhmTo36','','admin@admin.com','',NULL,'1268889823','1268889823','1', 'Admin','istrator','ADMIN','0');

DROP TABLE IF EXISTS `users_groups`;

#
# Table structure for table 'users_groups'
#

CREATE TABLE `users_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `group_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_users_groups_users1_idx` (`user_id`),
  KEY `fk_users_groups_groups1_idx` (`group_id`),
  CONSTRAINT `uc_users_groups` UNIQUE (`user_id`, `group_id`),
  CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
#	Correct one
#

CREATE TABLE users_groups (
  id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  group_id INTEGER NOT NULL);

alter table users_groups ADD CONSTRAINT fk_users_groups_users1_idx
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE NO ACTION;
  
alter table users_groups ADD CONSTRAINT fk_users_groups_groups1_idx
  FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE CASCADE ON UPDATE NO ACTION;

alter table users_groups ADD CONSTRAINT uc_users_groups UNIQUE(user_id, group_id);

INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES
     (1,1,1),
     (2,1,2);


DROP TABLE IF EXISTS `login_attempts`;

#
# Table structure for table 'login_attempts'
#

CREATE TABLE `login_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Table for storing session data. 
CREATE TABLE IF NOT EXISTS `ci_sessions` (
`id` varchar(40) NOT NULL,
`ip_address` varchar(45) NOT NULL,
`timestamp` int(10) unsigned DEFAULT 0 NOT NULL,
`data` blob NOT NULL,
KEY `ci_sessions_timestamp` (`timestamp`)
);

CREATE TABLE groups_locations (
	ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    group_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
	CONSTRAINT uc_groups_locations UNIQUE(group_id, location_id));

CREATE TABLE location (
	ID INTEGER NOT NULL PRIMARY KEY,
	name VARCHAR(10) NOT NULL,
	aadress VARCHAR(100));
	
CREATE VIEW v_users AS
	select users.id AS user_id, users.first_name, users.last_name, users.email, users.phone, groups.id AS group_id, groups.name, groups.description from 
	users 
	INNER JOIN users_groups
	ON users.id = users_groups.user_id
	INNER JOIN groups
	ON users_groups.group_id = groups.id;


CREATE VIEW v_users_locations AS
	SELECT users.id AS user_id , users.first_name, users.last_name, location.ID AS location_id , location.name AS location_name , location.aadress AS location_adderss FROM
	users INNER JOIN users_groups
	ON users.id = users_groups.user_id
	INNER JOIN groups_locations
	ON users_groups.group_id = groups_locations.group_id
	INNER JOIN location
	ON groups_locations.location_id = location.ID;
	
