import { pool } from '../models/server.js';
import { response, request } from 'express';

const userGet = async (req = request, res = response) => {
    try {
        const empleado = await pool.query('SELECT * FROM public.mostrar_empleados()');
        res.json(empleado.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const userPost = (req, res = response) => {

    const { nombre, edad } = req.body;

    res.json({
        msg: 'Mensaje: metodo post recibido - controlador',
        nombre,
        edad
    });
}

const userPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const userDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

export{
    userGet,
    userPost,
    userPut,
    userDelete
}