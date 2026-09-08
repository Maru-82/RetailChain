¿Cuántas filas devuelve cada consulta y por qué son distintas?

La Consulta 1 con UNION devuelve 11 filas. 
La Consulta 2 con UNION ALL devuelve 14 filas. Las 7 filas de inventario_sucursal_norte más las 7 de inventario_sucursal_sur, sin eliminar ninguna.
La diferencia de 3 filas entre ambas consultas se explica por los productos 103 (Monitor 4K 27"), 104 (Teclado Mecánico) y 106 (SSD Externo 1TB), que existen en ambas sucursales con el mismo id_producto, nombre_producto y categoria. Como la Consulta 1 no incluye la columna stock, esas filas quedan idénticas entre sucursales y UNION las unifica; de las 14 filas de origen, se eliminan 3 duplicadas y quedan 11.
El caso de la Webcam HD 1080p aparece en ambas sucursales, pero con id_producto distinto (107 en Norte, 111 en Sur). Como el id_producto no coincide, SQL las trata como dos filas distintas y ninguna de las dos se elimina, aunque el nombre del producto sea idéntico.

¿Por qué UNION ALL es más eficiente que UNION?

UNION no solo junta los resultados de ambas consultas, también tiene que comparar todas las filas entre sí para detectar cuáles están repetidas y sacarlas. Esa comparación extra consume más tiempo y recursos, y se nota más cuanto más grandes son las tablas de origen.
UNION ALL junta los resultados de las dos consultas una debajo de la otra sin comparar nada. Al no tener que revisar si hay filas repetidas, es una operación más rápida y liviana.

¿En qué casos de negocio usarías cada uno?

UNION — Consolidar una lista de contactos de email para una campaña de marketing, cuando esos contactos vienen de dos fuentes distintas (por ejemplo, la base de clientes de e-commerce y la base de suscriptores del newsletter). Ahí interesa una lista única de direcciones de email, sin duplicados, para no enviarle el mismo mail dos veces a la misma persona.
UNION ALL — Consolidar los logs de transacciones de dos pasarelas de pago distintas para un cierre contable mensual. Ahí cada transacción tiene que contarse una sola vez y todas suman al total facturado, aunque dos transacciones tengan exactamente el mismo monto y la misma fecha por coincidencia — eliminar esas filas "duplicadas" haría que el cierre contable subestime la facturación real.

¿Qué pasa si las columnas de ambas consultas no coinciden en número o tipo?

Si el número de columnas no coincide (por ejemplo, la primera consulta selecciona 4 columnas y la segunda selecciona 3), devuelve un error de sintaxis antes de ejecutar.

Si el número de columnas coincide pero los tipos de dato son incompatibles entre sí (por ejemplo, una columna de texto en una parte del UNION contra una columna de fecha en la otra), SQL también devuelve un error, porque no puede convertir un tipo en el otro de forma implícita. Si los tipos son compatibles pero distintos (por ejemplo, INT en una parte y DECIMAL en la otra),no da error, sino que convierte automáticamente ambas columnas al tipo de mayor precisión para poder combinarlas, aunque eso puede cambiar cómo se ve el dato en el resultado final (por ejemplo, un entero mostrado con decimales).
