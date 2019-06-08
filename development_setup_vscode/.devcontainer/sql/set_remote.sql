CREATE USER 'remote'@'localhost' IDENTIFIED BY '12345';
CREATE USER 'remote'@'%' IDENTIFIED BY '12345';
GRANT ALL ON *.* TO 'remote'@'localhost';
GRANT ALL ON *.* TO 'remote'@'%'; 