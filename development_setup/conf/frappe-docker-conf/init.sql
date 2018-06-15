UPDATE mysql.user SET host = '%' WHERE host LIKE '%.%.%.%' AND user != 'root';
UPDATE mysql.db SET host = '%' WHERE host LIKE '%.%.%.%' AND user != 'root';
FLUSH PRIVILEGES;