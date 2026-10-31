-- DISASTER RELIEF MANAGEMENT SYSTEM: LARGE DEMO DATASET
-- IMPORTANT: These are SYNTHETIC demo records for testing/demo purposes.
-- They are not reports of real disasters or real people.
-- This script APPENDS rows; it does not delete your existing data.
-- Run in MySQL Workbench after selecting the disaster_relief schema.
-- Core tables follow the schema shared in the conversation.

USE disaster_relief;
START TRANSACTION;

-- 1) DISASTERS: 18 events across 14 Indian cities and 9 disaster types.
-- Explicit IDs 1001-1018 keep these records easy to identify in the demo.
INSERT INTO disasters
(disaster_id, disaster_name, disaster_type, location, start_date, status)
VALUES
(1001,'Agartala Urban Flood Demo','Flood','Agartala, Tripura','2026-06-18','Active'),
(1002,'Guwahati River Flood Demo','Flood','Guwahati, Assam','2026-06-20','Active'),
(1003,'Shillong Slope Movement Demo','Landslide','Shillong, Meghalaya','2026-07-04','Monitoring'),
(1004,'Aizawl Hill Road Landslide Demo','Landslide','Aizawl, Mizoram','2026-07-09','Active'),
(1005,'Imphal Valley Flood Demo','Flood','Imphal, Manipur','2026-06-25','Response'),
(1006,'Kolkata Coastal Storm Demo','Severe Storm','Kolkata, West Bengal','2026-05-14','Monitoring'),
(1007,'Patna Heatwave Demo','Heatwave','Patna, Bihar','2026-05-22','Active'),
(1008,'Bhubaneswar Cyclone Preparedness Demo','Cyclone','Bhubaneswar, Odisha','2026-10-03','Preparedness'),
(1009,'Chennai Urban Flood Demo','Flood','Chennai, Tamil Nadu','2026-11-11','Preparedness'),
(1010,'Mumbai Heavy Rain Demo','Flood','Mumbai, Maharashtra','2026-07-16','Response'),
(1011,'Delhi Heatwave Demo','Heatwave','Delhi, Delhi','2026-06-02','Active'),
(1012,'Bengaluru Industrial Safety Demo','Industrial Accident','Bengaluru, Karnataka','2026-08-08','Monitoring'),
(1013,'Hyderabad Warehouse Fire Demo','Fire','Hyderabad, Telangana','2026-04-19','Closed'),
(1014,'Dehradun Earthquake Readiness Demo','Earthquake','Dehradun, Uttarakhand','2026-09-10','Preparedness'),
(1015,'Agartala Severe Storm Demo','Severe Storm','Agartala, Tripura','2026-08-21','Monitoring'),
(1016,'Guwahati Drought Preparedness Demo','Drought','Guwahati, Assam','2026-03-12','Preparedness'),
(1017,'Kolkata Industrial Safety Demo','Industrial Accident','Kolkata, West Bengal','2026-09-02','Monitoring'),
(1018,'Chennai Fire Response Demo','Fire','Chennai, Tamil Nadu','2026-02-07','Closed')
ON DUPLICATE KEY UPDATE
disaster_name=VALUES(disaster_name), disaster_type=VALUES(disaster_type),
location=VALUES(location), start_date=VALUES(start_date), status=VALUES(status);

-- 2) RELIEF CAMPS: 28 camps across the 14 cities.
-- Camp IDs 1001-1028 are explicit so related demo records can refer to them.
INSERT INTO relief_camps
(camp_id, camp_name, location, capacity, occupied, status)
VALUES
(1001,'Agartala Central Relief Camp','Agartala, Tripura',450,328,'Active'),
(1002,'Agartala North Community Shelter','Agartala, Tripura',220,141,'Active'),
(1003,'Guwahati Riverside Relief Camp','Guwahati, Assam',600,512,'Active'),
(1004,'Guwahati School Shelter','Guwahati, Assam',300,177,'Active'),
(1005,'Shillong Community Hall Camp','Shillong, Meghalaya',180,96,'Active'),
(1006,'Shillong East Temporary Shelter','Shillong, Meghalaya',150,72,'Monitoring'),
(1007,'Aizawl Sports Complex Camp','Aizawl, Mizoram',250,188,'Active'),
(1008,'Aizawl North Relief Point','Aizawl, Mizoram',120,64,'Active'),
(1009,'Imphal Valley Relief Camp','Imphal, Manipur',500,401,'Active'),
(1010,'Imphal West Community Shelter','Imphal, Manipur',260,159,'Active'),
(1011,'Kolkata Community Relief Centre','Kolkata, West Bengal',700,546,'Active'),
(1012,'Kolkata South School Shelter','Kolkata, West Bengal',350,204,'Active'),
(1013,'Patna Heat Relief Centre','Patna, Bihar',280,190,'Active'),
(1014,'Patna North Cooling Shelter','Patna, Bihar',160,101,'Active'),
(1015,'Bhubaneswar Cyclone Shelter A','Bhubaneswar, Odisha',650,420,'Preparedness'),
(1016,'Bhubaneswar Community Shelter','Bhubaneswar, Odisha',320,188,'Active'),
(1017,'Chennai Civic Relief Camp','Chennai, Tamil Nadu',550,365,'Active'),
(1018,'Chennai South Temporary Shelter','Chennai, Tamil Nadu',280,132,'Preparedness'),
(1019,'Mumbai Ward Relief Centre','Mumbai, Maharashtra',750,604,'Active'),
(1020,'Mumbai East School Shelter','Mumbai, Maharashtra',300,215,'Active'),
(1021,'Delhi Heat Support Centre','Delhi, Delhi',400,244,'Active'),
(1022,'Delhi Community Cooling Shelter','Delhi, Delhi',220,116,'Active'),
(1023,'Bengaluru Emergency Support Camp','Bengaluru, Karnataka',320,137,'Monitoring'),
(1024,'Bengaluru East Community Shelter','Bengaluru, Karnataka',180,83,'Active'),
(1025,'Hyderabad Relief and Recovery Camp','Hyderabad, Telangana',360,121,'Closed'),
(1026,'Hyderabad West Community Shelter','Hyderabad, Telangana',200,77,'Active'),
(1027,'Dehradun Mountain Relief Camp','Dehradun, Uttarakhand',240,162,'Preparedness'),
(1028,'Dehradun City Emergency Shelter','Dehradun, Uttarakhand',160,58,'Active')
ON DUPLICATE KEY UPDATE
camp_name=VALUES(camp_name), location=VALUES(location), capacity=VALUES(capacity),
occupied=VALUES(occupied), status=VALUES(status);

-- 3) RELIEF RESOURCES: 36 stock categories/items.
INSERT INTO relief_resources
(resource_id, item_name, category, total_quantity, quantity_distributed)
VALUES
(1001,'Packaged Drinking Water','Water',12000,7350),
(1002,'Water Purification Tablets','Water',8000,2950),
(1003,'Water Storage Can (20L)','Water',1800,910),
(1004,'Rice (1 kg packs)','Food',9000,5220),
(1005,'Ready-to-Eat Meal Packs','Food',6500,3810),
(1006,'Baby Food Packs','Food',1400,620),
(1007,'Dry Ration Kits','Food',3200,1940),
(1008,'ORS Sachets','Medical',6000,2740),
(1009,'First Aid Kits','Medical',950,405),
(1010,'Paracetamol Packs','Medical',1800,790),
(1011,'Bandage Rolls','Medical',2400,870),
(1012,'Antiseptic Solution Bottles','Medical',1200,455),
(1013,'N95 Masks','Safety',4500,1640),
(1014,'Disposable Gloves','Safety',8000,3180),
(1015,'Protective Goggles','Safety',1000,280),
(1016,'Emergency Blankets','Shelter',2800,1460),
(1017,'Family Tents','Shelter',650,302),
(1018,'Tarpaulin Sheets','Shelter',2200,1180),
(1019,'Sleeping Mats','Shelter',2600,1390),
(1020,'Hygiene Kits','Hygiene',3400,1775),
(1021,'Sanitary Product Kits','Hygiene',2800,1320),
(1022,'Soap Bars','Hygiene',7000,2880),
(1023,'Baby Diapers','Hygiene',3600,1490),
(1024,'Solar Lanterns','Equipment',950,440),
(1025,'Rechargeable Torches','Equipment',1400,625),
(1026,'Power Banks','Equipment',850,290),
(1027,'Portable Phone Chargers','Equipment',600,188),
(1028,'Raincoats','Clothing',1800,970),
(1029,'Blankets','Clothing',4200,2310),
(1030,'Children Clothing Kits','Clothing',1250,580),
(1031,'Adult Clothing Kits','Clothing',1600,710),
(1032,'Sandbags','Flood Control',12000,6450),
(1033,'Rescue Ropes','Rescue',420,106),
(1034,'Life Jackets','Rescue',780,315),
(1035,'Fire Extinguishers','Fire Safety',240,76),
(1036,'Wheelchairs','Accessibility',95,28)
ON DUPLICATE KEY UPDATE
item_name=VALUES(item_name), category=VALUES(category),
total_quantity=VALUES(total_quantity), quantity_distributed=VALUES(quantity_distributed);

-- 4) BENEFICIARIES: 56 synthetic profiles. IDs are unique demo IDs.
INSERT INTO beneficiaries
(victim_id, name, phone, age, gender, camp_id, family_members, status)
VALUES
('V-DEMO-001','Ananya Das','9000000001',34,'Female',1001,4,'Registered'),
('V-DEMO-002','Ritwik Saha','9000000002',42,'Male',1001,5,'Needs Assistance'),
('V-DEMO-003','Madhuri Debbarma','9000000003',67,'Female',1002,2,'Priority'),
('V-DEMO-004','Bikash Roy','9000000004',29,'Male',1002,3,'Registered'),
('V-DEMO-005','Nabanita Paul','9000000005',31,'Female',1003,4,'Registered'),
('V-DEMO-006','Arup Bora','9000000006',55,'Male',1003,6,'Needs Assistance'),
('V-DEMO-007','Mitali Das','9000000007',72,'Female',1004,1,'Priority'),
('V-DEMO-008','Pranab Saikia','9000000008',38,'Male',1004,4,'Registered'),
('V-DEMO-009','Ibadah Khonglam','9000000009',26,'Female',1005,3,'Registered'),
('V-DEMO-010','Dawphlang Lyngdoh','9000000010',61,'Male',1005,2,'Priority'),
('V-DEMO-011','Lalruatfeli','9000000011',44,'Female',1006,5,'Needs Assistance'),
('V-DEMO-012','Lalhmingmawia','9000000012',35,'Male',1006,4,'Registered'),
('V-DEMO-013','Thangjam Ibemcha','9000000013',52,'Female',1007,3,'Registered'),
('V-DEMO-014','Oinam Sanatomba','9000000014',47,'Male',1007,5,'Needs Assistance'),
('V-DEMO-015','Roshni Ghosh','9000000015',24,'Female',1011,2,'Registered'),
('V-DEMO-016','Sourav Mukherjee','9000000016',39,'Male',1011,4,'Registered'),
('V-DEMO-017','Farida Begum','9000000017',70,'Female',1012,3,'Priority'),
('V-DEMO-018','Debashis Pal','9000000018',58,'Male',1012,2,'Needs Assistance'),
('V-DEMO-019','Neha Kumari','9000000019',33,'Female',1013,4,'Registered'),
('V-DEMO-020','Amit Kumar','9000000020',45,'Male',1013,6,'Needs Assistance'),
('V-DEMO-021','Suman Devi','9000000021',75,'Female',1014,1,'Priority'),
('V-DEMO-022','Rakesh Yadav','9000000022',27,'Male',1014,3,'Registered'),
('V-DEMO-023','Suchitra Mohanty','9000000023',36,'Female',1015,4,'Registered'),
('V-DEMO-024','Pradeep Behera','9000000024',50,'Male',1015,5,'Needs Assistance'),
('V-DEMO-025','Lipsa Nayak','9000000025',29,'Female',1016,2,'Registered'),
('V-DEMO-026','Ashok Sahu','9000000026',64,'Male',1016,3,'Priority'),
('V-DEMO-027','Kavitha Rajan','9000000027',41,'Female',1017,4,'Registered'),
('V-DEMO-028','Arun Prakash','9000000028',32,'Male',1017,3,'Needs Assistance'),
('V-DEMO-029','Meena Krishnan','9000000029',69,'Female',1018,2,'Priority'),
('V-DEMO-030','Saravanan Kumar','9000000030',46,'Male',1018,5,'Registered'),
('V-DEMO-031','Ayesha Shaikh','9000000031',30,'Female',1019,4,'Registered'),
('V-DEMO-032','Nilesh Patil','9000000032',54,'Male',1019,5,'Needs Assistance'),
('V-DEMO-033','Jyoti Jadhav','9000000033',73,'Female',1020,2,'Priority'),
('V-DEMO-034','Rahul More','9000000034',28,'Male',1020,3,'Registered'),
('V-DEMO-035','Pooja Sharma','9000000035',35,'Female',1021,4,'Registered'),
('V-DEMO-036','Mohit Verma','9000000036',49,'Male',1021,3,'Needs Assistance'),
('V-DEMO-037','Shabnam Ali','9000000037',66,'Female',1022,2,'Priority'),
('V-DEMO-038','Vikas Singh','9000000038',31,'Male',1022,4,'Registered'),
('V-DEMO-039','Divya Reddy','9000000039',27,'Female',1023,3,'Registered'),
('V-DEMO-040','Kiran Kumar','9000000040',59,'Male',1023,5,'Needs Assistance'),
('V-DEMO-041','Sowmya Rao','9000000041',71,'Female',1024,2,'Priority'),
('V-DEMO-042','Manoj Gowda','9000000042',40,'Male',1024,4,'Registered'),
('V-DEMO-043','Sana Fatima','9000000043',33,'Female',1025,3,'Registered'),
('V-DEMO-044','Ramesh Naidu','9000000044',62,'Male',1025,2,'Priority'),
('V-DEMO-045','Aparna Reddy','9000000045',37,'Female',1026,4,'Registered'),
('V-DEMO-046','Srinivas Rao','9000000046',48,'Male',1026,5,'Needs Assistance'),
('V-DEMO-047','Megha Rawat','9000000047',25,'Female',1027,2,'Registered'),
('V-DEMO-048','Harish Bisht','9000000048',57,'Male',1027,4,'Needs Assistance'),
('V-DEMO-049','Nisha Kandari','9000000049',68,'Female',1028,1,'Priority'),
('V-DEMO-050','Deepak Negi','9000000050',36,'Male',1028,3,'Registered'),
('V-DEMO-051','Tania Debbarma','9000000051',19,'Female',1001,2,'Registered'),
('V-DEMO-052','Subhash Das','9000000052',81,'Male',1003,1,'Priority'),
('V-DEMO-053','Moumita Roy','9000000053',8,'Female',1011,5,'Priority'),
('V-DEMO-054','Anil Kumar','9000000054',14,'Male',1013,4,'Registered'),
('V-DEMO-055','Keerthana S','9000000055',22,'Female',1017,3,'Registered'),
('V-DEMO-056','Ishita Sharma','9000000056',76,'Female',1021,2,'Priority')
ON DUPLICATE KEY UPDATE
name=VALUES(name), phone=VALUES(phone), age=VALUES(age), gender=VALUES(gender),
camp_id=VALUES(camp_id), family_members=VALUES(family_members), status=VALUES(status);

-- 5) ASSISTANCE REQUESTS: 42 records.
INSERT INTO assistance_requests
(request_id, requester, category, camp_id, priority, status, description)
VALUES
('AR-DEMO-001','Ananya Das','Food',1001,'High','Pending','Family of four needs dry ration and drinking water.'),
('AR-DEMO-002','Ritwik Saha','Shelter',1001,'Medium','In Progress','Request for a weatherproof temporary shelter.'),
('AR-DEMO-003','Madhuri Debbarma','Medical',1002,'High','Pending','Needs routine medicine refill and mobility support.'),
('AR-DEMO-004','Bikash Roy','Clothing',1002,'Low','Resolved','Request for adult clothing and blankets.'),
('AR-DEMO-005','Nabanita Paul','Water',1003,'High','In Progress','Drinking water required for a family group.'),
('AR-DEMO-006','Arup Bora','Rescue',1003,'Critical','Pending','Request for help moving belongings from a flooded area.'),
('AR-DEMO-007','Mitali Das','Medical',1004,'High','Pending','Elderly resident requests medical assessment.'),
('AR-DEMO-008','Pranab Saikia','Hygiene',1004,'Medium','Resolved','Family hygiene kit requested.'),
('AR-DEMO-009','Ibadah Khonglam','Food',1005,'Medium','In Progress','Additional meal packs needed for three people.'),
('AR-DEMO-010','Dawphlang Lyngdoh','Shelter',1005,'High','Pending','Temporary accommodation for two people.'),
('AR-DEMO-011','Lalruatfeli','Water',1006,'High','Pending','Request for clean drinking water.'),
('AR-DEMO-012','Lalhmingmawia','Equipment',1006,'Low','Resolved','Rechargeable torch requested.'),
('AR-DEMO-013','Thangjam Ibemcha','Food',1007,'Medium','In Progress','Food kit requested for household.'),
('AR-DEMO-014','Oinam Sanatomba','Medical',1007,'High','Pending','Needs first-aid supplies and health check.'),
('AR-DEMO-015','Roshni Ghosh','Shelter',1011,'Medium','In Progress','Temporary shelter for two family members.'),
('AR-DEMO-016','Sourav Mukherjee','Water',1011,'High','Pending','Water supply requested for household.'),
('AR-DEMO-017','Farida Begum','Medical',1012,'Critical','In Progress','Priority medical assessment requested.'),
('AR-DEMO-018','Debashis Pal','Clothing',1012,'Low','Resolved','Dry clothes and blankets requested.'),
('AR-DEMO-019','Neha Kumari','Water',1013,'High','Pending','Drinking water and ORS requested during heat conditions.'),
('AR-DEMO-020','Amit Kumar','Medical',1013,'Critical','In Progress','Urgent assessment requested for heat-related symptoms.'),
('AR-DEMO-021','Suman Devi','Shelter',1014,'High','Pending','Cool indoor resting space requested.'),
('AR-DEMO-022','Rakesh Yadav','Food',1014,'Medium','Resolved','Meal packs requested.'),
('AR-DEMO-023','Suchitra Mohanty','Shelter',1015,'High','In Progress','Family needs cyclone-safe shelter allocation.'),
('AR-DEMO-024','Pradeep Behera','Rescue',1015,'Critical','Pending','Request for transport to a designated safe location.'),
('AR-DEMO-025','Lipsa Nayak','Hygiene',1016,'Low','Resolved','Hygiene kit requested.'),
('AR-DEMO-026','Ashok Sahu','Medical',1016,'High','Pending','Medicine and a basic health check requested.'),
('AR-DEMO-027','Kavitha Rajan','Food',1017,'Medium','In Progress','Family food kit requested.'),
('AR-DEMO-028','Arun Prakash','Water',1017,'High','Pending','Clean water requested for a household.'),
('AR-DEMO-029','Meena Krishnan','Medical',1018,'High','Pending','Follow-up assessment and medicine requested.'),
('AR-DEMO-030','Saravanan Kumar','Shelter',1018,'Low','Resolved','Temporary shelter information requested.'),
('AR-DEMO-031','Ayesha Shaikh','Food',1019,'Medium','In Progress','Food and drinking water requested.'),
('AR-DEMO-032','Nilesh Patil','Rescue',1019,'Critical','Pending','Request for assistance reaching a safe collection point.'),
('AR-DEMO-033','Jyoti Jadhav','Medical',1020,'High','Pending','Priority check-up requested.'),
('AR-DEMO-034','Rahul More','Clothing',1020,'Low','Resolved','Dry clothing kit requested.'),
('AR-DEMO-035','Pooja Sharma','Water',1021,'High','Pending','Water and ORS requested.'),
('AR-DEMO-036','Mohit Verma','Medical',1021,'High','In Progress','Request for heat-safety medical check.'),
('AR-DEMO-037','Shabnam Ali','Shelter',1022,'Medium','Resolved','Cooling shelter information requested.'),
('AR-DEMO-038','Vikas Singh','Food',1022,'Medium','Pending','Meal kit requested for household.'),
('AR-DEMO-039','Divya Reddy','Medical',1023,'High','In Progress','First aid and medical review requested.'),
('AR-DEMO-040','Kiran Kumar','Equipment',1023,'Low','Resolved','Torch and phone charging access requested.'),
('AR-DEMO-041','Sana Fatima','Shelter',1025,'Medium','Pending','Temporary shelter requested.'),
('AR-DEMO-042','Megha Rawat','Rescue',1027,'Critical','In Progress','Transport assistance requested in a mountainous area.')
ON DUPLICATE KEY UPDATE
requester=VALUES(requester), category=VALUES(category), camp_id=VALUES(camp_id),
priority=VALUES(priority), status=VALUES(status), description=VALUES(description);

-- 6) SOS REQUESTS: 35 records.
INSERT INTO sos_requests
(sos_id, name, location, request_type, request_time, status)
VALUES
('SOS-DEMO-001','Demo Caller 001','Agartala, Tripura - Ward 4','Flood Rescue','2026-06-18 08:15','Pending'),
('SOS-DEMO-002','Demo Caller 002','Agartala, Tripura - Ward 7','Food and Water','2026-06-18 09:05','In Progress'),
('SOS-DEMO-003','Demo Caller 003','Guwahati, Assam - Riverside','Flood Rescue','2026-06-20 07:45','Pending'),
('SOS-DEMO-004','Demo Caller 004','Guwahati, Assam - Ward 12','Medical Help','2026-06-20 10:10','In Progress'),
('SOS-DEMO-005','Demo Caller 005','Shillong, Meghalaya - East Slope','Landslide Support','2026-07-04 06:40','Pending'),
('SOS-DEMO-006','Demo Caller 006','Shillong, Meghalaya - Market Road','Evacuation','2026-07-04 07:25','Resolved'),
('SOS-DEMO-007','Demo Caller 007','Aizawl, Mizoram - Hill Road','Landslide Support','2026-07-09 08:30','Pending'),
('SOS-DEMO-008','Demo Caller 008','Aizawl, Mizoram - North Zone','Medical Help','2026-07-09 09:20','In Progress'),
('SOS-DEMO-009','Demo Caller 009','Imphal, Manipur - Valley Area','Flood Rescue','2026-06-25 05:55','Pending'),
('SOS-DEMO-010','Demo Caller 010','Imphal, Manipur - West Zone','Food and Water','2026-06-25 11:00','Resolved'),
('SOS-DEMO-011','Demo Caller 011','Kolkata, West Bengal - South Zone','Storm Shelter','2026-05-14 08:05','In Progress'),
('SOS-DEMO-012','Demo Caller 012','Kolkata, West Bengal - Ward 9','Medical Help','2026-05-14 09:45','Pending'),
('SOS-DEMO-013','Demo Caller 013','Patna, Bihar - Central Zone','Heat Relief','2026-05-22 12:15','Pending'),
('SOS-DEMO-014','Demo Caller 014','Patna, Bihar - North Zone','Medical Help','2026-05-22 13:05','In Progress'),
('SOS-DEMO-015','Demo Caller 015','Bhubaneswar, Odisha - Shelter Zone','Cyclone Shelter','2026-10-03 06:30','Monitoring'),
('SOS-DEMO-016','Demo Caller 016','Bhubaneswar, Odisha - Ward 3','Evacuation','2026-10-03 07:15','Pending'),
('SOS-DEMO-017','Demo Caller 017','Chennai, Tamil Nadu - Low-Lying Area','Flood Rescue','2026-11-11 06:10','Pending'),
('SOS-DEMO-018','Demo Caller 018','Chennai, Tamil Nadu - South Zone','Medical Help','2026-11-11 08:50','In Progress'),
('SOS-DEMO-019','Demo Caller 019','Mumbai, Maharashtra - Ward 5','Flood Rescue','2026-07-16 07:00','Pending'),
('SOS-DEMO-020','Demo Caller 020','Mumbai, Maharashtra - East Zone','Food and Water','2026-07-16 08:40','Resolved'),
('SOS-DEMO-021','Demo Caller 021','Delhi, Delhi - Central Zone','Heat Relief','2026-06-02 12:20','Pending'),
('SOS-DEMO-022','Demo Caller 022','Delhi, Delhi - West Zone','Medical Help','2026-06-02 13:30','In Progress'),
('SOS-DEMO-023','Demo Caller 023','Bengaluru, Karnataka - Industrial Area','Industrial Safety','2026-08-08 10:10','Monitoring'),
('SOS-DEMO-024','Demo Caller 024','Bengaluru, Karnataka - East Zone','Medical Help','2026-08-08 10:55','Resolved'),
('SOS-DEMO-025','Demo Caller 025','Hyderabad, Telangana - Warehouse District','Fire Response','2026-04-19 14:05','Resolved'),
('SOS-DEMO-026','Demo Caller 026','Hyderabad, Telangana - West Zone','Medical Help','2026-04-19 14:25','Resolved'),
('SOS-DEMO-027','Demo Caller 027','Dehradun, Uttarakhand - Foothill Zone','Earthquake Readiness','2026-09-10 08:10','Monitoring'),
('SOS-DEMO-028','Demo Caller 028','Dehradun, Uttarakhand - City Zone','Evacuation Information','2026-09-10 08:45','Pending'),
('SOS-DEMO-029','Demo Caller 029','Agartala, Tripura - Ward 2','Family Check','2026-08-21 17:15','Resolved'),
('SOS-DEMO-030','Demo Caller 030','Guwahati, Assam - Outer Zone','Drought Water Supply','2026-03-12 10:30','Monitoring'),
('SOS-DEMO-031','Demo Caller 031','Kolkata, West Bengal - Industrial Belt','Industrial Safety','2026-09-02 11:40','Pending'),
('SOS-DEMO-032','Demo Caller 032','Chennai, Tamil Nadu - Central Zone','Fire Response','2026-02-07 15:00','Resolved'),
('SOS-DEMO-033','Demo Caller 033','Patna, Bihar - South Zone','Heat Relief','2026-05-22 14:10','Pending'),
('SOS-DEMO-034','Demo Caller 034','Mumbai, Maharashtra - Coastal Ward','Evacuation Information','2026-07-16 09:30','In Progress'),
('SOS-DEMO-035','Demo Caller 035','Aizawl, Mizoram - Community Zone','Shelter and Supplies','2026-07-09 10:20','Pending')
ON DUPLICATE KEY UPDATE
name=VALUES(name), location=VALUES(location), request_type=VALUES(request_type),
request_time=VALUES(request_time), status=VALUES(status);

-- 7) MEDICAL CASES: 30 synthetic cases.
INSERT INTO medical_cases
(case_id, patient, medical_condition, camp_id, priority, status, referral_notes)
VALUES
('MC-DEMO-001','Demo Patient 001','Dehydration',1001,'High','Under Review','Provide oral rehydration and clinical assessment.'),
('MC-DEMO-002','Demo Patient 002','Minor cuts and abrasions',1001,'Medium','Treated','Clean wounds and monitor for infection.'),
('MC-DEMO-003','Demo Patient 003','Hypertension medication refill',1002,'High','Referred','Needs clinician review and medication continuity.'),
('MC-DEMO-004','Demo Patient 004','Fever',1003,'Medium','Under Review','Assess temperature and hydration.'),
('MC-DEMO-005','Demo Patient 005','Minor injury',1003,'Low','Treated','First aid provided; routine observation.'),
('MC-DEMO-006','Demo Patient 006','Respiratory irritation',1004,'Medium','Referred','Move away from dust and assess breathing.'),
('MC-DEMO-007','Demo Patient 007','Mobility assistance required',1005,'High','Under Review','Arrange accessible transport and support.'),
('MC-DEMO-008','Demo Patient 008','Skin irritation',1005,'Low','Treated','Basic care and hygiene guidance.'),
('MC-DEMO-009','Demo Patient 009','Dehydration',1006,'High','Under Review','Assess fluid status; escalate if worsening.'),
('MC-DEMO-010','Demo Patient 010','Anxiety after evacuation',1006,'Medium','Referred','Offer psychosocial first aid and follow-up.'),
('MC-DEMO-011','Demo Patient 011','Heat exhaustion symptoms',1011,'High','Referred','Move to a cool area and arrange prompt medical evaluation.'),
('MC-DEMO-012','Demo Patient 012','Diabetes medication continuity',1011,'High','Under Review','Check medication access and clinical needs.'),
('MC-DEMO-013','Demo Patient 013','Minor burn',1012,'Medium','Treated','Wound care and follow-up as clinically appropriate.'),
('MC-DEMO-014','Demo Patient 014','Fever and weakness',1012,'Medium','Under Review','Clinical assessment requested.'),
('MC-DEMO-015','Demo Patient 015','Heat-related illness risk',1013,'High','Referred','Prompt assessment; monitor for deterioration.'),
('MC-DEMO-016','Demo Patient 016','Dehydration',1013,'High','Under Review','Hydration assessment and observation.'),
('MC-DEMO-017','Demo Patient 017','Minor fracture concern',1014,'High','Referred','Immobilize if appropriate and arrange clinical evaluation.'),
('MC-DEMO-018','Demo Patient 018','Routine antenatal check',1015,'Medium','Under Review','Arrange routine clinician consultation.'),
('MC-DEMO-019','Demo Patient 019','Minor laceration',1015,'Medium','Treated','Wound cleaned and dressing applied.'),
('MC-DEMO-020','Demo Patient 020','Asthma history',1016,'High','Referred','Assess breathing and access to prescribed medication.'),
('MC-DEMO-021','Demo Patient 021','Gastrointestinal symptoms',1017,'Medium','Under Review','Assess hydration and symptoms.'),
('MC-DEMO-022','Demo Patient 022','Minor foot injury',1017,'Low','Treated','Basic first aid and review if symptoms worsen.'),
('MC-DEMO-023','Demo Patient 023','Medication replacement request',1018,'Medium','Under Review','Verify prescription and arrange authorized replacement.'),
('MC-DEMO-024','Demo Patient 024','Smoke exposure concern',1019,'High','Referred','Move to fresh air and seek urgent clinical assessment if symptomatic.'),
('MC-DEMO-025','Demo Patient 025','Minor cuts',1019,'Low','Treated','First aid and wound-care advice.'),
('MC-DEMO-026','Demo Patient 026','Heat exhaustion symptoms',1021,'High','Referred','Move to a cool place and arrange prompt assessment.'),
('MC-DEMO-027','Demo Patient 027','Anxiety and sleep disruption',1022,'Medium','Under Review','Offer psychosocial support and follow-up.'),
('MC-DEMO-028','Demo Patient 028','Minor injury',1023,'Low','Treated','First aid completed.'),
('MC-DEMO-029','Demo Patient 029','Fall-related injury',1027,'High','Referred','Arrange clinical assessment and safe transport.'),
('MC-DEMO-030','Demo Patient 030','Cold exposure concern',1028,'Medium','Under Review','Warm shelter and clinical assessment as needed.')
ON DUPLICATE KEY UPDATE
patient=VALUES(patient), medical_condition=VALUES(medical_condition), camp_id=VALUES(camp_id),
priority=VALUES(priority), status=VALUES(status), referral_notes=VALUES(referral_notes);

-- 8) PUBLIC NOTICES: 12 notices.
INSERT INTO public_notices
(notice_id, title, body, status)
VALUES
(1001,'Agartala Relief Camp Registration','Demo notice: residents can register at the listed relief camp. Bring identification if available; lack of documents should not delay urgent help.','Active'),
(1002,'Flood Safety Advisory','Demo notice: avoid walking or driving through floodwater. Follow instructions from local emergency officials.','Active'),
(1003,'Clean Drinking Water Distribution','Demo notice: water distribution is scheduled at designated camp counters. Follow posted queue and accessibility arrangements.','Active'),
(1004,'Medical Desk Timings','Demo notice: the camp medical desk is open during posted service hours. Emergency symptoms require immediate clinical attention.','Active'),
(1005,'Heat Safety Support','Demo notice: use shaded or cooled areas, drink safe water, and seek medical help for severe symptoms.','Active'),
(1006,'Cyclone Preparedness Information','Demo notice: keep essential medicines and documents ready and follow official evacuation announcements.','Active'),
(1007,'Family Reunification Desk','Demo notice: report missing family members to the designated help desk with available identifying details.','Active'),
(1008,'Accessible Shelter Support','Demo notice: residents needing mobility, communication, or other accessibility support can contact the camp coordinator.','Active'),
(1009,'Volunteer Registration','Demo notice: volunteers should register with the authorized coordination desk before assisting.','Active'),
(1010,'Relief Supply Collection','Demo notice: distribution priorities are based on assessed need and available stock. Please follow staff directions.','Active'),
(1011,'Camp Hygiene Reminder','Demo notice: use designated waste points and report water or sanitation issues to camp management.','Active'),
(1012,'Resolved Incident Update','Demo notice: this sample incident is marked closed for demonstration; check official channels for real emergency updates.','Archived')
ON DUPLICATE KEY UPDATE
title=VALUES(title), body=VALUES(body), status=VALUES(status);

-- 9) ACTIVITIES: 20 entries.
INSERT INTO activities (activity_id, activity_time, activity_text)
VALUES
(1001,'2026-10-28 08:00','Demo dataset loaded: Agartala camp occupancy reviewed.'),
(1002,'2026-10-28 08:15','Demo activity: water stock checked at Guwahati relief camp.'),
(1003,'2026-10-28 08:30','Demo activity: medical desk received a new case at Shillong camp.'),
(1004,'2026-10-28 08:45','Demo activity: temporary shelter capacity reviewed in Aizawl.'),
(1005,'2026-10-28 09:00','Demo activity: Imphal family assistance request entered.'),
(1006,'2026-10-28 09:15','Demo activity: Kolkata food-kit distribution recorded.'),
(1007,'2026-10-28 09:30','Demo activity: Patna heat-safety notice published.'),
(1008,'2026-10-28 09:45','Demo activity: Bhubaneswar cyclone shelter readiness reviewed.'),
(1009,'2026-10-28 10:00','Demo activity: Chennai water supply request triaged.'),
(1010,'2026-10-28 10:15','Demo activity: Mumbai rescue request assigned.'),
(1011,'2026-10-28 10:30','Demo activity: Delhi medical assistance request reviewed.'),
(1012,'2026-10-28 10:45','Demo activity: Bengaluru safety case referred for review.'),
(1013,'2026-10-28 11:00','Demo activity: Hyderabad fire-response case marked closed.'),
(1014,'2026-10-28 11:15','Demo activity: Dehradun preparedness shelter inspected.'),
(1015,'2026-10-28 11:30','Demo activity: stock levels reconciled for hygiene kits.'),
(1016,'2026-10-28 11:45','Demo activity: priority beneficiaries reviewed by camp coordinator.'),
(1017,'2026-10-28 12:00','Demo activity: SOS request moved to In Progress.'),
(1018,'2026-10-28 12:15','Demo activity: public information notice updated.'),
(1019,'2026-10-28 12:30','Demo activity: accessibility support request assigned.'),
(1020,'2026-10-28 12:45','Demo activity: daily relief inventory check completed.')
ON DUPLICATE KEY UPDATE activity_time=VALUES(activity_time), activity_text=VALUES(activity_text);

-- 10) AUDIT LOGS: 20 entries.
INSERT INTO audit_logs (audit_id, log_time, role, action, target)
VALUES
(1001,'2026-10-28 08:00:00','Admin','Loaded synthetic demo records','disasters'),
(1002,'2026-10-28 08:10:00','Admin','Reviewed relief camp occupancy','relief_camps'),
(1003,'2026-10-28 08:20:00','Coordinator','Reviewed beneficiary registrations','beneficiaries'),
(1004,'2026-10-28 08:30:00','Medical Team','Reviewed medical case queue','medical_cases'),
(1005,'2026-10-28 08:40:00','Supply Team','Checked food inventory','relief_resources'),
(1006,'2026-10-28 08:50:00','Supply Team','Checked water inventory','relief_resources'),
(1007,'2026-10-28 09:00:00','Admin','Published flood safety notice','public_notices'),
(1008,'2026-10-28 09:10:00','Coordinator','Triaged SOS request','sos_requests'),
(1009,'2026-10-28 09:20:00','Coordinator','Updated assistance request status','assistance_requests'),
(1010,'2026-10-28 09:30:00','Medical Team','Referred high-priority case','medical_cases'),
(1011,'2026-10-28 09:40:00','Camp Manager','Recorded camp occupancy review','relief_camps'),
(1012,'2026-10-28 09:50:00','Admin','Reviewed active disaster list','disasters'),
(1013,'2026-10-28 10:00:00','Supply Team','Recorded distribution batch','relief_resources'),
(1014,'2026-10-28 10:10:00','Coordinator','Assigned family support request','assistance_requests'),
(1015,'2026-10-28 10:20:00','Admin','Updated public notice','public_notices'),
(1016,'2026-10-28 10:30:00','Medical Team','Updated referral notes','medical_cases'),
(1017,'2026-10-28 10:40:00','Coordinator','Reviewed unresolved SOS requests','sos_requests'),
(1018,'2026-10-28 10:50:00','Camp Manager','Reviewed shelter readiness','relief_camps'),
(1019,'2026-10-28 11:00:00','Admin','Reviewed dashboard activity feed','activities'),
(1020,'2026-10-28 11:10:00','Admin','Completed demo audit review','audit_logs')
ON DUPLICATE KEY UPDATE role=VALUES(role), action=VALUES(action), target=VALUES(target);

COMMIT;

-- QUICK VERIFICATION: run these after the script completes.
SELECT 'disasters' AS table_name, COUNT(*) AS row_count FROM disasters
UNION ALL SELECT 'relief_camps', COUNT(*) FROM relief_camps
UNION ALL SELECT 'relief_resources', COUNT(*) FROM relief_resources
UNION ALL SELECT 'beneficiaries', COUNT(*) FROM beneficiaries
UNION ALL SELECT 'assistance_requests', COUNT(*) FROM assistance_requests
UNION ALL SELECT 'sos_requests', COUNT(*) FROM sos_requests
UNION ALL SELECT 'medical_cases', COUNT(*) FROM medical_cases
UNION ALL SELECT 'public_notices', COUNT(*) FROM public_notices
UNION ALL SELECT 'activities', COUNT(*) FROM activities
UNION ALL SELECT 'audit_logs', COUNT(*) FROM audit_logs;
