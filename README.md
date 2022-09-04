# Database-Design-Project

## Executive Summary 

Our client is a family-based motel with a total of 15 rooms. In order to help the them to manage room check records, manage its furniture, and keep track of its inventory, we designed this basic data architecture to help the motel to ease its daily operation activities. This project consists of a detailed ERD for different perspectives including the inventory summary user view, supplies summary user view, housekeeping room check user view, television inventory user view, and furnishing inventory user view. We ultimately determined that the user views for organizational structure and front desk computer screen are not needed since they do not consist of any essential data that will need to be created or updated often. 

In executing our project, we build a CDM model including all necessary entities that need to be a part of our database. When determining the size of our database, we decide to adopt an archive period of 20 years with 350 operating days each year. On average, we assume that 14 out of 15 rooms will be occupied and cleaned by the housekeeper on those 350 days annually. Based on these assumptions, we then proceed to design a process entity matrix, two transaction analysis forms, and a composite usage map. Then, we designed the database utilizing Oracle and inserted data correspondingly for the Durand Motor Inn, as well as showing sample queries on how Durand Motor Inn can use our database to easily keep track of its daily operations as well as analyze employees’ performances. 

## Conceptual Design 
