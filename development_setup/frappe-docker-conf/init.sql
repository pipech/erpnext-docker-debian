CREATE USER "remote"@"localhost" IDENTIFIED BY "$mysqlPass";
CREATE USER "remote"@"%" IDENTIFIED BY "$mysqlPass";

GRANT ALL ON *.* TO "remote"@"localhost";
GRANT ALL ON *.* TO "remote"@"%";