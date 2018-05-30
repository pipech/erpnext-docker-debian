UPDATE mysql.user SET host = '10.%.%.%' WHERE host LIKE '10.%.%.%' AND user != 'root';
UPDATE mysql.db SET host = '10.%.%.%' WHERE host LIKE '10.%.%.%' AND user != 'root';
FLUSH PRIVILEGES;