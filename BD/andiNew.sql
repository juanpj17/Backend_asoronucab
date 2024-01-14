CREATE OR REPLACE FUNCTION obtenerVentasPorProducto(fecha_inicial timestamp, fecha_final timestamp) 
RETURNS TABLE
(
    fk_presentacion int,
    total_cantidad numeric
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        dvfp.fk_presentacion,
        SUM(dvfp.det_ven_fis_pre_cantidad) AS total_cantidad
    FROM
        "Venta_Fisica" vf
    JOIN
        "Detalle_Venta_Fisica_Presentacion" dvfp ON vf.ven_fis_id = dvfp.fk_venta_fisica
    WHERE
        vf.ven_fis_fecha BETWEEN fecha_inicial AND fecha_final
    GROUP BY
        dvfp.fk_presentacion;

END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION obtenerVentasPorCliente()
RETURNS TABLE
(
    fk_lugar int,
    cantidad_ventas bigINT
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        cn.fk_lugar,
        COUNT(*) AS cantidad_ventas
    FROM
        "Cliente_Natural" cn
    JOIN
        "Venta_Virtual" vv ON cn.per_nat_id = vv.fk_cliente_natural_1
    GROUP BY
        cn.fk_lugar
    ORDER BY
        cantidad_ventas DESC
    LIMIT
        10;

END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION obtenerVentasPorMes(fecha_inicial timestamp, fecha_final timestamp) 
RETURNS TABLE
(
    presentacion int,
    total_cantidad numeric
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        dvfp.fk_presentacion as presentacion,
        SUM(dvfp.det_ven_fis_pre_cantidad) AS total_cantidad
    FROM
        "Venta_Fisica" vf
    JOIN
        "Detalle_Venta_Fisica_Presentacion" dvfp ON vf.ven_fis_id = dvfp.fk_venta_fisica
    WHERE
        vf.ven_fis_fecha BETWEEN fecha_inicial AND fecha_final
    GROUP BY
        dvfp.fk_presentacion;

    -- Agregamos la lógica para Venta Virtual
    RETURN QUERY
    SELECT
        dvvp.fk_presentacion as presentacion,
        SUM(dvvp.det_ven_vir_pre_cantidad) AS total_cantidad
    FROM
        "Venta_Virtual" vv
	JOIN
        "Detalle_Venta_Virtual_Presentacion" dvvp ON vv.detallev_id = dvvp.fk_venta_virtual
    WHERE
        vv.detallev_fecha_venta BETWEEN fecha_inicial AND fecha_final
    GROUP BY
        dvvp.fk_presentacion;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtenerCantidadVentas(fecha_inicial varchar, fecha_final varchar)
RETURNS INTEGER
AS $$
DECLARE
    total_ventas INTEGER;
BEGIN
    SELECT
        COUNT(*) + (
            SELECT COUNT(*)
            FROM "Venta_Fisica_Estatus"
            WHERE fk_estatus = 3 AND ven_fis_est_fecha_ini BETWEEN fecha_inicial AND fecha_final
        ) AS total
    INTO
        total_ventas
    FROM "Venta_Virtual_Estatus"
    WHERE fk_estatus = 3 AND ven_vir_est_fecha_ini BETWEEN fecha_inicial AND fecha_final;

    RETURN total_ventas;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtenerTotalPuntos(fecha_inicial timestamp, fecha_final timestamp)
RETURNS NUMERIC
AS $$
DECLARE
    total_ventas NUMERIC;
BEGIN
    SELECT
        COALESCE(SUM(pmep.monto_parcial), 0) + 
        COALESCE((
            SELECT SUM(pemp."pag_ent_met_pag_Monto_parcial")
            FROM "Venta_Fisica_Entrada" vfe
            JOIN "Pago_Entrada_Metodo_Pago" pemp ON vfe.ven_fis_ent_id = pemp.fk_venta_fisica_entrada
            WHERE vfe.ven_fis_ent_fecha BETWEEN fecha_inicial AND fecha_final
            AND pemp.fk_mi_punto IS NOT NULL
        ), 0) INTO total_ventas
    FROM
        "Venta_Fisica" vf
    JOIN
        "Pago_Metodo_Pago" pmep ON vf.ven_fis_id = pmep.fk_venta_fisica
    WHERE
        vf.ven_fis_fecha BETWEEN fecha_inicial AND fecha_final
        AND pmep.fk_mi_punto IS NOT NULL;
    RETURN total_ventas;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtenerCantidadesPorEstatus(fecha_inicial varchar, fecha_final varchar)
RETURNS TABLE
(
    est_nombre VARCHAR(255),
    cantidad bigINT
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        est.est_nombre,
        COUNT(*) AS cantidad
    FROM
        "Venta_Virtual_Estatus" vve
    JOIN
        "Estatus" est ON vve.fk_estatus = est.est_id
    WHERE
        vve.ven_vir_est_fecha_ini BETWEEN fecha_inicial AND fecha_final
    GROUP BY
        est.est_nombre;

END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION contarOrdenesConFechaFinalNull(fecha_inicial varchar, fecha_final varchar)
RETURNS INTEGER
AS $$
DECLARE
    cantidad_ordenes INTEGER;
BEGIN
    SELECT
        COUNT(*)
    INTO
        cantidad_ordenes
    FROM
        "Venta_Virtual_Estatus"
    WHERE
        ven_vir_est_fecha_ini BETWEEN fecha_inicial AND fecha_final

        AND ven_vir_est_fecha_fin IS NULL; 

    RETURN cantidad_ordenes;
END;
$$ LANGUAGE plpgsql;
