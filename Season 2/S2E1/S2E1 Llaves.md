# LLaves o Claves

"The key, the whole key, and nothing but the key, so help me, Codd."

En la S1E3, presentamos a Edgar Frank "Ted" Codd, considerado el fundador de las bases de datos relacionales. Y esta es una cita famosa relacionada con las claves primarias.

Una clave primaria en las bases de datos OLTP y relacionales es vital, y todas las bases de datos relacionales soportan una clave primaria.

Como explican Bill Inmon y Francesco Puppin en su libro El esquema estrella unificado,
El término "clave primaria" puede generar un poco de confusión porque, en el mundo de las bases de datos relacionales, puede tener un significado específico de "clave primaria forzada": un mecanismo que produce un error cuando se viola la unicidad de la clave.

Si consultamos la documentación de productos como Snowflake o Databricks, veremos afirmaciones como ésta

"Snowflake permite definir y mantener restricciones, pero no las impone, excepto las restricciones NOT NULL, que siempre se imponen".

<https://docs.snowflake.com/en/sql-reference/constraints-overview>

"Las restricciones informativas de clave primaria y clave externa codifican las relaciones entre los campos de las tablas y no se aplican".
<https://docs.databricks.com/tables/constraints.html>

En ambos productos (y en muchos otros), vemos que no aplican la clave primaria, sino que esa responsabilidad se deja a los procesos que escriben los datos.

Esta diferencia en la forma en que los motores de almacén de datos gestionan la clave primaria sugiere que quizá necesitemos un enfoque diferente para gestionar las claves en los almacenes de datos y los datamarts (principalmente OLAP).

## Clave natural / Clave comercial (Natural Key / Business Key)

Patrick Cuba, en su libro El Gurú de la Bóveda de Datos (Data Vault) , define:

¿Qué son las claves naturales? ¿Cómo identifica la empresa a una entidad individual, ya sea un cliente, un producto, una cuenta, un contrato, un taller o una fábrica? Son valores únicos que se utilizan dentro de la empresa y, a veces, fuera de ella, en las conversaciones con clientes, proveedores de servicios, socios, etc. Identifican aquello sobre lo que queremos realizar transacciones o con lo que queremos realizar transacciones, rastrean de forma única las cosas que hacen viable un negocio, sobre las que puede ser necesario elaborar informes reglamentarios, y se utilizan para identificar de forma única a una persona, empresa, cuenta, producto o cosa por su valor para la empresa.

Para el tema que nos ocupa, estos valores identificativos tienen un significado, y la bóveda de datos rastrea todo lo que rodea a esas claves historizando los datos sobre esas cosas y proporcionando la pista de auditoría sobre todo lo que sabemos de la
cosa.

En la bóveda de datos, las claves naturales son nuestras candidatas a claves empresariales de primera elección; en la terminología de Kimball, se denominan claves naturales porque, durante la vida probable de una entidad empresarial, podemos identificar de forma única a esa entidad mediante esa clave. La entidad empresarial puede estar representada por claves diferentes según el sistema o plataforma de origen, siempre que mantenga el mismo grano semántico.

Otras claves significativas incluyen cosas como números de identificación de vehículos, números de vuelo, número de orden de compra, códigos de barras, SKU; verás que éstas son las claves de identificación única que probablemente utilizarás cuando interactúes para hacer negocio. Son las claves empresariales de primera elección en la bóveda de datos.

Una prueba para identificar una clave comercial es ésta:
¿Puede el valor de la clave, sin ningún otro atributo, identificar una cosa de forma única?

- ¿La clave sin otro atributo se traduce en un área de importancia dentro de una empresa?
Al rastrear información sobre un cliente o una cuenta, ¿cuál es el número de identificación único al que está vinculada la cosa?
Utilizamos claves naturales todos los días, el número de cuenta que utilizamos para recargar nuestra tarjeta de transporte público, el número de cuenta donde se rastrean los detalles de nuestras facturas de servicios públicos, el número de cuenta bancaria donde se guardan nuestros fondos disponibles.
Algunas claves se comparten y otras se asignan exclusivamente a un cliente. Algunas claves naturales son altamente confidenciales, y otras incluyen una lógica incorporada que nos dice más cosas sobre esa clave.

## Claves hash

Las claves hash son claves sustitutas duraderas que pretenden optimizar la carga y la distribución de datos, pero no sirven estrictamente para optimizar la elaboración de informes.

En los almacenes de datos (data warehouses) no se trata de transacciones como en los sistemas OLTP o sistemas de registros. Supongamos que un cliente modifica la cantidad de un pedido en un sistema OLTP. En ese caso, debe producirse una actualización en un registro concreto (el pedido de ese cliente debe actualizarse utilizando una clave primaria que identifique el pedido).

Desde el punto de vista del almacén de datos, recibiremos una versión más reciente del pedido desde el sistema fuente. Normalmente, los almacenes de datos guardan instantáneas de los datos del sistema fuente. Podemos ver que la restricción de clave primaria ya no es crítica; no pasa nada por tener dos pedidos con la misma clave de negocio en el almacén de datos; dependiendo de tu metodología, existen distintos métodos.

 El método más intuitivo es ordenar por la última fecha de ingesta y encontrar el primer registro para cada clave de negocio. Por ejemplo, habrá dos registros con la misma clave de negocio (número de pedido) en los pedidos, y elegiremos el que tenga la última fecha de ingesta.

Dependiendo de la técnica de modelado y de los requisitos empresariales, existen técnicas más avanzadas, como la tabla PIT (Point in time table) de la bóveda de datos.

En otras palabras, lee la documentación de tu metodología (Kimball, Bóveda de datos, etc.) para encontrar las prácticas recomendadas para tratar las claves en OLAP. (Almacenes de datos, data marts, etc.)

Dado que puedes estar tratando con múltiples sistemas fuente o que los sistemas fuente serán sustituidos, los enfoques más comunes para tratar las claves incluyen estos pasos

Prepara la clave de negocio
Ceros iniciales o finales, mayúsculas y minúsculas (convertir todo a mayúsculas), espacios, etc.
Las claves empresariales de varias columnas pueden concatenarse en una sola
Aplica un hashing o una secuencia para crear una nueva clave.

El rendimiento también es algo a tener en cuenta; el tipo de datos que elijas para tus claves (que se utilizarán para hacer las uniones) sí importa.

He encontrado este interesante blog sobre tipos de datos y rendimiento en las uniones para el formato Delta Lake:
<https://www.confessionsofadataguy.com/data-types-in-delta-lake-spark-join-performance-and-thoughts/>
