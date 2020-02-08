


--**-------------------------------------------------------------**--
-- Materialized Views


-- CREATE MATERIALIZED VIEW view-name 
-- BUILD [IMMEDIATE | DEFERRED]
-- REFRESH [FAST | COMPLETE | FORCE ]
-- ON [COMMIT | DEMAND ] 
-- [[ENABLE | DISABLE] QUERY REWRITE ]
-- [ON PREBUILT TABLE] 
-- AS SELECT ...

-- * BUILD IMMEDIATE : Populates the MV immediately. 
-- * BUILD DEFERRED: Populates the MV on the first refresh request. 
-- * REFRESH FAST : Refresh the MV with just the changes of the existing data instead of repopulate entire MV. 
-- * REFRESH COMPLETE: The table of materialized is truncated and repopulated with the associated query. 
-- * REFRESH FORCE:A fast refresh is attempted. If fast refresh is not possible, complete refresh is performed. 
-- * ON COMMIT: The refresh is performed on a commitof any dependent tables. 
-- * ON DEMAND: The refresh is performed manually or a scheduled task. 
-- * ENABLE QUERY REWRITE : Allows the optimizer to use query rewrite option to improve performance for expensive and time consuming process of the associated SQL query. 
-- * DISABLE QUERY REWRITE : Disallows the optimizer for query rewriting. This option is default. 
-- * ON PREBUILT TABLE : Provides creating materialized view on an existing table. For example; this is useful if we lose the link between materialized view and it's table on database transportation. We can easily create materialized view on this table without recreating-refilling it. 
-- * AS SELECT : Query of the materialized view. The relevant table is populated with this query. It can be simple or complex query. 

--**-------------------------------------------------------------**--