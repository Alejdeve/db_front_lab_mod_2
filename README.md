# midterm modulo 2 Bases de datos.
## Por: Manuel Alejandro Garcia Rojas.

Soy Estudiante de Ironhack, vivo en Vilanova I la Geltrú, soy de Colombia, estudie Marketing e investigacion de mercados y Marketing digital, inicie un grado superior en DAW el cual no termine, pero me dejo bases y muchas ganas de aprender todo lo relacionado a este mundo dela programacion y el desarrollo de aplicaciones web y espero que este proyecto sea el primer paso de algo grande.

### Proyecto:

Este proyecto va de la implementación de una base de datos a una página web que se dedica a la venta de artículos para bebes, todo lo de ropa, calzado y juguetes, como la página web no maneja stock ya que los productos que vende son producto de otras marcas y almacenes utilizando el modelo de marketing de afiliados, vamos a crear una base de datos de tips y trucos para los usuarios de las páginas, donde ellos puedan dar sus experiencias y recomendaciones como padres y también, buscar soluciones o concejos de otros padres, solo buscando en nuestra pagina con la duda o problema que tengan.

## PequeShop

### Creación de la base de datos:

### 1. Crear una base de datos llamada BabyStore.

### Tablas:

Customers: Información sobre los clientes.
Products: Información sobre los productos.
Orders: Información sobre los pedidos realizados por los clientes.
OrderDetails: Información detallada de los productos incluidos en cada pedido.
Tips: Consejos para padres primerizos proporcionados por otros clientes.

### Relaciones entre tablas:

One-to-One: Relación entre Customers y Tips (cada cliente puede dejar un único tip).
One-to-Many: Relación entre Customers y Orders (un cliente puede hacer múltiples pedidos).
Many-to-Many: Relación entre Products y Orders a través de OrderDetails.
Bidireccional: Implementaremos las relaciones para que puedan ser navegadas en ambas direcciones.

### Consultas y funcionalidades:

Creación de consultas simples y complejas.
Triggers para mantener integridad y consistencia de datos.
Uso de transacciones para operaciones críticas.
Definición de funciones personalizadas.