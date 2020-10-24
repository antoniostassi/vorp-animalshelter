
CREATE TABLE  `dogs` (
  `identifier` varchar(40) NOT NULL,
  `dog` varchar(255) NOT NULL,
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


