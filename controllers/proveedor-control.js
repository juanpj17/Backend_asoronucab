
import { pool } from '../models/server.js';
import { response, request } from 'express';

const proveedorGet = async(req = request, res = response) => {
    try {
        const evento = await pool.query('SELECT * FROM seleccionar_proveedores()');
        res.json(evento.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};



const  proveedorPost = async (req = request, res = response) => {
    try {
        const evento = await pool.query('SELECT * FROM seleccionar_proveedores()');
        res.json(evento.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


const  proveedorPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const proveedorDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

export{
     proveedorGet,
     proveedorPost,
     proveedorPut,
     proveedorDelete
}