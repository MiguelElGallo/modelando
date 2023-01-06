# Introducción
El modelado de datos es crucial en informática, ya que nos ayuda a almacenar, recuperar y analizar datos de manera efectiva. En esencia, el modelado de datos crea un modelo de estructura de datos. Este modelo, también conocido como modelo de datos, nos permite comunicar el diseño y la organización de nuestros datos y las relaciones entre diferentes entidades de datos.
Tanto si es un profesional experimentado como si acaba de empezar su viaje de modelado de datos, esta introducción le proporcionará una base sólida y le inspirará para profundizar en este apasionante campo. ¡Entonces empecemos!

## Datos y Realidad
Me gusta hacer la primera distinción de datos en función de lo que representan en el mundo real. Comencemos con los objetos físicos, por ejemplo, artículos (en una tienda), clientes, proveedores, etc. Todos estos objetos existen en la realidad; puedes, en algún momento, verlos o incluso tocarlos. Estos objetos tienen atributos intrínsecos a ellos mismos. Por ejemplo, un cliente podría tener características como Datos de Nacimiento, Nombre y Apellido, etc. Me gusta hacer la primera distinción de datos en función de lo que representan en el mundo real. Todos estos objetos existen en la realidad; puedes, en algún momento, verlos o incluso tocarlos. Estos objetos tienen atributos intrínsecos a ellos mismos. Por ejemplo, un cliente podría tener características como fecha de nacimiento, nombre y apellido, etc.
Los otros tipos de objetos son más abstractos en cuanto a lo que representan; generalmente están vinculados a un tiempo específico e involucran uno o más objetos. (o entidades)

Por ejemplo, podemos modelar una factura. La factura describe un hecho (en una fecha), un evento que involucra a otros dos objetos: Cliente (Juan Pérez) y Artículo (El café). Note que la factura sin Cliente y Artículo no tiene mucho sentido. Requiere una fecha, un cliente, un artículo, una cantidad y muchas otras cosas para que tenga sentido. En otras palabras, para describir una factura, se necesita algo como: El 4 de enero a las 7:30, Juan Pérez compró tres cafés grandes por 9 pesos. (Fecha, Cliente, Cantidad, Total)

### Dimensiones (o datos maestros)
Objetos que puedes enumerar y existen por sí mismos. Por lo general, representan un objeto físico (cliente, artículo, etc.) pero pueden también ser algo abstracto como un centro de costos, un centro de ganancias, etc.

Estos objetos pueden tener dos tipos principales de atributos: atributos no dependientes del tiempo (por ejemplo, la fecha de nacimiento de una persona) y atributos dependientes del tiempo (por ejemplo, el apellido de una persona que puede cambiar por cualquier motivo durante su vida).

Estos atributos dependientes del tiempo deben tener un intervalo de validez, por ejemplo:
Desde el 12.03.1984, El nombre de la Persona es Hugo, hasta el 12.03.2004 Desde el 12.04.2004 hasta el final de los tiempos, la persona se llama Juan.

### Hechos (o datos transaccionales)
Representan un evento en una fecha específica que involucra una o más dimensiones. En datos transaccionales, está disponible un nuevo tipo de columna: indicadores o cifras clave.
Volvamos al ejemplo de la factura; las medidas son Cantidad = tres, Importe = 9 pesos. Estas columnas numéricas suelen ser las que agregas (suma) para ver algunos totales. Por ejemplo, sumá la columna de cantidad de todas las facturas en un mes para ver cuánto vendió durante ese mes.

## Ejercicio
Te sugiero que escribas al menos diez dimensiones y algunos de sus atributos y 3 hechos, para ayudarte a digerir este contenido. Siéntete libre de abrir problemas y hacer preguntas si tiene alguna duda usando la funcionalidad de GitHub.