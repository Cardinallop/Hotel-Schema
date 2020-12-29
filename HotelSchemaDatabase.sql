create database if not exists HotelSchemaDatabase;

use HotelSchemaDatabase;

CREATE TABLE State (
    StateID INT PRIMARY KEY AUTO_INCREMENT,
    State CHAR(20) NOT NULL,
    City CHAR(20) NOT NULL,
    Zip CHAR(10) NOT NULL
);

CREATE TABLE Amenities (
    AmenitiesID INT PRIMARY KEY AUTO_INCREMENT,
    Amenity CHAR(20) NOT NULL,
    Charge DOUBLE NULL,
    RoomTypeID INT,
    FOREIGN KEY (RoomTypeID)
        REFERENCES RoomType (RoomTypeID)
);

CREATE TABLE Guest (
    GuestID INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(25) NOT NULL,
    Address VARCHAR(45) NOT NULL,
    Phone CHAR(10) NOT NULL,
    StateID INT,
    FOREIGN KEY (StateID)
        REFERENCES State (StateID)
);
    --  somehow here I have to add the price of amenity to total price
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    Adults INT NOT NULL,
    Children INT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    TotalRoomCost DOUBLE NOT NULL,
    RoomNumberID INT,
    GuestID INT,
    FOREIGN KEY (RoomNumberID)
        REFERENCES Room (RoomNumberID),
    FOREIGN KEY (GuestID)
        REFERENCES Guest (GuestID)
);

CREATE TABLE Room (
    RoomNumberID INT PRIMARY KEY AUTO_INCREMENT,
    RoomTypeID INT,
    ADAAccessible BOOL NOT NULL DEFAULT 1,
    FOREIGN KEY (RoomTypeID)
        REFERENCES RoomType (RoomTypeID)
);

CREATE TABLE RoomType (
    RoomTypeID INT PRIMARY KEY AUTO_INCREMENT,
    RoomType CHAR(10) NOT NULL,
    BasePrice DOUBLE NOT NULL,
    ExtraPerson INT NULL,
    StandardOccupancy INT NOT NULL,
    MaximumOccupancy INT NOT NULL
);

insert into RoomType (RoomTypeID, RoomType, BasePrice, StandardOccupancy, MaximumOccupancy)
	values (1, 'Single', 149.99, 2, 2), 
			(2,'Double', 174.99, 2, 4),
            (3,'Suite', 399.99, 3, 8);
    
		 -- select * from RoomType; 
         -- to check if the above scripts gives the desired result
         
insert into Room (RoomNumberID, RoomTypeID, ADAAccessible)
	values (201, 2, 0),
			(202, 2, 1),
            (203, 2, 0),
            (204, 2, 1),
            (205, 1, 0),
            (206, 1, 1),
            (207, 1, 0),
            (208, 1, 1),
            (301, 2, 0),
            (302, 2, 1),
            (303, 2, 0),
            (304, 2, 0),
            (305, 1, 0),
            (306, 1, 1),
            (307, 1, 0),
            (308, 1, 1),
            (401, 3, 1),
            (402, 3, 1);
            
-- select * from Room; to check how rows affected...


insert into State (StateID, State, City, Zip)
	values (1, 'IA', 'Council Bluffs', '51501'),
			(2, 'AK', 'Wasile', '99654'),
            (3, 'TX', 'Harlingen', '78552'),
            (4, 'NJ', 'West Deptford', '08096'),
            (5, 'MI', 'Saginaw', '48601'),
            (6, 'CO', 'Arvada', '80003'),
            (7, 'IL', 'Zion', '60099'),
            (8, 'RI', 'Cumberland', '02864'),
            (9, 'NY', 'Oswego', '13126'),
            (10, 'VA', 'Burke', '22015'),
            (11, 'PA', 'Drexel Hill', '19026');

-- select * from State; to check data consistency

CREATE TABLE Amenities (
    AmenitiesID INT PRIMARY KEY AUTO_INCREMENT,
    Amenity CHAR(20) NOT NULL,
    Charge DOUBLE NULL,
    RoomTypeID INT,
    FOREIGN KEY (RoomTypeID)
        REFERENCES RoomType (RoomTypeID)
);

-- there should a bridge table to hold the amount of amenities for each room type

insert into Amenities (AmenitiesID, Amenity, Charge, RoomTypeID)
	values (1, 'Microwave', null, 1),
			(2, 'Refrigerator', null, 2),
            (3, 'Jacuzzi', 25, 2),
            (4, 'Refrigerator', null, 1);
            

insert into Guest (GuestID, `Name`, Address, Phone, StateID)
	values (1, 'Mack Simmer', '379 Old Shore Street', '2915530508', 1),
			(2, 'Bettyann Seery', '750 Wintergreen Dr.', '4782779632', 2),
            (3, 'Duane Cullison', '9662 Foxrun Lane', '3084940198', 3),
            (4, 'Karie Yang', '9378 W. Augusta Ave', '2147300298', 4),
			(5,'Aurore Lipton','762 Wild Rose Street','3775070974',5),
            (6,'Zachery Luechtefeld', '7 Poplar Dr','8144852615', 6),
            (7,'Jeremiah Pendergrass','70 Oakwood St', '2794910960', 7),
            (8,'Walter Holaway', '7556 Arrowhead St', '4463966785', 8),
            (9,'Wilfred Vise', '77 West Surrey Street', '8347271001', 9),
            (10,'Maritza Tilton', '939 Linda Rd', '4463516860', 10),
            (11,'Joleen Tison', '87 Queen St', '2318932755', 11);
            
-- select * from Guest; again to check data 

CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    Adults INT NOT NULL,
    Children INT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    TotalRoomCost DOUBLE NOT NULL,
    RoomNumberID INT,
    GuestID INT,
    FOREIGN KEY (RoomNumberID)
        REFERENCES Room (RoomNumberID),
    FOREIGN KEY (GuestID)
        REFERENCES Guest (GuestID)
);

-- there should be another bridge table for calculating total room cost

insert into Reservation (ReservationID, Adults, Children, StartDate, EndDate, TotalRoomCost, RoomNumberID, GuestID)
	values (1, 1, 0, '2023-2-2', '2023-2-4', 299.98, 308, 1),
			(2, 2, 1, '2023-2-5', '2023-2-10', 999.95, 203, 2),
            (3, 2, 0, '2023-2-22', '2023-2-24', 349.95, 305, 3),
            (4, 2, 2, '2023-3-6', '2023-3-7', 199.99, 201, 4),
            (5, 1,1, '2023-3-17', '2023-3-20', 524.97, 307, 4),
            (6, 3,0, '2023-3-18', '2023-3-23', 924.95, 302, 5),
            (7, 2,2, '2023-3-29', '2023-3-31', 349.98, 202, 6),
            (8, 2, 0, '2023-3-31', '2023-4-5', 874.95, 304, 7),
            (9, 1, 0, '2023-4-9','2023-4-13',799.96, 301,8),
			(10, 1,1, '2023-4-23','2023-4-24',174.99, 207,9),
            (11, 2,4, '2023-5-30','2023-6-2',1199.97, 401,10),
            (12, 2,0, '2023-6-10','2023-6-14',599.96, 206,11),
            (13, 1, 0, '2023-6-10','2023-6-14',599.96, 208,11),
            (14, 3, 0, '2023-6-17','2023-6-18',184.99, 304,5),
            (15, 2, 0, '2023-6-28','2023-7-2',699.96, 205,4),
            (16, 3, 1, '2023-7-13','2023-7-14',184.99, 204,8),
            (17, 4, 2, '2023-7-18','2023-7-21',1259.97, 401,9),
            (18, 2, 1, '2023-7-28','2023-7-29',199.99, 303,2),
            (19, 1, 0, '2023-8-30','2023-9-1',349.98, 305,2),
            (20, 2, 0, '2023-9-16','2023-9-17',149.99, 208,1),
            (21, 2, 2, '2023-9-13','2023-9-15',399.98, 203,4),
            (22, 2, 2, '2023-11-22','2023-11-25',1199.97, 401,3),
            (23, 2, 0, '2023-11-22','2023-11-25',449.97, 206,1),
            (24, 2, 2, '2023-11-22','2023-11-25',599.97, 301,1),
            (25, 2, 0, '2023-12-24','2023-12-28',699.96, 302,10);

-- the purpose of the primary key is to identify a single row

-- UPDATES 

update Guest SET
	`Name` = 'Bobur Murtozaev'
where GuestID = 3;  -- updates the row in the chosen table with a safe update mode on

select * from Guest;

-- --------------------------------

set sql_safe_updates = 0;

update Room set
	ADAAccessible = 0
where RoomTypeID = 1;

set sql_safe_updates = 1;

-- ----------------------------------

-- DELETE 

-- deletes are all or nothing

-- there is no undo in SQL

delete from Guest 
where GuestID = 5; -- doesn't work because GuestID is in use as a foriegn key

select * from Reservation;

delete from Reservation 
where GuestID = 5;

delete from Guest 
where GuestID = 5;

select * from Guest;

set sql_safe_updates = 1;

-- always check with SELECT query to verify that WHERE clause works as intended

-- ALTER TABLE command can be used to add columns into tables and add foreign keys to tables
--  CREATE TABLE can be used to create bridge table to explain more complex relationships

alter table Guest 
	add column (
		PersonalID char(20) null
        );
        
select * from Guest;

alter table Room 
	add column (
		GuestID int null
        ), 
	add constraint fk_Room_Guest
		foreign key (GuestID)
        references Guest(GuestID);

select * from Room;

select 
	Room.RoomNumberID,
    RoomType.RoomType,
    Amenities.Amenity
from Room 
inner join RoomType on Room.RoomTypeID = RoomType.RoomTypeID
inner join Amenities on RoomType.RoomTypeId = Amenities.RoomTypeId;

-- I need to find out how to print the number of amenities in one line, i think
-- I need a many-to-many bridge table between Amenities and Room or RoomType to work this out
-- also need to calculate total cost of the room with join scripts using IFNULL() function
-- Now I can generate the same exact tables thats given on the exercise

select 
	r.ReservationID,
    g.Name,
    r.RoomNumberID,
    r.StartDate,
    r.EndDate
from Reservation r
inner join Guest g on r.GuestID = g.GuestID
where r.EndDate between '2023-07-01' and '2023-07-31';

select
	g.Name,
    r.RoomNumberID,
    r.StartDate,
    r.EndDate,
    a.Amenity
from Guest g
inner join Reservation r on g.GuestID = r.GuestID
inner join Room rm on r.RoomNumberID = rm.RoomNumberID
inner join RoomType rt on rm.RoomTypeID = rt.RoomTypeID
inner join Amenities a on rt.RoomTypeID = a.RoomTypeID
where a.Amenity = 'Jacuzzi';


select
	g.Name, 
    r.ReservationID,
    r.RoomNumberID,
    r.StartDate,
    r.Adults
from Guest g
inner join Reservation r on g.GuestID = r.GuestID and g.Name = 'Mack Simmer';


select 
	Room.RoomNumberID,
    Reservation.ReservationID,
    Reservation.TotalRoomCost
from Room 
left outer join Reservation on Room.RoomNumberID = Reservation.RoomNumberID;


