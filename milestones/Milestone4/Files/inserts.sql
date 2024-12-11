-- MySQL Script generated by Ulices Gonzalez
-- Thurs Nov 7 2024
-- Last edited Dec 6 2024

USE `librarydb`;

-- -----------------------------------------------------
-- Insertion of addresses in order to enable creation of
-- patrons, libraries, and library branches 
-- -----------------------------------------------------

INSERT INTO Addresses (street_number, street_name, city, state, zipcode) VALUES 
(777, 'Arnold Dr', 'Martinez', 'CA', 94553), -- generic address for contra costa library
(4191, 'Appian Wy', 'El Sobrante', 'CA', 94803), -- for library 1
(2935, 'Pinole Valley Rd', 'Pinole', 'CA', 94564), -- for library 2
(13751, 'San Pablo Ave', 'San Pablo', 'CA', 94806), -- for library 3
(2601, 'May Rd', 'Richmond', 'CA', 94803), -- for institution 1
(1121, 'Allview Ave', 'El Sobrante', 'CA' ,94803), -- for institution 2
(5000, 'Valley View Rd', 'Richmond', 'CA', 94803), -- for institution 3
(4740, 'Appian Way', 'El Sobrante', 'CA', 94803), -- for apartments 1-3
(535, 'Appian Way', 'El Sobrante', 'CA', 94803), -- for po boxes 1-3
(325, 'Civic Center Plz', 'Richmond', 'CA', 94804), -- generic address for richmond library
(1247, 'Marin Ave', 'Albany', 'CA', 94706); -- generic address for albany library

-- -----------------------------------------------------
-- Creation of Main County Libraries 
-- -----------------------------------------------------

INSERT INTO `Public Libraries` (county_name, address) VALUES
('Contra Costa', 1),
('City of Richmond', 10),
('Albany', 11);

-- -----------------------------------------------------
-- Creation of Library Branches under a given County
-- in this case Contra Costa
-- -----------------------------------------------------

INSERT INTO `Library Branches` (is_virtual, libraryID, address) VALUES
(0, 1, 2),
(0, 1, 3),
(0, 1, 4);

-- -----------------------------------------------------
-- Specification of existing addresses for use to insert
-- in library records 
-- -----------------------------------------------------

INSERT INTO Libraries (biblioAddressID, county_region, branch) VALUES 
(2, 'West', '1'),
(3, 'West', '2'),
(4, 'West', '3');

-- -----------------------------------------------------
-- Specification of existing addresses for use to insert
-- in creating instituion records 
-- -----------------------------------------------------

INSERT INTO Institutions (instAddressID, school_district, school_name) VALUES 
(5, 'WCCUSD', 'Sheldon Elementary School'),
(6, 'WCCUSD', 'Betty Reid Soskin Middle School'),
(7, 'WCCUSD', 'De Anza High School');

-- -----------------------------------------------------
-- Specification of existing addresses for use to insert
-- patrons and staff through the use of apartments and
-- po boxes
-- -----------------------------------------------------

INSERT INTO Apartments (aptAddressID, building_number, apartment_number) VALUES 
(8, 3, 1),
(8, 1, 2),
(8, 2, 3);

INSERT INTO `P.O. Boxes` (poAddressID, po_box_number, service_name) VALUES 
(9, 31, 'USPS'),
(9, 12, 'USPS'),
(9, 23, 'USPS');

-- -----------------------------------------------------
-- Creation of patron accounts for library use
-- -----------------------------------------------------

INSERT INTO Patrons (email, first_name, middle_name, last_name, is_delinquent) VALUES
('uli@gmail.com', 'Uli', '', 'Guerrero', 0),
('ussgg@gmail.com', 'Sergio', 'Ulices', 'Gonzalez', 0),
('ulicessgg@gmail.com', 'Ulices', '', 'Gonzalez', 0),
('sgonz@gmail.com', 'Sergio', '', 'Gonzalez', 0),
('gonzgue@gmail.com', 'Ulices', '', 'Guerrero', 0),
('ugonz@gmail.com', 'Uli', '', 'Gonzalez', 0),
('sug@sfsu.edu', 'Serg', 'Ulyces', 'Guerrero', 0),
('ug01@sfsu.edu', 'Ulyces', '', 'Gonzal', 0),
('sg109@sfsu.edu', 'Sergio', '', 'Gonzal', 0),
('ug@cclib.gov', 'Ulysses', '', 'Gonz', 0),
('sg@cclib.gov', 'Serg', '', 'Guerr', 0),
('usg@cclib.gov', 'Uly', 'Ser', 'Gon', 0);

INSERT INTO `E-Cards` (libraryCardNo, date_of_birth) VALUES
(1, '2001-10-09'),
(2, '2009-01-10'),
(3, '2010-09-01');

INSERT INTO `Full-Service Cards` (libraryCardNo, date_of_birth, phone_number, address) VALUES
(4, '2001-10-09', 1234567890, 8),
(5, '2009-01-10', 5678901234, 8),
(6, '2010-09-01', 8901234567, 8);

INSERT INTO `Child Cards` (parentCardNum, child_first_name, child_middle_name, child_last_name, date_of_birth) VALUES
(4, 'Jon', '', 'Gonzalez', '2001-01-01'),
(4, 'Isa', '', 'Gonzalez', '2004-04-04'),
(4, 'Uli', '', 'Gonzalez', '2010-10-10');

INSERT INTO `Institutional Cards` (libraryCardNo, phone_number, address) VALUES
(7, 1357924680, 5),
(8, 2468013579, 6),
(9, 9876543210, 7);

INSERT INTO `Staff Cards` (libraryCardNo, date_of_birth, phone_number, address) VALUES
(10, '2001-01-01', 1234567890, 8),
(11, '2004-04-04', 5678901234, 8),
(12, '2007-07-07', 8901234567, 9);

INSERT INTO Items (call_number, title, owningBranch) VALUES
('ESL 01', 'PC01', 1),
('ESL 02', 'P0C2', 1),
('ESL 03', 'PC03', 1),
('DVD Spider', 'Spider-Man 2', 1),
('DVD Spider', 'The Amazing Spider-Man', 2),
('DVD Spider', 'Spider-Man: No Way Home', 3),
('Fic Maguire, G', 'Wicked', 2),
('Fic Steinbeck, J', 'The Long Valley', 3),
('Fic Twain, M', 'The Stranger', 3),
('NonFic Musashi, M', 'The Book of Five Rings', 2),
('NonFic Issacson, W', 'Leonardo Da Vinci', 3),
('NonFic LEGO', 'LEGO Botanical Almanac', 2),
('Arc Bastin, D', 'History of El Sobrante', 1),
('Arc Bastin, D', 'History of San Pablo', 3),
('Arc Bastin, D', 'History of Pinole', 2),
('Kit Energy', 'Energy Measurement Kit', 1),
('Kit Storytime', 'Little Leaders Story Kit', 3),
('Kit Raspberry', 'Raspberry Pi Kit', 2),
('Per Thrasher', 'Thrasher', 1),
('Per Wired', 'Wired', 3),
('Per Times', 'The New York Times', 2),
('Pass Park', 'National Park Pass', 1),
('Pass Legion', 'Legion of Honor Entry Pass', 3),
('Pass Alcatraz', 'Alcatraz Tour Pass', 2),
('Dig Collins, S', 'Ballad of Songbirds & Snakes', 1),
('Dig Riordan, R', 'The Lightning Thief', 3),
('Dig Meyer, S', 'Midnight Sun', 2);

INSERT INTO Computers (itemRecNo, computer_number, is_express, is_laptop, area, descrption) VALUES
(1, 1, 0, 0, 'Adult', 'Dell Workstation'),
(2, 2, 0, 0, 'Adult', 'Dell Workstation'),
(3, 3, 0, 0, 'Adult', 'Dell Workstation');

INSERT INTO AV (itemRecNo, content_length, age_rating, item_count, description) VALUES
(4, '01:27:00', 'PG-13', 1, 'Sequel to Spider-Man'),
(5, '01:36:00', 'PG-13', 1, 'Begining of TASM Duology'),
(6, '01:49:00', 'PG-13', 1, 'Conclusion to The MCU Spider-Man Trilogy');

INSERT INTO Fiction(itemRecNo, genre, author_first_name, author_last_name, age_rating, description) VALUES
(7, 'Fantasy', 'Gregory', 'Maguire', '', 'Learn the story of Elphaba and Glinda set before The Wizard of Oz'),
(8, '', 'John', 'Steinbeck', '', 'Collection of Short Stories featuring The Long Valley'),
(9, '', 'Mark', 'Twain', '', 'A mysterious stranger appears, some describe them as a devil others as an angel');

INSERT INTO NonFiction (itemRecNo, deweydecimal, library_of_congress_classification, topic, author_first_name, author_last_name, age_rating) VALUES
(10, '355.55', '', '', 'Miyamoto', 'Musashi', ''),
(11, '759.9', '', '', 'Walter', 'Issacson', ''),
(12, '688.173', '', '', '', 'LEGO', '');

INSERT INTO Archival (itemRecNo, deweyDecimal, library_of_congress_classification, item_count, description) VALUES
(13, '979.4', '', 1, 'Local History of the Community of El Sobrante'),
(14, '979.4', '', 1, 'Local History of the Community of San Pablo'),
(15, '979.4', '', 1, 'Local History of the Community of Pinole');

INSERT INTO Kit (itemRecNo, age_rating, item_count, description) VALUES
(16, '', 4, 'Tools for Monitoring Energy Consumption'),
(17, '0 - 5', 7, 'Storytime Materials for Children to learn about Leadership'),
(18, '', 3, 'Raspberry Pi Kit with preinstalled emulators for Retro Gaming');

INSERT INTO Periodical (itemRecNo, publisher, age_rating, issue_date, volume, issue) VALUES
(19, 'Thrasher Magazine', '', '2018-02-04', 81, 9),
(20, 'Wired Magazine', '', '2015-03-14', 36, 6),
(21, 'The New York Times', '', '2020-05-04', 49, 7);

INSERT INTO Pass (itemRecNo, item_count, description) VALUES
(22, 1, 'Free Parking Pass for any National Park'),
(23, 1, 'Pass for a Tour of Alcatraz by Boat'),
(24, 1, 'Pass fpr Free Entry to The SF Legion of Honor');

INSERT INTO Digital (itemRecNo, content_length, description) VALUES
(25, '362 Pages', 'Prequel to The Hunger Games series'),
(26, '289 Pages', 'The Begining of Percy Jackson and the Olympians series'),
(27, '436 Pages', 'Learn about the events of Twilight from Edward Cullens Perspective');

INSERT INTO Transactions (patronCardNumber, transactionBranch, transactionItem) VALUES
(1, 3, 4),
(2, 3, 8),
(9, 1, 5),
(7, 1, 6),
(11, 3, 21),
(3, 1, 16),
(4, 2, 7),
(4, 2, 12),
(4, 2, 26),
(8, 2, 19),
(6, 3, 14),
(10, 1, 9);

INSERT INTO Payments (transRecNo, total_paid, total_owed, date_of_payment) VALUES
(1, '0.0', '327.96', '2024-12-4'),
(2, '64.37', '0.0', '2024-12-5'),
(3, '19.82', '73.03', '2024-12-6');

INSERT INTO Holds (transRecNo, owningBranch, holdingBranch) VALUES
(4, 1, 2),
(5, 2, 1),
(6, 3, 3);

INSERT INTO Checkouts (transRecNo, checkoutBranch, checkout_date) VALUES
(7, 2, '2024-10-21'),
(8, 1, '2024-11-09'),
(9, 3, '2024-12-07');

INSERT INTO Returns (transRecNo, returnBranch, return_date) VALUES
(10, 3, '2024-12-07'),
(11, 1, '2024-12-07'),
(12, 2, '2024-12-07');