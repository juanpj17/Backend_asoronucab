import { pool } from '../models/server.js';
import { response, request } from 'express';

const tasaGet = async (req = request, res = response) => {
    try {
        const tasa = await pool.query('SELECT (public.obtener_historico_tasa()).*');
        res.json(tasa.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

export{
    tasaGet
}