import { pool } from '../models/server.js';
import { response, request } from 'express';

const tiendaFisicaGet = async(req = request, res = response) => {
   
    
};

const valorPuntoGet = async(req = request, res = response) => {
    try {

        const punto = await pool.query('SELECT * FROM obtener_ultimo_precio()');
        res.json(punto.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

const tiendaFisicaPost = async(req, res = response) => {

    try {
        const { cod_pro, cod_eve} = req.body;
        const result = await pool.query(
            'SELECT * FROM verificar_presentacion($1, $2)',
            [cod_pro, cod_eve]
          );
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
    };
    
}

const tiendaFisicaPresentacion = async(req, res = response) => {

    try {
        const { cod_pro } = req.body;
        const result = await pool.query(
            'SELECT * FROM verificar_presentacion_tienda($1)',
            [cod_pro]
          );
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
    };
    
}


const tiendaFisicaPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const tiendaFisicaDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

const traerNamePost = async(req, res = response) => {

    try {
        const { cod_pro} = req.body;
        console.log(req.body)
        const result = await pool.query(
            'SELECT presentacion_particular($1)',
            [cod_pro]
          );
          console.log(result)
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
    };
    
}

const tiendaFisicaSolaPost = async(req, res = response) => {

    try {
        const { cod_pro, cod_eve} = req.body;
        const result = await pool.query(
            'SELECT verificar_presentacion($1, $2)',
            [cod_pro, cod_eve]
          );
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
    };
    
}


const validarTipoCheque = async(req, res = response) => {

    try {
        const {param1, param2, param3} = req.body;
        const result = await pool.query('SELECT validar_tipos($1, $2, $3) as resultado', [param1, param2, param3]);
        res.json(result.rows);
    } catch (error) {
        console.error('Error al llamar a la función:', error);
        return false;
    }
}

const procesarPago = async(req, res = response) => {
 
    try {
        const { banco_cheque, 
                numero_cheque, 
                monto_parcial, 
                fk_venta_virtual, 
                fk_tarjeta,
                fk_efectivo,
                fk_mi_punto } = req.body;
        const result = await pool.query(
            'CALL procedimiento_insertar_pago($1, $2, $3, $4, $5, $6, $7)',
            [   banco_cheque, 
                numero_cheque, 
                monto_parcial, 
                fk_venta_virtual, 
                fk_tarjeta,
                fk_efectivo,
                fk_mi_punto ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const procesarPagoE = async(req, res = response) => {
 
    try {
        const { denominacion, 
                monto_parcial, 
                fk_venta_virtual, 
                fk_cheque,
                fk_tarjeta,
                fk_mi_punto } = req.body;

        const result = await pool.query(
            'CALL procedimiento_insertar_pago_efectivo($1, $2, $3, $4, $5, $6)',
            [   denominacion, 
                monto_parcial, 
                fk_venta_virtual, 
                fk_cheque,
                fk_tarjeta,
                fk_mi_punto ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const procesarPagoEntrada = async(req, res = response) => {

    try {
        const { denominacion, 
                monto_parcial, 
                tarjeta,
                cheque,
                mi_punto,
                fk_entrada,
                fk_venta_virtual } = req.body;

        const result = await pool.query(
            'CALL procedimiento_insertar_pago_efectivo_entrada($1, $2, $3, $4, $5, $6, $7)',
            [   denominacion, 
                monto_parcial, 
                tarjeta,
                cheque,
                mi_punto,
                fk_entrada,
                fk_venta_virtual ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}


const procesarPagoEntradaC = async(req, res = response) => {
    
    try {
        const { banco_cheque, 
                numero_cheque, 
                monto_parcial, 
                fk_tarjeta,
                fk_efectivo,
                fk_mi_punto,
                fk_entrada,
                fk_venta_virtual } = req.body; 
        const result = await pool.query(
            'CALL procedimiento_insertar_pago_entrada($1, $2, $3, $4, $5, $6, $7, $8)',
            [   banco_cheque, 
                numero_cheque, 
                monto_parcial, 
                fk_tarjeta,
                fk_efectivo,
                fk_mi_punto,
                fk_entrada,
                fk_venta_virtual ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }

}

const procesarPagoP = async(req, res = response) => {
 
    try {
        const { monto_parcial, 
                fk_venta_virtual, 
                fk_cheque,
                fk_efectivo,
                fk_tarjeta } = req.body;

        const result = await pool.query(
            'CALL procedimiento_insertar_pago_punto($1, $2, $3, $4, $5)',
            [   monto_parcial, 
                fk_venta_virtual, 
                fk_cheque,
                fk_efectivo,
                fk_tarjeta ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const procesarPagoEntradaP = async(req, res = response) => {
 
    
    try {
        const { monto_parcial, 
                tarjeta,
                fk_cheque,
                fk_efectivo,
                mi_punto,
                fk_entrada,
                fk_venta_virtual } = req.body;

        const result = await pool.query(
            'CALL procedimiento_insertar_pago_punto_entrada($1, $2, $3, $4, $5, $6, $7)',
            [   monto_parcial, 
                tarjeta,
                fk_cheque,
                fk_efectivo,
                mi_punto,
                fk_entrada,
                fk_venta_virtual ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}


const mostrarFactura = async(req, res = response) => {

    try {
        const {tipo} = req.body;
        const result = await pool.query('SELECT funcion_obtener_factura($1) as resultado', [tipo]);
        res.json(result.rows);
    } catch (error) {
        console.error('Error al llamar a la función:', error);
        return false;
    }
}
const validarTipoEfectivo = async(req, res = response) => {

    try {
        const {param1} = req.body;
        const result = await pool.query('SELECT validar_tipo_numeric($1) as resultado', [param1]);
        res.json(result.rows);
    } catch (error) {
        console.error('Error al llamar a la función:', error);
        return false;
    }
}

const actualizarEntrada = async(req, res = response) => {

    try {
        const { evento_id, cantidad_restar } = req.body;
        const result = await pool.query('SELECT actualizar_cantidad_entradas($1, $2) as resultado', [evento_id, cantidad_restar]);
        res.json(result.rows);
    } catch (error) {
        console.error('Error al llamar a la función:', error);
        return false;
    }
}

const procesarPagoT = async(req, res = response) => {
 
    try {
        const { monto_parcial, 
                fk_venta_virtual, 
                fk_efectivo,
                fk_cheque,
                fk_tarjeta,
                fk_mi_punto } = req.body;
            console.log(req.body)
        const result = await pool.query(
            'CALL procedimiento_insertar_pago_tarjeta($1, $2, $3, $4, $5, $6)',
            [   monto_parcial, 
                fk_venta_virtual, 
                fk_tarjeta,
                fk_efectivo,
                fk_cheque,
                fk_mi_punto  ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const procesarPagoEntradaT = async(req, res = response) => {
    
    try {
        const { monto_parcial, 
                tarjeta,
                cheque,
                efectivo,
                mi_punto,
                fk_entrada,
                fk_venta_virtual } = req.body;
            console.log(req.body)
        const result = await pool.query(
            'CALL procedimiento_insertar_pago_tarjeta_entrada($1, $2, $3, $4, $5, $6, $7)',
            [   monto_parcial, 
                tarjeta,
                cheque,
                efectivo,
                mi_punto,
                fk_entrada,
                fk_venta_virtual  ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}



const procesarDetalleE = async(req, res = response) => {
 
    try {
        const { cantidad, 
                precio, 
                codigo1,
                codigo2 } = req.body;
            console.log(req.body)
        const result = await pool.query(
            'CALL detalle_fisico_evento($1, $2, $3, $4)',
            [   cantidad, 
                precio, 
                codigo1,
                codigo2   ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const procesarDetalleT = async(req, res = response) => {
 
    try {
        const { cantidad, 
                precio, 
                presentacion } = req.body;
            console.log(req.body)
        const result = await pool.query(
            'CALL detalle_fisico_tienda($1, $2, $3)',
            [   cantidad, 
                precio, 
                presentacion   ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const detalleE = async(req, res = response) => {
 
    try {
        const { evento,
                cantidad_ent, 
                precio_unitario } = req.body;
            console.log(req.body)
        const result = await pool.query(
            'CALL regDetalleEntradaF($1, $2, $3)',
            [   evento,
                cantidad_ent, 
                precio_unitario  ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const actualizar = async(req, res = response) => {
 
    try {
        const { cantidad, 
                fk_evento,
                fk_presentacion } = req.body;
            console.log(req.body)
        const result = await pool.query(
            'CALL actualizar_venta_fisica_y_estatus($1, $2, $3)',
            [   cantidad, 
                fk_evento,
                fk_presentacion   ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const actualizarInventarioTienda = async(req, res = response) => {
 
    try {
        const { cantidad, 
                fk_presentacion } = req.body;
            console.log(req.body)
        const result = await pool.query(
            'CALL actualizar_venta_fisica_y_estatus_tienda($1, $2)',
            [   cantidad, 
                fk_presentacion   ]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const obtenerEntradas = async(req = request, res = response) => {
    try {
        const { codE } = req.body;
        const entrada = await pool.query('SELECT * FROM obtener_entradas_futuras($1)', [codE]);
        res.json(entrada.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};


export{
    tiendaFisicaGet,
    tiendaFisicaPost,
    tiendaFisicaPut,
    tiendaFisicaDelete,
    traerNamePost,
    tiendaFisicaSolaPost,
    valorPuntoGet,
    validarTipoCheque,
    validarTipoEfectivo,
    procesarPago,
    procesarPagoE,
    procesarPagoT,
    procesarDetalleE,
    actualizar,
    obtenerEntradas,
    detalleE,
    actualizarEntrada,
    procesarPagoP,
    procesarPagoEntradaC,
    procesarPagoEntrada,
    procesarPagoEntradaP,
    procesarPagoEntradaT,
    mostrarFactura,
    tiendaFisicaPresentacion,
    procesarDetalleT,
    actualizarInventarioTienda    
  
}