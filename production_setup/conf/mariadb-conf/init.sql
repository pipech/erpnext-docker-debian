UPDATE mysql.user SET host = '10.0.0.%' WHERE host LIKE '10.0.0.%' AND user != 'root';
UPDATE mysql.db SET host = '10.0.0.%' WHERE host LIKE '10.0.0.%' AND user != 'root';
FLUSH PRIVILEGES;