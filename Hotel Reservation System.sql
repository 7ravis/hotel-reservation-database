drop database if exists HotelReservation;

create database HotelReservation;

use HotelReservation;

create table Brand (
BrandID int unsigned not null auto_increment,
BrandName varchar(45) not null,
primary key (BrandID)
);

create table Hotel (
HotelID int unsigned not null auto_increment,
Brand_BrandID int unsigned not null,
primary key (HotelID),
foreign key (Brand_BrandID)
references Brand (BrandID)
);

create table Employee (
EmployeeID bigint(20) unsigned not null auto_increment,
FirstName varchar(45) not null,
LastName varchar(45) not null,
primary key (EmployeeID)
);

create table HotelEmployee (
HotelID int unsigned not null,
EmployeeID bigint(20) unsigned not null,
primary key (HotelID,EmployeeID)
);

create table RoomType (
RoomTypeID smallint(10) unsigned not null auto_increment,
RoomType varchar(20) not null,
primary key (RoomTypeID)
);

create table RoomRate (
RoomRateID bigint(20) unsigned not null auto_increment,
Rate smallint(10) unsigned not null,
StartDate date not null,
EndDate date,
RoomType_RoomTypeID smallint(10) unsigned not null,
primary key (RoomRateID),
foreign key (RoomType_RoomTypeID)
references RoomType (RoomTypeID)
);

create table Room (
RoomID smallint(10) unsigned not null auto_increment,
RoomNumber smallint(10) unsigned not null,
Floor smallint(10) not null,
OccupancyLimit smallint(10) unsigned not null,
RoomType_RoomTypeID smallint(10) unsigned not null,
Hotel_HotelID int unsigned not null,
primary key (RoomID),
foreign key (RoomType_RoomTypeID)
references RoomType (RoomTypeID),
foreign key (Hotel_HotelID)
references Hotel (HotelID)
);

create table Amenity (
AmenityID smallint(10) unsigned not null auto_increment,
AmenityName varchar(45),
primary key (AmenityID)
);

create table RoomAmenity (
Room_RoomID smallint(10) unsigned not null,
Amenity_AmenityID smallint(10) unsigned not null,
AmenityQuantity tinyint(5) unsigned not null,
primary key (Room_RoomID,Amenity_AmenityID)
);

create table AmenityRate (
AmenityRateID bigint(20) unsigned not null auto_increment,
Rate smallint(10) unsigned not null,
StartDate date not null,
EndDate date,
Amenity_AmenityID smallint(10) unsigned not null,
primary key (AmenityRateID),
foreign key (Amenity_AmenityID)
references Amenity (AmenityID)
);

