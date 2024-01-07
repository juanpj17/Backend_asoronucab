import { pool } from '../models/server.js';
import { response, request } from 'express';


const ventaFGet = async(req = request, res = response) => {
    try {
        // const juridico = await pool.query('SELECT * FROM public.seleccionar_todos_cliente()');
        const natural = await pool.query('SELECT * FROM public.seleccionar_todos_clientes()');
        res.json(natural.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

const ventaFPost = (req, res = response) => {

    const { nombre, edad } = req.body;

    res.json({
        msg: 'Mensaje: metodo post recibido - controlador',
        nombre,
        edad
    });
}

const ventaFPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const ventaFDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

const ventaFInsertar = async(req, res = response) => {
    const vacio = null;
    try {
        const { total,
                cod_cliente_natural_1,
                cod_empleado_1, 
                cod_empleado_2,
                cod_cliente_juridico,
                cod_estatus,
                cod_inventario_1,
                cod_inventario_2,
                cod_inventario_3 } = req.body;
                if(cod_cliente_natural_1 == null){
                    const result = await pool.query(
                        'SELECT agregar_venta_fisica($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)',
                        [   total,
                            vacio, 
                            cod_cliente_natural_1,
                            cod_empleado_1, 
                            cod_empleado_2,
                            cod_cliente_juridico,
                            cod_estatus,
                            cod_inventario_1,
                            cod_inventario_2,
                            cod_inventario_3    ]
                      );
                      
                    res.json(result.rows[0]);
                }else{
                    const idCliente = await buscarIdClienteNPorCedula(cod_cliente_natural_1)
                    const result = await pool.query(
                        'SELECT agregar_venta_fisica($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)',
                        [   total,
                            idCliente, 
                            cod_cliente_natural_1,
                            cod_empleado_1, 
                            cod_empleado_2,
                            cod_cliente_juridico,
                            cod_estatus,
                            cod_inventario_1,
                            cod_inventario_2,
                            cod_inventario_3    ]
                    );
              
                    res.json(result.rows[0]);

                }
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const buscarIdClienteNPorCedula = async (cedula) => {
    try {
      const result = await pool.query('SELECT per_nat_id FROM public."Cliente_Natural" WHERE per_nat_ci = $1', [cedula]);
      if (result.rows.length > 0) {
        return result.rows[0].per_nat_id;
      } else {
        throw new Error('ClienteN no encontrado');
      }
    } catch (error) {
      console.error('Error al buscar el ID del clienteN:', error);
      throw new Error('Error interno del servidor');
    }
  };

const tarjetaObtener = async(req, res = response) => {
    try {
        const { cod_cliente_natural_2 } = req.body;
                const idCliente = await buscarIdClienteNPorCedula(cod_cliente_natural_2)
        const result = await pool.query(
            'SELECT * from obtener_tarjetas_natural($1, $2)',
            [   idCliente,
                cod_cliente_natural_2   ]
          );

        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const tarjetaObtenerJ = async(req, res = response) => {
    try {
        const { cod_cliente } = req.body;
        const result = await pool.query(
            'SELECT * from obtener_tarjetas_juridico($1)',
            [   cod_cliente  ]
          );

        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const actualizarPuntos = async(req = request, res = response) => {
    try {
        const { codC , puntos_a_restar } = req.body;
        const idCliente = await buscarIdClienteNPorCedula(codC)
        const punto = await pool.query('SELECT * FROM restar_puntos_cliente_natural($1, $2, $3)', [idCliente, codC, puntos_a_restar]);
        res.json(punto.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};


const actualizarPuntosJ = async(req = request, res = response) => {
    try {
        const { codC , puntos_a_restar } = req.body;
        const punto = await pool.query('SELECT * FROM restar_puntos_cliente_juridico($1, $2)', [codC, puntos_a_restar]);
        res.json(punto.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};



const ocultarNumeros = async(req, res = response) => {
    try {
        const { num } = req.body;
        const result = await pool.query(
            'SELECT * from ocultar_numeros($1)',
            [   num  ]
          );

        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}



const entradaInserta = async(req, res = response) => {
    const vacio = null;
    try {
        const { total,
                cod_cliente_natural_2, 
                cod_cliente_juridico,
                fk_fisica} = req.body;
                console.log('entradas fisica')
                console.log(req.body)
                if(cod_cliente_natural_2 == null){
                    const result = await pool.query(
                        'SELECT insertar_venta_fisica_entrada($1, $2, $3, $4, $5)',
                        [   total,
                            vacio,
                            cod_cliente_natural_2, 
                            cod_cliente_juridico,
                            fk_fisica ]
                      );
                      res.json(result.rows[0]);
                }else{
                    const idCliente = await buscarIdClienteNPorCedula(cod_cliente_natural_2)
                    const result = await pool.query(
                        'SELECT insertar_venta_fisica_entrada($1, $2, $3, $4, $5)',
                        [   total,
                            idCliente,
                            cod_cliente_natural_2, 
                            cod_cliente_juridico,
                            fk_fisica ]
                    );
                    
                    res.json(result.rows[0]);
                }
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}


export{
    ventaFGet,
    ventaFPost,
    ventaFPut,
    ventaFDelete,
    ventaFInsertar,
    entradaInserta,
    tarjetaObtener,
    ocultarNumeros,
    actualizarPuntos,
    tarjetaObtenerJ,
    actualizarPuntosJ

}