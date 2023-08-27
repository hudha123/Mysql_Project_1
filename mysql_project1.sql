CREATE DATABASE Library;
use Library;

CREATE TABLE Books(
 ISBN VARCHAR(20) PRIMARY KEY,
 Book_title VARCHAR(200),
 Category VARCHAR(20),
 Rental_Price INT,
 Status ENUM('YES','NO'),
 Author VARCHAR(100),
 Publisher VARCHAR(100)
);    

CREATE TABLE Branch(
 Branch_no INT PRIMARY KEY,
 Manager_id INT,
 Branch_address VARCHAR(200),
 Contact_no BIGINT
);

CREATE TABLE Employee(
 Emp_id INT PRIMARY KEY,
 Emp_name VARCHAR(30),
 Position VARCHAR(30),
 Salary INT
);

CREATE TABLE Customer(
 Customer_id INT PRIMARY KEY,
 Customer_name VARCHAR(30),
 Customer_address VARCHAR(200),
 Reg_date DATE
);



CREATE TABLE IssueStatus(
 Issue_id INT PRIMARY KEY,
 Issued_cust INT,
 Issued_book_name VARCHAR(100),
 Issue_date DATE,
 Isbn_book VARCHAR(20),
 FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_id),
 FOREIGN KEY(Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus(
 Return_id INT PRIMARY KEY,
 Return_Cust INT,
 Return_book_name VARCHAR(100),
 Return_date DATE,
 Isbn_book2 VARCHAR(20),
 FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN),
 FOREIGN KEY (Return_Cust) REFERENCES Customer(Customer_id)
);

 
DESC Branch;
DESC Employee;
DESC Customer;
DESC IssueStatus;
DESC ReturnStatus;
DESC Books;


INSERT INTO Books VALUES
 ("978-93-96055-01","Learning Python", "Python",200,"NO","Mark Lutz","O'Reilly Media"),
 ("978-93-96055-02","Discovering Statistics Using R", "R", 190, "YES", "Andy Field", "SAGE Publications Ltd"),
 ("978-93-96055-03","Head-First Python", "Python",150, "YES", "Paul Barry", "O'Reilly Media"),
 ("978-93-96055-04","The Guns of August", "History", 190, "NO", "	Barbara W. Tuchman", "Random House Publishing Group"),
 ("978-93-96055-05","The Art of R Programming", "R", 120, "YES", "Norman Matloff", "No Starch Press"),
 ("978-93-96055-06","Effective Java", "Java", 180, "NO", "Joshua Bloch", "Addison Wesley"),
 ("978-93-96055-07","Python Distilled", "Python", 100, "NO", "David Beazley", "Pearson"),
 ("978-93-96055-08","Java: A Beginner’s Guide", "Java", 150, "YES", "Herbert Schildt", "McGraw-Hill Education"),
 ("978-93-96055-09","Learning SQL", "SQL", 155, "YES", "Alan Beaulieu", "O'Reilly Media"),
 ("978-93-96055-10","Expert C Programming", "C", 145, "YES", "APeter van der Linden", "Pearson");
 
 
   
INSERT INTO Branch VALUES
 (123,0111,"TIRUVANADAPURAM",9867546670), 
 (124,0112,"KOLLAM",7609812678),
 (125,0113,"CALICUT",8905643296),
 (126,0114,"MALAPPURAM",9546230984),
 (127,0115,"TRISSUR",8634256878),
 (128,0116,"KANNUR",7890343455),
 (129,0117,"ERANAKULAM",9876432790),
 (130,0118,"PALAKKAD",7806754390);   

INSERT INTO Employee VALUES
 (0111,"JOHN","ASSISTANT",50000),
 (0112,"RAJ","ACCONTANT",60000),
 (0113,"AADAM","CLERK",35000),
 (0114,"RAIN","ASSISTANT",48000),
 (0115,"GEETHA","MANAGER",80000),
 (0116,"HARI","LIBRARIAN",70000),
 (0117,"SHYAM","TECHNICIAN",40000),
 (0118,"MALAVIKA","CLERK",40000),
 (0119,"TAMIYA","ASSISTANT",65000),
 (0120,"ZAKARIYYA","ACCONTANT",68000);
 
 INSERT INTO Customer VALUES
  (2000,"KAJAL","MALAPPURAM","2018-03-12"),
  (2001,"LAL","KOCHI","2019-02-23"),
  (2002,"YARA","TALASSERY","2023-01-25"),
  (2003,"RINSI","MANGLURE","2022-11-30"),
  (2004,"NAZAL","KOLLAM","2020-10-12"),
  (2005,"TAMIZ","CALICUT","2023-07-15"),
  (2006,"LITHIYA","PUNE","2021-09-18"),
  (2007,"KIRAN","PALAKKAD","2023-07-16"),
  (2008,"JOHAN","ALAPPY","2022-05-24"),
  (2009,"VINOD","WAYANAD","2021-03-24");



INSERT INTO IssueStatus VALUES
 (5001,2000,"Learning Python","2023-05-19","978-93-96055-01"),
 (5002,2001,"Discovering Statistics Using R","2022-08-23","978-93-96055-02"),
 (5003,2002,"Head-First Python","2022-09-23","978-93-96055-03"),
 (5004,2004,"The Art of R Programming","2023-02-21","978-93-96055-05"),
 (5005,2005,"Java: A Beginner’s Guide","2023-05-28","978-93-96055-08"),
 (5006,2006,"Learning SQL","2022-09-15","978-93-96055-09"),
 (5007,2008,"Expert C Programming","2023-06-30","978-93-96055-10");
 
INSERT INTO  ReturnStatus VALUES
 (6001,2001,"Discovering Statistics Using R","2023-02-16","978-93-96055-02"),
 (6002,2002,"Head-First Python","2022-12-25","978-93-96055-03"),
 (6003,2005,"Learning SQL","2022-12-20","978-93-96055-09"),
 (6004, 2008,"Expert C Programming","2023-08-10","978-93-96055-10");


SELECT * FROM Branch;
SELECT * FROM Employee;
SELECT * FROM Customer;
SELECT * FROM Books;
SELECT * FROM IssueStatus;
SELECT * FROM ReturnStatus;

SELECT Book_title, Category, Rental_Price FROM Books WHERE Status="YES";

SELECT Emp_name,Salary FROM Employee ORDER BY Salary DESC;

SELECT Issued_book_name,Customer_name FROM IssueStatus,Customer
  WHERE IssueStatus.Issued_cust=Customer.Customer_id;
  
SELECT Category,count(Book_title) as Total_Books  FROM Books GROUP BY Category;

SELECT Emp_name,Position,Salary FROM Employee WHERE Salary>50000;

SELECT Customer_id, Customer_name,Reg_date From Customer 
  WHERE Reg_date <"2022-01-01"  and Customer_id NOT IN (SELECT Issued_cust FROM IssueStatus); 
  
SELECT Branch_no,count(Manager_id) FROM  Branch GROUP BY Branch_no;

    
SELECT Customer_name,Issued_book_name FROM Customer,IssueStatus
    WHERE Customer.Customer_id=IssueStatus.Issued_cust AND Customer_id IN (SELECT Issued_cust FROM IssueStatus WHERE Issue_date BETWEEN  "2023-05-31" AND "2023-07-01");
    
SELECT Book_title,Category FROM Books WHERE Category="History";
    
SELECT Branch.Branch_no, count(*) as Total_employee 
     FROM Branch 
     JOIN Employee ON Branch.Manager_id=Employee.Emp_id
     GROUP BY Branch.Branch_no
     HAVING COUNT(*) >5;