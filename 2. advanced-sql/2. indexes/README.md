# Indexes 

Indexes are schema objects for speeding up the retrieval of rows by using a pointer. 

* Basically, indexes improve performance of queries. 
* Because indexes have pointers, it directly points to a related row. (Locate to the exact location of the data in the disk rather than scanning all the disk). This is much faster than the normal way. 
* If there is no index for a column, "full-table scan" occurs. 
* Indexes are created explicitly or automatically (with creating primary or unique constraint). 
* After creating an index we do not directly do anything. Oracle Server automatically maintains indexes. 
* Indexes are tied to a table but have no effect on the base table that means if we drop an index, nothing changes in the base table. 
* If we drop a table, all the indexes related to this table are also dropped. 
* Indexes are used only when we refer to the index column in WHERE clause . 



### Types of Indexes (Unique - Nonunique Indexes) 

* **Unique Index**: Oracle Server automatically creates this index while creating a primary key or unique constraints. We can manually create unique indexes but it is recommended to create a unique constraint instead. With that way a unique index will be created implicitly. 
* **Nonunique Index**: These indexes are created by a user for improving performance with any column or columns. 
* **B-tree Indexes** : Default index type is B-tree that means if we don't specify anything we create B-tree indexes. Useful for high cardinality columns. (if most of the values are different using B-tree indexes will be faster) 
* **Bitmap Indexes** : Used with bitmap keyword. Useful for low cardinality columns. (Bitmap indexes will be faster if there are lots of duplicate values) 
* Bitmap indexes can not be unique. (We can not use unique keyword with bitmap) 

### Function Based Indexes 

* Normally, to run an index we refer to indexed columns but if we use some functions with these columns, indexes do not run and full-table scan occurs. 
* In these situations we use function based indexes for speeding up the query. 
* These functions can be SQL functions or user-defined functions. 
* For creating a function based index, you need to have QUERY REWRITE system privilege. 
   ~~~~sql 
   CREATE INDEX first_name_idx ON EMPLOYEES(LOWER(first_name));
   ~~~~
* Oracle Server uses this index only when this function is used in a query. 
* Without a WHERE clause Oracle Server perform full table scan even if the table has many indexes. 



### Multiple Indexes for same column(s)

* We can have multiple indexes defined for same column(s)

  ~~~~sql
  ALTER INDEX emp_phone_ix INVISIBLE;
  ~~~~

### Dropping an Index 

* We use DROP INDEX command to remove an index. 

* We need to have DROP an INDEX privilege or we must be owner of the index to remove an index. 

* Indexes **can not** be modified. To change an index we just drop an recreate it. 
  
   ~~~~sql
   DROP INDEX indexname;
   ~~~~
   
* If we drop a table all the indexes are dropped automatically. 

* If we want to allow DML operations while dropping an index we use ONLINE keyword. 

   ~~~~sql
   DROP INDEX emp_phone_ix ONLINE; 
   ~~~~

   Note: We can not drop an index used by unique or primary key constraints.  Also we can use USER_INDEXES view to query information about indexes.
