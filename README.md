# Database-Design-Project

## Executive Summary 

Our client is a family-based motel with a total of 15 rooms. In order to help the them to manage room check records, manage its furniture, and keep track of its inventory, we designed this basic data architecture to help the motel to ease its daily operation activities. This project consists of a detailed ERD for different perspectives including the inventory summary user view, supplies summary user view, housekeeping room check user view, television inventory user view, and furnishing inventory user view. We ultimately determined that the user views for organizational structure and front desk computer screen are not needed since they do not consist of any essential data that will need to be created or updated often. 

In executing our project, we build a CDM model including all necessary entities that need to be a part of our database. When determining the size of our database, we decide to adopt an archive period of 20 years with 350 operating days each year. On average, we assume that 14 out of 15 rooms will be occupied and cleaned by the housekeeper on those 350 days annually. Based on these assumptions, we then proceed to design a process entity matrix, two transaction analysis forms, and a composite usage map. Then, we designed the database utilizing Oracle and inserted data correspondingly for the Durand Motor Inn, as well as showing sample queries on how Durand Motor Inn can use our database to easily keep track of its daily operations as well as analyze employees’ performances. 

## Conceptual Design 

# a. & b. Entity Relationship Diagram for each user view 
& A short description of each user view (except user view 1 & 4)

**USER VIEW 2** - Major Inventory Items User View 

<img width="675" alt="Screen Shot 2022-09-03 at 19 53 40" src="https://user-images.githubusercontent.com/96354451/188295112-0e20d0e5-ca61-4372-aa06-30c929d10417.png">

This user view is often used when a need arises to adjust a room’s furnishings. Including quantity on hand, number in use, and available number. Inventory is a superclass for television, supplies, and other inventories. Each inventory has to have a ‘quantity on hand’ and a ‘description’. Each inventory also has calculated fields of number in use and number available. Each television has a size.

**USER VIEW 3** - Supplies Summary User View 

<img width="646" alt="Screen Shot 2022-09-03 at 19 53 52" src="https://user-images.githubusercontent.com/96354451/188295135-51fb7661-0a9d-44a2-a37c-a2c9f959f911.png">

This user view has the current inventory levels for various supplies used in the operation of the motel, including quantity on hand, reorder point, and reorder quantity. Supply is a subtype of inventory, and each supply has a “reorder point” and a “reorder quantity”.

**USER VIEW 5** - Housekeeping User View

<img width="660" alt="Screen Shot 2022-09-03 at 19 54 04" src="https://user-images.githubusercontent.com/96354451/188295148-62154b87-7a17-43e9-83bb-06adef528cd4.png">

User view 5 primarily shows the housekeeping room check perspective, which is primarily used for the housekeepers to record their daily cleaning activities such as the number of supplies replaced for each room and cleaning descriptions. The employee table is the super-class, and the manager and the housekeeper tables are the sub-class. The room_item records the number of supplies and cleaning status for each room that is done by each housekeeper on the room_check. Some rooms could have damages while some rooms do not. Therefore, the damage table is a failed subclass to the room_item table. 

**USER VIEW 6** - Television Inventory User View

<img width="760" alt="Screen Shot 2022-09-03 at 19 54 17" src="https://user-images.githubusercontent.com/96354451/188295175-0e1e5ec3-9400-4e6f-a2e3-274b78912559.png">

User view 6 includes all television inventory (currently 16 TVs). Along with the size and description for each TV. This user view also includes the vendor, maker, purchase date, serial number, service contract status for each TV set, and the room number it belongs to (if the tv is in use). The TV_set table includes each TV info. The serial number ‘Man_Ser_no’ is the unique identifier for each TV set. The Television table is a subtype of the Inventory table, including the size and description of the TV. 

""USER VIEW 7"" - Furnishings Inventory User View

<img width="634" alt="Screen Shot 2022-09-03 at 19 54 24" src="https://user-images.githubusercontent.com/96354451/188295194-58c0614d-4404-4a03-8691-9688044fbcb4.png">

This user view includes the current furnishing inventory. It shows the Furniture number, description of each piece of furniture, and the room it belongs to (if they are in use). 

# c. Conceptual Data Model (CDM)

<img width="837" alt="Screen Shot 2022-09-03 at 19 54 33" src="https://user-images.githubusercontent.com/96354451/188295204-4d5732cf-6f1e-46c7-b7ba-bae841b90f59.png">

# d. Business Rules 

**General**:
1.1. The Durand Motor Inn has 15 rooms. 
1.2  On average, the Durand Motor Inn has 14 out of 15 rooms occupied. 
1.3. An employee can only be a manager or a housekeeper.
1.4 The Durand Motor Inn has 7 employees, including 2 managers and 5 housekeepers.    
1.5. The Durand Motor Inn opens 350 days per year. 
1.6. Guests stay 5 days in the room on average. 
1.7. Each manager and housekeeper works 10 hours per day.
1.8. A housekeeper only reports to one manager, while a manager manages many housekeepers.
1.9. The database keeps track of 20 years of records.

**Inventory Related**:
2.1. Inventory can be but doesn’t have to be Television or Supplies.
2.2. Inventory can either be Television or Supplies but not both.
2.3. A room can have one queen bed/king bed, or two twin beds; the motel could move furniture from other rooms if guests have special needs.
2.4. Each room can have multiple furnishings, and each furnishing can be in one room or no room.
2.5. Each room can have multiple supplies, and each supply can be in one room or no room. 
2.6. A room can have none, one or more televisions. 
2.7. Each television may have a service contract. 
2.8 Each room on average has 2 beds.

**Housekeeping Related**: 
3.1. Each occupied room has to be cleaned by a housekeeper once a day and has to be checked off by a manager at the end of the day.
3.2. A room can have one room check record a day, and a room check record must match one room.
3.3. For each room checked, the housekeeper records the number of rooms checked, the start time, then the end time for room check each day.
3.4. During the room check, the housekeeper will record the damage description if there are any, and will not record one if there aren’t. 
3.5 On average 2 rooms would incur damage per day.

## Logical Design 

created 14 tables in total, all in 3NF. 

- **Inventory** (Inv_no, description)
- **Television** (Inv_no(FK), tv_size)
- **Supplies** (Inv_no(FK), ROP, ROQ) 
- **Room** (Room_no)
- **Vendor** (Vendor)
- **Maker** (Make)
- **TV_set** (Man_ser_no, Room_no (FK), Inv_no (FK), Vendor (FK), Make (FK), SERV_CON, PURCH_DATE) 
- **Furnishings_Room** (Fur_no, Inv_no(FK), Room_no(FK)) 
- **Employee** (Employee_id, First_name, Last_name)
- **Manager** (Employee_id (FK))
- **Housekeeper** (Employee_id (FK))
- **Room_Check** (rc_id, housekeeper_id(FK), manager_id(FK), time_start, time_end, check_time) 
- **Room_Item** (rc_id, room_no, inv_no_ft, inv_no_tt, inv_no_so, inv_no_sh, ft_quan, tt_quan, soap_quan, shampoo_quan, linen_desc, towel_desc, finish_time) 
- **Damage** (room_no, rc_id, d_description)

## Physical Design and Implementation with the Relational Model

# [a. Entity Matrix](https://docs.google.com/spreadsheets/d/1TINaUu-Ok6hvW9k9kC_4inCAnV2rQ9-k8cCU0KhYDz4/edit?usp=sharing)

<img width="865" alt="Screen Shot 2022-09-03 at 19 54 46" src="https://user-images.githubusercontent.com/96354451/188295448-3b0c7d8d-bfb2-4c6b-ac3c-ad7254849513.png">

# b. Transaction Analysis Forms 

1. Create Room Check 

<img width="759" alt="Screen Shot 2022-09-03 at 19 54 54" src="https://user-images.githubusercontent.com/96354451/188295480-3ab2755f-0aca-4fc6-bd76-8698eb339998.png">

The TAF for creating room_check consists of 6 paths where there are two types of creating and reading. The average is about 1.5 per hour and the peak is 15 per hour. The number of creates and reads are shown above in the map. 

2. Read Manager 

<img width="744" alt="Screen Shot 2022-09-03 at 19 55 03" src="https://user-images.githubusercontent.com/96354451/188295496-00c9e819-9acf-4282-9d93-9f7180c6c7f6.png">

The TAF explains that for the manager table that there are two paths and both are read. The references per transaction is 5 reads and there are 10 reads per period. 

## Composite Usage Map 

<img width="758" alt="Screen Shot 2022-09-03 at 19 55 15" src="https://user-images.githubusercontent.com/96354451/188295510-2f843979-0d58-48b6-ad78-4fe6d13f24ac.png">

d,e,f in the SQL file


