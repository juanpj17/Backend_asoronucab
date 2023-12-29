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

export{
    clienteGet,
    clientePost,
    clientePut,
    clienteDelete
}