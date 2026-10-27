CREATE DATABASE LibraryDB;


USE LibraryDB;


-- =========================
-- 1. Employee
-- =========================
CREATE TABLE Employee
(
    Emp_ID INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    Email VARCHAR(100),
    Salary DECIMAL(10,2),
    DateOfBirth DATE,
    Bonus DECIMAL(10,2),
    [Address] VARCHAR(200),
    Phone VARCHAR(20),
	Hiring_Date DATE,
    Supervisor_ID INT,
    Floor_No INT
);


-- =========================
-- 2. Floor
-- =========================
CREATE TABLE [Floor]
(
    Floor_No INT PRIMARY KEY,
    Number_Of_Blocks INT
);


-- =========================
-- 3. Employee works on Floor
-- =========================
ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Floor
FOREIGN KEY (Floor_No)
REFERENCES Floor(Floor_No);


-- =========================
-- 4. Employee supervises Employee
-- =========================
ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Supervisor
FOREIGN KEY (Supervisor_ID)
REFERENCES Employee(Emp_ID);



-- =========================
-- 5. User
-- =========================
CREATE TABLE Library_User
(
    SSN VARCHAR(20) PRIMARY KEY,
    [Name] VARCHAR(50),
    Email VARCHAR(100),
    Recorded_By INT NOT NULL,

    FOREIGN KEY (Recorded_By)
        REFERENCES Employee(Emp_ID)
);

-- =========================
-- 6. User Phones
--    Phones is Multivalued Attribute
-- =========================
CREATE TABLE User_Phone
(
    SSN VARCHAR(20),
    Phone VARCHAR(20),

    PRIMARY KEY (SSN, Phone),

    FOREIGN KEY (SSN)
        REFERENCES Library_User(SSN)
);


-- =========================
-- 7. Book
-- =========================
CREATE TABLE Book
(
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(200),

    Publisher_ID INT NOT NULL,
    Category_ID INT NOT NULL,
    Shelf_Code VARCHAR(20) NOT NULL
);


-- =========================
-- 8. Author
-- =========================
CREATE TABLE Author
(
    Author_ID INT PRIMARY KEY,
    [Name] VARCHAR(100)
);


-- =========================
-- 9. Publisher
-- =========================
CREATE TABLE Publisher
(
    Publisher_ID INT PRIMARY KEY,
    [Name] VARCHAR(100)
);


-- =========================
-- 10. Category
-- =========================
CREATE TABLE Category
(
    Category_ID INT PRIMARY KEY,
    Cat_Name VARCHAR(100)
);


-- =========================
-- 11. Shelf
-- =========================
CREATE TABLE Shelf
(
    Code VARCHAR(20) PRIMARY KEY,
    Floor_No INT NOT NULL,

    FOREIGN KEY (Floor_No)
        REFERENCES Floor(Floor_No)
);


-- =========================
-- 12.Add Book Foreign Keys
-- =========================

ALTER TABLE Book
ADD CONSTRAINT FK_Book_Publisher
FOREIGN KEY (Publisher_ID)
REFERENCES Publisher(Publisher_ID);


ALTER TABLE Book
ADD CONSTRAINT FK_Book_Category
FOREIGN KEY (Category_ID)
REFERENCES Category(Category_ID);


ALTER TABLE Book
ADD CONSTRAINT FK_Book_Shelf
FOREIGN KEY (Shelf_Code)
REFERENCES Shelf(Code);


-- =========================
-- 13. Book - Author
--    M:N Relationship
-- =========================
CREATE TABLE Book_Author
(
    Book_ID INT,
    Author_ID INT,

    PRIMARY KEY (Book_ID, Author_ID),

    FOREIGN KEY (Book_ID)
        REFERENCES Book(Book_ID),

    FOREIGN KEY (Author_ID)
        REFERENCES Author(Author_ID)
);


-- =========================
-- 14. Borrows
--    User - Book - Employee
-- =========================
CREATE TABLE Borrows
(
    SSN VARCHAR(20),
    Book_ID INT,
    Emp_ID INT,
	Date_Borrowed DATE,
    Due_Date DATE,
    Amount_Paid DECIMAL(10,2),

    PRIMARY KEY (SSN, Book_ID, Date_Borrowed),

    FOREIGN KEY (SSN)
        REFERENCES Library_User(SSN),

    FOREIGN KEY (Book_ID)
        REFERENCES Book(Book_ID),

    FOREIGN KEY (Emp_ID)
        REFERENCES Employee(Emp_ID)
);

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------


INSERT INTO Floor (Floor_No, Number_Of_Blocks)
VALUES
(1, 10),
(2, 8),
(3, 6),
(4, 5),
(5, 7),
(6, 9);


INSERT INTO Employee
(Emp_ID, FName, LName, Email, Salary, DateOfBirth, Bonus, [Address], Phone, Hiring_Date, Supervisor_ID, Floor_No)
VALUES
(1, 'Omar', 'Amr', 'omar@gmail.com', 8000, '1995-05-10', 1000, 'Cairo', '01011111111', '2022-03-15', NULL, 1),

(2, 'Ali', 'Mohamed', 'ali@gmail.com', 5000, '1998-08-20', 700, 'Alex', '01022222222', '2022-04-10', 1, 1),

(3, 'Mona', 'Ahmed', NULL, 4500, '1999-01-12', 500, 'Cairo', '01033333333', '2022-05-20', 1, 2),

(4, 'Ahmed', 'Hassan', 'ahmed@gmail.com', NULL, '2000-03-25', 900, 'Alex', '01044444444', '2022-06-05', 1, 2),

(5, 'Sara', 'Ali', NULL, 4000, '1997-11-30', 600, NULL, '01055555555', '2023-01-10', 2, 3),

(6, 'Mohamed', 'Samir', 'mohamed@gmail.com', 5500, '1996-07-15', 800, 'Cairo', '01066666666', '2022-04-25', 2, 3);


INSERT INTO Library_User
(SSN, [Name], Email, Recorded_By)
VALUES
('101', 'Ahmed Ali', 'ahmed@yahoo.com', 1),
('102', 'Sara', 'sara1@yahoo.com', 2),
('103', 'Maha', 'maha@yahoo.com', 3),
('104', 'Sara', 'sara2@yahoo.com', 2),
('105', 'Omar', 'omar@yahoo.com', 5);


INSERT INTO User_Phone (SSN, Phone)
VALUES
('101', '01111111111'),
('101', '01211111111'),
('102', '01122222222'),
('103', '01133333333'),
('104', '01144444444'),
('105', '01155555555');


INSERT INTO Publisher (Publisher_ID, [Name])
VALUES
(1, 'HarperCollins'),
(2, 'Penguin'),
(3, 'OReilly');



INSERT INTO Category (Category_ID, Cat_Name)
VALUES
(1, 'Programming'),
(2, 'Database'),
(3, 'Fiction');


INSERT INTO Author (Author_ID, [Name])
VALUES
(1, 'Robert Martin'),
(2, 'John Smith'),
(3, 'Ahmed Hassan'),
(4, 'Paulo Coelho');


INSERT INTO Shelf (Code, Floor_No)
VALUES
('A1', 1),
('B1', 1),
('A2', 2),
('B2', 3);


INSERT INTO Book
(Book_ID, Title, Publisher_ID, Category_ID, Shelf_Code)
VALUES
(1, 'C Programming Basics', 1, 1, 'A1'),
(2, 'SQL Fundamentals', 3, 1, 'A1'),
(3, 'Database Systems', 1, 2, 'B1'),
(4, 'Clean Code', 1, 1, 'A2'),
(5, 'The Alchemist', 2, 3, 'B2'),
(6, 'Algorithms', 3, 1, 'A2'),
(7, 'Data Structures', 1, 2, 'B2');


INSERT INTO Book_Author (Book_ID, Author_ID)
VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 3),
(4, 1),
(4, 2),
(5, 4),
(6, 1),
(7, 3);


INSERT INTO Borrows
(SSN, Book_ID, Emp_ID, Date_Borrowed, Due_Date, Amount_Paid)
VALUES
('101', 1, 2, '2022-02-15', '2022-03-15', 50),

('101', 2, 2, '2022-03-10', '2022-04-10', 40),

('101', 3, 3, '2022-04-05', '2022-05-05', 70),

('101', 5, 3, '2022-06-01', '2022-06-20', 20),

('102', 4, 4, '2022-05-01', '2022-06-01', 30),

('102', 6, 4, '2022-07-15', '2022-08-15', 25),

('103', 5, 5, '2022-08-01', '2022-08-20', 15),

('104', 7, 6, '2022-09-01', '2022-09-20', 35);


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--Q.1

select CONCAT( FName,' ',LName)
from Employee
where len(FName) > 3;

--=====================================
--Q.2

select COUNT(b.Book_ID) as NO_OF_PROGRAMMING_BOOKS
from Book b inner join Category c -- join is more better than subquery
on b.Category_ID=c.Category_ID 
and c.Cat_Name='Programming';  -- and is more better than where


--=====================================
--Q.3

select COUNT(b.Book_ID) as NO_OF_BOOKS
from Book b inner join Publisher p -- join is more better than subquery
on b.Publisher_ID=p.Publisher_ID
and p.[Name]='HarperCollins';  -- and is more better than where

--=====================================
--Q.4

select lu.SSN,lu.[Name],br.Date_Borrowed
from Library_User lu inner join Borrows br -- join is more better than subquery
on br.SSN=lu.SSN 
and br.Due_Date < '2022-07-01'; -- and is more better than where

--=====================================
--Q.5

select concat(b.Title,' is written by ',a.[Name]) as [Book Title]
from Book_Author ba 
inner join Author a on ba.Author_ID=a.Author_ID
inner join Book b on ba.Book_ID=b.Book_ID;

--=====================================
--Q.6

select [Name]
from Library_User
where [Name] like '%a%';

--=====================================
--Q.7

select top(1) ssn -- if you want the name we wiil use inner join
from  Borrows 
group by SSN
order by count(SSN) DESC;

--=====================================
--Q.8

select SSN,sum(Amount_Paid) as [total Amount Paid]
from  Borrows 
group by SSN;  -- if you want the name we wiil use inner join

--=====================================
--Q.9

select top(1) c.Cat_Name
from  Book b 
inner join Category c on b.Category_ID=c.Category_ID
inner join Borrows bo on b.Book_ID=bo.Book_ID
group by  c.Cat_Name
order by min(bo.Amount_Paid);

--=====================================
--Q.10

select isnull(Email,isnull([address],DateOfBirth))
from Employee;

--=====================================
--Q.11

select concat(c.Cat_Name ,' : ',count(b.Category_ID)) [Count Of Books]
from  Book b 
inner join Category c on b.Category_ID=c.Category_ID
group by  c.Cat_Name;

--=====================================
--Q.12

select b.Book_ID
from Shelf s 
inner join Book b on s.Code=b.Shelf_Code 
inner join [Floor] f on s.Floor_No=f.Floor_No 
WHERE NOT (f.Floor_No = 1 AND s.Code = 'A1');

--=====================================
--Q.13

select f.Floor_No,f.Number_Of_Blocks,count(e.Floor_No) [number_of_employees]
from [Floor] f inner join Employee e
on f.Floor_No=e.Floor_No
group by f.Floor_No,f.Number_Of_Blocks ;

--=====================================
--Q.14

select b.Title,lu.[Name]
from  Borrows bo
inner join  Book b  on b.Book_ID=bo.Book_ID 
and( bo.Date_Borrowed between '3/1/2022' and '10/1/2022')
inner join Library_User lu on lu.SSN =bo.SSN ;

--=====================================
--Q.15

select e.FName,e.LName,s.FName  [Supervisor_FName] ,s.LName  [Supervisor_LName]
from Employee e inner join Employee s
on e.Emp_ID=s.Supervisor_ID;

--=====================================
--Q.16

select FName,LName,isnull(salary,Bonus)
from Employee ;

--=====================================
--Q.17

select max(salary) max_Salary,min(salary) min_Salary
from Employee ; -- if you want the name we wiil use group by

--=====================================
--Q.18

CREATE FUNCTION [display_num_state] (@number INT)
RETURNS VARCHAR(10)
AS
BEGIN
    IF (@number % 2 = 0)
        RETURN 'Even';
    
    RETURN 'Odd';
END;

select dbo.display_num_state(1);

--=======================================
--Q.19

CREATE FUNCTION [display_Tittle_of_books] (@category VARCHAR(20))
RETURNS table
AS
RETURN(
    select b.Title
    from Book b
    inner join Category c on c.Category_ID=b.Category_ID
    and c.Cat_Name=@category
	);


select * from  dbo.display_Tittle_of_books('Programming');
--=====================================
--Q.20

CREATE FUNCTION [display_MultiTable] (@phone VARCHAR(20))
RETURNS table
AS
RETURN(
    select b.Title,lu.[Name],bo.Amount_Paid,bo.Due_Date
    from Borrows bo 
	inner join Book b on bo.Book_ID=b.Book_ID 
	inner join Library_User lu on lu.SSN=bo.SSN 
	inner join User_Phone up on up.SSN=lu.SSN and up.Phone=@phone
	);

select * from  dbo.display_MultiTable('01111111111');

--=====================================
--Q.21

CREATE FUNCTION [check_duplicated] (@user_name VARCHAR(20))
RETURNS VARCHAR(50)
AS
BEGIN
declare @num int = (select count ([Name])from Library_User where [Name]=@user_name)

    IF ( @num > 1)

          RETURN concat(@user_name,' is Repeated ', @num,' times') ;
    IF (@num = 1)
		 RETURN concat(@user_name,' is not duplicated')

    RETURN concat(@user_name,' is Not Found');
END;

select dbo.check_duplicated('Rana');

--=====================================
--Q.22

CREATE FUNCTION [display_Format_Date] (@date_valu DATE)
RETURNS VARCHAR(20)
AS
BEGIN
    RETURN FORMAT(@date_valu, 'dd/MM/yyyy');
END;

select dbo.display_Format_Date(getdate());

--=====================================
--Q.23

create procedure number_of_books_per_Category 
as
select c.Cat_Name ,count(b.Category_ID) 
from  Book b 
inner join Category c on b.Category_ID=c.Category_ID
group by  c.Cat_Name;

exec number_of_books_per_Category ;

--=====================================
--Q.24

create procedure old_manager (@old_Emp_id int,@new_Emp_id int,@floor_number int) -- chat helped  me in this question
as
UPDATE Employee
    SET Floor_No = NULL
    WHERE Emp_ID = @old_Emp_id
      AND Floor_No = @floor_number;

    UPDATE Employee
    SET Floor_No = @floor_number
    WHERE Emp_ID = @new_Emp_id;

EXEC old_manager 1, 5, 6;
--=====================================
--Q.25

create view vw_V1_AlexAndCairoEmp
as 
select *
from Employee
where [Address] in('Alex' , 'Cairo');

select * from vw_V1_AlexAndCairoEmp;
--=====================================
--Q.26

create view vw_V2_numberofbookspershelf
as 
select Shelf_Code ,count(Book_ID) numberofbooks
from Book  
group by Shelf_Code ;


SELECT *
FROM vw_V2_numberofbookspershelf;

--=====================================
--Q.27

create view vw_V3_maxnumberofbookspershelf
as 
SELECT top(1)Shelf_Code ,numberofbooks
FROM vw_V2_numberofbookspershelf 
order by numberofbooks DESC;

SELECT *
FROM vw_V3_maxnumberofbookspershelf;

--=====================================
--Q.28

CREATE TABLE ReturnedBooks
(
    UserSSN VARCHAR(20),
    bookid INT,
    DueDate DATE,
    ReturnDate DATE,
    fees DECIMAL(10,2),
    PRIMARY KEY (UserSSN, bookid, DueDate)
);

create trigger tri_insteadofinserting       -- chat helped  me in this question
on ReturnedBooks 
instead of insert
as 
insert into ReturnedBooks
    (UserSSN, bookid, DueDate, ReturnDate, fees)
    SELECT
        i.UserSSN,
        i.bookid,
        i.DueDate,
        i.ReturnDate,
        CASE
            WHEN i.ReturnDate = i.DueDate
                THEN 0                     -- fee=0 Deliver it in time
            ELSE b.Amount_Paid * 0.20
        END
    FROM inserted i
    INNER JOIN Borrows b
        ON b.SSN = i.UserSSN
        AND b.Book_ID = i.bookid
        AND b.Due_Date = i.DueDate;

--=====================================
--Q.29 --didn't understand

UPDATE Floor
SET Number_Of_Blocks = 2
WHERE Floor_No = 6;

UPDATE Employee
SET Floor_No = 6
WHERE Emp_ID = 5;
--=====================================
--Q.30 -- The solution by chat there wasn't enough time to solve it

CREATE VIEW v_2006_check
AS
SELECT 
    e.Emp_ID AS Manager_ID,
    f.Floor_No,
    f.Number_Of_Blocks,
    e.Hiring_Date
FROM Employee e
INNER JOIN Floor f
    ON e.Floor_No = f.Floor_No
WHERE e.Hiring_Date BETWEEN '2022-03-01' AND '2022-05-31';

SELECT *
FROM v_2006_check;
--=====================================
--Q.31

CREATE TRIGGER tri_PreventEmployeeChanges
ON Employee
AFTER INSERT, UPDATE, DELETE
AS
    ROLLBACK TRANSACTION;

    PRINT 'You cannot take any action with Employee table';

--=====================================
--Q.32

INSERT INTO User_Phone (SSN, Phone)
VALUES ('50', '01000000000');

UPDATE Employee
SET Emp_ID = 21
WHERE Emp_ID = 20;

DELETE FROM Employee
WHERE Emp_ID = 1;

DELETE FROM Employee
WHERE Emp_ID = 12;

CREATE CLUSTERED INDEX IX_Employee_Salary
ON Employee(Salary);

--=====================================
--Q.33

-- It was cancelled.

