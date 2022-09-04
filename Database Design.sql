set echo on;
set pagesize 60;
set linesize 100;
set autocommit on;
alter session set recyclebin=off;

drop table damage;
drop table room_item;
drop table room_check;
drop table housekeeper;
drop table manager;
drop table employee;
drop table Furnishings_room;
drop table TV_set;
drop table Maker;
drop table Vendor;
drop table Room;
drop table Supplies;
drop table Television;
drop table inventory;


CREATE TABLE Inventory(
	Inv_no number(5) PRIMARY KEY,
	Description varchar2(100),
	qoh number(5)
);

CREATE TABLE Television(
	Inv_no number(5) PRIMARY KEY REFERENCES Inventory,
	Tv_size varchar2(4) NOT NULL
);

CREATE TABLE Supplies(
	Inv_no number(5) PRIMARY KEY,
	ROP number(5) NOT NULL,
	ROQ number(5) NOT NULL,
	CONSTRAINT supply_fk FOREIGN KEY(Inv_no) REFERENCES Inventory
);

CREATE TABLE Room (
    ROOM_NO number(3) constraint room_no_pk primary key
);

CREATE TABLE Vendor (
    VENDOR_NAME varchar2 (20) constraint vendor_name_pk primary key);

CREATE TABLE Maker(
    MAKE varchar2 (20) constraint make_pk primary key);

CREATE TABLE TV_set (
    INV_NO number (5) constraint inv_no_fk references Inventory,
    ROOM_NO  number(3) constraint room_no_fk references ROOM,
    VENDOR_NAME varchar2 (20) constraint vendor_name_fk references VENDOR,
    MAKE varchar2 (20) constraint make_fk references MAKER,
    MAN_SER_NO varchar2 (20) constraint man_ser_pk primary key,
    SERV_CON varchar2 (5) constraint Serv_con_nn not null,
    PURCH_DATE date constraint purch_nn not null
);

CREATE TABLE Furnishings_Room(
	Fur_no number(5) PRIMARY KEY,
	Inv_no number(5) NOT NULL REFERENCES Inventory,
	Room_no number(5) REFERENCES Room
);

CREATE TABLE EMPLOYEE(
    employ_id number(3) constraint emp_pk primary key,
    First_name varchar2(10) constraint emp_fn not null,
    Last_name varchar2(10));

CREATE TABLE MANAGER(
    employee_id number(3) constraint man_pk references employee primary key);

CREATE TABLE HOUSEKEEPER(
    employee_id number(3) constraint housekeeper_pk references employee primary key);

CREATE TABLE ROOM_CHECK(
    rc_id number(5) constraint rc_id_pk primary key,
    housekeeper_id number(3) constraint rc_hk_id references housekeeper not null,
    manager_id number(3) constraint rc_man_id references manager not null,
    time_start date constraint rc_time_start not null,
    time_end date constraint rc_time_end not null,
    check_time date constraint rc_check_time not null,
    CONSTRAINT check_time check (time_end > time_start)
    );

CREATE TABLE ROOM_ITEM(
    rc_id number(5) constraint ri_rc_id references room_check not null,
    room_no number(3) constraint ri_room_no references room not null,
    inv_no_ft number(5) constraint ri_inv_no_ft references inventory not null,
    inv_no_tt number(5) constraint ri_inv_no_tt references inventory not null,
    inv_no_so number(5) constraint ri_inv_no_so references inventory not null,
    inv_no_sh number(5) constraint ri_inv_no_sh references inventory not null,
    clean_desc varchar2(30),
    ft_quan number(3),
    tt_quan number (3),
    soap_quan number(3),
    shampoo_quan number(3),
    linen_desc varchar2(1) constraint ri_linen_desc not null,
    towel_desc varchar2(1) constraint ri_towel_desc not null,
    finish_time date constraint ri_finish_time not null,
    primary key(rc_id, room_no));

CREATE TABLE DAMAGE(
    rc_id number(5) constraint damage_rc_id references room_check not null,
    room_no  number(3) constraint damage_room_no references room not null,
    d_description varchar2(50) constraint damage_desc not null,
    Primary key(rc_id, room_no)
);

CREATE INDEX last_name_index ON Employee (Last_name);
CREATE INDEX Inv_no_index ON Furnishings_room (Inv_no);
CREATE INDEX Room_no_index ON Furnishings_room (Room_no);
CREATE INDEX Tv_room_no_index ON TV_set (Room_no);

ALTER SESSION SET NLS_DATE_FORMAT='MM-DD-YY HH24:MI:SS';

INSERT INTO Inventory VALUES(011, 'Facial Tissue', 25);
INSERT INTO Inventory VALUES(012, 'Toilet Tissue', 88);
INSERT INTO Inventory VALUES(013, 'Hand Soap', 121);
INSERT INTO Inventory VALUES(014, 'Shampoo', 175);
INSERT INTO Inventory VALUES(015, 'Twin Bed', 08);
INSERT INTO Inventory VALUES(016, 'Queen Size Bed', 12);
INSERT INTO Inventory VALUES(017, 'King Size Bed', 02);
INSERT INTO Inventory VALUES(018, 'Radio', 15);
INSERT INTO Inventory VALUES(073, 'Television', 16);
INSERT INTO Inventory VALUES(172, 'Television', 16);
INSERT INTO Inventory VALUES(234, 'Television', 16);

INSERT INTO Television VALUES (073, '36''');
INSERT INTO Television VALUES (172, '50''');
INSERT INTO Television VALUES (234, '40''');

INSERT INTO Supplies VALUES(011, 20, 200);
INSERT INTO Supplies VALUES(012, 50, 300);
INSERT INTO Supplies VALUES(013, 50, 300);
INSERT INTO Supplies VALUES(014, 50, 300);

INSERT INTO Room VALUES(01);
INSERT INTO Room VALUES(02);
INSERT INTO Room VALUES(03);
INSERT INTO Room VALUES(04);
INSERT INTO Room VALUES(05);
INSERT INTO Room VALUES(06);
INSERT INTO Room VALUES(07);
INSERT INTO Room VALUES(08);
INSERT INTO Room VALUES(09);
INSERT INTO Room VALUES(10);
INSERT INTO Room VALUES(11);
INSERT INTO Room VALUES(12);
INSERT INTO Room VALUES(13);
INSERT INTO Room VALUES(14);
INSERT INTO Room VALUES(15);

INSERT INTO Vendor VALUES ('Ron''s TV');
INSERT INTO Vendor VALUES ('Best Buy');
INSERT INTO Vendor VALUES ('Circuit City');

INSERT INTO Maker VALUES('GE');
INSERT INTO Maker VALUES('Zenith');
INSERT INTO Maker VALUES('Sony');
INSERT INTO Maker VALUES('Mag');

ALTER SESSION SET NLS_DATE_FORMAT = 'MM/DD/YY';

INSERT INTO TV_set VALUES(073,'', 'Ron''s TV', 'GE', '1d170972333', 'yes', '02/01/19');
INSERT INTO TV_set VALUES(172, 08, 'Ron''s TV', 'Zenith', '77zx33456736', 'yes', '05/06/20');
INSERT INTO TV_set VALUES(234, 15, 'Best Buy', 'GE', '3d674210903' , 'no', '06/07/21');
INSERT INTO TV_set VALUES(172, 11, 'Circuit City', 'Sony',  's939931298st', 'no','09/06/20');
INSERT INTO TV_set VALUES(234, 14, 'Best Buy' , 'Mag', 'mag332dsd98', 'no', '01/07/21');
INSERT INTO TV_set VALUES(172, 01, 'Ron''s TV', 'Mag', 'mag31425932', 'yes', '04/24/20');
INSERT INTO TV_set VALUES(172, 02, 'Best Buy', 'Sony', '3dg3953526', 'no', '09/14/19');
INSERT INTO TV_set VALUES(234, 03, 'Circuit City', 'GE', '24fgh62352', 'yes', '06/25/20');
INSERT INTO TV_set VALUES(234, 04, 'Ron''s TV', 'Zenith', '25243fr5w56', 'no', '03/13/19');
INSERT INTO TV_set VALUES(234, 05, 'Ron''s TV', 'Sony', '7235dry5462', 'no', '05/26/19');
INSERT INTO TV_set VALUES(172, 06, 'Best Buy', 'GE', '235ey4y2dr4', 'yes', '07/19/21');
INSERT INTO TV_set VALUES(073, 07, 'Ron''s TV', 'GE', '1d163468253', 'yes', '01/13/19');
INSERT INTO TV_set VALUES(234, 09, 'Circuit City', 'Sony', '2642fdf6352', 'no', '11/09/20');
INSERT INTO TV_set VALUES(073, 10, 'Ron''s TV', 'Sony', 'sny25395253', 'yes', '12/11/19');
INSERT INTO TV_set VALUES(073, 12, 'Best Buy', 'GE', 'ge22355352', 'yes', '02/03/19');
INSERT INTO TV_set VALUES(172, 13, 'Circuit City', 'Zenith', 'z536d62624', 'no', '01/23/19');


INSERT INTO Furnishings_Room VALUES(001, 016, 09);
INSERT INTO Furnishings_Room VALUES(002, 016, 09);
INSERT INTO Furnishings_Room VALUES(003, 017, 12);
INSERT INTO Furnishings_Room VALUES(004, 015, '');
INSERT INTO Furnishings_Room VALUES(005, 015, '');
INSERT INTO Furnishings_Room VALUES(006, 015, 11);
/* insert for HR */
insert into employee values(1,'Annie','Hathaway');
insert into housekeeper values(1);
insert into employee values(2,'Jack','Miller');
insert into housekeeper values(2);
insert into employee values(3,'Dora','Byrd');
insert into housekeeper values(3);
insert into employee values(4,'Cody','Welch');
insert into housekeeper values(4);
insert into employee values(5,'Nicky','Romero');
insert into housekeeper values(5);
insert into employee values(6,'Maggie','Smith');
insert into manager values(6);
insert into employee values(7,'Jay','Chou');
insert into manager values(7);

/* insert for room_check */
ALTER SESSION SET NLS_DATE_FORMAT='MM-DD-YY HH24:MI:SS';
insert into room_check values(1,1,6,'02-28-21 09:00:00','02-28-21 14:10:00','02-28-21 14:15:00');
insert into room_check values(2,2,7,'12-11-21 10:00:00','12-11-21 15:05:00','12-11-21 16:20:00');
insert into room_check values(3,4,7,'12-08-21 08:45:00','12-08-21 14:00:00','12-08-21 15:10:00');

/* insert for room_item */
insert into room_item values(1,11,011,012,013,014,'Y','',2,1,'','Y','Y','02-28-21 09:14:00');
insert into room_item values(1,07,011,012,013,014,'Y',1,1,1,1,'Y','Y','02-28-21 09:43:00');
insert into room_item values(1,13,011,012,013,014,'Y','',1,1,1,'Y','Y','02-28-21 10:04:00');
insert into room_item values(1,12,011,012,013,014,'Y',1,'',1,1,'Y','Y','02-28-21 10:32:00');
insert into room_item values(1,02,011,012,013,014,'Y',1,1,'',2,'Y','Y','02-28-21 10:55:00');
insert into room_item values(1,03,011,012,013,014,'Y','',1,1,1,'Y','Y','02-28-21 11:20:00');
insert into room_item values(1,04,011,012,013,014,'Y','',1,1,01,'Y','Y','02-28-21 11:35:00');
insert into room_item values(1,05,011,012,013,014,'Y',1,2,1,1,'Y','Y','02-28-21 11:56:00');
insert into room_item values(1,06,011,012,013,014,'Y','',2,1,'','Y','Y','02-28-21 12:20:00');
insert into room_item values(1,08,011,012,013,014,'Y',1,1,1,1,'Y','Y','02-28-21 12:37:00');
insert into room_item values(1,09,011,012,013,014,'Y','',2,1,'','Y','Y','02-28-21 12:58:00');
insert into room_item values(1,14,011,012,013,014,'Y',2,1,1,'','Y','Y','02-28-21 13:14:00');
insert into room_item values(1,10,011,012,013,014,'Y','',2,1,2,'Y','Y','02-28-21 13:36:00');
insert into room_item values(1,15,011,012,013,014,'Y','',1,1,1,'Y','Y','02-28-21 14:10:00');

insert into room_item values(2,11,011,012,013,014,'Y','',2,1,'','Y','Y','02-28-21 10:14:00');
insert into room_item values(2,07,011,012,013,014,'Y',1,1,1,1,'Y','Y','02-28-21 10:43:00');
insert into room_item values(2,13,011,012,013,014,'Y','',1,1,1,'Y','Y','02-28-21 11:04:00');
insert into room_item values(2,12,011,012,013,014,'Y',1,'',1,1,'Y','Y','02-28-21 11:32:00');
insert into room_item values(2,02,011,012,013,014,'Y',1,1,'',2,'Y','Y','02-28-21 11:55:00');
insert into room_item values(2,03,011,012,013,014,'Y','',1,1,1,'Y','Y','02-28-21 12:20:00');
insert into room_item values(2,04,011,012,013,014,'Y','',1,1,01,'Y','Y','02-28-21 12:35:00');
insert into room_item values(2,05,011,012,013,014,'Y',1,2,1,1,'Y','Y','02-28-21 12:56:00');
insert into room_item values(2,06,011,012,013,014,'Y','',2,1,'','Y','Y','02-28-21 13:20:00');
insert into room_item values(2,08,011,012,013,014,'Y',1,1,1,1,'Y','Y','02-28-21 13:37:00');
insert into room_item values(2,09,011,012,013,014,'Y','',2,1,'','Y','Y','02-28-21 14:40:00');
insert into room_item values(2,14,011,012,013,014,'Y',2,1,1,'','Y','Y','02-28-21 15:20:00');
insert into room_item values(2,10,011,012,013,014,'Y','',2,1,2,'Y','Y','02-28-21 15:55:00');
insert into room_item values(2,15,011,012,013,014,'Y','',1,1,1,'Y','Y','02-28-21 16:20:00');

insert into room_item values(3,11,011,012,013,014,'Y','',2,1,'','Y','Y','02-28-21 09:05:00');
insert into room_item values(3,07,011,012,013,014,'Y',1,1,1,1,'Y','Y','02-28-21 09:43:00');
insert into room_item values(3,13,011,012,013,014,'Y','',1,2,1,'Y','Y','02-28-21 10:04:00');
insert into room_item values(3,12,011,012,013,014,'Y',1,'',1,1,'Y','Y','02-28-21 10:32:00');
insert into room_item values(3,02,011,012,013,014,'Y',1,1,'',2,'Y','Y','02-28-21 10:55:00');
insert into room_item values(3,03,011,012,013,014,'Y','',1,0,1,'Y','Y','02-28-21 11:20:00');
insert into room_item values(3,04,011,012,013,014,'Y','',1,1,01,'Y','Y','02-28-21 11:35:00');
insert into room_item values(3,05,011,012,013,014,'Y',1,2,'',1,'Y','Y','02-28-21 11:56:00');
insert into room_item values(3,06,011,012,013,014,'Y','',2,1,'','Y','Y','02-28-21 12:20:00');
insert into room_item values(3,08,011,012,013,014,'Y',1,1,1,1,'Y','Y','02-28-21 12:37:00');
insert into room_item values(3,09,011,012,013,014,'Y','',2,1,'','Y','Y','02-28-21 12:58:00');
insert into room_item values(3,14,011,012,013,014,'Y',2,1,1,'','Y','Y','02-28-21 13:14:00');
insert into room_item values(3,10,011,012,013,014,'Y','',2,1,2,'Y','Y','02-28-21 13:36:00');
insert into room_item values(3,01,011,012,013,014,'Y','',1,2,1,'Y','Y','02-28-21 14:00:00');


/* insert for damage */
insert into damage values(1,7,'guest removed all towels and ashtrays');
insert into damage values(2,11,'broken cups');
insert into damage values(3,3,'broken window');

SELECT * FROM Inventory;
SELECT * FROM Television;
SELECT * FROM Supplies;
SELECT * FROM Room;
SELECT * FROM Vendor;
SELECT * FROM Maker;
SELECT * FROM TV_set;
SELECT * FROM Furnishings_room;
SELECT * FROM Employee;
SELECT * FROM Manager;
SELECT * FROM Housekeeper;
SELECT * FROM Room_check;
SELECT * FROM Room_item;
SELECT * FROM Damage;
