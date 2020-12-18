create database if not exists TrackIt;

use TrackIt;

CREATE TABLE Task (
    TaskID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100) NOT NULL,
    Details TEXT NULL,
    DueDate DATE NOT NULL,
    EstimatedHours DECIMAL(5 , 2 ) NULL,
    ProjectId CHAR(50) NOT NULL,
    Workerid INT NOT NULL,
    FOREIGN KEY (ProjectId , WorkerId)
        REFERENCES ProjectWorker (Projectid , WorkerId)
);

CREATE TABLE Project (
    ProjectId CHAR(50) PRIMARY KEY,
    `Name` VARCHAR(100) NOT NULL,
    Summary VARCHAR(2000) NULL,
    DueDate DATE NOT NULL,
    isActive BOOL NOT NULL DEFAULT 1
);
-- ----------------------------------------
-- alter table Task 
CREATE TABLE Worker (
    WorkerId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL
);
    
-- DDL actions: -- CREATE => builds schema from scratch, 
CREATE TABLE ProjectWorker (
    ProjectId CHAR(50) NOT NULL,
    WorkerId INT NOT NULL,
    PRIMARY KEY pk_ProjectWorker (ProjectId , WorkerId),
    FOREIGN KEY (ProjectId)
        REFERENCES Project (Projectid),
    FOREIGN KEY (WorkerId)
        REFERENCES Worker (WorkerId)
);


    