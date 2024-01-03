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

CREATE TABLE IF NOT EXISTS "Detalle_Fisica"(    
    "detallef_id" SERIAL,
    "detallef_cantidad" NUMERIC(10, 0) NOT NULL CHECK ("detallef_cantidad" > 0),
    "detallef_precio_venta" NUMERIC(10, 0) NOT NULL CHECK ("detallef_precio_venta" > 0),
    PRIMARY KEY("detallef_id")
);

CREATE TABLE IF NOT EXISTS "Detalle_Fisica_Evento"(
    "detalle_fis_eve_id" SERIAL,
    "detalle_cantidad" NUMERIC(10, 0) NOT NULL CHECK ("detalle_cantidad" > 0),
    "detalle_precio_venta" NUMERIC(10, 0) NOT NULL CHECK ("detalle_precio_venta" > 0),
    PRIMARY KEY("detalle_fis_eve_id")
);

CREATE TABLE IF NOT EXISTS "Destilacion" (
    "des_Id" SERIAL,
    "des_nombre" VARCHAR(48) NOT NULL,
    "des_descripcion" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("des_Id")
);

CREATE TABLE IF NOT EXISTS "Efectivo" (
    "met_pag_id" SERIAL,
    "ef_denominacion" VARCHAR(48) NOT NULL CHECK ("ef_denominacion" IN ('€','$', 'Bs.S')),
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
    "detallev_cantidad" NUMERIC(10, 0) NOT NULL CHECK ("detallev_cantidad" > 0),
    "detallev_precio_venta" NUMERIC(10, 0) NOT NULL CHECK ("detallev_precio_venta" > 0),
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
    "com_prod_id" SERIAL,
    "com_prod_cantidad" NUMERIC(10,0) NOT NULL CHECK ("com_prod_cantidad" > 0),
    "com_prod_precio_unitario" NUMERIC(10, 0) NOT NULL CHECK ("com_prod_precio_unitario" > 0),
    "fk_presentacion" INT,
    "fk_producto" INT,
    PRIMARY KEY("com_prod_id", "fk_presentacion", "fk_producto"),
    CONSTRAINT "fk_presentacion" FOREIGN KEY ("fk_presentacion")
    REFERENCES "Presentacion" ("pre_id") ON DELETE CASCADE,
    CONSTRAINT "fk_producto" FOREIGN KEY ("fk_producto")
    REFERENCES "Producto" ("pro_codigo") ON DELETE CASCADE
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

---------------------------------------------CRUDS DE LAS TABLAS------------------------------------------------------------
--EMPLEADO

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
    mens_ VARCHAR;
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

-- FUNCTION: public.insertar_cliente_juridico(character varying, character varying, character varying, character varying, character varying, character varying, integer)

-- DROP FUNCTION IF EXISTS public.insertar_cliente_juridico(character varying, character varying, character varying, character varying, character varying, character varying, integer);

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
					per_jur_rif, per_jur_denominacion_comercial, per_jur_razon_social, per_jur_pagina_web, per_jur_direccion_fiscal, per_jur_direccion_fisica, per_jur_capital)
					VALUES (rif, denominacion_comer , razon_soc , pagina_web, direccion_fiscal, direccion_fisica , capital);
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
            per_jur_pagina_web AS puntos_acumulados,
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



-----Insertar Producto
CREATE OR REPLACE FUNCTION public.registrar_producto(
	nombre character varying,
	descripcion character varying,
	gradosa numeric,
	tipo character varying,
	anejamiento integer,
	proveedor integer,
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

ALTER FUNCTION public.eliminar_producto(integer)
    OWNER TO postgres;


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

CREATE OR REPLACE FUNCTION obtener_cantidad_entrada(
    codigo int
)
RETURNS INT AS $$

BEGIN
    -- Obtener la suma de la cantidad de entradas para el código dado
    SELECT ent_precio
    FROM "Entrada"
    WHERE fk_evento = codigo;

    RETURN ent_precio;
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
