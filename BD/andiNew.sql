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


-------------------------NUEVAS----------------------------
CREATE OR REPLACE FUNCTION InsertarOfertaFunc(numero INT)
RETURNS VOID AS $$
BEGIN
    INSERT INTO "Oferta" (ofe_valor, ofe_fecha_inicio, ofe_fecha_final) 
    VALUES (numero, CURRENT_DATE, CURRENT_DATE + INTERVAL '10' DAY);

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_ultimo_id_oferta()
RETURNS INT AS $$
DECLARE
    ultimo_id INT;
BEGIN
    SELECT MAX(ofe_id) INTO ultimo_id FROM "Oferta";
    RETURN COALESCE(ultimo_id, 0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION buscar_oferta_producto(codigo INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    id_presentacion INT;
BEGIN
    SELECT pre_id INTO id_presentacion
    FROM "Presentacion"
    WHERE fk_producto = codigo 
    LIMIT 1;


    RETURN id_presentacion;
END;
$$;

CREATE OR REPLACE FUNCTION Insertar_pre_ofe(presentacion INT, oferta INT)
RETURNS VOID AS $$
BEGIN
    INSERT INTO "Presentacion_Oferta" (pre_ofe_valor, fk_presentacion, fk_oferta) 
    VALUES (1, presentacion, oferta);

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE agregarOferta(
    IN descuento INT,
    IN producto INT
)
AS $$
DECLARE
    ultimo_id_oferta INT;
    id_presentacion INT;
BEGIN
	PERFORM insertarofertafunc(descuento);
  
    SELECT obtener_ultimo_id_oferta() INTO ultimo_id_oferta;

    id_presentacion := buscar_oferta_producto(producto);

    PERFORM Insertar_pre_ofe(id_presentacion,ultimo_id_oferta);
   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION ObtenerOfertasVigentes()
RETURNS TABLE(ofe_id INT , id_pro INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT ofe.ofe_id
    FROM "Presentacion_Oferta" po
    JOIN "Oferta" ofe ON ofe.ofe_id = po.fk_oferta
	JOIN "Presentacion" pre ON pre.pre_id = po.fk_presentacion
    WHERE CURRENT_DATE BETWEEN ofe.ofe_fecha_inicio AND ofe.ofe_fecha_final;
END;
$$;

CREATE OR REPLACE VIEW ofertas_vista AS
SELECT 
    pr.pro_codigo, 
    pr.pro_nombre, 
    pr.pro_grados_alcohol, 
    pr.pro_descripcion, 
    pr.pro_tipo, 
    pr.fk_lugar, 
    pr.fk_categoria, 
    pr.fk_variedad,
    i.ima_url,
    b.bot_capacidad,
    inv.inv_vir_precio,
    subquery.ofe_valor 
FROM "Producto" pr
JOIN "Imagen" i ON i."fk_producto" = pr."pro_codigo"
JOIN "Presentacion" pre ON pre."fk_producto" = pr."pro_codigo"
JOIN "Botella" b ON b."bot_id" = pre."fk_material_botella_3"
JOIN "Inventario_Virtual_Presentacion" inv ON inv."fk_presentacion" = pre."pre_id"
JOIN (
    SELECT presub.fk_producto, ofe.ofe_valor
    FROM "Presentacion_Oferta" po
    JOIN "Oferta" ofe ON ofe.ofe_id = po.fk_oferta
    JOIN "Presentacion" presub ON presub.pre_id = po.fk_presentacion
    WHERE CURRENT_DATE BETWEEN ofe.ofe_fecha_inicio AND ofe.ofe_fecha_final
) subquery ON subquery.fk_producto = pr.pro_codigo;
