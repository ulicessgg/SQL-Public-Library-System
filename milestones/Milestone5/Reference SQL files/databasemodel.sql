DROP DATABASE IF EXISTS TestDB; 
CREATE DATABASE IF NOT EXISTS TestDB; 
USE TestDB;

DROP TABLE IF EXISTS User;
CREATE TABLE User (
   ssn INT PRIMARY KEY AUTO_INCREMENT,
   email VARCHAR(20) NOT NULL,
   name VARCHAR(30) NOT NULL,
   CONSTRAINT UQ_USER_EMAIL UNIQUE KEY (email)
);

DROP TABLE IF EXISTS Organization;

CREATE TABLE Organization (
    org_id TINYINT AUTO_INCREMENT,
    title VARCHAR(20) NOT NULL,
    CONSTRAINT PK_ORGANIZATION_ID PRIMARY KEY (org_id)
);


DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee ( 
    employee_id TINYINT PRIMARY KEY AUTO_INCREMENT,
    ssn INT NOT NULL,
    organization TINYINT NOT NULL,
    num_dependents INT DEFAULT 0, 
    CONSTRAINT FK_EMPLOYEE_USER FOREIGN KEY (ssn) REFERENCES User(ssn)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_EMPLOYEE_Organization FOREIGN KEY (organization) REFERENCES Organization(org_id)
    ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE Account (
    account_id TINYINT AUTO_INCREMENT,
    org TINYINT, 
    email VARCHAR(20) NOT NULL,
    password CHAR(60) NOT NULL,
    CONSTRAINT PK_ACCOUNT_ID PRIMARY KEY (account_id),
    CONSTRAINT FK_ACCOUNT_EMAIL FOREIGN KEY (email) REFERENCES User(email)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_EMPLOYEE_ORG FOREIGN KEY (org) REFERENCES Organization(org_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO User (email, name) VALUES ("jose@mail.com", "Jose Ortiz"), ("joe@mail.com", "Joe Doe"); 
INSERT INTO Organization (title) VALUES ("SFSU"), ("Google"), ("Meta"), ("SalesForce");
INSERT INTO Employee (ssn, organization, num_dependents) VALUES (1, 1, 3), (1, 1, 1), (2, 1, 2), (2, 4, 4), (1, 4, 0);



