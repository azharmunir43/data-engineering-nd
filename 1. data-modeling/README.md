# Data Modeling Notes

### Relational Data Modeling

#### Normalization 

 The process of structuring a relational database in accordance with a series of normal forms in order to reduce data redundancy and increase data integrity. 

**Objectives of Normal Form:**

1. To free the database from unwanted insertions, updates, & deletion dependencies
2. To reduce the need for refactoring the database as new types of data are introduced
3. To make the relational model more informative to users
4. To make the database neutral to the query statistics

1. **How to reach First Normal Form (1NF):**

2. - Atomic values: each cell contains unique and single values, i.e. no sets, lists etc. as cell value.
   - Be able to add data without altering tables, adding columns etc..
   - Separate different relations into different tables, create logical groupings, i.e. we don't want to      have one giant table.
   - Keep relationships between tables together with foreign keys, being able to join

3. **Second Normal Form (2NF):**

4. - Have reached 1NF
   - All columns in the table must rely on the Primary Key, no composite key (we should not be needing more than 1 column to uniquely identify a row)

5. **Third Normal Form (3NF):**

6. - Must be in 2nd Normal Form

   - No transitive dependencies

   - - Remember, transitive dependencies you are trying to maintain is that to get from A-> C, you want to avoid going through B.

   - **When to use 3NF:** 

   - - When you want to update data, we want to be able to do in just 1 place. We want to avoid       updating the data in the Customers Detail table (in the example in the lecture slide). 

#### Denormalization

The process of trying to improve the read performance of a database at the expense of losing some write performance by adding redundant copies of data. 

Must be performed in **read heavy** workloads in order to increase performance.

- The Designer is in charge of keeping data consistent 
- Reads will be faster (select)     
- Writes will be slower (insert, update, delete) 

**Normalization** is about trying to increase data integrity by reducing the number of copies of the data. Data that needs to be added or updated will be done in as few places as possible. 

**Denormalization** is trying to increase performance by reducing the number of joins between tables (as joins can be slow). Data integrity will take a bit of a potential hit, as there will be more copies of the data (to reduce JOINS). 

### Non-Relational Data Modeling

- Query first approach. 
- Possible to have one table for one query. 
- About modeling queries not data, as we do in relational world.

### Primary Key 

- The PRIMARY KEY is how each row can be uniquely identified and how the data is distributed across the nodes (or servers) in our system. 
- The **first element** of the PRIMARY KEY is the PARTITION KEY (which will determine the distribution). *Partition key should be chosen such that it evenly distributes data across all nodes. So, having a good look at the data distribution by certain column can be really helpful here.* 
- The PRIMARY KEY is made up of either just the PARTITION KEY or with the addition of CLUSTERING COLUMNS, that is, Simple or Composite Primary Key.
- The partition key's row value will be hashed (turned into a number) and stored on the node in the system that holds that range of values. 
- Must be unique. No duplication in Apache Cassandra. Also, if conflicted, no error will be thrown and already available record will be overwritten.
- May have one or more clustering columns.

#### Clustering Column

The PRIMARY KEY is made up of either just the PARTITION KEY or with the addition of CLUSTERING COLUMNS. The CLUSTERING COLUMN will determine the sort order within a Partition. 

* Will sort data in ASC order
* More than one clustering column can be added, e.g. *PRIMARY KEY ((year), artist_name, album_name)*

#### WHERE Clause

The **WHERE** statement is allowing us to do the fast reads. With Apache Cassandra, we are talking about big data -- think terabytes of data -- so we are making it fast for read purposes. Data is spread across all the nodes. By using the WHERE statement, we know which node to go to, from which node to get that data and serve it back. For example, imagine we have 10 years of data on 10 nodes or servers. So 1 year's data is on a separate node. By using the WHERE year = 1 statement we know which node to visit fast to pull the data from.

- Data Modeling in Apache Cassandra is query focused, and that focus needs to be on the WHERE clause.
- Failure to include a WHERE clause will result in an error (if configuration is not applied) or very bad performance.
- Cassandra requires all fields in the WHERE clause to be part of the primary key.
- Cassandra will not allow a part of a primary key to hold a null value.
- While Cassandra will allow you to create a secondary index on a  column containing null values, it still won't allow you to query for  those null values.
- Cassandra does not support the use of NOT or not equal to (!=) operators in the WHERE clause.

