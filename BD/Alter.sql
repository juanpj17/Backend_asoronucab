/*ALTER TABLE tabla_secundaria
ADD CONSTRAINT nombre_constraint
FOREIGN KEY (clave_foranea_columna)
REFERENCES tabla_principal (clave_primaria_columna)
ON DELETE CASCADE;*/
-----------------------------------------------------Foraneas 
-- Afiliado
-- Variables
ALTER TABLE "Afiliado"
ADD COLUMN "fk_fisica" INT NOT NULL,
ADD COLUMN "fk_virtual" INT NOT NULL,
ADD COLUMN "fk_cliente_natural" INT UNIQUE ,
ADD COLUMN "fk_cliente_natural_2" VARCHAR(16) UNIQUE,
ADD COLUMN "fk_estatus" INT NOT NULL,
ADD COLUMN "fk_cliente_juridico" VARCHAR(16) UNIQUE,
ADD COLUMN "fk_proveedor" VARCHAR(16) UNIQUE;

-- Foraneas
ALTER TABLE "Afiliado" 
ADD CONSTRAINT "fk_fisica" 
FOREIGN KEY ("fk_fisica") REFERENCES "Fisica" ("aso_id") 
ON DELETE CASCADE,
ADD CONSTRAINT "fk_virtual" 
FOREIGN KEY ("fk_virtual") REFERENCES "Virtual" ("aso_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_afiliado_cliente_natural"
FOREIGN KEY ("fk_cliente_natural", "fk_cliente_natural_2") REFERENCES "Cliente_Natural"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_estatus" 
FOREIGN KEY ("fk_estatus") REFERENCES "Estatus"("est_id") 
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_juridico"
FOREIGN KEY ("fk_cliente_juridico") REFERENCES "Cliente_Juridico" ("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_proveedor"
FOREIGN KEY ("fk_proveedor") REFERENCES "Proveedor" ("per_jur_rif")
ON DELETE CASCADE;

---Arco Afiliado
ALTER TABLE "Afiliado"
ADD CHECK(
    CASE WHEN (fk_cliente_natural IS NOT NULL AND fk_cliente_natural_2 IS NOT NULL) 
    AND fk_proveedor IS NULL AND fk_cliente_juridico IS NULL THEN 1
    WHEN (fk_cliente_natural IS NULL AND fk_cliente_natural_2 IS NULL) 
    AND fk_cliente_juridico IS NOT NULL AND fk_proveedor IS NULL  THEN 1
    WHEN (fk_cliente_natural IS NULL AND fk_cliente_natural_2 IS NULL) 
    AND fk_cliente_juridico IS NULL AND fk_proveedor IS NOT NULL  THEN 1
    ELSE 0 END = 1
);

-- añejamiento
-- Variables
ALTER TABLE "Añejamiento"
ADD COLUMN "fk_destilacion" INT NOT NULL;

-- Foraneas
ALTER TABLE "Añejamiento"
ADD CONSTRAINT "fk_destilacion"
FOREIGN KEY ("fk_destilacion") REFERENCES "Destilacion"("des_Id")
ON DELETE CASCADE;

--CLIENTE NATURAL 
-- Variables
ALTER TABLE "Cliente_Natural"     
ADD COLUMN "fk_cliente_juridico" VARCHAR(16), 
ADD COLUMN "fk_proveedor" VARCHAR(16),
ADD COLUMN "fk_lugar" INT NOT NULL;

-- Foraneas     
ALTER TABLE "Cliente_Natural"
ADD CONSTRAINT "fk_cliente_juridico" 
FOREIGN KEY ("fk_cliente_juridico") REFERENCES "Cliente_Juridico"("per_jur_rif") 
ON DELETE CASCADE,
ADD CONSTRAINT "fk_proveedor" 
FOREIGN KEY ("fk_proveedor") REFERENCES "Proveedor"("per_jur_rif") 
ON DELETE CASCADE,
ADD CONSTRAINT "fk_lugar" 
FOREIGN KEY ("fk_lugar") REFERENCES "Lugar"("lug_id");


--COMPRA 
-- Variables
ALTER TABLE "Compra"
ADD COLUMN "fk_fisica" INT,
ADD COLUMN "fk_virtual" INT;

-- Foraneas
ALTER TABLE "Compra"
ADD CONSTRAINT "fk_fisica"
FOREIGN KEY ("fk_fisica") REFERENCES "Fisica"("aso_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_virtual"
FOREIGN KEY ("fk_virtual") REFERENCES "Virtual"("aso_id")
ON DELETE CASCADE;

-- CONTROL_ACCION
-- Variables
ALTER TABLE "Control_Accion"
ADD COLUMN "fk_usuario" INT NOT NULL;

-- Foraneas
ALTER TABLE "Control_Accion"
ADD CONSTRAINT "fk_usuario"
FOREIGN KEY ("fk_usuario") REFERENCES "Usuario"("usu_id")
ON DELETE CASCADE;

-- CORREO
-- Variables
ALTER TABLE "Correo"
ADD COLUMN "fk_empleado" INT, 
ADD COLUMN "fk_empleado_1" VARCHAR(16),
ADD COLUMN "fk_cliente_natural"  INT, 
ADD COLUMN "fk_cliente_natural_1" VARCHAR(16),
ADD COLUMN "fk_cliente_juridico" VARCHAR(16), 
ADD COLUMN "fk_proveedor" VARCHAR(16);

-- Foraneas 
ALTER TABLE "Correo"
ADD CONSTRAINT "fk_empleado"
FOREIGN KEY ("fk_empleado", "fk_empleado_1") REFERENCES "Empleado"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_natural"
FOREIGN KEY ("fk_cliente_natural", "fk_cliente_natural_1") REFERENCES "Cliente_Natural"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_juridico"
FOREIGN KEY ("fk_cliente_juridico") REFERENCES "Cliente_Juridico"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_proveedor"
FOREIGN KEY ("fk_proveedor") REFERENCES "Proveedor"("per_jur_rif")
ON DELETE CASCADE;

--Arco correo
ALTER TABLE "Correo"
ADD CHECK(
    --Condion para que solo se llene cliente_natural
    CASE WHEN (fk_cliente_natural IS NOT NULL AND fk_cliente_natural_1 IS NOT NULL)
    AND (fk_empleado IS NULL AND fk_empleado_1 IS NULL) 
    AND (fk_proveedor IS NULL) AND (fk_cliente_juridico IS NULL) THEN 1
    --condicion para que solo se llene empleado
    WHEN (fk_empleado IS NOT NULL AND fk_empleado_1 IS NOT NULL) 
    AND (fk_cliente_natural IS NULL AND fk_cliente_natural_1 IS NULL)
    AND (fk_proveedor IS NULL) AND (fk_cliente_juridico IS NULL) THEN 1
    --condicion para que solo se llene proveedor
    WHEN (fk_proveedor IS NOT NULL) AND (fk_cliente_juridico IS NULL)
    AND  (fk_cliente_natural IS NULL AND fk_cliente_natural_1 IS NULL)
    AND  (fk_empleado IS NULL AND fk_empleado_1 IS NULL) THEN 1
    --condicion para que solo se llene cliente_juridico
    WHEN (fk_cliente_juridico IS NOT NULL) AND (fk_proveedor IS NULL)
    AND  (fk_cliente_natural IS NULL AND fk_cliente_natural_1 IS NULL)
    AND  (fk_empleado IS NULL AND fk_empleado_1 IS NULL) THEN 1
    ELSE 0 END = 1
);

-- DEPARTAMENTO
-- Variables
ALTER TABLE "Departamento"
ADD COLUMN "fk_fisica" INT NOT NULL,
ADD COLUMN "fk_virtual" INT NOT NULL;

-- Foraneas 
ALTER TABLE "Departamento"
ADD CONSTRAINT "fk_fisica"
FOREIGN KEY ("fk_fisica") REFERENCES "Fisica"("aso_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_virtual"
FOREIGN KEY ("fk_virtual") REFERENCES "Virtual"("aso_id")
ON DELETE CASCADE;

--Destilacion
-- Variables
ALTER TABLE "Destilacion"
ADD COLUMN "fk_fermentacion" INT NOT NULL;

-- Foraneas
ALTER TABLE "Destilacion"
ADD CONSTRAINT "fk_fermentacion"
FOREIGN KEY ("fk_fermentacion") REFERENCES "Fermentacion"("fer_Id")
ON DELETE CASCADE;

--Empleado
-- Variables
ALTER TABLE "Empleado"
ADD COLUMN "fk_cliente_juridico" VARCHAR(16),
ADD COLUMN "fk_proveedor" VARCHAR(16),
ADD COLUMN "fk_lugar" INT NOT NULL;

-- Foraneas
ALTER TABLE "Empleado"
ADD CONSTRAINT "fk_cliente_juridico"
FOREIGN KEY ("fk_cliente_juridico") REFERENCES "Cliente_Juridico"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_proveedor"
FOREIGN KEY ("fk_proveedor") REFERENCES "Proveedor"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_lugar"
FOREIGN KEY ("fk_lugar") REFERENCES "Lugar"(lug_id);


--Entrada
-- Variables
ALTER TABLE "Entrada"
ADD COLUMN "fk_evento" INT;

-- Foraneas
ALTER TABLE "Entrada"
ADD CONSTRAINT "fk_evento"
FOREIGN KEY ("fk_evento") REFERENCES "Evento"("eve_id")
ON DELETE CASCADE;

--Evento
-- Variables
ALTER TABLE "Evento"
ADD COLUMN "fk_lugar" INT NOT NULL;

-- Foraneas 
ALTER TABLE "Evento"
ADD CONSTRAINT "fk_lugar"
FOREIGN KEY ("fk_lugar") REFERENCES "Lugar"("lug_id");

--Fisica
-- Variables
ALTER TABLE "Fisica"
ADD COLUMN "fk_lugar" INT UNIQUE NOT NULL,
ADD COLUMN "fk_tasa" INT UNIQUE NOT NULL;

-- Foraneas
ALTER TABLE "Fisica"
ADD CONSTRAINT "fk_lugar"
FOREIGN KEY ("fk_lugar") REFERENCES "Lugar"("lug_id"),
ADD CONSTRAINT "fk_tasa"
FOREIGN KEY ("fk_tasa") REFERENCES "Tasa"("tas_id")
ON DELETE CASCADE;

---Imagen
--Variables
ALTER TABLE "Imagen"
ADD COLUMN "fk_producto" INT;
--Foranea
ALTER TABLE "Imagen"
ADD CONSTRAINT "fk_producto"
FOREIGN KEY ("fk_producto") REFERENCES "Producto"("pro_codigo")
ON DELETE CASCADE;

--Lugar
-- Variables
ALTER TABLE "Lugar"
DROP CONSTRAINT IF EXISTS "Lugar_lug_tipo_check",
ADD CONSTRAINT "Lugar_lug_tipo_check" CHECK ("lug_tipo" IN ('país', 'estado', 'municipio', 'parroquia'));

--Arco Lugar_Persona
ALTER TABLE "Lugar_Persona"
ADD CHECK(
    CASE WHEN (fk_proveedor IS NOT NULL) AND (fk_cliente_juridico IS NULL) THEN 1
    WHEN (fk_cliente_juridico IS NOT NULL) AND (fk_proveedor IS NULL) THEN 1
    ELSE 0 END = 1
);

--nota cata
-- Variables
ALTER TABLE "Nota_Cata"
ADD COLUMN "fk_presentacion_evento_1" INT NOT NULL,
ADD COLUMN "fk_presentacion_evento_2" INT NOT NULL,
ADD COLUMN "fk_presentacion_evento_3" INT NOT NULL;

-- Foraneas
ALTER TABLE "Nota_Cata"
ADD CONSTRAINT "fk_presentacion_evento"
FOREIGN KEY ("fk_presentacion_evento_1", "fk_presentacion_evento_2", "fk_presentacion_evento_3") REFERENCES "Presentacion_Evento"("pre_eve_id", "fk_presentacion", "fk_evento")
ON DELETE CASCADE;



--Pago_afiliacion_cuota
ALTER TABLE "Pago_Afiliacion_Cuota"
ADD COLUMN "fk_afiliado" INT NOT NULL;

-- Foraneas
ALTER TABLE "Pago_Afiliacion_Cuota"
ADD CONSTRAINT "fk_afiliado"
FOREIGN KEY ("fk_afiliado") REFERENCES "Afiliado"("afi_id")
ON DELETE CASCADE;

--Pago_afiliacion_cuota_metodo_pago
ALTER TABLE "Pago_Afiliacion_Cuota_Metodo_Pago"
ADD COLUMN "fk_tarjeta" INT,
ADD COLUMN "fk_efectivo" INT,
ADD COLUMN "fk_cheque" INT,
ADD COLUMN "fk_mi_punto" INT;

ALTER TABLE "Pago_Afiliacion_Cuota_Metodo_Pago"
ADD CONSTRAINT "fk_tarjeta"
FOREIGN KEY ("fk_tarjeta") REFERENCES "Tarjeta"("met_pag_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_efectivo"
FOREIGN KEY ("fk_efectivo") REFERENCES "Efectivo"("met_pag_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cheque"
FOREIGN KEY ("fk_cheque") REFERENCES "Cheque"("met_pag_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_mi_punto"
FOREIGN KEY ("fk_mi_punto") REFERENCES "Mi_Punto"("met_pag_id")
ON DELETE CASCADE;


--Pago_Entrada_metodo_pago
-- Variables
ALTER TABLE "Pago_Entrada_Metodo_Pago"
ADD COLUMN "fk_venta_fisica_entrada" INT NOT NULL,
ADD COLUMN "fk_venta_virtual_entrada" INT NOT NULL,
ADD COLUMN "fk_tarjeta" INT,
ADD COLUMN "fk_efectivo" INT,
ADD COLUMN "fk_cheque" INT,
ADD COLUMN "fk_mi_punto" INT;

-- Foraneas
ALTER TABLE "Pago_Entrada_Metodo_Pago"
ADD CONSTRAINT "fk_venta_fisica_entrada"
FOREIGN KEY ("fk_venta_fisica_entrada") REFERENCES "Venta_Fisica_Entrada"("ven_fis_ent_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_venta_virtual_entrada"
FOREIGN KEY ("fk_venta_virtual_entrada") REFERENCES "Venta_Virtual_Entrada"("ven_vir_ent_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_tarjeta"
FOREIGN KEY ("fk_tarjeta") REFERENCES "Tarjeta"("met_pag_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_efectivo"
FOREIGN KEY ("fk_efectivo") REFERENCES "Efectivo"("met_pag_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cheque"
FOREIGN KEY ("fk_cheque") REFERENCES "Cheque"("met_pag_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_mi_punto"
FOREIGN KEY ("fk_mi_punto") REFERENCES "Mi_Punto"("met_pag_id")
ON DELETE CASCADE;

--Arco_Pago_Entrada_Metodo_Pago
ALTER TABLE "Pago_Entrada_Metodo_Pago"
ADD CHECK(
    CASE WHEN (fk_venta_fisica_entrada IS NOT NULL) AND (fk_venta_virtual_entrada IS NULL) THEN 1
    WHEN (fk_venta_virtual_entrada IS NOT NULL) AND (fk_venta_fisica_entrada IS NULL) THEN 1
    ELSE 0 END = 1
);

--Pago_Metodo_Pago
-- Variables
ALTER TABLE "Pago_Metodo_Pago"
ADD COLUMN "fk_venta_fisica" INT NOT NULL,
ADD COLUMN "fk_venta_virtual" INT NOT NULL,
ADD COLUMN "fk_tarjeta" INT,
ADD COLUMN "fk_efectivo" INT,
ADD COLUMN "fk_cheque" INT,
ADD COLUMN "fk_mi_punto" INT;

-- Foraneas
ALTER TABLE "Pago_Metodo_Pago"
ADD CONSTRAINT "fk_venta_fisica"
FOREIGN KEY ("fk_venta_fisica") REFERENCES "Venta_Fisica"("ven_fis_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_venta_virtual"
FOREIGN KEY ("fk_venta_virtual") REFERENCES "Venta_Virtual"("detallev_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_tarjeta"
FOREIGN KEY ("fk_tarjeta") REFERENCES "Tarjeta"("met_pag_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_efectivo"
FOREIGN KEY ("fk_efectivo") REFERENCES "Efectivo"("met_pag_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cheque"
FOREIGN KEY ("fk_cheque") REFERENCES "Cheque"("met_pag_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_mi_punto"
FOREIGN KEY ("fk_mi_punto") REFERENCES "Mi_Punto"("met_pag_id")
ON DELETE CASCADE;

--Arco_Pago_Metodo_Pago
ALTER TABLE "Pago_Metodo_Pago"
ADD CHECK(
    CASE WHEN (fk_venta_fisica IS NOT NULL) AND (fk_venta_virtual IS NULL) THEN 1
    WHEN (fk_venta_virtual IS NOT NULL) AND (fk_venta_fisica IS NULL) THEN 1
    ELSE 0 END = 1
);

--Presentacion
-- Variables
ALTER TABLE "Presentacion"
ADD COLUMN "fk_caja" INT NOT NULL,
ADD COLUMN "fk_producto" INT NOT NULL,
ADD COLUMN "fk_material_tapa_1" INT NOT NULL,
ADD COLUMN "fk_material_tapa_2" INT NOT NULL,
ADD COLUMN "fk_material_tapa_3" INT NOT NULL,
ADD COLUMN "fk_material_botella_1" INT NOT NULL,
ADD COLUMN "fk_material_botella_2" INT NOT NULL,
ADD COLUMN "fk_material_botella_3" INT NOT NULL;

-- Foraneas
ALTER TABLE "Presentacion"
ADD CONSTRAINT "fk_caja"
FOREIGN KEY ("fk_caja") REFERENCES "Caja"("caj_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_producto"
FOREIGN KEY ("fk_producto") REFERENCES "Producto"("pro_codigo")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_material_tapa"
FOREIGN KEY ("fk_material_tapa_1", "fk_material_tapa_2", "fk_material_tapa_3") REFERENCES "Material_Tapa"("mat_tap_id", "fk_material", "fk_tapa")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_material_botella"
FOREIGN KEY ("fk_material_botella_1", "fk_material_botella_2", "fk_material_botella_3") REFERENCES "Material_Botella"("mat_bot_id", "fk_material", "fk_botella")
ON DELETE CASCADE;

--Presentacion_evento
-- Variables
ALTER TABLE "Presentacion_Evento"
ADD COLUMN "fk_premio" INT;

-- Foraneas
ALTER TABLE "Presentacion_Evento"
ADD CONSTRAINT "fk_premio"
FOREIGN KEY ("fk_premio") REFERENCES "Premio"("pre_id")
ON DELETE CASCADE;


-- Producto
-- Variables
ALTER TABLE "Producto"
ADD COLUMN "fk_añejamiento" INT NOT NULL,
ADD COLUMN "fk_proveedor" VARCHAR(16) NOT NULL,
ADD COLUMN "fk_lugar" INT NOT NULL,
ADD COLUMN "fk_categoria" INT NOT NULL,
ADD COLUMN "fk_variedad" INT NOT NULL;


-- Foraneas
ALTER TABLE "Producto"
ADD CONSTRAINT "fk_añejamiento"
FOREIGN KEY ("fk_añejamiento") REFERENCES "Añejamiento"("añe_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_proveedor"
FOREIGN KEY ("fk_proveedor") REFERENCES "Proveedor"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_lugar"
FOREIGN KEY ("fk_lugar") REFERENCES "Lugar"("lug_id"),
ADD CONSTRAINT "fk_categoria"
FOREIGN KEY ("fk_categoria") REFERENCES "Categoria"("cat_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_variedad"
FOREIGN KEY ("fk_variedad") REFERENCES "Variedad"("var_id")
ON DELETE CASCADE;


--Punto
-- Variables
ALTER TABLE "Punto"
ADD COLUMN "fk_fisica" INT,
ADD COLUMN "fk_virtual" INT;

-- Foraneas
ALTER TABLE "Punto"
ADD CONSTRAINT "fk_fisica"
FOREIGN KEY ("fk_fisica") REFERENCES "Fisica"("aso_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_virtual"
FOREIGN KEY ("fk_virtual") REFERENCES "Virtual"("aso_id")
ON DELETE CASCADE;

--Tarjeta
-- Variables
ALTER TABLE "Tarjeta"
ADD COLUMN "fk_cliente_juridico" VARCHAR(16),
ADD COLUMN "fk_cliente_natural_1" INT,
ADD COLUMN "fk_cliente_natural_2" VARCHAR(16);

-- Foraneas
ALTER TABLE "Tarjeta"
ADD CONSTRAINT "fk_cliente_juridico"
FOREIGN KEY ("fk_cliente_juridico") REFERENCES "Cliente_Juridico"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_natural_1"
FOREIGN KEY ("fk_cliente_natural_1", "fk_cliente_natural_2") REFERENCES "Cliente_Natural"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE;

--Arco Tarjeta
ALTER TABLE "Tarjeta"
ADD CHECK(
    CASE WHEN (fk_cliente_natural_1 IS NOT NULL AND fk_cliente_natural_2 IS NOT NULL) 
    AND fk_cliente_juridico IS NULL THEN 1
    WHEN (fk_cliente_natural_1 IS NULL AND fk_cliente_natural_2 IS NULL) 
    AND fk_cliente_juridico IS NOT NULL THEN 1
    ELSE 0 END = 1
);


--Telefono
ALTER TABLE "Telefono"
ADD COLUMN "fk_cliente_natural_1" INT,
ADD COLUMN "fk_cliente_natural_2" VARCHAR(16),
ADD COLUMN "fk_cliente_juridico" VARCHAR(16),
ADD COLUMN "fk_proveedor" VARCHAR(16),
ADD COLUMN "fk_empleado_1" INT,
ADD COLUMN "fk_empleado_2" VARCHAR(16);

-- Foraneas
ALTER TABLE "Telefono"
ADD CONSTRAINT "fk_cliente_natural"
FOREIGN KEY ("fk_cliente_natural_1", "fk_cliente_natural_2") REFERENCES "Cliente_Natural"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_juridico"
FOREIGN KEY ("fk_cliente_juridico") REFERENCES "Cliente_Juridico"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_proveedor"
FOREIGN KEY ("fk_proveedor") REFERENCES "Proveedor"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_empleado"
FOREIGN KEY ("fk_empleado_1", "fk_empleado_2") REFERENCES "Empleado"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE;

--Arco Telefono
ALTER TABLE "Telefono"
ADD CHECK(
    --Condion para que solo se llene cliente_natural
    CASE WHEN (fk_cliente_natural_1 IS NOT NULL AND fk_cliente_natural_2 IS NOT NULL)
    AND (fk_empleado_1 IS NULL AND fk_empleado_2 IS NULL) 
    AND (fk_proveedor IS NULL) AND (fk_cliente_juridico IS NULL) THEN 1
    --condicion para que solo se llene empleado
    WHEN (fk_empleado_1 IS NOT NULL AND fk_empleado_2 IS NOT NULL) 
    AND (fk_cliente_natural_1 IS NULL AND fk_cliente_natural_2 IS NULL)
    AND (fk_proveedor IS NULL) AND (fk_cliente_juridico IS NULL) THEN 1
    --condicion para que solo se llene proveedor
    WHEN (fk_proveedor IS NOT NULL) AND (fk_cliente_juridico IS NULL)
    AND  (fk_cliente_natural_1 IS NULL AND fk_cliente_natural_2 IS NULL)
    AND  (fk_empleado_1 IS NULL AND fk_empleado_2 IS NULL) THEN 1
    --condicion para que solo se llene cliente_juridico
    WHEN (fk_cliente_juridico IS NOT NULL) AND (fk_proveedor IS NULL)
    AND  (fk_cliente_natural_1 IS NULL AND fk_cliente_natural_2 IS NULL)
    AND  (fk_empleado_1 IS NULL AND fk_empleado_2 IS NULL) THEN 1
    ELSE 0 END = 1
);

-- Usuario
-- Variables
ALTER TABLE "Usuario"
ADD COLUMN "fk_rol" INT NOT NULL,
ADD COLUMN "fk_cliente_juridico" VARCHAR(16)  UNIQUE,
ADD COLUMN "fk_proveedor" VARCHAR(16)  UNIQUE,
ADD COLUMN "fk_cliente_natural_1" INT  UNIQUE,
ADD COLUMN "fk_cliente_natural_2"  VARCHAR(16)  UNIQUE,
ADD COLUMN "fk_empleado_1" INT UNIQUE,
ADD COLUMN "fk_empleado_2"  VARCHAR(16) UNIQUE;

-- Foraneas
ALTER TABLE "Usuario"
ADD CONSTRAINT "fk_rol"
FOREIGN KEY ("fk_rol") REFERENCES "Rol"("rol_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_juridico"
FOREIGN KEY ("fk_cliente_juridico") REFERENCES "Cliente_Juridico"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_proveedor"
FOREIGN KEY ("fk_proveedor") REFERENCES "Proveedor"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_natural_1"
FOREIGN KEY ("fk_cliente_natural_1", "fk_cliente_natural_2") REFERENCES "Cliente_Natural"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_empleado_1"
FOREIGN KEY ("fk_empleado_1", "fk_empleado_2") REFERENCES "Empleado"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE;

--Arco Usuario
ALTER TABLE "Usuario"
ADD CHECK(
    --Condion para que solo se llene cliente_natural
    CASE WHEN (fk_cliente_natural_1 IS NOT NULL AND fk_cliente_natural_2 IS NOT NULL)
    AND (fk_empleado_1 IS NULL AND fk_empleado_2 IS NULL) 
    AND (fk_proveedor IS NULL) AND (fk_cliente_juridico IS NULL) THEN 1
    --condicion para que solo se llene empleado
    WHEN (fk_empleado_1 IS NOT NULL AND fk_empleado_2 IS NOT NULL) 
    AND (fk_cliente_natural_1 IS NULL AND fk_cliente_natural_2 IS NULL)
    AND (fk_proveedor IS NULL) AND (fk_cliente_juridico IS NULL) THEN 1
    --condicion para que solo se llene proveedor
    WHEN (fk_proveedor IS NOT NULL) AND (fk_cliente_juridico IS NULL)
    AND  (fk_cliente_natural_1 IS NULL AND fk_cliente_natural_2 IS NULL)
    AND  (fk_empleado_1 IS NULL AND fk_empleado_2 IS NULL) THEN 1
    --condicion para que solo se llene cliente_juridico
    WHEN (fk_cliente_juridico IS NOT NULL) AND (fk_proveedor IS NULL)
    AND  (fk_cliente_natural_1 IS NULL AND fk_cliente_natural_2 IS NULL)
    AND  (fk_empleado_1 IS NULL AND fk_empleado_2 IS NULL) THEN 1
    ELSE 0 END = 1
);

--Venta_Fisica
-- Variables
ALTER TABLE "Venta_Fisica"
ADD COLUMN "fk_fisica" INT NOT NULL,
ADD COLUMN "fk_cliente_natural_1" INT NOT NULL,
ADD COLUMN "fk_cliente_natural_2" VARCHAR(16) NOT NULL,
ADD COLUMN "fk_cliente_juridico" VARCHAR(16) NOT NULL,
ADD COLUMN "fk_empleado_1" INT NOT NULL,
ADD COLUMN "fk_empleado_2" VARCHAR(16) NOT NULL,
ADD COLUMN "fk_infp_1" INT NOT NULL,
ADD COLUMN "fk_infp_2" INT NOT NULL,
ADD COLUMN "fk_infp_3" INT NOT NULL;

-- Foraneas
ALTER TABLE "Venta_Fisica"
ADD CONSTRAINT "fk_fisica"
FOREIGN KEY ("fk_fisica") REFERENCES "Fisica"("aso_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_natural"
FOREIGN KEY ("fk_cliente_natural_1", "fk_cliente_natural_2") REFERENCES "Cliente_Natural"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_juridico"
FOREIGN KEY ("fk_cliente_juridico") REFERENCES "Cliente_Juridico"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_empleado"
FOREIGN KEY ("fk_empleado_1", "fk_empleado_2") REFERENCES "Empleado"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_infp"
FOREIGN KEY ("fk_infp_1", "fk_infp_2","fk_infp_3") REFERENCES "Inventario_Fisico_Presentacion"("inv_fis_pre_id", "fk_fisica", "fk_presentacion")
ON DELETE CASCADE;

--Arco_venta_fisica
ALTER TABLE "Venta_Fisica"
ADD CHECK(
    CASE WHEN (fk_cliente_natural_1 IS NOT NULL AND fk_cliente_natural_2 IS NOT NULL) 
    AND fk_cliente_juridico IS NULL THEN 1
    WHEN (fk_cliente_natural_1 IS NULL AND fk_cliente_natural_2 IS NULL) 
    AND fk_cliente_juridico IS NOT NULL THEN 1
    ELSE 0 END = 1
);

-- Venta_Fisica_Entrada
-- Variables
ALTER TABLE "Venta_Fisica_Entrada"
ADD COLUMN "fk_cliente_natural_1" INT NOT NULL,
ADD COLUMN "fk_cliente_juridico" VARCHAR(16) NOT NULL,
ADD COLUMN "fk_cliente_natural_2" VARCHAR(16) NOT NULL,
ADD COLUMN "fk_fisica" INT NOT NULL;

-- Foraneas
ALTER TABLE "Venta_Fisica_Entrada"
ADD CONSTRAINT "fk_cliente_natural_1"
FOREIGN KEY ("fk_cliente_natural_1", "fk_cliente_natural_2") REFERENCES "Cliente_Natural"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_juridico"
FOREIGN KEY ("fk_cliente_juridico") REFERENCES "Cliente_Juridico"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_fisica"
FOREIGN KEY ("fk_fisica") REFERENCES "Fisica"("aso_id")
ON DELETE CASCADE;

--Arco_venta_fisica_entrada
--Arco_venta_fisica_entrada
ALTER TABLE "Venta_Fisica_Entrada"
ADD CHECK(
    CASE WHEN (fk_cliente_natural_1 IS NOT NULL AND fk_cliente_natural_2 IS NOT NULL) 
    AND fk_cliente_juridico IS NULL THEN 1
    WHEN (fk_cliente_natural_1 IS NULL AND fk_cliente_natural_2 IS NULL) 
    AND fk_cliente_juridico IS NOT NULL THEN 1
    ELSE 0 END = 1
);

--Venta_Virtual_Entrada
-- Variables
ALTER TABLE "Venta_Virtual_Entrada"
ADD COLUMN "fk_cliente_natural_1" INT NOT NULL,
ADD COLUMN "fk_cliente_juridico" VARCHAR(16) NOT NULL,
ADD COLUMN "fk_cliente_natural_2" VARCHAR(16) NOT NULL,
ADD COLUMN "fk_virtual" INT NOT NULL;

-- Foraneas
ALTER TABLE "Venta_Virtual_Entrada"
ADD CONSTRAINT "fk_cliente_natural_1"
FOREIGN KEY ("fk_cliente_natural_1", "fk_cliente_natural_2") REFERENCES "Cliente_Natural"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_Cliente_juridico"
FOREIGN KEY ("fk_cliente_juridico") REFERENCES "Cliente_Juridico"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_virtual"
FOREIGN KEY ("fk_virtual") REFERENCES "Virtual"("aso_id")
ON DELETE CASCADE;

--Arco_venta_virtual_entrada
ALTER TABLE "Venta_Virtual_Entrada"
ADD CHECK(
    CASE WHEN (fk_cliente_natural_1 IS NOT NULL AND fk_cliente_natural_2 IS NOT NULL) 
    AND fk_cliente_juridico IS NULL THEN 1
    WHEN (fk_cliente_natural_1 IS NULL AND fk_cliente_natural_2 IS NULL) 
    AND fk_cliente_juridico IS NOT NULL THEN 1
    ELSE 0 END = 1
);


--Venta_Virtual
ALTER TABLE "Venta_Virtual"
ADD COLUMN "fk_virtual" INT NOT NULL,
ADD COLUMN "fk_cliente_natural_1" INT NOT NULL,
ADD COLUMN "fk_cliente_juridico" VARCHAR(16) NOT NULL,
ADD COLUMN "fk_cliente_natural_2" VARCHAR(16) NOT NULL,
ADD COLUMN "fk_invp_1" INT NOT NULL,
ADD COLUMN "fk_invp_2" INT NOT NULL,
ADD COLUMN "fk_invp_3" INT NOT NULL;

-- Foraneas
ALTER TABLE "Venta_Virtual"
ADD CONSTRAINT "fk_virtual"
FOREIGN KEY ("fk_virtual") REFERENCES "Virtual"("aso_id")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_natural"
FOREIGN KEY ("fk_cliente_natural_1","fk_cliente_natural_2") REFERENCES "Cliente_Natural"("per_nat_id", "per_nat_ci")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_cliente_juridico"
FOREIGN KEY ("fk_cliente_juridico") REFERENCES "Cliente_Juridico"("per_jur_rif")
ON DELETE CASCADE,
ADD CONSTRAINT "fk_invp"
FOREIGN KEY ("fk_invp_1", "fk_invp_2","fk_invp_3") REFERENCES "Inventario_Virtual_Presentacion"("inv_vir_pre_id", "fk_virtual", "fk_presentacion")
ON DELETE CASCADE;












