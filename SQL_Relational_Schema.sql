CREATE DATABASE VehicleWorkshop;
USE VehicleWorkshop;

CREATE TABLE Client (
	ClientID INT AUTO_INCREMENT PRIMARY KEY,
	Fname VARCHAR(20) NOT NULL,
	Mname VARCHAR(20),
	Lname VARCHAR(20),
	CPF CHAR(11),
    CNPJ CHAR(15),
    Contact CHAR(11) NOT NULL,
	Address VARCHAR(255),
    Email VARCHAR(50),
	CONSTRAINT unique_cpf_client UNIQUE (CPF),
    CONSTRAINT unique_cnpj_client UNIQUE (CNPJ),
    CHECK ((CNPJ is not null and CPF is null) or (CPF is not null and CNPJ is null))
);

CREATE TABLE Vehicle (
	LicensePlate CHAR(7) PRIMARY KEY NOT NULL,
    VehicleID INT,
	TypeVehicle ENUM('Car','Motorcycle','Van','Bus','Truck'),
    Manufacturer varchar(20),
	Model VARCHAR(20),
    Color VARCHAR(20),
	Year INT,
	CONSTRAINT unique_licenseplate_vehicle UNIQUE (LicensePlate),
    CONSTRAINT fk_vehicle_client FOREIGN KEY (VehicleID) REFERENCES Client(ClientID)
);

CREATE TABLE Employee (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(20) NOT NULL,
	Mname VARCHAR(20),
	Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Contact CHAR(11) NOT NULL,
	Address VARCHAR(255),
    Email VARCHAR(50),
    Position VARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
	CONSTRAINT unique_cpf_employee UNIQUE (CPF)
);

CREATE TABLE MechanicSpecialtie (
    SpecialtyID INT AUTO_INCREMENT PRIMARY KEY,
    SpecialtyName VARCHAR(50)
);

CREATE TABLE EmployeeSpecialtie (
    EmployeeID INT,
    SpecialtyID INT,
    PRIMARY KEY (EmployeeID, SpecialtyID),
    CONSTRAINT fk_employeespecialtie_employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    CONSTRAINT fk_employeespecialtie_mechanicspecialtie FOREIGN KEY (SpecialtyID) REFERENCES MechanicSpecialtie(SpecialtyID)
);

CREATE TABLE Service (
  ServiceID INT AUTO_INCREMENT PRIMARY KEY,
  ServiceName VARCHAR(100) NOT NULL,
  Description VARCHAR(255),
  DaysEstimated INT
);

CREATE TABLE ServiceRecord (
  RecordID INT AUTO_INCREMENT PRIMARY KEY,
  ClientID INT,
  LicensePlate CHAR(7),
  ServiceID INT,
  EmployeeID INT,
  ServiceDate DATE,
  Cost DECIMAL(10, 2) NOT NULL,
  CONSTRAINT fk_servicerecord_client FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
  CONSTRAINT fk_servicerecord_vehicle FOREIGN KEY (LicensePlate) REFERENCES Vehicle(LicensePlate),
  CONSTRAINT fk_servicerecord_service FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID),
  CONSTRAINT fk_servicerecord_employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Payment (
	ClientID INT,
    PaymentID INT,
    TypePayment ENUM('Boleto','Cartão de crédito','Cartão de débito', 'PIX'),
    PRIMARY KEY (ClientID, PaymentID),
    CONSTRAINT fk_payment_client FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    CONSTRAINT fk_payment_service FOREIGN KEY (PaymentID) REFERENCES Service(ServiceID)
);

-- ----------------------------------------------------------------------------------------------------------------------------------------------
-- Data Insertion
INSERT INTO Client (Fname, Mname, Lname, CPF, CNPJ, Contact, Address, Email) values 
	('John', 'Kennedy', 'Doe', '12345678901', NULL, '19912345678', '321 Main Street, Boulevard - New York', 'john.doe@example.com'),
	('Mark', 'Allan', 'Hoppus', '78945612300', NULL, '21978945612', '144 Elm Street, Downtown - Chicago ', 'mark.hoppus@example.com'),
	('Suzy', 'Qwi', 'Mueller', NULL, 456789123654987, '19945567889', '1002 Highland Street, Suburbia - Pasadena', NULL),
	('Thomas', 'Matthew', 'DeLonge', '18218218200', NULL, '11928128128', '182 Punk Street, Residential - Chicago','tom.delonge@example.com');

INSERT INTO Vehicle (LicensePlate, VehicleID, TypeVehicle, Manufacturer, Model, Color, Year) values
	('ABC1234', 1, 'Car', 'Toyota', 'Camry', 'Silver', 2022),
    ('DEF5678', 2, 'Truck', 'Ford', 'F-150', 'Blue', 2021),
    ('GHI9111', 1, 'Motorcycle', 'Honda', 'CBR600RR', 'Red', 2020),
    ('JKL1M12', 2, 'Bus', 'Mercedes-Benz', 'Sprinter', 'Yellow', 2022),
    ('NOP3Q45', 3, 'Car', 'Nissan', 'Altima', 'White', 2022),
    ('RST6U78', 4, 'Truck', 'Ram', '1500', 'Gray', 2021),
    ('VWX8521', 3, 'Motorcycle', 'Kawasaki', 'Ninja 400', 'Green', 2020),
    ('YZA4172', 1, 'Van', 'Ford', 'Transit', 'White', 2023),
    ('UWU1888', 4, 'Bus', 'Volvo', '9700', 'Blue', 2021);

INSERT INTO Employee (Fname, Mname, Lname, CPF, Contact, Address, Email, Position, Salary) values
	('Mila', 'Kutcher', 'Kunis', '23456789012', '21917624382', '9521 Lomwood Street, Center - Chicago', 'jane.johnson@example.com', 'Manager', 5000.00),
	('Thomas', 'Matthew', 'DeLonge', '18218218200', '11928128128', '182 Punk Street, Residential - Chicago','tom.delonge@example.com','Mechanic', 3000.00),
	('Michael', 'Miguel', 'Myers', '34567890123', '21971829328', '71 Oak Avenue, Boulevard - Chicago', 'michael.myers@example.com', 'Technician', 2200.00),
    ('John', 'Stark', 'Snow', '95175382460', '21924461792', '941 Snow Avenue, Center - Chicago', 'john.snow@example.com', 'Receptionist', 2000.00),
    ('David', 'Key', 'Jones', '56789012345', '21955178443', '274 Punk Street, Residential - Chicago', 'david.jones@example.com', 'Mechanic', 3000.00),
	('Leonardo', 'Da', 'Vinci', '33344455566', '21977114646', '64 Classic Street, Riverside Park - Chicago', NULL, 'Mechanic', 3500.00),
    ('Rembrandt', 'Van', 'Rijn', '88899911122', '21916162440', '1606 Green Avenue, Pinecrest Meadows - Chicago', NULL, 'Mechanic', 2500.00),
    ('Giorno', 'Joestar', 'Giovanna', '55577722200', '21955419755', '555 Golden Avenue, Sunnydale Heights - Chicago', 'giorno.giovanna@example.com', 'Mechanic', 3000.00);

INSERT INTO MechanicSpecialtie (SpecialtyName) values
	('Engine Repair'),
    ('Brake System'),
    ('Electrical Systems'),
    ('Suspension and Steering'),
    ('Transmission');

INSERT INTO EmployeeSpecialtie (EmployeeID, SpecialtyID) values
	(2, 1),
    (5, 4),
    (6, 2),
    (7, 3),
    (8, 5);

INSERT INTO Service (ServiceName, Description, DaysEstimated) values
	('Oil Change', 'Replace engine oil and oil filter', 1),
    ('Brake Inspection', 'Replace brake pads', 2),
    ('Tire Rotation', 'Rotate and balance tires', 1),
    ('Scratch Repair Service', 'Body panel replacement and paint over minor details', 7);

INSERT INTO ServiceRecord (ClientID, LicensePlate, ServiceID, EmployeeID, ServiceDate, Cost) values
	(1, 'ABC1234', 1, 2, '2023-08-18', 149.99),
    (2, 'DEF5678', 2, 6, '2023-08-19', 3199.99),
    (1, 'GHI9111', 3, 5, '2023-08-19', 299.99),
    (2, 'JKL1M12', 3, 5, '2023-08-20', 2499.99),
    (3, 'NOP3Q45', 4, 8, '2023-08-20', 2099.99),
    (4, 'RST6U78', 3, 5, '2023-08-21', 1699.99),
    (3, 'VWX8521', 1, 2, '2023-08-21', 89.99),
    (1, 'YZA4172', 4, 7, '2023-08-21', 1999.99),
    (4, 'UWU1888', 1, 2, '2023-08-22', 219.99);
    
INSERT INTO Payment (ClientID, PaymentID, TypePayment) values
	(1, 1, 'Boleto'),
    (2, 2, 'PIX'),
    (1, 3, 'Cartão de débito'),
	(2, 3, 'Cartão de crédito'),
    (3, 4, 'Cartão de crédito'),
    (4, 3, 'PIX'),
    (3, 1, 'Cartão de débito'),
    (1, 4, 'Cartão de crédito'),
    (4, 1, 'Boleto');
    
-- ----------------------------------------------------------------------------------------------------------------------------------------------
-- Queries

-- Show all clients information
SELECT * FROM Client;

-- Show all employees whose name starts with an 'M'
SELECT * FROM EMPLOYEE WHERE Fname like 'M%';

-- Show all employees whose salary ranges between 2500 and 3000
SELECT * FROM EMPLOYEE WHERE Salary BETWEEN 2500 AND 3000;

-- Calculate total income for all services provided
SELECT SUM(Cost) AS TotalIncome FROM ServiceRecord;

-- Show how much each client has spent at the workshop
SELECT CONCAT(Fname, ' ', Mname, ' ', Lname) AS CompleteName, SUM(sr.Cost) AS TotalSpent
FROM Client c
INNER JOIN ServiceRecord sr ON c.ClientID = sr.ClientID
GROUP BY CompleteName
ORDER BY TotalSpent DESC;

-- Show clients who are also employees
SELECT CONCAT(c.Fname, ' ', c.Mname, ' ', c.Lname) AS CompleteName, c.CPF, c.Contact
FROM Client c, Employee e 
WHERE c.CPF = e.CPF
ORDER BY CompleteName;

-- Show clients and their vehicles
SELECT CONCAT(c.Fname, ' ', c.Mname, ' ', c.Lname) AS CompleteName, v.LicensePlate
FROM Client c
LEFT OUTER JOIN Vehicle v ON c.ClientID = v.VehicleID;

-- Show how many vehicles each client has registered
SELECT CONCAT(c.Fname, ' ', c.Mname, ' ', c.Lname) AS CompleteName, COUNT(v.LicensePlate) AS RegisteredVehicles
FROM Client c
LEFT OUTER JOIN Vehicle v ON c.ClientID = v.VehicleID
GROUP BY CompleteName
ORDER BY CompleteName;

-- Show the number of vehicles by type
SELECT TypeVehicle, COUNT(*) AS NumberOfVehicles
FROM Vehicle
GROUP BY TypeVehicle
ORDER BY NumberOfVehicles DESC;

-- Show Top 3 clients who have spent the most
SELECT CONCAT(c.Fname, ' ', c.Mname, ' ', c.Lname) AS CompleteName, SUM(sr.Cost) AS TotalSpent
FROM Client c
LEFT OUTER JOIN ServiceRecord sr ON c.ClientID = sr.ClientID
GROUP BY c.ClientID
ORDER BY TotalSpent DESC
LIMIT 3;

-- Show all mechanics and their specialties
SELECT CONCAT(e.Fname, ' ', e.Mname, ' ', e.Lname) AS CompleteName, GROUP_CONCAT(ms.SpecialtyName) AS Specialties
FROM Employee e
JOIN EmployeeSpecialtie es ON e.EmployeeID = es.EmployeeID
JOIN MechanicSpecialtie ms ON es.SpecialtyID = ms.SpecialtyID
WHERE e.Position = 'Mechanic'
GROUP BY e.EmployeeID
ORDER BY CompleteName;

-- Show all the clients who have paid using PIX
SELECT CONCAT(c.Fname, ' ', c.Mname, ' ', c.Lname) AS CompleteName
FROM Client c
JOIN Payment p ON c.ClientID = p.ClientID
WHERE p.TypePayment = 'PIX';

-- Show the services which were performed more than 2 times, along with the count number
SELECT s.ServiceName, COUNT(*) AS ServiceCount
FROM ServiceRecord sr
JOIN Service s ON sr.ServiceID = s.ServiceID
GROUP BY s.ServiceName
HAVING ServiceCount > 2
ORDER BY ServiceCount DESC, ServiceName;

-- Show the average cost of services for each client, including only clients who have spent on average more than 1000.00
SELECT CONCAT(c.Fname, ' ', c.Mname, ' ', c.Lname) AS CompleteName, AVG(sr.Cost) AS AvgCost
FROM ServiceRecord sr
JOIN Client c ON sr.ClientID = c.ClientID
GROUP BY sr.ClientID
HAVING AvgCost > 1000
ORDER BY AvgCost DESC, CompleteName;

-- Show employees, their position, salary and bonus
SELECT CONCAT(Fname, ' ', Mname, ' ', Lname) AS CompleteName, Position, Salary, Salary * 0.1 as Bonus
FROM Employee
ORDER BY CompleteName;

-- Show combination of data of tables Employee, MechanicSpecialtie and EmployeeSpecialtie
SELECT * FROM Employee CROSS JOIN MechanicSpecialtie CROSS JOIN EmployeeSpecialtie;
