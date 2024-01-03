import { pool } from '../models/server.js';
import { response, request } from 'express';

const afiliarse = async (req=request, res = response) => {
    try {
      const {codigo}=req.body;
      console.log(req.body)
      const afiliado =await pool.query('SELECT( public.datos_afiliado($1,$2)).*',[req.body.cedula,req.body.rif]);
      res.json(afiliado.rows[0]);
    } catch (error) {
      console.error('Error al buscar el afiliado:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};



export{afiliarse}