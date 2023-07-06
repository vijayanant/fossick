+++
type = "post"
title = "Database Normalisation"
date = "2023-06-06"
draft = true
tags = ["DB", "Normalisation", "Normalization", "Normal Forms"]
categories = ["Databases"]
+++

Database normalisation is a series of steps that aims to achieve an efficient and organised design for a _relational database_. Applying these steps eliminate data redundancy and the chances of data becoming inconsistent. Additionally, a normalised database is easier to work with when writing code, as the data is organised in a logical and structured manner.

The table design resulting from the first step is called First Normal Form(1NF), the result of the second step is Second Normal Form (2NF), etc.

A table in a relational database is said to be normalised if it satisfies 1st normal form. The higher normal forms deal with different levels of redundancy elimination. There are five generally accepted steps of normalisation.  

Before we get into details of normal forms. Let us get familiar with what we mean by inconsistency and data anomalies.

## Data Anomalies and Inconsistencies
Data anomalies and inconsistencies are two common problems that can occur in databases. They can lead to errors, decreased performance, and a loss of confidence in the data.

### Data Anomaly

A data anomaly is an inconsistency in the data that occurs when the same data is stored in multiple places and not all of the copies are updated. This can happen when data is entered manually or when it is imported from another system.

There are three types of data anomalies:

* **Insertion anomaly:** This occurs when new data cannot be added to the database because it is missing some required information. For example, if a new employee is hired but their department has not yet been created, the employee cannot be added to the database.

* **Update anomaly:** This occurs when data is updated in one place but not in all of the places where it is stored. For example, if an employee's name is changed, but the change is not made to all of the records that contain the employee's name, the database will contain inconsistent data.

* **Deletion anomaly:** This occurs when data is deleted from one place but not in all of the places where it is stored. For example, if an employee is terminated, their record may be deleted from the employee table, but it may not be deleted from the payroll table. This can lead to problems if the employee is still owed money.

### Data Inconsistency

Data inconsistency is a situation where the same data exists in different formats in multiple tables. This can happen when data is entered manually or when it is imported from another system.

Data inconsistency can lead to errors, decreased performance, and a loss of confidence in the data. For example, if the same customer's address is stored indifferent formats in different tables, it can be difficult to determine the customer's correct address. This can lead to errors in marketing campaigns and customer service.

Here are some examples of data anomalies and inconsistency:

* A customer's name is stored in different capitalisations in different tables.
* A product's price is different in the inventory table than it is in the sales table.
* A customer's order history is incomplete because some orders were not entered into the system.

These are just a few examples of how data anomalies and inconsistency can occur. 

#### Example
Consider a database where all the data is stored in a single table.

| CustID | CustName | Address | Phone | OrderDate | OrderNo | ItemNo | Price | Shipped |
|--------|----------|---------|-------|-----------|---------|--------|-------|---------|
| 101 | Rahul Sharma | 123, Main Street, New Delhi, 110001 | 9876543210 | 11/11/2022 | 101 | 105 | 214.50 | YES |
| 101 | Rahul Sharma | 123, Main Street, New Delhi, 110001 | 9876543210 | 21/11/2022 | 102 | 108 | 155.50 | YES |
| 102 | Priya Singh | 456, High Street, Mumbai, 400001 | 8765432109 | 01/12/2022 | 103 | 105 | 414.50 | YES |
| 102 | Priya Singh | 456, High Street, Mumbai, 400001 | 8765432109 | 13/12/2022 | 104 | 109 | 1613.00 | YES |

This type of design has several drawbacks:

* More than one entity is represented in the table. In this case, the table represents Customers, Orders, and OrderItems.
* The table contains redundant data. Every time a customer places an order, their contact information (Name, Address, and Phone) is needlessly repeated.
* Querying for customers from a specific city is inefficient
* Any query requires the DB to search the entire table. To find every unique customer in the database, one would need to search every line. There is no location set aside to store data about Customers and only Customers.
* Updating information, such as customer names, requires the DB to change multiple rows. If `Rahul Sharma` moved from `New Delhi` to `Bengaluru,` the DB would need to update every row containing his information.
* Deleting a customer's only order also removes all contact information for that customer. If `Rahul Sharma` cancelled the only two orders he placed, no record of him as a potential customer would remain in the database.

## Not All Databases Need To Be In 5NF

You need to normalise your DB; but not all databases need to be normalised up to 5NF. In fact, there are many cases where it would be counterproductive to do so; it can also make the database more complex and difficult to use.

The decision of how much to normalise a database depends on a number of factors, including the size and complexity of the database, the frequency of updates, and the needs of the users. In general, it is good practice to normalise databases to at least 3NF. However, there may be cases where it is not necessary to normalise further. For example, a small database that is not updated very often may not need to be normalised beyond 3NF.

Here are some of the reasons why a database might not need to be normalised up to 5NF:

* The database is small and not updated very often.
* The users of the database do not need to be able to perform complex queries.
* The database is not critical to the business.
* The cost of normalising the database is too high.

## Prerequisites:
### Keys
* **Primary Key**: A primary key is a unique identifier for each record in a table. It uniquely identifies a row and ensures that each record is distinct. A primary key cannot contain null values and must be unique within the table. Typically, a primary key is chosen from one or more columns (attributes) that have unique values. It serves as a reference point for establishing relationships with other tables through foreign key constraints.

* **Foreign Key**: A foreign key is an attribute (column) in one table that refers to the primary key of another table. It establishes a relationship between two tables, where the foreign key in one table references the primary key in another table. This allows for the enforcement of referential integrity, ensuring that data remains consistent across related tables.

* **Candidate Key**: A candidate key is a column or a combination of columns that can uniquely identify a row in a table. It is similar to a primary key but may or may not be chosen as the primary key for the table. A table can have multiple candidate keys, but only one can be selected as the primary key. The other candidate keys become alternate keys. The columns in a candidate key are called prime attributes.

* **Alternate Key**: An alternate key is a candidate key that is not chosen as the primary key for a table. While it can uniquely identify a row, it serves as an alternative to the primary key. An alternate key is useful when there are multiple unique identifiers for a table, and the primary key is selected based on other considerations.

* **Super Key**: A super key is a set of one or more attributes that can uniquely identify a row in a table. It may include more attributes than the minimum required to uniquely identify a record. A super key can have additional attributes that are not necessary for uniqueness. Candidate keys are minimal super keys.

### Dependencies
* **Functional Dependency**: Functional dependency describes the relationship between two sets of attributes in a table. It states that the values of one set of attributes determine the values of another set of attributes. In other words, knowing the value(s) of certain attribute(s) allows us to determine the value(s) of another attribute(s).  

    Functional dependencies are denoted as `A -> B`, where `A` determines `B`. A FD `X –> Y` in a relation R means that for each row in the relation R that has the same value for `X` the value of `Y` must also be the same. 


* **Partial Dependency**: Partial dependency occurs when an attribute in a table is functionally dependent on only a part of a composite candidate key. It means that some non-key attributes depend on only a portion of the candidate key, rather than the entire key. Partial dependencies can lead to data redundancy and update anomalies.

* **Transitive Dependency**: Transitive dependency is a type of functional dependency that occurs when an attribute is functionally dependent on another attribute through a third attribute. In other words, there is an indirect relationship between two attributes through a third attribute. Transitive dependencies can cause data redundancy and complicate data retrieval and updates. `A -> B -> C`. Here `A` determines `C` indirectly through `B`  

* **Multivalued Dependency**: A multivalued dependency exists when there are at least three attributes (like X,Y and Z) in a relation and for a value of X there is a well defined set of values of Y and a well defined set of values of Z. However, the set of values of Y is independent of set Z and vice versa.

## First Normal Form (1NF)

**A relation R is in first normal form (1NF) if and only if all underlying domains contain atomic values only.’**

Technically, this is the only criteria that is needed for a relation/table to be in 1NF. However, some more rules are generally added to the 1NF rules. Once your design satisfy this rule, you can claim that your tables are normalised (up to 1NF).

### Atomic Values
Each column in a table should hold atomic (indivisible) values. This means that each value within a column should be indivisible and not contain multiple pieces of data. If a value has multiple components, it should be split into separate columns.

Having atomic values in each column helps prevent data redundancy and ensures data integrity. It eliminates the need to store multiple values in a single column, which can lead to data inconsistency and difficulties in manipulating and querying the data. Atomic values enable efficient storage, retrieval, and update operations.

Consider a table named "Employee" with a column called "Skills" that stores multiple skills as a single value.

|Employee ID	| Name	| Skills |
|------------|------|--------|
|1           | John | Programming, Database, UI/UX |

In this example, the "Skills" column violates 1NF because it contains multiple values, "Programming," "Database," and "UI/UX," separated by commas. This violates the atomicity rule as each skill should be stored in a separate column. Storing multiple values in a single column can lead to difficulties in querying and updating specific skills and can cause data redundancy.

### Unique Column Names
Each column in a table must have a unique name. This ensures clarity and avoids confusion when referencing columns.

Unique column names prevent ambiguity and confusion when referencing columns in the table. By enforcing distinct column names, it becomes easier to identify and understand the meaning of each column. This clarity improves the maintainability and readability of the database design and facilitates effective communication among developers and users.

Consider a table named "Student" with two columns named "Name" and "Student_Name."

|Name  | Student_Name |
|------|--------------|
|John  | Smith |
|Alice | Johnson |

In this example, the table violates 1NF because it has duplicate column names. Having non-unique column names leads to ambiguity and confusion when referencing columns. It becomes unclear which column should be used, causing difficulties in data retrieval and query formulation.

### Orderless Rows
The order of records (rows) in a table should not matter. The database should be able to retrieve and present the rows in any order without impacting the integrity or meaning of the data.

Requiring orderless rows ensures that the order in which records are stored or retrieved from the table does not affect the integrity or meaning of the data. It eliminates any dependencies on the physical order of the rows, enabling flexible data retrieval and manipulation operations. This independence from row order simplifies data management and reduces the likelihood of errors or inconsistencies caused by relying on a specific row order.

Consider a table named "Orders" where the order of the records represents the sequence of order placement.

| Order ID | Customer       | Date       |
| -------- | -------------- | ---------- |
| 1        | John Smith     | 2022-01-15 |
| 2        | Alice Johnson  | 2022-02-10 |
| 3        | Bob Williams   | 2022-01-05 |

In this example, the table violates 1NF because the order of the rows is significant and implies a specific sequence. Depending on the order of the records, the data may have different meanings or implications. Relying on row order can lead to inconsistencies when inserting, deleting, or updating records and can cause confusion in data interpretation.

### Uniquely Identifiable Rows 
Each row in a table should be uniquely identifiable. This requires the presence of a primary key, which is a column (or combination of columns) that uniquely identifies each row in the table. The primary key must have unique values and should not contain any null (empty) values.

Ensuring each row is uniquely identifiable through a primary key solves various problems and prevents anomalies in data management. Having a primary key allows for accurate referencing and linking of data across multiple tables. It helps avoid data duplication and inconsistencies that can arise from having duplicate rows. Additionally, a primary key enables efficient data retrieval, update operations, and maintaining data integrity.

Consider a table named "Students" without a primary key.

|Name  |Age  | Grade |
|------|-----|-------|
|John  |20   | A |
|Alice |19   | B |

In this example, the table violates 1NF because it does not have a primary key column. Without a unique identifier for each row, it becomes challenging to differentiate between duplicate or similar records. The absence of a primary key can lead to data duplication, difficulties in data retrieval, and update anomalies when modifying or deleting specific records.

By adhering to these rules, a table can achieve the First Normal Form. This helps eliminate data redundancy and ensures data integrity and consistency in the database.


## Second Normal Form (2NF)

**'A relation R is in second normal form (2NF) if and only if it is in 1NF and every non-key attribute is fully dependent on candidate key.’**

This means that a relation is in 2NF if it meets the following two conditions:

* It is in 1NF. This means that all of its attributes are atomic, and that there are no duplicate rows.
* It does not have any non-prime attribute that is functionally dependent on any proper subset of any candidate key of the relation (i.e. no partial dependencies)

Here is an example of a table that is in 1NF (but not in 2NF):

|Customer| Customer Address | Product | Manufacturer | Quantity | Order Date |
|--------|------------------|---------|--------------|----------|------------|
| Rajesh Kumar | 123 Main Street | iPhone 13 Pro| Apple | 1 | 06/06/2023 |
| Priya Sharma | 456 Elm Street | Samsung Galaxy S22 | Samsung| 2| 07/06/2023 |
| Ravi Singh   | 789 Oak Street  | MacBook Pro| Apple| 1| 08/06/2023 |
| Sunita Patel | 101 Pine Street | Dell XPS 13  | Dell  | 2 | 09/06/2023 |

Here are some problems with this design: 

* Everytime a customer buys same product multiple times, customer's address and the product's manufacturer details are repeated. 
* If a customers address changes, multiple rows needs to be updated which affects performance of your DB.
* If a customer has only one order, and that order is cancelled, we loose all other information about the customer. 

2NF helps fix these problems. Because a customer can purchase two or more  products on different date, the composite key `{Customer, Product, Order Date}` is a candidate key. In fact it is the only candidate key for this table. The non-key attributes, then, are `Customer Address`, `Manufacturer`, and `Quantity`. For the table to be in 2NF, these non-key attributes must be determined by entire key.

* `Customer Address` can be determined by `Customer` alone, this violates 2NF
* `Manufacturer` is determined by `Product`, this too violates 2NF
* `Quantity` is dependent on `Customer`, `Product` and `Order Date`. That is the
entire key. 

Since `Customer Address` and `Manufacturer` are partially dependent on primary key, we move them to separate table where they depend on the entire key.

#### Customer Table 

|CustomerID (PK)|Customer Name | Customer Address |
|---------------|--------------|------------------|
| 100           | Rajesh Kumar | 123 Main Street  |
| 101           | Priya Sharma | 456 Elm Street   |
| 102           | Ravi Singh   | 789 Oak Street   |
| 103           | Sunita Patel | 101 Pine Street  |

#### Product Table 

| ProductID  (PK)| ProductName |  Manufacturer|
|---|---------------------|---------|
| 1 | iPhone 13 Pro       | Apple   |
| 2 | Samsung Galaxy S22  | Samsung |
| 3 | MacBook Pro         | Apple   |
| 4 | Dell XPS 13         | Dell    |

#### Customer Order Table 
|CustomerID (PK, FK) | ProductID  (PK, FK)| Quantity | Order Date (PK)|
|-----|---|---|------------|
| 101 | 1 | 1 | 06/06/2023 |
| 102 | 2 | 2 | 07/06/2023 |
| 103 | 3 | 1 | 08/06/2023 |
| 104 | 4 | 2 | 09/06/2023 |

Now, check the problem we had identified with the original table and see if those problems remain!

## 3NF

**‘A relation R is in third normal form (3NF) if and only if it is in 2NF and
every non-key attribute is non-transitively dependent on the candidate key.’**

Normalising a table to 2NF ensures that every column in the table is functionally dependent on the entire key. Nonetheless, it does not put any restriction on the non-prime to non-prime attribute dependency. That is addressed in third normal form.

Here is a table of Men's Tennis Grand Slam Title Winners

| YEAR | TOURNAMENT | WINNER | DATE OF BIRTH |
|------|------------|--------|---------------|
| 2023 | French Open     | Novak Djokovic | 22 May 1987    |
| 2023 | Australian Open | Novak Djokovic | 22 May 1987    |
| 2022 | U.S. Open       | Carlos Alcaraz | 05 May 2003    |
| 2022 | Wimbledon       | Novak Djokovic | 22 May 1987    |
| 2022 | French Open     | Rafael Nadal   | 03 June 1986   |
| 2022 | Australian Open | Rafael Nadal   | 03 June 1986   |
| 2010 | Australian Open | Roger Federer  | 08 August 1981 |

As there can be multiple tournaments in a given year, `{Tournament, Year}` is a candidate key for this table. 

This table is in 2NF as there are no partial dependencies. 

* Winner's name and date of birth seems to repeating multiple times. We cannot avoid repeating winner's name if the same person wins multiple name. But repeating winner's DOB seems unnecessary.
* Data becomes inconsistent if an update is made to one of the rows changing the DOB. There could be two different DOBs for same payer! Which one is to be believed? 

We thought we solved data duplication and anomalies by removing partial dependencies from the table; then what caused this?

In this table the non-prime attribute winner's `DATE OF BIRTH` is transitively dependent on the candidate key `{Tournament, Year}` through the non-prime attribute `WINNER`.

`{Tournament, Year} -> WINNER -> DATE OF BIRTH`

Transitive dependencies can cause a number of problems, including:

* **Data redundancy**: If a transitive dependency exists, the same data is stored in multiple places in the database. This can lead to data inconsistencies and make it difficult to update or delete data.
* **Update anomalies**: If a transitive dependency exists, and we update the value of an attribute that is transitively dependent on another attribute, we may also need to update the value of the other attribute. This can be a problem if we do not know that the two attributes are related.
* **Deletion anomalies**: If a transitive dependency exists, and we delete a row from the table, we may also need to delete rows from other tables. This can be a problem if we do not know that the rows are related.

To avoid these problems, we normalise our tables so that there are no transitive dependencies. This can be done by splitting the table into multiple tables, with each table representing a single entity.

Here are some tips for avoiding transitive dependencies in your database tables:

* Identify the primary key for each table.
* Only include attributes in a table that are directly related to the primary key.
* If you need to store data that is indirectly related to the primary key, store it in a separate table.

#### Tournament Table

| YEAR | TOURNAMENT      | WINNER         |
|------|-----------------|----------------|
| 2023 | French Open     | Novak Djokovic |
| 2023 | Australian Open | Novak Djokovic |
| 2022 | U.S. Open       | Carlos Alcaraz |
| 2022 | Wimbledon       | Novak Djokovic |
| 2022 | French Open     | Rafael Nadal   |
| 2022 | Australian Open | Rafael Nadal   |
| 2010 | Australian Open | Roger Federer  |

#### Winner's Date Of Birth Table

| WINNER         | DATE OF BIRTH  |
|----------------|----------------|
| Novak Djokovic | 22 May 1987    |
| Carlos Alcaraz | 05 May 2003    |
| Rafael Nadal   | 03 June 1986   |
| Roger Federer  | 08 August 1981 |

## BCNF

**‘A relation R is in Boyce/Codd normal form (BCNF) if and only if every determinant is a candidate key.’**

## 4NF
**‘A relation R is in fourth normal form (4NF) if and only if, wherever there exists a MVD in R, say A ->> B, then all attributes of R are also functionally dependent on A. In other words, the only dependencies (FDs or MVDs) in R are of the form K -> X (i.e. a functional dependency from a candidate key K to some other attribute X). Equivalently: R is in 4NF if it is in BCNF and all MVD’s in R are in fact FDs.’**

## 5NF

**‘A relation R is in fifth normal form (5NF) - also called projection-join normal form (PJ/NF) if and only if every join dependency in R is a consequence of the candidate keys of R.’**

