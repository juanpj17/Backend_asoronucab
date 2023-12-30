import { pool } from '../models/server.js';
import { response, request } from 'express';

const parroquiaGet = async(req = request, res = response) => {
    try {
        const parroquia = await pool.query('SELECT "lug_nombre", "lug_id" FROM "Lugar" WHERE "lug_tipo"=\'parroquia\'');
        res.json(parroquia.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

const parroquiaPost = (req, res = response) => {

    const { nombre, edad } = req.body;

    res.json({
        msg: 'Mensaje: metodo post recibido - controlador',
        nombre,
        edad
    });
}

const parroquiaPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const parroquiaDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

export{
    parroquiaGet,
    parroquiaPost,
    parroquiaPut,
    parroquiaDelete
}