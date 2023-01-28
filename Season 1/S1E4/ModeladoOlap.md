# S1E4 - Modelado OLAP

Los Datawarehouses son necesarios, para hacer consultas eficaces de los datos empesariales y suelen almacenar datos históricos de diversas fuentes, como sistemas transaccionales, sistemas de apoyo a las operaciones y fuentes de datos externas. El concepto de Datawarehouse se introdujo por primera vez a finales de los años 80, cuando las empresas empezaron a darse cuenta del valor de analizar grandes cantidades de datos de distintas fuentes para tomar mejores decisiones empresariales. Desde entonces, el campo de Datawarehousing ha seguido evolucionando, con el desarrollo de nuevas tecnologías y técnicas para mejorar el rendimiento y la escalabilidad de los almacenes de datos. Hoy en día, los Datawarehouses son un componente fundamental de la infraestructura de BI de muchas organizaciones y sirven de apoyo a muchas funciones empresariales, como las finanzas, el marketing y las operaciones.

En otras palabras:

Múltiples fuentes (sistemas de registros, OLTP) --->Datos---> Almacén de datos (típicamente OLAP)

Sabemos por S1E3 las técnicas que puedes utilizar para modelar OLTP (utilizando bases de datos relacionales), pero ¿qué pasa con OLAP o los almacenes de Datos? 

## Datawarehouses 
Una ilustración simplificada de la "Arquitectura" de los data mart independientes. Estos silos analíticos independientes representan un Datawarehouse que, en esencia, no está arquitecturado. Aunque nadie presiona para que se aplique este enfoque, ocurre en todas partes. Las herramientas de BI de autoservicio sin una gobernanza adecuada son un catalizador de este enfoque. 

![DataMarts](/Season%201/S1E4/images/datamarts.png)

## Inmon (Fábrica de Información Corporativa Hub-and-Spoke)
Aquí los datos se extraen del sistema de registros y aterrizan en una base de datos 3NF(Tercera forma normal, ver temporadas anteriores) conocida como EDW (Almacén de Datos Empresariales - Enterprise Data Warehouse). Los data marts pueden estructurarse dimensionalmente, pero difieren de la arquitectura Kimball porque están centrados en los departamentos y no en los procesos empresariales. Los usuarios consultarán el EDW para obtener los datos más detallados; sin embargo, el ETL posterior también rellena los marts de datos.

![Inmon](/Season%201/S1E4/images/Inmon.png)

## Kimball (arquitectura Datawarehouse)
Los datos del área de presentación deben ser dimensionales, atómicos (pueden tener agregados para mejorar el rendimiento), centrados en los procesos empresariales y adherirse a la arquitectura de bus del almacén de datos de la empresa. NO debes estructurar los datos según la interpretación que de ellos hagan los distintos departamentos.

![Kimball](/Season%201/S1E4/images/Kimball.png)

## Híbrido (Kimball + Inmon)
Hay gente que afirma que es lo mejor de ambos mundos. 

![Híbrido](/Season%201/S1E4/images/Hybrid.png)

## Datavault

Te invito a que consultes este [enlace](https://datavaultalliance.com/news/building-a-real-time-data-vault-in-snowflake/) donde encontrarás la arquitectura de Datavault. Este diagrama tiene un sesgo de proveedor tecnológico, pero no he podido encontrar ningún otro de la Data Vault Alliance.
