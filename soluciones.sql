-- ══════════════════════════════════════════
-- RetailChain — UNION y UNION ALL
-- Autor: Marina Mónaco
-- Fecha: 08-09-26
-- ══════════════════════════════════════════

-- ── CONSULTA 1: UNION ────────────────────
-- Reporte de Catálogo Unificado
-- Pregunta de negocio: ¿Qué productos únicos comercializa
-- la empresa en toda su red de sucursales?
-- Operador: UNION (elimina filas completamente duplicadas)

SELECT id_producto, nombre_producto, categoria
FROM inventario_sucursal_norte
UNION
SELECT id_producto, nombre_producto, categoria
FROM inventario_sucursal_sur
ORDER BY id_producto;
-- No se incluye la columna stock para responder la pregunta de negocio.
-- Si se incluyera stock, UNION no eliminaría ningún duplicado, porque los
-- productos 103, 104 y 106 tienen stock distinto en cada sucursal


-- ── CONSULTA 2: UNION ALL ────────────────
-- Auditoría de Stock Total
-- Pregunta de negocio: ¿Cuántos registros físicos de stock
-- existen en total entre ambas sucursales?
-- Operador: UNION ALL (mantiene todos los registros incluyendo duplicados)

SELECT id_producto, nombre_producto, categoria, stock
FROM inventario_sucursal_norte
UNION ALL
SELECT id_producto, nombre_producto, categoria, stock
FROM inventario_sucursal_sur
ORDER BY id_producto;
-- Se incluyen todas las columnas, porque la pregunta de negocio es sobre el stock
-- físico real de cada sucursal, no sobre el catálogo de productos únicos.
-- UNION ALL mantiene las 14 filas (7 de Norte + 7 de Sur) sin eliminar
-- ninguna, incluyendo los productos 103, 104 y 106 una vez por cada
-- sucursal con su stock propio.

-- ── CONSULTA 3: COMPARACIÓN DE RESULTADOS ─
-- Ejecutá estas dos consultas para comparar cuántas filas
-- devuelve cada operador y explicá la diferencia en tu README

SELECT COUNT(*) AS filas_union
FROM (
    SELECT id_producto, nombre_producto, categoria
    FROM inventario_sucursal_norte
    UNION
    SELECT id_producto, nombre_producto, categoria
    FROM inventario_sucursal_sur
) AS resultado_union;

SELECT COUNT(*) AS filas_union_all
FROM (
    SELECT id_producto, nombre_producto, categoria, stock
    FROM inventario_sucursal_norte
    UNION ALL
    SELECT id_producto, nombre_producto, categoria, stock
    FROM inventario_sucursal_sur
) AS resultado_union_all;
-- filas_union = 11 (14 filas de origen − 3 duplicadas eliminadas: productos
-- 103, 104 y 106, que coinciden en id, nombre y categoría entre sucursales).
-- filas_union_all = 14 (las 7 filas de Norte + las 7 filas de Sur, sin
-- eliminar ninguna).
