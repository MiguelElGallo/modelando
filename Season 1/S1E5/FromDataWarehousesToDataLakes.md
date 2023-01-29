# From Datawarehouses to Datalakes

In this article we're going to discuss the differences between data warehouses, data lakes and lakehouses, as well as take a deeper look at some of their benefits and drawbacks.

## Data warehouses

Back in the 80s, data warehouses were the solution that provided an architectural model for the flow of data from systems of records like ERPs to decision support environments like SAP Business Warehouse, Oracle, and others.

BI and reporting tools where able to connect to the data warehouses to generate dashboards and reports, and also to support decision makers.

As data volumes grew and the complexity of the data increased (data became semi-structured, nested, etc.), data warehouses had some challenges:

High maintenance costs, mainly storage costs (high performance proprietary storage for a proprietary format).

There was no support for machine learning cases, as it was only meant for BI and reporting.

Lack of scalability and flexibility for handling different data complexities.

These challenges, the cloud and other factors started to shape into something new: the data lake.

## Data lakes

In the earlier days of the data lake movement, Hadoop was the main component. There were success stories, there were failure stories, nevertheless a new era had begun:

In many cases, companies have been able to replace expensive data warehouse software with in-house computing clusters running open source Hadoop.

It allowed companies to analyse massive amounts of unstructured data (also called big data) in a way that wasn’t possible before.

Nowadays it seems that Spark is the one running the show as the engine for data lakes. But what are the new challenges the data lakes yield?

They lack some basic features that were available for decades in RDBMS and data warehouses such as:

support for transactions

enforcement of data quality (like formal data types)

support of appends and updates without having to re-process multiple files

support of locking (or similar mechanism) to avoid inconsistency of updates coming from batch or stream

But on the other hand data lakes offer an extremely affordable and durable storage like Azure Storage or AWS S3, and are enablers of machine learning use cases.

Because of this, companies ended up having a mix of technologies: data lakes, data warehouses, streaming solutions, and others. But having multiple technologies increases the complexity, increases costs, and creates the need to copy data to multiple locations, which in turn increases latency and again costs, and from a security perspective it also increases the attack surface.

## Lakehouses

Lakehouse’s promise is to combine the best features of both data warehouses and data lakes. They are trying to enable data management features of data warehouses directly on low-cost storage (e.g Azure Storage, AWS S3) used by delta lakes.

Now I will get a bit more technical and more detailed, because this is the interesting part.

Imagine you are a retailer, you have a table called Items. This table has 9 million records. How would you store it in a data lake? One commonly used approach is with parquet files:

Maybe 18 files holding aprox. 0.5 MM records each. In a best case scenario, for this one table you’ll have to handle around 20 such files. There could even be 1,000 files representing the Items table in a suboptimal implementation. The point is that in a data lake you will end up with the “too many files” problem, sooner or later. Remember that in real life you will have more entities than just the items, which will contribute to having more files.

Now imagine you need to update 10,000 items (for example to add 1% to their price). You will need to find in which files those products are located, then delete the original files and write new ones instead. While this is happening, some processes could be trying to read those files but will fail. In other words, modifying existing data is very costly, complex and unreliable.

At some point you want to look back and determine when the price was changed and to which articles. In the data lake world, to keep a history of changes, you will need to create and maintain copies of the original files, which creates a significant overhead.

You may also want a streaming data flow to update the items, but at the same time there is a batch processes doing an update. And since there are no mechanism for locking, this is not feasible.

Since the computing that respond to queries goes “blindly” (without hints like indexes) and scan multiple or all the files, performance is not great in data lakes.

Lastly, all these pain points contribute to having poor data quality issues.

Lakehouse answers to the challenges above are:

ACID transactions: every operation is transactional. This means that every operation either fully succeeds or is aborted. When aborted, it is logged, and any residue is cleaned so you can retry later. Modification of existing data is possible because transactions allow you to do fine-grained updates. Real-time operations are consistent, and the historical data versions are automatically stored. The lakehouse also provides snapshots of data to allow developers to easily access and revert to earlier versions for audits, rollbacks, or experiment reproductions.

Indexing: a mechanism that helps the compute to read less files to find the needed information.

Schema validation: the data you put in the lakehouse must adhere to a defined schema. If data doesn’t adhere it can be moved to a quarantine and an automated notification sent out.

But how do you provide these features on top of cheap storage like the one of data lakes?

With file formats and frameworks like:

Delta Lake

Apache Iceberg

Apache Hudi

Etc.

You combine any of these formats with a compute engine like Spark and you get ACID transactions, indexing, versioning, etc. on top of automatically managed files stored in cheap storage from the data lake.

Going back to our Items table, if for example you choose Delta Lake, you will get a folder X containing the files with Items data. No need to worry about how many files, or nothing like that.

You can also have a catalog that will match table Items and the contents of folder X. Thanks to this, you can use SQL, or your preferred language, to query, update, insert or delete records without knowing the specific files. Now you have an actual table (like in RDBMS) but the storage is in a cheap and durable data lake.

There are other SaaS offerings like Snowflake, BigQuery, Etc. that provide same or even more features with storages prices as low as the ones offered by Datalakes. But if you use an open format like Delta Lake, Iceberg, etc. you can choose the engine that suits your needs bests.

This article is part I, in part II I will dig deeper in the different engines and formats.
