--**-------------------------------------------------------------**--
-- Sequences

-- A sequence is a user created object that automatically generates unique numbers. 
--	• A sequence is a shareable object that can be shared by multiple users. 
--	• It is used generally used for creating primary key value.  
--	• We can use sequences in anywhere to generate unique numbers. 
--	• Sequence numbers are stored independent of tables so a sequence can be used by multiple users and for multiple tables. 
--	• We can increase efficiency of accessing sequences by caching them in memory.
--**-------------------------------------------------------------**--


CREATE SEQUENCE [schema].[sequence name]   
[ {START WITH | INCREMENT BY} integer   -- • START WITH First sequnce number to be generated. (Default 1)
| {MAXVALUE integer | NOMAXVALUE}       -- • INCREMENT BY: Interval between sequence numbers. (Default 1) 
| {MINVALUE integer | NOMINVALUE}       -- • MAXVALUE : Maximum value that the sequence generates. 
| {CYCLE | NOCYCLE}                     -- • NOMAXVALUE: Generateres sequence values until it reaches 10^27. 
| {CACHE integer | NOCACHE}             -- • MINVALUE : Minimum value that the sequence generates. 
| {ORDER | NOORDER}                     -- • NOMINVALUE: Generateres sequence values until it reaches -10^26. 
;                                      -- • CYCLE: After reaching the maximum value, sequence continues to generate numbers starting 
										--   with the minimum value. 
                                        -- • NOCYCLE: Stops generating numbers after reaching the maximum value. (By default NOCYCLE is set) 
                                        -- • CACHE : Specifies how manyvalues are kept in memory by Oracle Server. 
                                        -- • NOCACHE : No value is kept in memory. 
                                        -- • ORDER : Guarantees sequence numbers to be generated in an order. 
                                        -- • NOORDER: Specify noorder if you don't want to guarantee sequence numbers to be generated in an order. 


--**----------------------------------------------------**--
-- Create Sequences (Example)
--**----------------------------------------------------**--

CREATE SEQUENCE employee_seq 
  START WITH 1 
  INCREMENT BY 1
  NOMAXVALUE
  NOCYCLE
  CACHE 50
  ORDER
;

--**----------------------------------------------------**--
-- Modifying Sequences

-- • We can modify a sequence with using ALTER SEQUENCE keywords. 
-- • We must be the owner or have the ALTER privilege to modify a sequence. 
-- • Only future sequence numbers are affected. 
-- • We can not use START WITH opetion while modifying a sequence. 
-- • We must drop and re-create the sequence for starting with a different number. 
-- • While modifying, some validation is performed (for example: MAXVALUE can not be smaller than the existing MAXVALUE)

--**----------------------------------------------------**--

ALTER SEQUENCE sequence_name 
{ INCREMENT BY } integer 
{ MAXVALUE integer | NOMAXVALUE } 
{ MINVALUE integer | NOMINVALUE }
{ CYCLE | NOCYCLE }
{ CACHE integer | NOCACHE }
{ ORDER | NOORDER }
;


--**----------------------------------------------------**--
-- Modifying Sequences (Example)
--**----------------------------------------------------**--

ALTER SEQUENCE employee_seq
  INCREMENT BY 1
  NOMAXVALUE
  NOCYCLE
  CACHE 100
  ORDER
;

--**----------------------------------------------------**--
-- Drop Sequence
--**----------------------------------------------------**--

--DROP SEQUENCE employee_seq;
