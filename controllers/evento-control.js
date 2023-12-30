import { pool } from '../models/server.js';
import { response, request } from 'express';

const eventoGet = async(req = request, res = response) => {
    try {
        const evento = await pool.query('SELECT * FROM seleccionar_eventos()');
        res.json(evento.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

// const eventoPost = (req, res = response) => {

//     const { nombre, edad } = req.body;

//     res.json({
//         msg: 'Mensaje: metodo post recibido - controlador',
//         nombre,
//         edad
//     });
// }

const eventoPost = async (req = request, res = response) => {
    try {
        const { nombre, descripcion, num_entradas, fecha_hora_inicial, fecha_hora_final, direccion, parroquia } = req.body;

        // Realizar la inserción en la base de datos
        const result = await pool.query(
            'INSERT INTO public."Evento" (eve_nombre, eve_descripcion, eve_cantidad_entradas, eve_fecha_hora_inicial, eve_fecha_hora_final, eve_direccion, fk_lugar) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *',
            [nombre, descripcion, num_entradas, fecha_hora_inicial, fecha_hora_final, direccion, parroquia]
        );

        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


const eventoPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const eventoDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

export{
    eventoGet,
    eventoPost,
    eventoPut,
    eventoDelete
}