/* 
CREATE DATABASE metastore;
CREATE USER 'hive'@'localhost' IDENTIFIED BY 'hive';
CREATE USER 'hive'@'%' IDENTIFIED BY 'hive';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'hive'@'localhost';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'hive'@'%';
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'localhost';
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'%';
FLUSH PRIVILEGES;
*/
CREATE DATABASE metastore;

-- Create the user (role) with password
CREATE ROLE hive WITH LOGIN PASSWORD 'hive';

-- Grant all privileges on the database to the user
ALTER DATABASE metastore OWNER TO hive;
GRANT ALL PRIVILEGES ON DATABASE metastore TO hive;

-- Switch to the metastore database
\c metastore
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO hive;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO hive;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO hive;