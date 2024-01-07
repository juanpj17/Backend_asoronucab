-- CREE ESTE ARCHIVO PQ SE ME BORRARON VARIAS FUNCIONESS

CREATE OR REPLACE FUNCTION obtener_proveedores()
RETURNS TABLE (
    proveedor_id INT,
    nombre VARCHAR,
    direccion VARCHAR,
    telefono VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        proveedor_id,
        nombre,
        direccion,
        telefono
    FROM
        "Proveedores";
END;
$$ LANGUAGE plpgsql;


-- FUNCTION: public.insertar_evento(character varying, character varying, integer, timestamp without time zone, timestamp without time zone, character varying, integer)

-- DROP FUNCTION IF EXISTS public.insertar_evento(character varying, character varying, integer, timestamp without time zone, timestamp without time zone, character varying, integer);

CREATE OR REPLACE FUNCTION public.insertar_evento(
	nomb character varying,
	descrip character varying,
	entradas integer,
	fh_i timestamp without time zone,
	fh_f timestamp without time zone,
	direccion character varying,
	parroquia integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

declare mensaje varchar;
declare Fnombre boolean;
begin
  Fnombre:= REPLACE(nomb, ' ', '') !~ '[^0-9A-Za-z]';
  	if (REPLACE(nomb, ' ', '')='' or REPLACE(descrip, ' ', '')='' or REPLACE(direccion, ' ', '')='' )then
		mensaje:='Hay campos sin llenar en su registro';
	else 
		if not Fnombre  then 
			mensaje:='No se aceptan caracteres especiales en el nombre del evento';
		else 
			mensaje:='Registro Exitoso';
			INSERT INTO public."Evento"(
		 	eve_nombre, eve_descripcion, eve_cantidad_entradas, eve_fecha_hora_inicial, eve_fecha_hora_final, eve_direccion,fk_lugar)
			VALUES (nomb,descrip,entradas,fh_i,fh_f,direccion,parroquia);
		end if;
	end if;
return mensaje;
end;
$BODY$;

ALTER FUNCTION public.insertar_evento(character varying, character varying, integer, timestamp without time zone, timestamp without time zone, character varying, integer)
    OWNER TO postgres;




CREATE OR REPLACE FUNCTION obtener_cantidad_entrada(codigo INT)
RETURNS TABLE (precio numeric) AS $$
BEGIN
   RETURN QUERY
   SELECT ent_precio
   FROM "Entrada"
   WHERE fk_evento = codigo;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_ultimo_id_venta_fisica()
RETURNS INT AS $$
DECLARE
    ultimo_id INT;
BEGIN
    SELECT MAX(ven_fis_id) INTO ultimo_id FROM "Venta_Fisica";
    RETURN COALESCE(ultimo_id, 0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insertar_venta_fisica(
    total NUMERIC(12, 3),
    cod_cliente_natural_1 INT,
    cod_cliente_natural_2 VARCHAR(16),
    cod_empleado_1 INT,
    cod_empleado_2 VARCHAR(16),
    cod_cliente_juridico VARCHAR(16),
    cod_inventario_1 INT,
    cod_inventario_2 INT,
    cod_inventario_3 INT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO "Venta_Fisica"(
        ven_fis_fecha,
        ven_fis_total,
        fk_fisica,
        fk_cliente_natural_1,
        fk_cliente_natural_2,
        fk_cliente_juridico,
        fk_empleado_1,
        fk_empleado_2,
        fk_infp_1,
        fk_infp_2,
        fk_infp_3
    )
    VALUES (
        NOW(),
        total,
        1,
        cod_cliente_natural_1,
        cod_cliente_natural_2,
        cod_cliente_juridico,
        cod_empleado_1,
        cod_empleado_2,
        cod_inventario_1,
        cod_inventario_2,
        cod_inventario_3
    );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION reg_estatus_venta_fisica(
    cod_venta INT,
    cod_estatus INT
)
RETURNS VOID AS $$
BEGIN

    INSERT INTO "Venta_Fisica_Estatus"(
        ven_fis_est_fecha_ini,
        ven_fis_est_fecha_fin,
        fk_venta_fisica,
        fk_estatus
    )
    VALUES (
        NOW(),
        NULL,
        cod_venta,
        9
    );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION agregar_venta_fisica(
    total NUMERIC(12, 3),
    cod_cliente_natural_1 INT,
    cod_cliente_natural_2 VARCHAR(16),
    cod_empleado_1 INT,
    cod_empleado_2 VARCHAR(16),
    cod_cliente_juridico VARCHAR(16),
    cod_estatus INT,
    cod_inventario_1 INT,
    cod_inventario_2 INT,
    cod_inventario_3 INT
)
RETURNS VOID AS $$
DECLARE
    last_id INT;
BEGIN
    -- Llamada a la función para insertar en "Venta_Fisica"
    PERFORM insertar_venta_fisica(
        total,
        cod_cliente_natural_1,
        cod_cliente_natural_2,
        cod_empleado_1,
        cod_empleado_2,
        cod_cliente_juridico,
        cod_inventario_1,
        cod_inventario_2,
        cod_inventario_3
    );

    -- Obtener el último ID de "Venta_Fisica"
    SELECT obtener_ultimo_id_venta_fisica() INTO last_id;

    -- Llamada a la función para registrar el estatus de la venta
    PERFORM reg_estatus_venta_fisica(last_id, cod_estatus);
    
    -- Llamada a la función para detalles de venta (debes proporcionar detalles adicionales)
    -- PERFORM detalle_venta(last_id, ...);
    
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION insertar_venta_fisica_entrada(
    total NUMERIC(12, 3),
    cod_cliente_natural_1 INT,
    cod_cliente_natural_2 VARCHAR(16),
    cod_cliente_juridico VARCHAR(16),
    fk_fisica int

)
RETURNS VOID AS $$
BEGIN
    INSERT INTO "Venta_Fisica_Entrada"(
        ven_fis_ent_fecha,
        ven_fis_ent_total,
		fk_cliente_natural_1,
		fk_cliente_juridico,
		fk_cliente_natural_2,
        fk_fisica

    )
    VALUES (
        NOW(),
        total,
        cod_cliente_natural_1,
		cod_cliente_juridico,
        cod_cliente_natural_2,
        fk_fisica
    );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION ocultar_numeros(num_original VARCHAR)
RETURNS VARCHAR AS $$
DECLARE
    num_oculto VARCHAR;
BEGIN
    IF LENGTH(num_original) >= 4 THEN
        num_oculto := '****' || RIGHT(num_original, 4);
    ELSE
        num_oculto := num_original; -- Devolver el número original si tiene menos de 4 caracteres
    END IF;

    RETURN num_oculto;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION obtener_tarjetas_natural(
    IN natural1 INT,
    IN natural2 VARCHAR
)
RETURNS TABLE (
    nombre VARCHAR,
    num_oculto VARCHAR,
    fecha TIMESTAMP,
    id integer
)
AS $$
BEGIN
    RETURN QUERY (
        SELECT
            tar_nombre,
            ocultar_numeros(tar_numero) AS num_oculto,
            tar_fecha_vencimiento,
            met_pag_id
        FROM
            "Tarjeta"
        WHERE
            fk_cliente_natural_1 = natural1
            AND fk_cliente_natural_2 = natural2
    );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_tarjetas_juridico(
    IN juridico VARCHAR
)
RETURNS TABLE (
    nombre VARCHAR,
    num_oculto VARCHAR,
    fecha TIMESTAMP,
    id integer
)
AS $$
BEGIN
    RETURN QUERY (
        SELECT
            tar_nombre,
            ocultar_numeros(tar_numero) AS num_oculto,
            tar_fecha_vencimiento,
            met_pag_id
        FROM
            "Tarjeta"
        WHERE
            fk_cliente_juridico = juridico
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_telefonos_cliente_n(
    IN codigo_cliente INT,
    IN cod_cli VARCHAR
)
RETURNS TABLE (numero varchar) AS $$
BEGIN
    RETURN QUERY
    SELECT tel_numero
    FROM "Telefono"
    WHERE fk_cliente_natural_1 = codigo_cliente
        AND fk_cliente_natural_2 = cod_cli;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_ultimo_precio()
RETURNS NUMERIC AS $$
DECLARE
    ultimo_id INTEGER;
    ultimo_precio NUMERIC;
BEGIN
    -- Obtener el último ID
    SELECT MAX(pun_id) INTO ultimo_id FROM "Punto";

    -- Obtener el último precio basado en el último ID
    SELECT pun_valor INTO ultimo_precio FROM "Punto" WHERE pun_id = ultimo_id;

    RETURN ultimo_precio;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION validar_tipos(param1 VARCHAR, param2 VARCHAR, param3 NUMERIC)
RETURNS BOOLEAN AS $$
BEGIN
    IF param1 IS NOT NULL AND param2 ~ '^[0-9]+$' AND param3 IS NOT NULL AND param3 > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION validar_tipo_numeric(valor NUMERIC)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Función para obtener el último ID de la tabla Venta_Fisica
CREATE OR REPLACE FUNCTION obtener_ultimo_id_venta_fisica()
RETURNS INT AS $$
DECLARE
    ultimo_id INT;
BEGIN
    SELECT MAX(ven_fis_id) INTO ultimo_id FROM "Venta_Fisica";
    RETURN COALESCE(ultimo_id, 0);
END;
$$ LANGUAGE plpgsql;

-- Función para insertar un cheque en la tabla Cheque
CREATE OR REPLACE FUNCTION insertar_cheque(banco VARCHAR, numero VARCHAR)
RETURNS INT AS $$
DECLARE
    id_cheque INT;
BEGIN
    INSERT INTO "Cheque" (che_banco, che_numero)
    VALUES (banco, numero)
    RETURNING met_pag_id INTO id_cheque;

    RETURN id_cheque;
END;
$$ LANGUAGE plpgsql;

-- Función para insertar un pago en la tabla Pago_Metodo_Pago
CREATE OR REPLACE FUNCTION insertar_pago_metodo_pago(
    monto_parcial NUMERIC,
    fk_venta_fisica INT,
    fk_venta_virtual INT,
    tarjeta INT,
    efectivo INT,
    fk_cheque INT,
    mi_punto INT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO "Pago_Metodo_Pago" (
        monto_parcial,
        fk_venta_fisica,
        fk_venta_virtual,
        fk_tarjeta,
        fk_efectivo,
        fk_cheque,
        fk_mi_punto
    ) VALUES (
        monto_parcial,
        fk_venta_fisica,
        fk_venta_virtual,
        tarjeta,
        efectivo,
        fk_cheque,
        mi_punto
    );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE procedimiento_insertar_pago(
    IN banco_cheque VARCHAR,
    IN numero_cheque VARCHAR,
    IN monto_parcial NUMERIC,
    IN fk_venta_virtual INT,
    IN tarjeta INT,
    IN efectivo INT,
    IN mi_punto INT
)
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
    id_cheque INT;
BEGIN
    -- Obtener el último ID de Venta_Fisica
    SELECT obtener_ultimo_id_venta_fisica() INTO ultimo_id_venta_fisica;

    -- Insertar el cheque y obtener su ID
    id_cheque := insertar_cheque(banco_cheque, numero_cheque);

    -- Insertar el pago con los valores obtenidos
   PERFORM insertar_pago_metodo_pago(
        monto_parcial,
        ultimo_id_venta_fisica,
        fk_venta_virtual,
        tarjeta,
        efectivo,
        id_cheque,
        mi_punto
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE procedimiento_insertar_pago_efectivo(
    IN denominacion VARCHAR,
    IN monto_parcial INT,
    IN fk_venta_virtual INT,
    IN fk_cheque INT,
    IN tarjeta INT,
    IN mi_punto INT
)
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
    id_efectivo INT;
BEGIN
    -- Obtener el último ID de Venta_Fisica
    SELECT obtener_ultimo_id_venta_fisica() INTO ultimo_id_venta_fisica;

    -- Insertar el cheque y obtener su ID
    id_efectivo := insertar_efectivo(denominacion, monto_parcial);

    -- Insertar el pago con los valores obtenidos
   PERFORM insertar_pago_metodo_pago(
        monto_parcial,
        ultimo_id_venta_fisica,
        fk_venta_virtual,
        tarjeta,
        id_efectivo,
        fk_cheque,
        mi_punto
    );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insertar_efectivo(denominacion VARCHAR, monto_parcial INTEGER)
RETURNS INT AS $$
DECLARE
    id_efectivo INT;
BEGIN
    INSERT INTO "Efectivo" (ef_denominacion, met_pag_cantidad)
    VALUES (denominacion, monto_parcial)
    RETURNING met_pag_id INTO id_efectivo;

    RETURN id_efectivo;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insertar_punto(cantidad INTEGER)
RETURNS INT AS $$
DECLARE
    id_punto INT;
BEGIN
    INSERT INTO "Mi_Punto" (mi_pun_cantidad)
    VALUES (cantidad)
    RETURNING met_pag_id INTO id_punto;

    RETURN id_punto;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE procedimiento_insertar_pago_tarjeta(
    IN monto_parcial NUMERIC,
    IN fk_venta_virtual INT,
    IN tarjeta INT,
    IN efectivo INT,
	IN cheque INT,
    IN mi_punto INT
)
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
BEGIN
    -- Obtener el último ID de Venta_Fisica
    SELECT obtener_ultimo_id_venta_fisica() INTO ultimo_id_venta_fisica;


    -- Insertar el pago con los valores obtenidos
   PERFORM insertar_pago_metodo_pago(
        monto_parcial,
        ultimo_id_venta_fisica,
        fk_venta_virtual,
        tarjeta,
        efectivo,
        cheque,
        mi_punto
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION buscar_id_pre_evento(codigo1 INT, codigo2 INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    id_pre_evento INT;
BEGIN
    -- Realizar la selección en la tabla Presentacion_Evento
    SELECT pre_eve_id INTO id_pre_evento
    FROM "Presentacion_Evento"
    WHERE fk_evento = codigo2 AND fk_presentacion = codigo1
    LIMIT 1;

    -- Devolver el id_pre_evento encontrado o NULL si no se encontró
    RETURN id_pre_evento;
END;
$$;

CREATE OR REPLACE FUNCTION insertar_detalle_evento(
    cantidad INT,
    precio NUMERIC,
	ventaCod INT,
    codigo1 INT,
    codigo2 INT,
	codigo3 INT
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN   
    -- Insertar en la tabla Detalle_Evento
    INSERT INTO "Detalle_Venta_Fisica_Presentacion_Evento" (det_ven_fis_pre_eve_cantidad, det_ven_fis_pre_eve_precio_venta, fk_venta_fisica, fk_presentacion_evento, fk_presentacion_evento_1, fk_presentacion_evento_2)
    VALUES (cantidad, precio, ventaCod, codigo1, codigo2, codigo3);
END;
$$;


CREATE OR REPLACE PROCEDURE detalle_fisico_evento(
    cantidad INT,
    precio NUMERIC,
    codigo1 INT,
    codigo2 INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    id_pre_evento INT;
    ultimo_id_venta_fisica INT;
BEGIN
    -- Llamar a la función para buscar el id_pre_evento
    id_pre_evento := buscar_id_pre_evento(codigo1, codigo2);
    SELECT obtener_ultimo_id_venta_fisica() INTO ultimo_id_venta_fisica;
    -- Verificar si el id_pre_evento es válido
    IF id_pre_evento IS NOT NULL THEN
        -- Llamar a la función para insertar el detalle del evento
        PERFORM insertar_detalle_evento(cantidad, precio, ultimo_id_venta_fisica, id_pre_evento, codigo1, codigo2 );
        

    ELSE
        -- Manejar la situación donde id_pre_evento no es válido
        RAISE EXCEPTION 'No se encontró un id_pre_evento válido';
    END IF;
END;
$$;


CREATE OR REPLACE FUNCTION actualizar_cantidad_presentacion_evento(
    p_fk_evento INT,
    p_fk_presentacion INT,
    p_cantidad_restar INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE "Presentacion_Evento"
    SET pre_eve_cantidad = pre_eve_cantidad - p_cantidad_restar
    WHERE fk_evento = p_fk_evento
      AND fk_presentacion = p_fk_presentacion;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION actualizar_venta_fisica_estatus(
    p_cod INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE "Venta_Fisica_Estatus"
    SET ven_fis_est_fecha_fin = CURRENT_TIMESTAMP
    WHERE fk_venta_fisica = p_cod AND ven_fis_est_fecha_fin IS NULL;

    INSERT INTO "Venta_Fisica_Estatus" (ven_fis_est_fecha_ini, ven_fis_est_fecha_fin, fk_venta_fisica, fk_estatus)
    VALUES (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, p_cod, 7);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE actualizar_venta_fisica_y_estatus(
	cantidad int,
	fk_evento int,
	fk_presentacion int
	)
LANGUAGE plpgsql
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
BEGIN
    -- Llamada a la función para obtener el último ID de Venta_Fisica
    SELECT obtener_ultimo_id_venta_fisica() INTO ultimo_id_venta_fisica;
	PERFORM actualizar_cantidad_presentacion_evento(fk_evento, fk_presentacion, cantidad);
    -- Llamada a la función para actualizar y insertar en Venta_Fisica_Estatus
    PERFORM actualizar_venta_fisica_estatus(ultimo_id_venta_fisica);
END;
$$;


CREATE OR REPLACE FUNCTION obtener_entradas_futuras(codE int)
RETURNS TABLE (
    evento INT,
    cantidad_entradas NUMERIC,
    precio NUMERIC,
	nombre varchar
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        e.eve_id,
        e.eve_cantidad_entradas,
        (SELECT ent_precio
         FROM "Entrada" ent
         WHERE ent.fk_evento = codE
         LIMIT 1) AS precio,
		 eve_nombre as nombreE
    FROM
        "Evento" e
    WHERE
        e.eve_fecha_hora_inicial > CURRENT_TIMESTAMP
		And eve_id = codE;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_precio_entrada(cod_evento INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    cod_id NUMERIC;
BEGIN
    SELECT ent_id INTO cod_id
    FROM "Entrada" ent
    WHERE ent.fk_evento = cod_evento
    LIMIT 1;

    RETURN cod_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_ultimo_id_venta_fisica_entrada()
RETURNS INT AS $$
DECLARE
    ultimo_id INT;
BEGIN
    SELECT MAX(ven_fis_ent_id) INTO ultimo_id FROM "Venta_Fisica_Entrada";
    RETURN COALESCE(ultimo_id, 0);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insertar_detalle_entrada(
    cantidad_ent NUMERIC,
    precio_unitario NUMERIC,
    fk_venta_fisica_entrada INT,
    fk_entrada INT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO "Detalle_Venta_Fisica_Entrada_Entrada" (
        det_ven_fis_ent_ent_cantidad_ent,
        det_ven_fis_ent_ent_precio_unitario,
        fk_venta_fisica_entrada,
        fk_entrada
    )
    VALUES (
        cantidad_ent,
        precio_unitario,
        fk_venta_fisica_entrada,
        fk_entrada
    );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_primera_entrada_por_evento(codigo_evento INT)
RETURNS TABLE (
    entrada_id INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        ent.ent_id
    FROM
        "Entrada" ent
    WHERE
        ent.fk_evento = codigo_evento
    LIMIT 1;

END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE regDetalleEntradaF(
	evento integer,
   	cantidad_ent NUMERIC, 
	precio_unitario NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
    primera_entrada INT; 
BEGIN

    SELECT obtener_ultimo_id_venta_fisica_entrada() INTO ultimo_id_venta_fisica;

    -- Llamar a tu función para obtener la primera entrada por evento
    SELECT * INTO primera_entrada FROM obtener_primera_entrada_por_evento(evento);

    -- Verificar si la primera_entrada es nula o no
    IF primera_entrada IS NOT NULL THEN
        -- Llamar a tu función para insertar en el detalle de entrada
    PERFORM insertar_detalle_entrada(cantidad_ent, precio_unitario, ultimo_id_venta_fisica, primera_entrada);
    ELSE
        -- Manejar el caso donde no se encuentra una entrada
        RAISE EXCEPTION 'No se encontró una entrada para el evento especificado';
    END IF;

   

END;
$$;




CREATE OR REPLACE FUNCTION actualizar_cantidad_entradas(evento_id INT, cantidad_restar INT)
RETURNS VOID AS $$
BEGIN
    -- Verificar si el evento existe
    IF NOT EXISTS (SELECT 1 FROM "Evento" WHERE eve_id = evento_id) THEN
        RAISE EXCEPTION 'No se encontró el evento con ID %', evento_id;
    END IF;

    -- Restar la cantidad proporcionada
    UPDATE "Evento"
    SET eve_cantidad_entradas = eve_cantidad_entradas - cantidad_restar
    WHERE eve_id = evento_id;

    -- Verificar si la cantidad después de restar es negativa
    IF (SELECT eve_cantidad_entradas < 0 FROM "Evento" WHERE eve_id = evento_id) THEN
        RAISE EXCEPTION 'La cantidad de entradas no puede ser negativa para el evento con ID %', evento_id;
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE procedimiento_insertar_pago_punto(
    IN monto_parcial INT,
    IN fk_venta_virtual INT,
    IN fk_cheque INT,
	IN fk_efectivo INT,
    IN tarjeta INT

)
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
    id_punto INT;
BEGIN
    -- Obtener el último ID de Venta_Fisica
    SELECT obtener_ultimo_id_venta_fisica() INTO ultimo_id_venta_fisica;

    -- Insertar el cheque y obtener su ID
    id_punto := insertar_punto( monto_parcial);

    -- Insertar el pago con los valores obtenidos
   PERFORM insertar_pago_metodo_pago(
        monto_parcial,
        ultimo_id_venta_fisica,
        fk_venta_virtual,
        tarjeta,
        fk_efectivo,
        fk_cheque,
        id_punto
    );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION restar_puntos_cliente_natural(
    id_cliente_natural INT,
	ci_cliente_natural VARCHAR,
    puntos_a_restar INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE "Cliente_Natural"
    SET per_nat_punto = per_nat_punto - puntos_a_restar
    WHERE per_nat_id = id_cliente_natural AND per_nat_ci = ci_cliente_natural;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION restar_puntos_cliente_juridico(
    id_cliente VARCHAR,
    puntos_a_restar INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE "Cliente_Juridico"
    SET per_jur_punto = per_jur_punto - puntos_a_restar
    WHERE per_jur_rif = id_cliente;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE procedimiento_insertar_pago_entrada(
    IN banco_cheque VARCHAR,
    IN numero_cheque VARCHAR,
    IN monto_parcial NUMERIC,
    IN tarjeta INT,
    IN efectivo INT,
    IN mi_punto INT,
    IN fk_entrada INT,
	IN fk_venta_v_e INT

)
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
    id_cheque INT;
    cod_id INT;
BEGIN
    -- Obtener el último ID de Venta_Fisica
    SELECT obtener_ultimo_id_venta_fisica_entrada() INTO ultimo_id_venta_fisica;

    -- Insertar el cheque y obtener su ID
    id_cheque := insertar_cheque(banco_cheque, numero_cheque);
    cod_id := obtener_precio_entrada(fk_entrada);
    -- Insertar el pago con los valores obtenidos
   PERFORM insertar_pago_metodo_pago_entrada(
        monto_parcial,
	   	cod_id,
	   	ultimo_id_venta_fisica,
		fk_venta_v_e,
        tarjeta,
        efectivo,
        id_cheque,
        mi_punto
    );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION insertar_pago_metodo_pago_entrada(
    monto_parcial NUMERIC,
    fk_entrada INT,
    fk_venta_f_e INT,
	fk_venta_v_e INT,
    tarjeta INT,
    efectivo INT,
    fk_cheque INT,
    mi_punto INT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO "Pago_Entrada_Metodo_Pago" (
        "pag_ent_met_pag_Monto_parcial",
        fk_entrada,
        fk_venta_fisica_entrada,
        fk_venta_virtual_entrada,
		fk_tarjeta,
        fk_efectivo,
        fk_cheque,
        fk_mi_punto
    ) VALUES (
        monto_parcial,
		fk_entrada,
        fk_venta_f_e,
        fk_venta_v_e,
        tarjeta,
        efectivo,
        fk_cheque,
        mi_punto
    );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE procedimiento_insertar_pago_efectivo_entrada(
    IN denominacion VARCHAR,
    IN monto_parcial INT,
    IN tarjeta INT,
    IN cheque INT,
    IN mi_punto INT,
    IN fk_entrada INT,
	IN fk_venta_v_e INT
)
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
    id_efectivo INT;
    cod_id INT;
BEGIN
    -- Obtener el último ID de Venta_Fisica
    SELECT obtener_ultimo_id_venta_fisica_entrada() INTO ultimo_id_venta_fisica;

    -- Insertar el cheque y obtener su ID
    id_efectivo := insertar_efectivo(denominacion, monto_parcial);
    cod_id := obtener_precio_entrada(fk_entrada);
    -- Insertar el pago con los valores obtenidos
   PERFORM insertar_pago_metodo_pago_entrada(
        monto_parcial,
	   	cod_id,
	   	ultimo_id_venta_fisica,
		fk_venta_v_e,
        tarjeta,
        id_efectivo,
        cheque,
        mi_punto
    );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE procedimiento_insertar_pago_punto_entrada(
    IN monto_parcial INT,
    IN tarjeta INT,
    IN cheque INT,
    IN efectivo INT,
    IN mi_punto INT,
    IN fk_entrada INT,
	IN fk_venta_v_e INT

)
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
    id_punto INT;
    cod_id INT;
BEGIN
    -- Obtener el último ID de Venta_Fisica
    SELECT obtener_ultimo_id_venta_fisica_entrada() INTO ultimo_id_venta_fisica;

    -- Insertar el cheque y obtener su ID
    id_punto := insertar_punto( monto_parcial);
    cod_id := obtener_precio_entrada(fk_entrada);
    -- Insertar el pago con los valores obtenidos
   PERFORM insertar_pago_metodo_pago_entrada(
        monto_parcial,
	   	cod_id,
	   	ultimo_id_venta_fisica,
		fk_venta_v_e,
        tarjeta,
        efectivo,
        cheque,
        id_punto
    );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE procedimiento_insertar_pago_tarjeta_entrada(
    IN monto_parcial INT,
    IN tarjeta INT,
    IN cheque INT,
    IN efectivo INT,
    IN mi_punto INT,
    IN fk_entrada INT,
	IN fk_venta_v_e INT
)
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
    cod_id INT;
BEGIN
    -- Obtener el último ID de Venta_Fisica
    SELECT obtener_ultimo_id_venta_fisica_entrada() INTO ultimo_id_venta_fisica;
    cod_id := obtener_precio_entrada(fk_entrada);

    -- Insertar el pago con los valores obtenidos
   PERFORM insertar_pago_metodo_pago_entrada(
        monto_parcial,
	   	cod_id,
	   	ultimo_id_venta_fisica,
		fk_venta_v_e,
        tarjeta,
        efectivo,
        cheque,
        mi_punto
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION funcion_obtener_factura(
    IN tipo INT
)
RETURNS INT
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
BEGIN
    IF tipo = 0 THEN
        
        SELECT obtener_ultimo_id_venta_fisica_entrada() INTO ultimo_id_venta_fisica;
    ELSIF tipo = 1 THEN
        
        SELECT obtener_ultimo_id_venta_fisica() INTO ultimo_id_venta_fisica;
    ELSE
       
        RAISE EXCEPTION 'Valor inesperado para tipol: %', tipol;
    END IF;

  
    RETURN ultimo_id_venta_fisica;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION verificar_presentacion_tienda(cod_pre integer)
    RETURNS TABLE(precio numeric, cantidad numeric) 
    LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    RETURN QUERY 
    SELECT inv_fis_cantidad, inv_fis_precio
    FROM public."Inventario_Fisico_Presentacion"
    WHERE cod_pre = fk_presentacion AND fk_fisica = 1;
END;
$BODY$;


CREATE OR REPLACE FUNCTION insertar_detalle_tienda(
    cantidad INT,
    precio NUMERIC,
	ventaCod INT,
    presentacion INT,
	codigo1 INT,
    codigo2 INT
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN   
 
    INSERT INTO "Detalle_Venta_Fisica_Presentacion" (det_ven_fis_pre_cantidad, det_ven_fis_pre_precio_venta, fk_venta_fisica, fk_presentacion, fk_infp_1, fk_infp_2)
    VALUES (cantidad, precio, ventaCod, presentacion, codigo1, codigo2);
END;
$$;

CREATE OR REPLACE FUNCTION buscar_id_pre_tienda(codigo1 INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    id_pre_tienda INT;
BEGIN
    -- Realizar la selección en la tabla
    SELECT inv_fis_pre_id INTO id_pre_tienda
    FROM "Inventario_Fisico_Presentacion"
    WHERE fk_presentacion = codigo1 AND fk_fisica = 1
    LIMIT 1;

    -- Devolver el id encontrado o NULL si no se encontró
    RETURN id_pre_tienda;
END;
$$;

CREATE OR REPLACE PROCEDURE detalle_fisico_tienda(
    cantidad INT,
    precio NUMERIC,
    presentacion INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    id_pre_tienda INT;
    ultimo_id_venta_fisica INT;
BEGIN
    -- Llamar a la función para buscar el id
    id_pre_tienda := buscar_id_pre_tienda(presentacion);
    SELECT obtener_ultimo_id_venta_fisica() INTO ultimo_id_venta_fisica;
    -- Verificar si el id es válido
    IF id_pre_tienda IS NOT NULL THEN
        -- Llamar a la función para insertar el detalle 
        PERFORM insertar_detalle_tienda(cantidad, precio, ultimo_id_venta_fisica, presentacion, id_pre_tienda, 1);
        

    ELSE
        -- Manejar la situación donde id no es válido
        RAISE EXCEPTION 'No se encontró un id válido';
    END IF;
END;
$$;

CREATE OR REPLACE FUNCTION actualizar_cantidad_presentacion_tienda(
    presentacion INT,
    cantidad_restar INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE "Inventario_Fisico_Presentacion"
    SET inv_fis_cantidad = inv_fis_cantidad - cantidad_restar
    WHERE fk_presentacion = presentacion
      AND fk_fisica = 1;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE actualizar_venta_fisica_y_estatus_tienda(
	cantidad int,
	fk_presentacion int
	)
LANGUAGE plpgsql
AS $$
DECLARE
    ultimo_id_venta_fisica INT;
BEGIN
    -- Llamada a la función para obtener el último ID de Venta_Fisica
    SELECT obtener_ultimo_id_venta_fisica() INTO ultimo_id_venta_fisica;
	PERFORM actualizar_cantidad_presentacion_tienda(fk_presentacion, cantidad);
    -- Llamada a la función para actualizar y insertar en Venta_Fisica_Estatus
    PERFORM actualizar_venta_fisica_estatus(ultimo_id_venta_fisica);
END;
$$;
------------------------------------------------------ALTER-------------------------------------------------------------

-- Reinicio la secuencia de Usuario, del id
ALTER SEQUENCE "Usuario_usu_id_seq" RESTART WITH 7;

ALTER TABLE "Telefono"
DROP COLUMN tel_tipo;


alter  table "Afiliado"
add column afi_codigo_iden varchar unique not null;


-- Reinicio la secuencia de entrada, del id
ALTER SEQUENCE "Entrada_ent_id_seq" RESTART WITH 8;

-- Añadir la columna "met_pag_cantidad"
ALTER TABLE "Efectivo" ADD COLUMN "met_pag_cantidad" INTEGER NOT NULL;

-- Reinicio la secuencia de empleado del id
ALTER SEQUENCE "Empleado_per_nat_id_seq" RESTART WITH 21;

-- Reinicio la secuencia de lugar, del id
ALTER SEQUENCE "Cheque_met_pag_id_seq" RESTART WITH 20;


ALTER TABLE "Mi_Punto"
ADD COLUMN mi_pun_cantidad INT NOT NULL;

ALTER TABLE "Pago_Entrada_Metodo_Pago"
ALTER COLUMN "fk_venta_fisica_entrada" DROP NOT NULL,
ALTER COLUMN "fk_venta_virtual_entrada" DROP NOT NULL;

ALTER TABLE "Detalle_Venta_Fisica_Presentacion"
ADD COLUMN fk_infp_1 INT,
ADD COLUMN fk_infp_2 INT;

------------------------------------------------------INSERT-------------------------------------------------------------

-- Insertar valores para dólares
INSERT INTO "Efectivo" ("ef_denominacion", "met_pag_cantidad")
VALUES 
    ('$',1),
    ('$',5),
    ('$', 10),
    ('$', 20),
    ('$', 50),
    ('$', 100);



-- Insertar valores para euros
INSERT INTO "Efectivo" ("ef_denominacion", "met_pag_cantidad")
VALUES 
    ('€', 1),
	('€', 5),
    ('€', 10),
    ('€', 20),
    ('€', 50),
    ('€',100);

-- Insertar valores para euros
INSERT INTO "Efectivo" ("ef_denominacion", "met_pag_cantidad")
VALUES 
    ('Bs.S', 1),
	('Bs.S', 5),
    ('Bs.S', 10),
    ('Bs.S', 20),
    ('Bs.S', 50),
    ('Bs.S',100);


-- Reinicio la secuencia de tarjeta del id
ALTER SEQUENCE "Tarjeta_met_pag_id_seq" RESTART WITH 11;