# Modelo y diseño OLTP

Sabemos por S1E2 que existen sistemas OLTP, OLAP y HTAP. Sabemos por S1E1 que podemos modelar los datos en dimensiones y tablas de hechos. Como habrás adivinado, la forma de modelar los datos difiere si construyes un sistema OLAP u OLTP.

El modelado de datos para OLTP suele ser así:

- Crear un modelo Entidad Relación (ERD)

- Convierte ese ERD en tablas de base de datos

- Aplicar las formas normales

Todos estos conceptos son antiguos (de los años 70-80), pero siguen siendo válidos hoy en día para las bases de datos relacionales.

## El modelo Entidad-Relación (ERD)

En 1976, Peter Chen publicó El modelo entidad-relación-hacia una visión unificada de los datos.
Puedes leer el documento original [aquí](https://dl.acm.org/doi/10.1145/320434.320440).

A continuación se muestra un ejemplo de un ERD:

![Ejemplo de ERD](/Season%201/S1E3/images/ERD1.png)

Aquí podemos ver dos tipos principales:
Entidades: Cliente, Artículo
Relaciones: compras

Para las entidades y las relaciones, los atributos se representan como óvalos. (ID, Nombre) (fecha, cantidad) (Número, descripción, precio)
Para obtener una lista completa de los símbolos que puedes utilizar en un ERD, consulta [aquí](https://www.inf.usi.ch/faculty/soule/teaching/2014-spring/02_Modeling_Enterprise_With_ER_Diagrams.pdf).

También podemos ver en el diagrama que el tipo de relación es m:n, lo que significa que un número m de clientes pueden comprar un número n de artículos.

Una vez dibujado el ERD, puedes convertirlo en tablas de base de datos relacional. Para las entidades, el proceso es bastante sencillo. Para cada entidad, habría una tabla. La cosa se pone más entretenida para las relaciones:
Como la relación es m:n, la relación se convertirá en una nueva tabla.
Todas las reglas se describen [aquí](https://pressbooks.pub/cmiller1137/chapter/implementing-entity-relationship-diagrams/).

## Las formas normales

Por la misma época, Edgar Frank "Ted" Codd, considerado el padre de las bases de datos relacionales, publicó un artículo titulado "[Un modelo relacional de datos para grandes bancos de datos compartidos](https://www.seas.upenn.edu/~zives/03f/cis550/codd.pdf)".

Unos años más tarde (1983), se presentó otro documento: [Una guía sencilla de cinco formas normales en la teoría de las bases de datos relacionales](https://dl.acm.org/doi/10.1145/358024.358054).

Puedes leer todas las formas normales desde ese enlace; yo pondría aquí una descripción de la tercera forma normal (3NF):

La tercera forma normal se viola cuando un campo no clave es un hecho sobre otro campo no clave, como en

```
| EMPLEADO | DEPARTAMENTO | UBICACIÓN |
|-------------|------------|----------|
|(CAMPO CLAVE)|            |          | 
```

El campo EMPLEADO es la clave. Si cada departamento está ubicado en un lugar, entonces el campo UBICACIÓN es un dato sobre el DEPARTAMENTO, además de ser un dato sobre el EMPLEADO.
Los problemas de este diseño son los mismos que los causados por las violaciones de la segunda forma normal.

- La ubicación del departamento se repite en el registro de cada empleado asignado a ese departamento.
- Si cambia la ubicación del departamento, hay que actualizar cada uno de esos registros.
- Debido a la redundancia, los datos pueden resultar incoherentes, por ejemplo, distintos registros que muestren distintas ubicaciones para el mismo departamento.
- Si un departamento no tiene empleados, puede que no haya ningún registro en cual guardar la ubicación del departamento.

Para satisfacer la tercera forma normal, el registro anterior debe descomponerse en dos registros:

```
| EMPLEADO     | DEPARTMENTO| 
|--------------|------------|
|(CAMPO CLAVE) |            | 


| DEPARTMENTO  | UBICACIÓN|
|--------------|----------|
|(CAMPO CLAVE) |          |
```

En resumen, un registro está en segunda y tercera formas normales si cada campo forma parte de la clave o proporciona un dato (de un solo valor) sobre exactamente toda la clave y nada más.

Puedes utilizar el ERD y las formas normales para tener un diseño limpio de una base de datos relacional (OLTP). En el próximo episodio, examinaremos las técnicas para diseñar bases de datos OLAP.
