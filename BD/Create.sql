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
    PRIMARY KEY("det_ven_fis_pre_id", "fk_venta_fisica", "fk_presentacion"),
    CONSTRAINT "fk_venta_fisica" FOREIGN KEY ("fk_venta_fisica")
    REFERENCES "Venta_Fisica" ("ven_fis_id") ON DELETE CASCADE,
    CONSTRAINT "fk_presentacion" FOREIGN KEY ("fk_presentacion")
    REFERENCES "Presentacion" ("pre_id") ON DELETE CASCADE
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
    PRIMARY KEY("det_ven_fis_pre_eve_id", "fk_venta_fisica", "fk_presentacion_evento", "fk_presentacion_evento_1", "fk_presentacion_evento_2"),
    CONSTRAINT "fk_venta_fisica" FOREIGN KEY ("fk_venta_fisica")
    REFERENCES "Venta_Fisica" ("ven_fis_id") ON DELETE CASCADE,
    CONSTRAINT "fk_presentacion_evento" FOREIGN KEY ("fk_presentacion_evento", "fk_presentacion_evento_1", "fk_presentacion_evento_2")
    REFERENCES "Presentacion_Evento" ("pre_eve_id","fk_presentacion", "fk_evento" ) ON DELETE CASCADE
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
    "fk_tarjeta" INT,
    "fk_cheque" INT,
    "fk_efectivo" INT,
    "fk_mi_punto" INT,
    PRIMARY KEY ("pa_af_me_pa_id", "fk_pago_afiliacion_cuota", "fk_tarjeta", "fk_cheque", "fk_efectivo", "fk_mi_punto"),
    CONSTRAINT "fk_pago_afiliacion_cuota" FOREIGN KEY ("fk_pago_afiliacion_cuota")
    REFERENCES "Pago_Afiliacion_Cuota" ("pa_af_cuo_id") ON DELETE CASCADE,
    CONSTRAINT "fk_tarjeta" FOREIGN KEY ("fk_tarjeta")
    REFERENCES "Tarjeta" ("met_pag_id") ON DELETE CASCADE,
    CONSTRAINT "fk_cheque" FOREIGN KEY ("fk_cheque")
    REFERENCES "Cheque" ("met_pag_id") ON DELETE CASCADE,
    CONSTRAINT "fk_efectivo" FOREIGN KEY ("fk_efectivo")
    REFERENCES "Efectivo" ("met_pag_id") ON DELETE CASCADE,
    CONSTRAINT "fk_mi_punto" FOREIGN KEY ("fk_mi_punto")
    REFERENCES "Mi_Punto" ("met_pag_id") ON DELETE CASCADE  
);

CREATE TABLE IF NOT EXISTS "Pago_Entrada_Metodo_Pago" (
    "pag_ent_met_pag_id" SERIAL,
    "pag_ent_met_pag_Monto_parcial" NUMERIC(12, 3) NOT NULL CHECK ("pag_ent_met_pag_Monto_parcial" > 0),
    "fk_entrada" INT,
    "fk_efectivo" INT,
    "fk_cheque" INT,
    "fk_tarjeta" INT,
    "fk_mi_punto" INT,
     PRIMARY KEY ("pag_ent_met_pag_id", "fk_entrada", "fk_efectivo", "fk_cheque", "fk_tarjeta", "fk_mi_punto"),
    CONSTRAINT "fk_entrada" FOREIGN KEY ("fk_entrada")
    REFERENCES "Entrada" ("ent_id") ON DELETE CASCADE,
    CONSTRAINT "fk_efectivo" FOREIGN KEY ("fk_efectivo")
    REFERENCES "Efectivo" ("met_pag_id") ON DELETE CASCADE,
    CONSTRAINT "fk_cheque" FOREIGN KEY ("fk_cheque")
    REFERENCES "Cheque" ("met_pag_id") ON DELETE CASCADE,
    CONSTRAINT "fk_tarjeta" FOREIGN KEY ("fk_tarjeta")
    REFERENCES "Tarjeta" ("met_pag_id") ON DELETE CASCADE,
    CONSTRAINT "fk_mi_punto" FOREIGN KEY ("fk_mi_punto")
    REFERENCES "Mi_Punto" ("met_pag_id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Pago_Metodo_Pago" (
    "pag_met_pag_id" SERIAL,
    "monto_parcial" NUMERIC NOT NULL CHECK ("monto_parcial" > 0),
    "fk_efectivo" INT,
    "fk_cheque" INT,
    "fk_tarjeta" INT,
    "fk_mi_punto" INT,
    PRIMARY KEY ("pag_met_pag_id", "fk_efectivo", "fk_cheque", "fk_tarjeta", "fk_mi_punto"),
    CONSTRAINT "fk_efectivo" FOREIGN KEY ("fk_efectivo")
    REFERENCES "Efectivo" ("met_pag_id") ON DELETE CASCADE,
    CONSTRAINT "fk_cheque" FOREIGN KEY ("fk_cheque")
    REFERENCES "Cheque" ("met_pag_id") ON DELETE CASCADE,
    CONSTRAINT "fk_tarjeta" FOREIGN KEY ("fk_tarjeta")
    REFERENCES "Tarjeta" ("met_pag_id") ON DELETE CASCADE,
    CONSTRAINT "fk_mi_punto" FOREIGN KEY ("fk_mi_punto")
    REFERENCES "Mi_Punto" ("met_pag_id") ON DELETE CASCADE
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
CREATE OR REPLACE PROCEDURE "agregar_empleado"
(
	"ced" VARCHAR, "rif" VARCHAR, "p_nombre" VARCHAR,
	"s_nombre" VARCHAR, "p_apellido" VARCHAR, 
	"s_apellido" VARCHAR, "direccion" VARCHAR, 
	"sueldo" NUMERIC(10,0), "fecha_ing" TIMESTAMP,
	"parroquia" INT, "contraseña" VARCHAR,
	"rol" INT
) 
AS $$
DECLARE 
	mens_1 VARCHAR;
	cod1_empleado INT;
	cod2_empleado VARCHAR;
BEGIN 
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

