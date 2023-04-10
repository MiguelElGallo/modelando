# The unified star schema

As we saw in [S1E4](https://github.com/MiguelElGallo/modelando/blob/main/Season%201/S1E4/OlapModelling.md), Ralf Kimball published almost 30 years ago the foundation of dimensional modeling.

Then Francesco Puppini joined forces, and in 2020 they published the [Unified Star Schema](https://www.amazon.com/Unified-Star-Schema-Resilient-Warehouse/dp/163462887X) (USS). Get the book if you work with dimensional modeling. Even if you do not take the road of USS, there is a lot of helpful material in the book, like Fan and Chasm Traps, etc.

I recommend you watch [this video](https://www.ukdatavaultusergroup.co.uk/bill-inmon-francesco-puppini-building-the-unified-star-schema/) to get an idea of the way of the USS.

If you want to explore the USS, here is a simple [SQL script ](https://github.com/MiguelElGallo/modelando/blob/main/Season%202/S2E3/uss.sql)that creates the "bridge" table as a view in Snowflake. You only need a free Snowflake account and run the script.

I also welcome improvements to the bridge table (to include other tables, etc.). The idea is to have a bridge table for people to try the USS in a well know model like TPCH.
