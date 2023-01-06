# Introduction
Data modeling is crucial in computer science, as it helps us effectively store, retrieve, and analyze data. At its core, data modeling creates a data structure blueprint. This blueprint, also known as a data model, allows us to communicate the design and organization of our data and the relationships between different data entities. 
Whether you're a seasoned professional or just starting your data modeling journey, this introduction will provide you with a solid foundation and inspire you to delve deeper into this exciting field. So, let's get started!

## Data and Reality
I like to make the first distinction of data based on what they represent in the real world. Let's start with physical objects, for example, items (in a store), customers, vendors, etc. All these objects exist in reality; you can, at some point, see them or even touch them. These objects have attributes intrinsic to themselves. For example, a customer could have characteristics like Date of Birth, Name, Last Name, etc.
The other types of objects are more abstract concerning what they represent; they are usually bound to a specific time and involve one or more other objects. (or entities)

For example, we can model an invoice, another type of object, or an entity. The invoice describes a fact (on a date), an event that involves two other objects: Customer (John doe) and Item (The coffee). Notice that the invoice without Customer and Item does not make much sense. It requires a date, a customer, an item, an amount, and many other possibles thing to make sense. In other words, to describe an invoice, you need something like: On 4th January at 7:30, John Doe bought three large coffees for 9 dollars. (Date, Customer, Quantity, Total)

### Dimensions (or master data)
Objects that you can enumerate and exist by themselves. Usually, they represent a physical object (customer, item, etc.) but could be something abstract like a cost center, profit center, etc. 

These objects can have two primary types of attributes: non-time-dependant attributes (for example, the date of birth of a person) and time-dependent attributes (for instance, the last name of a person that can change for whatever reason during his lifetime).

These time-dependent attributes need to have a validity interval, for example:
From 03.12.1984, The name of the Person is John, until 03.12.2004 From 04.12.2004 until the end of time, the person's name is Juan.

### Facts (or Transactional data)
They represent an event on a specific date involving one or more dimensions. In transactional data, a new type of column is available: measures or key figures. 
Let's go back to the invoice example; the measures are Quantity = three, Amount = 9 dollars. These numeric columns are usually the ones you aggregate (sum) to see some totals. For example, sum the amount column for all invoices in one month to see how much you sold during that month.

## Excercise
I suggest you to write down at least ten dimensions and some of their attribtues and 3 Facts, to help you digest this content. Feel free to open issues and ask questions if you have any doubts. 

