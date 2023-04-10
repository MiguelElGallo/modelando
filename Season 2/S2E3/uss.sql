create database if not exists uss_test;
use database uss_test;

create or replace  view  uss_test.public."BRIDGE" as

select  'ORDERS' as stage, 
       o_orderkey as _key_order,
       null as _key_item,
       null as _key_cust,
       o_orderdate as _key_date
from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
union
select  'ITEMS' as stage, 
       L_orderkey as _key_order,
       L_LINENUMBER as _key_item,
       null as _key_cust,
       null as _key_date
from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM
union
select  'CUSTOMERS' as stage, 
       null as _key_order,
       null as _key_item,
       C_CUSTKEY as _key_cust,
       null as _key_date

from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER;