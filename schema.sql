create database chaman;
use chaman;

CREATE TABLE IF NOT EXISTS User (
    username INT AUTO_INCREMENT PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    type VARCHAR(255),
    isAdmin TINYINT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS Hostel (
     hostel_id INT AUTO_INCREMENT PRIMARY KEY,
     hostel_name VARCHAR(255),
     hostel_address VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Hostel_registration (
    hostel_registration_id INT AUTO_INCREMENT PRIMARY KEY,
    hostel_id INT,
    session INT,
    hostel_warden_id INT,
    FOREIGN KEY (hostel_id) REFERENCES Hostel(hostel_id) ON DELETE CASCADE ,
    FOREIGN KEY (hostel_warden_id) REFERENCES User(username) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS HostelFacilities (
    facility_id INT AUTO_INCREMENT PRIMARY KEY,
    hostel_registration_id INT,
    Description VARCHAR(255),
    Condition_status INT,
    FOREIGN KEY (hostel_registration_id) REFERENCES Hostel_registration(hostel_registration_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Room (
    hostel_registration_id INT NOT NULL,
    room_no INT NOT NULL,
    PRIMARY KEY (hostel_registration_id, room_no),
    FOREIGN KEY (hostel_registration_id) REFERENCES Hostel_registration(hostel_registration_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Student (
    Roll INT AUTO_INCREMENT PRIMARY KEY,
    hostel_registration_id INT,
    Room_no INT,
    name VARCHAR(255),
    email VARCHAR(255),
    phone INT,
    branch VARCHAR(255),
    balance INT,
    Dob INT,
    FOREIGN KEY (Roll) REFERENCES User(username) ON DELETE CASCADE,
    FOREIGN KEY (Room_no) REFERENCES Room(room_no) ON DELETE CASCADE,
    FOREIGN KEY (hostel_registration_id) REFERENCES Hostel_registration(hostel_registration_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Complaints (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    Roll INT,
    Description VARCHAR(255),
    TimeStamp TIMESTAMP,
    Status VARCHAR(255),
    FOREIGN KEY (Roll) REFERENCES Student(Roll) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Notice (
    notice_id INT AUTO_INCREMENT PRIMARY KEY,
    hostel_registration_id INT,
    Description VARCHAR(255),
    date DATETIME,
    FOREIGN KEY (hostel_registration_id) REFERENCES Hostel_registration(hostel_registration_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name CHAR(255),
    employee_type VARCHAR(255),
    hostel_registration_id INT,
    FOREIGN KEY (employee_id) REFERENCES User(username) ON DELETE CASCADE,
    FOREIGN KEY (hostel_registration_id) REFERENCES Hostel_registration(hostel_registration_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Mess (
    entry_no INT AUTO_INCREMENT PRIMARY KEY,
    Roll INT,
    Date DATETIME,
    Slot INT,
    Cost INT,
    FOREIGN KEY (Roll) REFERENCES Student(Roll) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Transaction (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    Roll INT,
    amount INT,
    date DATETIME,
    type VARCHAR(255),
    FOREIGN KEY (Roll) REFERENCES Student(Roll) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Visitor (
    visitor_id INT AUTO_INCREMENT PRIMARY KEY,
    hostel_registration_id INT,
    visitor_name VARCHAR(255),
    visitor_purpose VARCHAR(255),
    entry_time INT,
    exit_time INT,
    FOREIGN KEY (hostel_registration_id) REFERENCES Hostel_registration(hostel_registration_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS EmployeeContactData (
    EmpID INT,
    MobileNumber INT,
    PRIMARY KEY (EmpID, MobileNumber),
    FOREIGN KEY (EmpID) REFERENCES Employee(employee_id)
);

CREATE TABLE IF NOT EXISTS EmployeeTypeSalary (
    EmployeeType VARCHAR(255) PRIMARY KEY,
    Salary INT,
    FOREIGN KEY (EmployeeType) REFERENCES Employee(employee_type) ON DELETE SET NULL
);