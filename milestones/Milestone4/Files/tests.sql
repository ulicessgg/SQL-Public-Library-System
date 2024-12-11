USE LibraryDB;

SHOW procedure status WHERE Db = 'LibraryDb';

Call ReportDelinquents();

Call CreateNewUser('uggs@gmail.com', 'Ulic', '', 'Gonzlo', 1, '2024-10-09');



Call ShelfCheck();