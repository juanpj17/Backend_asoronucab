CREATE TABLE IF NOT EXISTS "Afiliado" (
    "afi_id" SERIAL,
    "afi_fecha_afiliacion" timestamp NOT NULL,
    "afi_QR" VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY("afi_id")
);

CREATE TABLE IF NOT EXISTS "Añejamiento" (
    "añe_id" SERIAL,
    "añe_descripcion" VARCHAR(255) NOT NULL,
    "añe_fecha_ini" timestamp NOT NULL,
    "añe_fecha_final" timestamp NOT NULL,
    "fk_añejamiento" INT,    
    PRIMARY KEY("añe_id"),
    CONSTRAINT "fk_añejamiento" FOREIGN KEY ("fk_añejamiento")
    REFERENCES "Añejamiento" ("añe_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Barril" (
    "bar_id" SERIAL,
    "bar_nombre" VARCHAR(48) NOT NULL,
    "bar_descripcion" VARCHAR(255) NOT NULL,
    "bar_tipo_madera" VARCHAR(255) NOT NULL,
    PRIMARY KEY("bar_id")
);

CREATE TABLE IF NOT EXISTS "Beneficio" (
    "ben_id" SERIAL,
    "ben_nombre" VARCHAR(48) NOT NULL,
    "ben_descripcion" VARCHAR(255) NOT NULL,
    "ben_fecha_inicial" timestamp NOT NULL,
    "ben_fecha_fin" timestamp NOT NULL,
    PRIMARY KEY("ben_id")
);

CREATE TABLE IF NOT EXISTS "Botella" (
    "bot_id" SERIAL,
    "bot_nombre" VARCHAR (48) NOT NULL,
    "bot_altura" NUMERIC(5,2) NOT NULL CHECK ("bot_altura" > 0),
    "bot_ancho" NUMERIC(5,2) NOT NULL CHECK ("bot_ancho" > 0),
    "bot_capacidad" NUMERIC(5,2) NOT NULL CHECK ("bot_capacidad" > 0),
    PRIMARY KEY("bot_id")
);

CREATE TABLE IF NOT EXISTS "Caja" (
    "caj_id" SERIAL,
    "caj_capacidad" NUMERIC(5,0) NOT NULL CHECK ("caj_capacidad" > 0),
    "caj_descripcion" VARCHAR(255) NOT NULL,
    "fk_caja" INT,
    PRIMARY KEY("caj_id"),
    CONSTRAINT "fk_caja" FOREIGN KEY ("fk_caja")
    REFERENCES "Caja" ("caj_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Categoria" (
    "cat_id" SERIAL,
    "cat_nombre" VARCHAR(48) NOT NULL,
    PRIMARY KEY("cat_id")
);

CREATE TABLE IF NOT EXISTS "Cheque" (
    "met_pag_id" SERIAL,
    "che_banco" VARCHAR(48) NOT NULL,
    "che_numero" VARCHAR(16) UNIQUE NOT NULL,
    PRIMARY KEY("met_pag_id")
);

CREATE TABLE IF NOT EXISTS "Cliente_Juridico" (
    "per_jur_rif" VARCHAR(16) CHECK(CHAR_LENGTH("per_jur_rif") = 10),
    "per_jur_denominacion_comercial" VARCHAR(255) UNIQUE NOT NULL,
    "per_jur_razon_social" VARCHAR(255) UNIQUE NOT NULL,
    "per_jur_pagina_web" VARCHAR(255) UNIQUE NOT NULL,
    "per_jur_direccion_fiscal" VARCHAR(255) NOT NULL,
    "per_jur_direccion_fisica" VARCHAR(255) NOT NULL,
    "per_jur_capital" NUMERIC(12,3) NOT NULL CHECK ("per_jur_capital" > 0),
    "per_jur_punto"   NUMERIC(5,0) CHECK ("per_jur_punto" >= 0),
    PRIMARY KEY("per_jur_rif")
);

CREATE TABLE IF NOT EXISTS "Cliente_Natural" (
    "per_nat_id" SERIAL,
    "per_nat_ci" VARCHAR(16) CHECK(CHAR_LENGTH("per_nat_ci") between 7 and 9),
    "per_nat_rif" VARCHAR(16) UNIQUE ,
    "per_nat_p_nombre" VARCHAR(48) NOT NULL,
    "per_nat_s_nombre" VARCHAR(48),
    "per_nat_p_apellido" VARCHAR(48) NOT NULL,
    "per_nat_s_apellido" VARCHAR(48),
    "per_nat_direccion" VARCHAR(255) NOT NULL,
    "per_nat_punto" NUMERIC(5,0) CHECK ("per_nat_punto" >= 0),
    PRIMARY KEY("per_nat_id", "per_nat_ci")
);

CREATE TABLE IF NOT EXISTS "Color" (
    "col_id" SERIAL,
    "col_nombre" VARCHAR(48) NOT NULL,
    "col_descripcion" VARCHAR(255),
    PRIMARY KEY("col_id")
);

CREATE TABLE IF NOT EXISTS "Compra" (
    "com_id" SERIAL,
    "com_fecha" timestamp NOT NULL,
    "com_total" NUMERIC(12,3) NOT NULL CHECK("com_total" > 0),
    PRIMARY KEY("com_id")
);


CREATE TABLE IF NOT EXISTS "Control_Accion" (
    "con_acc_id" SERIAL,
    "con_acc_accion" VARCHAR(255) NOT NULL CHECK("con_acc_accion" IN ('Crear', 'Modificar', 'Eliminar', 'Consultar')),
    "con_acc_tabla" VARCHAR(255) NOT NULL,
    "con_acc_fecha_hora" timestamp NOT NULL,
    PRIMARY KEY("con_acc_id")
);

CREATE TABLE IF NOT EXISTS "Correo" (
    "cor_id" SERIAL,
    "cor_direccion" VARCHAR(255) UNIQUE NOT NULL,
    PRIMARY KEY("cor_id")
);

CREATE TABLE IF NOT EXISTS "Departamento"(
    "dep_id" SERIAL,
    "dep_nombre" VARCHAR(48) NOT NULL,
    "dep_descripcion" VARCHAR(255) NOT NULL,
    PRIMARY KEY("dep_id")
);


CREATE TABLE IF NOT EXISTS "Destilacion" (
    "des_Id" SERIAL,
    "des_nombre" VARCHAR(48) NOT NULL,
    "des_descripcion" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("des_Id")
);

CREATE TABLE IF NOT EXISTS "Efectivo" (
    "met_pag_id" SERIAL,
    "met_pag_cantidad" INTEGER NOT NULL, 
    "ef_moneda" VARCHAR(48) NOT NULL CHECK ("ef_moneda" IN ('€','$', 'Bs.S')),
    PRIMARY KEY ("met_pag_id")
);

CREATE TABLE IF NOT EXISTS "Empleado" (
    "per_nat_id" SERIAL,
    "per_nat_ci" VARCHAR(16) CHECK(CHAR_LENGTH("per_nat_ci") between 7 and 9),
    "per_nat_rif" VARCHAR(16) UNIQUE ,
    "per_nat_p_nombre" VARCHAR(48) NOT NULL,
    "per_nat_s_nombre" VARCHAR(48),
    "per_nat_p_apellido" VARCHAR(48) NOT NULL,
    "per_nat_s_apellido" VARCHAR(48),
    "per_nat_direccion" VARCHAR(255) NOT NULL,
    "emp_sueldo" NUMERIC(10,2) NOT NULL CHECK ("emp_sueldo" > 0),
    "emp_fecha_ingreso" timestamp NOT NULL,
    PRIMARY KEY("per_nat_id", "per_nat_ci")
);

CREATE TABLE IF NOT EXISTS "Entrada" (
    "ent_id" SERIAL,
    "ent_fecha_hora" timestamp NOT NULL,
	"ent_precio" NUMERIC(10,2) NOT NULL CHECK ("ent_precio" > 0),
    PRIMARY KEY ("ent_id")
);

CREATE TABLE IF NOT EXISTS "Estatus" (
    "est_id" SERIAL,
    "est_nombre" VARCHAR(48) NOT NULL,
    PRIMARY KEY ("est_id")
);

CREATE TABLE IF NOT EXISTS "Evento" (
    "eve_id" SERIAL,
    "eve_nombre" VARCHAR(48) NOT NULL,
    "eve_descripcion" VARCHAR(350) NOT NULL,
    "eve_cantidad_entradas" NUMERIC(10, 0) NOT NULL CHECK ("eve_cantidad_entradas" >= 0),
    "eve_fecha_hora_inicial" timestamp NOT NULL,
    "eve_fecha_hora_final" timestamp NOT NULL,
    "eve_direccion" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("eve_id")
);

CREATE TABLE IF NOT EXISTS "Fermentacion" (
    "fer_Id" SERIAL,
    "fer_nombre" VARCHAR(48) NOT NULL,
    "fer_descripcion" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("fer_Id")
);

CREATE TABLE IF NOT EXISTS "Fisica" (
    "aso_id" SERIAL,
    "aso_rif" VARCHAR(16) NOT NULL CHECK(CHAR_LENGTH("aso_rif") = 10),
    "aso_direccion" VARCHAR(255),
    PRIMARY KEY ("aso_id")
);

CREATE TABLE IF NOT EXISTS "Horario" (
    "hor_id" SERIAL,
    "hor_dia" VARCHAR(48) NOT NULL 
    CHECK ("hor_dia" IN ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')),
    "hor_hora_entrada" timestamp NOT NULL,
    "hor_hora_salida" timestamp NOT NULL,
    PRIMARY KEY("hor_id")
);

CREATE TABLE IF NOT EXISTS "Imagen" (
    "ima_id" SERIAL,
    "ima_nombre" VARCHAR(48) NOT NULL,
    "ima_descripcion" VARCHAR(255) NOT NULL,
    "ima_url" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("ima_id")
);

CREATE TABLE IF NOT EXISTS "Lugar" (
    "lug_id" SERIAL,
    "lug_tipo" VARCHAR(48) NOT NULL CHECK ("lug_tipo" IN ('país', 'estado', 'municipio', 'parroquia')),
    "lug_nombre" VARCHAR(48) NOT NULL,
    "fk_lugar" INT,
    PRIMARY KEY ("lug_id"),
    CONSTRAINT "fk_lugar" FOREIGN KEY ("fk_lugar")
    REFERENCES "Lugar" ("lug_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Materia"(   
    "mat_id" SERIAL,
    "mat_nombre" VARCHAR(48) NOT NULL,
    "mat_descripcion" VARCHAR(255),
    PRIMARY KEY ("mat_id")
);

CREATE TABLE IF NOT EXISTS "Material" (
    "mat_id" SERIAL,
    "mat_nombre" VARCHAR(48) NOT NULL,
    "mat_descripcion" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("mat_id")
);

CREATE TABLE IF NOT EXISTS "Mi_Punto" (
    "met_pag_id" SERIAL,
    PRIMARY KEY ("met_pag_id")
);

CREATE TABLE IF NOT EXISTS "Nota_Cata" (
    "not_cat_id" SERIAL,
    "not_cat_descripcion" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("not_cat_id")
);

CREATE TABLE IF NOT EXISTS "Oferta" (
    "ofe_id" SERIAL,
    "ofe_valor" NUMERIC(10, 0) NOT NULL CHECK ("ofe_valor" > 0),
    "ofe_fecha_inicio" timestamp NOT NULL,
    "ofe_fecha_final" timestamp NOT NULL,
    PRIMARY KEY ("ofe_id")
);

CREATE TABLE IF NOT EXISTS "Pago_Afiliacion_Cuota" (
    "pa_af_cuo_id" SERIAL,
    "pa_af_cuo_total" NUMERIC(12,3) NOT NULL CHECK ("pa_af_cuo_total" > 0),
    "pa_af_cuo_fecha" timestamp NOT NULL,
    "pa_af_cuo_mes_can" VARCHAR(48) NOT NULL CHECK ("pa_af_cuo_mes_can" IN ('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octumbre', 'Noviembre', 'Diciembre')),
    PRIMARY KEY("pa_af_cuo_id")
);

CREATE TABLE IF NOT EXISTS "Permiso" (
    "per_id" SERIAL,
    "per_accion" VARCHAR(48) NOT NULL CHECK ("per_accion" IN ('Crear', 'Modificar', 'Eliminar', 'Consultar')),
    "per_tabla" VARCHAR(48) NOT NULL,
    PRIMARY KEY ("per_id")
);

CREATE TABLE IF NOT EXISTS "Presentacion" (
    "pre_id" SERIAL,
    "pre_nombre" VARCHAR(48) NOT NULL,
    "pre_descripcion" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("pre_id")
);

CREATE TABLE IF NOT EXISTS "Premio" (
    "pre_id" SERIAL,
    "pre_nombre" VARCHAR(48) NOT NULL,
    PRIMARY KEY ("pre_id")
);

CREATE TABLE IF NOT EXISTS "Producto" (
    "pro_codigo" SERIAL,
    "pro_nombre" VARCHAR(48) NOT NULL,
    "pro_grados_alcohol" NUMERIC NOT NULL CHECK ("pro_grados_alcohol" > 0),
    "pro_descripcion" VARCHAR(255) NOT NULL,
    "pro_tipo" VARCHAR(48) NOT NULL CHECK ("pro_tipo" IN ('Agricola', 'Industrial')),
    PRIMARY KEY ("pro_codigo")
);

CREATE TABLE IF NOT EXISTS "Proveedor" (
    "per_jur_rif" VARCHAR(16) CHECK(CHAR_LENGTH("per_jur_rif") = 10),
    "per_jur_denominacion_comercial" VARCHAR(255) UNIQUE NOT NULL,
    "per_jur_razon_social" VARCHAR(255) UNIQUE NOT NULL,
    "per_jur_pagina_web" VARCHAR(255) UNIQUE NOT NULL,
    "per_jur_direccion_fiscal" VARCHAR(255) NOT NULL,
    "per_jur_direccion_fisica" VARCHAR(255) NOT NULL,
    "per_jur_capital" NUMERIC(12,3) NOT NULL CHECK ("per_jur_capital" > 0),
    PRIMARY KEY ("per_jur_rif")
);

CREATE TABLE IF NOT EXISTS "Punto" (
    "pun_id" SERIAL,
    "pun_valor" NUMERIC(12,3) NOT NULL CHECK ("pun_valor" > 0),
    "pun_fecha_inicial" timestamp NOT NULL,
    "pun_fecha_final" timestamp,
    PRIMARY KEY ("pun_id")
);

CREATE TABLE IF NOT EXISTS "Rol" (
    "rol_id" SERIAL,
    "rol_nombre" VARCHAR(48) NOT NULL,
    "rol_descripcion" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("rol_id")
);

CREATE TABLE IF NOT EXISTS "Sabor" (
    "sab_id" SERIAL,
    "sab_nombre" VARCHAR(48) NOT NULL,
    "sab_descripcion" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("sab_id")
);

CREATE TABLE IF NOT EXISTS "Tapa" (
    "tap_id" SERIAL,
    "tap_descripcion" VARCHAR(255) NOT NULL,
    "tap_largo" NUMERIC(5,2) NOT NULL CHECK ("tap_largo" > 0),
    "tap_ancho" NUMERIC(5,2) NOT NULL CHECK ("tap_ancho" > 0),
    "tap_radio" NUMERIC(5,2) NOT NULL CHECK ("tap_radio" > 0),
    PRIMARY KEY ("tap_id")
);

CREATE TABLE IF NOT EXISTS "Tarjeta"(
    "met_pag_id" SERIAL,
    "tar_nombre" VARCHAR(48) NOT NULL,
    "tar_numero" VARCHAR(16) NOT NULL,
    "tar_CVV" VARCHAR(3) NOT NULL,
    "tar_fecha_vencimiento" timestamp NOT NULL,
    PRIMARY KEY ("met_pag_id")
);

CREATE TABLE IF NOT EXISTS "Tasa"(
    "tas_id" SERIAL,
    "tas_valor" NUMERIC(12, 3) NOT NULL CHECK ("tas_valor" > 0),
    "tas_fecha_inicial" timestamp NOT NULL,
    "tas_fecha_final" timestamp,
    PRIMARY KEY ("tas_id")
);

CREATE TABLE IF NOT EXISTS "Telefono"(
    "tel_id" SERIAL,
    "tel_tipo" VARCHAR(48) NOT NULL,
    "tel_numero" VARCHAR(16) UNIQUE NOT NULL,
    PRIMARY KEY ("tel_id")
);

CREATE TABLE IF NOT EXISTS "Usuario"(
    "usu_id" SERIAL,
    "usu_contraseña" VARCHAR(48) NOT NULL,
    PRIMARY KEY ("usu_id")
);

CREATE TABLE IF NOT EXISTS "Vacacion"(
    "vac_id" SERIAL,
    "vac_fecha_inicio" timestamp NOT NULL,
    "vac_fecha_fin" timestamp NOT NULL,
    PRIMARY KEY ("vac_id")
);

CREATE TABLE IF NOT EXISTS "Variedad"(
    "var_id" SERIAL,
    "var_nombre" VARCHAR(48) NOT NULL,
    PRIMARY KEY ("var_id")
);

CREATE TABLE IF NOT EXISTS "Venta_Fisica"(
    "ven_fis_id" SERIAL,
    "ven_fis_fecha" timestamp NOT NULL,
    "ven_fis_total" NUMERIC(12, 3) NOT NULL CHECK ("ven_fis_total" > 0),
    PRIMARY KEY ("ven_fis_id")
);

CREATE TABLE IF NOT EXISTS "Venta_Fisica_Entrada"(
    "ven_fis_ent_id" SERIAL,
    "ven_fis_ent_fecha" timestamp NOT NULL,
    "ven_fis_ent_total" NUMERIC(12,3) NOT NULL CHECK ("ven_fis_ent_total" > 0),
    PRIMARY KEY ("ven_fis_ent_id")
);

CREATE TABLE IF NOT EXISTS "Virtual"(   
    "aso_id" SERIAL,
    "aso_rif" VARCHAR(16) NOT NULL CHECK(CHAR_LENGTH("aso_rif") = 10),
    "aso_pag_web" VARCHAR(255) NOT NULL,
    PRIMARY KEY("aso_id")
);

CREATE TABLE IF NOT EXISTS "Venta_Virtual"(
    "detallev_id" SERIAL,
    "detallev_fecha_venta" timestamp NOT NULL, 
    "detallev_total_venta" NUMERIC(10, 0) NOT NULL CHECK ("detallev_total_venta" >= 0),
    PRIMARY KEY("detallev_id")
);

CREATE TABLE IF NOT EXISTS "Venta_Virtual_Entrada"(
    "ven_vir_ent_id" SERIAL,
    "ven_vir_ent_cantidad" 
    NUMERIC(10, 0) NOT NULL CHECK ("ven_vir_ent_cantidad" > 0),
    "ven_vir_ent_precio_venta" 
    NUMERIC(10, 0) NOT NULL CHECK ("ven_vir_ent_precio_venta" > 0),
    PRIMARY KEY("ven_vir_ent_id")
);


-----------------------------------------------Tablas N a N------------------------------------------------------------ 

CREATE TABLE IF NOT EXISTS "Compra_Presentacion" (
    "com_pre_id" SERIAL,
    "com_pre_cantidad" NUMERIC(10,0) NOT NULL CHECK ("com_pre_cantidad" > 0),
    "com_pre_precio_unitario" NUMERIC(10, 0) NOT NULL CHECK ("com_pre_precio_unitario" > 0),
    "fk_presentacion" INT,
    "fk_compra" INT,
    PRIMARY KEY("com_pre_id", "fk_presentacion", "fk_compra"),
    CONSTRAINT "fk_presentacion" FOREIGN KEY ("fk_presentacion")
    REFERENCES "Presentacion" ("pre_id") ON DELETE CASCADE,
    CONSTRAINT "fk_compra" FOREIGN KEY ("fk_compra")
    REFERENCES "Compra" ("com_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Compra_Estatus"
(
    com_est_id serial,
    com_est_fecha_ini timestamp NOT NULL,
    com_estfecha_fin timestamp,
    fk_compra integer NOT NULL,
    fk_estatus integer NOT NULL,
    CONSTRAINT "Compra_Estatus_pkey" PRIMARY KEY (com_est_id, fk_compra, fk_estatus),
    CONSTRAINT fk_estatus FOREIGN KEY (fk_estatus)
        REFERENCES public."Estatus" (est_id) 
        ON DELETE CASCADE,
    CONSTRAINT fk_compra FOREIGN KEY (fk_compra)
        REFERENCES public."Compra" (com_id) 
        ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS "Presentacion_Evento"(
    "pre_eve_id" SERIAL,    
    "pre_eve_cantidad" NUMERIC(10, 0) CHECK ("pre_eve_cantidad" >= 0),
    "pre_eve_precio_venta" NUMERIC(12, 3) CHECK ("pre_eve_precio_venta" >=0),
    "fk_presentacion" INT,
    "fk_evento" INT,
    PRIMARY KEY ("pre_eve_id", "fk_presentacion", "fk_evento"),
    CONSTRAINT "fk_presentacion" FOREIGN KEY ("fk_presentacion")
    REFERENCES "Presentacion" ("pre_id") ON DELETE CASCADE,
    CONSTRAINT "fk_evento" FOREIGN KEY ("fk_evento")
    REFERENCES "Evento" ("eve_id") ON DELETE CASCADE

);

CREATE TABLE IF NOT EXISTS "Detalle_Venta_Fisica_Entrada_Entrada" (
    "det_ven_fis_ent_ent_id" SERIAL,
    "det_ven_fis_ent_ent_cantidad_ent" 
    NUMERIC(10, 0) NOT NULL CHECK ("det_ven_fis_ent_ent_cantidad_ent" >= 0),
    "det_ven_fis_ent_ent_precio_unitario" 
    NUMERIC(12,3) NOT NULL CHECK ("det_ven_fis_ent_ent_precio_unitario" > 0),
    "fk_venta_fisica_entrada" INT,
    "fk_entrada" INT UNIQUE NOT NULL,
    PRIMARY KEY ("det_ven_fis_ent_ent_id", "fk_venta_fisica_entrada"),
    CONSTRAINT "fk_venta_fisica_entrada" FOREIGN KEY ("fk_venta_fisica_entrada")
    REFERENCES "Venta_Fisica_Entrada" ("ven_fis_ent_id") ON DELETE CASCADE,
    CONSTRAINT "fk_entrada" FOREIGN KEY ("fk_entrada")
    REFERENCES "Entrada" ("ent_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Detalle_Venta_Fisica_Presentacion" (
    "det_ven_fis_pre_id" SERIAL,
    "det_ven_fis_pre_cantidad" 
    NUMERIC(10,0) NOT NULL CHECK ("det_ven_fis_pre_cantidad" > 0),
    "det_ven_fis_pre_precio_venta" 
    NUMERIC(12,3) NOT NULL CHECK ("det_ven_fis_pre_precio_venta" > 0),
    "fk_venta_fisica" INT,
    "fk_presentacion" INT,
    PRIMARY KEY("det_ven_fis_pre_id", "fk_presentacion"),
    CONSTRAINT "fk_presentacion" FOREIGN KEY ("fk_presentacion")
    REFERENCES "Presentacion" ("pre_id") ON DELETE CASCADE,
    CONSTRAINT "fk_venta_fisica" FOREIGN KEY ("fk_venta_fisica")
    REFERENCES "Venta_Fisica" ("ven_fis_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Detalle_Venta_Fisica_Presentacion_Evento" (
    "det_ven_fis_pre_eve_id" SERIAL,
    "det_ven_fis_pre_eve_cantidad" 
    NUMERIC(10,0) NOT NULL CHECK ("det_ven_fis_pre_eve_cantidad" >= 0),
    "det_ven_fis_pre_eve_precio_venta" 
    NUMERIC(12,3) NOT NULL CHECK ("det_ven_fis_pre_eve_precio_venta" > 0),
    "fk_venta_fisica" INT,
    "fk_presentacion_evento" INT,
    "fk_presentacion_evento_1" INT,
    "fk_presentacion_evento_2" INT,
    PRIMARY KEY("det_ven_fis_pre_eve_id", "fk_presentacion_evento", "fk_presentacion_evento_1", "fk_presentacion_evento_2"),
    CONSTRAINT "fk_presentacion_evento" FOREIGN KEY ("fk_presentacion_evento", "fk_presentacion_evento_1", "fk_presentacion_evento_2")
    REFERENCES "Presentacion_Evento" ("pre_eve_id","fk_presentacion", "fk_evento" ) ON DELETE CASCADE,
        CONSTRAINT "fk_venta_fisica" FOREIGN KEY ("fk_venta_fisica")
    REFERENCES "Venta_Fisica" ("ven_fis_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Detalle_Venta_Virtual_Entrada_Entrada" (
    "det_ven_vir_ent_ent_id" SERIAL,
    "det_ven_vir_ent_ent_cantidad_ent" 
    NUMERIC(10,0) NOT NULL CHECK ("det_ven_vir_ent_ent_cantidad_ent" >= 0),
    "det_ven_vir_ent_ent_precio_unitario" 
    NUMERIC(12,3) NOT NULL CHECK ("det_ven_vir_ent_ent_precio_unitario" > 0),
    "fk_venta_virtual_entrada" INT,
    "fk_entrada" INT UNIQUE NOT NULL,
    PRIMARY KEY ("det_ven_vir_ent_ent_id", "fk_venta_virtual_entrada"),
    CONSTRAINT "fk_venta_virtual_entrada" FOREIGN KEY ("fk_venta_virtual_entrada")
    REFERENCES "Venta_Virtual_Entrada" ("ven_vir_ent_id") ON DELETE CASCADE,
    CONSTRAINT "fk_entrada" FOREIGN KEY ("fk_entrada")
    REFERENCES "Entrada" ("ent_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Detalle_Venta_Virtual_Presentacion" (
    "det_ven_vir_pre_id" SERIAL,
    "det_ven_vir_pre_cantidad" 
    NUMERIC(10,0) NOT NULL CHECK ("det_ven_vir_pre_cantidad" >= 0),
    "det_ven_vir_pre_precio_venta" 
    NUMERIC(12,3) NOT NULL CHECK ("det_ven_vir_pre_precio_venta" > 0),
    "fk_venta_virtual" INT,
    "fk_presentacion" INT,
    PRIMARY KEY ("det_ven_vir_pre_id", "fk_venta_virtual", "fk_presentacion"),
    CONSTRAINT "fk_venta_virtual" FOREIGN KEY ("fk_venta_virtual")
    REFERENCES "Venta_Virtual" ("detallev_id") ON DELETE CASCADE,
    CONSTRAINT "fk_presentacion" FOREIGN KEY ("fk_presentacion")
    REFERENCES "Presentacion" ("pre_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Empleado_Beneficio" (
    "emp_ben_id" SERIAL,
    "fk_empleado" INT,
    "fk_empleado_2" VARCHAR(16),    
    "fk_beneficio" INT, 
    PRIMARY KEY ("emp_ben_id","fk_empleado","fk_empleado_2","fk_beneficio"),
    CONSTRAINT "fk_empleado" FOREIGN KEY ("fk_empleado", "fk_empleado_2") 
    REFERENCES "Empleado" ("per_nat_id", "per_nat_ci") ON DELETE CASCADE,
    CONSTRAINT "fk_beneficio" FOREIGN KEY ("fk_beneficio") 
    REFERENCES "Beneficio" ("ben_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Empleado_Departamento" (
    "emp_dep_id" SERIAL,
    "fk_empleado" INT,
    "fk_empleado_2" VARCHAR(16),
    "fk_departamento" INT,
    "emp_dep_cargo" VARCHAR(48) NOT NULL,
    "emp_dep_fecha_inicio" timestamp NOT NULL,
    "emp_dep_fecha_fin" timestamp,
    PRIMARY KEY ("emp_dep_id", "fk_empleado", "fk_empleado_2", "fk_departamento"),
    CONSTRAINT "fk_empleado" FOREIGN KEY ("fk_empleado", "fk_empleado_2")
    REFERENCES "Empleado" ("per_nat_id", "per_nat_ci") ON DELETE CASCADE,
    CONSTRAINT "fk_departamento" FOREIGN KEY ("fk_departamento")
    REFERENCES "Departamento" ("dep_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Empleado_Horario" (
    "emp_hor_id" SERIAL,
    "fk_empleado" INT,
    "fk_empleado_2" VARCHAR(16),
    "fk_horario" INT,
    PRIMARY KEY("emp_hor_id", "fk_empleado", "fk_empleado_2", "fk_horario"),
    CONSTRAINT "fk_empleado" FOREIGN KEY ("fk_empleado", "fk_empleado_2")
    REFERENCES "Empleado" ("per_nat_id", "per_nat_ci") ON DELETE CASCADE,
    CONSTRAINT "fk_horario" FOREIGN KEY ("fk_horario")
    REFERENCES "Horario" ("hor_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Inventario_Fisico_Presentacion" (
    "inv_fis_pre_id" SERIAL,
    "inv_fis_cantidad" NUMERIC(10,0) NOT NULL CHECK ("inv_fis_cantidad" > 0),
    "inv_fis_precio" NUMERIC(10,0) NOT NULL CHECK ("inv_fis_precio" > 0),
    "fk_fisica" INT,
    "fk_presentacion" INT,
    PRIMARY KEY("inv_fis_pre_id", "fk_fisica", "fk_presentacion"),
    CONSTRAINT "fk_fisica" FOREIGN KEY ("fk_fisica")
    REFERENCES "Fisica" ("aso_id") ON DELETE CASCADE,
    CONSTRAINT "fk_presentacion" FOREIGN KEY ("fk_presentacion")
    REFERENCES "Presentacion" ("pre_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Inventario_Virtual_Presentacion" (
    "inv_vir_pre_id" SERIAL,
    "inv_vir_pre_cantidad" NUMERIC(10,0) NOT NULL CHECK ("inv_vir_pre_cantidad" > 0),
    "inv_vir_precio" NUMERIC(10,0) NOT NULL CHECK ("inv_vir_precio" > 0),
    "fk_virtual" INT,
    "fk_presentacion" INT,
    PRIMARY KEY ("inv_vir_pre_id", "fk_virtual", "fk_presentacion"),
    CONSTRAINT "fk_virtual" FOREIGN KEY ("fk_virtual")
    REFERENCES "Virtual" ("aso_id") ON DELETE CASCADE,
    CONSTRAINT "fk_presentacion" FOREIGN KEY ("fk_presentacion")
    REFERENCES "Presentacion" ("pre_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Lugar_Persona" (
    "lug_per_id" SERIAL,
    "Lug_per_tipo" VARCHAR(48) NOT NULL CHECK ("Lug_per_tipo" IN ('Fiscal', 'Fisica')),
    "fk_lugar" INT,
    "fk_cliente_juridico" VARCHAR(16),
    "fk_proveedor" VARCHAR(16),
    PRIMARY KEY ("lug_per_id", "fk_lugar"),
    CONSTRAINT "fk_lugar" FOREIGN KEY ("fk_lugar")
    REFERENCES "Lugar" ("lug_id") ON DELETE CASCADE,
    CONSTRAINT "fk_cliente_juridico" FOREIGN KEY ("fk_cliente_juridico")
    REFERENCES "Cliente_Juridico" ("per_jur_rif") ON DELETE CASCADE,
    CONSTRAINT "fk_proveedor" FOREIGN KEY ("fk_proveedor")
    REFERENCES "Proveedor" ("per_jur_rif") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Material_Botella" (
    "mat_bot_id" SERIAL,
    "mat_bot_peso" NUMERIC(5,2) NOT NULL CHECK ("mat_bot_peso" > 0),
    "fk_material" INT,
    "fk_botella" INT,
    PRIMARY KEY ("mat_bot_id", "fk_material", "fk_botella"),
    CONSTRAINT "fk_material" FOREIGN KEY ("fk_material")
    REFERENCES "Material" ("mat_id") ON DELETE CASCADE,
    CONSTRAINT "fk_botella" FOREIGN KEY ("fk_botella")
    REFERENCES "Botella" ("bot_id") ON DELETE CASCADE   
);

CREATE TABLE IF NOT EXISTS "Material_Tapa" (
    "mat_tap_id" SERIAL,
    "fk_material" INT,
    "fk_tapa" INT,
    PRIMARY KEY ("mat_tap_id", "fk_material", "fk_tapa"),
    CONSTRAINT "fk_material" FOREIGN KEY ("fk_material")
    REFERENCES "Material" ("mat_id") ON DELETE CASCADE,
    CONSTRAINT "fk_tapa" FOREIGN KEY ("fk_tapa")
    REFERENCES "Tapa" ("tap_id") ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS "Pago_Afiliacion_Cuota_Metodo_Pago" (
    "pa_af_me_pa_id" SERIAL,
    "Monto_parcial" NUMERIC(12, 3) NOT NULL CHECK ("Monto_parcial" > 0),
    "fk_pago_afiliacion_cuota" INT,
    PRIMARY KEY ("pa_af_me_pa_id", "fk_pago_afiliacion_cuota"),
    CONSTRAINT "fk_pago_afiliacion_cuota" FOREIGN KEY ("fk_pago_afiliacion_cuota")
    REFERENCES "Pago_Afiliacion_Cuota" ("pa_af_cuo_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Pago_Entrada_Metodo_Pago" (
    "pag_ent_met_pag_id" SERIAL,
    "pag_ent_met_pag_Monto_parcial" NUMERIC(12, 3) NOT NULL CHECK ("pag_ent_met_pag_Monto_parcial" > 0),
    "fk_entrada" INT,
     PRIMARY KEY ("pag_ent_met_pag_id", "fk_entrada"),
    CONSTRAINT "fk_entrada" FOREIGN KEY ("fk_entrada")
    REFERENCES "Entrada" ("ent_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Pago_Metodo_Pago" (
    "pag_met_pag_id" SERIAL,
    "monto_parcial" NUMERIC NOT NULL CHECK ("monto_parcial" > 0),
    PRIMARY KEY ("pag_met_pag_id")
);

CREATE TABLE IF NOT EXISTS "Producto_Color" (
    "pro_col_id" SERIAL,
    "fk_producto" INT,
    "fk_color" INT,
    PRIMARY KEY ("pro_col_id", "fk_producto", "fk_color"),
    CONSTRAINT "fk_producto" FOREIGN KEY ("fk_producto")
    REFERENCES "Producto" ("pro_codigo") ON DELETE CASCADE,
    CONSTRAINT "fk_color" FOREIGN KEY ("fk_color")
    REFERENCES "Color" ("col_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Producto_Materia" (
    "pro_mat_id" SERIAL,
    "fk_producto" INT,
    "fk_materia" INT,
    PRIMARY KEY ("pro_mat_id", "fk_producto", "fk_materia"),
    CONSTRAINT "fk_producto" FOREIGN KEY ("fk_producto")
    REFERENCES "Producto" ("pro_codigo") ON DELETE CASCADE,
    CONSTRAINT "fk_materia" FOREIGN KEY ("fk_materia")
    REFERENCES "Materia" ("mat_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Producto_Sabor" (
    "pro_sab_id" SERIAL,
    "fk_producto" INT,
    "fk_sabor" INT,
    PRIMARY KEY ("pro_sab_id", "fk_producto", "fk_sabor"),
    CONSTRAINT "fk_producto" FOREIGN KEY ("fk_producto")
    REFERENCES "Producto" ("pro_codigo") ON DELETE CASCADE,
    CONSTRAINT "fk_sabor" FOREIGN KEY ("fk_sabor")
    REFERENCES "Sabor" ("sab_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Presentacion_Oferta" (
    "pre_ofe_id" SERIAL,
    "pre_ofe_valor" NUMERIC(12, 3) NOT NULL,
    "fk_presentacion" INT,
    "fk_oferta" INT,
    PRIMARY KEY ("pre_ofe_id", "fk_presentacion", "fk_oferta"),
    CONSTRAINT "fk_presentacion" FOREIGN KEY ("fk_presentacion")
    REFERENCES "Presentacion" ("pre_id") ON DELETE CASCADE,
    CONSTRAINT "fk_oferta" FOREIGN KEY ("fk_oferta")
    REFERENCES "Oferta" ("ofe_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Rol_Permiso" (
    "rol_per_id" SERIAL,
    "fk_rol" INT,
    "fk_permiso" INT,
    PRIMARY KEY ("rol_per_id", "fk_rol", "fk_permiso"),
    CONSTRAINT "fk_rol" FOREIGN KEY ("fk_rol")
    REFERENCES "Rol" ("rol_id") ON DELETE CASCADE,
    CONSTRAINT "fk_permiso" FOREIGN KEY ("fk_permiso")
    REFERENCES "Permiso" ("per_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Venta_Fisica_Estatus"(
    "ven_fis_est_id" SERIAL,
    "ven_fis_est_fecha_ini" VARCHAR(48) NOT NULL,
    "ven_fis_est_fecha_fin" VARCHAR(48),
    "fk_venta_fisica" INT,
    "fk_estatus" INT,
    PRIMARY KEY ("ven_fis_est_id", "fk_venta_fisica", "fk_estatus"),
    CONSTRAINT "fk_venta_fisica" FOREIGN KEY ("fk_venta_fisica")
    REFERENCES "Venta_Fisica" ("ven_fis_id") ON DELETE CASCADE,
    CONSTRAINT "fk_estatus" FOREIGN KEY ("fk_estatus")
    REFERENCES "Estatus" ("est_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Venta_Virtual_Estatus"(
    "ven_vir_est_id" SERIAL,
    "ven_vir_est_fecha_ini" VARCHAR(48) NOT NULL,
    "ven_vir_est_fecha_fin" VARCHAR(48),
    "fk_venta_virtual" INT,
    "fk_estatus" INT,
    PRIMARY KEY ("ven_vir_est_id", "fk_venta_virtual", "fk_estatus"),
    CONSTRAINT "fk_venta_virtual" FOREIGN KEY ("fk_venta_virtual")
    REFERENCES "Venta_Virtual" ("detallev_id") ON DELETE CASCADE,
    CONSTRAINT "fk_estatus" FOREIGN KEY ("fk_estatus")
    REFERENCES "Estatus" ("est_id") ON DELETE CASCADE
);


--------------------------------------------------------CRUDS-------------------------------------------------------------


------------------------------------------------------Producto-------------------------------------------------------
-----Insertar Producto
CREATE OR REPLACE FUNCTION public.registrar_producto(
	nombre character varying,
	descripcion character varying,
	gradosa numeric,
	tipo character varying,
	anejamiento integer,
	proveedor varchar,
	parroquia integer,
	categoria integer,
	variedad integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE mensaje varchar;
declare aux boolean;
BEGIN 
aux:=REPLACE(nombre, ' ', '') !~ '[^a-zA-z]';
	if  (REPLACE(nombre, ' ', '')='' or REPLACE(descripcion, ' ', '')='' or REPLACE(tipo, ' ', '')='')then
		mensaje:='Hay campos obligatorios vacios en el registro';
	else
		if not aux then
			mensaje:='El nombre del producto no acepta numeros ni caracteres especiales';
		else
			INSERT INTO public."Producto"(
			 pro_nombre, pro_grados_alcohol, pro_descripcion, pro_tipo, "fk_añejamiento", fk_proveedor, fk_lugar, fk_categoria, fk_variedad)
			 VALUES (nombre, gradosA,descripcion ,tipo, anejamiento, proveedor, parroquia, categoria, variedad);
			 mensaje:='Registro exitoso';
		end if;
	end if;
    RETURN mensaje ;
END;
$BODY$;

--Seleccionar Producto
CREATE OR REPLACE FUNCTION public.seleccionar_productos()
RETURNS TABLE(
    codigo integer,
    nombre character varying,
    grados_alcohol numeric,
    descripcion character varying,
    tipo character varying,
    parroquia integer,
    categoria integer,
    variedad integer,
    url varchar,
    capacidad numeric,
	precio numeric
)
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
ROWS 1000
AS $BODY$
BEGIN
    RETURN QUERY 
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
		inv.inv_vir_precio
    FROM "Producto" as pr
    JOIN "Imagen" as i ON i."fk_producto" = pr."pro_codigo"
    JOIN "Presentacion" as pre ON pre."fk_producto" = pr."pro_codigo"
    JOIN "Botella" as b ON b."bot_id" = pre."fk_material_botella_3"
    JOIN "Inventario_Virtual_Presentacion" as inv ON  "fk_presentacion" = "pre_id";
END;
$BODY$;

-- Eliminar Producto
CREATE OR REPLACE FUNCTION public.eliminar_producto(
	codigo integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	UPDATE public."Imagen"
	SET  fk_producto=null
	WHERE fk_producto=codigo;
	DELETE FROM public."Producto"
	WHERE pro_codigo=codigo;
end;
$BODY$;

--Seleccionar_proveedor
CREATE OR REPLACE FUNCTION "seleccionar_proveedor"()
RETURNS TABLE
(
	RIF VARCHAR(16),
	nombre VARCHAR
)
AS $$
BEGIN

	RETURN QUERY
	SELECT "per_jur_rif", "per_jur_razon_social"
	FROM "Proveedor";

END;
$$ LANGUAGE plpgsql;

--Seleccionar parroquias
CREATE OR REPLACE FUNCTION "seleccionar_parroquias"()
RETURNS TABLE
(
	id INT,
	nombre VARCHAR(255)
)
AS $$
BEGIN

	RETURN QUERY
	SELECT "lug_id", "lug_nombre"
	FROM "Lugar"
	WHERE "lug_tipo" = 'parroquia';

END;
$$ LANGUAGE plpgsql;

--Seleccionar_añejamiento
CREATE OR REPLACE FUNCTION "seleccionar_añejamiento"()
RETURNS TABLE
(
	id INT,
	nombre VARCHAR(255)
)
AS $$
BEGIN

	RETURN QUERY
	SELECT "añe_id", "añe_descripcion"
	FROM "Añejamiento";

END;
$$ LANGUAGE plpgsql;


--Seleccionar_categoria
CREATE OR REPLACE FUNCTION "seleccionar_categoria"()
RETURNS TABLE
(
	id INT,
	nombre VARCHAR(255)
)
AS $$
BEGIN

	RETURN QUERY
	SELECT "cat_id", "cat_nombre"
	FROM "Categoria";

END;
$$ LANGUAGE plpgsql;

--Seleccionar_variedad
CREATE OR REPLACE FUNCTION "seleccionar_variedad"()
RETURNS TABLE
(
	codigo INT,
	nombre VARCHAR
)
AS $$
BEGIN

	RETURN QUERY
	SELECT "var_id", "var_nombre"
	FROM "Variedad";

END;
$$ LANGUAGE plpgsql;

--seleccionar sabor
CREATE OR REPLACE FUNCTION "seleccionar_sabor"()
RETURNS TABLE
(
	codigo INT,
	nombre VARCHAR
)
AS $$
BEGIN

	RETURN QUERY
	SELECT "sab_id", "sab_nombre"
	FROM "Sabor";

END;
$$ LANGUAGE plpgsql;

--Seleccionar Color
CREATE OR REPLACE FUNCTION "seleccionar_color"()
RETURNS TABLE
(
	codigo INT,
	nombre VARCHAR
)
AS $$
BEGIN

	RETURN QUERY
	SELECT "col_id", "col_nombre"
	FROM "Color";

END;
$$ LANGUAGE plpgsql;

--Seleccionar materia
CREATE OR REPLACE FUNCTION "seleccionar_materia"()
RETURNS TABLE
(
	codigo INT,
	nombre VARCHAR
)
AS $$
BEGIN

	RETURN QUERY
	SELECT "mat_id", "mat_nombre"
	FROM "Materia";

END;
$$ LANGUAGE plpgsql;

--Seleccionar imagen
CREATE OR REPLACE FUNCTION "seleccionar_imagen"()
RETURNS TABLE
(
	codigo INT,
	url VARCHAR
)
AS $$
BEGIN

	RETURN QUERY
	SELECT "ima_id", "ima_url"
	FROM "Imagen";

END;
$$ LANGUAGE plpgsql;

--Seleccionar presentacion
CREATE OR REPLACE FUNCTION "seleccionar_presentacion"()
RETURNS TABLE
(
	codigo INT,
	capacidad NUMERIC
)
AS $$
BEGIN

	RETURN QUERY
	SELECT "bot_id", "bot_capacidad"
	FROM "Botella";

END;
$$ LANGUAGE plpgsql;

--Insertar Sabores
CREATE OR REPLACE FUNCTION public.insertar_sabores(
	id_producto integer,
	sabores integer[])
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare id_sabor int;
begin
FOREACH id_sabor IN ARRAY sabores
  	LOOP
		RAISE NOTICE 'id del sabor ==> %', id_sabor;
		INSERT INTO public."Producto_Sabor"(
		 fk_producto, fk_sabor)
		VALUES (id_producto, id_sabor);
  	END LOOP;
end;
$BODY$;

--Insertar Colores
-- FUNCTION: public.insertar_colores(integer, integer[])

-- DROP FUNCTION IF EXISTS public.insertar_colores(integer, integer[]);

CREATE OR REPLACE FUNCTION public.insertar_colores(
	id_producto integer,
	colores integer[])
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare id_color int;
begin
FOREACH id_color IN ARRAY colores
  	LOOP
		RAISE NOTICE 'id del sabor ==> %', id_color;
		INSERT INTO public."Producto_Color"(
		 fk_producto, fk_color)
		VALUES (id_producto, id_color);
  	END LOOP;
end;
$BODY$;

--Insertar Materia
CREATE OR REPLACE FUNCTION public.insertar_materia(
	id_producto integer,
	materias_primas integer[])
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare id_materia int;
begin
FOREACH id_materia IN ARRAY materias_primas
  	LOOP
		RAISE NOTICE 'id de la materia prima ==> %', id_materia;
		INSERT INTO public."Producto_Materia"(
		 fk_producto, fk_materia)
		VALUES (id_producto, id_materia);
  	END LOOP;
end;
$BODY$;

--Insertar Imagen
CREATE OR REPLACE FUNCTION public.insertar_imagen(
	id_producto integer,
	id_imagen integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	UPDATE public."Imagen"
	SET fk_producto=id_producto
	WHERE ima_id=id_imagen;
end;
$BODY$;

CREATE OR REPLACE FUNCTION public.insertar_presentacion(
    id_producto integer,
    presentaciones integer[]
)
RETURNS void
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    id_presentacion int;
BEGIN
    FOREACH id_presentacion IN ARRAY presentaciones
    LOOP
        RAISE NOTICE 'id de la presentacion ==> %', id_presentacion;
        
        -- Actualizar la tabla "Presentacion" con el nuevo fk_producto
        UPDATE public."Presentacion"
        SET "fk_producto" = id_producto
        WHERE "pre_id" = id_presentacion;
    END LOOP;
END;
$BODY$;

---------------------------------------------------------------------------------------------------------------------
create or replace function obtener_historico_tasa()
returns table (valor numeric,fecha_i timestamp,fecha_f timestamp)
as $$
begin
return query SELECT tas_valor, tas_fecha_inicial, tas_fecha_final
			  FROM public."Tasa"
			   order by  tas_fecha_inicial desc;
end
$$ language plpgsql;
-- historico de punto
create or replace function obtener_historico_punto()
returns table (valor numeric,fecha_i timestamp,fecha_f timestamp)
as $$
begin
return query SELECT pun_valor, pun_fecha_inicial, pun_fecha_final
			  FROM public."Punto"
			  order by  pun_fecha_inicial desc;
end
$$ language plpgsql;
--Afiliados
--codigo identificador
CREATE SEQUENCE IF NOT EXISTS public.carnet_secuencia
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.carnet_secuencia
    OWNER TO postgres;
	
CREATE OR REPLACE FUNCTION generar_secuencia() RETURNS bigint AS $$
DECLARE
   secuencia bigint;
   codigo varchar;
   i int;
BEGIN
   codigo:='';
    FOR i IN 0..8 STEP BY 1
	LOOP
	    secuencia := nextval('carnet_secuencia');
		codigo:= codigo || cast(secuencia as varchar) ;
		
		RAISE NOTICE 'Valor de la variable i es %', cast(secuencia as varchar);
		RAISE NOTICE 'Valor de la codigo es %', codigo;
	END LOOP;
	
   
   RETURN SUBSTRING ( codigo ,1 , 8 );
END;
$$ LANGUAGE plpgsql;
--obtener usuario
CREATE OR REPLACE FUNCTION public.obtener_codigo_rif_cliente(
	correo character varying,
	"contraseña" character varying)
    RETURNS TABLE(cod1 integer, cod2 character varying, tipo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare codCN int;
declare codEmp int;
declare codCJ varchar;
declare codCN_1 varchar;
declare codEmp_1 varchar;
declare codCJ_1 varchar;
declare aux1 int;
declare aux2 int;
declare aux3 int;
declare mensaje varchar;
begin
	--buscar por correo
	select  fk_cliente_natural
	into codCN
	from "Correo" where cor_direccion=correo;
	 RAISE NOTICE 'cliente natura 1: ==> %',codCN;
	select  fk_cliente_natural_1
	into codCN_1
	from "Correo" where cor_direccion=correo;
	 RAISE NOTICE 'cliente natura 2: ==> %',codCN_1;
	select fk_empleado 
	into codEmp
	from "Correo" where cor_direccion=correo;
	
	select fk_empleado_1 
	into codEmp_1
	from "Correo" where cor_direccion=correo;
    
	select fk_cliente_juridico 
	into codCJ
	from "Correo" where cor_direccion=correo;
	
	--buscar por contraseña
	select usu_id
	into aux1
	from "Usuario" where "usu_contraseña"="contraseña" and fk_empleado_1=codEmp and
	fk_empleado_2=codEmp_1;
	
	select usu_id
	into aux2
	from "Usuario" where "usu_contraseña"="contraseña" and fk_Cliente_Natural_1=codCN and
     fk_Cliente_Natural_2=codCN_1 ;
	 RAISE NOTICE 'cliente natura 1: ==> %',aux2;
	 
	select usu_id
	into aux3
	from "Usuario" where "usu_contraseña"="contraseña" and fk_Cliente_Juridico=codCJ ;
 
	if (aux2 is not null) then
		 RAISE NOTICE 'cliente dentro de la funcion: ==> %',codCN;
		return query select fk_cliente_natural,fk_cliente_natural_1,'Cliente_Natural'
					 from "Correo" where cor_direccion=correo;
	end if;
	
		if (aux3 is not null) then
			RAISE NOTICE 'cliente j: ==> %',codCJ;
			return query select 0,fk_cliente_juridico,'Cliente_Juridico'
					 from "Correo" where cor_direccion=correo;
		end if;
			if  (aux1 is not null )then
			         RAISE NOTICE 'empleado: ==> %',codEmp;
			    	return query select fk_empleado,fk_empleado_1,'Empleado'
					 from "Correo" where cor_direccion=correo;
			end if;
end;
$BODY$;
--datos del carnet

CREATE OR REPLACE FUNCTION public.datos_carnet(
	codigo_tipo character varying)
    RETURNS TABLE(cedula text, rif text, nombre text, apellido text, razon_social text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare parte1 text;
declare parte2 text;
declare parte3 varchar;
declare parte4 varchar;
begin
codigo_tipo:= '_'  || codigo_tipo;
parte1 := split_part(codigo_tipo, '_', 2);
parte2 := split_part(codigo_tipo, '_', 3);
parte3 := split_part(codigo_tipo, '_', 4);
parte4 := split_part(codigo_tipo, '_', 5);
  
RAISE NOTICE 'El id del  es: ==> %',parte1;
RAISE NOTICE 'El id del  es: ==> %', parte2;
RAISE NOTICE 'El id del  es: ==> %', parte3;
RAISE NOTICE 'El id del  es: ==> %', parte4;
if parte4='Natural' then
RAISE NOTICE 'El id del  es: ==> %', parte1;
return query  select cast(per_nat_ci as text),'',(per_nat_p_nombre ||' '|| per_nat_p_nombre) as nombres,
(per_nat_p_apellido  ||' '||per_nat_s_apellido) as apellidos,''
 from "Cliente_Natural" where per_nat_ci=parte2;
else
return query select '',Cast(per_jur_rif as text),'','',cast(per_jur_razon_social as text) from "Cliente_Juridico" where parte2=per_jur_rif;

end if;
end;
$BODY$;

ALTER FUNCTION public.datos_carnet(character varying)
    OWNER TO postgres;

--afiliacion
--afiliarse
CREATE OR REPLACE FUNCTION public.afiliarse(
	cedula character varying,
	rif character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare codigo varchar;
declare aux int;
begin 
codigo:=public.generar_secuencia();
	if  cedula= '' then
	INSERT INTO public."Afiliado"(
	afi_fecha_afiliacion, "afi_QR", 
	afi_codigo_iden, fk_fisica, fk_virtual, fk_cliente_natural, fk_cliente_natural_2, 
	fk_estatus, fk_cliente_juridico, fk_proveedor)
	VALUES (current_timestamp at time zone 'VET', rif,codigo, 1, 1, null, null,11 , rif, null);
	
	else
		select per_nat_id 
		into aux
		from "Cliente_Natural" where per_nat_ci=cedula;
		INSERT INTO public."Afiliado"(
	    afi_fecha_afiliacion, "afi_QR", 
	    afi_codigo_iden, fk_fisica, fk_virtual, fk_cliente_natural, fk_cliente_natural_2, 
		fk_estatus, fk_cliente_juridico, fk_proveedor)
		VALUES (current_timestamp at time zone 'VET', cedula,codigo, 1,1,aux, cedula,11 , null, null);
		
	end if;
end;
$BODY$;

ALTER FUNCTION public.afiliarse(character varying, character varying)
    OWNER TO postgres;
--busca el codigo qr y el de identificacion del ailiado y llama a la funcion afiliacion	

CREATE OR REPLACE FUNCTION public.datos_afiliado(
	cedula character varying,
	rif character varying)
    RETURNS TABLE(codigo character varying, qr character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare encontrado_1 int;
declare encontrado_2 int;
DECLARE AUX VARCHAR;
begin
    SELECT afi_id
	into encontrado_1
	FROM public."Afiliado"
	where fk_cliente_natural_2=cedula;
	SELECT afi_id
	into encontrado_2
	FROM public."Afiliado"
	where fk_cliente_juridico=rif;
 	if cedula <> '' and encontrado_1>0   then 
  		return  query SELECT afi_codigo_iden, "afi_QR" from "Afiliado" where afi_id=encontrado_1;
 	else 
   		if cedula <> '' and  then 
     	SELECT INTO AUX public.afiliarse(cedula, rif);
	 	return  query SELECT afi_codigo_iden, "afi_QR" from "Afiliado" where fk_cliente_natural_2=cedula;
		end if;
	end if;	
	if rif <> '' and encontrado_2>0  then 
  		return  query SELECT afi_codigo_iden, "afi_QR" from "Afiliado" where afi_id=encontrado_2;
 	else 
   		if rif <> '' then 
     	SELECT INTO AUX public.afiliarse(cedula, rif);
	 	return  query SELECT afi_codigo_iden, "afi_QR" from "Afiliado" where fk_cliente_juridico=rif;
		end if;
	end if;	
	
end;
$BODY$;

ALTER FUNCTION public.datos_afiliado(character varying, character varying)
    OWNER TO postgres;
--pagar afiliacion
--busca si ya pago el mes
CREATE OR REPLACE FUNCTION public.buscar_pago(
	codigo_afiliado character varying)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare codigo int;
declare fecha timestamp;
begin
fecha:=current_timestamp at time zone 'VET';
RAISE NOTICE 'Valor de la variable aux1 es %', fecha;
SELECT pa_af_cuo_id
	FROM public."Pago_Afiliacion_Cuota","Afiliado"
	INTO CODIGO
	where fk_afiliado=afi_id and afi_codigo_iden=codigo_afiliado and 
	extract( year from pa_af_cuo_fecha)=extract(year from  fecha) and 
	extract( month from pa_af_cuo_fecha)=extract(month from  fecha);
RETURN CODIGO;
end;

$BODY$;

ALTER FUNCTION public.buscar_pago(character varying)
    OWNER TO postgres;
-- comprobar si los montos parciales dan el total
CREATE OR REPLACE FUNCTION public.comprobar_montos_total(
	montos character varying[],
	codigos character varying[],
	total character varying)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare i varchar;
declare suma numeric;
begin
suma:=0;
FOREACH i IN ARRAY montos
  	LOOP
		suma:=suma+ cast(i as numeric);
		RAISE NOTICE 'Palaba encontrada ==> %', suma;
  	END LOOP;
	RAISE NOTICE 'total ==> %', suma;
	return cast (suma as varchar)= total;
end;

$BODY$;

ALTER FUNCTION public.comprobar_montos_total(character varying[], character varying[], character varying)
    OWNER TO postgres;
	-- inserta el pago
	CREATE OR REPLACE FUNCTION public.verificar_pago_afiliacion(
	codigo_afiliado character varying,
	montos character varying[],
	codigos_tarjeta character varying[],
	total character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare codigo int;
declare total_pago boolean;
declare id_afiliado int;
declare mensaje varchar;
begin

select afi_id into id_afiliado from "Afiliado" where afi_codigo_iden=codigo_afiliado;
codigo:=public.buscar_pago(codigo_afiliado);
total_pago:=public.comprobar_montos_total(montos, codigos_tarjeta, total);
	if codigo is null and total_pago=true then
		INSERT INTO public."Pago_Afiliacion_Cuota"(
		pa_af_cuo_total, pa_af_cuo_fecha, pa_af_cuo_mes_can, fk_afiliado)
		VALUES ( cast (total as numeric), current_timestamp at time zone 'VET',
				to_char(now() AT TIME ZONE 'VET', 'TMMonth'), id_afiliado);
		mensaje:='Cuota pagada exitosamente';
	else 
		if codigo>0 then
			mensaje:='Usted ya cancelo este mes';
		else
			mensaje:='El monto a cancelar no coincide con la cuota de afiliacion';
		end if;

  end if;

RETURN mensaje;
end;

$BODY$;

ALTER FUNCTION public.verificar_pago_afiliacion(character varying, character varying[], character varying[], character varying)
    OWNER TO postgres;
-- convierta la cadena en arrays
CREATE OR REPLACE FUNCTION public.pagar(
	codigo_identificador_afiliado character varying,
	montos character varying,
	id_tarjetas character varying,
	total character varying,
	cant_tarjetas character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

declare aux1 varchar;
declare montos_array varchar[];
declare tarjetas_array varchar[];
declare aux2 varchar;
declare mensaje varchar;
declare aux boolean;

declare i int;
begin
aux:=(montos !~ '[^0-9 $]');
i:=LENGTH(cant_tarjetas);
if aux=true then
 FOR i IN 1..i
	LOOP
		aux1:=split_part(montos, '$', i);
		RAISE NOTICE 'Valor de la variable aux1 es %', aux1;
		select into montos_array  array_append(montos_array, aux1 );
		
		aux2:=split_part(id_tarjetas, '$', i);
		select into tarjetas_array array_append(tarjetas_array,aux2);
	END LOOP;
 

RAISE NOTICE 'Valor del array montos  es %',montos_array ;
RAISE NOTICE 'Valor del array tarjetas  es %',tarjetas_array ;
   mensaje:=public.verificar_pago_afiliacion(codigo_identificador_afiliado,montos_array,tarjetas_array, total) ;  
  else
  	mensaje:='Los montos ingresados no son numeros validos';
	end if;
 
  return mensaje;
end;
$BODY$;

ALTER FUNCTION public.pagar(character varying, character varying, character varying, character varying, character varying)
    OWNER TO postgres;
--factura afiliacion

CREATE OR REPLACE FUNCTION public.datos_factura(
	codigo_identificador_afiliado character varying)
    RETURNS TABLE(num_factura character varying, total character varying, mes character varying, fecha character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare fecha timestamp;
begin
fecha:=current_timestamp at time zone 'VET';
return query
SELECT cast(pa_af_cuo_id as varchar), cast(pa_af_cuo_total as varchar),pa_af_cuo_mes_can,cast(subString(cast (pa_af_cuo_fecha as varchar),1,10) as varchar) 
	FROM public."Pago_Afiliacion_Cuota","Afiliado"
	where (fk_afiliado=afi_id and afi_codigo_iden=codigo_identificador_afiliado and 
	extract( year from pa_af_cuo_fecha)=extract(year from  fecha) and 
	extract( month from pa_af_cuo_fecha)=extract(month from  fecha));
end;
$BODY$;

ALTER FUNCTION public.datos_factura(character varying)
    OWNER TO postgres;
--datos afiliado
CREATE OR REPLACE FUNCTION public.obtener_datos_afiliado_factura(
	cod_iden_afiliacion character varying)
    RETURNS TABLE(nombre text, cedula character varying, direccion text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
 declare  cod1 int;
 declare  cod2 varchar;
 declare  cod3 varchar;
 begin
 select fk_cliente_natural
 into cod1 
 from "Afiliado"
 where afi_codigo_iden=cod_iden_afiliacion;
 
 select fk_cliente_natural_2
 into cod2 
 from "Afiliado"
 where afi_codigo_iden=cod_iden_afiliacion;
 
 select fk_cliente_juridico
 into cod3
 from "Afiliado"
 where afi_codigo_iden=cod_iden_afiliacion;
 RAISE NOTICE 'Valor de la variable aux1 es %', cod3;
 if (cod1>0 and cod2 is not null) then
 return query select (c.per_nat_p_nombre ||' '||c.per_nat_s_nombre ||' '||
					  c.per_nat_p_apellido ||' '|| c.per_nat_s_apellido  ) as nombres,c.per_nat_ci,
					  c.per_nat_direccion ||' ' || e.lug_nombre ||' ' ||m.lug_nombre||' ' ||p.lug_nombre as Ubicacion
 	from "Cliente_Natural" as c ,"Lugar" as p,"Lugar" as m,"Lugar" as e
	where c.per_nat_id=cod1  and c.per_nat_ci=cod2 and c.fk_lugar=p.lug_id and p.fk_lugar=m.lug_id and m.fk_lugar=e.lug_id;
 else
 	if cod3 is not null then
		return query select cast(c.per_jur_razon_social as text), c.per_jur_rif, c.per_jur_direccion_fisica ||' ' || e.lug_nombre ||' ' ||m.lug_nombre||' ' ||p.lug_nombre as Ubicacion
		from "Cliente_Juridico" as c ,"Lugar" as p,"Lugar" as m,"Lugar" as e, "Lugar_Persona" as l
		where c.per_jur_rif=cod3 and  l.fk_cliente_juridico=cod3 and l.fk_lugar=p.lug_id and p.fk_lugar=m.lug_id and m.fk_lugar=e.lug_id;
 	end if;
end if;
 end;
 
$BODY$;

ALTER FUNCTION public.obtener_datos_afiliado_factura(character varying)
    OWNER TO postgres;
--datos asoron
CREATE OR REPLACE FUNCTION public.obtener_datos_asoron_factura(
	)
    RETURNS TABLE(rif character varying, direccion text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

 begin
 
 
 return query select f.aso_rif,
					  f.aso_direccion ||' ' || e.lug_nombre ||' ' ||m.lug_nombre||' ' ||p.lug_nombre as Ubicacion
 	from "Fisica" f,"Lugar" as p,"Lugar" as m,"Lugar" as e
	where aso_id=1 and f.fk_lugar=p.lug_id and p.fk_lugar=m.lug_id and m.fk_lugar=e.lug_id;

 end;
 
$BODY$;

ALTER FUNCTION public.obtener_datos_asoron_factura()
    OWNER TO postgres;

--roles
CREATE OR REPLACE FUNCTION public.insertar_rol(
	nombre character varying,
	descripcion text)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE mensaje varchar;
declare aux boolean;
BEGIN
aux:=REPLACE(nombre, ' ', '') !~ '[^a-zA-z]';
	if (REPLACE(nombre, ' ', '')='' or REPLACE(descripcion, ' ', '')='') then
		mensaje:='Hay campos vacios';
	else
		if not aux then
			mensaje:='El nombre no acepta ni numeros ni caracteres especiales';
		else
			mensaje:='Registro exitoso';
			INSERT INTO public."Rol"(
			rol_nombre, rol_descripcion)
			VALUES (nombre, descripcion);
		end if;
	end if;
return mensaje;
END;
$BODY$;
---rol
--insertar permisos
CREATE OR REPLACE FUNCTION public.insertar_permiso_rol(
	codigo_permiso character varying,
	codigo_rol character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare rol_permiso int;
begin
select rol_per_id  
into rol_permiso
from "Rol_Permiso" where fk_rol= cast(codigo_rol as int)
and fk_permiso= cast(codigo_permiso as int);

if rol_permiso is  null then
INSERT INTO public."Rol_Permiso"(
	fk_rol, fk_permiso)
	VALUES ( cast(codigo_rol as int), cast(codigo_permiso as int));
end if;
return 'Permisos Asignados';
end;
$BODY$;

ALTER FUNCTION public.insertar_permiso_rol(character varying, character varying)
    OWNER TO postgres;
--insertar rol
CREATE OR REPLACE FUNCTION public.insertar_rol(
	nombre character varying,
	descripcion text)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE mensaje varchar;
declare aux boolean;
BEGIN
aux:=REPLACE(nombre, ' ', '') !~ '[^a-zA-z]';
	if (REPLACE(nombre, ' ', '')='' or REPLACE(descripcion, ' ', '')='') then
		mensaje:='Hay campos vacios';
	else
		if not aux then
			mensaje:='El nombre no acepta ni numeros ni caracteres especiales';
		else
			mensaje:='Registro exitoso';
			INSERT INTO public."Rol"(
			rol_nombre, rol_descripcion)
			VALUES (nombre, descripcion);
		end if;
	end if;
return mensaje;
END;
$BODY$;

ALTER FUNCTION public.insertar_rol(character varying, text)
    OWNER TO postgres;
--modificar rol
CREATE OR REPLACE FUNCTION public.modificar_rol(
	codigo character varying,
	nombre character varying,
	descripcion text)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE mensaje varchar;
declare aux boolean;
BEGIN
aux:=REPLACE(nombre, ' ', '') !~ '[^a-zA-z]';
	if (REPLACE(nombre, ' ', '')='' or REPLACE(descripcion, ' ', '')='') then
		mensaje:='Hay campos vacios';
	else
		if not aux then
			mensaje:='El nombre no acepta ni numeros ni caracteres especiales';
		else
			mensaje:='Modificacion exitosa';
			UPDATE public."Rol"
			SET rol_nombre=nombre, rol_descripcion=cast (descripcion as varchar)
			WHERE rol_id=cast(codigo as int);
		end if;
	end if;
return mensaje;
END;
$BODY$;

ALTER FUNCTION public.modificar_rol(character varying, character varying, text)
    OWNER TO postgres;
--seleccionar un rol para verlo en el modificar
CREATE OR REPLACE FUNCTION public.seleccionar_un_rol(
	codigo_rol character varying)
    RETURNS TABLE(nombre character varying, descripcion text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
 return query SELECT  rol_nombre, cast (rol_descripcion as text)
	FROM public."Rol"
	where rol_id = cast (codigo_rol as int);
end;
$BODY$;

ALTER FUNCTION public.seleccionar_un_rol(character varying)
    OWNER TO postgres;
--eliminar Rol

CREATE OR REPLACE FUNCTION public.eliminar_rol(
	codigo character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
    DELETE FROM public."Rol"
	WHERE rol_id=cast(codigo as int);
END;
$BODY$;

ALTER FUNCTION public.eliminar_rol(character varying)
    OWNER TO postgres;
--buscar todos los permisos

CREATE OR REPLACE FUNCTION public.obtener_permisos(
	)
    RETURNS TABLE(codigo character varying, nombre text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query SELECT cast(per_id as varchar), per_accion||'-'|| per_tabla as nombre_permiso
	FROM public."Permiso";
end;
$BODY$;

ALTER FUNCTION public.obtener_permisos()
    OWNER TO postgres;
-- inserta permiso rol
CREATE OR REPLACE FUNCTION public.insertar_permiso_rol(
	codigo_permiso character varying,
	codigo_rol character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare rol_permiso int;
begin
select rol_per_id  
into rol_permiso
from "Rol_Permiso" where fk_rol= cast(codigo_rol as int)
and fk_permiso= cast(codigo_permiso as int);

if rol_permiso is  null then
INSERT INTO public."Rol_Permiso"(
	fk_rol, fk_permiso)
	VALUES ( cast(codigo_rol as int), cast(codigo_permiso as int));
end if;
return 'Permisos Asignados';
end;
$BODY$;

ALTER FUNCTION public.insertar_permiso_rol(character varying, character varying)
    OWNER TO postgres;
--codigos de permisos por rol
CREATE OR REPLACE FUNCTION public.seleccionar_codigos_permisos_rol(
	id_rol character varying)
    RETURNS TABLE(codigo_permiso character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
RETURN query select cast(per_id as varchar) 
	from public."Permiso", public."Rol_Permiso"
	where fk_rol=cast(id_rol as int )and fk_permiso=per_id;

end;
$BODY$;

ALTER FUNCTION public.seleccionar_codigos_permisos_rol(character varying)
    OWNER TO postgres;
--eliminar permisos  por rol
CREATE OR REPLACE FUNCTION public.eliminar_permisos_rol(
	cod_rol character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	
 begin
 DELETE FROM public."Rol_Permiso"
	WHERE fk_rol=cast(cod_rol as int);
	
END;
$BODY$;

ALTER FUNCTION public.eliminar_permisos_rol(character varying)
    OWNER TO postgres;
--hasta ahora gaby
create or replace function tarjetas_afiliado(cod_iden_afiliado varchar) 
returns table(codigo_tarjeta varchar, numero_tarjeta varchar, banco varchar,fecha_vencimiento text)
as $$
declare cod1 int; 
declare cod2 varchar;
declare cod3 varchar;
begin
select fk_cliente_natural 
from public."Afiliado" into cod1 
where afi_codigo_iden=cod_iden_afiliado;
raise notice '%', cod1;
select fk_cliente_natural_2 from "Afiliado" into cod2 where afi_codigo_iden=cod_iden_afiliado;
raise notice '%1', cod2;
select fk_cliente_juridico from "Afiliado" into cod3 where afi_codigo_iden=cod_iden_afiliado;
raise notice '%', cod3;

	if (cod1 is not null and cod2 is not null) then
		return query select cast(met_pag_id as varchar),tar_numero,tar_nombre,
		(substring((cast(tar_fecha_vencimiento as varchar)) from 1 for 2)  || ' ' || substring((cast(tar_fecha_vencimiento as varchar)) from 6 for 4)) as
		fecha
		from "Tarjeta" where fk_cliente_natural_1 =cod1 and fk_cliente_natural_2=cod2;
			if cod3 is not null then
				return query select cast(met_pag_id as varchar),tar_numero,tar_nombre,
				(substring((cast(tar_fecha_vencimiento as varchar)) from 1 for 2)  || ' ' || substring((cast(tar_fecha_vencimiento as varchar)) from 6 for 4)) as
				fecha
				from "Tarjeta" where fk_cliente_juridico=cod3;
			end if;

	end if;
	
end;
$$  language plpgsql;
--auditoria
CREATE OR REPLACE FUNCTION public.insertar_auditoria(
	codigo_tipo_usuario character varying,
	accion character varying,
	tabla character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

declare cod1 varchar;
declare cod2 varchar;
declare tipo  varchar;
declare tipo2  varchar;
declare codUsuario int;

begin
codigo_tipo_usuario:= '_'|| codigo_tipo_usuario ;
raise notice 'Inicia... % ', codigo_tipo_usuario;
cod1 :=split_part(codigo_tipo_usuario, '_', 2);
raise notice 'Inicia... % ',cod1;
cod2 := split_part(codigo_tipo_usuario, '_', 3);
raise notice 'Inicia... % ',cod2;
tipo := split_part(codigo_tipo_usuario, '_', 4);
raise notice 'Inicia... % ',tipo;
tipo2 := split_part(codigo_tipo_usuario, '_', 5);
raise notice 'Inicia... % ',tipo2;
if cast(cod1 as int)>0  and  tipo='Cliente'then 
	select usu_id into codUsuario from "Usuario"
	where fk_cliente_natural_1=cast(cod1 as int) and fk_cliente_natural_2=cod2;			
end if;
if cast(cod1 as int)>0  and  tipo='Empleado'then 
	select usu_id into codUsuario from "Usuario"
	where fk_empleado_1=cast(cod1 as int) and fk_empleado_2=cod2;			
end if;
if cast(cod1 as int)=0 and  tipo ='Cliente' then
	select usu_id into codUsuario from "Usuario"
	where fk_cliente_juridico=cod2;		
end if;
raise notice 'Codi... % ',codUsuario;
if codUsuario is not null then
INSERT INTO public."Control_Accion"(
	con_acc_accion, con_acc_tabla, con_acc_fecha_hora, fk_usuario)
	VALUES (accion,tabla, current_timestamp at time zone 'VET',codUsuario);
end if;

 return ;
end;
$BODY$;
--nota de cata 
CREATE OR REPLACE FUNCTION public.insertar_nota_cata(
	nota character varying,
	codigo_evento integer,
	codigo_presentacion character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

declare codigo_evento_presentacion int;
declare mensaje varchar;
begin

	--buscar si la presentacion participo en el evento
	select pre_eve_id
	into  codigo_evento_presentacion
	from public."Presentacion_Evento"
	where fk_evento=codigo_evento and fk_presentacion=cast(codigo_presentacion as int);
	RAISE NOTICE 'El id del  es: ==> %',codigo_evento_presentacion;
	if   codigo_evento_presentacion>0 then
	mensaje:= 'Nota de cata registrada';
	INSERT INTO public."Nota_Cata" ("not_cat_descripcion", "fk_presentacion_evento_1","fk_presentacion_evento_2","fk_presentacion_evento_3")
	VALUES
  ( nota,codigo_evento_presentacion,cast( codigo_presentacion as int), codigo_evento);
	
	else
	mensaje:='No se puede asignar una nota de cata a un producto que no participo en el evento';
	end if;
	return mensaje;
end;
$BODY$;
---premio

CREATE OR REPLACE FUNCTION public.insertar_premio_evento(
	codigo_presentacion character varying,
	codigo_evento integer,
	cod_premio character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare codigo_evento_presentacion int;
declare mensaje varchar;
begin

	--buscar si la presentacion participo en el evento
	select pre_eve_id
	into  codigo_evento_presentacion
	from public."Presentacion_Evento"
	where fk_evento=codigo_evento and fk_presentacion=cast(codigo_presentacion as int);
	RAISE NOTICE 'El id del  es: ==> %',codigo_evento_presentacion;
	if   codigo_evento_presentacion>0 then
	INSERT INTO public."Presentacion_Evento"(
	pre_eve_cantidad, pre_eve_precio_venta, fk_presentacion, fk_evento, fk_premio)
	VALUES (null, null, cast (codigo_presentacion as int),codigo_evento ,cast( cod_premio as int));
	mensaje:= 'Premio asignado';
	else
	mensaje:='No se puede asignar un premio a un producto que no participo en el evento';
	end if;
	return mensaje;
end;
$BODY$;
-- obtner auditoria
CREATE OR REPLACE FUNCTION public.obtener_auditoria(
	)
    RETURNS TABLE(codigo_usuario character varying, accion character varying, tabla character varying, fecha_hora character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
 begin
return query  SELECT cast(fk_usuario as varchar), con_acc_accion, con_acc_tabla, cast(con_acc_fecha_hora as varchar)
	FROM public."Control_Accion";
 end;
 
$BODY$;
-- nombre y rol del usuario
CREATE OR REPLACE FUNCTION public.nombre_rol(
	cod_usuario character varying)
    RETURNS TABLE(rol character varying, nombre text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare cod1 int;
declare cod2 varchar;
declare cod3 varchar;
begin
select fk_empleado_1 into cod1 from "Usuario" where usu_id=cast (cod_usuario as int);
 raise notice 'Inicia... % ', cod1;
select fk_cliente_natural_1 into cod2 from "Usuario" where usu_id= cast (cod_usuario as int);
 raise notice 'Inicia... % ', cod2;
select fk_cliente_juridico into cod3 from "Usuario" where usu_id= cast (cod_usuario as int);
 raise notice 'Inicia... % ', cod3;
if cod1 is not null then
return query SELECT rol_nombre ,
 e.per_nat_p_nombre ||' '|| e.per_nat_p_apellido  as nombre
	FROM public."Usuario","Rol","Empleado" as e
	where usu_id=cast(cod_usuario as int) and fk_rol=rol_id and fk_empleado_1=e.per_nat_id and fk_empleado_2=e.per_nat_ci;
end if;
if cod2 is not  null then
return query SELECT rol_nombre ,
 e.per_nat_p_nombre ||' '|| e.per_nat_p_apellido  as nombre
	FROM public."Usuario","Rol","Cliente_Natural" as e
	where usu_id=cast(cod_usuario as int) and fk_rol=rol_id and fk_cliente_natural_1=e.per_nat_id and fk_Cliente_Natural_2=e.per_nat_ci;
end if;
if cod3 is not  null then
return query SELECT rol_nombre ,
 cast(e.per_jur_razon_social as text)
	FROM public."Usuario","Rol","Cliente_Juridico" as e
	where usu_id=cast(cod_usuario as int) and fk_rol=rol_id and fk_cliente_juridico=e.per_jur_rif;
end if;

end;
$BODY$;
-- obtener premios
CREATE OR REPLACE FUNCTION public.obtener_premios(
	)
    RETURNS TABLE(codigo character varying, nombre character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query select cast(pre_id as varchar),pre_nombre from "Premio";
end;
$BODY$;
--presentacion por producto

CREATE OR REPLACE FUNCTION public.obtener_presentaciones_producto(
	cod_producto character varying)
    RETURNS TABLE(codigo character varying, nombre character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query select cast(pre_id as varchar),pre_nombre from "Presentacion"
where fk_producto=cast(cod_producto as int);
end;
$BODY$;

----------------------------------------------------------------------------------------------------------------------
-- CREE ESTE ARCHIVO PQ SE ME BORRARON VARIAS FUNCIONESS

CREATE OR REPLACE FUNCTION obtener_proveedores()
RETURNS TABLE (
    proveedor_id VARCHAR,
    nombre VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        per_jur_rif,
        per_jur_denominacion_comercial
    FROM
        "Proveedor";
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
    cod_cliente_juridico VARCHAR(16)

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
        fk_empleado_2
    )
    VALUES (
        NOW(),
        total,
        1,
        cod_cliente_natural_1,
        cod_cliente_natural_2,
        cod_cliente_juridico,
        cod_empleado_1,
        cod_empleado_2
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
    cod_estatus INT
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
        cod_cliente_juridico
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
    INSERT INTO "Efectivo" (ef_moneda, met_pag_cantidad)
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
    WHERE cod_pre = fk_presentacion;
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

----------------------------------------------------------------------------------------------------------------------

--Insertar un empleado
CREATE OR REPLACE FUNCTION insertar_empleado(ced varchar,rif varchar,p_nombre varchar,
											 s_nombre varchar,p_apellido varchar,s_apellido varchar,
											direccion varchar,sueldo numeric(10,0),fecha_ing timestamp,parroquia int)
RETURNS varchar
AS $$
declare mensaje varchar;
declare ValCedRif boolean;
declare ValnombApell boolean;
BEGIN
ValCedRif:=(REPLACE(ced, ' ', '') !~ '[^0-9VE]' )and (REPLACE(rif, ' ', '') !~ '[^0-9N]');
ValnombApell:=(REPLACE(p_nombre, ' ', '') !~ '[^a-zA-z]') and (REPLACE(s_nombre, ' ', '') !~ '[^a-zA-z]')and 
(REPLACE(p_apellido, ' ', '') !~ '[^a-zA-z]')  and (REPLACE(s_apellido, ' ', '') !~ '[^a-zA-z]');
	if (REPLACE(ced, ' ', '')='' or REPLACE(p_nombre, ' ', '')=''or 
	    REPLACE(p_apellido, ' ', '')='' or REPLACE(direccion, ' ', '')='') then
	   		mensaje:='Hay datos obligatorios sin llenar en su registro';
	else
			if  not ValCedRif then
			mensaje:='El formato de cedula/rif es invalido solo se aceptan numeros';
			else
				if not ValnombApell then
					mensaje:='Los nombres y los apellidos no pueden tener ni numeros ni caracteres especiales';
				else
					mensaje:='Registro exitoso';
					INSERT INTO public."Empleado"(
					per_nat_ci, per_nat_rif, per_nat_p_nombre, per_nat_s_nombre, per_nat_p_apellido, per_nat_s_apellido, per_nat_direccion, emp_sueldo, emp_fecha_ingreso, fk_cliente_juridico, fk_proveedor, fk_lugar)
					VALUES ( ced, rif, p_nombre, s_nombre, p_apellido, s_apellido, direccion, sueldo,fecha_ing, null, null,parroquia);
				end if;
			end if; 
	end if;
    RETURN mensaje;
END;
$$ LANGUAGE plpgsql;

--Mostrar todos los empleados
CREATE OR REPLACE FUNCTION "mostrar_empleados" ()
RETURNS TABLE (
    "nombres_empleado" TEXT, 
    "apellidos_empleado" TEXT,  
    "cedula_empleado" VARCHAR,
	"rol_empleado" VARCHAR
)
AS $$
BEGIN
    RETURN QUERY
    SELECT CONCAT(e."per_nat_p_nombre", ' ', e."per_nat_s_nombre") AS "nombres_empleado",
           CONCAT(e."per_nat_p_apellido", ' ', e."per_nat_s_apellido") AS "apellidos_empleado", 
           e."per_nat_ci" AS "cedula_empleado",
		   r."rol_nombre"
    FROM "Usuario" as u
	JOIN "Rol" AS r ON u."fk_rol" = r."rol_id"
	JOIN "Empleado" AS e ON u."fk_empleado_1" = e."per_nat_id"
		 AND  u."fk_empleado_2" = e."per_nat_ci";
    
END;
$$ LANGUAGE plpgsql;

--Insertar un usuario que es empleado
CREATE OR REPLACE FUNCTION insertar_usuario_empleado(
    "contraseña" varchar, rol int,
	cod1_empleado int, cod2_empleado varchar
    )
RETURNS VOID
AS $$
BEGIN
	INSERT INTO public."Usuario"(
		"usu_contraseña", fk_rol, fk_cliente_juridico, fk_proveedor, fk_cliente_natural_1, fk_cliente_natural_2, fk_empleado_1, fk_empleado_2)
	VALUES ("contraseña", rol, NULL, NULL, NULL, NULL, cod1_empleado, cod2_empleado);	
END;
$$ language plpgsql;

--agregar empleado
--agregar empleado
CREATE OR REPLACE PROCEDURE "agregar_empleado"
(
	"ced" VARCHAR, "rif" VARCHAR, "p_nombre" VARCHAR,
	"s_nombre" VARCHAR, "p_apellido" VARCHAR, 
	"s_apellido" VARCHAR, "direccion" VARCHAR, 
	"sueldo" NUMERIC(10,0), 
	"parroquia" INT, "contraseña" VARCHAR,
	"rol" INT, "correo" VARCHAR
) 
AS $$
DECLARE 
	mens_1 VARCHAR;
	mens_2 VARCHAR;
    mens_3 VARCHAR;
	fecha_ing TIMESTAMP;
	cod1_empleado INT;
	cod2_empleado VARCHAR;
BEGIN
	fecha_ing = CURRENT_TIMESTAMP;
	mens_1 := insertar_empleado("ced", "rif", "p_nombre", "s_nombre",
								"p_apellido", "s_apellido", "direccion",
								"sueldo", "fecha_ing", "parroquia");
	RAISE NOTICE '%', mens_1;	
	-- Obtener el ID del empleado recién insertado
	SELECT "per_nat_id" INTO "cod1_empleado"
	FROM "Empleado"
	WHERE "per_nat_ci" = "ced";
	
	cod2_empleado := "ced";
	
	PERFORM insertar_usuario_empleado("contraseña", "rol",
									  cod1_empleado, cod2_empleado);
	mens_2 := insertar_correo("correo", cod1_empleado, cod2_empleado,
							  NULL, NULL, NULL);

    mens_3 := insertar_empleado_horario(cod1_empleado, cod2_empleado);
END;
$$ LANGUAGE plpgsql;

--Eliminar empleado
CREATE OR REPLACE FUNCTION public.eliminar_empleado(
	id_empleado_1 integer,
	id_empleado_2 character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
    DELETE FROM public."Empleado"
    WHERE per_nat_id=id_empleado_1 and per_nat_ci=id_empleado_2;
    return 'Empleado eliminado exitosamente';
end;
$BODY$;

--Insertar un correo
CREATE OR REPLACE FUNCTION public.insertar_correo(
	correo character varying,
	cod1_empleado integer,
	cod2_empleado character varying,
	cod1_cliente_natural integer,
	cod2_cliente_natural character varying,
	cod_cliente_juridico character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare mensaje varchar;
declare aux boolean;
begin
aux:=correo ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$';
	if not aux then 
	mensaje:='Formato de correo invalido';
	else
		if (cod1_empleado IS NULL and cod2_empleado IS NULL and cod_cliente_juridico IS NULL) then
			INSERT INTO public."Correo"(
			cor_direccion, fk_empleado, fk_empleado_1, fk_cliente_natural, fk_cliente_natural_1, fk_cliente_juridico, fk_proveedor)
			VALUES (correo, null, null, cod1_cliente_natural, cod2_cliente_natural,null, null);
			mensaje:='Registro exitoso' ;
		else
			if cod1_empleado IS NULL and cod2_empleado IS NULL and cod1_cliente_natural IS NULL and cod2_cliente_natural IS NULL then
				INSERT INTO public."Correo"(
				cor_direccion, fk_empleado, fk_empleado_1, fk_cliente_natural, fk_cliente_natural_1, fk_cliente_juridico, fk_proveedor)
				VALUES (correo, null, null,null ,null ,cod_cliente_juridico, null);
				mensaje:='Registro exitoso';
			else 
				if cod1_cliente_natural IS NULL and cod2_cliente_natural IS NULL and cod_cliente_juridico IS NULL then
				INSERT INTO public."Correo"(
				cor_direccion, fk_empleado, fk_empleado_1, fk_cliente_natural, fk_cliente_natural_1, fk_cliente_juridico, fk_proveedor)
				VALUES (correo,cod1_empleado  , cod2_empleado ,null ,null ,null, null);
				mensaje:='Registro exitoso';
				end if;
			end if;
		end if;
	end if;	
return mensaje;
end;
$BODY$;

--Insertar telefonos del empleado
CREATE OR REPLACE FUNCTION "insertar_telefono_empleado"( "numero" VARCHAR, "cod1_empleado" INT,
	                                            "cod2_empleado" VARCHAR)
RETURNS VARCHAR AS $$
    declare mensaje varchar;
    declare aux boolean;
BEGIN
    aux:=numero ~ '^[0-9]+$';
	    if not aux then 
	        mensaje:='Formato de numero invalido';
	    else
			INSERT INTO "Telefono"(
			    tel_numero, fk_cliente_natural_1, fk_cliente_natural_2, fk_cliente_juridico, fk_proveedor, fk_empleado_1, fk_empleado_2)
			    VALUES (numero,null,null,null,null, cod1_empleado, cod2_empleado);
			mensaje:='Registro exitoso';
	    end if;	
    return mensaje;
END;
$$ LANGUAGE plpgsql;




-- Crear función de filtrado de productos por proveedor
CREATE OR REPLACE FUNCTION obtener_productos_por_proveedor(proveedor_id VARCHAR)
RETURNS TABLE (
  codigo INT,
  nombre VARCHAR

)
AS $$
BEGIN
  RETURN QUERY
    SELECT pro_codigo, pro_nombre
    FROM "Producto"
    WHERE fk_proveedor = proveedor_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleccionar_un_evento(codigo int)
RETURNS table (nombre varchar,descripcion varchar,num_entradas numeric,
			   fecha_hora_inicial timestamp,fecha_hora_final timestamp, direccion varchar,
			  parroquia int)
AS
$$
BEGIN
   return query SELECT  eve_nombre, eve_descripcion, eve_cantidad_entradas, eve_fecha_hora_inicial, eve_fecha_hora_final, eve_direccion, fk_lugar
				FROM public."Evento"
				where eve_id=codigo;
END;
$$
LANGUAGE plpgsql;

-- FUNCTION: public.modificar_evento(integer, character varying, character varying, integer, timestamp without time zone, timestamp without time zone, character varying, integer)

-- DROP FUNCTION IF EXISTS public.modificar_evento(integer, character varying, character varying, integer, timestamp without time zone, timestamp without time zone, character varying, integer);

CREATE OR REPLACE FUNCTION public.modificar_evento(
	codigo integer,
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
			mensaje:='Modificacion Exitosa';
			UPDATE public."Evento"
			SET eve_nombre=nomb, eve_descripcion=descrip, eve_cantidad_entradas=entradas, 
			eve_fecha_hora_inicial=fh_i, eve_fecha_hora_final=fh_f, eve_direccion=direccion, fk_lugar=parroquia
			WHERE eve_id=codigo;
		end if;
	end if;
return mensaje;
end;
$BODY$;

ALTER FUNCTION public.modificar_evento(integer, character varying, character varying, integer, timestamp without time zone, timestamp without time zone, character varying, integer)
    OWNER TO postgres;


CREATE OR REPLACE FUNCTION eliminar_evento(codigo int)
RETURNS void AS
$$
BEGIN
    DELETE FROM public."Evento"
	WHERE eve_id=codigo;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleccionar_eventos()
RETURNS table (codigo int,nombre varchar,descripcion varchar,num_entradas numeric,
			   fecha_hora_inicial timestamp,fecha_hora_final timestamp, direccion varchar,
			  parroquia int)
AS
$$
BEGIN
   return query SELECT eve_id, eve_nombre, eve_descripcion, eve_cantidad_entradas, eve_fecha_hora_inicial, eve_fecha_hora_final, eve_direccion, fk_lugar
				FROM public."Evento";
END;
$$
LANGUAGE plpgsql;

-- FUNCTION: public.eliminar_un_cliente_natural(integer, character varying)

-- DROP FUNCTION IF EXISTS public.eliminar_un_cliente_natural(integer, character varying);

CREATE OR REPLACE FUNCTION public.eliminar_un_cliente_natural(
	cod1 integer,
	cod2 character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
DELETE FROM public."Cliente_Natural"
	WHERE per_nat_id=cod1 and per_nat_ci=cod2;
return 'Cliente eliminado';
end;
$BODY$;

ALTER FUNCTION public.eliminar_un_cliente_natural(integer, character varying)
    OWNER TO postgres;


CREATE OR REPLACE FUNCTION public.insertar_cliente_juridico(
	rif character varying,
	denominacion_comer character varying,
	razon_soc character varying,
	pagina_web character varying,
	direccion_fisica character varying,
	direccion_fiscal character varying,
	capital numeric)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare aux boolean;
declare aux2 boolean;
declare mensaje varchar;
begin
aux:=(REPLACE(rif, ' ', '') !~ '[^0-9JG]');
aux2:=(REPLACE(denominacion_comer, ' ', '') !~ '[^a-zA-z]') and (REPLACE(razon_soc, ' ', '') !~ '[^a-zA-z]') ;
	if (REPLACE(rif, ' ', '')='' or REPLACE(denominacion_comer, ' ', '')=''or 
	    REPLACE(razon_soc, ' ', '')='' or REPLACE(pagina_web, ' ', '')=''or REPLACE(direccion_fiscal, ' ', '')=''
   		or REPLACE(direccion_fisica, ' ', '')='') then
	   		mensaje:='Hay datos obligatorios sin llenar en su registro';
	else 
		if not aux then
			mensaje:='Formato de rif invalido';
		else
			if length(rif)<10 then
				mensaje:='El rif debe tener minimo 10 numeros';
			else
				if  not aux2 then
					mensaje:='La denominacion comercial y la razon social no acepta numeros ni caracteres especiales';
				else
					mensaje:='Registro exitoso';
					INSERT INTO public."Cliente_Juridico"(
					per_jur_rif, per_jur_denominacion_comercial, per_jur_razon_social, per_jur_pagina_web, per_jur_direccion_fiscal, per_jur_direccion_fisica, per_jur_capital, per_jur_punto)
					VALUES (rif, denominacion_comer , razon_soc , pagina_web, direccion_fiscal, direccion_fisica , capital, 0);
				end if;
			end if;
		end if;
	end if;
return mensaje;
end;
$BODY$;

ALTER FUNCTION public.insertar_cliente_juridico(character varying, character varying, character varying, character varying, character varying, character varying, numeric)
    OWNER TO postgres;

-- FUNCTION: public.seleccionar_todos_cliente_juridico()

-- DROP FUNCTION IF EXISTS public.seleccionar_todos_cliente_juridico();

CREATE OR REPLACE FUNCTION public.seleccionar_todos_cliente_juridico(
	)
    RETURNS TABLE(rif character varying, denominacion_comercial character varying, razon_social character varying, pagina_web character varying, direccion_fiscal character varying, direccion_fisica character varying, capital numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query  SELECT per_jur_rif, per_jur_denominacion_comercial, per_jur_razon_social, per_jur_pagina_web, per_jur_direccion_fiscal, per_jur_direccion_fisica, per_jur_capital
				FROM public."Cliente_Juridico";
end;
$BODY$;

ALTER FUNCTION public.seleccionar_todos_cliente_juridico()
    OWNER TO postgres;


-- FUNCTION: public.seleccionar_un_cliente_natural(integer, character varying)

-- DROP FUNCTION IF EXISTS public.seleccionar_un_cliente_natural(integer, character varying);

CREATE OR REPLACE FUNCTION public.seleccionar_un_cliente_natural(
	cod1 integer,
	cod2 character varying)
    RETURNS TABLE(rif character varying, p_nombre character varying, s_nombre character varying, p_apellido character varying, s_apellido character varying, direccion character varying, puntos_acumulados numeric, parroquia integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query  SELECT per_nat_rif, per_nat_p_nombre, per_nat_s_nombre, per_nat_p_apellido, per_nat_s_apellido, per_nat_direccion, per_nat_punto,fk_lugar
				FROM public."Cliente_Natural"
				where per_nat_id=cod1 and per_nat_ci=cod2;
end;
$BODY$;

ALTER FUNCTION public.seleccionar_un_cliente_natural(integer, character varying)
    OWNER TO postgres;

-- FUNCTION: public.seleccionar_un_cliente_juridico(character varying)

-- DROP FUNCTION IF EXISTS public.seleccionar_un_cliente_juridico(character varying);

CREATE OR REPLACE FUNCTION public.seleccionar_un_cliente_juridico(
	rif character varying)
    RETURNS TABLE(denominacion_comercial character varying, razon_social character varying, pagina_web character varying, direccion_fiscal character varying, direccion_fisica character varying, capital numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query  SELECT  per_jur_denominacion_comercial, per_jur_razon_social, per_jur_pagina_web, per_jur_direccion_fiscal, per_jur_direccion_fisica, per_jur_capital
				FROM public."Cliente_Juridico"
				where per_jur_rif=rif;
end;
$BODY$;

ALTER FUNCTION public.seleccionar_un_cliente_juridico(character varying)
    OWNER TO postgres;



CREATE OR REPLACE FUNCTION public.seleccionar_todos_clientes()
    RETURNS TABLE(doc character varying, 
				  nombre character varying, 
				  apellido character varying, 
				  puntos_acumulados character varying,
                  tipo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY 
        SELECT 
            per_jur_rif AS doc, 
            per_jur_denominacion_comercial AS nombre, 
            per_jur_razon_social AS apellido, 
            CAST(per_jur_punto AS VARCHAR(255)) AS puntos_acumulados,
            'juridico' AS tipo
        FROM public."Cliente_Juridico"
        UNION ALL
        SELECT 
            per_nat_ci AS doc, 
            per_nat_p_nombre AS denominacion_comercial, 
            per_nat_p_apellido AS razon_social, 
            CAST(per_nat_punto AS VARCHAR(255)) AS puntos_acumulados,
            'natural' AS tipo
        FROM public."Cliente_Natural";
END;
$BODY$;
ALTER FUNCTION public.seleccionar_todos_clientes()
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.seleccionar_un_cliente_natural_por_ci(
	cod2 character varying)
    RETURNS TABLE(rif character varying, p_nombre character varying, s_nombre character varying, p_apellido character varying, s_apellido character varying, direccion character varying, puntos_acumulados numeric, parroquia integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query  SELECT per_nat_rif, per_nat_p_nombre, per_nat_s_nombre, per_nat_p_apellido, per_nat_s_apellido, per_nat_direccion, per_nat_punto,fk_lugar
				FROM public."Cliente_Natural"
				where per_nat_ci=cod2;
end;
$BODY$;

ALTER FUNCTION public.seleccionar_un_cliente_natural_por_ci( character varying)
    OWNER TO postgres;




-- FUNCTION: public.registro_cliente_natural(character varying, character varying, character varying, character varying, character varying, character varying, character varying, integer)

-- DROP FUNCTION IF EXISTS public.registro_cliente_natural(character varying, character varying, character varying, character varying, character varying, character varying, character varying, integer);

CREATE OR REPLACE FUNCTION public.registro_cliente_natural(
	ced character varying,
	rif character varying,
	p_nombre character varying,
	s_nombre character varying,
	p_apellido character varying,
	s_apellido character varying,
	direccion character varying,
	parroquia integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare mensaje varchar;
declare ValCedRif boolean;
declare ValnombApell boolean;
begin
ValCedRif:=(REPLACE(ced, ' ', '') !~ '[^0-9VE]' )and (REPLACE(rif, ' ', '') !~ '[^0-9N]');
ValnombApell:=(REPLACE(p_nombre, ' ', '') !~ '[^a-zA-z]') and (REPLACE(s_nombre, ' ', '') !~ '[^a-zA-z]')and 
(REPLACE(p_apellido, ' ', '') !~ '[^a-zA-z]')  and (REPLACE(s_apellido, ' ', '') !~ '[^a-zA-z]');
	if (REPLACE(ced, ' ', '')='' or REPLACE(p_nombre, ' ', '')=''or 
	    REPLACE(p_apellido, ' ', '')='' or REPLACE(direccion, ' ', '')='') then
	   		mensaje:='Hay datos obligatorios sin llenar en su registro';
	else
			if  not ValCedRif then
			mensaje:='El formato de cedula/rif es invalido solo se aceptan numeros';
			else
				if not ValnombApell then
					mensaje:='Los nombres y los apellidos no pueden tener ni numeros ni caracteres especiales';
				else
					if length(ced)<7 or (length(REPLACE(rif, ' ', ''))>0 and length(REPLACE(rif, ' ', ''))<10) then
						mensaje:='La cedula debe tener minimo 7 numeros y el rif 10';
					else 
						mensaje:='Registro exitoso';
						INSERT INTO public."Cliente_Natural"(
						per_nat_ci, per_nat_rif, per_nat_p_nombre, per_nat_s_nombre, per_nat_p_apellido, per_nat_s_apellido, per_nat_direccion,per_nat_punto,fk_cliente_juridico, fk_proveedor, fk_lugar)
						VALUES ( ced, rif, p_nombre, s_nombre, p_apellido, s_apellido, direccion,0,null, null,parroquia);
					end if;
				end if;
			end if; 
	end if;
    
    RETURN mensaje;
END;
$BODY$;

ALTER FUNCTION public.registro_cliente_natural(character varying, character varying, character varying, character varying, character varying, character varying, character varying, integer)
    OWNER TO postgres;


CREATE OR REPLACE FUNCTION obtener_eventos_activos()
    RETURNS TABLE(
        
        evento_id  int,
        nombre_evento varchar,
        fecha_hora_inicial timestamp,
        fecha_hora_final timestamp
    )
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
AS $$
BEGIN
    RETURN QUERY
        SELECT
            eve_id as id,
            eve_nombre as nombre,
            eve_fecha_hora_inicial as hora_inicio,
            eve_fecha_hora_final as hora_fin
        FROM public."Evento"
        WHERE CURRENT_TIMESTAMP BETWEEN eve_fecha_hora_inicial AND eve_fecha_hora_final;
END;
$$;





CREATE OR REPLACE FUNCTION obtener_presentaciones_por_proveedor(rif_proveedor VARCHAR)
RETURNS TABLE (
    producto_id INT,
    nombre_producto VARCHAR,
    presentacion_id INT,
    nombre_presentacion VARCHAR
)
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
ROWS 1000
AS $$
BEGIN
    RETURN QUERY
        SELECT
            p.pro_codigo as producto_id,
            p.pro_nombre as nombre_producto,
            pr.pre_id as presentacion_id,
            pr.pre_nombre as nombre_presentacion
        FROM
            public."Producto" p
        JOIN
            public."Presentacion" pr ON p.pro_codigo = pr.fk_producto
        WHERE
            p.fk_proveedor = rif_proveedor;
END;
$$;


-- FUNCTION: public.seleccionar_roles()

-- DROP FUNCTION IF EXISTS public.seleccionar_roles();

CREATE OR REPLACE FUNCTION public.seleccionar_roles(
	)
    RETURNS TABLE(codigo integer, nombre character varying, descripcion character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
   return query 	SELECT rol_id, rol_nombre, rol_descripcion
					FROM public."Rol";
END;
$BODY$;

ALTER FUNCTION public.seleccionar_roles()
    OWNER TO postgres;


CREATE OR REPLACE PROCEDURE insertar_presentacion_evento(
  IN p_pre_eve_cantidad NUMERIC(10, 0),
  IN p_pre_eve_precio_venta NUMERIC(12, 3),
  IN p_fk_presentacion INT,
  IN p_fk_evento INT,
  IN p_fk_premio INT
)
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO "Presentacion_Evento"(
	  pre_eve_cantidad, 
	  pre_eve_precio_venta, 
	  fk_presentacion, 
	  fk_evento, 
	  fk_premio)
  VALUES (
	  p_pre_eve_cantidad, 
	  p_pre_eve_precio_venta,
	  p_fk_presentacion, 
	  p_fk_evento, 
	  p_fk_premio);
END;
$$;


CREATE OR REPLACE FUNCTION ultimo_id(
	)
    RETURNS TABLE(codigo integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
   return query 	SELECT MAX(eve_id)
					FROM public."Evento";
END;
$BODY$;

CREATE OR REPLACE FUNCTION verificar_presentacion(cod_pre integer, cod_eve integer)
    RETURNS TABLE(precio numeric, cantidad numeric) 
    LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    RETURN QUERY 
    SELECT pre_eve_precio_venta, pre_eve_cantidad
    FROM public."Presentacion_Evento"
    WHERE cod_pre = fk_presentacion AND cod_eve = fk_evento;
END;
$BODY$;


CREATE OR REPLACE FUNCTION presentacion_particular(cod_pre integer)
    RETURNS TABLE(nombre varchar) 
    LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    RETURN QUERY 
    SELECT pre_nombre 
    FROM public."Presentacion"
    WHERE cod_pre = pre_id;
END;
$BODY$;

CREATE OR REPLACE FUNCTION seleccionar_un_evento(codigo int)
RETURNS table (nombre varchar,descripcion varchar,num_entradas numeric,
			   fecha_hora_inicial timestamp,fecha_hora_final timestamp, direccion varchar,
			  parroquia int)
AS
$$
BEGIN
   return query SELECT  eve_nombre, eve_descripcion, eve_cantidad_entradas, eve_fecha_hora_inicial, eve_fecha_hora_final, eve_direccion, fk_lugar
				FROM public."Evento"
				where eve_id=codigo;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleccionar_un_lugar(codigo int)
RETURNS table (nombre varchar)
AS
$$
BEGIN
   return query SELECT  lug_nombre
				FROM public."Lugar"
				where codigo = lug_id;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleccionar_una_presentacion1(codigo int)
RETURNS table (cod int)
AS
$$
BEGIN
   return query SELECT  fk_presentacion
				FROM public."Presentacion_Evento"
				where codigo = fk_evento;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleccionar_una_presentacion2(codigo int)
RETURNS table (cod varchar)
AS
$$
BEGIN
   return query SELECT  pre_nombre
				FROM public."Presentacion"
				where codigo = pre_id;
END;
$$
LANGUAGE plpgsql;


-- FUNCTION: public.seleccionar_empleado(integer, character varying)

-- DROP FUNCTION IF EXISTS public.seleccionar_empleado(integer, character varying);

CREATE OR REPLACE FUNCTION public.seleccionar_empleado(
	codigo integer,
	ced character varying)
    RETURNS TABLE(cedula character varying, rif character varying, p_nombre character varying, s_nombre character varying, p_apellido character varying, s_apellido character varying, direccion character varying, sueldo numeric, fecha_ing timestamp without time zone, parroquia integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query SELECT per_nat_ci, per_nat_rif, per_nat_p_nombre, per_nat_s_nombre, per_nat_p_apellido, per_nat_s_apellido, per_nat_direccion, emp_sueldo, emp_fecha_ingreso, fk_lugar
	FROM public."Empleado"
	where per_nat_id=codigo and per_nat_ci=ced;
end;
$BODY$;

ALTER FUNCTION public.seleccionar_empleado(integer, character varying)
    OWNER TO postgres;


CREATE OR REPLACE FUNCTION seleccionar_un_usuario(codigo int, doc varchar)
RETURNS table (contrasena varchar, rol integer)
AS
$$
BEGIN
   return query SELECT  usu_contraseña, fk_rol
				FROM public."Usuario"
				where fk_empleado_1=codigo
				AND fk_empleado_2 =doc;
END;
$$
LANGUAGE plpgsql;


-- FUNCTION: public.modificar_usuario_password(character varying, integer, character varying, integer, character varying, character varying)

-- DROP FUNCTION IF EXISTS public.modificar_usuario_password(character varying, integer, character varying, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION public.modificar_usuario_password(
	"contraseña" character varying,
	cod1_cliente_natural integer,
	cod2_cliente_natural character varying,
	cod1_empleado integer,
	cod2_empleado character varying,
	cod_cliente_juridico character varying,
    rol integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin 
	if  not "contraseña"='' then
		if (cod1_empleado=0 and cod2_empleado='' and cod_cliente_juridico='') then
			UPDATE public."Usuario"
			SET "usu_contraseña"="contraseña", fk_rol=rol
			where fk_cliente_natural_1=cod1_cliente_natural and fk_cliente_natural_2=cod2_cliente_natural;
		else
			if cod1_empleado=0 and cod2_empleado='' and cod1_cliente_natural=0 and cod2_cliente_natural=''then
				UPDATE public."Usuario"
				SET "usu_contraseña"="contraseña",fk_rol=rol	
				where fk_cliente_juridico=cod_cliente_juridico;
			else 
				if cod1_cliente_natural=0 and cod2_cliente_natural='' and cod_cliente_juridico='' then
					UPDATE public."Usuario"
					SET "usu_contraseña"="contraseña", fk_rol=rol
					where fk_empleado_1=cod1_empleado and fk_empleado_2=cod2_empleado;
				end if;
			end if;
		end if;
	end if;
end;
$BODY$;

ALTER FUNCTION public.modificar_usuario_password(character varying, integer, character varying, integer, character varying, character varying, integer)
    OWNER TO postgres;

-- FUNCTION: public.modificar_empleado(integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, numeric, timestamp without time zone, integer)

-- DROP FUNCTION IF EXISTS public.modificar_empleado(integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, numeric, timestamp without time zone, integer);

CREATE OR REPLACE FUNCTION public.modificar_empleado(
	codigo integer,
	ced character varying,
	rif character varying,
	p_nombre character varying,
	s_nombre character varying,
	p_apellido character varying,
	s_apellido character varying,
	direccion character varying,
	sueldo numeric,
	parroquia integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare mensaje varchar;
declare ValCedRif boolean;
declare ValnombApell boolean;
BEGIN
ValCedRif:=(REPLACE(ced, ' ', '') !~ '[^0-9]' )and (REPLACE(rif, ' ', '') !~ '[^0-9]');
ValnombApell:=(REPLACE(p_nombre, ' ', '') !~ '[^a-zA-z]') and (REPLACE(s_nombre, ' ', '') !~ '[^a-zA-z]')and 
(REPLACE(p_apellido, ' ', '') !~ '[^a-zA-z]')  and (REPLACE(s_apellido, ' ', '') !~ '[^a-zA-z]');
	if (REPLACE(ced, ' ', '')='' or REPLACE(p_nombre, ' ', '')=''or 
	    REPLACE(p_apellido, ' ', '')='' or REPLACE(direccion, ' ', '')='') then
	   		mensaje:='Hay datos obligatorios sin llenar en su registro';
	else
			if  not ValCedRif then
			mensaje:='El formato de cedula/rif es invalido solo se aceptan numeros';
			else
				if not ValnombApell then
					mensaje:='Los nombres y los apellidos no pueden tener ni numeros ni caracteres especiales';
				else
					if sueldo=0 then
					mensaje:='El sueldo no puede ser 0bs';
					else
						if length(ced)<7 or (length(REPLACE(rif, ' ', ''))>0 and length(REPLACE(rif, ' ', ''))<10) then
						mensaje:='La cedula debe tener minimo 7 numeros y el rif 10';
						else
						mensaje:='Modificacion exitosa';
						UPDATE public."Empleado"
						SET  per_nat_ci=ced, per_nat_rif=rif, per_nat_p_nombre=p_nombre, per_nat_s_nombre=s_nombre, per_nat_p_apellido=p_apellido, per_nat_s_apellido=s_apellido, per_nat_direccion=direccion, emp_sueldo=sueldo, fk_lugar=parroquia
						WHERE per_nat_ci=ced and per_nat_id=codigo;
						end if;
					end if;
				end if;
			end if; 
	end if;
    RETURN mensaje;
END;
$BODY$;

ALTER FUNCTION public.modificar_empleado(integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, numeric, integer)
    OWNER TO postgres;


CREATE OR REPLACE FUNCTION insertar_telefono_empleado( numero VARCHAR, cod1_empleado INT,
	                                            cod2_empleado VARCHAR)
RETURNS VARCHAR AS $$
    declare mensaje varchar;
    declare aux boolean;
BEGIN
    aux:=numero ~ '^[0-9]+$';
	    if not aux then 
	        mensaje:='Formato de numero invalido';
	    else
			INSERT INTO "Telefono"(
			    tel_numero, fk_cliente_natural_1, fk_cliente_natural_2, fk_cliente_juridico, fk_proveedor, fk_empleado_1, fk_empleado_2)
			    VALUES (numero,null,null,null,null, cod1_empleado, cod2_empleado);
			mensaje:='Registro exitoso';
	    end if;	
    return mensaje;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleccionar_telefonos_empleado(codigo int, doc varchar)
RETURNS table (telefono varchar, telf_id integer)
AS
$$
BEGIN
   return query SELECT  tel_numero, tel_id
				FROM public."Telefono"
				where fk_empleado_1=codigo
				AND fk_empleado_2 =doc;
END;
$$
LANGUAGE plpgsql;


-- FUNCTION: public.eliminar_un_cliente_juridico(character varying)

-- DROP FUNCTION IF EXISTS public.eliminar_un_cliente_juridico(character varying);

CREATE OR REPLACE FUNCTION public.eliminar_un_cliente_juridico(
	rif character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
DELETE FROM public."Cliente_Juridico"
	WHERE per_jur_rif=rif;
return 'Cliente eliminado';
end;
$BODY$;

ALTER FUNCTION public.eliminar_un_cliente_juridico(character varying)
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION "insertar_telefono_clienteN"( "numero" VARCHAR, "cod1_cliente" INT,
	                                            "cod2_cliente" VARCHAR)
RETURNS VARCHAR AS $$
    declare mensaje varchar;
    declare aux boolean;
BEGIN
    aux:=numero ~ '^[0-9]+$';
	    if not aux then 
	        mensaje:='Formato de numero invalido';
	    else
			INSERT INTO "Telefono"(
			    tel_tipo, tel_numero, fk_cliente_natural_1, fk_cliente_natural_2, fk_cliente_juridico, fk_proveedor, fk_empleado_1, fk_empleado_2)
			    VALUES ('hola',numero, cod1_cliente, cod2_cliente, null,null,null, null);
			mensaje:='Registro exitoso';
	    end if;	
    return mensaje;
END;
$$ LANGUAGE plpgsql;


-- FUNCTION: public.modificar_cliente_natural(integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, integer)

-- DROP FUNCTION IF EXISTS public.modificar_cliente_natural(integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, integer);

CREATE OR REPLACE FUNCTION public.modificar_cliente_natural(
	codigo integer,
	ced character varying,
	rif character varying,
	p_nombre character varying,
	s_nombre character varying,
	p_apellido character varying,
	s_apellido character varying,
	direccion character varying,
	parroquia integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare mensaje varchar;
declare ValCedRif boolean;
declare ValnombApell boolean;
begin
ValCedRif:=(REPLACE(ced, ' ', '') !~ '[^0-9VE]' )and (REPLACE(rif, ' ', '') !~ '[^0-9N]');
ValnombApell:=(REPLACE(p_nombre, ' ', '') !~ '[^a-zA-z]') and (REPLACE(s_nombre, ' ', '') !~ '[^a-zA-z]')and 
(REPLACE(p_apellido, ' ', '') !~ '[^a-zA-z]')  and (REPLACE(s_apellido, ' ', '') !~ '[^a-zA-z]');
	if (REPLACE(ced, ' ', '')='' or REPLACE(p_nombre, ' ', '')=''or 
	    REPLACE(p_apellido, ' ', '')='' or REPLACE(direccion, ' ', '')='') then
	   		mensaje:='Hay datos obligatorios sin llenar en su registro';
	else
			if  not ValCedRif then
			mensaje:='El formato de cedula/rif es invalido solo se aceptan numeros';
			else
				if not ValnombApell then
					mensaje:='Los nombres y los apellidos no pueden tener ni numeros ni caracteres especiales';
				else
					if length(ced)<7 or (length(REPLACE(rif, ' ', ''))>0 and length(REPLACE(rif, ' ', ''))<10) then
						mensaje:='La cedula debe tener minimo 7 numeros y el rif 10';
					else 
						mensaje:='Modificacion exitosa';
						UPDATE public."Cliente_Natural"
						SET  per_nat_ci=ced, per_nat_rif=rif, per_nat_p_nombre=p_nombre, per_nat_s_nombre=s_nombre, per_nat_p_apellido=p_apellido, per_nat_s_apellido=s_apellido, per_nat_direccion=direccion, fk_lugar=parroquia
						WHERE per_nat_ci=ced and per_nat_id=codigo;
					end if;
				end if;
			end if; 
	end if;
    RETURN mensaje;
END;
$BODY$;

ALTER FUNCTION public.modificar_cliente_natural(integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, integer)
    OWNER TO postgres;


-- FUNCTION: public.seleccionar_un_cliente_juridico(character varying)

-- DROP FUNCTION IF EXISTS public.seleccionar_un_cliente_juridico(character varying);

CREATE OR REPLACE FUNCTION public.seleccionar_un_cliente_juridico(
	rif character varying)
    RETURNS TABLE(denominacion_comercial character varying, razon_social character varying, pagina_web character varying, direccion_fiscal character varying, direccion_fisica character varying, capital numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query  SELECT  per_jur_denominacion_comercial, per_jur_razon_social, per_jur_pagina_web, per_jur_direccion_fiscal, per_jur_direccion_fisica, per_jur_capital
				FROM public."Cliente_Juridico"
				where per_jur_rif=rif;
end;
$BODY$;

ALTER FUNCTION public.seleccionar_un_cliente_juridico(character varying)
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.consultar_correo_empleado(
	rif character varying, cod integer)
    RETURNS TABLE(correo character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query  SELECT cor_direccion
				FROM public."Correo"
				where fk_empleado_1=rif
				And fk_empleado=cod;
end;
$BODY$;

CREATE OR REPLACE FUNCTION eliminar_telefonos_por_codigo(codigo INTEGER, cedula varchar)
RETURNS VOID
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    DELETE FROM public."Telefono"
    WHERE codigo = fk_empleado_1
	And fk_empleado_2 = cedula;
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.modificar_empleado_correo(
	correo character varying, codEmpleado integer, cedula character varying )
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin 
	if  not correo='' then
		UPDATE public."Correo"
		SET cor_direccion=correo
		where fk_empleado=codEmpleado
		And fk_empleado_1=cedula;
	end if;
end;
$BODY$;

--Insertar un usuario que es cliente
CREATE OR REPLACE FUNCTION insertar_usuario_cliente(
    clave varchar, 
	cod1_cliente int, cod2_cliente varchar
    )
RETURNS VOID
AS $$
BEGIN
	INSERT INTO public."Usuario"(
		"usu_contraseña", fk_rol, fk_cliente_juridico, fk_proveedor, fk_cliente_natural_1, fk_cliente_natural_2, fk_empleado_1, fk_empleado_2)
	VALUES (clave, 9, NULL, NULL, cod1_cliente, cod2_cliente, NULL, NULL );	
END;
$$ language plpgsql;

CREATE OR REPLACE PROCEDURE agregar_cliente(
    p_nombre VARCHAR,
    s_nombre VARCHAR,
    p_apellido VARCHAR,
    s_apellido VARCHAR,
    cedula VARCHAR,
    rif VARCHAR,
    email VARCHAR,
    clave VARCHAR,
    parroquia INT,
    direccion VARCHAR
) AS $$
DECLARE
    mens_1 VARCHAR;
    mens_2 VARCHAR;
    cod_cliente INT;
BEGIN
    -- Llamar a la función registro_cliente_natural
    mens_1 := registro_cliente_natural(
        cedula,
		rif,
        p_nombre,
        s_nombre,
        p_apellido,
        s_apellido,
        direccion,
        parroquia
    );
    RAISE NOTICE '%', mens_1;

    -- Obtener el ID del cliente recién insertado
    SELECT "per_nat_id" INTO cod_cliente
    FROM "Cliente_Natural"
    WHERE "per_nat_ci" = cedula;

    -- Llamar a la función regusuario
    mens_2 := insertar_usuario_cliente(clave, cod_cliente, cedula);
    RAISE NOTICE '%', mens_2;

    -- Llamar a la función insertar_correo
    PERFORM insertar_correo(email, NULL, NULL, cod_cliente, cedula, NULL);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION public.consultar_correo_cliente(
	cedula character varying, cod integer)
    RETURNS TABLE(correo character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query  SELECT cor_direccion
				FROM public."Correo"
				where fk_cliente_natural=cod
				And fk_cliente_natural_1=cedula;
end;
$BODY$;

CREATE OR REPLACE FUNCTION seleccionar_un_usuario_clienteN(codigo int, doc varchar)
RETURNS table (contrasena varchar)
AS
$$
BEGIN
   return query SELECT  usu_contraseña
				FROM public."Usuario"
				where fk_cliente_natural_1=codigo
				AND fk_cliente_natural_2 =doc;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.modificar_clienteN_correo(
	correo character varying, codCliente integer, cedula character varying )
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin 
	if  not correo='' then
		UPDATE public."Correo"
		SET cor_direccion=correo
		where fk_cliente_natural=codCliente
		And fk_cliente_natural_1=cedula;
	end if;
end;
$BODY$;


CREATE OR REPLACE FUNCTION eliminar_telefonos_cliente(codigo INTEGER, cedula varchar)
RETURNS VOID
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    DELETE FROM public."Telefono"
    WHERE codigo = fk_cliente_natural_1
	And fk_cliente_natural_2 = cedula;
END;
$BODY$;

CREATE OR REPLACE FUNCTION insertar_lugar_persona(
  IN tipo character varying,
  IN lugarfisico INT,
  IN clientejuridico character varying
)
RETURNS VOID
AS $$
BEGIN
  INSERT INTO "Lugar_Persona"(
	  "Lug_per_tipo", 
	  "fk_lugar", 
	  "fk_cliente_juridico")
  VALUES (
	  tipo, 
	  lugarfisico,
	  clientejuridico);
END;

$$ language plpgsql;

CREATE OR REPLACE FUNCTION insertar_usuario_clienteJ(
    clave varchar,  cod1_cliente varchar
    )
RETURNS VOID
AS $$
BEGIN
	INSERT INTO public."Usuario"(
		"usu_contraseña", fk_rol, fk_cliente_juridico, fk_proveedor, fk_cliente_natural_1, fk_cliente_natural_2, fk_empleado_1, fk_empleado_2)
	VALUES (clave, 9, cod1_cliente, NULL, NULL, NULL, NULL, NULL );	
END;
$$ language plpgsql;

CREATE OR REPLACE PROCEDURE agregar_juridico(
    denominacion_comercial VARCHAR,
    razon_social VARCHAR,
    pagina_web VARCHAR,
    capital_disponible NUMERIC(12, 3),
    rif VARCHAR,
    clave VARCHAR,
    parroquia_fisica INT,
    direccion_fisica VARCHAR,
    parroquia_fiscal INT,
    direccion_fiscal VARCHAR,
	tipo_fisica character varying,
	tipo_fiscal character varying
) AS $$
DECLARE
    mens_1 VARCHAR;
    fecha_ing TIMESTAMP;
    cod_juridico INT;
BEGIN

    -- Llamar a la función ingresar_cliente_juridico
    mens_1 := insertar_cliente_juridico(
		rif,
        denominacion_comercial,
        razon_social,
        pagina_web,
        direccion_fisica,
        direccion_fiscal,
		capital_disponible
    );
    RAISE NOTICE '%', mens_1;



    -- Llamar a la función ingresar_lugar_persona
    PERFORM insertar_lugar_persona(
		tipo_fisica,
        parroquia_fisica,
        rif
    );
	
	PERFORM insertar_lugar_persona(
        tipo_fiscal,
        parroquia_fiscal,
        rif
    );

    -- Llamar a la función usuario_juridico
    PERFORM insertar_usuario_clienteJ(clave, rif);
END;
$$ LANGUAGE plpgsql;






CREATE OR REPLACE FUNCTION seleccionar_un_lugar_personaJ(tipo varchar, doc varchar)
RETURNS table (lugar integer)
AS
$$
BEGIN
   return query SELECT  fk_lugar
				FROM public."Lugar_Persona"
				where fk_cliente_juridico=doc
				AND "Lug_per_tipo" =tipo;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleccionar_usuarioJ( doc varchar)
RETURNS table (clave varchar)
AS
$$
BEGIN
   return query SELECT  "usu_contraseña"
				FROM public."Usuario"
				where fk_cliente_juridico=doc;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insertar_telefono_clienteJ(numero1 VARCHAR, numero2 VARCHAR, codigo varchar)
RETURNS VARCHAR AS $$
DECLARE
    mensaje VARCHAR;
    aux1 BOOLEAN;
    aux2 BOOLEAN;
BEGIN

    aux2 := numero2 ~ '^[0-9]+$';

    IF NOT aux2 THEN 
        mensaje := 'Formato de número invalido';
    ELSE
        -- Verificar si el registro ya existe
        IF EXISTS (
            SELECT 1
            FROM "Telefono"
            WHERE fk_cliente_juridico = codigo
              AND tel_numero = numero1
        ) THEN
            -- Realizar la actualización
            UPDATE "Telefono"
            SET tel_numero = numero2
            WHERE fk_cliente_juridico= codigo
              AND tel_numero = numero1;
            mensaje := 'Actualización exitosa';
        ELSE
            -- Realizar la inserción
            INSERT INTO "Telefono"(
                tel_tipo, tel_numero, fk_cliente_natural_1, fk_cliente_natural_2, fk_cliente_juridico, fk_proveedor, fk_empleado_1, fk_empleado_2)
                VALUES ('hola', numero2, NULL, NULL, codigo, NULL, NULL, NULL);
            mensaje := 'Registro exitoso';
        END IF;
    END IF;

    RETURN mensaje;
END;
$$ LANGUAGE plpgsql;
---------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION seleccionar_telefonos_juridico(codigo varchar)
RETURNS table (telefono varchar)
AS
$$
BEGIN
   return query SELECT  tel_numero
				FROM public."Telefono"
				where fk_cliente_juridico=codigo;
END;
$$
LANGUAGE plpgsql;

-- FUNCTION: public.modificar_cliente_juridico(character varying, character varying, character varying, character varying, character varying, character varying, numeric)

-- DROP FUNCTION IF EXISTS public.modificar_cliente_juridico(character varying, character varying, character varying, character varying, character varying, character varying, numeric);

CREATE OR REPLACE FUNCTION public.modificar_cliente_juridico(
	rif character varying,
	denominacion_comer character varying,
	razon_soc character varying,
	pagina_web character varying,
	direccion_fiscal character varying,
	direccion_fisica character varying,
	capital numeric)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare aux boolean;
declare aux2 boolean;
declare mensaje varchar;
begin
aux:=(REPLACE(rif, ' ', '') !~ '[^0-9JG]');
aux2:=(REPLACE(denominacion_Comer, ' ', '') !~ '[^a-zA-z]') and (REPLACE(razon_Soc, ' ', '') !~ '[^a-zA-z]') ;
	if (REPLACE(rif, ' ', '')='' or REPLACE(denominacion_Comer, ' ', '')=''or 
	    REPLACE(razon_Soc, ' ', '')='' or REPLACE(pagina_Web, ' ', '')=''or REPLACE(direccion_fiscal, ' ', '')=''
   		or REPLACE(direccion_fisica, ' ', '')='') then
	   		mensaje:='Hay datos obligatorios sin llenar en su registro';
	else 
		if not aux then
			mensaje:='Formato de rif invalido';
		else
			if length(rif)<10 then
			mensaje:='El rif debe tener minimo 10 numeros';
			else
				if  not aux2 then
					mensaje:='La denominacion comercial y la razon social no acepta numeros ni caracteres especiales';
				else
					mensaje:='Registro exitoso';
					UPDATE public."Cliente_Juridico"
					SET per_jur_rif=rif, per_jur_denominacion_comercial=denominacion_Comer, per_jur_razon_social=razon_Soc, per_jur_pagina_web=pagina_Web, 
					per_jur_direccion_fiscal=direccion_fiscal, per_jur_direccion_fisica=direccion_fisica, per_jur_capital=capital
					WHERE  per_jur_rif=rif;
				end if;
			end if;
		end if;
	end if;
return mensaje;
end;
$BODY$;

ALTER FUNCTION public.modificar_cliente_juridico(character varying, character varying, character varying, character varying, character varying, character varying, numeric)
    OWNER TO postgres;

-- CREATE OR REPLACE FUNCTION public.modificar_clienteJ_correo(
-- 	correo character varying, codClienteJ character varying )
--     RETURNS void
--     LANGUAGE 'plpgsql'
--     COST 100
--     VOLATILE PARALLEL UNSAFE
-- AS $BODY$
-- begin 
-- 	if  not correo='' then
-- 		UPDATE public."Correo"
-- 		SET cor_direccion=correo
-- 		where fk_empleado=codEmpleado
-- 		And fk_cliente_juridico=codClienteJ;
-- 	end if;
-- end;
-- $BODY$;

CREATE OR REPLACE PROCEDURE modificar_juridico(
    denominacion_comercial VARCHAR,
    razon_social VARCHAR,
    pagina_web VARCHAR,
    capital_disponible NUMERIC(12, 3),
    rif VARCHAR,
    clave VARCHAR,
    parroquia_fisica INT,
    direccion_fisica VARCHAR,
    parroquia_fiscal INT,
    direccion_fiscal VARCHAR,
	paraNull CHARACTER VARYING,
    tipoFa CHARACTER VARYING,
    tipoFl CHARACTER VARYING

) AS $$
DECLARE
    mens_1 VARCHAR;
    mens_2 VARCHAR;
    mens_3 VARCHAR;
    mens_4 VARCHAR;
BEGIN

    
    mens_1 := public.modificar_lugar_persona(
        tipoFa,
        parroquia_fisica,
        rif
        -- Agrega otros parámetros según los requerimientos de modificar_clienteJ
    );
    RAISE NOTICE '%', mens_1;


    mens_4 := public.modificar_lugar_persona(
        tipoFl,
        parroquia_fiscal,
        rif
        -- Agrega otros parámetros según los requerimientos de modificar_clienteJ
    );
    RAISE NOTICE '%', mens_4;


     -- Llamar a la función modificar_clienteJ
    mens_2 := modificar_cliente_juridico(
        rif,
        denominacion_comercial,
        razon_social,
		pagina_web,
		direccion_fisica,
		direccion_fiscal,
        capital_disponible
        -- Agrega otros parámetros según los requerimientos de modificar_clienteJ
    );
    RAISE NOTICE '%', mens_2;
    

    -- Llamar a la función modificar_clienteJ
    mens_2 := modificar_cliente_juridico(
        rif,
        denominacion_comercial,
        razon_social,
		pagina_web,
		direccion_fisica,
		direccion_fiscal,
        capital_disponible
        -- Agrega otros parámetros según los requerimientos de modificar_clienteJ
    );
    RAISE NOTICE '%', mens_2;

    -- Llamar a la función modificar_usuario_clave
    mens_3 := public.modificar_usuario_password(
        clave,0 , paraNull, 0, paraNull, rif, 9
        -- Agrega otros parámetros según los requerimientos de modificar_usuario_clave
    );
    RAISE NOTICE '%', mens_3;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.modificar_lugar_persona(
	tipo character varying, lugar int,
	cod_cliente character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin 
			UPDATE public."Lugar_Persona"
			SET fk_lugar=lugar
			where fk_cliente_juridico=cod_cliente and "Lug_per_tipo"=tipo;
	
end;
$BODY$;

CREATE OR REPLACE FUNCTION insertar_empleado_horario(
    codigo_empleado_1 int,
    codigo_empleado_2 VARCHAR
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO "Empleado_Horario" (fk_empleado, fk_empleado_2, fk_horario)
    VALUES (codigo_empleado_1, codigo_empleado_2, 1);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insertar_entrada(
    codigo int,
    fecha_inicial DATE,
    fecha_final DATE,
    precio numeric
)
RETURNS VOID AS $$
DECLARE
    fecha_actual DATE := fecha_inicial;
    i INT := 1;
BEGIN
    -- Iniciar el bucle
    WHILE fecha_actual <= fecha_final LOOP
        -- Realizar la inserción en la tabla "Entrada"
        INSERT INTO "Entrada" (ent_fecha_hora, ent_precio, fk_evento)
        VALUES (fecha_actual, precio, codigo);

        -- Incrementar la fecha y el índice
        fecha_actual := fecha_actual + INTERVAL '1 day';
        i := i + 1;
        
       
        EXIT WHEN fecha_actual > fecha_final;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_precio_entradas(
    codigo INT,
    precio numeric
)
RETURNS VOID AS $$
BEGIN

    UPDATE "Entrada"
    SET ent_precio =precio
    WHERE fk_evento = codigo;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION sumar_puntos_cliente_natural(
    id_cliente_natural INT,
	ci_cliente_natural VARCHAR,
    puntos_a_sumar INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE "Cliente_Natural"
    SET per_nat_punto = per_nat_punto + puntos_a_sumar
    WHERE per_nat_id = id_cliente_natural AND per_nat_ci = ci_cliente_natural;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION sumar_puntos_cliente_juridico(
    id_cliente VARCHAR,
    puntos_a_sumar INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE "Cliente_Juridico"
    SET per_jur_punto = per_jur_punto + puntos_a_sumar
    WHERE per_jur_rif = id_cliente;
END;
$$ LANGUAGE plpgsql;

create or replace function codigo_ordenes_reposicion ()
returns table (codigo varchar, fecha_inicio varchar)
as $$
begin
return query select cast(fk_compra as varchar), cast(com_est_fecha_ini as varchar) from "Compra_Estatus"
where fk_estatus=5;
end;
$$ LANGUAGE plpgsql;

create or replace function direccion_proveedor(codigo varchar )
returns table (direccion text)
as $$
begin
return query select prov.per_jur_direccion_fiscal ||' ' || e.lug_nombre ||' ' ||m.lug_nombre||' ' ||p.lug_nombre as Ubicacion
 	from "Proveedor" prov,"Lugar_Persona" as lp,"Lugar" as p,"Lugar" as m,"Lugar" as e
	where prov.per_jur_rif=codigo and lp."Lug_per_tipo"='Fiscal' and lp.fk_proveedor=codigo and  lp.fk_lugar=p.lug_id and p.fk_lugar=m.lug_id and m.fk_lugar=e.lug_id;
end;
$$ LANGUAGE plpgsql;

create or replace function fecha_orden(codigo varchar )
returns table (fecha varchar)
as $$
begin
return query  select cast(com_est_fecha_ini as varchar) from "Compra_Estatus"
where fk_compra=cast(codigo as int); 
end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.ordenes_compra(
	)
    RETURNS TABLE(codigo character varying, fecha character varying, estatus character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin 
return query select cast(com_id as varchar),cast(ce.com_est_fecha_ini as varchar),est_nombre
from "Compra","Compra_Estatus" ce,"Estatus"
where com_id=ce.fk_compra and ce.fk_estatus=est_id;
end;
$BODY$;

create or replace function codigo_ordenes_reposicion ()
returns table (codigo varchar, fecha_inicio varchar)
as $$
begin
return query select cast(fk_compra as varchar), cast(com_est_fecha_ini as varchar) from "Compra_Estatus"
where fk_estatus=5;
end;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE "crear_orden"
( 
	codigo INT, 
	identificacion VARCHAR, 
	presentacion INT,
	cantidad INT
)
AS $$

	DECLARE 
		--aqui se guarda el codigo de venta registrada a un cliente
		Cjuridico INT;
		Cnatural INT;

BEGIN

	Cjuridico := buscar_cliente_juridico( identificacion );
	Cnatural := buscar_cliente_natural( codigo, identificacion );
	
	IF Cnatural = 0 AND Cjuridico = 0 THEN
		CALL crear_venta_virtual( codigo, identificacion );
	END IF;
	
	Cjuridico := buscar_cliente_juridico( identificacion );
	Cnatural := buscar_cliente_natural( codigo, identificacion );
	
	IF Cnatural != 0 THEN 
		CALL crear_pedido( Cnatural, presentacion, cantidad );
	END IF;
	
	IF Cjuridico != 0 THEN 
		CALL crear_pedido( Cjuridico, presentacion, cantidad );
	END IF;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE crear_pedido( codigo INT, presentacion INT , cantidad INT )
AS $$
	DECLARE precio NUMERIC (12,3);
BEGIN 

	precio := buscar_precio( presentacion );

	INSERT INTO "Detalle_Venta_Virtual_Presentacion"
	(
		det_ven_vir_pre_cantidad, 
	 	det_ven_vir_pre_precio_venta, 
		fk_venta_virtual, 
		fk_presentacion 
	)
	VALUES
	(
		cantidad,
		precio,
		codigo,
		presentacion
	);

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION buscar_precio( codigo INT )
RETURNS NUMERIC AS $$
	DECLARE 
		precio NUMERIC(12,3);

BEGIN
	
	SELECT "inv_vir_precio" INTO precio
	FROM "Inventario_Virtual_Presentacion"
	WHERE "fk_presentacion" = codigo;
	
	RETURN precio;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE crear_venta_virtual( codigo INT, identificacion VARCHAR )
AS $$
	DECLARE 
		fecha timestamp;
BEGIN
	fecha := CURRENT_TIMESTAMP;
	IF codigo = 0 THEN
		INSERT INTO "Venta_Virtual"
			(	
				detallev_fecha_venta, 
				detallev_total_venta,
				fk_virtual,
	 			fk_cliente_natural_1,
	 			fk_cliente_juridico,
	 			fk_cliente_natural_2
			)
			VALUES
			(
				fecha,
				1,
				1,
				NULL,
				identificacion,
				NULL
			);
	ELSE
		INSERT INTO "Venta_Virtual"
			(	
				detallev_fecha_venta, 
				detallev_total_venta,
			 	fk_virtual,
	 			fk_cliente_natural_1,
	 			fk_cliente_juridico,
	 			fk_cliente_natural_2
			)
			VALUES
			(
				fecha,
				1,
				1,
				codigo,
				NULL,
				identificacion
			);
	END IF;
	
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_estatus()
RETURNS TRIGGER AS $$
DECLARE 
	fecha timestamp;
	codigo INT;
BEGIN
	fecha := CURRENT_TIMESTAMP;
	
	SELECT MAX (detallev_id) INTO codigo
	FROM "Venta_Virtual";
	
    INSERT INTO "Venta_Virtual_Estatus" 
	(
		ven_vir_est_fecha_ini,
		ven_vir_est_fecha_fin,
		fk_venta_virtual,
		fk_estatus
	) 
	VALUES 
	(
		fecha,
		NULL,
		codigo,
		3
	);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_estatus
AFTER INSERT ON "Venta_Virtual"
FOR EACH ROW
EXECUTE FUNCTION actualizar_estatus();

CREATE OR REPLACE FUNCTION buscar_cliente_juridico(rif VARCHAR)
RETURNS INT AS $$
    DECLARE
       id_venta INT := 0;
    BEGIN
        SELECT "detallev_id" INTO id_venta
        FROM "Venta_Virtual"
		JOIN "Venta_Virtual_Estatus" ON "fk_venta_virtual" = "detallev_id"
        WHERE "fk_cliente_juridico" = rif AND "fk_estatus" = 3;

        IF id_venta IS NULL THEN
			RETURN 0;
		END IF;
        RETURN id_venta;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION buscar_cliente_natural(codigo INT, cedula VARCHAR)
RETURNS INT AS $$
    DECLARE
        id_venta INT;
    BEGIN
        SELECT "detallev_id" INTO id_venta
        FROM "Venta_Virtual" 
		JOIN "Venta_Virtual_Estatus" ON "fk_venta_virtual" = "detallev_id"
        WHERE "fk_cliente_natural_1" = codigo AND "fk_cliente_natural_2" = cedula
				AND "fk_estatus" = 3;

		IF id_venta IS NULL THEN
			RETURN 0;
		END IF;
        RETURN id_venta;
    END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION public.pagar_venta_virtual(
	cod1 integer,
	cod2 character varying,
	montos character varying,
	id_tarjetas character varying,
	cant_tarjetas character varying,
	total character varying,
    codigo_venta integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

declare aux1 varchar;
declare montos_array varchar[];
declare tarjetas_array varchar[];
declare aux2 varchar;
declare mensaje varchar;
declare aux boolean;
declare total_pago boolean;
declare tarjetas_array_int int[];

declare i int;
declare j int;
declare cod_tarjeta int;
begin
aux:=(montos !~ '[^0-9 $]');
i:=LENGTH(cant_tarjetas);
j:=0;
if aux=true then
 FOR i IN 1..i
	LOOP
		aux1:=split_part(montos, '$', i);
		select into montos_array  array_append(montos_array, aux1 );
		
		aux2:=split_part(id_tarjetas, '$', i);
		select into tarjetas_array array_append(tarjetas_array, aux2);
		select into tarjetas_array_int array_append(tarjetas_array_int, cast(aux2 as int));
	END LOOP;

total_pago:=public.comprobar_montos_total(montos_array,  tarjetas_array, total);
-- si los montos parciales concuerdan con el total inserta en la tabla pago_metodo_pago
	if total_pago=true then
		FOREACH cod_tarjeta IN ARRAY tarjetas_array_int
		LOOP
			j:=j+1;
			INSERT INTO public."Pago_Metodo_Pago"(
			monto_parcial, fk_venta_fisica, fk_venta_virtual, fk_tarjeta, fk_efectivo, fk_cheque, fk_mi_punto)
			VALUES (cast(montos_array[j] as numeric), null, codigo_venta, cod_tarjeta, null, null, null);
		END LOOP;
   		mensaje:='Regitro de pago exitoso';  
	else 
 		mensaje:='La suma de los montos no es igual al total'; 
 	end if;
else
	mensaje:='Los montos ingresados no son numeros validos';
end if;
 
 return mensaje;
end;
$BODY$;
CREATE OR REPLACE FUNCTION public.detalleproducto(
	cod integer)
    RETURNS TABLE(direccion text, categoria character varying, variedad character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query select  e.lug_nombre ||'- ' ||m.lug_nombre||'- ' ||p.lug_nombre as Ubicacion,cat_nombre,var_nombre
 	from "Producto" pro,"Lugar" as p,"Lugar" as m,"Lugar" as e,"Categoria", "Variedad"
	where pro.pro_codigo=cod and   pro.fk_lugar=p.lug_id and p.fk_lugar=m.lug_id and m.fk_lugar=e.lug_id
	and cat_id=pro.fk_categoria and var_id=pro.fk_variedad ;
end;
$BODY$;
CREATE OR REPLACE FUNCTION public.seleccionar_productos_por_id(
	id integer)
    RETURNS TABLE(codigo integer, nombre character varying, grados_alcohol numeric, descripcion character varying, tipo character varying, parroquia integer, categoria integer, variedad integer, codigo_presentacion integer, url character varying, capacidad numeric, precio numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY 
    SELECT 
        pr.pro_codigo, 
        pr.pro_nombre, 
        pr.pro_grados_alcohol, 
        pr.pro_descripcion, 
        pr.pro_tipo, 
        pr.fk_lugar, 
        pr.fk_categoria, 
        pr.fk_variedad,
		pre.pre_id,
        i.ima_url,
        b.bot_capacidad,
		inv.inv_vir_precio
    FROM "Producto" as pr
    JOIN "Imagen" as i ON i."fk_producto" = pr."pro_codigo"
    JOIN "Presentacion" as pre ON pre."fk_producto" = pr."pro_codigo"
    JOIN "Botella" as b ON b."bot_id" = pre."fk_material_botella_3"
    JOIN "Inventario_Virtual_Presentacion" as inv ON  "fk_presentacion" = "pre_id"
	WHERE pr."pro_codigo" = id;
END;
$BODY$;
CREATE OR REPLACE FUNCTION public.carrito(
	cod1 integer,
	cod2 character varying,
	estatus integer)
    RETURNS TABLE(cantidad numeric, precio_unitario numeric, codigo_presentacion integer, codigo_venta integer, pre_nombre character varying, pro_nombre character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query select det_ven_vir_pre_cantidad,det_ven_vir_pre_precio_venta,dvv.fk_presentacion,detallev_id,p.pre_nombre,pro.pro_nombre
from "Detalle_Venta_Virtual_Presentacion" as dvv,"Venta_Virtual", "Venta_Virtual_Estatus" vve,"Presentacion" p, "Producto" pro
where ((fk_cliente_natural_1=cod1 and fk_cliente_natural_2=cod2)or(cod1=0 and fk_cliente_juridico=cod2))
and (dvv.fk_venta_virtual=detallev_id) and(vve.fk_venta_virtual=detallev_id) and (vve.fk_estatus=estatus) and dvv.fk_presentacion=p.pre_id and p.fk_producto=pro.pro_codigo ;
end;
$BODY$;

create or replace function fecha_Factura_Virtual(codigo_venta int)
returns table(fecha text) 
as $$
begin
return query select substring( cast(ven_vir_est_fecha_ini as varchar), 1,10) from "Venta_Virtual_Estatus"
where fk_venta_virtual=codigo_venta and fk_estatus=7;
end;
$$ language  plpgsql;

create or replace function datos_factura_venta_virtual(cod1 int,cod2 varchar)
returns table(nombre text,documento varchar, direccion text) 
as $$
begin
if(cod1>0) then
return query select cn.per_nat_p_nombre || ' '|| cn.per_nat_p_apellido,cn.per_nat_ci,per_nat_direccion  || ' '||
p.lug_nombre || ' '||m.lug_nombre || ' '||e.lug_nombre
from "Cliente_Natural" cn,"Lugar" p,"Lugar" m,"Lugar" e
where  cn.per_nat_ci=cod2 and cn.per_nat_id=cod1 and cn.fk_lugar=p.lug_id and p.fk_lugar=m.lug_id and m.fk_lugar=e.lug_id;
end if;
if(cod1=0) then
return query select cast(prov.per_jur_razon_social as text),prov.per_jur_rif,
   prov.per_jur_direccion_fiscal ||' ' || e.lug_nombre ||' ' ||m.lug_nombre||' ' ||p.lug_nombre as Ubicacion
 	from "Cliente_Juridico" prov,"Lugar_Persona" as lp,"Lugar" as p,"Lugar" as m,"Lugar" as e
	where prov.per_jur_rif=cod2 and lp."Lug_per_tipo"='Fiscal' and lp.fk_cliente_juridico=cod2 and lp.fk_lugar=p.lug_id and p.fk_lugar=m.lug_id and m.fk_lugar=e.lug_id;
end if;
end;
$$ language  plpgsql;


CREATE OR REPLACE FUNCTION public.factura_ordenes_reposicion(
	id character varying)
    RETURNS TABLE(codigo character varying, descripcion text, proveedor character varying, rif character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query select cast(c.com_id as varchar),p.pre_nombre  || ' ' ||produ.pro_nombre as descripcion,
pro.per_jur_razon_social,pro.per_jur_rif
from "Compra" c,"Compra_Presentacion" cp,"Presentacion" p,"Proveedor" pro,"Producto" produ
where c.com_id=cast(id as int) and cp.fk_compra=c.com_id and cp.fk_presentacion=p.pre_id and p.fk_producto=produ.pro_codigo 
and produ.fk_proveedor=pro.per_jur_rif;
end;
$BODY$;


-------modificar producto-------
CREATE OR REPLACE FUNCTION public.modificar_producto(
	codigo integer,
	nombre character varying,
	descripcion character varying,
	gradosa numeric,
	tipo character varying,
	anejamiento integer,
	proveedor character varying,
	parroquia integer,
	categoria integer,
	variedad integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE mensaje varchar;
declare aux boolean;
BEGIN 
aux:=REPLACE(nombre, ' ', '') !~ '[^a-zA-z]';
	if  (REPLACE(nombre, ' ', '')='' or REPLACE(descripcion, ' ', '')='' or REPLACE(tipo, ' ', '')='')then
		mensaje:='Hay campos obligatorios vacios en el registro';
	else
		if not aux then
			mensaje:='El nombre del producto no acepta numeros ni caracteres especiales';
		else
			UPDATE public."Producto"
			SET  pro_nombre=nombre, pro_grados_alcohol=gradosA, pro_descripcion=descripcion, pro_tipo=tipo, 
			"fk_añejamiento"=anejamiento, fk_proveedor=proveedor, fk_lugar=parroquia, fk_categoria=categoria, 
			fk_variedad=variedad
			WHERE pro_codigo=codigo;
			mensaje:='Modificacion exitosa';
		end if;
	end if;
    RETURN mensaje ;
END;
$BODY$;
---
CREATE OR REPLACE FUNCTION public.actualizar_sabores(
	id_producto integer,
	sabores integer[])
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    id_sabor int;
BEGIN
    FOREACH id_sabor IN ARRAY sabores
    LOOP
        RAISE NOTICE 'id del sabor ==> %', id_sabor;

        -- Actualizar la tabla "Producto_Sabor" con el nuevo fk_producto
        UPDATE public."Producto_Sabor"
        SET "fk_producto" = id_producto
        WHERE "fk_sabor" = id_sabor;
    END LOOP;
END;
$BODY$;
--
CREATE OR REPLACE FUNCTION public.actualizar_colores(
	id_producto integer,
	colores integer[])
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    id_color int;
BEGIN
    FOREACH id_color IN ARRAY colores
    LOOP
        RAISE NOTICE 'id del color ==> %', id_color;

        -- Actualizar la tabla "Producto_Color" con el nuevo fk_producto
        UPDATE public."Producto_Color"
        SET "fk_producto" = id_producto
        WHERE "fk_color" = id_color;
    END LOOP;
END;
$BODY$;
---
CREATE OR REPLACE FUNCTION public.actualizar_materia(
	id_producto integer,
	materias_primas integer[])
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    id_materia int;
BEGIN
    FOREACH id_materia IN ARRAY materias_primas
    LOOP
        RAISE NOTICE 'id de la materia prima ==> %', id_materia;

        -- Actualizar la tabla "Producto_Materia" con el nuevo fk_producto
        UPDATE public."Producto_Materia"
        SET "fk_producto" = id_producto
        WHERE "fk_materia" = id_materia;
    END LOOP;
END;
$BODY$;
---
CREATE OR REPLACE FUNCTION public.actualizar_imagen(
	id_producto integer,
	id_imagen integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
    -- Actualizar la tabla "Imagen" con el nuevo fk_producto
    UPDATE public."Imagen"
    SET "fk_producto" = id_producto
    WHERE "ima_id" = id_imagen;
END;
$BODY$;
-----
CREATE OR REPLACE FUNCTION public.actualizar_presentacion(
	id_producto integer,
	presentaciones integer[])
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    id_presentacion int;
BEGIN
    FOREACH id_presentacion IN ARRAY presentaciones
    LOOP
        RAISE NOTICE 'id de la presentacion ==> %', id_presentacion;

        -- Actualizar la tabla "Presentacion" con el nuevo fk_producto
        UPDATE public."Presentacion"
        SET "fk_producto" = id_producto
        WHERE "pre_id" = id_presentacion;
    END LOOP;
END;
$BODY$;

----
CREATE OR REPLACE FUNCTION public.seleccionar_productos_id(
	id integer)
    RETURNS TABLE(codigo integer, nombre character varying, grados_alcohol numeric, descripcion character varying, tipo character varying, parroquia integer, categoria integer, variedad integer, "añejamiento" integer, lugar integer, proveedor character varying, sabor integer[], color integer[], materia_prima integer[], capacidad numeric[], codigo_presentacion integer, url character varying, precio numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY 
    SELECT 
        pr.pro_codigo, 
        pr.pro_nombre, 
        pr.pro_grados_alcohol, 
        pr.pro_descripcion, 
        pr.pro_tipo, 
        pr.fk_lugar, 
        pr.fk_categoria, 
        pr.fk_variedad,
		pr."fk_añejamiento",
		pr.fk_lugar,
		pr.fk_proveedor,
        ARRAY_AGG(DISTINCT ps.fk_sabor) AS sabor,
        ARRAY_AGG(DISTINCT pc.fk_color) AS color,
        ARRAY_AGG(DISTINCT pm.fk_materia) AS materia_prima,
        ARRAY_AGG(DISTINCT b.bot_capacidad) AS capacidad,
        pre.pre_id,
        i.ima_url,
        inv.inv_vir_precio
    FROM "Producto" as pr
    JOIN "Imagen" as i ON i."fk_producto" = pr."pro_codigo"
    JOIN "Presentacion" as pre ON pre."fk_producto" = pr."pro_codigo"
    JOIN "Botella" as b ON b."bot_id" = pre."fk_material_botella_3"
    JOIN "Inventario_Virtual_Presentacion" as inv ON  "fk_presentacion" = "pre_id"
    LEFT JOIN "Producto_Sabor" AS ps ON ps."fk_producto" = pr."pro_codigo"
    LEFT JOIN "Producto_Color" AS pc ON pc."fk_producto" = pr."pro_codigo"
    LEFT JOIN "Producto_Materia" AS pm ON pm."fk_producto" = pr."pro_codigo"
    WHERE pr."pro_codigo" = id
    GROUP BY 
        pr.pro_codigo, 
        pr.pro_nombre, 
        pr.pro_grados_alcohol, 
        pr.pro_descripcion, 
        pr.pro_tipo, 
        pr.fk_lugar, 
        pr.fk_categoria, 
        pr.fk_variedad,
		pr."fk_añejamiento",
		pr.fk_lugar,
		pr.fk_proveedor,
        pre.pre_id,
        i.ima_url,
        inv.inv_vir_precio;
END;
$BODY$;
---

CREATE OR REPLACE FUNCTION revision_inventario_virtual()
RETURNS TRIGGER AS $$
DECLARE
    retirado NUMERIC(10, 0);
    cantidad NUMERIC(10, 0);
    codigo INT;
    presentaciones INT[];
BEGIN

    SELECT ARRAY_AGG("fk_presentacion") INTO presentaciones
    FROM "Detalle_Venta_Virtual_Presentacion"
    WHERE "fk_venta_virtual" = NEW."fk_venta_virtual";

    FOR i IN 1..COALESCE(array_length(presentaciones, 1), 0) LOOP
        RAISE NOTICE 'Valor de fk_presentacion: %', presentaciones[i];
        retirado := buscar_pedido(NEW."fk_venta_virtual", presentaciones[i]);
        cantidad := buscar_cantidad(presentaciones[i]);

        IF (cantidad - retirado) < 100 THEN
            CALL crear_orden_reposicion(1, presentaciones[i]);
        END IF;

        CALL actualizar_inventario_virtual(presentaciones[i], retirado, 0);
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER "revision_inventario_virtual"
AFTER INSERT ON "Pago_Metodo_Pago"
FOR EACH ROW
EXECUTE FUNCTION "revision_inventario_virtual"();



CREATE OR REPLACE PROCEDURE crear_orden_reposicion( identificacion INT, presentacion INT)
AS $$
	DECLARE 
		fecha timestamp;
		codigo INT;
BEGIN
	fecha := CURRENT_TIMESTAMP;
	INSERT INTO "Compra"(com_fecha, com_total, fk_fisica, fk_virtual)
	VALUES( fecha, 10.000, NULL, identificacion );
	
	SELECT MAX("com_id") INTO codigo FROM "Compra";
	CALL detalle_orden_reposicion( codigo, presentacion );
	
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE detalle_orden_reposicion( compra INT, presentacion INT )
AS $$
BEGIN
	INSERT INTO "Compra_Presentacion"
	(
		com_pre_cantidad, 
		com_pre_precio_unitario, 
		fk_compra, 
		fk_presentacion
	)
	VALUES( 1000, 10, compra,  presentacion);
	
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "actualizacion_estatus_venta"()
RETURNS TRIGGER 
AS $$
BEGIN
	
	UPDATE "Venta_Virtual_Estatus"
	SET "fk_estatus" = 7
	WHERE "fk_venta_virtual" = NEW."fk_venta_virtual";
		
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER "actualizacion_estatus_venta"
AFTER INSERT ON "Pago_Metodo_Pago"
FOR EACH ROW
EXECUTE FUNCTION "actualizacion_estatus_venta"();



CREATE OR REPLACE FUNCTION "buscar_cantidad"( codigo INT )
RETURNS NUMERIC
AS $$
	DECLARE 
		cantidad NUMERIC(10,0);
BEGIN

	SELECT "inv_vir_pre_cantidad" INTO cantidad
	FROM "Inventario_Virtual_Presentacion"
	WHERE "fk_presentacion" = codigo;

	RETURN cantidad;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "buscar_pedido"( codigo INT, codigo_presentacion INT  )
RETURNS NUMERIC
AS $$
	DECLARE 
		cantidad NUMERIC(10,0);
BEGIN

	SELECT "det_ven_vir_pre_cantidad" INTO cantidad
	FROM "Detalle_Venta_Virtual_Presentacion"
	WHERE "fk_venta_virtual" = codigo 
		AND "fk_presentacion" = codigo_presentacion;

	RETURN cantidad;

END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE "crear_orden"
( 
	codigo INT, 
	identificacion VARCHAR, 
	presentacion INT,
	cantidad INT
)
AS $$

	DECLARE 
		--aqui se guarda el codigo de venta registrada a un cliente
		Cjuridico INT;
		Cnatural INT;

BEGIN

	Cjuridico := buscar_cliente_juridico( identificacion );
	Cnatural := buscar_cliente_natural( codigo, identificacion );
	
	IF Cnatural = 0 AND Cjuridico = 0 THEN
		CALL crear_venta_virtual( codigo, identificacion );
	END IF;
	
	Cjuridico := buscar_cliente_juridico( identificacion );
	Cnatural := buscar_cliente_natural( codigo, identificacion );
	
	IF Cnatural != 0 THEN 
		CALL crear_pedido( Cnatural, presentacion, cantidad );
	END IF;
	
	IF Cjuridico != 0 THEN 
		CALL crear_pedido( Cjuridico, presentacion, cantidad );
	END IF;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE crear_pedido(codigo INT, presentacion INT, cantidad INT)
AS $$
DECLARE
    precio NUMERIC(12, 3);
BEGIN
    precio := buscar_precio(presentacion);

    -- Verificar si ya existe una fila con las mismas claves primarias
    PERFORM 1 FROM "Detalle_Venta_Virtual_Presentacion"
    WHERE fk_venta_virtual = codigo AND fk_presentacion = presentacion;

    IF FOUND THEN
        -- Si la fila existe, realizar una actualización
        UPDATE "Detalle_Venta_Virtual_Presentacion"
        SET det_ven_vir_pre_cantidad = cantidad
        WHERE fk_venta_virtual = codigo AND fk_presentacion = presentacion;
    ELSE
        -- Si la fila no existe, realizar una inserción
        INSERT INTO "Detalle_Venta_Virtual_Presentacion" (
            det_ven_vir_pre_cantidad,
            det_ven_vir_pre_precio_venta,
            fk_venta_virtual,
            fk_presentacion
        )
        VALUES (
            cantidad,
            precio,
            codigo,
            presentacion
        );
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "actualizar_compra_estatus"()
RETURNS TRIGGER
AS $$
	DECLARE 
		codigo INT;
		fecha TIMESTAMP;
BEGIN

	fecha := CURRENT_TIMESTAMP;
	SELECT MAX("com_id") INTO codigo FROM "Compra";

	INSERT INTO "Compra_Estatus"("com_est_fecha_ini", "com_estfecha_fin", "fk_compra", "fk_estatus")
	VALUES( fecha, NULL, codigo, 5);

	RETURN NEW;

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER "actualizar_compra_estatus"
AFTER INSERT ON "Compra"
FOR EACH ROW
EXECUTE FUNCTION "actualizar_compra_estatus"();


CREATE OR REPLACE FUNCTION public.actualizar_ordenes_compra(
	codigo_orden character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare aux int;
        codigo int;
begin 
SELECT com_est_id into aux
	FROM public."Compra_Estatus"
	where fk_compra=cast(codigo_orden as int ) and fk_estatus=7;
	if aux is null then
    UPDATE public."Compra_Estatus"
	SET  com_estfecha_fin= cast(substring(cast(current_timestamp at time zone 'VET' as varchar) from 1 for 10) as timestamp)
	WHERE fk_compra=cast(codigo_orden as int) and fk_estatus=5;
	INSERT INTO public."Compra_Estatus"(
	com_est_fecha_ini, com_estfecha_fin, fk_compra, fk_estatus)
	VALUES (cast(substring(cast(current_timestamp at time zone 'VET' as varchar) from 1 for 10) as timestamp), null,cast(codigo_orden as int ) ,7);
	end if;

    SELECT "pre_id" INTO codigo
    FROM "Compra_Presentacion"
    WHERE "fk_compra" = codigo_orden;

    CALL actualizar_inventario_virtual(codigo, 0, 1000);

end;
$BODY$;
--Nuevo de andi
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
---nuevo gaby
CREATE OR REPLACE FUNCTION public.venta_punto(
	)
    RETURNS TABLE(venta_f integer, codigo integer, cantidad_cangeada numeric, tipo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin

return query 	
   SELECT  fk_venta_fisica as venta , fk_mi_punto as punto, monto_parcial as monto, 'Venta_Fisica' as tipo
	FROM public."Pago_Metodo_Pago"
	group by fk_venta_fisica,fk_mi_punto, monto_parcial
	having  fk_mi_punto is not null
	union
	SELECT  fk_venta_fisica_entrada as venta, "fk_mi_punto" as punto,"pag_ent_met_pag_Monto_parcial" as monto,'Venta_Entrada' as tipo
	FROM public."Pago_Entrada_Metodo_Pago"
	group by fk_venta_fisica_entrada,
    "fk_mi_punto","pag_ent_met_pag_Monto_parcial"
	 having "fk_mi_punto" is not null ;
	
end;
$BODY$;

CREATE OR REPLACE FUNCTION public."calcular_añejamiento"(
	"id_añe" integer)
    RETURNS character varying[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare aux int;
declare aux2 varchar;
declare años_array varchar[];
begin
aux:=0;
aux2:=0;
	while aux is not null loop
 		select split_part(cast((SELECT distinct (añe_fecha_final - añe_fecha_ini)/365  AS dias_diferencia
			FROM "Añejamiento" where  id_añe=añe_id) as varchar), 'days', 1) into aux2;
			 RAISE NOTICE 'Valor de la variable aux1 es %', aux;
			select into años_array array_append(años_array, aux2 );
  select fk_añejamiento into aux from "Añejamiento" 
  where  id_añe=añe_id;
 	id_añe=aux;
 end loop;
	return años_array;
end;
$BODY$;

CREATE OR REPLACE FUNCTION public.cumplimiento_horario(
	fecha_i date,
	fecha_f date)
    RETURNS TABLE(cedula character varying, dia character varying, hora_llegada time without time zone, hora_entrada timestamp without time zone, hora_retiro time without time zone, hora_salida timestamp without time zone, cumplimiento text, nombre text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
return query SELECT "Empleado_Horario".fk_empleado_2,
    "Horario".hor_dia,
    "Empleado_Horario".hora_ent,
    "Horario".hor_hora_entrada,
    "Empleado_Horario".hora_sal,
    "Horario".hor_hora_salida,
    'Horario Cumplido'::text AS "?column?",
    ("Empleado".per_nat_p_nombre::text || ' '::text) || "Empleado".per_nat_p_apellido::text AS nombre_completo
   FROM "Empleado_Horario",
    "Horario",
    "Empleado"
  WHERE "Empleado_Horario".fecha >= fecha_i::date AND "Empleado_Horario".fecha <= fecha_f::date AND "Empleado_Horario".fk_horario = "Horario".hor_id AND "Empleado_Horario".hora_ent <= "Horario".hor_hora_entrada::time without time zone AND "Empleado_Horario".hora_sal >= "Horario".hor_hora_salida::time without time zone AND "Empleado".per_nat_ci::text = "Empleado_Horario".fk_empleado_2::text
UNION
 SELECT DISTINCT "Empleado_Horario".fk_empleado_2,
    "Horario".hor_dia,
    "Empleado_Horario".hora_ent,
    "Horario".hor_hora_entrada,
    "Empleado_Horario".hora_sal,
    "Horario".hor_hora_salida,
    'Horario Incumplido'::text,
    ("Empleado".per_nat_p_nombre::text || ' '::text) || "Empleado".per_nat_p_apellido::text AS nombre_completo
   FROM "Empleado_Horario",
    "Horario",
    "Empleado"
  WHERE "Empleado_Horario".fecha >= fecha_i::date AND "Empleado_Horario".fecha <= fecha_f::date AND "Empleado_Horario".fk_horario = "Horario".hor_id AND NOT ("Empleado_Horario".emp_hor_id IN ( SELECT "Empleado_Horario_1".emp_hor_id
           FROM "Empleado_Horario" "Empleado_Horario_1",
            "Horario" "Horario_1"
          WHERE "Empleado_Horario_1".fecha >= fecha_i::date AND "Empleado_Horario_1".fecha <= fecha_f::date AND "Empleado_Horario_1".fk_horario = "Horario_1".hor_id AND "Empleado_Horario_1".hora_ent <= "Horario_1".hor_hora_entrada::time without time zone AND "Empleado_Horario_1".hora_sal >= "Horario_1".hor_hora_salida::time without time zone)) AND "Empleado".per_nat_ci::text = "Empleado_Horario".fk_empleado_2::text;
end;
$BODY$;
CREATE OR REPLACE FUNCTION public.ficha(
	codigo_pro integer,
	codigo_pres integer)
    RETURNS TABLE(codigo integer, nombre character varying, grados_alcohol numeric, descripcion character varying, tipo character varying, categoria character varying, variedad character varying, "añejamiento" integer, lugar integer, proveedor character varying, materia_pri character varying[], codigo_presentacion integer, url character varying, nota character varying, elaboracion character varying, empaque_ind character varying, caja_grande_desc character varying, caja_grande_cap numeric, paleta_cap numeric, peso numeric, nombre_botella character varying, altura numeric, ancho numeric, capacidad numeric, tapa character varying, direccion_f text, barril character varying, destilacion character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
 return query SELECT pro_codigo, pro_nombre, pro_grados_alcohol, pro_descripcion, pro_tipo, cat_nombre, 
var_nombre, "fk_añejamiento", fk_lugar, fk_proveedor, materia_prima, pre_id, ima_url, not_cat_descripcion,
"añe_descripcion", caja_individual, caja_grande, cg_capacidad, paleta_capacidad, mat_bot_peso,
bot_nombre, bot_altura, bot_ancho, bot_capacidad, tap_descripcion, direccion, bar_descripcion, 
des_descripcion
	FROM public.ficha
	where pro_codigo=codigo_pro and pre_id=codigo_pres ;
end;
$BODY$;
CREATE OR REPLACE FUNCTION public.insertar_horario(
	fecha date,
	hora_e time without time zone,
	hora_sal time without time zone,
	cedula character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare codigo int;
declare aux int;
declare codigo_horario int[];
DECLARE i integer = 0;

begin

select fk_empleado into codigo from "Empleado_Horario" where  fk_empleado_2=cedula;
select fk_horario  into aux from "Empleado_Horario","Horario" where  fk_empleado_2=cedula and fk_empleado=codigo and hor_id=fk_horario and hor_dia='Lunes';
select into codigo_horario array_append(codigo_horario,aux);
select fk_horario  into aux from "Empleado_Horario","Horario" where  fk_empleado_2=cedula  and hor_id=fk_horario and hor_dia='Martes';
select into codigo_horario array_append(codigo_horario,aux);
select fk_horario  into aux from "Empleado_Horario","Horario" where  fk_empleado_2=cedula  and hor_id=fk_horario and hor_dia='Miercoles';
select into codigo_horario array_append(codigo_horario,aux);
select fk_horario  into aux from "Empleado_Horario","Horario" where  fk_empleado_2=cedula and hor_id=fk_horario and hor_dia='Jueves';
select into codigo_horario array_append(codigo_horario,aux);
select fk_horario  into aux from "Empleado_Horario","Horario" where  fk_empleado_2=cedula and  hor_id=fk_horario and hor_dia='Viernes';
select into codigo_horario array_append(codigo_horario,aux);
select fk_horario  into aux from "Empleado_Horario","Horario" where  fk_empleado_2=cedula and  hor_id=fk_horario and hor_dia='Sabado';
select into codigo_horario array_append(codigo_horario,aux);
select fk_horario  into aux from "Empleado_Horario","Horario" where  fk_empleado_2=cedula and hor_id=fk_horario and hor_dia='Domingo';
select into codigo_horario array_append(codigo_horario,aux);

FOR i IN 1..7
	LOOP
		if date_part('dow',cast(fecha as date))=i and codigo_horario[i] is not null then
	INSERT INTO public."Empleado_Horario"(
	fk_empleado, fk_empleado_2, fk_horario, fecha, hora_ent, hora_sal)
	VALUES (codigo, cedula, codigo_horario[i], fecha, hora_e, hora_sal);
end if;
	END LOOP;

end;
$BODY$;
--nuevo juan
CREATE OR REPLACE FUNCTION detalles_inventario_fisico(dato TEXT)
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
		SELECT "pre_id", "pre_nombre", "ven_fis_est_fecha_fin", "det_ven_fis_pre_cantidad"
		FROM "Venta_Fisica" AS venta
		JOIN "Detalle_Venta_Fisica_Presentacion" AS detalle ON detalle."fk_venta_fisica" = venta."ven_fis_id"
		JOIN "Presentacion" AS pre ON pre."pre_id" = detalle."fk_presentacion"
		JOIN "Venta_Fisica_Estatus" AS estatus ON estatus."fk_venta_fisica" = venta."ven_fis_id"
		WHERE estatus."fk_estatus" = 7
			AND EXTRACT(MONTH FROM CAST(estatus."ven_fis_est_fecha_fin" AS timestamp)) = mes;
	
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION detalles_inventario_fisico_evento(dato TEXT)
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
		SELECT "pre_id", "pre_nombre", "ven_fis_est_fecha_fin", "det_ven_fis_pre_eve_cantidad"
		FROM "Venta_Fisica" AS venta
		JOIN "Detalle_Venta_Fisica_Presentacion_Evento" AS detalle ON detalle."fk_venta_fisica" = venta."ven_fis_id"
		JOIN "Presentacion" AS pre ON pre."pre_id" = detalle."fk_presentacion_evento_1"
		JOIN "Venta_Fisica_Estatus" AS estatus ON estatus."fk_venta_fisica" = venta."ven_fis_id"
		WHERE estatus."fk_estatus" = 7
			AND EXTRACT(MONTH FROM CAST(estatus."ven_fis_est_fecha_fin" AS timestamp)) = mes;
	
END;
$$ LANGUAGE plpgsql;

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




---------------------------VISTA FICHA---------------------------------------------

CREATE OR REPLACE VIEW public.ficha
 AS
 SELECT pr.pro_codigo,
    pr.pro_nombre,
    pr.pro_grados_alcohol,
    pr.pro_descripcion,
    pr.pro_tipo,
    c.cat_nombre,
    v.var_nombre,
    pr."fk_añejamiento",
    pr.fk_lugar,
    pr.fk_proveedor,
    array_agg(DISTINCT mat.mat_nombre) AS materia_prima,
    pre.pre_id,
    i.ima_url,
    nc.not_cat_descripcion,
    a."añe_descripcion",
    ci.caj_descripcion AS caja_individual,
    cg.caj_descripcion AS caja_grande,
    cg.caj_capacidad AS cg_capacidad,
    paleta.caj_capacidad AS paleta_capacidad,
    mb.mat_bot_peso,
    b.bot_nombre,
    b.bot_altura,
    b.bot_ancho,
    b.bot_capacidad,
    t.tap_descripcion,
    (((e.lug_nombre::text || '-'::text) || m.lug_nombre::text) || '-'::text) || p.lug_nombre::text AS direccion,
    bar.bar_descripcion,
    des.des_descripcion
   FROM "Producto" pr
     JOIN "Imagen" i ON i.fk_producto = pr.pro_codigo
     JOIN "Categoria" c ON pr.fk_categoria = c.cat_id
     JOIN "Variedad" v ON pr.fk_variedad = v.var_id
     JOIN "Añejamiento" a ON a."añe_id" = pr."fk_añejamiento"
     JOIN "Barril" bar ON bar.bar_id = a.fk_barril
     JOIN "Presentacion" pre ON pre.fk_producto = pr.pro_codigo
     JOIN "Caja" ci ON ci.caj_id = pre.fk_caja
     JOIN "Caja" cg ON cg.caj_id = ci.fk_caja
     JOIN "Caja" paleta ON paleta.caj_id = cg.fk_caja
     JOIN "Material_Botella" mb ON pre.fk_material_botella_1 = mb.mat_bot_id AND pre.fk_material_botella_2 = mb.fk_material AND pre.fk_material_botella_3 = mb.fk_botella
     LEFT JOIN "Nota_Cata" nc ON nc.fk_presentacion_evento_2 = pre.pre_id
     JOIN "Botella" b ON b.bot_id = pre.fk_material_botella_3
     JOIN "Tapa" t ON t.tap_id = pre.fk_material_tapa_3
     LEFT JOIN "Producto_Sabor" ps ON ps.fk_producto = pr.pro_codigo
     LEFT JOIN "Producto_Color" pc ON pc.fk_producto = pr.pro_codigo
     LEFT JOIN "Producto_Materia" pm ON pm.fk_producto = pr.pro_codigo
     JOIN "Materia" mat ON mat.mat_id = pm.fk_materia
     JOIN "Lugar" p ON pr.fk_lugar = p.lug_id
     JOIN "Lugar" m ON p.fk_lugar = m.lug_id
     JOIN "Lugar" e ON m.fk_lugar = e.lug_id
     JOIN "Destilacion" des ON des."des_Id" = a.fk_destilacion
  GROUP BY pr.pro_codigo, pr.pro_nombre, pr.pro_grados_alcohol, 
  pr.pro_descripcion, pr.pro_tipo, pr.fk_categoria, pr.fk_variedad, pr."fk_añejamiento",
  pr.fk_lugar, pr.fk_proveedor, pre.pre_id, i.ima_url, a."añe_descripcion", ci.caj_descripcion,
  cg.caj_descripcion, cg.caj_capacidad, paleta.caj_capacidad, mb.mat_bot_peso, b.bot_nombre, 
  b.bot_altura, b.bot_ancho, b.bot_capacidad, t.tap_descripcion, c.cat_nombre, v.var_nombre, 
  ((((e.lug_nombre::text || '-'::text) || m.lug_nombre::text) || '-'::text) || p.lug_nombre::text),
  bar.bar_descripcion, des.des_descripcion, nc.not_cat_descripcion;
