import { pool } from '../models/server.js';
import { response, request } from 'express';

const puntoGet = async (req = request, res = response) => {
    try {
        const punto = await pool.query('SELECT (public.obtener_historico_punto()).*');
        res.json(punto.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

export{
    puntoGet
}