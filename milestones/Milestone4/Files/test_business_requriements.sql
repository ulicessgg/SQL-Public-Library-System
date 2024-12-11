USE LibraryDB;

SHOW procedure status WHERE Db = 'LibraryDb';

Call ReportDelinquents();

 Call CreateNewPatron('uggs@gmail.com', 'Ulic', '', 'Gonzlo', '2024-10-09'); -- comment this out after to test upgrade patron account

 Call AddressVerifcation(1013, 'Rollingwood Dr', 'El Sobrante', 'California', 94804, 0, 0, 0, ''); -- comment this out after to test upgrade patron account

 Call UpgradePatronAccount(13, 1029384756, 1013, 'Rollingwood Dr', 'El Sobrante', 'California', 94804); --  comment this out to test create new patron and address verifcation

Call ShelfCheck();