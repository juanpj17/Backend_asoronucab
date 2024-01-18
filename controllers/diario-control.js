import { pool } from '../models/server.js';
import { response, request } from 'express';

const ofertaPost = async (req = request, res = response) => {
    try {
        const { descuento, producto } = req.body;
        console.log('aca,', req.body)
        const result = await pool.query(
            'CALL agregarOferta($1, $2)',
            [descuento, producto]
          );
          


        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const ofertaGet = async (req = request, res = response) => {
    try {
        // const { descuento, producto } = req.body;
        // console.log('aca,', req.body)
        const result = await pool.query(
            'SELECT * FROM ofertas_vista'
          );
          


        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


export{ofertaPost, ofertaGet}