create database librarydb;

use librarydb;

create table Branch(Branch_no int primary key,Manager_id int,
Branch_address varchar(50),Contact_no int);

insert into Branch(Branch_no,Manager_id,Branch_address,Contact_no)
values
(1,101,'gandhi nagar,2nd street',123456),
(2,102,'ayl road,cochi',456805),
(3,103,'casio street,hyderabad',789565),
(4,104,'amaya louge,mumbai',787952),
(5,105,'sayam street,harihar',125867);

create table Employees(Emp_id int primary key,Emp_name varchar(50),
Position varchar(20),salary decimal(10,2));

insert into Employees(Emp_id,Emp_name,position,salary)
values
(101,'Nicks','Sales Manager',8000),
(102,'lashmi','Admin',16000),
(103,'Aster','Accountant',20000),
(104,'John','HR',15000),
(105,'sagar','It support',11000);

create table Customer(Customer_id int primary key,Customer_name varchar(30),
Customer_address varchar(50),Reg_date date);

insert into Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
values
(1, 'Akhan', 'Bluemoon appartments', '2023-02-02'),
(2, 'Maxi', 'grace colony', '2023-03-03'),
(3, 'Monica', 'bijrow street', '2023-04-04'),
(4, 'jaggu', 'Sawmill road', '2023-05-05'),
(5, 'Kia', 'SM streeet', '2023-06-06');

create table Books(ISBN varchar(20)primary key,
Book_title varchar(100),Category Varchar(50),Rental_price decimal(10,2),
Status varchar(30),Author varchar(100),Publisher varchar(100));

insert into Books(ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
values
('isbn1', 'Lord of rings', 'Epic', 15.00, 'yes', 'Tolkein', 'Abc Publisher'),
('isbn2', 'Harry potter', 'Fantasy', 20.00, 'yes', 'Rowling', 'xyz Publisher'),
('isbn3', 'Fifth mountain', 'Fiction', 8.00, 'no', 'Paulo coelho', 'cgb Publisher'),
('isbn4', 'Feroze gandhi', 'Biography', 9.00, 'yes', 'Bertil', 'mkl Publisher'),
('isbn5', 'Half girlfriend', 'Novel', 11.00, 'no', 'Chetan bagath', 'sdf Publisher');

create table IssueStatus(Issue_id int primary key,Issued_cust int,
Issued_book_name varchar(100),Issue_date date,ISBN_book varchar(20),
foreign key(Issued_cust)references Customer(Customer_id),
foreign key(ISBN_book)references Books(ISBN));

insert into IssueStatus(Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
values
(1, 1, 'Lord of rings', '2023-01-09', 'isbn1'),
(2, 2, 'Harrypotter', '2023-02-05', 'isbn2'),
(3, 3, 'Fifth mountain', '2023-03-15', 'isbn3'),
(4, 4, 'Feroze gandhi', '2023-04-20', 'isbn4'),
(5, 5, 'Half girlfriend', '2023-05-28', 'isbn5');


create table ReturnState(Return_id int primary key,
Return_cust int,Return_book_name varchar(100),
Return_date date,ISBN_book2 varchar(20),
foreign key(Return_cust)references Customer(Customer_id),
foreign key(ISBN_book2)references Books(ISBN));
insert into ReturnState(Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
values
(1, 1, 'Lord of rings', '2023-01-11', 'isbn1'),
(2, 2, 'Harry potter', '2023-02-09', 'isbn2'),
(3, 3, 'Fifth mountain', '2023-03-20', 'isbn3'),
(4, 4, 'Feroze gandhi', '2023-04-25', 'isbn4'),
(5, 5, 'Half girlfriend', '2023-05-31', 'isbn5');


/*Write the queries for the following:
1. Retrieve the book title, category, and rental price of all available
books.*/
select Book_title,Category,Rental_price from Books where Status = 'Yes';

/*2. List the employee names and their respective salaries in descending
order of salary.*/
select Emp_name,Salary from Employees order by Salary desc;

/*3. Retrieve the book titles and the corresponding customers who have
issued those books.*/
select b.Book_title, c.Customer_name
from IssueStatus i
join Books b on i.Isbn_book = b.ISBN
join Customer c on i.Issued_cust = c.Customer_Id;

/*4. Display the total count of books in each category.*/
select category, count(*) as book_count
from Books
group by Category;

/*5. Retrieve the employee names and their positions for the employees
whose salaries are above Rs.50,000.*/
select Emp_name,position from Employees
where Salary > 50000;

/*6. List the customer names who registered before 2022-01-01 and have
not issued any books yet.*/
select Customer_name from Customer
where Reg_date<'2022-01-01'
and Customer_id not in (select Issued_cust from IssueStatus); 


/*7. Display the branch numbers and the total count of employees in each
branch.*/
select b.Branch_no,count(*) as Total_count
from Employees e
join Branch b on e.Emp_id =b.Manager_id
group by b.Branch_no;

/*8. Display the names of customers who have issued books in the month
of June 2023.*/
select c.Customer_name 
from Customer c 
join IssueStatus i on c.Customer_Id = i.Issued_cust
where month(i.Issue_date) =6 and year(i.Issue_date) =2023; 

/*9. Retrieve book_title from book table containing history.*/
select Book_title
from Books
where Category = 'history';

/*10.Retrieve the branch numbers along with the count of employees for
branches having more than 5 employees.*/
select b.Branch_no,count(*)as Employee_count
from Employees e
join Branch b on e.Emp_id = b.Manager_id
group by b.Branch_no
Having Employee_Count > 5;


 
