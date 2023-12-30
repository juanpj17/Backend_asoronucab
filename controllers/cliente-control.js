import { pool } from '../models/server.js';
import { response, request } from 'express';

const clienteGet = async(req = request, res = response) => {
    try {
        const cliente = await pool.query('SELECT * FROM public.seleccionar_todos_cliente_natural()');
        res.json(cliente.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

const clientePost = (req, res = response) => {

    const { nombre, edad } = req.body;

    res.json({
        msg: 'Mensaje: metodo post recibido - controlador',
        nombre,
        edad
    });
}

const clientePut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const clienteDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}


const clienteGetN = async(req = request, res = response) => {
    try {
        const cliente = await pool.query('SELECT * FROM public.seleccionar_todos_cliente_natural()');
        res.json(cliente.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

const clientePostN = async (req, res = response) => {
    try {
        const { ced, rif, p_nombre, s_nombre, p_apellido, s_apellido, direccion, parroquia} = req.body;
        
        const result = await pool.query(
            'SELECT public.registro_cliente_natural($1, $2, $3, $4, $5, $6, $7, $8)',
            [ced, rif, p_nombre, s_nombre, p_apellido, s_apellido, direccion, parroquia]
          );
          


        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
};
}

const clientePutN = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const clienteDeleteN = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}



export{
    clienteGet,
    clientePost,
    clientePut,
    clienteDelete,
    clienteGetN,
    clientePostN,
    clientePutN,
    clienteDeleteN,
}