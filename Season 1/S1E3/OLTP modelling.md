# OLTP model and design

We know from S1E2 that there are OLTP, OLAP, and HTAP systems. We know from S1E1 that we can model data into dimensions and fact tables. As you may have guessed, how to model the data differs if you build an OLAP or OLTP system.

The data modeling for OLTP usually goes like this:

• Create an Entity Relationship model. (ERD)

• Convert that ERD into database tables

• Apply the Normal forms

All these concepts are ancient (from the '70 '80s) but are still valid today for relational databases.

## The Entity-relationship model (ERD)

In 1976, Peter Chen Published The entity-relationship model—toward a unified view of data.
You can read the original paper [here](https://dl.acm.org/doi/10.1145/320434.320440).

An example of an ERD follows:

![ERD Example](/Season%201/S1E3/images/ERD1.png)

Here we can see two main types:
Entities: Customer, Item
Relationships: buys

For entities and relationship attributes are represented as ovals. (ID, Name) (date, quantity) (Number, description, price)
For a complete list of symbols you can use in an ERD, see [here](https://www.inf.usi.ch/faculty/soule/teaching/2014-spring/02_Modeling_Enterprise_With_ER_Diagrams.pdf).

We can also see in the diagram that the relationship type is m:n, meaning an m number of customers can buy and n number of items.

Once you have drawn the ERD, you can convert it to relational database tables. For the entities, the process is pretty simple. For each entity, there would be a table. It gets more enjoyable for the relationships:
Since the relationship is m:n, the relationship will become a new table.
All the rules are described [here](https://pressbooks.pub/cmiller1137/chapter/implementing-entity-relationship-diagrams/).

## The normal forms

Around the same time, Edgar Frank "Ted" Codd, considered the father of relational databases, published a paper called "[A Relational Model of Data for Large Shared Data Banks](https://www.seas.upenn.edu/~zives/03f/cis550/codd.pdf)".

Some years later (1983), another paper was presented: [A Simple Guide to Five Normal Forms in Relational Database Theory.](https://dl.acm.org/doi/10.1145/358024.358054).

You can read all the normal forms from that link; I would put here a description of the third normal form (3NF):

Third normal form is violated when a nonkey field is a fact about another nonkey field, as in

```
| EMPLOYEE    | DEPARTMENT | LOCATION |
|-------------|------------|----------|
| (KEY FIELD) |            |          |
```

The EMPLOYEE field is the key. If each department is located in one place, then the LOCATION field is a fact about the DEPARTMENT.In addition to being a fact about the EMPLOYEE.
The problems with this design are the same as those caused by violations of the second normal form.
• The department's location is repeated in the record of every employee assigned to that department.
• If the department's location changes, every such record must be updated.
• Because of the redundancy, the data might become inconsistent, e.g., different records showing different locations for the same department.
• If a department has no employees, there may be no record in which to keep the department's location.

To satisfy third normal form, the record shown above should be decomposed into two records:

```
| EMPLOYEE    | DEPARTMENT | 
|-------------|------------|
| (KEY FIELD) |            |

| DEPARTMENT  | LOCATION |
|-------------|----------|
| (KEY FIELD) |          |
```

To summarize, a record is in second and third normal forms if every field is either part of the key or provides a (single-valued) fact about exactly the whole key and nothing else.

You can use ERD and Normal forms to have a clean design for a relational database (OLTP). In the next episode, we will examine the techniques for designing OLAP databases.
