drop database if exists HotelReservation;

create database HotelReservation;

use HotelReservation;

create table Brand (
BrandID smallint(10) unsigned not null auto_increment,
BrandName varchar(45) not null,
primary key (BrandID)
);

create table Hotel (
HotelID mediumint(10) unsigned not null auto_increment,
Brand_BrandID smallint(10) unsigned not null,
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
Hotel_HotelID mediumint(10) unsigned not null,
Employee_EmployeeID bigint(20) unsigned not null,
primary key (Hotel_HotelID, Employee_EmployeeID),
foreign key (Hotel_HotelID)
references Hotel (HotelID),
foreign key (Employee_EmployeeID)
references Employee (EmployeeID)
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
RoomID int(10) unsigned not null auto_increment,
RoomNumber smallint(10) unsigned not null,
Floor smallint(10) not null,
OccupancyLimit smallint(10) unsigned not null,
RoomType_RoomTypeID smallint(10) unsigned not null,
Hotel_HotelID mediumint(10) unsigned not null,
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
Room_RoomID int(10) unsigned not null,
Amenity_AmenityID smallint(10) unsigned not null,
AmenityQuantity tinyint(5) unsigned not null,
primary key (Room_RoomID, Amenity_AmenityID),
foreign key (Room_RoomID)
references Room (RoomID),
foreign key (Amenity_AmenityID)
references Amenity (AmenityID)
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

create table Guest (
GuestID bigint(20) unsigned not null auto_increment,
FirstName varchar(45) not null,
LastName varchar(45) not null,
BirthDate date,
Employee_EmployeeID bigint(20) unsigned,
primary key (GuestID),
foreign key (Employee_EmployeeID)
references Employee (EmployeeID)
);

create table EmailType (
EmailTypeID tinyint(10) unsigned not null auto_increment,
Type varchar(30) not null,
primary key (EmailTypeID)
);

create table Email (
EmailID bigint(20) unsigned not null auto_increment,
EmailAddress varchar(100) not null,
EmailType_EmailTypeID tinyint(10) unsigned,
Guest_GuestID bigint(20) unsigned,
Hotel_HotelID mediumint(10) unsigned,
Employee_EmployeeID bigint(20) unsigned,
primary key (EmailID),
foreign key (Guest_GuestID)
references Guest (GuestID),
foreign key (Hotel_HotelID)
references Hotel (HotelID),
foreign key (Employee_EmployeeID)
references Employee (EmployeeID),
foreign key (EmailType_EmailTypeID)
references EmailType (EmailTypeID)
);

create table PhoneType (
PhoneTypeID tinyint(10) unsigned not null auto_increment,
Type varchar(30) not null,
primary key (PhoneTypeID)
);

create table Phone (
PhoneID bigint(20) unsigned not null auto_increment,
PhoneType_PhoneTypeID tinyint(10) unsigned,
PhoneNumber varchar(20) not null,
Guest_GuestID bigint(20) unsigned,
Hotel_HotelID mediumint(10) unsigned,
Employee_EmployeeID bigint(20) unsigned,
primary key (PhoneID),
foreign key (Guest_GuestID)
references Guest (GuestID),
foreign key (Hotel_HotelID)
references Hotel (HotelID),
foreign key (Employee_EmployeeID)
references Employee (EmployeeID),
foreign key (PhoneType_PhoneTypeID)
references PhoneType (PhoneTypeID)
);

create table CityZip (
CityZipID mediumint(20) unsigned not null auto_increment,
City varchar(45) not null,
State char(2) not null,
Zipcode varchar(10) not null,
primary key (City, State, Zipcode),
unique key (CityZipID)
);

create table AddressType (
AddressTypeID tinyint(10) unsigned not null auto_increment,
Type varchar(30) not null,
primary key (AddressTypeID)
);

create table Address (
AddressID bigint(20) unsigned not null auto_increment,
AddressType_AddressTypeID tinyint(10) unsigned,
StreetAddress varchar(45) not null,
CityZip_CityZipID mediumint(20) unsigned not null,
Guest_GuestID bigint(20) unsigned,
Hotel_HotelID mediumint(10) unsigned,
Employee_EmployeeID bigint(20) unsigned,
primary key (AddressID),
foreign key (Guest_GuestID)
references Guest (GuestID),
foreign key (Hotel_HotelID)
references Hotel (HotelID),
foreign key (Employee_EmployeeID)
references Employee (EmployeeID),
foreign key (CityZip_CityZipID)
references CityZip (CityZipID),
foreign key (AddressType_AddressTypeID)
references AddressType (AddressTypeID)
);

create table Reservation (
ReservationID bigint(20) unsigned not null auto_increment,
Guest_GuestID bigint(20) unsigned not null,
TotalBeforeTax mediumint(10) unsigned,
Tax smallint(10) unsigned,
primary key (ReservationID),
foreign key (Guest_GuestID)
references Guest (GuestID)
);

create table RoomReservation (
RoomReservationID bigint(20) unsigned not null auto_increment,
Room_RoomID int(10) unsigned not null,
Reservation_ReservationID bigint(20) unsigned not null,
StartDate date not null,
EndDate date,
primary key (RoomReservationID), -- this bridge table uses a single primary key for simplicity since it is used as a foreign key in various tables
foreign key (Room_RoomID)
references Room (RoomID),
foreign key (Reservation_ReservationID)
references Reservation (ReservationID)
);

create table RoomReservationGuest (
Guest_GuestID bigint(20) unsigned not null,
RoomReservation_RoomReservationID bigint(20) unsigned not null,
primary key (Guest_GuestID, RoomReservation_RoomReservationID),
foreign key (Guest_GuestID)
references Guest (GuestID),
foreign key (RoomReservation_RoomReservationID)
references RoomReservation (RoomReservationID)
);

create table AddOn (
AddOnID smallint(20) unsigned not null auto_increment,
AddOnType varchar(30) not null,
primary key (AddOnID)
);

create table AddOnRate (
AddOnRateID bigint(20) unsigned not null auto_increment,
Rate smallint(10) unsigned not null,
StartDate date not null,
EndDate date,
AddOn_AddOnID smallint(20) unsigned not null,
primary key (AddOnRateID),
foreign key (AddOn_AddOnID)
references AddOn (AddOnID)
);

create table RoomReservationAddOn (
RoomReservationAddOnID bigint(20) unsigned not null auto_increment,  -- this bridge table does not have a composite key because it allows multiple add-ons of the same type for the same room
RoomReservation_RoomReservationID bigint(20) unsigned not null,
AddOn_AddOnID smallint(20) unsigned not null,
primary key (RoomReservationAddOnID),
foreign key (RoomReservation_RoomReservationID)
references RoomReservation (RoomReservationID),
foreign key (AddOn_AddOnID)
references AddOn (AddOnID)
);

create table Promo (
PromoID bigint(20) unsigned not null auto_increment,
PromoCode varchar(20) not null,
Description varchar(45) not null,
DollarDiscount smallint(10) unsigned,
PercentDiscount tinyint(10) unsigned,
StartDate date not null,
EndDate date,
RoomType_RoomTypeID smallint(10) unsigned,
Amenity_AmenityID smallint(10) unsigned,
AddOn_AddOnID smallint(20) unsigned,
primary key (PromoID),
foreign key (RoomType_RoomTypeID)
references RoomType (RoomTypeID),
foreign key (Amenity_AmenityID)
references Amenity (AmenityID),
foreign key (AddOn_AddOnID)
references AddOn (AddOnID)
);

create table ReservationDetail (
ReservationDetailID bigint(20) unsigned not null auto_increment,
Reservation_ReservationID bigint(20) unsigned not null,
RoomReservation_RoomReservationID bigint(20) unsigned not null,
RoomReservationAddOn_RoomReservationAddOnID bigint(20) unsigned,
Description varchar(45),
Rate mediumint(15) unsigned not null,
primary key (ReservationDetailID),
foreign key (Reservation_ReservationID)
references Reservation (ReservationID),
foreign key (RoomReservation_RoomReservationID)
references RoomReservation (RoomReservationID),
foreign key (RoomReservationAddOn_RoomReservationAddOnID)
references RoomReservationAddOn (RoomReservationAddOnID)
);

create table ReservationPromo (
Promo_PromoID bigint(20) unsigned not null,
Reservation_ReservationID bigint(20) unsigned not null,
primary key (Promo_PromoID, Reservation_ReservationID),
foreign key (Promo_PromoID)
references Promo (PromoID),
foreign key (Reservation_ReservationID)
references Reservation (ReservationID)
);

create table Override (
OverrideID bigint(20) unsigned not null auto_increment,
Reservation_ReservationID bigint(20) unsigned not null,
Amount mediumint(15) not null,
Reason varchar(100) not null,
Employee_EmployeeID bigint(20) unsigned not null,
primary key (OverrideID),
foreign key (Reservation_ReservationID)
references Reservation (ReservationID),
foreign key (Employee_EmployeeID)
references Employee (EmployeeID)
);

-- TRIGGERS THAT REQUIRE A BILL DETAIL TO RELATE TO EITHER A ROOM OR AN ADD ON
DELIMITER //

create trigger ReservationDetailInsertTrigger1
before insert on ReservationDetail 
for each row
begin
IF (new.RoomReservation_RoomReservationID is null AND new.RoomReservationAddOn_RoomReservationAddOnID is null) THEN 
	signal sqlstate '45000' 
	set message_text = 'RoomReservationID and RoomReservationAddOnID cannot both be null';
end if;
end//

create trigger ReservationDetailUpdateTrigger1
before update on ReservationDetail 
for each row
begin
IF (new.RoomReservation_RoomReservationID is null AND new.RoomReservationAddOn_RoomReservationAddOnID is null) THEN 
	signal sqlstate '45000' 
	set message_text = 'RoomReservationID and RoomReservationAddOnID cannot both be null';
end if;
end//

create trigger ReservationDetailInsertTrigger2
before insert on ReservationDetail 
for each row
begin
IF (new.RoomReservation_RoomReservationID is not null AND new.RoomReservationAddOn_RoomReservationAddOnID is not null) THEN 
	signal sqlstate '45000' 
	set message_text = 'RoomReservationID and RoomReservationAddOnID cannot both contain data';
end if;
end//

create trigger ReservationDetailUpdateTrigger2
before update on ReservationDetail 
for each row
begin
IF (new.RoomReservation_RoomReservationID is not null AND new.RoomReservationAddOn_RoomReservationAddOnID is not null) THEN 
	signal sqlstate '45000' 
	set message_text = 'RoomReservationID and RoomReservationAddOnID cannot both contain data';
end if;
end//

DELIMITER ;
