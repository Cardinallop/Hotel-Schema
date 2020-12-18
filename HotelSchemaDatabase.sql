create database if not exists HotelSchemaDatabase;

use HotelSchemaDatabase;

create table State (
	StateID int primary key auto_increment,
    State char(20) not null,
    City char(20) not null,
    Zip char(10) not null
);

create table Amenities (
	AmenitiesID int primary key auto_increment,
    Amenity char(20) not null,
    Charge double null,
    RoomTypeID int,
    foreign key fk_Amenities_RoomType (RoomTypeID)
		references RoomType(RoomTypeID)
);

create table Guest (
	GuestID int primary key auto_increment,
    `Name` varchar(25) not null,
    Address varchar(45) not null,
    Phone char(10) not null,
    StateID int,
    foreign key fk_Guest_State (StateID)
		references State (StateID)
	);
    --  somehow here I have to add the price of amenity to total price
create table Reservation (
	ReservationID int primary key auto_increment,
    Adults int not null,
    Children int null,
    StartDate date not null,
    EndDate date not null,
    TotalRoomCost double not null,
    RoomNumberID int, 
    GuestID int,
    foreign key fk_Reservation_Room (RoomNumberID)
		references Room (RoomNumberID),
	foreign key fk_Reservation_Guest (GuestID)
		references Guest (GuestID)
);

create table Room (
	RoomNumberID int primary key auto_increment,
    RoomTypeID int,
    ADAAccessible bool not null default 1,
    foreign key fk_Room_RoomType (RoomTypeID)
		references RoomType (RoomTypeID)
);

create table RoomType (
	RoomTypeID int primary key auto_increment,
    RoomType char(10) not null,
    BasePrice double not null,
    ExtraPerson int null,
    StandardOccupancy int not null,
    MaximumOccupancy int not null
);



    