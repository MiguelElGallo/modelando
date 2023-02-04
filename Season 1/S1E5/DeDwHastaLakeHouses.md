# From Datawarehouses to Datalakes

En este artículo vamos a hablar de las diferencias entre los data warehouses, los data lakes y los data lakehouses, así como a profundizar en algunas de sus ventajas e inconvenientes.

## Data warehouses

En los años 80, los data warehouses eran la solución que proporcionaba un modelo arquitectónico para el flujo de datos desde los sistemas de registros, como los ERP, a los entornos de apoyo a la toma de decisiones, como SAP Business Warehouse, Oracle y otros.

Las herramientas de BI y elaboración de informes podían conectarse a los data warehouses para generar cuadros de mando e informes, y también para apoyar a los responsables de la toma de decisiones.

A medida que crecían los volúmenes de datos y aumentaba su complejidad (los datos se volvían semiestructurados, anidados, etc.), los data warehouses se enfrentaban a algunos retos:

Costes de mantenimiento elevados, principalmente costes de almacenamiento (almacenamiento propietario de alto rendimiento para un formato propietario).

No había soporte para casos de aprendizaje automático (machine learning), ya que sólo estaba pensado para BI e informes.

Falta de escalabilidad y flexibilidad para manejar diferentes complejidades de datos.

Estos retos, la nube y otros factores empezaron a dar forma a algo nuevo: el data lake.

## Data lakes

En los primeros días del movimiento de los data lakes, Hadoop era el componente principal. Hubo historias de éxito, hubo historias de fracaso, sin embargo, había comenzado una nueva era:

En muchos casos, las empresas pudieron sustituir el costoso data warehouse por clústeres informáticos internos que ejecutaban Hadoop de código abierto.

Esto permitió a las empresas analizar cantidades masivas de datos no estructurados (también llamados big data) de una forma que antes no era posible.

Hoy en día parece que Spark es quien lleva la batuta como motor de los data lakes. Pero, ¿cuáles son los nuevos retos que plantean los data lakes?

Carecen de algunas características básicas que estuvieron disponibles durante décadas en los RDBMS y data warehouses, tales como

soporte para transacciones

aplicación de la calidad de los datos (como tipos de datos formales)

soporte de anexos y actualizaciones (insert, update) sin tener que volver a procesar varios archivos

soporte de bloqueo (o mecanismo similar) para evitar la incoherencia de las actualizaciones procedentes de lotes o flujos.

Pero, por otro lado, los data lakes ofrecen un almacenamiento extremadamente asequible y duradero, como Azure Storage o AWS S3, y son facilitadores de casos de uso de aprendizaje automático.

Por eso, las empresas acaban teniendo una mezcla de tecnologías: data lakes, data warehouses, soluciones de streaming y otras. Pero disponer de múltiples tecnologías aumenta la complejidad, incrementa los costes y crea la necesidad de copiar los datos a múltiples ubicaciones, lo que a su vez aumenta la latencia y de nuevo los costes, y desde el punto de vista de la seguridad también aumenta la superficie de ataque.

## Lakehouses

La promesa de Lakehouse es combinar las mejores características tanto de los almacenes de datos como de los lagos de datos. Intentan habilitar las funciones de gestión de datos de los almacenes de datos directamente en el almacenamiento de bajo coste (por ejemplo, Azure Storage, AWS S3) que utilizan los lagos de datos.

Ahora me pondré un poco más técnico y más detallado, porque ésta es la parte interesante.

Imagina que eres un minorista y tienes una tabla llamada Artículos. Esta tabla tiene 9 millones de registros. ¿Cómo la almacenarías en un lago de datos? Un enfoque comúnmente utilizado es con archivos de parquet:

Tal vez 18 archivos que contengan aprox. 0,5 MM de registros cada uno. En el mejor de los casos, para esta única tabla tendrás que manejar unos 20 archivos de este tipo. Incluso podría haber 1.000 archivos representando la tabla Artículos en una implementación subóptima. La cuestión es que en un lago de datos acabarás encontrándote con el problema de "demasiados archivos", tarde o temprano. Recuerda que en la vida real tendrás más entidades además de los artículos, lo que contribuirá a tener más archivos.

Ahora imagina que necesitas actualizar 10.000 artículos (por ejemplo, para añadir un 1% a su precio). Tendrás que encontrar en qué archivos se encuentran esos productos, luego borrar los archivos originales y escribir otros nuevos en su lugar. Mientras esto ocurre, algunos procesos podrían estar intentando leer esos archivos, pero fallarán. En otras palabras, modificar los datos existentes es muy costoso, complejo y poco fiable.

En algún momento querrás mirar atrás y determinar cuándo se modificó el precio y a qué artículos. En el mundo de los lagos de datos, para mantener un historial de los cambios, tendrás que crear y mantener copias de los archivos originales, lo que genera una sobrecarga importante.

También es posible que quieras un flujo de datos en streaming para actualizar los artículos, pero al mismo tiempo hay un proceso por lotes realizando una actualización. Y como no existe ningún mecanismo de bloqueo, esto no es factible.

Como la informática que responde a las consultas va "a ciegas" (sin pistas como los índices) y escanea varios o todos los archivos, el rendimiento no es muy bueno en los lagos de datos.

Por último, todos estos puntos problemáticos contribuyen a tener problemas de mala calidad de los datos.

Las respuestas de Lakehouse a los retos anteriores son

Transacciones ACID: cada operación es transaccional. Esto significa que cada operación tiene éxito o se cancela. Cuando se aborta, se registra, y cualquier residuo se limpia para que puedas volver a intentarlo más tarde. La modificación de los datos existentes es posible porque las transacciones te permiten realizar actualizaciones detalladas. Las operaciones en tiempo real son coherentes, y las versiones históricas de los datos se almacenan automáticamente. También proporciona instantáneas de los datos para que los desarrolladores puedan acceder fácilmente a versiones anteriores y volver a ellas para auditorías, reversiones o reproducciones de experimentos.

Indexación: mecanismo que ayuda al ordenador a leer menos archivos para encontrar la información necesaria.

Validación de esquemas: los datos que introduces en la base de datos deben adherirse a un esquema definido. Si los datos no se adhieren, se pueden mover a una cuarentena y se envía una notificación automatizada.

Pero, ¿cómo proporcionar estas funciones sobre un almacenamiento barato como el de los lagos de datos?

Con formatos de archivo y marcos como

Delta Lake

Apache Iceberg

Apache Hudi

etc.

Combinas cualquiera de estos formatos con un motor de cálculo como Spark y obtienes transacciones ACID, indexación, versionado, etc. sobre archivos gestionados automáticamente y almacenados en un almacenamiento barato del lago de datos.

Volviendo a nuestra tabla Artículos, si por ejemplo eliges Delta Lake, obtendrás una carpeta X que contiene los archivos con datos de Artículos. No tendrás que preocuparte de cuántos archivos ni nada parecido.

También puedes tener un catálogo que hará coincidir la tabla Artículos y el contenido de la carpeta X. Gracias a esto, puedes utilizar SQL, o tu lenguaje preferido, para consultar, actualizar, insertar o eliminar registros sin conocer los archivos concretos. Ahora tienes una tabla real (como en un RDBMS), pero el almacenamiento está en un lago de datos barato y duradero.

Hay otras ofertas SaaS como Snowflake, BigQuery, etc. que proporcionan las mismas o incluso más prestaciones con precios de almacenamiento tan bajos como los que ofrece Datalakes. Pero si utilizas un formato abierto como Delta Lake, Iceberg, etc. puedes elegir el motor que mejor se adapte a tus necesidades.
