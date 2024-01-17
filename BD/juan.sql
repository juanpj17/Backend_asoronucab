CREATE OR REPLACE FUNCTION detalles_inventario_virtual_venta(dato TEXT)
RETURNS TABLE
(

	codigo INT,
	nombre VARCHAR(255),
	fecha VARCHAR(255),
	cantidad NUMERIC(10,0)
)
AS $$
	DECLARE
	mes INT;
	
BEGIN

	mes := validar_mes(dato);
	RAISE NOTICE 'Mes = %', mes;
	RETURN QUERY
		SELECT "pre_id", "pre_nombre", "ven_vir_est_fecha_fin", "det_ven_vir_pre_cantidad"
		FROM "Venta_Virtual" AS venta
		JOIN "Detalle_Venta_Virtual_Presentacion" AS detalle ON detalle."fk_venta_virtual" = venta."detallev_id"
		JOIN "Presentacion" AS pre ON pre."pre_id" = detalle."fk_presentacion"
		JOIN "Venta_Virtual_Estatus" AS estatus ON estatus."fk_venta_virtual" = venta."detallev_id"
		WHERE estatus."fk_estatus" = 7
			AND EXTRACT(MONTH FROM CAST(estatus."ven_vir_est_fecha_fin" AS timestamp)) = mes;
	
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION detalles_inventario_virtual_compra(dato TEXT)
RETURNS TABLE
(

	codigo INT,
	nombre VARCHAR(255),
	fecha TIMESTAMP(255),
	cantidad NUMERIC(10,0)
)
AS $$
	DECLARE
	mes INT;
	
BEGIN

	mes := validar_mes(dato);
	RAISE NOTICE 'Mes = %', mes;
	RETURN QUERY
		SELECT "pre_id", "pre_nombre", "com_estfecha_fin", "com_pre_cantidad"
		FROM "Compra" AS compra
		JOIN "Compra_Presentacion" AS detalle ON detalle."fk_compra" = compra."com_id"
		JOIN "Presentacion" AS pre ON pre."pre_id" = detalle."fk_presentacion"
		JOIN "Compra_Estatus" AS estatus ON estatus."fk_compra" = compra."com_id"
		WHERE estatus."fk_estatus" = 7
			AND EXTRACT(MONTH FROM CAST(estatus."com_estfecha_fin" AS timestamp)) = mes;
	
END;
$$ LANGUAGE plpgsql;
	
CREATE OR REPLACE FUNCTION validar_mes(dato TEXT)
RETURNS INTEGER AS $$
DECLARE
    mes INT;
BEGIN
    BEGIN
        mes := CAST(dato AS INTEGER);
    EXCEPTION
        WHEN others THEN
            BEGIN
                mes := EXTRACT(MONTH FROM TO_DATE(dato || ' 2022', 'Month YYYY'));
            EXCEPTION
                WHEN others THEN                
                    mes := CASE UPPER(dato)
                            WHEN 'ENERO' THEN 1
                            WHEN 'FEBRERO' THEN 2
                            WHEN 'MARZO' THEN 3
                            WHEN 'ABRIL' THEN 4
                            WHEN 'MAYO' THEN 5
                            WHEN 'JUNIO' THEN 6
                            WHEN 'JULIO' THEN 7
                            WHEN 'AGOSTO' THEN 8
                            WHEN 'SEPTIEMBRE' THEN 9
                            WHEN 'OCTUBRE' THEN 10
                            WHEN 'NOVIEMBRE' THEN 11
                            WHEN 'DICIEMBRE' THEN 12
                            ELSE 1  
                          END;
            END;
    END;
    RAISE NOTICE 'Mes = %', mes;
    RETURN mes;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE "actualizar_inventario_virtual"
( 
	codigo INT, 
	retirado NUMERIC, 
	reposicion NUMERIC 
)
AS $$
	DECLARE
	total NUMERIC(10,0);

BEGIN
	IF(reposicion = 0) THEN
		total := buscar_cantidad(codigo) - retirado;
		UPDATE "Inventario_Virtual_Presentacion"
		SET "inv_vir_pre_cantidad" = total
		WHERE "fk_presentacion" = codigo;
	ELSE
		UPDATE "Inventario_Virtual_Presentacion"
		SET "inv_vir_pre_cantidad" = reposicion
		WHERE "fk_presentacion" = codigo;
	END IF;

END;
$$ LANGUAGE plpgsql;

