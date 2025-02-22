CREATE TABLE IF NOT EXISTS mydb.customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO mydb.customers (name)
VALUES ('Nome');
