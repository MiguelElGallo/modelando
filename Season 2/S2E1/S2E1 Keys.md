# Keys

"The key, the whole key, and nothing but the key, so help me, Codd."

In S1E3, we introduced Edgar Frank "Ted" Codd, Considered the founder of relational databases. And that is a famous quote related to primary keys. 

A primary key in OLTP and relational databases is vital, and all relational databases enforce a primary key.

As Bill Inmon and Francesco Puppin explain in their book the Unified star schema,
The term "Primary Key" may generate a bit of confusion because, in the world of relational databases, it may have a specific meaning of "enforced Primary Key": a mechanism that produces an error when the uniqueness of the key is violated.

If we check the documentation of products like Snowflake or Databricks, we see statements like this:

"Snowflake supports defining and maintaining constraints, but does not enforce them, except for NOT NULL constraints, which are always enforced."

<https://docs.snowflake.com/en/sql-reference/constraints-overview>

"Informational primary key and foreign key constraints encode relationships between fields in tables and are not enforced."
<https://docs.databricks.com/tables/constraints.html>

In both products (and many others), we see that they do not enforce the primary key, but that responsibility is left to the processes that write the data.

This difference in how data warehouse engines handle the primary key suggests that we may need a different approach for managing the keys in data warehouses and datamarts (mainly OLAP).

## Natural Key / Business Key

Patrick Cuba, in his book The Data Vault Guru, defines:

What are natural keys? How does the business identify an individual entity, be it a customer, product, account, contract, workshop, or factory? These are unique values that are used within the enterprise and sometimes externally to the enterprise in discussions with customers, service providers, partners, etc. They identify the thing we want to transact on or with, uniquely track the things that make a business viable, may need regulatory reporting on, and are used to uniquely identify a person, company, account, product, or thing through its value to the business.
To the subject area of concern, these identifying values have meaning, and data vault tracks everything around those keys by historizing data about these things and providing the audit trail on everything we know about the
thing.
In the data vault, natural keys are our first-choice business key candidates; in Kimball terminology, they are called natural keys because, for the life of a business entity likely, we can uniquely identify that entity by that key. The business entity may be represented by different keys depending on the source system or platform as long as it holds the same semantic grain. Other meaningful keys include things like vehicle identification numbers, flight numbers, purchase order number, barcodes, SKUs; you see these are the uniquely identifying keys you will likely use when interacting with for doing business, for commerce. They are the first-choice business keys in data vault.
A test for identifying a business key is this:
Can the key value with no other attribute uniquely identify a thing?
• Does the key with no other attribute translate to an area of importance within an enterprise?
When tracking information about a customer or account, what is the unique identification number that the thing is tied to?
We use natural keys every day, the account number we use to top-up our public transport card, the account number where details of our utility bills are tracked, the bank account number where our disposable funds are kept.
Some keys are shared and some are uniquely assigned to a customer. Some natural keys are highly confidential, and some include embedded logic that tells us more about that key.

## Hash keys

Hash keys are durable surrogate keys that aim to optimize loading and data distribution but are not strictly for optimizing reporting.

We are not dealing with transactions in Data warehouses as in OLTP systems or systems of records. Suppose a customer changes the quantity of an order in an OLTP system. In that case, an update in a specific record (that order from that customer needs to be updated using a primary key that identifies the order) needs to happen.

From the data warehouse point of view, we will receive a newer version of the order from the source system. Usually, data warehouses store snapshots of the data from the source system. We can see that the primary key constraint is no longer critical; it is ok to have two orders with the same business key in the data warehouse; depending on your methodology, there are different methods.

 The most intuitive method is to sort by the last ingestion date and find the first record for each business key. For example, there will be two records with the same business key (order number) in the orders, and we will pick the one with the last ingestion date.

Depending on the modeling technique and business requirements, more advanced techniques like the data vault's PIT (Point in time table) exist.

In other words, read your methodology documentation (Kimball, Data Vault, etc.)  to find the recommended practices for dealing with keys in OLAP. (Data warehouses, data marts, etc.)

Since you may be dealing with multiple source systems or source systems will be replaced, the most common approaches to dealing with keys include these steps

Prepare the business key
Leading or trailing zeros, case (convert all to uppercase), spaces, etc.
Multi-column business keys can be concatenated into one
Apply a hashing or a sequence to create a new key.

Performance is also something to keep in mind; the data type you choose for your keys (that will be used for doing the joins) does matter.

Found this interesting blog about data types and performance in joins for Delta Lake format:
<https://www.confessionsofadataguy.com/data-types-in-delta-lake-spark-join-performance-and-thoughts/>