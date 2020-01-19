--**-------------------------------------------------------------------------------**--
-- Using Sequences

-- • NEXTVAL: Returns next sequence value. Returns a unique value in every usage even by different users. 
-- • CURRVAL: Returns the current sequence value. We must use NEXTVAL at least for one time to be able use currval keyword in our session. 
-- • We can use NEXTVAL and currval in: 
--  • SELECT list of a SELECT statement (not in a subquery or a view) 
--  • SELECT list of a subquery in an INSERT Statement. 
--  • VALUES part of an INSERT Statement. 
--  • SET clause of an UPDATE Statement. 
--  • We can not use NEXTVAL and currval with a DISTINCT keyword or with a GROUP BY, HAVING, ORDER BY clauses. 
--**-------------------------------------------------------------------------------**--

--**----------------------------------------------------**--
-- SELECT List Example
--**----------------------------------------------------**--

SELECT employee_seq.CURRVAL,  employee_seq.NEXTVAL FROM DUAL;

--**----------------------------------------------------**--
-- VALUES of INSERT Example
--**----------------------------------------------------**--

INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, SALARY, JOB_ID) 
VALUES (EMPLOYEE_SEQ.NEXTVAL, 'James' , 'Warner' , 'WARNER' ,sysdate, '2500', 'Data Engineer') ; 

--**----------------------------------------------------**--
-- While Defining Table Structure
--**----------------------------------------------------**--

CREATE TABLE Employee2( 
ID NUMBER DEFAULT employee_seq.NEXTVAL NOT NULL, 
Name varchar2(59)

); 


INSERT INTO Employee2(Name) VALUES('Azhar') ;


--**--------------------------------------------------------**--
-- Problem : How do we change the value in an Oracle Sequence?
--**--------------------------------------------------------**--

--  • You can change the LASTVALUE for an Oracle sequence, by executing an ALTER SEQUENCE command.
--  • For example, if the last value used by the Oracle sequence was 100 and you would like to reset 
--    the sequence to serve 225 as the next value.

ALTER SEQUENCE employee_seq
INCREMENT BY 124;

SELECT employee_seq.NEXTVAL FROM dual;

ALTER SEQUENCE employee_seq
INCREMENT BY 1;
