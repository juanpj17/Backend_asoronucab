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


------------------------------------------------------ALTER-------------------------------------------------------------



alter  table "Afiliado"
add column afi_codigo_iden varchar unique not null;


-- Reinicio la secuencia de entrada, del id
ALTER SEQUENCE "Entrada_ent_id_seq" RESTART WITH 8;

